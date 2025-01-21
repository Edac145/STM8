   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _tick:
  16  0000 00000000      	dc.l	0
  52                     ; 25 void TIM4_Config(void)
  52                     ; 26 {
  54                     	switch	.text
  55  0000               _TIM4_Config:
  59                     ; 27 	CLK_PeripheralClockConfig (CLK_PERIPHERAL_TIMER4 , ENABLE); 
  61  0000 ae0401        	ldw	x,#1025
  62  0003 cd0000        	call	_CLK_PeripheralClockConfig
  64                     ; 29 	TIM4_DeInit();
  66  0006 cd0000        	call	_TIM4_DeInit
  68                     ; 30 	TIM4_TimeBaseInit(TIM4_PRESCALER_16, 250); //TimerClock = 16000000 / 16 / 250 = 4000Hz
  70  0009 ae04fa        	ldw	x,#1274
  71  000c cd0000        	call	_TIM4_TimeBaseInit
  73                     ; 31 	TIM4_ClearFlag(TIM4_FLAG_UPDATE);
  75  000f a601          	ld	a,#1
  76  0011 cd0000        	call	_TIM4_ClearFlag
  78                     ; 32 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
  80  0014 ae0101        	ldw	x,#257
  81  0017 cd0000        	call	_TIM4_ITConfig
  83                     ; 34 	enableInterrupts(); // global interrupt enable
  86  001a 9a            rim
  88                     ; 35 	TIM4_Cmd(ENABLE);  //Start Timer 4
  91  001b a601          	ld	a,#1
  92  001d cd0000        	call	_TIM4_Cmd
  94                     ; 36 }
  97  0020 81            	ret
 124                     ; 39 void TIM4_UPD_IRQHandler(void) // now compiles w/SDCC 4.3.0. not tested for function, yet
 124                     ; 40 {
 126                     	switch	.text
 127  0021               f_TIM4_UPD_IRQHandler:
 129  0021 8a            	push	cc
 130  0022 84            	pop	a
 131  0023 a4bf          	and	a,#191
 132  0025 88            	push	a
 133  0026 86            	pop	cc
 134  0027 3b0002        	push	c_x+2
 135  002a be00          	ldw	x,c_x
 136  002c 89            	pushw	x
 137  002d 3b0002        	push	c_y+2
 138  0030 be00          	ldw	x,c_y
 139  0032 89            	pushw	x
 142                     ; 41 	tick++;
 144  0033 ae0000        	ldw	x,#_tick
 145  0036 a601          	ld	a,#1
 146  0038 cd0000        	call	c_lgadc
 148                     ; 42 	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 150  003b a601          	ld	a,#1
 151  003d cd0000        	call	_TIM4_ClearITPendingBit
 153                     ; 43 	GPIO_WriteReverse(TICK_PIN);            //toggle our systick pin (should be about 2kHz)
 155  0040 4b20          	push	#32
 156  0042 ae500f        	ldw	x,#20495
 157  0045 cd0000        	call	_GPIO_WriteReverse
 159  0048 84            	pop	a
 160                     ; 44 }
 163  0049 85            	popw	x
 164  004a bf00          	ldw	c_y,x
 165  004c 320002        	pop	c_y+2
 166  004f 85            	popw	x
 167  0050 bf00          	ldw	c_x,x
 168  0052 320002        	pop	c_x+2
 169  0055 80            	iret
 212                     ; 47 void delay_ms(uint16_t ms)
 212                     ; 48 {
 214                     	switch	.text
 215  0056               _delay_ms:
 217  0056 89            	pushw	x
 218  0057 89            	pushw	x
 219       00000002      OFST:	set	2
 222                     ; 50     for(i = 0; i < ms; i++)
 224  0058 5f            	clrw	x
 225  0059 1f01          	ldw	(OFST-1,sp),x
 228  005b 200c          	jra	L75
 229  005d               L35:
 230                     ; 52         delay_us(1000);
 232  005d ae03e8        	ldw	x,#1000
 233  0060 ad10          	call	_delay_us
 235                     ; 50     for(i = 0; i < ms; i++)
 237  0062 1e01          	ldw	x,(OFST-1,sp)
 238  0064 1c0001        	addw	x,#1
 239  0067 1f01          	ldw	(OFST-1,sp),x
 241  0069               L75:
 244  0069 1e01          	ldw	x,(OFST-1,sp)
 245  006b 1303          	cpw	x,(OFST+1,sp)
 246  006d 25ee          	jrult	L35
 247                     ; 55 }
 250  006f 5b04          	addw	sp,#4
 251  0071 81            	ret
 314                     ; 61 void delay_us(uint16_t us)
 314                     ; 62 {
 315                     	switch	.text
 316  0072               _delay_us:
 318  0072 89            	pushw	x
 319  0073 5205          	subw	sp,#5
 320       00000005      OFST:	set	5
 323                     ; 63 	uint8_t start_us = TIM4_GetCounter();  //tim4 increments every us
 325  0075 cd0000        	call	_TIM4_GetCounter
 327  0078 6b05          	ld	(OFST+0,sp),a
 329                     ; 64 	if(us>=250){   //we only need to bother with the following for delays greater than 1 tick (250us)
 331  007a 1e06          	ldw	x,(OFST+1,sp)
 332  007c a300fa        	cpw	x,#250
 333  007f 2514          	jrult	L131
 334                     ; 65 		uint16_t start_tick = (uint16_t)tick;  //the tick increments every 250us
 336  0081 be02          	ldw	x,_tick+2
 337  0083 1f01          	ldw	(OFST-4,sp),x
 339                     ; 66 		uint16_t delay_ticks = us/250;
 341  0085 1e06          	ldw	x,(OFST+1,sp)
 342  0087 a6fa          	ld	a,#250
 343  0089 62            	div	x,a
 344  008a 1f03          	ldw	(OFST-2,sp),x
 347  008c               L321:
 348                     ; 68 		while(((uint16_t)tick - start_tick) < delay_ticks); // delay in multiples of 250us
 350  008c be02          	ldw	x,_tick+2
 351  008e 72f001        	subw	x,(OFST-4,sp)
 352  0091 1303          	cpw	x,(OFST-2,sp)
 353  0093 25f7          	jrult	L321
 354  0095               L131:
 355                     ; 70 	while(TIM4_GetCounter() < start_us); //now wait until our 1us counter matches our start us
 357  0095 cd0000        	call	_TIM4_GetCounter
 359  0098 1105          	cp	a,(OFST+0,sp)
 360  009a 25f9          	jrult	L131
 361                     ; 71 }
 364  009c 5b07          	addw	sp,#7
 365  009e 81            	ret
 389                     ; 74 uint16_t millis(void){
 390                     	switch	.text
 391  009f               _millis:
 395                     ; 75 	return((uint16_t)(tick >> 2)); // divide tick by 4 returns milliseconds
 397  009f ae0000        	ldw	x,#_tick
 398  00a2 cd0000        	call	c_ltor
 400  00a5 a602          	ld	a,#2
 401  00a7 cd0000        	call	c_lursh
 403  00aa be02          	ldw	x,c_lreg+2
 406  00ac 81            	ret
 431                     ; 79 uint32_t micros(void){
 432                     	switch	.text
 433  00ad               _micros:
 437                     ; 80 	return(tick*250 + TIM4_GetCounter()); //each tick is worth 250us
 439  00ad cd0000        	call	_TIM4_GetCounter
 441  00b0 88            	push	a
 442  00b1 ae0000        	ldw	x,#_tick
 443  00b4 cd0000        	call	c_ltor
 445  00b7 a6fa          	ld	a,#250
 446  00b9 cd0000        	call	c_smul
 448  00bc 84            	pop	a
 449  00bd cd0000        	call	c_ladc
 453  00c0 81            	ret
 477                     	xdef	_micros
 478                     	xdef	_millis
 479                     	xdef	_delay_us
 480                     	xdef	_delay_ms
 481                     	xdef	_TIM4_Config
 482                     	xdef	_tick
 483                     	xdef	f_TIM4_UPD_IRQHandler
 484                     	xref	_TIM4_ClearITPendingBit
 485                     	xref	_TIM4_ClearFlag
 486                     	xref	_TIM4_GetCounter
 487                     	xref	_TIM4_ITConfig
 488                     	xref	_TIM4_Cmd
 489                     	xref	_TIM4_TimeBaseInit
 490                     	xref	_TIM4_DeInit
 491                     	xref	_GPIO_WriteReverse
 492                     	xref	_CLK_PeripheralClockConfig
 493                     	xref.b	c_lreg
 494                     	xref.b	c_x
 495                     	xref.b	c_y
 514                     	xref	c_ladc
 515                     	xref	c_smul
 516                     	xref	c_lursh
 517                     	xref	c_ltor
 518                     	xref	c_lgadc
 519                     	end
