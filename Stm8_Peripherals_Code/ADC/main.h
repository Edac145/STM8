#include "stdio.h"
#include "stm8s.h"
#include "delay.h"

#define false 0
#define true  1

#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

void clock_setup(void);
void GPIO_setup(void);
void ADC2_setup(void);
void UART3_setup(void);
unsigned int read_ADC_Channel(uint8_t channel);
bool check_negative_zero_crossing(void);
float convert_adc_to_voltage(unsigned int adcValue);
bool detect_negative_zero_cross(unsigned int previous_sample, unsigned int current_sample, unsigned int threshold);
void send_square_pulse(uint16_t duration_ms);
