/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#define PUTCHAR_PROTOTYPE char putchar (char c)
#define GETCHAR_PROTOTYPE char getchar (void)
#define F_CPU 24000000UL
#include "stm8s.h"
#include "stm8s_tim4.h"

#include "util.h"
#include "time.h"
#include "delay.h"
#include "stm8s_gpio.h"
#include "stm8s_adc2.h"

void clock_setup(void);
void TIM4_setup(void);
void main()
{
	bool i = 0;
     
   GPIO_DeInit(GPIOB);
   GPIO_DeInit(GPIOD);
 
   GPIO_Init(GPIOB, GPIO_PIN_7, GPIO_MODE_IN_FL_NO_IT);
   GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
	while (1)
	{
		if(GPIO_ReadInputPin(GPIOB, GPIO_PIN_7) == FALSE)
      {
         while(GPIO_ReadInputPin(GPIOB, GPIO_PIN_7) == FALSE);
         i ^= 1;
      }
                                
      switch(i)
      {
         case 0:
         {
            // delay_ms(1000);
             break;

         }
         case 1:
         {
             //delay_ms(200);
             break;
         }
      }
                                
      GPIO_WriteReverse(GPIOD, GPIO_PIN_0);	  
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
 
 
void TIM4_setup(void)
{               
     TIM4_DeInit();
     TIM4_TimeBaseInit(TIM4_PRESCALER_32, 128);      
     TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
     TIM4_Cmd(ENABLE);
     
     enableInterrupts();
}

#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t* file, uint32_t line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif