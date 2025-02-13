#ifndef MAIN_H
#define MAIN_H

#include "stm8s.h"
#include "string.h"
#include "delay.h"
#include "math.h"
#include "stdio.h"
#include "stdlib.h"
#include "eeprom.h"
#include "i2c.h"
#include "ds3231.h"
#include "init.h"
//EEprom and printdatetime update
#define false 0
#define true  1

#define ADC_MAX_VALUE 1024.0                              // 10-bit ADC on Arduino Uno
#define V_REF 4.6                                        // Reference voltage                              
#define NUM_SAMPLES 512
#define SAMPLE_RATE 150  // Number of samples                     

#define VAR_SIGNAL ADC2_CHANNEL_5
#define FDR_SIGNAL ADC2_CHANNEL_6
#define SET_FREQ 5   
#define AC_AMPLITUDE_THRESHOLD 1.1  // AC threshold in Volts (20mV)        // Square pulse duration in ms
#define SET_FREQUENCY_ADDRESS 0x4000

/** Global Variables **/
volatile float sine1_frequency = 0.0;                     // Frequency of sine wave 1
volatile float sine1_amplitude = 0.0;                     // Amplitude of sine wave 1                                 
unsigned int count = 0;
bool isThyristorON = false;
bool state = 0;
bool pulseFlag = 0;

unsigned int overflow_count = 0;
uint16_t pulse_ticks = 0;
unsigned long start_time = 0;
unsigned long end_time = 0;
unsigned long last_cross_time = 0;
volatile float set_frequency = 5;
volatile float frequency = 0.0;
float set_freq = 0.0;
char buffer[50] = {0};
/** Function Prototypes **/
void initialize_system(void);

bool detectPosZeroCross(float previousSample, float currentSample, float threshold);
bool detectZeroCross(float previousSample, float currentSample, float threshold);
bool detect_negative_zero_cross(float previous_sample, float current_sample, float threshold);
bool check_negative_zero_crossing(void);
void send_square_pulse(uint16_t duration_ms);
void send_pulse_commutation(uint16_t duration_ms);
bool check_signal_dc(float amplitude);

void initialize_adc_buffer(float buffer[]);
void output_results(float frequency, float amplitude, float FDR_Voltage);
float calculate_amplitude(float adc_signal[], uint32_t sample_size);
float process_adc_signal(uint8_t channel, float *frequency, float *amplitude);
float convert_adc_to_voltage(unsigned int adcValue);
float calculate_frequency(unsigned long period);
extern void I2CInit(void);

void read_set_frequency(float *set_freq);
void config_mode(void);
void logResults(const char *logMessage);

float process_FDR_signal(void);
void process_VAR_signal(float FDR_amplitude);
void handle_Frequency_Below_Set_Freq(float VAR_amplitude);
void wait_for_negative_zero_crossing(void);
void handle_signal_1_DC(float VAR_amplitude);
void handle_signal_1_AC(float VAR_amplitude);

bool check_FDR_Zero(void);
void handle_commutation_pulse(void);


float calc_FDR_amplitude(void);


#endif //MAIN_H