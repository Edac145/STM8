#ifndef INIT_H
#define INIT_H

#include "stm8s.h"
#include "stm8s_clk.h"
#include "stm8s_adc2.h"
#include "stm8s_uart3.h"
#include "stdio.h"
#include "eeprom.h"
#include "ds3231.h"
#include "stm8s_flash.h"
#include "string.h"

/** Macro Definitions **/
#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

// Define LED colors and their corresponding GPIO pins
#define LED_WHITE     GPIOC, GPIO_PIN_3  // Red LED connected to PC3
#define LED_GREEN     GPIOE, GPIO_PIN_3  // Green LED connected to PE3
#define LED_BLUE      GPIOD, GPIO_PIN_0  // Blue LED connected to PD0
#define LED_ORANGE    GPIOD, GPIO_PIN_3  // Yellow LED connected to PD3
#define LED_RED       GPIOA, GPIO_PIN_3  // White LED connected to PA3

#define SER_THYRISTOR    GPIOC, GPIO_PIN_2  // Red LED connected to PC3
#define COM_THYRISTOR    GPIOE, GPIO_PIN_6  // Green LED connected to PE3

void clock_setup(void);
void UART3_setup(void);
void ADC2_setup(void);
void GPIO_setup(void);
void TIM1_setup(void);
void INT_EEPROM_Setup(void);

void UART3_ClearBuffer(void) ;
void UART3_ReceiveString(char *buffer, uint16_t max_length);

void UART1_setup(void);
void UART1_ClearBuffer(void) ;
void UART1_SendString(char *str);
void UART1_ReceiveString(char *buffer, uint16_t max_length);

void LED_Write(GPIO_TypeDef* GPIOx, uint16_t GPIO_PIN, uint8_t state);

uint32_t elapsedTime(uint32_t start, uint32_t end);
unsigned int read_ADC_Channel(uint8_t channel);

void internal_EEPROM_ReadStr(uint32_t address, char *buffer, uint16_t max_length);
void internal_EEPROM_WriteStr(uint32_t address, char *str);

void printDateTime(void);
void sprintDateTime(char *buffer);

void ConvertFloatToString(float value, char *str, uint16_t maxLength);
float ConvertStringToFloat(char *str) ;
void createFormattedLog(float frequency, float fieldVoltage, float fieldCurrent, float fdrVoltage, const char *message);


#endif //MAIN_H