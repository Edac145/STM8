#ifndef DELAY_H
#define DELAY_H

/** Global tick **/
	extern volatile uint32_t tick;

/** Functions **/
  @far @interrupt void TIM4_IRQHandler(void);
	void TIM4_Config(void);
	void delay_ms(uint16_t ms);
	void delay_us(uint16_t us);
	uint16_t millis(void);
	uint32_t micros(void);

#endif //DELAY_H
