   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  45                     ; 49 void TIM4_DeInit(void)
  45                     ; 50 {
  46                     	switch	.text
  47  0000               f_TIM4_DeInit:
  51                     ; 51   TIM4->CR1 = TIM4_CR1_RESET_VALUE;
  53  0000 725f5340      	clr	21312
  54                     ; 52   TIM4->IER = TIM4_IER_RESET_VALUE;
  56  0004 725f5341      	clr	21313
  57                     ; 53   TIM4->CNTR = TIM4_CNTR_RESET_VALUE;
  59  0008 725f5344      	clr	21316
  60                     ; 54   TIM4->PSCR = TIM4_PSCR_RESET_VALUE;
  62  000c 725f5345      	clr	21317
  63                     ; 55   TIM4->ARR = TIM4_ARR_RESET_VALUE;
  65  0010 35ff5346      	mov	21318,#255
  66                     ; 56   TIM4->SR1 = TIM4_SR1_RESET_VALUE;
  68  0014 725f5342      	clr	21314
  69                     ; 57 }
  72  0018 87            	retf	
 177                     ; 65 void TIM4_TimeBaseInit(TIM4_Prescaler_TypeDef TIM4_Prescaler, uint8_t TIM4_Period)
 177                     ; 66 {
 178                     	switch	.text
 179  0019               f_TIM4_TimeBaseInit:
 183                     ; 68   assert_param(IS_TIM4_PRESCALER_OK(TIM4_Prescaler));
 185                     ; 70   TIM4->PSCR = (uint8_t)(TIM4_Prescaler);
 187  0019 9e            	ld	a,xh
 188  001a c75345        	ld	21317,a
 189                     ; 72   TIM4->ARR = (uint8_t)(TIM4_Period);
 191  001d 9f            	ld	a,xl
 192  001e c75346        	ld	21318,a
 193                     ; 73 }
 196  0021 87            	retf	
 250                     ; 81 void TIM4_Cmd(FunctionalState NewState)
 250                     ; 82 {
 251                     	switch	.text
 252  0022               f_TIM4_Cmd:
 256                     ; 84   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 258                     ; 87   if (NewState != DISABLE)
 260  0022 4d            	tnz	a
 261  0023 2705          	jreq	L511
 262                     ; 89     TIM4->CR1 |= TIM4_CR1_CEN;
 264  0025 72105340      	bset	21312,#0
 267  0029 87            	retf	
 268  002a               L511:
 269                     ; 93     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_CEN);
 271  002a 72115340      	bres	21312,#0
 272                     ; 95 }
 275  002e 87            	retf	
 332                     ; 107 void TIM4_ITConfig(TIM4_IT_TypeDef TIM4_IT, FunctionalState NewState)
 332                     ; 108 {
 333                     	switch	.text
 334  002f               f_TIM4_ITConfig:
 336  002f 89            	pushw	x
 337       00000000      OFST:	set	0
 340                     ; 110   assert_param(IS_TIM4_IT_OK(TIM4_IT));
 342                     ; 111   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 344                     ; 113   if (NewState != DISABLE)
 346  0030 9f            	ld	a,xl
 347  0031 4d            	tnz	a
 348  0032 2706          	jreq	L151
 349                     ; 116     TIM4->IER |= (uint8_t)TIM4_IT;
 351  0034 9e            	ld	a,xh
 352  0035 ca5341        	or	a,21313
 354  0038 2006          	jra	L351
 355  003a               L151:
 356                     ; 121     TIM4->IER &= (uint8_t)(~TIM4_IT);
 358  003a 7b01          	ld	a,(OFST+1,sp)
 359  003c 43            	cpl	a
 360  003d c45341        	and	a,21313
 361  0040               L351:
 362  0040 c75341        	ld	21313,a
 363                     ; 123 }
 366  0043 85            	popw	x
 367  0044 87            	retf	
 402                     ; 131 void TIM4_UpdateDisableConfig(FunctionalState NewState)
 402                     ; 132 {
 403                     	switch	.text
 404  0045               f_TIM4_UpdateDisableConfig:
 408                     ; 134   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 410                     ; 137   if (NewState != DISABLE)
 412  0045 4d            	tnz	a
 413  0046 2705          	jreq	L371
 414                     ; 139     TIM4->CR1 |= TIM4_CR1_UDIS;
 416  0048 72125340      	bset	21312,#1
 419  004c 87            	retf	
 420  004d               L371:
 421                     ; 143     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_UDIS);
 423  004d 72135340      	bres	21312,#1
 424                     ; 145 }
 427  0051 87            	retf	
 484                     ; 155 void TIM4_UpdateRequestConfig(TIM4_UpdateSource_TypeDef TIM4_UpdateSource)
 484                     ; 156 {
 485                     	switch	.text
 486  0052               f_TIM4_UpdateRequestConfig:
 490                     ; 158   assert_param(IS_TIM4_UPDATE_SOURCE_OK(TIM4_UpdateSource));
 492                     ; 161   if (TIM4_UpdateSource != TIM4_UPDATESOURCE_GLOBAL)
 494  0052 4d            	tnz	a
 495  0053 2705          	jreq	L522
 496                     ; 163     TIM4->CR1 |= TIM4_CR1_URS;
 498  0055 72145340      	bset	21312,#2
 501  0059 87            	retf	
 502  005a               L522:
 503                     ; 167     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_URS);
 505  005a 72155340      	bres	21312,#2
 506                     ; 169 }
 509  005e 87            	retf	
 565                     ; 179 void TIM4_SelectOnePulseMode(TIM4_OPMode_TypeDef TIM4_OPMode)
 565                     ; 180 {
 566                     	switch	.text
 567  005f               f_TIM4_SelectOnePulseMode:
 571                     ; 182   assert_param(IS_TIM4_OPM_MODE_OK(TIM4_OPMode));
 573                     ; 185   if (TIM4_OPMode != TIM4_OPMODE_REPETITIVE)
 575  005f 4d            	tnz	a
 576  0060 2705          	jreq	L752
 577                     ; 187     TIM4->CR1 |= TIM4_CR1_OPM;
 579  0062 72165340      	bset	21312,#3
 582  0066 87            	retf	
 583  0067               L752:
 584                     ; 191     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_OPM);
 586  0067 72175340      	bres	21312,#3
 587                     ; 193 }
 590  006b 87            	retf	
 657                     ; 215 void TIM4_PrescalerConfig(TIM4_Prescaler_TypeDef Prescaler, TIM4_PSCReloadMode_TypeDef TIM4_PSCReloadMode)
 657                     ; 216 {
 658                     	switch	.text
 659  006c               f_TIM4_PrescalerConfig:
 663                     ; 218   assert_param(IS_TIM4_PRESCALER_RELOAD_OK(TIM4_PSCReloadMode));
 665                     ; 219   assert_param(IS_TIM4_PRESCALER_OK(Prescaler));
 667                     ; 222   TIM4->PSCR = (uint8_t)Prescaler;
 669  006c 9e            	ld	a,xh
 670  006d c75345        	ld	21317,a
 671                     ; 225   TIM4->EGR = (uint8_t)TIM4_PSCReloadMode;
 673  0070 9f            	ld	a,xl
 674  0071 c75343        	ld	21315,a
 675                     ; 226 }
 678  0074 87            	retf	
 713                     ; 234 void TIM4_ARRPreloadConfig(FunctionalState NewState)
 713                     ; 235 {
 714                     	switch	.text
 715  0075               f_TIM4_ARRPreloadConfig:
 719                     ; 237   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 721                     ; 240   if (NewState != DISABLE)
 723  0075 4d            	tnz	a
 724  0076 2705          	jreq	L333
 725                     ; 242     TIM4->CR1 |= TIM4_CR1_ARPE;
 727  0078 721e5340      	bset	21312,#7
 730  007c 87            	retf	
 731  007d               L333:
 732                     ; 246     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_ARPE);
 734  007d 721f5340      	bres	21312,#7
 735                     ; 248 }
 738  0081 87            	retf	
 786                     ; 257 void TIM4_GenerateEvent(TIM4_EventSource_TypeDef TIM4_EventSource)
 786                     ; 258 {
 787                     	switch	.text
 788  0082               f_TIM4_GenerateEvent:
 792                     ; 260   assert_param(IS_TIM4_EVENT_SOURCE_OK(TIM4_EventSource));
 794                     ; 263   TIM4->EGR = (uint8_t)(TIM4_EventSource);
 796  0082 c75343        	ld	21315,a
 797                     ; 264 }
 800  0085 87            	retf	
 833                     ; 272 void TIM4_SetCounter(uint8_t Counter)
 833                     ; 273 {
 834                     	switch	.text
 835  0086               f_TIM4_SetCounter:
 839                     ; 275   TIM4->CNTR = (uint8_t)(Counter);
 841  0086 c75344        	ld	21316,a
 842                     ; 276 }
 845  0089 87            	retf	
 878                     ; 284 void TIM4_SetAutoreload(uint8_t Autoreload)
 878                     ; 285 {
 879                     	switch	.text
 880  008a               f_TIM4_SetAutoreload:
 884                     ; 287   TIM4->ARR = (uint8_t)(Autoreload);
 886  008a c75346        	ld	21318,a
 887                     ; 288 }
 890  008d 87            	retf	
 912                     ; 295 uint8_t TIM4_GetCounter(void)
 912                     ; 296 {
 913                     	switch	.text
 914  008e               f_TIM4_GetCounter:
 918                     ; 298   return (uint8_t)(TIM4->CNTR);
 920  008e c65344        	ld	a,21316
 923  0091 87            	retf	
 946                     ; 306 TIM4_Prescaler_TypeDef TIM4_GetPrescaler(void)
 946                     ; 307 {
 947                     	switch	.text
 948  0092               f_TIM4_GetPrescaler:
 952                     ; 309   return (TIM4_Prescaler_TypeDef)(TIM4->PSCR);
 954  0092 c65345        	ld	a,21317
 957  0095 87            	retf	
1035                     ; 319 FlagStatus TIM4_GetFlagStatus(TIM4_FLAG_TypeDef TIM4_FLAG)
1035                     ; 320 {
1036                     	switch	.text
1037  0096               f_TIM4_GetFlagStatus:
1039       00000001      OFST:	set	1
1042                     ; 321   FlagStatus bitstatus = RESET;
1044                     ; 324   assert_param(IS_TIM4_GET_FLAG_OK(TIM4_FLAG));
1046                     ; 326   if ((TIM4->SR1 & (uint8_t)TIM4_FLAG)  != 0)
1048  0096 c45342        	and	a,21314
1049  0099 2702          	jreq	L774
1050                     ; 328     bitstatus = SET;
1052  009b a601          	ld	a,#1
1055  009d               L774:
1056                     ; 332     bitstatus = RESET;
1059                     ; 334   return ((FlagStatus)bitstatus);
1063  009d 87            	retf	
1097                     ; 344 void TIM4_ClearFlag(TIM4_FLAG_TypeDef TIM4_FLAG)
1097                     ; 345 {
1098                     	switch	.text
1099  009e               f_TIM4_ClearFlag:
1103                     ; 347   assert_param(IS_TIM4_GET_FLAG_OK(TIM4_FLAG));
1105                     ; 350   TIM4->SR1 = (uint8_t)(~TIM4_FLAG);
1107  009e 43            	cpl	a
1108  009f c75342        	ld	21314,a
1109                     ; 351 }
1112  00a2 87            	retf	
1175                     ; 360 ITStatus TIM4_GetITStatus(TIM4_IT_TypeDef TIM4_IT)
1175                     ; 361 {
1176                     	switch	.text
1177  00a3               f_TIM4_GetITStatus:
1179  00a3 88            	push	a
1180  00a4 89            	pushw	x
1181       00000002      OFST:	set	2
1184                     ; 362   ITStatus bitstatus = RESET;
1186                     ; 364   uint8_t itstatus = 0x0, itenable = 0x0;
1190                     ; 367   assert_param(IS_TIM4_IT_OK(TIM4_IT));
1192                     ; 369   itstatus = (uint8_t)(TIM4->SR1 & (uint8_t)TIM4_IT);
1194  00a5 c45342        	and	a,21314
1195  00a8 6b01          	ld	(OFST-1,sp),a
1197                     ; 371   itenable = (uint8_t)(TIM4->IER & (uint8_t)TIM4_IT);
1199  00aa c65341        	ld	a,21313
1200  00ad 1403          	and	a,(OFST+1,sp)
1201  00af 6b02          	ld	(OFST+0,sp),a
1203                     ; 373   if ((itstatus != (uint8_t)RESET ) && (itenable != (uint8_t)RESET ))
1205  00b1 7b01          	ld	a,(OFST-1,sp)
1206  00b3 2708          	jreq	L355
1208  00b5 7b02          	ld	a,(OFST+0,sp)
1209  00b7 2704          	jreq	L355
1210                     ; 375     bitstatus = (ITStatus)SET;
1212  00b9 a601          	ld	a,#1
1215  00bb 2001          	jra	L555
1216  00bd               L355:
1217                     ; 379     bitstatus = (ITStatus)RESET;
1219  00bd 4f            	clr	a
1221  00be               L555:
1222                     ; 381   return ((ITStatus)bitstatus);
1226  00be 5b03          	addw	sp,#3
1227  00c0 87            	retf	
1262                     ; 391 void TIM4_ClearITPendingBit(TIM4_IT_TypeDef TIM4_IT)
1262                     ; 392 {
1263                     	switch	.text
1264  00c1               f_TIM4_ClearITPendingBit:
1268                     ; 394   assert_param(IS_TIM4_IT_OK(TIM4_IT));
1270                     ; 397   TIM4->SR1 = (uint8_t)(~TIM4_IT);
1272  00c1 43            	cpl	a
1273  00c2 c75342        	ld	21314,a
1274                     ; 398 }
1277  00c5 87            	retf	
1289                     	xdef	f_TIM4_ClearITPendingBit
1290                     	xdef	f_TIM4_GetITStatus
1291                     	xdef	f_TIM4_ClearFlag
1292                     	xdef	f_TIM4_GetFlagStatus
1293                     	xdef	f_TIM4_GetPrescaler
1294                     	xdef	f_TIM4_GetCounter
1295                     	xdef	f_TIM4_SetAutoreload
1296                     	xdef	f_TIM4_SetCounter
1297                     	xdef	f_TIM4_GenerateEvent
1298                     	xdef	f_TIM4_ARRPreloadConfig
1299                     	xdef	f_TIM4_PrescalerConfig
1300                     	xdef	f_TIM4_SelectOnePulseMode
1301                     	xdef	f_TIM4_UpdateRequestConfig
1302                     	xdef	f_TIM4_UpdateDisableConfig
1303                     	xdef	f_TIM4_ITConfig
1304                     	xdef	f_TIM4_Cmd
1305                     	xdef	f_TIM4_TimeBaseInit
1306                     	xdef	f_TIM4_DeInit
1325                     	end
