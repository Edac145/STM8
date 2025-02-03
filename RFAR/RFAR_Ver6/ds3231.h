#ifndef _DS3231_H_
#define _DS3231_H_

void DS3231_GetTime(uint8_t *buf, uint8_t size);
void DS3231_SetTime(uint8_t *buf, uint8_t size);
void DS3231_GetTemp(uint8_t *val, uint8_t *frac);
uint8_t _bcd2dec(uint8_t bcd);
uint8_t _dec2bcd(uint8_t dec);

#endif