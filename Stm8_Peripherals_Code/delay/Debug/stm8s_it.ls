   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  49                     ; 40 void TIM4_UPD_IRQHandler(void) 
  49                     ; 41 {
  50                     	switch	.text
  51  0000               f_TIM4_UPD_IRQHandler:
  53  0000 8a            	push	cc
  54  0001 84            	pop	a
  55  0002 a4bf          	and	a,#191
  56  0004 88            	push	a
  57  0005 86            	pop	cc
  58  0006 3b0002        	push	c_x+2
  59  0009 be00          	ldw	x,c_x
  60  000b 89            	pushw	x
  61  000c 3b0002        	push	c_y+2
  62  000f be00          	ldw	x,c_y
  63  0011 89            	pushw	x
  66                     ; 42      switch(seg)
  68  0012 b600          	ld	a,_seg
  70                     ; 73                break;
  71  0014 4a            	dec	a
  72  0015 270d          	jreq	L3
  73  0017 4a            	dec	a
  74  0018 272f          	jreq	L5
  75  001a 4a            	dec	a
  76  001b 2754          	jreq	L7
  77  001d 4a            	dec	a
  78  001e 2779          	jreq	L11
  79  0020 acbc00bc      	jpf	L33
  80  0024               L3:
  81                     ; 46                n = (value / 1000);
  83  0024 be00          	ldw	x,_value
  84  0026 90ae03e8      	ldw	y,#1000
  85  002a 65            	divw	x,y
  86  002b 01            	rrwa	x,a
  87  002c b700          	ld	_n,a
  88  002e 02            	rlwa	x,a
  89                     ; 47                GPIO_Write(GPIOD, num[n]);
  91  002f b600          	ld	a,_n
  92  0031 5f            	clrw	x
  93  0032 97            	ld	xl,a
  94  0033 d60000        	ld	a,(_num,x)
  95  0036 88            	push	a
  96  0037 ae500f        	ldw	x,#20495
  97  003a cd0000        	call	_GPIO_Write
  99  003d 84            	pop	a
 100                     ; 48                GPIO_Write(GPIOC, 0xE0);
 102  003e 4be0          	push	#224
 103  0040 ae500a        	ldw	x,#20490
 104  0043 cd0000        	call	_GPIO_Write
 106  0046 84            	pop	a
 107                     ; 49                break;
 109  0047 2073          	jra	L33
 110  0049               L5:
 111                     ; 54                n = ((value / 100) % 10);
 113  0049 be00          	ldw	x,_value
 114  004b a664          	ld	a,#100
 115  004d 62            	div	x,a
 116  004e a60a          	ld	a,#10
 117  0050 62            	div	x,a
 118  0051 5f            	clrw	x
 119  0052 97            	ld	xl,a
 120  0053 01            	rrwa	x,a
 121  0054 b700          	ld	_n,a
 122  0056 02            	rlwa	x,a
 123                     ; 55                GPIO_Write(GPIOD, num[n]);
 125  0057 b600          	ld	a,_n
 126  0059 5f            	clrw	x
 127  005a 97            	ld	xl,a
 128  005b d60000        	ld	a,(_num,x)
 129  005e 88            	push	a
 130  005f ae500f        	ldw	x,#20495
 131  0062 cd0000        	call	_GPIO_Write
 133  0065 84            	pop	a
 134                     ; 56                GPIO_Write(GPIOC, 0xD0);
 136  0066 4bd0          	push	#208
 137  0068 ae500a        	ldw	x,#20490
 138  006b cd0000        	call	_GPIO_Write
 140  006e 84            	pop	a
 141                     ; 57                break;
 143  006f 204b          	jra	L33
 144  0071               L7:
 145                     ; 62                n = ((value / 10) % 10);
 147  0071 be00          	ldw	x,_value
 148  0073 a60a          	ld	a,#10
 149  0075 62            	div	x,a
 150  0076 a60a          	ld	a,#10
 151  0078 62            	div	x,a
 152  0079 5f            	clrw	x
 153  007a 97            	ld	xl,a
 154  007b 01            	rrwa	x,a
 155  007c b700          	ld	_n,a
 156  007e 02            	rlwa	x,a
 157                     ; 63                GPIO_Write(GPIOD, num[n]);
 159  007f b600          	ld	a,_n
 160  0081 5f            	clrw	x
 161  0082 97            	ld	xl,a
 162  0083 d60000        	ld	a,(_num,x)
 163  0086 88            	push	a
 164  0087 ae500f        	ldw	x,#20495
 165  008a cd0000        	call	_GPIO_Write
 167  008d 84            	pop	a
 168                     ; 64                GPIO_Write(GPIOC, 0xB0);
 170  008e 4bb0          	push	#176
 171  0090 ae500a        	ldw	x,#20490
 172  0093 cd0000        	call	_GPIO_Write
 174  0096 84            	pop	a
 175                     ; 65                break;
 177  0097 2023          	jra	L33
 178  0099               L11:
 179                     ; 70                n = (value % 10);
 181  0099 be00          	ldw	x,_value
 182  009b a60a          	ld	a,#10
 183  009d 62            	div	x,a
 184  009e 5f            	clrw	x
 185  009f 97            	ld	xl,a
 186  00a0 01            	rrwa	x,a
 187  00a1 b700          	ld	_n,a
 188  00a3 02            	rlwa	x,a
 189                     ; 71                GPIO_Write(GPIOD, num[n]);
 191  00a4 b600          	ld	a,_n
 192  00a6 5f            	clrw	x
 193  00a7 97            	ld	xl,a
 194  00a8 d60000        	ld	a,(_num,x)
 195  00ab 88            	push	a
 196  00ac ae500f        	ldw	x,#20495
 197  00af cd0000        	call	_GPIO_Write
 199  00b2 84            	pop	a
 200                     ; 72                GPIO_Write(GPIOC, 0x70);
 202  00b3 4b70          	push	#112
 203  00b5 ae500a        	ldw	x,#20490
 204  00b8 cd0000        	call	_GPIO_Write
 206  00bb 84            	pop	a
 207                     ; 73                break;
 209  00bc               L33:
 210                     ; 77        seg++;
 212  00bc 3c00          	inc	_seg
 213                     ; 78        if(seg > 4)
 215  00be b600          	ld	a,_seg
 216  00c0 a105          	cp	a,#5
 217  00c2 2504          	jrult	L53
 218                     ; 80             seg = 1;
 220  00c4 35010000      	mov	_seg,#1
 221  00c8               L53:
 222                     ; 83        TIM4_ClearFlag(TIM4_FLAG_UPDATE);
 224  00c8 a601          	ld	a,#1
 225  00ca cd0000        	call	_TIM4_ClearFlag
 227                     ; 84 }
 230  00cd 85            	popw	x
 231  00ce bf00          	ldw	c_y,x
 232  00d0 320002        	pop	c_y+2
 233  00d3 85            	popw	x
 234  00d4 bf00          	ldw	c_x,x
 235  00d6 320002        	pop	c_x+2
 236  00d9 80            	iret
 259                     ; 106 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
 259                     ; 107 {
 260                     	switch	.text
 261  00da               f_NonHandledInterrupt:
 265                     ; 111 }
 268  00da 80            	iret
 290                     ; 119 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
 290                     ; 120 {
 291                     	switch	.text
 292  00db               f_TRAP_IRQHandler:
 296                     ; 124 }
 299  00db 80            	iret
 321                     ; 131 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 321                     ; 132 
 321                     ; 133 {
 322                     	switch	.text
 323  00dc               f_TLI_IRQHandler:
 327                     ; 137 }
 330  00dc 80            	iret
 352                     ; 144 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 352                     ; 145 {
 353                     	switch	.text
 354  00dd               f_AWU_IRQHandler:
 358                     ; 149 }
 361  00dd 80            	iret
 383                     ; 156 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 383                     ; 157 {
 384                     	switch	.text
 385  00de               f_CLK_IRQHandler:
 389                     ; 161 }
 392  00de 80            	iret
 415                     ; 168 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 415                     ; 169 {
 416                     	switch	.text
 417  00df               f_EXTI_PORTA_IRQHandler:
 421                     ; 173 }
 424  00df 80            	iret
 447                     ; 180 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 447                     ; 181 {
 448                     	switch	.text
 449  00e0               f_EXTI_PORTB_IRQHandler:
 453                     ; 185 }
 456  00e0 80            	iret
 479                     ; 192 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 479                     ; 193 {
 480                     	switch	.text
 481  00e1               f_EXTI_PORTC_IRQHandler:
 485                     ; 197 }
 488  00e1 80            	iret
 511                     ; 204 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 511                     ; 205 {
 512                     	switch	.text
 513  00e2               f_EXTI_PORTD_IRQHandler:
 517                     ; 209 }
 520  00e2 80            	iret
 543                     ; 216 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 543                     ; 217 {
 544                     	switch	.text
 545  00e3               f_EXTI_PORTE_IRQHandler:
 549                     ; 221 }
 552  00e3 80            	iret
 574                     ; 268 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 574                     ; 269 {
 575                     	switch	.text
 576  00e4               f_SPI_IRQHandler:
 580                     ; 273 }
 583  00e4 80            	iret
 606                     ; 280 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 606                     ; 281 {
 607                     	switch	.text
 608  00e5               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 612                     ; 285 }
 615  00e5 80            	iret
 638                     ; 292 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 638                     ; 293 {
 639                     	switch	.text
 640  00e6               f_TIM1_CAP_COM_IRQHandler:
 644                     ; 297 }
 647  00e6 80            	iret
 670                     ; 330  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 670                     ; 331  {
 671                     	switch	.text
 672  00e7               f_TIM2_UPD_OVF_BRK_IRQHandler:
 676                     ; 335  }
 679  00e7 80            	iret
 702                     ; 342  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 702                     ; 343  {
 703                     	switch	.text
 704  00e8               f_TIM2_CAP_COM_IRQHandler:
 708                     ; 347  }
 711  00e8 80            	iret
 734                     ; 357  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 734                     ; 358  {
 735                     	switch	.text
 736  00e9               f_TIM3_UPD_OVF_BRK_IRQHandler:
 740                     ; 362  }
 743  00e9 80            	iret
 766                     ; 369  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 766                     ; 370  {
 767                     	switch	.text
 768  00ea               f_TIM3_CAP_COM_IRQHandler:
 772                     ; 374  }
 775  00ea 80            	iret
 798                     ; 384  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 798                     ; 385  {
 799                     	switch	.text
 800  00eb               f_UART1_TX_IRQHandler:
 804                     ; 389  }
 807  00eb 80            	iret
 830                     ; 396  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 830                     ; 397  {
 831                     	switch	.text
 832  00ec               f_UART1_RX_IRQHandler:
 836                     ; 401  }
 839  00ec 80            	iret
 861                     ; 435 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 861                     ; 436 {
 862                     	switch	.text
 863  00ed               f_I2C_IRQHandler:
 867                     ; 440 }
 870  00ed 80            	iret
 893                     ; 474  INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
 893                     ; 475  {
 894                     	switch	.text
 895  00ee               f_UART3_TX_IRQHandler:
 899                     ; 479  }
 902  00ee 80            	iret
 925                     ; 486  INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
 925                     ; 487  {
 926                     	switch	.text
 927  00ef               f_UART3_RX_IRQHandler:
 931                     ; 491  }
 934  00ef 80            	iret
 956                     ; 500  INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
 956                     ; 501  {
 957                     	switch	.text
 958  00f0               f_ADC2_IRQHandler:
 962                     ; 505  }
 965  00f0 80            	iret
 988                     ; 540  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 988                     ; 541  {
 989                     	switch	.text
 990  00f1               f_TIM4_UPD_OVF_IRQHandler:
 994                     ; 545  }
 997  00f1 80            	iret
1020                     ; 553 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1020                     ; 554 {
1021                     	switch	.text
1022  00f2               f_EEPROM_EEC_IRQHandler:
1026                     ; 558 }
1029  00f2 80            	iret
1041                     	xref	_num
1042                     	xref.b	_seg
1043                     	xref.b	_n
1044                     	xref.b	_value
1045                     	xdef	f_EEPROM_EEC_IRQHandler
1046                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1047                     	xdef	f_ADC2_IRQHandler
1048                     	xdef	f_UART3_TX_IRQHandler
1049                     	xdef	f_UART3_RX_IRQHandler
1050                     	xdef	f_I2C_IRQHandler
1051                     	xdef	f_UART1_RX_IRQHandler
1052                     	xdef	f_UART1_TX_IRQHandler
1053                     	xdef	f_TIM3_CAP_COM_IRQHandler
1054                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1055                     	xdef	f_TIM2_CAP_COM_IRQHandler
1056                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1057                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1058                     	xdef	f_TIM1_CAP_COM_IRQHandler
1059                     	xdef	f_SPI_IRQHandler
1060                     	xdef	f_EXTI_PORTE_IRQHandler
1061                     	xdef	f_EXTI_PORTD_IRQHandler
1062                     	xdef	f_EXTI_PORTC_IRQHandler
1063                     	xdef	f_EXTI_PORTB_IRQHandler
1064                     	xdef	f_EXTI_PORTA_IRQHandler
1065                     	xdef	f_CLK_IRQHandler
1066                     	xdef	f_AWU_IRQHandler
1067                     	xdef	f_TLI_IRQHandler
1068                     	xdef	f_TRAP_IRQHandler
1069                     	xdef	f_NonHandledInterrupt
1070                     	xref	_TIM4_ClearFlag
1071                     	xref	_GPIO_Write
1072                     	xdef	f_TIM4_UPD_IRQHandler
1073                     	xref.b	c_x
1074                     	xref.b	c_y
1093                     	end
