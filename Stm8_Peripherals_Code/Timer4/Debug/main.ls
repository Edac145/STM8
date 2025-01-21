   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _millis_count:
  16  0000 00000000      	dc.l	0
  17  0004               _micros_offset:
  18  0004 0000          	dc.w	0
  19  0006               _tick:
  20  0006 00000000      	dc.l	0
  90                     ; 32 void main() {
  92                     	switch	.text
  93  0000               _main:
  95  0000 520c          	subw	sp,#12
  96       0000000c      OFST:	set	12
  99                     ; 33   clock_setup();
 101  0002 cd0089        	call	_clock_setup
 103                     ; 34   TIM4_Config();
 105  0005 cd00c8        	call	_TIM4_Config
 107                     ; 35   UART3_setup();
 109  0008 cd01b8        	call	_UART3_setup
 111                     ; 36   GPIO_DeInit(GPIOC);
 113  000b ae500a        	ldw	x,#20490
 114  000e cd0000        	call	_GPIO_DeInit
 116                     ; 37   GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 118  0011 4be0          	push	#224
 119  0013 4b08          	push	#8
 120  0015 ae500a        	ldw	x,#20490
 121  0018 cd0000        	call	_GPIO_Init
 123  001b 85            	popw	x
 124                     ; 39   enableInterrupts();  // Enable global interrupts
 127  001c 9a            rim
 129  001d               L34:
 130                     ; 47       start_time = millis();
 132  001d cd0132        	call	_millis
 134  0020 cd0000        	call	c_uitolx
 136  0023 96            	ldw	x,sp
 137  0024 1c0009        	addw	x,#OFST-3
 138  0027 cd0000        	call	c_rtol
 141                     ; 49       GPIO_WriteLow(GPIOC, GPIO_PIN_3);
 143  002a 4b08          	push	#8
 144  002c ae500a        	ldw	x,#20490
 145  002f cd0000        	call	_GPIO_WriteLow
 147  0032 84            	pop	a
 148                     ; 50       delay_ms(1000);  // LED OFF for 100ms
 150  0033 ae03e8        	ldw	x,#1000
 151  0036 cd00e9        	call	_delay_ms
 153                     ; 51       GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
 155  0039 4b08          	push	#8
 156  003b ae500a        	ldw	x,#20490
 157  003e cd0000        	call	_GPIO_WriteHigh
 159  0041 84            	pop	a
 160                     ; 52       delay_ms(1000);  // LED ON for 100ms
 162  0042 ae03e8        	ldw	x,#1000
 163  0045 cd00e9        	call	_delay_ms
 165                     ; 53       currentTime = millis();
 167  0048 cd0132        	call	_millis
 169  004b cd0000        	call	c_uitolx
 171  004e 96            	ldw	x,sp
 172  004f 1c0005        	addw	x,#OFST-7
 173  0052 cd0000        	call	c_rtol
 176                     ; 54       LoopTime = elapsedTime(start_time, currentTime);
 178  0055 1e07          	ldw	x,(OFST-5,sp)
 179  0057 89            	pushw	x
 180  0058 1e07          	ldw	x,(OFST-5,sp)
 181  005a 89            	pushw	x
 182  005b 1e0f          	ldw	x,(OFST+3,sp)
 183  005d 89            	pushw	x
 184  005e 1e0f          	ldw	x,(OFST+3,sp)
 185  0060 89            	pushw	x
 186  0061 cd0154        	call	_elapsedTime
 188  0064 5b08          	addw	sp,#8
 189  0066 96            	ldw	x,sp
 190  0067 1c0001        	addw	x,#OFST-11
 191  006a cd0000        	call	c_rtol
 194                     ; 55       printf("currentTime: %lu   starTime: %lu   Loop Time: %lu\n", currentTime,
 194                     ; 56              start_time, LoopTime);
 196  006d 1e03          	ldw	x,(OFST-9,sp)
 197  006f 89            	pushw	x
 198  0070 1e03          	ldw	x,(OFST-9,sp)
 199  0072 89            	pushw	x
 200  0073 1e0f          	ldw	x,(OFST+3,sp)
 201  0075 89            	pushw	x
 202  0076 1e0f          	ldw	x,(OFST+3,sp)
 203  0078 89            	pushw	x
 204  0079 1e0f          	ldw	x,(OFST+3,sp)
 205  007b 89            	pushw	x
 206  007c 1e0f          	ldw	x,(OFST+3,sp)
 207  007e 89            	pushw	x
 208  007f ae0000        	ldw	x,#L74
 209  0082 cd0000        	call	_printf
 211  0085 5b0c          	addw	sp,#12
 212                     ; 57       start_time = 0;
 215  0087 2094          	jra	L34
 248                     ; 62 void clock_setup(void) {
 249                     	switch	.text
 250  0089               _clock_setup:
 254                     ; 63   CLK_DeInit();
 256  0089 cd0000        	call	_CLK_DeInit
 258                     ; 64   CLK_HSECmd(DISABLE);
 260  008c 4f            	clr	a
 261  008d cd0000        	call	_CLK_HSECmd
 263                     ; 65   CLK_LSICmd(DISABLE);
 265  0090 4f            	clr	a
 266  0091 cd0000        	call	_CLK_LSICmd
 268                     ; 66   CLK_HSICmd(ENABLE);
 270  0094 a601          	ld	a,#1
 271  0096 cd0000        	call	_CLK_HSICmd
 274  0099               L36:
 275                     ; 67   while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 277  0099 ae0102        	ldw	x,#258
 278  009c cd0000        	call	_CLK_GetFlagStatus
 280  009f 4d            	tnz	a
 281  00a0 27f7          	jreq	L36
 282                     ; 69   CLK_ClockSwitchCmd(ENABLE);
 284  00a2 a601          	ld	a,#1
 285  00a4 cd0000        	call	_CLK_ClockSwitchCmd
 287                     ; 70   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 289  00a7 4f            	clr	a
 290  00a8 cd0000        	call	_CLK_HSIPrescalerConfig
 292                     ; 71   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 294  00ab a680          	ld	a,#128
 295  00ad cd0000        	call	_CLK_SYSCLKConfig
 297                     ; 73   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
 297                     ; 74                         CLK_CURRENTCLOCKSTATE_ENABLE);
 299  00b0 4b01          	push	#1
 300  00b2 4b00          	push	#0
 301  00b4 ae01e1        	ldw	x,#481
 302  00b7 cd0000        	call	_CLK_ClockSwitchConfig
 304  00ba 85            	popw	x
 305                     ; 76   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 307  00bb ae0401        	ldw	x,#1025
 308  00be cd0000        	call	_CLK_PeripheralClockConfig
 310                     ; 77   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 312  00c1 ae0301        	ldw	x,#769
 313  00c4 cd0000        	call	_CLK_PeripheralClockConfig
 315                     ; 81 }
 318  00c7 81            	ret
 348                     ; 83 void TIM4_Config(void) {
 349                     	switch	.text
 350  00c8               _TIM4_Config:
 354                     ; 84   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 356  00c8 ae0401        	ldw	x,#1025
 357  00cb cd0000        	call	_CLK_PeripheralClockConfig
 359                     ; 86   TIM4_DeInit();
 361  00ce cd0000        	call	_TIM4_DeInit
 363                     ; 87   TIM4_TimeBaseInit(TIM4_PRESCALER_16,
 363                     ; 88                     250);  // TimerClock = 16000000 / 16 / 250 = 4000Hz
 365  00d1 ae04fa        	ldw	x,#1274
 366  00d4 cd0000        	call	_TIM4_TimeBaseInit
 368                     ; 89   TIM4_ClearFlag(TIM4_FLAG_UPDATE);
 370  00d7 a601          	ld	a,#1
 371  00d9 cd0000        	call	_TIM4_ClearFlag
 373                     ; 90   TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
 375  00dc ae0101        	ldw	x,#257
 376  00df cd0000        	call	_TIM4_ITConfig
 378                     ; 92   enableInterrupts();  // global interrupt enable
 381  00e2 9a            rim
 383                     ; 93   TIM4_Cmd(ENABLE);    // Start Timer 4
 386  00e3 a601          	ld	a,#1
 387  00e5 cd0000        	call	_TIM4_Cmd
 389                     ; 94 }
 392  00e8 81            	ret
 436                     ; 96 void delay_ms(uint16_t ms) {
 437                     	switch	.text
 438  00e9               _delay_ms:
 440  00e9 89            	pushw	x
 441  00ea 89            	pushw	x
 442       00000002      OFST:	set	2
 445                     ; 98   for (i = 0; i < ms; i++) {
 447  00eb 5f            	clrw	x
 448  00ec 1f01          	ldw	(OFST-1,sp),x
 451  00ee 200c          	jra	L521
 452  00f0               L121:
 453                     ; 99     delay_us(1000);
 455  00f0 ae03e8        	ldw	x,#1000
 456  00f3 ad10          	call	_delay_us
 458                     ; 98   for (i = 0; i < ms; i++) {
 460  00f5 1e01          	ldw	x,(OFST-1,sp)
 461  00f7 1c0001        	addw	x,#1
 462  00fa 1f01          	ldw	(OFST-1,sp),x
 464  00fc               L521:
 467  00fc 1e01          	ldw	x,(OFST-1,sp)
 468  00fe 1303          	cpw	x,(OFST+1,sp)
 469  0100 25ee          	jrult	L121
 470                     ; 101 }
 473  0102 5b04          	addw	sp,#4
 474  0104 81            	ret
 537                     ; 107 void delay_us(uint16_t us) {
 538                     	switch	.text
 539  0105               _delay_us:
 541  0105 89            	pushw	x
 542  0106 5205          	subw	sp,#5
 543       00000005      OFST:	set	5
 546                     ; 108   uint8_t start_us = TIM4_GetCounter();  // tim4 increments every us
 548  0108 cd0000        	call	_TIM4_GetCounter
 550  010b 6b05          	ld	(OFST+0,sp),a
 552                     ; 109   if (us >= 250) {  // we only need to bother with the following for delays
 554  010d 1e06          	ldw	x,(OFST+1,sp)
 555  010f a300fa        	cpw	x,#250
 556  0112 2514          	jrult	L771
 557                     ; 111     uint16_t start_tick = (uint16_t)tick;  // the tick increments every 250us
 559  0114 be08          	ldw	x,_tick+2
 560  0116 1f01          	ldw	(OFST-4,sp),x
 562                     ; 112     uint16_t delay_ticks = us / 250;
 564  0118 1e06          	ldw	x,(OFST+1,sp)
 565  011a a6fa          	ld	a,#250
 566  011c 62            	div	x,a
 567  011d 1f03          	ldw	(OFST-2,sp),x
 570  011f               L171:
 571                     ; 114     while (((uint16_t)tick - start_tick) <
 571                     ; 115            delay_ticks);  // delay in multiples of 250us
 573  011f be08          	ldw	x,_tick+2
 574  0121 72f001        	subw	x,(OFST-4,sp)
 575  0124 1303          	cpw	x,(OFST-2,sp)
 576  0126 25f7          	jrult	L171
 577  0128               L771:
 578                     ; 117   while (TIM4_GetCounter() <
 578                     ; 118          start_us);  // now wait until our 1us counter matches our start us
 580  0128 cd0000        	call	_TIM4_GetCounter
 582  012b 1105          	cp	a,(OFST+0,sp)
 583  012d 25f9          	jrult	L771
 584                     ; 119 }
 587  012f 5b07          	addw	sp,#7
 588  0131 81            	ret
 612                     ; 122 uint16_t millis(void) {
 613                     	switch	.text
 614  0132               _millis:
 618                     ; 123   return ((uint16_t)(tick >> 2));  // divide tick by 4 returns milliseconds
 620  0132 ae0006        	ldw	x,#_tick
 621  0135 cd0000        	call	c_ltor
 623  0138 a602          	ld	a,#2
 624  013a cd0000        	call	c_lursh
 626  013d be02          	ldw	x,c_lreg+2
 629  013f 81            	ret
 654                     ; 127 uint32_t micros(void) {
 655                     	switch	.text
 656  0140               _micros:
 660                     ; 128   return (tick * 250 + TIM4_GetCounter());  // each tick is worth 250us
 662  0140 cd0000        	call	_TIM4_GetCounter
 664  0143 88            	push	a
 665  0144 ae0006        	ldw	x,#_tick
 666  0147 cd0000        	call	c_ltor
 668  014a a6fa          	ld	a,#250
 669  014c cd0000        	call	c_smul
 671  014f 84            	pop	a
 672  0150 cd0000        	call	c_ladc
 676  0153 81            	ret
 719                     ; 131 uint32_t elapsedTime(uint32_t start, uint32_t end) {
 720                     	switch	.text
 721  0154               _elapsedTime:
 723       00000000      OFST:	set	0
 726                     ; 132   if (end >= start) {
 728  0154 96            	ldw	x,sp
 729  0155 1c0007        	addw	x,#OFST+7
 730  0158 cd0000        	call	c_ltor
 732  015b 96            	ldw	x,sp
 733  015c 1c0003        	addw	x,#OFST+3
 734  015f cd0000        	call	c_lcmp
 736  0162 250f          	jrult	L542
 737                     ; 134     return end - start;
 739  0164 96            	ldw	x,sp
 740  0165 1c0007        	addw	x,#OFST+7
 741  0168 cd0000        	call	c_ltor
 743  016b 96            	ldw	x,sp
 744  016c 1c0003        	addw	x,#OFST+3
 745  016f cd0000        	call	c_lsub
 749  0172 81            	ret
 750  0173               L542:
 751                     ; 136     return (65535 - start + 1) + end;
 753  0173 ae0000        	ldw	x,#0
 754  0176 bf02          	ldw	c_lreg+2,x
 755  0178 ae0001        	ldw	x,#1
 756  017b bf00          	ldw	c_lreg,x
 757  017d 96            	ldw	x,sp
 758  017e 1c0003        	addw	x,#OFST+3
 759  0181 cd0000        	call	c_lsub
 761  0184 96            	ldw	x,sp
 762  0185 1c0007        	addw	x,#OFST+7
 763  0188 cd0000        	call	c_ladd
 767  018b 81            	ret
 792                     ; 140 @far @interrupt void TIM4_IRQHandler(void) {
 794                     	switch	.text
 795  018c               f_TIM4_IRQHandler:
 797  018c 8a            	push	cc
 798  018d 84            	pop	a
 799  018e a4bf          	and	a,#191
 800  0190 88            	push	a
 801  0191 86            	pop	cc
 802  0192 3b0002        	push	c_x+2
 803  0195 be00          	ldw	x,c_x
 804  0197 89            	pushw	x
 805  0198 3b0002        	push	c_y+2
 806  019b be00          	ldw	x,c_y
 807  019d 89            	pushw	x
 810                     ; 141   tick++;
 812  019e ae0006        	ldw	x,#_tick
 813  01a1 a601          	ld	a,#1
 814  01a3 cd0000        	call	c_lgadc
 816                     ; 142   TIM4_ClearFlag(TIM4_FLAG_UPDATE);  // Clear the TIM4 update interrupt flag
 818  01a6 a601          	ld	a,#1
 819  01a8 cd0000        	call	_TIM4_ClearFlag
 821                     ; 144 }
 824  01ab 85            	popw	x
 825  01ac bf00          	ldw	c_y,x
 826  01ae 320002        	pop	c_y+2
 827  01b1 85            	popw	x
 828  01b2 bf00          	ldw	c_x,x
 829  01b4 320002        	pop	c_x+2
 830  01b7 80            	iret
 855                     ; 147 void UART3_setup(void) {
 857                     	switch	.text
 858  01b8               _UART3_setup:
 862                     ; 148   UART3_DeInit();
 864  01b8 cd0000        	call	_UART3_DeInit
 866                     ; 151   UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
 866                     ; 152              UART3_MODE_TX_ENABLE);
 868  01bb 4b04          	push	#4
 869  01bd 4b00          	push	#0
 870  01bf 4b00          	push	#0
 871  01c1 4b00          	push	#0
 872  01c3 ae2580        	ldw	x,#9600
 873  01c6 89            	pushw	x
 874  01c7 ae0000        	ldw	x,#0
 875  01ca 89            	pushw	x
 876  01cb cd0000        	call	_UART3_Init
 878  01ce 5b08          	addw	sp,#8
 879                     ; 154   UART3_Cmd(ENABLE);  // Enable UART1
 881  01d0 a601          	ld	a,#1
 882  01d2 cd0000        	call	_UART3_Cmd
 884                     ; 155 }
 887  01d5 81            	ret
 923                     ; 157 PUTCHAR_PROTOTYPE {
 924                     	switch	.text
 925  01d6               _putchar:
 927  01d6 88            	push	a
 928       00000000      OFST:	set	0
 931                     ; 159   UART3_SendData8(c);
 933  01d7 cd0000        	call	_UART3_SendData8
 936  01da               L113:
 937                     ; 161   while (UART3_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 939  01da ae0080        	ldw	x,#128
 940  01dd cd0000        	call	_UART3_GetFlagStatus
 942  01e0 4d            	tnz	a
 943  01e1 27f7          	jreq	L113
 944                     ; 163   return (c);
 946  01e3 7b01          	ld	a,(OFST+1,sp)
 949  01e5 5b01          	addw	sp,#1
 950  01e7 81            	ret
 992                     	xdef	_main
 993                     	xdef	_UART3_setup
 994                     	xdef	f_TIM4_IRQHandler
 995                     	xdef	_elapsedTime
 996                     	xdef	_micros
 997                     	xdef	_millis
 998                     	xdef	_delay_us
 999                     	xdef	_delay_ms
1000                     	xdef	_TIM4_Config
1001                     	xdef	_clock_setup
1002                     	xdef	_tick
1003                     	xdef	_micros_offset
1004                     	xdef	_millis_count
1005                     	xref	_UART3_GetFlagStatus
1006                     	xref	_UART3_SendData8
1007                     	xref	_UART3_Cmd
1008                     	xref	_UART3_Init
1009                     	xref	_UART3_DeInit
1010                     	xref	_TIM4_ClearFlag
1011                     	xref	_TIM4_GetCounter
1012                     	xref	_TIM4_ITConfig
1013                     	xref	_TIM4_Cmd
1014                     	xref	_TIM4_TimeBaseInit
1015                     	xref	_TIM4_DeInit
1016                     	xref	_GPIO_WriteLow
1017                     	xref	_GPIO_WriteHigh
1018                     	xref	_GPIO_Init
1019                     	xref	_GPIO_DeInit
1020                     	xref	_CLK_GetFlagStatus
1021                     	xref	_CLK_SYSCLKConfig
1022                     	xref	_CLK_HSIPrescalerConfig
1023                     	xref	_CLK_ClockSwitchConfig
1024                     	xref	_CLK_PeripheralClockConfig
1025                     	xref	_CLK_ClockSwitchCmd
1026                     	xref	_CLK_LSICmd
1027                     	xref	_CLK_HSICmd
1028                     	xref	_CLK_HSECmd
1029                     	xref	_CLK_DeInit
1030                     	xdef	_putchar
1031                     	xref	_printf
1032                     .const:	section	.text
1033  0000               L74:
1034  0000 63757272656e  	dc.b	"currentTime: %lu  "
1035  0012 207374617254  	dc.b	" starTime: %lu   L"
1036  0024 6f6f70205469  	dc.b	"oop Time: %lu",10,0
1037                     	xref.b	c_lreg
1038                     	xref.b	c_x
1039                     	xref.b	c_y
1059                     	xref	c_lgadc
1060                     	xref	c_ladd
1061                     	xref	c_lsub
1062                     	xref	c_lcmp
1063                     	xref	c_ladc
1064                     	xref	c_smul
1065                     	xref	c_lursh
1066                     	xref	c_ltor
1067                     	xref	c_rtol
1068                     	xref	c_uitolx
1069                     	end
