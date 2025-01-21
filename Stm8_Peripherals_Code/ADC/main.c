/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stdio.h"
#include "stm8s.h"

#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

void clock_setup(void);
void GPIO_setup(void);
void ADC2_setup(void);
void UART3_setup(void);
unsigned int read_ADC_Channel(uint8_t channel);

void main() {
    unsigned int A0, A1;

    clock_setup();
    GPIO_setup();
    ADC2_setup();
    UART3_setup();

    while (1) {
        A0 = read_ADC_Channel(5);
        A1 = read_ADC_Channel(6);

        printf("Adc Value 0: %d  Adc Value 1: %d\n", A0, A1);
    }
}

void clock_setup(void) {
    CLK_DeInit();

    CLK_HSECmd(DISABLE);
    CLK_LSICmd(DISABLE);
    CLK_HSICmd(ENABLE);
    while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);

    CLK_ClockSwitchCmd(ENABLE);
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV2);
    CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV4);

    CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI,
                          DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);

    CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
}

void GPIO_setup(void) {
    GPIO_DeInit(GPIOB);
    GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_IN_FL_NO_IT);
    GPIO_Init(GPIOB, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
}

void ADC2_setup(void) {
    ADC2_DeInit();

    ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS,
              ADC2_CHANNEL_5,
              ADC2_PRESSEL_FCPU_D2,
              ADC2_EXTTRIG_GPIO,
              DISABLE,
              ADC2_ALIGN_RIGHT,
              ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6,
              DISABLE);

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
