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
 993                     ; 319 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
 993                     ; 320 {
 994                     	switch	.text
 995  0106               f_CLK_ClockSwitchConfig:
 997  0106 89            	pushw	x
 998  0107 5204          	subw	sp,#4
 999       00000004      OFST:	set	4
1002                     ; 323     uint16_t DownCounter = CLK_TIMEOUT;
1004  0109 ae0491        	ldw	x,#1169
1005  010c 1f03          	ldw	(OFST-1,sp),x
1007                     ; 324     ErrorStatus Swif = ERROR;
1009                     ; 327     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1011                     ; 328     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1013                     ; 329     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1015                     ; 330     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1017                     ; 333     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1019  010e c650c3        	ld	a,20675
1020  0111 6b01          	ld	(OFST-3,sp),a
1022                     ; 336     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1024  0113 7b05          	ld	a,(OFST+1,sp)
1025  0115 a101          	cp	a,#1
1026  0117 2639          	jrne	L544
1027                     ; 340         CLK->SWCR |= CLK_SWCR_SWEN;
1029  0119 721250c5      	bset	20677,#1
1030                     ; 343         if (ITState != DISABLE)
1032  011d 0d0a          	tnz	(OFST+6,sp)
1033  011f 2706          	jreq	L744
1034                     ; 345             CLK->SWCR |= CLK_SWCR_SWIEN;
1036  0121 721450c5      	bset	20677,#2
1038  0125 2004          	jra	L154
1039  0127               L744:
1040                     ; 349             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1042  0127 721550c5      	bres	20677,#2
1043  012b               L154:
1044                     ; 353         CLK->SWR = (uint8_t)CLK_NewClock;
1046  012b 7b06          	ld	a,(OFST+2,sp)
1047  012d c750c4        	ld	20676,a
1049  0130 2007          	jra	L754
1050  0132               L354:
1051                     ; 357             DownCounter--;
1053  0132 1e03          	ldw	x,(OFST-1,sp)
1054  0134 1d0001        	subw	x,#1
1055  0137 1f03          	ldw	(OFST-1,sp),x
1057  0139               L754:
1058                     ; 355         while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1060  0139 c650c5        	ld	a,20677
1061  013c a501          	bcp	a,#1
1062  013e 2704          	jreq	L364
1064  0140 1e03          	ldw	x,(OFST-1,sp)
1065  0142 26ee          	jrne	L354
1066  0144               L364:
1067                     ; 360         if (DownCounter != 0)
1069  0144 1e03          	ldw	x,(OFST-1,sp)
1070  0146 2706          	jreq	L564
1071                     ; 362             Swif = SUCCESS;
1073  0148 a601          	ld	a,#1
1074  014a 6b02          	ld	(OFST-2,sp),a
1077  014c 201b          	jra	L174
1078  014e               L564:
1079                     ; 366             Swif = ERROR;
1081  014e 0f02          	clr	(OFST-2,sp)
1083  0150 2017          	jra	L174
1084  0152               L544:
1085                     ; 374         if (ITState != DISABLE)
1087  0152 0d0a          	tnz	(OFST+6,sp)
1088  0154 2706          	jreq	L374
1089                     ; 376             CLK->SWCR |= CLK_SWCR_SWIEN;
1091  0156 721450c5      	bset	20677,#2
1093  015a 2004          	jra	L574
1094  015c               L374:
1095                     ; 380             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1097  015c 721550c5      	bres	20677,#2
1098  0160               L574:
1099                     ; 384         CLK->SWR = (uint8_t)CLK_NewClock;
1101  0160 7b06          	ld	a,(OFST+2,sp)
1102  0162 c750c4        	ld	20676,a
1103                     ; 388         Swif = SUCCESS;
1105  0165 a601          	ld	a,#1
1106  0167 6b02          	ld	(OFST-2,sp),a
1108  0169               L174:
1109                     ; 393     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1111  0169 0d0b          	tnz	(OFST+7,sp)
1112  016b 260c          	jrne	L774
1114  016d 7b01          	ld	a,(OFST-3,sp)
1115  016f a1e1          	cp	a,#225
1116  0171 2606          	jrne	L774
1117                     ; 395         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1119  0173 721150c0      	bres	20672,#0
1121  0177 201e          	jra	L105
1122  0179               L774:
1123                     ; 397     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1125  0179 0d0b          	tnz	(OFST+7,sp)
1126  017b 260c          	jrne	L305
1128  017d 7b01          	ld	a,(OFST-3,sp)
1129  017f a1d2          	cp	a,#210
1130  0181 2606          	jrne	L305
1131                     ; 399         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1133  0183 721750c0      	bres	20672,#3
1135  0187 200e          	jra	L105
1136  0189               L305:
1137                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1139  0189 0d0b          	tnz	(OFST+7,sp)
1140  018b 260a          	jrne	L105
1142  018d 7b01          	ld	a,(OFST-3,sp)
1143  018f a1b4          	cp	a,#180
1144  0191 2604          	jrne	L105
1145                     ; 403         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1147  0193 721150c1      	bres	20673,#0
1148  0197               L105:
1149                     ; 406     return(Swif);
1151  0197 7b02          	ld	a,(OFST-2,sp)
1154  0199 5b06          	addw	sp,#6
1155  019b 87            	retf
1292                     ; 416 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1292                     ; 417 {
1293                     	switch	.text
1294  019c               f_CLK_HSIPrescalerConfig:
1296  019c 88            	push	a
1297       00000000      OFST:	set	0
1300                     ; 420     assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1302                     ; 423     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1304  019d c650c6        	ld	a,20678
1305  01a0 a4e7          	and	a,#231
1306  01a2 c750c6        	ld	20678,a
1307                     ; 426     CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1309  01a5 c650c6        	ld	a,20678
1310  01a8 1a01          	or	a,(OFST+1,sp)
1311  01aa c750c6        	ld	20678,a
1312                     ; 428 }
1315  01ad 84            	pop	a
1316  01ae 87            	retf
1450                     ; 439 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1450                     ; 440 {
1451                     	switch	.text
1452  01af               f_CLK_CCOConfig:
1454  01af 88            	push	a
1455       00000000      OFST:	set	0
1458                     ; 443     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1460                     ; 446     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1462  01b0 c650c9        	ld	a,20681
1463  01b3 a4e1          	and	a,#225
1464  01b5 c750c9        	ld	20681,a
1465                     ; 449     CLK->CCOR |= (uint8_t)CLK_CCO;
1467  01b8 c650c9        	ld	a,20681
1468  01bb 1a01          	or	a,(OFST+1,sp)
1469  01bd c750c9        	ld	20681,a
1470                     ; 452     CLK->CCOR |= CLK_CCOR_CCOEN;
1472  01c0 721050c9      	bset	20681,#0
1473                     ; 454 }
1476  01c4 84            	pop	a
1477  01c5 87            	retf
1541                     ; 464 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1541                     ; 465 {
1542                     	switch	.text
1543  01c6               f_CLK_ITConfig:
1545  01c6 89            	pushw	x
1546       00000000      OFST:	set	0
1549                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1551                     ; 469     assert_param(IS_CLK_IT_OK(CLK_IT));
1553                     ; 471     if (NewState != DISABLE)
1555  01c7 9f            	ld	a,xl
1556  01c8 4d            	tnz	a
1557  01c9 2719          	jreq	L507
1558                     ; 473         switch (CLK_IT)
1560  01cb 9e            	ld	a,xh
1562                     ; 481         default:
1562                     ; 482             break;
1563  01cc a00c          	sub	a,#12
1564  01ce 270a          	jreq	L146
1565  01d0 a010          	sub	a,#16
1566  01d2 2624          	jrne	L317
1567                     ; 475         case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1567                     ; 476             CLK->SWCR |= CLK_SWCR_SWIEN;
1569  01d4 721450c5      	bset	20677,#2
1570                     ; 477             break;
1572  01d8 201e          	jra	L317
1573  01da               L146:
1574                     ; 478         case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1574                     ; 479             CLK->CSSR |= CLK_CSSR_CSSDIE;
1576  01da 721450c8      	bset	20680,#2
1577                     ; 480             break;
1579  01de 2018          	jra	L317
1580  01e0               L346:
1581                     ; 481         default:
1581                     ; 482             break;
1583  01e0 2016          	jra	L317
1584  01e2               L117:
1586  01e2 2014          	jra	L317
1587  01e4               L507:
1588                     ; 487         switch (CLK_IT)
1590  01e4 7b01          	ld	a,(OFST+1,sp)
1592                     ; 495         default:
1592                     ; 496             break;
1593  01e6 a00c          	sub	a,#12
1594  01e8 270a          	jreq	L746
1595  01ea a010          	sub	a,#16
1596  01ec 260a          	jrne	L317
1597                     ; 489         case CLK_IT_SWIF: /* Disable the clock switch interrupt */
1597                     ; 490             CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
1599  01ee 721550c5      	bres	20677,#2
1600                     ; 491             break;
1602  01f2 2004          	jra	L317
1603  01f4               L746:
1604                     ; 492         case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
1604                     ; 493             CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
1606  01f4 721550c8      	bres	20680,#2
1607                     ; 494             break;
1608  01f8               L317:
1609                     ; 500 }
1612  01f8 85            	popw	x
1613  01f9 87            	retf
1614  01fa               L156:
1615                     ; 495         default:
1615                     ; 496             break;
1617  01fa 20fc          	jra	L317
1618  01fc               L717:
1619  01fc 20fa          	jra	L317
1653                     ; 507 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
1653                     ; 508 {
1654                     	switch	.text
1655  01fe               f_CLK_SYSCLKConfig:
1657  01fe 88            	push	a
1658       00000000      OFST:	set	0
1661                     ; 511     assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
1663                     ; 513     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
1665  01ff a580          	bcp	a,#128
1666  0201 2614          	jrne	L737
1667                     ; 515         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1669  0203 c650c6        	ld	a,20678
1670  0206 a4e7          	and	a,#231
1671  0208 c750c6        	ld	20678,a
1672                     ; 516         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
1674  020b 7b01          	ld	a,(OFST+1,sp)
1675  020d a418          	and	a,#24
1676  020f ca50c6        	or	a,20678
1677  0212 c750c6        	ld	20678,a
1679  0215 2012          	jra	L147
1680  0217               L737:
1681                     ; 520         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
1683  0217 c650c6        	ld	a,20678
1684  021a a4f8          	and	a,#248
1685  021c c750c6        	ld	20678,a
1686                     ; 521         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
1688  021f 7b01          	ld	a,(OFST+1,sp)
1689  0221 a407          	and	a,#7
1690  0223 ca50c6        	or	a,20678
1691  0226 c750c6        	ld	20678,a
1692  0229               L147:
1693                     ; 524 }
1696  0229 84            	pop	a
1697  022a 87            	retf
1752                     ; 531 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
1752                     ; 532 {
1753                     	switch	.text
1754  022b               f_CLK_SWIMConfig:
1758                     ; 535     assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
1760                     ; 537     if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
1762  022b 4d            	tnz	a
1763  022c 2706          	jreq	L177
1764                     ; 540         CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
1766  022e 721050cd      	bset	20685,#0
1768  0232 2004          	jra	L377
1769  0234               L177:
1770                     ; 545         CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
1772  0234 721150cd      	bres	20685,#0
1773  0238               L377:
1774                     ; 548 }
1777  0238 87            	retf
1800                     ; 557 void CLK_ClockSecuritySystemEnable(void)
1800                     ; 558 {
1801                     	switch	.text
1802  0239               f_CLK_ClockSecuritySystemEnable:
1806                     ; 560     CLK->CSSR |= CLK_CSSR_CSSEN;
1808  0239 721050c8      	bset	20680,#0
1809                     ; 561 }
1812  023d 87            	retf
1836                     ; 569 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
1836                     ; 570 {
1837                     	switch	.text
1838  023e               f_CLK_GetSYSCLKSource:
1842                     ; 571     return((CLK_Source_TypeDef)CLK->CMSR);
1844  023e c650c3        	ld	a,20675
1847  0241 87            	retf
1909                     ; 579 uint32_t CLK_GetClockFreq(void)
1909                     ; 580 {
1910                     	switch	.text
1911  0242               f_CLK_GetClockFreq:
1913  0242 5209          	subw	sp,#9
1914       00000009      OFST:	set	9
1917                     ; 582     uint32_t clockfrequency = 0;
1919                     ; 583     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
1921                     ; 584     uint8_t tmp = 0, presc = 0;
1925                     ; 587     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
1927  0244 c650c3        	ld	a,20675
1928  0247 6b09          	ld	(OFST+0,sp),a
1930                     ; 589     if (clocksource == CLK_SOURCE_HSI)
1932  0249 7b09          	ld	a,(OFST+0,sp)
1933  024b a1e1          	cp	a,#225
1934  024d 2644          	jrne	L7401
1935                     ; 591         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
1937  024f c650c6        	ld	a,20678
1938  0252 a418          	and	a,#24
1939  0254 6b09          	ld	(OFST+0,sp),a
1941                     ; 592         tmp = (uint8_t)(tmp >> 3);
1943  0256 0409          	srl	(OFST+0,sp)
1944  0258 0409          	srl	(OFST+0,sp)
1945  025a 0409          	srl	(OFST+0,sp)
1947                     ; 593         presc = HSIDivFactor[tmp];
1949  025c 7b09          	ld	a,(OFST+0,sp)
1950  025e 5f            	clrw	x
1951  025f 97            	ld	xl,a
1952  0260 d60000        	ld	a,(_HSIDivFactor,x)
1953  0263 6b09          	ld	(OFST+0,sp),a
1955                     ; 594         clockfrequency = HSI_VALUE / presc;
1957  0265 7b09          	ld	a,(OFST+0,sp)
1958  0267 b703          	ld	c_lreg+3,a
1959  0269 3f02          	clr	c_lreg+2
1960  026b 3f01          	clr	c_lreg+1
1961  026d 3f00          	clr	c_lreg
1962  026f 96            	ldw	x,sp
1963  0270 1c0001        	addw	x,#OFST-8
1964  0273 8d000000      	callf	d_rtol
1967  0277 ae2400        	ldw	x,#9216
1968  027a bf02          	ldw	c_lreg+2,x
1969  027c ae00f4        	ldw	x,#244
1970  027f bf00          	ldw	c_lreg,x
1971  0281 96            	ldw	x,sp
1972  0282 1c0001        	addw	x,#OFST-8
1973  0285 8d000000      	callf	d_ludv
1975  0289 96            	ldw	x,sp
1976  028a 1c0005        	addw	x,#OFST-4
1977  028d 8d000000      	callf	d_rtol
1981  0291 201c          	jra	L1501
1982  0293               L7401:
1983                     ; 596     else if ( clocksource == CLK_SOURCE_LSI)
1985  0293 7b09          	ld	a,(OFST+0,sp)
1986  0295 a1d2          	cp	a,#210
1987  0297 260c          	jrne	L3501
1988                     ; 598         clockfrequency = LSI_VALUE;
1990  0299 aef400        	ldw	x,#62464
1991  029c 1f07          	ldw	(OFST-2,sp),x
1992  029e ae0001        	ldw	x,#1
1993  02a1 1f05          	ldw	(OFST-4,sp),x
1996  02a3 200a          	jra	L1501
1997  02a5               L3501:
1998                     ; 602         clockfrequency = HSE_VALUE;
2000  02a5 ae3600        	ldw	x,#13824
2001  02a8 1f07          	ldw	(OFST-2,sp),x
2002  02aa ae016e        	ldw	x,#366
2003  02ad 1f05          	ldw	(OFST-4,sp),x
2005  02af               L1501:
2006                     ; 605     return((uint32_t)clockfrequency);
2008  02af 96            	ldw	x,sp
2009  02b0 1c0005        	addw	x,#OFST-4
2010  02b3 8d000000      	callf	d_ltor
2014  02b7 5b09          	addw	sp,#9
2015  02b9 87            	retf
2113                     ; 616 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2113                     ; 617 {
2114                     	switch	.text
2115  02ba               f_CLK_AdjustHSICalibrationValue:
2117  02ba 88            	push	a
2118       00000000      OFST:	set	0
2121                     ; 620     assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2123                     ; 623     CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2125  02bb c650cc        	ld	a,20684
2126  02be a4f8          	and	a,#248
2127  02c0 1a01          	or	a,(OFST+1,sp)
2128  02c2 c750cc        	ld	20684,a
2129                     ; 625 }
2132  02c5 84            	pop	a
2133  02c6 87            	retf
2156                     ; 636 void CLK_SYSCLKEmergencyClear(void)
2156                     ; 637 {
2157                     	switch	.text
2158  02c7               f_CLK_SYSCLKEmergencyClear:
2162                     ; 638     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2164  02c7 721150c5      	bres	20677,#0
2165                     ; 639 }
2168  02cb 87            	retf
2320                     ; 648 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2320                     ; 649 {
2321                     	switch	.text
2322  02cc               f_CLK_GetFlagStatus:
2324  02cc 89            	pushw	x
2325  02cd 5203          	subw	sp,#3
2326       00000003      OFST:	set	3
2329                     ; 651     uint16_t statusreg = 0;
2331                     ; 652     uint8_t tmpreg = 0;
2333                     ; 653     FlagStatus bitstatus = RESET;
2335                     ; 656     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2337                     ; 659     statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2339  02cf 01            	rrwa	x,a
2340  02d0 9f            	ld	a,xl
2341  02d1 a4ff          	and	a,#255
2342  02d3 97            	ld	xl,a
2343  02d4 4f            	clr	a
2344  02d5 02            	rlwa	x,a
2345  02d6 1f01          	ldw	(OFST-2,sp),x
2346  02d8 01            	rrwa	x,a
2348                     ; 662     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2350  02d9 1e01          	ldw	x,(OFST-2,sp)
2351  02db a30100        	cpw	x,#256
2352  02de 2607          	jrne	L1221
2353                     ; 664         tmpreg = CLK->ICKR;
2355  02e0 c650c0        	ld	a,20672
2356  02e3 6b03          	ld	(OFST+0,sp),a
2359  02e5 202f          	jra	L3221
2360  02e7               L1221:
2361                     ; 666     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2363  02e7 1e01          	ldw	x,(OFST-2,sp)
2364  02e9 a30200        	cpw	x,#512
2365  02ec 2607          	jrne	L5221
2366                     ; 668         tmpreg = CLK->ECKR;
2368  02ee c650c1        	ld	a,20673
2369  02f1 6b03          	ld	(OFST+0,sp),a
2372  02f3 2021          	jra	L3221
2373  02f5               L5221:
2374                     ; 670     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2376  02f5 1e01          	ldw	x,(OFST-2,sp)
2377  02f7 a30300        	cpw	x,#768
2378  02fa 2607          	jrne	L1321
2379                     ; 672         tmpreg = CLK->SWCR;
2381  02fc c650c5        	ld	a,20677
2382  02ff 6b03          	ld	(OFST+0,sp),a
2385  0301 2013          	jra	L3221
2386  0303               L1321:
2387                     ; 674     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2389  0303 1e01          	ldw	x,(OFST-2,sp)
2390  0305 a30400        	cpw	x,#1024
2391  0308 2607          	jrne	L5321
2392                     ; 676         tmpreg = CLK->CSSR;
2394  030a c650c8        	ld	a,20680
2395  030d 6b03          	ld	(OFST+0,sp),a
2398  030f 2005          	jra	L3221
2399  0311               L5321:
2400                     ; 680         tmpreg = CLK->CCOR;
2402  0311 c650c9        	ld	a,20681
2403  0314 6b03          	ld	(OFST+0,sp),a
2405  0316               L3221:
2406                     ; 683     if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2408  0316 7b05          	ld	a,(OFST+2,sp)
2409  0318 1503          	bcp	a,(OFST+0,sp)
2410  031a 2706          	jreq	L1421
2411                     ; 685         bitstatus = SET;
2413  031c a601          	ld	a,#1
2414  031e 6b03          	ld	(OFST+0,sp),a
2417  0320 2002          	jra	L3421
2418  0322               L1421:
2419                     ; 689         bitstatus = RESET;
2421  0322 0f03          	clr	(OFST+0,sp)
2423  0324               L3421:
2424                     ; 693     return((FlagStatus)bitstatus);
2426  0324 7b03          	ld	a,(OFST+0,sp)
2429  0326 5b05          	addw	sp,#5
2430  0328 87            	retf
2475                     ; 703 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
2475                     ; 704 {
2476                     	switch	.text
2477  0329               f_CLK_GetITStatus:
2479  0329 88            	push	a
2480  032a 88            	push	a
2481       00000001      OFST:	set	1
2484                     ; 706     ITStatus bitstatus = RESET;
2486                     ; 709     assert_param(IS_CLK_IT_OK(CLK_IT));
2488                     ; 711     if (CLK_IT == CLK_IT_SWIF)
2490  032b a11c          	cp	a,#28
2491  032d 2611          	jrne	L7621
2492                     ; 714         if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2494  032f c450c5        	and	a,20677
2495  0332 a10c          	cp	a,#12
2496  0334 2606          	jrne	L1721
2497                     ; 716             bitstatus = SET;
2499  0336 a601          	ld	a,#1
2500  0338 6b01          	ld	(OFST+0,sp),a
2503  033a 2015          	jra	L5721
2504  033c               L1721:
2505                     ; 720             bitstatus = RESET;
2507  033c 0f01          	clr	(OFST+0,sp)
2509  033e 2011          	jra	L5721
2510  0340               L7621:
2511                     ; 726         if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2513  0340 c650c8        	ld	a,20680
2514  0343 1402          	and	a,(OFST+1,sp)
2515  0345 a10c          	cp	a,#12
2516  0347 2606          	jrne	L7721
2517                     ; 728             bitstatus = SET;
2519  0349 a601          	ld	a,#1
2520  034b 6b01          	ld	(OFST+0,sp),a
2523  034d 2002          	jra	L5721
2524  034f               L7721:
2525                     ; 732             bitstatus = RESET;
2527  034f 0f01          	clr	(OFST+0,sp)
2529  0351               L5721:
2530                     ; 737     return bitstatus;
2532  0351 7b01          	ld	a,(OFST+0,sp)
2535  0353 85            	popw	x
2536  0354 87            	retf
2571                     ; 747 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
2571                     ; 748 {
2572                     	switch	.text
2573  0355               f_CLK_ClearITPendingBit:
2577                     ; 751     assert_param(IS_CLK_IT_OK(CLK_IT));
2579                     ; 753     if (CLK_IT == (uint8_t)CLK_IT_CSSD)
2581  0355 a10c          	cp	a,#12
2582  0357 2606          	jrne	L1231
2583                     ; 756         CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
2585  0359 721750c8      	bres	20680,#3
2587  035d 2004          	jra	L3231
2588  035f               L1231:
2589                     ; 761         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
2591  035f 721750c5      	bres	20677,#3
2592  0363               L3231:
2593                     ; 764 }
2596  0363 87            	retf
2630                     	xdef	_CLKPrescTable
2631                     	xdef	_HSIDivFactor
2632                     	xdef	f_CLK_ClearITPendingBit
2633                     	xdef	f_CLK_GetITStatus
2634                     	xdef	f_CLK_GetFlagStatus
2635                     	xdef	f_CLK_GetSYSCLKSource
2636                     	xdef	f_CLK_GetClockFreq
2637                     	xdef	f_CLK_AdjustHSICalibrationValue
2638                     	xdef	f_CLK_SYSCLKEmergencyClear
2639                     	xdef	f_CLK_ClockSecuritySystemEnable
2640                     	xdef	f_CLK_SWIMConfig
2641                     	xdef	f_CLK_SYSCLKConfig
2642                     	xdef	f_CLK_ITConfig
2643                     	xdef	f_CLK_CCOConfig
2644                     	xdef	f_CLK_HSIPrescalerConfig
2645                     	xdef	f_CLK_ClockSwitchConfig
2646                     	xdef	f_CLK_PeripheralClockConfig
2647                     	xdef	f_CLK_SlowActiveHaltWakeUpCmd
2648                     	xdef	f_CLK_FastHaltWakeUpCmd
2649                     	xdef	f_CLK_ClockSwitchCmd
2650                     	xdef	f_CLK_CCOCmd
2651                     	xdef	f_CLK_LSICmd
2652                     	xdef	f_CLK_HSICmd
2653                     	xdef	f_CLK_HSECmd
2654                     	xdef	f_CLK_DeInit
2655                     	xref.b	c_lreg
2656                     	xref.b	c_x
2675                     	xref	d_ltor
2676                     	xref	d_ludv
2677                     	xref	d_rtol
2678                     	end
