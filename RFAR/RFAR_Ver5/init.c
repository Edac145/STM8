#include "init.h"

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