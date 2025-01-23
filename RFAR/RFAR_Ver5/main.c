#include "stm8s.h"
#include <stdio.h>
#include <stdlib.h>
#include "delay.h"
#include "eeprom.h"
#include "i2c.h"
#include "ds3231.h"
#include "init.h"
#include "main.h"

/** Main Function **/
void main() {
	
	float VAR_frequency = 0, VAR_amplitude = 0;
	float FDR_amplitude = 0;
	// Initialize system and peripherals
	initialize_system();  
	// Process Signal 2 (FDR): Only amplitude is calculated
	FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
	
	if (FDR_amplitude > 0) {  // Voltage detected on Signal 2
    GPIO_WriteHigh(GPIOC, GPIO_PIN_3);  // Turn on LED
		while(1){
    // Process Signal 1: Calculate both frequency and amplitude
    VAR_amplitude = process_adc_signal(VAR_SIGNAL, &VAR_frequency, &VAR_amplitude);
		printf("Signal 1 Frequency: %.2f Hz, Amplitude: %.2f V\n", VAR_frequency, VAR_amplitude);

    if (VAR_frequency <= SET_FREQ){
			// Perform further processing on Signal 1
			if(check_negative_zero_crossing()){     // Wait for negative zero crossing
				send_square_pulse(5); 
				FDR_Sampling:                         // LABEL for goto
				VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
				
				if(check_signal_dc(VAR_amplitude)){
					GPIO_WriteHigh(GPIOA, GPIO_PIN_1);  // Turn on LED if Signal is DC
					FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
					
					if(isThyristorON){
						send_square_pulse(3000);
						GPIO_WriteHigh(GPIOA, GPIO_PIN_1);  // Turn on LED ORANGE
						goto FDR_Sampling;
					}
					else{
						goto FDR_Sampling;
					}
					
				}
				else{						
					if (VAR_amplitude < AC_AMPLITUDE_THRESHOLD) {
						GPIO_WriteHigh(GPIOB, GPIO_PIN_2);  // Turn on LED if Signal is AC < 20 mV
						delay_ms(3000);
						send_square_pulse(5);
					} 
					else{
						GPIO_WriteHigh(GPIOB, GPIO_PIN_2);  // Turn on LED if Signal is AC < 20 mV
					}
					
				}
				
			}
			
    } 
		else {
			printf("Frequency above set Frequency.\n");
    }
		
	 }
	 
	}

}

/** Initialize system and peripherals **/
void initialize_system(void) {
	clock_setup();          // Configure system clock
	TIM4_Config();          // Timer 4 config for delay
	UART3_setup();          // Setup UART communication
	ADC2_setup();           // Setup ADC
	EEPROM_Config();        // Configuring EEPROM
	I2CInit();
	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	printf("System Initialization Completed\n\r");
}

/** Detect zero crossing of a signal **/
bool detectZeroCross(float previousSample, float currentSample, float threshold) {
	if (crossingType == -1) {  // If no crossing type detected, check for both positive and negative
		if (previousSample <= threshold && currentSample > threshold) {
			crossingType = 0;  // Positive zero crossing
			return true;
		} else if (previousSample >= threshold && currentSample < threshold) {
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

/** Detect a negative zero-crossing **/
bool detect_negative_zero_cross(float previous_sample, float current_sample, float threshold) {
    return (previous_sample > threshold && current_sample <= threshold);
}

bool check_negative_zero_crossing(void) {
	float prev_adc_value = 0;  // Store previous ADC sample value
	float current_adc_value = 0;  // Store current ADC sample value

	while (1) {
		// Step 1: Read ADC value representing the current sample
		current_adc_value = convert_adc_to_voltage(read_ADC_Channel(VAR_SIGNAL));
		// Step 2: Check for negative zero crossing
		if (detect_negative_zero_cross(prev_adc_value, current_adc_value, ZEROCROSS_THRESHOLD)) {
			printf("Negative zero crossing detected!\n");
			return true;
		} 
		// Step 3: Update previous ADC value for next iteration
		prev_adc_value = current_adc_value;
		// Step 4: Maintain sampling rate (usable for ADC sampling loops)
	}
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

float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
	unsigned long currentEdgeTime = 0;
	float freqBuff = 0;
	int freqCount = 0;
	uint16_t i = 0;
	bool isChannel1 = (channel == VAR_SIGNAL);  // Check if the channel is for Signal 1 or Signal 2
	lastEdgeTime = 0;                 // Reset last zero-crossing time
	
	initialize_adc_buffer(buffer);

	// Step 1: Collect ADC samples for the selected channel
	for (i = 0; i < NUM_SAMPLES; i++) {
	// Read and convert ADC sample to voltage
	buffer[i] = convert_adc_to_voltage(read_ADC_Channel(channel));

	if (isChannel1 && (frequency != NULL)) { // Only calculate frequency for Signal 1 (Channel 1)
		// Step 2: Detect zero-crossing
		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
			currentEdgeTime = micros();
			if (lastEdgeTime > 0) {  // Zero-crossing detected; calculate period and frequency
				unsigned long period = currentEdgeTime - lastEdgeTime;  // Period in microseconds
				float singleFrequency = calculate_frequency(period);   // Calculate frequency in Hz
				freqBuff += singleFrequency;  // Accumulate frequency values
				freqCount++;

				if (freqCount == 2) {  // Stop after detecting 2 zero-crossings
					count = i;  // Limit used for amplitude calculation within this range
					break;
				}
			}
			lastEdgeTime = currentEdgeTime;  // Update last edge time
		}
	}

	// Maintain the sampling rate
	delay_us(1000000 / SAMPLE_RATE);
	}

	// Step 3: Calculate and return amplitude for both channels
	*amplitude = calculate_amplitude(buffer, (freqCount > 0 ? count : NUM_SAMPLES));

	// Step 4: Only return frequency if the signal is from Channel 1
	if (isChannel1 && freqCount > 0) {
		*frequency = freqBuff / freqCount;  // Calculate average frequency
	} 
	else if (isChannel1) {
		*frequency = 0;  // No crossings detected, return 0 frequency
	}

	return *amplitude;  // Always return amplitude
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

/** Send a square pulse **/
void send_square_pulse(uint16_t duration_ms) {
	GPIO_WriteHigh(GPIOC, GPIO_PIN_3); // Set square pulse pin high
	delay_ms(duration_ms);            // Wait for the pulse duration
	GPIO_WriteLow(GPIOC, GPIO_PIN_3); // Set square pulse pin low
}

/** Check if signal is DC or AC, and turn on corresponding LED **/
bool check_signal_dc(float amplitude) {
	if (amplitude == 0) {
		isThyristorON = true;
		return true;
	} else{
		isThyristorON = false;
		return false;
	}
}

void configure_set_frequency(void) {
    char buffer[20]; // Buffer for UART input
		float new_frequency = 5.0; // Convert string to float
    printf("Enter new set frequency (0.3 - 5 Hz):\n");
    
    UART3_ReceiveString(buffer, sizeof(buffer)); // Receive user input
    new_frequency = atof(buffer); // Convert string to float
    
    // Validate frequency range
    if (new_frequency >= 0.3 && new_frequency <= 5.0) {
       // EEPROM_Write(SET_FREQUENCY_ADDRESS, new_frequency); // Store in EEPROM
        printf("Set frequency updated to: %.2f Hz\n", new_frequency);
    } else {
        printf("Invalid frequency. Please enter a value between 0.3 and 5 Hz.\n");
    }
}