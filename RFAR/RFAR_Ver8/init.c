#include "init.h"
#include "stdio.h"

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
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
	UART3_DeInit();
	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TXRX_ENABLE);
	UART3_Cmd(ENABLE);
}

void UART1_setup(void) {
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
	UART1_DeInit();
	UART1_Init(9600, 
                UART1_WORDLENGTH_8D, 
                UART1_STOPBITS_1, 
                UART1_PARITY_NO, 
                UART1_SYNCMODE_CLOCK_DISABLE, 
                UART1_MODE_TXRX_ENABLE);
	UART1_Cmd(ENABLE);
}

/** Setup ADC for analog signal processing **/
void ADC2_setup(void) {
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
	ADC2_DeInit();

	ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
						ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6, DISABLE);

	ADC2_Cmd(ENABLE);
}

void TIM1_setup(void)
{
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
     TIM1_DeInit();
     //TIM1_TimeBaseInit(2000, TIM1_COUNTERMODE_UP, 55535, 1);
		 //TIM1_TimeBaseInit(16000, TIM1_COUNTERMODE_UP, 999, 1);
		 TIM1_TimeBaseInit(1600, TIM1_COUNTERMODE_UP, 65535, 1);
     TIM1_ICInit(TIM1_CHANNEL_1, TIM1_ICPOLARITY_RISING, 
                 TIM1_ICSELECTION_DIRECTTI, 1, 1);
     TIM1_ITConfig(TIM1_IT_UPDATE, ENABLE);
     TIM1_ITConfig(TIM1_IT_CC1, ENABLE);
     TIM1_Cmd(ENABLE);
     
     enableInterrupts();
}

void INT_EEPROM_Setup(void){
	FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
    /* Unlock Data memory */
	FLASH_Unlock(FLASH_MEMTYPE_DATA);
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

void UART1_ClearBuffer(void) {
    while (UART1_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
        (void)UART1_ReceiveData8(); // Clear any preexisting data
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

void UART1_SendString(char *str)
{
	while (*str)
	{
			UART1_SendData8(*str);
			while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
			str++;
	}
}

void UART1_ReceiveString(char *buffer, uint16_t max_length) {
	uint16_t i = 0;
	char receivedChar;

	for (i = 0; i < max_length; i++) {
			buffer[i] = '\0';
	}
	i = 0;

	// Receive characters until newline or max length is reached
	while (i < max_length - 1) {
			while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == RESET);

			receivedChar = UART1_ReceiveData8();

			if (receivedChar == '\n' || receivedChar == '\r') {
					break; // Stop on newline or carriage return
			}
			buffer[i++] = receivedChar;
	}

	buffer[i] = '\0'; // Null-terminate the string
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
	//printf("%d ,", adcValue);
	return adcValue;
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

void printDateTime(void){
	uint8_t rtc_buf[7], init_time[7];
	//DS3231_SetTime(init_time, 7);
	DS3231_GetTime(rtc_buf, 7);
	printf("%02d/%02d/%02d ",
		(rtc_buf[4] >> 4) * 10 + (rtc_buf[4] & 0x0F), // Convert Hours from BCD
		(rtc_buf[5] >> 4) * 10 + (rtc_buf[5] & 0x0F), // Convert Minutes from BCD
		(rtc_buf[6] >> 4) * 10 + (rtc_buf[6] & 0x0F)  // Convert Seconds from BCD
		);
	printf("%02d:%02d:%02d",
			(rtc_buf[2] >> 4) * 10 + (rtc_buf[2] & 0x0F), // Convert Hours from BCD
			(rtc_buf[1] >> 4) * 10 + (rtc_buf[1] & 0x0F), // Convert Minutes from BCD
			(rtc_buf[0] >> 4) * 10 + (rtc_buf[0] & 0x0F)  // Convert Seconds from BCD
		);
}

void sprintDateTime(char *buffer) {
    uint8_t rtc_buf[7];

    // Get the current time from DS3231 (make sure the function is defined elsewhere)
    DS3231_GetTime(rtc_buf, 7);

    // Format string to buffer using sprintf
    sprintf(buffer, "%02d/%02d/%02d %02d:%02d:%02d",
        (rtc_buf[4] >> 4) * 10 + (rtc_buf[4] & 0x0F), // Convert Hours from BCD
        (rtc_buf[5] >> 4) * 10 + (rtc_buf[5] & 0x0F), // Convert Minutes from BCD
        (rtc_buf[6] >> 4) * 10 + (rtc_buf[6] & 0x0F), // Convert Seconds from BCD
        (rtc_buf[2] >> 4) * 10 + (rtc_buf[2] & 0x0F), // Convert Hours from BCD
        (rtc_buf[1] >> 4) * 10 + (rtc_buf[1] & 0x0F), // Convert Minutes from BCD
        (rtc_buf[0] >> 4) * 10 + (rtc_buf[0] & 0x0F)  // Convert Seconds from BCD
    );
}

float ConvertStringToFloat(char *str) {
    float value = 0.0f;
		char formattedStr[16]; // Temporary buffer to format value
    // Convert string to float
    sscanf(str, "%f", &value);

    // Limit precision to 3 decimal places
    sprintf(formattedStr, "%.3f", value); // Format float with %.3f
    sscanf(formattedStr, "%f", &value); // Re-convert to float for uniformity

    return value;
}

void ConvertFloatToString(float value, char *str, uint16_t maxLength) {
    // Ensure the output string respects the buffer size and includes %.3f formatting
    sprintf(str, "%.3f", value);
}

// LED write function
void LED_Write(GPIO_TypeDef* GPIOx, uint16_t GPIO_PIN, uint8_t state) {
    if (state) {
        GPIO_WriteHigh(GPIOx, GPIO_PIN); // Turn LED ON
    } else {
        GPIO_WriteLow(GPIOx, GPIO_PIN); // Turn LED OFF
    }
}


// Function to create a formatted string based on input arguments
void createFormattedLog(float frequency, float fieldVoltage, float fieldCurrent, float fdrVoltage, const char *message) {
    char buffer[200] = ""; // Buffer to hold the resulting formatted string
    char temp[50];         // Temporary buffer for each formatted piece

    // Check and add Frequency if the value is valid
    if (frequency != -1) {
        sprintf(temp, "Freq: %.3f Hz", frequency);
        strcat(buffer, temp);
    }

    // Check and add Field Voltage if the value is valid
    if (fieldVoltage != -1) {
        if (strlen(buffer) > 0) strcat(buffer, ", "); // Add separator if needed
        sprintf(temp, "FieldVolt: %.2f V", fieldVoltage);
        strcat(buffer, temp);
    }

    // Check and add Field Current if the value is valid
    if (fieldCurrent != -1) {
        if (strlen(buffer) > 0) strcat(buffer, ", "); // Add separator if needed
        sprintf(temp, "FieldCurrent: %.2f A", fieldCurrent);
        strcat(buffer, temp);
    }

    // Check and add FDR Voltage if the value is valid
    if (fdrVoltage != -1) {
        if (strlen(buffer) > 0) strcat(buffer, ", "); // Add separator if needed
        sprintf(temp, "FDR_Volt: %.2f V", fdrVoltage);
        strcat(buffer, temp);
    }

    // Add the message if it is not a null character
    if (message != NULL && message[0] != '\0') {
        if (strlen(buffer) > 0) strcat(buffer, " - "); // Add separator to separate numeric data and message
        strcat(buffer, message);
    }

    // Final resulting buffer
    printf("Result: %s\n", buffer);
}