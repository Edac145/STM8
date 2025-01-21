#include "stm8s.h"
#include "ds3231_internal.h"
#include "ds3231.h"
#include "i2c.h"
#include "string.h"

void DS3231_GetTime(uint8_t *buf, uint8_t size)
{
    I2CRead(DS3231_ADDR, DS3231_SECONDS, buf, size);
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
    buf[0] = (__TIME__[6] - '0')*16 + (__TIME__[7] - '0');
    buf[1] = (__TIME__[3] - '0')*16 + (__TIME__[4] - '0');
    buf[2] = (__TIME__[0] - '0')*16 + (__TIME__[1] - '0');
    buf[5] = ((strstr(months, month_str) - months) / 3 + 1);    // Month
    buf[4] = ((__DATE__[4] - '0') << 4) | (__DATE__[5] - '0'); // Day
    buf[6] = ((__DATE__[9] - '0') << 4) | (__DATE__[10] - '0'); // Year (last two digits)

    // Calculate Day of the Week
    year = (__DATE__[9] - '0') * 10 + (__DATE__[10] - '0') + 2000;
    month = (strstr(months, month_str) - months) / 3 + 1;
    day = (__DATE__[4] - '0') * 10 + (__DATE__[5] - '0');
    if (month < 3) {
        month += 12;
        year -= 1;
    }
    buf[3] = ((day + (13 * (month + 1)) / 5 + year + (year / 4) - (year / 100) + (year / 400)) % 7) + 1;


    I2CWrite(DS3231_ADDR, DS3231_SECONDS, buf, size);
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