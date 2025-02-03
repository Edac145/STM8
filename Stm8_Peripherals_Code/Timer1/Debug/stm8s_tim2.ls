   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  45                     ; 52 void TIM2_DeInit(void)
  45                     ; 53 {
  46                     	switch	.text
  47  0000               f_TIM2_DeInit:
  51                     ; 54   TIM2->CR1 = (uint8_t)TIM2_CR1_RESET_VALUE;
  53  0000 725f5300      	clr	21248
  54                     ; 55   TIM2->IER = (uint8_t)TIM2_IER_RESET_VALUE;
  56  0004 725f5301      	clr	21249
  57                     ; 56   TIM2->SR2 = (uint8_t)TIM2_SR2_RESET_VALUE;
  59  0008 725f5303      	clr	21251
  60                     ; 59   TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  62  000c 725f5308      	clr	21256
  63                     ; 60   TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  65  0010 725f5309      	clr	21257
  66                     ; 64   TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  68  0014 725f5308      	clr	21256
  69                     ; 65   TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  71  0018 725f5309      	clr	21257
  72                     ; 66   TIM2->CCMR1 = (uint8_t)TIM2_CCMR1_RESET_VALUE;
  74  001c 725f5305      	clr	21253
  75                     ; 67   TIM2->CCMR2 = (uint8_t)TIM2_CCMR2_RESET_VALUE;
  77  0020 725f5306      	clr	21254
  78                     ; 68   TIM2->CCMR3 = (uint8_t)TIM2_CCMR3_RESET_VALUE;
  80  0024 725f5307      	clr	21255
  81                     ; 69   TIM2->CNTRH = (uint8_t)TIM2_CNTRH_RESET_VALUE;
  83  0028 725f530a      	clr	21258
  84                     ; 70   TIM2->CNTRL = (uint8_t)TIM2_CNTRL_RESET_VALUE;
  86  002c 725f530b      	clr	21259
  87                     ; 71   TIM2->PSCR = (uint8_t)TIM2_PSCR_RESET_VALUE;
  89  0030 725f530c      	clr	21260
  90                     ; 72   TIM2->ARRH  = (uint8_t)TIM2_ARRH_RESET_VALUE;
  92  0034 35ff530d      	mov	21261,#255
  93                     ; 73   TIM2->ARRL  = (uint8_t)TIM2_ARRL_RESET_VALUE;
  95  0038 35ff530e      	mov	21262,#255
  96                     ; 74   TIM2->CCR1H = (uint8_t)TIM2_CCR1H_RESET_VALUE;
  98  003c 725f530f      	clr	21263
  99                     ; 75   TIM2->CCR1L = (uint8_t)TIM2_CCR1L_RESET_VALUE;
 101  0040 725f5310      	clr	21264
 102                     ; 76   TIM2->CCR2H = (uint8_t)TIM2_CCR2H_RESET_VALUE;
 104  0044 725f5311      	clr	21265
 105                     ; 77   TIM2->CCR2L = (uint8_t)TIM2_CCR2L_RESET_VALUE;
 107  0048 725f5312      	clr	21266
 108                     ; 78   TIM2->CCR3H = (uint8_t)TIM2_CCR3H_RESET_VALUE;
 110  004c 725f5313      	clr	21267
 111                     ; 79   TIM2->CCR3L = (uint8_t)TIM2_CCR3L_RESET_VALUE;
 113  0050 725f5314      	clr	21268
 114                     ; 80   TIM2->SR1 = (uint8_t)TIM2_SR1_RESET_VALUE;
 116  0054 725f5302      	clr	21250
 117                     ; 81 }
 120  0058 87            	retf	
 287                     ; 89 void TIM2_TimeBaseInit( TIM2_Prescaler_TypeDef TIM2_Prescaler,
 287                     ; 90                         uint16_t TIM2_Period)
 287                     ; 91 {
 288                     	switch	.text
 289  0059               f_TIM2_TimeBaseInit:
 291       ffffffff      OFST: set -1
 294                     ; 93   TIM2->PSCR = (uint8_t)(TIM2_Prescaler);
 296  0059 c7530c        	ld	21260,a
 297                     ; 95   TIM2->ARRH = (uint8_t)(TIM2_Period >> 8);
 299  005c 7b04          	ld	a,(OFST+5,sp)
 300  005e c7530d        	ld	21261,a
 301                     ; 96   TIM2->ARRL = (uint8_t)(TIM2_Period);
 303  0061 7b05          	ld	a,(OFST+6,sp)
 304  0063 c7530e        	ld	21262,a
 305                     ; 97 }
 308  0066 87            	retf	
 464                     ; 108 void TIM2_OC1Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 464                     ; 109                   TIM2_OutputState_TypeDef TIM2_OutputState,
 464                     ; 110                   uint16_t TIM2_Pulse,
 464                     ; 111                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 464                     ; 112 {
 465                     	switch	.text
 466  0067               f_TIM2_OC1Init:
 468  0067 89            	pushw	x
 469  0068 88            	push	a
 470       00000001      OFST:	set	1
 473                     ; 114   assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 475                     ; 115   assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 477                     ; 116   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 479                     ; 119   TIM2->CCER1 &= (uint8_t)(~( TIM2_CCER1_CC1E | TIM2_CCER1_CC1P));
 481  0069 c65308        	ld	a,21256
 482  006c a4fc          	and	a,#252
 483  006e c75308        	ld	21256,a
 484                     ; 121   TIM2->CCER1 |= (uint8_t)((uint8_t)(TIM2_OutputState & TIM2_CCER1_CC1E ) | 
 484                     ; 122                            (uint8_t)(TIM2_OCPolarity & TIM2_CCER1_CC1P));
 486  0071 7b09          	ld	a,(OFST+8,sp)
 487  0073 a402          	and	a,#2
 488  0075 6b01          	ld	(OFST+0,sp),a
 490  0077 9f            	ld	a,xl
 491  0078 a401          	and	a,#1
 492  007a 1a01          	or	a,(OFST+0,sp)
 493  007c ca5308        	or	a,21256
 494  007f c75308        	ld	21256,a
 495                     ; 125   TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM)) |
 495                     ; 126                           (uint8_t)TIM2_OCMode);
 497  0082 c65305        	ld	a,21253
 498  0085 a48f          	and	a,#143
 499  0087 1a02          	or	a,(OFST+1,sp)
 500  0089 c75305        	ld	21253,a
 501                     ; 129   TIM2->CCR1H = (uint8_t)(TIM2_Pulse >> 8);
 503  008c 7b07          	ld	a,(OFST+6,sp)
 504  008e c7530f        	ld	21263,a
 505                     ; 130   TIM2->CCR1L = (uint8_t)(TIM2_Pulse);
 507  0091 7b08          	ld	a,(OFST+7,sp)
 508  0093 c75310        	ld	21264,a
 509                     ; 131 }
 512  0096 5b03          	addw	sp,#3
 513  0098 87            	retf	
 576                     ; 142 void TIM2_OC2Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 576                     ; 143                   TIM2_OutputState_TypeDef TIM2_OutputState,
 576                     ; 144                   uint16_t TIM2_Pulse,
 576                     ; 145                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 576                     ; 146 {
 577                     	switch	.text
 578  0099               f_TIM2_OC2Init:
 580  0099 89            	pushw	x
 581  009a 88            	push	a
 582       00000001      OFST:	set	1
 585                     ; 148   assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 587                     ; 149   assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 589                     ; 150   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 591                     ; 154   TIM2->CCER1 &= (uint8_t)(~( TIM2_CCER1_CC2E |  TIM2_CCER1_CC2P ));
 593  009b c65308        	ld	a,21256
 594  009e a4cf          	and	a,#207
 595  00a0 c75308        	ld	21256,a
 596                     ; 156   TIM2->CCER1 |= (uint8_t)((uint8_t)(TIM2_OutputState  & TIM2_CCER1_CC2E ) |
 596                     ; 157                            (uint8_t)(TIM2_OCPolarity & TIM2_CCER1_CC2P));
 598  00a3 7b09          	ld	a,(OFST+8,sp)
 599  00a5 a420          	and	a,#32
 600  00a7 6b01          	ld	(OFST+0,sp),a
 602  00a9 9f            	ld	a,xl
 603  00aa a410          	and	a,#16
 604  00ac 1a01          	or	a,(OFST+0,sp)
 605  00ae ca5308        	or	a,21256
 606  00b1 c75308        	ld	21256,a
 607                     ; 161   TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM)) | 
 607                     ; 162                           (uint8_t)TIM2_OCMode);
 609  00b4 c65306        	ld	a,21254
 610  00b7 a48f          	and	a,#143
 611  00b9 1a02          	or	a,(OFST+1,sp)
 612  00bb c75306        	ld	21254,a
 613                     ; 166   TIM2->CCR2H = (uint8_t)(TIM2_Pulse >> 8);
 615  00be 7b07          	ld	a,(OFST+6,sp)
 616  00c0 c75311        	ld	21265,a
 617                     ; 167   TIM2->CCR2L = (uint8_t)(TIM2_Pulse);
 619  00c3 7b08          	ld	a,(OFST+7,sp)
 620  00c5 c75312        	ld	21266,a
 621                     ; 168 }
 624  00c8 5b03          	addw	sp,#3
 625  00ca 87            	retf	
 688                     ; 179 void TIM2_OC3Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 688                     ; 180                   TIM2_OutputState_TypeDef TIM2_OutputState,
 688                     ; 181                   uint16_t TIM2_Pulse,
 688                     ; 182                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 688                     ; 183 {
 689                     	switch	.text
 690  00cb               f_TIM2_OC3Init:
 692  00cb 89            	pushw	x
 693  00cc 88            	push	a
 694       00000001      OFST:	set	1
 697                     ; 185   assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 699                     ; 186   assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 701                     ; 187   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 703                     ; 189   TIM2->CCER2 &= (uint8_t)(~( TIM2_CCER2_CC3E  | TIM2_CCER2_CC3P));
 705  00cd c65309        	ld	a,21257
 706  00d0 a4fc          	and	a,#252
 707  00d2 c75309        	ld	21257,a
 708                     ; 191   TIM2->CCER2 |= (uint8_t)((uint8_t)(TIM2_OutputState & TIM2_CCER2_CC3E) |  
 708                     ; 192                            (uint8_t)(TIM2_OCPolarity & TIM2_CCER2_CC3P));
 710  00d5 7b09          	ld	a,(OFST+8,sp)
 711  00d7 a402          	and	a,#2
 712  00d9 6b01          	ld	(OFST+0,sp),a
 714  00db 9f            	ld	a,xl
 715  00dc a401          	and	a,#1
 716  00de 1a01          	or	a,(OFST+0,sp)
 717  00e0 ca5309        	or	a,21257
 718  00e3 c75309        	ld	21257,a
 719                     ; 195   TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM)) |
 719                     ; 196                           (uint8_t)TIM2_OCMode);
 721  00e6 c65307        	ld	a,21255
 722  00e9 a48f          	and	a,#143
 723  00eb 1a02          	or	a,(OFST+1,sp)
 724  00ed c75307        	ld	21255,a
 725                     ; 199   TIM2->CCR3H = (uint8_t)(TIM2_Pulse >> 8);
 727  00f0 7b07          	ld	a,(OFST+6,sp)
 728  00f2 c75313        	ld	21267,a
 729                     ; 200   TIM2->CCR3L = (uint8_t)(TIM2_Pulse);
 731  00f5 7b08          	ld	a,(OFST+7,sp)
 732  00f7 c75314        	ld	21268,a
 733                     ; 201 }
 736  00fa 5b03          	addw	sp,#3
 737  00fc 87            	retf	
 929                     ; 212 void TIM2_ICInit(TIM2_Channel_TypeDef TIM2_Channel,
 929                     ; 213                  TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
 929                     ; 214                  TIM2_ICSelection_TypeDef TIM2_ICSelection,
 929                     ; 215                  TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
 929                     ; 216                  uint8_t TIM2_ICFilter)
 929                     ; 217 {
 930                     	switch	.text
 931  00fd               f_TIM2_ICInit:
 933  00fd 89            	pushw	x
 934       00000000      OFST:	set	0
 937                     ; 219   assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
 939                     ; 220   assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
 941                     ; 221   assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
 943                     ; 222   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
 945                     ; 223   assert_param(IS_TIM2_IC_FILTER_OK(TIM2_ICFilter));
 947                     ; 225   if (TIM2_Channel == TIM2_CHANNEL_1)
 949  00fe 9e            	ld	a,xh
 950  00ff 4d            	tnz	a
 951  0100 2616          	jrne	L104
 952                     ; 228     TI1_Config((uint8_t)TIM2_ICPolarity,
 952                     ; 229                (uint8_t)TIM2_ICSelection,
 952                     ; 230                (uint8_t)TIM2_ICFilter);
 954  0102 7b08          	ld	a,(OFST+8,sp)
 955  0104 88            	push	a
 956  0105 7b07          	ld	a,(OFST+7,sp)
 957  0107 97            	ld	xl,a
 958  0108 7b03          	ld	a,(OFST+3,sp)
 959  010a 95            	ld	xh,a
 960  010b 8d170417      	callf	L3f_TI1_Config
 962  010f 84            	pop	a
 963                     ; 233     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
 965  0110 7b07          	ld	a,(OFST+7,sp)
 966  0112 8d380338      	callf	f_TIM2_SetIC1Prescaler
 969  0116 202f          	jra	L304
 970  0118               L104:
 971                     ; 235   else if (TIM2_Channel == TIM2_CHANNEL_2)
 973  0118 7b01          	ld	a,(OFST+1,sp)
 974  011a 4a            	dec	a
 975  011b 2616          	jrne	L504
 976                     ; 238     TI2_Config((uint8_t)TIM2_ICPolarity,
 976                     ; 239                (uint8_t)TIM2_ICSelection,
 976                     ; 240                (uint8_t)TIM2_ICFilter);
 978  011d 7b08          	ld	a,(OFST+8,sp)
 979  011f 88            	push	a
 980  0120 7b07          	ld	a,(OFST+7,sp)
 981  0122 97            	ld	xl,a
 982  0123 7b03          	ld	a,(OFST+3,sp)
 983  0125 95            	ld	xh,a
 984  0126 8d470447      	callf	L5f_TI2_Config
 986  012a 84            	pop	a
 987                     ; 243     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
 989  012b 7b07          	ld	a,(OFST+7,sp)
 990  012d 8d450345      	callf	f_TIM2_SetIC2Prescaler
 993  0131 2014          	jra	L304
 994  0133               L504:
 995                     ; 248     TI3_Config((uint8_t)TIM2_ICPolarity,
 995                     ; 249                (uint8_t)TIM2_ICSelection,
 995                     ; 250                (uint8_t)TIM2_ICFilter);
 997  0133 7b08          	ld	a,(OFST+8,sp)
 998  0135 88            	push	a
 999  0136 7b07          	ld	a,(OFST+7,sp)
1000  0138 97            	ld	xl,a
1001  0139 7b03          	ld	a,(OFST+3,sp)
1002  013b 95            	ld	xh,a
1003  013c 8d770477      	callf	L7f_TI3_Config
1005  0140 84            	pop	a
1006                     ; 253     TIM2_SetIC3Prescaler(TIM2_ICPrescaler);
1008  0141 7b07          	ld	a,(OFST+7,sp)
1009  0143 8d520352      	callf	f_TIM2_SetIC3Prescaler
1011  0147               L304:
1012                     ; 255 }
1015  0147 85            	popw	x
1016  0148 87            	retf	
1111                     ; 266 void TIM2_PWMIConfig(TIM2_Channel_TypeDef TIM2_Channel,
1111                     ; 267                      TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
1111                     ; 268                      TIM2_ICSelection_TypeDef TIM2_ICSelection,
1111                     ; 269                      TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
1111                     ; 270                      uint8_t TIM2_ICFilter)
1111                     ; 271 {
1112                     	switch	.text
1113  0149               f_TIM2_PWMIConfig:
1115  0149 89            	pushw	x
1116  014a 89            	pushw	x
1117       00000002      OFST:	set	2
1120                     ; 272   uint8_t icpolarity = (uint8_t)TIM2_ICPOLARITY_RISING;
1122                     ; 273   uint8_t icselection = (uint8_t)TIM2_ICSELECTION_DIRECTTI;
1124                     ; 276   assert_param(IS_TIM2_PWMI_CHANNEL_OK(TIM2_Channel));
1126                     ; 277   assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
1128                     ; 278   assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
1130                     ; 279   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
1132                     ; 282   if (TIM2_ICPolarity != TIM2_ICPOLARITY_FALLING)
1134  014b 9f            	ld	a,xl
1135  014c a144          	cp	a,#68
1136  014e 2706          	jreq	L754
1137                     ; 284     icpolarity = (uint8_t)TIM2_ICPOLARITY_FALLING;
1139  0150 a644          	ld	a,#68
1140  0152 6b01          	ld	(OFST-1,sp),a
1143  0154 2002          	jra	L164
1144  0156               L754:
1145                     ; 288     icpolarity = (uint8_t)TIM2_ICPOLARITY_RISING;
1147  0156 0f01          	clr	(OFST-1,sp)
1149  0158               L164:
1150                     ; 292   if (TIM2_ICSelection == TIM2_ICSELECTION_DIRECTTI)
1152  0158 7b08          	ld	a,(OFST+6,sp)
1153  015a 4a            	dec	a
1154  015b 2604          	jrne	L364
1155                     ; 294     icselection = (uint8_t)TIM2_ICSELECTION_INDIRECTTI;
1157  015d a602          	ld	a,#2
1159  015f 2002          	jra	L564
1160  0161               L364:
1161                     ; 298     icselection = (uint8_t)TIM2_ICSELECTION_DIRECTTI;
1163  0161 a601          	ld	a,#1
1164  0163               L564:
1165  0163 6b02          	ld	(OFST+0,sp),a
1167                     ; 301   if (TIM2_Channel == TIM2_CHANNEL_1)
1169  0165 7b03          	ld	a,(OFST+1,sp)
1170  0167 262a          	jrne	L764
1171                     ; 304     TI1_Config((uint8_t)TIM2_ICPolarity, (uint8_t)TIM2_ICSelection,
1171                     ; 305                (uint8_t)TIM2_ICFilter);
1173  0169 7b0a          	ld	a,(OFST+8,sp)
1174  016b 88            	push	a
1175  016c 7b09          	ld	a,(OFST+7,sp)
1176  016e 97            	ld	xl,a
1177  016f 7b05          	ld	a,(OFST+3,sp)
1178  0171 95            	ld	xh,a
1179  0172 8d170417      	callf	L3f_TI1_Config
1181  0176 84            	pop	a
1182                     ; 308     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1184  0177 7b09          	ld	a,(OFST+7,sp)
1185  0179 8d380338      	callf	f_TIM2_SetIC1Prescaler
1187                     ; 311     TI2_Config(icpolarity, icselection, TIM2_ICFilter);
1189  017d 7b0a          	ld	a,(OFST+8,sp)
1190  017f 88            	push	a
1191  0180 7b03          	ld	a,(OFST+1,sp)
1192  0182 97            	ld	xl,a
1193  0183 7b02          	ld	a,(OFST+0,sp)
1194  0185 95            	ld	xh,a
1195  0186 8d470447      	callf	L5f_TI2_Config
1197  018a 84            	pop	a
1198                     ; 314     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1200  018b 7b09          	ld	a,(OFST+7,sp)
1201  018d 8d450345      	callf	f_TIM2_SetIC2Prescaler
1204  0191 2028          	jra	L174
1205  0193               L764:
1206                     ; 319     TI2_Config((uint8_t)TIM2_ICPolarity, (uint8_t)TIM2_ICSelection,
1206                     ; 320                (uint8_t)TIM2_ICFilter);
1208  0193 7b0a          	ld	a,(OFST+8,sp)
1209  0195 88            	push	a
1210  0196 7b09          	ld	a,(OFST+7,sp)
1211  0198 97            	ld	xl,a
1212  0199 7b05          	ld	a,(OFST+3,sp)
1213  019b 95            	ld	xh,a
1214  019c 8d470447      	callf	L5f_TI2_Config
1216  01a0 84            	pop	a
1217                     ; 323     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1219  01a1 7b09          	ld	a,(OFST+7,sp)
1220  01a3 8d450345      	callf	f_TIM2_SetIC2Prescaler
1222                     ; 326     TI1_Config((uint8_t)icpolarity, icselection, (uint8_t)TIM2_ICFilter);
1224  01a7 7b0a          	ld	a,(OFST+8,sp)
1225  01a9 88            	push	a
1226  01aa 7b03          	ld	a,(OFST+1,sp)
1227  01ac 97            	ld	xl,a
1228  01ad 7b02          	ld	a,(OFST+0,sp)
1229  01af 95            	ld	xh,a
1230  01b0 8d170417      	callf	L3f_TI1_Config
1232  01b4 84            	pop	a
1233                     ; 329     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1235  01b5 7b09          	ld	a,(OFST+7,sp)
1236  01b7 8d380338      	callf	f_TIM2_SetIC1Prescaler
1238  01bb               L174:
1239                     ; 331 }
1242  01bb 5b04          	addw	sp,#4
1243  01bd 87            	retf	
1297                     ; 339 void TIM2_Cmd(FunctionalState NewState)
1297                     ; 340 {
1298                     	switch	.text
1299  01be               f_TIM2_Cmd:
1303                     ; 342   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1305                     ; 345   if (NewState != DISABLE)
1307  01be 4d            	tnz	a
1308  01bf 2705          	jreq	L125
1309                     ; 347     TIM2->CR1 |= (uint8_t)TIM2_CR1_CEN;
1311  01c1 72105300      	bset	21248,#0
1314  01c5 87            	retf	
1315  01c6               L125:
1316                     ; 351     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_CEN);
1318  01c6 72115300      	bres	21248,#0
1319                     ; 353 }
1322  01ca 87            	retf	
1400                     ; 368 void TIM2_ITConfig(TIM2_IT_TypeDef TIM2_IT, FunctionalState NewState)
1400                     ; 369 {
1401                     	switch	.text
1402  01cb               f_TIM2_ITConfig:
1404  01cb 89            	pushw	x
1405       00000000      OFST:	set	0
1408                     ; 371   assert_param(IS_TIM2_IT_OK(TIM2_IT));
1410                     ; 372   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1412                     ; 374   if (NewState != DISABLE)
1414  01cc 9f            	ld	a,xl
1415  01cd 4d            	tnz	a
1416  01ce 2706          	jreq	L365
1417                     ; 377     TIM2->IER |= (uint8_t)TIM2_IT;
1419  01d0 9e            	ld	a,xh
1420  01d1 ca5301        	or	a,21249
1422  01d4 2006          	jra	L565
1423  01d6               L365:
1424                     ; 382     TIM2->IER &= (uint8_t)(~TIM2_IT);
1426  01d6 7b01          	ld	a,(OFST+1,sp)
1427  01d8 43            	cpl	a
1428  01d9 c45301        	and	a,21249
1429  01dc               L565:
1430  01dc c75301        	ld	21249,a
1431                     ; 384 }
1434  01df 85            	popw	x
1435  01e0 87            	retf	
1470                     ; 392 void TIM2_UpdateDisableConfig(FunctionalState NewState)
1470                     ; 393 {
1471                     	switch	.text
1472  01e1               f_TIM2_UpdateDisableConfig:
1476                     ; 395   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1478                     ; 398   if (NewState != DISABLE)
1480  01e1 4d            	tnz	a
1481  01e2 2705          	jreq	L506
1482                     ; 400     TIM2->CR1 |= (uint8_t)TIM2_CR1_UDIS;
1484  01e4 72125300      	bset	21248,#1
1487  01e8 87            	retf	
1488  01e9               L506:
1489                     ; 404     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_UDIS);
1491  01e9 72135300      	bres	21248,#1
1492                     ; 406 }
1495  01ed 87            	retf	
1552                     ; 416 void TIM2_UpdateRequestConfig(TIM2_UpdateSource_TypeDef TIM2_UpdateSource)
1552                     ; 417 {
1553                     	switch	.text
1554  01ee               f_TIM2_UpdateRequestConfig:
1558                     ; 419   assert_param(IS_TIM2_UPDATE_SOURCE_OK(TIM2_UpdateSource));
1560                     ; 422   if (TIM2_UpdateSource != TIM2_UPDATESOURCE_GLOBAL)
1562  01ee 4d            	tnz	a
1563  01ef 2705          	jreq	L736
1564                     ; 424     TIM2->CR1 |= (uint8_t)TIM2_CR1_URS;
1566  01f1 72145300      	bset	21248,#2
1569  01f5 87            	retf	
1570  01f6               L736:
1571                     ; 428     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_URS);
1573  01f6 72155300      	bres	21248,#2
1574                     ; 430 }
1577  01fa 87            	retf	
1633                     ; 440 void TIM2_SelectOnePulseMode(TIM2_OPMode_TypeDef TIM2_OPMode)
1633                     ; 441 {
1634                     	switch	.text
1635  01fb               f_TIM2_SelectOnePulseMode:
1639                     ; 443   assert_param(IS_TIM2_OPM_MODE_OK(TIM2_OPMode));
1641                     ; 446   if (TIM2_OPMode != TIM2_OPMODE_REPETITIVE)
1643  01fb 4d            	tnz	a
1644  01fc 2705          	jreq	L176
1645                     ; 448     TIM2->CR1 |= (uint8_t)TIM2_CR1_OPM;
1647  01fe 72165300      	bset	21248,#3
1650  0202 87            	retf	
1651  0203               L176:
1652                     ; 452     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_OPM);
1654  0203 72175300      	bres	21248,#3
1655                     ; 454 }
1658  0207 87            	retf	
1725                     ; 484 void TIM2_PrescalerConfig(TIM2_Prescaler_TypeDef Prescaler,
1725                     ; 485                           TIM2_PSCReloadMode_TypeDef TIM2_PSCReloadMode)
1725                     ; 486 {
1726                     	switch	.text
1727  0208               f_TIM2_PrescalerConfig:
1731                     ; 488   assert_param(IS_TIM2_PRESCALER_RELOAD_OK(TIM2_PSCReloadMode));
1733                     ; 489   assert_param(IS_TIM2_PRESCALER_OK(Prescaler));
1735                     ; 492   TIM2->PSCR = (uint8_t)Prescaler;
1737  0208 9e            	ld	a,xh
1738  0209 c7530c        	ld	21260,a
1739                     ; 495   TIM2->EGR = (uint8_t)TIM2_PSCReloadMode;
1741  020c 9f            	ld	a,xl
1742  020d c75304        	ld	21252,a
1743                     ; 496 }
1746  0210 87            	retf	
1803                     ; 507 void TIM2_ForcedOC1Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1803                     ; 508 {
1804                     	switch	.text
1805  0211               f_TIM2_ForcedOC1Config:
1807  0211 88            	push	a
1808       00000000      OFST:	set	0
1811                     ; 510   assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1813                     ; 513   TIM2->CCMR1  =  (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM))  
1813                     ; 514                             | (uint8_t)TIM2_ForcedAction);
1815  0212 c65305        	ld	a,21253
1816  0215 a48f          	and	a,#143
1817  0217 1a01          	or	a,(OFST+1,sp)
1818  0219 c75305        	ld	21253,a
1819                     ; 515 }
1822  021c 84            	pop	a
1823  021d 87            	retf	
1858                     ; 526 void TIM2_ForcedOC2Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1858                     ; 527 {
1859                     	switch	.text
1860  021e               f_TIM2_ForcedOC2Config:
1862  021e 88            	push	a
1863       00000000      OFST:	set	0
1866                     ; 529   assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1868                     ; 532   TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM))  
1868                     ; 533                           | (uint8_t)TIM2_ForcedAction);
1870  021f c65306        	ld	a,21254
1871  0222 a48f          	and	a,#143
1872  0224 1a01          	or	a,(OFST+1,sp)
1873  0226 c75306        	ld	21254,a
1874                     ; 534 }
1877  0229 84            	pop	a
1878  022a 87            	retf	
1913                     ; 545 void TIM2_ForcedOC3Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1913                     ; 546 {
1914                     	switch	.text
1915  022b               f_TIM2_ForcedOC3Config:
1917  022b 88            	push	a
1918       00000000      OFST:	set	0
1921                     ; 548   assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1923                     ; 551   TIM2->CCMR3  =  (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM))
1923                     ; 552                             | (uint8_t)TIM2_ForcedAction);
1925  022c c65307        	ld	a,21255
1926  022f a48f          	and	a,#143
1927  0231 1a01          	or	a,(OFST+1,sp)
1928  0233 c75307        	ld	21255,a
1929                     ; 553 }
1932  0236 84            	pop	a
1933  0237 87            	retf	
1968                     ; 561 void TIM2_ARRPreloadConfig(FunctionalState NewState)
1968                     ; 562 {
1969                     	switch	.text
1970  0238               f_TIM2_ARRPreloadConfig:
1974                     ; 564   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1976                     ; 567   if (NewState != DISABLE)
1978  0238 4d            	tnz	a
1979  0239 2705          	jreq	L7201
1980                     ; 569     TIM2->CR1 |= (uint8_t)TIM2_CR1_ARPE;
1982  023b 721e5300      	bset	21248,#7
1985  023f 87            	retf	
1986  0240               L7201:
1987                     ; 573     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_ARPE);
1989  0240 721f5300      	bres	21248,#7
1990                     ; 575 }
1993  0244 87            	retf	
2028                     ; 583 void TIM2_OC1PreloadConfig(FunctionalState NewState)
2028                     ; 584 {
2029                     	switch	.text
2030  0245               f_TIM2_OC1PreloadConfig:
2034                     ; 586   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2036                     ; 589   if (NewState != DISABLE)
2038  0245 4d            	tnz	a
2039  0246 2705          	jreq	L1501
2040                     ; 591     TIM2->CCMR1 |= (uint8_t)TIM2_CCMR_OCxPE;
2042  0248 72165305      	bset	21253,#3
2045  024c 87            	retf	
2046  024d               L1501:
2047                     ; 595     TIM2->CCMR1 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2049  024d 72175305      	bres	21253,#3
2050                     ; 597 }
2053  0251 87            	retf	
2088                     ; 605 void TIM2_OC2PreloadConfig(FunctionalState NewState)
2088                     ; 606 {
2089                     	switch	.text
2090  0252               f_TIM2_OC2PreloadConfig:
2094                     ; 608   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2096                     ; 611   if (NewState != DISABLE)
2098  0252 4d            	tnz	a
2099  0253 2705          	jreq	L3701
2100                     ; 613     TIM2->CCMR2 |= (uint8_t)TIM2_CCMR_OCxPE;
2102  0255 72165306      	bset	21254,#3
2105  0259 87            	retf	
2106  025a               L3701:
2107                     ; 617     TIM2->CCMR2 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2109  025a 72175306      	bres	21254,#3
2110                     ; 619 }
2113  025e 87            	retf	
2148                     ; 627 void TIM2_OC3PreloadConfig(FunctionalState NewState)
2148                     ; 628 {
2149                     	switch	.text
2150  025f               f_TIM2_OC3PreloadConfig:
2154                     ; 630   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2156                     ; 633   if (NewState != DISABLE)
2158  025f 4d            	tnz	a
2159  0260 2705          	jreq	L5111
2160                     ; 635     TIM2->CCMR3 |= (uint8_t)TIM2_CCMR_OCxPE;
2162  0262 72165307      	bset	21255,#3
2165  0266 87            	retf	
2166  0267               L5111:
2167                     ; 639     TIM2->CCMR3 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2169  0267 72175307      	bres	21255,#3
2170                     ; 641 }
2173  026b 87            	retf	
2245                     ; 653 void TIM2_GenerateEvent(TIM2_EventSource_TypeDef TIM2_EventSource)
2245                     ; 654 {
2246                     	switch	.text
2247  026c               f_TIM2_GenerateEvent:
2251                     ; 656   assert_param(IS_TIM2_EVENT_SOURCE_OK(TIM2_EventSource));
2253                     ; 659   TIM2->EGR = (uint8_t)TIM2_EventSource;
2255  026c c75304        	ld	21252,a
2256                     ; 660 }
2259  026f 87            	retf	
2294                     ; 670 void TIM2_OC1PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2294                     ; 671 {
2295                     	switch	.text
2296  0270               f_TIM2_OC1PolarityConfig:
2300                     ; 673   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2302                     ; 676   if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2304  0270 4d            	tnz	a
2305  0271 2705          	jreq	L1711
2306                     ; 678     TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC1P;
2308  0273 72125308      	bset	21256,#1
2311  0277 87            	retf	
2312  0278               L1711:
2313                     ; 682     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1P);
2315  0278 72135308      	bres	21256,#1
2316                     ; 684 }
2319  027c 87            	retf	
2354                     ; 694 void TIM2_OC2PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2354                     ; 695 {
2355                     	switch	.text
2356  027d               f_TIM2_OC2PolarityConfig:
2360                     ; 697   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2362                     ; 700   if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2364  027d 4d            	tnz	a
2365  027e 2705          	jreq	L3121
2366                     ; 702     TIM2->CCER1 |= TIM2_CCER1_CC2P;
2368  0280 721a5308      	bset	21256,#5
2371  0284 87            	retf	
2372  0285               L3121:
2373                     ; 706     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2P);
2375  0285 721b5308      	bres	21256,#5
2376                     ; 708 }
2379  0289 87            	retf	
2414                     ; 718 void TIM2_OC3PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2414                     ; 719 {
2415                     	switch	.text
2416  028a               f_TIM2_OC3PolarityConfig:
2420                     ; 721   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2422                     ; 724   if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2424  028a 4d            	tnz	a
2425  028b 2705          	jreq	L5321
2426                     ; 726     TIM2->CCER2 |= (uint8_t)TIM2_CCER2_CC3P;
2428  028d 72125309      	bset	21257,#1
2431  0291 87            	retf	
2432  0292               L5321:
2433                     ; 730     TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3P);
2435  0292 72135309      	bres	21257,#1
2436                     ; 732 }
2439  0296 87            	retf	
2483                     ; 745 void TIM2_CCxCmd(TIM2_Channel_TypeDef TIM2_Channel, FunctionalState NewState)
2483                     ; 746 {
2484                     	switch	.text
2485  0297               f_TIM2_CCxCmd:
2487  0297 89            	pushw	x
2488       00000000      OFST:	set	0
2491                     ; 748   assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
2493                     ; 749   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2495                     ; 751   if (TIM2_Channel == TIM2_CHANNEL_1)
2497  0298 9e            	ld	a,xh
2498  0299 4d            	tnz	a
2499  029a 2610          	jrne	L3621
2500                     ; 754     if (NewState != DISABLE)
2502  029c 9f            	ld	a,xl
2503  029d 4d            	tnz	a
2504  029e 2706          	jreq	L5621
2505                     ; 756       TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC1E;
2507  02a0 72105308      	bset	21256,#0
2509  02a4 2029          	jra	L1721
2510  02a6               L5621:
2511                     ; 760       TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
2513  02a6 72115308      	bres	21256,#0
2514  02aa 2023          	jra	L1721
2515  02ac               L3621:
2516                     ; 764   else if (TIM2_Channel == TIM2_CHANNEL_2)
2518  02ac 7b01          	ld	a,(OFST+1,sp)
2519  02ae 4a            	dec	a
2520  02af 2610          	jrne	L3721
2521                     ; 767     if (NewState != DISABLE)
2523  02b1 7b02          	ld	a,(OFST+2,sp)
2524  02b3 2706          	jreq	L5721
2525                     ; 769       TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC2E;
2527  02b5 72185308      	bset	21256,#4
2529  02b9 2014          	jra	L1721
2530  02bb               L5721:
2531                     ; 773       TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
2533  02bb 72195308      	bres	21256,#4
2534  02bf 200e          	jra	L1721
2535  02c1               L3721:
2536                     ; 779     if (NewState != DISABLE)
2538  02c1 7b02          	ld	a,(OFST+2,sp)
2539  02c3 2706          	jreq	L3031
2540                     ; 781       TIM2->CCER2 |= (uint8_t)TIM2_CCER2_CC3E;
2542  02c5 72105309      	bset	21257,#0
2544  02c9 2004          	jra	L1721
2545  02cb               L3031:
2546                     ; 785       TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3E);
2548  02cb 72115309      	bres	21257,#0
2549  02cf               L1721:
2550                     ; 788 }
2553  02cf 85            	popw	x
2554  02d0 87            	retf	
2598                     ; 810 void TIM2_SelectOCxM(TIM2_Channel_TypeDef TIM2_Channel, TIM2_OCMode_TypeDef TIM2_OCMode)
2598                     ; 811 {
2599                     	switch	.text
2600  02d1               f_TIM2_SelectOCxM:
2602  02d1 89            	pushw	x
2603       00000000      OFST:	set	0
2606                     ; 813   assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
2608                     ; 814   assert_param(IS_TIM2_OCM_OK(TIM2_OCMode));
2610                     ; 816   if (TIM2_Channel == TIM2_CHANNEL_1)
2612  02d2 9e            	ld	a,xh
2613  02d3 4d            	tnz	a
2614  02d4 2610          	jrne	L1331
2615                     ; 819     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
2617  02d6 72115308      	bres	21256,#0
2618                     ; 822     TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM))
2618                     ; 823                             | (uint8_t)TIM2_OCMode);
2620  02da c65305        	ld	a,21253
2621  02dd a48f          	and	a,#143
2622  02df 1a02          	or	a,(OFST+2,sp)
2623  02e1 c75305        	ld	21253,a
2625  02e4 2023          	jra	L3331
2626  02e6               L1331:
2627                     ; 825   else if (TIM2_Channel == TIM2_CHANNEL_2)
2629  02e6 7b01          	ld	a,(OFST+1,sp)
2630  02e8 4a            	dec	a
2631  02e9 2610          	jrne	L5331
2632                     ; 828     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
2634  02eb 72195308      	bres	21256,#4
2635                     ; 831     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM))
2635                     ; 832                             | (uint8_t)TIM2_OCMode);
2637  02ef c65306        	ld	a,21254
2638  02f2 a48f          	and	a,#143
2639  02f4 1a02          	or	a,(OFST+2,sp)
2640  02f6 c75306        	ld	21254,a
2642  02f9 200e          	jra	L3331
2643  02fb               L5331:
2644                     ; 837     TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3E);
2646  02fb 72115309      	bres	21257,#0
2647                     ; 840     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM))
2647                     ; 841                             | (uint8_t)TIM2_OCMode);
2649  02ff c65307        	ld	a,21255
2650  0302 a48f          	and	a,#143
2651  0304 1a02          	or	a,(OFST+2,sp)
2652  0306 c75307        	ld	21255,a
2653  0309               L3331:
2654                     ; 843 }
2657  0309 85            	popw	x
2658  030a 87            	retf	
2691                     ; 851 void TIM2_SetCounter(uint16_t Counter)
2691                     ; 852 {
2692                     	switch	.text
2693  030b               f_TIM2_SetCounter:
2697                     ; 854   TIM2->CNTRH = (uint8_t)(Counter >> 8);
2699  030b 9e            	ld	a,xh
2700  030c c7530a        	ld	21258,a
2701                     ; 855   TIM2->CNTRL = (uint8_t)(Counter);
2703  030f 9f            	ld	a,xl
2704  0310 c7530b        	ld	21259,a
2705                     ; 856 }
2708  0313 87            	retf	
2741                     ; 864 void TIM2_SetAutoreload(uint16_t Autoreload)
2741                     ; 865 {
2742                     	switch	.text
2743  0314               f_TIM2_SetAutoreload:
2747                     ; 867   TIM2->ARRH = (uint8_t)(Autoreload >> 8);
2749  0314 9e            	ld	a,xh
2750  0315 c7530d        	ld	21261,a
2751                     ; 868   TIM2->ARRL = (uint8_t)(Autoreload);
2753  0318 9f            	ld	a,xl
2754  0319 c7530e        	ld	21262,a
2755                     ; 869 }
2758  031c 87            	retf	
2791                     ; 877 void TIM2_SetCompare1(uint16_t Compare1)
2791                     ; 878 {
2792                     	switch	.text
2793  031d               f_TIM2_SetCompare1:
2797                     ; 880   TIM2->CCR1H = (uint8_t)(Compare1 >> 8);
2799  031d 9e            	ld	a,xh
2800  031e c7530f        	ld	21263,a
2801                     ; 881   TIM2->CCR1L = (uint8_t)(Compare1);
2803  0321 9f            	ld	a,xl
2804  0322 c75310        	ld	21264,a
2805                     ; 882 }
2808  0325 87            	retf	
2841                     ; 890 void TIM2_SetCompare2(uint16_t Compare2)
2841                     ; 891 {
2842                     	switch	.text
2843  0326               f_TIM2_SetCompare2:
2847                     ; 893   TIM2->CCR2H = (uint8_t)(Compare2 >> 8);
2849  0326 9e            	ld	a,xh
2850  0327 c75311        	ld	21265,a
2851                     ; 894   TIM2->CCR2L = (uint8_t)(Compare2);
2853  032a 9f            	ld	a,xl
2854  032b c75312        	ld	21266,a
2855                     ; 895 }
2858  032e 87            	retf	
2891                     ; 903 void TIM2_SetCompare3(uint16_t Compare3)
2891                     ; 904 {
2892                     	switch	.text
2893  032f               f_TIM2_SetCompare3:
2897                     ; 906   TIM2->CCR3H = (uint8_t)(Compare3 >> 8);
2899  032f 9e            	ld	a,xh
2900  0330 c75313        	ld	21267,a
2901                     ; 907   TIM2->CCR3L = (uint8_t)(Compare3);
2903  0333 9f            	ld	a,xl
2904  0334 c75314        	ld	21268,a
2905                     ; 908 }
2908  0337 87            	retf	
2943                     ; 920 void TIM2_SetIC1Prescaler(TIM2_ICPSC_TypeDef TIM2_IC1Prescaler)
2943                     ; 921 {
2944                     	switch	.text
2945  0338               f_TIM2_SetIC1Prescaler:
2947  0338 88            	push	a
2948       00000000      OFST:	set	0
2951                     ; 923   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC1Prescaler));
2953                     ; 926   TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_ICxPSC))
2953                     ; 927                           | (uint8_t)TIM2_IC1Prescaler);
2955  0339 c65305        	ld	a,21253
2956  033c a4f3          	and	a,#243
2957  033e 1a01          	or	a,(OFST+1,sp)
2958  0340 c75305        	ld	21253,a
2959                     ; 928 }
2962  0343 84            	pop	a
2963  0344 87            	retf	
2998                     ; 940 void TIM2_SetIC2Prescaler(TIM2_ICPSC_TypeDef TIM2_IC2Prescaler)
2998                     ; 941 {
2999                     	switch	.text
3000  0345               f_TIM2_SetIC2Prescaler:
3002  0345 88            	push	a
3003       00000000      OFST:	set	0
3006                     ; 943   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC2Prescaler));
3008                     ; 946   TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3008                     ; 947                           | (uint8_t)TIM2_IC2Prescaler);
3010  0346 c65306        	ld	a,21254
3011  0349 a4f3          	and	a,#243
3012  034b 1a01          	or	a,(OFST+1,sp)
3013  034d c75306        	ld	21254,a
3014                     ; 948 }
3017  0350 84            	pop	a
3018  0351 87            	retf	
3053                     ; 960 void TIM2_SetIC3Prescaler(TIM2_ICPSC_TypeDef TIM2_IC3Prescaler)
3053                     ; 961 {
3054                     	switch	.text
3055  0352               f_TIM2_SetIC3Prescaler:
3057  0352 88            	push	a
3058       00000000      OFST:	set	0
3061                     ; 964   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC3Prescaler));
3063                     ; 966   TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3063                     ; 967                           | (uint8_t)TIM2_IC3Prescaler);
3065  0353 c65307        	ld	a,21255
3066  0356 a4f3          	and	a,#243
3067  0358 1a01          	or	a,(OFST+1,sp)
3068  035a c75307        	ld	21255,a
3069                     ; 968 }
3072  035d 84            	pop	a
3073  035e 87            	retf	
3124                     ; 975 uint16_t TIM2_GetCapture1(void)
3124                     ; 976 {
3125                     	switch	.text
3126  035f               f_TIM2_GetCapture1:
3128  035f 5204          	subw	sp,#4
3129       00000004      OFST:	set	4
3132                     ; 978   uint16_t tmpccr1 = 0;
3134                     ; 979   uint8_t tmpccr1l=0, tmpccr1h=0;
3138                     ; 981   tmpccr1h = TIM2->CCR1H;
3140  0361 c6530f        	ld	a,21263
3141  0364 6b02          	ld	(OFST-2,sp),a
3143                     ; 982   tmpccr1l = TIM2->CCR1L;
3145  0366 c65310        	ld	a,21264
3146  0369 6b01          	ld	(OFST-3,sp),a
3148                     ; 984   tmpccr1 = (uint16_t)(tmpccr1l);
3150  036b 5f            	clrw	x
3151  036c 97            	ld	xl,a
3152  036d 1f03          	ldw	(OFST-1,sp),x
3154                     ; 985   tmpccr1 |= (uint16_t)((uint16_t)tmpccr1h << 8);
3156  036f 5f            	clrw	x
3157  0370 7b02          	ld	a,(OFST-2,sp)
3158  0372 97            	ld	xl,a
3159  0373 7b04          	ld	a,(OFST+0,sp)
3160  0375 01            	rrwa	x,a
3161  0376 1a03          	or	a,(OFST-1,sp)
3162  0378 01            	rrwa	x,a
3164                     ; 987   return (uint16_t)tmpccr1;
3168  0379 5b04          	addw	sp,#4
3169  037b 87            	retf	
3220                     ; 995 uint16_t TIM2_GetCapture2(void)
3220                     ; 996 {
3221                     	switch	.text
3222  037c               f_TIM2_GetCapture2:
3224  037c 5204          	subw	sp,#4
3225       00000004      OFST:	set	4
3228                     ; 998   uint16_t tmpccr2 = 0;
3230                     ; 999   uint8_t tmpccr2l=0, tmpccr2h=0;
3234                     ; 1001   tmpccr2h = TIM2->CCR2H;
3236  037e c65311        	ld	a,21265
3237  0381 6b02          	ld	(OFST-2,sp),a
3239                     ; 1002   tmpccr2l = TIM2->CCR2L;
3241  0383 c65312        	ld	a,21266
3242  0386 6b01          	ld	(OFST-3,sp),a
3244                     ; 1004   tmpccr2 = (uint16_t)(tmpccr2l);
3246  0388 5f            	clrw	x
3247  0389 97            	ld	xl,a
3248  038a 1f03          	ldw	(OFST-1,sp),x
3250                     ; 1005   tmpccr2 |= (uint16_t)((uint16_t)tmpccr2h << 8);
3252  038c 5f            	clrw	x
3253  038d 7b02          	ld	a,(OFST-2,sp)
3254  038f 97            	ld	xl,a
3255  0390 7b04          	ld	a,(OFST+0,sp)
3256  0392 01            	rrwa	x,a
3257  0393 1a03          	or	a,(OFST-1,sp)
3258  0395 01            	rrwa	x,a
3260                     ; 1007   return (uint16_t)tmpccr2;
3264  0396 5b04          	addw	sp,#4
3265  0398 87            	retf	
3316                     ; 1015 uint16_t TIM2_GetCapture3(void)
3316                     ; 1016 {
3317                     	switch	.text
3318  0399               f_TIM2_GetCapture3:
3320  0399 5204          	subw	sp,#4
3321       00000004      OFST:	set	4
3324                     ; 1018   uint16_t tmpccr3 = 0;
3326                     ; 1019   uint8_t tmpccr3l=0, tmpccr3h=0;
3330                     ; 1021   tmpccr3h = TIM2->CCR3H;
3332  039b c65313        	ld	a,21267
3333  039e 6b02          	ld	(OFST-2,sp),a
3335                     ; 1022   tmpccr3l = TIM2->CCR3L;
3337  03a0 c65314        	ld	a,21268
3338  03a3 6b01          	ld	(OFST-3,sp),a
3340                     ; 1024   tmpccr3 = (uint16_t)(tmpccr3l);
3342  03a5 5f            	clrw	x
3343  03a6 97            	ld	xl,a
3344  03a7 1f03          	ldw	(OFST-1,sp),x
3346                     ; 1025   tmpccr3 |= (uint16_t)((uint16_t)tmpccr3h << 8);
3348  03a9 5f            	clrw	x
3349  03aa 7b02          	ld	a,(OFST-2,sp)
3350  03ac 97            	ld	xl,a
3351  03ad 7b04          	ld	a,(OFST+0,sp)
3352  03af 01            	rrwa	x,a
3353  03b0 1a03          	or	a,(OFST-1,sp)
3354  03b2 01            	rrwa	x,a
3356                     ; 1027   return (uint16_t)tmpccr3;
3360  03b3 5b04          	addw	sp,#4
3361  03b5 87            	retf	
3394                     ; 1035 uint16_t TIM2_GetCounter(void)
3394                     ; 1036 {
3395                     	switch	.text
3396  03b6               f_TIM2_GetCounter:
3398  03b6 89            	pushw	x
3399       00000002      OFST:	set	2
3402                     ; 1037   uint16_t tmpcntr = 0;
3404                     ; 1039   tmpcntr =  ((uint16_t)TIM2->CNTRH << 8);
3406  03b7 c6530a        	ld	a,21258
3407  03ba 97            	ld	xl,a
3408  03bb 4f            	clr	a
3409  03bc 02            	rlwa	x,a
3410  03bd 1f01          	ldw	(OFST-1,sp),x
3412                     ; 1041   return (uint16_t)( tmpcntr| (uint16_t)(TIM2->CNTRL));
3414  03bf c6530b        	ld	a,21259
3415  03c2 5f            	clrw	x
3416  03c3 97            	ld	xl,a
3417  03c4 01            	rrwa	x,a
3418  03c5 1a02          	or	a,(OFST+0,sp)
3419  03c7 01            	rrwa	x,a
3420  03c8 1a01          	or	a,(OFST-1,sp)
3421  03ca 01            	rrwa	x,a
3424  03cb 5b02          	addw	sp,#2
3425  03cd 87            	retf	
3448                     ; 1049 TIM2_Prescaler_TypeDef TIM2_GetPrescaler(void)
3448                     ; 1050 {
3449                     	switch	.text
3450  03ce               f_TIM2_GetPrescaler:
3454                     ; 1052   return (TIM2_Prescaler_TypeDef)(TIM2->PSCR);
3456  03ce c6530c        	ld	a,21260
3459  03d1 87            	retf	
3597                     ; 1068 FlagStatus TIM2_GetFlagStatus(TIM2_FLAG_TypeDef TIM2_FLAG)
3597                     ; 1069 {
3598                     	switch	.text
3599  03d2               f_TIM2_GetFlagStatus:
3601  03d2 89            	pushw	x
3602  03d3 89            	pushw	x
3603       00000002      OFST:	set	2
3606                     ; 1070   FlagStatus bitstatus = RESET;
3608                     ; 1071   uint8_t tim2_flag_l = 0, tim2_flag_h = 0;
3612                     ; 1074   assert_param(IS_TIM2_GET_FLAG_OK(TIM2_FLAG));
3614                     ; 1076   tim2_flag_l = (uint8_t)(TIM2->SR1 & (uint8_t)TIM2_FLAG);
3616  03d4 9f            	ld	a,xl
3617  03d5 c45302        	and	a,21250
3618  03d8 6b01          	ld	(OFST-1,sp),a
3620                     ; 1077   tim2_flag_h = (uint8_t)((uint16_t)TIM2_FLAG >> 8);
3622  03da 7b03          	ld	a,(OFST+1,sp)
3623  03dc 6b02          	ld	(OFST+0,sp),a
3625                     ; 1079   if ((tim2_flag_l | (uint8_t)(TIM2->SR2 & tim2_flag_h)) != (uint8_t)RESET )
3627  03de c45303        	and	a,21251
3628  03e1 1a01          	or	a,(OFST-1,sp)
3629  03e3 2702          	jreq	L5371
3630                     ; 1081     bitstatus = SET;
3632  03e5 a601          	ld	a,#1
3635  03e7               L5371:
3636                     ; 1085     bitstatus = RESET;
3639                     ; 1087   return (FlagStatus)bitstatus;
3643  03e7 5b04          	addw	sp,#4
3644  03e9 87            	retf	
3678                     ; 1103 void TIM2_ClearFlag(TIM2_FLAG_TypeDef TIM2_FLAG)
3678                     ; 1104 {
3679                     	switch	.text
3680  03ea               f_TIM2_ClearFlag:
3684                     ; 1106   assert_param(IS_TIM2_CLEAR_FLAG_OK(TIM2_FLAG));
3686                     ; 1109   TIM2->SR1 = (uint8_t)(~((uint8_t)(TIM2_FLAG)));
3688  03ea 9f            	ld	a,xl
3689  03eb 43            	cpl	a
3690  03ec c75302        	ld	21250,a
3691                     ; 1110   TIM2->SR2 = (uint8_t)(~((uint8_t)((uint8_t)TIM2_FLAG >> 8)));
3693  03ef 35ff5303      	mov	21251,#255
3694                     ; 1111 }
3697  03f3 87            	retf	
3760                     ; 1123 ITStatus TIM2_GetITStatus(TIM2_IT_TypeDef TIM2_IT)
3760                     ; 1124 {
3761                     	switch	.text
3762  03f4               f_TIM2_GetITStatus:
3764  03f4 88            	push	a
3765  03f5 89            	pushw	x
3766       00000002      OFST:	set	2
3769                     ; 1125   ITStatus bitstatus = RESET;
3771                     ; 1126   uint8_t TIM2_itStatus = 0, TIM2_itEnable = 0;
3775                     ; 1129   assert_param(IS_TIM2_GET_IT_OK(TIM2_IT));
3777                     ; 1131   TIM2_itStatus = (uint8_t)(TIM2->SR1 & TIM2_IT);
3779  03f6 c45302        	and	a,21250
3780  03f9 6b01          	ld	(OFST-1,sp),a
3782                     ; 1133   TIM2_itEnable = (uint8_t)(TIM2->IER & TIM2_IT);
3784  03fb c65301        	ld	a,21249
3785  03fe 1403          	and	a,(OFST+1,sp)
3786  0400 6b02          	ld	(OFST+0,sp),a
3788                     ; 1135   if ((TIM2_itStatus != (uint8_t)RESET ) && (TIM2_itEnable != (uint8_t)RESET ))
3790  0402 7b01          	ld	a,(OFST-1,sp)
3791  0404 2708          	jreq	L1102
3793  0406 7b02          	ld	a,(OFST+0,sp)
3794  0408 2704          	jreq	L1102
3795                     ; 1137     bitstatus = SET;
3797  040a a601          	ld	a,#1
3800  040c 2001          	jra	L3102
3801  040e               L1102:
3802                     ; 1141     bitstatus = RESET;
3804  040e 4f            	clr	a
3806  040f               L3102:
3807                     ; 1143   return (ITStatus)(bitstatus);
3811  040f 5b03          	addw	sp,#3
3812  0411 87            	retf	
3847                     ; 1156 void TIM2_ClearITPendingBit(TIM2_IT_TypeDef TIM2_IT)
3847                     ; 1157 {
3848                     	switch	.text
3849  0412               f_TIM2_ClearITPendingBit:
3853                     ; 1159   assert_param(IS_TIM2_IT_OK(TIM2_IT));
3855                     ; 1162   TIM2->SR1 = (uint8_t)(~TIM2_IT);
3857  0412 43            	cpl	a
3858  0413 c75302        	ld	21250,a
3859                     ; 1163 }
3862  0416 87            	retf	
3913                     ; 1181 static void TI1_Config(uint8_t TIM2_ICPolarity,
3913                     ; 1182                        uint8_t TIM2_ICSelection,
3913                     ; 1183                        uint8_t TIM2_ICFilter)
3913                     ; 1184 {
3914                     	switch	.text
3915  0417               L3f_TI1_Config:
3917  0417 89            	pushw	x
3918  0418 88            	push	a
3919       00000001      OFST:	set	1
3922                     ; 1186   TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
3924  0419 72115308      	bres	21256,#0
3925                     ; 1189   TIM2->CCMR1  = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~(uint8_t)( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF )))
3925                     ; 1190                            | (uint8_t)(((TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
3927  041d 7b07          	ld	a,(OFST+6,sp)
3928  041f 97            	ld	xl,a
3929  0420 a610          	ld	a,#16
3930  0422 42            	mul	x,a
3931  0423 9f            	ld	a,xl
3932  0424 1a03          	or	a,(OFST+2,sp)
3933  0426 6b01          	ld	(OFST+0,sp),a
3935  0428 c65305        	ld	a,21253
3936  042b a40c          	and	a,#12
3937  042d 1a01          	or	a,(OFST+0,sp)
3938  042f c75305        	ld	21253,a
3939                     ; 1193   if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
3941  0432 7b02          	ld	a,(OFST+1,sp)
3942  0434 2706          	jreq	L1602
3943                     ; 1195     TIM2->CCER1 |= TIM2_CCER1_CC1P;
3945  0436 72125308      	bset	21256,#1
3947  043a 2004          	jra	L3602
3948  043c               L1602:
3949                     ; 1199     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1P);
3951  043c 72135308      	bres	21256,#1
3952  0440               L3602:
3953                     ; 1202   TIM2->CCER1 |= TIM2_CCER1_CC1E;
3955  0440 72105308      	bset	21256,#0
3956                     ; 1203 }
3959  0444 5b03          	addw	sp,#3
3960  0446 87            	retf	
4011                     ; 1221 static void TI2_Config(uint8_t TIM2_ICPolarity,
4011                     ; 1222                        uint8_t TIM2_ICSelection,
4011                     ; 1223                        uint8_t TIM2_ICFilter)
4011                     ; 1224 {
4012                     	switch	.text
4013  0447               L5f_TI2_Config:
4015  0447 89            	pushw	x
4016  0448 88            	push	a
4017       00000001      OFST:	set	1
4020                     ; 1226   TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
4022  0449 72195308      	bres	21256,#4
4023                     ; 1229   TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~(uint8_t)( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF ))) 
4023                     ; 1230                           | (uint8_t)(( (TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
4025  044d 7b07          	ld	a,(OFST+6,sp)
4026  044f 97            	ld	xl,a
4027  0450 a610          	ld	a,#16
4028  0452 42            	mul	x,a
4029  0453 9f            	ld	a,xl
4030  0454 1a03          	or	a,(OFST+2,sp)
4031  0456 6b01          	ld	(OFST+0,sp),a
4033  0458 c65306        	ld	a,21254
4034  045b a40c          	and	a,#12
4035  045d 1a01          	or	a,(OFST+0,sp)
4036  045f c75306        	ld	21254,a
4037                     ; 1234   if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4039  0462 7b02          	ld	a,(OFST+1,sp)
4040  0464 2706          	jreq	L3112
4041                     ; 1236     TIM2->CCER1 |= TIM2_CCER1_CC2P;
4043  0466 721a5308      	bset	21256,#5
4045  046a 2004          	jra	L5112
4046  046c               L3112:
4047                     ; 1240     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2P);
4049  046c 721b5308      	bres	21256,#5
4050  0470               L5112:
4051                     ; 1244   TIM2->CCER1 |= TIM2_CCER1_CC2E;
4053  0470 72185308      	bset	21256,#4
4054                     ; 1245 }
4057  0474 5b03          	addw	sp,#3
4058  0476 87            	retf	
4109                     ; 1261 static void TI3_Config(uint8_t TIM2_ICPolarity, uint8_t TIM2_ICSelection,
4109                     ; 1262                        uint8_t TIM2_ICFilter)
4109                     ; 1263 {
4110                     	switch	.text
4111  0477               L7f_TI3_Config:
4113  0477 89            	pushw	x
4114  0478 88            	push	a
4115       00000001      OFST:	set	1
4118                     ; 1265   TIM2->CCER2 &=  (uint8_t)(~TIM2_CCER2_CC3E);
4120  0479 72115309      	bres	21257,#0
4121                     ; 1268   TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF))) 
4121                     ; 1269                           | (uint8_t)(( (TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
4123  047d 7b07          	ld	a,(OFST+6,sp)
4124  047f 97            	ld	xl,a
4125  0480 a610          	ld	a,#16
4126  0482 42            	mul	x,a
4127  0483 9f            	ld	a,xl
4128  0484 1a03          	or	a,(OFST+2,sp)
4129  0486 6b01          	ld	(OFST+0,sp),a
4131  0488 c65307        	ld	a,21255
4132  048b a40c          	and	a,#12
4133  048d 1a01          	or	a,(OFST+0,sp)
4134  048f c75307        	ld	21255,a
4135                     ; 1273   if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4137  0492 7b02          	ld	a,(OFST+1,sp)
4138  0494 2706          	jreq	L5412
4139                     ; 1275     TIM2->CCER2 |= TIM2_CCER2_CC3P;
4141  0496 72125309      	bset	21257,#1
4143  049a 2004          	jra	L7412
4144  049c               L5412:
4145                     ; 1279     TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3P);
4147  049c 72135309      	bres	21257,#1
4148  04a0               L7412:
4149                     ; 1282   TIM2->CCER2 |= TIM2_CCER2_CC3E;
4151  04a0 72105309      	bset	21257,#0
4152                     ; 1283 }
4155  04a4 5b03          	addw	sp,#3
4156  04a6 87            	retf	
4168                     	xdef	f_TIM2_ClearITPendingBit
4169                     	xdef	f_TIM2_GetITStatus
4170                     	xdef	f_TIM2_ClearFlag
4171                     	xdef	f_TIM2_GetFlagStatus
4172                     	xdef	f_TIM2_GetPrescaler
4173                     	xdef	f_TIM2_GetCounter
4174                     	xdef	f_TIM2_GetCapture3
4175                     	xdef	f_TIM2_GetCapture2
4176                     	xdef	f_TIM2_GetCapture1
4177                     	xdef	f_TIM2_SetIC3Prescaler
4178                     	xdef	f_TIM2_SetIC2Prescaler
4179                     	xdef	f_TIM2_SetIC1Prescaler
4180                     	xdef	f_TIM2_SetCompare3
4181                     	xdef	f_TIM2_SetCompare2
4182                     	xdef	f_TIM2_SetCompare1
4183                     	xdef	f_TIM2_SetAutoreload
4184                     	xdef	f_TIM2_SetCounter
4185                     	xdef	f_TIM2_SelectOCxM
4186                     	xdef	f_TIM2_CCxCmd
4187                     	xdef	f_TIM2_OC3PolarityConfig
4188                     	xdef	f_TIM2_OC2PolarityConfig
4189                     	xdef	f_TIM2_OC1PolarityConfig
4190                     	xdef	f_TIM2_GenerateEvent
4191                     	xdef	f_TIM2_OC3PreloadConfig
4192                     	xdef	f_TIM2_OC2PreloadConfig
4193                     	xdef	f_TIM2_OC1PreloadConfig
4194                     	xdef	f_TIM2_ARRPreloadConfig
4195                     	xdef	f_TIM2_ForcedOC3Config
4196                     	xdef	f_TIM2_ForcedOC2Config
4197                     	xdef	f_TIM2_ForcedOC1Config
4198                     	xdef	f_TIM2_PrescalerConfig
4199                     	xdef	f_TIM2_SelectOnePulseMode
4200                     	xdef	f_TIM2_UpdateRequestConfig
4201                     	xdef	f_TIM2_UpdateDisableConfig
4202                     	xdef	f_TIM2_ITConfig
4203                     	xdef	f_TIM2_Cmd
4204                     	xdef	f_TIM2_PWMIConfig
4205                     	xdef	f_TIM2_ICInit
4206                     	xdef	f_TIM2_OC3Init
4207                     	xdef	f_TIM2_OC2Init
4208                     	xdef	f_TIM2_OC1Init
4209                     	xdef	f_TIM2_TimeBaseInit
4210                     	xdef	f_TIM2_DeInit
4229                     	end
