   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _tick:
  16  0000 00000000      	dc.l	0
  52                     ; 25 void TIM4_Config(void)
  52                     ; 26 {
  53                     	switch	.text
  54  0000               f_TIM4_Config:
  58                     ; 27 	CLK_PeripheralClockConfig (CLK_PERIPHERAL_TIMER4 , ENABLE); 
  60  0000 ae0401        	ldw	x,#1025
  61  0003 8d000000      	callf	f_CLK_PeripheralClockConfig
  63                     ; 29 	TIM4_DeInit();
  65  0007 8d000000      	callf	f_TIM4_DeInit
  67                     ; 30 	TIM4_TimeBaseInit(TIM4_PRESCALER_16, 250); //TimerClock = 16000000 / 16 / 250 = 4000Hz
  69  000b ae04fa        	ldw	x,#1274
  70  000e 8d000000      	callf	f_TIM4_TimeBaseInit
  72                     ; 31 	TIM4_ClearFlag(TIM4_FLAG_UPDATE);
  74  0012 a601          	ld	a,#1
  75  0014 8d000000      	callf	f_TIM4_ClearFlag
  77                     ; 32 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
  79  0018 ae0101        	ldw	x,#257
  80  001b 8d000000      	callf	f_TIM4_ITConfig
  82                     ; 34 	enableInterrupts(); // global interrupt enable
  85  001f 9a            rim
  87                     ; 35 	TIM4_Cmd(ENABLE);  //Start Timer 4
  90  0020 a601          	ld	a,#1
  91  0022 8d000000      	callf	f_TIM4_Cmd
  93                     ; 36 }
  96  0026 87            	retf
 120                     ; 39 @far @interrupt void TIM4_IRQHandler(void)// now compiles w/SDCC 4.3.0. not tested for function, yet
 120                     ; 40 {
 121                     	switch	.text
 122  0027               f_TIM4_IRQHandler:
 124  0027 8a            	push	cc
 125  0028 84            	pop	a
 126  0029 a4bf          	and	a,#191
 127  002b 88            	push	a
 128  002c 86            	pop	cc
 129  002d 3b0002        	push	c_x+2
 130  0030 be00          	ldw	x,c_x
 131  0032 89            	pushw	x
 132  0033 3b0002        	push	c_y+2
 133  0036 be00          	ldw	x,c_y
 134  0038 89            	pushw	x
 137                     ; 41 	tick++;
 139  0039 ae0000        	ldw	x,#_tick
 140  003c a601          	ld	a,#1
 141  003e 8d000000      	callf	d_lgadc
 143                     ; 43 	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 145  0042 a601          	ld	a,#1
 146  0044 8d000000      	callf	f_TIM4_ClearITPendingBit
 148                     ; 45 }
 151  0048 85            	popw	x
 152  0049 bf00          	ldw	c_y,x
 153  004b 320002        	pop	c_y+2
 154  004e 85            	popw	x
 155  004f bf00          	ldw	c_x,x
 156  0051 320002        	pop	c_x+2
 157  0054 80            	iret
 200                     ; 48 void delay_ms(uint16_t ms)
 200                     ; 49 {
 201                     	switch	.text
 202  0055               f_delay_ms:
 204  0055 89            	pushw	x
 205  0056 89            	pushw	x
 206       00000002      OFST:	set	2
 209                     ; 50 	int i = 0;
 211                     ; 51 	for(i=0; i<ms; i++)
 213  0057 5f            	clrw	x
 214  0058 1f01          	ldw	(OFST-1,sp),x
 217  005a 200e          	jra	L75
 218  005c               L35:
 219                     ; 52 		delay_us(1000);
 221  005c ae03e8        	ldw	x,#1000
 222  005f 8d730073      	callf	f_delay_us
 224                     ; 51 	for(i=0; i<ms; i++)
 226  0063 1e01          	ldw	x,(OFST-1,sp)
 227  0065 1c0001        	addw	x,#1
 228  0068 1f01          	ldw	(OFST-1,sp),x
 230  006a               L75:
 233  006a 1e01          	ldw	x,(OFST-1,sp)
 234  006c 1303          	cpw	x,(OFST+1,sp)
 235  006e 25ec          	jrult	L35
 236                     ; 53 }
 239  0070 5b04          	addw	sp,#4
 240  0072 87            	retf
 302                     ; 59 void delay_us(uint16_t us)
 302                     ; 60 {
 303                     	switch	.text
 304  0073               f_delay_us:
 306  0073 89            	pushw	x
 307  0074 5205          	subw	sp,#5
 308       00000005      OFST:	set	5
 311                     ; 61 	uint8_t start_us = TIM4_GetCounter();  //tim4 increments every us
 313  0076 8d000000      	callf	f_TIM4_GetCounter
 315  007a 6b05          	ld	(OFST+0,sp),a
 317                     ; 62 	if(us>=250){   //we only need to bother with the following for delays greater than 1 tick (250us)
 319  007c 1e06          	ldw	x,(OFST+1,sp)
 320  007e a300fa        	cpw	x,#250
 321  0081 2514          	jrult	L131
 322                     ; 63 		uint16_t start_tick = (uint16_t)tick;  //the tick increments every 250us
 324  0083 be02          	ldw	x,_tick+2
 325  0085 1f01          	ldw	(OFST-4,sp),x
 327                     ; 64 		uint16_t delay_ticks = us/250;
 329  0087 1e06          	ldw	x,(OFST+1,sp)
 330  0089 a6fa          	ld	a,#250
 331  008b 62            	div	x,a
 332  008c 1f03          	ldw	(OFST-2,sp),x
 335  008e               L321:
 336                     ; 66 		while(((uint16_t)tick - start_tick) < delay_ticks); // delay in multiples of 250us
 338  008e be02          	ldw	x,_tick+2
 339  0090 72f001        	subw	x,(OFST-4,sp)
 340  0093 1303          	cpw	x,(OFST-2,sp)
 341  0095 25f7          	jrult	L321
 342  0097               L131:
 343                     ; 68 	while(TIM4_GetCounter() < start_us); //now wait until our 1us counter matches our start us
 345  0097 8d000000      	callf	f_TIM4_GetCounter
 347  009b 1105          	cp	a,(OFST+0,sp)
 348  009d 25f8          	jrult	L131
 349                     ; 69 }
 352  009f 5b07          	addw	sp,#7
 353  00a1 87            	retf
 376                     ; 72 uint16_t millis(void){
 377                     	switch	.text
 378  00a2               f_millis:
 382                     ; 73 	return((uint16_t)(tick >> 2)); // divide tick by 4 returns milliseconds
 384  00a2 ae0000        	ldw	x,#_tick
 385  00a5 8d000000      	callf	d_ltor
 387  00a9 a602          	ld	a,#2
 388  00ab 8d000000      	callf	d_lursh
 390  00af be02          	ldw	x,c_lreg+2
 393  00b1 87            	retf
 417                     ; 77 uint32_t micros(void){
 418                     	switch	.text
 419  00b2               f_micros:
 423                     ; 78 	return(tick*250 + TIM4_GetCounter()); //each tick is worth 250us
 425  00b2 8d000000      	callf	f_TIM4_GetCounter
 427  00b6 88            	push	a
 428  00b7 ae0000        	ldw	x,#_tick
 429  00ba 8d000000      	callf	d_ltor
 431  00be a6fa          	ld	a,#250
 432  00c0 8d000000      	callf	d_smul
 434  00c4 84            	pop	a
 435  00c5 8d000000      	callf	d_ladc
 439  00c9 87            	retf
 462                     	xdef	f_micros
 463                     	xdef	f_millis
 464                     	xdef	f_delay_us
 465                     	xdef	f_delay_ms
 466                     	xdef	f_TIM4_Config
 467                     	xdef	f_TIM4_IRQHandler
 468                     	xdef	_tick
 469                     	xref	f_TIM4_ClearITPendingBit
 470                     	xref	f_TIM4_ClearFlag
 471                     	xref	f_TIM4_GetCounter
 472                     	xref	f_TIM4_ITConfig
 473                     	xref	f_TIM4_Cmd
 474                     	xref	f_TIM4_TimeBaseInit
 475                     	xref	f_TIM4_DeInit
 476                     	xref	f_CLK_PeripheralClockConfig
 477                     	xref.b	c_lreg
 478                     	xref.b	c_x
 479                     	xref.b	c_y
 498                     	xref	d_ladc
 499                     	xref	d_smul
 500                     	xref	d_lursh
 501                     	xref	d_ltor
 502                     	xref	d_lgadc
 503                     	end
