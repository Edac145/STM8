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
 304                     .const:	section	.text
 305  0000               L01:
 306  0000 00000064      	dc.l	100
 307                     ; 83 void UART3_Init(uint32_t BaudRate, UART3_WordLength_TypeDef WordLength, 
 307                     ; 84                 UART3_StopBits_TypeDef StopBits, UART3_Parity_TypeDef Parity, 
 307                     ; 85                 UART3_Mode_TypeDef Mode)
 307                     ; 86 {
 308                     	switch	.text
 309  0023               f_UART3_Init:
 311  0023 520e          	subw	sp,#14
 312       0000000e      OFST:	set	14
 315                     ; 87   uint8_t BRR2_1 = 0, BRR2_2 = 0;
 319                     ; 88   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 323                     ; 91   assert_param(IS_UART3_WORDLENGTH_OK(WordLength));
 325                     ; 92   assert_param(IS_UART3_STOPBITS_OK(StopBits));
 327                     ; 93   assert_param(IS_UART3_PARITY_OK(Parity));
 329                     ; 94   assert_param(IS_UART3_BAUDRATE_OK(BaudRate));
 331                     ; 95   assert_param(IS_UART3_MODE_OK((uint8_t)Mode));
 333                     ; 98   UART3->CR1 &= (uint8_t)(~UART3_CR1_M);     
 335  0025 72195244      	bres	21060,#4
 336                     ; 100   UART3->CR1 |= (uint8_t)WordLength; 
 338  0029 c65244        	ld	a,21060
 339  002c 1a16          	or	a,(OFST+8,sp)
 340  002e c75244        	ld	21060,a
 341                     ; 103   UART3->CR3 &= (uint8_t)(~UART3_CR3_STOP);  
 343  0031 c65246        	ld	a,21062
 344  0034 a4cf          	and	a,#207
 345  0036 c75246        	ld	21062,a
 346                     ; 105   UART3->CR3 |= (uint8_t)StopBits;  
 348  0039 c65246        	ld	a,21062
 349  003c 1a17          	or	a,(OFST+9,sp)
 350  003e c75246        	ld	21062,a
 351                     ; 108   UART3->CR1 &= (uint8_t)(~(UART3_CR1_PCEN | UART3_CR1_PS));  
 353  0041 c65244        	ld	a,21060
 354  0044 a4f9          	and	a,#249
 355  0046 c75244        	ld	21060,a
 356                     ; 110   UART3->CR1 |= (uint8_t)Parity;     
 358  0049 c65244        	ld	a,21060
 359  004c 1a18          	or	a,(OFST+10,sp)
 360  004e c75244        	ld	21060,a
 361                     ; 113   UART3->BRR1 &= (uint8_t)(~UART3_BRR1_DIVM);  
 363  0051 725f5242      	clr	21058
 364                     ; 115   UART3->BRR2 &= (uint8_t)(~UART3_BRR2_DIVM);  
 366  0055 c65243        	ld	a,21059
 367  0058 a40f          	and	a,#15
 368  005a c75243        	ld	21059,a
 369                     ; 117   UART3->BRR2 &= (uint8_t)(~UART3_BRR2_DIVF);  
 371  005d c65243        	ld	a,21059
 372  0060 a4f0          	and	a,#240
 373  0062 c75243        	ld	21059,a
 374                     ; 120   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 376  0065 96            	ldw	x,sp
 377  0066 1c0012        	addw	x,#OFST+4
 378  0069 8d000000      	callf	d_ltor
 380  006d a604          	ld	a,#4
 381  006f 8d000000      	callf	d_llsh
 383  0073 96            	ldw	x,sp
 384  0074 1c0001        	addw	x,#OFST-13
 385  0077 8d000000      	callf	d_rtol
 388  007b 8d000000      	callf	f_CLK_GetClockFreq
 390  007f 96            	ldw	x,sp
 391  0080 1c0001        	addw	x,#OFST-13
 392  0083 8d000000      	callf	d_ludv
 394  0087 96            	ldw	x,sp
 395  0088 1c000b        	addw	x,#OFST-3
 396  008b 8d000000      	callf	d_rtol
 399                     ; 121   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 401  008f 96            	ldw	x,sp
 402  0090 1c0012        	addw	x,#OFST+4
 403  0093 8d000000      	callf	d_ltor
 405  0097 a604          	ld	a,#4
 406  0099 8d000000      	callf	d_llsh
 408  009d 96            	ldw	x,sp
 409  009e 1c0001        	addw	x,#OFST-13
 410  00a1 8d000000      	callf	d_rtol
 413  00a5 8d000000      	callf	f_CLK_GetClockFreq
 415  00a9 a664          	ld	a,#100
 416  00ab 8d000000      	callf	d_smul
 418  00af 96            	ldw	x,sp
 419  00b0 1c0001        	addw	x,#OFST-13
 420  00b3 8d000000      	callf	d_ludv
 422  00b7 96            	ldw	x,sp
 423  00b8 1c0007        	addw	x,#OFST-7
 424  00bb 8d000000      	callf	d_rtol
 427                     ; 124   BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 427                     ; 125                                 << 4) / 100) & (uint8_t)0x0F); 
 429  00bf 96            	ldw	x,sp
 430  00c0 1c000b        	addw	x,#OFST-3
 431  00c3 8d000000      	callf	d_ltor
 433  00c7 a664          	ld	a,#100
 434  00c9 8d000000      	callf	d_smul
 436  00cd 96            	ldw	x,sp
 437  00ce 1c0001        	addw	x,#OFST-13
 438  00d1 8d000000      	callf	d_rtol
 441  00d5 96            	ldw	x,sp
 442  00d6 1c0007        	addw	x,#OFST-7
 443  00d9 8d000000      	callf	d_ltor
 445  00dd 96            	ldw	x,sp
 446  00de 1c0001        	addw	x,#OFST-13
 447  00e1 8d000000      	callf	d_lsub
 449  00e5 a604          	ld	a,#4
 450  00e7 8d000000      	callf	d_llsh
 452  00eb ae0000        	ldw	x,#L01
 453  00ee 8d000000      	callf	d_ludv
 455  00f2 b603          	ld	a,c_lreg+3
 456  00f4 a40f          	and	a,#15
 457  00f6 6b05          	ld	(OFST-9,sp),a
 459                     ; 126   BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 461  00f8 1e0d          	ldw	x,(OFST-1,sp)
 462  00fa 54            	srlw	x
 463  00fb 54            	srlw	x
 464  00fc 54            	srlw	x
 465  00fd 54            	srlw	x
 466  00fe 01            	rrwa	x,a
 467  00ff a4f0          	and	a,#240
 468  0101 5f            	clrw	x
 469  0102 6b06          	ld	(OFST-8,sp),a
 471                     ; 128   UART3->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 473  0104 7b05          	ld	a,(OFST-9,sp)
 474  0106 1a06          	or	a,(OFST-8,sp)
 475  0108 c75243        	ld	21059,a
 476                     ; 130   UART3->BRR1 = (uint8_t)BaudRate_Mantissa;           
 478  010b 7b0e          	ld	a,(OFST+0,sp)
 479  010d c75242        	ld	21058,a
 480                     ; 132   if ((uint8_t)(Mode & UART3_MODE_TX_ENABLE))
 482  0110 7b19          	ld	a,(OFST+11,sp)
 483  0112 a504          	bcp	a,#4
 484  0114 2706          	jreq	L741
 485                     ; 135     UART3->CR2 |= UART3_CR2_TEN;  
 487  0116 72165245      	bset	21061,#3
 489  011a 2004          	jra	L151
 490  011c               L741:
 491                     ; 140     UART3->CR2 &= (uint8_t)(~UART3_CR2_TEN);  
 493  011c 72175245      	bres	21061,#3
 494  0120               L151:
 495                     ; 142   if ((uint8_t)(Mode & UART3_MODE_RX_ENABLE))
 497  0120 7b19          	ld	a,(OFST+11,sp)
 498  0122 a508          	bcp	a,#8
 499  0124 2706          	jreq	L351
 500                     ; 145     UART3->CR2 |= UART3_CR2_REN;  
 502  0126 72145245      	bset	21061,#2
 504  012a 2004          	jra	L551
 505  012c               L351:
 506                     ; 150     UART3->CR2 &= (uint8_t)(~UART3_CR2_REN);  
 508  012c 72155245      	bres	21061,#2
 509  0130               L551:
 510                     ; 152 }
 513  0130 5b0e          	addw	sp,#14
 514  0132 87            	retf
 568                     ; 160 void UART3_Cmd(FunctionalState NewState)
 568                     ; 161 {
 569                     	switch	.text
 570  0133               f_UART3_Cmd:
 574                     ; 162   if (NewState != DISABLE)
 576  0133 4d            	tnz	a
 577  0134 2706          	jreq	L502
 578                     ; 165     UART3->CR1 &= (uint8_t)(~UART3_CR1_UARTD); 
 580  0136 721b5244      	bres	21060,#5
 582  013a 2004          	jra	L702
 583  013c               L502:
 584                     ; 170     UART3->CR1 |= UART3_CR1_UARTD;  
 586  013c 721a5244      	bset	21060,#5
 587  0140               L702:
 588                     ; 172 }
 591  0140 87            	retf
 722                     ; 189 void UART3_ITConfig(UART3_IT_TypeDef UART3_IT, FunctionalState NewState)
 722                     ; 190 {
 723                     	switch	.text
 724  0141               f_UART3_ITConfig:
 726  0141 89            	pushw	x
 727  0142 89            	pushw	x
 728       00000002      OFST:	set	2
 731                     ; 191   uint8_t uartreg = 0, itpos = 0x00;
 735                     ; 194   assert_param(IS_UART3_CONFIG_IT_OK(UART3_IT));
 737                     ; 195   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 739                     ; 198   uartreg = (uint8_t)((uint16_t)UART3_IT >> 0x08);
 741  0143 9e            	ld	a,xh
 742  0144 6b01          	ld	(OFST-1,sp),a
 744                     ; 201   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART3_IT & (uint8_t)0x0F));
 746  0146 9f            	ld	a,xl
 747  0147 a40f          	and	a,#15
 748  0149 5f            	clrw	x
 749  014a 97            	ld	xl,a
 750  014b a601          	ld	a,#1
 751  014d 5d            	tnzw	x
 752  014e 2704          	jreq	L61
 753  0150               L02:
 754  0150 48            	sll	a
 755  0151 5a            	decw	x
 756  0152 26fc          	jrne	L02
 757  0154               L61:
 758  0154 6b02          	ld	(OFST+0,sp),a
 760                     ; 203   if (NewState != DISABLE)
 762  0156 0d08          	tnz	(OFST+6,sp)
 763  0158 273a          	jreq	L172
 764                     ; 206     if (uartreg == 0x01)
 766  015a 7b01          	ld	a,(OFST-1,sp)
 767  015c a101          	cp	a,#1
 768  015e 260a          	jrne	L372
 769                     ; 208       UART3->CR1 |= itpos;
 771  0160 c65244        	ld	a,21060
 772  0163 1a02          	or	a,(OFST+0,sp)
 773  0165 c75244        	ld	21060,a
 775  0168 2066          	jra	L703
 776  016a               L372:
 777                     ; 210     else if (uartreg == 0x02)
 779  016a 7b01          	ld	a,(OFST-1,sp)
 780  016c a102          	cp	a,#2
 781  016e 260a          	jrne	L772
 782                     ; 212       UART3->CR2 |= itpos;
 784  0170 c65245        	ld	a,21061
 785  0173 1a02          	or	a,(OFST+0,sp)
 786  0175 c75245        	ld	21061,a
 788  0178 2056          	jra	L703
 789  017a               L772:
 790                     ; 214     else if (uartreg == 0x03)
 792  017a 7b01          	ld	a,(OFST-1,sp)
 793  017c a103          	cp	a,#3
 794  017e 260a          	jrne	L303
 795                     ; 216       UART3->CR4 |= itpos;
 797  0180 c65247        	ld	a,21063
 798  0183 1a02          	or	a,(OFST+0,sp)
 799  0185 c75247        	ld	21063,a
 801  0188 2046          	jra	L703
 802  018a               L303:
 803                     ; 220       UART3->CR6 |= itpos;
 805  018a c65249        	ld	a,21065
 806  018d 1a02          	or	a,(OFST+0,sp)
 807  018f c75249        	ld	21065,a
 808  0192 203c          	jra	L703
 809  0194               L172:
 810                     ; 226     if (uartreg == 0x01)
 812  0194 7b01          	ld	a,(OFST-1,sp)
 813  0196 a101          	cp	a,#1
 814  0198 260b          	jrne	L113
 815                     ; 228       UART3->CR1 &= (uint8_t)(~itpos);
 817  019a 7b02          	ld	a,(OFST+0,sp)
 818  019c 43            	cpl	a
 819  019d c45244        	and	a,21060
 820  01a0 c75244        	ld	21060,a
 822  01a3 202b          	jra	L703
 823  01a5               L113:
 824                     ; 230     else if (uartreg == 0x02)
 826  01a5 7b01          	ld	a,(OFST-1,sp)
 827  01a7 a102          	cp	a,#2
 828  01a9 260b          	jrne	L513
 829                     ; 232       UART3->CR2 &= (uint8_t)(~itpos);
 831  01ab 7b02          	ld	a,(OFST+0,sp)
 832  01ad 43            	cpl	a
 833  01ae c45245        	and	a,21061
 834  01b1 c75245        	ld	21061,a
 836  01b4 201a          	jra	L703
 837  01b6               L513:
 838                     ; 234     else if (uartreg == 0x03)
 840  01b6 7b01          	ld	a,(OFST-1,sp)
 841  01b8 a103          	cp	a,#3
 842  01ba 260b          	jrne	L123
 843                     ; 236       UART3->CR4 &= (uint8_t)(~itpos);
 845  01bc 7b02          	ld	a,(OFST+0,sp)
 846  01be 43            	cpl	a
 847  01bf c45247        	and	a,21063
 848  01c2 c75247        	ld	21063,a
 850  01c5 2009          	jra	L703
 851  01c7               L123:
 852                     ; 240       UART3->CR6 &= (uint8_t)(~itpos);
 854  01c7 7b02          	ld	a,(OFST+0,sp)
 855  01c9 43            	cpl	a
 856  01ca c45249        	and	a,21065
 857  01cd c75249        	ld	21065,a
 858  01d0               L703:
 859                     ; 243 }
 862  01d0 5b04          	addw	sp,#4
 863  01d2 87            	retf
 921                     ; 252 void UART3_LINBreakDetectionConfig(UART3_LINBreakDetectionLength_TypeDef UART3_LINBreakDetectionLength)
 921                     ; 253 {
 922                     	switch	.text
 923  01d3               f_UART3_LINBreakDetectionConfig:
 927                     ; 255   assert_param(IS_UART3_LINBREAKDETECTIONLENGTH_OK(UART3_LINBreakDetectionLength));
 929                     ; 257   if (UART3_LINBreakDetectionLength != UART3_LINBREAKDETECTIONLENGTH_10BITS)
 931  01d3 4d            	tnz	a
 932  01d4 2706          	jreq	L353
 933                     ; 259     UART3->CR4 |= UART3_CR4_LBDL;
 935  01d6 721a5247      	bset	21063,#5
 937  01da 2004          	jra	L553
 938  01dc               L353:
 939                     ; 263     UART3->CR4 &= ((uint8_t)~UART3_CR4_LBDL);
 941  01dc 721b5247      	bres	21063,#5
 942  01e0               L553:
 943                     ; 265 }
 946  01e0 87            	retf
1066                     ; 277 void UART3_LINConfig(UART3_LinMode_TypeDef UART3_Mode,
1066                     ; 278                      UART3_LinAutosync_TypeDef UART3_Autosync, 
1066                     ; 279                      UART3_LinDivUp_TypeDef UART3_DivUp)
1066                     ; 280 {
1067                     	switch	.text
1068  01e1               f_UART3_LINConfig:
1070  01e1 89            	pushw	x
1071       00000000      OFST:	set	0
1074                     ; 282   assert_param(IS_UART3_SLAVE_OK(UART3_Mode));
1076                     ; 283   assert_param(IS_UART3_AUTOSYNC_OK(UART3_Autosync));
1078                     ; 284   assert_param(IS_UART3_DIVUP_OK(UART3_DivUp));
1080                     ; 286   if (UART3_Mode != UART3_LIN_MODE_MASTER)
1082  01e2 9e            	ld	a,xh
1083  01e3 4d            	tnz	a
1084  01e4 2706          	jreq	L534
1085                     ; 288     UART3->CR6 |=  UART3_CR6_LSLV;
1087  01e6 721a5249      	bset	21065,#5
1089  01ea 2004          	jra	L734
1090  01ec               L534:
1091                     ; 292     UART3->CR6 &= ((uint8_t)~UART3_CR6_LSLV);
1093  01ec 721b5249      	bres	21065,#5
1094  01f0               L734:
1095                     ; 295   if (UART3_Autosync != UART3_LIN_AUTOSYNC_DISABLE)
1097  01f0 0d02          	tnz	(OFST+2,sp)
1098  01f2 2706          	jreq	L144
1099                     ; 297     UART3->CR6 |=  UART3_CR6_LASE ;
1101  01f4 72185249      	bset	21065,#4
1103  01f8 2004          	jra	L344
1104  01fa               L144:
1105                     ; 301     UART3->CR6 &= ((uint8_t)~ UART3_CR6_LASE );
1107  01fa 72195249      	bres	21065,#4
1108  01fe               L344:
1109                     ; 304   if (UART3_DivUp != UART3_LIN_DIVUP_LBRR1)
1111  01fe 0d06          	tnz	(OFST+6,sp)
1112  0200 2706          	jreq	L544
1113                     ; 306     UART3->CR6 |=  UART3_CR6_LDUM;
1115  0202 721e5249      	bset	21065,#7
1117  0206 2004          	jra	L744
1118  0208               L544:
1119                     ; 310     UART3->CR6 &= ((uint8_t)~ UART3_CR6_LDUM);
1121  0208 721f5249      	bres	21065,#7
1122  020c               L744:
1123                     ; 312 }
1126  020c 85            	popw	x
1127  020d 87            	retf
1161                     ; 320 void UART3_LINCmd(FunctionalState NewState)
1161                     ; 321 {
1162                     	switch	.text
1163  020e               f_UART3_LINCmd:
1167                     ; 323   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1169                     ; 325   if (NewState != DISABLE)
1171  020e 4d            	tnz	a
1172  020f 2706          	jreq	L764
1173                     ; 328     UART3->CR3 |= UART3_CR3_LINEN;
1175  0211 721c5246      	bset	21062,#6
1177  0215 2004          	jra	L174
1178  0217               L764:
1179                     ; 333     UART3->CR3 &= ((uint8_t)~UART3_CR3_LINEN);
1181  0217 721d5246      	bres	21062,#6
1182  021b               L174:
1183                     ; 335 }
1186  021b 87            	retf
1242                     ; 343 void UART3_WakeUpConfig(UART3_WakeUp_TypeDef UART3_WakeUp)
1242                     ; 344 {
1243                     	switch	.text
1244  021c               f_UART3_WakeUpConfig:
1248                     ; 346   assert_param(IS_UART3_WAKEUP_OK(UART3_WakeUp));
1250                     ; 348   UART3->CR1 &= ((uint8_t)~UART3_CR1_WAKE);
1252  021c 72175244      	bres	21060,#3
1253                     ; 349   UART3->CR1 |= (uint8_t)UART3_WakeUp;
1255  0220 ca5244        	or	a,21060
1256  0223 c75244        	ld	21060,a
1257                     ; 350 }
1260  0226 87            	retf
1295                     ; 358 void UART3_ReceiverWakeUpCmd(FunctionalState NewState)
1295                     ; 359 {
1296                     	switch	.text
1297  0227               f_UART3_ReceiverWakeUpCmd:
1301                     ; 361   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1303                     ; 363   if (NewState != DISABLE)
1305  0227 4d            	tnz	a
1306  0228 2706          	jreq	L735
1307                     ; 366     UART3->CR2 |= UART3_CR2_RWU;
1309  022a 72125245      	bset	21061,#1
1311  022e 2004          	jra	L145
1312  0230               L735:
1313                     ; 371     UART3->CR2 &= ((uint8_t)~UART3_CR2_RWU);
1315  0230 72135245      	bres	21061,#1
1316  0234               L145:
1317                     ; 373 }
1320  0234 87            	retf
1342                     ; 380 uint8_t UART3_ReceiveData8(void)
1342                     ; 381 {
1343                     	switch	.text
1344  0235               f_UART3_ReceiveData8:
1348                     ; 382   return ((uint8_t)UART3->DR);
1350  0235 c65241        	ld	a,21057
1353  0238 87            	retf
1386                     ; 390 uint16_t UART3_ReceiveData9(void)
1386                     ; 391 {
1387                     	switch	.text
1388  0239               f_UART3_ReceiveData9:
1390  0239 89            	pushw	x
1391       00000002      OFST:	set	2
1394                     ; 392   uint16_t temp = 0;
1396                     ; 394   temp = (uint16_t)(((uint16_t)((uint16_t)UART3->CR1 & (uint16_t)UART3_CR1_R8)) << 1);
1398  023a c65244        	ld	a,21060
1399  023d 5f            	clrw	x
1400  023e a480          	and	a,#128
1401  0240 5f            	clrw	x
1402  0241 02            	rlwa	x,a
1403  0242 58            	sllw	x
1404  0243 1f01          	ldw	(OFST-1,sp),x
1406                     ; 395   return (uint16_t)((((uint16_t)UART3->DR) | temp) & ((uint16_t)0x01FF));
1408  0245 c65241        	ld	a,21057
1409  0248 5f            	clrw	x
1410  0249 97            	ld	xl,a
1411  024a 01            	rrwa	x,a
1412  024b 1a02          	or	a,(OFST+0,sp)
1413  024d 01            	rrwa	x,a
1414  024e 1a01          	or	a,(OFST-1,sp)
1415  0250 01            	rrwa	x,a
1416  0251 01            	rrwa	x,a
1417  0252 a4ff          	and	a,#255
1418  0254 01            	rrwa	x,a
1419  0255 a401          	and	a,#1
1420  0257 01            	rrwa	x,a
1423  0258 5b02          	addw	sp,#2
1424  025a 87            	retf
1457                     ; 403 void UART3_SendData8(uint8_t Data)
1457                     ; 404 {
1458                     	switch	.text
1459  025b               f_UART3_SendData8:
1463                     ; 406   UART3->DR = Data;
1465  025b c75241        	ld	21057,a
1466                     ; 407 }
1469  025e 87            	retf
1502                     ; 414 void UART3_SendData9(uint16_t Data)
1502                     ; 415 {
1503                     	switch	.text
1504  025f               f_UART3_SendData9:
1506  025f 89            	pushw	x
1507       00000000      OFST:	set	0
1510                     ; 417   UART3->CR1 &= ((uint8_t)~UART3_CR1_T8);                  
1512  0260 721d5244      	bres	21060,#6
1513                     ; 420   UART3->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART3_CR1_T8); 
1515  0264 54            	srlw	x
1516  0265 54            	srlw	x
1517  0266 9f            	ld	a,xl
1518  0267 a440          	and	a,#64
1519  0269 ca5244        	or	a,21060
1520  026c c75244        	ld	21060,a
1521                     ; 423   UART3->DR   = (uint8_t)(Data);                    
1523  026f 7b02          	ld	a,(OFST+2,sp)
1524  0271 c75241        	ld	21057,a
1525                     ; 424 }
1528  0274 85            	popw	x
1529  0275 87            	retf
1551                     ; 431 void UART3_SendBreak(void)
1551                     ; 432 {
1552                     	switch	.text
1553  0276               f_UART3_SendBreak:
1557                     ; 433   UART3->CR2 |= UART3_CR2_SBK;
1559  0276 72105245      	bset	21061,#0
1560                     ; 434 }
1563  027a 87            	retf
1596                     ; 441 void UART3_SetAddress(uint8_t UART3_Address)
1596                     ; 442 {
1597                     	switch	.text
1598  027b               f_UART3_SetAddress:
1600  027b 88            	push	a
1601       00000000      OFST:	set	0
1604                     ; 444   assert_param(IS_UART3_ADDRESS_OK(UART3_Address));
1606                     ; 447   UART3->CR4 &= ((uint8_t)~UART3_CR4_ADD);
1608  027c c65247        	ld	a,21063
1609  027f a4f0          	and	a,#240
1610  0281 c75247        	ld	21063,a
1611                     ; 449   UART3->CR4 |= UART3_Address;
1613  0284 c65247        	ld	a,21063
1614  0287 1a01          	or	a,(OFST+1,sp)
1615  0289 c75247        	ld	21063,a
1616                     ; 450 }
1619  028c 84            	pop	a
1620  028d 87            	retf
1776                     ; 458 FlagStatus UART3_GetFlagStatus(UART3_Flag_TypeDef UART3_FLAG)
1776                     ; 459 {
1777                     	switch	.text
1778  028e               f_UART3_GetFlagStatus:
1780  028e 89            	pushw	x
1781  028f 88            	push	a
1782       00000001      OFST:	set	1
1785                     ; 460   FlagStatus status = RESET;
1787                     ; 463   assert_param(IS_UART3_FLAG_OK(UART3_FLAG));
1789                     ; 466   if (UART3_FLAG == UART3_FLAG_LBDF)
1791  0290 a30210        	cpw	x,#528
1792  0293 2610          	jrne	L147
1793                     ; 468     if ((UART3->CR4 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1795  0295 9f            	ld	a,xl
1796  0296 c45247        	and	a,21063
1797  0299 2706          	jreq	L347
1798                     ; 471       status = SET;
1800  029b a601          	ld	a,#1
1801  029d 6b01          	ld	(OFST+0,sp),a
1804  029f 2039          	jra	L747
1805  02a1               L347:
1806                     ; 476       status = RESET;
1808  02a1 0f01          	clr	(OFST+0,sp)
1810  02a3 2035          	jra	L747
1811  02a5               L147:
1812                     ; 479   else if (UART3_FLAG == UART3_FLAG_SBK)
1814  02a5 1e02          	ldw	x,(OFST+1,sp)
1815  02a7 a30101        	cpw	x,#257
1816  02aa 2611          	jrne	L157
1817                     ; 481     if ((UART3->CR2 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1819  02ac c65245        	ld	a,21061
1820  02af 1503          	bcp	a,(OFST+2,sp)
1821  02b1 2706          	jreq	L357
1822                     ; 484       status = SET;
1824  02b3 a601          	ld	a,#1
1825  02b5 6b01          	ld	(OFST+0,sp),a
1828  02b7 2021          	jra	L747
1829  02b9               L357:
1830                     ; 489       status = RESET;
1832  02b9 0f01          	clr	(OFST+0,sp)
1834  02bb 201d          	jra	L747
1835  02bd               L157:
1836                     ; 492   else if ((UART3_FLAG == UART3_FLAG_LHDF) || (UART3_FLAG == UART3_FLAG_LSF))
1838  02bd 1e02          	ldw	x,(OFST+1,sp)
1839  02bf a30302        	cpw	x,#770
1840  02c2 2707          	jreq	L367
1842  02c4 1e02          	ldw	x,(OFST+1,sp)
1843  02c6 a30301        	cpw	x,#769
1844  02c9 2614          	jrne	L167
1845  02cb               L367:
1846                     ; 494     if ((UART3->CR6 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1848  02cb c65249        	ld	a,21065
1849  02ce 1503          	bcp	a,(OFST+2,sp)
1850  02d0 2706          	jreq	L567
1851                     ; 497       status = SET;
1853  02d2 a601          	ld	a,#1
1854  02d4 6b01          	ld	(OFST+0,sp),a
1857  02d6 2002          	jra	L747
1858  02d8               L567:
1859                     ; 502       status = RESET;
1861  02d8 0f01          	clr	(OFST+0,sp)
1863  02da               L747:
1864                     ; 520   return  status;
1866  02da 7b01          	ld	a,(OFST+0,sp)
1869  02dc 5b03          	addw	sp,#3
1870  02de 87            	retf
1871  02df               L167:
1872                     ; 507     if ((UART3->SR & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1874  02df c65240        	ld	a,21056
1875  02e2 1503          	bcp	a,(OFST+2,sp)
1876  02e4 2706          	jreq	L377
1877                     ; 510       status = SET;
1879  02e6 a601          	ld	a,#1
1880  02e8 6b01          	ld	(OFST+0,sp),a
1883  02ea 20ee          	jra	L747
1884  02ec               L377:
1885                     ; 515       status = RESET;
1887  02ec 0f01          	clr	(OFST+0,sp)
1889  02ee 20ea          	jra	L747
1923                     ; 551 void UART3_ClearFlag(UART3_Flag_TypeDef UART3_FLAG)
1923                     ; 552 {
1924                     	switch	.text
1925  02f0               f_UART3_ClearFlag:
1927  02f0 89            	pushw	x
1928       00000000      OFST:	set	0
1931                     ; 554   assert_param(IS_UART3_CLEAR_FLAG_OK(UART3_FLAG));
1933                     ; 557   if (UART3_FLAG == UART3_FLAG_RXNE)
1935  02f1 a30020        	cpw	x,#32
1936  02f4 2606          	jrne	L5101
1937                     ; 559     UART3->SR = (uint8_t)~(UART3_SR_RXNE);
1939  02f6 35df5240      	mov	21056,#223
1941  02fa 201e          	jra	L7101
1942  02fc               L5101:
1943                     ; 562   else if (UART3_FLAG == UART3_FLAG_LBDF)
1945  02fc 1e01          	ldw	x,(OFST+1,sp)
1946  02fe a30210        	cpw	x,#528
1947  0301 2606          	jrne	L1201
1948                     ; 564     UART3->CR4 &= (uint8_t)(~UART3_CR4_LBDF);
1950  0303 72195247      	bres	21063,#4
1952  0307 2011          	jra	L7101
1953  0309               L1201:
1954                     ; 567   else if (UART3_FLAG == UART3_FLAG_LHDF)
1956  0309 1e01          	ldw	x,(OFST+1,sp)
1957  030b a30302        	cpw	x,#770
1958  030e 2606          	jrne	L5201
1959                     ; 569     UART3->CR6 &= (uint8_t)(~UART3_CR6_LHDF);
1961  0310 72135249      	bres	21065,#1
1963  0314 2004          	jra	L7101
1964  0316               L5201:
1965                     ; 574     UART3->CR6 &= (uint8_t)(~UART3_CR6_LSF);
1967  0316 72115249      	bres	21065,#0
1968  031a               L7101:
1969                     ; 576 }
1972  031a 85            	popw	x
1973  031b 87            	retf
2054                     ; 591 ITStatus UART3_GetITStatus(UART3_IT_TypeDef UART3_IT)
2054                     ; 592 {
2055                     	switch	.text
2056  031c               f_UART3_GetITStatus:
2058  031c 89            	pushw	x
2059  031d 89            	pushw	x
2060       00000002      OFST:	set	2
2063                     ; 593   ITStatus pendingbitstatus = RESET;
2065                     ; 594   uint8_t itpos = 0;
2067                     ; 595   uint8_t itmask1 = 0;
2069                     ; 596   uint8_t itmask2 = 0;
2071                     ; 597   uint8_t enablestatus = 0;
2073                     ; 600   assert_param(IS_UART3_GET_IT_OK(UART3_IT));
2075                     ; 603   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART3_IT & (uint8_t)0x0F));
2077  031e 9f            	ld	a,xl
2078  031f a40f          	and	a,#15
2079  0321 5f            	clrw	x
2080  0322 97            	ld	xl,a
2081  0323 a601          	ld	a,#1
2082  0325 5d            	tnzw	x
2083  0326 2704          	jreq	L65
2084  0328               L06:
2085  0328 48            	sll	a
2086  0329 5a            	decw	x
2087  032a 26fc          	jrne	L06
2088  032c               L65:
2089  032c 6b01          	ld	(OFST-1,sp),a
2091                     ; 605   itmask1 = (uint8_t)((uint8_t)UART3_IT >> (uint8_t)4);
2093  032e 7b04          	ld	a,(OFST+2,sp)
2094  0330 4e            	swap	a
2095  0331 a40f          	and	a,#15
2096  0333 6b02          	ld	(OFST+0,sp),a
2098                     ; 607   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2100  0335 7b02          	ld	a,(OFST+0,sp)
2101  0337 5f            	clrw	x
2102  0338 97            	ld	xl,a
2103  0339 a601          	ld	a,#1
2104  033b 5d            	tnzw	x
2105  033c 2704          	jreq	L26
2106  033e               L46:
2107  033e 48            	sll	a
2108  033f 5a            	decw	x
2109  0340 26fc          	jrne	L46
2110  0342               L26:
2111  0342 6b02          	ld	(OFST+0,sp),a
2113                     ; 610   if (UART3_IT == UART3_IT_PE)
2115  0344 1e03          	ldw	x,(OFST+1,sp)
2116  0346 a30100        	cpw	x,#256
2117  0349 261c          	jrne	L3701
2118                     ; 613     enablestatus = (uint8_t)((uint8_t)UART3->CR1 & itmask2);
2120  034b c65244        	ld	a,21060
2121  034e 1402          	and	a,(OFST+0,sp)
2122  0350 6b02          	ld	(OFST+0,sp),a
2124                     ; 616     if (((UART3->SR & itpos) != (uint8_t)0x00) && enablestatus)
2126  0352 c65240        	ld	a,21056
2127  0355 1501          	bcp	a,(OFST-1,sp)
2128  0357 270a          	jreq	L5701
2130  0359 0d02          	tnz	(OFST+0,sp)
2131  035b 2706          	jreq	L5701
2132                     ; 619       pendingbitstatus = SET;
2134  035d a601          	ld	a,#1
2135  035f 6b02          	ld	(OFST+0,sp),a
2138  0361 2064          	jra	L1011
2139  0363               L5701:
2140                     ; 624       pendingbitstatus = RESET;
2142  0363 0f02          	clr	(OFST+0,sp)
2144  0365 2060          	jra	L1011
2145  0367               L3701:
2146                     ; 627   else if (UART3_IT == UART3_IT_LBDF)
2148  0367 1e03          	ldw	x,(OFST+1,sp)
2149  0369 a30346        	cpw	x,#838
2150  036c 261c          	jrne	L3011
2151                     ; 630     enablestatus = (uint8_t)((uint8_t)UART3->CR4 & itmask2);
2153  036e c65247        	ld	a,21063
2154  0371 1402          	and	a,(OFST+0,sp)
2155  0373 6b02          	ld	(OFST+0,sp),a
2157                     ; 632     if (((UART3->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2159  0375 c65247        	ld	a,21063
2160  0378 1501          	bcp	a,(OFST-1,sp)
2161  037a 270a          	jreq	L5011
2163  037c 0d02          	tnz	(OFST+0,sp)
2164  037e 2706          	jreq	L5011
2165                     ; 635       pendingbitstatus = SET;
2167  0380 a601          	ld	a,#1
2168  0382 6b02          	ld	(OFST+0,sp),a
2171  0384 2041          	jra	L1011
2172  0386               L5011:
2173                     ; 640       pendingbitstatus = RESET;
2175  0386 0f02          	clr	(OFST+0,sp)
2177  0388 203d          	jra	L1011
2178  038a               L3011:
2179                     ; 643   else if (UART3_IT == UART3_IT_LHDF)
2181  038a 1e03          	ldw	x,(OFST+1,sp)
2182  038c a30412        	cpw	x,#1042
2183  038f 261c          	jrne	L3111
2184                     ; 646     enablestatus = (uint8_t)((uint8_t)UART3->CR6 & itmask2);
2186  0391 c65249        	ld	a,21065
2187  0394 1402          	and	a,(OFST+0,sp)
2188  0396 6b02          	ld	(OFST+0,sp),a
2190                     ; 648     if (((UART3->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
2192  0398 c65249        	ld	a,21065
2193  039b 1501          	bcp	a,(OFST-1,sp)
2194  039d 270a          	jreq	L5111
2196  039f 0d02          	tnz	(OFST+0,sp)
2197  03a1 2706          	jreq	L5111
2198                     ; 651       pendingbitstatus = SET;
2200  03a3 a601          	ld	a,#1
2201  03a5 6b02          	ld	(OFST+0,sp),a
2204  03a7 201e          	jra	L1011
2205  03a9               L5111:
2206                     ; 656       pendingbitstatus = RESET;
2208  03a9 0f02          	clr	(OFST+0,sp)
2210  03ab 201a          	jra	L1011
2211  03ad               L3111:
2212                     ; 662     enablestatus = (uint8_t)((uint8_t)UART3->CR2 & itmask2);
2214  03ad c65245        	ld	a,21061
2215  03b0 1402          	and	a,(OFST+0,sp)
2216  03b2 6b02          	ld	(OFST+0,sp),a
2218                     ; 664     if (((UART3->SR & itpos) != (uint8_t)0x00) && enablestatus)
2220  03b4 c65240        	ld	a,21056
2221  03b7 1501          	bcp	a,(OFST-1,sp)
2222  03b9 270a          	jreq	L3211
2224  03bb 0d02          	tnz	(OFST+0,sp)
2225  03bd 2706          	jreq	L3211
2226                     ; 667       pendingbitstatus = SET;
2228  03bf a601          	ld	a,#1
2229  03c1 6b02          	ld	(OFST+0,sp),a
2232  03c3 2002          	jra	L1011
2233  03c5               L3211:
2234                     ; 672       pendingbitstatus = RESET;
2236  03c5 0f02          	clr	(OFST+0,sp)
2238  03c7               L1011:
2239                     ; 676   return  pendingbitstatus;
2241  03c7 7b02          	ld	a,(OFST+0,sp)
2244  03c9 5b04          	addw	sp,#4
2245  03cb 87            	retf
2280                     ; 706 void UART3_ClearITPendingBit(UART3_IT_TypeDef UART3_IT)
2280                     ; 707 {
2281                     	switch	.text
2282  03cc               f_UART3_ClearITPendingBit:
2284  03cc 89            	pushw	x
2285       00000000      OFST:	set	0
2288                     ; 709   assert_param(IS_UART3_CLEAR_IT_OK(UART3_IT));
2290                     ; 712   if (UART3_IT == UART3_IT_RXNE)
2292  03cd a30255        	cpw	x,#597
2293  03d0 2606          	jrne	L5411
2294                     ; 714     UART3->SR = (uint8_t)~(UART3_SR_RXNE);
2296  03d2 35df5240      	mov	21056,#223
2298  03d6 2011          	jra	L7411
2299  03d8               L5411:
2300                     ; 717   else if (UART3_IT == UART3_IT_LBDF)
2302  03d8 1e01          	ldw	x,(OFST+1,sp)
2303  03da a30346        	cpw	x,#838
2304  03dd 2606          	jrne	L1511
2305                     ; 719     UART3->CR4 &= (uint8_t)~(UART3_CR4_LBDF);
2307  03df 72195247      	bres	21063,#4
2309  03e3 2004          	jra	L7411
2310  03e5               L1511:
2311                     ; 724     UART3->CR6 &= (uint8_t)(~UART3_CR6_LHDF);
2313  03e5 72135249      	bres	21065,#1
2314  03e9               L7411:
2315                     ; 726 }
2318  03e9 85            	popw	x
2319  03ea 87            	retf
2331                     	xdef	f_UART3_ClearITPendingBit
2332                     	xdef	f_UART3_GetITStatus
2333                     	xdef	f_UART3_ClearFlag
2334                     	xdef	f_UART3_GetFlagStatus
2335                     	xdef	f_UART3_SetAddress
2336                     	xdef	f_UART3_SendBreak
2337                     	xdef	f_UART3_SendData9
2338                     	xdef	f_UART3_SendData8
2339                     	xdef	f_UART3_ReceiveData9
2340                     	xdef	f_UART3_ReceiveData8
2341                     	xdef	f_UART3_WakeUpConfig
2342                     	xdef	f_UART3_ReceiverWakeUpCmd
2343                     	xdef	f_UART3_LINCmd
2344                     	xdef	f_UART3_LINConfig
2345                     	xdef	f_UART3_LINBreakDetectionConfig
2346                     	xdef	f_UART3_ITConfig
2347                     	xdef	f_UART3_Cmd
2348                     	xdef	f_UART3_Init
2349                     	xdef	f_UART3_DeInit
2350                     	xref	f_CLK_GetClockFreq
2351                     	xref.b	c_lreg
2352                     	xref.b	c_x
2371                     	xref	d_lsub
2372                     	xref	d_smul
2373                     	xref	d_ludv
2374                     	xref	d_rtol
2375                     	xref	d_llsh
2376                     	xref	d_ltor
2377                     	end
