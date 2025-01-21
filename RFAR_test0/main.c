/* MAIN.C file
 * Author: EDAC Multitech Pvt Ltd
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s.h"
#include "delay.h"
#include "string.h"

#define UART_RECEIVE_BUFFER_SIZE 100 // Define a maximum buffer size
#define TERMINATION_CHAR '\n'       // Define the termination character

struct sineWave
{
	float frequency;
	float amplitude;
};


unsigned long lastEdgeTime = 0;          // Time of the last zero crossing
unsigned long currentEdgeTime = 0;       // Time of the current zero crossing
volatile float sine1_frequency = 0.0;    // Frequency of sine wave 1

void clock_setup(void);
void ADC2_setup(void);
void UART1_setup(void);
unsigned int ADC_Conversion(uint8_t adcChannel);
char UART1_ReceiveString(char *buffer);
struct sineWave adc_sampling(void);
bool detectPosZeroCross(float adcPrev, float adcCurrent);



void main()
{
	unsigned int A0 = 0x0000; // ADC Channel 0 Value
	unsigned int A1 = 0x0000; // ADC Channel 1 Value
	char rxBuffer[UART_RECEIVE_BUFFER_SIZE]; // Buffer to hold the received string

	clock_setup();
	ADC2_setup();
	UART1_setup();
	while (1)
	{
		unsigned char length = UART1_ReceiveString(rxBuffer); // Receive the string
   // A0 = ADC_Conversion(ADC2_CHANNEL_0);
	 struct sineWave obj = adc_sampling();
		
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
     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
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

void ADC2_setup(void)
{
   ADC2_DeInit();         
                
   ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, 
             ADC2_CHANNEL_0,
             ADC2_PRESSEL_FCPU_D18, 
             ADC2_EXTTRIG_GPIO, 
             DISABLE, 
             ADC2_ALIGN_RIGHT, 
             ADC2_SCHMITTTRIG_CHANNEL0 | ADC2_SCHMITTTRIG_CHANNEL1, 
             DISABLE);
						 
                                                                                  
   ADC2_Cmd(ENABLE);
}

unsigned int ADC_Conversion(uint8_t adcChannel)
{
	unsigned int adcValue = 0;
	// Configure and Read ADC Channel 0
	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, 
												adcChannel, 
												ADC2_ALIGN_RIGHT);
	ADC2_StartConversion();
	while (ADC2_GetFlagStatus() == FALSE);
	adcValue = ADC2_GetConversionValue();
	ADC2_ClearFlag();
	return adcValue;	
}

struct sineWave adc_sampling(void)
{
	  struct sineWave sinewave;
    // Variable declarations moved to the top
    float adc_buffer_1[256] = { -1 };  // ADC buffer for sine wave 1
    unsigned long period;
    uint16_t i;                               // Loop counter
    int freqCount = 0;                        // Frequency count
    float freqBuff = 0.0;                     // Frequency buffer
    lastEdgeTime = 0;                         // Initialize last edge time

    // Read sine wave 1 (input signal 1)
    for (i = 0; i < 256; i++) {
        adc_buffer_1[i] = (ADC_Conversion(ADC2_CHANNEL_0) * (5 / 1023.0));  // Convert ADC value to voltage

        if (i > 0 && detectPosZeroCross(adc_buffer_1[i - 1], adc_buffer_1[i])) {
            currentEdgeTime = micros();                               // Record current time
            if (lastEdgeTime > 0) {                                   // Ensure a previous edge exists
                period = currentEdgeTime - lastEdgeTime;              // Calculate period
                freqCount++;
                sine1_frequency = 1.0 / (period / 1e6);               // Convert period to frequency (Hz)
                freqBuff += sine1_frequency;
            }
            lastEdgeTime = currentEdgeTime;  // Update last edge time
        }
    }
		
		 // // Calculate frequency and amplitude for sine wave 1
  sinewave.frequency = freqBuff / freqCount;
 // sinewave.amplitude = calculate_amplitude(adc_buffer_1, NUM_SAMPLES);
	return sinewave; 
}

 bool detectPosZeroCross(float adcPrev, float adcCurrent) 
{
  if (adcPrev == 0 && adcCurrent > 0) 
	{
    return 1;
  } 
	else
    return 0;
}

void UART1_setup(void)
{
     UART1_DeInit();
                
     UART1_Init(9600, 
                UART1_WORDLENGTH_8D,  
                UART1_STOPBITS_1, 
                UART1_PARITY_NO, 
                UART1_SYNCMODE_CLOCK_DISABLE, 
                UART1_MODE_TXRX_ENABLE);
                
     UART1_Cmd(ENABLE);
		 return;
}

void UART1_SendString(char *str)
{
    while (*str) // Loop until the null terminator is encountered
    {
        UART1_SendData8(*str); // Send the current character
        while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); // Wait for TXE flag
        str++; // Move to the next character
    }
}

char UART1_ReceiveString(char *buffer)
{
    char ch;
    unsigned char index = 0;

    // Initialize the buffer with null terminators
    memset(buffer, 0, UART_RECEIVE_BUFFER_SIZE);

    while (TRUE)
    {
        // Check if a character is received
        if (UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE)
        {
            ch = UART1_ReceiveData8(); // Receive the character
            UART1_ClearFlag(UART1_FLAG_RXNE);

            if (ch == TERMINATION_CHAR || index >= (UART_RECEIVE_BUFFER_SIZE - 1))
            {
                buffer[index] = '\0'; // Null-terminate the string
                return index;        // Return the length of the string
            }

            buffer[index++] = ch; // Store the character and increment the index
        }
    }
}