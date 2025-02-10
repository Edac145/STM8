#include "stm8s.h"
#include "stdio.h"
#include "delay.h"
#include <math.h>

#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

#define false 0
#define true  1

#define ADC_MAX_VALUE 1023.0                              // 10-bit ADC on Arduino Uno
#define V_REF 4.66                                        // Reference voltage
#define SET_FREQUENCY 5.0                                 // Frequency threshold in Hz
#define NUM_SAMPLES 1024                                  // Number of samples
#define SAMPLE_RATE 150                                   // Sampling rate in Hz
#define ZEROCROSS_THRESHOLD 1.1                        // Signal zero-crossing threshold

#define VAR_SIGNAL ADC2_CHANNEL_5
#define FDR_SIGNAL ADC2_CHANNEL_6

/** Global Variables **/
volatile float sine1_frequency = 0.0;                     // Frequency of sine wave 1
volatile float sine1_amplitude = 0.0;                     // Amplitude of sine wave 1
unsigned long lastEdgeTime = 0;                           // Time of the last zero crossing
unsigned long currentEdgeTime = 0;                        // Time of the current zero crossing
int crossingType = -1;                                    // Crossing type: -1 (undetermined), 0 (positive), 1 (negative)
unsigned int count = 0;

/** Function Prototypes **/
void initialize_system(void);
void configure_peripherals(void);

void clock_setup(void);
void UART3_setup(void);
void ADC2_setup(void);
void GPIO_setup(void);

uint32_t elapsedTime(uint32_t start, uint32_t end);
unsigned int read_ADC_Channel(uint8_t channel);

bool detect_zero_crossing(float previous_sample, float current_sample);
bool detectPosZeroCross(float previousSample, float currentSample, float threshold);
bool detectZeroCross(float previousSample, float currentSample, float threshold);

void initialize_adc_buffer(float buffer[]);
void output_results(float frequency, float amplitude);
float calculate_amplitude(float adc_signal[], uint32_t sample_size);
float process_adc_signal(uint8_t channel, float *frequency, float *amplitude);
float convert_adc_to_voltage(unsigned int adcValue);
float calculate_frequency(unsigned long period);
float process_FDR_samples(float buffer[]);
void UART3_ClearBuffer(void) ;
void UART3_ReceiveString(char *buffer, uint16_t max_length);
/** Main Function **/
void main() {
	float frequency = 0.0, amplitude = 0.0;
	unsigned int adcValue = 0;
	initialize_system();
	while(1)
	{
		adcValue = read_ADC_Channel(FDR_SIGNAL);
		amplitude = convert_adc_to_voltage(adcValue);
		printf("ADC Vaue: %u, Voltage: %.3f\n", adcValue, amplitude);
		amplitude = process_adc_signal(FDR_SIGNAL, &frequency, &amplitude);
		printf("frequency; %.3f, amplitude: %.3f\n\r", frequency, amplitude);
	}	
}

/***************************************
 * Function Definitions
 ***************************************/

/** Initialize system and peripherals **/
void initialize_system(void) {
	clock_setup();          // Configure system clock
	TIM4_Config();	// Timer 4 config for delay
	GPIO_setup();
	UART3_setup();          // Setup UART communication
	ADC2_setup();           // Setup ADC
	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	printf("System Initialization Completed\n\r");
}

/** Configure clocks and peripherals **/
void clock_setup(void) {
	CLK_DeInit();
	CLK_HSECmd(DISABLE);
	CLK_LSICmd(DISABLE);
	CLK_HSICmd(ENABLE);
	while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);

	// Configure clock settings
	CLK_ClockSwitchCmd(ENABLE);
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);

	// Enable peripheral clocks
	//CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
}

void GPIO_setup(void) {
	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
	GPIO_DeInit(GPIOA);     // Reset GPIO settings for port C
	GPIO_DeInit(GPIOB);     // Reset GPIO settings for port C
	GPIO_DeInit(GPIOD);     // Reset GPIO settings for port C
	GPIO_DeInit(GPIOE);     // Reset GPIO settings for port C
	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_IN_FL_NO_IT);
	GPIO_Init(GPIOB, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
	GPIO_Init(GPIOA, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOE, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	
	GPIO_Init(GPIOD, GPIO_PIN_7, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOE, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	
  GPIO_Init (GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
  GPIO_Init (GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
}

/** Setup UART communication at 9600 baud **/
void UART3_setup(void) {
	UART3_DeInit();
	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TXRX_ENABLE);
	UART3_Cmd(ENABLE);
}

/** Setup ADC for analog signal processing **/
void ADC2_setup(void) {
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
	ADC2_DeInit();

	ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
						ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6, DISABLE);

	ADC2_Cmd(ENABLE);
}

/** Measure elapsed time, accounting for timer rollover **/
uint32_t elapsedTime(uint32_t start, uint32_t end) {
	return (end >= start) ? (end - start) : ((0xffffffff - start + 1) + end);
}

/** Read an analog value from an ADC channel **/
unsigned int read_ADC_Channel(uint8_t channel) {
	unsigned int adcValue = 0;
	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, channel, ADC2_ALIGN_RIGHT);
	ADC2_StartConversion();
	// Wait for ADC conversion to complete
	while (ADC2_GetFlagStatus() == RESET);
	// Get and return ADC value
	adcValue = ADC2_GetConversionValue();
	ADC2_ClearFlag();
	return adcValue;
}

/** Detect zero crossing of a signal **/
bool detectZeroCross(float previousSample, float currentSample, float threshold) {
	if (crossingType == -1) {  // If no crossing type detected, check for both positive and negative
		if (previousSample <= threshold && currentSample > threshold) {
			crossingType = 0;  // Positive zero crossing
			return true;
		} else if (previousSample >= -threshold && currentSample < -threshold) {
			crossingType = 1;  // Negative zero crossing
			return true;
		}
	} else if (crossingType == 0 && previousSample <= threshold && currentSample > threshold) {
			return true;  // Positive zero crossing
	} else if (crossingType == 1 && previousSample >= threshold && currentSample < threshold) {
			return true;  // Negative zero crossing
	}

	return false;  // No zero crossing detected
}

/** Detect only positive zero crossing **/
bool detectPosZeroCross(float previousSample, float currentSample, float threshold) {
	return (previousSample <= threshold && currentSample > threshold);
}

/** Calculate amplitude of a sine wave **/
float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
	uint32_t i = 0;
	float max_val = -V_REF, min_val = V_REF;

	for (i = 0; i < sample_size; i++) {
		if (adc_signal[i] > max_val) max_val = adc_signal[i];
		if (adc_signal[i] < min_val) min_val = adc_signal[i];
	}
  printf("Max Vaue: %.4f,  Min Value: %.4f\n", max_val, min_val);
	return (max_val - min_val);
}

/** Initialize ADC buffer before data acquisition **/
void initialize_adc_buffer(float buffer[]) {
	uint16_t i = 0;
	for (i = 0; i < NUM_SAMPLES; i++) {
		buffer[i] = -1;  // Reset each element of the ADC buffer
	}
}

float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
	unsigned long currentEdgeTime = 0;
	float freqBuff = 0;
	int freqCount = 0;
	uint16_t i = 0, count = 0;
	float lastStoredValue = 0.0;       // Track the last stored ADC voltage
	bool isChannel1 = (channel == VAR_SIGNAL);
	bool firstSample = true;           // Flag for first sample storage
	lastEdgeTime = 0;                 // Reset last zero-crossing time

 

	while (count < NUM_SAMPLES) {  
		float currentVoltage = convert_adc_to_voltage(read_ADC_Channel(channel));
    //printf("%.4f " , currentVoltage); 
		// Store the first value unconditionally or when there's a =0.05V change
		if (firstSample || fabs(currentVoltage - lastStoredValue) >= 0.05) {
			buffer[count] = currentVoltage;
			//printf("fabs: %.4f \n" , fabs(currentVoltage - lastStoredValue));
			//printf("%.4f " , currentVoltage);    // Less than 0.3 fluctation in a dc signal.
			lastStoredValue = currentVoltage;
			firstSample = false;  // First sample has been stored
			count++;

			// Zero-crossing detection and frequency calculation
			if (isChannel1 && (frequency != NULL) && count > 1) {
				if (detectZeroCross(buffer[count - 2], buffer[count - 1], ZEROCROSS_THRESHOLD)) {
					currentEdgeTime = micros();
					if (lastEdgeTime > 0) {  
						unsigned long period = currentEdgeTime - lastEdgeTime;
						float singleFrequency = calculate_frequency(period);
						freqCount++;

						/*if (freqCount == 2) {  
							*amplitude = calculate_amplitude(buffer, count);
							// Step 4: Only return frequency if the signal is from Channel 1
							if (isChannel1 && freqCount > 0) {
								*frequency = singleFrequency;  // Calculate average frequency
							} 
							else if (isChannel1) {
								*frequency = 0;  // No crossings detected, return 0 frequency
							}
							return *amplitude;
						}*/
					}
					lastEdgeTime = currentEdgeTime;
				}
			}
		}
	}

	// Final amplitude calculation
	*amplitude = calculate_amplitude(buffer, count);
	
	if (isChannel1 && freqCount > 0) {
		*frequency = freqBuff / freqCount;
	} else if (isChannel1) {
		*frequency = 0;
	}

	return *amplitude;
}


/** Process ADC samples: Detect zero crossings and calculate frequency **/
float process_FDR_samples(float buffer[]) {
	int ZCount = 0;
	uint16_t i = 0;
	float amplitude;
	for (i = 0; i < NUM_SAMPLES; i++) {
		// Step 1: Read ADC sample and convert it to a voltage value
		buffer[i] = convert_adc_to_voltage(read_ADC_Channel(ADC2_CHANNEL_6));
		// Step 2: Maintain sampling rate
		delay_us(1000000 / SAMPLE_RATE);
		// Step 3: Detect zero crossing
		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
				unsigned long period = currentEdgeTime - lastEdgeTime;   // Calculate period
				ZCount++;
				if (ZCount == 2)
				{
					count = i;    // for amplitude calculation limit bound
					break;        // break when zeroCrossing detection is two
				}
			}
	}
	amplitude = calculate_amplitude(buffer, count);
	
	return amplitude;
}

/** Convert ADC value to voltage **/
float convert_adc_to_voltage(unsigned int adcValue) {
	return adcValue * (V_REF / ADC_MAX_VALUE);
}

/** Calculate frequency from period **/
float calculate_frequency(unsigned long period) {
	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
}

/** Output frequency and amplitude results through UART **/
void output_results(float frequency, float amplitude) {
	//printf("\nFrequency: %f Hz\n\r", frequency);
	//printf("Amplitude: %f V\n\r", amplitude);
	char buffer[40]; // Adjust the size as necessary
	
	// Format the output string
	sprintf(buffer, "%.3f,%.3f,%.3f\n", frequency, amplitude, amplitude);

	// Send the formatted string via UART
	printf("%s", buffer);
	//EEPROM_LogData(buffer);
}

/** Redirect the output of `printf()` to UART **/
PUTCHAR_PROTOTYPE {
	UART3_SendData8(c);
	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
	return c;
}

GETCHAR_PROTOTYPE
{
  char c = 0;
  /* Loop until the Read data register flag is SET */
  while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
	c = UART3_ReceiveData8();
  return (c);
}

void UART3_ClearBuffer(void) {
    while (UART3_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
        (void)UART3_ReceiveData8(); // Clear any preexisting data
    }
}

void UART3_ReceiveString(char *buffer, uint16_t max_length) {
    uint16_t i = 0;
    char receivedChar;

    for (i = 0; i < max_length; i++) {
        buffer[i] = '\0';
    }
    i = 0;

    // Receive characters until newline or max length is reached
    while (i < max_length - 1) {
        while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);

        receivedChar = UART3_ReceiveData8();

        if (receivedChar == '\n' || receivedChar == '\r') {
            break; // Stop on newline or carriage return
        }

        buffer[i++] = receivedChar;
    }

    buffer[i] = '\0'; // Null-terminate the string
}