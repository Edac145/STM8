/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "stdio.h"
#include "delay.h"

#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

void UART3_setup (void);
void clock_setup (void);

void main(void)
{

    uint8_t val = 0x00, val_comp = 0x00;
    uint32_t add = 0x00;
		clock_setup ();
		UART3_setup ();
		TIM4_Config();
    /* Define FLASH programming time */
    FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);

    /* Unlock Data memory */
    FLASH_Unlock(FLASH_MEMTYPE_DATA);

    /* Read a byte at a specified address */
    add = 0x4000;
    val = FLASH_ReadByte(add);

    /* Program complement value (of previous read byte) at previous address + 1 */
    val_comp = (uint8_t)(~val);
    FLASH_ProgramByte((add + 1), val_comp);

    /* Check program action */
    val = FLASH_ReadByte((add + 1));
    if (val == val_comp)
    {
			  delay_ms(1000);
				printf("Operation Read and Write Success\n\r");
    }
		else
		{
				delay_ms(1000);
				printf("Operation Read and Write Failed\n\r");
		}

    /* Erase byte at a specified address & address + 1 */
    FLASH_EraseByte(add);
    FLASH_EraseByte((add + 1));
    /* Erase action */
    val = FLASH_ReadByte(add);
    val_comp = FLASH_ReadByte((add + 1));
    if ((val != 0x00) & (val_comp != 0x00))
    {
			delay_ms(1000);
			printf("Operation Erase Failed\n\r");
    }
		else
		{
			delay_ms(1000);
			printf("Operation Erase Success\n\r");
		}

    while (1)
    {
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