/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stdio.h"
#include "stm8s.h"

 
#define PUTCHAR_PROTOTYPE char putchar (char c)
#define GETCHAR_PROTOTYPE char getchar (void)

void clock_setup(void);
void UART1_setup(void);

void UART1_SendString(char *str);
void UART1_ReceiveString(char *buffer, uint16_t max_length);

void main(void)
{
  char ans[40];
  /*High speed internal clock prescaler: 1*/
  clock_setup();
    
  UART1_setup();


  /* Output a message on Hyperterminal using printf function */
  printf("\n\rUART1 Example :retarget the C library printf()/getchar() functions to the UART\n\r");
  printf("\n\rEnter Text\n\r");

  while (1)
  {
		//printf("\n\rUART1 Example :retarget the C library printf()/getchar() functions to the UART\n\r");
		//printf("\n\rEnter Text\n\r");
		UART1_SendString("Hello World!\n\r");
		UART1_ReceiveString(ans, sizeof(ans));
		UART1_SendString("Recieved String is:");
		UART1_SendString(ans);
   // ans = getchar();
    //printf("%c", ans);  
  }
}
/**
  * @brief Retargets the C library printf function to the UART.
  * @param c Character to send
  * @retval char Character sent
  */
PUTCHAR_PROTOTYPE
{
  /* Write a character to the UART1 */
  UART1_SendData8(c);
  /* Loop until the end of transmission */
  while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);

  return (c);
}

void clock_setup(void)
{
	CLK_DeInit();
						
	CLK_HSECmd(DISABLE);
	CLK_LSICmd(DISABLE);
	CLK_HSICmd(ENABLE);
	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
						
	CLK_ClockSwitchCmd(ENABLE);
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
						
	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
	DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
						
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);           
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
}

void UART1_setup(void)
{
	 UART1_DeInit();
							
	 UART1_Init(9600, 
							UART1_WORDLENGTH_8D, 
							UART1_STOPBITS_1, 
							UART1_PARITY_NO, 
							UART1_SYNCMODE_CLOCK_DISABLE, 
							UART1_MODE_TXRX_ENABLE);
							
	 UART1_Cmd(ENABLE);
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


