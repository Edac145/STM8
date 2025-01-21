#include "main.h"


int main(void)
{
	HSI16_config();
	TIM4_SYSTICK_config();
	GPIO_config();
	enableInterrupts();

	while (1)
	{
		GPIO_WriteReverse(GPIOB, GPIO_PIN_5);
		DELAY_ms(500);
	}
}



#ifdef USE_FULL_ASSERT

	void assert_failed(uint8_t* file, uint32_t line)
	{
		while (1)
		{
		}
	}
#endif