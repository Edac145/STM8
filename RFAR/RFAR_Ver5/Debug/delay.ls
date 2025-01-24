   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  17                     	bsct
  18  0000               _tick:
  19  0000 00000000      	dc.l	0
  55                     ; 25 void TIM4_Config(void)
  55                     ; 26 {
  56                     	switch	.text
  57  0000               f_TIM4_Config:
  61                     ; 27 	CLK_PeripheralClockConfig (CLK_PERIPHERAL_TIMER4 , ENABLE); 
  63  0000 ae0401        	ldw	x,#1025
  64  0003 8d000000      	callf	f_CLK_PeripheralClockConfig
  66                     ; 29 	TIM4_DeInit();
  68  0007 8d000000      	callf	f_TIM4_DeInit
  70                     ; 30 	TIM4_TimeBaseInit(TIM4_PRESCALER_16, 250); //TimerClock = 16000000 / 16 / 250 = 4000Hz
  72  000b ae04fa        	ldw	x,#1274
  73  000e 8d000000      	callf	f_TIM4_TimeBaseInit
  75                     ; 31 	TIM4_ClearFlag(TIM4_FLAG_UPDATE);
  77  0012 a601          	ld	a,#1
  78  0014 8d000000      	callf	f_TIM4_ClearFlag
  80                     ; 32 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
  82  0018 ae0101        	ldw	x,#257
  83  001b 8d000000      	callf	f_TIM4_ITConfig
  85                     ; 34 	enableInterrupts(); // global interrupt enable
  88  001f 9a            	rim	
  90                     ; 35 	TIM4_Cmd(ENABLE);  //Start Timer 4
  93  0020 a601          	ld	a,#1
  95                     ; 36 }
  98  0022 ac000000      	jpf	f_TIM4_Cmd
 122                     ; 39 @far @interrupt void TIM4_IRQHandler(void)// now compiles w/SDCC 4.3.0. not tested for function, yet
 122                     ; 40 {
 123                     	switch	.text
 124  0026               f_TIM4_IRQHandler:
 126  0026 8a            	push	cc
 127  0027 84            	pop	a
 128  0028 a4bf          	and	a,#191
 129  002a 88            	push	a
 130  002b 86            	pop	cc
 131  002c 3b0002        	push	c_x+2
 132  002f be00          	ldw	x,c_x
 133  0031 89            	pushw	x
 134  0032 3b0002        	push	c_y+2
 135  0035 be00          	ldw	x,c_y
 136  0037 89            	pushw	x
 139                     ; 41 	tick++;
 141  0038 ae0000        	ldw	x,#_tick
 142  003b a601          	ld	a,#1
 143  003d 8d000000      	callf	d_lgadc
 145                     ; 42 	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 147  0041 a601          	ld	a,#1
 148  0043 8d000000      	callf	f_TIM4_ClearITPendingBit
 150                     ; 44 }
 153  0047 85            	popw	x
 154  0048 bf00          	ldw	c_y,x
 155  004a 320002        	pop	c_y+2
 156  004d 85            	popw	x
 157  004e bf00          	ldw	c_x,x
 158  0050 320002        	pop	c_x+2
 159  0053 80            	iret	
 202                     ; 47 void delay_ms(uint16_t ms)
 202                     ; 48 {
 203                     	switch	.text
 204  0054               f_delay_ms:
 206  0054 89            	pushw	x
 207  0055 89            	pushw	x
 208       00000002      OFST:	set	2
 211                     ; 49 	int i = 0;
 213                     ; 50 	for(i=0; i<ms; i++)
 215  0056 5f            	clrw	x
 217  0057 200a          	jra	L75
 218  0059               L35:
 219                     ; 51 		delay_us(1000);
 221  0059 ae03e8        	ldw	x,#1000
 222  005c 8d6c006c      	callf	f_delay_us
 224                     ; 50 	for(i=0; i<ms; i++)
 226  0060 1e01          	ldw	x,(OFST-1,sp)
 227  0062 5c            	incw	x
 228  0063               L75:
 229  0063 1f01          	ldw	(OFST-1,sp),x
 233  0065 1303          	cpw	x,(OFST+1,sp)
 234  0067 25f0          	jrult	L35
 235                     ; 52 }
 238  0069 5b04          	addw	sp,#4
 239  006b 87            	retf	
 301                     ; 58 void delay_us(uint16_t us)
 301                     ; 59 {
 302                     	switch	.text
 303  006c               f_delay_us:
 305  006c 89            	pushw	x
 306  006d 5205          	subw	sp,#5
 307       00000005      OFST:	set	5
 310                     ; 60 	uint8_t start_us = TIM4_GetCounter();  //tim4 increments every us
 312  006f 8d000000      	callf	f_TIM4_GetCounter
 314  0073 6b05          	ld	(OFST+0,sp),a
 316                     ; 61 	if(us>=250){   //we only need to bother with the following for delays greater than 1 tick (250us)
 318  0075 1e06          	ldw	x,(OFST+1,sp)
 319  0077 a300fa        	cpw	x,#250
 320  007a 2514          	jrult	L131
 321                     ; 62 		uint16_t start_tick = (uint16_t)tick;  //the tick increments every 250us
 323  007c be02          	ldw	x,_tick+2
 324  007e 1f01          	ldw	(OFST-4,sp),x
 326                     ; 63 		uint16_t delay_ticks = us/250;
 328  0080 a6fa          	ld	a,#250
 329  0082 1e06          	ldw	x,(OFST+1,sp)
 330  0084 62            	div	x,a
 331  0085 1f03          	ldw	(OFST-2,sp),x
 334  0087               L321:
 335                     ; 65 		while(((uint16_t)tick - start_tick) < delay_ticks); // delay in multiples of 250us
 337  0087 be02          	ldw	x,_tick+2
 338  0089 72f001        	subw	x,(OFST-4,sp)
 339  008c 1303          	cpw	x,(OFST-2,sp)
 340  008e 25f7          	jrult	L321
 341  0090               L131:
 342                     ; 67 	while(TIM4_GetCounter() < start_us); //now wait until our 1us counter matches our start us
 344  0090 8d000000      	callf	f_TIM4_GetCounter
 346  0094 1105          	cp	a,(OFST+0,sp)
 347  0096 25f8          	jrult	L131
 348                     ; 68 }
 351  0098 5b07          	addw	sp,#7
 352  009a 87            	retf	
 375                     ; 71 uint16_t millis(void){
 376                     	switch	.text
 377  009b               f_millis:
 381                     ; 72 	return((uint16_t)(tick >> 2)); // divide tick by 4 returns milliseconds
 383  009b ae0000        	ldw	x,#_tick
 384  009e 8d000000      	callf	d_ltor
 386  00a2 a602          	ld	a,#2
 387  00a4 8d000000      	callf	d_lursh
 389  00a8 be02          	ldw	x,c_lreg+2
 392  00aa 87            	retf	
 416                     ; 76 uint32_t micros(void){
 417                     	switch	.text
 418  00ab               f_micros:
 422                     ; 77 	return(tick*250 + TIM4_GetCounter()); //each tick is worth 250us
 424  00ab 8d000000      	callf	f_TIM4_GetCounter
 426  00af 88            	push	a
 427  00b0 ae0000        	ldw	x,#_tick
 428  00b3 8d000000      	callf	d_ltor
 430  00b7 a6fa          	ld	a,#250
 431  00b9 8d000000      	callf	d_smul
 433  00bd 84            	pop	a
 437  00be ac000000      	jpf	d_ladc
 460                     	xdef	f_micros
 461                     	xdef	f_millis
 462                     	xdef	f_delay_us
 463                     	xdef	f_delay_ms
 464                     	xdef	f_TIM4_Config
 465                     	xdef	f_TIM4_IRQHandler
 466                     	xdef	_tick
 467                     	xref	f_TIM4_ClearITPendingBit
 468                     	xref	f_TIM4_ClearFlag
 469                     	xref	f_TIM4_GetCounter
 470                     	xref	f_TIM4_ITConfig
 471                     	xref	f_TIM4_Cmd
 472                     	xref	f_TIM4_TimeBaseInit
 473                     	xref	f_TIM4_DeInit
 474                     	xref	f_CLK_PeripheralClockConfig
 475                     	xref.b	c_lreg
 476                     	xref.b	c_x
 477                     	xref.b	c_y
 496                     	xref	d_ladc
 497                     	xref	d_smul
 498                     	xref	d_lursh
 499                     	xref	d_ltor
 500                     	xref	d_lgadc
 501                     	end
