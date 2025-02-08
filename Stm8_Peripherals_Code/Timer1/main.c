/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s.h"
#include "delay.h"
#include "stdio.h"

/** Macro Definitions **/
#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

bool state = 0;

unsigned int overflow_count = 0;
uint16_t pulse_ticks = 0;
unsigned long start_time = 0;
unsigned long end_time = 0;
unsigned long last_cross_time = 0;
volatile float set_frequency = 0;
volatile float frequency = 0.0;
void clock_setup(void);
void GPIO_setup(void);
void TIM1_setup(void);
void UART3_setup(void);
void TIM2_setup(void);

void main()
{
	uint16_t time_period = 0;
                
	clock_setup();
	GPIO_setup();
	TIM1_setup();
	TIM2_setup();
	UART3_setup();
	TIM4_Config();
	set_frequency = 52;
	while (1){
		time_period = pulse_ticks;
		//frequency = (1000.0 / time_period); // Calculate frequency in Hz
		printf("Time Period: %u, Frequency: %.3f, Pulse_ticks: %u\n\r", time_period, frequency, pulse_ticks); 
	/*	if (frequency <= set_frequency && state == 1)
		{
			GPIO_WriteHigh(GPIOC, GPIO_PIN_2); // Send pulse // Send pulse
	    delay_ms(5);
			GPIO_WriteLow(GPIOC, GPIO_PIN_2);
			state = 0;
		}*/
		//delay_ms(400);
	}
}

void clock_setup(void)
{
    CLK_DeInit();
                
    CLK_HSECmd(DISABLE);
    CLK_LSICmd(DISABLE);
    CLK_HSICmd(ENABLE);
    while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
                
    CLK_ClockSwitchCmd(ENABLE);
    //CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
    //CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV2);
		CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
    CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
    CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
    DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
                
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
}

void GPIO_setup(void)
{               
     GPIO_DeInit(GPIOC);
     GPIO_Init(GPIOC, GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);
		 GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
		 GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);
     GPIO_DeInit(GPIOD);
     GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST);
}

void TIM1_setup(void)
{
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
 
void TIM2_setup(void)
{
     TIM2_DeInit();
     TIM2_TimeBaseInit(TIM2_PRESCALER_32, 1250);
     TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000, 
                  TIM2_OCPOLARITY_LOW);
     TIM2_SetCompare1(625);
     TIM2_Cmd(ENABLE);
} 
 
void UART3_setup(void) {
	UART3_DeInit();
	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TXRX_ENABLE);
	UART3_Cmd(ENABLE);
}

/** Redirect the output of `printf()` to UART **/
PUTCHAR_PROTOTYPE {
	UART3_SendData8(c);
	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
	return c;
}
