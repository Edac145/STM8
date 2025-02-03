/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 
 */
 
#include "stm8s.h"
#include "delay.h"

#define false 0
#define true  1

#define ADC_MAX_VALUE 1023.0                              // 10-bit ADC on Arduino Uno
#define V_REF 4.66                                        // Reference voltage
#define SET_FREQUENCY 5.0                                 // Frequency threshold in Hz
#define NUM_SAMPLES 1024                                  // Number of samples
#define SAMPLE_RATE 150                                   // Sampling rate in Hz
#define ZEROCROSS_THRESHOLD 2.38                          // Signal zero-crossing threshold

bool state = FALSE;
uint32_t i, j;
volatile uint8_t delay_flag = 0;
  
void GPIO_setup(void);
void EXTI_setup(void);
void clock_setup(void);
void UART3_setup(void);
void ADC2_setup(void);
@far @interrupt void EXTI1_IRQHandler(void);

void main()
{
	clock_setup();
	TIM4_Config();
	GPIO_setup();
	ADC2_setup();
	GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
	EXTI_setup();
	
	while (1){
		if (delay_flag)
    {
        delay_ms(5);  // Now it's safe to use delay_ms() outside the ISR
        GPIO_WriteLow(GPIOD, GPIO_PIN_4);
        delay_flag = 0;  // Reset flag
				GPIO_WriteLow(GPIOC, GPIO_PIN_3);
				delay_ms(2000);				
    }
		
	}
}

void GPIO_setup(void)
{
	GPIO_DeInit(GPIOB);     
	GPIO_DeInit(GPIOC); 
	GPIO_DeInit(GPIOD);	
	GPIO_Init(GPIOB, GPIO_PIN_7, GPIO_MODE_IN_PU_IT);
	GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
}
  
void EXTI_setup(void)
{
	ITC_DeInit();
	ITC_SetSoftwarePriority(ITC_IRQ_PORTB, ITC_PRIORITYLEVEL_0);
							
	EXTI_DeInit();
	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOB, EXTI_SENSITIVITY_RISE_ONLY);
	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_RISE_ONLY);
							
	enableInterrupts();
}
  
void clock_setup(void)
{
    CLK_DeInit();
                
    CLK_HSECmd(DISABLE);
    CLK_LSICmd(DISABLE);
    CLK_HSICmd(ENABLE);
    while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
                
    CLK_ClockSwitchCmd(ENABLE);
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
    CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
                
    CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
    DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
                
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
}

/** Convert ADC value to voltage **/
float convert_adc_to_voltage(unsigned int adcValue) {
	return adcValue * (V_REF / ADC_MAX_VALUE);
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

/** Setup UART communication at 9600 baud **/
void UART3_setup(void) {
	UART3_DeInit();
	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TX_ENABLE);
	UART3_Cmd(ENABLE);
}

/** Setup ADC for analog signal processing **/
void ADC2_setup(void) {
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
	ADC2_DeInit();

	ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
						ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5, DISABLE);

	ADC2_Cmd(ENABLE);
}

void EXTI1_IRQHandler(void)
{
	state = 1;
	GPIO_WriteHigh(GPIOD, GPIO_PIN_4);
	delay_flag = 1;  // Set flag to indicate delay should happen
	for(i = 0; i < 100; i++)
	{
		for(j = 0; j < 8; j++)
		{
			
		}
	}
	//delay_ms(5);
	//GPIO_WriteLow(GPIOD, GPIO_PIN_4);
//GPIO_DeInit(GPIOB);   
}