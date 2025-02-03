   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  17                     	bsct
  18  0000               _state:
  19  0000 00            	dc.b	0
  20  0001               _overflow_count:
  21  0001 0000          	dc.w	0
  22  0003               _pulse_ticks:
  23  0003 00000000      	dc.l	0
  24  0007               _start_time:
  25  0007 00000000      	dc.l	0
  26  000b               _end_time:
  27  000b 00000000      	dc.l	0
  28  000f               _last_cross_time:
  29  000f 00000000      	dc.l	0
  30  0013               _set_frequency:
  31  0013 00000000      	dc.w	0,0
  32  0017               _frequency:
  33  0017 00000000      	dc.w	0,0
  87                     ; 28 void main()
  87                     ; 29 {
  88                     	switch	.text
  89  0000               f_main:
  91  0000 5204          	subw	sp,#4
  92       00000004      OFST:	set	4
  95                     ; 30 	unsigned long time_period = 0;
  97                     ; 32 	clock_setup();
  99  0002 8d7b007b      	callf	f_clock_setup
 101                     ; 33 	GPIO_setup();
 103  0006 8dec00ec      	callf	f_GPIO_setup
 105                     ; 34 	TIM1_setup();
 107  000a 8d2b012b      	callf	f_TIM1_setup
 109                     ; 35 	TIM2_setup();
 111  000e 8d630163      	callf	f_TIM2_setup
 113                     ; 36 	UART3_setup();
 115  0012 8d8e018e      	callf	f_UART3_setup
 117                     ; 37 	TIM4_Config();
 119  0016 8d000000      	callf	f_TIM4_Config
 121                     ; 38 	set_frequency = 50.0;
 123  001a ce0038        	ldw	x,L33+2
 124  001d bf15          	ldw	_set_frequency+2,x
 125  001f ce0036        	ldw	x,L33
 126  0022 bf13          	ldw	_set_frequency,x
 127  0024               L73:
 128                     ; 40 		time_period = pulse_ticks;
 130  0024 be05          	ldw	x,_pulse_ticks+2
 131  0026 1f03          	ldw	(OFST-1,sp),x
 132  0028 be03          	ldw	x,_pulse_ticks
 133  002a 1f01          	ldw	(OFST-3,sp),x
 135                     ; 42 		printf("Time Period: %lu, Frequency: %.3f, Pulse_ticks: %lu\n\r", time_period, frequency, pulse_ticks); 
 137  002c be05          	ldw	x,_pulse_ticks+2
 138  002e 89            	pushw	x
 139  002f be03          	ldw	x,_pulse_ticks
 140  0031 89            	pushw	x
 141  0032 be19          	ldw	x,_frequency+2
 142  0034 89            	pushw	x
 143  0035 be17          	ldw	x,_frequency
 144  0037 89            	pushw	x
 145  0038 1e0b          	ldw	x,(OFST+7,sp)
 146  003a 89            	pushw	x
 147  003b 1e0b          	ldw	x,(OFST+7,sp)
 148  003d 89            	pushw	x
 149  003e ae0000        	ldw	x,#L34
 150  0041 8d000000      	callf	f_printf
 152  0045 5b0c          	addw	sp,#12
 153                     ; 43 		if (frequency <= set_frequency && state == 1)
 155  0047 ae0017        	ldw	x,#_frequency
 156  004a 8d000000      	callf	d_ltor
 158  004e ae0013        	ldw	x,#_set_frequency
 159  0051 8d000000      	callf	d_fcmp
 161  0055 2ccd          	jrsgt	L73
 163  0057 b600          	ld	a,_state
 164  0059 4a            	dec	a
 165  005a 26c8          	jrne	L73
 166                     ; 45 			GPIO_WriteLow(GPIOC, GPIO_PIN_2); // Send pulse
 168  005c 4b04          	push	#4
 169  005e ae500a        	ldw	x,#20490
 170  0061 8d000000      	callf	f_GPIO_WriteLow
 172  0065 ae0005        	ldw	x,#5
 173  0068 84            	pop	a
 174                     ; 46 	    delay_ms(5);
 176  0069 8d000000      	callf	f_delay_ms
 178                     ; 47 			GPIO_WriteHigh(GPIOC, GPIO_PIN_2);
 180  006d 4b04          	push	#4
 181  006f ae500a        	ldw	x,#20490
 182  0072 8d000000      	callf	f_GPIO_WriteHigh
 184  0076 3f00          	clr	_state
 185  0078 84            	pop	a
 186                     ; 48 			state = 0;
 188  0079 20a9          	jra	L73
 220                     ; 54 void clock_setup(void)
 220                     ; 55 {
 221                     	switch	.text
 222  007b               f_clock_setup:
 226                     ; 56     CLK_DeInit();
 228  007b 8d000000      	callf	f_CLK_DeInit
 230                     ; 58     CLK_HSECmd(DISABLE);
 232  007f 4f            	clr	a
 233  0080 8d000000      	callf	f_CLK_HSECmd
 235                     ; 59     CLK_LSICmd(DISABLE);
 237  0084 4f            	clr	a
 238  0085 8d000000      	callf	f_CLK_LSICmd
 240                     ; 60     CLK_HSICmd(ENABLE);
 242  0089 a601          	ld	a,#1
 243  008b 8d000000      	callf	f_CLK_HSICmd
 246  008f               L16:
 247                     ; 61     while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 249  008f ae0102        	ldw	x,#258
 250  0092 8d000000      	callf	f_CLK_GetFlagStatus
 252  0096 4d            	tnz	a
 253  0097 27f6          	jreq	L16
 254                     ; 63     CLK_ClockSwitchCmd(ENABLE);
 256  0099 a601          	ld	a,#1
 257  009b 8d000000      	callf	f_CLK_ClockSwitchCmd
 259                     ; 66 		CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 261  009f 4f            	clr	a
 262  00a0 8d000000      	callf	f_CLK_HSIPrescalerConfig
 264                     ; 67     CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 266  00a4 a680          	ld	a,#128
 267  00a6 8d000000      	callf	f_CLK_SYSCLKConfig
 269                     ; 68     CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 269                     ; 69     DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 271  00aa 4b01          	push	#1
 272  00ac 4b00          	push	#0
 273  00ae ae01e1        	ldw	x,#481
 274  00b1 8d000000      	callf	f_CLK_ClockSwitchConfig
 276  00b5 85            	popw	x
 277                     ; 71     CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 279  00b6 ae0100        	ldw	x,#256
 280  00b9 8d000000      	callf	f_CLK_PeripheralClockConfig
 282                     ; 72     CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 284  00bd 5f            	clrw	x
 285  00be 8d000000      	callf	f_CLK_PeripheralClockConfig
 287                     ; 73     CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 289  00c2 ae1300        	ldw	x,#4864
 290  00c5 8d000000      	callf	f_CLK_PeripheralClockConfig
 292                     ; 74     CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 294  00c9 ae1200        	ldw	x,#4608
 295  00cc 8d000000      	callf	f_CLK_PeripheralClockConfig
 297                     ; 75     CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 299  00d0 ae0301        	ldw	x,#769
 300  00d3 8d000000      	callf	f_CLK_PeripheralClockConfig
 302                     ; 76     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
 304  00d7 ae0701        	ldw	x,#1793
 305  00da 8d000000      	callf	f_CLK_PeripheralClockConfig
 307                     ; 77     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 309  00de ae0501        	ldw	x,#1281
 310  00e1 8d000000      	callf	f_CLK_PeripheralClockConfig
 312                     ; 78     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 314  00e5 ae0400        	ldw	x,#1024
 316                     ; 79 }
 319  00e8 ac000000      	jpf	f_CLK_PeripheralClockConfig
 343                     ; 81 void GPIO_setup(void)
 343                     ; 82 {               
 344                     	switch	.text
 345  00ec               f_GPIO_setup:
 349                     ; 83      GPIO_DeInit(GPIOC);
 351  00ec ae500a        	ldw	x,#20490
 352  00ef 8d000000      	callf	f_GPIO_DeInit
 354                     ; 84      GPIO_Init(GPIOC, GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);
 356  00f3 4b00          	push	#0
 357  00f5 4b02          	push	#2
 358  00f7 ae500a        	ldw	x,#20490
 359  00fa 8d000000      	callf	f_GPIO_Init
 361  00fe 85            	popw	x
 362                     ; 85 		 GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
 364  00ff 4be0          	push	#224
 365  0101 4b10          	push	#16
 366  0103 ae500a        	ldw	x,#20490
 367  0106 8d000000      	callf	f_GPIO_Init
 369  010a 85            	popw	x
 370                     ; 86 		 GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);
 372  010b 4be0          	push	#224
 373  010d 4b04          	push	#4
 374  010f ae500a        	ldw	x,#20490
 375  0112 8d000000      	callf	f_GPIO_Init
 377  0116 85            	popw	x
 378                     ; 87      GPIO_DeInit(GPIOD);
 380  0117 ae500f        	ldw	x,#20495
 381  011a 8d000000      	callf	f_GPIO_DeInit
 383                     ; 88      GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST);
 385  011e 4bf0          	push	#240
 386  0120 4b10          	push	#16
 387  0122 ae500f        	ldw	x,#20495
 388  0125 8d000000      	callf	f_GPIO_Init
 390  0129 85            	popw	x
 391                     ; 89 }
 394  012a 87            	retf	
 422                     ; 91 void TIM1_setup(void)
 422                     ; 92 {
 423                     	switch	.text
 424  012b               f_TIM1_setup:
 428                     ; 93      TIM1_DeInit();
 430  012b 8d000000      	callf	f_TIM1_DeInit
 432                     ; 95 		 TIM1_TimeBaseInit(16000, TIM1_COUNTERMODE_UP, 999, 1);
 434  012f 4b01          	push	#1
 435  0131 ae03e7        	ldw	x,#999
 436  0134 89            	pushw	x
 437  0135 4b00          	push	#0
 438  0137 ae3e80        	ldw	x,#16000
 439  013a 8d000000      	callf	f_TIM1_TimeBaseInit
 441  013e 5b04          	addw	sp,#4
 442                     ; 96      TIM1_ICInit(TIM1_CHANNEL_1, TIM1_ICPOLARITY_RISING, 
 442                     ; 97                  TIM1_ICSELECTION_DIRECTTI, 1, 1);
 444  0140 4b01          	push	#1
 445  0142 4b01          	push	#1
 446  0144 4b01          	push	#1
 447  0146 5f            	clrw	x
 448  0147 8d000000      	callf	f_TIM1_ICInit
 450  014b 5b03          	addw	sp,#3
 451                     ; 98      TIM1_ITConfig(TIM1_IT_UPDATE, ENABLE);
 453  014d ae0101        	ldw	x,#257
 454  0150 8d000000      	callf	f_TIM1_ITConfig
 456                     ; 99      TIM1_ITConfig(TIM1_IT_CC1, ENABLE);
 458  0154 ae0201        	ldw	x,#513
 459  0157 8d000000      	callf	f_TIM1_ITConfig
 461                     ; 100      TIM1_Cmd(ENABLE);
 463  015b a601          	ld	a,#1
 464  015d 8d000000      	callf	f_TIM1_Cmd
 466                     ; 102      enableInterrupts();
 469  0161 9a            	rim	
 471                     ; 103 }
 475  0162 87            	retf	
 502                     ; 105 void TIM2_setup(void)
 502                     ; 106 {
 503                     	switch	.text
 504  0163               f_TIM2_setup:
 508                     ; 107      TIM2_DeInit();
 510  0163 8d000000      	callf	f_TIM2_DeInit
 512                     ; 108      TIM2_TimeBaseInit(TIM2_PRESCALER_32, 1250);
 514  0167 ae04e2        	ldw	x,#1250
 515  016a 89            	pushw	x
 516  016b a605          	ld	a,#5
 517  016d 8d000000      	callf	f_TIM2_TimeBaseInit
 519  0171 85            	popw	x
 520                     ; 109      TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000, 
 520                     ; 110                   TIM2_OCPOLARITY_LOW);
 522  0172 4b22          	push	#34
 523  0174 ae03e8        	ldw	x,#1000
 524  0177 89            	pushw	x
 525  0178 ae6011        	ldw	x,#24593
 526  017b 8d000000      	callf	f_TIM2_OC1Init
 528  017f 5b03          	addw	sp,#3
 529                     ; 111      TIM2_SetCompare1(625);
 531  0181 ae0271        	ldw	x,#625
 532  0184 8d000000      	callf	f_TIM2_SetCompare1
 534                     ; 112      TIM2_Cmd(ENABLE);
 536  0188 a601          	ld	a,#1
 538                     ; 113 } 
 541  018a ac000000      	jpf	f_TIM2_Cmd
 566                     ; 115 void UART3_setup(void) {
 567                     	switch	.text
 568  018e               f_UART3_setup:
 572                     ; 116 	UART3_DeInit();
 574  018e 8d000000      	callf	f_UART3_DeInit
 576                     ; 117 	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TXRX_ENABLE);
 578  0192 4b0c          	push	#12
 579  0194 4b00          	push	#0
 580  0196 4b00          	push	#0
 581  0198 4b00          	push	#0
 582  019a ae2580        	ldw	x,#9600
 583  019d 89            	pushw	x
 584  019e 5f            	clrw	x
 585  019f 89            	pushw	x
 586  01a0 8d000000      	callf	f_UART3_Init
 588  01a4 5b08          	addw	sp,#8
 589                     ; 118 	UART3_Cmd(ENABLE);
 591  01a6 a601          	ld	a,#1
 593                     ; 119 }
 596  01a8 ac000000      	jpf	f_UART3_Cmd
 631                     ; 122 PUTCHAR_PROTOTYPE {
 632                     	switch	.text
 633  01ac               f_putchar:
 635  01ac 88            	push	a
 636       00000000      OFST:	set	0
 639                     ; 123 	UART3_SendData8(c);
 641  01ad 8d000000      	callf	f_UART3_SendData8
 644  01b1               L541:
 645                     ; 124 	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
 647  01b1 ae0080        	ldw	x,#128
 648  01b4 8d000000      	callf	f_UART3_GetFlagStatus
 650  01b8 4d            	tnz	a
 651  01b9 27f6          	jreq	L541
 652                     ; 125 	return c;
 654  01bb 7b01          	ld	a,(OFST+1,sp)
 657  01bd 5b01          	addw	sp,#1
 658  01bf 87            	retf	
 765                     	xdef	f_main
 766                     	xdef	f_TIM2_setup
 767                     	xdef	f_UART3_setup
 768                     	xdef	f_TIM1_setup
 769                     	xdef	f_GPIO_setup
 770                     	xdef	f_clock_setup
 771                     	xdef	_frequency
 772                     	xdef	_set_frequency
 773                     	xdef	_last_cross_time
 774                     	xdef	_end_time
 775                     	xdef	_start_time
 776                     	xdef	_pulse_ticks
 777                     	xdef	_overflow_count
 778                     	xdef	_state
 779                     	xdef	f_putchar
 780                     	xref	f_printf
 781                     	xref	f_delay_ms
 782                     	xref	f_TIM4_Config
 783                     	xref	f_UART3_GetFlagStatus
 784                     	xref	f_UART3_SendData8
 785                     	xref	f_UART3_Cmd
 786                     	xref	f_UART3_Init
 787                     	xref	f_UART3_DeInit
 788                     	xref	f_TIM2_SetCompare1
 789                     	xref	f_TIM2_Cmd
 790                     	xref	f_TIM2_OC1Init
 791                     	xref	f_TIM2_TimeBaseInit
 792                     	xref	f_TIM2_DeInit
 793                     	xref	f_TIM1_ITConfig
 794                     	xref	f_TIM1_Cmd
 795                     	xref	f_TIM1_ICInit
 796                     	xref	f_TIM1_TimeBaseInit
 797                     	xref	f_TIM1_DeInit
 798                     	xref	f_GPIO_WriteLow
 799                     	xref	f_GPIO_WriteHigh
 800                     	xref	f_GPIO_Init
 801                     	xref	f_GPIO_DeInit
 802                     	xref	f_CLK_GetFlagStatus
 803                     	xref	f_CLK_SYSCLKConfig
 804                     	xref	f_CLK_HSIPrescalerConfig
 805                     	xref	f_CLK_ClockSwitchConfig
 806                     	xref	f_CLK_PeripheralClockConfig
 807                     	xref	f_CLK_ClockSwitchCmd
 808                     	xref	f_CLK_LSICmd
 809                     	xref	f_CLK_HSICmd
 810                     	xref	f_CLK_HSECmd
 811                     	xref	f_CLK_DeInit
 812                     .const:	section	.text
 813  0000               L34:
 814  0000 54696d652050  	dc.b	"Time Period: %lu, "
 815  0012 467265717565  	dc.b	"Frequency: %.3f, P"
 816  0024 756c73655f74  	dc.b	"ulse_ticks: %lu",10
 817  0034 0d00          	dc.b	13,0
 818  0036               L33:
 819  0036 42480000      	dc.w	16968,0
 820                     	xref.b	c_x
 840                     	xref	d_fcmp
 841                     	xref	d_ltor
 842                     	end
