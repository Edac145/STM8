   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  42                     ; 49 void TIM4_DeInit(void)
  42                     ; 50 {
  43                     	switch	.text
  44  0000               f_TIM4_DeInit:
  48                     ; 51   TIM4->CR1 = TIM4_CR1_RESET_VALUE;
  50  0000 725f5340      	clr	21312
  51                     ; 52   TIM4->IER = TIM4_IER_RESET_VALUE;
  53  0004 725f5341      	clr	21313
  54                     ; 53   TIM4->CNTR = TIM4_CNTR_RESET_VALUE;
  56  0008 725f5344      	clr	21316
  57                     ; 54   TIM4->PSCR = TIM4_PSCR_RESET_VALUE;
  59  000c 725f5345      	clr	21317
  60                     ; 55   TIM4->ARR = TIM4_ARR_RESET_VALUE;
  62  0010 35ff5346      	mov	21318,#255
  63                     ; 56   TIM4->SR1 = TIM4_SR1_RESET_VALUE;
  65  0014 725f5342      	clr	21314
  66                     ; 57 }
  69  0018 87            	retf
 174                     ; 65 void TIM4_TimeBaseInit(TIM4_Prescaler_TypeDef TIM4_Prescaler, uint8_t TIM4_Period)
 174                     ; 66 {
 175                     	switch	.text
 176  0019               f_TIM4_TimeBaseInit:
 180                     ; 68   assert_param(IS_TIM4_PRESCALER_OK(TIM4_Prescaler));
 182                     ; 70   TIM4->PSCR = (uint8_t)(TIM4_Prescaler);
 184  0019 9e            	ld	a,xh
 185  001a c75345        	ld	21317,a
 186                     ; 72   TIM4->ARR = (uint8_t)(TIM4_Period);
 188  001d 9f            	ld	a,xl
 189  001e c75346        	ld	21318,a
 190                     ; 73 }
 193  0021 87            	retf
 247                     ; 81 void TIM4_Cmd(FunctionalState NewState)
 247                     ; 82 {
 248                     	switch	.text
 249  0022               f_TIM4_Cmd:
 253                     ; 84   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 255                     ; 87   if (NewState != DISABLE)
 257  0022 4d            	tnz	a
 258  0023 2706          	jreq	L511
 259                     ; 89     TIM4->CR1 |= TIM4_CR1_CEN;
 261  0025 72105340      	bset	21312,#0
 263  0029 2004          	jra	L711
 264  002b               L511:
 265                     ; 93     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_CEN);
 267  002b 72115340      	bres	21312,#0
 268  002f               L711:
 269                     ; 95 }
 272  002f 87            	retf
 329                     ; 107 void TIM4_ITConfig(TIM4_IT_TypeDef TIM4_IT, FunctionalState NewState)
 329                     ; 108 {
 330                     	switch	.text
 331  0030               f_TIM4_ITConfig:
 333  0030 89            	pushw	x
 334       00000000      OFST:	set	0
 337                     ; 110   assert_param(IS_TIM4_IT_OK(TIM4_IT));
 339                     ; 111   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 341                     ; 113   if (NewState != DISABLE)
 343  0031 9f            	ld	a,xl
 344  0032 4d            	tnz	a
 345  0033 2709          	jreq	L151
 346                     ; 116     TIM4->IER |= (uint8_t)TIM4_IT;
 348  0035 9e            	ld	a,xh
 349  0036 ca5341        	or	a,21313
 350  0039 c75341        	ld	21313,a
 352  003c 2009          	jra	L351
 353  003e               L151:
 354                     ; 121     TIM4->IER &= (uint8_t)(~TIM4_IT);
 356  003e 7b01          	ld	a,(OFST+1,sp)
 357  0040 43            	cpl	a
 358  0041 c45341        	and	a,21313
 359  0044 c75341        	ld	21313,a
 360  0047               L351:
 361                     ; 123 }
 364  0047 85            	popw	x
 365  0048 87            	retf
 400                     ; 131 void TIM4_UpdateDisableConfig(FunctionalState NewState)
 400                     ; 132 {
 401                     	switch	.text
 402  0049               f_TIM4_UpdateDisableConfig:
 406                     ; 134   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 408                     ; 137   if (NewState != DISABLE)
 410  0049 4d            	tnz	a
 411  004a 2706          	jreq	L371
 412                     ; 139     TIM4->CR1 |= TIM4_CR1_UDIS;
 414  004c 72125340      	bset	21312,#1
 416  0050 2004          	jra	L571
 417  0052               L371:
 418                     ; 143     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_UDIS);
 420  0052 72135340      	bres	21312,#1
 421  0056               L571:
 422                     ; 145 }
 425  0056 87            	retf
 482                     ; 155 void TIM4_UpdateRequestConfig(TIM4_UpdateSource_TypeDef TIM4_UpdateSource)
 482                     ; 156 {
 483                     	switch	.text
 484  0057               f_TIM4_UpdateRequestConfig:
 488                     ; 158   assert_param(IS_TIM4_UPDATE_SOURCE_OK(TIM4_UpdateSource));
 490                     ; 161   if (TIM4_UpdateSource != TIM4_UPDATESOURCE_GLOBAL)
 492  0057 4d            	tnz	a
 493  0058 2706          	jreq	L522
 494                     ; 163     TIM4->CR1 |= TIM4_CR1_URS;
 496  005a 72145340      	bset	21312,#2
 498  005e 2004          	jra	L722
 499  0060               L522:
 500                     ; 167     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_URS);
 502  0060 72155340      	bres	21312,#2
 503  0064               L722:
 504                     ; 169 }
 507  0064 87            	retf
 563                     ; 179 void TIM4_SelectOnePulseMode(TIM4_OPMode_TypeDef TIM4_OPMode)
 563                     ; 180 {
 564                     	switch	.text
 565  0065               f_TIM4_SelectOnePulseMode:
 569                     ; 182   assert_param(IS_TIM4_OPM_MODE_OK(TIM4_OPMode));
 571                     ; 185   if (TIM4_OPMode != TIM4_OPMODE_REPETITIVE)
 573  0065 4d            	tnz	a
 574  0066 2706          	jreq	L752
 575                     ; 187     TIM4->CR1 |= TIM4_CR1_OPM;
 577  0068 72165340      	bset	21312,#3
 579  006c 2004          	jra	L162
 580  006e               L752:
 581                     ; 191     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_OPM);
 583  006e 72175340      	bres	21312,#3
 584  0072               L162:
 585                     ; 193 }
 588  0072 87            	retf
 655                     ; 215 void TIM4_PrescalerConfig(TIM4_Prescaler_TypeDef Prescaler, TIM4_PSCReloadMode_TypeDef TIM4_PSCReloadMode)
 655                     ; 216 {
 656                     	switch	.text
 657  0073               f_TIM4_PrescalerConfig:
 661                     ; 218   assert_param(IS_TIM4_PRESCALER_RELOAD_OK(TIM4_PSCReloadMode));
 663                     ; 219   assert_param(IS_TIM4_PRESCALER_OK(Prescaler));
 665                     ; 222   TIM4->PSCR = (uint8_t)Prescaler;
 667  0073 9e            	ld	a,xh
 668  0074 c75345        	ld	21317,a
 669                     ; 225   TIM4->EGR = (uint8_t)TIM4_PSCReloadMode;
 671  0077 9f            	ld	a,xl
 672  0078 c75343        	ld	21315,a
 673                     ; 226 }
 676  007b 87            	retf
 711                     ; 234 void TIM4_ARRPreloadConfig(FunctionalState NewState)
 711                     ; 235 {
 712                     	switch	.text
 713  007c               f_TIM4_ARRPreloadConfig:
 717                     ; 237   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 719                     ; 240   if (NewState != DISABLE)
 721  007c 4d            	tnz	a
 722  007d 2706          	jreq	L333
 723                     ; 242     TIM4->CR1 |= TIM4_CR1_ARPE;
 725  007f 721e5340      	bset	21312,#7
 727  0083 2004          	jra	L533
 728  0085               L333:
 729                     ; 246     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_ARPE);
 731  0085 721f5340      	bres	21312,#7
 732  0089               L533:
 733                     ; 248 }
 736  0089 87            	retf
 784                     ; 257 void TIM4_GenerateEvent(TIM4_EventSource_TypeDef TIM4_EventSource)
 784                     ; 258 {
 785                     	switch	.text
 786  008a               f_TIM4_GenerateEvent:
 790                     ; 260   assert_param(IS_TIM4_EVENT_SOURCE_OK(TIM4_EventSource));
 792                     ; 263   TIM4->EGR = (uint8_t)(TIM4_EventSource);
 794  008a c75343        	ld	21315,a
 795                     ; 264 }
 798  008d 87            	retf
 831                     ; 272 void TIM4_SetCounter(uint8_t Counter)
 831                     ; 273 {
 832                     	switch	.text
 833  008e               f_TIM4_SetCounter:
 837                     ; 275   TIM4->CNTR = (uint8_t)(Counter);
 839  008e c75344        	ld	21316,a
 840                     ; 276 }
 843  0091 87            	retf
 876                     ; 284 void TIM4_SetAutoreload(uint8_t Autoreload)
 876                     ; 285 {
 877                     	switch	.text
 878  0092               f_TIM4_SetAutoreload:
 882                     ; 287   TIM4->ARR = (uint8_t)(Autoreload);
 884  0092 c75346        	ld	21318,a
 885                     ; 288 }
 888  0095 87            	retf
 910                     ; 295 uint8_t TIM4_GetCounter(void)
 910                     ; 296 {
 911                     	switch	.text
 912  0096               f_TIM4_GetCounter:
 916                     ; 298   return (uint8_t)(TIM4->CNTR);
 918  0096 c65344        	ld	a,21316
 921  0099 87            	retf
 944                     ; 306 TIM4_Prescaler_TypeDef TIM4_GetPrescaler(void)
 944                     ; 307 {
 945                     	switch	.text
 946  009a               f_TIM4_GetPrescaler:
 950                     ; 309   return (TIM4_Prescaler_TypeDef)(TIM4->PSCR);
 952  009a c65345        	ld	a,21317
 955  009d 87            	retf
1033                     ; 319 FlagStatus TIM4_GetFlagStatus(TIM4_FLAG_TypeDef TIM4_FLAG)
1033                     ; 320 {
1034                     	switch	.text
1035  009e               f_TIM4_GetFlagStatus:
1037  009e 88            	push	a
1038       00000001      OFST:	set	1
1041                     ; 321   FlagStatus bitstatus = RESET;
1043                     ; 324   assert_param(IS_TIM4_GET_FLAG_OK(TIM4_FLAG));
1045                     ; 326   if ((TIM4->SR1 & (uint8_t)TIM4_FLAG)  != 0)
1047  009f c45342        	and	a,21314
1048  00a2 2706          	jreq	L774
1049                     ; 328     bitstatus = SET;
1051  00a4 a601          	ld	a,#1
1052  00a6 6b01          	ld	(OFST+0,sp),a
1055  00a8 2002          	jra	L105
1056  00aa               L774:
1057                     ; 332     bitstatus = RESET;
1059  00aa 0f01          	clr	(OFST+0,sp)
1061  00ac               L105:
1062                     ; 334   return ((FlagStatus)bitstatus);
1064  00ac 7b01          	ld	a,(OFST+0,sp)
1067  00ae 5b01          	addw	sp,#1
1068  00b0 87            	retf
1102                     ; 344 void TIM4_ClearFlag(TIM4_FLAG_TypeDef TIM4_FLAG)
1102                     ; 345 {
1103                     	switch	.text
1104  00b1               f_TIM4_ClearFlag:
1108                     ; 347   assert_param(IS_TIM4_GET_FLAG_OK(TIM4_FLAG));
1110                     ; 350   TIM4->SR1 = (uint8_t)(~TIM4_FLAG);
1112  00b1 43            	cpl	a
1113  00b2 c75342        	ld	21314,a
1114                     ; 351 }
1117  00b5 87            	retf
1180                     ; 360 ITStatus TIM4_GetITStatus(TIM4_IT_TypeDef TIM4_IT)
1180                     ; 361 {
1181                     	switch	.text
1182  00b6               f_TIM4_GetITStatus:
1184  00b6 88            	push	a
1185  00b7 89            	pushw	x
1186       00000002      OFST:	set	2
1189                     ; 362   ITStatus bitstatus = RESET;
1191                     ; 364   uint8_t itstatus = 0x0, itenable = 0x0;
1195                     ; 367   assert_param(IS_TIM4_IT_OK(TIM4_IT));
1197                     ; 369   itstatus = (uint8_t)(TIM4->SR1 & (uint8_t)TIM4_IT);
1199  00b8 c45342        	and	a,21314
1200  00bb 6b01          	ld	(OFST-1,sp),a
1202                     ; 371   itenable = (uint8_t)(TIM4->IER & (uint8_t)TIM4_IT);
1204  00bd c65341        	ld	a,21313
1205  00c0 1403          	and	a,(OFST+1,sp)
1206  00c2 6b02          	ld	(OFST+0,sp),a
1208                     ; 373   if ((itstatus != (uint8_t)RESET ) && (itenable != (uint8_t)RESET ))
1210  00c4 0d01          	tnz	(OFST-1,sp)
1211  00c6 270a          	jreq	L355
1213  00c8 0d02          	tnz	(OFST+0,sp)
1214  00ca 2706          	jreq	L355
1215                     ; 375     bitstatus = (ITStatus)SET;
1217  00cc a601          	ld	a,#1
1218  00ce 6b02          	ld	(OFST+0,sp),a
1221  00d0 2002          	jra	L555
1222  00d2               L355:
1223                     ; 379     bitstatus = (ITStatus)RESET;
1225  00d2 0f02          	clr	(OFST+0,sp)
1227  00d4               L555:
1228                     ; 381   return ((ITStatus)bitstatus);
1230  00d4 7b02          	ld	a,(OFST+0,sp)
1233  00d6 5b03          	addw	sp,#3
1234  00d8 87            	retf
1269                     ; 391 void TIM4_ClearITPendingBit(TIM4_IT_TypeDef TIM4_IT)
1269                     ; 392 {
1270                     	switch	.text
1271  00d9               f_TIM4_ClearITPendingBit:
1275                     ; 394   assert_param(IS_TIM4_IT_OK(TIM4_IT));
1277                     ; 397   TIM4->SR1 = (uint8_t)(~TIM4_IT);
1279  00d9 43            	cpl	a
1280  00da c75342        	ld	21314,a
1281                     ; 398 }
1284  00dd 87            	retf
1296                     	xdef	f_TIM4_ClearITPendingBit
1297                     	xdef	f_TIM4_GetITStatus
1298                     	xdef	f_TIM4_ClearFlag
1299                     	xdef	f_TIM4_GetFlagStatus
1300                     	xdef	f_TIM4_GetPrescaler
1301                     	xdef	f_TIM4_GetCounter
1302                     	xdef	f_TIM4_SetAutoreload
1303                     	xdef	f_TIM4_SetCounter
1304                     	xdef	f_TIM4_GenerateEvent
1305                     	xdef	f_TIM4_ARRPreloadConfig
1306                     	xdef	f_TIM4_PrescalerConfig
1307                     	xdef	f_TIM4_SelectOnePulseMode
1308                     	xdef	f_TIM4_UpdateRequestConfig
1309                     	xdef	f_TIM4_UpdateDisableConfig
1310                     	xdef	f_TIM4_ITConfig
1311                     	xdef	f_TIM4_Cmd
1312                     	xdef	f_TIM4_TimeBaseInit
1313                     	xdef	f_TIM4_DeInit
1332                     	end
