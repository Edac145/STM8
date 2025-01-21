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
 122                     ; 39 @far @interrupt void TIM4_IRQHandler(void)// now compiles w/SDCC 4.3.0. not tested for function, yet
 122                     ; 40 {
 124                     	switch	.text
 125  0021               f_TIM4_IRQHandler:
 127  0021 8a            	push	cc
 128  0022 84            	pop	a
 129  0023 a4bf          	and	a,#191
 130  0025 88            	push	a
 131  0026 86            	pop	cc
 132  0027 3b0002        	push	c_x+2
 133  002a be00          	ldw	x,c_x
 134  002c 89            	pushw	x
 135  002d 3b0002        	push	c_y+2
 136  0030 be00          	ldw	x,c_y
 137  0032 89            	pushw	x
 140                     ; 41 	tick++;
 142  0033 ae0000        	ldw	x,#_tick
 143  0036 a601          	ld	a,#1
 144  0038 cd0000        	call	c_lgadc
 146                     ; 42 	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 148  003b a601          	ld	a,#1
 149  003d cd0000        	call	_TIM4_ClearITPendingBit
 151                     ; 44 }
 154  0040 85            	popw	x
 155  0041 bf00          	ldw	c_y,x
 156  0043 320002        	pop	c_y+2
 157  0046 85            	popw	x
 158  0047 bf00          	ldw	c_x,x
 159  0049 320002        	pop	c_x+2
 160  004c 80            	iret
 203                     ; 47 void delay_ms(uint16_t ms)
 203                     ; 48 {
 205                     	switch	.text
 206  004d               _delay_ms:
 208  004d 89            	pushw	x
 209  004e 89            	pushw	x
 210       00000002      OFST:	set	2
 213                     ; 49 	int i = 0;
 215                     ; 50 	for(i=0; i<ms; i++)
 217  004f 5f            	clrw	x
 218  0050 1f01          	ldw	(OFST-1,sp),x
 221  0052 200c          	jra	L75
 222  0054               L35:
 223                     ; 51 		delay_us(1000);
 225  0054 ae03e8        	ldw	x,#1000
 226  0057 ad10          	call	_delay_us
 228                     ; 50 	for(i=0; i<ms; i++)
 230  0059 1e01          	ldw	x,(OFST-1,sp)
 231  005b 1c0001        	addw	x,#1
 232  005e 1f01          	ldw	(OFST-1,sp),x
 234  0060               L75:
 237  0060 1e01          	ldw	x,(OFST-1,sp)
 238  0062 1303          	cpw	x,(OFST+1,sp)
 239  0064 25ee          	jrult	L35
 240                     ; 52 }
 243  0066 5b04          	addw	sp,#4
 244  0068 81            	ret
 307                     ; 58 void delay_us(uint16_t us)
 307                     ; 59 {
 308                     	switch	.text
 309  0069               _delay_us:
 311  0069 89            	pushw	x
 312  006a 5205          	subw	sp,#5
 313       00000005      OFST:	set	5
 316                     ; 60 	uint8_t start_us = TIM4_GetCounter();  //tim4 increments every us
 318  006c cd0000        	call	_TIM4_GetCounter
 320  006f 6b05          	ld	(OFST+0,sp),a
 322                     ; 61 	if(us>=250){   //we only need to bother with the following for delays greater than 1 tick (250us)
 324  0071 1e06          	ldw	x,(OFST+1,sp)
 325  0073 a300fa        	cpw	x,#250
 326  0076 2514          	jrult	L131
 327                     ; 62 		uint16_t start_tick = (uint16_t)tick;  //the tick increments every 250us
 329  0078 be02          	ldw	x,_tick+2
 330  007a 1f01          	ldw	(OFST-4,sp),x
 332                     ; 63 		uint16_t delay_ticks = us/250;
 334  007c 1e06          	ldw	x,(OFST+1,sp)
 335  007e a6fa          	ld	a,#250
 336  0080 62            	div	x,a
 337  0081 1f03          	ldw	(OFST-2,sp),x
 340  0083               L321:
 341                     ; 65 		while(((uint16_t)tick - start_tick) < delay_ticks); // delay in multiples of 250us
 343  0083 be02          	ldw	x,_tick+2
 344  0085 72f001        	subw	x,(OFST-4,sp)
 345  0088 1303          	cpw	x,(OFST-2,sp)
 346  008a 25f7          	jrult	L321
 347  008c               L131:
 348                     ; 67 	while(TIM4_GetCounter() < start_us); //now wait until our 1us counter matches our start us
 350  008c cd0000        	call	_TIM4_GetCounter
 352  008f 1105          	cp	a,(OFST+0,sp)
 353  0091 25f9          	jrult	L131
 354                     ; 68 }
 357  0093 5b07          	addw	sp,#7
 358  0095 81            	ret
 382                     ; 71 uint16_t millis(void){
 383                     	switch	.text
 384  0096               _millis:
 388                     ; 72 	return((uint16_t)(tick >> 2)); // divide tick by 4 returns milliseconds
 390  0096 ae0000        	ldw	x,#_tick
 391  0099 cd0000        	call	c_ltor
 393  009c a602          	ld	a,#2
 394  009e cd0000        	call	c_lursh
 396  00a1 be02          	ldw	x,c_lreg+2
 399  00a3 81            	ret
 424                     ; 76 uint32_t micros(void){
 425                     	switch	.text
 426  00a4               _micros:
 430                     ; 77 	return(tick*250 + TIM4_GetCounter()); //each tick is worth 250us
 432  00a4 cd0000        	call	_TIM4_GetCounter
 434  00a7 88            	push	a
 435  00a8 ae0000        	ldw	x,#_tick
 436  00ab cd0000        	call	c_ltor
 438  00ae a6fa          	ld	a,#250
 439  00b0 cd0000        	call	c_smul
 441  00b3 84            	pop	a
 442  00b4 cd0000        	call	c_ladc
 446  00b7 81            	ret
 470                     	xdef	_micros
 471                     	xdef	_millis
 472                     	xdef	_delay_us
 473                     	xdef	_delay_ms
 474                     	xdef	_TIM4_Config
 475                     	xdef	f_TIM4_IRQHandler
 476                     	xdef	_tick
 477                     	xref	_TIM4_ClearITPendingBit
 478                     	xref	_TIM4_ClearFlag
 479                     	xref	_TIM4_GetCounter
 480                     	xref	_TIM4_ITConfig
 481                     	xref	_TIM4_Cmd
 482                     	xref	_TIM4_TimeBaseInit
 483                     	xref	_TIM4_DeInit
 484                     	xref	_CLK_PeripheralClockConfig
 485                     	xref.b	c_lreg
 486                     	xref.b	c_x
 487                     	xref.b	c_y
 506                     	xref	c_ladc
 507                     	xref	c_smul
 508                     	xref	c_lursh
 509                     	xref	c_ltor
 510                     	xref	c_lgadc
 511                     	end
