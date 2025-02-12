/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s.h"

void setup(void);
void clock_setup(void);
void GPIO_setup(void);

void main()
{
	bool i = 0;
     
   GPIO_DeInit(GPIOE);
   GPIO_DeInit(GPIOC);
	 GPIO_DeInit(GPIOD);
   GPIO_DeInit(GPIOA);
 
   GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_OD_LOW_FAST);
	 GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
	 GPIO_Init(GPIOE, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
	 GPIO_WriteHigh(GPIOE, GPIO_PIN_3);
	 GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
	 GPIO_WriteHigh(GPIOD, GPIO_PIN_0);
	 GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
	 GPIO_WriteHigh(GPIOD, GPIO_PIN_3);
	 GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
	 GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
	while (1){
		
	}
}

void setup(void)
{
  clock_setup();
	GPIO_setup();
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
  CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV4);
                                
  CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
  DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
                                
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
                                
  CLK_CCOConfig(CLK_OUTPUT_CPU);
  CLK_CCOCmd(ENABLE);
  while(CLK_GetFlagStatus(CLK_FLAG_CCORDY) == FALSE);
}

void GPIO_setup(void)
{                               
  //GPIO_DeInit(GPIOC);
  GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
}