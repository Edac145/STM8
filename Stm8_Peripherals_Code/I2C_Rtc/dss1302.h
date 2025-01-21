#include "stm8s.h"

#define DS1302_RST    GPIO_PIN_6
#define DS1302_RST_PORT   GPIOB
#define DS1302_SCLK   GPIO_PIN_4
#define DS1302_SCLK_PORT   GPIOD
#define DS1302_DATA   GPIO_PIN_7
#define DS1302_DATA_PORT  GPIOB

extern void ds1302_init();
extern void set_time(unsigned char time[]);
extern void read_time(unsigned char time[7]);