   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  82                     ; 13 void main()
  82                     ; 14 {
  84                     	switch	.text
  85  0000               _main:
  87  0000 520c          	subw	sp,#12
  88       0000000c      OFST:	set	12
  91                     ; 15 	clock_setup();
  93  0002 cd0087        	call	_clock_setup
  95                     ; 16 	TIM4_Config();
  97  0005 cd0000        	call	_TIM4_Config
  99                     ; 17   UART3_setup();
 101  0008 cd00f7        	call	_UART3_setup
 103                     ; 18   GPIO_DeInit(GPIOC);
 105  000b ae500a        	ldw	x,#20490
 106  000e cd0000        	call	_GPIO_DeInit
 108                     ; 19   GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 110  0011 4be0          	push	#224
 111  0013 4b08          	push	#8
 112  0015 ae500a        	ldw	x,#20490
 113  0018 cd0000        	call	_GPIO_Init
 115  001b 85            	popw	x
 116                     ; 20   printf("Initializing Uart Starting:\n\r");
 118  001c ae0033        	ldw	x,#L73
 119  001f cd0000        	call	_printf
 121  0022               L14:
 122                     ; 25 		start_time = micros();
 124  0022 cd0000        	call	_micros
 126  0025 96            	ldw	x,sp
 127  0026 1c0009        	addw	x,#OFST-3
 128  0029 cd0000        	call	c_rtol
 131                     ; 27 		GPIO_WriteLow(GPIOC, GPIO_PIN_3);
 133  002c 4b08          	push	#8
 134  002e ae500a        	ldw	x,#20490
 135  0031 cd0000        	call	_GPIO_WriteLow
 137  0034 84            	pop	a
 138                     ; 28 		delay_ms(1000);  // LED OFF for 100ms
 140  0035 ae03e8        	ldw	x,#1000
 141  0038 cd0000        	call	_delay_ms
 143                     ; 29 		GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
 145  003b 4b08          	push	#8
 146  003d ae500a        	ldw	x,#20490
 147  0040 cd0000        	call	_GPIO_WriteHigh
 149  0043 84            	pop	a
 150                     ; 30 		delay_ms(1000);  // LED ON for 100ms
 152  0044 ae03e8        	ldw	x,#1000
 153  0047 cd0000        	call	_delay_ms
 155                     ; 31 		currentTime = micros();
 157  004a cd0000        	call	_micros
 159  004d 96            	ldw	x,sp
 160  004e 1c0005        	addw	x,#OFST-7
 161  0051 cd0000        	call	c_rtol
 164                     ; 32 		LoopTime = elapsedTime(start_time, currentTime);
 166  0054 1e07          	ldw	x,(OFST-5,sp)
 167  0056 89            	pushw	x
 168  0057 1e07          	ldw	x,(OFST-5,sp)
 169  0059 89            	pushw	x
 170  005a 1e0f          	ldw	x,(OFST+3,sp)
 171  005c 89            	pushw	x
 172  005d 1e0f          	ldw	x,(OFST+3,sp)
 173  005f 89            	pushw	x
 174  0060 ad64          	call	_elapsedTime
 176  0062 5b08          	addw	sp,#8
 177  0064 96            	ldw	x,sp
 178  0065 1c0001        	addw	x,#OFST-11
 179  0068 cd0000        	call	c_rtol
 182                     ; 33 		printf("currentTime: %lu   starTime: %lu   Loop Time: %lu\n", currentTime,
 182                     ; 34 					 start_time, LoopTime);
 184  006b 1e03          	ldw	x,(OFST-9,sp)
 185  006d 89            	pushw	x
 186  006e 1e03          	ldw	x,(OFST-9,sp)
 187  0070 89            	pushw	x
 188  0071 1e0f          	ldw	x,(OFST+3,sp)
 189  0073 89            	pushw	x
 190  0074 1e0f          	ldw	x,(OFST+3,sp)
 191  0076 89            	pushw	x
 192  0077 1e0f          	ldw	x,(OFST+3,sp)
 193  0079 89            	pushw	x
 194  007a 1e0f          	ldw	x,(OFST+3,sp)
 195  007c 89            	pushw	x
 196  007d ae0000        	ldw	x,#L54
 197  0080 cd0000        	call	_printf
 199  0083 5b0c          	addw	sp,#12
 200                     ; 35 		start_time = 0;
 203  0085 209b          	jra	L14
 236                     ; 40 void clock_setup(void) {
 237                     	switch	.text
 238  0087               _clock_setup:
 242                     ; 41   CLK_DeInit();
 244  0087 cd0000        	call	_CLK_DeInit
 246                     ; 42   CLK_HSECmd(DISABLE);
 248  008a 4f            	clr	a
 249  008b cd0000        	call	_CLK_HSECmd
 251                     ; 43   CLK_LSICmd(DISABLE);
 253  008e 4f            	clr	a
 254  008f cd0000        	call	_CLK_LSICmd
 256                     ; 44   CLK_HSICmd(ENABLE);
 258  0092 a601          	ld	a,#1
 259  0094 cd0000        	call	_CLK_HSICmd
 262  0097               L16:
 263                     ; 45   while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 265  0097 ae0102        	ldw	x,#258
 266  009a cd0000        	call	_CLK_GetFlagStatus
 268  009d 4d            	tnz	a
 269  009e 27f7          	jreq	L16
 270                     ; 47   CLK_ClockSwitchCmd(ENABLE);
 272  00a0 a601          	ld	a,#1
 273  00a2 cd0000        	call	_CLK_ClockSwitchCmd
 275                     ; 48   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 277  00a5 4f            	clr	a
 278  00a6 cd0000        	call	_CLK_HSIPrescalerConfig
 280                     ; 49   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 282  00a9 a680          	ld	a,#128
 283  00ab cd0000        	call	_CLK_SYSCLKConfig
 285                     ; 51   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
 285                     ; 52                         CLK_CURRENTCLOCKSTATE_ENABLE);
 287  00ae 4b01          	push	#1
 288  00b0 4b00          	push	#0
 289  00b2 ae01e1        	ldw	x,#481
 290  00b5 cd0000        	call	_CLK_ClockSwitchConfig
 292  00b8 85            	popw	x
 293                     ; 54   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 295  00b9 ae0401        	ldw	x,#1025
 296  00bc cd0000        	call	_CLK_PeripheralClockConfig
 298                     ; 55   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 300  00bf ae0301        	ldw	x,#769
 301  00c2 cd0000        	call	_CLK_PeripheralClockConfig
 303                     ; 59 }
 306  00c5 81            	ret
 349                     ; 61 uint32_t elapsedTime(uint32_t start, uint32_t end) {
 350                     	switch	.text
 351  00c6               _elapsedTime:
 353       00000000      OFST:	set	0
 356                     ; 62   if (end >= start) 
 358  00c6 96            	ldw	x,sp
 359  00c7 1c0007        	addw	x,#OFST+7
 360  00ca cd0000        	call	c_ltor
 362  00cd 96            	ldw	x,sp
 363  00ce 1c0003        	addw	x,#OFST+3
 364  00d1 cd0000        	call	c_lcmp
 366  00d4 250f          	jrult	L701
 367                     ; 65     return end - start;
 369  00d6 96            	ldw	x,sp
 370  00d7 1c0007        	addw	x,#OFST+7
 371  00da cd0000        	call	c_ltor
 373  00dd 96            	ldw	x,sp
 374  00de 1c0003        	addw	x,#OFST+3
 375  00e1 cd0000        	call	c_lsub
 379  00e4 81            	ret
 380  00e5               L701:
 381                     ; 69     return (0xffffffff - start + 1) + end;
 383  00e5 96            	ldw	x,sp
 384  00e6 1c0003        	addw	x,#OFST+3
 385  00e9 cd0000        	call	c_ltor
 387  00ec cd0000        	call	c_lneg
 389  00ef 96            	ldw	x,sp
 390  00f0 1c0007        	addw	x,#OFST+7
 391  00f3 cd0000        	call	c_ladd
 395  00f6 81            	ret
 421                     ; 74 void UART3_setup(void) {
 422                     	switch	.text
 423  00f7               _UART3_setup:
 427                     ; 75   UART3_DeInit();
 429  00f7 cd0000        	call	_UART3_DeInit
 431                     ; 78   UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
 431                     ; 79              UART3_MODE_TX_ENABLE);
 433  00fa 4b04          	push	#4
 434  00fc 4b00          	push	#0
 435  00fe 4b00          	push	#0
 436  0100 4b00          	push	#0
 437  0102 ae2580        	ldw	x,#9600
 438  0105 89            	pushw	x
 439  0106 ae0000        	ldw	x,#0
 440  0109 89            	pushw	x
 441  010a cd0000        	call	_UART3_Init
 443  010d 5b08          	addw	sp,#8
 444                     ; 81   UART3_Cmd(ENABLE);  // Enable UART1
 446  010f a601          	ld	a,#1
 447  0111 cd0000        	call	_UART3_Cmd
 449                     ; 82 }
 452  0114 81            	ret
 488                     ; 84 PUTCHAR_PROTOTYPE {
 489                     	switch	.text
 490  0115               _putchar:
 492  0115 88            	push	a
 493       00000000      OFST:	set	0
 496                     ; 86   UART3_SendData8(c);
 498  0116 cd0000        	call	_UART3_SendData8
 501  0119               L341:
 502                     ; 88   while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);
 504  0119 ae0080        	ldw	x,#128
 505  011c cd0000        	call	_UART3_GetFlagStatus
 507  011f 4d            	tnz	a
 508  0120 27f7          	jreq	L341
 509                     ; 90   return (c);
 511  0122 7b01          	ld	a,(OFST+1,sp)
 514  0124 5b01          	addw	sp,#1
 515  0126 81            	ret
 528                     	xdef	_main
 529                     	xdef	_UART3_setup
 530                     	xdef	_elapsedTime
 531                     	xdef	_clock_setup
 532                     	xref	_micros
 533                     	xref	_delay_ms
 534                     	xref	_TIM4_Config
 535                     	xdef	_putchar
 536                     	xref	_printf
 537                     	xref	_UART3_GetFlagStatus
 538                     	xref	_UART3_SendData8
 539                     	xref	_UART3_Cmd
 540                     	xref	_UART3_Init
 541                     	xref	_UART3_DeInit
 542                     	xref	_GPIO_WriteLow
 543                     	xref	_GPIO_WriteHigh
 544                     	xref	_GPIO_Init
 545                     	xref	_GPIO_DeInit
 546                     	xref	_CLK_GetFlagStatus
 547                     	xref	_CLK_SYSCLKConfig
 548                     	xref	_CLK_HSIPrescalerConfig
 549                     	xref	_CLK_ClockSwitchConfig
 550                     	xref	_CLK_PeripheralClockConfig
 551                     	xref	_CLK_ClockSwitchCmd
 552                     	xref	_CLK_LSICmd
 553                     	xref	_CLK_HSICmd
 554                     	xref	_CLK_HSECmd
 555                     	xref	_CLK_DeInit
 556                     .const:	section	.text
 557  0000               L54:
 558  0000 63757272656e  	dc.b	"currentTime: %lu  "
 559  0012 207374617254  	dc.b	" starTime: %lu   L"
 560  0024 6f6f70205469  	dc.b	"oop Time: %lu",10,0
 561  0033               L73:
 562  0033 496e69746961  	dc.b	"Initializing Uart "
 563  0045 537461727469  	dc.b	"Starting:",10
 564  004f 0d00          	dc.b	13,0
 584                     	xref	c_ladd
 585                     	xref	c_lneg
 586                     	xref	c_lsub
 587                     	xref	c_lcmp
 588                     	xref	c_ltor
 589                     	xref	c_rtol
 590                     	end
