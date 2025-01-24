   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  17                     .const:	section	.text
  18  0000               _HSIDivFactor:
  19  0000 01            	dc.b	1
  20  0001 02            	dc.b	2
  21  0002 04            	dc.b	4
  22  0003 08            	dc.b	8
  23  0004               _CLKPrescTable:
  24  0004 01            	dc.b	1
  25  0005 02            	dc.b	2
  26  0006 04            	dc.b	4
  27  0007 08            	dc.b	8
  28  0008 0a            	dc.b	10
  29  0009 10            	dc.b	16
  30  000a 14            	dc.b	20
  31  000b 28            	dc.b	40
  60                     ; 66 void CLK_DeInit(void)
  60                     ; 67 {
  61                     	switch	.text
  62  0000               f_CLK_DeInit:
  66                     ; 69     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  68  0000 350150c0      	mov	20672,#1
  69                     ; 70     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  71  0004 725f50c1      	clr	20673
  72                     ; 71     CLK->SWR  = CLK_SWR_RESET_VALUE;
  74  0008 35e150c4      	mov	20676,#225
  75                     ; 72     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  77  000c 725f50c5      	clr	20677
  78                     ; 73     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  80  0010 351850c6      	mov	20678,#24
  81                     ; 74     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  83  0014 35ff50c7      	mov	20679,#255
  84                     ; 75     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  86  0018 35ff50ca      	mov	20682,#255
  87                     ; 76     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  89  001c 725f50c8      	clr	20680
  90                     ; 77     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  92  0020 725f50c9      	clr	20681
  94  0024               L52:
  95                     ; 78     while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
  97  0024 720050c9fb    	btjt	20681,#0,L52
  98                     ; 80     CLK->CCOR = CLK_CCOR_RESET_VALUE;
 100  0029 725f50c9      	clr	20681
 101                     ; 81     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 103  002d 725f50cc      	clr	20684
 104                     ; 82     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 106  0031 725f50cd      	clr	20685
 107                     ; 84 }
 110  0035 87            	retf	
 165                     ; 95 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 165                     ; 96 {
 166                     	switch	.text
 167  0036               f_CLK_FastHaltWakeUpCmd:
 171                     ; 99     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 173                     ; 101     if (NewState != DISABLE)
 175  0036 4d            	tnz	a
 176  0037 2705          	jreq	L75
 177                     ; 104         CLK->ICKR |= CLK_ICKR_FHWU;
 179  0039 721450c0      	bset	20672,#2
 182  003d 87            	retf	
 183  003e               L75:
 184                     ; 109         CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 186  003e 721550c0      	bres	20672,#2
 187                     ; 112 }
 190  0042 87            	retf	
 224                     ; 119 void CLK_HSECmd(FunctionalState NewState)
 224                     ; 120 {
 225                     	switch	.text
 226  0043               f_CLK_HSECmd:
 230                     ; 123     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 232                     ; 125     if (NewState != DISABLE)
 234  0043 4d            	tnz	a
 235  0044 2705          	jreq	L101
 236                     ; 128         CLK->ECKR |= CLK_ECKR_HSEEN;
 238  0046 721050c1      	bset	20673,#0
 241  004a 87            	retf	
 242  004b               L101:
 243                     ; 133         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 245  004b 721150c1      	bres	20673,#0
 246                     ; 136 }
 249  004f 87            	retf	
 283                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 283                     ; 144 {
 284                     	switch	.text
 285  0050               f_CLK_HSICmd:
 289                     ; 147     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 291                     ; 149     if (NewState != DISABLE)
 293  0050 4d            	tnz	a
 294  0051 2705          	jreq	L321
 295                     ; 152         CLK->ICKR |= CLK_ICKR_HSIEN;
 297  0053 721050c0      	bset	20672,#0
 300  0057 87            	retf	
 301  0058               L321:
 302                     ; 157         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 304  0058 721150c0      	bres	20672,#0
 305                     ; 160 }
 308  005c 87            	retf	
 342                     ; 167 void CLK_LSICmd(FunctionalState NewState)
 342                     ; 168 {
 343                     	switch	.text
 344  005d               f_CLK_LSICmd:
 348                     ; 171     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 350                     ; 173     if (NewState != DISABLE)
 352  005d 4d            	tnz	a
 353  005e 2705          	jreq	L541
 354                     ; 176         CLK->ICKR |= CLK_ICKR_LSIEN;
 356  0060 721650c0      	bset	20672,#3
 359  0064 87            	retf	
 360  0065               L541:
 361                     ; 181         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 363  0065 721750c0      	bres	20672,#3
 364                     ; 184 }
 367  0069 87            	retf	
 401                     ; 192 void CLK_CCOCmd(FunctionalState NewState)
 401                     ; 193 {
 402                     	switch	.text
 403  006a               f_CLK_CCOCmd:
 407                     ; 196     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 409                     ; 198     if (NewState != DISABLE)
 411  006a 4d            	tnz	a
 412  006b 2705          	jreq	L761
 413                     ; 201         CLK->CCOR |= CLK_CCOR_CCOEN;
 415  006d 721050c9      	bset	20681,#0
 418  0071 87            	retf	
 419  0072               L761:
 420                     ; 206         CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 422  0072 721150c9      	bres	20681,#0
 423                     ; 209 }
 426  0076 87            	retf	
 460                     ; 218 void CLK_ClockSwitchCmd(FunctionalState NewState)
 460                     ; 219 {
 461                     	switch	.text
 462  0077               f_CLK_ClockSwitchCmd:
 466                     ; 222     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 468                     ; 224     if (NewState != DISABLE )
 470  0077 4d            	tnz	a
 471  0078 2705          	jreq	L112
 472                     ; 227         CLK->SWCR |= CLK_SWCR_SWEN;
 474  007a 721250c5      	bset	20677,#1
 477  007e 87            	retf	
 478  007f               L112:
 479                     ; 232         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 481  007f 721350c5      	bres	20677,#1
 482                     ; 235 }
 485  0083 87            	retf	
 520                     ; 245 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 520                     ; 246 {
 521                     	switch	.text
 522  0084               f_CLK_SlowActiveHaltWakeUpCmd:
 526                     ; 249     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 528                     ; 251     if (NewState != DISABLE)
 530  0084 4d            	tnz	a
 531  0085 2705          	jreq	L332
 532                     ; 254         CLK->ICKR |= CLK_ICKR_SWUAH;
 534  0087 721a50c0      	bset	20672,#5
 537  008b 87            	retf	
 538  008c               L332:
 539                     ; 259         CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 541  008c 721b50c0      	bres	20672,#5
 542                     ; 262 }
 545  0090 87            	retf	
 703                     ; 272 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 703                     ; 273 {
 704                     	switch	.text
 705  0091               f_CLK_PeripheralClockConfig:
 707  0091 89            	pushw	x
 708       00000000      OFST:	set	0
 711                     ; 276     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 713                     ; 277     assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 715                     ; 279     if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 717  0092 9e            	ld	a,xh
 718  0093 a510          	bcp	a,#16
 719  0095 2630          	jrne	L123
 720                     ; 281         if (NewState != DISABLE)
 722  0097 7b02          	ld	a,(OFST+2,sp)
 723  0099 2714          	jreq	L323
 724                     ; 284             CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 726  009b 7b01          	ld	a,(OFST+1,sp)
 727  009d a40f          	and	a,#15
 728  009f 5f            	clrw	x
 729  00a0 97            	ld	xl,a
 730  00a1 a601          	ld	a,#1
 731  00a3 5d            	tnzw	x
 732  00a4 2704          	jreq	L62
 733  00a6               L03:
 734  00a6 48            	sll	a
 735  00a7 5a            	decw	x
 736  00a8 26fc          	jrne	L03
 737  00aa               L62:
 738  00aa ca50c7        	or	a,20679
 740  00ad 2013          	jpf	LC002
 741  00af               L323:
 742                     ; 289             CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 744  00af 7b01          	ld	a,(OFST+1,sp)
 745  00b1 a40f          	and	a,#15
 746  00b3 5f            	clrw	x
 747  00b4 97            	ld	xl,a
 748  00b5 a601          	ld	a,#1
 749  00b7 5d            	tnzw	x
 750  00b8 2704          	jreq	L23
 751  00ba               L43:
 752  00ba 48            	sll	a
 753  00bb 5a            	decw	x
 754  00bc 26fc          	jrne	L43
 755  00be               L23:
 756  00be 43            	cpl	a
 757  00bf c450c7        	and	a,20679
 758  00c2               LC002:
 759  00c2 c750c7        	ld	20679,a
 760  00c5 202e          	jra	L723
 761  00c7               L123:
 762                     ; 294         if (NewState != DISABLE)
 764  00c7 7b02          	ld	a,(OFST+2,sp)
 765  00c9 2714          	jreq	L133
 766                     ; 297             CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 768  00cb 7b01          	ld	a,(OFST+1,sp)
 769  00cd a40f          	and	a,#15
 770  00cf 5f            	clrw	x
 771  00d0 97            	ld	xl,a
 772  00d1 a601          	ld	a,#1
 773  00d3 5d            	tnzw	x
 774  00d4 2704          	jreq	L63
 775  00d6               L04:
 776  00d6 48            	sll	a
 777  00d7 5a            	decw	x
 778  00d8 26fc          	jrne	L04
 779  00da               L63:
 780  00da ca50ca        	or	a,20682
 782  00dd 2013          	jpf	LC001
 783  00df               L133:
 784                     ; 302             CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 786  00df 7b01          	ld	a,(OFST+1,sp)
 787  00e1 a40f          	and	a,#15
 788  00e3 5f            	clrw	x
 789  00e4 97            	ld	xl,a
 790  00e5 a601          	ld	a,#1
 791  00e7 5d            	tnzw	x
 792  00e8 2704          	jreq	L24
 793  00ea               L44:
 794  00ea 48            	sll	a
 795  00eb 5a            	decw	x
 796  00ec 26fc          	jrne	L44
 797  00ee               L24:
 798  00ee 43            	cpl	a
 799  00ef c450ca        	and	a,20682
 800  00f2               LC001:
 801  00f2 c750ca        	ld	20682,a
 802  00f5               L723:
 803                     ; 306 }
 806  00f5 85            	popw	x
 807  00f6 87            	retf	
 994                     ; 319 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
 994                     ; 320 {
 995                     	switch	.text
 996  00f7               f_CLK_ClockSwitchConfig:
 998  00f7 89            	pushw	x
 999  00f8 5204          	subw	sp,#4
1000       00000004      OFST:	set	4
1003                     ; 323     uint16_t DownCounter = CLK_TIMEOUT;
1005  00fa ae0491        	ldw	x,#1169
1006  00fd 1f03          	ldw	(OFST-1,sp),x
1008                     ; 324     ErrorStatus Swif = ERROR;
1010                     ; 327     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1012                     ; 328     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1014                     ; 329     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1016                     ; 330     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1018                     ; 333     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1020  00ff c650c3        	ld	a,20675
1021  0102 6b01          	ld	(OFST-3,sp),a
1023                     ; 336     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1025  0104 7b05          	ld	a,(OFST+1,sp)
1026  0106 4a            	dec	a
1027  0107 262d          	jrne	L544
1028                     ; 340         CLK->SWCR |= CLK_SWCR_SWEN;
1030  0109 721250c5      	bset	20677,#1
1031                     ; 343         if (ITState != DISABLE)
1033  010d 7b0a          	ld	a,(OFST+6,sp)
1034  010f 2706          	jreq	L744
1035                     ; 345             CLK->SWCR |= CLK_SWCR_SWIEN;
1037  0111 721450c5      	bset	20677,#2
1039  0115 2004          	jra	L154
1040  0117               L744:
1041                     ; 349             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1043  0117 721550c5      	bres	20677,#2
1044  011b               L154:
1045                     ; 353         CLK->SWR = (uint8_t)CLK_NewClock;
1047  011b 7b06          	ld	a,(OFST+2,sp)
1048  011d c750c4        	ld	20676,a
1050  0120 2003          	jra	L754
1051  0122               L354:
1052                     ; 357             DownCounter--;
1054  0122 5a            	decw	x
1055  0123 1f03          	ldw	(OFST-1,sp),x
1057  0125               L754:
1058                     ; 355         while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1060  0125 720150c504    	btjf	20677,#0,L364
1062  012a 1e03          	ldw	x,(OFST-1,sp)
1063  012c 26f4          	jrne	L354
1064  012e               L364:
1065                     ; 360         if (DownCounter != 0)
1067  012e 1e03          	ldw	x,(OFST-1,sp)
1068                     ; 362             Swif = SUCCESS;
1070  0130 2617          	jrne	LC003
1071                     ; 366             Swif = ERROR;
1073  0132 0f02          	clr	(OFST-2,sp)
1075  0134 2017          	jra	L174
1076  0136               L544:
1077                     ; 374         if (ITState != DISABLE)
1079  0136 7b0a          	ld	a,(OFST+6,sp)
1080  0138 2706          	jreq	L374
1081                     ; 376             CLK->SWCR |= CLK_SWCR_SWIEN;
1083  013a 721450c5      	bset	20677,#2
1085  013e 2004          	jra	L574
1086  0140               L374:
1087                     ; 380             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1089  0140 721550c5      	bres	20677,#2
1090  0144               L574:
1091                     ; 384         CLK->SWR = (uint8_t)CLK_NewClock;
1093  0144 7b06          	ld	a,(OFST+2,sp)
1094  0146 c750c4        	ld	20676,a
1095                     ; 388         Swif = SUCCESS;
1097  0149               LC003:
1099  0149 a601          	ld	a,#1
1100  014b 6b02          	ld	(OFST-2,sp),a
1102  014d               L174:
1103                     ; 393     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1105  014d 7b0b          	ld	a,(OFST+7,sp)
1106  014f 260c          	jrne	L774
1108  0151 7b01          	ld	a,(OFST-3,sp)
1109  0153 a1e1          	cp	a,#225
1110  0155 2606          	jrne	L774
1111                     ; 395         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1113  0157 721150c0      	bres	20672,#0
1115  015b 201e          	jra	L105
1116  015d               L774:
1117                     ; 397     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1119  015d 7b0b          	ld	a,(OFST+7,sp)
1120  015f 260c          	jrne	L305
1122  0161 7b01          	ld	a,(OFST-3,sp)
1123  0163 a1d2          	cp	a,#210
1124  0165 2606          	jrne	L305
1125                     ; 399         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1127  0167 721750c0      	bres	20672,#3
1129  016b 200e          	jra	L105
1130  016d               L305:
1131                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1133  016d 7b0b          	ld	a,(OFST+7,sp)
1134  016f 260a          	jrne	L105
1136  0171 7b01          	ld	a,(OFST-3,sp)
1137  0173 a1b4          	cp	a,#180
1138  0175 2604          	jrne	L105
1139                     ; 403         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1141  0177 721150c1      	bres	20673,#0
1142  017b               L105:
1143                     ; 406     return(Swif);
1145  017b 7b02          	ld	a,(OFST-2,sp)
1148  017d 5b06          	addw	sp,#6
1149  017f 87            	retf	
1286                     ; 416 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1286                     ; 417 {
1287                     	switch	.text
1288  0180               f_CLK_HSIPrescalerConfig:
1290  0180 88            	push	a
1291       00000000      OFST:	set	0
1294                     ; 420     assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1296                     ; 423     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1298  0181 c650c6        	ld	a,20678
1299  0184 a4e7          	and	a,#231
1300  0186 c750c6        	ld	20678,a
1301                     ; 426     CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1303  0189 c650c6        	ld	a,20678
1304  018c 1a01          	or	a,(OFST+1,sp)
1305  018e c750c6        	ld	20678,a
1306                     ; 428 }
1309  0191 84            	pop	a
1310  0192 87            	retf	
1444                     ; 439 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1444                     ; 440 {
1445                     	switch	.text
1446  0193               f_CLK_CCOConfig:
1448  0193 88            	push	a
1449       00000000      OFST:	set	0
1452                     ; 443     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1454                     ; 446     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1456  0194 c650c9        	ld	a,20681
1457  0197 a4e1          	and	a,#225
1458  0199 c750c9        	ld	20681,a
1459                     ; 449     CLK->CCOR |= (uint8_t)CLK_CCO;
1461  019c c650c9        	ld	a,20681
1462  019f 1a01          	or	a,(OFST+1,sp)
1463  01a1 c750c9        	ld	20681,a
1464                     ; 452     CLK->CCOR |= CLK_CCOR_CCOEN;
1466  01a4 721050c9      	bset	20681,#0
1467                     ; 454 }
1470  01a8 84            	pop	a
1471  01a9 87            	retf	
1535                     ; 464 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1535                     ; 465 {
1536                     	switch	.text
1537  01aa               f_CLK_ITConfig:
1539  01aa 89            	pushw	x
1540       00000000      OFST:	set	0
1543                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1545                     ; 469     assert_param(IS_CLK_IT_OK(CLK_IT));
1547                     ; 471     if (NewState != DISABLE)
1549  01ab 9f            	ld	a,xl
1550  01ac 4d            	tnz	a
1551  01ad 2715          	jreq	L507
1552                     ; 473         switch (CLK_IT)
1554  01af 9e            	ld	a,xh
1556                     ; 481         default:
1556                     ; 482             break;
1557  01b0 a00c          	sub	a,#12
1558  01b2 270a          	jreq	L146
1559  01b4 a010          	sub	a,#16
1560  01b6 2620          	jrne	L317
1561                     ; 475         case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1561                     ; 476             CLK->SWCR |= CLK_SWCR_SWIEN;
1563  01b8 721450c5      	bset	20677,#2
1564                     ; 477             break;
1566  01bc 201a          	jra	L317
1567  01be               L146:
1568                     ; 478         case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1568                     ; 479             CLK->CSSR |= CLK_CSSR_CSSDIE;
1570  01be 721450c8      	bset	20680,#2
1571                     ; 480             break;
1573  01c2 2014          	jra	L317
1574                     ; 481         default:
1574                     ; 482             break;
1577  01c4               L507:
1578                     ; 487         switch (CLK_IT)
1580  01c4 7b01          	ld	a,(OFST+1,sp)
1582                     ; 495         default:
1582                     ; 496             break;
1583  01c6 a00c          	sub	a,#12
1584  01c8 270a          	jreq	L746
1585  01ca a010          	sub	a,#16
1586  01cc 260a          	jrne	L317
1587                     ; 489         case CLK_IT_SWIF: /* Disable the clock switch interrupt */
1587                     ; 490             CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
1589  01ce 721550c5      	bres	20677,#2
1590                     ; 491             break;
1592  01d2 2004          	jra	L317
1593  01d4               L746:
1594                     ; 492         case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
1594                     ; 493             CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
1596  01d4 721550c8      	bres	20680,#2
1597                     ; 494             break;
1598  01d8               L317:
1599                     ; 500 }
1602  01d8 85            	popw	x
1603  01d9 87            	retf	
1604                     ; 495         default:
1604                     ; 496             break;
1639                     ; 507 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
1639                     ; 508 {
1640                     	switch	.text
1641  01da               f_CLK_SYSCLKConfig:
1643  01da 88            	push	a
1644       00000000      OFST:	set	0
1647                     ; 511     assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
1649                     ; 513     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
1651  01db a580          	bcp	a,#128
1652  01dd 260e          	jrne	L737
1653                     ; 515         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1655  01df c650c6        	ld	a,20678
1656  01e2 a4e7          	and	a,#231
1657  01e4 c750c6        	ld	20678,a
1658                     ; 516         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
1660  01e7 7b01          	ld	a,(OFST+1,sp)
1661  01e9 a418          	and	a,#24
1663  01eb 200c          	jra	L147
1664  01ed               L737:
1665                     ; 520         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
1667  01ed c650c6        	ld	a,20678
1668  01f0 a4f8          	and	a,#248
1669  01f2 c750c6        	ld	20678,a
1670                     ; 521         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
1672  01f5 7b01          	ld	a,(OFST+1,sp)
1673  01f7 a407          	and	a,#7
1674  01f9               L147:
1675  01f9 ca50c6        	or	a,20678
1676  01fc c750c6        	ld	20678,a
1677                     ; 524 }
1680  01ff 84            	pop	a
1681  0200 87            	retf	
1736                     ; 531 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
1736                     ; 532 {
1737                     	switch	.text
1738  0201               f_CLK_SWIMConfig:
1742                     ; 535     assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
1744                     ; 537     if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
1746  0201 4d            	tnz	a
1747  0202 2705          	jreq	L177
1748                     ; 540         CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
1750  0204 721050cd      	bset	20685,#0
1753  0208 87            	retf	
1754  0209               L177:
1755                     ; 545         CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
1757  0209 721150cd      	bres	20685,#0
1758                     ; 548 }
1761  020d 87            	retf	
1784                     ; 557 void CLK_ClockSecuritySystemEnable(void)
1784                     ; 558 {
1785                     	switch	.text
1786  020e               f_CLK_ClockSecuritySystemEnable:
1790                     ; 560     CLK->CSSR |= CLK_CSSR_CSSEN;
1792  020e 721050c8      	bset	20680,#0
1793                     ; 561 }
1796  0212 87            	retf	
1820                     ; 569 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
1820                     ; 570 {
1821                     	switch	.text
1822  0213               f_CLK_GetSYSCLKSource:
1826                     ; 571     return((CLK_Source_TypeDef)CLK->CMSR);
1828  0213 c650c3        	ld	a,20675
1831  0216 87            	retf	
1893                     ; 579 uint32_t CLK_GetClockFreq(void)
1893                     ; 580 {
1894                     	switch	.text
1895  0217               f_CLK_GetClockFreq:
1897  0217 5209          	subw	sp,#9
1898       00000009      OFST:	set	9
1901                     ; 582     uint32_t clockfrequency = 0;
1903                     ; 583     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
1905                     ; 584     uint8_t tmp = 0, presc = 0;
1909                     ; 587     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
1911  0219 c650c3        	ld	a,20675
1912  021c 6b09          	ld	(OFST+0,sp),a
1914                     ; 589     if (clocksource == CLK_SOURCE_HSI)
1916  021e a1e1          	cp	a,#225
1917  0220 2637          	jrne	L7401
1918                     ; 591         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
1920  0222 c650c6        	ld	a,20678
1921  0225 a418          	and	a,#24
1922  0227 44            	srl	a
1923  0228 44            	srl	a
1924  0229 44            	srl	a
1926                     ; 592         tmp = (uint8_t)(tmp >> 3);
1929                     ; 593         presc = HSIDivFactor[tmp];
1931  022a 5f            	clrw	x
1932  022b 97            	ld	xl,a
1933  022c d60000        	ld	a,(_HSIDivFactor,x)
1934  022f 6b09          	ld	(OFST+0,sp),a
1936                     ; 594         clockfrequency = HSI_VALUE / presc;
1938  0231 b703          	ld	c_lreg+3,a
1939  0233 3f02          	clr	c_lreg+2
1940  0235 3f01          	clr	c_lreg+1
1941  0237 3f00          	clr	c_lreg
1942  0239 96            	ldw	x,sp
1943  023a 5c            	incw	x
1944  023b 8d000000      	callf	d_rtol
1947  023f ae2400        	ldw	x,#9216
1948  0242 bf02          	ldw	c_lreg+2,x
1949  0244 ae00f4        	ldw	x,#244
1950  0247 bf00          	ldw	c_lreg,x
1951  0249 96            	ldw	x,sp
1952  024a 5c            	incw	x
1953  024b 8d000000      	callf	d_ludv
1955  024f 96            	ldw	x,sp
1956  0250 1c0005        	addw	x,#OFST-4
1957  0253 8d000000      	callf	d_rtol
1961  0257 2018          	jra	L1501
1962  0259               L7401:
1963                     ; 596     else if ( clocksource == CLK_SOURCE_LSI)
1965  0259 a1d2          	cp	a,#210
1966  025b 260a          	jrne	L3501
1967                     ; 598         clockfrequency = LSI_VALUE;
1969  025d aef400        	ldw	x,#62464
1970  0260 1f07          	ldw	(OFST-2,sp),x
1971  0262 ae0001        	ldw	x,#1
1973  0265 2008          	jpf	LC004
1974  0267               L3501:
1975                     ; 602         clockfrequency = HSE_VALUE;
1977  0267 ae3600        	ldw	x,#13824
1978  026a 1f07          	ldw	(OFST-2,sp),x
1979  026c ae016e        	ldw	x,#366
1980  026f               LC004:
1981  026f 1f05          	ldw	(OFST-4,sp),x
1983  0271               L1501:
1984                     ; 605     return((uint32_t)clockfrequency);
1986  0271 96            	ldw	x,sp
1987  0272 1c0005        	addw	x,#OFST-4
1988  0275 8d000000      	callf	d_ltor
1992  0279 5b09          	addw	sp,#9
1993  027b 87            	retf	
2091                     ; 616 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2091                     ; 617 {
2092                     	switch	.text
2093  027c               f_CLK_AdjustHSICalibrationValue:
2095  027c 88            	push	a
2096       00000000      OFST:	set	0
2099                     ; 620     assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2101                     ; 623     CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2103  027d c650cc        	ld	a,20684
2104  0280 a4f8          	and	a,#248
2105  0282 1a01          	or	a,(OFST+1,sp)
2106  0284 c750cc        	ld	20684,a
2107                     ; 625 }
2110  0287 84            	pop	a
2111  0288 87            	retf	
2134                     ; 636 void CLK_SYSCLKEmergencyClear(void)
2134                     ; 637 {
2135                     	switch	.text
2136  0289               f_CLK_SYSCLKEmergencyClear:
2140                     ; 638     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2142  0289 721150c5      	bres	20677,#0
2143                     ; 639 }
2146  028d 87            	retf	
2298                     ; 648 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2298                     ; 649 {
2299                     	switch	.text
2300  028e               f_CLK_GetFlagStatus:
2302  028e 89            	pushw	x
2303  028f 5203          	subw	sp,#3
2304       00000003      OFST:	set	3
2307                     ; 651     uint16_t statusreg = 0;
2309                     ; 652     uint8_t tmpreg = 0;
2311                     ; 653     FlagStatus bitstatus = RESET;
2313                     ; 656     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2315                     ; 659     statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2317  0291 01            	rrwa	x,a
2318  0292 4f            	clr	a
2319  0293 02            	rlwa	x,a
2320  0294 1f01          	ldw	(OFST-2,sp),x
2322                     ; 662     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2324  0296 a30100        	cpw	x,#256
2325  0299 2605          	jrne	L1221
2326                     ; 664         tmpreg = CLK->ICKR;
2328  029b c650c0        	ld	a,20672
2330  029e 2021          	jra	L3221
2331  02a0               L1221:
2332                     ; 666     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2334  02a0 a30200        	cpw	x,#512
2335  02a3 2605          	jrne	L5221
2336                     ; 668         tmpreg = CLK->ECKR;
2338  02a5 c650c1        	ld	a,20673
2340  02a8 2017          	jra	L3221
2341  02aa               L5221:
2342                     ; 670     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2344  02aa a30300        	cpw	x,#768
2345  02ad 2605          	jrne	L1321
2346                     ; 672         tmpreg = CLK->SWCR;
2348  02af c650c5        	ld	a,20677
2350  02b2 200d          	jra	L3221
2351  02b4               L1321:
2352                     ; 674     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2354  02b4 a30400        	cpw	x,#1024
2355  02b7 2605          	jrne	L5321
2356                     ; 676         tmpreg = CLK->CSSR;
2358  02b9 c650c8        	ld	a,20680
2360  02bc 2003          	jra	L3221
2361  02be               L5321:
2362                     ; 680         tmpreg = CLK->CCOR;
2364  02be c650c9        	ld	a,20681
2365  02c1               L3221:
2366  02c1 6b03          	ld	(OFST+0,sp),a
2368                     ; 683     if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2370  02c3 7b05          	ld	a,(OFST+2,sp)
2371  02c5 1503          	bcp	a,(OFST+0,sp)
2372  02c7 2704          	jreq	L1421
2373                     ; 685         bitstatus = SET;
2375  02c9 a601          	ld	a,#1
2378  02cb 2001          	jra	L3421
2379  02cd               L1421:
2380                     ; 689         bitstatus = RESET;
2382  02cd 4f            	clr	a
2384  02ce               L3421:
2385                     ; 693     return((FlagStatus)bitstatus);
2389  02ce 5b05          	addw	sp,#5
2390  02d0 87            	retf	
2435                     ; 703 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
2435                     ; 704 {
2436                     	switch	.text
2437  02d1               f_CLK_GetITStatus:
2439  02d1 88            	push	a
2440  02d2 88            	push	a
2441       00000001      OFST:	set	1
2444                     ; 706     ITStatus bitstatus = RESET;
2446                     ; 709     assert_param(IS_CLK_IT_OK(CLK_IT));
2448                     ; 711     if (CLK_IT == CLK_IT_SWIF)
2450  02d3 a11c          	cp	a,#28
2451  02d5 2609          	jrne	L7621
2452                     ; 714         if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2454  02d7 c450c5        	and	a,20677
2455  02da a10c          	cp	a,#12
2456  02dc 260f          	jrne	L7721
2457                     ; 716             bitstatus = SET;
2459  02de 2009          	jpf	LC006
2460                     ; 720             bitstatus = RESET;
2461  02e0               L7621:
2462                     ; 726         if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2464  02e0 c650c8        	ld	a,20680
2465  02e3 1402          	and	a,(OFST+1,sp)
2466  02e5 a10c          	cp	a,#12
2467  02e7 2604          	jrne	L7721
2468                     ; 728             bitstatus = SET;
2470  02e9               LC006:
2472  02e9 a601          	ld	a,#1
2475  02eb 2001          	jra	L5721
2476  02ed               L7721:
2477                     ; 732             bitstatus = RESET;
2480  02ed 4f            	clr	a
2482  02ee               L5721:
2483                     ; 737     return bitstatus;
2487  02ee 85            	popw	x
2488  02ef 87            	retf	
2523                     ; 747 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
2523                     ; 748 {
2524                     	switch	.text
2525  02f0               f_CLK_ClearITPendingBit:
2529                     ; 751     assert_param(IS_CLK_IT_OK(CLK_IT));
2531                     ; 753     if (CLK_IT == (uint8_t)CLK_IT_CSSD)
2533  02f0 a10c          	cp	a,#12
2534  02f2 2605          	jrne	L1231
2535                     ; 756         CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
2537  02f4 721750c8      	bres	20680,#3
2540  02f8 87            	retf	
2541  02f9               L1231:
2542                     ; 761         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
2544  02f9 721750c5      	bres	20677,#3
2545                     ; 764 }
2548  02fd 87            	retf	
2582                     	xdef	_CLKPrescTable
2583                     	xdef	_HSIDivFactor
2584                     	xdef	f_CLK_ClearITPendingBit
2585                     	xdef	f_CLK_GetITStatus
2586                     	xdef	f_CLK_GetFlagStatus
2587                     	xdef	f_CLK_GetSYSCLKSource
2588                     	xdef	f_CLK_GetClockFreq
2589                     	xdef	f_CLK_AdjustHSICalibrationValue
2590                     	xdef	f_CLK_SYSCLKEmergencyClear
2591                     	xdef	f_CLK_ClockSecuritySystemEnable
2592                     	xdef	f_CLK_SWIMConfig
2593                     	xdef	f_CLK_SYSCLKConfig
2594                     	xdef	f_CLK_ITConfig
2595                     	xdef	f_CLK_CCOConfig
2596                     	xdef	f_CLK_HSIPrescalerConfig
2597                     	xdef	f_CLK_ClockSwitchConfig
2598                     	xdef	f_CLK_PeripheralClockConfig
2599                     	xdef	f_CLK_SlowActiveHaltWakeUpCmd
2600                     	xdef	f_CLK_FastHaltWakeUpCmd
2601                     	xdef	f_CLK_ClockSwitchCmd
2602                     	xdef	f_CLK_CCOCmd
2603                     	xdef	f_CLK_LSICmd
2604                     	xdef	f_CLK_HSICmd
2605                     	xdef	f_CLK_HSECmd
2606                     	xdef	f_CLK_DeInit
2607                     	xref.b	c_lreg
2608                     	xref.b	c_x
2627                     	xref	d_ltor
2628                     	xref	d_ludv
2629                     	xref	d_rtol
2630                     	end
