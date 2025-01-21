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
  88                     ; 18 void main()
  88                     ; 19 {
  90                     	switch	.text
  91  0000               _main:
  93  0000 5208          	subw	sp,#8
  94       00000008      OFST:	set	8
  97                     ; 21 	GPIO_setup();
  99  0002 ad3d          	call	_GPIO_setup
 101                     ; 22 	clock_setup();
 103  0004 ad4d          	call	_clock_setup
 105  0006               L33:
 106                     ; 25 		lastTime = micros();
 108  0006 cd0000        	call	_micros
 110  0009 96            	ldw	x,sp
 111  000a 1c0005        	addw	x,#OFST-3
 112  000d cd0000        	call	c_rtol
 115                     ; 26 		value++;
 117  0010 be00          	ldw	x,_value
 118  0012 1c0001        	addw	x,#1
 119  0015 bf00          	ldw	_value,x
 120                     ; 27     GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
 122  0017 4b08          	push	#8
 123  0019 ae500a        	ldw	x,#20490
 124  001c cd0000        	call	_GPIO_WriteHigh
 126  001f 84            	pop	a
 127                     ; 28 		delay_ms(1000);
 129  0020 ae03e8        	ldw	x,#1000
 130  0023 cd0000        	call	_delay_ms
 132                     ; 29 		GPIO_WriteLow(GPIOC, GPIO_PIN_3);
 134  0026 4b08          	push	#8
 135  0028 ae500a        	ldw	x,#20490
 136  002b cd0000        	call	_GPIO_WriteLow
 138  002e 84            	pop	a
 139                     ; 30 		delay_ms(1000);
 141  002f ae03e8        	ldw	x,#1000
 142  0032 cd0000        	call	_delay_ms
 144                     ; 31 		currentTime = micros() - lastTime; 
 146  0035 cd0000        	call	_micros
 148  0038 96            	ldw	x,sp
 149  0039 1c0005        	addw	x,#OFST-3
 150  003c cd0000        	call	c_lsub
 153  003f 20c5          	jra	L33
 178                     ; 35 void GPIO_setup(void)
 178                     ; 36 {
 179                     	switch	.text
 180  0041               _GPIO_setup:
 184                     ; 37      GPIO_DeInit(GPIOC);
 186  0041 ae500a        	ldw	x,#20490
 187  0044 cd0000        	call	_GPIO_DeInit
 189                     ; 38      GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST);
 191  0047 4bf0          	push	#240
 192  0049 4b08          	push	#8
 193  004b ae500a        	ldw	x,#20490
 194  004e cd0000        	call	_GPIO_Init
 196  0051 85            	popw	x
 197                     ; 42 }
 200  0052 81            	ret
 233                     ; 45 void clock_setup(void)
 233                     ; 46 {
 234                     	switch	.text
 235  0053               _clock_setup:
 239                     ; 47      CLK_DeInit();
 241  0053 cd0000        	call	_CLK_DeInit
 243                     ; 49      CLK_HSECmd(ENABLE);
 245  0056 a601          	ld	a,#1
 246  0058 cd0000        	call	_CLK_HSECmd
 248                     ; 50      CLK_LSICmd(DISABLE);
 250  005b 4f            	clr	a
 251  005c cd0000        	call	_CLK_LSICmd
 253                     ; 51      CLK_HSICmd(DISABLE);
 255  005f 4f            	clr	a
 256  0060 cd0000        	call	_CLK_HSICmd
 259  0063               L16:
 260                     ; 52      while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 262  0063 ae0102        	ldw	x,#258
 263  0066 cd0000        	call	_CLK_GetFlagStatus
 265  0069 4d            	tnz	a
 266  006a 27f7          	jreq	L16
 267                     ; 54      CLK_ClockSwitchCmd(ENABLE);
 269  006c a601          	ld	a,#1
 270  006e cd0000        	call	_CLK_ClockSwitchCmd
 272                     ; 55      CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV4);
 274  0071 a610          	ld	a,#16
 275  0073 cd0000        	call	_CLK_HSIPrescalerConfig
 277                     ; 56      CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 279  0076 a680          	ld	a,#128
 280  0078 cd0000        	call	_CLK_SYSCLKConfig
 282                     ; 57 		 CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 282                     ; 58      DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 284  007b 4b01          	push	#1
 285  007d 4b00          	push	#0
 286  007f ae01e1        	ldw	x,#481
 287  0082 cd0000        	call	_CLK_ClockSwitchConfig
 289  0085 85            	popw	x
 290                     ; 60      CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 292  0086 ae0100        	ldw	x,#256
 293  0089 cd0000        	call	_CLK_PeripheralClockConfig
 295                     ; 61      CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 297  008c 5f            	clrw	x
 298  008d cd0000        	call	_CLK_PeripheralClockConfig
 300                     ; 62      CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 302  0090 ae1300        	ldw	x,#4864
 303  0093 cd0000        	call	_CLK_PeripheralClockConfig
 305                     ; 63      CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 307  0096 ae1200        	ldw	x,#4608
 308  0099 cd0000        	call	_CLK_PeripheralClockConfig
 310                     ; 64      CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 312  009c ae0200        	ldw	x,#512
 313  009f cd0000        	call	_CLK_PeripheralClockConfig
 315                     ; 65      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 317  00a2 ae0700        	ldw	x,#1792
 318  00a5 cd0000        	call	_CLK_PeripheralClockConfig
 320                     ; 66      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 322  00a8 ae0500        	ldw	x,#1280
 323  00ab cd0000        	call	_CLK_PeripheralClockConfig
 325                     ; 68 }
 328  00ae 81            	ret
 380                     	xdef	_main
 381                     	xdef	_clock_setup
 382                     	xdef	_GPIO_setup
 383                     	xdef	_num
 384                     	xdef	_seg
 385                     	xdef	_n
 386                     	xdef	_value
 387                     	xref	_micros
 388                     	xref	_delay_ms
 389                     	xref	_GPIO_WriteLow
 390                     	xref	_GPIO_WriteHigh
 391                     	xref	_GPIO_Init
 392                     	xref	_GPIO_DeInit
 393                     	xref	_CLK_GetFlagStatus
 394                     	xref	_CLK_SYSCLKConfig
 395                     	xref	_CLK_HSIPrescalerConfig
 396                     	xref	_CLK_ClockSwitchConfig
 397                     	xref	_CLK_PeripheralClockConfig
 398                     	xref	_CLK_ClockSwitchCmd
 399                     	xref	_CLK_LSICmd
 400                     	xref	_CLK_HSICmd
 401                     	xref	_CLK_HSECmd
 402                     	xref	_CLK_DeInit
 421                     	xref	c_lsub
 422                     	xref	c_rtol
 423                     	end
