/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s.h"
unsigned int value = 0x00;
 
unsigned char n = 0x00;
unsigned char seg = 0x01;
const unsigned char num[0x0A] = 
{0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90};
 
 
void clock_setup(void);
void delay_init(void);
void delay_us(unsigned char time);
void delay_ms(unsigned int time);

void main()
{
  clock_setup();
	GPIO_DeInit(GPIOC);
	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
	while (1)
	{
		delay_ms(1000);
		GPIO_WriteLow(GPIOC, GPIO_PIN_3);
		delay_ms(1000);
		GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
		
	}
}

void clock_setup(void)
{
     CLK_DeInit();
                
     CLK_HSECmd(ENABLE);
     CLK_LSICmd(DISABLE);
     CLK_HSICmd(DISABLE);
     while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
                
     CLK_ClockSwitchCmd(ENABLE);
     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
     CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
                
     CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
     DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
                
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
}
 
void delay_init(void)
{
	TIM4->PSCR = 0x01;   //2 MHz/2 = 1 Mhz
	TIM4->ARR = 0xFF;    //255 will be reloaded
	TIM4->CR1 &= 0x00;   //CR1=0, all default value
	TIM4->CR1 |= (1<<2);  //URS = 1 (update only when overflow)
	TIM4->EGR = 0x00;     // no Action
	TIM4->CNTR = 0x00;   // cntr is zero by default
	TIM4->IER = 0x00;    // interrupt is disabled
}

void delay_us(unsigned char time)
{
	TIM4->EGR |= 0x01;
	TIM4->CNTR = 0;
	TIM4->CR1 |= (1<<0);
	while(TIM4->CNTR<time);
	TIM4->CR1 &= ~(1<<0);
	TIM4->CNTR = 0x00;
	
	TIM4->SR1 &= ~(1<<0);
}

void delay_ms(unsigned int time)
{
	time*=10;
	while(time--)
		delay_us(100);
}