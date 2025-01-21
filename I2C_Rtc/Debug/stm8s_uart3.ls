   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  42                     ; 54 void UART3_DeInit(void)
  42                     ; 55 {
  44                     	switch	.text
  45  0000               _UART3_DeInit:
  49                     ; 58   (void) UART3->SR;
  51  0000 c65240        	ld	a,21056
  52                     ; 59   (void) UART3->DR;
  54  0003 c65241        	ld	a,21057
  55                     ; 61   UART3->BRR2 = UART3_BRR2_RESET_VALUE; /*Set UART3_BRR2 to reset value 0x00 */
  57  0006 725f5243      	clr	21059
  58                     ; 62   UART3->BRR1 = UART3_BRR1_RESET_VALUE; /*Set UART3_BRR1 to reset value 0x00 */
  60  000a 725f5242      	clr	21058
  61                     ; 64   UART3->CR1 = UART3_CR1_RESET_VALUE;  /*Set UART3_CR1 to reset value 0x00  */
  63  000e 725f5244      	clr	21060
  64                     ; 65   UART3->CR2 = UART3_CR2_RESET_VALUE;  /*Set UART3_CR2 to reset value 0x00  */
  66  0012 725f5245      	clr	21061
  67                     ; 66   UART3->CR3 = UART3_CR3_RESET_VALUE;  /*Set UART3_CR3 to reset value 0x00  */
  69  0016 725f5246      	clr	21062
  70                     ; 67   UART3->CR4 = UART3_CR4_RESET_VALUE;  /*Set UART3_CR4 to reset value 0x00  */
  72  001a 725f5247      	clr	21063
  73                     ; 68   UART3->CR6 = UART3_CR6_RESET_VALUE;  /*Set UART3_CR6 to reset value 0x00  */
  75  001e 725f5249      	clr	21065
  76                     ; 69 }
  79  0022 81            	ret
 306                     .const:	section	.text
 307  0000               L01:
 308  0000 00000064      	dc.l	100
 309                     ; 83 void UART3_Init(uint32_t BaudRate, UART3_WordLength_TypeDef WordLength, 
 309                     ; 84                 UART3_StopBits_TypeDef StopBits, UART3_Parity_TypeDef Parity, 
 309                     ; 85                 UART3_Mode_TypeDef Mode)
 309                     ; 86 {
 310                     	switch	.text
 311  0023               _UART3_Init:
 313  0023 520e          	subw	sp,#14
 314       0000000e      OFST:	set	14
 317                     ; 87   uint8_t BRR2_1 = 0, BRR2_2 = 0;
 321                     ; 88   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 325                     ; 91   assert_param(IS_UART3_WORDLENGTH_OK(WordLength));
 327                     ; 92   assert_param(IS_UART3_STOPBITS_OK(StopBits));
 329                     ; 93   assert_param(IS_UART3_PARITY_OK(Parity));
 331                     ; 94   assert_param(IS_UART3_BAUDRATE_OK(BaudRate));
 333                     ; 95   assert_param(IS_UART3_MODE_OK((uint8_t)Mode));
 335                     ; 98   UART3->CR1 &= (uint8_t)(~UART3_CR1_M);     
 337  0025 72195244      	bres	21060,#4
 338                     ; 100   UART3->CR1 |= (uint8_t)WordLength; 
 340  0029 c65244        	ld	a,21060
 341  002c 1a15          	or	a,(OFST+7,sp)
 342  002e c75244        	ld	21060,a
 343                     ; 103   UART3->CR3 &= (uint8_t)(~UART3_CR3_STOP);  
 345  0031 c65246        	ld	a,21062
 346  0034 a4cf          	and	a,#207
 347  0036 c75246        	ld	21062,a
 348                     ; 105   UART3->CR3 |= (uint8_t)StopBits;  
 350  0039 c65246        	ld	a,21062
 351  003c 1a16          	or	a,(OFST+8,sp)
 352  003e c75246        	ld	21062,a
 353                     ; 108   UART3->CR1 &= (uint8_t)(~(UART3_CR1_PCEN | UART3_CR1_PS));  
 355  0041 c65244        	ld	a,21060
 356  0044 a4f9          	and	a,#249
 357  0046 c75244        	ld	21060,a
 358                     ; 110   UART3->CR1 |= (uint8_t)Parity;     
 360  0049 c65244        	ld	a,21060
 361  004c 1a17          	or	a,(OFST+9,sp)
 362  004e c75244        	ld	21060,a
 363                     ; 113   UART3->BRR1 &= (uint8_t)(~UART3_BRR1_DIVM);  
 365  0051 725f5242      	clr	21058
 366                     ; 115   UART3->BRR2 &= (uint8_t)(~UART3_BRR2_DIVM);  
 368  0055 c65243        	ld	a,21059
 369  0058 a40f          	and	a,#15
 370  005a c75243        	ld	21059,a
 371                     ; 117   UART3->BRR2 &= (uint8_t)(~UART3_BRR2_DIVF);  
 373  005d c65243        	ld	a,21059
 374  0060 a4f0          	and	a,#240
 375  0062 c75243        	ld	21059,a
 376                     ; 120   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 378  0065 96            	ldw	x,sp
 379  0066 1c0011        	addw	x,#OFST+3
 380  0069 cd0000        	call	c_ltor
 382  006c a604          	ld	a,#4
 383  006e cd0000        	call	c_llsh
 385  0071 96            	ldw	x,sp
 386  0072 1c0001        	addw	x,#OFST-13
 387  0075 cd0000        	call	c_rtol
 390  0078 cd0000        	call	_CLK_GetClockFreq
 392  007b 96            	ldw	x,sp
 393  007c 1c0001        	addw	x,#OFST-13
 394  007f cd0000        	call	c_ludv
 396  0082 96            	ldw	x,sp
 397  0083 1c000b        	addw	x,#OFST-3
 398  0086 cd0000        	call	c_rtol
 401                     ; 121   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 403  0089 96            	ldw	x,sp
 404  008a 1c0011        	addw	x,#OFST+3
 405  008d cd0000        	call	c_ltor
 407  0090 a604          	ld	a,#4
 408  0092 cd0000        	call	c_llsh
 410  0095 96            	ldw	x,sp
 411  0096 1c0001        	addw	x,#OFST-13
 412  0099 cd0000        	call	c_rtol
 415  009c cd0000        	call	_CLK_GetClockFreq
 417  009f a664          	ld	a,#100
 418  00a1 cd0000        	call	c_smul
 420  00a4 96            	ldw	x,sp
 421  00a5 1c0001        	addw	x,#OFST-13
 422  00a8 cd0000        	call	c_ludv
 424  00ab 96            	ldw	x,sp
 425  00ac 1c0007        	addw	x,#OFST-7
 426  00af cd0000        	call	c_rtol
 429                     ; 124   BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 429                     ; 125                                 << 4) / 100) & (uint8_t)0x0F); 
 431  00b2 96            	ldw	x,sp
 432  00b3 1c000b        	addw	x,#OFST-3
 433  00b6 cd0000        	call	c_ltor
 435  00b9 a664          	ld	a,#100
 436  00bb cd0000        	call	c_smul
 438  00be 96            	ldw	x,sp
 439  00bf 1c0001        	addw	x,#OFST-13
 440  00c2 cd0000        	call	c_rtol
 443  00c5 96            	ldw	x,sp
 444  00c6 1c0007        	addw	x,#OFST-7
 445  00c9 cd0000        	call	c_ltor
 447  00cc 96            	ldw	x,sp
 448  00cd 1c0001        	addw	x,#OFST-13
 449  00d0 cd0000        	call	c_lsub
 451  00d3 a604          	ld	a,#4
 452  00d5 cd0000        	call	c_llsh
 454  00d8 ae0000        	ldw	x,#L01
 455  00db cd0000        	call	c_ludv
 457  00de b603          	ld	a,c_lreg+3
 458  00e0 a40f          	and	a,#15
 459  00e2 6b05          	ld	(OFST-9,sp),a
 461                     ; 126   BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 463  00e4 1e0d          	ldw	x,(OFST-1,sp)
 464  00e6 54            	srlw	x
 465  00e7 54            	srlw	x
 466  00e8 54            	srlw	x
 467  00e9 54            	srlw	x
 468  00ea 01            	rrwa	x,a
 469  00eb a4f0          	and	a,#240
 470  00ed 5f            	clrw	x
 471  00ee 6b06          	ld	(OFST-8,sp),a
 473                     ; 128   UART3->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 475  00f0 7b05          	ld	a,(OFST-9,sp)
 476  00f2 1a06          	or	a,(OFST-8,sp)
 477  00f4 c75243        	ld	21059,a
 478                     ; 130   UART3->BRR1 = (uint8_t)BaudRate_Mantissa;           
 480  00f7 7b0e          	ld	a,(OFST+0,sp)
 481  00f9 c75242        	ld	21058,a
 482                     ; 132   if ((uint8_t)(Mode & UART3_MODE_TX_ENABLE))
 484  00fc 7b18          	ld	a,(OFST+10,sp)
 485  00fe a504          	bcp	a,#4
 486  0100 2706          	jreq	L741
 487                     ; 135     UART3->CR2 |= UART3_CR2_TEN;  
 489  0102 72165245      	bset	21061,#3
 491  0106 2004          	jra	L151
 492  0108               L741:
 493                     ; 140     UART3->CR2 &= (uint8_t)(~UART3_CR2_TEN);  
 495  0108 72175245      	bres	21061,#3
 496  010c               L151:
 497                     ; 142   if ((uint8_t)(Mode & UART3_MODE_RX_ENABLE))
 499  010c 7b18          	ld	a,(OFST+10,sp)
 500  010e a508          	bcp	a,#8
 501  0110 2706          	jreq	L351
 502                     ; 145     UART3->CR2 |= UART3_CR2_REN;  
 504  0112 72145245      	bset	21061,#2
 506  0116 2004          	jra	L551
 507  0118               L351:
 508                     ; 150     UART3->CR2 &= (uint8_t)(~UART3_CR2_REN);  
 510  0118 72155245      	bres	21061,#2
 511  011c               L551:
 512                     ; 152 }
 515  011c 5b0e          	addw	sp,#14
 516  011e 81            	ret
 571                     ; 160 void UART3_Cmd(FunctionalState NewState)
 571                     ; 161 {
 572                     	switch	.text
 573  011f               _UART3_Cmd:
 577                     ; 162   if (NewState != DISABLE)
 579  011f 4d            	tnz	a
 580  0120 2706          	jreq	L502
 581                     ; 165     UART3->CR1 &= (uint8_t)(~UART3_CR1_UARTD); 
 583  0122 721b5244      	bres	21060,#5
 585  0126 2004          	jra	L702
 586  0128               L502:
 587                     ; 170     UART3->CR1 |= UART3_CR1_UARTD;  
 589  0128 721a5244      	bset	21060,#5
 590  012c               L702:
 591                     ; 172 }
 594  012c 81            	ret
 726                     ; 189 void UART3_ITConfig(UART3_IT_TypeDef UART3_IT, FunctionalState NewState)
 726                     ; 190 {
 727                     	switch	.text
 728  012d               _UART3_ITConfig:
 730  012d 89            	pushw	x
 731  012e 89            	pushw	x
 732       00000002      OFST:	set	2
 735                     ; 191   uint8_t uartreg = 0, itpos = 0x00;
 739                     ; 194   assert_param(IS_UART3_CONFIG_IT_OK(UART3_IT));
 741                     ; 195   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 743                     ; 198   uartreg = (uint8_t)((uint16_t)UART3_IT >> 0x08);
 745  012f 9e            	ld	a,xh
 746  0130 6b01          	ld	(OFST-1,sp),a
 748                     ; 201   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART3_IT & (uint8_t)0x0F));
 750  0132 9f            	ld	a,xl
 751  0133 a40f          	and	a,#15
 752  0135 5f            	clrw	x
 753  0136 97            	ld	xl,a
 754  0137 a601          	ld	a,#1
 755  0139 5d            	tnzw	x
 756  013a 2704          	jreq	L61
 757  013c               L02:
 758  013c 48            	sll	a
 759  013d 5a            	decw	x
 760  013e 26fc          	jrne	L02
 761  0140               L61:
 762  0140 6b02          	ld	(OFST+0,sp),a
 764                     ; 203   if (NewState != DISABLE)
 766  0142 0d07          	tnz	(OFST+5,sp)
 767  0144 273a          	jreq	L172
 768                     ; 206     if (uartreg == 0x01)
 770  0146 7b01          	ld	a,(OFST-1,sp)
 771  0148 a101          	cp	a,#1
 772  014a 260a          	jrne	L372
 773                     ; 208       UART3->CR1 |= itpos;
 775  014c c65244        	ld	a,21060
 776  014f 1a02          	or	a,(OFST+0,sp)
 777  0151 c75244        	ld	21060,a
 779  0154 2066          	jra	L703
 780  0156               L372:
 781                     ; 210     else if (uartreg == 0x02)
 783  0156 7b01          	ld	a,(OFST-1,sp)
 784  0158 a102          	cp	a,#2
 785  015a 260a          	jrne	L772
 786                     ; 212       UART3->CR2 |= itpos;
 788  015c c65245        	ld	a,21061
 789  015f 1a02          	or	a,(OFST+0,sp)
 790  0161 c75245        	ld	21061,a
 792  0164 2056          	jra	L703
 793  0166               L772:
 794                     ; 214     else if (uartreg == 0x03)
 796  0166 7b01          	ld	a,(OFST-1,sp)
 797  0168 a103          	cp	a,#3
 798  016a 260a          	jrne	L303
 799                     ; 216       UART3->CR4 |= itpos;
 801  016c c65247        	ld	a,21063
 802  016f 1a02          	or	a,(OFST+0,sp)
 803  0171 c75247        	ld	21063,a
 805  0174 2046          	jra	L703
 806  0176               L303:
 807                     ; 220       UART3->CR6 |= itpos;
 809  0176 c65249        	ld	a,21065
 810  0179 1a02          	or	a,(OFST+0,sp)
 811  017b c75249        	ld	21065,a
 812  017e 203c          	jra	L703
 813  0180               L172:
 814                     ; 226     if (uartreg == 0x01)
 816  0180 7b01          	ld	a,(OFST-1,sp)
 817  0182 a101          	cp	a,#1
 818  0184 260b          	jrne	L113
 819                     ; 228       UART3->CR1 &= (uint8_t)(~itpos);
 821  0186 7b02          	ld	a,(OFST+0,sp)
 822  0188 43            	cpl	a
 823  0189 c45244        	and	a,21060
 824  018c c75244        	ld	21060,a
 826  018f 202b          	jra	L703
 827  0191               L113:
 828                     ; 230     else if (uartreg == 0x02)
 830  0191 7b01          	ld	a,(OFST-1,sp)
 831  0193 a102          	cp	a,#2
 832  0195 260b          	jrne	L513
 833                     ; 232       UART3->CR2 &= (uint8_t)(~itpos);
 835  0197 7b02          	ld	a,(OFST+0,sp)
 836  0199 43            	cpl	a
 837  019a c45245        	and	a,21061
 838  019d c75245        	ld	21061,a
 840  01a0 201a          	jra	L703
 841  01a2               L513:
 842                     ; 234     else if (uartreg == 0x03)
 844  01a2 7b01          	ld	a,(OFST-1,sp)
 845  01a4 a103          	cp	a,#3
 846  01a6 260b          	jrne	L123
 847                     ; 236       UART3->CR4 &= (uint8_t)(~itpos);
 849  01a8 7b02          	ld	a,(OFST+0,sp)
 850  01aa 43            	cpl	a
 851  01ab c45247        	and	a,21063
 852  01ae c75247        	ld	21063,a
 854  01b1 2009          	jra	L703
 855  01b3               L123:
 856                     ; 240       UART3->CR6 &= (uint8_t)(~itpos);
 858  01b3 7b02          	ld	a,(OFST+0,sp)
 859  01b5 43            	cpl	a
 860  01b6 c45249        	and	a,21065
 861  01b9 c75249        	ld	21065,a
 862  01bc               L703:
 863                     ; 243 }
 866  01bc 5b04          	addw	sp,#4
 867  01be 81            	ret
 926                     ; 252 void UART3_LINBreakDetectionConfig(UART3_LINBreakDetectionLength_TypeDef UART3_LINBreakDetectionLength)
 926                     ; 253 {
 927                     	switch	.text
 928  01bf               _UART3_LINBreakDetectionConfig:
 932                     ; 255   assert_param(IS_UART3_LINBREAKDETECTIONLENGTH_OK(UART3_LINBreakDetectionLength));
 934                     ; 257   if (UART3_LINBreakDetectionLength != UART3_LINBREAKDETECTIONLENGTH_10BITS)
 936  01bf 4d            	tnz	a
 937  01c0 2706          	jreq	L353
 938                     ; 259     UART3->CR4 |= UART3_CR4_LBDL;
 940  01c2 721a5247      	bset	21063,#5
 942  01c6 2004          	jra	L553
 943  01c8               L353:
 944                     ; 263     UART3->CR4 &= ((uint8_t)~UART3_CR4_LBDL);
 946  01c8 721b5247      	bres	21063,#5
 947  01cc               L553:
 948                     ; 265 }
 951  01cc 81            	ret
1072                     ; 277 void UART3_LINConfig(UART3_LinMode_TypeDef UART3_Mode,
1072                     ; 278                      UART3_LinAutosync_TypeDef UART3_Autosync, 
1072                     ; 279                      UART3_LinDivUp_TypeDef UART3_DivUp)
1072                     ; 280 {
1073                     	switch	.text
1074  01cd               _UART3_LINConfig:
1076  01cd 89            	pushw	x
1077       00000000      OFST:	set	0
1080                     ; 282   assert_param(IS_UART3_SLAVE_OK(UART3_Mode));
1082                     ; 283   assert_param(IS_UART3_AUTOSYNC_OK(UART3_Autosync));
1084                     ; 284   assert_param(IS_UART3_DIVUP_OK(UART3_DivUp));
1086                     ; 286   if (UART3_Mode != UART3_LIN_MODE_MASTER)
1088  01ce 9e            	ld	a,xh
1089  01cf 4d            	tnz	a
1090  01d0 2706          	jreq	L534
1091                     ; 288     UART3->CR6 |=  UART3_CR6_LSLV;
1093  01d2 721a5249      	bset	21065,#5
1095  01d6 2004          	jra	L734
1096  01d8               L534:
1097                     ; 292     UART3->CR6 &= ((uint8_t)~UART3_CR6_LSLV);
1099  01d8 721b5249      	bres	21065,#5
1100  01dc               L734:
1101                     ; 295   if (UART3_Autosync != UART3_LIN_AUTOSYNC_DISABLE)
1103  01dc 0d02          	tnz	(OFST+2,sp)
1104  01de 2706          	jreq	L144
1105                     ; 297     UART3->CR6 |=  UART3_CR6_LASE ;
1107  01e0 72185249      	bset	21065,#4
1109  01e4 2004          	jra	L344
1110  01e6               L144:
1111                     ; 301     UART3->CR6 &= ((uint8_t)~ UART3_CR6_LASE );
1113  01e6 72195249      	bres	21065,#4
1114  01ea               L344:
1115                     ; 304   if (UART3_DivUp != UART3_LIN_DIVUP_LBRR1)
1117  01ea 0d05          	tnz	(OFST+5,sp)
1118  01ec 2706          	jreq	L544
1119                     ; 306     UART3->CR6 |=  UART3_CR6_LDUM;
1121  01ee 721e5249      	bset	21065,#7
1123  01f2 2004          	jra	L744
1124  01f4               L544:
1125                     ; 310     UART3->CR6 &= ((uint8_t)~ UART3_CR6_LDUM);
1127  01f4 721f5249      	bres	21065,#7
1128  01f8               L744:
1129                     ; 312 }
1132  01f8 85            	popw	x
1133  01f9 81            	ret
1168                     ; 320 void UART3_LINCmd(FunctionalState NewState)
1168                     ; 321 {
1169                     	switch	.text
1170  01fa               _UART3_LINCmd:
1174                     ; 323   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1176                     ; 325   if (NewState != DISABLE)
1178  01fa 4d            	tnz	a
1179  01fb 2706          	jreq	L764
1180                     ; 328     UART3->CR3 |= UART3_CR3_LINEN;
1182  01fd 721c5246      	bset	21062,#6
1184  0201 2004          	jra	L174
1185  0203               L764:
1186                     ; 333     UART3->CR3 &= ((uint8_t)~UART3_CR3_LINEN);
1188  0203 721d5246      	bres	21062,#6
1189  0207               L174:
1190                     ; 335 }
1193  0207 81            	ret
1250                     ; 343 void UART3_WakeUpConfig(UART3_WakeUp_TypeDef UART3_WakeUp)
1250                     ; 344 {
1251                     	switch	.text
1252  0208               _UART3_WakeUpConfig:
1256                     ; 346   assert_param(IS_UART3_WAKEUP_OK(UART3_WakeUp));
1258                     ; 348   UART3->CR1 &= ((uint8_t)~UART3_CR1_WAKE);
1260  0208 72175244      	bres	21060,#3
1261                     ; 349   UART3->CR1 |= (uint8_t)UART3_WakeUp;
1263  020c ca5244        	or	a,21060
1264  020f c75244        	ld	21060,a
1265                     ; 350 }
1268  0212 81            	ret
1304                     ; 358 void UART3_ReceiverWakeUpCmd(FunctionalState NewState)
1304                     ; 359 {
1305                     	switch	.text
1306  0213               _UART3_ReceiverWakeUpCmd:
1310                     ; 361   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1312                     ; 363   if (NewState != DISABLE)
1314  0213 4d            	tnz	a
1315  0214 2706          	jreq	L735
1316                     ; 366     UART3->CR2 |= UART3_CR2_RWU;
1318  0216 72125245      	bset	21061,#1
1320  021a 2004          	jra	L145
1321  021c               L735:
1322                     ; 371     UART3->CR2 &= ((uint8_t)~UART3_CR2_RWU);
1324  021c 72135245      	bres	21061,#1
1325  0220               L145:
1326                     ; 373 }
1329  0220 81            	ret
1352                     ; 380 uint8_t UART3_ReceiveData8(void)
1352                     ; 381 {
1353                     	switch	.text
1354  0221               _UART3_ReceiveData8:
1358                     ; 382   return ((uint8_t)UART3->DR);
1360  0221 c65241        	ld	a,21057
1363  0224 81            	ret
1397                     ; 390 uint16_t UART3_ReceiveData9(void)
1397                     ; 391 {
1398                     	switch	.text
1399  0225               _UART3_ReceiveData9:
1401  0225 89            	pushw	x
1402       00000002      OFST:	set	2
1405                     ; 392   uint16_t temp = 0;
1407                     ; 394   temp = (uint16_t)(((uint16_t)((uint16_t)UART3->CR1 & (uint16_t)UART3_CR1_R8)) << 1);
1409  0226 c65244        	ld	a,21060
1410  0229 5f            	clrw	x
1411  022a a480          	and	a,#128
1412  022c 5f            	clrw	x
1413  022d 02            	rlwa	x,a
1414  022e 58            	sllw	x
1415  022f 1f01          	ldw	(OFST-1,sp),x
1417                     ; 395   return (uint16_t)((((uint16_t)UART3->DR) | temp) & ((uint16_t)0x01FF));
1419  0231 c65241        	ld	a,21057
1420  0234 5f            	clrw	x
1421  0235 97            	ld	xl,a
1422  0236 01            	rrwa	x,a
1423  0237 1a02          	or	a,(OFST+0,sp)
1424  0239 01            	rrwa	x,a
1425  023a 1a01          	or	a,(OFST-1,sp)
1426  023c 01            	rrwa	x,a
1427  023d 01            	rrwa	x,a
1428  023e a4ff          	and	a,#255
1429  0240 01            	rrwa	x,a
1430  0241 a401          	and	a,#1
1431  0243 01            	rrwa	x,a
1434  0244 5b02          	addw	sp,#2
1435  0246 81            	ret
1469                     ; 403 void UART3_SendData8(uint8_t Data)
1469                     ; 404 {
1470                     	switch	.text
1471  0247               _UART3_SendData8:
1475                     ; 406   UART3->DR = Data;
1477  0247 c75241        	ld	21057,a
1478                     ; 407 }
1481  024a 81            	ret
1515                     ; 414 void UART3_SendData9(uint16_t Data)
1515                     ; 415 {
1516                     	switch	.text
1517  024b               _UART3_SendData9:
1519  024b 89            	pushw	x
1520       00000000      OFST:	set	0
1523                     ; 417   UART3->CR1 &= ((uint8_t)~UART3_CR1_T8);                  
1525  024c 721d5244      	bres	21060,#6
1526                     ; 420   UART3->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART3_CR1_T8); 
1528  0250 54            	srlw	x
1529  0251 54            	srlw	x
1530  0252 9f            	ld	a,xl
1531  0253 a440          	and	a,#64
1532  0255 ca5244        	or	a,21060
1533  0258 c75244        	ld	21060,a
1534                     ; 423   UART3->DR   = (uint8_t)(Data);                    
1536  025b 7b02          	ld	a,(OFST+2,sp)
1537  025d c75241        	ld	21057,a
1538                     ; 424 }
1541  0260 85            	popw	x
1542  0261 81            	ret
1565                     ; 431 void UART3_SendBreak(void)
1565                     ; 432 {
1566                     	switch	.text
1567  0262               _UART3_SendBreak:
1571                     ; 433   UART3->CR2 |= UART3_CR2_SBK;
1573  0262 72105245      	bset	21061,#0
1574                     ; 434 }
1577  0266 81            	ret
1611                     ; 441 void UART3_SetAddress(uint8_t UART3_Address)
1611                     ; 442 {
1612                     	switch	.text
1613  0267               _UART3_SetAddress:
1615  0267 88            	push	a
1616       00000000      OFST:	set	0
1619                     ; 444   assert_param(IS_UART3_ADDRESS_OK(UART3_Address));
1621                     ; 447   UART3->CR4 &= ((uint8_t)~UART3_CR4_ADD);
1623  0268 c65247        	ld	a,21063
1624  026b a4f0          	and	a,#240
1625  026d c75247        	ld	21063,a
1626                     ; 449   UART3->CR4 |= UART3_Address;
1628  0270 c65247        	ld	a,21063
1629  0273 1a01          	or	a,(OFST+1,sp)
1630  0275 c75247        	ld	21063,a
1631                     ; 450 }
1634  0278 84            	pop	a
1635  0279 81            	ret
1792                     ; 458 FlagStatus UART3_GetFlagStatus(UART3_Flag_TypeDef UART3_FLAG)
1792                     ; 459 {
1793                     	switch	.text
1794  027a               _UART3_GetFlagStatus:
1796  027a 89            	pushw	x
1797  027b 88            	push	a
1798       00000001      OFST:	set	1
1801                     ; 460   FlagStatus status = RESET;
1803                     ; 463   assert_param(IS_UART3_FLAG_OK(UART3_FLAG));
1805                     ; 466   if (UART3_FLAG == UART3_FLAG_LBDF)
1807  027c a30210        	cpw	x,#528
1808  027f 2610          	jrne	L147
1809                     ; 468     if ((UART3->CR4 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1811  0281 9f            	ld	a,xl
1812  0282 c45247        	and	a,21063
1813  0285 2706          	jreq	L347
1814                     ; 471       status = SET;
1816  0287 a601          	ld	a,#1
1817  0289 6b01          	ld	(OFST+0,sp),a
1820  028b 2039          	jra	L747
1821  028d               L347:
1822                     ; 476       status = RESET;
1824  028d 0f01          	clr	(OFST+0,sp)
1826  028f 2035          	jra	L747
1827  0291               L147:
1828                     ; 479   else if (UART3_FLAG == UART3_FLAG_SBK)
1830  0291 1e02          	ldw	x,(OFST+1,sp)
1831  0293 a30101        	cpw	x,#257
1832  0296 2611          	jrne	L157
1833                     ; 481     if ((UART3->CR2 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1835  0298 c65245        	ld	a,21061
1836  029b 1503          	bcp	a,(OFST+2,sp)
1837  029d 2706          	jreq	L357
1838                     ; 484       status = SET;
1840  029f a601          	ld	a,#1
1841  02a1 6b01          	ld	(OFST+0,sp),a
1844  02a3 2021          	jra	L747
1845  02a5               L357:
1846                     ; 489       status = RESET;
1848  02a5 0f01          	clr	(OFST+0,sp)
1850  02a7 201d          	jra	L747
1851  02a9               L157:
1852                     ; 492   else if ((UART3_FLAG == UART3_FLAG_LHDF) || (UART3_FLAG == UART3_FLAG_LSF))
1854  02a9 1e02          	ldw	x,(OFST+1,sp)
1855  02ab a30302        	cpw	x,#770
1856  02ae 2707          	jreq	L367
1858  02b0 1e02          	ldw	x,(OFST+1,sp)
1859  02b2 a30301        	cpw	x,#769
1860  02b5 2614          	jrne	L167
1861  02b7               L367:
1862                     ; 494     if ((UART3->CR6 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1864  02b7 c65249        	ld	a,21065
1865  02ba 1503          	bcp	a,(OFST+2,sp)
1866  02bc 2706          	jreq	L567
1867                     ; 497       status = SET;
1869  02be a601          	ld	a,#1
1870  02c0 6b01          	ld	(OFST+0,sp),a
1873  02c2 2002          	jra	L747
1874  02c4               L567:
1875                     ; 502       status = RESET;
1877  02c4 0f01          	clr	(OFST+0,sp)
1879  02c6               L747:
1880                     ; 520   return  status;
1882  02c6 7b01          	ld	a,(OFST+0,sp)
1885  02c8 5b03          	addw	sp,#3
1886  02ca 81            	ret
1887  02cb               L167:
1888                     ; 507     if ((UART3->SR & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
1890  02cb c65240        	ld	a,21056
1891  02ce 1503          	bcp	a,(OFST+2,sp)
1892  02d0 2706          	jreq	L377
1893                     ; 510       status = SET;
1895  02d2 a601          	ld	a,#1
1896  02d4 6b01          	ld	(OFST+0,sp),a
1899  02d6 20ee          	jra	L747
1900  02d8               L377:
1901                     ; 515       status = RESET;
1903  02d8 0f01          	clr	(OFST+0,sp)
1905  02da 20ea          	jra	L747
1940                     ; 551 void UART3_ClearFlag(UART3_Flag_TypeDef UART3_FLAG)
1940                     ; 552 {
1941                     	switch	.text
1942  02dc               _UART3_ClearFlag:
1944  02dc 89            	pushw	x
1945       00000000      OFST:	set	0
1948                     ; 554   assert_param(IS_UART3_CLEAR_FLAG_OK(UART3_FLAG));
1950                     ; 557   if (UART3_FLAG == UART3_FLAG_RXNE)
1952  02dd a30020        	cpw	x,#32
1953  02e0 2606          	jrne	L5101
1954                     ; 559     UART3->SR = (uint8_t)~(UART3_SR_RXNE);
1956  02e2 35df5240      	mov	21056,#223
1958  02e6 201e          	jra	L7101
1959  02e8               L5101:
1960                     ; 562   else if (UART3_FLAG == UART3_FLAG_LBDF)
1962  02e8 1e01          	ldw	x,(OFST+1,sp)
1963  02ea a30210        	cpw	x,#528
1964  02ed 2606          	jrne	L1201
1965                     ; 564     UART3->CR4 &= (uint8_t)(~UART3_CR4_LBDF);
1967  02ef 72195247      	bres	21063,#4
1969  02f3 2011          	jra	L7101
1970  02f5               L1201:
1971                     ; 567   else if (UART3_FLAG == UART3_FLAG_LHDF)
1973  02f5 1e01          	ldw	x,(OFST+1,sp)
1974  02f7 a30302        	cpw	x,#770
1975  02fa 2606          	jrne	L5201
1976                     ; 569     UART3->CR6 &= (uint8_t)(~UART3_CR6_LHDF);
1978  02fc 72135249      	bres	21065,#1
1980  0300 2004          	jra	L7101
1981  0302               L5201:
1982                     ; 574     UART3->CR6 &= (uint8_t)(~UART3_CR6_LSF);
1984  0302 72115249      	bres	21065,#0
1985  0306               L7101:
1986                     ; 576 }
1989  0306 85            	popw	x
1990  0307 81            	ret
2072                     ; 591 ITStatus UART3_GetITStatus(UART3_IT_TypeDef UART3_IT)
2072                     ; 592 {
2073                     	switch	.text
2074  0308               _UART3_GetITStatus:
2076  0308 89            	pushw	x
2077  0309 89            	pushw	x
2078       00000002      OFST:	set	2
2081                     ; 593   ITStatus pendingbitstatus = RESET;
2083                     ; 594   uint8_t itpos = 0;
2085                     ; 595   uint8_t itmask1 = 0;
2087                     ; 596   uint8_t itmask2 = 0;
2089                     ; 597   uint8_t enablestatus = 0;
2091                     ; 600   assert_param(IS_UART3_GET_IT_OK(UART3_IT));
2093                     ; 603   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART3_IT & (uint8_t)0x0F));
2095  030a 9f            	ld	a,xl
2096  030b a40f          	and	a,#15
2097  030d 5f            	clrw	x
2098  030e 97            	ld	xl,a
2099  030f a601          	ld	a,#1
2100  0311 5d            	tnzw	x
2101  0312 2704          	jreq	L65
2102  0314               L06:
2103  0314 48            	sll	a
2104  0315 5a            	decw	x
2105  0316 26fc          	jrne	L06
2106  0318               L65:
2107  0318 6b01          	ld	(OFST-1,sp),a
2109                     ; 605   itmask1 = (uint8_t)((uint8_t)UART3_IT >> (uint8_t)4);
2111  031a 7b04          	ld	a,(OFST+2,sp)
2112  031c 4e            	swap	a
2113  031d a40f          	and	a,#15
2114  031f 6b02          	ld	(OFST+0,sp),a
2116                     ; 607   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2118  0321 7b02          	ld	a,(OFST+0,sp)
2119  0323 5f            	clrw	x
2120  0324 97            	ld	xl,a
2121  0325 a601          	ld	a,#1
2122  0327 5d            	tnzw	x
2123  0328 2704          	jreq	L26
2124  032a               L46:
2125  032a 48            	sll	a
2126  032b 5a            	decw	x
2127  032c 26fc          	jrne	L46
2128  032e               L26:
2129  032e 6b02          	ld	(OFST+0,sp),a
2131                     ; 610   if (UART3_IT == UART3_IT_PE)
2133  0330 1e03          	ldw	x,(OFST+1,sp)
2134  0332 a30100        	cpw	x,#256
2135  0335 261c          	jrne	L3701
2136                     ; 613     enablestatus = (uint8_t)((uint8_t)UART3->CR1 & itmask2);
2138  0337 c65244        	ld	a,21060
2139  033a 1402          	and	a,(OFST+0,sp)
2140  033c 6b02          	ld	(OFST+0,sp),a
2142                     ; 616     if (((UART3->SR & itpos) != (uint8_t)0x00) && enablestatus)
2144  033e c65240        	ld	a,21056
2145  0341 1501          	bcp	a,(OFST-1,sp)
2146  0343 270a          	jreq	L5701
2148  0345 0d02          	tnz	(OFST+0,sp)
2149  0347 2706          	jreq	L5701
2150                     ; 619       pendingbitstatus = SET;
2152  0349 a601          	ld	a,#1
2153  034b 6b02          	ld	(OFST+0,sp),a
2156  034d 2064          	jra	L1011
2157  034f               L5701:
2158                     ; 624       pendingbitstatus = RESET;
2160  034f 0f02          	clr	(OFST+0,sp)
2162  0351 2060          	jra	L1011
2163  0353               L3701:
2164                     ; 627   else if (UART3_IT == UART3_IT_LBDF)
2166  0353 1e03          	ldw	x,(OFST+1,sp)
2167  0355 a30346        	cpw	x,#838
2168  0358 261c          	jrne	L3011
2169                     ; 630     enablestatus = (uint8_t)((uint8_t)UART3->CR4 & itmask2);
2171  035a c65247        	ld	a,21063
2172  035d 1402          	and	a,(OFST+0,sp)
2173  035f 6b02          	ld	(OFST+0,sp),a
2175                     ; 632     if (((UART3->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2177  0361 c65247        	ld	a,21063
2178  0364 1501          	bcp	a,(OFST-1,sp)
2179  0366 270a          	jreq	L5011
2181  0368 0d02          	tnz	(OFST+0,sp)
2182  036a 2706          	jreq	L5011
2183                     ; 635       pendingbitstatus = SET;
2185  036c a601          	ld	a,#1
2186  036e 6b02          	ld	(OFST+0,sp),a
2189  0370 2041          	jra	L1011
2190  0372               L5011:
2191                     ; 640       pendingbitstatus = RESET;
2193  0372 0f02          	clr	(OFST+0,sp)
2195  0374 203d          	jra	L1011
2196  0376               L3011:
2197                     ; 643   else if (UART3_IT == UART3_IT_LHDF)
2199  0376 1e03          	ldw	x,(OFST+1,sp)
2200  0378 a30412        	cpw	x,#1042
2201  037b 261c          	jrne	L3111
2202                     ; 646     enablestatus = (uint8_t)((uint8_t)UART3->CR6 & itmask2);
2204  037d c65249        	ld	a,21065
2205  0380 1402          	and	a,(OFST+0,sp)
2206  0382 6b02          	ld	(OFST+0,sp),a
2208                     ; 648     if (((UART3->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
2210  0384 c65249        	ld	a,21065
2211  0387 1501          	bcp	a,(OFST-1,sp)
2212  0389 270a          	jreq	L5111
2214  038b 0d02          	tnz	(OFST+0,sp)
2215  038d 2706          	jreq	L5111
2216                     ; 651       pendingbitstatus = SET;
2218  038f a601          	ld	a,#1
2219  0391 6b02          	ld	(OFST+0,sp),a
2222  0393 201e          	jra	L1011
2223  0395               L5111:
2224                     ; 656       pendingbitstatus = RESET;
2226  0395 0f02          	clr	(OFST+0,sp)
2228  0397 201a          	jra	L1011
2229  0399               L3111:
2230                     ; 662     enablestatus = (uint8_t)((uint8_t)UART3->CR2 & itmask2);
2232  0399 c65245        	ld	a,21061
2233  039c 1402          	and	a,(OFST+0,sp)
2234  039e 6b02          	ld	(OFST+0,sp),a
2236                     ; 664     if (((UART3->SR & itpos) != (uint8_t)0x00) && enablestatus)
2238  03a0 c65240        	ld	a,21056
2239  03a3 1501          	bcp	a,(OFST-1,sp)
2240  03a5 270a          	jreq	L3211
2242  03a7 0d02          	tnz	(OFST+0,sp)
2243  03a9 2706          	jreq	L3211
2244                     ; 667       pendingbitstatus = SET;
2246  03ab a601          	ld	a,#1
2247  03ad 6b02          	ld	(OFST+0,sp),a
2250  03af 2002          	jra	L1011
2251  03b1               L3211:
2252                     ; 672       pendingbitstatus = RESET;
2254  03b1 0f02          	clr	(OFST+0,sp)
2256  03b3               L1011:
2257                     ; 676   return  pendingbitstatus;
2259  03b3 7b02          	ld	a,(OFST+0,sp)
2262  03b5 5b04          	addw	sp,#4
2263  03b7 81            	ret
2299                     ; 706 void UART3_ClearITPendingBit(UART3_IT_TypeDef UART3_IT)
2299                     ; 707 {
2300                     	switch	.text
2301  03b8               _UART3_ClearITPendingBit:
2303  03b8 89            	pushw	x
2304       00000000      OFST:	set	0
2307                     ; 709   assert_param(IS_UART3_CLEAR_IT_OK(UART3_IT));
2309                     ; 712   if (UART3_IT == UART3_IT_RXNE)
2311  03b9 a30255        	cpw	x,#597
2312  03bc 2606          	jrne	L5411
2313                     ; 714     UART3->SR = (uint8_t)~(UART3_SR_RXNE);
2315  03be 35df5240      	mov	21056,#223
2317  03c2 2011          	jra	L7411
2318  03c4               L5411:
2319                     ; 717   else if (UART3_IT == UART3_IT_LBDF)
2321  03c4 1e01          	ldw	x,(OFST+1,sp)
2322  03c6 a30346        	cpw	x,#838
2323  03c9 2606          	jrne	L1511
2324                     ; 719     UART3->CR4 &= (uint8_t)~(UART3_CR4_LBDF);
2326  03cb 72195247      	bres	21063,#4
2328  03cf 2004          	jra	L7411
2329  03d1               L1511:
2330                     ; 724     UART3->CR6 &= (uint8_t)(~UART3_CR6_LHDF);
2332  03d1 72135249      	bres	21065,#1
2333  03d5               L7411:
2334                     ; 726 }
2337  03d5 85            	popw	x
2338  03d6 81            	ret
2351                     	xdef	_UART3_ClearITPendingBit
2352                     	xdef	_UART3_GetITStatus
2353                     	xdef	_UART3_ClearFlag
2354                     	xdef	_UART3_GetFlagStatus
2355                     	xdef	_UART3_SetAddress
2356                     	xdef	_UART3_SendBreak
2357                     	xdef	_UART3_SendData9
2358                     	xdef	_UART3_SendData8
2359                     	xdef	_UART3_ReceiveData9
2360                     	xdef	_UART3_ReceiveData8
2361                     	xdef	_UART3_WakeUpConfig
2362                     	xdef	_UART3_ReceiverWakeUpCmd
2363                     	xdef	_UART3_LINCmd
2364                     	xdef	_UART3_LINConfig
2365                     	xdef	_UART3_LINBreakDetectionConfig
2366                     	xdef	_UART3_ITConfig
2367                     	xdef	_UART3_Cmd
2368                     	xdef	_UART3_Init
2369                     	xdef	_UART3_DeInit
2370                     	xref	_CLK_GetClockFreq
2371                     	xref.b	c_lreg
2372                     	xref.b	c_x
2391                     	xref	c_lsub
2392                     	xref	c_smul
2393                     	xref	c_ludv
2394                     	xref	c_rtol
2395                     	xref	c_llsh
2396                     	xref	c_ltor
2397                     	end
