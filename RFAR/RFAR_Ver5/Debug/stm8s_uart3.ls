   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  45                     ; 54 void UART3_DeInit(void)
  45                     ; 55 {
  46                     	switch	.text
  47  0000               f_UART3_DeInit:
  51                     ; 58   (void) UART3->SR;
  53  0000 c65240        	ld	a,21056
  54                     ; 59   (void) UART3->DR;
  56  0003 c65241        	ld	a,21057
  57                     ; 61   UART3->BRR2 = UART3_BRR2_RESET_VALUE; /*Set UART3_BRR2 to reset value 0x00 */
  59  0006 725f5243      	clr	21059
  60                     ; 62   UART3->BRR1 = UART3_BRR1_RESET_VALUE; /*Set UART3_BRR1 to reset value 0x00 */
  62  000a 725f5242      	clr	21058
  63                     ; 64   UART3->CR1 = UART3_CR1_RESET_VALUE;  /*Set UART3_CR1 to reset value 0x00  */
  65  000e 725f5244      	clr	21060
  66                     ; 65   UART3->CR2 = UART3_CR2_RESET_VALUE;  /*Set UART3_CR2 to reset value 0x00  */
  68  0012 725f5245      	clr	21061
  69                     ; 66   UART3->CR3 = UART3_CR3_RESET_VALUE;  /*Set UART3_CR3 to reset value 0x00  */
  71  0016 725f5246      	clr	21062
  72                     ; 67   UART3->CR4 = UART3_CR4_RESET_VALUE;  /*Set UART3_CR4 to reset value 0x00  */
  74  001a 725f5247      	clr	21063
  75                     ; 68   UART3->CR6 = UART3_CR6_RESET_VALUE;  /*Set UART3_CR6 to reset value 0x00  */
  77  001e 725f5249      	clr	21065
  78                     ; 69 }
  81  0022 87            	retf	
 307                     .const:	section	.text
 308  0000               L41:
 309  0000 00000064      	dc.l	100
 310                     ; 83 void UART3_Init(uint32_t BaudRate, UART3_WordLength_TypeDef WordLength, 
 310                     ; 84                 UART3_StopBits_TypeDef StopBits, UART3_Parity_TypeDef Parity, 
 310                     ; 85                 UART3_Mode_TypeDef Mode)
 310                     ; 86 {
 311                     	switch	.text
 312  0023               f_UART3_Init:
 314  0023 520e          	subw	sp,#14
 315       0000000e      OFST:	set	14
 318                     ; 87   uint8_t BRR2_1 = 0, BRR2_2 = 0;
 322                     ; 88   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 326                     ; 91   assert_param(IS_UART3_WORDLENGTH_OK(WordLength));
 328                     ; 92   assert_param(IS_UART3_STOPBITS_OK(StopBits));
 330                     ; 93   assert_param(IS_UART3_PARITY_OK(Parity));
 332                     ; 94   assert_param(IS_UART3_BAUDRATE_OK(BaudRate));
 334                     ; 95   assert_param(IS_UART3_MODE_OK((uint8_t)Mode));
 336                     ; 98   UART3->CR1 &= (uint8_t)(~UART3_CR1_M);     
 338  0025 72195244      	bres	21060,#4
 339                     ; 100   UART3->CR1 |= (uint8_t)WordLength; 
 341  0029 c65244        	ld	a,21060
 342  002c 1a16          	or	a,(OFST+8,sp)
 343  002e c75244        	ld	21060,a
 344                     ; 103   UART3->CR3 &= (uint8_t)(~UART3_CR3_STOP);  
 346  0031 c65246        	ld	a,21062
 347  0034 a4cf          	and	a,#207
 348  0036 c75246        	ld	21062,a
 349                     ; 105   UART3->CR3 |= (uint8_t)StopBits;  
 351  0039 c65246        	ld	a,21062
 352  003c 1a17          	or	a,(OFST+9,sp)
 353  003e c75246        	ld	21062,a
 354                     ; 108   UART3->CR1 &= (uint8_t)(~(UART3_CR1_PCEN | UART3_CR1_PS));  
 356  0041 c65244        	ld	a,21060
 357  0044 a4f9          	and	a,#249
 358  0046 c75244        	ld	21060,a
 359                     ; 110   UART3->CR1 |= (uint8_t)Parity;     
 361  0049 c65244        	ld	a,21060
 362  004c 1a18          	or	a,(OFST+10,sp)
 363  004e c75244        	ld	21060,a
 364                     ; 113   UART3->BRR1 &= (uint8_t)(~UART3_BRR1_DIVM);  
 366  0051 725f5242      	clr	21058
 367                     ; 115   UART3->BRR2 &= (uint8_t)(~UART3_BRR2_DIVM);  
 369  0055 c65243        	ld	a,21059
 370  0058 a40f          	and	a,#15
 371  005a c75243        	ld	21059,a
 372                     ; 117   UART3->BRR2 &= (uint8_t)(~UART3_BRR2_DIVF);  
 374  005d c65243        	ld	a,21059
 375  0060 a4f0          	and	a,#240
 376  0062 c75243        	ld	21059,a
 377                     ; 120   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 379  0065 96            	ldw	x,sp
 380  0066 1c0012        	addw	x,#OFST+4
 381  0069 8d000000      	callf	d_ltor
 383  006d a604          	ld	a,#4
 384  006f 8d000000      	callf	d_llsh
 386  0073 96            	ldw	x,sp
 387  0074 5c            	incw	x
 388  0075 8d000000      	callf	d_rtol
 391  0079 8d000000      	callf	f_CLK_GetClockFreq
 393  007d 96            	ldw	x,sp
 394  007e 5c            	incw	x
 395  007f 8d000000      	callf	d_ludv
 397  0083 96            	ldw	x,sp
 398  0084 1c000b        	addw	x,#OFST-3
 399  0087 8d000000      	callf	d_rtol
 402                     ; 121   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 404  008b 96            	ldw	x,sp
 405  008c 1c0012        	addw	x,#OFST+4
 406  008f 8d000000      	callf	d_ltor
 408  0093 a604          	ld	a,#4
 409  0095 8d000000      	callf	d_llsh
 411  0099 96            	ldw	x,sp
 412  009a 5c            	incw	x
 413  009b 8d000000      	callf	d_rtol
 416  009f 8d000000      	callf	f_CLK_GetClockFreq
 418  00a3 a664          	ld	a,#100
 419  00a5 8d000000      	callf	d_smul
 421  00a9 96            	ldw	x,sp
 422  00aa 5c            	incw	x
 423  00ab 8d000000      	callf	d_ludv
 425  00af 96            	ldw	x,sp
 426  00b0 1c0007        	addw	x,#OFST-7
 427  00b3 8d000000      	callf	d_rtol
 430                     ; 124   BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 430                     ; 125                                 << 4) / 100) & (uint8_t)0x0F); 
 432  00b7 96            	ldw	x,sp
 433  00b8 1c000b        	addw	x,#OFST-3
 434  00bb 8d000000      	callf	d_ltor
 436  00bf a664          	ld	a,#100
 437  00c1 8d000000      	callf	d_smul
 439  00c5 96            	ldw	x,sp
 440  00c6 5c            	incw	x
 441  00c7 8d000000      	callf	d_rtol
 444  00cb 96            	ldw	x,sp
 445  00cc 1c0007        	addw	x,#OFST-7
 446  00cf 8d000000      	callf	d_ltor
 448  00d3 96            	ldw	x,sp
 449  00d4 5c            	incw	x
 450  00d5 8d000000      	callf	d_lsub
 452  00d9 a604          	ld	a,#4
 453  00db 8d000000      	callf	d_llsh
 455  00df ae0000        	ldw	x,#L41
 456  00e2 8d000000      	callf	d_ludv
 458  00e6 b603          	ld	a,c_lreg+3
 459  00e8 a40f          	and	a,#15
 460  00ea 6b05          	ld	(OFST-9,sp),a
 462                     ; 126   BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 464  00ec 1e0d          	ldw	x,(OFST-1,sp)
 465  00ee 54            	srlw	x
 466  00ef 54            	srlw	x
 467  00f0 54            	srlw	x
 468  00f1 54            	srlw	x
 469  00f2 01            	rrwa	x,a
 470  00f3 a4f0          	and	a,#240
 471  00f5 6b06          	ld	(OFST-8,sp),a
 473                     ; 128   UART3->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 475  00f7 1a05          	or	a,(OFST-9,sp)
 476  00f9 c75243        	ld	21059,a
 477                     ; 130   UART3->BRR1 = (uint8_t)BaudRate_Mantissa;           
 479  00fc 7b0e          	ld	a,(OFST+0,sp)
 480  00fe c75242        	ld	21058,a
 481                     ; 132   if ((uint8_t)(Mode & UART3_MODE_TX_ENABLE))
 483  0101 7b19          	ld	a,(OFST+11,sp)
 484  0103 a504          	bcp	a,#4
 485  0105 2706          	jreq	L741
 486                     ; 135     UART3->CR2 |= UART3_CR2_TEN;  
 488  0107 72165245      	bset	21061,#3
 490  010b 2004          	jra	L151
 491  010d               L741:
 492                     ; 140     UART3->CR2 &= (uint8_t)(~UART3_CR2_TEN);  
 494  010d 72175245      	bres	21061,#3
 495  0111               L151:
 496                     ; 142   if ((uint8_t)(Mode & UART3_MODE_RX_ENABLE))
 498  0111 a508          	bcp	a,#8
 499  0113 2706          	jreq	L351
 500                     ; 145     UART3->CR2 |= UART3_CR2_REN;  
 502  0115 72145245      	bset	21061,#2
 504  0119 2004          	jra	L551
 505  011b               L351:
 506                     ; 150     UART3->CR2 &= (uint8_t)(~UART3_CR2_REN);  
 508  011b 72155245      	bres	21061,#2
 509  011f               L551:
 510                     ; 152 }
 513  011f 5b0e          	addw	sp,#14
 514  0121 87            	retf	
 568                     ; 160 void UART3_Cmd(FunctionalState NewState)
 568                     ; 161 {
 569                     	switch	.text
 570  0122               f_UART3_Cmd:
 574                     ; 162   if (NewState != DISABLE)
 576  0122 4d            	tnz	a
 577  0123 2705          	jreq	L502
 578                     ; 165     UART3->CR1 &= (uint8_t)(~UART3_CR1_UARTD); 
 580  0125 721b5244      	bres	21060,#5
 583  0129 87            	retf	
 584  012a               L502:
 585                     ; 170     UART3->CR1 |= UART3_CR1_UARTD;  
 587  012a 721a5244      	bset	21060,#5
 588                     ; 172 }
 591  012e 87            	retf	
 722                     ; 189 void UART3_ITConfig(UART3_IT_TypeDef UART3_IT, FunctionalState NewState)
 722                     ; 190 {
 723                     	switch	.text
 724  012f               f_UART3_ITConfig:
 726  012f 89            	pushw	x
 727  0130 89            	pushw	x
 728       00000002      OFST:	set	2
 731                     ; 191   uint8_t uartreg = 0, itpos = 0x00;
 735                     ; 194   assert_param(IS_UART3_CONFIG_IT_OK(UART3_IT));
 737                     ; 195   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 739                     ; 198   uartreg = (uint8_t)((uint16_t)UART3_IT >> 0x08);
 741  0131 9e            	ld	a,xh
 742  0132 6b01          	ld	(OFST-1,sp),a
 744                     ; 201   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART3_IT & (uint8_t)0x0F));
 746  0134 9f            	ld	a,xl
 747  0135 a40f          	and	a,#15
 748  0137 5f            	clrw	x
 749  0138 97            	ld	xl,a
 750  0139 a601          	ld	a,#1
 751  013b 5d            	tnzw	x
 752  013c 2704          	jreq	L22
 753  013e               L42:
 754  013e 48            	sll	a
 755  013f 5a            	decw	x
 756  0140 26fc          	jrne	L42
 757  0142               L22:
 758  0142 6b02          	ld	(OFST+0,sp),a
 760                     ; 203   if (NewState != DISABLE)
 762  0144 7b08          	ld	a,(OFST+6,sp)
 763  0146 272a          	jreq	L172
 764                     ; 206     if (uartreg == 0x01)
 766  0148 7b01          	ld	a,(OFST-1,sp)
 767  014a a101          	cp	a,#1
 768  014c 2607          	jrne	L372
 769                     ; 208       UART3->CR1 |= itpos;
 771  014e c65244        	ld	a,21060
 772  0151 1a02          	or	a,(OFST+0,sp)
 774  0153 2029          	jpf	LC003
 775  0155               L372:
 776                     ; 210     else if (uartreg == 0x02)
 778  0155 a102          	cp	a,#2
 779  0157 2607          	jrne	L772
 780                     ; 212       UART3->CR2 |= itpos;
 782  0159 c65245        	ld	a,21061
 783  015c 1a02          	or	a,(OFST+0,sp)
 785  015e 202d          	jpf	LC002
 786  0160               L772:
 787                     ; 214     else if (uartreg == 0x03)
 789  0160 a103          	cp	a,#3
 790  0162 2607          	jrne	L303
 791                     ; 216       UART3->CR4 |= itpos;
 793  0164 c65247        	ld	a,21063
 794  0167 1a02          	or	a,(OFST+0,sp)
 796  0169 2031          	jpf	LC004
 797  016b               L303:
 798                     ; 220       UART3->CR6 |= itpos;
 800  016b c65249        	ld	a,21065
 801  016e 1a02          	or	a,(OFST+0,sp)
 802  0170 2035          	jpf	LC001
 803  0172               L172:
 804                     ; 226     if (uartreg == 0x01)
 806  0172 7b01          	ld	a,(OFST-1,sp)
 807  0174 a101          	cp	a,#1
 808  0176 260b          	jrne	L113
 809                     ; 228       UART3->CR1 &= (uint8_t)(~itpos);
 811  0178 7b02          	ld	a,(OFST+0,sp)
 812  017a 43            	cpl	a
 813  017b c45244        	and	a,21060
 814  017e               LC003:
 815  017e c75244        	ld	21060,a
 817  0181 2027          	jra	L703
 818  0183               L113:
 819                     ; 230     else if (uartreg == 0x02)
 821  0183 a102          	cp	a,#2
 822  0185 260b          	jrne	L513
 823                     ; 232       UART3->CR2 &= (uint8_t)(~itpos);
 825  0187 7b02          	ld	a,(OFST+0,sp)
 826  0189 43            	cpl	a
 827  018a c45245        	and	a,21061
 828  018d               LC002:
 829  018d c75245        	ld	21061,a
 831  0190 2018          	jra	L703
 832  0192               L513:
 833                     ; 234     else if (uartreg == 0x03)
 835  0192 a103          	cp	a,#3
 836  0194 260b          	jrne	L123
 837                     ; 236       UART3->CR4 &= (uint8_t)(~itpos);
 839  0196 7b02          	ld	a,(OFST+0,sp)
 840  0198 43            	cpl	a
 841  0199 c45247        	and	a,21063
 842  019c               LC004:
 843  019c c75247        	ld	21063,a
 845  019f 2009          	jra	L703
 846  01a1               L123:
 847                     ; 240       UART3->CR6 &= (uint8_t)(~itpos);
 849  01a1 7b02          	ld	a,(OFST+0,sp)
 850  01a3 43            	cpl	a
 851  01a4 c45249        	and	a,21065
 852  01a7               LC001:
 853  01a7 c75249        	ld	21065,a
 854  01aa               L703:
 855                     ; 243 }
 858  01aa 5b04          	addw	sp,#4
 859  01ac 87            	retf	
 917                     ; 252 void UART3_LINBreakDetectionConfig(UART3_LINBreakDetectionLength_TypeDef UART3_LINBreakDetectionLength)
 917                     ; 253 {
 918                     	switch	.text
 919  01ad               f_UART3_LINBreakDetectionConfig:
 923                     ; 255   assert_param(IS_UART3_LINBREAKDETECTIONLENGTH_OK(UART3_LINBreakDetectionLength));
 925                     ; 257   if (UART3_LINBreakDetectionLength != UART3_LINBREAKDETECTIONLENGTH_10BITS)
 927  01ad 4d            	tnz	a
 928  01ae 2705          	jreq	L353
 929                     ; 259     UART3->CR4 |= UART3_CR4_LBDL;
 931  01b0 721a5247      	bset	21063,#5
 934  01b4 87            	retf	
 935  01b5               L353:
 936                     ; 263     UART3->CR4 &= ((uint8_t)~UART3_CR4_LBDL);
 938  01b5 721b5247      	bres	21063,#5
 939                     ; 265 }
 942  01b9 87            	retf	
1062                     ; 277 void UART3_LINConfig(UART3_LinMode_TypeDef UART3_Mode,
1062                     ; 278                      UART3_LinAutosync_TypeDef UART3_Autosync, 
1062                     ; 279                      UART3_LinDivUp_TypeDef UART3_DivUp)
1062                     ; 280 {
1063                     	switch	.text
1064  01ba               f_UART3_LINConfig:
1066  01ba 89            	pushw	x
1067       00000000      OFST:	set	0
1070                     ; 282   assert_param(IS_UART3_SLAVE_OK(UART3_Mode));
1072                     ; 283   assert_param(IS_UART3_AUTOSYNC_OK(UART3_Autosync));
1074                     ; 284   assert_param(IS_UART3_DIVUP_OK(UART3_DivUp));
1076                     ; 286   if (UART3_Mode != UART3_LIN_MODE_MASTER)
1078  01bb 9e            	ld	a,xh
1079  01bc 4d            	tnz	a
1080  01bd 2706          	jreq	L534
1081                     ; 288     UART3->CR6 |=  UART3_CR6_LSLV;
1083  01bf 721a5249      	bset	21065,#5
1085  01c3 2004          	jra	L734
1086  01c5               L534:
1087                     ; 292     UART3->CR6 &= ((uint8_t)~UART3_CR6_LSLV);
1089  01c5 721b5249      	bres	21065,#5
1090  01c9               L734:
1091                     ; 295   if (UART3_Autosync != UART3_LIN_AUTOSYNC_DISABLE)
1093  01c9 7b02          	ld	a,(OFST+2,sp)
1094  01cb 2706          	jreq	L144
1095                     ; 297     UART3->CR6 |=  UART3_CR6_LASE ;
1097  01cd 72185249      	bset	21065,#4
1099  01d1 2004          	jra	L344
1100  01d3               L144:
1101                     ; 301     UART3->CR6 &= ((uint8_t)~ UART3_CR6_LASE );
1103  01d3 72195249      	bres	21065,#4
1104  01d7               L344:
1105                     ; 304   if (UART3_DivUp != UART3_LIN_DIVUP_LBRR1)
1107  01d7 7b06          	ld	a,(OFST+6,sp)
1108  01d9 2706          	jreq	L544
1109                     ; 306     UART3->CR6 |=  UART3_CR6_LDUM;
1111  01db 721e5249      	bset	21065,#7
1113  01df 2004          	jra	L744
1114  01e1               L544:
1115                     ; 310     UART3->CR6 &= ((uint8_t)~ UART3_CR6_LDUM);
1117  01e1 721f5249      	bres	21065,#7
1118  01e5               L744:
1119                     ; 312 }
1122  01e5 85            	popw	x
1123  01e6 87            	retf	
1157                     ; 320 void UART3_LINCmd(FunctionalState NewState)
1157                     ; 321 {
1158                     	switch	.text
1159  01e7               f_UART3_LINCmd:
1163                     ; 323   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1165                     ; 325   if (NewState != DISABLE)
1167  01e7 4d            	tnz	a
1168  01e8 2705          	jreq	L764
1169                     ; 328     UART3->CR3 |= UART3_CR3_LINEN;
1171  01ea 721c5246      	bset	21062,#6
1174  01ee 87            	retf	
1175  01ef               L764:
1176                     ; 333     UART3->CR3 &= ((uint8_t)~UART3_CR3_LINEN);
1178  01ef 721d5246      	bres	21062,#6
1179                     ; 335 }
1182  01f3 87            	retf	
1238                     ; 343 void UART3_WakeUpConfig(UART3_WakeUp_TypeDef UART3_WakeUp)
1238                     ; 344 {
1239                     	switch	.text
1240  01f4               f_UART3_WakeUpConfig:
1244                     ; 346   assert_param(IS_UART3_WAKEUP_OK(UART3_WakeUp));
1246                     ; 348   UART3->CR1 &= ((uint8_t)~UART3_CR1_WAKE);
1248  01f4 72175244      	bres	21060,#3
1249                     ; 349   UART3->CR1 |= (uint8_t)UART3_WakeUp;
1251  01f8 ca5244        	or	a,21060
1252  01fb c75244        	ld	21060,a
1253                     ; 350 }
1256  01fe 87            	retf	
1291                     ; 358 void UART3_ReceiverWakeUpCmd(FunctionalState NewState)
1291                     ; 359 {
1292                     	switch	.text
1293  01ff               f_UART3_ReceiverWakeUpCmd:
1297                     ; 361   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1299                     ; 363   if (NewState != DISABLE)
1301  01ff 4d            	tnz	a
1302  0200 2705          	jreq	L735
1303                     ; 366     UART3->CR2 |= UART3_CR2_RWU;
1305  0202 72125245      	bset	21061,#1
1308  0206 87            	retf	
1309  0207               L735:
1310                     ; 371     UART3->CR2 &= ((uint8_t)~UART3_CR2_RWU);
1312  0207 72135245      	bres	21061,#1
1313                     ; 373 }
1316  020b 87            	retf	
1338                     ; 380 uint8_t UART3_ReceiveData8(void)
1338                     ; 381 {
1339                     	switch	.text
1340  020c               f_UART3_ReceiveData8:
1344                     ; 382   return ((uint8_t)UART3->DR);
1346  020c c65241        	ld	a,21057
1349  020f 87            	retf	
1382                     ; 390 uint16_t UART3_ReceiveData9(void)
1382                     ; 391 {
1383                     	switch	.text
1384  0210               f_UART3_ReceiveData9:
1386  0210 89            	pushw	x
1387       00000002      OFST:	set	2
1390                     ; 392   uint16_t temp = 0;
1392                     ; 394   temp = (uint16_t)(((uint16_t)((uint16_t)UART3->CR1 & (uint16_t)UART3_CR1_R8)) << 1);
1394  0211 c65244        	ld	a,21060
1395  0214 a480          	and	a,#128
1396  0216 5f            	clrw	x
1397  0217 02            	rlwa	x,a
1398  0218 58            	sllw	x
1399  0219 1f01          	ldw	(OFST-1,sp),x
1401                     ; 395   return (uint16_t)((((uint16_t)UART3->DR) | temp) & ((uint16_t)0x01FF));
1403  021b c65241        	ld	a,21057
1404  021e 5f            	clrw	x
1405  021f 97            	ld	xl,a
1406  0220 01            	rrwa	x,a
1407  0221 1a02          	or	a,(OFST+0,sp)
1408  0223 01            	rrwa	x,a
1409  0224 1a01          	or	a,(OFST-1,sp)
1410  0226 a401          	and	a,#1
1411  0228 01            	rrwa	x,a
1414  0229 5b02          	addw	sp,#2
1415  022b 87            	retf	
1448                     ; 403 void UART3_SendData8(uint8_t Data)
1448                     ; 404 {
1449                     	switch	.text
1450  022c               f_UART3_SendData8:
1454                     ; 406   UART3->DR = Data;
1456  022c c75241        	ld	21057,a
1457                     ; 407 }
1460  022f 87            	retf	
1493                     ; 414 void UART3_SendData9(uint16_t Data)
1493                     ; 415 {
1494                     	switch	.text
1495  0230               f_UART3_SendData9:
1497  0230 89            	pushw	x
1498       00000000      OFST:	set	0
1501                     ; 417   UART3->CR1 &= ((uint8_t)~UART3_CR1_T8);                  
1503  0231 721d5244      	bres	21060,#6
1504                     ; 420   UART3->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART3_CR1_T8); 
1506  0235 54            	srlw	x
1507  0236 54            	srlw	x
1508  0237 9f            	ld	a,xl
1509  0238 a440          	and	a,#64
1510  023a ca5244        	or	a,21060
1511  023d c75244        	ld	21060,a
1512                     ; 423   UART3->DR   = (uint8_t)(Data);                    
1514  0240 7b02          	ld	a,(OFST+2,sp)
1515  0242 c75241        	ld	21057,a
1516                     ; 424 }
1519  0245 85            	popw	x
1520  0246 87            	retf	
1542                     ; 431 void UART3_SendBreak(void)
1542                     ; 432 {
1543                     	switch	.text
1544  0247               f_UART3_SendBreak:
1548                     ; 433   UART3->CR2 |= UART3_CR2_SBK;
1550  0247 72105245      	bset	21061,#0
1551                     ; 434 }
1554  024b 87            	retf	
1587                     ; 441 void UART3_SetAddress(uint8_t UART3_Address)
1587                     ; 442 {
1588                     	switch	.text
1589  024c               f_UART3_SetAddress:
1591  024c 88            	push	a
1592       00000000      OFST:	set	0
1595                     ; 444   assert_param(IS_UART3_ADDRESS_OK(UART3_Address));
1597                     ; 447   UART3->CR4 &= ((uint8_t)~UART3_CR4_ADD);
1599  024d c65247        	ld	a,21063
1600  0250 a4f0          	and	a,#240
1601  0252 c75247        	ld	21063,a
1602                     ; 449   UART3->CR4 |= UART3_Address;
1604  0255 c65247        	ld	a,21063
1605  0258 1a01          	or	a,(OFST+1,sp)
1606  025a c75247        	ld	21063,a
1607                     ; 450 }
1610  025d 84            	pop	a
1611  025e 87            	retf	
1767                     ; 458 FlagStatus UART3_GetFlagStatus(UART3_Flag_TypeDef UART3_FLAG)
1767                     ; 459 {
1768                     	switch	.text
1769  025f               f_UART3_GetFlagStatus:
1771  025f 89            	pushw	x
1772  0260 88            	push	a
1773       00000001      OFST:	set	1
1776                     ; 460   FlagStatus status = RESET;
1778                     ; 463   assert_param(IS_UART3_FLAG_OK(UART3_FLAG));
1780                     ; 466   if (UART3_FLAG == UART3_FLAG_LBDF)
1782  0261 a30210        	cpw	x,#528
1783  0264 2608          	jrne	L147
1784                     ; 468     if ((UART3->CR4 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1786  0266 9f            	ld	a,xl
1787  0267 c45247        	and	a,21063
1788  026a 2726          	jreq	L747
1789                     ; 471       status = SET;
1791  026c 201f          	jpf	LC007
1792                     ; 476       status = RESET;
1793  026e               L147:
1794                     ; 479   else if (UART3_FLAG == UART3_FLAG_SBK)
1796  026e a30101        	cpw	x,#257
1797  0271 2609          	jrne	L157
1798                     ; 481     if ((UART3->CR2 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1800  0273 c65245        	ld	a,21061
1801  0276 1503          	bcp	a,(OFST+2,sp)
1802  0278 2717          	jreq	L567
1803                     ; 484       status = SET;
1805  027a 2011          	jpf	LC007
1806                     ; 489       status = RESET;
1807  027c               L157:
1808                     ; 492   else if ((UART3_FLAG == UART3_FLAG_LHDF) || (UART3_FLAG == UART3_FLAG_LSF))
1810  027c a30302        	cpw	x,#770
1811  027f 2705          	jreq	L367
1813  0281 a30301        	cpw	x,#769
1814  0284 260f          	jrne	L167
1815  0286               L367:
1816                     ; 494     if ((UART3->CR6 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1818  0286 c65249        	ld	a,21065
1819  0289 1503          	bcp	a,(OFST+2,sp)
1820  028b 2704          	jreq	L567
1821                     ; 497       status = SET;
1823  028d               LC007:
1827  028d a601          	ld	a,#1
1831  028f 2001          	jra	L747
1832  0291               L567:
1833                     ; 502       status = RESET;
1837  0291 4f            	clr	a
1839  0292               L747:
1840                     ; 520   return  status;
1844  0292 5b03          	addw	sp,#3
1845  0294 87            	retf	
1846  0295               L167:
1847                     ; 507     if ((UART3->SR & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1849  0295 c65240        	ld	a,21056
1850  0298 1503          	bcp	a,(OFST+2,sp)
1851  029a 27f5          	jreq	L567
1852                     ; 510       status = SET;
1854  029c 20ef          	jpf	LC007
1855                     ; 515       status = RESET;
1889                     ; 551 void UART3_ClearFlag(UART3_Flag_TypeDef UART3_FLAG)
1889                     ; 552 {
1890                     	switch	.text
1891  029e               f_UART3_ClearFlag:
1893       00000000      OFST:	set	0
1896                     ; 554   assert_param(IS_UART3_CLEAR_FLAG_OK(UART3_FLAG));
1898                     ; 557   if (UART3_FLAG == UART3_FLAG_RXNE)
1900  029e a30020        	cpw	x,#32
1901  02a1 2605          	jrne	L5101
1902                     ; 559     UART3->SR = (uint8_t)~(UART3_SR_RXNE);
1904  02a3 35df5240      	mov	21056,#223
1907  02a7 87            	retf	
1908  02a8               L5101:
1909                     ; 562   else if (UART3_FLAG == UART3_FLAG_LBDF)
1911  02a8 a30210        	cpw	x,#528
1912  02ab 2605          	jrne	L1201
1913                     ; 564     UART3->CR4 &= (uint8_t)(~UART3_CR4_LBDF);
1915  02ad 72195247      	bres	21063,#4
1918  02b1 87            	retf	
1919  02b2               L1201:
1920                     ; 567   else if (UART3_FLAG == UART3_FLAG_LHDF)
1922  02b2 a30302        	cpw	x,#770
1923  02b5 2605          	jrne	L5201
1924                     ; 569     UART3->CR6 &= (uint8_t)(~UART3_CR6_LHDF);
1926  02b7 72135249      	bres	21065,#1
1929  02bb 87            	retf	
1930  02bc               L5201:
1931                     ; 574     UART3->CR6 &= (uint8_t)(~UART3_CR6_LSF);
1933  02bc 72115249      	bres	21065,#0
1934                     ; 576 }
1937  02c0 87            	retf	
2018                     ; 591 ITStatus UART3_GetITStatus(UART3_IT_TypeDef UART3_IT)
2018                     ; 592 {
2019                     	switch	.text
2020  02c1               f_UART3_GetITStatus:
2022  02c1 89            	pushw	x
2023  02c2 89            	pushw	x
2024       00000002      OFST:	set	2
2027                     ; 593   ITStatus pendingbitstatus = RESET;
2029                     ; 594   uint8_t itpos = 0;
2031                     ; 595   uint8_t itmask1 = 0;
2033                     ; 596   uint8_t itmask2 = 0;
2035                     ; 597   uint8_t enablestatus = 0;
2037                     ; 600   assert_param(IS_UART3_GET_IT_OK(UART3_IT));
2039                     ; 603   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART3_IT & (uint8_t)0x0F));
2041  02c3 9f            	ld	a,xl
2042  02c4 a40f          	and	a,#15
2043  02c6 5f            	clrw	x
2044  02c7 97            	ld	xl,a
2045  02c8 a601          	ld	a,#1
2046  02ca 5d            	tnzw	x
2047  02cb 2704          	jreq	L26
2048  02cd               L46:
2049  02cd 48            	sll	a
2050  02ce 5a            	decw	x
2051  02cf 26fc          	jrne	L46
2052  02d1               L26:
2053  02d1 6b01          	ld	(OFST-1,sp),a
2055                     ; 605   itmask1 = (uint8_t)((uint8_t)UART3_IT >> (uint8_t)4);
2057  02d3 7b04          	ld	a,(OFST+2,sp)
2058  02d5 4e            	swap	a
2059  02d6 a40f          	and	a,#15
2060  02d8 6b02          	ld	(OFST+0,sp),a
2062                     ; 607   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2064  02da 5f            	clrw	x
2065  02db 97            	ld	xl,a
2066  02dc a601          	ld	a,#1
2067  02de 5d            	tnzw	x
2068  02df 2704          	jreq	L66
2069  02e1               L07:
2070  02e1 48            	sll	a
2071  02e2 5a            	decw	x
2072  02e3 26fc          	jrne	L07
2073  02e5               L66:
2074  02e5 6b02          	ld	(OFST+0,sp),a
2076                     ; 610   if (UART3_IT == UART3_IT_PE)
2078  02e7 1e03          	ldw	x,(OFST+1,sp)
2079  02e9 a30100        	cpw	x,#256
2080  02ec 260c          	jrne	L3701
2081                     ; 613     enablestatus = (uint8_t)((uint8_t)UART3->CR1 & itmask2);
2083  02ee c65244        	ld	a,21060
2084  02f1 1402          	and	a,(OFST+0,sp)
2085  02f3 6b02          	ld	(OFST+0,sp),a
2087                     ; 616     if (((UART3->SR & itpos) != (uint8_t)0x00) && enablestatus)
2089  02f5 c65240        	ld	a,21056
2091                     ; 619       pendingbitstatus = SET;
2093  02f8 2020          	jpf	LC010
2094                     ; 624       pendingbitstatus = RESET;
2095  02fa               L3701:
2096                     ; 627   else if (UART3_IT == UART3_IT_LBDF)
2098  02fa a30346        	cpw	x,#838
2099  02fd 260c          	jrne	L3011
2100                     ; 630     enablestatus = (uint8_t)((uint8_t)UART3->CR4 & itmask2);
2102  02ff c65247        	ld	a,21063
2103  0302 1402          	and	a,(OFST+0,sp)
2104  0304 6b02          	ld	(OFST+0,sp),a
2106                     ; 632     if (((UART3->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2108  0306 c65247        	ld	a,21063
2110                     ; 635       pendingbitstatus = SET;
2112  0309 200f          	jpf	LC010
2113                     ; 640       pendingbitstatus = RESET;
2114  030b               L3011:
2115                     ; 643   else if (UART3_IT == UART3_IT_LHDF)
2117  030b a30412        	cpw	x,#1042
2118  030e 2616          	jrne	L3111
2119                     ; 646     enablestatus = (uint8_t)((uint8_t)UART3->CR6 & itmask2);
2121  0310 c65249        	ld	a,21065
2122  0313 1402          	and	a,(OFST+0,sp)
2123  0315 6b02          	ld	(OFST+0,sp),a
2125                     ; 648     if (((UART3->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
2127  0317 c65249        	ld	a,21065
2129  031a               LC010:
2130  031a 1501          	bcp	a,(OFST-1,sp)
2131  031c 271a          	jreq	L3211
2132  031e 7b02          	ld	a,(OFST+0,sp)
2133  0320 2716          	jreq	L3211
2134                     ; 651       pendingbitstatus = SET;
2136  0322               LC009:
2140  0322 a601          	ld	a,#1
2143  0324 2013          	jra	L1011
2144                     ; 656       pendingbitstatus = RESET;
2145  0326               L3111:
2146                     ; 662     enablestatus = (uint8_t)((uint8_t)UART3->CR2 & itmask2);
2148  0326 c65245        	ld	a,21061
2149  0329 1402          	and	a,(OFST+0,sp)
2150  032b 6b02          	ld	(OFST+0,sp),a
2152                     ; 664     if (((UART3->SR & itpos) != (uint8_t)0x00) && enablestatus)
2154  032d c65240        	ld	a,21056
2155  0330 1501          	bcp	a,(OFST-1,sp)
2156  0332 2704          	jreq	L3211
2158  0334 7b02          	ld	a,(OFST+0,sp)
2159                     ; 667       pendingbitstatus = SET;
2161  0336 26ea          	jrne	LC009
2162  0338               L3211:
2163                     ; 672       pendingbitstatus = RESET;
2168  0338 4f            	clr	a
2170  0339               L1011:
2171                     ; 676   return  pendingbitstatus;
2175  0339 5b04          	addw	sp,#4
2176  033b 87            	retf	
2211                     ; 706 void UART3_ClearITPendingBit(UART3_IT_TypeDef UART3_IT)
2211                     ; 707 {
2212                     	switch	.text
2213  033c               f_UART3_ClearITPendingBit:
2215       00000000      OFST:	set	0
2218                     ; 709   assert_param(IS_UART3_CLEAR_IT_OK(UART3_IT));
2220                     ; 712   if (UART3_IT == UART3_IT_RXNE)
2222  033c a30255        	cpw	x,#597
2223  033f 2605          	jrne	L5411
2224                     ; 714     UART3->SR = (uint8_t)~(UART3_SR_RXNE);
2226  0341 35df5240      	mov	21056,#223
2229  0345 87            	retf	
2230  0346               L5411:
2231                     ; 717   else if (UART3_IT == UART3_IT_LBDF)
2233  0346 a30346        	cpw	x,#838
2234  0349 2605          	jrne	L1511
2235                     ; 719     UART3->CR4 &= (uint8_t)~(UART3_CR4_LBDF);
2237  034b 72195247      	bres	21063,#4
2240  034f 87            	retf	
2241  0350               L1511:
2242                     ; 724     UART3->CR6 &= (uint8_t)(~UART3_CR6_LHDF);
2244  0350 72135249      	bres	21065,#1
2245                     ; 726 }
2248  0354 87            	retf	
2260                     	xdef	f_UART3_ClearITPendingBit
2261                     	xdef	f_UART3_GetITStatus
2262                     	xdef	f_UART3_ClearFlag
2263                     	xdef	f_UART3_GetFlagStatus
2264                     	xdef	f_UART3_SetAddress
2265                     	xdef	f_UART3_SendBreak
2266                     	xdef	f_UART3_SendData9
2267                     	xdef	f_UART3_SendData8
2268                     	xdef	f_UART3_ReceiveData9
2269                     	xdef	f_UART3_ReceiveData8
2270                     	xdef	f_UART3_WakeUpConfig
2271                     	xdef	f_UART3_ReceiverWakeUpCmd
2272                     	xdef	f_UART3_LINCmd
2273                     	xdef	f_UART3_LINConfig
2274                     	xdef	f_UART3_LINBreakDetectionConfig
2275                     	xdef	f_UART3_ITConfig
2276                     	xdef	f_UART3_Cmd
2277                     	xdef	f_UART3_Init
2278                     	xdef	f_UART3_DeInit
2279                     	xref	f_CLK_GetClockFreq
2280                     	xref.b	c_lreg
2281                     	xref.b	c_x
2300                     	xref	d_lsub
2301                     	xref	d_smul
2302                     	xref	d_ludv
2303                     	xref	d_rtol
2304                     	xref	d_llsh
2305                     	xref	d_ltor
2306                     	end
