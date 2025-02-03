/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s.h"
#include "main.h"


volatile uint16_t adc_value=0;
volatile uint16_t prev_value = 0;
volatile uint16_t curr_value = 0;

void main() {
    unsigned int A0, A1;
		unsigned int prev_adc_value = 0;
		unsigned int curr_adc_value = 0;
		float voltage = 0;
    clock_setup();
		TIM4_Config();
		enableInterrupts();
		UART3_setup();
		//printf("Startin\n");
    GPIO_setup();
    ADC2_setup();
   // UART3_setup();
		printf("Startin\n");
    delay_ms(1000);
    while (1) {
			GPIO_WriteHigh(GPIOC, GPIO_PIN_2); // Initialize pin for GPIO
			delay_ms(1000);
			GPIO_WriteLow(GPIOC, GPIO_PIN_2); 
			delay_ms(1000);
        //A0 = read_ADC_Channel(5);
       // A1 = read_ADC_Channel(6);
				//voltage = (A0 * (4.60/1024));
        //printf("1\n");
        //printf("Adc Value 0: %d\n", A0);
				//printf("Adc Value 0: %d Voltage: %f\n", A0, voltage);
				//printf("Voltage: %f\n", A0, voltage);
			
			
			/*	curr_adc_value = read_ADC_Channel(ADC2_CHANNEL_5);
			  printf(" %u -> %u\n", prev_adc_value, curr_adc_value);
				if (detect_negative_zero_cross(prev_adc_value, curr_adc_value, 600)) {
						printf("Zero crossing detected: %u -> %u\n", prev_adc_value, curr_adc_value);
						send_square_pulse(5);
				}
			
				prev_adc_value = curr_adc_value;*/
				//delay_ms(10); // Small delay for stability
			printf("Conversion Startin\n");
			ADC2_StartConversion();	
			
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

    CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI,
                          DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);

    CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
}

void GPIO_setup(void) {
    GPIO_DeInit(GPIOB);
		GPIO_DeInit(GPIOC);
    GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_IN_FL_IT);
    GPIO_Init(GPIOB, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
		GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
		GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); 
}

void ADC2_setup(void) {
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
	ADC2_DeInit();

ADC2_Init(ADC2_CONVERSIONMODE_SINGLE,
			ADC2_CHANNEL_5,
			ADC2_PRESSEL_FCPU_D2,
			ADC2_EXTTRIG_TIM,
			DISABLE,
			ADC2_ALIGN_RIGHT,
			ADC2_SCHMITTTRIG_CHANNEL5,
			DISABLE);	
	ADC2_ITConfig(ENABLE);

	ADC2_Cmd(ENABLE);

}

unsigned int read_ADC_Channel(uint8_t channel) {
    unsigned int adcValue = 0;

    // Configure the ADC for the specified channel
    ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS,
                          channel,
                          ADC2_ALIGN_RIGHT);

    // Start ADC Conversion
    ADC2_StartConversion();

    // Wait until the conversion is complete
    while (ADC2_GetFlagStatus() == RESET);

    // Get the conversion result
    adcValue = ADC2_GetConversionValue();

    // Clear the end of conversion flag
    ADC2_ClearFlag();

    return adcValue;
}

void UART3_setup(void) {
    UART3_DeInit();

    // Configure UART3 at 9600 baud rate, 8 bits, no parity, 1 stop bit
    UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
               UART3_MODE_TX_ENABLE);

    UART3_Cmd(ENABLE);  // Enable UART3
}

PUTCHAR_PROTOTYPE {
    /* Write a character to UART3 */
    UART3_SendData8(c);

    /* Wait until the data is transmitted */
    while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);

    return (c);
}

bool check_negative_zero_crossing(void) {
	unsigned int prev_adc_value = 0;  // Store previous ADC sample value
	unsigned int current_adc_value = 0;  // Store current ADC sample value

	while (1) {
		// Step 1: Read ADC value representing the current sample
		current_adc_value = read_ADC_Channel(ADC2_CHANNEL_5);
		// Step 2: Check for negative zero crossing
		if (detect_negative_zero_cross(prev_adc_value, current_adc_value, 512)) {
			printf("NZC: %u, %u\n", prev_adc_value, current_adc_value);
			return true;
		} 
		// Step 3: Update previous ADC value for next iteration
		prev_adc_value = current_adc_value;
		// Step 4: Maintain sampling rate (usable for ADC sampling loops)
	}
}

/** Convert ADC value to voltage **/
float convert_adc_to_voltage(unsigned int adcValue) {
	return adcValue * (4.60 / 1024);
}

/** Send a square pulse **/
void send_square_pulse(uint16_t duration_ms) {
	GPIO_WriteHigh(GPIOC, GPIO_PIN_4); // Set square pulse pin high
	delay_ms(duration_ms);            // Wait for the pulse duration
	GPIO_WriteLow(GPIOC, GPIO_PIN_4); // Set square pulse pin low
}

/** Read an analog value from an ADC channel **/

/*bool detect_negative_zero_cross(float previous_sample, float current_sample, float threshold) {
    return (previous_sample > threshold && current_sample <= threshold);
}*/

bool detect_negative_zero_cross(unsigned int previous_sample, unsigned int current_sample, unsigned int threshold) {
// Adjustable hysteresis range
    if(previous_sample > threshold  && current_sample <= threshold )
			return 1;
		else
		 return 0;
}

