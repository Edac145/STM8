   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  45                     ; 54 void ADC2_DeInit(void)
  45                     ; 55 {
  46                     	switch	.text
  47  0000               f_ADC2_DeInit:
  51                     ; 56   ADC2->CSR  = ADC2_CSR_RESET_VALUE;
  53  0000 725f5400      	clr	21504
  54                     ; 57   ADC2->CR1  = ADC2_CR1_RESET_VALUE;
  56  0004 725f5401      	clr	21505
  57                     ; 58   ADC2->CR2  = ADC2_CR2_RESET_VALUE;
  59  0008 725f5402      	clr	21506
  60                     ; 59   ADC2->TDRH = ADC2_TDRH_RESET_VALUE;
  62  000c 725f5406      	clr	21510
  63                     ; 60   ADC2->TDRL = ADC2_TDRL_RESET_VALUE;
  65  0010 725f5407      	clr	21511
  66                     ; 61 }
  69  0014 87            	retf	
 594                     ; 83 void ADC2_Init(ADC2_ConvMode_TypeDef ADC2_ConversionMode, ADC2_Channel_TypeDef ADC2_Channel, ADC2_PresSel_TypeDef ADC2_PrescalerSelection, ADC2_ExtTrig_TypeDef ADC2_ExtTrigger, FunctionalState ADC2_ExtTriggerState, ADC2_Align_TypeDef ADC2_Align, ADC2_SchmittTrigg_TypeDef ADC2_SchmittTriggerChannel, FunctionalState ADC2_SchmittTriggerState)
 594                     ; 84 {
 595                     	switch	.text
 596  0015               f_ADC2_Init:
 598  0015 89            	pushw	x
 599       00000000      OFST:	set	0
 602                     ; 86   assert_param(IS_ADC2_CONVERSIONMODE_OK(ADC2_ConversionMode));
 604                     ; 87   assert_param(IS_ADC2_CHANNEL_OK(ADC2_Channel));
 606                     ; 88   assert_param(IS_ADC2_PRESSEL_OK(ADC2_PrescalerSelection));
 608                     ; 89   assert_param(IS_ADC2_EXTTRIG_OK(ADC2_ExtTrigger));
 610                     ; 90   assert_param(IS_FUNCTIONALSTATE_OK(((ADC2_ExtTriggerState))));
 612                     ; 91   assert_param(IS_ADC2_ALIGN_OK(ADC2_Align));
 614                     ; 92   assert_param(IS_ADC2_SCHMITTTRIG_OK(ADC2_SchmittTriggerChannel));
 616                     ; 93   assert_param(IS_FUNCTIONALSTATE_OK(ADC2_SchmittTriggerState));
 618                     ; 98   ADC2_ConversionConfig(ADC2_ConversionMode, ADC2_Channel, ADC2_Align);
 620  0016 7b09          	ld	a,(OFST+9,sp)
 621  0018 88            	push	a
 622  0019 7b02          	ld	a,(OFST+2,sp)
 623  001b 95            	ld	xh,a
 624  001c 8de900e9      	callf	f_ADC2_ConversionConfig
 626  0020 84            	pop	a
 627                     ; 100   ADC2_PrescalerConfig(ADC2_PrescalerSelection);
 629  0021 7b06          	ld	a,(OFST+6,sp)
 630  0023 8d5b005b      	callf	f_ADC2_PrescalerConfig
 632                     ; 105   ADC2_ExternalTriggerConfig(ADC2_ExtTrigger, ADC2_ExtTriggerState);
 634  0027 7b08          	ld	a,(OFST+8,sp)
 635  0029 97            	ld	xl,a
 636  002a 7b07          	ld	a,(OFST+7,sp)
 637  002c 95            	ld	xh,a
 638  002d 8d160116      	callf	f_ADC2_ExternalTriggerConfig
 640                     ; 110   ADC2_SchmittTriggerConfig(ADC2_SchmittTriggerChannel, ADC2_SchmittTriggerState);
 642  0031 7b0b          	ld	a,(OFST+11,sp)
 643  0033 97            	ld	xl,a
 644  0034 7b0a          	ld	a,(OFST+10,sp)
 645  0036 95            	ld	xh,a
 646  0037 8d6e006e      	callf	f_ADC2_SchmittTriggerConfig
 648                     ; 113   ADC2->CR1 |= ADC2_CR1_ADON;
 650  003b 72105401      	bset	21505,#0
 651                     ; 114 }
 654  003f 85            	popw	x
 655  0040 87            	retf	
 689                     ; 121 void ADC2_Cmd(FunctionalState NewState)
 689                     ; 122 {
 690                     	switch	.text
 691  0041               f_ADC2_Cmd:
 695                     ; 124   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 697                     ; 126   if (NewState != DISABLE)
 699  0041 4d            	tnz	a
 700  0042 2705          	jreq	L703
 701                     ; 128     ADC2->CR1 |= ADC2_CR1_ADON;
 703  0044 72105401      	bset	21505,#0
 706  0048 87            	retf	
 707  0049               L703:
 708                     ; 132     ADC2->CR1 &= (uint8_t)(~ADC2_CR1_ADON);
 710  0049 72115401      	bres	21505,#0
 711                     ; 134 }
 714  004d 87            	retf	
 748                     ; 141 void ADC2_ITConfig(FunctionalState NewState)
 748                     ; 142 {
 749                     	switch	.text
 750  004e               f_ADC2_ITConfig:
 754                     ; 144   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 756                     ; 146   if (NewState != DISABLE)
 758  004e 4d            	tnz	a
 759  004f 2705          	jreq	L133
 760                     ; 149     ADC2->CSR |= (uint8_t)ADC2_CSR_EOCIE;
 762  0051 721a5400      	bset	21504,#5
 765  0055 87            	retf	
 766  0056               L133:
 767                     ; 154     ADC2->CSR &= (uint8_t)(~ADC2_CSR_EOCIE);
 769  0056 721b5400      	bres	21504,#5
 770                     ; 156 }
 773  005a 87            	retf	
 808                     ; 164 void ADC2_PrescalerConfig(ADC2_PresSel_TypeDef ADC2_Prescaler)
 808                     ; 165 {
 809                     	switch	.text
 810  005b               f_ADC2_PrescalerConfig:
 812  005b 88            	push	a
 813       00000000      OFST:	set	0
 816                     ; 167   assert_param(IS_ADC2_PRESSEL_OK(ADC2_Prescaler));
 818                     ; 170   ADC2->CR1 &= (uint8_t)(~ADC2_CR1_SPSEL);
 820  005c c65401        	ld	a,21505
 821  005f a48f          	and	a,#143
 822  0061 c75401        	ld	21505,a
 823                     ; 172   ADC2->CR1 |= (uint8_t)(ADC2_Prescaler);
 825  0064 c65401        	ld	a,21505
 826  0067 1a01          	or	a,(OFST+1,sp)
 827  0069 c75401        	ld	21505,a
 828                     ; 173 }
 831  006c 84            	pop	a
 832  006d 87            	retf	
 878                     ; 183 void ADC2_SchmittTriggerConfig(ADC2_SchmittTrigg_TypeDef ADC2_SchmittTriggerChannel, FunctionalState NewState)
 878                     ; 184 {
 879                     	switch	.text
 880  006e               f_ADC2_SchmittTriggerConfig:
 882  006e 89            	pushw	x
 883       00000000      OFST:	set	0
 886                     ; 186   assert_param(IS_ADC2_SCHMITTTRIG_OK(ADC2_SchmittTriggerChannel));
 888                     ; 187   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 890                     ; 189   if (ADC2_SchmittTriggerChannel == ADC2_SCHMITTTRIG_ALL)
 892  006f 9e            	ld	a,xh
 893  0070 a11f          	cp	a,#31
 894  0072 261d          	jrne	L573
 895                     ; 191     if (NewState != DISABLE)
 897  0074 9f            	ld	a,xl
 898  0075 4d            	tnz	a
 899  0076 270a          	jreq	L773
 900                     ; 193       ADC2->TDRL &= (uint8_t)0x0;
 902  0078 725f5407      	clr	21511
 903                     ; 194       ADC2->TDRH &= (uint8_t)0x0;
 905  007c 725f5406      	clr	21510
 907  0080 2065          	jra	L304
 908  0082               L773:
 909                     ; 198       ADC2->TDRL |= (uint8_t)0xFF;
 911  0082 c65407        	ld	a,21511
 912  0085 aaff          	or	a,#255
 913  0087 c75407        	ld	21511,a
 914                     ; 199       ADC2->TDRH |= (uint8_t)0xFF;
 916  008a c65406        	ld	a,21510
 917  008d aaff          	or	a,#255
 918  008f 2053          	jpf	LC001
 919  0091               L573:
 920                     ; 202   else if (ADC2_SchmittTriggerChannel < ADC2_SCHMITTTRIG_CHANNEL8)
 922  0091 7b01          	ld	a,(OFST+1,sp)
 923  0093 a108          	cp	a,#8
 924  0095 0d02          	tnz	(OFST+2,sp)
 925  0097 2426          	jruge	L504
 926                     ; 204     if (NewState != DISABLE)
 928  0099 2714          	jreq	L704
 929                     ; 206       ADC2->TDRL &= (uint8_t)(~(uint8_t)((uint8_t)0x01 << (uint8_t)ADC2_SchmittTriggerChannel));
 931  009b 5f            	clrw	x
 932  009c 97            	ld	xl,a
 933  009d a601          	ld	a,#1
 934  009f 5d            	tnzw	x
 935  00a0 2704          	jreq	L03
 936  00a2               L23:
 937  00a2 48            	sll	a
 938  00a3 5a            	decw	x
 939  00a4 26fc          	jrne	L23
 940  00a6               L03:
 941  00a6 43            	cpl	a
 942  00a7 c45407        	and	a,21511
 943  00aa               LC002:
 944  00aa c75407        	ld	21511,a
 946  00ad 2038          	jra	L304
 947  00af               L704:
 948                     ; 210       ADC2->TDRL |= (uint8_t)((uint8_t)0x01 << (uint8_t)ADC2_SchmittTriggerChannel);
 950  00af 5f            	clrw	x
 951  00b0 97            	ld	xl,a
 952  00b1 a601          	ld	a,#1
 953  00b3 5d            	tnzw	x
 954  00b4 2704          	jreq	L43
 955  00b6               L63:
 956  00b6 48            	sll	a
 957  00b7 5a            	decw	x
 958  00b8 26fc          	jrne	L63
 959  00ba               L43:
 960  00ba ca5407        	or	a,21511
 961  00bd 20eb          	jpf	LC002
 962  00bf               L504:
 963                     ; 215     if (NewState != DISABLE)
 965  00bf 2713          	jreq	L514
 966                     ; 217       ADC2->TDRH &= (uint8_t)(~(uint8_t)((uint8_t)0x01 << ((uint8_t)ADC2_SchmittTriggerChannel - (uint8_t)8)));
 968  00c1 a008          	sub	a,#8
 969  00c3 5f            	clrw	x
 970  00c4 97            	ld	xl,a
 971  00c5 a601          	ld	a,#1
 972  00c7 5d            	tnzw	x
 973  00c8 2704          	jreq	L04
 974  00ca               L24:
 975  00ca 48            	sll	a
 976  00cb 5a            	decw	x
 977  00cc 26fc          	jrne	L24
 978  00ce               L04:
 979  00ce 43            	cpl	a
 980  00cf c45406        	and	a,21510
 982  00d2 2010          	jpf	LC001
 983  00d4               L514:
 984                     ; 221       ADC2->TDRH |= (uint8_t)((uint8_t)0x01 << ((uint8_t)ADC2_SchmittTriggerChannel - (uint8_t)8));
 986  00d4 a008          	sub	a,#8
 987  00d6 5f            	clrw	x
 988  00d7 97            	ld	xl,a
 989  00d8 a601          	ld	a,#1
 990  00da 5d            	tnzw	x
 991  00db 2704          	jreq	L44
 992  00dd               L64:
 993  00dd 48            	sll	a
 994  00de 5a            	decw	x
 995  00df 26fc          	jrne	L64
 996  00e1               L44:
 997  00e1 ca5406        	or	a,21510
 998  00e4               LC001:
 999  00e4 c75406        	ld	21510,a
1000  00e7               L304:
1001                     ; 224 }
1004  00e7 85            	popw	x
1005  00e8 87            	retf	
1061                     ; 236 void ADC2_ConversionConfig(ADC2_ConvMode_TypeDef ADC2_ConversionMode, ADC2_Channel_TypeDef ADC2_Channel, ADC2_Align_TypeDef ADC2_Align)
1061                     ; 237 {
1062                     	switch	.text
1063  00e9               f_ADC2_ConversionConfig:
1065  00e9 89            	pushw	x
1066       00000000      OFST:	set	0
1069                     ; 239   assert_param(IS_ADC2_CONVERSIONMODE_OK(ADC2_ConversionMode));
1071                     ; 240   assert_param(IS_ADC2_CHANNEL_OK(ADC2_Channel));
1073                     ; 241   assert_param(IS_ADC2_ALIGN_OK(ADC2_Align));
1075                     ; 244   ADC2->CR2 &= (uint8_t)(~ADC2_CR2_ALIGN);
1077  00ea 72175402      	bres	21506,#3
1078                     ; 246   ADC2->CR2 |= (uint8_t)(ADC2_Align);
1080  00ee c65402        	ld	a,21506
1081  00f1 1a06          	or	a,(OFST+6,sp)
1082  00f3 c75402        	ld	21506,a
1083                     ; 248   if (ADC2_ConversionMode == ADC2_CONVERSIONMODE_CONTINUOUS)
1085  00f6 9e            	ld	a,xh
1086  00f7 4a            	dec	a
1087  00f8 2606          	jrne	L744
1088                     ; 251     ADC2->CR1 |= ADC2_CR1_CONT;
1090  00fa 72125401      	bset	21505,#1
1092  00fe 2004          	jra	L154
1093  0100               L744:
1094                     ; 256     ADC2->CR1 &= (uint8_t)(~ADC2_CR1_CONT);
1096  0100 72135401      	bres	21505,#1
1097  0104               L154:
1098                     ; 260   ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH);
1100  0104 c65400        	ld	a,21504
1101  0107 a4f0          	and	a,#240
1102  0109 c75400        	ld	21504,a
1103                     ; 262   ADC2->CSR |= (uint8_t)(ADC2_Channel);
1105  010c c65400        	ld	a,21504
1106  010f 1a02          	or	a,(OFST+2,sp)
1107  0111 c75400        	ld	21504,a
1108                     ; 263 }
1111  0114 85            	popw	x
1112  0115 87            	retf	
1157                     ; 275 void ADC2_ExternalTriggerConfig(ADC2_ExtTrig_TypeDef ADC2_ExtTrigger, FunctionalState NewState)
1157                     ; 276 {
1158                     	switch	.text
1159  0116               f_ADC2_ExternalTriggerConfig:
1161  0116 89            	pushw	x
1162       00000000      OFST:	set	0
1165                     ; 278   assert_param(IS_ADC2_EXTTRIG_OK(ADC2_ExtTrigger));
1167                     ; 279   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1169                     ; 282   ADC2->CR2 &= (uint8_t)(~ADC2_CR2_EXTSEL);
1171  0117 c65402        	ld	a,21506
1172  011a a4cf          	and	a,#207
1173  011c c75402        	ld	21506,a
1174                     ; 284   if (NewState != DISABLE)
1176  011f 9f            	ld	a,xl
1177  0120 4d            	tnz	a
1178  0121 2706          	jreq	L574
1179                     ; 287     ADC2->CR2 |= (uint8_t)(ADC2_CR2_EXTTRIG);
1181  0123 721c5402      	bset	21506,#6
1183  0127 2004          	jra	L774
1184  0129               L574:
1185                     ; 292     ADC2->CR2 &= (uint8_t)(~ADC2_CR2_EXTTRIG);
1187  0129 721d5402      	bres	21506,#6
1188  012d               L774:
1189                     ; 296   ADC2->CR2 |= (uint8_t)(ADC2_ExtTrigger);
1191  012d c65402        	ld	a,21506
1192  0130 1a01          	or	a,(OFST+1,sp)
1193  0132 c75402        	ld	21506,a
1194                     ; 297 }
1197  0135 85            	popw	x
1198  0136 87            	retf	
1221                     ; 308 void ADC2_StartConversion(void)
1221                     ; 309 {
1222                     	switch	.text
1223  0137               f_ADC2_StartConversion:
1227                     ; 310   ADC2->CR1 |= ADC2_CR1_ADON;
1229  0137 72105401      	bset	21505,#0
1230                     ; 311 }
1233  013b 87            	retf	
1276                     ; 320 uint16_t ADC2_GetConversionValue(void)
1276                     ; 321 {
1277                     	switch	.text
1278  013c               f_ADC2_GetConversionValue:
1280  013c 5205          	subw	sp,#5
1281       00000005      OFST:	set	5
1284                     ; 322   uint16_t temph = 0;
1286                     ; 323   uint8_t templ = 0;
1288                     ; 325   if ((ADC2->CR2 & ADC2_CR2_ALIGN) != 0) /* Right alignment */
1290  013e 720754020e    	btjf	21506,#3,L335
1291                     ; 328     templ = ADC2->DRL;
1293  0143 c65405        	ld	a,21509
1294  0146 6b03          	ld	(OFST-2,sp),a
1296                     ; 330     temph = ADC2->DRH;
1298  0148 c65404        	ld	a,21508
1299  014b 97            	ld	xl,a
1301                     ; 332     temph = (uint16_t)(templ | (uint16_t)(temph << (uint8_t)8));
1303  014c 7b03          	ld	a,(OFST-2,sp)
1304  014e 02            	rlwa	x,a
1307  014f 201a          	jra	L535
1308  0151               L335:
1309                     ; 337     temph = ADC2->DRH;
1311  0151 c65404        	ld	a,21508
1312  0154 97            	ld	xl,a
1314                     ; 339     templ = ADC2->DRL;
1316  0155 c65405        	ld	a,21509
1317  0158 6b03          	ld	(OFST-2,sp),a
1319                     ; 341     temph = (uint16_t)((uint16_t)((uint16_t)templ << 6) | (uint16_t)((uint16_t)temph << 8));
1321  015a 4f            	clr	a
1322  015b 02            	rlwa	x,a
1323  015c 1f01          	ldw	(OFST-4,sp),x
1325  015e 7b03          	ld	a,(OFST-2,sp)
1326  0160 97            	ld	xl,a
1327  0161 a640          	ld	a,#64
1328  0163 42            	mul	x,a
1329  0164 01            	rrwa	x,a
1330  0165 1a02          	or	a,(OFST-3,sp)
1331  0167 01            	rrwa	x,a
1332  0168 1a01          	or	a,(OFST-4,sp)
1333  016a 01            	rrwa	x,a
1335  016b               L535:
1336                     ; 344   return ((uint16_t)temph);
1340  016b 5b05          	addw	sp,#5
1341  016d 87            	retf	
1384                     ; 352 FlagStatus ADC2_GetFlagStatus(void)
1384                     ; 353 {
1385                     	switch	.text
1386  016e               f_ADC2_GetFlagStatus:
1390                     ; 355   return (FlagStatus)(ADC2->CSR & ADC2_CSR_EOC);
1392  016e c65400        	ld	a,21504
1393  0171 a480          	and	a,#128
1396  0173 87            	retf	
1418                     ; 363 void ADC2_ClearFlag(void)
1418                     ; 364 {
1419                     	switch	.text
1420  0174               f_ADC2_ClearFlag:
1424                     ; 365   ADC2->CSR &= (uint8_t)(~ADC2_CSR_EOC);
1426  0174 721f5400      	bres	21504,#7
1427                     ; 366 }
1430  0178 87            	retf	
1453                     ; 374 ITStatus ADC2_GetITStatus(void)
1453                     ; 375 {
1454                     	switch	.text
1455  0179               f_ADC2_GetITStatus:
1459                     ; 376   return (ITStatus)(ADC2->CSR & ADC2_CSR_EOC);
1461  0179 c65400        	ld	a,21504
1462  017c a480          	and	a,#128
1465  017e 87            	retf	
1488                     ; 384 void ADC2_ClearITPendingBit(void)
1488                     ; 385 {
1489                     	switch	.text
1490  017f               f_ADC2_ClearITPendingBit:
1494                     ; 386   ADC2->CSR &= (uint8_t)(~ADC2_CSR_EOC);
1496  017f 721f5400      	bres	21504,#7
1497                     ; 387 }
1500  0183 87            	retf	
1512                     	xdef	f_ADC2_ClearITPendingBit
1513                     	xdef	f_ADC2_GetITStatus
1514                     	xdef	f_ADC2_ClearFlag
1515                     	xdef	f_ADC2_GetFlagStatus
1516                     	xdef	f_ADC2_GetConversionValue
1517                     	xdef	f_ADC2_StartConversion
1518                     	xdef	f_ADC2_ExternalTriggerConfig
1519                     	xdef	f_ADC2_ConversionConfig
1520                     	xdef	f_ADC2_SchmittTriggerConfig
1521                     	xdef	f_ADC2_PrescalerConfig
1522                     	xdef	f_ADC2_ITConfig
1523                     	xdef	f_ADC2_Cmd
1524                     	xdef	f_ADC2_Init
1525                     	xdef	f_ADC2_DeInit
1544                     	end
