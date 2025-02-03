#ifndef MAIN_H
#define MAIN_H

#include "stm8s.h"

#define false 0
#define true  1

#define ADC_MAX_VALUE 1023.0                              // 10-bit ADC on Arduino Uno
#define V_REF 4.6                                        // Reference voltage                              
#define NUM_SAMPLES 1024                                  // Number of samples
#define SAMPLE_RATE 150                                   // Sampling rate in Hz
#define ZEROCROSS_THRESHOLD 2.64                         // Signal zero-crossing threshold
#define VAR_SIGNAL ADC2_CHANNEL_5
#define FDR_SIGNAL ADC2_CHANNEL_6
#define SET_FREQ 5.0    
#define AC_AMPLITUDE_THRESHOLD 0.01  // AC threshold in Volts (20mV)
#define SQUARE_PULSE_MS 5         // Square pulse duration in ms
#define SET_FREQUENCY_ADDRESS 0x4000

/** Global Variables **/
volatile float sine1_frequency = 0.0;                     // Frequency of sine wave 1
volatile float sine1_amplitude = 0.0;                     // Amplitude of sine wave 1
unsigned long lastEdgeTime = 0;                           // Time of the last zero crossing
unsigned long currentEdgeTime = 0;                        // Time of the current zero crossing
int crossingType = -1;                                    // Crossing type: -1 (undetermined), 0 (positive), 1 (negative)
unsigned int count = 0;
bool isThyristorON = false;

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

void configure_set_frequency(void);





#endif //MAIN_H