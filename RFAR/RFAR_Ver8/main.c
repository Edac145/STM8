#include "stm8s.h"
#include "main.h"

/** Main Function **/
void main() {
  float FDR_amplitude = 0.0;
	//char buf[7];
	// Initialize system and peripherals
	initialize_system();
	//process_eeprom_logs(); // Example EEPROM address
  //config_mode();
	//DS3231_SetTime(buf, 7);
	read_set_frequency(&set_freq);
	//Process Signal 2 (FDR): Only amplitude is calculated
	FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);

	if (FDR_amplitude > 0) { // Voltage detected on Signal 2
		printf("FDR Voltage Exists");
		GPIO_WriteHigh(LED_RED); // Turn on LED
		GPIO_WriteHigh(GPIOD, GPIO_PIN_4);
		process_VAR_signal(FDR_amplitude); // Handle Signal 1
	}
}

/** Initialize system and peripherals **/
void initialize_system(void) {
	clock_setup();          // Configure system clock
	TIM4_Config(); 	// Timer 4 config for delay
	GPIO_setup();
	TIM1_setup();
	UART3_setup();          // Setup UART communication
	UART1_setup();
	ADC2_setup();						// Setup ADC
	EEPROM_Config();        // Configuring EEPROM
	I2CInit();  // for Configuring RTC
	INT_EEPROM_Setup();
	printf("System Initialization Completed\n\r");
}

float process_FDR_signal(void) {
	float FDR_Amplitude = 0, VAR_amplitude = 0;
  char buffer[50];
	
	while (1) {
		VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
		FDR_Amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_Amplitude);
    sprintf(buffer, "Freq: %.3f, Field_Volt: %.3f, FDR_Volt: %.3f\n", frequency, VAR_amplitude, FDR_Amplitude);
	  printf("%s", buffer);
		logResults(buffer);
		if ((FDR_Amplitude > 1.1) && (VAR_amplitude > 0.7)) {
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
		VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
		VAR_frequency = frequency;
		printDateTime();
		//sprintDateTime(buffer);
		//printf("%s\n", buffer);
		printf(" Frequency: %.3f, Amplitude: %.3f, Current: %.3f, FDR_Voltage: %.3f\n",
					 VAR_frequency, VAR_amplitude, VAR_amplitude / 4.7, FDR_amplitude);
    sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", frequency, VAR_amplitude, VAR_amplitude/4.7, FDR_amplitude);
		logResults(buffer);
		output_results(VAR_frequency, VAR_amplitude, FDR_amplitude);

		if (VAR_frequency <= SET_FREQ) {
			char buffer[40]; // Adjust the size as necessary
			pulseFlag = 1;
			printf("Frequency Below Set Frequency.\n");
			// Format the output string
			sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", VAR_frequency, VAR_amplitude, VAR_amplitude/4.7, FDR_amplitude);
			printf("%s", buffer);
			logResults(buffer);
			handle_Frequency_Below_Set_Freq(VAR_amplitude);
		}
	}
}

void handle_Frequency_Below_Set_Freq(float VAR_amplitude) {
	char buffer[40];
	GPIO_WriteHigh(LED_BLUE); 
	GPIO_WriteHigh(GPIOD, GPIO_PIN_2); 
	VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
  sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", frequency, VAR_amplitude, VAR_amplitude/4.7, 0);
	printf("%s", buffer);
	logResults(buffer);
	
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
	
	VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
	if (VAR_amplitude < AC_AMPLITUDE_THRESHOLD) {
		//printDateTime();
		sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", frequency, VAR_amplitude, VAR_amplitude/4.7, 0);
	  printf("%s", buffer);
		logResults(buffer);
		printf("VarAmplitude below 10 mv.\n");
		GPIO_WriteLow(LED_WHITE); // Turn on LED if Signal is AC < 20 mV
		delay_ms(3000);
		pulseFlag = 1;
	} else {
		while(1){
			pulseFlag = 1;
			//printDateTime();
			GPIO_WriteHigh(GPIOD, GPIO_PIN_7);  // Turn on LED if Signal is AC < 20 ms
			sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", frequency, VAR_amplitude, VAR_amplitude/4.7, 0);
			printf("%s", buffer);
			logResults(buffer);
			printf("VarAmplitude Not below 10 mv.\n");
			GPIO_WriteHigh(LED_WHITE);  // Turn on LED if Signal is AC < 20 ms	
			VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
			//handle_Frequency_Below_Set_Freq(VAR_amplitude);
			if(check_signal_dc(VAR_amplitude)){
				printf("Signal 1 DC(After AC).\n");
				GPIO_WriteHigh(LED_BLUE); 
				process_FDR_signal();
			}
		}
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

float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
	uint16_t i = 0, count = 0;
	float lastStoredValue = 0.0;       // Track the last stored ADC voltage
	bool isChannel1 = (channel == VAR_SIGNAL);
	bool firstSample = true;           // Flag for first sample storage               // Reset last zero-crossing time
  float dummyRead = convert_adc_to_voltage(read_ADC_Channel(channel));
	uint16_t dcCount = 0;
	
	while (count < NUM_SAMPLES) {  
		float currentVoltage = convert_adc_to_voltage(read_ADC_Channel(channel));
    //printf("%.4f " , currentVoltage); 
		// Store the first value unconditionally or when there's a =0.05V change
		if (fabs(currentVoltage - lastStoredValue) >= 0.01 || firstSample) {
			buffer[count] = currentVoltage;
			//printf("%.4f " , currentVoltage);    // Less than 0.3 fluctation in a dc signal.
			lastStoredValue = currentVoltage;
			firstSample = false;  // First sample has been stored
			count++;
		}
	}
	// Final amplitude calculation
	*amplitude = calculate_amplitude(buffer, count);
	return *amplitude;
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
	printf("Checking FDR_Amplitude: %.2f\n", FDR_amplitude);
	return (FDR_amplitude >= 1.1); // Returns true if FDR_amplitude is non-zero
}

float calc_FDR_amplitude(void) {
	float FDR_amplitude = 0;
	FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
	return (FDR_amplitude); // Returns true if FDR_amplitude is non-zero
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
			// Additional processing if needed (example: write to EEPROM)
			printf("123456789\n");
			//value = ConvertStringToFloat(buffer);
			internal_EEPROM_WriteStr(0x4000, buffer); // Example address for storing string
			//printf("success\n");
			//printf("New Parameter: %s\n", buffer);
			//value = ConvertStringToFloat(buffer);
			//printf("Value: %f\n", value);
			
		} else if (strcmp(buffer, "ready") == 0) {
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