   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  43                     ; 61 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  43                     ; 62 {
  44                     	switch	.text
  45  0000               f_NonHandledInterrupt:
  49                     ; 66 }
  52  0000 80            	iret
  74                     ; 74 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  74                     ; 75 {
  75                     	switch	.text
  76  0001               f_TRAP_IRQHandler:
  80                     ; 79 }
  83  0001 80            	iret
 105                     ; 86 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 105                     ; 87 
 105                     ; 88 {
 106                     	switch	.text
 107  0002               f_TLI_IRQHandler:
 111                     ; 92 }
 114  0002 80            	iret
 136                     ; 99 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 136                     ; 100 {
 137                     	switch	.text
 138  0003               f_AWU_IRQHandler:
 142                     ; 104 }
 145  0003 80            	iret
 167                     ; 111 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 167                     ; 112 {
 168                     	switch	.text
 169  0004               f_CLK_IRQHandler:
 173                     ; 116 }
 176  0004 80            	iret
 199                     ; 123 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 199                     ; 124 {
 200                     	switch	.text
 201  0005               f_EXTI_PORTA_IRQHandler:
 205                     ; 128 }
 208  0005 80            	iret
 231                     ; 135 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 231                     ; 136 {
 232                     	switch	.text
 233  0006               f_EXTI_PORTB_IRQHandler:
 237                     ; 140 }
 240  0006 80            	iret
 263                     ; 147 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 263                     ; 148 {
 264                     	switch	.text
 265  0007               f_EXTI_PORTC_IRQHandler:
 269                     ; 152 }
 272  0007 80            	iret
 295                     ; 159 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 295                     ; 160 {
 296                     	switch	.text
 297  0008               f_EXTI_PORTD_IRQHandler:
 301                     ; 164 }
 304  0008 80            	iret
 327                     ; 171 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 327                     ; 172 {
 328                     	switch	.text
 329  0009               f_EXTI_PORTE_IRQHandler:
 333                     ; 176 }
 336  0009 80            	iret
 358                     ; 223 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 358                     ; 224 {
 359                     	switch	.text
 360  000a               f_SPI_IRQHandler:
 364                     ; 228 }
 367  000a 80            	iret
 390                     ; 235 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 390                     ; 236 {
 391                     	switch	.text
 392  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 396                     ; 240 }
 399  000b 80            	iret
 422                     ; 247 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 422                     ; 248 {
 423                     	switch	.text
 424  000c               f_TIM1_CAP_COM_IRQHandler:
 428                     ; 252 }
 431  000c 80            	iret
 454                     ; 285  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 454                     ; 286  {
 455                     	switch	.text
 456  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 460                     ; 290  }
 463  000d 80            	iret
 486                     ; 297  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 486                     ; 298  {
 487                     	switch	.text
 488  000e               f_TIM2_CAP_COM_IRQHandler:
 492                     ; 302  }
 495  000e 80            	iret
 518                     ; 312  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 518                     ; 313  {
 519                     	switch	.text
 520  000f               f_TIM3_UPD_OVF_BRK_IRQHandler:
 524                     ; 317  }
 527  000f 80            	iret
 550                     ; 324  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 550                     ; 325  {
 551                     	switch	.text
 552  0010               f_TIM3_CAP_COM_IRQHandler:
 556                     ; 329  }
 559  0010 80            	iret
 582                     ; 339  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 582                     ; 340  {
 583                     	switch	.text
 584  0011               f_UART1_TX_IRQHandler:
 588                     ; 344  }
 591  0011 80            	iret
 614                     ; 351  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 614                     ; 352  {
 615                     	switch	.text
 616  0012               f_UART1_RX_IRQHandler:
 620                     ; 356  }
 623  0012 80            	iret
 645                     ; 390 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 645                     ; 391 {
 646                     	switch	.text
 647  0013               f_I2C_IRQHandler:
 651                     ; 395 }
 654  0013 80            	iret
 677                     ; 429  INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
 677                     ; 430  {
 678                     	switch	.text
 679  0014               f_UART3_TX_IRQHandler:
 683                     ; 434  }
 686  0014 80            	iret
 709                     ; 441  INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
 709                     ; 442  {
 710                     	switch	.text
 711  0015               f_UART3_RX_IRQHandler:
 715                     ; 446  }
 718  0015 80            	iret
 740                     ; 455  INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
 740                     ; 456  {
 741                     	switch	.text
 742  0016               f_ADC2_IRQHandler:
 746                     ; 460  }
 749  0016 80            	iret
 772                     ; 495  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 772                     ; 496  {
 773                     	switch	.text
 774  0017               f_TIM4_UPD_OVF_IRQHandler:
 778                     ; 500  }
 781  0017 80            	iret
 804                     ; 508 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 804                     ; 509 {
 805                     	switch	.text
 806  0018               f_EEPROM_EEC_IRQHandler:
 810                     ; 513 }
 813  0018 80            	iret
 825                     	xdef	f_EEPROM_EEC_IRQHandler
 826                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 827                     	xdef	f_ADC2_IRQHandler
 828                     	xdef	f_UART3_TX_IRQHandler
 829                     	xdef	f_UART3_RX_IRQHandler
 830                     	xdef	f_I2C_IRQHandler
 831                     	xdef	f_UART1_RX_IRQHandler
 832                     	xdef	f_UART1_TX_IRQHandler
 833                     	xdef	f_TIM3_CAP_COM_IRQHandler
 834                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
 835                     	xdef	f_TIM2_CAP_COM_IRQHandler
 836                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 837                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 838                     	xdef	f_TIM1_CAP_COM_IRQHandler
 839                     	xdef	f_SPI_IRQHandler
 840                     	xdef	f_EXTI_PORTE_IRQHandler
 841                     	xdef	f_EXTI_PORTD_IRQHandler
 842                     	xdef	f_EXTI_PORTC_IRQHandler
 843                     	xdef	f_EXTI_PORTB_IRQHandler
 844                     	xdef	f_EXTI_PORTA_IRQHandler
 845                     	xdef	f_CLK_IRQHandler
 846                     	xdef	f_AWU_IRQHandler
 847                     	xdef	f_TLI_IRQHandler
 848                     	xdef	f_TRAP_IRQHandler
 849                     	xdef	f_NonHandledInterrupt
 868                     	end
