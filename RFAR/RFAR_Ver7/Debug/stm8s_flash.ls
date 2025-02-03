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
 315                     ; 158 void FLASH_EraseByte(uint32_t Address)
 315                     ; 159 {
 316                     	switch	.text
 317  0044               f_FLASH_EraseByte:
 319       00000000      OFST:	set	0
 322                     ; 161     assert_param(IS_FLASH_ADDRESS_OK(Address));
 324                     ; 164    *(PointerAttr uint8_t*) (uint16_t)Address = FLASH_CLEAR_BYTE; 
 326  0044 7b06          	ld	a,(OFST+6,sp)
 327  0046 97            	ld	xl,a
 328  0047 7b07          	ld	a,(OFST+7,sp)
 329  0049 3f00          	clr	c_x
 330  004b 02            	rlwa	x,a
 331  004c 9093          	ldw	y,x
 332  004e bf01          	ldw	c_x+1,x
 333  0050 4f            	clr	a
 334  0051 92bd0000      	ldf	[c_x.e],a
 335                     ; 166 }
 338  0055 87            	retf
 380                     ; 176 void FLASH_ProgramByte(uint32_t Address, uint8_t Data)
 380                     ; 177 {
 381                     	switch	.text
 382  0056               f_FLASH_ProgramByte:
 384       00000000      OFST:	set	0
 387                     ; 179     assert_param(IS_FLASH_ADDRESS_OK(Address));
 389                     ; 180     *(PointerAttr uint8_t*) (uint16_t)Address = Data;
 391  0056 7b06          	ld	a,(OFST+6,sp)
 392  0058 97            	ld	xl,a
 393  0059 7b07          	ld	a,(OFST+7,sp)
 394  005b 3f00          	clr	c_x
 395  005d 02            	rlwa	x,a
 396  005e 9093          	ldw	y,x
 397  0060 7b08          	ld	a,(OFST+8,sp)
 398  0062 bf01          	ldw	c_x+1,x
 399  0064 92bd0000      	ldf	[c_x.e],a
 400                     ; 181 }
 403  0068 87            	retf
 436                     ; 190 uint8_t FLASH_ReadByte(uint32_t Address)
 436                     ; 191 {
 437                     	switch	.text
 438  0069               f_FLASH_ReadByte:
 440       00000000      OFST:	set	0
 443                     ; 193     assert_param(IS_FLASH_ADDRESS_OK(Address));
 445                     ; 196     return(*(PointerAttr uint8_t *) (uint16_t)Address); 
 447  0069 7b06          	ld	a,(OFST+6,sp)
 448  006b 97            	ld	xl,a
 449  006c 7b07          	ld	a,(OFST+7,sp)
 450  006e 3f00          	clr	c_x
 451  0070 02            	rlwa	x,a
 452  0071 9093          	ldw	y,x
 453  0073 bf01          	ldw	c_x+1,x
 454  0075 92bc0000      	ldf	a,[c_x.e]
 457  0079 87            	retf
 499                     ; 207 void FLASH_ProgramWord(uint32_t Address, uint32_t Data)
 499                     ; 208 {
 500                     	switch	.text
 501  007a               f_FLASH_ProgramWord:
 503       00000000      OFST:	set	0
 506                     ; 210     assert_param(IS_FLASH_ADDRESS_OK(Address));
 508                     ; 213     FLASH->CR2 |= FLASH_CR2_WPRG;
 510  007a 721c505b      	bset	20571,#6
 511                     ; 214     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
 513  007e 721d505c      	bres	20572,#6
 514                     ; 217     *((PointerAttr uint8_t*)(uint16_t)Address)       = *((uint8_t*)(&Data));
 516  0082 7b06          	ld	a,(OFST+6,sp)
 517  0084 97            	ld	xl,a
 518  0085 7b07          	ld	a,(OFST+7,sp)
 519  0087 3f00          	clr	c_x
 520  0089 02            	rlwa	x,a
 521  008a 9093          	ldw	y,x
 522  008c 7b08          	ld	a,(OFST+8,sp)
 523  008e bf01          	ldw	c_x+1,x
 524  0090 92bd0000      	ldf	[c_x.e],a
 525                     ; 219     *(((PointerAttr uint8_t*)(uint16_t)Address) + 1) = *((uint8_t*)(&Data)+1); 
 527  0094 7b06          	ld	a,(OFST+6,sp)
 528  0096 97            	ld	xl,a
 529  0097 7b07          	ld	a,(OFST+7,sp)
 530  0099 3f00          	clr	c_x
 531  009b 02            	rlwa	x,a
 532  009c 9093          	ldw	y,x
 533  009e 90ae0001      	ldw	y,#1
 534  00a2 bf01          	ldw	c_x+1,x
 535  00a4 93            	ldw	x,y
 536  00a5 7b09          	ld	a,(OFST+9,sp)
 537  00a7 92a70000      	ldf	([c_x.e],x),a
 538                     ; 221     *(((PointerAttr uint8_t*)(uint16_t)Address) + 2) = *((uint8_t*)(&Data)+2); 
 540  00ab 7b06          	ld	a,(OFST+6,sp)
 541  00ad 97            	ld	xl,a
 542  00ae 7b07          	ld	a,(OFST+7,sp)
 543  00b0 3f00          	clr	c_x
 544  00b2 02            	rlwa	x,a
 545  00b3 9093          	ldw	y,x
 546  00b5 90ae0002      	ldw	y,#2
 547  00b9 bf01          	ldw	c_x+1,x
 548  00bb 93            	ldw	x,y
 549  00bc 7b0a          	ld	a,(OFST+10,sp)
 550  00be 92a70000      	ldf	([c_x.e],x),a
 551                     ; 223     *(((PointerAttr uint8_t*)(uint16_t)Address) + 3) = *((uint8_t*)(&Data)+3); 
 553  00c2 7b06          	ld	a,(OFST+6,sp)
 554  00c4 97            	ld	xl,a
 555  00c5 7b07          	ld	a,(OFST+7,sp)
 556  00c7 3f00          	clr	c_x
 557  00c9 02            	rlwa	x,a
 558  00ca 9093          	ldw	y,x
 559  00cc 90ae0003      	ldw	y,#3
 560  00d0 bf01          	ldw	c_x+1,x
 561  00d2 93            	ldw	x,y
 562  00d3 7b0b          	ld	a,(OFST+11,sp)
 563  00d5 92a70000      	ldf	([c_x.e],x),a
 564                     ; 224 }
 567  00d9 87            	retf
 611                     ; 232 void FLASH_ProgramOptionByte(uint16_t Address, uint8_t Data)
 611                     ; 233 {
 612                     	switch	.text
 613  00da               f_FLASH_ProgramOptionByte:
 615  00da 89            	pushw	x
 616       00000000      OFST:	set	0
 619                     ; 235     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 621                     ; 238     FLASH->CR2 |= FLASH_CR2_OPT;
 623  00db 721e505b      	bset	20571,#7
 624                     ; 239     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 626  00df 721f505c      	bres	20572,#7
 627                     ; 242     if (Address == 0x4800)
 629  00e3 a34800        	cpw	x,#18432
 630  00e6 2607          	jrne	L542
 631                     ; 245        *((NEAR uint8_t*)Address) = Data;
 633  00e8 7b06          	ld	a,(OFST+6,sp)
 634  00ea 1e01          	ldw	x,(OFST+1,sp)
 635  00ec f7            	ld	(x),a
 637  00ed 200c          	jra	L742
 638  00ef               L542:
 639                     ; 250        *((NEAR uint8_t*)Address) = Data;
 641  00ef 7b06          	ld	a,(OFST+6,sp)
 642  00f1 1e01          	ldw	x,(OFST+1,sp)
 643  00f3 f7            	ld	(x),a
 644                     ; 251        *((NEAR uint8_t*)((uint16_t)(Address + 1))) = (uint8_t)(~Data);
 646  00f4 7b06          	ld	a,(OFST+6,sp)
 647  00f6 43            	cpl	a
 648  00f7 1e01          	ldw	x,(OFST+1,sp)
 649  00f9 e701          	ld	(1,x),a
 650  00fb               L742:
 651                     ; 253     FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 653  00fb a6fd          	ld	a,#253
 654  00fd 8deb01eb      	callf	f_FLASH_WaitForLastOperation
 656                     ; 256     FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 658  0101 721f505b      	bres	20571,#7
 659                     ; 257     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 661  0105 721e505c      	bset	20572,#7
 662                     ; 258 }
 665  0109 85            	popw	x
 666  010a 87            	retf
 701                     ; 265 void FLASH_EraseOptionByte(uint16_t Address)
 701                     ; 266 {
 702                     	switch	.text
 703  010b               f_FLASH_EraseOptionByte:
 705  010b 89            	pushw	x
 706       00000000      OFST:	set	0
 709                     ; 268     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 711                     ; 271     FLASH->CR2 |= FLASH_CR2_OPT;
 713  010c 721e505b      	bset	20571,#7
 714                     ; 272     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 716  0110 721f505c      	bres	20572,#7
 717                     ; 275      if (Address == 0x4800)
 719  0114 a34800        	cpw	x,#18432
 720  0117 2603          	jrne	L762
 721                     ; 278        *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 723  0119 7f            	clr	(x)
 725  011a 2009          	jra	L172
 726  011c               L762:
 727                     ; 283        *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 729  011c 1e01          	ldw	x,(OFST+1,sp)
 730  011e 7f            	clr	(x)
 731                     ; 284        *((NEAR uint8_t*)((uint16_t)(Address + (uint16_t)1 ))) = FLASH_SET_BYTE;
 733  011f 1e01          	ldw	x,(OFST+1,sp)
 734  0121 a6ff          	ld	a,#255
 735  0123 e701          	ld	(1,x),a
 736  0125               L172:
 737                     ; 286     FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 739  0125 a6fd          	ld	a,#253
 740  0127 8deb01eb      	callf	f_FLASH_WaitForLastOperation
 742                     ; 289     FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 744  012b 721f505b      	bres	20571,#7
 745                     ; 290     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 747  012f 721e505c      	bset	20572,#7
 748                     ; 291 }
 751  0133 85            	popw	x
 752  0134 87            	retf
 814                     ; 297 uint16_t FLASH_ReadOptionByte(uint16_t Address)
 814                     ; 298 {
 815                     	switch	.text
 816  0135               f_FLASH_ReadOptionByte:
 818  0135 5204          	subw	sp,#4
 819       00000004      OFST:	set	4
 822                     ; 299     uint8_t value_optbyte, value_optbyte_complement = 0;
 824                     ; 300     uint16_t res_value = 0;
 826                     ; 303     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 828                     ; 306     value_optbyte = *((NEAR uint8_t*)Address); /* Read option byte */
 830  0137 f6            	ld	a,(x)
 831  0138 6b01          	ld	(OFST-3,sp),a
 833                     ; 307     value_optbyte_complement = *(((NEAR uint8_t*)Address) + 1); /* Read option byte complement */
 835  013a e601          	ld	a,(1,x)
 836  013c 6b02          	ld	(OFST-2,sp),a
 838                     ; 310     if (Address == 0x4800)	 
 840  013e a34800        	cpw	x,#18432
 841  0141 2608          	jrne	L523
 842                     ; 312         res_value =	 value_optbyte;
 844  0143 7b01          	ld	a,(OFST-3,sp)
 845  0145 5f            	clrw	x
 846  0146 97            	ld	xl,a
 847  0147 1f03          	ldw	(OFST-1,sp),x
 850  0149 2023          	jra	L723
 851  014b               L523:
 852                     ; 316         if (value_optbyte == (uint8_t)(~value_optbyte_complement))
 854  014b 7b02          	ld	a,(OFST-2,sp)
 855  014d 43            	cpl	a
 856  014e 1101          	cp	a,(OFST-3,sp)
 857  0150 2617          	jrne	L133
 858                     ; 318             res_value = (uint16_t)((uint16_t)value_optbyte << 8);
 860  0152 7b01          	ld	a,(OFST-3,sp)
 861  0154 5f            	clrw	x
 862  0155 97            	ld	xl,a
 863  0156 4f            	clr	a
 864  0157 02            	rlwa	x,a
 865  0158 1f03          	ldw	(OFST-1,sp),x
 867                     ; 319             res_value = res_value | (uint16_t)value_optbyte_complement;
 869  015a 7b02          	ld	a,(OFST-2,sp)
 870  015c 5f            	clrw	x
 871  015d 97            	ld	xl,a
 872  015e 01            	rrwa	x,a
 873  015f 1a04          	or	a,(OFST+0,sp)
 874  0161 01            	rrwa	x,a
 875  0162 1a03          	or	a,(OFST-1,sp)
 876  0164 01            	rrwa	x,a
 877  0165 1f03          	ldw	(OFST-1,sp),x
 880  0167 2005          	jra	L723
 881  0169               L133:
 882                     ; 323             res_value = FLASH_OPTIONBYTE_ERROR;
 884  0169 ae5555        	ldw	x,#21845
 885  016c 1f03          	ldw	(OFST-1,sp),x
 887  016e               L723:
 888                     ; 326     return(res_value);
 890  016e 1e03          	ldw	x,(OFST-1,sp)
 893  0170 5b04          	addw	sp,#4
 894  0172 87            	retf
 967                     ; 335 void FLASH_SetLowPowerMode(FLASH_LPMode_TypeDef FLASH_LPMode)
 967                     ; 336 {
 968                     	switch	.text
 969  0173               f_FLASH_SetLowPowerMode:
 971  0173 88            	push	a
 972       00000000      OFST:	set	0
 975                     ; 338     assert_param(IS_FLASH_LOW_POWER_MODE_OK(FLASH_LPMode));
 977                     ; 341     FLASH->CR1 &= (uint8_t)(~(FLASH_CR1_HALT | FLASH_CR1_AHALT)); 
 979  0174 c6505a        	ld	a,20570
 980  0177 a4f3          	and	a,#243
 981  0179 c7505a        	ld	20570,a
 982                     ; 344     FLASH->CR1 |= (uint8_t)FLASH_LPMode; 
 984  017c c6505a        	ld	a,20570
 985  017f 1a01          	or	a,(OFST+1,sp)
 986  0181 c7505a        	ld	20570,a
 987                     ; 345 }
 990  0184 84            	pop	a
 991  0185 87            	retf
1048                     ; 353 void FLASH_SetProgrammingTime(FLASH_ProgramTime_TypeDef FLASH_ProgTime)
1048                     ; 354 {
1049                     	switch	.text
1050  0186               f_FLASH_SetProgrammingTime:
1054                     ; 356     assert_param(IS_FLASH_PROGRAM_TIME_OK(FLASH_ProgTime));
1056                     ; 358     FLASH->CR1 &= (uint8_t)(~FLASH_CR1_FIX);
1058  0186 7211505a      	bres	20570,#0
1059                     ; 359     FLASH->CR1 |= (uint8_t)FLASH_ProgTime;
1061  018a ca505a        	or	a,20570
1062  018d c7505a        	ld	20570,a
1063                     ; 360 }
1066  0190 87            	retf
1090                     ; 367 FLASH_LPMode_TypeDef FLASH_GetLowPowerMode(void)
1090                     ; 368 {
1091                     	switch	.text
1092  0191               f_FLASH_GetLowPowerMode:
1096                     ; 369     return((FLASH_LPMode_TypeDef)(FLASH->CR1 & (uint8_t)(FLASH_CR1_HALT | FLASH_CR1_AHALT)));
1098  0191 c6505a        	ld	a,20570
1099  0194 a40c          	and	a,#12
1102  0196 87            	retf
1126                     ; 377 FLASH_ProgramTime_TypeDef FLASH_GetProgrammingTime(void)
1126                     ; 378 {
1127                     	switch	.text
1128  0197               f_FLASH_GetProgrammingTime:
1132                     ; 379     return((FLASH_ProgramTime_TypeDef)(FLASH->CR1 & FLASH_CR1_FIX));
1134  0197 c6505a        	ld	a,20570
1135  019a a401          	and	a,#1
1138  019c 87            	retf
1171                     ; 387 uint32_t FLASH_GetBootSize(void)
1171                     ; 388 {
1172                     	switch	.text
1173  019d               f_FLASH_GetBootSize:
1175  019d 5204          	subw	sp,#4
1176       00000004      OFST:	set	4
1179                     ; 389     uint32_t temp = 0;
1181                     ; 392     temp = (uint32_t)((uint32_t)FLASH->FPR * (uint32_t)512);
1183  019f c6505d        	ld	a,20573
1184  01a2 5f            	clrw	x
1185  01a3 97            	ld	xl,a
1186  01a4 90ae0200      	ldw	y,#512
1187  01a8 8d000000      	callf	d_umul
1189  01ac 96            	ldw	x,sp
1190  01ad 1c0001        	addw	x,#OFST-3
1191  01b0 8d000000      	callf	d_rtol
1194                     ; 395     if (FLASH->FPR == 0xFF)
1196  01b4 c6505d        	ld	a,20573
1197  01b7 a1ff          	cp	a,#255
1198  01b9 2612          	jrne	L354
1199                     ; 397         temp += 512;
1201  01bb ae0200        	ldw	x,#512
1202  01be bf02          	ldw	c_lreg+2,x
1203  01c0 ae0000        	ldw	x,#0
1204  01c3 bf00          	ldw	c_lreg,x
1205  01c5 96            	ldw	x,sp
1206  01c6 1c0001        	addw	x,#OFST-3
1207  01c9 8d000000      	callf	d_lgadd
1210  01cd               L354:
1211                     ; 401     return(temp);
1213  01cd 96            	ldw	x,sp
1214  01ce 1c0001        	addw	x,#OFST-3
1215  01d1 8d000000      	callf	d_ltor
1219  01d5 5b04          	addw	sp,#4
1220  01d7 87            	retf
1328                     ; 412 FlagStatus FLASH_GetFlagStatus(FLASH_Flag_TypeDef FLASH_FLAG)
1328                     ; 413 {
1329                     	switch	.text
1330  01d8               f_FLASH_GetFlagStatus:
1332  01d8 88            	push	a
1333       00000001      OFST:	set	1
1336                     ; 414     FlagStatus status = RESET;
1338                     ; 416     assert_param(IS_FLASH_FLAGS_OK(FLASH_FLAG));
1340                     ; 419     if ((FLASH->IAPSR & (uint8_t)FLASH_FLAG) != (uint8_t)RESET)
1342  01d9 c4505f        	and	a,20575
1343  01dc 2706          	jreq	L525
1344                     ; 421         status = SET; /* FLASH_FLAG is set */
1346  01de a601          	ld	a,#1
1347  01e0 6b01          	ld	(OFST+0,sp),a
1350  01e2 2002          	jra	L725
1351  01e4               L525:
1352                     ; 425         status = RESET; /* FLASH_FLAG is reset*/
1354  01e4 0f01          	clr	(OFST+0,sp)
1356  01e6               L725:
1357                     ; 429     return status;
1359  01e6 7b01          	ld	a,(OFST+0,sp)
1362  01e8 5b01          	addw	sp,#1
1363  01ea 87            	retf
1455                     ; 531 IN_RAM(FLASH_Status_TypeDef FLASH_WaitForLastOperation(FLASH_MemType_TypeDef FLASH_MemType)) 
1455                     ; 532 {
1456                     	switch	.text
1457  01eb               f_FLASH_WaitForLastOperation:
1459  01eb 5205          	subw	sp,#5
1460       00000005      OFST:	set	5
1463                     ; 533     uint8_t flagstatus = 0x00;
1465  01ed 0f05          	clr	(OFST+0,sp)
1467                     ; 534     uint32_t timeout = OPERATION_TIMEOUT;
1469  01ef aeffff        	ldw	x,#65535
1470  01f2 1f03          	ldw	(OFST-2,sp),x
1471  01f4 ae000f        	ldw	x,#15
1472  01f7 1f01          	ldw	(OFST-4,sp),x
1474                     ; 539     if (FLASH_MemType == FLASH_MEMTYPE_PROG)
1476  01f9 a1fd          	cp	a,#253
1477  01fb 2634          	jrne	L116
1479  01fd 2011          	jra	L775
1480  01ff               L575:
1481                     ; 543             flagstatus = (uint8_t)(FLASH->IAPSR & (uint8_t)(FLASH_IAPSR_EOP |
1481                     ; 544                                               FLASH_IAPSR_WR_PG_DIS));
1483  01ff c6505f        	ld	a,20575
1484  0202 a405          	and	a,#5
1485  0204 6b05          	ld	(OFST+0,sp),a
1487                     ; 545             timeout--;
1489  0206 96            	ldw	x,sp
1490  0207 1c0001        	addw	x,#OFST-4
1491  020a a601          	ld	a,#1
1492  020c 8d000000      	callf	d_lgsbc
1495  0210               L775:
1496                     ; 541         while ((flagstatus == 0x00) && (timeout != 0x00))
1498  0210 0d05          	tnz	(OFST+0,sp)
1499  0212 262b          	jrne	L506
1501  0214 96            	ldw	x,sp
1502  0215 1c0001        	addw	x,#OFST-4
1503  0218 8d000000      	callf	d_lzmp
1505  021c 26e1          	jrne	L575
1506  021e 201f          	jra	L506
1507  0220               L706:
1508                     ; 552             flagstatus = (uint8_t)(FLASH->IAPSR & (uint8_t)(FLASH_IAPSR_HVOFF |
1508                     ; 553                                               FLASH_IAPSR_WR_PG_DIS));
1510  0220 c6505f        	ld	a,20575
1511  0223 a441          	and	a,#65
1512  0225 6b05          	ld	(OFST+0,sp),a
1514                     ; 554             timeout--;
1516  0227 96            	ldw	x,sp
1517  0228 1c0001        	addw	x,#OFST-4
1518  022b a601          	ld	a,#1
1519  022d 8d000000      	callf	d_lgsbc
1522  0231               L116:
1523                     ; 550         while ((flagstatus == 0x00) && (timeout != 0x00))
1525  0231 0d05          	tnz	(OFST+0,sp)
1526  0233 260a          	jrne	L506
1528  0235 96            	ldw	x,sp
1529  0236 1c0001        	addw	x,#OFST-4
1530  0239 8d000000      	callf	d_lzmp
1532  023d 26e1          	jrne	L706
1533  023f               L506:
1534                     ; 566     if (timeout == 0x00 )
1536  023f 96            	ldw	x,sp
1537  0240 1c0001        	addw	x,#OFST-4
1538  0243 8d000000      	callf	d_lzmp
1540  0247 2604          	jrne	L716
1541                     ; 568         flagstatus = FLASH_STATUS_TIMEOUT;
1543  0249 a602          	ld	a,#2
1544  024b 6b05          	ld	(OFST+0,sp),a
1546  024d               L716:
1547                     ; 571     return((FLASH_Status_TypeDef)flagstatus);
1549  024d 7b05          	ld	a,(OFST+0,sp)
1552  024f 5b05          	addw	sp,#5
1553  0251 87            	retf
1615                     ; 581 IN_RAM(void FLASH_EraseBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType))
1615                     ; 582 {
1616                     	switch	.text
1617  0252               f_FLASH_EraseBlock:
1619  0252 89            	pushw	x
1620  0253 5207          	subw	sp,#7
1621       00000007      OFST:	set	7
1624                     ; 583   uint32_t startaddress = 0;
1626                     ; 593   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1628                     ; 594   if (FLASH_MemType == FLASH_MEMTYPE_PROG)
1630  0255 7b0d          	ld	a,(OFST+6,sp)
1631  0257 a1fd          	cp	a,#253
1632  0259 260c          	jrne	L356
1633                     ; 596       assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1635                     ; 597       startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1637  025b ae8000        	ldw	x,#32768
1638  025e 1f03          	ldw	(OFST-4,sp),x
1639  0260 ae0000        	ldw	x,#0
1640  0263 1f01          	ldw	(OFST-6,sp),x
1643  0265 200a          	jra	L556
1644  0267               L356:
1645                     ; 601       assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1647                     ; 602       startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1649  0267 ae4000        	ldw	x,#16384
1650  026a 1f03          	ldw	(OFST-4,sp),x
1651  026c ae0000        	ldw	x,#0
1652  026f 1f01          	ldw	(OFST-6,sp),x
1654  0271               L556:
1655                     ; 607     pwFlash = (PointerAttr uint8_t *)(uint32_t)(startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE));
1657  0271 1e08          	ldw	x,(OFST+1,sp)
1658  0273 a680          	ld	a,#128
1659  0275 8d000000      	callf	d_cmulx
1661  0279 96            	ldw	x,sp
1662  027a 1c0001        	addw	x,#OFST-6
1663  027d 8d000000      	callf	d_ladd
1665  0281 450100        	mov	c_x,c_lreg+1
1666  0284 be02          	ldw	x,c_lreg+2
1667  0286 b600          	ld	a,c_x
1668  0288 6b05          	ld	(OFST-2,sp),a
1669  028a 1f06          	ldw	(OFST-1,sp),x
1671                     ; 614     FLASH->CR2 |= FLASH_CR2_ERASE;
1673  028c 721a505b      	bset	20571,#5
1674                     ; 615     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NERASE);
1676  0290 721b505c      	bres	20572,#5
1677                     ; 622   *pwFlash = (uint8_t)0;
1679  0294 7b05          	ld	a,(OFST-2,sp)
1680  0296 b700          	ld	c_x,a
1681  0298 1e06          	ldw	x,(OFST-1,sp)
1682  029a bf01          	ldw	c_x+1,x
1683  029c 4f            	clr	a
1684  029d 92bd0000      	ldf	[c_x.e],a
1685                     ; 623   *(pwFlash + 1) = (uint8_t)0;
1687  02a1 7b05          	ld	a,(OFST-2,sp)
1688  02a3 b700          	ld	c_x,a
1689  02a5 1e06          	ldw	x,(OFST-1,sp)
1690  02a7 90ae0001      	ldw	y,#1
1691  02ab bf01          	ldw	c_x+1,x
1692  02ad 93            	ldw	x,y
1693  02ae 4f            	clr	a
1694  02af 92a70000      	ldf	([c_x.e],x),a
1695                     ; 624   *(pwFlash + 2) = (uint8_t)0;
1697  02b3 7b05          	ld	a,(OFST-2,sp)
1698  02b5 b700          	ld	c_x,a
1699  02b7 1e06          	ldw	x,(OFST-1,sp)
1700  02b9 90ae0002      	ldw	y,#2
1701  02bd bf01          	ldw	c_x+1,x
1702  02bf 93            	ldw	x,y
1703  02c0 4f            	clr	a
1704  02c1 92a70000      	ldf	([c_x.e],x),a
1705                     ; 625   *(pwFlash + 3) = (uint8_t)0;    
1707  02c5 7b05          	ld	a,(OFST-2,sp)
1708  02c7 b700          	ld	c_x,a
1709  02c9 1e06          	ldw	x,(OFST-1,sp)
1710  02cb 90ae0003      	ldw	y,#3
1711  02cf bf01          	ldw	c_x+1,x
1712  02d1 93            	ldw	x,y
1713  02d2 4f            	clr	a
1714  02d3 92a70000      	ldf	([c_x.e],x),a
1715                     ; 627 }
1718  02d7 5b09          	addw	sp,#9
1719  02d9 87            	retf
1822                     ; 638 IN_RAM(void FLASH_ProgramBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType, 
1822                     ; 639                         FLASH_ProgramMode_TypeDef FLASH_ProgMode, uint8_t *Buffer))
1822                     ; 640 {
1823                     	switch	.text
1824  02da               f_FLASH_ProgramBlock:
1826  02da 89            	pushw	x
1827  02db 5206          	subw	sp,#6
1828       00000006      OFST:	set	6
1831                     ; 641     uint16_t Count = 0;
1833                     ; 642     uint32_t startaddress = 0;
1835                     ; 645     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1837                     ; 646     assert_param(IS_FLASH_PROGRAM_MODE_OK(FLASH_ProgMode));
1839                     ; 647     if (FLASH_MemType == FLASH_MEMTYPE_PROG)
1841  02dd 7b0c          	ld	a,(OFST+6,sp)
1842  02df a1fd          	cp	a,#253
1843  02e1 260c          	jrne	L137
1844                     ; 649         assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1846                     ; 650         startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1848  02e3 ae8000        	ldw	x,#32768
1849  02e6 1f03          	ldw	(OFST-3,sp),x
1850  02e8 ae0000        	ldw	x,#0
1851  02eb 1f01          	ldw	(OFST-5,sp),x
1854  02ed 200a          	jra	L337
1855  02ef               L137:
1856                     ; 654         assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1858                     ; 655         startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1860  02ef ae4000        	ldw	x,#16384
1861  02f2 1f03          	ldw	(OFST-3,sp),x
1862  02f4 ae0000        	ldw	x,#0
1863  02f7 1f01          	ldw	(OFST-5,sp),x
1865  02f9               L337:
1866                     ; 659     startaddress = startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE);
1868  02f9 1e07          	ldw	x,(OFST+1,sp)
1869  02fb a680          	ld	a,#128
1870  02fd 8d000000      	callf	d_cmulx
1872  0301 96            	ldw	x,sp
1873  0302 1c0001        	addw	x,#OFST-5
1874  0305 8d000000      	callf	d_lgadd
1877                     ; 662     if (FLASH_ProgMode == FLASH_PROGRAMMODE_STANDARD)
1879  0309 0d0d          	tnz	(OFST+7,sp)
1880  030b 260a          	jrne	L537
1881                     ; 665         FLASH->CR2 |= FLASH_CR2_PRG;
1883  030d 7210505b      	bset	20571,#0
1884                     ; 666         FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NPRG);
1886  0311 7211505c      	bres	20572,#0
1888  0315 2008          	jra	L737
1889  0317               L537:
1890                     ; 671         FLASH->CR2 |= FLASH_CR2_FPRG;
1892  0317 7218505b      	bset	20571,#4
1893                     ; 672         FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NFPRG);
1895  031b 7219505c      	bres	20572,#4
1896  031f               L737:
1897                     ; 676     for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1899  031f 5f            	clrw	x
1900  0320 1f05          	ldw	(OFST-1,sp),x
1902  0322               L147:
1903                     ; 680   *((PointerAttr uint8_t*) (uint16_t)startaddress + Count) = ((uint8_t)(Buffer[Count]));
1905  0322 7b03          	ld	a,(OFST-3,sp)
1906  0324 97            	ld	xl,a
1907  0325 7b04          	ld	a,(OFST-2,sp)
1908  0327 3f00          	clr	c_x
1909  0329 02            	rlwa	x,a
1910  032a 9093          	ldw	y,x
1911  032c 1605          	ldw	y,(OFST-1,sp)
1912  032e bf01          	ldw	c_x+1,x
1913  0330 93            	ldw	x,y
1914  0331 160e          	ldw	y,(OFST+8,sp)
1915  0333 72f905        	addw	y,(OFST-1,sp)
1916  0336 90f6          	ld	a,(y)
1917  0338 92a70000      	ldf	([c_x.e],x),a
1918                     ; 676     for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1920  033c 1e05          	ldw	x,(OFST-1,sp)
1921  033e 1c0001        	addw	x,#1
1922  0341 1f05          	ldw	(OFST-1,sp),x
1926  0343 1e05          	ldw	x,(OFST-1,sp)
1927  0345 a30080        	cpw	x,#128
1928  0348 25d8          	jrult	L147
1929                     ; 685 }
1932  034a 5b08          	addw	sp,#8
1933  034c 87            	retf
1945                     	xdef	f_FLASH_WaitForLastOperation
1946                     	xdef	f_FLASH_ProgramBlock
1947                     	xdef	f_FLASH_EraseBlock
1948                     	xdef	f_FLASH_GetFlagStatus
1949                     	xdef	f_FLASH_GetBootSize
1950                     	xdef	f_FLASH_GetProgrammingTime
1951                     	xdef	f_FLASH_GetLowPowerMode
1952                     	xdef	f_FLASH_SetProgrammingTime
1953                     	xdef	f_FLASH_SetLowPowerMode
1954                     	xdef	f_FLASH_EraseOptionByte
1955                     	xdef	f_FLASH_ProgramOptionByte
1956                     	xdef	f_FLASH_ReadOptionByte
1957                     	xdef	f_FLASH_ProgramWord
1958                     	xdef	f_FLASH_ReadByte
1959                     	xdef	f_FLASH_ProgramByte
1960                     	xdef	f_FLASH_EraseByte
1961                     	xdef	f_FLASH_ITConfig
1962                     	xdef	f_FLASH_DeInit
1963                     	xdef	f_FLASH_Lock
1964                     	xdef	f_FLASH_Unlock
1965                     	xref.b	c_lreg
1966                     	xref.b	c_x
1967                     	xref.b	c_y
1986                     	xref	d_ladd
1987                     	xref	d_cmulx
1988                     	xref	d_lzmp
1989                     	xref	d_lgsbc
1990                     	xref	d_ltor
1991                     	xref	d_lgadd
1992                     	xref	d_rtol
1993                     	xref	d_umul
1994                     	end
