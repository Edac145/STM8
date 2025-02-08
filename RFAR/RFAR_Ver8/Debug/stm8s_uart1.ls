   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  42                     ; 53 void UART1_DeInit(void)
  42                     ; 54 {
  43                     	switch	.text
  44  0000               f_UART1_DeInit:
  48                     ; 57   (void)UART1->SR;
  50  0000 c65230        	ld	a,21040
  51                     ; 58   (void)UART1->DR;
  53  0003 c65231        	ld	a,21041
  54                     ; 60   UART1->BRR2 = UART1_BRR2_RESET_VALUE;  /* Set UART1_BRR2 to reset value 0x00 */
  56  0006 725f5233      	clr	21043
  57                     ; 61   UART1->BRR1 = UART1_BRR1_RESET_VALUE;  /* Set UART1_BRR1 to reset value 0x00 */
  59  000a 725f5232      	clr	21042
  60                     ; 63   UART1->CR1 = UART1_CR1_RESET_VALUE;  /* Set UART1_CR1 to reset value 0x00 */
  62  000e 725f5234      	clr	21044
  63                     ; 64   UART1->CR2 = UART1_CR2_RESET_VALUE;  /* Set UART1_CR2 to reset value 0x00 */
  65  0012 725f5235      	clr	21045
  66                     ; 65   UART1->CR3 = UART1_CR3_RESET_VALUE;  /* Set UART1_CR3 to reset value 0x00 */
  68  0016 725f5236      	clr	21046
  69                     ; 66   UART1->CR4 = UART1_CR4_RESET_VALUE;  /* Set UART1_CR4 to reset value 0x00 */
  71  001a 725f5237      	clr	21047
  72                     ; 67   UART1->CR5 = UART1_CR5_RESET_VALUE;  /* Set UART1_CR5 to reset value 0x00 */
  74  001e 725f5238      	clr	21048
  75                     ; 69   UART1->GTR = UART1_GTR_RESET_VALUE;
  77  0022 725f5239      	clr	21049
  78                     ; 70   UART1->PSCR = UART1_PSCR_RESET_VALUE;
  80  0026 725f523a      	clr	21050
  81                     ; 71 }
  84  002a 87            	retf
 380                     .const:	section	.text
 381  0000               L01:
 382  0000 00000064      	dc.l	100
 383                     ; 90 void UART1_Init(uint32_t BaudRate, UART1_WordLength_TypeDef WordLength, 
 383                     ; 91                 UART1_StopBits_TypeDef StopBits, UART1_Parity_TypeDef Parity, 
 383                     ; 92                 UART1_SyncMode_TypeDef SyncMode, UART1_Mode_TypeDef Mode)
 383                     ; 93 {
 384                     	switch	.text
 385  002b               f_UART1_Init:
 387  002b 520c          	subw	sp,#12
 388       0000000c      OFST:	set	12
 391                     ; 94   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 395                     ; 97   assert_param(IS_UART1_BAUDRATE_OK(BaudRate));
 397                     ; 98   assert_param(IS_UART1_WORDLENGTH_OK(WordLength));
 399                     ; 99   assert_param(IS_UART1_STOPBITS_OK(StopBits));
 401                     ; 100   assert_param(IS_UART1_PARITY_OK(Parity));
 403                     ; 101   assert_param(IS_UART1_MODE_OK((uint8_t)Mode));
 405                     ; 102   assert_param(IS_UART1_SYNCMODE_OK((uint8_t)SyncMode));
 407                     ; 105   UART1->CR1 &= (uint8_t)(~UART1_CR1_M);  
 409  002d 72195234      	bres	21044,#4
 410                     ; 108   UART1->CR1 |= (uint8_t)WordLength;
 412  0031 c65234        	ld	a,21044
 413  0034 1a14          	or	a,(OFST+8,sp)
 414  0036 c75234        	ld	21044,a
 415                     ; 111   UART1->CR3 &= (uint8_t)(~UART1_CR3_STOP);  
 417  0039 c65236        	ld	a,21046
 418  003c a4cf          	and	a,#207
 419  003e c75236        	ld	21046,a
 420                     ; 113   UART1->CR3 |= (uint8_t)StopBits;  
 422  0041 c65236        	ld	a,21046
 423  0044 1a15          	or	a,(OFST+9,sp)
 424  0046 c75236        	ld	21046,a
 425                     ; 116   UART1->CR1 &= (uint8_t)(~(UART1_CR1_PCEN | UART1_CR1_PS  ));  
 427  0049 c65234        	ld	a,21044
 428  004c a4f9          	and	a,#249
 429  004e c75234        	ld	21044,a
 430                     ; 118   UART1->CR1 |= (uint8_t)Parity;  
 432  0051 c65234        	ld	a,21044
 433  0054 1a16          	or	a,(OFST+10,sp)
 434  0056 c75234        	ld	21044,a
 435                     ; 121   UART1->BRR1 &= (uint8_t)(~UART1_BRR1_DIVM);  
 437  0059 725f5232      	clr	21042
 438                     ; 123   UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVM);  
 440  005d c65233        	ld	a,21043
 441  0060 a40f          	and	a,#15
 442  0062 c75233        	ld	21043,a
 443                     ; 125   UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVF);  
 445  0065 c65233        	ld	a,21043
 446  0068 a4f0          	and	a,#240
 447  006a c75233        	ld	21043,a
 448                     ; 128   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 450  006d 96            	ldw	x,sp
 451  006e 1c0010        	addw	x,#OFST+4
 452  0071 8d000000      	callf	d_ltor
 454  0075 a604          	ld	a,#4
 455  0077 8d000000      	callf	d_llsh
 457  007b 96            	ldw	x,sp
 458  007c 1c0001        	addw	x,#OFST-11
 459  007f 8d000000      	callf	d_rtol
 462  0083 8d000000      	callf	f_CLK_GetClockFreq
 464  0087 96            	ldw	x,sp
 465  0088 1c0001        	addw	x,#OFST-11
 466  008b 8d000000      	callf	d_ludv
 468  008f 96            	ldw	x,sp
 469  0090 1c0009        	addw	x,#OFST-3
 470  0093 8d000000      	callf	d_rtol
 473                     ; 129   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 475  0097 96            	ldw	x,sp
 476  0098 1c0010        	addw	x,#OFST+4
 477  009b 8d000000      	callf	d_ltor
 479  009f a604          	ld	a,#4
 480  00a1 8d000000      	callf	d_llsh
 482  00a5 96            	ldw	x,sp
 483  00a6 1c0001        	addw	x,#OFST-11
 484  00a9 8d000000      	callf	d_rtol
 487  00ad 8d000000      	callf	f_CLK_GetClockFreq
 489  00b1 a664          	ld	a,#100
 490  00b3 8d000000      	callf	d_smul
 492  00b7 96            	ldw	x,sp
 493  00b8 1c0001        	addw	x,#OFST-11
 494  00bb 8d000000      	callf	d_ludv
 496  00bf 96            	ldw	x,sp
 497  00c0 1c0005        	addw	x,#OFST-7
 498  00c3 8d000000      	callf	d_rtol
 501                     ; 131   UART1->BRR2 |= (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100)) << 4) / 100) & (uint8_t)0x0F); 
 503  00c7 96            	ldw	x,sp
 504  00c8 1c0009        	addw	x,#OFST-3
 505  00cb 8d000000      	callf	d_ltor
 507  00cf a664          	ld	a,#100
 508  00d1 8d000000      	callf	d_smul
 510  00d5 96            	ldw	x,sp
 511  00d6 1c0001        	addw	x,#OFST-11
 512  00d9 8d000000      	callf	d_rtol
 515  00dd 96            	ldw	x,sp
 516  00de 1c0005        	addw	x,#OFST-7
 517  00e1 8d000000      	callf	d_ltor
 519  00e5 96            	ldw	x,sp
 520  00e6 1c0001        	addw	x,#OFST-11
 521  00e9 8d000000      	callf	d_lsub
 523  00ed a604          	ld	a,#4
 524  00ef 8d000000      	callf	d_llsh
 526  00f3 ae0000        	ldw	x,#L01
 527  00f6 8d000000      	callf	d_ludv
 529  00fa b603          	ld	a,c_lreg+3
 530  00fc a40f          	and	a,#15
 531  00fe ca5233        	or	a,21043
 532  0101 c75233        	ld	21043,a
 533                     ; 133   UART1->BRR2 |= (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0); 
 535  0104 1e0b          	ldw	x,(OFST-1,sp)
 536  0106 54            	srlw	x
 537  0107 54            	srlw	x
 538  0108 54            	srlw	x
 539  0109 54            	srlw	x
 540  010a 01            	rrwa	x,a
 541  010b a4f0          	and	a,#240
 542  010d 5f            	clrw	x
 543  010e ca5233        	or	a,21043
 544  0111 c75233        	ld	21043,a
 545                     ; 135   UART1->BRR1 |= (uint8_t)BaudRate_Mantissa;           
 547  0114 c65232        	ld	a,21042
 548  0117 1a0c          	or	a,(OFST+0,sp)
 549  0119 c75232        	ld	21042,a
 550                     ; 138   UART1->CR2 &= (uint8_t)~(UART1_CR2_TEN | UART1_CR2_REN); 
 552  011c c65235        	ld	a,21045
 553  011f a4f3          	and	a,#243
 554  0121 c75235        	ld	21045,a
 555                     ; 140   UART1->CR3 &= (uint8_t)~(UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL); 
 557  0124 c65236        	ld	a,21046
 558  0127 a4f8          	and	a,#248
 559  0129 c75236        	ld	21046,a
 560                     ; 142   UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART1_CR3_CPOL | 
 560                     ; 143                                                         UART1_CR3_CPHA | UART1_CR3_LBCL));  
 562  012c 7b17          	ld	a,(OFST+11,sp)
 563  012e a407          	and	a,#7
 564  0130 ca5236        	or	a,21046
 565  0133 c75236        	ld	21046,a
 566                     ; 145   if ((uint8_t)(Mode & UART1_MODE_TX_ENABLE))
 568  0136 7b18          	ld	a,(OFST+12,sp)
 569  0138 a504          	bcp	a,#4
 570  013a 2706          	jreq	L561
 571                     ; 148     UART1->CR2 |= (uint8_t)UART1_CR2_TEN;  
 573  013c 72165235      	bset	21045,#3
 575  0140 2004          	jra	L761
 576  0142               L561:
 577                     ; 153     UART1->CR2 &= (uint8_t)(~UART1_CR2_TEN);  
 579  0142 72175235      	bres	21045,#3
 580  0146               L761:
 581                     ; 155   if ((uint8_t)(Mode & UART1_MODE_RX_ENABLE))
 583  0146 7b18          	ld	a,(OFST+12,sp)
 584  0148 a508          	bcp	a,#8
 585  014a 2706          	jreq	L171
 586                     ; 158     UART1->CR2 |= (uint8_t)UART1_CR2_REN;  
 588  014c 72145235      	bset	21045,#2
 590  0150 2004          	jra	L371
 591  0152               L171:
 592                     ; 163     UART1->CR2 &= (uint8_t)(~UART1_CR2_REN);  
 594  0152 72155235      	bres	21045,#2
 595  0156               L371:
 596                     ; 167   if ((uint8_t)(SyncMode & UART1_SYNCMODE_CLOCK_DISABLE))
 598  0156 7b17          	ld	a,(OFST+11,sp)
 599  0158 a580          	bcp	a,#128
 600  015a 2706          	jreq	L571
 601                     ; 170     UART1->CR3 &= (uint8_t)(~UART1_CR3_CKEN); 
 603  015c 72175236      	bres	21046,#3
 605  0160 200a          	jra	L771
 606  0162               L571:
 607                     ; 174     UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & UART1_CR3_CKEN);
 609  0162 7b17          	ld	a,(OFST+11,sp)
 610  0164 a408          	and	a,#8
 611  0166 ca5236        	or	a,21046
 612  0169 c75236        	ld	21046,a
 613  016c               L771:
 614                     ; 176 }
 617  016c 5b0c          	addw	sp,#12
 618  016e 87            	retf
 672                     ; 184 void UART1_Cmd(FunctionalState NewState)
 672                     ; 185 {
 673                     	switch	.text
 674  016f               f_UART1_Cmd:
 678                     ; 186   if (NewState != DISABLE)
 680  016f 4d            	tnz	a
 681  0170 2706          	jreq	L722
 682                     ; 189     UART1->CR1 &= (uint8_t)(~UART1_CR1_UARTD); 
 684  0172 721b5234      	bres	21044,#5
 686  0176 2004          	jra	L132
 687  0178               L722:
 688                     ; 194     UART1->CR1 |= UART1_CR1_UARTD;  
 690  0178 721a5234      	bset	21044,#5
 691  017c               L132:
 692                     ; 196 }
 695  017c 87            	retf
 815                     ; 211 void UART1_ITConfig(UART1_IT_TypeDef UART1_IT, FunctionalState NewState)
 815                     ; 212 {
 816                     	switch	.text
 817  017d               f_UART1_ITConfig:
 819  017d 89            	pushw	x
 820  017e 89            	pushw	x
 821       00000002      OFST:	set	2
 824                     ; 213   uint8_t uartreg = 0, itpos = 0x00;
 828                     ; 216   assert_param(IS_UART1_CONFIG_IT_OK(UART1_IT));
 830                     ; 217   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 832                     ; 220   uartreg = (uint8_t)((uint16_t)UART1_IT >> 0x08);
 834  017f 9e            	ld	a,xh
 835  0180 6b01          	ld	(OFST-1,sp),a
 837                     ; 222   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART1_IT & (uint8_t)0x0F));
 839  0182 9f            	ld	a,xl
 840  0183 a40f          	and	a,#15
 841  0185 5f            	clrw	x
 842  0186 97            	ld	xl,a
 843  0187 a601          	ld	a,#1
 844  0189 5d            	tnzw	x
 845  018a 2704          	jreq	L61
 846  018c               L02:
 847  018c 48            	sll	a
 848  018d 5a            	decw	x
 849  018e 26fc          	jrne	L02
 850  0190               L61:
 851  0190 6b02          	ld	(OFST+0,sp),a
 853                     ; 224   if (NewState != DISABLE)
 855  0192 0d08          	tnz	(OFST+6,sp)
 856  0194 272a          	jreq	L503
 857                     ; 227     if (uartreg == 0x01)
 859  0196 7b01          	ld	a,(OFST-1,sp)
 860  0198 a101          	cp	a,#1
 861  019a 260a          	jrne	L703
 862                     ; 229       UART1->CR1 |= itpos;
 864  019c c65234        	ld	a,21044
 865  019f 1a02          	or	a,(OFST+0,sp)
 866  01a1 c75234        	ld	21044,a
 868  01a4 2045          	jra	L713
 869  01a6               L703:
 870                     ; 231     else if (uartreg == 0x02)
 872  01a6 7b01          	ld	a,(OFST-1,sp)
 873  01a8 a102          	cp	a,#2
 874  01aa 260a          	jrne	L313
 875                     ; 233       UART1->CR2 |= itpos;
 877  01ac c65235        	ld	a,21045
 878  01af 1a02          	or	a,(OFST+0,sp)
 879  01b1 c75235        	ld	21045,a
 881  01b4 2035          	jra	L713
 882  01b6               L313:
 883                     ; 237       UART1->CR4 |= itpos;
 885  01b6 c65237        	ld	a,21047
 886  01b9 1a02          	or	a,(OFST+0,sp)
 887  01bb c75237        	ld	21047,a
 888  01be 202b          	jra	L713
 889  01c0               L503:
 890                     ; 243     if (uartreg == 0x01)
 892  01c0 7b01          	ld	a,(OFST-1,sp)
 893  01c2 a101          	cp	a,#1
 894  01c4 260b          	jrne	L123
 895                     ; 245       UART1->CR1 &= (uint8_t)(~itpos);
 897  01c6 7b02          	ld	a,(OFST+0,sp)
 898  01c8 43            	cpl	a
 899  01c9 c45234        	and	a,21044
 900  01cc c75234        	ld	21044,a
 902  01cf 201a          	jra	L713
 903  01d1               L123:
 904                     ; 247     else if (uartreg == 0x02)
 906  01d1 7b01          	ld	a,(OFST-1,sp)
 907  01d3 a102          	cp	a,#2
 908  01d5 260b          	jrne	L523
 909                     ; 249       UART1->CR2 &= (uint8_t)(~itpos);
 911  01d7 7b02          	ld	a,(OFST+0,sp)
 912  01d9 43            	cpl	a
 913  01da c45235        	and	a,21045
 914  01dd c75235        	ld	21045,a
 916  01e0 2009          	jra	L713
 917  01e2               L523:
 918                     ; 253       UART1->CR4 &= (uint8_t)(~itpos);
 920  01e2 7b02          	ld	a,(OFST+0,sp)
 921  01e4 43            	cpl	a
 922  01e5 c45237        	and	a,21047
 923  01e8 c75237        	ld	21047,a
 924  01eb               L713:
 925                     ; 257 }
 928  01eb 5b04          	addw	sp,#4
 929  01ed 87            	retf
 964                     ; 265 void UART1_HalfDuplexCmd(FunctionalState NewState)
 964                     ; 266 {
 965                     	switch	.text
 966  01ee               f_UART1_HalfDuplexCmd:
 970                     ; 267   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 972                     ; 269   if (NewState != DISABLE)
 974  01ee 4d            	tnz	a
 975  01ef 2706          	jreq	L743
 976                     ; 271     UART1->CR5 |= UART1_CR5_HDSEL;  /**< UART1 Half Duplex Enable  */
 978  01f1 72165238      	bset	21048,#3
 980  01f5 2004          	jra	L153
 981  01f7               L743:
 982                     ; 275     UART1->CR5 &= (uint8_t)~UART1_CR5_HDSEL; /**< UART1 Half Duplex Disable */
 984  01f7 72175238      	bres	21048,#3
 985  01fb               L153:
 986                     ; 277 }
 989  01fb 87            	retf
1045                     ; 285 void UART1_IrDAConfig(UART1_IrDAMode_TypeDef UART1_IrDAMode)
1045                     ; 286 {
1046                     	switch	.text
1047  01fc               f_UART1_IrDAConfig:
1051                     ; 287   assert_param(IS_UART1_IRDAMODE_OK(UART1_IrDAMode));
1053                     ; 289   if (UART1_IrDAMode != UART1_IRDAMODE_NORMAL)
1055  01fc 4d            	tnz	a
1056  01fd 2706          	jreq	L104
1057                     ; 291     UART1->CR5 |= UART1_CR5_IRLP;
1059  01ff 72145238      	bset	21048,#2
1061  0203 2004          	jra	L304
1062  0205               L104:
1063                     ; 295     UART1->CR5 &= ((uint8_t)~UART1_CR5_IRLP);
1065  0205 72155238      	bres	21048,#2
1066  0209               L304:
1067                     ; 297 }
1070  0209 87            	retf
1104                     ; 305 void UART1_IrDACmd(FunctionalState NewState)
1104                     ; 306 {
1105                     	switch	.text
1106  020a               f_UART1_IrDACmd:
1110                     ; 308   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1112                     ; 310   if (NewState != DISABLE)
1114  020a 4d            	tnz	a
1115  020b 2706          	jreq	L324
1116                     ; 313     UART1->CR5 |= UART1_CR5_IREN;
1118  020d 72125238      	bset	21048,#1
1120  0211 2004          	jra	L524
1121  0213               L324:
1122                     ; 318     UART1->CR5 &= ((uint8_t)~UART1_CR5_IREN);
1124  0213 72135238      	bres	21048,#1
1125  0217               L524:
1126                     ; 320 }
1129  0217 87            	retf
1187                     ; 329 void UART1_LINBreakDetectionConfig(UART1_LINBreakDetectionLength_TypeDef UART1_LINBreakDetectionLength)
1187                     ; 330 {
1188                     	switch	.text
1189  0218               f_UART1_LINBreakDetectionConfig:
1193                     ; 331   assert_param(IS_UART1_LINBREAKDETECTIONLENGTH_OK(UART1_LINBreakDetectionLength));
1195                     ; 333   if (UART1_LINBreakDetectionLength != UART1_LINBREAKDETECTIONLENGTH_10BITS)
1197  0218 4d            	tnz	a
1198  0219 2706          	jreq	L554
1199                     ; 335     UART1->CR4 |= UART1_CR4_LBDL;
1201  021b 721a5237      	bset	21047,#5
1203  021f 2004          	jra	L754
1204  0221               L554:
1205                     ; 339     UART1->CR4 &= ((uint8_t)~UART1_CR4_LBDL);
1207  0221 721b5237      	bres	21047,#5
1208  0225               L754:
1209                     ; 341 }
1212  0225 87            	retf
1246                     ; 349 void UART1_LINCmd(FunctionalState NewState)
1246                     ; 350 {
1247                     	switch	.text
1248  0226               f_UART1_LINCmd:
1252                     ; 351   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1254                     ; 353   if (NewState != DISABLE)
1256  0226 4d            	tnz	a
1257  0227 2706          	jreq	L774
1258                     ; 356     UART1->CR3 |= UART1_CR3_LINEN;
1260  0229 721c5236      	bset	21046,#6
1262  022d 2004          	jra	L105
1263  022f               L774:
1264                     ; 361     UART1->CR3 &= ((uint8_t)~UART1_CR3_LINEN);
1266  022f 721d5236      	bres	21046,#6
1267  0233               L105:
1268                     ; 363 }
1271  0233 87            	retf
1305                     ; 371 void UART1_SmartCardCmd(FunctionalState NewState)
1305                     ; 372 {
1306                     	switch	.text
1307  0234               f_UART1_SmartCardCmd:
1311                     ; 373   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1313                     ; 375   if (NewState != DISABLE)
1315  0234 4d            	tnz	a
1316  0235 2706          	jreq	L125
1317                     ; 378     UART1->CR5 |= UART1_CR5_SCEN;
1319  0237 721a5238      	bset	21048,#5
1321  023b 2004          	jra	L325
1322  023d               L125:
1323                     ; 383     UART1->CR5 &= ((uint8_t)(~UART1_CR5_SCEN));
1325  023d 721b5238      	bres	21048,#5
1326  0241               L325:
1327                     ; 385 }
1330  0241 87            	retf
1365                     ; 394 void UART1_SmartCardNACKCmd(FunctionalState NewState)
1365                     ; 395 {
1366                     	switch	.text
1367  0242               f_UART1_SmartCardNACKCmd:
1371                     ; 396   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1373                     ; 398   if (NewState != DISABLE)
1375  0242 4d            	tnz	a
1376  0243 2706          	jreq	L345
1377                     ; 401     UART1->CR5 |= UART1_CR5_NACK;
1379  0245 72185238      	bset	21048,#4
1381  0249 2004          	jra	L545
1382  024b               L345:
1383                     ; 406     UART1->CR5 &= ((uint8_t)~(UART1_CR5_NACK));
1385  024b 72195238      	bres	21048,#4
1386  024f               L545:
1387                     ; 408 }
1390  024f 87            	retf
1446                     ; 416 void UART1_WakeUpConfig(UART1_WakeUp_TypeDef UART1_WakeUp)
1446                     ; 417 {
1447                     	switch	.text
1448  0250               f_UART1_WakeUpConfig:
1452                     ; 418   assert_param(IS_UART1_WAKEUP_OK(UART1_WakeUp));
1454                     ; 420   UART1->CR1 &= ((uint8_t)~UART1_CR1_WAKE);
1456  0250 72175234      	bres	21044,#3
1457                     ; 421   UART1->CR1 |= (uint8_t)UART1_WakeUp;
1459  0254 ca5234        	or	a,21044
1460  0257 c75234        	ld	21044,a
1461                     ; 422 }
1464  025a 87            	retf
1499                     ; 430 void UART1_ReceiverWakeUpCmd(FunctionalState NewState)
1499                     ; 431 {
1500                     	switch	.text
1501  025b               f_UART1_ReceiverWakeUpCmd:
1505                     ; 432   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1507                     ; 434   if (NewState != DISABLE)
1509  025b 4d            	tnz	a
1510  025c 2706          	jreq	L316
1511                     ; 437     UART1->CR2 |= UART1_CR2_RWU;
1513  025e 72125235      	bset	21045,#1
1515  0262 2004          	jra	L516
1516  0264               L316:
1517                     ; 442     UART1->CR2 &= ((uint8_t)~UART1_CR2_RWU);
1519  0264 72135235      	bres	21045,#1
1520  0268               L516:
1521                     ; 444 }
1524  0268 87            	retf
1546                     ; 451 uint8_t UART1_ReceiveData8(void)
1546                     ; 452 {
1547                     	switch	.text
1548  0269               f_UART1_ReceiveData8:
1552                     ; 453   return ((uint8_t)UART1->DR);
1554  0269 c65231        	ld	a,21041
1557  026c 87            	retf
1588                     ; 461 uint16_t UART1_ReceiveData9(void)
1588                     ; 462 {
1589                     	switch	.text
1590  026d               f_UART1_ReceiveData9:
1592  026d 89            	pushw	x
1593       00000002      OFST:	set	2
1596                     ; 463   uint16_t temp = 0;
1598                     ; 465   temp = (uint16_t)(((uint16_t)( (uint16_t)UART1->CR1 & (uint16_t)UART1_CR1_R8)) << 1);
1600  026e c65234        	ld	a,21044
1601  0271 5f            	clrw	x
1602  0272 a480          	and	a,#128
1603  0274 5f            	clrw	x
1604  0275 02            	rlwa	x,a
1605  0276 58            	sllw	x
1606  0277 1f01          	ldw	(OFST-1,sp),x
1608                     ; 466   return (uint16_t)( (((uint16_t) UART1->DR) | temp ) & ((uint16_t)0x01FF));
1610  0279 c65231        	ld	a,21041
1611  027c 5f            	clrw	x
1612  027d 97            	ld	xl,a
1613  027e 01            	rrwa	x,a
1614  027f 1a02          	or	a,(OFST+0,sp)
1615  0281 01            	rrwa	x,a
1616  0282 1a01          	or	a,(OFST-1,sp)
1617  0284 01            	rrwa	x,a
1618  0285 01            	rrwa	x,a
1619  0286 a4ff          	and	a,#255
1620  0288 01            	rrwa	x,a
1621  0289 a401          	and	a,#1
1622  028b 01            	rrwa	x,a
1625  028c 5b02          	addw	sp,#2
1626  028e 87            	retf
1657                     ; 474 void UART1_SendData8(uint8_t Data)
1657                     ; 475 {
1658                     	switch	.text
1659  028f               f_UART1_SendData8:
1663                     ; 477   UART1->DR = Data;
1665  028f c75231        	ld	21041,a
1666                     ; 478 }
1669  0292 87            	retf
1700                     ; 486 void UART1_SendData9(uint16_t Data)
1700                     ; 487 {
1701                     	switch	.text
1702  0293               f_UART1_SendData9:
1704  0293 89            	pushw	x
1705       00000000      OFST:	set	0
1708                     ; 489   UART1->CR1 &= ((uint8_t)~UART1_CR1_T8);
1710  0294 721d5234      	bres	21044,#6
1711                     ; 491   UART1->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART1_CR1_T8);
1713  0298 54            	srlw	x
1714  0299 54            	srlw	x
1715  029a 9f            	ld	a,xl
1716  029b a440          	and	a,#64
1717  029d ca5234        	or	a,21044
1718  02a0 c75234        	ld	21044,a
1719                     ; 493   UART1->DR   = (uint8_t)(Data);
1721  02a3 7b02          	ld	a,(OFST+2,sp)
1722  02a5 c75231        	ld	21041,a
1723                     ; 494 }
1726  02a8 85            	popw	x
1727  02a9 87            	retf
1749                     ; 501 void UART1_SendBreak(void)
1749                     ; 502 {
1750                     	switch	.text
1751  02aa               f_UART1_SendBreak:
1755                     ; 503   UART1->CR2 |= UART1_CR2_SBK;
1757  02aa 72105235      	bset	21045,#0
1758                     ; 504 }
1761  02ae 87            	retf
1792                     ; 511 void UART1_SetAddress(uint8_t UART1_Address)
1792                     ; 512 {
1793                     	switch	.text
1794  02af               f_UART1_SetAddress:
1796  02af 88            	push	a
1797       00000000      OFST:	set	0
1800                     ; 514   assert_param(IS_UART1_ADDRESS_OK(UART1_Address));
1802                     ; 517   UART1->CR4 &= ((uint8_t)~UART1_CR4_ADD);
1804  02b0 c65237        	ld	a,21047
1805  02b3 a4f0          	and	a,#240
1806  02b5 c75237        	ld	21047,a
1807                     ; 519   UART1->CR4 |= UART1_Address;
1809  02b8 c65237        	ld	a,21047
1810  02bb 1a01          	or	a,(OFST+1,sp)
1811  02bd c75237        	ld	21047,a
1812                     ; 520 }
1815  02c0 84            	pop	a
1816  02c1 87            	retf
1847                     ; 528 void UART1_SetGuardTime(uint8_t UART1_GuardTime)
1847                     ; 529 {
1848                     	switch	.text
1849  02c2               f_UART1_SetGuardTime:
1853                     ; 531   UART1->GTR = UART1_GuardTime;
1855  02c2 c75239        	ld	21049,a
1856                     ; 532 }
1859  02c5 87            	retf
1890                     ; 556 void UART1_SetPrescaler(uint8_t UART1_Prescaler)
1890                     ; 557 {
1891                     	switch	.text
1892  02c6               f_UART1_SetPrescaler:
1896                     ; 559   UART1->PSCR = UART1_Prescaler;
1898  02c6 c7523a        	ld	21050,a
1899                     ; 560 }
1902  02c9 87            	retf
2044                     ; 568 FlagStatus UART1_GetFlagStatus(UART1_Flag_TypeDef UART1_FLAG)
2044                     ; 569 {
2045                     	switch	.text
2046  02ca               f_UART1_GetFlagStatus:
2048  02ca 89            	pushw	x
2049  02cb 88            	push	a
2050       00000001      OFST:	set	1
2053                     ; 570   FlagStatus status = RESET;
2055                     ; 573   assert_param(IS_UART1_FLAG_OK(UART1_FLAG));
2057                     ; 577   if (UART1_FLAG == UART1_FLAG_LBDF)
2059  02cc a30210        	cpw	x,#528
2060  02cf 2610          	jrne	L1301
2061                     ; 579     if ((UART1->CR4 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2063  02d1 9f            	ld	a,xl
2064  02d2 c45237        	and	a,21047
2065  02d5 2706          	jreq	L3301
2066                     ; 582       status = SET;
2068  02d7 a601          	ld	a,#1
2069  02d9 6b01          	ld	(OFST+0,sp),a
2072  02db 202b          	jra	L7301
2073  02dd               L3301:
2074                     ; 587       status = RESET;
2076  02dd 0f01          	clr	(OFST+0,sp)
2078  02df 2027          	jra	L7301
2079  02e1               L1301:
2080                     ; 590   else if (UART1_FLAG == UART1_FLAG_SBK)
2082  02e1 1e02          	ldw	x,(OFST+1,sp)
2083  02e3 a30101        	cpw	x,#257
2084  02e6 2611          	jrne	L1401
2085                     ; 592     if ((UART1->CR2 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2087  02e8 c65235        	ld	a,21045
2088  02eb 1503          	bcp	a,(OFST+2,sp)
2089  02ed 2706          	jreq	L3401
2090                     ; 595       status = SET;
2092  02ef a601          	ld	a,#1
2093  02f1 6b01          	ld	(OFST+0,sp),a
2096  02f3 2013          	jra	L7301
2097  02f5               L3401:
2098                     ; 600       status = RESET;
2100  02f5 0f01          	clr	(OFST+0,sp)
2102  02f7 200f          	jra	L7301
2103  02f9               L1401:
2104                     ; 605     if ((UART1->SR & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2106  02f9 c65230        	ld	a,21040
2107  02fc 1503          	bcp	a,(OFST+2,sp)
2108  02fe 2706          	jreq	L1501
2109                     ; 608       status = SET;
2111  0300 a601          	ld	a,#1
2112  0302 6b01          	ld	(OFST+0,sp),a
2115  0304 2002          	jra	L7301
2116  0306               L1501:
2117                     ; 613       status = RESET;
2119  0306 0f01          	clr	(OFST+0,sp)
2121  0308               L7301:
2122                     ; 617   return status;
2124  0308 7b01          	ld	a,(OFST+0,sp)
2127  030a 5b03          	addw	sp,#3
2128  030c 87            	retf
2162                     ; 646 void UART1_ClearFlag(UART1_Flag_TypeDef UART1_FLAG)
2162                     ; 647 {
2163                     	switch	.text
2164  030d               f_UART1_ClearFlag:
2168                     ; 648   assert_param(IS_UART1_CLEAR_FLAG_OK(UART1_FLAG));
2170                     ; 651   if (UART1_FLAG == UART1_FLAG_RXNE)
2172  030d a30020        	cpw	x,#32
2173  0310 2606          	jrne	L3701
2174                     ; 653     UART1->SR = (uint8_t)~(UART1_SR_RXNE);
2176  0312 35df5230      	mov	21040,#223
2178  0316 2004          	jra	L5701
2179  0318               L3701:
2180                     ; 658     UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
2182  0318 72195237      	bres	21047,#4
2183  031c               L5701:
2184                     ; 660 }
2187  031c 87            	retf
2260                     ; 675 ITStatus UART1_GetITStatus(UART1_IT_TypeDef UART1_IT)
2260                     ; 676 {
2261                     	switch	.text
2262  031d               f_UART1_GetITStatus:
2264  031d 89            	pushw	x
2265  031e 89            	pushw	x
2266       00000002      OFST:	set	2
2269                     ; 677   ITStatus pendingbitstatus = RESET;
2271                     ; 678   uint8_t itpos = 0;
2273                     ; 679   uint8_t itmask1 = 0;
2275                     ; 680   uint8_t itmask2 = 0;
2277                     ; 681   uint8_t enablestatus = 0;
2279                     ; 684   assert_param(IS_UART1_GET_IT_OK(UART1_IT));
2281                     ; 687   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART1_IT & (uint8_t)0x0F));
2283  031f 9f            	ld	a,xl
2284  0320 a40f          	and	a,#15
2285  0322 5f            	clrw	x
2286  0323 97            	ld	xl,a
2287  0324 a601          	ld	a,#1
2288  0326 5d            	tnzw	x
2289  0327 2704          	jreq	L27
2290  0329               L47:
2291  0329 48            	sll	a
2292  032a 5a            	decw	x
2293  032b 26fc          	jrne	L47
2294  032d               L27:
2295  032d 6b01          	ld	(OFST-1,sp),a
2297                     ; 689   itmask1 = (uint8_t)((uint8_t)UART1_IT >> (uint8_t)4);
2299  032f 7b04          	ld	a,(OFST+2,sp)
2300  0331 4e            	swap	a
2301  0332 a40f          	and	a,#15
2302  0334 6b02          	ld	(OFST+0,sp),a
2304                     ; 691   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2306  0336 7b02          	ld	a,(OFST+0,sp)
2307  0338 5f            	clrw	x
2308  0339 97            	ld	xl,a
2309  033a a601          	ld	a,#1
2310  033c 5d            	tnzw	x
2311  033d 2704          	jreq	L67
2312  033f               L001:
2313  033f 48            	sll	a
2314  0340 5a            	decw	x
2315  0341 26fc          	jrne	L001
2316  0343               L67:
2317  0343 6b02          	ld	(OFST+0,sp),a
2319                     ; 695   if (UART1_IT == UART1_IT_PE)
2321  0345 1e03          	ldw	x,(OFST+1,sp)
2322  0347 a30100        	cpw	x,#256
2323  034a 261c          	jrne	L1311
2324                     ; 698     enablestatus = (uint8_t)((uint8_t)UART1->CR1 & itmask2);
2326  034c c65234        	ld	a,21044
2327  034f 1402          	and	a,(OFST+0,sp)
2328  0351 6b02          	ld	(OFST+0,sp),a
2330                     ; 701     if (((UART1->SR & itpos) != (uint8_t)0x00) && enablestatus)
2332  0353 c65230        	ld	a,21040
2333  0356 1501          	bcp	a,(OFST-1,sp)
2334  0358 270a          	jreq	L3311
2336  035a 0d02          	tnz	(OFST+0,sp)
2337  035c 2706          	jreq	L3311
2338                     ; 704       pendingbitstatus = SET;
2340  035e a601          	ld	a,#1
2341  0360 6b02          	ld	(OFST+0,sp),a
2344  0362 2041          	jra	L7311
2345  0364               L3311:
2346                     ; 709       pendingbitstatus = RESET;
2348  0364 0f02          	clr	(OFST+0,sp)
2350  0366 203d          	jra	L7311
2351  0368               L1311:
2352                     ; 713   else if (UART1_IT == UART1_IT_LBDF)
2354  0368 1e03          	ldw	x,(OFST+1,sp)
2355  036a a30346        	cpw	x,#838
2356  036d 261c          	jrne	L1411
2357                     ; 716     enablestatus = (uint8_t)((uint8_t)UART1->CR4 & itmask2);
2359  036f c65237        	ld	a,21047
2360  0372 1402          	and	a,(OFST+0,sp)
2361  0374 6b02          	ld	(OFST+0,sp),a
2363                     ; 718     if (((UART1->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2365  0376 c65237        	ld	a,21047
2366  0379 1501          	bcp	a,(OFST-1,sp)
2367  037b 270a          	jreq	L3411
2369  037d 0d02          	tnz	(OFST+0,sp)
2370  037f 2706          	jreq	L3411
2371                     ; 721       pendingbitstatus = SET;
2373  0381 a601          	ld	a,#1
2374  0383 6b02          	ld	(OFST+0,sp),a
2377  0385 201e          	jra	L7311
2378  0387               L3411:
2379                     ; 726       pendingbitstatus = RESET;
2381  0387 0f02          	clr	(OFST+0,sp)
2383  0389 201a          	jra	L7311
2384  038b               L1411:
2385                     ; 732     enablestatus = (uint8_t)((uint8_t)UART1->CR2 & itmask2);
2387  038b c65235        	ld	a,21045
2388  038e 1402          	and	a,(OFST+0,sp)
2389  0390 6b02          	ld	(OFST+0,sp),a
2391                     ; 734     if (((UART1->SR & itpos) != (uint8_t)0x00) && enablestatus)
2393  0392 c65230        	ld	a,21040
2394  0395 1501          	bcp	a,(OFST-1,sp)
2395  0397 270a          	jreq	L1511
2397  0399 0d02          	tnz	(OFST+0,sp)
2398  039b 2706          	jreq	L1511
2399                     ; 737       pendingbitstatus = SET;
2401  039d a601          	ld	a,#1
2402  039f 6b02          	ld	(OFST+0,sp),a
2405  03a1 2002          	jra	L7311
2406  03a3               L1511:
2407                     ; 742       pendingbitstatus = RESET;
2409  03a3 0f02          	clr	(OFST+0,sp)
2411  03a5               L7311:
2412                     ; 747   return  pendingbitstatus;
2414  03a5 7b02          	ld	a,(OFST+0,sp)
2417  03a7 5b04          	addw	sp,#4
2418  03a9 87            	retf
2453                     ; 775 void UART1_ClearITPendingBit(UART1_IT_TypeDef UART1_IT)
2453                     ; 776 {
2454                     	switch	.text
2455  03aa               f_UART1_ClearITPendingBit:
2459                     ; 777   assert_param(IS_UART1_CLEAR_IT_OK(UART1_IT));
2461                     ; 780   if (UART1_IT == UART1_IT_RXNE)
2463  03aa a30255        	cpw	x,#597
2464  03ad 2606          	jrne	L3711
2465                     ; 782     UART1->SR = (uint8_t)~(UART1_SR_RXNE);
2467  03af 35df5230      	mov	21040,#223
2469  03b3 2004          	jra	L5711
2470  03b5               L3711:
2471                     ; 787     UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
2473  03b5 72195237      	bres	21047,#4
2474  03b9               L5711:
2475                     ; 789 }
2478  03b9 87            	retf
2490                     	xdef	f_UART1_ClearITPendingBit
2491                     	xdef	f_UART1_GetITStatus
2492                     	xdef	f_UART1_ClearFlag
2493                     	xdef	f_UART1_GetFlagStatus
2494                     	xdef	f_UART1_SetPrescaler
2495                     	xdef	f_UART1_SetGuardTime
2496                     	xdef	f_UART1_SetAddress
2497                     	xdef	f_UART1_SendBreak
2498                     	xdef	f_UART1_SendData9
2499                     	xdef	f_UART1_SendData8
2500                     	xdef	f_UART1_ReceiveData9
2501                     	xdef	f_UART1_ReceiveData8
2502                     	xdef	f_UART1_ReceiverWakeUpCmd
2503                     	xdef	f_UART1_WakeUpConfig
2504                     	xdef	f_UART1_SmartCardNACKCmd
2505                     	xdef	f_UART1_SmartCardCmd
2506                     	xdef	f_UART1_LINCmd
2507                     	xdef	f_UART1_LINBreakDetectionConfig
2508                     	xdef	f_UART1_IrDACmd
2509                     	xdef	f_UART1_IrDAConfig
2510                     	xdef	f_UART1_HalfDuplexCmd
2511                     	xdef	f_UART1_ITConfig
2512                     	xdef	f_UART1_Cmd
2513                     	xdef	f_UART1_Init
2514                     	xdef	f_UART1_DeInit
2515                     	xref	f_CLK_GetClockFreq
2516                     	xref.b	c_lreg
2517                     	xref.b	c_x
2536                     	xref	d_lsub
2537                     	xref	d_smul
2538                     	xref	d_ludv
2539                     	xref	d_rtol
2540                     	xref	d_llsh
2541                     	xref	d_ltor
2542                     	end
