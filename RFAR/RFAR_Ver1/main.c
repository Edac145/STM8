#include "stm8s.h"
#include "stdio.h"
#include "delay.h"

#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

#define ADC_MAX_VALUE 1023     // 10-bit ADC on Arduino Uno
#define V_REF 5                // Reference voltage
#define SET_FREQUENCY 5.0      // Frequency threshold in Hz
#define NUM_SAMPLES 512        // Number of samples
#define SAMPLE_RATE 100      // Sampling rate in Hz
#define ZEROCROSS_THRESHOLD 2.38  // Crowbar signal threshold

// Global variables
volatile float sine1_frequency = 0.0;    // Frequency of sine wave 1
volatile float sine1_amplitude = 0.0;    // Amplitude of sine wave 1
unsigned long lastEdgeTime = 0;          // Time of the last zero crossing
unsigned long currentEdgeTime = 0;       // Time of the current zero crossing
int crossingType = -1; // Initialize -1: No crossing detected yet (undetermined type)

// Function Prototypes
void clock_setup(void);
uint32_t elapsedTime(uint32_t start, uint32_t end);
void UART3_setup(void);
void ADC2_setup(void);
unsigned int read_ADC_Channel(uint8_t channel);
bool detect_zero_crossing(float previous_sample, float current_sample);
float calculate_amplitude(float adc_signal[], uint32_t sample_size) ;
bool detectPosZeroCross(float previousSample, float currentSample, float threshold);
bool detectZeroCross(float previousSample, float currentSample, float threshold) ;

void main()
{
	clock_setup();
	TIM4_Config();
  UART3_setup();
	ADC2_setup();
  GPIO_DeInit(GPIOC);
  GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
  printf("Initializing Uart Starting:\n\r");
	while (1)
	{
		float adc_buffer_1[NUM_SAMPLES] = { -1 };  // ADC buffer for sine wave 1
		uint16_t i = 0;
		unsigned int adcValue = 0;
		int freqCount = 0;
		float freqBuff = 0;
		float voltage = 0;
		lastEdgeTime = 0;
		
		 // Read sine wave 1 (input signal 1)
		for (i = 0; i < NUM_SAMPLES; i++) 
		{
			adc_buffer_1[i] = (read_ADC_Channel(ADC2_CHANNEL_5) * (4.66 / 1023.0));  // Convert ADC value to voltage
			delay_us(1000000 / SAMPLE_RATE);             // Maintain sample rate
			if (i > 0 && detectZeroCross(adc_buffer_1[i - 1], adc_buffer_1[i], 2.38)) 
			{
				currentEdgeTime = micros();                               // Record current time
				if (lastEdgeTime > 0) 
				{                                   // Ensure a previous edge exists
					unsigned long period = currentEdgeTime - lastEdgeTime;  // Calculate period
					freqCount++;
					sine1_frequency = 1.0 / (period / 1e6);  // Convert period to frequency (Hz)
					freqBuff += sine1_frequency;
				}
				lastEdgeTime = currentEdgeTime;  // Update last edge time
			}
		}
		
		for (i = 0; i < NUM_SAMPLES; i++) 
			printf("%f, ", adc_buffer_1[i]);
  
		sine1_amplitude = calculate_amplitude(adc_buffer_1, NUM_SAMPLES);
		
		printf("\nFrequency: %f\n\r", sine1_frequency);
	
		printf("Amplitude: %f\n\r", sine1_amplitude);
			
	}
}

void clock_setup(void) {
  CLK_DeInit();
  CLK_HSECmd(DISABLE);
  CLK_LSICmd(DISABLE);
  CLK_HSICmd(ENABLE);
  while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);

  CLK_ClockSwitchCmd(ENABLE);
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);

  CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
                        CLK_CURRENTCLOCKSTATE_ENABLE);

  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
}

uint32_t elapsedTime(uint32_t start, uint32_t end) {
  if (end >= start) 
	{
    // Normal case: no rollover
    return end - start;
  } 
	else 
	{  // Handle timer/unsigned int rollover
    return (0xffffffff - start + 1) + end;
  }
}

// Configure UART1
void UART3_setup(void) {
  UART3_DeInit();

  // Configure UART1 at 9600 baud rate, 8 bits, no parity, 1 stop bit
  UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
             UART3_MODE_TX_ENABLE);

  UART3_Cmd(ENABLE);  // Enable UART1
}

PUTCHAR_PROTOTYPE {
  /* Write a character to the UART1 */
  UART3_SendData8(c);
  /* Loop until the end of transmission */
  while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);

  return (c);
}

void ADC2_setup(void) {
		CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
    ADC2_DeInit();

    ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS,
              ADC2_CHANNEL_5,
              ADC2_PRESSEL_FCPU_D2,
              ADC2_EXTTRIG_GPIO,
              DISABLE,
              ADC2_ALIGN_RIGHT,
              ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6,
              DISABLE);

    ADC2_Cmd(ENABLE);
}

unsigned int read_ADC_Channel(uint8_t channel) {
    unsigned int adcValue = 0;

    // Configure the ADC for the specified channel
    ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS,
                          channel,
                          ADC2_ALIGN_RIGHT);

    // Start ADC Conversion
    ADC2_StartConversion();

    // Wait until the conversion is complete
    while (ADC2_GetFlagStatus() == RESET);

    // Get the conversion result
    adcValue = ADC2_GetConversionValue();

    // Clear the end of conversion flag
    ADC2_ClearFlag();

    return adcValue;
}


bool detectZeroCross(float previousSample, float currentSample, float threshold) 
{
    // If no crossing type is detected yet, check for both positive and negative zero crossings
    if (crossingType == -1) 
    {
        if (previousSample <= threshold && currentSample > threshold) 
        {
            crossingType = 0; // Set to positive zero crossing detection
            return 1;
        } 
        else if (previousSample >= -threshold && currentSample < -threshold) 
        {
            crossingType = 1; // Set to negative zero crossing detection
            return 0;
        }
    } 
    // Once a crossing type is established, check only for that type
    else if (crossingType == 0) // Positive zero crossing detection
    {
        if (previousSample <= threshold && currentSample > threshold) 
        {
            return 1;
        }
    } 
    else if (crossingType == 1) // Negative zero crossing detection
    {
        if (previousSample >= -threshold && currentSample < -threshold) 
        {
            return 1;
        }
    }

    // If no crossing detected, return false
    return 0;
}


bool detectPosZeroCross(float previousSample, float currentSample, float threshold) 
{
	if(previousSample <= threshold && currentSample > threshold)
		return 1;
	else
		return 0;
}

// Calculate amplitude of a sine wave
float calculate_amplitude(float adc_signal[], uint32_t sample_size) 
{
	uint32_t i = 0;
  float max_val = -V_REF, min_val = V_REF;
  for (i = 0; i < sample_size; i++) 
	{
    if (adc_signal[i] > max_val) max_val = adc_signal[i];
    if (adc_signal[i] < min_val) min_val = adc_signal[i];
  }
  return (max_val - min_val);
}
