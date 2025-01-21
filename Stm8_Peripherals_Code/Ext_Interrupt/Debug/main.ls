   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _state:
  16  0000 00            	dc.b	0
  45                     ; 15 void main()
  45                     ; 16 {
  47                     	switch	.text
  48  0000               _main:
  52  0000               L12:
  53                     ; 17 	while (1);
  55  0000 20fe          	jra	L12
  80                     ; 20 void GPIO_setup(void)
  80                     ; 21 {
  81                     	switch	.text
  82  0002               _GPIO_setup:
  86                     ; 22     GPIO_DeInit(GPIOB);    
  88  0002 ae5005        	ldw	x,#20485
  89  0005 cd0000        	call	_GPIO_DeInit
  91                     ; 23     GPIO_Init(GPIOB, GPIO_PIN_7, GPIO_MODE_IN_PU_IT);
  93  0008 4b60          	push	#96
  94  000a 4b80          	push	#128
  95  000c ae5005        	ldw	x,#20485
  96  000f cd0000        	call	_GPIO_Init
  98  0012 85            	popw	x
  99                     ; 25     GPIO_DeInit(GPIOD);
 101  0013 ae500f        	ldw	x,#20495
 102  0016 cd0000        	call	_GPIO_DeInit
 104                     ; 26     GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
 106  0019 4be0          	push	#224
 107  001b 4b01          	push	#1
 108  001d ae500f        	ldw	x,#20495
 109  0020 cd0000        	call	_GPIO_Init
 111  0023 85            	popw	x
 112                     ; 27 }
 115  0024 81            	ret
 144                     ; 30 void EXTI_setup(void)
 144                     ; 31 {
 145                     	switch	.text
 146  0025               _EXTI_setup:
 150                     ; 32     ITC_DeInit();
 152  0025 cd0000        	call	_ITC_DeInit
 154                     ; 33     ITC_SetSoftwarePriority(ITC_IRQ_PORTB, ITC_PRIORITYLEVEL_0);
 156  0028 ae0402        	ldw	x,#1026
 157  002b cd0000        	call	_ITC_SetSoftwarePriority
 159                     ; 35     EXTI_DeInit();
 161  002e cd0000        	call	_EXTI_DeInit
 163                     ; 36     EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOB, EXTI_SENSITIVITY_FALL_ONLY);
 165  0031 ae0102        	ldw	x,#258
 166  0034 cd0000        	call	_EXTI_SetExtIntSensitivity
 168                     ; 37     EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);
 170  0037 4f            	clr	a
 171  0038 cd0000        	call	_EXTI_SetTLISensitivity
 173                     ; 39     enableInterrupts();
 176  003b 9a            rim
 178                     ; 40 }
 182  003c 81            	ret
 215                     ; 43 void clock_setup(void)
 215                     ; 44 {
 216                     	switch	.text
 217  003d               _clock_setup:
 221                     ; 45     CLK_DeInit();
 223  003d cd0000        	call	_CLK_DeInit
 225                     ; 47     CLK_HSECmd(DISABLE);
 227  0040 4f            	clr	a
 228  0041 cd0000        	call	_CLK_HSECmd
 230                     ; 48     CLK_LSICmd(DISABLE);
 232  0044 4f            	clr	a
 233  0045 cd0000        	call	_CLK_LSICmd
 235                     ; 49     CLK_HSICmd(ENABLE);
 237  0048 a601          	ld	a,#1
 238  004a cd0000        	call	_CLK_HSICmd
 241  004d               L75:
 242                     ; 50     while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 244  004d ae0102        	ldw	x,#258
 245  0050 cd0000        	call	_CLK_GetFlagStatus
 247  0053 4d            	tnz	a
 248  0054 27f7          	jreq	L75
 249                     ; 52     CLK_ClockSwitchCmd(ENABLE);
 251  0056 a601          	ld	a,#1
 252  0058 cd0000        	call	_CLK_ClockSwitchCmd
 254                     ; 53     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 256  005b 4f            	clr	a
 257  005c cd0000        	call	_CLK_HSIPrescalerConfig
 259                     ; 54     CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 261  005f a680          	ld	a,#128
 262  0061 cd0000        	call	_CLK_SYSCLKConfig
 264                     ; 56     CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 264                     ; 57     DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 266  0064 4b01          	push	#1
 267  0066 4b00          	push	#0
 268  0068 ae01e1        	ldw	x,#481
 269  006b cd0000        	call	_CLK_ClockSwitchConfig
 271  006e 85            	popw	x
 272                     ; 59     CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 274  006f ae0100        	ldw	x,#256
 275  0072 cd0000        	call	_CLK_PeripheralClockConfig
 277                     ; 60     CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 279  0075 5f            	clrw	x
 280  0076 cd0000        	call	_CLK_PeripheralClockConfig
 282                     ; 61     CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 284  0079 ae1300        	ldw	x,#4864
 285  007c cd0000        	call	_CLK_PeripheralClockConfig
 287                     ; 62     CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 289  007f ae1200        	ldw	x,#4608
 290  0082 cd0000        	call	_CLK_PeripheralClockConfig
 292                     ; 63     CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 294  0085 ae0200        	ldw	x,#512
 295  0088 cd0000        	call	_CLK_PeripheralClockConfig
 297                     ; 64     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 299  008b ae0700        	ldw	x,#1792
 300  008e cd0000        	call	_CLK_PeripheralClockConfig
 302                     ; 65     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 304  0091 ae0500        	ldw	x,#1280
 305  0094 cd0000        	call	_CLK_PeripheralClockConfig
 307                     ; 66     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 309  0097 ae0400        	ldw	x,#1024
 310  009a cd0000        	call	_CLK_PeripheralClockConfig
 312                     ; 67 }
 315  009d 81            	ret
 360                     	xdef	_main
 361                     	xdef	_clock_setup
 362                     	xdef	_EXTI_setup
 363                     	xdef	_GPIO_setup
 364                     	xdef	_state
 365                     	xref	_ITC_SetSoftwarePriority
 366                     	xref	_ITC_DeInit
 367                     	xref	_GPIO_Init
 368                     	xref	_GPIO_DeInit
 369                     	xref	_EXTI_SetTLISensitivity
 370                     	xref	_EXTI_SetExtIntSensitivity
 371                     	xref	_EXTI_DeInit
 372                     	xref	_CLK_GetFlagStatus
 373                     	xref	_CLK_SYSCLKConfig
 374                     	xref	_CLK_HSIPrescalerConfig
 375                     	xref	_CLK_ClockSwitchConfig
 376                     	xref	_CLK_PeripheralClockConfig
 377                     	xref	_CLK_ClockSwitchCmd
 378                     	xref	_CLK_LSICmd
 379                     	xref	_CLK_HSICmd
 380                     	xref	_CLK_HSECmd
 381                     	xref	_CLK_DeInit
 400                     	end
