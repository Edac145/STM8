   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  42                     ; 62 @far @interrupt void TRAP_IRQHandler(void)
  42                     ; 63 {
  43                     	switch	.text
  44  0000               f_TRAP_IRQHandler:
  48                     ; 67 }
  51  0000 80            	iret
  73                     ; 89 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
  73                     ; 90 {
  74                     	switch	.text
  75  0001               f_TLI_IRQHandler:
  79                     ; 94 }
  82  0001 80            	iret
 104                     ; 102 INTERRUPT_HANDLER(AWU_IRQHandler, 1)	
 104                     ; 103 {
 105                     	switch	.text
 106  0002               f_AWU_IRQHandler:
 110                     ; 107 }
 113  0002 80            	iret
 135                     ; 115 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 135                     ; 116 {
 136                     	switch	.text
 137  0003               f_CLK_IRQHandler:
 141                     ; 120 }
 144  0003 80            	iret
 167                     ; 128 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 167                     ; 129 {
 168                     	switch	.text
 169  0004               f_EXTI_PORTA_IRQHandler:
 173                     ; 133 }
 176  0004 80            	iret
 199                     ; 140 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 199                     ; 141 {
 200                     	switch	.text
 201  0005               f_EXTI_PORTB_IRQHandler:
 205                     ; 145 }
 208  0005 80            	iret
 231                     ; 153 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 231                     ; 154 {
 232                     	switch	.text
 233  0006               f_EXTI_PORTC_IRQHandler:
 237                     ; 158 }
 240  0006 80            	iret
 263                     ; 166 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 263                     ; 167 {
 264                     	switch	.text
 265  0007               f_EXTI_PORTD_IRQHandler:
 269                     ; 171 }
 272  0007 80            	iret
 295                     ; 179 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 295                     ; 180 {
 296                     	switch	.text
 297  0008               f_EXTI_PORTE_IRQHandler:
 301                     ; 184 }
 304  0008 80            	iret
 326                     ; 234 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 326                     ; 235 {
 327                     	switch	.text
 328  0009               f_SPI_IRQHandler:
 332                     ; 239 }
 335  0009 80            	iret
 358                     ; 247 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 358                     ; 248 {
 359                     	switch	.text
 360  000a               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 364                     ; 252 }
 367  000a 80            	iret
 390                     ; 260 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 390                     ; 261 {
 391                     	switch	.text
 392  000b               f_TIM1_CAP_COM_IRQHandler:
 396                     ; 265 }
 399  000b 80            	iret
 422                     ; 300  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 422                     ; 301 {
 423                     	switch	.text
 424  000c               f_TIM2_UPD_OVF_BRK_IRQHandler:
 428                     ; 305 }
 431  000c 80            	iret
 454                     ; 313  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 454                     ; 314 {
 455                     	switch	.text
 456  000d               f_TIM2_CAP_COM_IRQHandler:
 460                     ; 318 }
 463  000d 80            	iret
 486                     ; 329  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 486                     ; 330 {
 487                     	switch	.text
 488  000e               f_TIM3_UPD_OVF_BRK_IRQHandler:
 492                     ; 334 }
 495  000e 80            	iret
 518                     ; 342  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 518                     ; 343 {
 519                     	switch	.text
 520  000f               f_TIM3_CAP_COM_IRQHandler:
 524                     ; 347 }
 527  000f 80            	iret
 550                     ; 358  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 550                     ; 359 {
 551                     	switch	.text
 552  0010               f_UART1_TX_IRQHandler:
 556                     ; 363 }
 559  0010 80            	iret
 582                     ; 371  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 582                     ; 372 {
 583                     	switch	.text
 584  0011               f_UART1_RX_IRQHandler:
 588                     ; 376 }
 591  0011 80            	iret
 613                     ; 385 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 613                     ; 386 {
 614                     	switch	.text
 615  0012               f_I2C_IRQHandler:
 619                     ; 390 }
 622  0012 80            	iret
 645                     ; 427  INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
 645                     ; 428 {
 646                     	switch	.text
 647  0013               f_UART3_TX_IRQHandler:
 651                     ; 432 }
 654  0013 80            	iret
 677                     ; 440  INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
 677                     ; 441 {
 678                     	switch	.text
 679  0014               f_UART3_RX_IRQHandler:
 683                     ; 445 }
 686  0014 80            	iret
 708                     ; 455  INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
 708                     ; 456 {
 709                     	switch	.text
 710  0015               f_ADC2_IRQHandler:
 714                     ; 460 }
 717  0015 80            	iret
 740                     ; 495  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 740                     ; 496 {
 741                     	switch	.text
 742  0016               f_TIM4_UPD_OVF_IRQHandler:
 746                     ; 500 }
 749  0016 80            	iret
 772                     ; 509 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 772                     ; 510 {
 773                     	switch	.text
 774  0017               f_EEPROM_EEC_IRQHandler:
 778                     ; 514 }
 781  0017 80            	iret
 793                     	xdef	f_EEPROM_EEC_IRQHandler
 794                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 795                     	xdef	f_ADC2_IRQHandler
 796                     	xdef	f_UART3_TX_IRQHandler
 797                     	xdef	f_UART3_RX_IRQHandler
 798                     	xdef	f_I2C_IRQHandler
 799                     	xdef	f_UART1_RX_IRQHandler
 800                     	xdef	f_UART1_TX_IRQHandler
 801                     	xdef	f_TIM3_CAP_COM_IRQHandler
 802                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
 803                     	xdef	f_TIM2_CAP_COM_IRQHandler
 804                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 805                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 806                     	xdef	f_TIM1_CAP_COM_IRQHandler
 807                     	xdef	f_SPI_IRQHandler
 808                     	xdef	f_EXTI_PORTE_IRQHandler
 809                     	xdef	f_EXTI_PORTD_IRQHandler
 810                     	xdef	f_EXTI_PORTC_IRQHandler
 811                     	xdef	f_EXTI_PORTB_IRQHandler
 812                     	xdef	f_EXTI_PORTA_IRQHandler
 813                     	xdef	f_CLK_IRQHandler
 814                     	xdef	f_AWU_IRQHandler
 815                     	xdef	f_TLI_IRQHandler
 816                     	xdef	f_TRAP_IRQHandler
 835                     	end
