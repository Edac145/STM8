   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _i:
  16  0000 0000          	dc.w	0
  45                     ; 72 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  45                     ; 73 {
  46                     	switch	.text
  47  0000               f_TRAP_IRQHandler:
  51                     ; 77 }
  54  0000 80            	iret
  76                     ; 84 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
  76                     ; 85 
  76                     ; 86 {
  77                     	switch	.text
  78  0001               f_TLI_IRQHandler:
  82                     ; 90 }
  85  0001 80            	iret
 107                     ; 97 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 107                     ; 98 {
 108                     	switch	.text
 109  0002               f_AWU_IRQHandler:
 113                     ; 102 }
 116  0002 80            	iret
 138                     ; 109 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 138                     ; 110 {
 139                     	switch	.text
 140  0003               f_CLK_IRQHandler:
 144                     ; 114 }
 147  0003 80            	iret
 170                     ; 121 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 170                     ; 122 {
 171                     	switch	.text
 172  0004               f_EXTI_PORTA_IRQHandler:
 176                     ; 126 }
 179  0004 80            	iret
 202                     ; 133 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 202                     ; 134 {
 203                     	switch	.text
 204  0005               f_EXTI_PORTB_IRQHandler:
 208                     ; 138 }
 211  0005 80            	iret
 234                     ; 145 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 234                     ; 146 {
 235                     	switch	.text
 236  0006               f_EXTI_PORTC_IRQHandler:
 240                     ; 150 }
 243  0006 80            	iret
 266                     ; 157 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 266                     ; 158 {
 267                     	switch	.text
 268  0007               f_EXTI_PORTD_IRQHandler:
 272                     ; 162 }
 275  0007 80            	iret
 298                     ; 169 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 298                     ; 170 {
 299                     	switch	.text
 300  0008               f_EXTI_PORTE_IRQHandler:
 304                     ; 174 }
 307  0008 80            	iret
 329                     ; 196  INTERRUPT_HANDLER(CAN_RX_IRQHandler, 8)
 329                     ; 197  {
 330                     	switch	.text
 331  0009               f_CAN_RX_IRQHandler:
 335                     ; 201  }
 338  0009 80            	iret
 360                     ; 208  INTERRUPT_HANDLER(CAN_TX_IRQHandler, 9)
 360                     ; 209  {
 361                     	switch	.text
 362  000a               f_CAN_TX_IRQHandler:
 366                     ; 213  }
 369  000a 80            	iret
 391                     ; 221 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 391                     ; 222 {
 392                     	switch	.text
 393  000b               f_SPI_IRQHandler:
 397                     ; 226 }
 400  000b 80            	iret
 423                     ; 233 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 423                     ; 234 {
 424                     	switch	.text
 425  000c               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 429                     ; 238 }
 432  000c 80            	iret
 455                     ; 245 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 455                     ; 246 {
 456                     	switch	.text
 457  000d               f_TIM1_CAP_COM_IRQHandler:
 461                     ; 250 }
 464  000d 80            	iret
 487                     ; 283  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 487                     ; 284  {
 488                     	switch	.text
 489  000e               f_TIM2_UPD_OVF_BRK_IRQHandler:
 493                     ; 288  }
 496  000e 80            	iret
 519                     ; 295  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 519                     ; 296  {
 520                     	switch	.text
 521  000f               f_TIM2_CAP_COM_IRQHandler:
 525                     ; 300  }
 528  000f 80            	iret
 551                     ; 310  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 551                     ; 311  {
 552                     	switch	.text
 553  0010               f_TIM3_UPD_OVF_BRK_IRQHandler:
 557                     ; 315  }
 560  0010 80            	iret
 583                     ; 322  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 583                     ; 323  {
 584                     	switch	.text
 585  0011               f_TIM3_CAP_COM_IRQHandler:
 589                     ; 327  }
 592  0011 80            	iret
 615                     ; 337  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 615                     ; 338  {
 616                     	switch	.text
 617  0012               f_UART1_TX_IRQHandler:
 621                     ; 342  }
 624  0012 80            	iret
 647                     ; 349  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 647                     ; 350  {
 648                     	switch	.text
 649  0013               f_UART1_RX_IRQHandler:
 653                     ; 354  }
 656  0013 80            	iret
 678                     ; 388 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 678                     ; 389 {
 679                     	switch	.text
 680  0014               f_I2C_IRQHandler:
 684                     ; 393 }
 687  0014 80            	iret
 710                     ; 427  INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
 710                     ; 428  {
 711                     	switch	.text
 712  0015               f_UART3_TX_IRQHandler:
 716                     ; 432  }
 719  0015 80            	iret
 742                     ; 439  INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
 742                     ; 440  {
 743                     	switch	.text
 744  0016               f_UART3_RX_IRQHandler:
 748                     ; 444  }
 751  0016 80            	iret
 782                     ; 453 @svlreg INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
 782                     ; 454  {
 783                     	switch	.text
 784  0017               f_ADC2_IRQHandler:
 786  0017 8a            	push	cc
 787  0018 84            	pop	a
 788  0019 a4bf          	and	a,#191
 789  001b 88            	push	a
 790  001c 86            	pop	cc
 791  001d 3b0002        	push	c_x+2
 792  0020 be00          	ldw	x,c_x
 793  0022 89            	pushw	x
 794  0023 3b0002        	push	c_y+2
 795  0026 be00          	ldw	x,c_y
 796  0028 89            	pushw	x
 797  0029 be02          	ldw	x,c_lreg+2
 798  002b 89            	pushw	x
 799  002c be00          	ldw	x,c_lreg
 800  002e 89            	pushw	x
 803                     ; 458 	adc_value= ADC2_GetConversionValue();
 805  002f 8d000000      	callf	f_ADC2_GetConversionValue
 807  0033 bf00          	ldw	_adc_value,x
 808                     ; 459 	if (detect_negative_zero_cross(prev_value, adc_value, 600)) {
 810  0035 ae0258        	ldw	x,#600
 811  0038 89            	pushw	x
 812  0039 be00          	ldw	x,_adc_value
 813  003b 89            	pushw	x
 814  003c be00          	ldw	x,_prev_value
 815  003e 8d000000      	callf	f_detect_negative_zero_cross
 817  0042 5b04          	addw	sp,#4
 818  0044 4d            	tnz	a
 819  0045 2731          	jreq	L113
 820                     ; 460 		printf("Zero crossing detected: %u -> %u\n", prev_value, adc_value);
 822  0047 be00          	ldw	x,_adc_value
 823  0049 89            	pushw	x
 824  004a be00          	ldw	x,_prev_value
 825  004c 89            	pushw	x
 826  004d ae0004        	ldw	x,#L313
 827  0050 8d000000      	callf	f_printf
 829  0054 5b04          	addw	sp,#4
 830                     ; 461 		GPIO_WriteHigh(GPIOC, GPIO_PIN_4); // Set square pulse pin high
 832  0056 4b10          	push	#16
 833  0058 ae500a        	ldw	x,#20490
 834  005b 8d000000      	callf	f_GPIO_WriteHigh
 836  005f 84            	pop	a
 837                     ; 462 		delay_ms(5);
 839  0060 ae0005        	ldw	x,#5
 840  0063 8d000000      	callf	f_delay_ms
 842                     ; 463 		printf("Low");
 844  0067 ae0000        	ldw	x,#L513
 845  006a 8d000000      	callf	f_printf
 847                     ; 464 	  GPIO_WriteLow(GPIOC, GPIO_PIN_4); // Set square pulse pin low
 849  006e 4b10          	push	#16
 850  0070 ae500a        	ldw	x,#20490
 851  0073 8d000000      	callf	f_GPIO_WriteLow
 853  0077 84            	pop	a
 854  0078               L113:
 855                     ; 466 	prev_value = adc_value;
 857  0078 be00          	ldw	x,_adc_value
 858  007a bf00          	ldw	_prev_value,x
 859                     ; 467 	ADC2_ClearITPendingBit();
 861  007c 8d000000      	callf	f_ADC2_ClearITPendingBit
 863                     ; 468  }
 866  0080 85            	popw	x
 867  0081 bf00          	ldw	c_lreg,x
 868  0083 85            	popw	x
 869  0084 bf02          	ldw	c_lreg+2,x
 870  0086 85            	popw	x
 871  0087 bf00          	ldw	c_y,x
 872  0089 320002        	pop	c_y+2
 873  008c 85            	popw	x
 874  008d bf00          	ldw	c_x,x
 875  008f 320002        	pop	c_x+2
 876  0092 80            	iret
 899                     ; 503  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 899                     ; 504  {
 900                     	switch	.text
 901  0093               f_TIM4_UPD_OVF_IRQHandler:
 905                     ; 508  }
 908  0093 80            	iret
 931                     ; 516 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 931                     ; 517 {
 932                     	switch	.text
 933  0094               f_EEPROM_EEC_IRQHandler:
 937                     ; 521 }
 940  0094 80            	iret
 963                     	xdef	_i
 964                     	xref.b	_prev_value
 965                     	xref.b	_adc_value
 966                     	xdef	f_EEPROM_EEC_IRQHandler
 967                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 968                     	xdef	f_ADC2_IRQHandler
 969                     	xdef	f_UART3_TX_IRQHandler
 970                     	xdef	f_UART3_RX_IRQHandler
 971                     	xdef	f_I2C_IRQHandler
 972                     	xdef	f_UART1_RX_IRQHandler
 973                     	xdef	f_UART1_TX_IRQHandler
 974                     	xdef	f_TIM3_CAP_COM_IRQHandler
 975                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
 976                     	xdef	f_TIM2_CAP_COM_IRQHandler
 977                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 978                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 979                     	xdef	f_TIM1_CAP_COM_IRQHandler
 980                     	xdef	f_SPI_IRQHandler
 981                     	xdef	f_CAN_TX_IRQHandler
 982                     	xdef	f_CAN_RX_IRQHandler
 983                     	xdef	f_EXTI_PORTE_IRQHandler
 984                     	xdef	f_EXTI_PORTD_IRQHandler
 985                     	xdef	f_EXTI_PORTC_IRQHandler
 986                     	xdef	f_EXTI_PORTB_IRQHandler
 987                     	xdef	f_EXTI_PORTA_IRQHandler
 988                     	xdef	f_CLK_IRQHandler
 989                     	xdef	f_AWU_IRQHandler
 990                     	xdef	f_TLI_IRQHandler
 991                     	xdef	f_TRAP_IRQHandler
 992                     	xref	f_detect_negative_zero_cross
 993                     	xref	f_delay_ms
 994                     	xref	f_printf
 995                     	xref	f_GPIO_WriteLow
 996                     	xref	f_GPIO_WriteHigh
 997                     	xref	f_ADC2_ClearITPendingBit
 998                     	xref	f_ADC2_GetConversionValue
 999                     .const:	section	.text
1000  0000               L513:
1001  0000 4c6f7700      	dc.b	"Low",0
1002  0004               L313:
1003  0004 5a65726f2063  	dc.b	"Zero crossing dete"
1004  0016 637465643a20  	dc.b	"cted: %u -> %u",10,0
1005                     	xref.b	c_lreg
1006                     	xref.b	c_x
1007                     	xref.b	c_y
1027                     	end
