/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s.h"
#include "stdio.h"
#include "delay.h"
#include "i2c.h"
#include "ds3231.h"
//#include "Ds1302.h"

#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

void clock_setup (void);
void UART3_setup (void);
void GPIO_setup (void);
extern void I2CInit(void);
void PrintTime(uint8_t *buf);

void main (void)
{
	unsigned char time_buf[7] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00};
	// Set time: 12:00:00 on 1st July 2023
	unsigned char init_time[7] = {0x00, 0x00, 0x12, 0x01, 0x07, 0x07, 0x23}; 
	uint8_t rtc_buf[7];
	uint8_t tmp;
	uint8_t day;
	uint8_t month; // Mask out century bit
	uint8_t year;
	int i = 0 ;
  clock_setup ();
  TIM4_Config ();
  UART3_setup ();
  GPIO_setup ();
	I2CInit();
  printf("\r\nCompiled: %s %s\r\n", __DATE__, __TIME__);
	DS3231_SetTime(init_time, 7);
  while(1)
	{
		DS3231_GetTime(rtc_buf, 7);
		//DS3231_GetTemp(&tempd, &tempf);
    day = (rtc_buf[4] >> 8);
		month = (rtc_buf[5] >> 12); // Mask out century bit
		year = (rtc_buf[6] >> 8);
		printf("Raw day: %02X (Parsed Day: %02d)\n", rtc_buf[4], day);
		printf("Raw month: %02X (Parsed Month: %02d)\n", rtc_buf[5], month);
		printf("Raw year: %02X (Parsed Year: 20%02d)\n", rtc_buf[6], year);
		
		// Print the Date in a human-readable format
		printf("Date: %02X-%02X-20%02X\n", day, month, year);

		printf("Time: %02d:%02d:%02d\n",
					 (rtc_buf[2] >> 4) * 10 + (rtc_buf[2] & 0x0F), // Convert Hours from BCD
					 (rtc_buf[1] >> 4) * 10 + (rtc_buf[1] & 0x0F), // Convert Minutes from BCD
					 (rtc_buf[0] >> 4) * 10 + (rtc_buf[0] & 0x0F)  // Convert Seconds from BCD
					);
		delay_ms(1000);
	}
}

void UART3_setup (void)
{
  UART3_DeInit ();

  // Configure UART1 at 9600 baud rate, 8 bits, no parity, 1 stop bit
  UART3_Init (9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
              UART3_MODE_TX_ENABLE);

  UART3_Cmd (ENABLE); // Enable UART1
}

PUTCHAR_PROTOTYPE{
  /* Write a character to the UART1 */
  UART3_SendData8 (c);
  /* Loop until the end of transmission */
  while (UART3_GetFlagStatus (UART3_FLAG_TXE) == RESET);

  return (c);
}

void clock_setup (void)
{
  CLK_DeInit ();
  CLK_HSECmd (DISABLE);
  CLK_LSICmd (DISABLE);
  CLK_HSICmd (ENABLE);
  while (CLK_GetFlagStatus (CLK_FLAG_HSIRDY) == FALSE);

  CLK_ClockSwitchCmd (ENABLE);
  CLK_HSIPrescalerConfig (CLK_PRESCALER_HSIDIV1);
  CLK_SYSCLKConfig (CLK_PRESCALER_CPUDIV1);

  CLK_ClockSwitchConfig (CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
                         CLK_CURRENTCLOCKSTATE_ENABLE);

  //CLK_PeripheralClockConfig (CLK_PERIPHERAL_TIMER4, ENABLE);
  CLK_PeripheralClockConfig (CLK_PERIPHERAL_UART3, ENABLE);
  //CLK_PeripheralClockConfig (CLK_PERIPHERAL_I2C, ENABLE);
  // CLK_CCOConfig(CLK_OUTPUT_CPU);
  // CLK_CCOCmd(ENABLE);
  // while(CLK_GetFlagStatus(CLK_FLAG_CCORDY) == FALSE);
}

void GPIO_setup (void)
{
  GPIO_DeInit (GPIOE);
  GPIO_Init (GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
  GPIO_Init (GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
}

void PrintTime(uint8_t *buf) {
    printf("Time: %02d:%02d:%02d\n",
           (buf[2] >> 4) * 10 + (buf[2] & 0x0F),  // Convert hours from BCD
           (buf[1] >> 4) * 10 + (buf[1] & 0x0F),  // Convert minutes from BCD
           (buf[0] >> 4) * 10 + (buf[0] & 0x0F)); // Convert seconds from BCD
}