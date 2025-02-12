   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  42                     ; 47 void EXTI_DeInit(void)
  42                     ; 48 {
  44                     	switch	.text
  45  0000               _EXTI_DeInit:
  49                     ; 49     EXTI->CR1 = EXTI_CR1_RESET_VALUE;
  51  0000 725f50a0      	clr	20640
  52                     ; 50     EXTI->CR2 = EXTI_CR2_RESET_VALUE;
  54  0004 725f50a1      	clr	20641
  55                     ; 51 }
  58  0008 81            	ret
 183                     ; 64 void EXTI_SetExtIntSensitivity(EXTI_Port_TypeDef Port, EXTI_Sensitivity_TypeDef SensitivityValue)
 183                     ; 65 {
 184                     	switch	.text
 185  0009               _EXTI_SetExtIntSensitivity:
 187  0009 89            	pushw	x
 188       00000000      OFST:	set	0
 191                     ; 68     assert_param(IS_EXTI_PORT_OK(Port));
 193                     ; 69     assert_param(IS_EXTI_SENSITIVITY_OK(SensitivityValue));
 195                     ; 72     switch (Port)
 197  000a 9e            	ld	a,xh
 199                     ; 94     default:
 199                     ; 95         break;
 200  000b 4d            	tnz	a
 201  000c 270e          	jreq	L12
 202  000e 4a            	dec	a
 203  000f 271d          	jreq	L32
 204  0011 4a            	dec	a
 205  0012 272e          	jreq	L52
 206  0014 4a            	dec	a
 207  0015 2742          	jreq	L72
 208  0017 4a            	dec	a
 209  0018 2756          	jreq	L13
 210  001a 2064          	jra	L311
 211  001c               L12:
 212                     ; 74     case EXTI_PORT_GPIOA:
 212                     ; 75         EXTI->CR1 &= (uint8_t)(~EXTI_CR1_PAIS);
 214  001c c650a0        	ld	a,20640
 215  001f a4fc          	and	a,#252
 216  0021 c750a0        	ld	20640,a
 217                     ; 76         EXTI->CR1 |= (uint8_t)(SensitivityValue);
 219  0024 c650a0        	ld	a,20640
 220  0027 1a02          	or	a,(OFST+2,sp)
 221  0029 c750a0        	ld	20640,a
 222                     ; 77         break;
 224  002c 2052          	jra	L311
 225  002e               L32:
 226                     ; 78     case EXTI_PORT_GPIOB:
 226                     ; 79         EXTI->CR1 &= (uint8_t)(~EXTI_CR1_PBIS);
 228  002e c650a0        	ld	a,20640
 229  0031 a4f3          	and	a,#243
 230  0033 c750a0        	ld	20640,a
 231                     ; 80         EXTI->CR1 |= (uint8_t)((uint8_t)(SensitivityValue) << 2);
 233  0036 7b02          	ld	a,(OFST+2,sp)
 234  0038 48            	sll	a
 235  0039 48            	sll	a
 236  003a ca50a0        	or	a,20640
 237  003d c750a0        	ld	20640,a
 238                     ; 81         break;
 240  0040 203e          	jra	L311
 241  0042               L52:
 242                     ; 82     case EXTI_PORT_GPIOC:
 242                     ; 83         EXTI->CR1 &= (uint8_t)(~EXTI_CR1_PCIS);
 244  0042 c650a0        	ld	a,20640
 245  0045 a4cf          	and	a,#207
 246  0047 c750a0        	ld	20640,a
 247                     ; 84         EXTI->CR1 |= (uint8_t)((uint8_t)(SensitivityValue) << 4);
 249  004a 7b02          	ld	a,(OFST+2,sp)
 250  004c 97            	ld	xl,a
 251  004d a610          	ld	a,#16
 252  004f 42            	mul	x,a
 253  0050 9f            	ld	a,xl
 254  0051 ca50a0        	or	a,20640
 255  0054 c750a0        	ld	20640,a
 256                     ; 85         break;
 258  0057 2027          	jra	L311
 259  0059               L72:
 260                     ; 86     case EXTI_PORT_GPIOD:
 260                     ; 87         EXTI->CR1 &= (uint8_t)(~EXTI_CR1_PDIS);
 262  0059 c650a0        	ld	a,20640
 263  005c a43f          	and	a,#63
 264  005e c750a0        	ld	20640,a
 265                     ; 88         EXTI->CR1 |= (uint8_t)((uint8_t)(SensitivityValue) << 6);
 267  0061 7b02          	ld	a,(OFST+2,sp)
 268  0063 97            	ld	xl,a
 269  0064 a640          	ld	a,#64
 270  0066 42            	mul	x,a
 271  0067 9f            	ld	a,xl
 272  0068 ca50a0        	or	a,20640
 273  006b c750a0        	ld	20640,a
 274                     ; 89         break;
 276  006e 2010          	jra	L311
 277  0070               L13:
 278                     ; 90     case EXTI_PORT_GPIOE:
 278                     ; 91         EXTI->CR2 &= (uint8_t)(~EXTI_CR2_PEIS);
 280  0070 c650a1        	ld	a,20641
 281  0073 a4fc          	and	a,#252
 282  0075 c750a1        	ld	20641,a
 283                     ; 92         EXTI->CR2 |= (uint8_t)(SensitivityValue);
 285  0078 c650a1        	ld	a,20641
 286  007b 1a02          	or	a,(OFST+2,sp)
 287  007d c750a1        	ld	20641,a
 288                     ; 93         break;
 290  0080               L33:
 291                     ; 94     default:
 291                     ; 95         break;
 293  0080               L311:
 294                     ; 97 }
 297  0080 85            	popw	x
 298  0081 81            	ret
 356                     ; 106 void EXTI_SetTLISensitivity(EXTI_TLISensitivity_TypeDef SensitivityValue)
 356                     ; 107 {
 357                     	switch	.text
 358  0082               _EXTI_SetTLISensitivity:
 362                     ; 109     assert_param(IS_EXTI_TLISENSITIVITY_OK(SensitivityValue));
 364                     ; 112     EXTI->CR2 &= (uint8_t)(~EXTI_CR2_TLIS);
 366  0082 721550a1      	bres	20641,#2
 367                     ; 113     EXTI->CR2 |= (uint8_t)(SensitivityValue);
 369  0086 ca50a1        	or	a,20641
 370  0089 c750a1        	ld	20641,a
 371                     ; 114 }
 374  008c 81            	ret
 420                     ; 121 EXTI_Sensitivity_TypeDef EXTI_GetExtIntSensitivity(EXTI_Port_TypeDef Port)
 420                     ; 122 {
 421                     	switch	.text
 422  008d               _EXTI_GetExtIntSensitivity:
 424  008d 88            	push	a
 425       00000001      OFST:	set	1
 428                     ; 123     uint8_t value = 0;
 430  008e 0f01          	clr	(OFST+0,sp)
 432                     ; 126     assert_param(IS_EXTI_PORT_OK(Port));
 434                     ; 128     switch (Port)
 437                     ; 145     default:
 437                     ; 146         break;
 438  0090 4d            	tnz	a
 439  0091 270e          	jreq	L341
 440  0093 4a            	dec	a
 441  0094 2714          	jreq	L541
 442  0096 4a            	dec	a
 443  0097 271c          	jreq	L741
 444  0099 4a            	dec	a
 445  009a 2725          	jreq	L151
 446  009c 4a            	dec	a
 447  009d 2730          	jreq	L351
 448  009f 2035          	jra	L302
 449  00a1               L341:
 450                     ; 130     case EXTI_PORT_GPIOA:
 450                     ; 131         value = (uint8_t)(EXTI->CR1 & EXTI_CR1_PAIS);
 452  00a1 c650a0        	ld	a,20640
 453  00a4 a403          	and	a,#3
 454  00a6 6b01          	ld	(OFST+0,sp),a
 456                     ; 132         break;
 458  00a8 202c          	jra	L302
 459  00aa               L541:
 460                     ; 133     case EXTI_PORT_GPIOB:
 460                     ; 134         value = (uint8_t)((uint8_t)(EXTI->CR1 & EXTI_CR1_PBIS) >> 2);
 462  00aa c650a0        	ld	a,20640
 463  00ad a40c          	and	a,#12
 464  00af 44            	srl	a
 465  00b0 44            	srl	a
 466  00b1 6b01          	ld	(OFST+0,sp),a
 468                     ; 135         break;
 470  00b3 2021          	jra	L302
 471  00b5               L741:
 472                     ; 136     case EXTI_PORT_GPIOC:
 472                     ; 137         value = (uint8_t)((uint8_t)(EXTI->CR1 & EXTI_CR1_PCIS) >> 4);
 474  00b5 c650a0        	ld	a,20640
 475  00b8 a430          	and	a,#48
 476  00ba 4e            	swap	a
 477  00bb a40f          	and	a,#15
 478  00bd 6b01          	ld	(OFST+0,sp),a
 480                     ; 138         break;
 482  00bf 2015          	jra	L302
 483  00c1               L151:
 484                     ; 139     case EXTI_PORT_GPIOD:
 484                     ; 140         value = (uint8_t)((uint8_t)(EXTI->CR1 & EXTI_CR1_PDIS) >> 6);
 486  00c1 c650a0        	ld	a,20640
 487  00c4 a4c0          	and	a,#192
 488  00c6 4e            	swap	a
 489  00c7 44            	srl	a
 490  00c8 44            	srl	a
 491  00c9 a403          	and	a,#3
 492  00cb 6b01          	ld	(OFST+0,sp),a
 494                     ; 141         break;
 496  00cd 2007          	jra	L302
 497  00cf               L351:
 498                     ; 142     case EXTI_PORT_GPIOE:
 498                     ; 143         value = (uint8_t)(EXTI->CR2 & EXTI_CR2_PEIS);
 500  00cf c650a1        	ld	a,20641
 501  00d2 a403          	and	a,#3
 502  00d4 6b01          	ld	(OFST+0,sp),a
 504                     ; 144         break;
 506  00d6               L551:
 507                     ; 145     default:
 507                     ; 146         break;
 509  00d6               L302:
 510                     ; 149     return((EXTI_Sensitivity_TypeDef)value);
 512  00d6 7b01          	ld	a,(OFST+0,sp)
 515  00d8 5b01          	addw	sp,#1
 516  00da 81            	ret
 552                     ; 157 EXTI_TLISensitivity_TypeDef EXTI_GetTLISensitivity(void)
 552                     ; 158 {
 553                     	switch	.text
 554  00db               _EXTI_GetTLISensitivity:
 556  00db 88            	push	a
 557       00000001      OFST:	set	1
 560                     ; 160     uint8_t value = 0;
 562                     ; 163     value = (uint8_t)(EXTI->CR2 & EXTI_CR2_TLIS);
 564  00dc c650a1        	ld	a,20641
 565  00df a404          	and	a,#4
 566  00e1 6b01          	ld	(OFST+0,sp),a
 568                     ; 165     return((EXTI_TLISensitivity_TypeDef)value);
 570  00e3 7b01          	ld	a,(OFST+0,sp)
 573  00e5 5b01          	addw	sp,#1
 574  00e7 81            	ret
 587                     	xdef	_EXTI_GetTLISensitivity
 588                     	xdef	_EXTI_GetExtIntSensitivity
 589                     	xdef	_EXTI_SetTLISensitivity
 590                     	xdef	_EXTI_SetExtIntSensitivity
 591                     	xdef	_EXTI_DeInit
 610                     	end
