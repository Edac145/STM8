   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  42                     ; 67 void I2C_DeInit(void)
  42                     ; 68 {
  43                     	switch	.text
  44  0000               f_I2C_DeInit:
  48                     ; 69   I2C->CR1 = I2C_CR1_RESET_VALUE;
  50  0000 725f5210      	clr	21008
  51                     ; 70   I2C->CR2 = I2C_CR2_RESET_VALUE;
  53  0004 725f5211      	clr	21009
  54                     ; 71   I2C->FREQR = I2C_FREQR_RESET_VALUE;
  56  0008 725f5212      	clr	21010
  57                     ; 72   I2C->OARL = I2C_OARL_RESET_VALUE;
  59  000c 725f5213      	clr	21011
  60                     ; 73   I2C->OARH = I2C_OARH_RESET_VALUE;
  62  0010 725f5214      	clr	21012
  63                     ; 74   I2C->ITR = I2C_ITR_RESET_VALUE;
  65  0014 725f521a      	clr	21018
  66                     ; 75   I2C->CCRL = I2C_CCRL_RESET_VALUE;
  68  0018 725f521b      	clr	21019
  69                     ; 76   I2C->CCRH = I2C_CCRH_RESET_VALUE;
  71  001c 725f521c      	clr	21020
  72                     ; 77   I2C->TRISER = I2C_TRISER_RESET_VALUE;
  74  0020 3502521d      	mov	21021,#2
  75                     ; 78 }
  78  0024 87            	retf
 256                     .const:	section	.text
 257  0000               L01:
 258  0000 000186a1      	dc.l	100001
 259  0004               L21:
 260  0004 000f4240      	dc.l	1000000
 261                     ; 96 void I2C_Init(uint32_t OutputClockFrequencyHz, uint16_t OwnAddress, 
 261                     ; 97               I2C_DutyCycle_TypeDef I2C_DutyCycle, I2C_Ack_TypeDef Ack, 
 261                     ; 98               I2C_AddMode_TypeDef AddMode, uint8_t InputClockFrequencyMHz )
 261                     ; 99 {
 262                     	switch	.text
 263  0025               f_I2C_Init:
 265  0025 5209          	subw	sp,#9
 266       00000009      OFST:	set	9
 269                     ; 100   uint16_t result = 0x0004;
 271                     ; 101   uint16_t tmpval = 0;
 273                     ; 102   uint8_t tmpccrh = 0;
 275  0027 0f07          	clr	(OFST-2,sp)
 277                     ; 105   assert_param(IS_I2C_ACK_OK(Ack));
 279                     ; 106   assert_param(IS_I2C_ADDMODE_OK(AddMode));
 281                     ; 107   assert_param(IS_I2C_OWN_ADDRESS_OK(OwnAddress));
 283                     ; 108   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));  
 285                     ; 109   assert_param(IS_I2C_INPUT_CLOCK_FREQ_OK(InputClockFrequencyMHz));
 287                     ; 110   assert_param(IS_I2C_OUTPUT_CLOCK_FREQ_OK(OutputClockFrequencyHz));
 289                     ; 115   I2C->FREQR &= (uint8_t)(~I2C_FREQR_FREQ);
 291  0029 c65212        	ld	a,21010
 292  002c a4c0          	and	a,#192
 293  002e c75212        	ld	21010,a
 294                     ; 117   I2C->FREQR |= InputClockFrequencyMHz;
 296  0031 c65212        	ld	a,21010
 297  0034 1a16          	or	a,(OFST+13,sp)
 298  0036 c75212        	ld	21010,a
 299                     ; 121   I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 301  0039 72115210      	bres	21008,#0
 302                     ; 124   I2C->CCRH &= (uint8_t)(~(I2C_CCRH_FS | I2C_CCRH_DUTY | I2C_CCRH_CCR));
 304  003d c6521c        	ld	a,21020
 305  0040 a430          	and	a,#48
 306  0042 c7521c        	ld	21020,a
 307                     ; 125   I2C->CCRL &= (uint8_t)(~I2C_CCRL_CCR);
 309  0045 725f521b      	clr	21019
 310                     ; 128   if (OutputClockFrequencyHz > I2C_MAX_STANDARD_FREQ) /* FAST MODE */
 312  0049 96            	ldw	x,sp
 313  004a 1c000d        	addw	x,#OFST+4
 314  004d 8d000000      	callf	d_ltor
 316  0051 ae0000        	ldw	x,#L01
 317  0054 8d000000      	callf	d_lcmp
 319  0058 2404          	jruge	L41
 320  005a acf300f3      	jpf	L131
 321  005e               L41:
 322                     ; 131     tmpccrh = I2C_CCRH_FS;
 324  005e a680          	ld	a,#128
 325  0060 6b07          	ld	(OFST-2,sp),a
 327                     ; 133     if (I2C_DutyCycle == I2C_DUTYCYCLE_2)
 329  0062 0d13          	tnz	(OFST+10,sp)
 330  0064 2635          	jrne	L331
 331                     ; 136       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 3));
 333  0066 96            	ldw	x,sp
 334  0067 1c000d        	addw	x,#OFST+4
 335  006a 8d000000      	callf	d_ltor
 337  006e a603          	ld	a,#3
 338  0070 8d000000      	callf	d_smul
 340  0074 96            	ldw	x,sp
 341  0075 1c0001        	addw	x,#OFST-8
 342  0078 8d000000      	callf	d_rtol
 345  007c 7b16          	ld	a,(OFST+13,sp)
 346  007e b703          	ld	c_lreg+3,a
 347  0080 3f02          	clr	c_lreg+2
 348  0082 3f01          	clr	c_lreg+1
 349  0084 3f00          	clr	c_lreg
 350  0086 ae0004        	ldw	x,#L21
 351  0089 8d000000      	callf	d_lmul
 353  008d 96            	ldw	x,sp
 354  008e 1c0001        	addw	x,#OFST-8
 355  0091 8d000000      	callf	d_ludv
 357  0095 be02          	ldw	x,c_lreg+2
 358  0097 1f08          	ldw	(OFST-1,sp),x
 361  0099 2039          	jra	L531
 362  009b               L331:
 363                     ; 141       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 25));
 365  009b 96            	ldw	x,sp
 366  009c 1c000d        	addw	x,#OFST+4
 367  009f 8d000000      	callf	d_ltor
 369  00a3 a619          	ld	a,#25
 370  00a5 8d000000      	callf	d_smul
 372  00a9 96            	ldw	x,sp
 373  00aa 1c0001        	addw	x,#OFST-8
 374  00ad 8d000000      	callf	d_rtol
 377  00b1 7b16          	ld	a,(OFST+13,sp)
 378  00b3 b703          	ld	c_lreg+3,a
 379  00b5 3f02          	clr	c_lreg+2
 380  00b7 3f01          	clr	c_lreg+1
 381  00b9 3f00          	clr	c_lreg
 382  00bb ae0004        	ldw	x,#L21
 383  00be 8d000000      	callf	d_lmul
 385  00c2 96            	ldw	x,sp
 386  00c3 1c0001        	addw	x,#OFST-8
 387  00c6 8d000000      	callf	d_ludv
 389  00ca be02          	ldw	x,c_lreg+2
 390  00cc 1f08          	ldw	(OFST-1,sp),x
 392                     ; 143       tmpccrh |= I2C_CCRH_DUTY;
 394  00ce 7b07          	ld	a,(OFST-2,sp)
 395  00d0 aa40          	or	a,#64
 396  00d2 6b07          	ld	(OFST-2,sp),a
 398  00d4               L531:
 399                     ; 147     if (result < (uint16_t)0x01)
 401  00d4 1e08          	ldw	x,(OFST-1,sp)
 402  00d6 2605          	jrne	L731
 403                     ; 150       result = (uint16_t)0x0001;
 405  00d8 ae0001        	ldw	x,#1
 406  00db 1f08          	ldw	(OFST-1,sp),x
 408  00dd               L731:
 409                     ; 156     tmpval = ((InputClockFrequencyMHz * 3) / 10) + 1;
 411  00dd 7b16          	ld	a,(OFST+13,sp)
 412  00df 97            	ld	xl,a
 413  00e0 a603          	ld	a,#3
 414  00e2 42            	mul	x,a
 415  00e3 a60a          	ld	a,#10
 416  00e5 8d000000      	callf	d_sdivx
 418  00e9 5c            	incw	x
 419  00ea 1f05          	ldw	(OFST-4,sp),x
 421                     ; 157     I2C->TRISER = (uint8_t)tmpval;
 423  00ec 7b06          	ld	a,(OFST-3,sp)
 424  00ee c7521d        	ld	21021,a
 426  00f1 2047          	jra	L141
 427  00f3               L131:
 428                     ; 164     result = (uint16_t)((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz << (uint8_t)1));
 430  00f3 96            	ldw	x,sp
 431  00f4 1c000d        	addw	x,#OFST+4
 432  00f7 8d000000      	callf	d_ltor
 434  00fb 3803          	sll	c_lreg+3
 435  00fd 3902          	rlc	c_lreg+2
 436  00ff 3901          	rlc	c_lreg+1
 437  0101 3900          	rlc	c_lreg
 438  0103 96            	ldw	x,sp
 439  0104 1c0001        	addw	x,#OFST-8
 440  0107 8d000000      	callf	d_rtol
 443  010b 7b16          	ld	a,(OFST+13,sp)
 444  010d b703          	ld	c_lreg+3,a
 445  010f 3f02          	clr	c_lreg+2
 446  0111 3f01          	clr	c_lreg+1
 447  0113 3f00          	clr	c_lreg
 448  0115 ae0004        	ldw	x,#L21
 449  0118 8d000000      	callf	d_lmul
 451  011c 96            	ldw	x,sp
 452  011d 1c0001        	addw	x,#OFST-8
 453  0120 8d000000      	callf	d_ludv
 455  0124 be02          	ldw	x,c_lreg+2
 456  0126 1f08          	ldw	(OFST-1,sp),x
 458                     ; 167     if (result < (uint16_t)0x0004)
 460  0128 1e08          	ldw	x,(OFST-1,sp)
 461  012a a30004        	cpw	x,#4
 462  012d 2405          	jruge	L341
 463                     ; 170       result = (uint16_t)0x0004;
 465  012f ae0004        	ldw	x,#4
 466  0132 1f08          	ldw	(OFST-1,sp),x
 468  0134               L341:
 469                     ; 176     I2C->TRISER = (uint8_t)(InputClockFrequencyMHz + (uint8_t)1);
 471  0134 7b16          	ld	a,(OFST+13,sp)
 472  0136 4c            	inc	a
 473  0137 c7521d        	ld	21021,a
 474  013a               L141:
 475                     ; 181   I2C->CCRL = (uint8_t)result;
 477  013a 7b09          	ld	a,(OFST+0,sp)
 478  013c c7521b        	ld	21019,a
 479                     ; 182   I2C->CCRH = (uint8_t)((uint8_t)((uint8_t)(result >> 8) & I2C_CCRH_CCR) | tmpccrh);
 481  013f 7b08          	ld	a,(OFST-1,sp)
 482  0141 a40f          	and	a,#15
 483  0143 1a07          	or	a,(OFST-2,sp)
 484  0145 c7521c        	ld	21020,a
 485                     ; 185   I2C->CR1 |= I2C_CR1_PE;
 487  0148 72105210      	bset	21008,#0
 488                     ; 188   I2C_AcknowledgeConfig(Ack);
 490  014c 7b14          	ld	a,(OFST+11,sp)
 491  014e 8dc301c3      	callf	f_I2C_AcknowledgeConfig
 493                     ; 191   I2C->OARL = (uint8_t)(OwnAddress);
 495  0152 7b12          	ld	a,(OFST+9,sp)
 496  0154 c75213        	ld	21011,a
 497                     ; 192   I2C->OARH = (uint8_t)((uint8_t)(AddMode | I2C_OARH_ADDCONF) |
 497                     ; 193                    (uint8_t)((OwnAddress & (uint16_t)0x0300) >> (uint8_t)7));
 499  0157 1e11          	ldw	x,(OFST+8,sp)
 500  0159 4f            	clr	a
 501  015a 01            	rrwa	x,a
 502  015b 48            	sll	a
 503  015c 59            	rlcw	x
 504  015d 01            	rrwa	x,a
 505  015e a406          	and	a,#6
 506  0160 5f            	clrw	x
 507  0161 6b04          	ld	(OFST-5,sp),a
 509  0163 7b15          	ld	a,(OFST+12,sp)
 510  0165 aa40          	or	a,#64
 511  0167 1a04          	or	a,(OFST-5,sp)
 512  0169 c75214        	ld	21012,a
 513                     ; 194 }
 516  016c 5b09          	addw	sp,#9
 517  016e 87            	retf
 571                     ; 202 void I2C_Cmd(FunctionalState NewState)
 571                     ; 203 {
 572                     	switch	.text
 573  016f               f_I2C_Cmd:
 577                     ; 205   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 579                     ; 207   if (NewState != DISABLE)
 581  016f 4d            	tnz	a
 582  0170 2706          	jreq	L371
 583                     ; 210     I2C->CR1 |= I2C_CR1_PE;
 585  0172 72105210      	bset	21008,#0
 587  0176 2004          	jra	L571
 588  0178               L371:
 589                     ; 215     I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 591  0178 72115210      	bres	21008,#0
 592  017c               L571:
 593                     ; 217 }
 596  017c 87            	retf
 630                     ; 225 void I2C_GeneralCallCmd(FunctionalState NewState)
 630                     ; 226 {
 631                     	switch	.text
 632  017d               f_I2C_GeneralCallCmd:
 636                     ; 228   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 638                     ; 230   if (NewState != DISABLE)
 640  017d 4d            	tnz	a
 641  017e 2706          	jreq	L512
 642                     ; 233     I2C->CR1 |= I2C_CR1_ENGC;
 644  0180 721c5210      	bset	21008,#6
 646  0184 2004          	jra	L712
 647  0186               L512:
 648                     ; 238     I2C->CR1 &= (uint8_t)(~I2C_CR1_ENGC);
 650  0186 721d5210      	bres	21008,#6
 651  018a               L712:
 652                     ; 240 }
 655  018a 87            	retf
 689                     ; 250 void I2C_GenerateSTART(FunctionalState NewState)
 689                     ; 251 {
 690                     	switch	.text
 691  018b               f_I2C_GenerateSTART:
 695                     ; 253   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 697                     ; 255   if (NewState != DISABLE)
 699  018b 4d            	tnz	a
 700  018c 2706          	jreq	L732
 701                     ; 258     I2C->CR2 |= I2C_CR2_START;
 703  018e 72105211      	bset	21009,#0
 705  0192 2004          	jra	L142
 706  0194               L732:
 707                     ; 263     I2C->CR2 &= (uint8_t)(~I2C_CR2_START);
 709  0194 72115211      	bres	21009,#0
 710  0198               L142:
 711                     ; 265 }
 714  0198 87            	retf
 748                     ; 273 void I2C_GenerateSTOP(FunctionalState NewState)
 748                     ; 274 {
 749                     	switch	.text
 750  0199               f_I2C_GenerateSTOP:
 754                     ; 276   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 756                     ; 278   if (NewState != DISABLE)
 758  0199 4d            	tnz	a
 759  019a 2706          	jreq	L162
 760                     ; 281     I2C->CR2 |= I2C_CR2_STOP;
 762  019c 72125211      	bset	21009,#1
 764  01a0 2004          	jra	L362
 765  01a2               L162:
 766                     ; 286     I2C->CR2 &= (uint8_t)(~I2C_CR2_STOP);
 768  01a2 72135211      	bres	21009,#1
 769  01a6               L362:
 770                     ; 288 }
 773  01a6 87            	retf
 808                     ; 296 void I2C_SoftwareResetCmd(FunctionalState NewState)
 808                     ; 297 {
 809                     	switch	.text
 810  01a7               f_I2C_SoftwareResetCmd:
 814                     ; 299   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 816                     ; 301   if (NewState != DISABLE)
 818  01a7 4d            	tnz	a
 819  01a8 2706          	jreq	L303
 820                     ; 304     I2C->CR2 |= I2C_CR2_SWRST;
 822  01aa 721e5211      	bset	21009,#7
 824  01ae 2004          	jra	L503
 825  01b0               L303:
 826                     ; 309     I2C->CR2 &= (uint8_t)(~I2C_CR2_SWRST);
 828  01b0 721f5211      	bres	21009,#7
 829  01b4               L503:
 830                     ; 311 }
 833  01b4 87            	retf
 868                     ; 320 void I2C_StretchClockCmd(FunctionalState NewState)
 868                     ; 321 {
 869                     	switch	.text
 870  01b5               f_I2C_StretchClockCmd:
 874                     ; 323   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 876                     ; 325   if (NewState != DISABLE)
 878  01b5 4d            	tnz	a
 879  01b6 2706          	jreq	L523
 880                     ; 328     I2C->CR1 &= (uint8_t)(~I2C_CR1_NOSTRETCH);
 882  01b8 721f5210      	bres	21008,#7
 884  01bc 2004          	jra	L723
 885  01be               L523:
 886                     ; 334     I2C->CR1 |= I2C_CR1_NOSTRETCH;
 888  01be 721e5210      	bset	21008,#7
 889  01c2               L723:
 890                     ; 336 }
 893  01c2 87            	retf
 928                     ; 345 void I2C_AcknowledgeConfig(I2C_Ack_TypeDef Ack)
 928                     ; 346 {
 929                     	switch	.text
 930  01c3               f_I2C_AcknowledgeConfig:
 932  01c3 88            	push	a
 933       00000000      OFST:	set	0
 936                     ; 348   assert_param(IS_I2C_ACK_OK(Ack));
 938                     ; 350   if (Ack == I2C_ACK_NONE)
 940  01c4 4d            	tnz	a
 941  01c5 2606          	jrne	L743
 942                     ; 353     I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);
 944  01c7 72155211      	bres	21009,#2
 946  01cb 2014          	jra	L153
 947  01cd               L743:
 948                     ; 358     I2C->CR2 |= I2C_CR2_ACK;
 950  01cd 72145211      	bset	21009,#2
 951                     ; 360     if (Ack == I2C_ACK_CURR)
 953  01d1 7b01          	ld	a,(OFST+1,sp)
 954  01d3 a101          	cp	a,#1
 955  01d5 2606          	jrne	L353
 956                     ; 363       I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);
 958  01d7 72175211      	bres	21009,#3
 960  01db 2004          	jra	L153
 961  01dd               L353:
 962                     ; 368       I2C->CR2 |= I2C_CR2_POS;
 964  01dd 72165211      	bset	21009,#3
 965  01e1               L153:
 966                     ; 371 }
 969  01e1 84            	pop	a
 970  01e2 87            	retf
1041                     ; 381 void I2C_ITConfig(I2C_IT_TypeDef I2C_IT, FunctionalState NewState)
1041                     ; 382 {
1042                     	switch	.text
1043  01e3               f_I2C_ITConfig:
1045  01e3 89            	pushw	x
1046       00000000      OFST:	set	0
1049                     ; 384   assert_param(IS_I2C_INTERRUPT_OK(I2C_IT));
1051                     ; 385   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1053                     ; 387   if (NewState != DISABLE)
1055  01e4 9f            	ld	a,xl
1056  01e5 4d            	tnz	a
1057  01e6 2709          	jreq	L314
1058                     ; 390     I2C->ITR |= (uint8_t)I2C_IT;
1060  01e8 9e            	ld	a,xh
1061  01e9 ca521a        	or	a,21018
1062  01ec c7521a        	ld	21018,a
1064  01ef 2009          	jra	L514
1065  01f1               L314:
1066                     ; 395     I2C->ITR &= (uint8_t)(~(uint8_t)I2C_IT);
1068  01f1 7b01          	ld	a,(OFST+1,sp)
1069  01f3 43            	cpl	a
1070  01f4 c4521a        	and	a,21018
1071  01f7 c7521a        	ld	21018,a
1072  01fa               L514:
1073                     ; 397 }
1076  01fa 85            	popw	x
1077  01fb 87            	retf
1112                     ; 405 void I2C_FastModeDutyCycleConfig(I2C_DutyCycle_TypeDef I2C_DutyCycle)
1112                     ; 406 {
1113                     	switch	.text
1114  01fc               f_I2C_FastModeDutyCycleConfig:
1118                     ; 408   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));
1120                     ; 410   if (I2C_DutyCycle == I2C_DUTYCYCLE_16_9)
1122  01fc a140          	cp	a,#64
1123  01fe 2606          	jrne	L534
1124                     ; 413     I2C->CCRH |= I2C_CCRH_DUTY;
1126  0200 721c521c      	bset	21020,#6
1128  0204 2004          	jra	L734
1129  0206               L534:
1130                     ; 418     I2C->CCRH &= (uint8_t)(~I2C_CCRH_DUTY);
1132  0206 721d521c      	bres	21020,#6
1133  020a               L734:
1134                     ; 420 }
1137  020a 87            	retf
1159                     ; 427 uint8_t I2C_ReceiveData(void)
1159                     ; 428 {
1160                     	switch	.text
1161  020b               f_I2C_ReceiveData:
1165                     ; 430   return ((uint8_t)I2C->DR);
1167  020b c65216        	ld	a,21014
1170  020e 87            	retf
1234                     ; 440 void I2C_Send7bitAddress(uint8_t Address, I2C_Direction_TypeDef Direction)
1234                     ; 441 {
1235                     	switch	.text
1236  020f               f_I2C_Send7bitAddress:
1238  020f 89            	pushw	x
1239       00000000      OFST:	set	0
1242                     ; 443   assert_param(IS_I2C_ADDRESS_OK(Address));
1244                     ; 444   assert_param(IS_I2C_DIRECTION_OK(Direction));
1246                     ; 447   Address &= (uint8_t)0xFE;
1248  0210 7b01          	ld	a,(OFST+1,sp)
1249  0212 a4fe          	and	a,#254
1250  0214 6b01          	ld	(OFST+1,sp),a
1251                     ; 450   I2C->DR = (uint8_t)(Address | (uint8_t)Direction);
1253  0216 7b01          	ld	a,(OFST+1,sp)
1254  0218 1a02          	or	a,(OFST+2,sp)
1255  021a c75216        	ld	21014,a
1256                     ; 451 }
1259  021d 85            	popw	x
1260  021e 87            	retf
1293                     ; 458 void I2C_SendData(uint8_t Data)
1293                     ; 459 {
1294                     	switch	.text
1295  021f               f_I2C_SendData:
1299                     ; 461   I2C->DR = Data;
1301  021f c75216        	ld	21014,a
1302                     ; 462 }
1305  0222 87            	retf
1528                     ; 578 ErrorStatus I2C_CheckEvent(I2C_Event_TypeDef I2C_Event)
1528                     ; 579 {
1529                     	switch	.text
1530  0223               f_I2C_CheckEvent:
1532  0223 89            	pushw	x
1533  0224 5206          	subw	sp,#6
1534       00000006      OFST:	set	6
1537                     ; 580   __IO uint16_t lastevent = 0x00;
1539  0226 5f            	clrw	x
1540  0227 1f04          	ldw	(OFST-2,sp),x
1542                     ; 581   uint8_t flag1 = 0x00 ;
1544                     ; 582   uint8_t flag2 = 0x00;
1546                     ; 583   ErrorStatus status = ERROR;
1548                     ; 586   assert_param(IS_I2C_EVENT_OK(I2C_Event));
1550                     ; 588   if (I2C_Event == I2C_EVENT_SLAVE_ACK_FAILURE)
1552  0229 1e07          	ldw	x,(OFST+1,sp)
1553  022b a30004        	cpw	x,#4
1554  022e 260b          	jrne	L136
1555                     ; 590     lastevent = I2C->SR2 & I2C_SR2_AF;
1557  0230 c65218        	ld	a,21016
1558  0233 a404          	and	a,#4
1559  0235 5f            	clrw	x
1560  0236 97            	ld	xl,a
1561  0237 1f04          	ldw	(OFST-2,sp),x
1564  0239 201f          	jra	L336
1565  023b               L136:
1566                     ; 594     flag1 = I2C->SR1;
1568  023b c65217        	ld	a,21015
1569  023e 6b03          	ld	(OFST-3,sp),a
1571                     ; 595     flag2 = I2C->SR3;
1573  0240 c65219        	ld	a,21017
1574  0243 6b06          	ld	(OFST+0,sp),a
1576                     ; 596     lastevent = ((uint16_t)((uint16_t)flag2 << (uint16_t)8) | (uint16_t)flag1);
1578  0245 7b03          	ld	a,(OFST-3,sp)
1579  0247 5f            	clrw	x
1580  0248 97            	ld	xl,a
1581  0249 1f01          	ldw	(OFST-5,sp),x
1583  024b 7b06          	ld	a,(OFST+0,sp)
1584  024d 5f            	clrw	x
1585  024e 97            	ld	xl,a
1586  024f 4f            	clr	a
1587  0250 02            	rlwa	x,a
1588  0251 01            	rrwa	x,a
1589  0252 1a02          	or	a,(OFST-4,sp)
1590  0254 01            	rrwa	x,a
1591  0255 1a01          	or	a,(OFST-5,sp)
1592  0257 01            	rrwa	x,a
1593  0258 1f04          	ldw	(OFST-2,sp),x
1595  025a               L336:
1596                     ; 599   if (((uint16_t)lastevent & (uint16_t)I2C_Event) == (uint16_t)I2C_Event)
1598  025a 1e04          	ldw	x,(OFST-2,sp)
1599  025c 01            	rrwa	x,a
1600  025d 1408          	and	a,(OFST+2,sp)
1601  025f 01            	rrwa	x,a
1602  0260 1407          	and	a,(OFST+1,sp)
1603  0262 01            	rrwa	x,a
1604  0263 1307          	cpw	x,(OFST+1,sp)
1605  0265 2606          	jrne	L536
1606                     ; 602     status = SUCCESS;
1608  0267 a601          	ld	a,#1
1609  0269 6b06          	ld	(OFST+0,sp),a
1612  026b 2002          	jra	L736
1613  026d               L536:
1614                     ; 607     status = ERROR;
1616  026d 0f06          	clr	(OFST+0,sp)
1618  026f               L736:
1619                     ; 611   return status;
1621  026f 7b06          	ld	a,(OFST+0,sp)
1624  0271 5b08          	addw	sp,#8
1625  0273 87            	retf
1677                     ; 628 I2C_Event_TypeDef I2C_GetLastEvent(void)
1677                     ; 629 {
1678                     	switch	.text
1679  0274               f_I2C_GetLastEvent:
1681  0274 5206          	subw	sp,#6
1682       00000006      OFST:	set	6
1685                     ; 630   __IO uint16_t lastevent = 0;
1687  0276 5f            	clrw	x
1688  0277 1f05          	ldw	(OFST-1,sp),x
1690                     ; 631   uint16_t flag1 = 0;
1692                     ; 632   uint16_t flag2 = 0;
1694                     ; 634   if ((I2C->SR2 & I2C_SR2_AF) != 0x00)
1696  0279 c65218        	ld	a,21016
1697  027c a504          	bcp	a,#4
1698  027e 2707          	jreq	L766
1699                     ; 636     lastevent = I2C_EVENT_SLAVE_ACK_FAILURE;
1701  0280 ae0004        	ldw	x,#4
1702  0283 1f05          	ldw	(OFST-1,sp),x
1705  0285 201b          	jra	L176
1706  0287               L766:
1707                     ; 641     flag1 = I2C->SR1;
1709  0287 c65217        	ld	a,21015
1710  028a 5f            	clrw	x
1711  028b 97            	ld	xl,a
1712  028c 1f01          	ldw	(OFST-5,sp),x
1714                     ; 642     flag2 = I2C->SR3;
1716  028e c65219        	ld	a,21017
1717  0291 5f            	clrw	x
1718  0292 97            	ld	xl,a
1719  0293 1f03          	ldw	(OFST-3,sp),x
1721                     ; 645     lastevent = ((uint16_t)((uint16_t)flag2 << 8) | (uint16_t)flag1);
1723  0295 1e03          	ldw	x,(OFST-3,sp)
1724  0297 4f            	clr	a
1725  0298 02            	rlwa	x,a
1726  0299 01            	rrwa	x,a
1727  029a 1a02          	or	a,(OFST-4,sp)
1728  029c 01            	rrwa	x,a
1729  029d 1a01          	or	a,(OFST-5,sp)
1730  029f 01            	rrwa	x,a
1731  02a0 1f05          	ldw	(OFST-1,sp),x
1733  02a2               L176:
1734                     ; 648   return (I2C_Event_TypeDef)lastevent;
1736  02a2 1e05          	ldw	x,(OFST-1,sp)
1739  02a4 5b06          	addw	sp,#6
1740  02a6 87            	retf
1954                     ; 679 FlagStatus I2C_GetFlagStatus(I2C_Flag_TypeDef I2C_Flag)
1954                     ; 680 {
1955                     	switch	.text
1956  02a7               f_I2C_GetFlagStatus:
1958  02a7 89            	pushw	x
1959  02a8 89            	pushw	x
1960       00000002      OFST:	set	2
1963                     ; 681   uint8_t tempreg = 0;
1965  02a9 0f02          	clr	(OFST+0,sp)
1967                     ; 682   uint8_t regindex = 0;
1969                     ; 683   FlagStatus bitstatus = RESET;
1971                     ; 686   assert_param(IS_I2C_FLAG_OK(I2C_Flag));
1973                     ; 689   regindex = (uint8_t)((uint16_t)I2C_Flag >> 8);
1975  02ab 9e            	ld	a,xh
1976  02ac 6b01          	ld	(OFST-1,sp),a
1978                     ; 691   switch (regindex)
1980  02ae 7b01          	ld	a,(OFST-1,sp)
1982                     ; 708     default:
1982                     ; 709       break;
1983  02b0 4a            	dec	a
1984  02b1 2708          	jreq	L376
1985  02b3 4a            	dec	a
1986  02b4 270c          	jreq	L576
1987  02b6 4a            	dec	a
1988  02b7 2710          	jreq	L776
1989  02b9 2013          	jra	L3101
1990  02bb               L376:
1991                     ; 694     case 0x01:
1991                     ; 695       tempreg = (uint8_t)I2C->SR1;
1993  02bb c65217        	ld	a,21015
1994  02be 6b02          	ld	(OFST+0,sp),a
1996                     ; 696       break;
1998  02c0 200c          	jra	L3101
1999  02c2               L576:
2000                     ; 699     case 0x02:
2000                     ; 700       tempreg = (uint8_t)I2C->SR2;
2002  02c2 c65218        	ld	a,21016
2003  02c5 6b02          	ld	(OFST+0,sp),a
2005                     ; 701       break;
2007  02c7 2005          	jra	L3101
2008  02c9               L776:
2009                     ; 704     case 0x03:
2009                     ; 705       tempreg = (uint8_t)I2C->SR3;
2011  02c9 c65219        	ld	a,21017
2012  02cc 6b02          	ld	(OFST+0,sp),a
2014                     ; 706       break;
2016  02ce               L107:
2017                     ; 708     default:
2017                     ; 709       break;
2019  02ce               L3101:
2020                     ; 713   if ((tempreg & (uint8_t)I2C_Flag ) != 0)
2022  02ce 7b04          	ld	a,(OFST+2,sp)
2023  02d0 1502          	bcp	a,(OFST+0,sp)
2024  02d2 2706          	jreq	L5101
2025                     ; 716     bitstatus = SET;
2027  02d4 a601          	ld	a,#1
2028  02d6 6b02          	ld	(OFST+0,sp),a
2031  02d8 2002          	jra	L7101
2032  02da               L5101:
2033                     ; 721     bitstatus = RESET;
2035  02da 0f02          	clr	(OFST+0,sp)
2037  02dc               L7101:
2038                     ; 724   return bitstatus;
2040  02dc 7b02          	ld	a,(OFST+0,sp)
2043  02de 5b04          	addw	sp,#4
2044  02e0 87            	retf
2087                     ; 759 void I2C_ClearFlag(I2C_Flag_TypeDef I2C_FLAG)
2087                     ; 760 {
2088                     	switch	.text
2089  02e1               f_I2C_ClearFlag:
2091  02e1 89            	pushw	x
2092       00000002      OFST:	set	2
2095                     ; 761   uint16_t flagpos = 0;
2097                     ; 763   assert_param(IS_I2C_CLEAR_FLAG_OK(I2C_FLAG));
2099                     ; 766   flagpos = (uint16_t)I2C_FLAG & FLAG_Mask;
2101  02e2 01            	rrwa	x,a
2102  02e3 a4ff          	and	a,#255
2103  02e5 5f            	clrw	x
2104  02e6 02            	rlwa	x,a
2105  02e7 1f01          	ldw	(OFST-1,sp),x
2106  02e9 01            	rrwa	x,a
2108                     ; 768   I2C->SR2 = (uint8_t)((uint16_t)(~flagpos));
2110  02ea 7b02          	ld	a,(OFST+0,sp)
2111  02ec 43            	cpl	a
2112  02ed c75218        	ld	21016,a
2113                     ; 769 }
2116  02f0 85            	popw	x
2117  02f1 87            	retf
2282                     ; 791 ITStatus I2C_GetITStatus(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2282                     ; 792 {
2283                     	switch	.text
2284  02f2               f_I2C_GetITStatus:
2286  02f2 89            	pushw	x
2287  02f3 5204          	subw	sp,#4
2288       00000004      OFST:	set	4
2291                     ; 793   ITStatus bitstatus = RESET;
2293                     ; 794   __IO uint8_t enablestatus = 0;
2295  02f5 0f03          	clr	(OFST-1,sp)
2297                     ; 795   uint16_t tempregister = 0;
2299                     ; 798     assert_param(IS_I2C_ITPENDINGBIT_OK(I2C_ITPendingBit));
2301                     ; 800   tempregister = (uint8_t)( ((uint16_t)((uint16_t)I2C_ITPendingBit & ITEN_Mask)) >> 8);
2303  02f7 9e            	ld	a,xh
2304  02f8 a407          	and	a,#7
2305  02fa 5f            	clrw	x
2306  02fb 97            	ld	xl,a
2307  02fc 1f01          	ldw	(OFST-3,sp),x
2309                     ; 803   enablestatus = (uint8_t)(I2C->ITR & ( uint8_t)tempregister);
2311  02fe c6521a        	ld	a,21018
2312  0301 1402          	and	a,(OFST-2,sp)
2313  0303 6b03          	ld	(OFST-1,sp),a
2315                     ; 805   if ((uint16_t)((uint16_t)I2C_ITPendingBit & REGISTER_Mask) == REGISTER_SR1_Index)
2317  0305 7b05          	ld	a,(OFST+1,sp)
2318  0307 97            	ld	xl,a
2319  0308 7b06          	ld	a,(OFST+2,sp)
2320  030a 9f            	ld	a,xl
2321  030b a430          	and	a,#48
2322  030d 97            	ld	xl,a
2323  030e 4f            	clr	a
2324  030f 02            	rlwa	x,a
2325  0310 a30100        	cpw	x,#256
2326  0313 2615          	jrne	L1311
2327                     ; 808     if (((I2C->SR1 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2329  0315 c65217        	ld	a,21015
2330  0318 1506          	bcp	a,(OFST+2,sp)
2331  031a 270a          	jreq	L3311
2333  031c 0d03          	tnz	(OFST-1,sp)
2334  031e 2706          	jreq	L3311
2335                     ; 811       bitstatus = SET;
2337  0320 a601          	ld	a,#1
2338  0322 6b04          	ld	(OFST+0,sp),a
2341  0324 2017          	jra	L7311
2342  0326               L3311:
2343                     ; 816       bitstatus = RESET;
2345  0326 0f04          	clr	(OFST+0,sp)
2347  0328 2013          	jra	L7311
2348  032a               L1311:
2349                     ; 822     if (((I2C->SR2 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2351  032a c65218        	ld	a,21016
2352  032d 1506          	bcp	a,(OFST+2,sp)
2353  032f 270a          	jreq	L1411
2355  0331 0d03          	tnz	(OFST-1,sp)
2356  0333 2706          	jreq	L1411
2357                     ; 825       bitstatus = SET;
2359  0335 a601          	ld	a,#1
2360  0337 6b04          	ld	(OFST+0,sp),a
2363  0339 2002          	jra	L7311
2364  033b               L1411:
2365                     ; 830       bitstatus = RESET;
2367  033b 0f04          	clr	(OFST+0,sp)
2369  033d               L7311:
2370                     ; 834   return  bitstatus;
2372  033d 7b04          	ld	a,(OFST+0,sp)
2375  033f 5b06          	addw	sp,#6
2376  0341 87            	retf
2420                     ; 871 void I2C_ClearITPendingBit(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2420                     ; 872 {
2421                     	switch	.text
2422  0342               f_I2C_ClearITPendingBit:
2424  0342 89            	pushw	x
2425       00000002      OFST:	set	2
2428                     ; 873   uint16_t flagpos = 0;
2430                     ; 876   assert_param(IS_I2C_CLEAR_ITPENDINGBIT_OK(I2C_ITPendingBit));
2432                     ; 879   flagpos = (uint16_t)I2C_ITPendingBit & FLAG_Mask;
2434  0343 01            	rrwa	x,a
2435  0344 a4ff          	and	a,#255
2436  0346 5f            	clrw	x
2437  0347 02            	rlwa	x,a
2438  0348 1f01          	ldw	(OFST-1,sp),x
2439  034a 01            	rrwa	x,a
2441                     ; 882   I2C->SR2 = (uint8_t)((uint16_t)~flagpos);
2443  034b 7b02          	ld	a,(OFST+0,sp)
2444  034d 43            	cpl	a
2445  034e c75218        	ld	21016,a
2446                     ; 883 }
2449  0351 85            	popw	x
2450  0352 87            	retf
2462                     	xdef	f_I2C_ClearITPendingBit
2463                     	xdef	f_I2C_GetITStatus
2464                     	xdef	f_I2C_ClearFlag
2465                     	xdef	f_I2C_GetFlagStatus
2466                     	xdef	f_I2C_GetLastEvent
2467                     	xdef	f_I2C_CheckEvent
2468                     	xdef	f_I2C_SendData
2469                     	xdef	f_I2C_Send7bitAddress
2470                     	xdef	f_I2C_ReceiveData
2471                     	xdef	f_I2C_ITConfig
2472                     	xdef	f_I2C_FastModeDutyCycleConfig
2473                     	xdef	f_I2C_AcknowledgeConfig
2474                     	xdef	f_I2C_StretchClockCmd
2475                     	xdef	f_I2C_SoftwareResetCmd
2476                     	xdef	f_I2C_GenerateSTOP
2477                     	xdef	f_I2C_GenerateSTART
2478                     	xdef	f_I2C_GeneralCallCmd
2479                     	xdef	f_I2C_Cmd
2480                     	xdef	f_I2C_Init
2481                     	xdef	f_I2C_DeInit
2482                     	xref.b	c_lreg
2483                     	xref.b	c_x
2502                     	xref	d_sdivx
2503                     	xref	d_ludv
2504                     	xref	d_rtol
2505                     	xref	d_smul
2506                     	xref	d_lmul
2507                     	xref	d_lcmp
2508                     	xref	d_ltor
2509                     	end
