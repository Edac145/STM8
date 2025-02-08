   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     .const:	section	.text
  15  0000               _HSIDivFactor:
  16  0000 01            	dc.b	1
  17  0001 02            	dc.b	2
  18  0002 04            	dc.b	4
  19  0003 08            	dc.b	8
  20  0004               _CLKPrescTable:
  21  0004 01            	dc.b	1
  22  0005 02            	dc.b	2
  23  0006 04            	dc.b	4
  24  0007 08            	dc.b	8
  25  0008 0a            	dc.b	10
  26  0009 10            	dc.b	16
  27  000a 14            	dc.b	20
  28  000b 28            	dc.b	40
  57                     ; 66 void CLK_DeInit(void)
  57                     ; 67 {
  58                     	switch	.text
  59  0000               f_CLK_DeInit:
  63                     ; 69     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  65  0000 350150c0      	mov	20672,#1
  66                     ; 70     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  68  0004 725f50c1      	clr	20673
  69                     ; 71     CLK->SWR  = CLK_SWR_RESET_VALUE;
  71  0008 35e150c4      	mov	20676,#225
  72                     ; 72     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  74  000c 725f50c5      	clr	20677
  75                     ; 73     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  77  0010 351850c6      	mov	20678,#24
  78                     ; 74     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  80  0014 35ff50c7      	mov	20679,#255
  81                     ; 75     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  83  0018 35ff50ca      	mov	20682,#255
  84                     ; 76     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  86  001c 725f50c8      	clr	20680
  87                     ; 77     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  89  0020 725f50c9      	clr	20681
  91  0024               L52:
  92                     ; 78     while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
  94  0024 c650c9        	ld	a,20681
  95  0027 a501          	bcp	a,#1
  96  0029 26f9          	jrne	L52
  97                     ; 80     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  99  002b 725f50c9      	clr	20681
 100                     ; 81     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 102  002f 725f50cc      	clr	20684
 103                     ; 82     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 105  0033 725f50cd      	clr	20685
 106                     ; 84 }
 109  0037 87            	retf
 164                     ; 95 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 164                     ; 96 {
 165                     	switch	.text
 166  0038               f_CLK_FastHaltWakeUpCmd:
 170                     ; 99     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 172                     ; 101     if (NewState != DISABLE)
 174  0038 4d            	tnz	a
 175  0039 2706          	jreq	L75
 176                     ; 104         CLK->ICKR |= CLK_ICKR_FHWU;
 178  003b 721450c0      	bset	20672,#2
 180  003f 2004          	jra	L16
 181  0041               L75:
 182                     ; 109         CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 184  0041 721550c0      	bres	20672,#2
 185  0045               L16:
 186                     ; 112 }
 189  0045 87            	retf
 223                     ; 119 void CLK_HSECmd(FunctionalState NewState)
 223                     ; 120 {
 224                     	switch	.text
 225  0046               f_CLK_HSECmd:
 229                     ; 123     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 231                     ; 125     if (NewState != DISABLE)
 233  0046 4d            	tnz	a
 234  0047 2706          	jreq	L101
 235                     ; 128         CLK->ECKR |= CLK_ECKR_HSEEN;
 237  0049 721050c1      	bset	20673,#0
 239  004d 2004          	jra	L301
 240  004f               L101:
 241                     ; 133         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 243  004f 721150c1      	bres	20673,#0
 244  0053               L301:
 245                     ; 136 }
 248  0053 87            	retf
 282                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 282                     ; 144 {
 283                     	switch	.text
 284  0054               f_CLK_HSICmd:
 288                     ; 147     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 290                     ; 149     if (NewState != DISABLE)
 292  0054 4d            	tnz	a
 293  0055 2706          	jreq	L321
 294                     ; 152         CLK->ICKR |= CLK_ICKR_HSIEN;
 296  0057 721050c0      	bset	20672,#0
 298  005b 2004          	jra	L521
 299  005d               L321:
 300                     ; 157         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 302  005d 721150c0      	bres	20672,#0
 303  0061               L521:
 304                     ; 160 }
 307  0061 87            	retf
 341                     ; 167 void CLK_LSICmd(FunctionalState NewState)
 341                     ; 168 {
 342                     	switch	.text
 343  0062               f_CLK_LSICmd:
 347                     ; 171     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 349                     ; 173     if (NewState != DISABLE)
 351  0062 4d            	tnz	a
 352  0063 2706          	jreq	L541
 353                     ; 176         CLK->ICKR |= CLK_ICKR_LSIEN;
 355  0065 721650c0      	bset	20672,#3
 357  0069 2004          	jra	L741
 358  006b               L541:
 359                     ; 181         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 361  006b 721750c0      	bres	20672,#3
 362  006f               L741:
 363                     ; 184 }
 366  006f 87            	retf
 400                     ; 192 void CLK_CCOCmd(FunctionalState NewState)
 400                     ; 193 {
 401                     	switch	.text
 402  0070               f_CLK_CCOCmd:
 406                     ; 196     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 408                     ; 198     if (NewState != DISABLE)
 410  0070 4d            	tnz	a
 411  0071 2706          	jreq	L761
 412                     ; 201         CLK->CCOR |= CLK_CCOR_CCOEN;
 414  0073 721050c9      	bset	20681,#0
 416  0077 2004          	jra	L171
 417  0079               L761:
 418                     ; 206         CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 420  0079 721150c9      	bres	20681,#0
 421  007d               L171:
 422                     ; 209 }
 425  007d 87            	retf
 459                     ; 218 void CLK_ClockSwitchCmd(FunctionalState NewState)
 459                     ; 219 {
 460                     	switch	.text
 461  007e               f_CLK_ClockSwitchCmd:
 465                     ; 222     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 467                     ; 224     if (NewState != DISABLE )
 469  007e 4d            	tnz	a
 470  007f 2706          	jreq	L112
 471                     ; 227         CLK->SWCR |= CLK_SWCR_SWEN;
 473  0081 721250c5      	bset	20677,#1
 475  0085 2004          	jra	L312
 476  0087               L112:
 477                     ; 232         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 479  0087 721350c5      	bres	20677,#1
 480  008b               L312:
 481                     ; 235 }
 484  008b 87            	retf
 519                     ; 245 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 519                     ; 246 {
 520                     	switch	.text
 521  008c               f_CLK_SlowActiveHaltWakeUpCmd:
 525                     ; 249     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 527                     ; 251     if (NewState != DISABLE)
 529  008c 4d            	tnz	a
 530  008d 2706          	jreq	L332
 531                     ; 254         CLK->ICKR |= CLK_ICKR_SWUAH;
 533  008f 721a50c0      	bset	20672,#5
 535  0093 2004          	jra	L532
 536  0095               L332:
 537                     ; 259         CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 539  0095 721b50c0      	bres	20672,#5
 540  0099               L532:
 541                     ; 262 }
 544  0099 87            	retf
 702                     ; 272 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 702                     ; 273 {
 703                     	switch	.text
 704  009a               f_CLK_PeripheralClockConfig:
 706  009a 89            	pushw	x
 707       00000000      OFST:	set	0
 710                     ; 276     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 712                     ; 277     assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 714                     ; 279     if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 716  009b 9e            	ld	a,xh
 717  009c a510          	bcp	a,#16
 718  009e 2633          	jrne	L123
 719                     ; 281         if (NewState != DISABLE)
 721  00a0 0d02          	tnz	(OFST+2,sp)
 722  00a2 2717          	jreq	L323
 723                     ; 284             CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 725  00a4 7b01          	ld	a,(OFST+1,sp)
 726  00a6 a40f          	and	a,#15
 727  00a8 5f            	clrw	x
 728  00a9 97            	ld	xl,a
 729  00aa a601          	ld	a,#1
 730  00ac 5d            	tnzw	x
 731  00ad 2704          	jreq	L62
 732  00af               L03:
 733  00af 48            	sll	a
 734  00b0 5a            	decw	x
 735  00b1 26fc          	jrne	L03
 736  00b3               L62:
 737  00b3 ca50c7        	or	a,20679
 738  00b6 c750c7        	ld	20679,a
 740  00b9 2049          	jra	L723
 741  00bb               L323:
 742                     ; 289             CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 744  00bb 7b01          	ld	a,(OFST+1,sp)
 745  00bd a40f          	and	a,#15
 746  00bf 5f            	clrw	x
 747  00c0 97            	ld	xl,a
 748  00c1 a601          	ld	a,#1
 749  00c3 5d            	tnzw	x
 750  00c4 2704          	jreq	L23
 751  00c6               L43:
 752  00c6 48            	sll	a
 753  00c7 5a            	decw	x
 754  00c8 26fc          	jrne	L43
 755  00ca               L23:
 756  00ca 43            	cpl	a
 757  00cb c450c7        	and	a,20679
 758  00ce c750c7        	ld	20679,a
 759  00d1 2031          	jra	L723
 760  00d3               L123:
 761                     ; 294         if (NewState != DISABLE)
 763  00d3 0d02          	tnz	(OFST+2,sp)
 764  00d5 2717          	jreq	L133
 765                     ; 297             CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 767  00d7 7b01          	ld	a,(OFST+1,sp)
 768  00d9 a40f          	and	a,#15
 769  00db 5f            	clrw	x
 770  00dc 97            	ld	xl,a
 771  00dd a601          	ld	a,#1
 772  00df 5d            	tnzw	x
 773  00e0 2704          	jreq	L63
 774  00e2               L04:
 775  00e2 48            	sll	a
 776  00e3 5a            	decw	x
 777  00e4 26fc          	jrne	L04
 778  00e6               L63:
 779  00e6 ca50ca        	or	a,20682
 780  00e9 c750ca        	ld	20682,a
 782  00ec 2016          	jra	L723
 783  00ee               L133:
 784                     ; 302             CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 786  00ee 7b01          	ld	a,(OFST+1,sp)
 787  00f0 a40f          	and	a,#15
 788  00f2 5f            	clrw	x
 789  00f3 97            	ld	xl,a
 790  00f4 a601          	ld	a,#1
 791  00f6 5d            	tnzw	x
 792  00f7 2704          	jreq	L24
 793  00f9               L44:
 794  00f9 48            	sll	a
 795  00fa 5a            	decw	x
 796  00fb 26fc          	jrne	L44
 797  00fd               L24:
 798  00fd 43            	cpl	a
 799  00fe c450ca        	and	a,20682
 800  0101 c750ca        	ld	20682,a
 801  0104               L723:
 802                     ; 306 }
 805  0104 85            	popw	x
 806  0105 87            	retf
 991                     ; 319 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
 991                     ; 320 {
 992                     	switch	.text
 993  0106               f_CLK_ClockSwitchConfig:
 995  0106 89            	pushw	x
 996  0107 5204          	subw	sp,#4
 997       00000004      OFST:	set	4
1000                     ; 323     uint16_t DownCounter = CLK_TIMEOUT;
1002  0109 ae0491        	ldw	x,#1169
1003  010c 1f03          	ldw	(OFST-1,sp),x
1005                     ; 324     ErrorStatus Swif = ERROR;
1007                     ; 327     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1009                     ; 328     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1011                     ; 329     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1013                     ; 330     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1015                     ; 333     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1017  010e c650c3        	ld	a,20675
1018  0111 6b01          	ld	(OFST-3,sp),a
1020                     ; 336     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1022  0113 7b05          	ld	a,(OFST+1,sp)
1023  0115 a101          	cp	a,#1
1024  0117 2639          	jrne	L344
1025                     ; 340         CLK->SWCR |= CLK_SWCR_SWEN;
1027  0119 721250c5      	bset	20677,#1
1028                     ; 343         if (ITState != DISABLE)
1030  011d 0d0a          	tnz	(OFST+6,sp)
1031  011f 2706          	jreq	L544
1032                     ; 345             CLK->SWCR |= CLK_SWCR_SWIEN;
1034  0121 721450c5      	bset	20677,#2
1036  0125 2004          	jra	L744
1037  0127               L544:
1038                     ; 349             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1040  0127 721550c5      	bres	20677,#2
1041  012b               L744:
1042                     ; 353         CLK->SWR = (uint8_t)CLK_NewClock;
1044  012b 7b06          	ld	a,(OFST+2,sp)
1045  012d c750c4        	ld	20676,a
1047  0130 2007          	jra	L554
1048  0132               L154:
1049                     ; 357             DownCounter--;
1051  0132 1e03          	ldw	x,(OFST-1,sp)
1052  0134 1d0001        	subw	x,#1
1053  0137 1f03          	ldw	(OFST-1,sp),x
1055  0139               L554:
1056                     ; 355         while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1058  0139 c650c5        	ld	a,20677
1059  013c a501          	bcp	a,#1
1060  013e 2704          	jreq	L164
1062  0140 1e03          	ldw	x,(OFST-1,sp)
1063  0142 26ee          	jrne	L154
1064  0144               L164:
1065                     ; 360         if (DownCounter != 0)
1067  0144 1e03          	ldw	x,(OFST-1,sp)
1068  0146 2706          	jreq	L364
1069                     ; 362             Swif = SUCCESS;
1071  0148 a601          	ld	a,#1
1072  014a 6b02          	ld	(OFST-2,sp),a
1075  014c 201b          	jra	L764
1076  014e               L364:
1077                     ; 366             Swif = ERROR;
1079  014e 0f02          	clr	(OFST-2,sp)
1081  0150 2017          	jra	L764
1082  0152               L344:
1083                     ; 374         if (ITState != DISABLE)
1085  0152 0d0a          	tnz	(OFST+6,sp)
1086  0154 2706          	jreq	L174
1087                     ; 376             CLK->SWCR |= CLK_SWCR_SWIEN;
1089  0156 721450c5      	bset	20677,#2
1091  015a 2004          	jra	L374
1092  015c               L174:
1093                     ; 380             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1095  015c 721550c5      	bres	20677,#2
1096  0160               L374:
1097                     ; 384         CLK->SWR = (uint8_t)CLK_NewClock;
1099  0160 7b06          	ld	a,(OFST+2,sp)
1100  0162 c750c4        	ld	20676,a
1101                     ; 388         Swif = SUCCESS;
1103  0165 a601          	ld	a,#1
1104  0167 6b02          	ld	(OFST-2,sp),a
1106  0169               L764:
1107                     ; 393     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1109  0169 0d0b          	tnz	(OFST+7,sp)
1110  016b 260c          	jrne	L574
1112  016d 7b01          	ld	a,(OFST-3,sp)
1113  016f a1e1          	cp	a,#225
1114  0171 2606          	jrne	L574
1115                     ; 395         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1117  0173 721150c0      	bres	20672,#0
1119  0177 201e          	jra	L774
1120  0179               L574:
1121                     ; 397     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1123  0179 0d0b          	tnz	(OFST+7,sp)
1124  017b 260c          	jrne	L105
1126  017d 7b01          	ld	a,(OFST-3,sp)
1127  017f a1d2          	cp	a,#210
1128  0181 2606          	jrne	L105
1129                     ; 399         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1131  0183 721750c0      	bres	20672,#3
1133  0187 200e          	jra	L774
1134  0189               L105:
1135                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1137  0189 0d0b          	tnz	(OFST+7,sp)
1138  018b 260a          	jrne	L774
1140  018d 7b01          	ld	a,(OFST-3,sp)
1141  018f a1b4          	cp	a,#180
1142  0191 2604          	jrne	L774
1143                     ; 403         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1145  0193 721150c1      	bres	20673,#0
1146  0197               L774:
1147                     ; 406     return(Swif);
1149  0197 7b02          	ld	a,(OFST-2,sp)
1152  0199 5b06          	addw	sp,#6
1153  019b 87            	retf
1290                     ; 416 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1290                     ; 417 {
1291                     	switch	.text
1292  019c               f_CLK_HSIPrescalerConfig:
1294  019c 88            	push	a
1295       00000000      OFST:	set	0
1298                     ; 420     assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1300                     ; 423     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1302  019d c650c6        	ld	a,20678
1303  01a0 a4e7          	and	a,#231
1304  01a2 c750c6        	ld	20678,a
1305                     ; 426     CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1307  01a5 c650c6        	ld	a,20678
1308  01a8 1a01          	or	a,(OFST+1,sp)
1309  01aa c750c6        	ld	20678,a
1310                     ; 428 }
1313  01ad 84            	pop	a
1314  01ae 87            	retf
1448                     ; 439 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1448                     ; 440 {
1449                     	switch	.text
1450  01af               f_CLK_CCOConfig:
1452  01af 88            	push	a
1453       00000000      OFST:	set	0
1456                     ; 443     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1458                     ; 446     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1460  01b0 c650c9        	ld	a,20681
1461  01b3 a4e1          	and	a,#225
1462  01b5 c750c9        	ld	20681,a
1463                     ; 449     CLK->CCOR |= (uint8_t)CLK_CCO;
1465  01b8 c650c9        	ld	a,20681
1466  01bb 1a01          	or	a,(OFST+1,sp)
1467  01bd c750c9        	ld	20681,a
1468                     ; 452     CLK->CCOR |= CLK_CCOR_CCOEN;
1470  01c0 721050c9      	bset	20681,#0
1471                     ; 454 }
1474  01c4 84            	pop	a
1475  01c5 87            	retf
1539                     ; 464 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1539                     ; 465 {
1540                     	switch	.text
1541  01c6               f_CLK_ITConfig:
1543  01c6 89            	pushw	x
1544       00000000      OFST:	set	0
1547                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1549                     ; 469     assert_param(IS_CLK_IT_OK(CLK_IT));
1551                     ; 471     if (NewState != DISABLE)
1553  01c7 9f            	ld	a,xl
1554  01c8 4d            	tnz	a
1555  01c9 2719          	jreq	L307
1556                     ; 473         switch (CLK_IT)
1558  01cb 9e            	ld	a,xh
1560                     ; 481         default:
1560                     ; 482             break;
1561  01cc a00c          	sub	a,#12
1562  01ce 270a          	jreq	L736
1563  01d0 a010          	sub	a,#16
1564  01d2 2624          	jrne	L117
1565                     ; 475         case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1565                     ; 476             CLK->SWCR |= CLK_SWCR_SWIEN;
1567  01d4 721450c5      	bset	20677,#2
1568                     ; 477             break;
1570  01d8 201e          	jra	L117
1571  01da               L736:
1572                     ; 478         case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1572                     ; 479             CLK->CSSR |= CLK_CSSR_CSSDIE;
1574  01da 721450c8      	bset	20680,#2
1575                     ; 480             break;
1577  01de 2018          	jra	L117
1578  01e0               L146:
1579                     ; 481         default:
1579                     ; 482             break;
1581  01e0 2016          	jra	L117
1582  01e2               L707:
1584  01e2 2014          	jra	L117
1585  01e4               L307:
1586                     ; 487         switch (CLK_IT)
1588  01e4 7b01          	ld	a,(OFST+1,sp)
1590                     ; 495         default:
1590                     ; 496             break;
1591  01e6 a00c          	sub	a,#12
1592  01e8 270a          	jreq	L546
1593  01ea a010          	sub	a,#16
1594  01ec 260a          	jrne	L117
1595                     ; 489         case CLK_IT_SWIF: /* Disable the clock switch interrupt */
1595                     ; 490             CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
1597  01ee 721550c5      	bres	20677,#2
1598                     ; 491             break;
1600  01f2 2004          	jra	L117
1601  01f4               L546:
1602                     ; 492         case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
1602                     ; 493             CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
1604  01f4 721550c8      	bres	20680,#2
1605                     ; 494             break;
1606  01f8               L117:
1607                     ; 500 }
1610  01f8 85            	popw	x
1611  01f9 87            	retf
1612  01fa               L746:
1613                     ; 495         default:
1613                     ; 496             break;
1615  01fa 20fc          	jra	L117
1616  01fc               L517:
1617  01fc 20fa          	jra	L117
1651                     ; 507 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
1651                     ; 508 {
1652                     	switch	.text
1653  01fe               f_CLK_SYSCLKConfig:
1655  01fe 88            	push	a
1656       00000000      OFST:	set	0
1659                     ; 511     assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
1661                     ; 513     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
1663  01ff a580          	bcp	a,#128
1664  0201 2614          	jrne	L537
1665                     ; 515         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1667  0203 c650c6        	ld	a,20678
1668  0206 a4e7          	and	a,#231
1669  0208 c750c6        	ld	20678,a
1670                     ; 516         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
1672  020b 7b01          	ld	a,(OFST+1,sp)
1673  020d a418          	and	a,#24
1674  020f ca50c6        	or	a,20678
1675  0212 c750c6        	ld	20678,a
1677  0215 2012          	jra	L737
1678  0217               L537:
1679                     ; 520         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
1681  0217 c650c6        	ld	a,20678
1682  021a a4f8          	and	a,#248
1683  021c c750c6        	ld	20678,a
1684                     ; 521         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
1686  021f 7b01          	ld	a,(OFST+1,sp)
1687  0221 a407          	and	a,#7
1688  0223 ca50c6        	or	a,20678
1689  0226 c750c6        	ld	20678,a
1690  0229               L737:
1691                     ; 524 }
1694  0229 84            	pop	a
1695  022a 87            	retf
1750                     ; 531 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
1750                     ; 532 {
1751                     	switch	.text
1752  022b               f_CLK_SWIMConfig:
1756                     ; 535     assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
1758                     ; 537     if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
1760  022b 4d            	tnz	a
1761  022c 2706          	jreq	L767
1762                     ; 540         CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
1764  022e 721050cd      	bset	20685,#0
1766  0232 2004          	jra	L177
1767  0234               L767:
1768                     ; 545         CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
1770  0234 721150cd      	bres	20685,#0
1771  0238               L177:
1772                     ; 548 }
1775  0238 87            	retf
1798                     ; 557 void CLK_ClockSecuritySystemEnable(void)
1798                     ; 558 {
1799                     	switch	.text
1800  0239               f_CLK_ClockSecuritySystemEnable:
1804                     ; 560     CLK->CSSR |= CLK_CSSR_CSSEN;
1806  0239 721050c8      	bset	20680,#0
1807                     ; 561 }
1810  023d 87            	retf
1834                     ; 569 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
1834                     ; 570 {
1835                     	switch	.text
1836  023e               f_CLK_GetSYSCLKSource:
1840                     ; 571     return((CLK_Source_TypeDef)CLK->CMSR);
1842  023e c650c3        	ld	a,20675
1845  0241 87            	retf
1901                     ; 579 uint32_t CLK_GetClockFreq(void)
1901                     ; 580 {
1902                     	switch	.text
1903  0242               f_CLK_GetClockFreq:
1905  0242 5209          	subw	sp,#9
1906       00000009      OFST:	set	9
1909                     ; 582     uint32_t clockfrequency = 0;
1911                     ; 583     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
1913                     ; 584     uint8_t tmp = 0, presc = 0;
1917                     ; 587     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
1919  0244 c650c3        	ld	a,20675
1920  0247 6b09          	ld	(OFST+0,sp),a
1922                     ; 589     if (clocksource == CLK_SOURCE_HSI)
1924  0249 7b09          	ld	a,(OFST+0,sp)
1925  024b a1e1          	cp	a,#225
1926  024d 2644          	jrne	L7301
1927                     ; 591         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
1929  024f c650c6        	ld	a,20678
1930  0252 a418          	and	a,#24
1931  0254 6b09          	ld	(OFST+0,sp),a
1933                     ; 592         tmp = (uint8_t)(tmp >> 3);
1935  0256 0409          	srl	(OFST+0,sp)
1936  0258 0409          	srl	(OFST+0,sp)
1937  025a 0409          	srl	(OFST+0,sp)
1939                     ; 593         presc = HSIDivFactor[tmp];
1941  025c 7b09          	ld	a,(OFST+0,sp)
1942  025e 5f            	clrw	x
1943  025f 97            	ld	xl,a
1944  0260 d60000        	ld	a,(_HSIDivFactor,x)
1945  0263 6b09          	ld	(OFST+0,sp),a
1947                     ; 594         clockfrequency = HSI_VALUE / presc;
1949  0265 7b09          	ld	a,(OFST+0,sp)
1950  0267 b703          	ld	c_lreg+3,a
1951  0269 3f02          	clr	c_lreg+2
1952  026b 3f01          	clr	c_lreg+1
1953  026d 3f00          	clr	c_lreg
1954  026f 96            	ldw	x,sp
1955  0270 1c0001        	addw	x,#OFST-8
1956  0273 8d000000      	callf	d_rtol
1959  0277 ae2400        	ldw	x,#9216
1960  027a bf02          	ldw	c_lreg+2,x
1961  027c ae00f4        	ldw	x,#244
1962  027f bf00          	ldw	c_lreg,x
1963  0281 96            	ldw	x,sp
1964  0282 1c0001        	addw	x,#OFST-8
1965  0285 8d000000      	callf	d_ludv
1967  0289 96            	ldw	x,sp
1968  028a 1c0005        	addw	x,#OFST-4
1969  028d 8d000000      	callf	d_rtol
1973  0291 201c          	jra	L1401
1974  0293               L7301:
1975                     ; 596     else if ( clocksource == CLK_SOURCE_LSI)
1977  0293 7b09          	ld	a,(OFST+0,sp)
1978  0295 a1d2          	cp	a,#210
1979  0297 260c          	jrne	L3401
1980                     ; 598         clockfrequency = LSI_VALUE;
1982  0299 aef400        	ldw	x,#62464
1983  029c 1f07          	ldw	(OFST-2,sp),x
1984  029e ae0001        	ldw	x,#1
1985  02a1 1f05          	ldw	(OFST-4,sp),x
1988  02a3 200a          	jra	L1401
1989  02a5               L3401:
1990                     ; 602         clockfrequency = HSE_VALUE;
1992  02a5 ae3600        	ldw	x,#13824
1993  02a8 1f07          	ldw	(OFST-2,sp),x
1994  02aa ae016e        	ldw	x,#366
1995  02ad 1f05          	ldw	(OFST-4,sp),x
1997  02af               L1401:
1998                     ; 605     return((uint32_t)clockfrequency);
2000  02af 96            	ldw	x,sp
2001  02b0 1c0005        	addw	x,#OFST-4
2002  02b3 8d000000      	callf	d_ltor
2006  02b7 5b09          	addw	sp,#9
2007  02b9 87            	retf
2105                     ; 616 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2105                     ; 617 {
2106                     	switch	.text
2107  02ba               f_CLK_AdjustHSICalibrationValue:
2109  02ba 88            	push	a
2110       00000000      OFST:	set	0
2113                     ; 620     assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2115                     ; 623     CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2117  02bb c650cc        	ld	a,20684
2118  02be a4f8          	and	a,#248
2119  02c0 1a01          	or	a,(OFST+1,sp)
2120  02c2 c750cc        	ld	20684,a
2121                     ; 625 }
2124  02c5 84            	pop	a
2125  02c6 87            	retf
2148                     ; 636 void CLK_SYSCLKEmergencyClear(void)
2148                     ; 637 {
2149                     	switch	.text
2150  02c7               f_CLK_SYSCLKEmergencyClear:
2154                     ; 638     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2156  02c7 721150c5      	bres	20677,#0
2157                     ; 639 }
2160  02cb 87            	retf
2308                     ; 648 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2308                     ; 649 {
2309                     	switch	.text
2310  02cc               f_CLK_GetFlagStatus:
2312  02cc 89            	pushw	x
2313  02cd 5203          	subw	sp,#3
2314       00000003      OFST:	set	3
2317                     ; 651     uint16_t statusreg = 0;
2319                     ; 652     uint8_t tmpreg = 0;
2321                     ; 653     FlagStatus bitstatus = RESET;
2323                     ; 656     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2325                     ; 659     statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2327  02cf 01            	rrwa	x,a
2328  02d0 9f            	ld	a,xl
2329  02d1 a4ff          	and	a,#255
2330  02d3 97            	ld	xl,a
2331  02d4 4f            	clr	a
2332  02d5 02            	rlwa	x,a
2333  02d6 1f01          	ldw	(OFST-2,sp),x
2334  02d8 01            	rrwa	x,a
2336                     ; 662     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2338  02d9 1e01          	ldw	x,(OFST-2,sp)
2339  02db a30100        	cpw	x,#256
2340  02de 2607          	jrne	L5021
2341                     ; 664         tmpreg = CLK->ICKR;
2343  02e0 c650c0        	ld	a,20672
2344  02e3 6b03          	ld	(OFST+0,sp),a
2347  02e5 202f          	jra	L7021
2348  02e7               L5021:
2349                     ; 666     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2351  02e7 1e01          	ldw	x,(OFST-2,sp)
2352  02e9 a30200        	cpw	x,#512
2353  02ec 2607          	jrne	L1121
2354                     ; 668         tmpreg = CLK->ECKR;
2356  02ee c650c1        	ld	a,20673
2357  02f1 6b03          	ld	(OFST+0,sp),a
2360  02f3 2021          	jra	L7021
2361  02f5               L1121:
2362                     ; 670     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2364  02f5 1e01          	ldw	x,(OFST-2,sp)
2365  02f7 a30300        	cpw	x,#768
2366  02fa 2607          	jrne	L5121
2367                     ; 672         tmpreg = CLK->SWCR;
2369  02fc c650c5        	ld	a,20677
2370  02ff 6b03          	ld	(OFST+0,sp),a
2373  0301 2013          	jra	L7021
2374  0303               L5121:
2375                     ; 674     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2377  0303 1e01          	ldw	x,(OFST-2,sp)
2378  0305 a30400        	cpw	x,#1024
2379  0308 2607          	jrne	L1221
2380                     ; 676         tmpreg = CLK->CSSR;
2382  030a c650c8        	ld	a,20680
2383  030d 6b03          	ld	(OFST+0,sp),a
2386  030f 2005          	jra	L7021
2387  0311               L1221:
2388                     ; 680         tmpreg = CLK->CCOR;
2390  0311 c650c9        	ld	a,20681
2391  0314 6b03          	ld	(OFST+0,sp),a
2393  0316               L7021:
2394                     ; 683     if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2396  0316 7b05          	ld	a,(OFST+2,sp)
2397  0318 1503          	bcp	a,(OFST+0,sp)
2398  031a 2706          	jreq	L5221
2399                     ; 685         bitstatus = SET;
2401  031c a601          	ld	a,#1
2402  031e 6b03          	ld	(OFST+0,sp),a
2405  0320 2002          	jra	L7221
2406  0322               L5221:
2407                     ; 689         bitstatus = RESET;
2409  0322 0f03          	clr	(OFST+0,sp)
2411  0324               L7221:
2412                     ; 693     return((FlagStatus)bitstatus);
2414  0324 7b03          	ld	a,(OFST+0,sp)
2417  0326 5b05          	addw	sp,#5
2418  0328 87            	retf
2463                     ; 703 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
2463                     ; 704 {
2464                     	switch	.text
2465  0329               f_CLK_GetITStatus:
2467  0329 88            	push	a
2468  032a 88            	push	a
2469       00000001      OFST:	set	1
2472                     ; 706     ITStatus bitstatus = RESET;
2474                     ; 709     assert_param(IS_CLK_IT_OK(CLK_IT));
2476                     ; 711     if (CLK_IT == CLK_IT_SWIF)
2478  032b a11c          	cp	a,#28
2479  032d 2611          	jrne	L3521
2480                     ; 714         if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2482  032f c450c5        	and	a,20677
2483  0332 a10c          	cp	a,#12
2484  0334 2606          	jrne	L5521
2485                     ; 716             bitstatus = SET;
2487  0336 a601          	ld	a,#1
2488  0338 6b01          	ld	(OFST+0,sp),a
2491  033a 2015          	jra	L1621
2492  033c               L5521:
2493                     ; 720             bitstatus = RESET;
2495  033c 0f01          	clr	(OFST+0,sp)
2497  033e 2011          	jra	L1621
2498  0340               L3521:
2499                     ; 726         if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2501  0340 c650c8        	ld	a,20680
2502  0343 1402          	and	a,(OFST+1,sp)
2503  0345 a10c          	cp	a,#12
2504  0347 2606          	jrne	L3621
2505                     ; 728             bitstatus = SET;
2507  0349 a601          	ld	a,#1
2508  034b 6b01          	ld	(OFST+0,sp),a
2511  034d 2002          	jra	L1621
2512  034f               L3621:
2513                     ; 732             bitstatus = RESET;
2515  034f 0f01          	clr	(OFST+0,sp)
2517  0351               L1621:
2518                     ; 737     return bitstatus;
2520  0351 7b01          	ld	a,(OFST+0,sp)
2523  0353 85            	popw	x
2524  0354 87            	retf
2559                     ; 747 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
2559                     ; 748 {
2560                     	switch	.text
2561  0355               f_CLK_ClearITPendingBit:
2565                     ; 751     assert_param(IS_CLK_IT_OK(CLK_IT));
2567                     ; 753     if (CLK_IT == (uint8_t)CLK_IT_CSSD)
2569  0355 a10c          	cp	a,#12
2570  0357 2606          	jrne	L5031
2571                     ; 756         CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
2573  0359 721750c8      	bres	20680,#3
2575  035d 2004          	jra	L7031
2576  035f               L5031:
2577                     ; 761         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
2579  035f 721750c5      	bres	20677,#3
2580  0363               L7031:
2581                     ; 764 }
2584  0363 87            	retf
2618                     	xdef	_CLKPrescTable
2619                     	xdef	_HSIDivFactor
2620                     	xdef	f_CLK_ClearITPendingBit
2621                     	xdef	f_CLK_GetITStatus
2622                     	xdef	f_CLK_GetFlagStatus
2623                     	xdef	f_CLK_GetSYSCLKSource
2624                     	xdef	f_CLK_GetClockFreq
2625                     	xdef	f_CLK_AdjustHSICalibrationValue
2626                     	xdef	f_CLK_SYSCLKEmergencyClear
2627                     	xdef	f_CLK_ClockSecuritySystemEnable
2628                     	xdef	f_CLK_SWIMConfig
2629                     	xdef	f_CLK_SYSCLKConfig
2630                     	xdef	f_CLK_ITConfig
2631                     	xdef	f_CLK_CCOConfig
2632                     	xdef	f_CLK_HSIPrescalerConfig
2633                     	xdef	f_CLK_ClockSwitchConfig
2634                     	xdef	f_CLK_PeripheralClockConfig
2635                     	xdef	f_CLK_SlowActiveHaltWakeUpCmd
2636                     	xdef	f_CLK_FastHaltWakeUpCmd
2637                     	xdef	f_CLK_ClockSwitchCmd
2638                     	xdef	f_CLK_CCOCmd
2639                     	xdef	f_CLK_LSICmd
2640                     	xdef	f_CLK_HSICmd
2641                     	xdef	f_CLK_HSECmd
2642                     	xdef	f_CLK_DeInit
2643                     	xref.b	c_lreg
2644                     	xref.b	c_x
2663                     	xref	d_ltor
2664                     	xref	d_ludv
2665                     	xref	d_rtol
2666                     	end
