#include "stm8s.h"
#include "stm8s_clk.h"
#include "stm8s_adc2.h"
#include "stm8s_uart3.h"
#include "stdio.h"
#include "eeprom.h"
#include "ds3231.h"


/** Macro Definitions **/
#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

void clock_setup(void);
void UART3_setup(void);
void ADC2_setup(void);
void GPIO_setup(void);

void UART3_ClearBuffer(void) ;
void UART3_ReceiveString(char *buffer, uint16_t max_length);

uint32_t elapsedTime(uint32_t start, uint32_t end);
unsigned int read_ADC_Channel(uint8_t channel);

void printDateTime(void);