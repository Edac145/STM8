   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	switch	.data
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
 143                     ; 42 	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 145  0042 a601          	ld	a,#1
 146  0044 8d000000      	callf	f_TIM4_ClearITPendingBit
 148                     ; 44 }
 151  0048 85            	popw	x
 152  0049 bf00          	ldw	c_y,x
 153  004b 320002        	pop	c_y+2
 154  004e 85            	popw	x
 155  004f bf00          	ldw	c_x,x
 156  0051 320002        	pop	c_x+2
 157  0054 80            	iret
 196                     ; 47 void delay_ms(uint16_t ms)
 196                     ; 48 {
 197                     	switch	.text
 198  0055               f_delay_ms:
 200  0055 89            	pushw	x
 201  0056 89            	pushw	x
 202       00000002      OFST:	set	2
 205                     ; 49 	int i = 0;
 207                     ; 50 	for(i=0; i<ms; i++)
 209  0057 5f            	clrw	x
 210  0058 1f01          	ldw	(OFST-1,sp),x
 213  005a 200e          	jra	L35
 214  005c               L74:
 215                     ; 51 		delay_us(1000);
 217  005c ae03e8        	ldw	x,#1000
 218  005f 8d730073      	callf	f_delay_us
 220                     ; 50 	for(i=0; i<ms; i++)
 222  0063 1e01          	ldw	x,(OFST-1,sp)
 223  0065 1c0001        	addw	x,#1
 224  0068 1f01          	ldw	(OFST-1,sp),x
 226  006a               L35:
 229  006a 1e01          	ldw	x,(OFST-1,sp)
 230  006c 1303          	cpw	x,(OFST+1,sp)
 231  006e 25ec          	jrult	L74
 232                     ; 52 }
 235  0070 5b04          	addw	sp,#4
 236  0072 87            	retf
 290                     ; 58 void delay_us(uint16_t us)
 290                     ; 59 {
 291                     	switch	.text
 292  0073               f_delay_us:
 294  0073 89            	pushw	x
 295  0074 5205          	subw	sp,#5
 296       00000005      OFST:	set	5
 299                     ; 60 	uint8_t start_us = TIM4_GetCounter();  //tim4 increments every us
 301  0076 8d000000      	callf	f_TIM4_GetCounter
 303  007a 6b05          	ld	(OFST+0,sp),a
 305                     ; 61 	if(us>=250){   //we only need to bother with the following for delays greater than 1 tick (250us)
 307  007c 1e06          	ldw	x,(OFST+1,sp)
 308  007e a300fa        	cpw	x,#250
 309  0081 2516          	jrult	L511
 310                     ; 62 		uint16_t start_tick = (uint16_t)tick;  //the tick increments every 250us
 312  0083 ce0002        	ldw	x,_tick+2
 313  0086 1f01          	ldw	(OFST-4,sp),x
 315                     ; 63 		uint16_t delay_ticks = us/250;
 317  0088 1e06          	ldw	x,(OFST+1,sp)
 318  008a a6fa          	ld	a,#250
 319  008c 62            	div	x,a
 320  008d 1f03          	ldw	(OFST-2,sp),x
 323  008f               L701:
 324                     ; 65 		while(((uint16_t)tick - start_tick) < delay_ticks); // delay in multiples of 250us
 326  008f ce0002        	ldw	x,_tick+2
 327  0092 72f001        	subw	x,(OFST-4,sp)
 328  0095 1303          	cpw	x,(OFST-2,sp)
 329  0097 25f6          	jrult	L701
 330  0099               L511:
 331                     ; 67 	while(TIM4_GetCounter() < start_us); //now wait until our 1us counter matches our start us
 333  0099 8d000000      	callf	f_TIM4_GetCounter
 335  009d 1105          	cp	a,(OFST+0,sp)
 336  009f 25f8          	jrult	L511
 337                     ; 68 }
 340  00a1 5b07          	addw	sp,#7
 341  00a3 87            	retf
 364                     ; 71 uint16_t millis(void){
 365                     	switch	.text
 366  00a4               f_millis:
 370                     ; 72 	return((uint16_t)(tick >> 2)); // divide tick by 4 returns milliseconds
 372  00a4 ae0000        	ldw	x,#_tick
 373  00a7 8d000000      	callf	d_ltor
 375  00ab a602          	ld	a,#2
 376  00ad 8d000000      	callf	d_lursh
 378  00b1 be02          	ldw	x,c_lreg+2
 381  00b3 87            	retf
 405                     ; 76 uint32_t micros(void){
 406                     	switch	.text
 407  00b4               f_micros:
 411                     ; 77 	return(tick*250 + TIM4_GetCounter()); //each tick is worth 250us
 413  00b4 8d000000      	callf	f_TIM4_GetCounter
 415  00b8 88            	push	a
 416  00b9 ae0000        	ldw	x,#_tick
 417  00bc 8d000000      	callf	d_ltor
 419  00c0 a6fa          	ld	a,#250
 420  00c2 8d000000      	callf	d_smul
 422  00c6 84            	pop	a
 423  00c7 8d000000      	callf	d_ladc
 427  00cb 87            	retf
 450                     	xdef	f_micros
 451                     	xdef	f_millis
 452                     	xdef	f_delay_us
 453                     	xdef	f_delay_ms
 454                     	xdef	f_TIM4_Config
 455                     	xdef	f_TIM4_IRQHandler
 456                     	xdef	_tick
 457                     	xref	f_TIM4_ClearITPendingBit
 458                     	xref	f_TIM4_ClearFlag
 459                     	xref	f_TIM4_GetCounter
 460                     	xref	f_TIM4_ITConfig
 461                     	xref	f_TIM4_Cmd
 462                     	xref	f_TIM4_TimeBaseInit
 463                     	xref	f_TIM4_DeInit
 464                     	xref	f_CLK_PeripheralClockConfig
 465                     	xref.b	c_lreg
 466                     	xref.b	c_x
 467                     	xref.b	c_y
 486                     	xref	d_ladc
 487                     	xref	d_smul
 488                     	xref	d_lursh
 489                     	xref	d_ltor
 490                     	xref	d_lgadc
 491                     	end
