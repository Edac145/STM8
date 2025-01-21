#ifndef __MAIN_H__
#define __MAIN_H__
#include "stm8s.h"

#define BUZZER_GPIO_PORT  (GPIOA)
#define BUZZER_PIN GPIO_PIN_3
//extern void buzzer_init();
//extern void buzzer(char on);


//#define TEST  GPIO_PIN_2
//#define HALL GPIO_PIN_3

#define DIGTRON_PORT GPIOC
#define SI  GPIO_PIN_4
#define SCK GPIO_PIN_3
#define RCK GPIO_PIN_2
//#define EN  GPIO_PIN_5
#define DIGTRON_GPIO_PINS (SI | SCK | RCK )
//extern void digtron_init();
//extern void digtron_display(char l);
//extern void digtron_display_none();

#define RELAY_GPIO_PORT   GPIOB
#define RELAY_PIN         GPIO_PIN_1
//extern void relay_init();
//extern void relay(char on);


#define sEE_I2C                          I2C  
#define sEE_I2C_CLK                      CLK_PERIPHERAL_I2C
#define sEE_I2C_SCL_PIN                  GPIO_PIN_1                  /* PC.01 */
#define sEE_I2C_SCL_GPIO_PORT            GPIOE                       /* GPIOE */
#define sEE_I2C_SDA_PIN                  GPIO_PIN_2                  /* PC.00 */
#define sEE_I2C_SDA_GPIO_PORT            GPIOE                       /* GPIOE */
//#define sEE_M24C64_32


#define sEE_DIRECTION_TX                 0
#define sEE_DIRECTION_RX       1



//#define SD_DETECT_PIN                                      /* PE.04 */
//#define SD_DETECT_GPIO_PORT                                     /* GPIOE */

#endif

