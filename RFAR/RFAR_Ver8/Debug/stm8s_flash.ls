   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  74                     ; 81 void FLASH_Unlock(FLASH_MemType_TypeDef FLASH_MemType)
  74                     ; 82 {
  75                     	switch	.text
  76  0000               f_FLASH_Unlock:
  80                     ; 84     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
  82                     ; 87     if (FLASH_MemType == FLASH_MEMTYPE_PROG)
  84  0000 a1fd          	cp	a,#253
  85  0002 260a          	jrne	L73
  86                     ; 89         FLASH->PUKR = FLASH_RASS_KEY1;
  88  0004 35565062      	mov	20578,#86
  89                     ; 90         FLASH->PUKR = FLASH_RASS_KEY2;
  91  0008 35ae5062      	mov	20578,#174
  93  000c 2008          	jra	L14
  94  000e               L73:
  95                     ; 95         FLASH->DUKR = FLASH_RASS_KEY2; /* Warning: keys are reversed on data memory !!! */
  97  000e 35ae5064      	mov	20580,#174
  98                     ; 96         FLASH->DUKR = FLASH_RASS_KEY1;
 100  0012 35565064      	mov	20580,#86
 101  0016               L14:
 102                     ; 98 }
 105  0016 87            	retf
 139                     ; 106 void FLASH_Lock(FLASH_MemType_TypeDef FLASH_MemType)
 139                     ; 107 {
 140                     	switch	.text
 141  0017               f_FLASH_Lock:
 145                     ; 109     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
 147                     ; 112   FLASH->IAPSR &= (uint8_t)FLASH_MemType;
 149  0017 c4505f        	and	a,20575
 150  001a c7505f        	ld	20575,a
 151                     ; 113 }
 154  001d 87            	retf
 176                     ; 120 void FLASH_DeInit(void)
 176                     ; 121 {
 177                     	switch	.text
 178  001e               f_FLASH_DeInit:
 182                     ; 122     FLASH->CR1 = FLASH_CR1_RESET_VALUE;
 184  001e 725f505a      	clr	20570
 185                     ; 123     FLASH->CR2 = FLASH_CR2_RESET_VALUE;
 187  0022 725f505b      	clr	20571
 188                     ; 124     FLASH->NCR2 = FLASH_NCR2_RESET_VALUE;
 190  0026 35ff505c      	mov	20572,#255
 191                     ; 125     FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_DUL);
 193  002a 7217505f      	bres	20575,#3
 194                     ; 126     FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_PUL);
 196  002e 7213505f      	bres	20575,#1
 197                     ; 127     (void) FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
 199  0032 c6505f        	ld	a,20575
 200                     ; 128 }
 203  0035 87            	retf
 257                     ; 136 void FLASH_ITConfig(FunctionalState NewState)
 257                     ; 137 {
 258                     	switch	.text
 259  0036               f_FLASH_ITConfig:
 263                     ; 139   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 265                     ; 141     if (NewState != DISABLE)
 267  0036 4d            	tnz	a
 268  0037 2706          	jreq	L711
 269                     ; 143         FLASH->CR1 |= FLASH_CR1_IE; /* Enables the interrupt sources */
 271  0039 7212505a      	bset	20570,#1
 273  003d 2004          	jra	L121
 274  003f               L711:
 275                     ; 147         FLASH->CR1 &= (uint8_t)(~FLASH_CR1_IE); /* Disables the interrupt sources */
 277  003f 7213505a      	bres	20570,#1
 278  0043               L121:
 279                     ; 149 }
 282  0043 87            	retf
 313                     ; 158 void FLASH_EraseByte(uint32_t Address)
 313                     ; 159 {
 314                     	switch	.text
 315  0044               f_FLASH_EraseByte:
 317       00000000      OFST:	set	0
 320                     ; 161     assert_param(IS_FLASH_ADDRESS_OK(Address));
 322                     ; 164    *(PointerAttr uint8_t*) (uint16_t)Address = FLASH_CLEAR_BYTE; 
 324  0044 7b06          	ld	a,(OFST+6,sp)
 325  0046 97            	ld	xl,a
 326  0047 7b07          	ld	a,(OFST+7,sp)
 327  0049 3f00          	clr	c_x
 328  004b 02            	rlwa	x,a
 329  004c 9093          	ldw	y,x
 330  004e bf01          	ldw	c_x+1,x
 331  0050 4f            	clr	a
 332  0051 92bd0000      	ldf	[c_x.e],a
 333                     ; 166 }
 336  0055 87            	retf
 374                     ; 176 void FLASH_ProgramByte(uint32_t Address, uint8_t Data)
 374                     ; 177 {
 375                     	switch	.text
 376  0056               f_FLASH_ProgramByte:
 378       00000000      OFST:	set	0
 381                     ; 179     assert_param(IS_FLASH_ADDRESS_OK(Address));
 383                     ; 180     *(PointerAttr uint8_t*) (uint16_t)Address = Data;
 385  0056 7b06          	ld	a,(OFST+6,sp)
 386  0058 97            	ld	xl,a
 387  0059 7b07          	ld	a,(OFST+7,sp)
 388  005b 3f00          	clr	c_x
 389  005d 02            	rlwa	x,a
 390  005e 9093          	ldw	y,x
 391  0060 7b08          	ld	a,(OFST+8,sp)
 392  0062 bf01          	ldw	c_x+1,x
 393  0064 92bd0000      	ldf	[c_x.e],a
 394                     ; 181 }
 397  0068 87            	retf
 428                     ; 190 uint8_t FLASH_ReadByte(uint32_t Address)
 428                     ; 191 {
 429                     	switch	.text
 430  0069               f_FLASH_ReadByte:
 432       00000000      OFST:	set	0
 435                     ; 193     assert_param(IS_FLASH_ADDRESS_OK(Address));
 437                     ; 196     return(*(PointerAttr uint8_t *) (uint16_t)Address); 
 439  0069 7b06          	ld	a,(OFST+6,sp)
 440  006b 97            	ld	xl,a
 441  006c 7b07          	ld	a,(OFST+7,sp)
 442  006e 3f00          	clr	c_x
 443  0070 02            	rlwa	x,a
 444  0071 9093          	ldw	y,x
 445  0073 bf01          	ldw	c_x+1,x
 446  0075 92bc0000      	ldf	a,[c_x.e]
 449  0079 87            	retf
 487                     ; 207 void FLASH_ProgramWord(uint32_t Address, uint32_t Data)
 487                     ; 208 {
 488                     	switch	.text
 489  007a               f_FLASH_ProgramWord:
 491       00000000      OFST:	set	0
 494                     ; 210     assert_param(IS_FLASH_ADDRESS_OK(Address));
 496                     ; 213     FLASH->CR2 |= FLASH_CR2_WPRG;
 498  007a 721c505b      	bset	20571,#6
 499                     ; 214     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
 501  007e 721d505c      	bres	20572,#6
 502                     ; 217     *((PointerAttr uint8_t*)(uint16_t)Address)       = *((uint8_t*)(&Data));
 504  0082 7b06          	ld	a,(OFST+6,sp)
 505  0084 97            	ld	xl,a
 506  0085 7b07          	ld	a,(OFST+7,sp)
 507  0087 3f00          	clr	c_x
 508  0089 02            	rlwa	x,a
 509  008a 9093          	ldw	y,x
 510  008c 7b08          	ld	a,(OFST+8,sp)
 511  008e bf01          	ldw	c_x+1,x
 512  0090 92bd0000      	ldf	[c_x.e],a
 513                     ; 219     *(((PointerAttr uint8_t*)(uint16_t)Address) + 1) = *((uint8_t*)(&Data)+1); 
 515  0094 7b06          	ld	a,(OFST+6,sp)
 516  0096 97            	ld	xl,a
 517  0097 7b07          	ld	a,(OFST+7,sp)
 518  0099 3f00          	clr	c_x
 519  009b 02            	rlwa	x,a
 520  009c 9093          	ldw	y,x
 521  009e 90ae0001      	ldw	y,#1
 522  00a2 bf01          	ldw	c_x+1,x
 523  00a4 93            	ldw	x,y
 524  00a5 7b09          	ld	a,(OFST+9,sp)
 525  00a7 92a70000      	ldf	([c_x.e],x),a
 526                     ; 221     *(((PointerAttr uint8_t*)(uint16_t)Address) + 2) = *((uint8_t*)(&Data)+2); 
 528  00ab 7b06          	ld	a,(OFST+6,sp)
 529  00ad 97            	ld	xl,a
 530  00ae 7b07          	ld	a,(OFST+7,sp)
 531  00b0 3f00          	clr	c_x
 532  00b2 02            	rlwa	x,a
 533  00b3 9093          	ldw	y,x
 534  00b5 90ae0002      	ldw	y,#2
 535  00b9 bf01          	ldw	c_x+1,x
 536  00bb 93            	ldw	x,y
 537  00bc 7b0a          	ld	a,(OFST+10,sp)
 538  00be 92a70000      	ldf	([c_x.e],x),a
 539                     ; 223     *(((PointerAttr uint8_t*)(uint16_t)Address) + 3) = *((uint8_t*)(&Data)+3); 
 541  00c2 7b06          	ld	a,(OFST+6,sp)
 542  00c4 97            	ld	xl,a
 543  00c5 7b07          	ld	a,(OFST+7,sp)
 544  00c7 3f00          	clr	c_x
 545  00c9 02            	rlwa	x,a
 546  00ca 9093          	ldw	y,x
 547  00cc 90ae0003      	ldw	y,#3
 548  00d0 bf01          	ldw	c_x+1,x
 549  00d2 93            	ldw	x,y
 550  00d3 7b0b          	ld	a,(OFST+11,sp)
 551  00d5 92a70000      	ldf	([c_x.e],x),a
 552                     ; 224 }
 555  00d9 87            	retf
 595                     ; 232 void FLASH_ProgramOptionByte(uint16_t Address, uint8_t Data)
 595                     ; 233 {
 596                     	switch	.text
 597  00da               f_FLASH_ProgramOptionByte:
 599  00da 89            	pushw	x
 600       00000000      OFST:	set	0
 603                     ; 235     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 605                     ; 238     FLASH->CR2 |= FLASH_CR2_OPT;
 607  00db 721e505b      	bset	20571,#7
 608                     ; 239     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 610  00df 721f505c      	bres	20572,#7
 611                     ; 242     if (Address == 0x4800)
 613  00e3 a34800        	cpw	x,#18432
 614  00e6 2607          	jrne	L522
 615                     ; 245        *((NEAR uint8_t*)Address) = Data;
 617  00e8 7b06          	ld	a,(OFST+6,sp)
 618  00ea 1e01          	ldw	x,(OFST+1,sp)
 619  00ec f7            	ld	(x),a
 621  00ed 200c          	jra	L722
 622  00ef               L522:
 623                     ; 250        *((NEAR uint8_t*)Address) = Data;
 625  00ef 7b06          	ld	a,(OFST+6,sp)
 626  00f1 1e01          	ldw	x,(OFST+1,sp)
 627  00f3 f7            	ld	(x),a
 628                     ; 251        *((NEAR uint8_t*)((uint16_t)(Address + 1))) = (uint8_t)(~Data);
 630  00f4 7b06          	ld	a,(OFST+6,sp)
 631  00f6 43            	cpl	a
 632  00f7 1e01          	ldw	x,(OFST+1,sp)
 633  00f9 e701          	ld	(1,x),a
 634  00fb               L722:
 635                     ; 253     FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 637  00fb a6fd          	ld	a,#253
 638  00fd 8deb01eb      	callf	f_FLASH_WaitForLastOperation
 640                     ; 256     FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 642  0101 721f505b      	bres	20571,#7
 643                     ; 257     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 645  0105 721e505c      	bset	20572,#7
 646                     ; 258 }
 649  0109 85            	popw	x
 650  010a 87            	retf
 683                     ; 265 void FLASH_EraseOptionByte(uint16_t Address)
 683                     ; 266 {
 684                     	switch	.text
 685  010b               f_FLASH_EraseOptionByte:
 687  010b 89            	pushw	x
 688       00000000      OFST:	set	0
 691                     ; 268     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 693                     ; 271     FLASH->CR2 |= FLASH_CR2_OPT;
 695  010c 721e505b      	bset	20571,#7
 696                     ; 272     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 698  0110 721f505c      	bres	20572,#7
 699                     ; 275      if (Address == 0x4800)
 701  0114 a34800        	cpw	x,#18432
 702  0117 2603          	jrne	L542
 703                     ; 278        *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 705  0119 7f            	clr	(x)
 707  011a 2009          	jra	L742
 708  011c               L542:
 709                     ; 283        *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 711  011c 1e01          	ldw	x,(OFST+1,sp)
 712  011e 7f            	clr	(x)
 713                     ; 284        *((NEAR uint8_t*)((uint16_t)(Address + (uint16_t)1 ))) = FLASH_SET_BYTE;
 715  011f 1e01          	ldw	x,(OFST+1,sp)
 716  0121 a6ff          	ld	a,#255
 717  0123 e701          	ld	(1,x),a
 718  0125               L742:
 719                     ; 286     FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 721  0125 a6fd          	ld	a,#253
 722  0127 8deb01eb      	callf	f_FLASH_WaitForLastOperation
 724                     ; 289     FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 726  012b 721f505b      	bres	20571,#7
 727                     ; 290     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 729  012f 721e505c      	bset	20572,#7
 730                     ; 291 }
 733  0133 85            	popw	x
 734  0134 87            	retf
 788                     ; 297 uint16_t FLASH_ReadOptionByte(uint16_t Address)
 788                     ; 298 {
 789                     	switch	.text
 790  0135               f_FLASH_ReadOptionByte:
 792  0135 5204          	subw	sp,#4
 793       00000004      OFST:	set	4
 796                     ; 299     uint8_t value_optbyte, value_optbyte_complement = 0;
 798                     ; 300     uint16_t res_value = 0;
 800                     ; 303     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 802                     ; 306     value_optbyte = *((NEAR uint8_t*)Address); /* Read option byte */
 804  0137 f6            	ld	a,(x)
 805  0138 6b01          	ld	(OFST-3,sp),a
 807                     ; 307     value_optbyte_complement = *(((NEAR uint8_t*)Address) + 1); /* Read option byte complement */
 809  013a e601          	ld	a,(1,x)
 810  013c 6b02          	ld	(OFST-2,sp),a
 812                     ; 310     if (Address == 0x4800)	 
 814  013e a34800        	cpw	x,#18432
 815  0141 2608          	jrne	L372
 816                     ; 312         res_value =	 value_optbyte;
 818  0143 7b01          	ld	a,(OFST-3,sp)
 819  0145 5f            	clrw	x
 820  0146 97            	ld	xl,a
 821  0147 1f03          	ldw	(OFST-1,sp),x
 824  0149 2023          	jra	L572
 825  014b               L372:
 826                     ; 316         if (value_optbyte == (uint8_t)(~value_optbyte_complement))
 828  014b 7b02          	ld	a,(OFST-2,sp)
 829  014d 43            	cpl	a
 830  014e 1101          	cp	a,(OFST-3,sp)
 831  0150 2617          	jrne	L772
 832                     ; 318             res_value = (uint16_t)((uint16_t)value_optbyte << 8);
 834  0152 7b01          	ld	a,(OFST-3,sp)
 835  0154 5f            	clrw	x
 836  0155 97            	ld	xl,a
 837  0156 4f            	clr	a
 838  0157 02            	rlwa	x,a
 839  0158 1f03          	ldw	(OFST-1,sp),x
 841                     ; 319             res_value = res_value | (uint16_t)value_optbyte_complement;
 843  015a 7b02          	ld	a,(OFST-2,sp)
 844  015c 5f            	clrw	x
 845  015d 97            	ld	xl,a
 846  015e 01            	rrwa	x,a
 847  015f 1a04          	or	a,(OFST+0,sp)
 848  0161 01            	rrwa	x,a
 849  0162 1a03          	or	a,(OFST-1,sp)
 850  0164 01            	rrwa	x,a
 851  0165 1f03          	ldw	(OFST-1,sp),x
 854  0167 2005          	jra	L572
 855  0169               L772:
 856                     ; 323             res_value = FLASH_OPTIONBYTE_ERROR;
 858  0169 ae5555        	ldw	x,#21845
 859  016c 1f03          	ldw	(OFST-1,sp),x
 861  016e               L572:
 862                     ; 326     return(res_value);
 864  016e 1e03          	ldw	x,(OFST-1,sp)
 867  0170 5b04          	addw	sp,#4
 868  0172 87            	retf
 941                     ; 335 void FLASH_SetLowPowerMode(FLASH_LPMode_TypeDef FLASH_LPMode)
 941                     ; 336 {
 942                     	switch	.text
 943  0173               f_FLASH_SetLowPowerMode:
 945  0173 88            	push	a
 946       00000000      OFST:	set	0
 949                     ; 338     assert_param(IS_FLASH_LOW_POWER_MODE_OK(FLASH_LPMode));
 951                     ; 341     FLASH->CR1 &= (uint8_t)(~(FLASH_CR1_HALT | FLASH_CR1_AHALT)); 
 953  0174 c6505a        	ld	a,20570
 954  0177 a4f3          	and	a,#243
 955  0179 c7505a        	ld	20570,a
 956                     ; 344     FLASH->CR1 |= (uint8_t)FLASH_LPMode; 
 958  017c c6505a        	ld	a,20570
 959  017f 1a01          	or	a,(OFST+1,sp)
 960  0181 c7505a        	ld	20570,a
 961                     ; 345 }
 964  0184 84            	pop	a
 965  0185 87            	retf
1022                     ; 353 void FLASH_SetProgrammingTime(FLASH_ProgramTime_TypeDef FLASH_ProgTime)
1022                     ; 354 {
1023                     	switch	.text
1024  0186               f_FLASH_SetProgrammingTime:
1028                     ; 356     assert_param(IS_FLASH_PROGRAM_TIME_OK(FLASH_ProgTime));
1030                     ; 358     FLASH->CR1 &= (uint8_t)(~FLASH_CR1_FIX);
1032  0186 7211505a      	bres	20570,#0
1033                     ; 359     FLASH->CR1 |= (uint8_t)FLASH_ProgTime;
1035  018a ca505a        	or	a,20570
1036  018d c7505a        	ld	20570,a
1037                     ; 360 }
1040  0190 87            	retf
1064                     ; 367 FLASH_LPMode_TypeDef FLASH_GetLowPowerMode(void)
1064                     ; 368 {
1065                     	switch	.text
1066  0191               f_FLASH_GetLowPowerMode:
1070                     ; 369     return((FLASH_LPMode_TypeDef)(FLASH->CR1 & (uint8_t)(FLASH_CR1_HALT | FLASH_CR1_AHALT)));
1072  0191 c6505a        	ld	a,20570
1073  0194 a40c          	and	a,#12
1076  0196 87            	retf
1100                     ; 377 FLASH_ProgramTime_TypeDef FLASH_GetProgrammingTime(void)
1100                     ; 378 {
1101                     	switch	.text
1102  0197               f_FLASH_GetProgrammingTime:
1106                     ; 379     return((FLASH_ProgramTime_TypeDef)(FLASH->CR1 & FLASH_CR1_FIX));
1108  0197 c6505a        	ld	a,20570
1109  019a a401          	and	a,#1
1112  019c 87            	retf
1143                     ; 387 uint32_t FLASH_GetBootSize(void)
1143                     ; 388 {
1144                     	switch	.text
1145  019d               f_FLASH_GetBootSize:
1147  019d 5204          	subw	sp,#4
1148       00000004      OFST:	set	4
1151                     ; 389     uint32_t temp = 0;
1153                     ; 392     temp = (uint32_t)((uint32_t)FLASH->FPR * (uint32_t)512);
1155  019f c6505d        	ld	a,20573
1156  01a2 5f            	clrw	x
1157  01a3 97            	ld	xl,a
1158  01a4 90ae0200      	ldw	y,#512
1159  01a8 8d000000      	callf	d_umul
1161  01ac 96            	ldw	x,sp
1162  01ad 1c0001        	addw	x,#OFST-3
1163  01b0 8d000000      	callf	d_rtol
1166                     ; 395     if (FLASH->FPR == 0xFF)
1168  01b4 c6505d        	ld	a,20573
1169  01b7 a1ff          	cp	a,#255
1170  01b9 2612          	jrne	L714
1171                     ; 397         temp += 512;
1173  01bb ae0200        	ldw	x,#512
1174  01be bf02          	ldw	c_lreg+2,x
1175  01c0 ae0000        	ldw	x,#0
1176  01c3 bf00          	ldw	c_lreg,x
1177  01c5 96            	ldw	x,sp
1178  01c6 1c0001        	addw	x,#OFST-3
1179  01c9 8d000000      	callf	d_lgadd
1182  01cd               L714:
1183                     ; 401     return(temp);
1185  01cd 96            	ldw	x,sp
1186  01ce 1c0001        	addw	x,#OFST-3
1187  01d1 8d000000      	callf	d_ltor
1191  01d5 5b04          	addw	sp,#4
1192  01d7 87            	retf
1300                     ; 412 FlagStatus FLASH_GetFlagStatus(FLASH_Flag_TypeDef FLASH_FLAG)
1300                     ; 413 {
1301                     	switch	.text
1302  01d8               f_FLASH_GetFlagStatus:
1304  01d8 88            	push	a
1305       00000001      OFST:	set	1
1308                     ; 414     FlagStatus status = RESET;
1310                     ; 416     assert_param(IS_FLASH_FLAGS_OK(FLASH_FLAG));
1312                     ; 419     if ((FLASH->IAPSR & (uint8_t)FLASH_FLAG) != (uint8_t)RESET)
1314  01d9 c4505f        	and	a,20575
1315  01dc 2706          	jreq	L174
1316                     ; 421         status = SET; /* FLASH_FLAG is set */
1318  01de a601          	ld	a,#1
1319  01e0 6b01          	ld	(OFST+0,sp),a
1322  01e2 2002          	jra	L374
1323  01e4               L174:
1324                     ; 425         status = RESET; /* FLASH_FLAG is reset*/
1326  01e4 0f01          	clr	(OFST+0,sp)
1328  01e6               L374:
1329                     ; 429     return status;
1331  01e6 7b01          	ld	a,(OFST+0,sp)
1334  01e8 5b01          	addw	sp,#1
1335  01ea 87            	retf
1423                     ; 531 IN_RAM(FLASH_Status_TypeDef FLASH_WaitForLastOperation(FLASH_MemType_TypeDef FLASH_MemType)) 
1423                     ; 532 {
1424                     	switch	.text
1425  01eb               f_FLASH_WaitForLastOperation:
1427  01eb 5205          	subw	sp,#5
1428       00000005      OFST:	set	5
1431                     ; 533     uint8_t flagstatus = 0x00;
1433  01ed 0f05          	clr	(OFST+0,sp)
1435                     ; 534     uint32_t timeout = OPERATION_TIMEOUT;
1437  01ef aeffff        	ldw	x,#65535
1438  01f2 1f03          	ldw	(OFST-2,sp),x
1439  01f4 ae000f        	ldw	x,#15
1440  01f7 1f01          	ldw	(OFST-4,sp),x
1442                     ; 539     if (FLASH_MemType == FLASH_MEMTYPE_PROG)
1444  01f9 a1fd          	cp	a,#253
1445  01fb 2634          	jrne	L155
1447  01fd 2011          	jra	L735
1448  01ff               L535:
1449                     ; 543             flagstatus = (uint8_t)(FLASH->IAPSR & (uint8_t)(FLASH_IAPSR_EOP |
1449                     ; 544                                               FLASH_IAPSR_WR_PG_DIS));
1451  01ff c6505f        	ld	a,20575
1452  0202 a405          	and	a,#5
1453  0204 6b05          	ld	(OFST+0,sp),a
1455                     ; 545             timeout--;
1457  0206 96            	ldw	x,sp
1458  0207 1c0001        	addw	x,#OFST-4
1459  020a a601          	ld	a,#1
1460  020c 8d000000      	callf	d_lgsbc
1463  0210               L735:
1464                     ; 541         while ((flagstatus == 0x00) && (timeout != 0x00))
1466  0210 0d05          	tnz	(OFST+0,sp)
1467  0212 262b          	jrne	L545
1469  0214 96            	ldw	x,sp
1470  0215 1c0001        	addw	x,#OFST-4
1471  0218 8d000000      	callf	d_lzmp
1473  021c 26e1          	jrne	L535
1474  021e 201f          	jra	L545
1475  0220               L745:
1476                     ; 552             flagstatus = (uint8_t)(FLASH->IAPSR & (uint8_t)(FLASH_IAPSR_HVOFF |
1476                     ; 553                                               FLASH_IAPSR_WR_PG_DIS));
1478  0220 c6505f        	ld	a,20575
1479  0223 a441          	and	a,#65
1480  0225 6b05          	ld	(OFST+0,sp),a
1482                     ; 554             timeout--;
1484  0227 96            	ldw	x,sp
1485  0228 1c0001        	addw	x,#OFST-4
1486  022b a601          	ld	a,#1
1487  022d 8d000000      	callf	d_lgsbc
1490  0231               L155:
1491                     ; 550         while ((flagstatus == 0x00) && (timeout != 0x00))
1493  0231 0d05          	tnz	(OFST+0,sp)
1494  0233 260a          	jrne	L545
1496  0235 96            	ldw	x,sp
1497  0236 1c0001        	addw	x,#OFST-4
1498  0239 8d000000      	callf	d_lzmp
1500  023d 26e1          	jrne	L745
1501  023f               L545:
1502                     ; 566     if (timeout == 0x00 )
1504  023f 96            	ldw	x,sp
1505  0240 1c0001        	addw	x,#OFST-4
1506  0243 8d000000      	callf	d_lzmp
1508  0247 2604          	jrne	L755
1509                     ; 568         flagstatus = FLASH_STATUS_TIMEOUT;
1511  0249 a602          	ld	a,#2
1512  024b 6b05          	ld	(OFST+0,sp),a
1514  024d               L755:
1515                     ; 571     return((FLASH_Status_TypeDef)flagstatus);
1517  024d 7b05          	ld	a,(OFST+0,sp)
1520  024f 5b05          	addw	sp,#5
1521  0251 87            	retf
1579                     ; 581 IN_RAM(void FLASH_EraseBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType))
1579                     ; 582 {
1580                     	switch	.text
1581  0252               f_FLASH_EraseBlock:
1583  0252 89            	pushw	x
1584  0253 5207          	subw	sp,#7
1585       00000007      OFST:	set	7
1588                     ; 583   uint32_t startaddress = 0;
1590                     ; 593   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1592                     ; 594   if (FLASH_MemType == FLASH_MEMTYPE_PROG)
1594  0255 7b0d          	ld	a,(OFST+6,sp)
1595  0257 a1fd          	cp	a,#253
1596  0259 260c          	jrne	L706
1597                     ; 596       assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1599                     ; 597       startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1601  025b ae8000        	ldw	x,#32768
1602  025e 1f03          	ldw	(OFST-4,sp),x
1603  0260 ae0000        	ldw	x,#0
1604  0263 1f01          	ldw	(OFST-6,sp),x
1607  0265 200a          	jra	L116
1608  0267               L706:
1609                     ; 601       assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1611                     ; 602       startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1613  0267 ae4000        	ldw	x,#16384
1614  026a 1f03          	ldw	(OFST-4,sp),x
1615  026c ae0000        	ldw	x,#0
1616  026f 1f01          	ldw	(OFST-6,sp),x
1618  0271               L116:
1619                     ; 607     pwFlash = (PointerAttr uint8_t *)(uint32_t)(startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE));
1621  0271 1e08          	ldw	x,(OFST+1,sp)
1622  0273 a680          	ld	a,#128
1623  0275 8d000000      	callf	d_cmulx
1625  0279 96            	ldw	x,sp
1626  027a 1c0001        	addw	x,#OFST-6
1627  027d 8d000000      	callf	d_ladd
1629  0281 450100        	mov	c_x,c_lreg+1
1630  0284 be02          	ldw	x,c_lreg+2
1631  0286 b600          	ld	a,c_x
1632  0288 6b05          	ld	(OFST-2,sp),a
1633  028a 1f06          	ldw	(OFST-1,sp),x
1635                     ; 614     FLASH->CR2 |= FLASH_CR2_ERASE;
1637  028c 721a505b      	bset	20571,#5
1638                     ; 615     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NERASE);
1640  0290 721b505c      	bres	20572,#5
1641                     ; 622   *pwFlash = (uint8_t)0;
1643  0294 7b05          	ld	a,(OFST-2,sp)
1644  0296 b700          	ld	c_x,a
1645  0298 1e06          	ldw	x,(OFST-1,sp)
1646  029a bf01          	ldw	c_x+1,x
1647  029c 4f            	clr	a
1648  029d 92bd0000      	ldf	[c_x.e],a
1649                     ; 623   *(pwFlash + 1) = (uint8_t)0;
1651  02a1 7b05          	ld	a,(OFST-2,sp)
1652  02a3 b700          	ld	c_x,a
1653  02a5 1e06          	ldw	x,(OFST-1,sp)
1654  02a7 90ae0001      	ldw	y,#1
1655  02ab bf01          	ldw	c_x+1,x
1656  02ad 93            	ldw	x,y
1657  02ae 4f            	clr	a
1658  02af 92a70000      	ldf	([c_x.e],x),a
1659                     ; 624   *(pwFlash + 2) = (uint8_t)0;
1661  02b3 7b05          	ld	a,(OFST-2,sp)
1662  02b5 b700          	ld	c_x,a
1663  02b7 1e06          	ldw	x,(OFST-1,sp)
1664  02b9 90ae0002      	ldw	y,#2
1665  02bd bf01          	ldw	c_x+1,x
1666  02bf 93            	ldw	x,y
1667  02c0 4f            	clr	a
1668  02c1 92a70000      	ldf	([c_x.e],x),a
1669                     ; 625   *(pwFlash + 3) = (uint8_t)0;    
1671  02c5 7b05          	ld	a,(OFST-2,sp)
1672  02c7 b700          	ld	c_x,a
1673  02c9 1e06          	ldw	x,(OFST-1,sp)
1674  02cb 90ae0003      	ldw	y,#3
1675  02cf bf01          	ldw	c_x+1,x
1676  02d1 93            	ldw	x,y
1677  02d2 4f            	clr	a
1678  02d3 92a70000      	ldf	([c_x.e],x),a
1679                     ; 627 }
1682  02d7 5b09          	addw	sp,#9
1683  02d9 87            	retf
1780                     ; 638 IN_RAM(void FLASH_ProgramBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType, 
1780                     ; 639                         FLASH_ProgramMode_TypeDef FLASH_ProgMode, uint8_t *Buffer))
1780                     ; 640 {
1781                     	switch	.text
1782  02da               f_FLASH_ProgramBlock:
1784  02da 89            	pushw	x
1785  02db 5206          	subw	sp,#6
1786       00000006      OFST:	set	6
1789                     ; 641     uint16_t Count = 0;
1791                     ; 642     uint32_t startaddress = 0;
1793                     ; 645     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1795                     ; 646     assert_param(IS_FLASH_PROGRAM_MODE_OK(FLASH_ProgMode));
1797                     ; 647     if (FLASH_MemType == FLASH_MEMTYPE_PROG)
1799  02dd 7b0c          	ld	a,(OFST+6,sp)
1800  02df a1fd          	cp	a,#253
1801  02e1 260c          	jrne	L756
1802                     ; 649         assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1804                     ; 650         startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1806  02e3 ae8000        	ldw	x,#32768
1807  02e6 1f03          	ldw	(OFST-3,sp),x
1808  02e8 ae0000        	ldw	x,#0
1809  02eb 1f01          	ldw	(OFST-5,sp),x
1812  02ed 200a          	jra	L166
1813  02ef               L756:
1814                     ; 654         assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1816                     ; 655         startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1818  02ef ae4000        	ldw	x,#16384
1819  02f2 1f03          	ldw	(OFST-3,sp),x
1820  02f4 ae0000        	ldw	x,#0
1821  02f7 1f01          	ldw	(OFST-5,sp),x
1823  02f9               L166:
1824                     ; 659     startaddress = startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE);
1826  02f9 1e07          	ldw	x,(OFST+1,sp)
1827  02fb a680          	ld	a,#128
1828  02fd 8d000000      	callf	d_cmulx
1830  0301 96            	ldw	x,sp
1831  0302 1c0001        	addw	x,#OFST-5
1832  0305 8d000000      	callf	d_lgadd
1835                     ; 662     if (FLASH_ProgMode == FLASH_PROGRAMMODE_STANDARD)
1837  0309 0d0d          	tnz	(OFST+7,sp)
1838  030b 260a          	jrne	L366
1839                     ; 665         FLASH->CR2 |= FLASH_CR2_PRG;
1841  030d 7210505b      	bset	20571,#0
1842                     ; 666         FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NPRG);
1844  0311 7211505c      	bres	20572,#0
1846  0315 2008          	jra	L566
1847  0317               L366:
1848                     ; 671         FLASH->CR2 |= FLASH_CR2_FPRG;
1850  0317 7218505b      	bset	20571,#4
1851                     ; 672         FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NFPRG);
1853  031b 7219505c      	bres	20572,#4
1854  031f               L566:
1855                     ; 676     for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1857  031f 5f            	clrw	x
1858  0320 1f05          	ldw	(OFST-1,sp),x
1860  0322               L766:
1861                     ; 680   *((PointerAttr uint8_t*) (uint16_t)startaddress + Count) = ((uint8_t)(Buffer[Count]));
1863  0322 7b03          	ld	a,(OFST-3,sp)
1864  0324 97            	ld	xl,a
1865  0325 7b04          	ld	a,(OFST-2,sp)
1866  0327 3f00          	clr	c_x
1867  0329 02            	rlwa	x,a
1868  032a 9093          	ldw	y,x
1869  032c 1605          	ldw	y,(OFST-1,sp)
1870  032e bf01          	ldw	c_x+1,x
1871  0330 93            	ldw	x,y
1872  0331 160e          	ldw	y,(OFST+8,sp)
1873  0333 72f905        	addw	y,(OFST-1,sp)
1874  0336 90f6          	ld	a,(y)
1875  0338 92a70000      	ldf	([c_x.e],x),a
1876                     ; 676     for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1878  033c 1e05          	ldw	x,(OFST-1,sp)
1879  033e 1c0001        	addw	x,#1
1880  0341 1f05          	ldw	(OFST-1,sp),x
1884  0343 1e05          	ldw	x,(OFST-1,sp)
1885  0345 a30080        	cpw	x,#128
1886  0348 25d8          	jrult	L766
1887                     ; 685 }
1890  034a 5b08          	addw	sp,#8
1891  034c 87            	retf
1903                     	xdef	f_FLASH_WaitForLastOperation
1904                     	xdef	f_FLASH_ProgramBlock
1905                     	xdef	f_FLASH_EraseBlock
1906                     	xdef	f_FLASH_GetFlagStatus
1907                     	xdef	f_FLASH_GetBootSize
1908                     	xdef	f_FLASH_GetProgrammingTime
1909                     	xdef	f_FLASH_GetLowPowerMode
1910                     	xdef	f_FLASH_SetProgrammingTime
1911                     	xdef	f_FLASH_SetLowPowerMode
1912                     	xdef	f_FLASH_EraseOptionByte
1913                     	xdef	f_FLASH_ProgramOptionByte
1914                     	xdef	f_FLASH_ReadOptionByte
1915                     	xdef	f_FLASH_ProgramWord
1916                     	xdef	f_FLASH_ReadByte
1917                     	xdef	f_FLASH_ProgramByte
1918                     	xdef	f_FLASH_EraseByte
1919                     	xdef	f_FLASH_ITConfig
1920                     	xdef	f_FLASH_DeInit
1921                     	xdef	f_FLASH_Lock
1922                     	xdef	f_FLASH_Unlock
1923                     	xref.b	c_lreg
1924                     	xref.b	c_x
1925                     	xref.b	c_y
1944                     	xref	d_ladd
1945                     	xref	d_cmulx
1946                     	xref	d_lzmp
1947                     	xref	d_lgsbc
1948                     	xref	d_ltor
1949                     	xref	d_lgadd
1950                     	xref	d_rtol
1951                     	xref	d_umul
1952                     	end
