#ifndef DS1302_H
#define DS1302_H

#include "stm8s.h"
#include "stdbool.h"

#define INPUT  GPIO_MODE_IN_FL_NO_IT   // Input mode: Floating, no interrupt
#define OUTPUT GPIO_MODE_OUT_PP_LOW_SLOW    // Output mode: Push-Pull, Low

// DateTime structure definition
typedef struct {
    uint8_t second; // Seconds (0-59)
    uint8_t minute; // Minutes (0-59)
    uint8_t hour;   // Hours (0-23)
    uint8_t day;    // Day of the month (1-31)
    uint8_t month;  // Month (1-12)
    uint8_t dow;    // Day of the week (1-7, 1 = Sunday)
    uint8_t year;   // Year (00-99)
} DateTime;

// Public function declarations
void Ds1302_Init(GPIO_TypeDef* port_ena, uint8_t pin_ena, 
                 GPIO_TypeDef* port_clk, uint8_t pin_clk, 
                 GPIO_TypeDef* port_dat, uint8_t pin_dat);
bool Ds1302_IsHalted(void);
void Ds1302_GetDateTime(DateTime* dt);
void Ds1302_SetDateTime(DateTime* dt);
void Ds1302_Halt(void);
void Ds1302_Start(void);
static void _setHaltFlag(bool stopped);
static void _prepareRead(uint8_t address);
static void _prepareWrite(uint8_t address);
static void _end(void);
uint8_t _readByte(void);
static void _writeByte(uint8_t value);
static void _nextBit(void);
static void _setDirection(GPIO_TypeDef* port, uint8_t pin, uint8_t direction);
static uint8_t _bcd2dec(uint8_t bcd);
static uint8_t _dec2bcd(uint8_t dec);

#endif // DS1302_H

