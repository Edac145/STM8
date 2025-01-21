   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  68                     ; 17 void main() {
  70                     	switch	.text
  71  0000               _main:
  73  0000 5204          	subw	sp,#4
  74       00000004      OFST:	set	4
  77                     ; 20     clock_setup();
  79  0002 ad27          	call	_clock_setup
  81                     ; 21     GPIO_setup();
  83  0004 cd008d        	call	_GPIO_setup
  85                     ; 22     ADC2_setup();
  87  0007 cd00aa        	call	_ADC2_setup
  89                     ; 23     UART3_setup();
  91  000a cd00e8        	call	_UART3_setup
  93  000d               L33:
  94                     ; 26         A0 = read_ADC_Channel(5);
  96  000d a605          	ld	a,#5
  97  000f cd00c7        	call	_read_ADC_Channel
  99  0012 1f01          	ldw	(OFST-3,sp),x
 101                     ; 27         A1 = read_ADC_Channel(6);
 103  0014 a606          	ld	a,#6
 104  0016 cd00c7        	call	_read_ADC_Channel
 106  0019 1f03          	ldw	(OFST-1,sp),x
 108                     ; 29         printf("Adc Value 0: %d  Adc Value 1: %d\n", A0, A1);
 110  001b 1e03          	ldw	x,(OFST-1,sp)
 111  001d 89            	pushw	x
 112  001e 1e03          	ldw	x,(OFST-1,sp)
 113  0020 89            	pushw	x
 114  0021 ae0000        	ldw	x,#L73
 115  0024 cd0000        	call	_printf
 117  0027 5b04          	addw	sp,#4
 119  0029 20e2          	jra	L33
 152                     ; 33 void clock_setup(void) {
 153                     	switch	.text
 154  002b               _clock_setup:
 158                     ; 34     CLK_DeInit();
 160  002b cd0000        	call	_CLK_DeInit
 162                     ; 36     CLK_HSECmd(DISABLE);
 164  002e 4f            	clr	a
 165  002f cd0000        	call	_CLK_HSECmd
 167                     ; 37     CLK_LSICmd(DISABLE);
 169  0032 4f            	clr	a
 170  0033 cd0000        	call	_CLK_LSICmd
 172                     ; 38     CLK_HSICmd(ENABLE);
 174  0036 a601          	ld	a,#1
 175  0038 cd0000        	call	_CLK_HSICmd
 178  003b               L35:
 179                     ; 39     while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 181  003b ae0102        	ldw	x,#258
 182  003e cd0000        	call	_CLK_GetFlagStatus
 184  0041 4d            	tnz	a
 185  0042 27f7          	jreq	L35
 186                     ; 41     CLK_ClockSwitchCmd(ENABLE);
 188  0044 a601          	ld	a,#1
 189  0046 cd0000        	call	_CLK_ClockSwitchCmd
 191                     ; 42     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV2);
 193  0049 a608          	ld	a,#8
 194  004b cd0000        	call	_CLK_HSIPrescalerConfig
 196                     ; 43     CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV4);
 198  004e a682          	ld	a,#130
 199  0050 cd0000        	call	_CLK_SYSCLKConfig
 201                     ; 45     CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI,
 201                     ; 46                           DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 203  0053 4b01          	push	#1
 204  0055 4b00          	push	#0
 205  0057 ae01e1        	ldw	x,#481
 206  005a cd0000        	call	_CLK_ClockSwitchConfig
 208  005d 85            	popw	x
 209                     ; 48     CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 211  005e ae0100        	ldw	x,#256
 212  0061 cd0000        	call	_CLK_PeripheralClockConfig
 214                     ; 49     CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 216  0064 5f            	clrw	x
 217  0065 cd0000        	call	_CLK_PeripheralClockConfig
 219                     ; 50     CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 221  0068 ae1301        	ldw	x,#4865
 222  006b cd0000        	call	_CLK_PeripheralClockConfig
 224                     ; 51     CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 226  006e ae1200        	ldw	x,#4608
 227  0071 cd0000        	call	_CLK_PeripheralClockConfig
 229                     ; 52     CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 231  0074 ae0200        	ldw	x,#512
 232  0077 cd0000        	call	_CLK_PeripheralClockConfig
 234                     ; 53     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 236  007a ae0700        	ldw	x,#1792
 237  007d cd0000        	call	_CLK_PeripheralClockConfig
 239                     ; 54     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 241  0080 ae0500        	ldw	x,#1280
 242  0083 cd0000        	call	_CLK_PeripheralClockConfig
 244                     ; 55     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 246  0086 ae0400        	ldw	x,#1024
 247  0089 cd0000        	call	_CLK_PeripheralClockConfig
 249                     ; 56 }
 252  008c 81            	ret
 277                     ; 58 void GPIO_setup(void) {
 278                     	switch	.text
 279  008d               _GPIO_setup:
 283                     ; 59     GPIO_DeInit(GPIOB);
 285  008d ae5005        	ldw	x,#20485
 286  0090 cd0000        	call	_GPIO_DeInit
 288                     ; 60     GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_IN_FL_NO_IT);
 290  0093 4b00          	push	#0
 291  0095 4b20          	push	#32
 292  0097 ae5005        	ldw	x,#20485
 293  009a cd0000        	call	_GPIO_Init
 295  009d 85            	popw	x
 296                     ; 61     GPIO_Init(GPIOB, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 298  009e 4b00          	push	#0
 299  00a0 4b40          	push	#64
 300  00a2 ae5005        	ldw	x,#20485
 301  00a5 cd0000        	call	_GPIO_Init
 303  00a8 85            	popw	x
 304                     ; 62 }
 307  00a9 81            	ret
 333                     ; 64 void ADC2_setup(void) {
 334                     	switch	.text
 335  00aa               _ADC2_setup:
 339                     ; 65     ADC2_DeInit();
 341  00aa cd0000        	call	_ADC2_DeInit
 343                     ; 67     ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS,
 343                     ; 68               ADC2_CHANNEL_5,
 343                     ; 69               ADC2_PRESSEL_FCPU_D2,
 343                     ; 70               ADC2_EXTTRIG_GPIO,
 343                     ; 71               DISABLE,
 343                     ; 72               ADC2_ALIGN_RIGHT,
 343                     ; 73               ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6,
 343                     ; 74               DISABLE);
 345  00ad 4b00          	push	#0
 346  00af 4b07          	push	#7
 347  00b1 4b08          	push	#8
 348  00b3 4b00          	push	#0
 349  00b5 4b01          	push	#1
 350  00b7 4b00          	push	#0
 351  00b9 ae0105        	ldw	x,#261
 352  00bc cd0000        	call	_ADC2_Init
 354  00bf 5b06          	addw	sp,#6
 355                     ; 76     ADC2_Cmd(ENABLE);
 357  00c1 a601          	ld	a,#1
 358  00c3 cd0000        	call	_ADC2_Cmd
 360                     ; 77 }
 363  00c6 81            	ret
 411                     ; 79 unsigned int read_ADC_Channel(uint8_t channel) {
 412                     	switch	.text
 413  00c7               _read_ADC_Channel:
 415  00c7 89            	pushw	x
 416       00000002      OFST:	set	2
 419                     ; 80     unsigned int adcValue = 0;
 421                     ; 83     ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS,
 421                     ; 84                           channel,
 421                     ; 85                           ADC2_ALIGN_RIGHT);
 423  00c8 4b08          	push	#8
 424  00ca ae0100        	ldw	x,#256
 425  00cd 97            	ld	xl,a
 426  00ce cd0000        	call	_ADC2_ConversionConfig
 428  00d1 84            	pop	a
 429                     ; 88     ADC2_StartConversion();
 431  00d2 cd0000        	call	_ADC2_StartConversion
 434  00d5               L321:
 435                     ; 91     while (ADC2_GetFlagStatus() == RESET);
 437  00d5 cd0000        	call	_ADC2_GetFlagStatus
 439  00d8 4d            	tnz	a
 440  00d9 27fa          	jreq	L321
 441                     ; 94     adcValue = ADC2_GetConversionValue();
 443  00db cd0000        	call	_ADC2_GetConversionValue
 445  00de 1f01          	ldw	(OFST-1,sp),x
 447                     ; 97     ADC2_ClearFlag();
 449  00e0 cd0000        	call	_ADC2_ClearFlag
 451                     ; 99     return adcValue;
 453  00e3 1e01          	ldw	x,(OFST-1,sp)
 456  00e5 5b02          	addw	sp,#2
 457  00e7 81            	ret
 483                     ; 102 void UART3_setup(void) {
 484                     	switch	.text
 485  00e8               _UART3_setup:
 489                     ; 103     UART3_DeInit();
 491  00e8 cd0000        	call	_UART3_DeInit
 493                     ; 106     UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
 493                     ; 107                UART3_MODE_TX_ENABLE);
 495  00eb 4b04          	push	#4
 496  00ed 4b00          	push	#0
 497  00ef 4b00          	push	#0
 498  00f1 4b00          	push	#0
 499  00f3 ae2580        	ldw	x,#9600
 500  00f6 89            	pushw	x
 501  00f7 ae0000        	ldw	x,#0
 502  00fa 89            	pushw	x
 503  00fb cd0000        	call	_UART3_Init
 505  00fe 5b08          	addw	sp,#8
 506                     ; 109     UART3_Cmd(ENABLE);  // Enable UART3
 508  0100 a601          	ld	a,#1
 509  0102 cd0000        	call	_UART3_Cmd
 511                     ; 110 }
 514  0105 81            	ret
 550                     ; 112 PUTCHAR_PROTOTYPE {
 551                     	switch	.text
 552  0106               _putchar:
 554  0106 88            	push	a
 555       00000000      OFST:	set	0
 558                     ; 114     UART3_SendData8(c);
 560  0107 cd0000        	call	_UART3_SendData8
 563  010a               L751:
 564                     ; 117     while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);
 566  010a ae0080        	ldw	x,#128
 567  010d cd0000        	call	_UART3_GetFlagStatus
 569  0110 4d            	tnz	a
 570  0111 27f7          	jreq	L751
 571                     ; 119     return (c);
 573  0113 7b01          	ld	a,(OFST+1,sp)
 576  0115 5b01          	addw	sp,#1
 577  0117 81            	ret
 590                     	xdef	_main
 591                     	xdef	_read_ADC_Channel
 592                     	xdef	_UART3_setup
 593                     	xdef	_ADC2_setup
 594                     	xdef	_GPIO_setup
 595                     	xdef	_clock_setup
 596                     	xref	_UART3_GetFlagStatus
 597                     	xref	_UART3_SendData8
 598                     	xref	_UART3_Cmd
 599                     	xref	_UART3_Init
 600                     	xref	_UART3_DeInit
 601                     	xref	_GPIO_Init
 602                     	xref	_GPIO_DeInit
 603                     	xref	_CLK_GetFlagStatus
 604                     	xref	_CLK_SYSCLKConfig
 605                     	xref	_CLK_HSIPrescalerConfig
 606                     	xref	_CLK_ClockSwitchConfig
 607                     	xref	_CLK_PeripheralClockConfig
 608                     	xref	_CLK_ClockSwitchCmd
 609                     	xref	_CLK_LSICmd
 610                     	xref	_CLK_HSICmd
 611                     	xref	_CLK_HSECmd
 612                     	xref	_CLK_DeInit
 613                     	xref	_ADC2_ClearFlag
 614                     	xref	_ADC2_GetFlagStatus
 615                     	xref	_ADC2_GetConversionValue
 616                     	xref	_ADC2_StartConversion
 617                     	xref	_ADC2_ConversionConfig
 618                     	xref	_ADC2_Cmd
 619                     	xref	_ADC2_Init
 620                     	xref	_ADC2_DeInit
 621                     	xdef	_putchar
 622                     	xref	_printf
 623                     .const:	section	.text
 624  0000               L73:
 625  0000 416463205661  	dc.b	"Adc Value 0: %d  A"
 626  0012 64632056616c  	dc.b	"dc Value 1: %d",10,0
 646                     	end
