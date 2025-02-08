   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  42                     ; 54 void UART3_DeInit(void)
  42                     ; 55 {
  43                     	switch	.text
  44  0000               f_UART3_DeInit:
  48                     ; 58   (void) UART3->SR;
  50  0000 c65240        	ld	a,21056
  51                     ; 59   (void) UART3->DR;
  53  0003 c65241        	ld	a,21057
  54                     ; 61   UART3->BRR2 = UART3_BRR2_RESET_VALUE; /*Set UART3_BRR2 to reset value 0x00 */
  56  0006 725f5243      	clr	21059
  57                     ; 62   UART3->BRR1 = UART3_BRR1_RESET_VALUE; /*Set UART3_BRR1 to reset value 0x00 */
  59  000a 725f5242      	clr	21058
  60                     ; 64   UART3->CR1 = UART3_CR1_RESET_VALUE;  /*Set UART3_CR1 to reset value 0x00  */
  62  000e 725f5244      	clr	21060
  63                     ; 65   UART3->CR2 = UART3_CR2_RESET_VALUE;  /*Set UART3_CR2 to reset value 0x00  */
  65  0012 725f5245      	clr	21061
  66                     ; 66   UART3->CR3 = UART3_CR3_RESET_VALUE;  /*Set UART3_CR3 to reset value 0x00  */
  68  0016 725f5246      	clr	21062
  69                     ; 67   UART3->CR4 = UART3_CR4_RESET_VALUE;  /*Set UART3_CR4 to reset value 0x00  */
  71  001a 725f5247      	clr	21063
  72                     ; 68   UART3->CR6 = UART3_CR6_RESET_VALUE;  /*Set UART3_CR6 to reset value 0x00  */
  74  001e 725f5249      	clr	21065
  75                     ; 69 }
  78  0022 87            	retf
 294                     .const:	section	.text
 295  0000               L01:
 296  0000 00000064      	dc.l	100
 297                     ; 83 void UART3_Init(uint32_t BaudRate, UART3_WordLength_TypeDef WordLength, 
 297                     ; 84                 UART3_StopBits_TypeDef StopBits, UART3_Parity_TypeDef Parity, 
 297                     ; 85                 UART3_Mode_TypeDef Mode)
 297                     ; 86 {
 298                     	switch	.text
 299  0023               f_UART3_Init:
 301  0023 520e          	subw	sp,#14
 302       0000000e      OFST:	set	14
 305                     ; 87   uint8_t BRR2_1 = 0, BRR2_2 = 0;
 309                     ; 88   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 313                     ; 91   assert_param(IS_UART3_WORDLENGTH_OK(WordLength));
 315                     ; 92   assert_param(IS_UART3_STOPBITS_OK(StopBits));
 317                     ; 93   assert_param(IS_UART3_PARITY_OK(Parity));
 319                     ; 94   assert_param(IS_UART3_BAUDRATE_OK(BaudRate));
 321                     ; 95   assert_param(IS_UART3_MODE_OK((uint8_t)Mode));
 323                     ; 98   UART3->CR1 &= (uint8_t)(~UART3_CR1_M);     
 325  0025 72195244      	bres	21060,#4
 326                     ; 100   UART3->CR1 |= (uint8_t)WordLength; 
 328  0029 c65244        	ld	a,21060
 329  002c 1a16          	or	a,(OFST+8,sp)
 330  002e c75244        	ld	21060,a
 331                     ; 103   UART3->CR3 &= (uint8_t)(~UART3_CR3_STOP);  
 333  0031 c65246        	ld	a,21062
 334  0034 a4cf          	and	a,#207
 335  0036 c75246        	ld	21062,a
 336                     ; 105   UART3->CR3 |= (uint8_t)StopBits;  
 338  0039 c65246        	ld	a,21062
 339  003c 1a17          	or	a,(OFST+9,sp)
 340  003e c75246        	ld	21062,a
 341                     ; 108   UART3->CR1 &= (uint8_t)(~(UART3_CR1_PCEN | UART3_CR1_PS));  
 343  0041 c65244        	ld	a,21060
 344  0044 a4f9          	and	a,#249
 345  0046 c75244        	ld	21060,a
 346                     ; 110   UART3->CR1 |= (uint8_t)Parity;     
 348  0049 c65244        	ld	a,21060
 349  004c 1a18          	or	a,(OFST+10,sp)
 350  004e c75244        	ld	21060,a
 351                     ; 113   UART3->BRR1 &= (uint8_t)(~UART3_BRR1_DIVM);  
 353  0051 725f5242      	clr	21058
 354                     ; 115   UART3->BRR2 &= (uint8_t)(~UART3_BRR2_DIVM);  
 356  0055 c65243        	ld	a,21059
 357  0058 a40f          	and	a,#15
 358  005a c75243        	ld	21059,a
 359                     ; 117   UART3->BRR2 &= (uint8_t)(~UART3_BRR2_DIVF);  
 361  005d c65243        	ld	a,21059
 362  0060 a4f0          	and	a,#240
 363  0062 c75243        	ld	21059,a
 364                     ; 120   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 366  0065 96            	ldw	x,sp
 367  0066 1c0012        	addw	x,#OFST+4
 368  0069 8d000000      	callf	d_ltor
 370  006d a604          	ld	a,#4
 371  006f 8d000000      	callf	d_llsh
 373  0073 96            	ldw	x,sp
 374  0074 1c0001        	addw	x,#OFST-13
 375  0077 8d000000      	callf	d_rtol
 378  007b 8d000000      	callf	f_CLK_GetClockFreq
 380  007f 96            	ldw	x,sp
 381  0080 1c0001        	addw	x,#OFST-13
 382  0083 8d000000      	callf	d_ludv
 384  0087 96            	ldw	x,sp
 385  0088 1c000b        	addw	x,#OFST-3
 386  008b 8d000000      	callf	d_rtol
 389                     ; 121   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 391  008f 96            	ldw	x,sp
 392  0090 1c0012        	addw	x,#OFST+4
 393  0093 8d000000      	callf	d_ltor
 395  0097 a604          	ld	a,#4
 396  0099 8d000000      	callf	d_llsh
 398  009d 96            	ldw	x,sp
 399  009e 1c0001        	addw	x,#OFST-13
 400  00a1 8d000000      	callf	d_rtol
 403  00a5 8d000000      	callf	f_CLK_GetClockFreq
 405  00a9 a664          	ld	a,#100
 406  00ab 8d000000      	callf	d_smul
 408  00af 96            	ldw	x,sp
 409  00b0 1c0001        	addw	x,#OFST-13
 410  00b3 8d000000      	callf	d_ludv
 412  00b7 96            	ldw	x,sp
 413  00b8 1c0007        	addw	x,#OFST-7
 414  00bb 8d000000      	callf	d_rtol
 417                     ; 124   BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 417                     ; 125                                 << 4) / 100) & (uint8_t)0x0F); 
 419  00bf 96            	ldw	x,sp
 420  00c0 1c000b        	addw	x,#OFST-3
 421  00c3 8d000000      	callf	d_ltor
 423  00c7 a664          	ld	a,#100
 424  00c9 8d000000      	callf	d_smul
 426  00cd 96            	ldw	x,sp
 427  00ce 1c0001        	addw	x,#OFST-13
 428  00d1 8d000000      	callf	d_rtol
 431  00d5 96            	ldw	x,sp
 432  00d6 1c0007        	addw	x,#OFST-7
 433  00d9 8d000000      	callf	d_ltor
 435  00dd 96            	ldw	x,sp
 436  00de 1c0001        	addw	x,#OFST-13
 437  00e1 8d000000      	callf	d_lsub
 439  00e5 a604          	ld	a,#4
 440  00e7 8d000000      	callf	d_llsh
 442  00eb ae0000        	ldw	x,#L01
 443  00ee 8d000000      	callf	d_ludv
 445  00f2 b603          	ld	a,c_lreg+3
 446  00f4 a40f          	and	a,#15
 447  00f6 6b05          	ld	(OFST-9,sp),a
 449                     ; 126   BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 451  00f8 1e0d          	ldw	x,(OFST-1,sp)
 452  00fa 54            	srlw	x
 453  00fb 54            	srlw	x
 454  00fc 54            	srlw	x
 455  00fd 54            	srlw	x
 456  00fe 01            	rrwa	x,a
 457  00ff a4f0          	and	a,#240
 458  0101 5f            	clrw	x
 459  0102 6b06          	ld	(OFST-8,sp),a
 461                     ; 128   UART3->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 463  0104 7b05          	ld	a,(OFST-9,sp)
 464  0106 1a06          	or	a,(OFST-8,sp)
 465  0108 c75243        	ld	21059,a
 466                     ; 130   UART3->BRR1 = (uint8_t)BaudRate_Mantissa;           
 468  010b 7b0e          	ld	a,(OFST+0,sp)
 469  010d c75242        	ld	21058,a
 470                     ; 132   if ((uint8_t)(Mode & UART3_MODE_TX_ENABLE))
 472  0110 7b19          	ld	a,(OFST+11,sp)
 473  0112 a504          	bcp	a,#4
 474  0114 2706          	jreq	L531
 475                     ; 135     UART3->CR2 |= UART3_CR2_TEN;  
 477  0116 72165245      	bset	21061,#3
 479  011a 2004          	jra	L731
 480  011c               L531:
 481                     ; 140     UART3->CR2 &= (uint8_t)(~UART3_CR2_TEN);  
 483  011c 72175245      	bres	21061,#3
 484  0120               L731:
 485                     ; 142   if ((uint8_t)(Mode & UART3_MODE_RX_ENABLE))
 487  0120 7b19          	ld	a,(OFST+11,sp)
 488  0122 a508          	bcp	a,#8
 489  0124 2706          	jreq	L141
 490                     ; 145     UART3->CR2 |= UART3_CR2_REN;  
 492  0126 72145245      	bset	21061,#2
 494  012a 2004          	jra	L341
 495  012c               L141:
 496                     ; 150     UART3->CR2 &= (uint8_t)(~UART3_CR2_REN);  
 498  012c 72155245      	bres	21061,#2
 499  0130               L341:
 500                     ; 152 }
 503  0130 5b0e          	addw	sp,#14
 504  0132 87            	retf
 558                     ; 160 void UART3_Cmd(FunctionalState NewState)
 558                     ; 161 {
 559                     	switch	.text
 560  0133               f_UART3_Cmd:
 564                     ; 162   if (NewState != DISABLE)
 566  0133 4d            	tnz	a
 567  0134 2706          	jreq	L371
 568                     ; 165     UART3->CR1 &= (uint8_t)(~UART3_CR1_UARTD); 
 570  0136 721b5244      	bres	21060,#5
 572  013a 2004          	jra	L571
 573  013c               L371:
 574                     ; 170     UART3->CR1 |= UART3_CR1_UARTD;  
 576  013c 721a5244      	bset	21060,#5
 577  0140               L571:
 578                     ; 172 }
 581  0140 87            	retf
 708                     ; 189 void UART3_ITConfig(UART3_IT_TypeDef UART3_IT, FunctionalState NewState)
 708                     ; 190 {
 709                     	switch	.text
 710  0141               f_UART3_ITConfig:
 712  0141 89            	pushw	x
 713  0142 89            	pushw	x
 714       00000002      OFST:	set	2
 717                     ; 191   uint8_t uartreg = 0, itpos = 0x00;
 721                     ; 194   assert_param(IS_UART3_CONFIG_IT_OK(UART3_IT));
 723                     ; 195   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 725                     ; 198   uartreg = (uint8_t)((uint16_t)UART3_IT >> 0x08);
 727  0143 9e            	ld	a,xh
 728  0144 6b01          	ld	(OFST-1,sp),a
 730                     ; 201   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART3_IT & (uint8_t)0x0F));
 732  0146 9f            	ld	a,xl
 733  0147 a40f          	and	a,#15
 734  0149 5f            	clrw	x
 735  014a 97            	ld	xl,a
 736  014b a601          	ld	a,#1
 737  014d 5d            	tnzw	x
 738  014e 2704          	jreq	L61
 739  0150               L02:
 740  0150 48            	sll	a
 741  0151 5a            	decw	x
 742  0152 26fc          	jrne	L02
 743  0154               L61:
 744  0154 6b02          	ld	(OFST+0,sp),a
 746                     ; 203   if (NewState != DISABLE)
 748  0156 0d08          	tnz	(OFST+6,sp)
 749  0158 273a          	jreq	L352
 750                     ; 206     if (uartreg == 0x01)
 752  015a 7b01          	ld	a,(OFST-1,sp)
 753  015c a101          	cp	a,#1
 754  015e 260a          	jrne	L552
 755                     ; 208       UART3->CR1 |= itpos;
 757  0160 c65244        	ld	a,21060
 758  0163 1a02          	or	a,(OFST+0,sp)
 759  0165 c75244        	ld	21060,a
 761  0168 2066          	jra	L172
 762  016a               L552:
 763                     ; 210     else if (uartreg == 0x02)
 765  016a 7b01          	ld	a,(OFST-1,sp)
 766  016c a102          	cp	a,#2
 767  016e 260a          	jrne	L162
 768                     ; 212       UART3->CR2 |= itpos;
 770  0170 c65245        	ld	a,21061
 771  0173 1a02          	or	a,(OFST+0,sp)
 772  0175 c75245        	ld	21061,a
 774  0178 2056          	jra	L172
 775  017a               L162:
 776                     ; 214     else if (uartreg == 0x03)
 778  017a 7b01          	ld	a,(OFST-1,sp)
 779  017c a103          	cp	a,#3
 780  017e 260a          	jrne	L562
 781                     ; 216       UART3->CR4 |= itpos;
 783  0180 c65247        	ld	a,21063
 784  0183 1a02          	or	a,(OFST+0,sp)
 785  0185 c75247        	ld	21063,a
 787  0188 2046          	jra	L172
 788  018a               L562:
 789                     ; 220       UART3->CR6 |= itpos;
 791  018a c65249        	ld	a,21065
 792  018d 1a02          	or	a,(OFST+0,sp)
 793  018f c75249        	ld	21065,a
 794  0192 203c          	jra	L172
 795  0194               L352:
 796                     ; 226     if (uartreg == 0x01)
 798  0194 7b01          	ld	a,(OFST-1,sp)
 799  0196 a101          	cp	a,#1
 800  0198 260b          	jrne	L372
 801                     ; 228       UART3->CR1 &= (uint8_t)(~itpos);
 803  019a 7b02          	ld	a,(OFST+0,sp)
 804  019c 43            	cpl	a
 805  019d c45244        	and	a,21060
 806  01a0 c75244        	ld	21060,a
 808  01a3 202b          	jra	L172
 809  01a5               L372:
 810                     ; 230     else if (uartreg == 0x02)
 812  01a5 7b01          	ld	a,(OFST-1,sp)
 813  01a7 a102          	cp	a,#2
 814  01a9 260b          	jrne	L772
 815                     ; 232       UART3->CR2 &= (uint8_t)(~itpos);
 817  01ab 7b02          	ld	a,(OFST+0,sp)
 818  01ad 43            	cpl	a
 819  01ae c45245        	and	a,21061
 820  01b1 c75245        	ld	21061,a
 822  01b4 201a          	jra	L172
 823  01b6               L772:
 824                     ; 234     else if (uartreg == 0x03)
 826  01b6 7b01          	ld	a,(OFST-1,sp)
 827  01b8 a103          	cp	a,#3
 828  01ba 260b          	jrne	L303
 829                     ; 236       UART3->CR4 &= (uint8_t)(~itpos);
 831  01bc 7b02          	ld	a,(OFST+0,sp)
 832  01be 43            	cpl	a
 833  01bf c45247        	and	a,21063
 834  01c2 c75247        	ld	21063,a
 836  01c5 2009          	jra	L172
 837  01c7               L303:
 838                     ; 240       UART3->CR6 &= (uint8_t)(~itpos);
 840  01c7 7b02          	ld	a,(OFST+0,sp)
 841  01c9 43            	cpl	a
 842  01ca c45249        	and	a,21065
 843  01cd c75249        	ld	21065,a
 844  01d0               L172:
 845                     ; 243 }
 848  01d0 5b04          	addw	sp,#4
 849  01d2 87            	retf
 907                     ; 252 void UART3_LINBreakDetectionConfig(UART3_LINBreakDetectionLength_TypeDef UART3_LINBreakDetectionLength)
 907                     ; 253 {
 908                     	switch	.text
 909  01d3               f_UART3_LINBreakDetectionConfig:
 913                     ; 255   assert_param(IS_UART3_LINBREAKDETECTIONLENGTH_OK(UART3_LINBreakDetectionLength));
 915                     ; 257   if (UART3_LINBreakDetectionLength != UART3_LINBREAKDETECTIONLENGTH_10BITS)
 917  01d3 4d            	tnz	a
 918  01d4 2706          	jreq	L533
 919                     ; 259     UART3->CR4 |= UART3_CR4_LBDL;
 921  01d6 721a5247      	bset	21063,#5
 923  01da 2004          	jra	L733
 924  01dc               L533:
 925                     ; 263     UART3->CR4 &= ((uint8_t)~UART3_CR4_LBDL);
 927  01dc 721b5247      	bres	21063,#5
 928  01e0               L733:
 929                     ; 265 }
 932  01e0 87            	retf
1052                     ; 277 void UART3_LINConfig(UART3_LinMode_TypeDef UART3_Mode,
1052                     ; 278                      UART3_LinAutosync_TypeDef UART3_Autosync, 
1052                     ; 279                      UART3_LinDivUp_TypeDef UART3_DivUp)
1052                     ; 280 {
1053                     	switch	.text
1054  01e1               f_UART3_LINConfig:
1056  01e1 89            	pushw	x
1057       00000000      OFST:	set	0
1060                     ; 282   assert_param(IS_UART3_SLAVE_OK(UART3_Mode));
1062                     ; 283   assert_param(IS_UART3_AUTOSYNC_OK(UART3_Autosync));
1064                     ; 284   assert_param(IS_UART3_DIVUP_OK(UART3_DivUp));
1066                     ; 286   if (UART3_Mode != UART3_LIN_MODE_MASTER)
1068  01e2 9e            	ld	a,xh
1069  01e3 4d            	tnz	a
1070  01e4 2706          	jreq	L714
1071                     ; 288     UART3->CR6 |=  UART3_CR6_LSLV;
1073  01e6 721a5249      	bset	21065,#5
1075  01ea 2004          	jra	L124
1076  01ec               L714:
1077                     ; 292     UART3->CR6 &= ((uint8_t)~UART3_CR6_LSLV);
1079  01ec 721b5249      	bres	21065,#5
1080  01f0               L124:
1081                     ; 295   if (UART3_Autosync != UART3_LIN_AUTOSYNC_DISABLE)
1083  01f0 0d02          	tnz	(OFST+2,sp)
1084  01f2 2706          	jreq	L324
1085                     ; 297     UART3->CR6 |=  UART3_CR6_LASE ;
1087  01f4 72185249      	bset	21065,#4
1089  01f8 2004          	jra	L524
1090  01fa               L324:
1091                     ; 301     UART3->CR6 &= ((uint8_t)~ UART3_CR6_LASE );
1093  01fa 72195249      	bres	21065,#4
1094  01fe               L524:
1095                     ; 304   if (UART3_DivUp != UART3_LIN_DIVUP_LBRR1)
1097  01fe 0d06          	tnz	(OFST+6,sp)
1098  0200 2706          	jreq	L724
1099                     ; 306     UART3->CR6 |=  UART3_CR6_LDUM;
1101  0202 721e5249      	bset	21065,#7
1103  0206 2004          	jra	L134
1104  0208               L724:
1105                     ; 310     UART3->CR6 &= ((uint8_t)~ UART3_CR6_LDUM);
1107  0208 721f5249      	bres	21065,#7
1108  020c               L134:
1109                     ; 312 }
1112  020c 85            	popw	x
1113  020d 87            	retf
1147                     ; 320 void UART3_LINCmd(FunctionalState NewState)
1147                     ; 321 {
1148                     	switch	.text
1149  020e               f_UART3_LINCmd:
1153                     ; 323   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1155                     ; 325   if (NewState != DISABLE)
1157  020e 4d            	tnz	a
1158  020f 2706          	jreq	L154
1159                     ; 328     UART3->CR3 |= UART3_CR3_LINEN;
1161  0211 721c5246      	bset	21062,#6
1163  0215 2004          	jra	L354
1164  0217               L154:
1165                     ; 333     UART3->CR3 &= ((uint8_t)~UART3_CR3_LINEN);
1167  0217 721d5246      	bres	21062,#6
1168  021b               L354:
1169                     ; 335 }
1172  021b 87            	retf
1228                     ; 343 void UART3_WakeUpConfig(UART3_WakeUp_TypeDef UART3_WakeUp)
1228                     ; 344 {
1229                     	switch	.text
1230  021c               f_UART3_WakeUpConfig:
1234                     ; 346   assert_param(IS_UART3_WAKEUP_OK(UART3_WakeUp));
1236                     ; 348   UART3->CR1 &= ((uint8_t)~UART3_CR1_WAKE);
1238  021c 72175244      	bres	21060,#3
1239                     ; 349   UART3->CR1 |= (uint8_t)UART3_WakeUp;
1241  0220 ca5244        	or	a,21060
1242  0223 c75244        	ld	21060,a
1243                     ; 350 }
1246  0226 87            	retf
1281                     ; 358 void UART3_ReceiverWakeUpCmd(FunctionalState NewState)
1281                     ; 359 {
1282                     	switch	.text
1283  0227               f_UART3_ReceiverWakeUpCmd:
1287                     ; 361   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1289                     ; 363   if (NewState != DISABLE)
1291  0227 4d            	tnz	a
1292  0228 2706          	jreq	L125
1293                     ; 366     UART3->CR2 |= UART3_CR2_RWU;
1295  022a 72125245      	bset	21061,#1
1297  022e 2004          	jra	L325
1298  0230               L125:
1299                     ; 371     UART3->CR2 &= ((uint8_t)~UART3_CR2_RWU);
1301  0230 72135245      	bres	21061,#1
1302  0234               L325:
1303                     ; 373 }
1306  0234 87            	retf
1328                     ; 380 uint8_t UART3_ReceiveData8(void)
1328                     ; 381 {
1329                     	switch	.text
1330  0235               f_UART3_ReceiveData8:
1334                     ; 382   return ((uint8_t)UART3->DR);
1336  0235 c65241        	ld	a,21057
1339  0238 87            	retf
1370                     ; 390 uint16_t UART3_ReceiveData9(void)
1370                     ; 391 {
1371                     	switch	.text
1372  0239               f_UART3_ReceiveData9:
1374  0239 89            	pushw	x
1375       00000002      OFST:	set	2
1378                     ; 392   uint16_t temp = 0;
1380                     ; 394   temp = (uint16_t)(((uint16_t)((uint16_t)UART3->CR1 & (uint16_t)UART3_CR1_R8)) << 1);
1382  023a c65244        	ld	a,21060
1383  023d 5f            	clrw	x
1384  023e a480          	and	a,#128
1385  0240 5f            	clrw	x
1386  0241 02            	rlwa	x,a
1387  0242 58            	sllw	x
1388  0243 1f01          	ldw	(OFST-1,sp),x
1390                     ; 395   return (uint16_t)((((uint16_t)UART3->DR) | temp) & ((uint16_t)0x01FF));
1392  0245 c65241        	ld	a,21057
1393  0248 5f            	clrw	x
1394  0249 97            	ld	xl,a
1395  024a 01            	rrwa	x,a
1396  024b 1a02          	or	a,(OFST+0,sp)
1397  024d 01            	rrwa	x,a
1398  024e 1a01          	or	a,(OFST-1,sp)
1399  0250 01            	rrwa	x,a
1400  0251 01            	rrwa	x,a
1401  0252 a4ff          	and	a,#255
1402  0254 01            	rrwa	x,a
1403  0255 a401          	and	a,#1
1404  0257 01            	rrwa	x,a
1407  0258 5b02          	addw	sp,#2
1408  025a 87            	retf
1439                     ; 403 void UART3_SendData8(uint8_t Data)
1439                     ; 404 {
1440                     	switch	.text
1441  025b               f_UART3_SendData8:
1445                     ; 406   UART3->DR = Data;
1447  025b c75241        	ld	21057,a
1448                     ; 407 }
1451  025e 87            	retf
1482                     ; 414 void UART3_SendData9(uint16_t Data)
1482                     ; 415 {
1483                     	switch	.text
1484  025f               f_UART3_SendData9:
1486  025f 89            	pushw	x
1487       00000000      OFST:	set	0
1490                     ; 417   UART3->CR1 &= ((uint8_t)~UART3_CR1_T8);                  
1492  0260 721d5244      	bres	21060,#6
1493                     ; 420   UART3->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART3_CR1_T8); 
1495  0264 54            	srlw	x
1496  0265 54            	srlw	x
1497  0266 9f            	ld	a,xl
1498  0267 a440          	and	a,#64
1499  0269 ca5244        	or	a,21060
1500  026c c75244        	ld	21060,a
1501                     ; 423   UART3->DR   = (uint8_t)(Data);                    
1503  026f 7b02          	ld	a,(OFST+2,sp)
1504  0271 c75241        	ld	21057,a
1505                     ; 424 }
1508  0274 85            	popw	x
1509  0275 87            	retf
1531                     ; 431 void UART3_SendBreak(void)
1531                     ; 432 {
1532                     	switch	.text
1533  0276               f_UART3_SendBreak:
1537                     ; 433   UART3->CR2 |= UART3_CR2_SBK;
1539  0276 72105245      	bset	21061,#0
1540                     ; 434 }
1543  027a 87            	retf
1574                     ; 441 void UART3_SetAddress(uint8_t UART3_Address)
1574                     ; 442 {
1575                     	switch	.text
1576  027b               f_UART3_SetAddress:
1578  027b 88            	push	a
1579       00000000      OFST:	set	0
1582                     ; 444   assert_param(IS_UART3_ADDRESS_OK(UART3_Address));
1584                     ; 447   UART3->CR4 &= ((uint8_t)~UART3_CR4_ADD);
1586  027c c65247        	ld	a,21063
1587  027f a4f0          	and	a,#240
1588  0281 c75247        	ld	21063,a
1589                     ; 449   UART3->CR4 |= UART3_Address;
1591  0284 c65247        	ld	a,21063
1592  0287 1a01          	or	a,(OFST+1,sp)
1593  0289 c75247        	ld	21063,a
1594                     ; 450 }
1597  028c 84            	pop	a
1598  028d 87            	retf
1754                     ; 458 FlagStatus UART3_GetFlagStatus(UART3_Flag_TypeDef UART3_FLAG)
1754                     ; 459 {
1755                     	switch	.text
1756  028e               f_UART3_GetFlagStatus:
1758  028e 89            	pushw	x
1759  028f 88            	push	a
1760       00000001      OFST:	set	1
1763                     ; 460   FlagStatus status = RESET;
1765                     ; 463   assert_param(IS_UART3_FLAG_OK(UART3_FLAG));
1767                     ; 466   if (UART3_FLAG == UART3_FLAG_LBDF)
1769  0290 a30210        	cpw	x,#528
1770  0293 2610          	jrne	L317
1771                     ; 468     if ((UART3->CR4 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1773  0295 9f            	ld	a,xl
1774  0296 c45247        	and	a,21063
1775  0299 2706          	jreq	L517
1776                     ; 471       status = SET;
1778  029b a601          	ld	a,#1
1779  029d 6b01          	ld	(OFST+0,sp),a
1782  029f 2039          	jra	L127
1783  02a1               L517:
1784                     ; 476       status = RESET;
1786  02a1 0f01          	clr	(OFST+0,sp)
1788  02a3 2035          	jra	L127
1789  02a5               L317:
1790                     ; 479   else if (UART3_FLAG == UART3_FLAG_SBK)
1792  02a5 1e02          	ldw	x,(OFST+1,sp)
1793  02a7 a30101        	cpw	x,#257
1794  02aa 2611          	jrne	L327
1795                     ; 481     if ((UART3->CR2 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1797  02ac c65245        	ld	a,21061
1798  02af 1503          	bcp	a,(OFST+2,sp)
1799  02b1 2706          	jreq	L527
1800                     ; 484       status = SET;
1802  02b3 a601          	ld	a,#1
1803  02b5 6b01          	ld	(OFST+0,sp),a
1806  02b7 2021          	jra	L127
1807  02b9               L527:
1808                     ; 489       status = RESET;
1810  02b9 0f01          	clr	(OFST+0,sp)
1812  02bb 201d          	jra	L127
1813  02bd               L327:
1814                     ; 492   else if ((UART3_FLAG == UART3_FLAG_LHDF) || (UART3_FLAG == UART3_FLAG_LSF))
1816  02bd 1e02          	ldw	x,(OFST+1,sp)
1817  02bf a30302        	cpw	x,#770
1818  02c2 2707          	jreq	L537
1820  02c4 1e02          	ldw	x,(OFST+1,sp)
1821  02c6 a30301        	cpw	x,#769
1822  02c9 2614          	jrne	L337
1823  02cb               L537:
1824                     ; 494     if ((UART3->CR6 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1826  02cb c65249        	ld	a,21065
1827  02ce 1503          	bcp	a,(OFST+2,sp)
1828  02d0 2706          	jreq	L737
1829                     ; 497       status = SET;
1831  02d2 a601          	ld	a,#1
1832  02d4 6b01          	ld	(OFST+0,sp),a
1835  02d6 2002          	jra	L127
1836  02d8               L737:
1837                     ; 502       status = RESET;
1839  02d8 0f01          	clr	(OFST+0,sp)
1841  02da               L127:
1842                     ; 520   return  status;
1844  02da 7b01          	ld	a,(OFST+0,sp)
1847  02dc 5b03          	addw	sp,#3
1848  02de 87            	retf
1849  02df               L337:
1850                     ; 507     if ((UART3->SR & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1852  02df c65240        	ld	a,21056
1853  02e2 1503          	bcp	a,(OFST+2,sp)
1854  02e4 2706          	jreq	L547
1855                     ; 510       status = SET;
1857  02e6 a601          	ld	a,#1
1858  02e8 6b01          	ld	(OFST+0,sp),a
1861  02ea 20ee          	jra	L127
1862  02ec               L547:
1863                     ; 515       status = RESET;
1865  02ec 0f01          	clr	(OFST+0,sp)
1867  02ee 20ea          	jra	L127
1901                     ; 551 void UART3_ClearFlag(UART3_Flag_TypeDef UART3_FLAG)
1901                     ; 552 {
1902                     	switch	.text
1903  02f0               f_UART3_ClearFlag:
1905  02f0 89            	pushw	x
1906       00000000      OFST:	set	0
1909                     ; 554   assert_param(IS_UART3_CLEAR_FLAG_OK(UART3_FLAG));
1911                     ; 557   if (UART3_FLAG == UART3_FLAG_RXNE)
1913  02f1 a30020        	cpw	x,#32
1914  02f4 2606          	jrne	L767
1915                     ; 559     UART3->SR = (uint8_t)~(UART3_SR_RXNE);
1917  02f6 35df5240      	mov	21056,#223
1919  02fa 201e          	jra	L177
1920  02fc               L767:
1921                     ; 562   else if (UART3_FLAG == UART3_FLAG_LBDF)
1923  02fc 1e01          	ldw	x,(OFST+1,sp)
1924  02fe a30210        	cpw	x,#528
1925  0301 2606          	jrne	L377
1926                     ; 564     UART3->CR4 &= (uint8_t)(~UART3_CR4_LBDF);
1928  0303 72195247      	bres	21063,#4
1930  0307 2011          	jra	L177
1931  0309               L377:
1932                     ; 567   else if (UART3_FLAG == UART3_FLAG_LHDF)
1934  0309 1e01          	ldw	x,(OFST+1,sp)
1935  030b a30302        	cpw	x,#770
1936  030e 2606          	jrne	L777
1937                     ; 569     UART3->CR6 &= (uint8_t)(~UART3_CR6_LHDF);
1939  0310 72135249      	bres	21065,#1
1941  0314 2004          	jra	L177
1942  0316               L777:
1943                     ; 574     UART3->CR6 &= (uint8_t)(~UART3_CR6_LSF);
1945  0316 72115249      	bres	21065,#0
1946  031a               L177:
1947                     ; 576 }
1950  031a 85            	popw	x
1951  031b 87            	retf
2024                     ; 591 ITStatus UART3_GetITStatus(UART3_IT_TypeDef UART3_IT)
2024                     ; 592 {
2025                     	switch	.text
2026  031c               f_UART3_GetITStatus:
2028  031c 89            	pushw	x
2029  031d 89            	pushw	x
2030       00000002      OFST:	set	2
2033                     ; 593   ITStatus pendingbitstatus = RESET;
2035                     ; 594   uint8_t itpos = 0;
2037                     ; 595   uint8_t itmask1 = 0;
2039                     ; 596   uint8_t itmask2 = 0;
2041                     ; 597   uint8_t enablestatus = 0;
2043                     ; 600   assert_param(IS_UART3_GET_IT_OK(UART3_IT));
2045                     ; 603   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART3_IT & (uint8_t)0x0F));
2047  031e 9f            	ld	a,xl
2048  031f a40f          	and	a,#15
2049  0321 5f            	clrw	x
2050  0322 97            	ld	xl,a
2051  0323 a601          	ld	a,#1
2052  0325 5d            	tnzw	x
2053  0326 2704          	jreq	L65
2054  0328               L06:
2055  0328 48            	sll	a
2056  0329 5a            	decw	x
2057  032a 26fc          	jrne	L06
2058  032c               L65:
2059  032c 6b01          	ld	(OFST-1,sp),a
2061                     ; 605   itmask1 = (uint8_t)((uint8_t)UART3_IT >> (uint8_t)4);
2063  032e 7b04          	ld	a,(OFST+2,sp)
2064  0330 4e            	swap	a
2065  0331 a40f          	and	a,#15
2066  0333 6b02          	ld	(OFST+0,sp),a
2068                     ; 607   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2070  0335 7b02          	ld	a,(OFST+0,sp)
2071  0337 5f            	clrw	x
2072  0338 97            	ld	xl,a
2073  0339 a601          	ld	a,#1
2074  033b 5d            	tnzw	x
2075  033c 2704          	jreq	L26
2076  033e               L46:
2077  033e 48            	sll	a
2078  033f 5a            	decw	x
2079  0340 26fc          	jrne	L46
2080  0342               L26:
2081  0342 6b02          	ld	(OFST+0,sp),a
2083                     ; 610   if (UART3_IT == UART3_IT_PE)
2085  0344 1e03          	ldw	x,(OFST+1,sp)
2086  0346 a30100        	cpw	x,#256
2087  0349 261c          	jrne	L5301
2088                     ; 613     enablestatus = (uint8_t)((uint8_t)UART3->CR1 & itmask2);
2090  034b c65244        	ld	a,21060
2091  034e 1402          	and	a,(OFST+0,sp)
2092  0350 6b02          	ld	(OFST+0,sp),a
2094                     ; 616     if (((UART3->SR & itpos) != (uint8_t)0x00) && enablestatus)
2096  0352 c65240        	ld	a,21056
2097  0355 1501          	bcp	a,(OFST-1,sp)
2098  0357 270a          	jreq	L7301
2100  0359 0d02          	tnz	(OFST+0,sp)
2101  035b 2706          	jreq	L7301
2102                     ; 619       pendingbitstatus = SET;
2104  035d a601          	ld	a,#1
2105  035f 6b02          	ld	(OFST+0,sp),a
2108  0361 2064          	jra	L3401
2109  0363               L7301:
2110                     ; 624       pendingbitstatus = RESET;
2112  0363 0f02          	clr	(OFST+0,sp)
2114  0365 2060          	jra	L3401
2115  0367               L5301:
2116                     ; 627   else if (UART3_IT == UART3_IT_LBDF)
2118  0367 1e03          	ldw	x,(OFST+1,sp)
2119  0369 a30346        	cpw	x,#838
2120  036c 261c          	jrne	L5401
2121                     ; 630     enablestatus = (uint8_t)((uint8_t)UART3->CR4 & itmask2);
2123  036e c65247        	ld	a,21063
2124  0371 1402          	and	a,(OFST+0,sp)
2125  0373 6b02          	ld	(OFST+0,sp),a
2127                     ; 632     if (((UART3->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2129  0375 c65247        	ld	a,21063
2130  0378 1501          	bcp	a,(OFST-1,sp)
2131  037a 270a          	jreq	L7401
2133  037c 0d02          	tnz	(OFST+0,sp)
2134  037e 2706          	jreq	L7401
2135                     ; 635       pendingbitstatus = SET;
2137  0380 a601          	ld	a,#1
2138  0382 6b02          	ld	(OFST+0,sp),a
2141  0384 2041          	jra	L3401
2142  0386               L7401:
2143                     ; 640       pendingbitstatus = RESET;
2145  0386 0f02          	clr	(OFST+0,sp)
2147  0388 203d          	jra	L3401
2148  038a               L5401:
2149                     ; 643   else if (UART3_IT == UART3_IT_LHDF)
2151  038a 1e03          	ldw	x,(OFST+1,sp)
2152  038c a30412        	cpw	x,#1042
2153  038f 261c          	jrne	L5501
2154                     ; 646     enablestatus = (uint8_t)((uint8_t)UART3->CR6 & itmask2);
2156  0391 c65249        	ld	a,21065
2157  0394 1402          	and	a,(OFST+0,sp)
2158  0396 6b02          	ld	(OFST+0,sp),a
2160                     ; 648     if (((UART3->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
2162  0398 c65249        	ld	a,21065
2163  039b 1501          	bcp	a,(OFST-1,sp)
2164  039d 270a          	jreq	L7501
2166  039f 0d02          	tnz	(OFST+0,sp)
2167  03a1 2706          	jreq	L7501
2168                     ; 651       pendingbitstatus = SET;
2170  03a3 a601          	ld	a,#1
2171  03a5 6b02          	ld	(OFST+0,sp),a
2174  03a7 201e          	jra	L3401
2175  03a9               L7501:
2176                     ; 656       pendingbitstatus = RESET;
2178  03a9 0f02          	clr	(OFST+0,sp)
2180  03ab 201a          	jra	L3401
2181  03ad               L5501:
2182                     ; 662     enablestatus = (uint8_t)((uint8_t)UART3->CR2 & itmask2);
2184  03ad c65245        	ld	a,21061
2185  03b0 1402          	and	a,(OFST+0,sp)
2186  03b2 6b02          	ld	(OFST+0,sp),a
2188                     ; 664     if (((UART3->SR & itpos) != (uint8_t)0x00) && enablestatus)
2190  03b4 c65240        	ld	a,21056
2191  03b7 1501          	bcp	a,(OFST-1,sp)
2192  03b9 270a          	jreq	L5601
2194  03bb 0d02          	tnz	(OFST+0,sp)
2195  03bd 2706          	jreq	L5601
2196                     ; 667       pendingbitstatus = SET;
2198  03bf a601          	ld	a,#1
2199  03c1 6b02          	ld	(OFST+0,sp),a
2202  03c3 2002          	jra	L3401
2203  03c5               L5601:
2204                     ; 672       pendingbitstatus = RESET;
2206  03c5 0f02          	clr	(OFST+0,sp)
2208  03c7               L3401:
2209                     ; 676   return  pendingbitstatus;
2211  03c7 7b02          	ld	a,(OFST+0,sp)
2214  03c9 5b04          	addw	sp,#4
2215  03cb 87            	retf
2250                     ; 706 void UART3_ClearITPendingBit(UART3_IT_TypeDef UART3_IT)
2250                     ; 707 {
2251                     	switch	.text
2252  03cc               f_UART3_ClearITPendingBit:
2254  03cc 89            	pushw	x
2255       00000000      OFST:	set	0
2258                     ; 709   assert_param(IS_UART3_CLEAR_IT_OK(UART3_IT));
2260                     ; 712   if (UART3_IT == UART3_IT_RXNE)
2262  03cd a30255        	cpw	x,#597
2263  03d0 2606          	jrne	L7011
2264                     ; 714     UART3->SR = (uint8_t)~(UART3_SR_RXNE);
2266  03d2 35df5240      	mov	21056,#223
2268  03d6 2011          	jra	L1111
2269  03d8               L7011:
2270                     ; 717   else if (UART3_IT == UART3_IT_LBDF)
2272  03d8 1e01          	ldw	x,(OFST+1,sp)
2273  03da a30346        	cpw	x,#838
2274  03dd 2606          	jrne	L3111
2275                     ; 719     UART3->CR4 &= (uint8_t)~(UART3_CR4_LBDF);
2277  03df 72195247      	bres	21063,#4
2279  03e3 2004          	jra	L1111
2280  03e5               L3111:
2281                     ; 724     UART3->CR6 &= (uint8_t)(~UART3_CR6_LHDF);
2283  03e5 72135249      	bres	21065,#1
2284  03e9               L1111:
2285                     ; 726 }
2288  03e9 85            	popw	x
2289  03ea 87            	retf
2301                     	xdef	f_UART3_ClearITPendingBit
2302                     	xdef	f_UART3_GetITStatus
2303                     	xdef	f_UART3_ClearFlag
2304                     	xdef	f_UART3_GetFlagStatus
2305                     	xdef	f_UART3_SetAddress
2306                     	xdef	f_UART3_SendBreak
2307                     	xdef	f_UART3_SendData9
2308                     	xdef	f_UART3_SendData8
2309                     	xdef	f_UART3_ReceiveData9
2310                     	xdef	f_UART3_ReceiveData8
2311                     	xdef	f_UART3_WakeUpConfig
2312                     	xdef	f_UART3_ReceiverWakeUpCmd
2313                     	xdef	f_UART3_LINCmd
2314                     	xdef	f_UART3_LINConfig
2315                     	xdef	f_UART3_LINBreakDetectionConfig
2316                     	xdef	f_UART3_ITConfig
2317                     	xdef	f_UART3_Cmd
2318                     	xdef	f_UART3_Init
2319                     	xdef	f_UART3_DeInit
2320                     	xref	f_CLK_GetClockFreq
2321                     	xref.b	c_lreg
2322                     	xref.b	c_x
2341                     	xref	d_lsub
2342                     	xref	d_smul
2343                     	xref	d_ludv
2344                     	xref	d_rtol
2345                     	xref	d_llsh
2346                     	xref	d_ltor
2347                     	end
