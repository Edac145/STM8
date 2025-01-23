   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  42                     ; 54 void ADC2_DeInit(void)
  42                     ; 55 {
  43                     	switch	.text
  44  0000               f_ADC2_DeInit:
  48                     ; 56   ADC2->CSR  = ADC2_CSR_RESET_VALUE;
  50  0000 725f5400      	clr	21504
  51                     ; 57   ADC2->CR1  = ADC2_CR1_RESET_VALUE;
  53  0004 725f5401      	clr	21505
  54                     ; 58   ADC2->CR2  = ADC2_CR2_RESET_VALUE;
  56  0008 725f5402      	clr	21506
  57                     ; 59   ADC2->TDRH = ADC2_TDRH_RESET_VALUE;
  59  000c 725f5406      	clr	21510
  60                     ; 60   ADC2->TDRL = ADC2_TDRL_RESET_VALUE;
  62  0010 725f5407      	clr	21511
  63                     ; 61 }
  66  0014 87            	retf
 591                     ; 83 void ADC2_Init(ADC2_ConvMode_TypeDef ADC2_ConversionMode, ADC2_Channel_TypeDef ADC2_Channel, ADC2_PresSel_TypeDef ADC2_PrescalerSelection, ADC2_ExtTrig_TypeDef ADC2_ExtTrigger, FunctionalState ADC2_ExtTriggerState, ADC2_Align_TypeDef ADC2_Align, ADC2_SchmittTrigg_TypeDef ADC2_SchmittTriggerChannel, FunctionalState ADC2_SchmittTriggerState)
 591                     ; 84 {
 592                     	switch	.text
 593  0015               f_ADC2_Init:
 595  0015 89            	pushw	x
 596       00000000      OFST:	set	0
 599                     ; 86   assert_param(IS_ADC2_CONVERSIONMODE_OK(ADC2_ConversionMode));
 601                     ; 87   assert_param(IS_ADC2_CHANNEL_OK(ADC2_Channel));
 603                     ; 88   assert_param(IS_ADC2_PRESSEL_OK(ADC2_PrescalerSelection));
 605                     ; 89   assert_param(IS_ADC2_EXTTRIG_OK(ADC2_ExtTrigger));
 607                     ; 90   assert_param(IS_FUNCTIONALSTATE_OK(((ADC2_ExtTriggerState))));
 609                     ; 91   assert_param(IS_ADC2_ALIGN_OK(ADC2_Align));
 611                     ; 92   assert_param(IS_ADC2_SCHMITTTRIG_OK(ADC2_SchmittTriggerChannel));
 613                     ; 93   assert_param(IS_FUNCTIONALSTATE_OK(ADC2_SchmittTriggerState));
 615                     ; 98   ADC2_ConversionConfig(ADC2_ConversionMode, ADC2_Channel, ADC2_Align);
 617  0016 7b09          	ld	a,(OFST+9,sp)
 618  0018 88            	push	a
 619  0019 9f            	ld	a,xl
 620  001a 97            	ld	xl,a
 621  001b 7b02          	ld	a,(OFST+2,sp)
 622  001d 95            	ld	xh,a
 623  001e 8d000100      	callf	f_ADC2_ConversionConfig
 625  0022 84            	pop	a
 626                     ; 100   ADC2_PrescalerConfig(ADC2_PrescalerSelection);
 628  0023 7b06          	ld	a,(OFST+6,sp)
 629  0025 8d5f005f      	callf	f_ADC2_PrescalerConfig
 631                     ; 105   ADC2_ExternalTriggerConfig(ADC2_ExtTrigger, ADC2_ExtTriggerState);
 633  0029 7b08          	ld	a,(OFST+8,sp)
 634  002b 97            	ld	xl,a
 635  002c 7b07          	ld	a,(OFST+7,sp)
 636  002e 95            	ld	xh,a
 637  002f 8d2e012e      	callf	f_ADC2_ExternalTriggerConfig
 639                     ; 110   ADC2_SchmittTriggerConfig(ADC2_SchmittTriggerChannel, ADC2_SchmittTriggerState);
 641  0033 7b0b          	ld	a,(OFST+11,sp)
 642  0035 97            	ld	xl,a
 643  0036 7b0a          	ld	a,(OFST+10,sp)
 644  0038 95            	ld	xh,a
 645  0039 8d720072      	callf	f_ADC2_SchmittTriggerConfig
 647                     ; 113   ADC2->CR1 |= ADC2_CR1_ADON;
 649  003d 72105401      	bset	21505,#0
 650                     ; 114 }
 653  0041 85            	popw	x
 654  0042 87            	retf
 688                     ; 121 void ADC2_Cmd(FunctionalState NewState)
 688                     ; 122 {
 689                     	switch	.text
 690  0043               f_ADC2_Cmd:
 694                     ; 124   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 696                     ; 126   if (NewState != DISABLE)
 698  0043 4d            	tnz	a
 699  0044 2706          	jreq	L703
 700                     ; 128     ADC2->CR1 |= ADC2_CR1_ADON;
 702  0046 72105401      	bset	21505,#0
 704  004a 2004          	jra	L113
 705  004c               L703:
 706                     ; 132     ADC2->CR1 &= (uint8_t)(~ADC2_CR1_ADON);
 708  004c 72115401      	bres	21505,#0
 709  0050               L113:
 710                     ; 134 }
 713  0050 87            	retf
 747                     ; 141 void ADC2_ITConfig(FunctionalState NewState)
 747                     ; 142 {
 748                     	switch	.text
 749  0051               f_ADC2_ITConfig:
 753                     ; 144   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 755                     ; 146   if (NewState != DISABLE)
 757  0051 4d            	tnz	a
 758  0052 2706          	jreq	L133
 759                     ; 149     ADC2->CSR |= (uint8_t)ADC2_CSR_EOCIE;
 761  0054 721a5400      	bset	21504,#5
 763  0058 2004          	jra	L333
 764  005a               L133:
 765                     ; 154     ADC2->CSR &= (uint8_t)(~ADC2_CSR_EOCIE);
 767  005a 721b5400      	bres	21504,#5
 768  005e               L333:
 769                     ; 156 }
 772  005e 87            	retf
 807                     ; 164 void ADC2_PrescalerConfig(ADC2_PresSel_TypeDef ADC2_Prescaler)
 807                     ; 165 {
 808                     	switch	.text
 809  005f               f_ADC2_PrescalerConfig:
 811  005f 88            	push	a
 812       00000000      OFST:	set	0
 815                     ; 167   assert_param(IS_ADC2_PRESSEL_OK(ADC2_Prescaler));
 817                     ; 170   ADC2->CR1 &= (uint8_t)(~ADC2_CR1_SPSEL);
 819  0060 c65401        	ld	a,21505
 820  0063 a48f          	and	a,#143
 821  0065 c75401        	ld	21505,a
 822                     ; 172   ADC2->CR1 |= (uint8_t)(ADC2_Prescaler);
 824  0068 c65401        	ld	a,21505
 825  006b 1a01          	or	a,(OFST+1,sp)
 826  006d c75401        	ld	21505,a
 827                     ; 173 }
 830  0070 84            	pop	a
 831  0071 87            	retf
 877                     ; 183 void ADC2_SchmittTriggerConfig(ADC2_SchmittTrigg_TypeDef ADC2_SchmittTriggerChannel, FunctionalState NewState)
 877                     ; 184 {
 878                     	switch	.text
 879  0072               f_ADC2_SchmittTriggerConfig:
 881  0072 89            	pushw	x
 882       00000000      OFST:	set	0
 885                     ; 186   assert_param(IS_ADC2_SCHMITTTRIG_OK(ADC2_SchmittTriggerChannel));
 887                     ; 187   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 889                     ; 189   if (ADC2_SchmittTriggerChannel == ADC2_SCHMITTTRIG_ALL)
 891  0073 9e            	ld	a,xh
 892  0074 a11f          	cp	a,#31
 893  0076 2620          	jrne	L573
 894                     ; 191     if (NewState != DISABLE)
 896  0078 9f            	ld	a,xl
 897  0079 4d            	tnz	a
 898  007a 270a          	jreq	L773
 899                     ; 193       ADC2->TDRL &= (uint8_t)0x0;
 901  007c 725f5407      	clr	21511
 902                     ; 194       ADC2->TDRH &= (uint8_t)0x0;
 904  0080 725f5406      	clr	21510
 906  0084 2078          	jra	L304
 907  0086               L773:
 908                     ; 198       ADC2->TDRL |= (uint8_t)0xFF;
 910  0086 c65407        	ld	a,21511
 911  0089 aaff          	or	a,#255
 912  008b c75407        	ld	21511,a
 913                     ; 199       ADC2->TDRH |= (uint8_t)0xFF;
 915  008e c65406        	ld	a,21510
 916  0091 aaff          	or	a,#255
 917  0093 c75406        	ld	21510,a
 918  0096 2066          	jra	L304
 919  0098               L573:
 920                     ; 202   else if (ADC2_SchmittTriggerChannel < ADC2_SCHMITTTRIG_CHANNEL8)
 922  0098 7b01          	ld	a,(OFST+1,sp)
 923  009a a108          	cp	a,#8
 924  009c 242f          	jruge	L504
 925                     ; 204     if (NewState != DISABLE)
 927  009e 0d02          	tnz	(OFST+2,sp)
 928  00a0 2716          	jreq	L704
 929                     ; 206       ADC2->TDRL &= (uint8_t)(~(uint8_t)((uint8_t)0x01 << (uint8_t)ADC2_SchmittTriggerChannel));
 931  00a2 7b01          	ld	a,(OFST+1,sp)
 932  00a4 5f            	clrw	x
 933  00a5 97            	ld	xl,a
 934  00a6 a601          	ld	a,#1
 935  00a8 5d            	tnzw	x
 936  00a9 2704          	jreq	L02
 937  00ab               L22:
 938  00ab 48            	sll	a
 939  00ac 5a            	decw	x
 940  00ad 26fc          	jrne	L22
 941  00af               L02:
 942  00af 43            	cpl	a
 943  00b0 c45407        	and	a,21511
 944  00b3 c75407        	ld	21511,a
 946  00b6 2046          	jra	L304
 947  00b8               L704:
 948                     ; 210       ADC2->TDRL |= (uint8_t)((uint8_t)0x01 << (uint8_t)ADC2_SchmittTriggerChannel);
 950  00b8 7b01          	ld	a,(OFST+1,sp)
 951  00ba 5f            	clrw	x
 952  00bb 97            	ld	xl,a
 953  00bc a601          	ld	a,#1
 954  00be 5d            	tnzw	x
 955  00bf 2704          	jreq	L42
 956  00c1               L62:
 957  00c1 48            	sll	a
 958  00c2 5a            	decw	x
 959  00c3 26fc          	jrne	L62
 960  00c5               L42:
 961  00c5 ca5407        	or	a,21511
 962  00c8 c75407        	ld	21511,a
 963  00cb 2031          	jra	L304
 964  00cd               L504:
 965                     ; 215     if (NewState != DISABLE)
 967  00cd 0d02          	tnz	(OFST+2,sp)
 968  00cf 2718          	jreq	L514
 969                     ; 217       ADC2->TDRH &= (uint8_t)(~(uint8_t)((uint8_t)0x01 << ((uint8_t)ADC2_SchmittTriggerChannel - (uint8_t)8)));
 971  00d1 7b01          	ld	a,(OFST+1,sp)
 972  00d3 a008          	sub	a,#8
 973  00d5 5f            	clrw	x
 974  00d6 97            	ld	xl,a
 975  00d7 a601          	ld	a,#1
 976  00d9 5d            	tnzw	x
 977  00da 2704          	jreq	L03
 978  00dc               L23:
 979  00dc 48            	sll	a
 980  00dd 5a            	decw	x
 981  00de 26fc          	jrne	L23
 982  00e0               L03:
 983  00e0 43            	cpl	a
 984  00e1 c45406        	and	a,21510
 985  00e4 c75406        	ld	21510,a
 987  00e7 2015          	jra	L304
 988  00e9               L514:
 989                     ; 221       ADC2->TDRH |= (uint8_t)((uint8_t)0x01 << ((uint8_t)ADC2_SchmittTriggerChannel - (uint8_t)8));
 991  00e9 7b01          	ld	a,(OFST+1,sp)
 992  00eb a008          	sub	a,#8
 993  00ed 5f            	clrw	x
 994  00ee 97            	ld	xl,a
 995  00ef a601          	ld	a,#1
 996  00f1 5d            	tnzw	x
 997  00f2 2704          	jreq	L43
 998  00f4               L63:
 999  00f4 48            	sll	a
1000  00f5 5a            	decw	x
1001  00f6 26fc          	jrne	L63
1002  00f8               L43:
1003  00f8 ca5406        	or	a,21510
1004  00fb c75406        	ld	21510,a
1005  00fe               L304:
1006                     ; 224 }
1009  00fe 85            	popw	x
1010  00ff 87            	retf
1066                     ; 236 void ADC2_ConversionConfig(ADC2_ConvMode_TypeDef ADC2_ConversionMode, ADC2_Channel_TypeDef ADC2_Channel, ADC2_Align_TypeDef ADC2_Align)
1066                     ; 237 {
1067                     	switch	.text
1068  0100               f_ADC2_ConversionConfig:
1070  0100 89            	pushw	x
1071       00000000      OFST:	set	0
1074                     ; 239   assert_param(IS_ADC2_CONVERSIONMODE_OK(ADC2_ConversionMode));
1076                     ; 240   assert_param(IS_ADC2_CHANNEL_OK(ADC2_Channel));
1078                     ; 241   assert_param(IS_ADC2_ALIGN_OK(ADC2_Align));
1080                     ; 244   ADC2->CR2 &= (uint8_t)(~ADC2_CR2_ALIGN);
1082  0101 72175402      	bres	21506,#3
1083                     ; 246   ADC2->CR2 |= (uint8_t)(ADC2_Align);
1085  0105 c65402        	ld	a,21506
1086  0108 1a06          	or	a,(OFST+6,sp)
1087  010a c75402        	ld	21506,a
1088                     ; 248   if (ADC2_ConversionMode == ADC2_CONVERSIONMODE_CONTINUOUS)
1090  010d 9e            	ld	a,xh
1091  010e a101          	cp	a,#1
1092  0110 2606          	jrne	L744
1093                     ; 251     ADC2->CR1 |= ADC2_CR1_CONT;
1095  0112 72125401      	bset	21505,#1
1097  0116 2004          	jra	L154
1098  0118               L744:
1099                     ; 256     ADC2->CR1 &= (uint8_t)(~ADC2_CR1_CONT);
1101  0118 72135401      	bres	21505,#1
1102  011c               L154:
1103                     ; 260   ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH);
1105  011c c65400        	ld	a,21504
1106  011f a4f0          	and	a,#240
1107  0121 c75400        	ld	21504,a
1108                     ; 262   ADC2->CSR |= (uint8_t)(ADC2_Channel);
1110  0124 c65400        	ld	a,21504
1111  0127 1a02          	or	a,(OFST+2,sp)
1112  0129 c75400        	ld	21504,a
1113                     ; 263 }
1116  012c 85            	popw	x
1117  012d 87            	retf
1162                     ; 275 void ADC2_ExternalTriggerConfig(ADC2_ExtTrig_TypeDef ADC2_ExtTrigger, FunctionalState NewState)
1162                     ; 276 {
1163                     	switch	.text
1164  012e               f_ADC2_ExternalTriggerConfig:
1166  012e 89            	pushw	x
1167       00000000      OFST:	set	0
1170                     ; 278   assert_param(IS_ADC2_EXTTRIG_OK(ADC2_ExtTrigger));
1172                     ; 279   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1174                     ; 282   ADC2->CR2 &= (uint8_t)(~ADC2_CR2_EXTSEL);
1176  012f c65402        	ld	a,21506
1177  0132 a4cf          	and	a,#207
1178  0134 c75402        	ld	21506,a
1179                     ; 284   if (NewState != DISABLE)
1181  0137 9f            	ld	a,xl
1182  0138 4d            	tnz	a
1183  0139 2706          	jreq	L574
1184                     ; 287     ADC2->CR2 |= (uint8_t)(ADC2_CR2_EXTTRIG);
1186  013b 721c5402      	bset	21506,#6
1188  013f 2004          	jra	L774
1189  0141               L574:
1190                     ; 292     ADC2->CR2 &= (uint8_t)(~ADC2_CR2_EXTTRIG);
1192  0141 721d5402      	bres	21506,#6
1193  0145               L774:
1194                     ; 296   ADC2->CR2 |= (uint8_t)(ADC2_ExtTrigger);
1196  0145 c65402        	ld	a,21506
1197  0148 1a01          	or	a,(OFST+1,sp)
1198  014a c75402        	ld	21506,a
1199                     ; 297 }
1202  014d 85            	popw	x
1203  014e 87            	retf
1226                     ; 308 void ADC2_StartConversion(void)
1226                     ; 309 {
1227                     	switch	.text
1228  014f               f_ADC2_StartConversion:
1232                     ; 310   ADC2->CR1 |= ADC2_CR1_ADON;
1234  014f 72105401      	bset	21505,#0
1235                     ; 311 }
1238  0153 87            	retf
1281                     ; 320 uint16_t ADC2_GetConversionValue(void)
1281                     ; 321 {
1282                     	switch	.text
1283  0154               f_ADC2_GetConversionValue:
1285  0154 5205          	subw	sp,#5
1286       00000005      OFST:	set	5
1289                     ; 322   uint16_t temph = 0;
1291                     ; 323   uint8_t templ = 0;
1293                     ; 325   if ((ADC2->CR2 & ADC2_CR2_ALIGN) != 0) /* Right alignment */
1295  0156 c65402        	ld	a,21506
1296  0159 a508          	bcp	a,#8
1297  015b 2715          	jreq	L335
1298                     ; 328     templ = ADC2->DRL;
1300  015d c65405        	ld	a,21509
1301  0160 6b03          	ld	(OFST-2,sp),a
1303                     ; 330     temph = ADC2->DRH;
1305  0162 c65404        	ld	a,21508
1306  0165 5f            	clrw	x
1307  0166 97            	ld	xl,a
1308  0167 1f04          	ldw	(OFST-1,sp),x
1310                     ; 332     temph = (uint16_t)(templ | (uint16_t)(temph << (uint8_t)8));
1312  0169 1e04          	ldw	x,(OFST-1,sp)
1313  016b 7b03          	ld	a,(OFST-2,sp)
1314  016d 02            	rlwa	x,a
1315  016e 1f04          	ldw	(OFST-1,sp),x
1318  0170 2021          	jra	L535
1319  0172               L335:
1320                     ; 337     temph = ADC2->DRH;
1322  0172 c65404        	ld	a,21508
1323  0175 5f            	clrw	x
1324  0176 97            	ld	xl,a
1325  0177 1f04          	ldw	(OFST-1,sp),x
1327                     ; 339     templ = ADC2->DRL;
1329  0179 c65405        	ld	a,21509
1330  017c 6b03          	ld	(OFST-2,sp),a
1332                     ; 341     temph = (uint16_t)((uint16_t)((uint16_t)templ << 6) | (uint16_t)((uint16_t)temph << 8));
1334  017e 1e04          	ldw	x,(OFST-1,sp)
1335  0180 4f            	clr	a
1336  0181 02            	rlwa	x,a
1337  0182 1f01          	ldw	(OFST-4,sp),x
1339  0184 7b03          	ld	a,(OFST-2,sp)
1340  0186 97            	ld	xl,a
1341  0187 a640          	ld	a,#64
1342  0189 42            	mul	x,a
1343  018a 01            	rrwa	x,a
1344  018b 1a02          	or	a,(OFST-3,sp)
1345  018d 01            	rrwa	x,a
1346  018e 1a01          	or	a,(OFST-4,sp)
1347  0190 01            	rrwa	x,a
1348  0191 1f04          	ldw	(OFST-1,sp),x
1350  0193               L535:
1351                     ; 344   return ((uint16_t)temph);
1353  0193 1e04          	ldw	x,(OFST-1,sp)
1356  0195 5b05          	addw	sp,#5
1357  0197 87            	retf
1400                     ; 352 FlagStatus ADC2_GetFlagStatus(void)
1400                     ; 353 {
1401                     	switch	.text
1402  0198               f_ADC2_GetFlagStatus:
1406                     ; 355   return (FlagStatus)(ADC2->CSR & ADC2_CSR_EOC);
1408  0198 c65400        	ld	a,21504
1409  019b a480          	and	a,#128
1412  019d 87            	retf
1434                     ; 363 void ADC2_ClearFlag(void)
1434                     ; 364 {
1435                     	switch	.text
1436  019e               f_ADC2_ClearFlag:
1440                     ; 365   ADC2->CSR &= (uint8_t)(~ADC2_CSR_EOC);
1442  019e 721f5400      	bres	21504,#7
1443                     ; 366 }
1446  01a2 87            	retf
1469                     ; 374 ITStatus ADC2_GetITStatus(void)
1469                     ; 375 {
1470                     	switch	.text
1471  01a3               f_ADC2_GetITStatus:
1475                     ; 376   return (ITStatus)(ADC2->CSR & ADC2_CSR_EOC);
1477  01a3 c65400        	ld	a,21504
1478  01a6 a480          	and	a,#128
1481  01a8 87            	retf
1504                     ; 384 void ADC2_ClearITPendingBit(void)
1504                     ; 385 {
1505                     	switch	.text
1506  01a9               f_ADC2_ClearITPendingBit:
1510                     ; 386   ADC2->CSR &= (uint8_t)(~ADC2_CSR_EOC);
1512  01a9 721f5400      	bres	21504,#7
1513                     ; 387 }
1516  01ad 87            	retf
1528                     	xdef	f_ADC2_ClearITPendingBit
1529                     	xdef	f_ADC2_GetITStatus
1530                     	xdef	f_ADC2_ClearFlag
1531                     	xdef	f_ADC2_GetFlagStatus
1532                     	xdef	f_ADC2_GetConversionValue
1533                     	xdef	f_ADC2_StartConversion
1534                     	xdef	f_ADC2_ExternalTriggerConfig
1535                     	xdef	f_ADC2_ConversionConfig
1536                     	xdef	f_ADC2_SchmittTriggerConfig
1537                     	xdef	f_ADC2_PrescalerConfig
1538                     	xdef	f_ADC2_ITConfig
1539                     	xdef	f_ADC2_Cmd
1540                     	xdef	f_ADC2_Init
1541                     	xdef	f_ADC2_DeInit
1560                     	end
