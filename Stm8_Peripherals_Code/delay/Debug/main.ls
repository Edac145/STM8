   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _value:
  16  0000 0000          	dc.w	0
  17  0002               _n:
  18  0002 00            	dc.b	0
  19  0003               _seg:
  20  0003 01            	dc.b	1
  21                     .const:	section	.text
  22  0000               _num:
  23  0000 c0            	dc.b	192
  24  0001 f9            	dc.b	249
  25  0002 a4            	dc.b	164
  26  0003 b0            	dc.b	176
  27  0004 99            	dc.b	153
  28  0005 92            	dc.b	146
  29  0006 82            	dc.b	130
  30  0007 f8            	dc.b	248
  31  0008 80            	dc.b	128
  32  0009 90            	dc.b	144
  67                     ; 19 void main()
  67                     ; 20 {
  69                     	switch	.text
  70  0000               _main:
  74                     ; 21   clock_setup();
  76  0000 ad3a          	call	_clock_setup
  78                     ; 22 	GPIO_DeInit(GPIOC);
  80  0002 ae500a        	ldw	x,#20490
  81  0005 cd0000        	call	_GPIO_DeInit
  83                     ; 23 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
  85  0008 4be0          	push	#224
  86  000a 4b08          	push	#8
  87  000c ae500a        	ldw	x,#20490
  88  000f cd0000        	call	_GPIO_Init
  90  0012 85            	popw	x
  91                     ; 24 	GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
  93  0013 4b08          	push	#8
  94  0015 ae500a        	ldw	x,#20490
  95  0018 cd0000        	call	_GPIO_WriteHigh
  97  001b 84            	pop	a
  98  001c               L12:
  99                     ; 27 		delay_ms(1000);
 101  001c ae03e8        	ldw	x,#1000
 102  001f cd00dd        	call	_delay_ms
 104                     ; 28 		GPIO_WriteLow(GPIOC, GPIO_PIN_3);
 106  0022 4b08          	push	#8
 107  0024 ae500a        	ldw	x,#20490
 108  0027 cd0000        	call	_GPIO_WriteLow
 110  002a 84            	pop	a
 111                     ; 29 		delay_ms(1000);
 113  002b ae03e8        	ldw	x,#1000
 114  002e cd00dd        	call	_delay_ms
 116                     ; 30 		GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
 118  0031 4b08          	push	#8
 119  0033 ae500a        	ldw	x,#20490
 120  0036 cd0000        	call	_GPIO_WriteHigh
 122  0039 84            	pop	a
 124  003a 20e0          	jra	L12
 157                     ; 35 void clock_setup(void)
 157                     ; 36 {
 158                     	switch	.text
 159  003c               _clock_setup:
 163                     ; 37      CLK_DeInit();
 165  003c cd0000        	call	_CLK_DeInit
 167                     ; 39      CLK_HSECmd(ENABLE);
 169  003f a601          	ld	a,#1
 170  0041 cd0000        	call	_CLK_HSECmd
 172                     ; 40      CLK_LSICmd(DISABLE);
 174  0044 4f            	clr	a
 175  0045 cd0000        	call	_CLK_LSICmd
 177                     ; 41      CLK_HSICmd(DISABLE);
 179  0048 4f            	clr	a
 180  0049 cd0000        	call	_CLK_HSICmd
 183  004c               L73:
 184                     ; 42      while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 186  004c ae0102        	ldw	x,#258
 187  004f cd0000        	call	_CLK_GetFlagStatus
 189  0052 4d            	tnz	a
 190  0053 27f7          	jreq	L73
 191                     ; 44      CLK_ClockSwitchCmd(ENABLE);
 193  0055 a601          	ld	a,#1
 194  0057 cd0000        	call	_CLK_ClockSwitchCmd
 196                     ; 45      CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
 198  005a a618          	ld	a,#24
 199  005c cd0000        	call	_CLK_HSIPrescalerConfig
 201                     ; 46      CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 203  005f a680          	ld	a,#128
 204  0061 cd0000        	call	_CLK_SYSCLKConfig
 206                     ; 48      CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 206                     ; 49      DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 208  0064 4b01          	push	#1
 209  0066 4b00          	push	#0
 210  0068 ae01e1        	ldw	x,#481
 211  006b cd0000        	call	_CLK_ClockSwitchConfig
 213  006e 85            	popw	x
 214                     ; 51      CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 216  006f ae0100        	ldw	x,#256
 217  0072 cd0000        	call	_CLK_PeripheralClockConfig
 219                     ; 52      CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 221  0075 5f            	clrw	x
 222  0076 cd0000        	call	_CLK_PeripheralClockConfig
 224                     ; 53      CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 226  0079 ae1300        	ldw	x,#4864
 227  007c cd0000        	call	_CLK_PeripheralClockConfig
 229                     ; 54      CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 231  007f ae1200        	ldw	x,#4608
 232  0082 cd0000        	call	_CLK_PeripheralClockConfig
 234                     ; 55      CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 236  0085 ae0200        	ldw	x,#512
 237  0088 cd0000        	call	_CLK_PeripheralClockConfig
 239                     ; 56      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 241  008b ae0700        	ldw	x,#1792
 242  008e cd0000        	call	_CLK_PeripheralClockConfig
 244                     ; 57      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 246  0091 ae0500        	ldw	x,#1280
 247  0094 cd0000        	call	_CLK_PeripheralClockConfig
 249                     ; 58      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 251  0097 ae0401        	ldw	x,#1025
 252  009a cd0000        	call	_CLK_PeripheralClockConfig
 254                     ; 59 }
 257  009d 81            	ret
 280                     ; 61 void delay_init(void)
 280                     ; 62 {
 281                     	switch	.text
 282  009e               _delay_init:
 286                     ; 63 	TIM4->PSCR = 0x01;   //2 MHz/2 = 1 Mhz
 288  009e 35015345      	mov	21317,#1
 289                     ; 64 	TIM4->ARR = 0xFF;    //255 will be reloaded
 291  00a2 35ff5346      	mov	21318,#255
 292                     ; 65 	TIM4->CR1 &= 0x00;   //CR1=0, all default value
 294  00a6 725f5340      	clr	21312
 295                     ; 66 	TIM4->CR1 |= (1<<2);  //URS = 1 (update only when overflow)
 297  00aa 72145340      	bset	21312,#2
 298                     ; 67 	TIM4->EGR = 0x00;     // no Action
 300  00ae 725f5343      	clr	21315
 301                     ; 68 	TIM4->CNTR = 0x00;   // cntr is zero by default
 303  00b2 725f5344      	clr	21316
 304                     ; 69 	TIM4->IER = 0x00;    // interrupt is disabled
 306  00b6 725f5341      	clr	21313
 307                     ; 70 }
 310  00ba 81            	ret
 344                     ; 72 void delay_us(unsigned char time)
 344                     ; 73 {
 345                     	switch	.text
 346  00bb               _delay_us:
 348  00bb 88            	push	a
 349       00000000      OFST:	set	0
 352                     ; 74 	TIM4->EGR |= 0x01;
 354  00bc 72105343      	bset	21315,#0
 355                     ; 75 	TIM4->CNTR = 0;
 357  00c0 725f5344      	clr	21316
 358                     ; 76 	TIM4->CR1 |= (1<<0);
 360  00c4 72105340      	bset	21312,#0
 362  00c8               L37:
 363                     ; 77 	while(TIM4->CNTR<time);
 365  00c8 c65344        	ld	a,21316
 366  00cb 1101          	cp	a,(OFST+1,sp)
 367  00cd 25f9          	jrult	L37
 368                     ; 78 	TIM4->CR1 &= ~(1<<0);
 370  00cf 72115340      	bres	21312,#0
 371                     ; 79 	TIM4->CNTR = 0x00;
 373  00d3 725f5344      	clr	21316
 374                     ; 81 	TIM4->SR1 &= ~(1<<0);
 376  00d7 72115342      	bres	21314,#0
 377                     ; 82 }
 380  00db 84            	pop	a
 381  00dc 81            	ret
 416                     ; 84 void delay_ms(unsigned int time)
 416                     ; 85 {
 417                     	switch	.text
 418  00dd               _delay_ms:
 420  00dd 89            	pushw	x
 421       00000000      OFST:	set	0
 424                     ; 86 	time*=10;
 426  00de 1e01          	ldw	x,(OFST+1,sp)
 427  00e0 a60a          	ld	a,#10
 428  00e2 cd0000        	call	c_bmulx
 430  00e5 1f01          	ldw	(OFST+1,sp),x
 432  00e7 2004          	jra	L711
 433  00e9               L511:
 434                     ; 88 		delay_us(100);
 436  00e9 a664          	ld	a,#100
 437  00eb adce          	call	_delay_us
 439  00ed               L711:
 440                     ; 87 	while(time--)
 442  00ed 1e01          	ldw	x,(OFST+1,sp)
 443  00ef 1d0001        	subw	x,#1
 444  00f2 1f01          	ldw	(OFST+1,sp),x
 445  00f4 1c0001        	addw	x,#1
 446  00f7 a30000        	cpw	x,#0
 447  00fa 26ed          	jrne	L511
 448                     ; 89 }
 451  00fc 85            	popw	x
 452  00fd 81            	ret
 504                     	xdef	_main
 505                     	xdef	_delay_ms
 506                     	xdef	_delay_us
 507                     	xdef	_delay_init
 508                     	xdef	_clock_setup
 509                     	xdef	_num
 510                     	xdef	_seg
 511                     	xdef	_n
 512                     	xdef	_value
 513                     	xref	_GPIO_WriteLow
 514                     	xref	_GPIO_WriteHigh
 515                     	xref	_GPIO_Init
 516                     	xref	_GPIO_DeInit
 517                     	xref	_CLK_GetFlagStatus
 518                     	xref	_CLK_SYSCLKConfig
 519                     	xref	_CLK_HSIPrescalerConfig
 520                     	xref	_CLK_ClockSwitchConfig
 521                     	xref	_CLK_PeripheralClockConfig
 522                     	xref	_CLK_ClockSwitchCmd
 523                     	xref	_CLK_LSICmd
 524                     	xref	_CLK_HSICmd
 525                     	xref	_CLK_HSECmd
 526                     	xref	_CLK_DeInit
 527                     	xref.b	c_x
 546                     	xref	c_bmulx
 547                     	end
