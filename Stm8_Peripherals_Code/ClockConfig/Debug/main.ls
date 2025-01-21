   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  77                     ; 11 void main()
  77                     ; 12 {
  79                     	switch	.text
  80  0000               _main:
  82  0000 88            	push	a
  83       00000001      OFST:	set	1
  86                     ; 13 	bool i = 0;
  88                     ; 15    GPIO_DeInit(GPIOE);
  90  0001 ae5014        	ldw	x,#20500
  91  0004 cd0000        	call	_GPIO_DeInit
  93                     ; 16    GPIO_DeInit(GPIOC);
  95  0007 ae500a        	ldw	x,#20490
  96  000a cd0000        	call	_GPIO_DeInit
  98                     ; 17 	 GPIO_DeInit(GPIOD);
 100  000d ae500f        	ldw	x,#20495
 101  0010 cd0000        	call	_GPIO_DeInit
 103                     ; 18    GPIO_DeInit(GPIOA);
 105  0013 ae5000        	ldw	x,#20480
 106  0016 cd0000        	call	_GPIO_DeInit
 108                     ; 20    GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_OD_LOW_FAST);
 110  0019 4ba0          	push	#160
 111  001b 4b08          	push	#8
 112  001d ae500a        	ldw	x,#20490
 113  0020 cd0000        	call	_GPIO_Init
 115  0023 85            	popw	x
 116                     ; 21 	 GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
 118  0024 4b08          	push	#8
 119  0026 ae500a        	ldw	x,#20490
 120  0029 cd0000        	call	_GPIO_WriteHigh
 122  002c 84            	pop	a
 123                     ; 22 	 GPIO_Init(GPIOE, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 125  002d 4be0          	push	#224
 126  002f 4b08          	push	#8
 127  0031 ae5014        	ldw	x,#20500
 128  0034 cd0000        	call	_GPIO_Init
 130  0037 85            	popw	x
 131                     ; 23 	 GPIO_WriteHigh(GPIOE, GPIO_PIN_3);
 133  0038 4b08          	push	#8
 134  003a ae5014        	ldw	x,#20500
 135  003d cd0000        	call	_GPIO_WriteHigh
 137  0040 84            	pop	a
 138                     ; 24 	 GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
 140  0041 4be0          	push	#224
 141  0043 4b01          	push	#1
 142  0045 ae500f        	ldw	x,#20495
 143  0048 cd0000        	call	_GPIO_Init
 145  004b 85            	popw	x
 146                     ; 25 	 GPIO_WriteHigh(GPIOD, GPIO_PIN_0);
 148  004c 4b01          	push	#1
 149  004e ae500f        	ldw	x,#20495
 150  0051 cd0000        	call	_GPIO_WriteHigh
 152  0054 84            	pop	a
 153                     ; 26 	 GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 155  0055 4be0          	push	#224
 156  0057 4b08          	push	#8
 157  0059 ae500f        	ldw	x,#20495
 158  005c cd0000        	call	_GPIO_Init
 160  005f 85            	popw	x
 161                     ; 27 	 GPIO_WriteHigh(GPIOD, GPIO_PIN_3);
 163  0060 4b08          	push	#8
 164  0062 ae500f        	ldw	x,#20495
 165  0065 cd0000        	call	_GPIO_WriteHigh
 167  0068 84            	pop	a
 168                     ; 28 	 GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 170  0069 4be0          	push	#224
 171  006b 4b08          	push	#8
 172  006d ae5000        	ldw	x,#20480
 173  0070 cd0000        	call	_GPIO_Init
 175  0073 85            	popw	x
 176                     ; 29 	 GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
 178  0074 4b08          	push	#8
 179  0076 ae5000        	ldw	x,#20480
 180  0079 cd0000        	call	_GPIO_WriteHigh
 182  007c 84            	pop	a
 183  007d               L73:
 185  007d 20fe          	jra	L73
 210                     ; 35 void setup(void)
 210                     ; 36 {
 211                     	switch	.text
 212  007f               _setup:
 216                     ; 37   clock_setup();
 218  007f ad03          	call	_clock_setup
 220                     ; 38 	GPIO_setup();
 222  0081 ad76          	call	_GPIO_setup
 224                     ; 39 }
 227  0083 81            	ret
 262                     ; 42 void clock_setup(void)
 262                     ; 43 {
 263                     	switch	.text
 264  0084               _clock_setup:
 268                     ; 44   CLK_DeInit();
 270  0084 cd0000        	call	_CLK_DeInit
 272                     ; 46   CLK_HSECmd(DISABLE);
 274  0087 4f            	clr	a
 275  0088 cd0000        	call	_CLK_HSECmd
 277                     ; 47   CLK_LSICmd(DISABLE);
 279  008b 4f            	clr	a
 280  008c cd0000        	call	_CLK_LSICmd
 282                     ; 48   CLK_HSICmd(ENABLE);
 284  008f a601          	ld	a,#1
 285  0091 cd0000        	call	_CLK_HSICmd
 288  0094               L56:
 289                     ; 49   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 291  0094 ae0102        	ldw	x,#258
 292  0097 cd0000        	call	_CLK_GetFlagStatus
 294  009a 4d            	tnz	a
 295  009b 27f7          	jreq	L56
 296                     ; 51   CLK_ClockSwitchCmd(ENABLE);
 298  009d a601          	ld	a,#1
 299  009f cd0000        	call	_CLK_ClockSwitchCmd
 301                     ; 52   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
 303  00a2 a618          	ld	a,#24
 304  00a4 cd0000        	call	_CLK_HSIPrescalerConfig
 306                     ; 53   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV4);
 308  00a7 a682          	ld	a,#130
 309  00a9 cd0000        	call	_CLK_SYSCLKConfig
 311                     ; 55   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 311                     ; 56   DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 313  00ac 4b01          	push	#1
 314  00ae 4b00          	push	#0
 315  00b0 ae01e1        	ldw	x,#481
 316  00b3 cd0000        	call	_CLK_ClockSwitchConfig
 318  00b6 85            	popw	x
 319                     ; 58   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 321  00b7 5f            	clrw	x
 322  00b8 cd0000        	call	_CLK_PeripheralClockConfig
 324                     ; 59   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 326  00bb ae0100        	ldw	x,#256
 327  00be cd0000        	call	_CLK_PeripheralClockConfig
 329                     ; 60   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 331  00c1 ae0200        	ldw	x,#512
 332  00c4 cd0000        	call	_CLK_PeripheralClockConfig
 334                     ; 61   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 336  00c7 ae1200        	ldw	x,#4608
 337  00ca cd0000        	call	_CLK_PeripheralClockConfig
 339                     ; 62   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 341  00cd ae1300        	ldw	x,#4864
 342  00d0 cd0000        	call	_CLK_PeripheralClockConfig
 344                     ; 63   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 346  00d3 ae0700        	ldw	x,#1792
 347  00d6 cd0000        	call	_CLK_PeripheralClockConfig
 349                     ; 64   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 351  00d9 ae0500        	ldw	x,#1280
 352  00dc cd0000        	call	_CLK_PeripheralClockConfig
 354                     ; 65   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 356  00df ae0400        	ldw	x,#1024
 357  00e2 cd0000        	call	_CLK_PeripheralClockConfig
 359                     ; 67   CLK_CCOConfig(CLK_OUTPUT_CPU);
 361  00e5 a608          	ld	a,#8
 362  00e7 cd0000        	call	_CLK_CCOConfig
 364                     ; 68   CLK_CCOCmd(ENABLE);
 366  00ea a601          	ld	a,#1
 367  00ec cd0000        	call	_CLK_CCOCmd
 370  00ef               L37:
 371                     ; 69   while(CLK_GetFlagStatus(CLK_FLAG_CCORDY) == FALSE);
 373  00ef ae0502        	ldw	x,#1282
 374  00f2 cd0000        	call	_CLK_GetFlagStatus
 376  00f5 4d            	tnz	a
 377  00f6 27f7          	jreq	L37
 378                     ; 70 }
 381  00f8 81            	ret
 405                     ; 72 void GPIO_setup(void)
 405                     ; 73 {                               
 406                     	switch	.text
 407  00f9               _GPIO_setup:
 411                     ; 75   GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 413  00f9 4be0          	push	#224
 414  00fb 4b08          	push	#8
 415  00fd ae500a        	ldw	x,#20490
 416  0100 cd0000        	call	_GPIO_Init
 418  0103 85            	popw	x
 419                     ; 76 }
 422  0104 81            	ret
 435                     	xdef	_main
 436                     	xdef	_GPIO_setup
 437                     	xdef	_clock_setup
 438                     	xdef	_setup
 439                     	xref	_GPIO_WriteHigh
 440                     	xref	_GPIO_Init
 441                     	xref	_GPIO_DeInit
 442                     	xref	_CLK_GetFlagStatus
 443                     	xref	_CLK_SYSCLKConfig
 444                     	xref	_CLK_CCOConfig
 445                     	xref	_CLK_HSIPrescalerConfig
 446                     	xref	_CLK_ClockSwitchConfig
 447                     	xref	_CLK_PeripheralClockConfig
 448                     	xref	_CLK_ClockSwitchCmd
 449                     	xref	_CLK_CCOCmd
 450                     	xref	_CLK_LSICmd
 451                     	xref	_CLK_HSICmd
 452                     	xref	_CLK_HSECmd
 453                     	xref	_CLK_DeInit
 472                     	end
