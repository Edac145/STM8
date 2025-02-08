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
  23  0003 0000          	dc.w	0
  24  0005               _start_time:
  25  0005 00000000      	dc.l	0
  26  0009               _end_time:
  27  0009 00000000      	dc.l	0
  28  000d               _last_cross_time:
  29  000d 00000000      	dc.l	0
  30  0011               _set_frequency:
  31  0011 00000000      	dc.w	0,0
  32  0015               _frequency:
  33  0015 00000000      	dc.w	0,0
  83                     ; 28 void main()
  83                     ; 29 {
  84                     	switch	.text
  85  0000               f_main:
  87  0000 89            	pushw	x
  88       00000002      OFST:	set	2
  91                     ; 30 	uint16_t time_period = 0;
  93                     ; 32 	clock_setup();
  95  0001 8d3f003f      	callf	f_clock_setup
  97                     ; 33 	GPIO_setup();
  99  0005 8db000b0      	callf	f_GPIO_setup
 101                     ; 34 	TIM1_setup();
 103  0009 8def00ef      	callf	f_TIM1_setup
 105                     ; 35 	TIM2_setup();
 107  000d 8d270127      	callf	f_TIM2_setup
 109                     ; 36 	UART3_setup();
 111  0011 8d520152      	callf	f_UART3_setup
 113                     ; 37 	TIM4_Config();
 115  0015 8d000000      	callf	f_TIM4_Config
 117                     ; 38 	set_frequency = 52;
 119  0019 a634          	ld	a,#52
 120  001b 8d000000      	callf	d_ctof
 122  001f ae0011        	ldw	x,#_set_frequency
 123  0022 8d000000      	callf	d_rtol
 125  0026               L72:
 126                     ; 40 		time_period = pulse_ticks;
 128  0026 be03          	ldw	x,_pulse_ticks
 129  0028 1f01          	ldw	(OFST-1,sp),x
 131                     ; 42 		printf("Time Period: %u, Frequency: %.3f, Pulse_ticks: %u\n\r", time_period, frequency, pulse_ticks); 
 133  002a 89            	pushw	x
 134  002b be17          	ldw	x,_frequency+2
 135  002d 89            	pushw	x
 136  002e be15          	ldw	x,_frequency
 137  0030 89            	pushw	x
 138  0031 1e07          	ldw	x,(OFST+5,sp)
 139  0033 89            	pushw	x
 140  0034 ae0000        	ldw	x,#L33
 141  0037 8d000000      	callf	f_printf
 143  003b 5b08          	addw	sp,#8
 145  003d 20e7          	jra	L72
 177                     ; 54 void clock_setup(void)
 177                     ; 55 {
 178                     	switch	.text
 179  003f               f_clock_setup:
 183                     ; 56     CLK_DeInit();
 185  003f 8d000000      	callf	f_CLK_DeInit
 187                     ; 58     CLK_HSECmd(DISABLE);
 189  0043 4f            	clr	a
 190  0044 8d000000      	callf	f_CLK_HSECmd
 192                     ; 59     CLK_LSICmd(DISABLE);
 194  0048 4f            	clr	a
 195  0049 8d000000      	callf	f_CLK_LSICmd
 197                     ; 60     CLK_HSICmd(ENABLE);
 199  004d a601          	ld	a,#1
 200  004f 8d000000      	callf	f_CLK_HSICmd
 203  0053               L74:
 204                     ; 61     while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 206  0053 ae0102        	ldw	x,#258
 207  0056 8d000000      	callf	f_CLK_GetFlagStatus
 209  005a 4d            	tnz	a
 210  005b 27f6          	jreq	L74
 211                     ; 63     CLK_ClockSwitchCmd(ENABLE);
 213  005d a601          	ld	a,#1
 214  005f 8d000000      	callf	f_CLK_ClockSwitchCmd
 216                     ; 66 		CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 218  0063 4f            	clr	a
 219  0064 8d000000      	callf	f_CLK_HSIPrescalerConfig
 221                     ; 67     CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 223  0068 a680          	ld	a,#128
 224  006a 8d000000      	callf	f_CLK_SYSCLKConfig
 226                     ; 68     CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 226                     ; 69     DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 228  006e 4b01          	push	#1
 229  0070 4b00          	push	#0
 230  0072 ae01e1        	ldw	x,#481
 231  0075 8d000000      	callf	f_CLK_ClockSwitchConfig
 233  0079 85            	popw	x
 234                     ; 71     CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 236  007a ae0100        	ldw	x,#256
 237  007d 8d000000      	callf	f_CLK_PeripheralClockConfig
 239                     ; 72     CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 241  0081 5f            	clrw	x
 242  0082 8d000000      	callf	f_CLK_PeripheralClockConfig
 244                     ; 73     CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 246  0086 ae1300        	ldw	x,#4864
 247  0089 8d000000      	callf	f_CLK_PeripheralClockConfig
 249                     ; 74     CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 251  008d ae1200        	ldw	x,#4608
 252  0090 8d000000      	callf	f_CLK_PeripheralClockConfig
 254                     ; 75     CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 256  0094 ae0301        	ldw	x,#769
 257  0097 8d000000      	callf	f_CLK_PeripheralClockConfig
 259                     ; 76     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
 261  009b ae0701        	ldw	x,#1793
 262  009e 8d000000      	callf	f_CLK_PeripheralClockConfig
 264                     ; 77     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 266  00a2 ae0501        	ldw	x,#1281
 267  00a5 8d000000      	callf	f_CLK_PeripheralClockConfig
 269                     ; 78     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 271  00a9 ae0400        	ldw	x,#1024
 273                     ; 79 }
 276  00ac ac000000      	jpf	f_CLK_PeripheralClockConfig
 300                     ; 81 void GPIO_setup(void)
 300                     ; 82 {               
 301                     	switch	.text
 302  00b0               f_GPIO_setup:
 306                     ; 83      GPIO_DeInit(GPIOC);
 308  00b0 ae500a        	ldw	x,#20490
 309  00b3 8d000000      	callf	f_GPIO_DeInit
 311                     ; 84      GPIO_Init(GPIOC, GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);
 313  00b7 4b00          	push	#0
 314  00b9 4b02          	push	#2
 315  00bb ae500a        	ldw	x,#20490
 316  00be 8d000000      	callf	f_GPIO_Init
 318  00c2 85            	popw	x
 319                     ; 85 		 GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
 321  00c3 4be0          	push	#224
 322  00c5 4b10          	push	#16
 323  00c7 ae500a        	ldw	x,#20490
 324  00ca 8d000000      	callf	f_GPIO_Init
 326  00ce 85            	popw	x
 327                     ; 86 		 GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);
 329  00cf 4be0          	push	#224
 330  00d1 4b04          	push	#4
 331  00d3 ae500a        	ldw	x,#20490
 332  00d6 8d000000      	callf	f_GPIO_Init
 334  00da 85            	popw	x
 335                     ; 87      GPIO_DeInit(GPIOD);
 337  00db ae500f        	ldw	x,#20495
 338  00de 8d000000      	callf	f_GPIO_DeInit
 340                     ; 88      GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST);
 342  00e2 4bf0          	push	#240
 343  00e4 4b10          	push	#16
 344  00e6 ae500f        	ldw	x,#20495
 345  00e9 8d000000      	callf	f_GPIO_Init
 347  00ed 85            	popw	x
 348                     ; 89 }
 351  00ee 87            	retf	
 379                     ; 91 void TIM1_setup(void)
 379                     ; 92 {
 380                     	switch	.text
 381  00ef               f_TIM1_setup:
 385                     ; 93      TIM1_DeInit();
 387  00ef 8d000000      	callf	f_TIM1_DeInit
 389                     ; 96 		 TIM1_TimeBaseInit(1600, TIM1_COUNTERMODE_UP, 65535, 1);
 391  00f3 4b01          	push	#1
 392  00f5 aeffff        	ldw	x,#65535
 393  00f8 89            	pushw	x
 394  00f9 4b00          	push	#0
 395  00fb ae0640        	ldw	x,#1600
 396  00fe 8d000000      	callf	f_TIM1_TimeBaseInit
 398  0102 5b04          	addw	sp,#4
 399                     ; 97      TIM1_ICInit(TIM1_CHANNEL_1, TIM1_ICPOLARITY_RISING, 
 399                     ; 98                  TIM1_ICSELECTION_DIRECTTI, 1, 1);
 401  0104 4b01          	push	#1
 402  0106 4b01          	push	#1
 403  0108 4b01          	push	#1
 404  010a 5f            	clrw	x
 405  010b 8d000000      	callf	f_TIM1_ICInit
 407  010f 5b03          	addw	sp,#3
 408                     ; 99      TIM1_ITConfig(TIM1_IT_UPDATE, ENABLE);
 410  0111 ae0101        	ldw	x,#257
 411  0114 8d000000      	callf	f_TIM1_ITConfig
 413                     ; 100      TIM1_ITConfig(TIM1_IT_CC1, ENABLE);
 415  0118 ae0201        	ldw	x,#513
 416  011b 8d000000      	callf	f_TIM1_ITConfig
 418                     ; 101      TIM1_Cmd(ENABLE);
 420  011f a601          	ld	a,#1
 421  0121 8d000000      	callf	f_TIM1_Cmd
 423                     ; 103      enableInterrupts();
 426  0125 9a            	rim	
 428                     ; 104 }
 432  0126 87            	retf	
 459                     ; 106 void TIM2_setup(void)
 459                     ; 107 {
 460                     	switch	.text
 461  0127               f_TIM2_setup:
 465                     ; 108      TIM2_DeInit();
 467  0127 8d000000      	callf	f_TIM2_DeInit
 469                     ; 109      TIM2_TimeBaseInit(TIM2_PRESCALER_32, 1250);
 471  012b ae04e2        	ldw	x,#1250
 472  012e 89            	pushw	x
 473  012f a605          	ld	a,#5
 474  0131 8d000000      	callf	f_TIM2_TimeBaseInit
 476  0135 85            	popw	x
 477                     ; 110      TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000, 
 477                     ; 111                   TIM2_OCPOLARITY_LOW);
 479  0136 4b22          	push	#34
 480  0138 ae03e8        	ldw	x,#1000
 481  013b 89            	pushw	x
 482  013c ae6011        	ldw	x,#24593
 483  013f 8d000000      	callf	f_TIM2_OC1Init
 485  0143 5b03          	addw	sp,#3
 486                     ; 112      TIM2_SetCompare1(625);
 488  0145 ae0271        	ldw	x,#625
 489  0148 8d000000      	callf	f_TIM2_SetCompare1
 491                     ; 113      TIM2_Cmd(ENABLE);
 493  014c a601          	ld	a,#1
 495                     ; 114 } 
 498  014e ac000000      	jpf	f_TIM2_Cmd
 523                     ; 116 void UART3_setup(void) {
 524                     	switch	.text
 525  0152               f_UART3_setup:
 529                     ; 117 	UART3_DeInit();
 531  0152 8d000000      	callf	f_UART3_DeInit
 533                     ; 118 	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TXRX_ENABLE);
 535  0156 4b0c          	push	#12
 536  0158 4b00          	push	#0
 537  015a 4b00          	push	#0
 538  015c 4b00          	push	#0
 539  015e ae2580        	ldw	x,#9600
 540  0161 89            	pushw	x
 541  0162 5f            	clrw	x
 542  0163 89            	pushw	x
 543  0164 8d000000      	callf	f_UART3_Init
 545  0168 5b08          	addw	sp,#8
 546                     ; 119 	UART3_Cmd(ENABLE);
 548  016a a601          	ld	a,#1
 550                     ; 120 }
 553  016c ac000000      	jpf	f_UART3_Cmd
 588                     ; 123 PUTCHAR_PROTOTYPE {
 589                     	switch	.text
 590  0170               f_putchar:
 592  0170 88            	push	a
 593       00000000      OFST:	set	0
 596                     ; 124 	UART3_SendData8(c);
 598  0171 8d000000      	callf	f_UART3_SendData8
 601  0175               L331:
 602                     ; 125 	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
 604  0175 ae0080        	ldw	x,#128
 605  0178 8d000000      	callf	f_UART3_GetFlagStatus
 607  017c 4d            	tnz	a
 608  017d 27f6          	jreq	L331
 609                     ; 126 	return c;
 611  017f 7b01          	ld	a,(OFST+1,sp)
 614  0181 5b01          	addw	sp,#1
 615  0183 87            	retf	
 722                     	xdef	f_main
 723                     	xdef	f_TIM2_setup
 724                     	xdef	f_UART3_setup
 725                     	xdef	f_TIM1_setup
 726                     	xdef	f_GPIO_setup
 727                     	xdef	f_clock_setup
 728                     	xdef	_frequency
 729                     	xdef	_set_frequency
 730                     	xdef	_last_cross_time
 731                     	xdef	_end_time
 732                     	xdef	_start_time
 733                     	xdef	_pulse_ticks
 734                     	xdef	_overflow_count
 735                     	xdef	_state
 736                     	xdef	f_putchar
 737                     	xref	f_printf
 738                     	xref	f_TIM4_Config
 739                     	xref	f_UART3_GetFlagStatus
 740                     	xref	f_UART3_SendData8
 741                     	xref	f_UART3_Cmd
 742                     	xref	f_UART3_Init
 743                     	xref	f_UART3_DeInit
 744                     	xref	f_TIM2_SetCompare1
 745                     	xref	f_TIM2_Cmd
 746                     	xref	f_TIM2_OC1Init
 747                     	xref	f_TIM2_TimeBaseInit
 748                     	xref	f_TIM2_DeInit
 749                     	xref	f_TIM1_ITConfig
 750                     	xref	f_TIM1_Cmd
 751                     	xref	f_TIM1_ICInit
 752                     	xref	f_TIM1_TimeBaseInit
 753                     	xref	f_TIM1_DeInit
 754                     	xref	f_GPIO_Init
 755                     	xref	f_GPIO_DeInit
 756                     	xref	f_CLK_GetFlagStatus
 757                     	xref	f_CLK_SYSCLKConfig
 758                     	xref	f_CLK_HSIPrescalerConfig
 759                     	xref	f_CLK_ClockSwitchConfig
 760                     	xref	f_CLK_PeripheralClockConfig
 761                     	xref	f_CLK_ClockSwitchCmd
 762                     	xref	f_CLK_LSICmd
 763                     	xref	f_CLK_HSICmd
 764                     	xref	f_CLK_HSECmd
 765                     	xref	f_CLK_DeInit
 766                     .const:	section	.text
 767  0000               L33:
 768  0000 54696d652050  	dc.b	"Time Period: %u, F"
 769  0012 72657175656e  	dc.b	"requency: %.3f, Pu"
 770  0024 6c73655f7469  	dc.b	"lse_ticks: %u",10
 771  0032 0d00          	dc.b	13,0
 791                     	xref	d_rtol
 792                     	xref	d_ctof
 793                     	end
