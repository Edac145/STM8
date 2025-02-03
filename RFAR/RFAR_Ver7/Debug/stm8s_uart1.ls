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
 386                     .const:	section	.text
 387  0000               L01:
 388  0000 00000064      	dc.l	100
 389                     ; 90 void UART1_Init(uint32_t BaudRate, UART1_WordLength_TypeDef WordLength, 
 389                     ; 91                 UART1_StopBits_TypeDef StopBits, UART1_Parity_TypeDef Parity, 
 389                     ; 92                 UART1_SyncMode_TypeDef SyncMode, UART1_Mode_TypeDef Mode)
 389                     ; 93 {
 390                     	switch	.text
 391  002b               f_UART1_Init:
 393  002b 520c          	subw	sp,#12
 394       0000000c      OFST:	set	12
 397                     ; 94   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 401                     ; 97   assert_param(IS_UART1_BAUDRATE_OK(BaudRate));
 403                     ; 98   assert_param(IS_UART1_WORDLENGTH_OK(WordLength));
 405                     ; 99   assert_param(IS_UART1_STOPBITS_OK(StopBits));
 407                     ; 100   assert_param(IS_UART1_PARITY_OK(Parity));
 409                     ; 101   assert_param(IS_UART1_MODE_OK((uint8_t)Mode));
 411                     ; 102   assert_param(IS_UART1_SYNCMODE_OK((uint8_t)SyncMode));
 413                     ; 105   UART1->CR1 &= (uint8_t)(~UART1_CR1_M);  
 415  002d 72195234      	bres	21044,#4
 416                     ; 108   UART1->CR1 |= (uint8_t)WordLength;
 418  0031 c65234        	ld	a,21044
 419  0034 1a14          	or	a,(OFST+8,sp)
 420  0036 c75234        	ld	21044,a
 421                     ; 111   UART1->CR3 &= (uint8_t)(~UART1_CR3_STOP);  
 423  0039 c65236        	ld	a,21046
 424  003c a4cf          	and	a,#207
 425  003e c75236        	ld	21046,a
 426                     ; 113   UART1->CR3 |= (uint8_t)StopBits;  
 428  0041 c65236        	ld	a,21046
 429  0044 1a15          	or	a,(OFST+9,sp)
 430  0046 c75236        	ld	21046,a
 431                     ; 116   UART1->CR1 &= (uint8_t)(~(UART1_CR1_PCEN | UART1_CR1_PS  ));  
 433  0049 c65234        	ld	a,21044
 434  004c a4f9          	and	a,#249
 435  004e c75234        	ld	21044,a
 436                     ; 118   UART1->CR1 |= (uint8_t)Parity;  
 438  0051 c65234        	ld	a,21044
 439  0054 1a16          	or	a,(OFST+10,sp)
 440  0056 c75234        	ld	21044,a
 441                     ; 121   UART1->BRR1 &= (uint8_t)(~UART1_BRR1_DIVM);  
 443  0059 725f5232      	clr	21042
 444                     ; 123   UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVM);  
 446  005d c65233        	ld	a,21043
 447  0060 a40f          	and	a,#15
 448  0062 c75233        	ld	21043,a
 449                     ; 125   UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVF);  
 451  0065 c65233        	ld	a,21043
 452  0068 a4f0          	and	a,#240
 453  006a c75233        	ld	21043,a
 454                     ; 128   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 456  006d 96            	ldw	x,sp
 457  006e 1c0010        	addw	x,#OFST+4
 458  0071 8d000000      	callf	d_ltor
 460  0075 a604          	ld	a,#4
 461  0077 8d000000      	callf	d_llsh
 463  007b 96            	ldw	x,sp
 464  007c 1c0001        	addw	x,#OFST-11
 465  007f 8d000000      	callf	d_rtol
 468  0083 8d000000      	callf	f_CLK_GetClockFreq
 470  0087 96            	ldw	x,sp
 471  0088 1c0001        	addw	x,#OFST-11
 472  008b 8d000000      	callf	d_ludv
 474  008f 96            	ldw	x,sp
 475  0090 1c0009        	addw	x,#OFST-3
 476  0093 8d000000      	callf	d_rtol
 479                     ; 129   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 481  0097 96            	ldw	x,sp
 482  0098 1c0010        	addw	x,#OFST+4
 483  009b 8d000000      	callf	d_ltor
 485  009f a604          	ld	a,#4
 486  00a1 8d000000      	callf	d_llsh
 488  00a5 96            	ldw	x,sp
 489  00a6 1c0001        	addw	x,#OFST-11
 490  00a9 8d000000      	callf	d_rtol
 493  00ad 8d000000      	callf	f_CLK_GetClockFreq
 495  00b1 a664          	ld	a,#100
 496  00b3 8d000000      	callf	d_smul
 498  00b7 96            	ldw	x,sp
 499  00b8 1c0001        	addw	x,#OFST-11
 500  00bb 8d000000      	callf	d_ludv
 502  00bf 96            	ldw	x,sp
 503  00c0 1c0005        	addw	x,#OFST-7
 504  00c3 8d000000      	callf	d_rtol
 507                     ; 131   UART1->BRR2 |= (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100)) << 4) / 100) & (uint8_t)0x0F); 
 509  00c7 96            	ldw	x,sp
 510  00c8 1c0009        	addw	x,#OFST-3
 511  00cb 8d000000      	callf	d_ltor
 513  00cf a664          	ld	a,#100
 514  00d1 8d000000      	callf	d_smul
 516  00d5 96            	ldw	x,sp
 517  00d6 1c0001        	addw	x,#OFST-11
 518  00d9 8d000000      	callf	d_rtol
 521  00dd 96            	ldw	x,sp
 522  00de 1c0005        	addw	x,#OFST-7
 523  00e1 8d000000      	callf	d_ltor
 525  00e5 96            	ldw	x,sp
 526  00e6 1c0001        	addw	x,#OFST-11
 527  00e9 8d000000      	callf	d_lsub
 529  00ed a604          	ld	a,#4
 530  00ef 8d000000      	callf	d_llsh
 532  00f3 ae0000        	ldw	x,#L01
 533  00f6 8d000000      	callf	d_ludv
 535  00fa b603          	ld	a,c_lreg+3
 536  00fc a40f          	and	a,#15
 537  00fe ca5233        	or	a,21043
 538  0101 c75233        	ld	21043,a
 539                     ; 133   UART1->BRR2 |= (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0); 
 541  0104 1e0b          	ldw	x,(OFST-1,sp)
 542  0106 54            	srlw	x
 543  0107 54            	srlw	x
 544  0108 54            	srlw	x
 545  0109 54            	srlw	x
 546  010a 01            	rrwa	x,a
 547  010b a4f0          	and	a,#240
 548  010d 5f            	clrw	x
 549  010e ca5233        	or	a,21043
 550  0111 c75233        	ld	21043,a
 551                     ; 135   UART1->BRR1 |= (uint8_t)BaudRate_Mantissa;           
 553  0114 c65232        	ld	a,21042
 554  0117 1a0c          	or	a,(OFST+0,sp)
 555  0119 c75232        	ld	21042,a
 556                     ; 138   UART1->CR2 &= (uint8_t)~(UART1_CR2_TEN | UART1_CR2_REN); 
 558  011c c65235        	ld	a,21045
 559  011f a4f3          	and	a,#243
 560  0121 c75235        	ld	21045,a
 561                     ; 140   UART1->CR3 &= (uint8_t)~(UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL); 
 563  0124 c65236        	ld	a,21046
 564  0127 a4f8          	and	a,#248
 565  0129 c75236        	ld	21046,a
 566                     ; 142   UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART1_CR3_CPOL | 
 566                     ; 143                                                         UART1_CR3_CPHA | UART1_CR3_LBCL));  
 568  012c 7b17          	ld	a,(OFST+11,sp)
 569  012e a407          	and	a,#7
 570  0130 ca5236        	or	a,21046
 571  0133 c75236        	ld	21046,a
 572                     ; 145   if ((uint8_t)(Mode & UART1_MODE_TX_ENABLE))
 574  0136 7b18          	ld	a,(OFST+12,sp)
 575  0138 a504          	bcp	a,#4
 576  013a 2706          	jreq	L371
 577                     ; 148     UART1->CR2 |= (uint8_t)UART1_CR2_TEN;  
 579  013c 72165235      	bset	21045,#3
 581  0140 2004          	jra	L571
 582  0142               L371:
 583                     ; 153     UART1->CR2 &= (uint8_t)(~UART1_CR2_TEN);  
 585  0142 72175235      	bres	21045,#3
 586  0146               L571:
 587                     ; 155   if ((uint8_t)(Mode & UART1_MODE_RX_ENABLE))
 589  0146 7b18          	ld	a,(OFST+12,sp)
 590  0148 a508          	bcp	a,#8
 591  014a 2706          	jreq	L771
 592                     ; 158     UART1->CR2 |= (uint8_t)UART1_CR2_REN;  
 594  014c 72145235      	bset	21045,#2
 596  0150 2004          	jra	L102
 597  0152               L771:
 598                     ; 163     UART1->CR2 &= (uint8_t)(~UART1_CR2_REN);  
 600  0152 72155235      	bres	21045,#2
 601  0156               L102:
 602                     ; 167   if ((uint8_t)(SyncMode & UART1_SYNCMODE_CLOCK_DISABLE))
 604  0156 7b17          	ld	a,(OFST+11,sp)
 605  0158 a580          	bcp	a,#128
 606  015a 2706          	jreq	L302
 607                     ; 170     UART1->CR3 &= (uint8_t)(~UART1_CR3_CKEN); 
 609  015c 72175236      	bres	21046,#3
 611  0160 200a          	jra	L502
 612  0162               L302:
 613                     ; 174     UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & UART1_CR3_CKEN);
 615  0162 7b17          	ld	a,(OFST+11,sp)
 616  0164 a408          	and	a,#8
 617  0166 ca5236        	or	a,21046
 618  0169 c75236        	ld	21046,a
 619  016c               L502:
 620                     ; 176 }
 623  016c 5b0c          	addw	sp,#12
 624  016e 87            	retf
 678                     ; 184 void UART1_Cmd(FunctionalState NewState)
 678                     ; 185 {
 679                     	switch	.text
 680  016f               f_UART1_Cmd:
 684                     ; 186   if (NewState != DISABLE)
 686  016f 4d            	tnz	a
 687  0170 2706          	jreq	L532
 688                     ; 189     UART1->CR1 &= (uint8_t)(~UART1_CR1_UARTD); 
 690  0172 721b5234      	bres	21044,#5
 692  0176 2004          	jra	L732
 693  0178               L532:
 694                     ; 194     UART1->CR1 |= UART1_CR1_UARTD;  
 696  0178 721a5234      	bset	21044,#5
 697  017c               L732:
 698                     ; 196 }
 701  017c 87            	retf
 825                     ; 211 void UART1_ITConfig(UART1_IT_TypeDef UART1_IT, FunctionalState NewState)
 825                     ; 212 {
 826                     	switch	.text
 827  017d               f_UART1_ITConfig:
 829  017d 89            	pushw	x
 830  017e 89            	pushw	x
 831       00000002      OFST:	set	2
 834                     ; 213   uint8_t uartreg = 0, itpos = 0x00;
 838                     ; 216   assert_param(IS_UART1_CONFIG_IT_OK(UART1_IT));
 840                     ; 217   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 842                     ; 220   uartreg = (uint8_t)((uint16_t)UART1_IT >> 0x08);
 844  017f 9e            	ld	a,xh
 845  0180 6b01          	ld	(OFST-1,sp),a
 847                     ; 222   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART1_IT & (uint8_t)0x0F));
 849  0182 9f            	ld	a,xl
 850  0183 a40f          	and	a,#15
 851  0185 5f            	clrw	x
 852  0186 97            	ld	xl,a
 853  0187 a601          	ld	a,#1
 854  0189 5d            	tnzw	x
 855  018a 2704          	jreq	L61
 856  018c               L02:
 857  018c 48            	sll	a
 858  018d 5a            	decw	x
 859  018e 26fc          	jrne	L02
 860  0190               L61:
 861  0190 6b02          	ld	(OFST+0,sp),a
 863                     ; 224   if (NewState != DISABLE)
 865  0192 0d08          	tnz	(OFST+6,sp)
 866  0194 272a          	jreq	L713
 867                     ; 227     if (uartreg == 0x01)
 869  0196 7b01          	ld	a,(OFST-1,sp)
 870  0198 a101          	cp	a,#1
 871  019a 260a          	jrne	L123
 872                     ; 229       UART1->CR1 |= itpos;
 874  019c c65234        	ld	a,21044
 875  019f 1a02          	or	a,(OFST+0,sp)
 876  01a1 c75234        	ld	21044,a
 878  01a4 2045          	jra	L133
 879  01a6               L123:
 880                     ; 231     else if (uartreg == 0x02)
 882  01a6 7b01          	ld	a,(OFST-1,sp)
 883  01a8 a102          	cp	a,#2
 884  01aa 260a          	jrne	L523
 885                     ; 233       UART1->CR2 |= itpos;
 887  01ac c65235        	ld	a,21045
 888  01af 1a02          	or	a,(OFST+0,sp)
 889  01b1 c75235        	ld	21045,a
 891  01b4 2035          	jra	L133
 892  01b6               L523:
 893                     ; 237       UART1->CR4 |= itpos;
 895  01b6 c65237        	ld	a,21047
 896  01b9 1a02          	or	a,(OFST+0,sp)
 897  01bb c75237        	ld	21047,a
 898  01be 202b          	jra	L133
 899  01c0               L713:
 900                     ; 243     if (uartreg == 0x01)
 902  01c0 7b01          	ld	a,(OFST-1,sp)
 903  01c2 a101          	cp	a,#1
 904  01c4 260b          	jrne	L333
 905                     ; 245       UART1->CR1 &= (uint8_t)(~itpos);
 907  01c6 7b02          	ld	a,(OFST+0,sp)
 908  01c8 43            	cpl	a
 909  01c9 c45234        	and	a,21044
 910  01cc c75234        	ld	21044,a
 912  01cf 201a          	jra	L133
 913  01d1               L333:
 914                     ; 247     else if (uartreg == 0x02)
 916  01d1 7b01          	ld	a,(OFST-1,sp)
 917  01d3 a102          	cp	a,#2
 918  01d5 260b          	jrne	L733
 919                     ; 249       UART1->CR2 &= (uint8_t)(~itpos);
 921  01d7 7b02          	ld	a,(OFST+0,sp)
 922  01d9 43            	cpl	a
 923  01da c45235        	and	a,21045
 924  01dd c75235        	ld	21045,a
 926  01e0 2009          	jra	L133
 927  01e2               L733:
 928                     ; 253       UART1->CR4 &= (uint8_t)(~itpos);
 930  01e2 7b02          	ld	a,(OFST+0,sp)
 931  01e4 43            	cpl	a
 932  01e5 c45237        	and	a,21047
 933  01e8 c75237        	ld	21047,a
 934  01eb               L133:
 935                     ; 257 }
 938  01eb 5b04          	addw	sp,#4
 939  01ed 87            	retf
 974                     ; 265 void UART1_HalfDuplexCmd(FunctionalState NewState)
 974                     ; 266 {
 975                     	switch	.text
 976  01ee               f_UART1_HalfDuplexCmd:
 980                     ; 267   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 982                     ; 269   if (NewState != DISABLE)
 984  01ee 4d            	tnz	a
 985  01ef 2706          	jreq	L163
 986                     ; 271     UART1->CR5 |= UART1_CR5_HDSEL;  /**< UART1 Half Duplex Enable  */
 988  01f1 72165238      	bset	21048,#3
 990  01f5 2004          	jra	L363
 991  01f7               L163:
 992                     ; 275     UART1->CR5 &= (uint8_t)~UART1_CR5_HDSEL; /**< UART1 Half Duplex Disable */
 994  01f7 72175238      	bres	21048,#3
 995  01fb               L363:
 996                     ; 277 }
 999  01fb 87            	retf
1055                     ; 285 void UART1_IrDAConfig(UART1_IrDAMode_TypeDef UART1_IrDAMode)
1055                     ; 286 {
1056                     	switch	.text
1057  01fc               f_UART1_IrDAConfig:
1061                     ; 287   assert_param(IS_UART1_IRDAMODE_OK(UART1_IrDAMode));
1063                     ; 289   if (UART1_IrDAMode != UART1_IRDAMODE_NORMAL)
1065  01fc 4d            	tnz	a
1066  01fd 2706          	jreq	L314
1067                     ; 291     UART1->CR5 |= UART1_CR5_IRLP;
1069  01ff 72145238      	bset	21048,#2
1071  0203 2004          	jra	L514
1072  0205               L314:
1073                     ; 295     UART1->CR5 &= ((uint8_t)~UART1_CR5_IRLP);
1075  0205 72155238      	bres	21048,#2
1076  0209               L514:
1077                     ; 297 }
1080  0209 87            	retf
1114                     ; 305 void UART1_IrDACmd(FunctionalState NewState)
1114                     ; 306 {
1115                     	switch	.text
1116  020a               f_UART1_IrDACmd:
1120                     ; 308   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1122                     ; 310   if (NewState != DISABLE)
1124  020a 4d            	tnz	a
1125  020b 2706          	jreq	L534
1126                     ; 313     UART1->CR5 |= UART1_CR5_IREN;
1128  020d 72125238      	bset	21048,#1
1130  0211 2004          	jra	L734
1131  0213               L534:
1132                     ; 318     UART1->CR5 &= ((uint8_t)~UART1_CR5_IREN);
1134  0213 72135238      	bres	21048,#1
1135  0217               L734:
1136                     ; 320 }
1139  0217 87            	retf
1197                     ; 329 void UART1_LINBreakDetectionConfig(UART1_LINBreakDetectionLength_TypeDef UART1_LINBreakDetectionLength)
1197                     ; 330 {
1198                     	switch	.text
1199  0218               f_UART1_LINBreakDetectionConfig:
1203                     ; 331   assert_param(IS_UART1_LINBREAKDETECTIONLENGTH_OK(UART1_LINBreakDetectionLength));
1205                     ; 333   if (UART1_LINBreakDetectionLength != UART1_LINBREAKDETECTIONLENGTH_10BITS)
1207  0218 4d            	tnz	a
1208  0219 2706          	jreq	L764
1209                     ; 335     UART1->CR4 |= UART1_CR4_LBDL;
1211  021b 721a5237      	bset	21047,#5
1213  021f 2004          	jra	L174
1214  0221               L764:
1215                     ; 339     UART1->CR4 &= ((uint8_t)~UART1_CR4_LBDL);
1217  0221 721b5237      	bres	21047,#5
1218  0225               L174:
1219                     ; 341 }
1222  0225 87            	retf
1256                     ; 349 void UART1_LINCmd(FunctionalState NewState)
1256                     ; 350 {
1257                     	switch	.text
1258  0226               f_UART1_LINCmd:
1262                     ; 351   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1264                     ; 353   if (NewState != DISABLE)
1266  0226 4d            	tnz	a
1267  0227 2706          	jreq	L115
1268                     ; 356     UART1->CR3 |= UART1_CR3_LINEN;
1270  0229 721c5236      	bset	21046,#6
1272  022d 2004          	jra	L315
1273  022f               L115:
1274                     ; 361     UART1->CR3 &= ((uint8_t)~UART1_CR3_LINEN);
1276  022f 721d5236      	bres	21046,#6
1277  0233               L315:
1278                     ; 363 }
1281  0233 87            	retf
1315                     ; 371 void UART1_SmartCardCmd(FunctionalState NewState)
1315                     ; 372 {
1316                     	switch	.text
1317  0234               f_UART1_SmartCardCmd:
1321                     ; 373   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1323                     ; 375   if (NewState != DISABLE)
1325  0234 4d            	tnz	a
1326  0235 2706          	jreq	L335
1327                     ; 378     UART1->CR5 |= UART1_CR5_SCEN;
1329  0237 721a5238      	bset	21048,#5
1331  023b 2004          	jra	L535
1332  023d               L335:
1333                     ; 383     UART1->CR5 &= ((uint8_t)(~UART1_CR5_SCEN));
1335  023d 721b5238      	bres	21048,#5
1336  0241               L535:
1337                     ; 385 }
1340  0241 87            	retf
1375                     ; 394 void UART1_SmartCardNACKCmd(FunctionalState NewState)
1375                     ; 395 {
1376                     	switch	.text
1377  0242               f_UART1_SmartCardNACKCmd:
1381                     ; 396   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1383                     ; 398   if (NewState != DISABLE)
1385  0242 4d            	tnz	a
1386  0243 2706          	jreq	L555
1387                     ; 401     UART1->CR5 |= UART1_CR5_NACK;
1389  0245 72185238      	bset	21048,#4
1391  0249 2004          	jra	L755
1392  024b               L555:
1393                     ; 406     UART1->CR5 &= ((uint8_t)~(UART1_CR5_NACK));
1395  024b 72195238      	bres	21048,#4
1396  024f               L755:
1397                     ; 408 }
1400  024f 87            	retf
1456                     ; 416 void UART1_WakeUpConfig(UART1_WakeUp_TypeDef UART1_WakeUp)
1456                     ; 417 {
1457                     	switch	.text
1458  0250               f_UART1_WakeUpConfig:
1462                     ; 418   assert_param(IS_UART1_WAKEUP_OK(UART1_WakeUp));
1464                     ; 420   UART1->CR1 &= ((uint8_t)~UART1_CR1_WAKE);
1466  0250 72175234      	bres	21044,#3
1467                     ; 421   UART1->CR1 |= (uint8_t)UART1_WakeUp;
1469  0254 ca5234        	or	a,21044
1470  0257 c75234        	ld	21044,a
1471                     ; 422 }
1474  025a 87            	retf
1509                     ; 430 void UART1_ReceiverWakeUpCmd(FunctionalState NewState)
1509                     ; 431 {
1510                     	switch	.text
1511  025b               f_UART1_ReceiverWakeUpCmd:
1515                     ; 432   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1517                     ; 434   if (NewState != DISABLE)
1519  025b 4d            	tnz	a
1520  025c 2706          	jreq	L526
1521                     ; 437     UART1->CR2 |= UART1_CR2_RWU;
1523  025e 72125235      	bset	21045,#1
1525  0262 2004          	jra	L726
1526  0264               L526:
1527                     ; 442     UART1->CR2 &= ((uint8_t)~UART1_CR2_RWU);
1529  0264 72135235      	bres	21045,#1
1530  0268               L726:
1531                     ; 444 }
1534  0268 87            	retf
1556                     ; 451 uint8_t UART1_ReceiveData8(void)
1556                     ; 452 {
1557                     	switch	.text
1558  0269               f_UART1_ReceiveData8:
1562                     ; 453   return ((uint8_t)UART1->DR);
1564  0269 c65231        	ld	a,21041
1567  026c 87            	retf
1600                     ; 461 uint16_t UART1_ReceiveData9(void)
1600                     ; 462 {
1601                     	switch	.text
1602  026d               f_UART1_ReceiveData9:
1604  026d 89            	pushw	x
1605       00000002      OFST:	set	2
1608                     ; 463   uint16_t temp = 0;
1610                     ; 465   temp = (uint16_t)(((uint16_t)( (uint16_t)UART1->CR1 & (uint16_t)UART1_CR1_R8)) << 1);
1612  026e c65234        	ld	a,21044
1613  0271 5f            	clrw	x
1614  0272 a480          	and	a,#128
1615  0274 5f            	clrw	x
1616  0275 02            	rlwa	x,a
1617  0276 58            	sllw	x
1618  0277 1f01          	ldw	(OFST-1,sp),x
1620                     ; 466   return (uint16_t)( (((uint16_t) UART1->DR) | temp ) & ((uint16_t)0x01FF));
1622  0279 c65231        	ld	a,21041
1623  027c 5f            	clrw	x
1624  027d 97            	ld	xl,a
1625  027e 01            	rrwa	x,a
1626  027f 1a02          	or	a,(OFST+0,sp)
1627  0281 01            	rrwa	x,a
1628  0282 1a01          	or	a,(OFST-1,sp)
1629  0284 01            	rrwa	x,a
1630  0285 01            	rrwa	x,a
1631  0286 a4ff          	and	a,#255
1632  0288 01            	rrwa	x,a
1633  0289 a401          	and	a,#1
1634  028b 01            	rrwa	x,a
1637  028c 5b02          	addw	sp,#2
1638  028e 87            	retf
1671                     ; 474 void UART1_SendData8(uint8_t Data)
1671                     ; 475 {
1672                     	switch	.text
1673  028f               f_UART1_SendData8:
1677                     ; 477   UART1->DR = Data;
1679  028f c75231        	ld	21041,a
1680                     ; 478 }
1683  0292 87            	retf
1716                     ; 486 void UART1_SendData9(uint16_t Data)
1716                     ; 487 {
1717                     	switch	.text
1718  0293               f_UART1_SendData9:
1720  0293 89            	pushw	x
1721       00000000      OFST:	set	0
1724                     ; 489   UART1->CR1 &= ((uint8_t)~UART1_CR1_T8);
1726  0294 721d5234      	bres	21044,#6
1727                     ; 491   UART1->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART1_CR1_T8);
1729  0298 54            	srlw	x
1730  0299 54            	srlw	x
1731  029a 9f            	ld	a,xl
1732  029b a440          	and	a,#64
1733  029d ca5234        	or	a,21044
1734  02a0 c75234        	ld	21044,a
1735                     ; 493   UART1->DR   = (uint8_t)(Data);
1737  02a3 7b02          	ld	a,(OFST+2,sp)
1738  02a5 c75231        	ld	21041,a
1739                     ; 494 }
1742  02a8 85            	popw	x
1743  02a9 87            	retf
1765                     ; 501 void UART1_SendBreak(void)
1765                     ; 502 {
1766                     	switch	.text
1767  02aa               f_UART1_SendBreak:
1771                     ; 503   UART1->CR2 |= UART1_CR2_SBK;
1773  02aa 72105235      	bset	21045,#0
1774                     ; 504 }
1777  02ae 87            	retf
1810                     ; 511 void UART1_SetAddress(uint8_t UART1_Address)
1810                     ; 512 {
1811                     	switch	.text
1812  02af               f_UART1_SetAddress:
1814  02af 88            	push	a
1815       00000000      OFST:	set	0
1818                     ; 514   assert_param(IS_UART1_ADDRESS_OK(UART1_Address));
1820                     ; 517   UART1->CR4 &= ((uint8_t)~UART1_CR4_ADD);
1822  02b0 c65237        	ld	a,21047
1823  02b3 a4f0          	and	a,#240
1824  02b5 c75237        	ld	21047,a
1825                     ; 519   UART1->CR4 |= UART1_Address;
1827  02b8 c65237        	ld	a,21047
1828  02bb 1a01          	or	a,(OFST+1,sp)
1829  02bd c75237        	ld	21047,a
1830                     ; 520 }
1833  02c0 84            	pop	a
1834  02c1 87            	retf
1867                     ; 528 void UART1_SetGuardTime(uint8_t UART1_GuardTime)
1867                     ; 529 {
1868                     	switch	.text
1869  02c2               f_UART1_SetGuardTime:
1873                     ; 531   UART1->GTR = UART1_GuardTime;
1875  02c2 c75239        	ld	21049,a
1876                     ; 532 }
1879  02c5 87            	retf
1912                     ; 556 void UART1_SetPrescaler(uint8_t UART1_Prescaler)
1912                     ; 557 {
1913                     	switch	.text
1914  02c6               f_UART1_SetPrescaler:
1918                     ; 559   UART1->PSCR = UART1_Prescaler;
1920  02c6 c7523a        	ld	21050,a
1921                     ; 560 }
1924  02c9 87            	retf
2066                     ; 568 FlagStatus UART1_GetFlagStatus(UART1_Flag_TypeDef UART1_FLAG)
2066                     ; 569 {
2067                     	switch	.text
2068  02ca               f_UART1_GetFlagStatus:
2070  02ca 89            	pushw	x
2071  02cb 88            	push	a
2072       00000001      OFST:	set	1
2075                     ; 570   FlagStatus status = RESET;
2077                     ; 573   assert_param(IS_UART1_FLAG_OK(UART1_FLAG));
2079                     ; 577   if (UART1_FLAG == UART1_FLAG_LBDF)
2081  02cc a30210        	cpw	x,#528
2082  02cf 2610          	jrne	L7501
2083                     ; 579     if ((UART1->CR4 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2085  02d1 9f            	ld	a,xl
2086  02d2 c45237        	and	a,21047
2087  02d5 2706          	jreq	L1601
2088                     ; 582       status = SET;
2090  02d7 a601          	ld	a,#1
2091  02d9 6b01          	ld	(OFST+0,sp),a
2094  02db 202b          	jra	L5601
2095  02dd               L1601:
2096                     ; 587       status = RESET;
2098  02dd 0f01          	clr	(OFST+0,sp)
2100  02df 2027          	jra	L5601
2101  02e1               L7501:
2102                     ; 590   else if (UART1_FLAG == UART1_FLAG_SBK)
2104  02e1 1e02          	ldw	x,(OFST+1,sp)
2105  02e3 a30101        	cpw	x,#257
2106  02e6 2611          	jrne	L7601
2107                     ; 592     if ((UART1->CR2 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2109  02e8 c65235        	ld	a,21045
2110  02eb 1503          	bcp	a,(OFST+2,sp)
2111  02ed 2706          	jreq	L1701
2112                     ; 595       status = SET;
2114  02ef a601          	ld	a,#1
2115  02f1 6b01          	ld	(OFST+0,sp),a
2118  02f3 2013          	jra	L5601
2119  02f5               L1701:
2120                     ; 600       status = RESET;
2122  02f5 0f01          	clr	(OFST+0,sp)
2124  02f7 200f          	jra	L5601
2125  02f9               L7601:
2126                     ; 605     if ((UART1->SR & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2128  02f9 c65230        	ld	a,21040
2129  02fc 1503          	bcp	a,(OFST+2,sp)
2130  02fe 2706          	jreq	L7701
2131                     ; 608       status = SET;
2133  0300 a601          	ld	a,#1
2134  0302 6b01          	ld	(OFST+0,sp),a
2137  0304 2002          	jra	L5601
2138  0306               L7701:
2139                     ; 613       status = RESET;
2141  0306 0f01          	clr	(OFST+0,sp)
2143  0308               L5601:
2144                     ; 617   return status;
2146  0308 7b01          	ld	a,(OFST+0,sp)
2149  030a 5b03          	addw	sp,#3
2150  030c 87            	retf
2184                     ; 646 void UART1_ClearFlag(UART1_Flag_TypeDef UART1_FLAG)
2184                     ; 647 {
2185                     	switch	.text
2186  030d               f_UART1_ClearFlag:
2190                     ; 648   assert_param(IS_UART1_CLEAR_FLAG_OK(UART1_FLAG));
2192                     ; 651   if (UART1_FLAG == UART1_FLAG_RXNE)
2194  030d a30020        	cpw	x,#32
2195  0310 2606          	jrne	L1211
2196                     ; 653     UART1->SR = (uint8_t)~(UART1_SR_RXNE);
2198  0312 35df5230      	mov	21040,#223
2200  0316 2004          	jra	L3211
2201  0318               L1211:
2202                     ; 658     UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
2204  0318 72195237      	bres	21047,#4
2205  031c               L3211:
2206                     ; 660 }
2209  031c 87            	retf
2290                     ; 675 ITStatus UART1_GetITStatus(UART1_IT_TypeDef UART1_IT)
2290                     ; 676 {
2291                     	switch	.text
2292  031d               f_UART1_GetITStatus:
2294  031d 89            	pushw	x
2295  031e 89            	pushw	x
2296       00000002      OFST:	set	2
2299                     ; 677   ITStatus pendingbitstatus = RESET;
2301                     ; 678   uint8_t itpos = 0;
2303                     ; 679   uint8_t itmask1 = 0;
2305                     ; 680   uint8_t itmask2 = 0;
2307                     ; 681   uint8_t enablestatus = 0;
2309                     ; 684   assert_param(IS_UART1_GET_IT_OK(UART1_IT));
2311                     ; 687   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART1_IT & (uint8_t)0x0F));
2313  031f 9f            	ld	a,xl
2314  0320 a40f          	and	a,#15
2315  0322 5f            	clrw	x
2316  0323 97            	ld	xl,a
2317  0324 a601          	ld	a,#1
2318  0326 5d            	tnzw	x
2319  0327 2704          	jreq	L27
2320  0329               L47:
2321  0329 48            	sll	a
2322  032a 5a            	decw	x
2323  032b 26fc          	jrne	L47
2324  032d               L27:
2325  032d 6b01          	ld	(OFST-1,sp),a
2327                     ; 689   itmask1 = (uint8_t)((uint8_t)UART1_IT >> (uint8_t)4);
2329  032f 7b04          	ld	a,(OFST+2,sp)
2330  0331 4e            	swap	a
2331  0332 a40f          	and	a,#15
2332  0334 6b02          	ld	(OFST+0,sp),a
2334                     ; 691   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2336  0336 7b02          	ld	a,(OFST+0,sp)
2337  0338 5f            	clrw	x
2338  0339 97            	ld	xl,a
2339  033a a601          	ld	a,#1
2340  033c 5d            	tnzw	x
2341  033d 2704          	jreq	L67
2342  033f               L001:
2343  033f 48            	sll	a
2344  0340 5a            	decw	x
2345  0341 26fc          	jrne	L001
2346  0343               L67:
2347  0343 6b02          	ld	(OFST+0,sp),a
2349                     ; 695   if (UART1_IT == UART1_IT_PE)
2351  0345 1e03          	ldw	x,(OFST+1,sp)
2352  0347 a30100        	cpw	x,#256
2353  034a 261c          	jrne	L7611
2354                     ; 698     enablestatus = (uint8_t)((uint8_t)UART1->CR1 & itmask2);
2356  034c c65234        	ld	a,21044
2357  034f 1402          	and	a,(OFST+0,sp)
2358  0351 6b02          	ld	(OFST+0,sp),a
2360                     ; 701     if (((UART1->SR & itpos) != (uint8_t)0x00) && enablestatus)
2362  0353 c65230        	ld	a,21040
2363  0356 1501          	bcp	a,(OFST-1,sp)
2364  0358 270a          	jreq	L1711
2366  035a 0d02          	tnz	(OFST+0,sp)
2367  035c 2706          	jreq	L1711
2368                     ; 704       pendingbitstatus = SET;
2370  035e a601          	ld	a,#1
2371  0360 6b02          	ld	(OFST+0,sp),a
2374  0362 2041          	jra	L5711
2375  0364               L1711:
2376                     ; 709       pendingbitstatus = RESET;
2378  0364 0f02          	clr	(OFST+0,sp)
2380  0366 203d          	jra	L5711
2381  0368               L7611:
2382                     ; 713   else if (UART1_IT == UART1_IT_LBDF)
2384  0368 1e03          	ldw	x,(OFST+1,sp)
2385  036a a30346        	cpw	x,#838
2386  036d 261c          	jrne	L7711
2387                     ; 716     enablestatus = (uint8_t)((uint8_t)UART1->CR4 & itmask2);
2389  036f c65237        	ld	a,21047
2390  0372 1402          	and	a,(OFST+0,sp)
2391  0374 6b02          	ld	(OFST+0,sp),a
2393                     ; 718     if (((UART1->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2395  0376 c65237        	ld	a,21047
2396  0379 1501          	bcp	a,(OFST-1,sp)
2397  037b 270a          	jreq	L1021
2399  037d 0d02          	tnz	(OFST+0,sp)
2400  037f 2706          	jreq	L1021
2401                     ; 721       pendingbitstatus = SET;
2403  0381 a601          	ld	a,#1
2404  0383 6b02          	ld	(OFST+0,sp),a
2407  0385 201e          	jra	L5711
2408  0387               L1021:
2409                     ; 726       pendingbitstatus = RESET;
2411  0387 0f02          	clr	(OFST+0,sp)
2413  0389 201a          	jra	L5711
2414  038b               L7711:
2415                     ; 732     enablestatus = (uint8_t)((uint8_t)UART1->CR2 & itmask2);
2417  038b c65235        	ld	a,21045
2418  038e 1402          	and	a,(OFST+0,sp)
2419  0390 6b02          	ld	(OFST+0,sp),a
2421                     ; 734     if (((UART1->SR & itpos) != (uint8_t)0x00) && enablestatus)
2423  0392 c65230        	ld	a,21040
2424  0395 1501          	bcp	a,(OFST-1,sp)
2425  0397 270a          	jreq	L7021
2427  0399 0d02          	tnz	(OFST+0,sp)
2428  039b 2706          	jreq	L7021
2429                     ; 737       pendingbitstatus = SET;
2431  039d a601          	ld	a,#1
2432  039f 6b02          	ld	(OFST+0,sp),a
2435  03a1 2002          	jra	L5711
2436  03a3               L7021:
2437                     ; 742       pendingbitstatus = RESET;
2439  03a3 0f02          	clr	(OFST+0,sp)
2441  03a5               L5711:
2442                     ; 747   return  pendingbitstatus;
2444  03a5 7b02          	ld	a,(OFST+0,sp)
2447  03a7 5b04          	addw	sp,#4
2448  03a9 87            	retf
2483                     ; 775 void UART1_ClearITPendingBit(UART1_IT_TypeDef UART1_IT)
2483                     ; 776 {
2484                     	switch	.text
2485  03aa               f_UART1_ClearITPendingBit:
2489                     ; 777   assert_param(IS_UART1_CLEAR_IT_OK(UART1_IT));
2491                     ; 780   if (UART1_IT == UART1_IT_RXNE)
2493  03aa a30255        	cpw	x,#597
2494  03ad 2606          	jrne	L1321
2495                     ; 782     UART1->SR = (uint8_t)~(UART1_SR_RXNE);
2497  03af 35df5230      	mov	21040,#223
2499  03b3 2004          	jra	L3321
2500  03b5               L1321:
2501                     ; 787     UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
2503  03b5 72195237      	bres	21047,#4
2504  03b9               L3321:
2505                     ; 789 }
2508  03b9 87            	retf
2520                     	xdef	f_UART1_ClearITPendingBit
2521                     	xdef	f_UART1_GetITStatus
2522                     	xdef	f_UART1_ClearFlag
2523                     	xdef	f_UART1_GetFlagStatus
2524                     	xdef	f_UART1_SetPrescaler
2525                     	xdef	f_UART1_SetGuardTime
2526                     	xdef	f_UART1_SetAddress
2527                     	xdef	f_UART1_SendBreak
2528                     	xdef	f_UART1_SendData9
2529                     	xdef	f_UART1_SendData8
2530                     	xdef	f_UART1_ReceiveData9
2531                     	xdef	f_UART1_ReceiveData8
2532                     	xdef	f_UART1_ReceiverWakeUpCmd
2533                     	xdef	f_UART1_WakeUpConfig
2534                     	xdef	f_UART1_SmartCardNACKCmd
2535                     	xdef	f_UART1_SmartCardCmd
2536                     	xdef	f_UART1_LINCmd
2537                     	xdef	f_UART1_LINBreakDetectionConfig
2538                     	xdef	f_UART1_IrDACmd
2539                     	xdef	f_UART1_IrDAConfig
2540                     	xdef	f_UART1_HalfDuplexCmd
2541                     	xdef	f_UART1_ITConfig
2542                     	xdef	f_UART1_Cmd
2543                     	xdef	f_UART1_Init
2544                     	xdef	f_UART1_DeInit
2545                     	xref	f_CLK_GetClockFreq
2546                     	xref.b	c_lreg
2547                     	xref.b	c_x
2566                     	xref	d_lsub
2567                     	xref	d_smul
2568                     	xref	d_ludv
2569                     	xref	d_rtol
2570                     	xref	d_llsh
2571                     	xref	d_ltor
2572                     	end
