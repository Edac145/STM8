#include "stdio.h"
#include "stdlib.h"
#include "stm8s.h"

#ifdef _RAISONANCE_
#define PUTCHAR_PROTOTYPE int putchar(char c)
#define GETCHAR_PROTOTYPE int getchar(void)
#elif defined(_COSMIC_)
#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)
#else /* _IAR_ */
#define PUTCHAR_PROTOTYPE int putchar(int c)
#define GETCHAR_PROTOTYPE int getchar(void)
#endif /* _RAISONANCE_ */

volatile unsigned long millis_count = 0;  // Milliseconds counter
volatile unsigned int micros_offset = 0;  // Microseconds offset
volatile uint32_t tick = 0;               // increments every 250us

// Function Prototypes
void clock_setup(void);
void TIM4_Config(void);
void delay_ms(uint16_t ms);
void delay_us(uint16_t us);
uint16_t millis(void);
uint32_t micros(void);
uint32_t elapsedTime(uint32_t start, uint32_t end);
@far @interrupt void TIM4_IRQHandler(void);
void UART3_setup(void);
// int putchar(int ch);

void main() {
  clock_setup();
  TIM4_Config();
  UART3_setup();
  GPIO_DeInit(GPIOC);
  GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);

  enableInterrupts();  // Enable global interrupts
                       // printf("UART initialized. Ready to send and receive
                       // data.\r\n");

  while (1) {
    uint32_t start_time, currentTime;
    uint32_t LoopTime;
    while (1) {
      start_time = millis();
      // printf("StartTime: %lu\n", start_time);
      GPIO_WriteLow(GPIOC, GPIO_PIN_3);
      delay_ms(1000);  // LED OFF for 100ms
      GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
      delay_ms(1000);  // LED ON for 100ms
      currentTime = millis();
      LoopTime = elapsedTime(start_time, currentTime);
      printf("currentTime: %lu   starTime: %lu   Loop Time: %lu\n", currentTime,
             start_time, LoopTime);
      start_time = 0;
    }
  }
}

void clock_setup(void) {
  CLK_DeInit();
  CLK_HSECmd(DISABLE);
  CLK_LSICmd(DISABLE);
  CLK_HSICmd(ENABLE);
  while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);

  CLK_ClockSwitchCmd(ENABLE);
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);

  CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
                        CLK_CURRENTCLOCKSTATE_ENABLE);

  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
  // CLK_CCOConfig(CLK_OUTPUT_CPU);
  // CLK_CCOCmd(ENABLE);
  // while(CLK_GetFlagStatus(CLK_FLAG_CCORDY) == FALSE);
}

void TIM4_Config(void) {
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);

  TIM4_DeInit();
  TIM4_TimeBaseInit(TIM4_PRESCALER_16,
                    250);  // TimerClock = 16000000 / 16 / 250 = 4000Hz
  TIM4_ClearFlag(TIM4_FLAG_UPDATE);
  TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);

  enableInterrupts();  // global interrupt enable
  TIM4_Cmd(ENABLE);    // Start Timer 4
}

void delay_ms(uint16_t ms) {
  int i;
  for (i = 0; i < ms; i++) {
    delay_us(1000);
  }
}

/** delays to the nearest 1us
 * accepts a value from 0 to 65536us to delay
 * if longer delays are needed, use delay_ms
 **/
void delay_us(uint16_t us) {
  uint8_t start_us = TIM4_GetCounter();  // tim4 increments every us
  if (us >= 250) {  // we only need to bother with the following for delays
                    // greater than 1 tick (250us)
    uint16_t start_tick = (uint16_t)tick;  // the tick increments every 250us
    uint16_t delay_ticks = us / 250;

    while (((uint16_t)tick - start_tick) <
           delay_ticks);  // delay in multiples of 250us
  }
  while (TIM4_GetCounter() <
         start_us);  // now wait until our 1us counter matches our start us
}

/** returns the number of milliseconds that have passed since boot  **/
uint16_t millis(void) {
  return ((uint16_t)(tick >> 2));  // divide tick by 4 returns milliseconds
}

/** returns the number of microseconds that have passed since boot  **/
uint32_t micros(void) {
  return (tick * 250 + TIM4_GetCounter());  // each tick is worth 250us
}

uint32_t elapsedTime(uint32_t start, uint32_t end) {
  if (end >= start) {
    // Normal case: no rollover
    return end - start;
  } else {  // Handle timer/unsigned int rollover
    return (65535 - start + 1) + end;
  }
}

@far @interrupt void TIM4_IRQHandler(void) {
  tick++;
  TIM4_ClearFlag(TIM4_FLAG_UPDATE);  // Clear the TIM4 update interrupt flag
                                     // GPIO_WriteReverse(GPIOC, GPIO_PIN_3);
}

// Configure UART1
void UART3_setup(void) {
  UART3_DeInit();

  // Configure UART1 at 9600 baud rate, 8 bits, no parity, 1 stop bit
  UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
             UART3_MODE_TX_ENABLE);

  UART3_Cmd(ENABLE);  // Enable UART1
}

PUTCHAR_PROTOTYPE {
  /* Write a character to the UART1 */
  UART3_SendData8(c);
  /* Loop until the end of transmission */
  while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);

  return (c);
}
