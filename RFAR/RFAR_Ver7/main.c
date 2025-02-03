#include "stm8s.h"
#include "stdio.h"
#include "stdlib.h"
#include "delay.h"
#include "eeprom.h"
#include "i2c.h"
#include "ds3231.h"
#include "init.h"
#include "main.h"

float set_freq = 0.0;
/** Main Function **/
void main() {
  float FDR_amplitude = 0.0;
	// Initialize system and peripherals
	initialize_system();
  config_mode();
	read_set_frequency(&set_freq);
	while (1) {
		//Process Signal 2 (FDR): Only amplitude is calculated
		FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);

		if (FDR_amplitude > 0) { // Voltage detected on Signal 2
		  printf("FDR Voltage Exists\n");
		  GPIO_WriteHigh(LED_RED); // Turn on LED
			GPIO_WriteHigh(GPIOD, GPIO_PIN_4);
			process_VAR_signal(FDR_amplitude); // Handle Signal 1
		}
	}
}

/** Initialize system and peripherals **/
void initialize_system(void) {
	clock_setup();          // Configure system clock
	TIM4_Config();          // Timer 4 config for delay
	GPIO_setup();
	UART3_setup();          // Setup UART communication
	UART1_setup();
	ADC2_setup();						// Setup ADC
	EEPROM_Config();        // Configuring EEPROM
	I2CInit();  // for Configuring RTC
	internal_EEPROM_Setup();
	printf("System Initialization Completed\n\r");
}

float process_FDR_signal(void) {
	float FDR_amplitude = 0, VAR_amplitude = 0;
  char buffer[40];
	while (1) {
		VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
		FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
    sprintf(buffer, "0.000,%.3f,%.3f,%.3f,1\n", VAR_amplitude, VAR_amplitude/4.7, FDR_amplitude);
	  printf("%s", buffer);
		if ((FDR_amplitude > 0) && (VAR_amplitude > 0)) {
			do{
				handle_commutation_pulse(); // Execute the pulse sending
			} while (check_FDR_amplitude()); // Repeat if FDR_amplitude is still non-zero
		}
	}
	return 0; // Unreachable, but keeps function signature valid
}

void process_VAR_signal(float FDR_amplitude) {
	float VAR_frequency = 0.0, VAR_amplitude = 0.0;
  char buffer[50];
	while (1) {
		VAR_amplitude = process_adc_signal(VAR_SIGNAL, &VAR_frequency, &VAR_amplitude);
		//printDateTime();
		//sprintDateTime(buffer);
		//printf("%s\n", buffer);
		printf(" Frequency: %.3f, Amplitude: %.3f, Current: %.3f, FDR_Voltage: %.3f\n",
					 VAR_frequency, VAR_amplitude, VAR_amplitude / 4.7, FDR_amplitude);

		output_results(VAR_frequency, VAR_amplitude, FDR_amplitude);

		if (VAR_frequency <= SET_FREQ) {
			char buffer[40]; // Adjust the size as necessary	
			printf("Frequency Below Set Frequency.\n");
			// Format the output string
			sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", VAR_frequency, VAR_amplitude, VAR_amplitude/4.7, FDR_amplitude);
			printf("%s", buffer);
			handle_Frequency_Below_Set_Freq(VAR_amplitude);
		}
	}
}

void wait_for_negative_zero_crossing(void) {
	while (!check_negative_zero_crossing()) {
			// Wait loop for negative zero crossing
			
	}
}

void handle_Frequency_Below_Set_Freq(float VAR_amplitude) {
	char buffer[40];
	wait_for_negative_zero_crossing();
	printf("Sending Square Pulse.\n");
	send_square_pulse(5);
	GPIO_WriteHigh(LED_BLUE); 
	GPIO_WriteHigh(GPIOD, GPIO_PIN_2); 
	VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
  sprintf(buffer, "0.000,%.3f,%.3f,%.3f,1\n", VAR_amplitude, VAR_amplitude/4.7, 0);
	printf("%s", buffer);
	if (check_signal_dc(VAR_amplitude)) {
		//printDateTime();
		printf("Signal 1 DC.\n");
		GPIO_WriteHigh(LED_BLUE); 
		process_FDR_signal();
	} else {
		//printDateTime();
		printf("Signal 1 AC and VarAmplitude: %f.\n", VAR_amplitude);
		handle_signal_1_AC(VAR_amplitude);
	}
}


void handle_signal_1_AC(float VAR_amplitude) {
	char buffer[40];
	if (VAR_amplitude < AC_AMPLITUDE_THRESHOLD) {
		//printDateTime();
		sprintf(buffer, "0.000,%.3f,%.3f,%.3f,1\n", VAR_amplitude, VAR_amplitude/4.7, 0);
	  printf("%s", buffer);
		printf("VarAmplitude below 10 mv.\n");
		GPIO_WriteLow(LED_WHITE); // Turn on LED if Signal is AC < 20 mV
		delay_ms(3000);
		send_square_pulse(5);
	} else {
		//printDateTime();
		GPIO_WriteHigh(GPIOD, GPIO_PIN_7);  // Turn on LED if Signal is AC < 20 ms
		sprintf(buffer, "%0.000,%.3f,%.3f,%.3f,1\n", VAR_amplitude, VAR_amplitude/4.7, 0);
	  printf("%s", buffer);
		printf("VarAmplitude Not below 10 mv.\n");
		handle_Frequency_Below_Set_Freq(VAR_amplitude);
		GPIO_WriteHigh(LED_WHITE);  // Turn on LED if Signal is AC < 20 ms		
	}
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
	float hyst = 0.5;
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
			//printDateTime();
			printf(" Negative zero crossing detected!\n");
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
	//printf("Max Value: %.2f, Min_Value: %.2f\n", max_val, min_val);
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
	
	//initialize_adc_buffer(buffer);

	// Step 1: Collect ADC samples for the selected channel
	for (i = 0; i < NUM_SAMPLES; i++) {
	// Read and convert ADC sample to voltage
	buffer[i] = convert_adc_to_voltage(read_ADC_Channel(channel));
  //printf("%f ", buffer[i]);
	if (isChannel1 && (frequency != NULL)) { // Only calculate frequency for Signal 1 (Channel 1)
		// Step 2: Detect zero-crossing
		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
			currentEdgeTime = micros();
			if (lastEdgeTime > 0) {  // Zero-crossing detected; calculate period and frequency
				unsigned long period = currentEdgeTime - lastEdgeTime;  // Period in microseconds
				float singleFrequency = calculate_frequency(period);   // Calculate frequency in Hz
				//freqBuff += singleFrequency;  // Accumulate frequency values
				freqCount++;

				if (freqCount == 2) {  // Stop after detecting 2 zero-crossings
					count = i;  // Limit used for amplitude calculation within this range
					// Step 3: Calculate and return amplitude for both channels
					*amplitude = calculate_amplitude(buffer, (freqCount > 0 ? count : NUM_SAMPLES));
				
					// Step 4: Only return frequency if the signal is from Channel 1
					if (isChannel1 && freqCount > 0) {
						*frequency = singleFrequency;  // Calculate average frequency
					} 
					else if (isChannel1) {
						*frequency = 0;  // No crossings detected, return 0 frequency
					}
					return *amplitude;
				}
			}
			lastEdgeTime = currentEdgeTime;  // Update last edge time
		}
	}

	// Maintain the sampling rate
	delay_us(1000000 / SAMPLE_RATE);
	}
	//for(i = 0; i < NUM_SAMPLES; i++)
		//    printf("%f, ", buffer[i]);
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
void output_results(float frequency, float amplitude, float FDR_Voltage) {
	char buffer[40]; // Adjust the size as necessary
	
	// Format the output string
	sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,0\n", frequency, amplitude, amplitude/4.7, FDR_Voltage);
  
	// Send the formatted string via UART
	printf("%s", buffer);
	UART1_SendString(buffer);
	//EEPROM_LogData(buffer);
}

// Function to log a message to EEPROM with current date and time prepended
void logResults(const char *logMessage) {
	char datetimeBuffer[20];  // Buffer to store the formatted datetime string
	char logBuffer[100];      // Final buffer to store the concatenated log string

	// Get current datetime
	sprintDateTime(datetimeBuffer);

	// Concatenate datetime and log message
	sprintf(logBuffer, "%s - %s", datetimeBuffer, logMessage);
	log_to_eeprom(logBuffer);

}

/** Send a square pulse **/
void send_square_pulse(uint16_t duration_ms) {
	GPIO_WriteHigh(SER_THYRISTOR); // Set square pulse pin high
	delay_ms(duration_ms);            // Wait for the pulse duration
	GPIO_WriteLow(SER_THYRISTOR); // Set square pulse pin low
}

void handle_commutation_pulse(void) {
	GPIO_WriteHigh(COM_THYRISTOR); // Set square pulse pin high
	delay_ms(3000);            // Wait for the pulse duration
	GPIO_WriteLow(COM_THYRISTOR); // Set square pulse pin low
	GPIO_WriteHigh(LED_ORANGE); // Turn on LED ORANGE
	printf("Commutation Thyristor Pulse Sent\n");
}

bool check_FDR_amplitude(void) {
    float FDR_amplitude = 0;
    FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
    return (FDR_amplitude != 0); // Returns true if FDR_amplitude is non-zero
}

/** Check if signal is DC or AC, and turn on corresponding LED **/
bool check_signal_dc(float amplitude) {
	if (amplitude < 0.5) {
		isThyristorON = true;
		return true;
	} else{
		isThyristorON = false;
		return false;
	}
}

void read_set_frequency(float *set_freq) {
	char setFreqString[30];
	internal_EEPROM_ReadStr(0x4000, setFreqString,  sizeof(setFreqString));
	printf("String read from EEPROM: %s\n\r", setFreqString);
	*set_freq = ConvertStringToFloat(setFreqString);
	printf("New set_freq: %f\n", *set_freq);
}

void  config_mode(void){
	char buffer[40]; // UART input buffer for storing received strings
  float value = 0;
	char stored_data[40];
	while(1)
	{
		// Step 1: Check initial GPIO pin state
		if (GPIO_ReadInputPin(GPIOA, GPIO_PIN_6) == RESET) {
			// GPIO pin is not high; exit config_mode
			return;
		}
		// Step 2: Wait for UART input for the first string ("set" or "read")
		printf("Entering Config Mode!\n");
		printf("Enter the Command!\n");
		UART3_ClearBuffer();
		UART3_ReceiveString(buffer, sizeof(buffer)); // Receive the first string via UART
	
		if (strcmp(buffer, "set") == 0) {
			// Handle "set" command
			printf("SET Command Received. Waiting for new parameter...\n");
			UART3_ReceiveString(buffer, sizeof(buffer)); // Receive the parameter string
			printf("New Parameter: %s\n", buffer);
			value = ConvertStringToFloat(buffer);
			printf("Value: %f\n", value);
			// Additional processing if needed (example: write to EEPROM)
			internal_EEPROM_WriteStr(0x4000, buffer); // Example address for storing string
			printf("success\n");
			
		} else if (strcmp(buffer, "read") == 0) {
			// Handle "read" command
			printf("READ Command Received. Reading stored values...\n");
			// Example: Read a string from EEPROM
			process_eeprom_logs(); // Example EEPROM address
			printf("Finished Reading EEPROM!\n");
			
		} else {
			// Invalid command
			printf("Invalid Command Received: %s\n", buffer);
		}
	}
}

void internal_EEPROM_WriteStr(uint32_t address, char *str) {
	while (*str) {
		FLASH_ProgramByte(address++, (uint8_t)(*str++));
	}
	FLASH_ProgramByte(address, '\0'); // Write a null terminator
}

void internal_EEPROM_ReadStr(uint32_t address, char *buffer, uint16_t max_length) {
	uint16_t i = 0;
	char c;

	while (i < max_length - 1) {
		c = (char)FLASH_ReadByte(address++); // Read a byte
		if (c == '\0') {
				break; // Stop if null terminator is encountered
		}
		buffer[i++] = c; // Store the character in the buffer
	}
	buffer[i] = '\0'; // Null-terminate the string
}