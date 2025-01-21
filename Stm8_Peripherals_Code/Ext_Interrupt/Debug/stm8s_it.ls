   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  43                     ; 42 void EXTI1_IRQHandler(void)
  43                     ; 43 {
  44                     	switch	.text
  45  0000               f_EXTI1_IRQHandler:
  49                     ; 44 	state ^= 1;
  51  0000 90100000      	bcpl	_state,#0
  52                     ; 45 }
  55  0004 80            	iret
  78                     ; 56 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  78                     ; 57 {
  79                     	switch	.text
  80  0005               f_NonHandledInterrupt:
  84                     ; 61 }
  87  0005 80            	iret
 109                     ; 69 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
 109                     ; 70 {
 110                     	switch	.text
 111  0006               f_TRAP_IRQHandler:
 115                     ; 74 }
 118  0006 80            	iret
 140                     ; 80 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 140                     ; 81 {
 141                     	switch	.text
 142  0007               f_TLI_IRQHandler:
 146                     ; 85 }
 149  0007 80            	iret
 171                     ; 92 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 171                     ; 93 {
 172                     	switch	.text
 173  0008               f_AWU_IRQHandler:
 177                     ; 97 }
 180  0008 80            	iret
 202                     ; 104 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 202                     ; 105 {
 203                     	switch	.text
 204  0009               f_CLK_IRQHandler:
 208                     ; 109 }
 211  0009 80            	iret
 234                     ; 116 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 234                     ; 117 {
 235                     	switch	.text
 236  000a               f_EXTI_PORTA_IRQHandler:
 240                     ; 121 }
 243  000a 80            	iret
 266                     ; 128 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 266                     ; 129 {
 267                     	switch	.text
 268  000b               f_EXTI_PORTB_IRQHandler:
 272                     ; 133 }
 275  000b 80            	iret
 298                     ; 140 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 298                     ; 141 {
 299                     	switch	.text
 300  000c               f_EXTI_PORTC_IRQHandler:
 304                     ; 145 }
 307  000c 80            	iret
 330                     ; 152 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 330                     ; 153 {
 331                     	switch	.text
 332  000d               f_EXTI_PORTD_IRQHandler:
 336                     ; 157 }
 339  000d 80            	iret
 362                     ; 164 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 362                     ; 165 {
 363                     	switch	.text
 364  000e               f_EXTI_PORTE_IRQHandler:
 368                     ; 169 }
 371  000e 80            	iret
 393                     ; 215 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 393                     ; 216 {
 394                     	switch	.text
 395  000f               f_SPI_IRQHandler:
 399                     ; 220 }
 402  000f 80            	iret
 425                     ; 227 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 425                     ; 228 {
 426                     	switch	.text
 427  0010               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 431                     ; 232 }
 434  0010 80            	iret
 457                     ; 239 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 457                     ; 240 {
 458                     	switch	.text
 459  0011               f_TIM1_CAP_COM_IRQHandler:
 463                     ; 244 }
 466  0011 80            	iret
 489                     ; 276  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 489                     ; 277 {
 490                     	switch	.text
 491  0012               f_TIM2_UPD_OVF_BRK_IRQHandler:
 495                     ; 281 }
 498  0012 80            	iret
 521                     ; 288  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 521                     ; 289 {
 522                     	switch	.text
 523  0013               f_TIM2_CAP_COM_IRQHandler:
 527                     ; 293 }
 530  0013 80            	iret
 553                     ; 303  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 553                     ; 304 {
 554                     	switch	.text
 555  0014               f_TIM3_UPD_OVF_BRK_IRQHandler:
 559                     ; 308 }
 562  0014 80            	iret
 585                     ; 315  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 585                     ; 316 {
 586                     	switch	.text
 587  0015               f_TIM3_CAP_COM_IRQHandler:
 591                     ; 320 }
 594  0015 80            	iret
 617                     ; 330  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 617                     ; 331 {
 618                     	switch	.text
 619  0016               f_UART1_TX_IRQHandler:
 623                     ; 335 }
 626  0016 80            	iret
 649                     ; 342  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 649                     ; 343 {
 650                     	switch	.text
 651  0017               f_UART1_RX_IRQHandler:
 655                     ; 347 }
 658  0017 80            	iret
 680                     ; 355 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 680                     ; 356 {
 681                     	switch	.text
 682  0018               f_I2C_IRQHandler:
 686                     ; 360 }
 689  0018 80            	iret
 712                     ; 394  INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
 712                     ; 395 {
 713                     	switch	.text
 714  0019               f_UART3_TX_IRQHandler:
 718                     ; 399   }
 721  0019 80            	iret
 744                     ; 406  INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
 744                     ; 407 {
 745                     	switch	.text
 746  001a               f_UART3_RX_IRQHandler:
 750                     ; 411   }
 753  001a 80            	iret
 775                     ; 420  INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
 775                     ; 421 {
 776                     	switch	.text
 777  001b               f_ADC2_IRQHandler:
 781                     ; 426     return;
 784  001b 80            	iret
 807                     ; 464  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 807                     ; 465 {
 808                     	switch	.text
 809  001c               f_TIM4_UPD_OVF_IRQHandler:
 813                     ; 470 }
 816  001c 80            	iret
 839                     ; 478 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 839                     ; 479 {
 840                     	switch	.text
 841  001d               f_EEPROM_EEC_IRQHandler:
 845                     ; 483 }
 848  001d 80            	iret
 860                     	xref.b	_state
 861                     	xdef	f_EEPROM_EEC_IRQHandler
 862                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 863                     	xdef	f_ADC2_IRQHandler
 864                     	xdef	f_UART3_TX_IRQHandler
 865                     	xdef	f_UART3_RX_IRQHandler
 866                     	xdef	f_I2C_IRQHandler
 867                     	xdef	f_UART1_RX_IRQHandler
 868                     	xdef	f_UART1_TX_IRQHandler
 869                     	xdef	f_TIM3_CAP_COM_IRQHandler
 870                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
 871                     	xdef	f_TIM2_CAP_COM_IRQHandler
 872                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 873                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 874                     	xdef	f_TIM1_CAP_COM_IRQHandler
 875                     	xdef	f_SPI_IRQHandler
 876                     	xdef	f_EXTI_PORTE_IRQHandler
 877                     	xdef	f_EXTI_PORTD_IRQHandler
 878                     	xdef	f_EXTI_PORTC_IRQHandler
 879                     	xdef	f_EXTI_PORTB_IRQHandler
 880                     	xdef	f_EXTI_PORTA_IRQHandler
 881                     	xdef	f_CLK_IRQHandler
 882                     	xdef	f_AWU_IRQHandler
 883                     	xdef	f_TLI_IRQHandler
 884                     	xdef	f_TRAP_IRQHandler
 885                     	xdef	f_NonHandledInterrupt
 886                     	xdef	f_EXTI1_IRQHandler
 905                     	end
