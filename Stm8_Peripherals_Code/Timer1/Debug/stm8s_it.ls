   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  17                     	bsct
  18  0000               _last_capture:
  19  0000 00000000      	dc.l	0
  20  0004               _prescaling_factor:
  21  0004 0001          	dc.w	1
  54                     ; 46 void TIM1_UPD_IRQHandler(void) 
  54                     ; 47 {
  55                     	switch	.text
  56  0000               f_TIM1_UPD_IRQHandler:
  58  0000 8a            	push	cc
  59  0001 84            	pop	a
  60  0002 a4bf          	and	a,#191
  61  0004 88            	push	a
  62  0005 86            	pop	cc
  63  0006 3b0002        	push	c_x+2
  64  0009 be00          	ldw	x,c_x
  65  000b 89            	pushw	x
  66  000c 3b0002        	push	c_y+2
  67  000f be00          	ldw	x,c_y
  68  0011 89            	pushw	x
  71                     ; 48 	overflow_count++;
  73  0012 be00          	ldw	x,_overflow_count
  74  0014 5c            	incw	x
  75  0015 bf00          	ldw	_overflow_count,x
  76                     ; 49 	TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
  78  0017 a601          	ld	a,#1
  79  0019 8d000000      	callf	f_TIM1_ClearITPendingBit
  81                     ; 50 	TIM1_ClearFlag(TIM1_FLAG_UPDATE);
  83  001d ae0001        	ldw	x,#1
  84  0020 8d000000      	callf	f_TIM1_ClearFlag
  86                     ; 51 }
  89  0024 85            	popw	x
  90  0025 bf00          	ldw	c_y,x
  91  0027 320002        	pop	c_y+2
  92  002a 85            	popw	x
  93  002b bf00          	ldw	c_x,x
  94  002d 320002        	pop	c_x+2
  95  0030 80            	iret	
 150                     .const:	section	.text
 151  0000               L02:
 152  0000 00000406      	dc.l	1030
 153                     ; 54 void TIM1_CH1_CCP_IRQHandler(void) 
 153                     ; 55 {
 154                     	switch	.text
 155  0031               f_TIM1_CH1_CCP_IRQHandler:
 157  0031 8a            	push	cc
 158  0032 84            	pop	a
 159  0033 a4bf          	and	a,#191
 160  0035 88            	push	a
 161  0036 86            	pop	cc
 162       0000000c      OFST:	set	12
 163  0037 3b0002        	push	c_x+2
 164  003a be00          	ldw	x,c_x
 165  003c 89            	pushw	x
 166  003d 3b0002        	push	c_y+2
 167  0040 be00          	ldw	x,c_y
 168  0042 89            	pushw	x
 169  0043 be02          	ldw	x,c_lreg+2
 170  0045 89            	pushw	x
 171  0046 be00          	ldw	x,c_lreg
 172  0048 89            	pushw	x
 173  0049 520c          	subw	sp,#12
 176                     ; 56 	uint32_t i = 0, j = 0;
 180                     ; 57 	end_time = TIM1_GetCapture1();
 182  004b 8d000000      	callf	f_TIM1_GetCapture1
 184  004f 8d000000      	callf	d_uitolx
 186  0053 ae0000        	ldw	x,#_end_time
 187  0056 8d000000      	callf	d_rtol
 189                     ; 58 	pulse_ticks = ((overflow_count << 16) - start_time + end_time);
 191  005a ae0000        	ldw	x,#_start_time
 192  005d 8d000000      	callf	d_ltor
 194  0061 8d000000      	callf	d_lneg
 196  0065 ae0000        	ldw	x,#_end_time
 197  0068 8d000000      	callf	d_ladd
 199  006c ae0000        	ldw	x,#_pulse_ticks
 200  006f 8d000000      	callf	d_rtol
 202                     ; 59 	start_time = end_time;
 204  0073 be02          	ldw	x,_end_time+2
 205  0075 bf02          	ldw	_start_time+2,x
 206  0077 be00          	ldw	x,_end_time
 207  0079 bf00          	ldw	_start_time,x
 208                     ; 60 	overflow_count = 0;
 210  007b 5f            	clrw	x
 211  007c bf00          	ldw	_overflow_count,x
 212                     ; 74 	frequency = (1000.0 / pulse_ticks); // Calculate frequency in Hz
 214  007e ae0000        	ldw	x,#_pulse_ticks
 215  0081 8d000000      	callf	d_ltor
 217  0085 8d000000      	callf	d_ultof
 219  0089 96            	ldw	x,sp
 220  008a 5c            	incw	x
 221  008b 8d000000      	callf	d_rtol
 224  008f ae0004        	ldw	x,#L74
 225  0092 8d000000      	callf	d_ltor
 227  0096 96            	ldw	x,sp
 228  0097 5c            	incw	x
 229  0098 8d000000      	callf	d_fdiv
 231  009c ae0000        	ldw	x,#_frequency
 232  009f 8d000000      	callf	d_rtol
 234                     ; 76 	if (frequency <= set_frequency) {
 236  00a3 8d000000      	callf	d_ltor
 238  00a7 ae0000        	ldw	x,#_set_frequency
 239  00aa 8d000000      	callf	d_fcmp
 241  00ae 2c06          	jrsgt	L35
 242                     ; 77 		state = 1;
 244  00b0 35010000      	mov	_state,#1
 246  00b4 2002          	jra	L55
 247  00b6               L35:
 248                     ; 80 		state = 0;
 250  00b6 3f00          	clr	_state
 251  00b8               L55:
 252                     ; 82   if (state == 1) {
 254  00b8 b600          	ld	a,_state
 255  00ba 4a            	dec	a
 256  00bb 2634          	jrne	L75
 257                     ; 83 		GPIO_WriteLow(GPIOC, GPIO_PIN_2); // Send pulse
 259  00bd 4b04          	push	#4
 260  00bf ae500a        	ldw	x,#20490
 261  00c2 8d000000      	callf	f_GPIO_WriteLow
 263  00c6 5f            	clrw	x
 264  00c7 84            	pop	a
 265                     ; 84 		for(i = 0; i < 1030; i++)
 267  00c8 1f0b          	ldw	(OFST-1,sp),x
 268  00ca 1f09          	ldw	(OFST-3,sp),x
 270  00cc               L16:
 273  00cc 96            	ldw	x,sp
 274  00cd 1c0009        	addw	x,#OFST-3
 275  00d0 a601          	ld	a,#1
 276  00d2 8d000000      	callf	d_lgadc
 281  00d6 96            	ldw	x,sp
 282  00d7 1c0009        	addw	x,#OFST-3
 283  00da 8d000000      	callf	d_ltor
 285  00de ae0000        	ldw	x,#L02
 286  00e1 8d000000      	callf	d_lcmp
 288  00e5 25e5          	jrult	L16
 289                     ; 88 		GPIO_WriteHigh(GPIOC, GPIO_PIN_2);
 291  00e7 4b04          	push	#4
 292  00e9 ae500a        	ldw	x,#20490
 293  00ec 8d000000      	callf	f_GPIO_WriteHigh
 295  00f0 84            	pop	a
 296  00f1               L75:
 297                     ; 91 	TIM1_ClearITPendingBit(TIM1_IT_CC1);
 299  00f1 a602          	ld	a,#2
 300  00f3 8d000000      	callf	f_TIM1_ClearITPendingBit
 302                     ; 92 	TIM1_ClearFlag(TIM1_FLAG_CC1);
 304  00f7 ae0002        	ldw	x,#2
 305  00fa 8d000000      	callf	f_TIM1_ClearFlag
 307                     ; 93 }
 310  00fe 5b0c          	addw	sp,#12
 311  0100 85            	popw	x
 312  0101 bf00          	ldw	c_lreg,x
 313  0103 85            	popw	x
 314  0104 bf02          	ldw	c_lreg+2,x
 315  0106 85            	popw	x
 316  0107 bf00          	ldw	c_y,x
 317  0109 320002        	pop	c_y+2
 318  010c 85            	popw	x
 319  010d bf00          	ldw	c_x,x
 320  010f 320002        	pop	c_x+2
 321  0112 80            	iret	
 344                     ; 118 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
 344                     ; 119 {
 345                     	switch	.text
 346  0113               f_NonHandledInterrupt:
 350                     ; 123 }
 353  0113 80            	iret	
 375                     ; 131 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
 375                     ; 132 {
 376                     	switch	.text
 377  0114               f_TRAP_IRQHandler:
 381                     ; 136 }
 384  0114 80            	iret	
 406                     ; 142 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 406                     ; 143 {
 407                     	switch	.text
 408  0115               f_TLI_IRQHandler:
 412                     ; 147 }
 415  0115 80            	iret	
 437                     ; 154 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 437                     ; 155 {
 438                     	switch	.text
 439  0116               f_AWU_IRQHandler:
 443                     ; 159 }
 446  0116 80            	iret	
 468                     ; 166 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 468                     ; 167 {
 469                     	switch	.text
 470  0117               f_CLK_IRQHandler:
 474                     ; 171 }
 477  0117 80            	iret	
 500                     ; 178 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 500                     ; 179 {
 501                     	switch	.text
 502  0118               f_EXTI_PORTA_IRQHandler:
 506                     ; 183 }
 509  0118 80            	iret	
 532                     ; 190 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 532                     ; 191 {
 533                     	switch	.text
 534  0119               f_EXTI_PORTB_IRQHandler:
 538                     ; 195 }
 541  0119 80            	iret	
 564                     ; 202 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 564                     ; 203 {
 565                     	switch	.text
 566  011a               f_EXTI_PORTC_IRQHandler:
 570                     ; 207 }
 573  011a 80            	iret	
 596                     ; 214 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 596                     ; 215 {
 597                     	switch	.text
 598  011b               f_EXTI_PORTD_IRQHandler:
 602                     ; 219 }
 605  011b 80            	iret	
 628                     ; 226 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 628                     ; 227 {
 629                     	switch	.text
 630  011c               f_EXTI_PORTE_IRQHandler:
 634                     ; 231 }
 637  011c 80            	iret	
 659                     ; 252  INTERRUPT_HANDLER(CAN_RX_IRQHandler, 8)
 659                     ; 253 {
 660                     	switch	.text
 661  011d               f_CAN_RX_IRQHandler:
 665                     ; 257 }
 668  011d 80            	iret	
 690                     ; 264  INTERRUPT_HANDLER(CAN_TX_IRQHandler, 9)
 690                     ; 265 {
 691                     	switch	.text
 692  011e               f_CAN_TX_IRQHandler:
 696                     ; 269 }
 699  011e 80            	iret	
 721                     ; 277 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 721                     ; 278 {
 722                     	switch	.text
 723  011f               f_SPI_IRQHandler:
 727                     ; 282 }
 730  011f 80            	iret	
 753                     ; 289 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 753                     ; 290 {
 754                     	switch	.text
 755  0120               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 759                     ; 294 }
 762  0120 80            	iret	
 785                     ; 301 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 785                     ; 302 {
 786                     	switch	.text
 787  0121               f_TIM1_CAP_COM_IRQHandler:
 791                     ; 306 }
 794  0121 80            	iret	
 817                     ; 338  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 817                     ; 339 {
 818                     	switch	.text
 819  0122               f_TIM2_UPD_OVF_BRK_IRQHandler:
 823                     ; 343 }
 826  0122 80            	iret	
 849                     ; 350  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 849                     ; 351 {
 850                     	switch	.text
 851  0123               f_TIM2_CAP_COM_IRQHandler:
 855                     ; 355 }
 858  0123 80            	iret	
 881                     ; 365  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 881                     ; 366 {
 882                     	switch	.text
 883  0124               f_TIM3_UPD_OVF_BRK_IRQHandler:
 887                     ; 370 }
 890  0124 80            	iret	
 913                     ; 377  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 913                     ; 378 {
 914                     	switch	.text
 915  0125               f_TIM3_CAP_COM_IRQHandler:
 919                     ; 382 }
 922  0125 80            	iret	
 945                     ; 392  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 945                     ; 393 {
 946                     	switch	.text
 947  0126               f_UART1_TX_IRQHandler:
 951                     ; 397 }
 954  0126 80            	iret	
 977                     ; 404  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 977                     ; 405 {
 978                     	switch	.text
 979  0127               f_UART1_RX_IRQHandler:
 983                     ; 409 }
 986  0127 80            	iret	
1008                     ; 417 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
1008                     ; 418 {
1009                     	switch	.text
1010  0128               f_I2C_IRQHandler:
1014                     ; 422 }
1017  0128 80            	iret	
1040                     ; 456  INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
1040                     ; 457 {
1041                     	switch	.text
1042  0129               f_UART3_TX_IRQHandler:
1046                     ; 461   }
1049  0129 80            	iret	
1072                     ; 468  INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
1072                     ; 469 {
1073                     	switch	.text
1074  012a               f_UART3_RX_IRQHandler:
1078                     ; 473   }
1081  012a 80            	iret	
1103                     ; 482  INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
1103                     ; 483 {
1104                     	switch	.text
1105  012b               f_ADC2_IRQHandler:
1109                     ; 488     return;
1112  012b 80            	iret	
1135                     ; 526  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1135                     ; 527 {
1136                     	switch	.text
1137  012c               f_TIM4_UPD_OVF_IRQHandler:
1141                     ; 531 }
1144  012c 80            	iret	
1167                     ; 539 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1167                     ; 540 {
1168                     	switch	.text
1169  012d               f_EEPROM_EEC_IRQHandler:
1173                     ; 544 }
1176  012d 80            	iret	
1208                     	xref.b	_set_frequency
1209                     	xref.b	_state
1210                     	xref.b	_frequency
1211                     	xdef	_prescaling_factor
1212                     	xdef	_last_capture
1213                     	xref.b	_end_time
1214                     	xref.b	_start_time
1215                     	xref.b	_pulse_ticks
1216                     	xref.b	_overflow_count
1217                     	xdef	f_EEPROM_EEC_IRQHandler
1218                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1219                     	xdef	f_ADC2_IRQHandler
1220                     	xdef	f_UART3_TX_IRQHandler
1221                     	xdef	f_UART3_RX_IRQHandler
1222                     	xdef	f_I2C_IRQHandler
1223                     	xdef	f_UART1_RX_IRQHandler
1224                     	xdef	f_UART1_TX_IRQHandler
1225                     	xdef	f_TIM3_CAP_COM_IRQHandler
1226                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1227                     	xdef	f_TIM2_CAP_COM_IRQHandler
1228                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1229                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1230                     	xdef	f_TIM1_CAP_COM_IRQHandler
1231                     	xdef	f_SPI_IRQHandler
1232                     	xdef	f_CAN_TX_IRQHandler
1233                     	xdef	f_CAN_RX_IRQHandler
1234                     	xdef	f_EXTI_PORTE_IRQHandler
1235                     	xdef	f_EXTI_PORTD_IRQHandler
1236                     	xdef	f_EXTI_PORTC_IRQHandler
1237                     	xdef	f_EXTI_PORTB_IRQHandler
1238                     	xdef	f_EXTI_PORTA_IRQHandler
1239                     	xdef	f_CLK_IRQHandler
1240                     	xdef	f_AWU_IRQHandler
1241                     	xdef	f_TLI_IRQHandler
1242                     	xdef	f_TRAP_IRQHandler
1243                     	xdef	f_NonHandledInterrupt
1244                     	xdef	f_TIM1_CH1_CCP_IRQHandler
1245                     	xdef	f_TIM1_UPD_IRQHandler
1246                     	xref	f_TIM1_ClearITPendingBit
1247                     	xref	f_TIM1_ClearFlag
1248                     	xref	f_TIM1_GetCapture1
1249                     	xref	f_GPIO_WriteLow
1250                     	xref	f_GPIO_WriteHigh
1251                     	switch	.const
1252  0004               L74:
1253  0004 447a0000      	dc.w	17530,0
1254                     	xref.b	c_lreg
1255                     	xref.b	c_x
1256                     	xref.b	c_y
1276                     	xref	d_lcmp
1277                     	xref	d_lgadc
1278                     	xref	d_fcmp
1279                     	xref	d_fdiv
1280                     	xref	d_ultof
1281                     	xref	d_ladd
1282                     	xref	d_lneg
1283                     	xref	d_ltor
1284                     	xref	d_rtol
1285                     	xref	d_uitolx
1286                     	end
