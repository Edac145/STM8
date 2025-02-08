   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	switch	.data
  15  0000               _last_capture:
  16  0000 00000000      	dc.l	0
  17  0004               _prescaling_factor:
  18  0004 0001          	dc.w	1
  19  0006               _i:
  20  0006 00000000      	dc.l	0
  21  000a               _j:
  22  000a 00000000      	dc.l	0
  55                     ; 47 void TIM1_UPD_IRQHandler(void) 
  55                     ; 48 {
  56                     	switch	.text
  57  0000               f_TIM1_UPD_IRQHandler:
  59  0000 8a            	push	cc
  60  0001 84            	pop	a
  61  0002 a4bf          	and	a,#191
  62  0004 88            	push	a
  63  0005 86            	pop	cc
  64  0006 3b0002        	push	c_x+2
  65  0009 be00          	ldw	x,c_x
  66  000b 89            	pushw	x
  67  000c 3b0002        	push	c_y+2
  68  000f be00          	ldw	x,c_y
  69  0011 89            	pushw	x
  72                     ; 49 	overflow_count++;
  74  0012 ce0000        	ldw	x,_overflow_count
  75  0015 1c0001        	addw	x,#1
  76  0018 cf0000        	ldw	_overflow_count,x
  77                     ; 50 	TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
  79  001b a601          	ld	a,#1
  80  001d 8d000000      	callf	f_TIM1_ClearITPendingBit
  82                     ; 51 	TIM1_ClearFlag(TIM1_FLAG_UPDATE);
  84  0021 ae0001        	ldw	x,#1
  85  0024 8d000000      	callf	f_TIM1_ClearFlag
  87                     ; 52 }
  90  0028 85            	popw	x
  91  0029 bf00          	ldw	c_y,x
  92  002b 320002        	pop	c_y+2
  93  002e 85            	popw	x
  94  002f bf00          	ldw	c_x,x
  95  0031 320002        	pop	c_x+2
  96  0034 80            	iret
 133                     .const:	section	.text
 134  0000               L01:
 135  0000 00000406      	dc.l	1030
 136                     ; 55 void TIM1_CH1_CCP_IRQHandler(void) 
 136                     ; 56 {
 137                     	switch	.text
 138  0035               f_TIM1_CH1_CCP_IRQHandler:
 140  0035 8a            	push	cc
 141  0036 84            	pop	a
 142  0037 a4bf          	and	a,#191
 143  0039 88            	push	a
 144  003a 86            	pop	cc
 145       00000004      OFST:	set	4
 146  003b 3b0002        	push	c_x+2
 147  003e be00          	ldw	x,c_x
 148  0040 89            	pushw	x
 149  0041 3b0002        	push	c_y+2
 150  0044 be00          	ldw	x,c_y
 151  0046 89            	pushw	x
 152  0047 be02          	ldw	x,c_lreg+2
 153  0049 89            	pushw	x
 154  004a be00          	ldw	x,c_lreg
 155  004c 89            	pushw	x
 156  004d 5204          	subw	sp,#4
 159                     ; 57 	end_time = TIM1_GetCapture1();
 161  004f 8d000000      	callf	f_TIM1_GetCapture1
 163  0053 8d000000      	callf	d_uitolx
 165  0057 ae0000        	ldw	x,#_end_time
 166  005a 8d000000      	callf	d_rtol
 168                     ; 58 	pulse_ticks = ((overflow_count << 16) - start_time + end_time);
 170  005e ce0002        	ldw	x,_start_time+2
 171  0061 50            	negw	x
 172  0062 72bb0002      	addw	x,_end_time+2
 173  0066 cf0000        	ldw	_pulse_ticks,x
 174                     ; 59 	start_time = end_time;
 176  0069 ce0002        	ldw	x,_end_time+2
 177  006c cf0002        	ldw	_start_time+2,x
 178  006f ce0000        	ldw	x,_end_time
 179  0072 cf0000        	ldw	_start_time,x
 180                     ; 60 	overflow_count = 0;
 182  0075 5f            	clrw	x
 183  0076 cf0000        	ldw	_overflow_count,x
 184                     ; 61 	frequency = (10000.0 / pulse_ticks); // Calculate frequency in Hz
 186  0079 ce0000        	ldw	x,_pulse_ticks
 187  007c 8d000000      	callf	d_uitof
 189  0080 96            	ldw	x,sp
 190  0081 1c0001        	addw	x,#OFST-3
 191  0084 8d000000      	callf	d_rtol
 194  0088 ae0004        	ldw	x,#L53
 195  008b 8d000000      	callf	d_ltor
 197  008f 96            	ldw	x,sp
 198  0090 1c0001        	addw	x,#OFST-3
 199  0093 8d000000      	callf	d_fdiv
 201  0097 ae0000        	ldw	x,#_frequency
 202  009a 8d000000      	callf	d_rtol
 204                     ; 63 	if (frequency <= set_frequency) {
 206  009e 9c            	rvf
 207  009f ae0000        	ldw	x,#_frequency
 208  00a2 8d000000      	callf	d_ltor
 210  00a6 ae0000        	ldw	x,#_set_frequency
 211  00a9 8d000000      	callf	d_fcmp
 213  00ad 2c04          	jrsgt	L14
 214                     ; 64 		state = 1;
 216  00af 35010000      	mov	_state,#1
 217  00b3               L14:
 218                     ; 67   if (state == 1 && pulseFlag == 1) {
 220  00b3 c60000        	ld	a,_state
 221  00b6 a101          	cp	a,#1
 222  00b8 2644          	jrne	L34
 224  00ba c60000        	ld	a,_pulseFlag
 225  00bd a101          	cp	a,#1
 226  00bf 263d          	jrne	L34
 227                     ; 68 		GPIO_WriteHigh(GPIOC, GPIO_PIN_2); // Send pulse
 229  00c1 4b04          	push	#4
 230  00c3 ae500a        	ldw	x,#20490
 231  00c6 8d000000      	callf	f_GPIO_WriteHigh
 233  00ca 84            	pop	a
 234                     ; 69 		for(i = 0; i < 1030; i++)
 236  00cb ae0000        	ldw	x,#0
 237  00ce cf0008        	ldw	_i+2,x
 238  00d1 ae0000        	ldw	x,#0
 239  00d4 cf0006        	ldw	_i,x
 240  00d7               L54:
 243  00d7 ae0006        	ldw	x,#_i
 244  00da a601          	ld	a,#1
 245  00dc 8d000000      	callf	d_lgadc
 249  00e0 ae0006        	ldw	x,#_i
 250  00e3 8d000000      	callf	d_ltor
 252  00e7 ae0000        	ldw	x,#L01
 253  00ea 8d000000      	callf	d_lcmp
 255  00ee 25e7          	jrult	L54
 256                     ; 73 		GPIO_WriteLow(GPIOC, GPIO_PIN_2);
 258  00f0 4b04          	push	#4
 259  00f2 ae500a        	ldw	x,#20490
 260  00f5 8d000000      	callf	f_GPIO_WriteLow
 262  00f9 84            	pop	a
 263                     ; 74 		pulseFlag = 0;
 265  00fa 725f0000      	clr	_pulseFlag
 266  00fe               L34:
 267                     ; 77 	TIM1_ClearITPendingBit(TIM1_IT_CC1);
 269  00fe a602          	ld	a,#2
 270  0100 8d000000      	callf	f_TIM1_ClearITPendingBit
 272                     ; 78 	TIM1_ClearFlag(TIM1_FLAG_CC1);
 274  0104 ae0002        	ldw	x,#2
 275  0107 8d000000      	callf	f_TIM1_ClearFlag
 277                     ; 79 }
 280  010b 5b04          	addw	sp,#4
 281  010d 85            	popw	x
 282  010e bf00          	ldw	c_lreg,x
 283  0110 85            	popw	x
 284  0111 bf02          	ldw	c_lreg+2,x
 285  0113 85            	popw	x
 286  0114 bf00          	ldw	c_y,x
 287  0116 320002        	pop	c_y+2
 288  0119 85            	popw	x
 289  011a bf00          	ldw	c_x,x
 290  011c 320002        	pop	c_x+2
 291  011f 80            	iret
 314                     ; 104 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
 314                     ; 105 {
 315                     	switch	.text
 316  0120               f_NonHandledInterrupt:
 320                     ; 109 }
 323  0120 80            	iret
 345                     ; 117 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
 345                     ; 118 {
 346                     	switch	.text
 347  0121               f_TRAP_IRQHandler:
 351                     ; 122 }
 354  0121 80            	iret
 376                     ; 128 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 376                     ; 129 {
 377                     	switch	.text
 378  0122               f_TLI_IRQHandler:
 382                     ; 133 }
 385  0122 80            	iret
 407                     ; 140 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 407                     ; 141 {
 408                     	switch	.text
 409  0123               f_AWU_IRQHandler:
 413                     ; 145 }
 416  0123 80            	iret
 438                     ; 152 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 438                     ; 153 {
 439                     	switch	.text
 440  0124               f_CLK_IRQHandler:
 444                     ; 157 }
 447  0124 80            	iret
 470                     ; 164 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 470                     ; 165 {
 471                     	switch	.text
 472  0125               f_EXTI_PORTA_IRQHandler:
 476                     ; 169 }
 479  0125 80            	iret
 502                     ; 176 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 502                     ; 177 {
 503                     	switch	.text
 504  0126               f_EXTI_PORTB_IRQHandler:
 508                     ; 181 }
 511  0126 80            	iret
 534                     ; 188 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 534                     ; 189 {
 535                     	switch	.text
 536  0127               f_EXTI_PORTC_IRQHandler:
 540                     ; 193 }
 543  0127 80            	iret
 566                     ; 200 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 566                     ; 201 {
 567                     	switch	.text
 568  0128               f_EXTI_PORTD_IRQHandler:
 572                     ; 205 }
 575  0128 80            	iret
 598                     ; 212 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 598                     ; 213 {
 599                     	switch	.text
 600  0129               f_EXTI_PORTE_IRQHandler:
 604                     ; 217 }
 607  0129 80            	iret
 629                     ; 238  INTERRUPT_HANDLER(CAN_RX_IRQHandler, 8)
 629                     ; 239 {
 630                     	switch	.text
 631  012a               f_CAN_RX_IRQHandler:
 635                     ; 243 }
 638  012a 80            	iret
 660                     ; 250  INTERRUPT_HANDLER(CAN_TX_IRQHandler, 9)
 660                     ; 251 {
 661                     	switch	.text
 662  012b               f_CAN_TX_IRQHandler:
 666                     ; 255 }
 669  012b 80            	iret
 691                     ; 263 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 691                     ; 264 {
 692                     	switch	.text
 693  012c               f_SPI_IRQHandler:
 697                     ; 268 }
 700  012c 80            	iret
 723                     ; 275 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 723                     ; 276 {
 724                     	switch	.text
 725  012d               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 729                     ; 280 }
 732  012d 80            	iret
 755                     ; 287 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 755                     ; 288 {
 756                     	switch	.text
 757  012e               f_TIM1_CAP_COM_IRQHandler:
 761                     ; 292 }
 764  012e 80            	iret
 787                     ; 324  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 787                     ; 325 {
 788                     	switch	.text
 789  012f               f_TIM2_UPD_OVF_BRK_IRQHandler:
 793                     ; 329 }
 796  012f 80            	iret
 819                     ; 336  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 819                     ; 337 {
 820                     	switch	.text
 821  0130               f_TIM2_CAP_COM_IRQHandler:
 825                     ; 341 }
 828  0130 80            	iret
 851                     ; 351  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 851                     ; 352 {
 852                     	switch	.text
 853  0131               f_TIM3_UPD_OVF_BRK_IRQHandler:
 857                     ; 356 }
 860  0131 80            	iret
 883                     ; 363  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 883                     ; 364 {
 884                     	switch	.text
 885  0132               f_TIM3_CAP_COM_IRQHandler:
 889                     ; 368 }
 892  0132 80            	iret
 915                     ; 378  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 915                     ; 379 {
 916                     	switch	.text
 917  0133               f_UART1_TX_IRQHandler:
 921                     ; 383 }
 924  0133 80            	iret
 947                     ; 390  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 947                     ; 391 {
 948                     	switch	.text
 949  0134               f_UART1_RX_IRQHandler:
 953                     ; 395 }
 956  0134 80            	iret
 978                     ; 403 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 978                     ; 404 {
 979                     	switch	.text
 980  0135               f_I2C_IRQHandler:
 984                     ; 408 }
 987  0135 80            	iret
1010                     ; 442  INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
1010                     ; 443 {
1011                     	switch	.text
1012  0136               f_UART3_TX_IRQHandler:
1016                     ; 447   }
1019  0136 80            	iret
1042                     ; 454  INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
1042                     ; 455 {
1043                     	switch	.text
1044  0137               f_UART3_RX_IRQHandler:
1048                     ; 459   }
1051  0137 80            	iret
1073                     ; 468  INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
1073                     ; 469 {
1074                     	switch	.text
1075  0138               f_ADC2_IRQHandler:
1079                     ; 474     return;
1082  0138 80            	iret
1105                     ; 512  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1105                     ; 513 {
1106                     	switch	.text
1107  0139               f_TIM4_UPD_OVF_IRQHandler:
1111                     ; 517 }
1114  0139 80            	iret
1137                     ; 525 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1137                     ; 526 {
1138                     	switch	.text
1139  013a               f_EEPROM_EEC_IRQHandler:
1143                     ; 530 }
1146  013a 80            	iret
1192                     	xdef	_j
1193                     	xdef	_i
1194                     	xref	_pulseFlag
1195                     	xref	_set_frequency
1196                     	xref	_state
1197                     	xref	_frequency
1198                     	xdef	_prescaling_factor
1199                     	xdef	_last_capture
1200                     	xref	_end_time
1201                     	xref	_start_time
1202                     	xref	_pulse_ticks
1203                     	xref	_overflow_count
1204                     	xdef	f_EEPROM_EEC_IRQHandler
1205                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1206                     	xdef	f_ADC2_IRQHandler
1207                     	xdef	f_UART3_TX_IRQHandler
1208                     	xdef	f_UART3_RX_IRQHandler
1209                     	xdef	f_I2C_IRQHandler
1210                     	xdef	f_UART1_RX_IRQHandler
1211                     	xdef	f_UART1_TX_IRQHandler
1212                     	xdef	f_TIM3_CAP_COM_IRQHandler
1213                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1214                     	xdef	f_TIM2_CAP_COM_IRQHandler
1215                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1216                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1217                     	xdef	f_TIM1_CAP_COM_IRQHandler
1218                     	xdef	f_SPI_IRQHandler
1219                     	xdef	f_CAN_TX_IRQHandler
1220                     	xdef	f_CAN_RX_IRQHandler
1221                     	xdef	f_EXTI_PORTE_IRQHandler
1222                     	xdef	f_EXTI_PORTD_IRQHandler
1223                     	xdef	f_EXTI_PORTC_IRQHandler
1224                     	xdef	f_EXTI_PORTB_IRQHandler
1225                     	xdef	f_EXTI_PORTA_IRQHandler
1226                     	xdef	f_CLK_IRQHandler
1227                     	xdef	f_AWU_IRQHandler
1228                     	xdef	f_TLI_IRQHandler
1229                     	xdef	f_TRAP_IRQHandler
1230                     	xdef	f_NonHandledInterrupt
1231                     	xdef	f_TIM1_CH1_CCP_IRQHandler
1232                     	xdef	f_TIM1_UPD_IRQHandler
1233                     	xref	f_TIM1_ClearITPendingBit
1234                     	xref	f_TIM1_ClearFlag
1235                     	xref	f_TIM1_GetCapture1
1236                     	xref	f_GPIO_WriteLow
1237                     	xref	f_GPIO_WriteHigh
1238                     	switch	.const
1239  0004               L53:
1240  0004 461c4000      	dc.w	17948,16384
1241                     	xref.b	c_lreg
1242                     	xref.b	c_x
1243                     	xref.b	c_y
1263                     	xref	d_lcmp
1264                     	xref	d_lgadc
1265                     	xref	d_fcmp
1266                     	xref	d_fdiv
1267                     	xref	d_uitof
1268                     	xref	d_ltor
1269                     	xref	d_rtol
1270                     	xref	d_uitolx
1271                     	end
