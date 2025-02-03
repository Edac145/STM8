   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  45                     ; 67 void I2C_DeInit(void)
  45                     ; 68 {
  46                     	switch	.text
  47  0000               f_I2C_DeInit:
  51                     ; 69   I2C->CR1 = I2C_CR1_RESET_VALUE;
  53  0000 725f5210      	clr	21008
  54                     ; 70   I2C->CR2 = I2C_CR2_RESET_VALUE;
  56  0004 725f5211      	clr	21009
  57                     ; 71   I2C->FREQR = I2C_FREQR_RESET_VALUE;
  59  0008 725f5212      	clr	21010
  60                     ; 72   I2C->OARL = I2C_OARL_RESET_VALUE;
  62  000c 725f5213      	clr	21011
  63                     ; 73   I2C->OARH = I2C_OARH_RESET_VALUE;
  65  0010 725f5214      	clr	21012
  66                     ; 74   I2C->ITR = I2C_ITR_RESET_VALUE;
  68  0014 725f521a      	clr	21018
  69                     ; 75   I2C->CCRL = I2C_CCRL_RESET_VALUE;
  71  0018 725f521b      	clr	21019
  72                     ; 76   I2C->CCRH = I2C_CCRH_RESET_VALUE;
  74  001c 725f521c      	clr	21020
  75                     ; 77   I2C->TRISER = I2C_TRISER_RESET_VALUE;
  77  0020 3502521d      	mov	21021,#2
  78                     ; 78 }
  81  0024 87            	retf	
 259                     .const:	section	.text
 260  0000               L01:
 261  0000 000186a1      	dc.l	100001
 262  0004               L21:
 263  0004 000f4240      	dc.l	1000000
 264                     ; 96 void I2C_Init(uint32_t OutputClockFrequencyHz, uint16_t OwnAddress, 
 264                     ; 97               I2C_DutyCycle_TypeDef I2C_DutyCycle, I2C_Ack_TypeDef Ack, 
 264                     ; 98               I2C_AddMode_TypeDef AddMode, uint8_t InputClockFrequencyMHz )
 264                     ; 99 {
 265                     	switch	.text
 266  0025               f_I2C_Init:
 268  0025 5209          	subw	sp,#9
 269       00000009      OFST:	set	9
 272                     ; 100   uint16_t result = 0x0004;
 274                     ; 101   uint16_t tmpval = 0;
 276                     ; 102   uint8_t tmpccrh = 0;
 278  0027 0f07          	clr	(OFST-2,sp)
 280                     ; 105   assert_param(IS_I2C_ACK_OK(Ack));
 282                     ; 106   assert_param(IS_I2C_ADDMODE_OK(AddMode));
 284                     ; 107   assert_param(IS_I2C_OWN_ADDRESS_OK(OwnAddress));
 286                     ; 108   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));  
 288                     ; 109   assert_param(IS_I2C_INPUT_CLOCK_FREQ_OK(InputClockFrequencyMHz));
 290                     ; 110   assert_param(IS_I2C_OUTPUT_CLOCK_FREQ_OK(OutputClockFrequencyHz));
 292                     ; 115   I2C->FREQR &= (uint8_t)(~I2C_FREQR_FREQ);
 294  0029 c65212        	ld	a,21010
 295  002c a4c0          	and	a,#192
 296  002e c75212        	ld	21010,a
 297                     ; 117   I2C->FREQR |= InputClockFrequencyMHz;
 299  0031 c65212        	ld	a,21010
 300  0034 1a16          	or	a,(OFST+13,sp)
 301  0036 c75212        	ld	21010,a
 302                     ; 121   I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 304  0039 72115210      	bres	21008,#0
 305                     ; 124   I2C->CCRH &= (uint8_t)(~(I2C_CCRH_FS | I2C_CCRH_DUTY | I2C_CCRH_CCR));
 307  003d c6521c        	ld	a,21020
 308  0040 a430          	and	a,#48
 309  0042 c7521c        	ld	21020,a
 310                     ; 125   I2C->CCRL &= (uint8_t)(~I2C_CCRL_CCR);
 312  0045 725f521b      	clr	21019
 313                     ; 128   if (OutputClockFrequencyHz > I2C_MAX_STANDARD_FREQ) /* FAST MODE */
 315  0049 96            	ldw	x,sp
 316  004a 1c000d        	addw	x,#OFST+4
 317  004d 8d000000      	callf	d_ltor
 319  0051 ae0000        	ldw	x,#L01
 320  0054 8d000000      	callf	d_lcmp
 322  0058 2404ace500e5  	jrult	L131
 323                     ; 131     tmpccrh = I2C_CCRH_FS;
 325  005e a680          	ld	a,#128
 326  0060 6b07          	ld	(OFST-2,sp),a
 328                     ; 133     if (I2C_DutyCycle == I2C_DUTYCYCLE_2)
 330  0062 96            	ldw	x,sp
 331  0063 0d13          	tnz	(OFST+10,sp)
 332  0065 2630          	jrne	L331
 333                     ; 136       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 3));
 335  0067 1c000d        	addw	x,#OFST+4
 336  006a 8d000000      	callf	d_ltor
 338  006e a603          	ld	a,#3
 339  0070 8d000000      	callf	d_smul
 341  0074 96            	ldw	x,sp
 342  0075 5c            	incw	x
 343  0076 8d000000      	callf	d_rtol
 346  007a 7b16          	ld	a,(OFST+13,sp)
 347  007c b703          	ld	c_lreg+3,a
 348  007e 3f02          	clr	c_lreg+2
 349  0080 3f01          	clr	c_lreg+1
 350  0082 3f00          	clr	c_lreg
 351  0084 ae0004        	ldw	x,#L21
 352  0087 8d000000      	callf	d_lmul
 354  008b 96            	ldw	x,sp
 355  008c 5c            	incw	x
 356  008d 8d000000      	callf	d_ludv
 358  0091 be02          	ldw	x,c_lreg+2
 359  0093 1f08          	ldw	(OFST-1,sp),x
 362  0095 2034          	jra	L531
 363  0097               L331:
 364                     ; 141       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 25));
 366  0097 1c000d        	addw	x,#OFST+4
 367  009a 8d000000      	callf	d_ltor
 369  009e a619          	ld	a,#25
 370  00a0 8d000000      	callf	d_smul
 372  00a4 96            	ldw	x,sp
 373  00a5 5c            	incw	x
 374  00a6 8d000000      	callf	d_rtol
 377  00aa 7b16          	ld	a,(OFST+13,sp)
 378  00ac b703          	ld	c_lreg+3,a
 379  00ae 3f02          	clr	c_lreg+2
 380  00b0 3f01          	clr	c_lreg+1
 381  00b2 3f00          	clr	c_lreg
 382  00b4 ae0004        	ldw	x,#L21
 383  00b7 8d000000      	callf	d_lmul
 385  00bb 96            	ldw	x,sp
 386  00bc 5c            	incw	x
 387  00bd 8d000000      	callf	d_ludv
 389  00c1 be02          	ldw	x,c_lreg+2
 390  00c3 1f08          	ldw	(OFST-1,sp),x
 392                     ; 143       tmpccrh |= I2C_CCRH_DUTY;
 394  00c5 7b07          	ld	a,(OFST-2,sp)
 395  00c7 aa40          	or	a,#64
 396  00c9 6b07          	ld	(OFST-2,sp),a
 398  00cb               L531:
 399                     ; 147     if (result < (uint16_t)0x01)
 401  00cb 1e08          	ldw	x,(OFST-1,sp)
 402  00cd 2603          	jrne	L731
 403                     ; 150       result = (uint16_t)0x0001;
 405  00cf 5c            	incw	x
 406  00d0 1f08          	ldw	(OFST-1,sp),x
 408  00d2               L731:
 409                     ; 156     tmpval = ((InputClockFrequencyMHz * 3) / 10) + 1;
 411  00d2 7b16          	ld	a,(OFST+13,sp)
 412  00d4 97            	ld	xl,a
 413  00d5 a603          	ld	a,#3
 414  00d7 42            	mul	x,a
 415  00d8 a60a          	ld	a,#10
 416  00da 8d000000      	callf	d_sdivx
 418  00de 5c            	incw	x
 419  00df 1f05          	ldw	(OFST-4,sp),x
 421                     ; 157     I2C->TRISER = (uint8_t)tmpval;
 423  00e1 7b06          	ld	a,(OFST-3,sp)
 425  00e3 203c          	jra	L141
 426  00e5               L131:
 427                     ; 164     result = (uint16_t)((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz << (uint8_t)1));
 429  00e5 96            	ldw	x,sp
 430  00e6 1c000d        	addw	x,#OFST+4
 431  00e9 8d000000      	callf	d_ltor
 433  00ed 3803          	sll	c_lreg+3
 434  00ef 3902          	rlc	c_lreg+2
 435  00f1 3901          	rlc	c_lreg+1
 436  00f3 96            	ldw	x,sp
 437  00f4 3900          	rlc	c_lreg
 438  00f6 5c            	incw	x
 439  00f7 8d000000      	callf	d_rtol
 442  00fb 7b16          	ld	a,(OFST+13,sp)
 443  00fd b703          	ld	c_lreg+3,a
 444  00ff 3f02          	clr	c_lreg+2
 445  0101 3f01          	clr	c_lreg+1
 446  0103 3f00          	clr	c_lreg
 447  0105 ae0004        	ldw	x,#L21
 448  0108 8d000000      	callf	d_lmul
 450  010c 96            	ldw	x,sp
 451  010d 5c            	incw	x
 452  010e 8d000000      	callf	d_ludv
 454  0112 be02          	ldw	x,c_lreg+2
 456                     ; 167     if (result < (uint16_t)0x0004)
 458  0114 a30004        	cpw	x,#4
 459  0117 2403          	jruge	L341
 460                     ; 170       result = (uint16_t)0x0004;
 462  0119 ae0004        	ldw	x,#4
 464  011c               L341:
 465  011c 1f08          	ldw	(OFST-1,sp),x
 466                     ; 176     I2C->TRISER = (uint8_t)(InputClockFrequencyMHz + (uint8_t)1);
 468  011e 7b16          	ld	a,(OFST+13,sp)
 469  0120 4c            	inc	a
 470  0121               L141:
 471  0121 c7521d        	ld	21021,a
 472                     ; 181   I2C->CCRL = (uint8_t)result;
 474  0124 7b09          	ld	a,(OFST+0,sp)
 475  0126 c7521b        	ld	21019,a
 476                     ; 182   I2C->CCRH = (uint8_t)((uint8_t)((uint8_t)(result >> 8) & I2C_CCRH_CCR) | tmpccrh);
 478  0129 7b08          	ld	a,(OFST-1,sp)
 479  012b a40f          	and	a,#15
 480  012d 1a07          	or	a,(OFST-2,sp)
 481  012f c7521c        	ld	21020,a
 482                     ; 185   I2C->CR1 |= I2C_CR1_PE;
 484  0132 72105210      	bset	21008,#0
 485                     ; 188   I2C_AcknowledgeConfig(Ack);
 487  0136 7b14          	ld	a,(OFST+11,sp)
 488  0138 8da601a6      	callf	f_I2C_AcknowledgeConfig
 490                     ; 191   I2C->OARL = (uint8_t)(OwnAddress);
 492  013c 7b12          	ld	a,(OFST+9,sp)
 493  013e c75213        	ld	21011,a
 494                     ; 192   I2C->OARH = (uint8_t)((uint8_t)(AddMode | I2C_OARH_ADDCONF) |
 494                     ; 193                    (uint8_t)((OwnAddress & (uint16_t)0x0300) >> (uint8_t)7));
 496  0141 1e11          	ldw	x,(OFST+8,sp)
 497  0143 4f            	clr	a
 498  0144 01            	rrwa	x,a
 499  0145 48            	sll	a
 500  0146 01            	rrwa	x,a
 501  0147 49            	rlc	a
 502  0148 a406          	and	a,#6
 503  014a 6b04          	ld	(OFST-5,sp),a
 505  014c 7b15          	ld	a,(OFST+12,sp)
 506  014e aa40          	or	a,#64
 507  0150 1a04          	or	a,(OFST-5,sp)
 508  0152 c75214        	ld	21012,a
 509                     ; 194 }
 512  0155 5b09          	addw	sp,#9
 513  0157 87            	retf	
 567                     ; 202 void I2C_Cmd(FunctionalState NewState)
 567                     ; 203 {
 568                     	switch	.text
 569  0158               f_I2C_Cmd:
 573                     ; 205   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 575                     ; 207   if (NewState != DISABLE)
 577  0158 4d            	tnz	a
 578  0159 2705          	jreq	L371
 579                     ; 210     I2C->CR1 |= I2C_CR1_PE;
 581  015b 72105210      	bset	21008,#0
 584  015f 87            	retf	
 585  0160               L371:
 586                     ; 215     I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 588  0160 72115210      	bres	21008,#0
 589                     ; 217 }
 592  0164 87            	retf	
 626                     ; 225 void I2C_GeneralCallCmd(FunctionalState NewState)
 626                     ; 226 {
 627                     	switch	.text
 628  0165               f_I2C_GeneralCallCmd:
 632                     ; 228   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 634                     ; 230   if (NewState != DISABLE)
 636  0165 4d            	tnz	a
 637  0166 2705          	jreq	L512
 638                     ; 233     I2C->CR1 |= I2C_CR1_ENGC;
 640  0168 721c5210      	bset	21008,#6
 643  016c 87            	retf	
 644  016d               L512:
 645                     ; 238     I2C->CR1 &= (uint8_t)(~I2C_CR1_ENGC);
 647  016d 721d5210      	bres	21008,#6
 648                     ; 240 }
 651  0171 87            	retf	
 685                     ; 250 void I2C_GenerateSTART(FunctionalState NewState)
 685                     ; 251 {
 686                     	switch	.text
 687  0172               f_I2C_GenerateSTART:
 691                     ; 253   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 693                     ; 255   if (NewState != DISABLE)
 695  0172 4d            	tnz	a
 696  0173 2705          	jreq	L732
 697                     ; 258     I2C->CR2 |= I2C_CR2_START;
 699  0175 72105211      	bset	21009,#0
 702  0179 87            	retf	
 703  017a               L732:
 704                     ; 263     I2C->CR2 &= (uint8_t)(~I2C_CR2_START);
 706  017a 72115211      	bres	21009,#0
 707                     ; 265 }
 710  017e 87            	retf	
 744                     ; 273 void I2C_GenerateSTOP(FunctionalState NewState)
 744                     ; 274 {
 745                     	switch	.text
 746  017f               f_I2C_GenerateSTOP:
 750                     ; 276   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 752                     ; 278   if (NewState != DISABLE)
 754  017f 4d            	tnz	a
 755  0180 2705          	jreq	L162
 756                     ; 281     I2C->CR2 |= I2C_CR2_STOP;
 758  0182 72125211      	bset	21009,#1
 761  0186 87            	retf	
 762  0187               L162:
 763                     ; 286     I2C->CR2 &= (uint8_t)(~I2C_CR2_STOP);
 765  0187 72135211      	bres	21009,#1
 766                     ; 288 }
 769  018b 87            	retf	
 804                     ; 296 void I2C_SoftwareResetCmd(FunctionalState NewState)
 804                     ; 297 {
 805                     	switch	.text
 806  018c               f_I2C_SoftwareResetCmd:
 810                     ; 299   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 812                     ; 301   if (NewState != DISABLE)
 814  018c 4d            	tnz	a
 815  018d 2705          	jreq	L303
 816                     ; 304     I2C->CR2 |= I2C_CR2_SWRST;
 818  018f 721e5211      	bset	21009,#7
 821  0193 87            	retf	
 822  0194               L303:
 823                     ; 309     I2C->CR2 &= (uint8_t)(~I2C_CR2_SWRST);
 825  0194 721f5211      	bres	21009,#7
 826                     ; 311 }
 829  0198 87            	retf	
 864                     ; 320 void I2C_StretchClockCmd(FunctionalState NewState)
 864                     ; 321 {
 865                     	switch	.text
 866  0199               f_I2C_StretchClockCmd:
 870                     ; 323   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 872                     ; 325   if (NewState != DISABLE)
 874  0199 4d            	tnz	a
 875  019a 2705          	jreq	L523
 876                     ; 328     I2C->CR1 &= (uint8_t)(~I2C_CR1_NOSTRETCH);
 878  019c 721f5210      	bres	21008,#7
 881  01a0 87            	retf	
 882  01a1               L523:
 883                     ; 334     I2C->CR1 |= I2C_CR1_NOSTRETCH;
 885  01a1 721e5210      	bset	21008,#7
 886                     ; 336 }
 889  01a5 87            	retf	
 924                     ; 345 void I2C_AcknowledgeConfig(I2C_Ack_TypeDef Ack)
 924                     ; 346 {
 925                     	switch	.text
 926  01a6               f_I2C_AcknowledgeConfig:
 928       00000000      OFST:	set	0
 931                     ; 348   assert_param(IS_I2C_ACK_OK(Ack));
 933                     ; 350   if (Ack == I2C_ACK_NONE)
 935  01a6 4d            	tnz	a
 936  01a7 2605          	jrne	L743
 937                     ; 353     I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);
 939  01a9 72155211      	bres	21009,#2
 942  01ad 87            	retf	
 943  01ae               L743:
 944                     ; 358     I2C->CR2 |= I2C_CR2_ACK;
 946  01ae 72145211      	bset	21009,#2
 947                     ; 360     if (Ack == I2C_ACK_CURR)
 949  01b2 4a            	dec	a
 950  01b3 2605          	jrne	L353
 951                     ; 363       I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);
 953  01b5 72175211      	bres	21009,#3
 956  01b9 87            	retf	
 957  01ba               L353:
 958                     ; 368       I2C->CR2 |= I2C_CR2_POS;
 960  01ba 72165211      	bset	21009,#3
 961                     ; 371 }
 964  01be 87            	retf	
1035                     ; 381 void I2C_ITConfig(I2C_IT_TypeDef I2C_IT, FunctionalState NewState)
1035                     ; 382 {
1036                     	switch	.text
1037  01bf               f_I2C_ITConfig:
1039  01bf 89            	pushw	x
1040       00000000      OFST:	set	0
1043                     ; 384   assert_param(IS_I2C_INTERRUPT_OK(I2C_IT));
1045                     ; 385   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1047                     ; 387   if (NewState != DISABLE)
1049  01c0 9f            	ld	a,xl
1050  01c1 4d            	tnz	a
1051  01c2 2706          	jreq	L314
1052                     ; 390     I2C->ITR |= (uint8_t)I2C_IT;
1054  01c4 9e            	ld	a,xh
1055  01c5 ca521a        	or	a,21018
1057  01c8 2006          	jra	L514
1058  01ca               L314:
1059                     ; 395     I2C->ITR &= (uint8_t)(~(uint8_t)I2C_IT);
1061  01ca 7b01          	ld	a,(OFST+1,sp)
1062  01cc 43            	cpl	a
1063  01cd c4521a        	and	a,21018
1064  01d0               L514:
1065  01d0 c7521a        	ld	21018,a
1066                     ; 397 }
1069  01d3 85            	popw	x
1070  01d4 87            	retf	
1105                     ; 405 void I2C_FastModeDutyCycleConfig(I2C_DutyCycle_TypeDef I2C_DutyCycle)
1105                     ; 406 {
1106                     	switch	.text
1107  01d5               f_I2C_FastModeDutyCycleConfig:
1111                     ; 408   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));
1113                     ; 410   if (I2C_DutyCycle == I2C_DUTYCYCLE_16_9)
1115  01d5 a140          	cp	a,#64
1116  01d7 2605          	jrne	L534
1117                     ; 413     I2C->CCRH |= I2C_CCRH_DUTY;
1119  01d9 721c521c      	bset	21020,#6
1122  01dd 87            	retf	
1123  01de               L534:
1124                     ; 418     I2C->CCRH &= (uint8_t)(~I2C_CCRH_DUTY);
1126  01de 721d521c      	bres	21020,#6
1127                     ; 420 }
1130  01e2 87            	retf	
1152                     ; 427 uint8_t I2C_ReceiveData(void)
1152                     ; 428 {
1153                     	switch	.text
1154  01e3               f_I2C_ReceiveData:
1158                     ; 430   return ((uint8_t)I2C->DR);
1160  01e3 c65216        	ld	a,21014
1163  01e6 87            	retf	
1227                     ; 440 void I2C_Send7bitAddress(uint8_t Address, I2C_Direction_TypeDef Direction)
1227                     ; 441 {
1228                     	switch	.text
1229  01e7               f_I2C_Send7bitAddress:
1231  01e7 89            	pushw	x
1232       00000000      OFST:	set	0
1235                     ; 443   assert_param(IS_I2C_ADDRESS_OK(Address));
1237                     ; 444   assert_param(IS_I2C_DIRECTION_OK(Direction));
1239                     ; 447   Address &= (uint8_t)0xFE;
1241  01e8 7b01          	ld	a,(OFST+1,sp)
1242  01ea a4fe          	and	a,#254
1243  01ec 6b01          	ld	(OFST+1,sp),a
1244                     ; 450   I2C->DR = (uint8_t)(Address | (uint8_t)Direction);
1246  01ee 1a02          	or	a,(OFST+2,sp)
1247  01f0 c75216        	ld	21014,a
1248                     ; 451 }
1251  01f3 85            	popw	x
1252  01f4 87            	retf	
1285                     ; 458 void I2C_SendData(uint8_t Data)
1285                     ; 459 {
1286                     	switch	.text
1287  01f5               f_I2C_SendData:
1291                     ; 461   I2C->DR = Data;
1293  01f5 c75216        	ld	21014,a
1294                     ; 462 }
1297  01f8 87            	retf	
1520                     ; 578 ErrorStatus I2C_CheckEvent(I2C_Event_TypeDef I2C_Event)
1520                     ; 579 {
1521                     	switch	.text
1522  01f9               f_I2C_CheckEvent:
1524  01f9 89            	pushw	x
1525  01fa 5206          	subw	sp,#6
1526       00000006      OFST:	set	6
1529                     ; 580   __IO uint16_t lastevent = 0x00;
1531  01fc 5f            	clrw	x
1532  01fd 1f04          	ldw	(OFST-2,sp),x
1534                     ; 581   uint8_t flag1 = 0x00 ;
1536                     ; 582   uint8_t flag2 = 0x00;
1538                     ; 583   ErrorStatus status = ERROR;
1540                     ; 586   assert_param(IS_I2C_EVENT_OK(I2C_Event));
1542                     ; 588   if (I2C_Event == I2C_EVENT_SLAVE_ACK_FAILURE)
1544  01ff 1e07          	ldw	x,(OFST+1,sp)
1545  0201 a30004        	cpw	x,#4
1546  0204 2609          	jrne	L136
1547                     ; 590     lastevent = I2C->SR2 & I2C_SR2_AF;
1549  0206 c65218        	ld	a,21016
1550  0209 a404          	and	a,#4
1551  020b 5f            	clrw	x
1552  020c 97            	ld	xl,a
1554  020d 201a          	jra	L336
1555  020f               L136:
1556                     ; 594     flag1 = I2C->SR1;
1558  020f c65217        	ld	a,21015
1559  0212 6b03          	ld	(OFST-3,sp),a
1561                     ; 595     flag2 = I2C->SR3;
1563  0214 c65219        	ld	a,21017
1564  0217 6b06          	ld	(OFST+0,sp),a
1566                     ; 596     lastevent = ((uint16_t)((uint16_t)flag2 << (uint16_t)8) | (uint16_t)flag1);
1568  0219 5f            	clrw	x
1569  021a 7b03          	ld	a,(OFST-3,sp)
1570  021c 97            	ld	xl,a
1571  021d 1f01          	ldw	(OFST-5,sp),x
1573  021f 5f            	clrw	x
1574  0220 7b06          	ld	a,(OFST+0,sp)
1575  0222 97            	ld	xl,a
1576  0223 7b02          	ld	a,(OFST-4,sp)
1577  0225 01            	rrwa	x,a
1578  0226 1a01          	or	a,(OFST-5,sp)
1579  0228 01            	rrwa	x,a
1580  0229               L336:
1581  0229 1f04          	ldw	(OFST-2,sp),x
1583                     ; 599   if (((uint16_t)lastevent & (uint16_t)I2C_Event) == (uint16_t)I2C_Event)
1585  022b 1e04          	ldw	x,(OFST-2,sp)
1586  022d 01            	rrwa	x,a
1587  022e 1408          	and	a,(OFST+2,sp)
1588  0230 01            	rrwa	x,a
1589  0231 1407          	and	a,(OFST+1,sp)
1590  0233 01            	rrwa	x,a
1591  0234 1307          	cpw	x,(OFST+1,sp)
1592  0236 2604          	jrne	L536
1593                     ; 602     status = SUCCESS;
1595  0238 a601          	ld	a,#1
1598  023a 2001          	jra	L736
1599  023c               L536:
1600                     ; 607     status = ERROR;
1602  023c 4f            	clr	a
1604  023d               L736:
1605                     ; 611   return status;
1609  023d 5b08          	addw	sp,#8
1610  023f 87            	retf	
1662                     ; 628 I2C_Event_TypeDef I2C_GetLastEvent(void)
1662                     ; 629 {
1663                     	switch	.text
1664  0240               f_I2C_GetLastEvent:
1666  0240 5206          	subw	sp,#6
1667       00000006      OFST:	set	6
1670                     ; 630   __IO uint16_t lastevent = 0;
1672  0242 5f            	clrw	x
1673  0243 1f05          	ldw	(OFST-1,sp),x
1675                     ; 631   uint16_t flag1 = 0;
1677                     ; 632   uint16_t flag2 = 0;
1679                     ; 634   if ((I2C->SR2 & I2C_SR2_AF) != 0x00)
1681  0245 7205521805    	btjf	21016,#2,L766
1682                     ; 636     lastevent = I2C_EVENT_SLAVE_ACK_FAILURE;
1684  024a ae0004        	ldw	x,#4
1686  024d 2013          	jra	L176
1687  024f               L766:
1688                     ; 641     flag1 = I2C->SR1;
1690  024f c65217        	ld	a,21015
1691  0252 97            	ld	xl,a
1692  0253 1f01          	ldw	(OFST-5,sp),x
1694                     ; 642     flag2 = I2C->SR3;
1696  0255 c65219        	ld	a,21017
1697  0258 5f            	clrw	x
1698  0259 97            	ld	xl,a
1699  025a 1f03          	ldw	(OFST-3,sp),x
1701                     ; 645     lastevent = ((uint16_t)((uint16_t)flag2 << 8) | (uint16_t)flag1);
1703  025c 7b02          	ld	a,(OFST-4,sp)
1704  025e 01            	rrwa	x,a
1705  025f 1a01          	or	a,(OFST-5,sp)
1706  0261 01            	rrwa	x,a
1707  0262               L176:
1708  0262 1f05          	ldw	(OFST-1,sp),x
1710                     ; 648   return (I2C_Event_TypeDef)lastevent;
1712  0264 1e05          	ldw	x,(OFST-1,sp)
1715  0266 5b06          	addw	sp,#6
1716  0268 87            	retf	
1930                     ; 679 FlagStatus I2C_GetFlagStatus(I2C_Flag_TypeDef I2C_Flag)
1930                     ; 680 {
1931                     	switch	.text
1932  0269               f_I2C_GetFlagStatus:
1934  0269 89            	pushw	x
1935  026a 89            	pushw	x
1936       00000002      OFST:	set	2
1939                     ; 681   uint8_t tempreg = 0;
1941  026b 0f02          	clr	(OFST+0,sp)
1943                     ; 682   uint8_t regindex = 0;
1945                     ; 683   FlagStatus bitstatus = RESET;
1947                     ; 686   assert_param(IS_I2C_FLAG_OK(I2C_Flag));
1949                     ; 689   regindex = (uint8_t)((uint16_t)I2C_Flag >> 8);
1951  026d 9e            	ld	a,xh
1952  026e 6b01          	ld	(OFST-1,sp),a
1954                     ; 691   switch (regindex)
1957                     ; 708     default:
1957                     ; 709       break;
1958  0270 4a            	dec	a
1959  0271 2708          	jreq	L376
1960  0273 4a            	dec	a
1961  0274 270a          	jreq	L576
1962  0276 4a            	dec	a
1963  0277 270c          	jreq	L776
1964  0279 200f          	jra	L3101
1965  027b               L376:
1966                     ; 694     case 0x01:
1966                     ; 695       tempreg = (uint8_t)I2C->SR1;
1968  027b c65217        	ld	a,21015
1969                     ; 696       break;
1971  027e 2008          	jpf	LC001
1972  0280               L576:
1973                     ; 699     case 0x02:
1973                     ; 700       tempreg = (uint8_t)I2C->SR2;
1975  0280 c65218        	ld	a,21016
1976                     ; 701       break;
1978  0283 2003          	jpf	LC001
1979  0285               L776:
1980                     ; 704     case 0x03:
1980                     ; 705       tempreg = (uint8_t)I2C->SR3;
1982  0285 c65219        	ld	a,21017
1983  0288               LC001:
1984  0288 6b02          	ld	(OFST+0,sp),a
1986                     ; 706       break;
1988                     ; 708     default:
1988                     ; 709       break;
1990  028a               L3101:
1991                     ; 713   if ((tempreg & (uint8_t)I2C_Flag ) != 0)
1993  028a 7b04          	ld	a,(OFST+2,sp)
1994  028c 1502          	bcp	a,(OFST+0,sp)
1995  028e 2704          	jreq	L5101
1996                     ; 716     bitstatus = SET;
1998  0290 a601          	ld	a,#1
2001  0292 2001          	jra	L7101
2002  0294               L5101:
2003                     ; 721     bitstatus = RESET;
2005  0294 4f            	clr	a
2007  0295               L7101:
2008                     ; 724   return bitstatus;
2012  0295 5b04          	addw	sp,#4
2013  0297 87            	retf	
2056                     ; 759 void I2C_ClearFlag(I2C_Flag_TypeDef I2C_FLAG)
2056                     ; 760 {
2057                     	switch	.text
2058  0298               f_I2C_ClearFlag:
2060  0298 89            	pushw	x
2061       00000002      OFST:	set	2
2064                     ; 761   uint16_t flagpos = 0;
2066                     ; 763   assert_param(IS_I2C_CLEAR_FLAG_OK(I2C_FLAG));
2068                     ; 766   flagpos = (uint16_t)I2C_FLAG & FLAG_Mask;
2070  0299 01            	rrwa	x,a
2071  029a 5f            	clrw	x
2072  029b 02            	rlwa	x,a
2073  029c 1f01          	ldw	(OFST-1,sp),x
2075                     ; 768   I2C->SR2 = (uint8_t)((uint16_t)(~flagpos));
2077  029e 7b02          	ld	a,(OFST+0,sp)
2078  02a0 43            	cpl	a
2079  02a1 c75218        	ld	21016,a
2080                     ; 769 }
2083  02a4 85            	popw	x
2084  02a5 87            	retf	
2249                     ; 791 ITStatus I2C_GetITStatus(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2249                     ; 792 {
2250                     	switch	.text
2251  02a6               f_I2C_GetITStatus:
2253  02a6 89            	pushw	x
2254  02a7 5204          	subw	sp,#4
2255       00000004      OFST:	set	4
2258                     ; 793   ITStatus bitstatus = RESET;
2260                     ; 794   __IO uint8_t enablestatus = 0;
2262  02a9 0f03          	clr	(OFST-1,sp)
2264                     ; 795   uint16_t tempregister = 0;
2266                     ; 798     assert_param(IS_I2C_ITPENDINGBIT_OK(I2C_ITPendingBit));
2268                     ; 800   tempregister = (uint8_t)( ((uint16_t)((uint16_t)I2C_ITPendingBit & ITEN_Mask)) >> 8);
2270  02ab 9e            	ld	a,xh
2271  02ac a407          	and	a,#7
2272  02ae 5f            	clrw	x
2273  02af 97            	ld	xl,a
2274  02b0 1f01          	ldw	(OFST-3,sp),x
2276                     ; 803   enablestatus = (uint8_t)(I2C->ITR & ( uint8_t)tempregister);
2278  02b2 c6521a        	ld	a,21018
2279  02b5 1402          	and	a,(OFST-2,sp)
2280  02b7 6b03          	ld	(OFST-1,sp),a
2282                     ; 805   if ((uint16_t)((uint16_t)I2C_ITPendingBit & REGISTER_Mask) == REGISTER_SR1_Index)
2284  02b9 7b05          	ld	a,(OFST+1,sp)
2285  02bb a430          	and	a,#48
2286  02bd 97            	ld	xl,a
2287  02be 4f            	clr	a
2288  02bf 02            	rlwa	x,a
2289  02c0 a30100        	cpw	x,#256
2290  02c3 260d          	jrne	L1311
2291                     ; 808     if (((I2C->SR1 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2293  02c5 c65217        	ld	a,21015
2294  02c8 1506          	bcp	a,(OFST+2,sp)
2295  02ca 2715          	jreq	L1411
2297  02cc 0d03          	tnz	(OFST-1,sp)
2298  02ce 2711          	jreq	L1411
2299                     ; 811       bitstatus = SET;
2301  02d0 200b          	jpf	LC003
2302                     ; 816       bitstatus = RESET;
2303  02d2               L1311:
2304                     ; 822     if (((I2C->SR2 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2306  02d2 c65218        	ld	a,21016
2307  02d5 1506          	bcp	a,(OFST+2,sp)
2308  02d7 2708          	jreq	L1411
2310  02d9 0d03          	tnz	(OFST-1,sp)
2311  02db 2704          	jreq	L1411
2312                     ; 825       bitstatus = SET;
2314  02dd               LC003:
2316  02dd a601          	ld	a,#1
2319  02df 2001          	jra	L7311
2320  02e1               L1411:
2321                     ; 830       bitstatus = RESET;
2324  02e1 4f            	clr	a
2326  02e2               L7311:
2327                     ; 834   return  bitstatus;
2331  02e2 5b06          	addw	sp,#6
2332  02e4 87            	retf	
2376                     ; 871 void I2C_ClearITPendingBit(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2376                     ; 872 {
2377                     	switch	.text
2378  02e5               f_I2C_ClearITPendingBit:
2380  02e5 89            	pushw	x
2381       00000002      OFST:	set	2
2384                     ; 873   uint16_t flagpos = 0;
2386                     ; 876   assert_param(IS_I2C_CLEAR_ITPENDINGBIT_OK(I2C_ITPendingBit));
2388                     ; 879   flagpos = (uint16_t)I2C_ITPendingBit & FLAG_Mask;
2390  02e6 01            	rrwa	x,a
2391  02e7 5f            	clrw	x
2392  02e8 02            	rlwa	x,a
2393  02e9 1f01          	ldw	(OFST-1,sp),x
2395                     ; 882   I2C->SR2 = (uint8_t)((uint16_t)~flagpos);
2397  02eb 7b02          	ld	a,(OFST+0,sp)
2398  02ed 43            	cpl	a
2399  02ee c75218        	ld	21016,a
2400                     ; 883 }
2403  02f1 85            	popw	x
2404  02f2 87            	retf	
2416                     	xdef	f_I2C_ClearITPendingBit
2417                     	xdef	f_I2C_GetITStatus
2418                     	xdef	f_I2C_ClearFlag
2419                     	xdef	f_I2C_GetFlagStatus
2420                     	xdef	f_I2C_GetLastEvent
2421                     	xdef	f_I2C_CheckEvent
2422                     	xdef	f_I2C_SendData
2423                     	xdef	f_I2C_Send7bitAddress
2424                     	xdef	f_I2C_ReceiveData
2425                     	xdef	f_I2C_ITConfig
2426                     	xdef	f_I2C_FastModeDutyCycleConfig
2427                     	xdef	f_I2C_AcknowledgeConfig
2428                     	xdef	f_I2C_StretchClockCmd
2429                     	xdef	f_I2C_SoftwareResetCmd
2430                     	xdef	f_I2C_GenerateSTOP
2431                     	xdef	f_I2C_GenerateSTART
2432                     	xdef	f_I2C_GeneralCallCmd
2433                     	xdef	f_I2C_Cmd
2434                     	xdef	f_I2C_Init
2435                     	xdef	f_I2C_DeInit
2436                     	xref.b	c_lreg
2437                     	xref.b	c_x
2456                     	xref	d_sdivx
2457                     	xref	d_ludv
2458                     	xref	d_rtol
2459                     	xref	d_smul
2460                     	xref	d_lmul
2461                     	xref	d_lcmp
2462                     	xref	d_ltor
2463                     	end
