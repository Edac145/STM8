/* Ds1302.c
 *
 * Ds1302 library for STM8AF5288
 *
 * @version 1.0.0
 * @author Your Name
 * @license MIT
 */

#include "Ds1302.h"
#include "stm8s.h"
#include "delay.h"

#define REG_SECONDS           0x80
#define REG_MINUTES           0x82
#define REG_HOUR              0x84
#define REG_DATE              0x86
#define REG_MONTH             0x88
#define REG_DAY               0x8A
#define REG_YEAR              0x8C
#define REG_WP                0x8E
#define REG_BURST             0xBE

static GPIO_TypeDef* _port_ena;
static GPIO_TypeDef* _port_clk;
static GPIO_TypeDef* _port_dat;
static uint8_t _pin_ena;
static uint8_t _pin_clk;
static uint8_t _pin_dat;
static uint8_t _dat_direction;

static void _setDirection(GPIO_TypeDef* port, uint8_t pin, uint8_t direction);
static void _nextBit(void);
uint8_t _readByte(void);
static void _writeByte(uint8_t value);
static uint8_t _bcd2dec(uint8_t bcd);
static uint8_t _dec2bcd(uint8_t dec);
static void _prepareRead(uint8_t address);
static void _prepareWrite(uint8_t address);
static void _end(void);

void Ds1302_Init(GPIO_TypeDef* port_ena, uint8_t pin_ena, 
                 GPIO_TypeDef* port_clk, uint8_t pin_clk, 
                 GPIO_TypeDef* port_dat, uint8_t pin_dat)
{
    _port_ena = port_ena;
    _port_clk = port_clk;
    _port_dat = port_dat;
    _pin_ena = pin_ena;
    _pin_clk = pin_clk;
    _pin_dat = pin_dat;

    _dat_direction = INPUT;

    GPIO_Init(port_ena, pin_ena, GPIO_MODE_OUT_PP_LOW_FAST);
    GPIO_Init(port_clk, pin_clk, GPIO_MODE_OUT_PP_LOW_FAST);
    _setDirection(port_dat, pin_dat, _dat_direction);

    GPIO_WriteLow(port_ena, pin_ena);
    GPIO_WriteLow(port_clk, pin_clk);
}

bool Ds1302_IsHalted(void)
{
	uint8_t seconds = 0;
	_prepareRead(REG_SECONDS);
	seconds = _readByte();
	_end();
	return (seconds & 0b10000000);
}

void Ds1302_GetDateTime(DateTime* dt)
{
    _prepareRead(REG_BURST);
    dt->second = _bcd2dec(_readByte() & 0b01111111);
    dt->minute = _bcd2dec(_readByte() & 0b01111111);
    dt->hour   = _bcd2dec(_readByte() & 0b00111111);
    dt->day    = _bcd2dec(_readByte() & 0b00111111);
    dt->month  = _bcd2dec(_readByte() & 0b00011111);
    dt->dow    = _bcd2dec(_readByte() & 0b00000111);
    dt->year   = _bcd2dec(_readByte() & 0b11111111);
    _end();
}

void Ds1302_SetDateTime(DateTime* dt)
{
    _prepareWrite(REG_WP);
    _writeByte(0b00000000);
    _end();

    _prepareWrite(REG_BURST);
    _writeByte(_dec2bcd(dt->second % 60));
    _writeByte(_dec2bcd(dt->minute % 60));
    _writeByte(_dec2bcd(dt->hour % 24));
    _writeByte(_dec2bcd(dt->day % 32));
    _writeByte(_dec2bcd(dt->month % 13));
    _writeByte(_dec2bcd(dt->dow % 8));
    _writeByte(_dec2bcd(dt->year % 100));
    _writeByte(0b10000000);
    _end();
}

void Ds1302_Halt(void)
{
    _setHaltFlag(true);
}

void Ds1302_Start(void)
{
    _setHaltFlag(false);
}

static void _setHaltFlag(bool stopped)
{
    uint8_t regs[8];
		int b = 0;
    _prepareRead(REG_BURST);
    for (b = 0; b < 8; b++) regs[b] = _readByte();
    _end();

    if (stopped) regs[0] |= 0b10000000;
    else regs[0] &= ~0b10000000;
    regs[7] = 0b10000000;

    _prepareWrite(REG_WP);
    _writeByte(0b00000000);
    _end();

    _prepareWrite(REG_BURST);
    for (b = 0; b < 8; b++) _writeByte(regs[b]);
    _end();
}

static void _prepareRead(uint8_t address)
{
	uint8_t command = 0;
	_setDirection(_port_dat, _pin_dat, OUTPUT);
	GPIO_WriteHigh(_port_ena, _pin_ena);
	command = 0b10000001 | address;
	_writeByte(command);
	_setDirection(_port_dat, _pin_dat, INPUT);
}

static void _prepareWrite(uint8_t address)
{
	uint8_t command = 0;
	_setDirection(_port_dat, _pin_dat, OUTPUT);
	GPIO_WriteHigh(_port_ena, _pin_ena);
	command = 0b10000000 | address;
	_writeByte(command);
}

static void _end(void)
{
    GPIO_WriteLow(_port_ena, _pin_ena);
}

uint8_t _readByte(void)
{
    uint8_t byte = 0;
		uint8_t b = 0;
    for (b = 0; b < 8; b++)
    {
        if (GPIO_ReadInputPin(_port_dat, _pin_dat)) byte |= (0x01 << b);
        _nextBit();
    }

    return byte;
}

static void _writeByte(uint8_t value)
{
	uint8_t b = 0;
    for (b = 0; b < 8; b++)
    {
        GPIO_WriteLow(_port_clk, _pin_clk);
        GPIO_Write(_port_dat, (value & 0x01));
        _nextBit();
        value >>= 1;
    }
}

static void _nextBit(void)
{
    GPIO_WriteHigh(_port_clk, _pin_clk);
    delay_us(1); // Replace with STM8-compatible delay
    GPIO_WriteLow(_port_clk, _pin_clk);
    delay_us(1);
}

static void _setDirection(GPIO_TypeDef* port, uint8_t pin, uint8_t direction)
{
    if (direction == INPUT)
    {
        GPIO_Init(port, pin, GPIO_MODE_IN_FL_NO_IT);
    }
    else
    {
        GPIO_Init(port, pin, GPIO_MODE_OUT_PP_LOW_FAST);
    }
}

static uint8_t _bcd2dec(uint8_t bcd)
{
    return ((bcd >> 4) * 10) + (bcd & 0x0F);
}

static uint8_t _dec2bcd(uint8_t dec)
{
    return ((dec / 10) << 4) | (dec % 10);
}

