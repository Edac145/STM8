#include "stm8s.h"
#include "stdio.h"
#include "delay.h"
#include "eeprom.h"
/** Macro Definitions **/
#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

#define false 0
#define true  1

#define ADC_MAX_VALUE 1023.0                              // 10-bit ADC on Arduino Uno
#define V_REF 4.66                                        // Reference voltage
#define SET_FREQUENCY 5.0                                 // Frequency threshold in Hz
#define NUM_SAMPLES 1024                                  // Number of samples
#define SAMPLE_RATE 150                                   // Sampling rate in Hz
#define ZEROCROSS_THRESHOLD 2.38                          // Signal zero-crossing threshold

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
void main_loop(void);

void clock_setup(void);
void UART3_setup(void);
void ADC2_setup(void);

uint32_t elapsedTime(uint32_t start, uint32_t end);
unsigned int read_ADC_Channel(uint8_t channel);

bool detect_zero_crossing(float previous_sample, float current_sample);
bool detectPosZeroCross(float previousSample, float currentSample, float threshold);
bool detectZeroCross(float previousSample, float currentSample, float threshold);

void initialize_adc_buffer(float buffer[]);
void output_results(float frequency, float amplitude);
float calculate_amplitude(float adc_signal[], uint32_t sample_size);
float process_adc_samples(float buffer[]);
float convert_adc_to_voltage(unsigned int adcValue);
float calculate_frequency(unsigned long period);


/** Main Function **/
void main() {
    // Initialize system and peripherals
    initialize_system();
    // Main processing loop
    main_loop();
}

/***************************************
 * Function Definitions
 ***************************************/

/** Initialize system and peripherals **/
void initialize_system(void) {
	clock_setup();          // Configure system clock
	TIM4_Config();          // Timer 4 config for delay
	UART3_setup();          // Setup UART communication
	ADC2_setup();           // Setup ADC
	EEPROM_Config();        // Configuring EEPROM
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

/** Setup UART communication at 9600 baud **/
void UART3_setup(void) {
	UART3_DeInit();
	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TX_ENABLE);
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

/** Main processing loop **/
void main_loop(void) {
	while (1) {
 // Step 1: Initialize the ADC buffer
	float adc_buffer_1[NUM_SAMPLES] = { -1 };
	float sine1_frequency = 0;
	float sine1_amplitude = 0;
	//printf("Starting\n");
	
	initialize_adc_buffer(adc_buffer_1);
 
	// Step 2: Process ADC samples to detect zero crossings and calculate frequency
	sine1_frequency = process_adc_samples(adc_buffer_1);
	// Step 3: Calculate amplitude
	sine1_amplitude = calculate_amplitude(adc_buffer_1, count);

	// Step 4: Output results to UART
	output_results(sine1_frequency, sine1_amplitude);
	}
}

/***************************************
 * Helper Functions
 ***************************************/

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
	} else if (crossingType == 1 && previousSample >= -threshold && currentSample < -threshold) {
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

	return (max_val - min_val);
}

/** Initialize ADC buffer before data acquisition **/
void initialize_adc_buffer(float buffer[]) {
	uint16_t i = 0;
	for (i = 0; i < NUM_SAMPLES; i++) {
		buffer[i] = -1;  // Reset each element of the ADC buffer
	}
}

/** Process ADC samples: Detect zero crossings and calculate frequency **/
float process_adc_samples(float buffer[]) {
	unsigned long currentEdgeTime = 0;
	float freqBuff = 0;
	int freqCount = 0;
	uint16_t i = 0;
	lastEdgeTime = 0;           // Reset last zero-crossing time
	for (i = 0; i < NUM_SAMPLES; i++) {
		// Step 1: Read ADC sample and convert it to a voltage value
		buffer[i] = convert_adc_to_voltage(read_ADC_Channel(ADC2_CHANNEL_5));
		// Step 2: Maintain sampling rate
		delay_us(1000000 / SAMPLE_RATE);
		// Step 3: Detect zero crossing
		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
			currentEdgeTime = micros();
			if (lastEdgeTime > 0) {  // Ensure a previous edge exists
				unsigned long period = currentEdgeTime - lastEdgeTime;   // Calculate period
				float frequency = calculate_frequency(period);
				freqBuff += frequency;
				freqCount++;
				if (freqCount == 2)
				{
					count = i;    // for amplitude calculation limit bound
					break;        // break when zeroCrossing detection is two
				}
			}

			lastEdgeTime = currentEdgeTime;  // Update last edge time
		}
	}
  
	// Calculate average frequency if crossings were detected
	return (freqCount > 0) ? (freqBuff / freqCount) : 0.0;
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
