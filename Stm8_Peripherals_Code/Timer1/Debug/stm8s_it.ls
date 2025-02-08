   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  17                     	bsct
  18  0000               _last_capture:
  19  0000 00000000      	dc.l	0
  20  0004               _prescaling_factor:
  21  0004 0001          	dc.w	1
  22  0006               _i:
  23  0006 00000000      	dc.l	0
  24  000a               _j:
  25  000a 00000000      	dc.l	0
  58                     ; 46 void TIM1_UPD_IRQHandler(void) 
  58                     ; 47 {
  59                     	switch	.text
  60  0000               f_TIM1_UPD_IRQHandler:
  62  0000 8a            	push	cc
  63  0001 84            	pop	a
  64  0002 a4bf          	and	a,#191
  65  0004 88            	push	a
  66  0005 86            	pop	cc
  67  0006 3b0002        	push	c_x+2
  68  0009 be00          	ldw	x,c_x
  69  000b 89            	pushw	x
  70  000c 3b0002        	push	c_y+2
  71  000f be00          	ldw	x,c_y
  72  0011 89            	pushw	x
  75                     ; 48 	overflow_count++;
  77  0012 be00          	ldw	x,_overflow_count
  78  0014 5c            	incw	x
  79  0015 bf00          	ldw	_overflow_count,x
  80                     ; 49 	TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
  82  0017 a601          	ld	a,#1
  83  0019 8d000000      	callf	f_TIM1_ClearITPendingBit
  85                     ; 50 	TIM1_ClearFlag(TIM1_FLAG_UPDATE);
  87  001d ae0001        	ldw	x,#1
  88  0020 8d000000      	callf	f_TIM1_ClearFlag
  90                     ; 51 }
  93  0024 85            	popw	x
  94  0025 bf00          	ldw	c_y,x
  95  0027 320002        	pop	c_y+2
  96  002a 85            	popw	x
  97  002b bf00          	ldw	c_x,x
  98  002d 320002        	pop	c_x+2
  99  0030 80            	iret	
 133                     .const:	section	.text
 134  0000               L61:
 135  0000 00000406      	dc.l	1030
 136                     ; 54 void TIM1_CH1_CCP_IRQHandler(void) 
 136                     ; 55 {
 137                     	switch	.text
 138  0031               f_TIM1_CH1_CCP_IRQHandler:
 140  0031 8a            	push	cc
 141  0032 84            	pop	a
 142  0033 a4bf          	and	a,#191
 143  0035 88            	push	a
 144  0036 86            	pop	cc
 145       00000004      OFST:	set	4
 146  0037 3b0002        	push	c_x+2
 147  003a be00          	ldw	x,c_x
 148  003c 89            	pushw	x
 149  003d 3b0002        	push	c_y+2
 150  0040 be00          	ldw	x,c_y
 151  0042 89            	pushw	x
 152  0043 be02          	ldw	x,c_lreg+2
 153  0045 89            	pushw	x
 154  0046 be00          	ldw	x,c_lreg
 155  0048 89            	pushw	x
 156  0049 5204          	subw	sp,#4
 159                     ; 56 	end_time = TIM1_GetCapture1();
 161  004b 8d000000      	callf	f_TIM1_GetCapture1
 163  004f 8d000000      	callf	d_uitolx
 165  0053 ae0000        	ldw	x,#_end_time
 166  0056 8d000000      	callf	d_rtol
 168                     ; 57 	pulse_ticks = ((overflow_count << 16) - start_time + end_time);
 170  005a be02          	ldw	x,_start_time+2
 171  005c 50            	negw	x
 172  005d 72bb0002      	addw	x,_end_time+2
 173  0061 bf00          	ldw	_pulse_ticks,x
 174                     ; 58 	start_time = end_time;
 176  0063 be02          	ldw	x,_end_time+2
 177  0065 bf02          	ldw	_start_time+2,x
 178  0067 be00          	ldw	x,_end_time
 179  0069 bf00          	ldw	_start_time,x
 180                     ; 59 	overflow_count = 0;
 182  006b 5f            	clrw	x
 183  006c bf00          	ldw	_overflow_count,x
 184                     ; 60 	frequency = (10000.0 / pulse_ticks); // Calculate frequency in Hz
 186  006e be00          	ldw	x,_pulse_ticks
 187  0070 8d000000      	callf	d_uitof
 189  0074 96            	ldw	x,sp
 190  0075 5c            	incw	x
 191  0076 8d000000      	callf	d_rtol
 194  007a ae0004        	ldw	x,#L53
 195  007d 8d000000      	callf	d_ltor
 197  0081 96            	ldw	x,sp
 198  0082 5c            	incw	x
 199  0083 8d000000      	callf	d_fdiv
 201  0087 ae0000        	ldw	x,#_frequency
 202  008a 8d000000      	callf	d_rtol
 204                     ; 62 	if (frequency <= set_frequency) {
 206  008e 8d000000      	callf	d_ltor
 208  0092 ae0000        	ldw	x,#_set_frequency
 209  0095 8d000000      	callf	d_fcmp
 211  0099 2c06          	jrsgt	L14
 212                     ; 63 		state = 1;
 214  009b 35010000      	mov	_state,#1
 216  009f 2002          	jra	L34
 217  00a1               L14:
 218                     ; 66 		state = 0;
 220  00a1 3f00          	clr	_state
 221  00a3               L34:
 222                     ; 68   if (state == 1) {
 224  00a3 b600          	ld	a,_state
 225  00a5 4a            	dec	a
 226  00a6 2623          	jrne	L54
 227                     ; 69 		GPIOC->ODR |= (uint8_t)GPIO_PIN_2; // Send pulse
 229  00a8 7214500a      	bset	20490,#2
 230                     ; 70 		for(i = 0; i < 1030; i++)
 232  00ac 5f            	clrw	x
 233  00ad bf08          	ldw	_i+2,x
 234  00af bf06          	ldw	_i,x
 235  00b1               L74:
 238  00b1 ae0006        	ldw	x,#_i
 239  00b4 a601          	ld	a,#1
 240  00b6 8d000000      	callf	d_lgadc
 244  00ba 8d000000      	callf	d_ltor
 246  00be ae0000        	ldw	x,#L61
 247  00c1 8d000000      	callf	d_lcmp
 249  00c5 25ea          	jrult	L74
 250                     ; 74 		GPIOC->ODR &= (uint8_t)(~GPIO_PIN_2);
 252  00c7 7215500a      	bres	20490,#2
 253  00cb               L54:
 254                     ; 77 	TIM1_ClearITPendingBit(TIM1_IT_CC1);
 256  00cb a602          	ld	a,#2
 257  00cd 8d000000      	callf	f_TIM1_ClearITPendingBit
 259                     ; 78 	TIM1_ClearFlag(TIM1_FLAG_CC1);
 261  00d1 ae0002        	ldw	x,#2
 262  00d4 8d000000      	callf	f_TIM1_ClearFlag
 264                     ; 79 }
 267  00d8 5b04          	addw	sp,#4
 268  00da 85            	popw	x
 269  00db bf00          	ldw	c_lreg,x
 270  00dd 85            	popw	x
 271  00de bf02          	ldw	c_lreg+2,x
 272  00e0 85            	popw	x
 273  00e1 bf00          	ldw	c_y,x
 274  00e3 320002        	pop	c_y+2
 275  00e6 85            	popw	x
 276  00e7 bf00          	ldw	c_x,x
 277  00e9 320002        	pop	c_x+2
 278  00ec 80            	iret	
 301                     ; 104 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
 301                     ; 105 {
 302                     	switch	.text
 303  00ed               f_NonHandledInterrupt:
 307                     ; 109 }
 310  00ed 80            	iret	
 332                     ; 117 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
 332                     ; 118 {
 333                     	switch	.text
 334  00ee               f_TRAP_IRQHandler:
 338                     ; 122 }
 341  00ee 80            	iret	
 363                     ; 128 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 363                     ; 129 {
 364                     	switch	.text
 365  00ef               f_TLI_IRQHandler:
 369                     ; 133 }
 372  00ef 80            	iret	
 394                     ; 140 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 394                     ; 141 {
 395                     	switch	.text
 396  00f0               f_AWU_IRQHandler:
 400                     ; 145 }
 403  00f0 80            	iret	
 425                     ; 152 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 425                     ; 153 {
 426                     	switch	.text
 427  00f1               f_CLK_IRQHandler:
 431                     ; 157 }
 434  00f1 80            	iret	
 457                     ; 164 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 457                     ; 165 {
 458                     	switch	.text
 459  00f2               f_EXTI_PORTA_IRQHandler:
 463                     ; 169 }
 466  00f2 80            	iret	
 489                     ; 176 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 489                     ; 177 {
 490                     	switch	.text
 491  00f3               f_EXTI_PORTB_IRQHandler:
 495                     ; 181 }
 498  00f3 80            	iret	
 521                     ; 188 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 521                     ; 189 {
 522                     	switch	.text
 523  00f4               f_EXTI_PORTC_IRQHandler:
 527                     ; 193 }
 530  00f4 80            	iret	
 553                     ; 200 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 553                     ; 201 {
 554                     	switch	.text
 555  00f5               f_EXTI_PORTD_IRQHandler:
 559                     ; 205 }
 562  00f5 80            	iret	
 585                     ; 212 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 585                     ; 213 {
 586                     	switch	.text
 587  00f6               f_EXTI_PORTE_IRQHandler:
 591                     ; 217 }
 594  00f6 80            	iret	
 616                     ; 238  INTERRUPT_HANDLER(CAN_RX_IRQHandler, 8)
 616                     ; 239 {
 617                     	switch	.text
 618  00f7               f_CAN_RX_IRQHandler:
 622                     ; 243 }
 625  00f7 80            	iret	
 647                     ; 250  INTERRUPT_HANDLER(CAN_TX_IRQHandler, 9)
 647                     ; 251 {
 648                     	switch	.text
 649  00f8               f_CAN_TX_IRQHandler:
 653                     ; 255 }
 656  00f8 80            	iret	
 678                     ; 263 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 678                     ; 264 {
 679                     	switch	.text
 680  00f9               f_SPI_IRQHandler:
 684                     ; 268 }
 687  00f9 80            	iret	
 710                     ; 275 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 710                     ; 276 {
 711                     	switch	.text
 712  00fa               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 716                     ; 280 }
 719  00fa 80            	iret	
 742                     ; 287 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 742                     ; 288 {
 743                     	switch	.text
 744  00fb               f_TIM1_CAP_COM_IRQHandler:
 748                     ; 292 }
 751  00fb 80            	iret	
 774                     ; 324  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 774                     ; 325 {
 775                     	switch	.text
 776  00fc               f_TIM2_UPD_OVF_BRK_IRQHandler:
 780                     ; 329 }
 783  00fc 80            	iret	
 806                     ; 336  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 806                     ; 337 {
 807                     	switch	.text
 808  00fd               f_TIM2_CAP_COM_IRQHandler:
 812                     ; 341 }
 815  00fd 80            	iret	
 838                     ; 351  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 838                     ; 352 {
 839                     	switch	.text
 840  00fe               f_TIM3_UPD_OVF_BRK_IRQHandler:
 844                     ; 356 }
 847  00fe 80            	iret	
 870                     ; 363  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 870                     ; 364 {
 871                     	switch	.text
 872  00ff               f_TIM3_CAP_COM_IRQHandler:
 876                     ; 368 }
 879  00ff 80            	iret	
 902                     ; 378  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 902                     ; 379 {
 903                     	switch	.text
 904  0100               f_UART1_TX_IRQHandler:
 908                     ; 383 }
 911  0100 80            	iret	
 934                     ; 390  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 934                     ; 391 {
 935                     	switch	.text
 936  0101               f_UART1_RX_IRQHandler:
 940                     ; 395 }
 943  0101 80            	iret	
 965                     ; 403 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 965                     ; 404 {
 966                     	switch	.text
 967  0102               f_I2C_IRQHandler:
 971                     ; 408 }
 974  0102 80            	iret	
 997                     ; 442  INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
 997                     ; 443 {
 998                     	switch	.text
 999  0103               f_UART3_TX_IRQHandler:
1003                     ; 447   }
1006  0103 80            	iret	
1029                     ; 454  INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
1029                     ; 455 {
1030                     	switch	.text
1031  0104               f_UART3_RX_IRQHandler:
1035                     ; 459   }
1038  0104 80            	iret	
1060                     ; 468  INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
1060                     ; 469 {
1061                     	switch	.text
1062  0105               f_ADC2_IRQHandler:
1066                     ; 474     return;
1069  0105 80            	iret	
1092                     ; 512  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1092                     ; 513 {
1093                     	switch	.text
1094  0106               f_TIM4_UPD_OVF_IRQHandler:
1098                     ; 517 }
1101  0106 80            	iret	
1124                     ; 525 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1124                     ; 526 {
1125                     	switch	.text
1126  0107               f_EEPROM_EEC_IRQHandler:
1130                     ; 530 }
1133  0107 80            	iret	
1183                     	xdef	_j
1184                     	xdef	_i
1185                     	xref.b	_set_frequency
1186                     	xref.b	_state
1187                     	xref.b	_frequency
1188                     	xdef	_prescaling_factor
1189                     	xdef	_last_capture
1190                     	xref.b	_end_time
1191                     	xref.b	_start_time
1192                     	xref.b	_pulse_ticks
1193                     	xref.b	_overflow_count
1194                     	xdef	f_EEPROM_EEC_IRQHandler
1195                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1196                     	xdef	f_ADC2_IRQHandler
1197                     	xdef	f_UART3_TX_IRQHandler
1198                     	xdef	f_UART3_RX_IRQHandler
1199                     	xdef	f_I2C_IRQHandler
1200                     	xdef	f_UART1_RX_IRQHandler
1201                     	xdef	f_UART1_TX_IRQHandler
1202                     	xdef	f_TIM3_CAP_COM_IRQHandler
1203                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1204                     	xdef	f_TIM2_CAP_COM_IRQHandler
1205                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1206                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1207                     	xdef	f_TIM1_CAP_COM_IRQHandler
1208                     	xdef	f_SPI_IRQHandler
1209                     	xdef	f_CAN_TX_IRQHandler
1210                     	xdef	f_CAN_RX_IRQHandler
1211                     	xdef	f_EXTI_PORTE_IRQHandler
1212                     	xdef	f_EXTI_PORTD_IRQHandler
1213                     	xdef	f_EXTI_PORTC_IRQHandler
1214                     	xdef	f_EXTI_PORTB_IRQHandler
1215                     	xdef	f_EXTI_PORTA_IRQHandler
1216                     	xdef	f_CLK_IRQHandler
1217                     	xdef	f_AWU_IRQHandler
1218                     	xdef	f_TLI_IRQHandler
1219                     	xdef	f_TRAP_IRQHandler
1220                     	xdef	f_NonHandledInterrupt
1221                     	xdef	f_TIM1_CH1_CCP_IRQHandler
1222                     	xdef	f_TIM1_UPD_IRQHandler
1223                     	xref	f_TIM1_ClearITPendingBit
1224                     	xref	f_TIM1_ClearFlag
1225                     	xref	f_TIM1_GetCapture1
1226                     	switch	.const
1227  0004               L53:
1228  0004 461c4000      	dc.w	17948,16384
1229                     	xref.b	c_lreg
1230                     	xref.b	c_x
1231                     	xref.b	c_y
1251                     	xref	d_lcmp
1252                     	xref	d_lgadc
1253                     	xref	d_fcmp
1254                     	xref	d_fdiv
1255                     	xref	d_uitof
1256                     	xref	d_ltor
1257                     	xref	d_rtol
1258                     	xref	d_uitolx
1259                     	end
