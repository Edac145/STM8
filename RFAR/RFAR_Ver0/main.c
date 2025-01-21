#include "stm8s.h"
#include "stdio.h"
#include "delay.h"

#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

// Function Prototypes
void clock_setup(void);
uint32_t elapsedTime(uint32_t start, uint32_t end);
void UART3_setup(void);

void main()
{
	clock_setup();
	TIM4_Config();
  UART3_setup();
  GPIO_DeInit(GPIOC);
  GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
  printf("Initializing Uart Starting:\n\r");
	while (1)
	{
		uint32_t start_time, currentTime, LoopTime;
		
		start_time = micros();
		//printf("StartTime: %lu\n", start_time);
		GPIO_WriteLow(GPIOC, GPIO_PIN_3);
		delay_ms(1000);  // LED OFF for 100ms
		GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
		delay_ms(1000);  // LED ON for 100ms
		currentTime = micros();
		LoopTime = elapsedTime(start_time, currentTime);
		printf("currentTime: %lu   starTime: %lu   Loop Time: %lu\n", currentTime,
					 start_time, LoopTime);
		start_time = 0;
		
	}
}

void clock_setup(void) {
  CLK_DeInit();
  CLK_HSECmd(DISABLE);
  CLK_LSICmd(DISABLE);
  CLK_HSICmd(ENABLE);
  while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);

  CLK_ClockSwitchCmd(ENABLE);
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);

  CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
                        CLK_CURRENTCLOCKSTATE_ENABLE);

  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
  // CLK_CCOConfig(CLK_OUTPUT_CPU);
  // CLK_CCOCmd(ENABLE);
  // while(CLK_GetFlagStatus(CLK_FLAG_CCORDY) == FALSE);
}

uint32_t elapsedTime(uint32_t start, uint32_t end) {
  if (end >= start) 
	{
    // Normal case: no rollover
    return end - start;
  } 
	else 
	{  // Handle timer/unsigned int rollover
    return (0xffffffff - start + 1) + end;
  }
}

// Configure UART1
void UART3_setup(void) {
  UART3_DeInit();

  // Configure UART1 at 9600 baud rate, 8 bits, no parity, 1 stop bit
  UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
             UART3_MODE_TX_ENABLE);

  UART3_Cmd(ENABLE);  // Enable UART1
}

PUTCHAR_PROTOTYPE {
  /* Write a character to the UART1 */
  UART3_SendData8(c);
  /* Loop until the end of transmission */
  while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);

  return (c);
}

