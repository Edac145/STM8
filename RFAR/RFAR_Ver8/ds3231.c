#include "stm8s.h"
#include "ds3231_internal.h"
#include "ds3231.h"
#include "i2c.h"
#include "stdio.h"
#include "string.h"


void DS3231_GetTime(uint8_t *buf, uint8_t size)
{
    I2CRead(DS3231_READ_ADDR, DS3231_SECONDS, buf, size);
}

void DS3231_SetTime(uint8_t *buf, uint8_t size)
{
#define SETTIME
#ifdef SETTIME
		const char *months = "JanFebMarAprMayJunJulAugSepOctNovDec";
	  const char *month_str = __DATE__;
	  int year;
	  int month;
    int day;
		// Calculate the month
		
    month = ((strstr(months, month_str) - months) / 3 + 1); // Month index (1 for Jan, 2 for Feb, etc.)
    buf[0] = (__TIME__[6] - '0')*16 + (__TIME__[7] - '0');
    buf[1] = (__TIME__[3] - '0')*16 + (__TIME__[4] - '0');
    buf[2] = (__TIME__[0] - '0')*16 + (__TIME__[1] - '0');
		buf[5] = ('0' - '0') * 16 + ('2' - '0');
    buf[4] = ((__DATE__[4] - '0') * 16) + (__DATE__[5] - '0'); // Day
    buf[6] = ((__DATE__[9] - '0') * 16) + (__DATE__[10] - '0'); // Year (last two digits)

  //  buf[3] = ((day + (13 * (month + 1)) / 5 + year + (year / 4) - (year / 100) + (year / 400)) % 7) + 1;


    I2CWrite(DS3231_WRITE_ADDR, DS3231_SECONDS, buf, size);
#else
    (void *) buf;
    (void *) size;
#endif
}

void DS3231_GetTemp(uint8_t *val, uint8_t *frac)
{
    uint8_t tmp;

    I2CRead(DS3231_ADDR, DS3231_TEMP_MSB, val, 1);
    I2CRead(DS3231_ADDR, DS3231_TEMP_LSB, &tmp, 1);

    switch (tmp)
    {
        case 0x40:
            *frac = 3;
            break;
        case 0x80:
            *frac = 5;
            break;
        case 0xC0:
            *frac = 8;
            break;
        default:
            *frac = 0;
    }
}

uint8_t _bcd2dec(uint8_t bcd)
{
    return ((bcd >> 4) * 10) + (bcd & 0x0F);
}

uint8_t _dec2bcd(uint8_t dec)
{
    return ((dec / 10) << 4) | (dec % 10);
}
