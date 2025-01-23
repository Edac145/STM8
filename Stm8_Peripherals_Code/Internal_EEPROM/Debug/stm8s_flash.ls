   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  74                     ; 81 void FLASH_Unlock(FLASH_MemType_TypeDef FLASH_MemType)
  74                     ; 82 {
  76                     	switch	.text
  77  0000               _FLASH_Unlock:
  81                     ; 84     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
  83                     ; 87     if (FLASH_MemType == FLASH_MEMTYPE_PROG)
  85  0000 a1fd          	cp	a,#253
  86  0002 260a          	jrne	L73
  87                     ; 89         FLASH->PUKR = FLASH_RASS_KEY1;
  89  0004 35565062      	mov	20578,#86
  90                     ; 90         FLASH->PUKR = FLASH_RASS_KEY2;
  92  0008 35ae5062      	mov	20578,#174
  94  000c 2008          	jra	L14
  95  000e               L73:
  96                     ; 95         FLASH->DUKR = FLASH_RASS_KEY2; /* Warning: keys are reversed on data memory !!! */
  98  000e 35ae5064      	mov	20580,#174
  99                     ; 96         FLASH->DUKR = FLASH_RASS_KEY1;
 101  0012 35565064      	mov	20580,#86
 102  0016               L14:
 103                     ; 98 }
 106  0016 81            	ret
 141                     ; 106 void FLASH_Lock(FLASH_MemType_TypeDef FLASH_MemType)
 141                     ; 107 {
 142                     	switch	.text
 143  0017               _FLASH_Lock:
 147                     ; 109     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
 149                     ; 112   FLASH->IAPSR &= (uint8_t)FLASH_MemType;
 151  0017 c4505f        	and	a,20575
 152  001a c7505f        	ld	20575,a
 153                     ; 113 }
 156  001d 81            	ret
 179                     ; 120 void FLASH_DeInit(void)
 179                     ; 121 {
 180                     	switch	.text
 181  001e               _FLASH_DeInit:
 185                     ; 122     FLASH->CR1 = FLASH_CR1_RESET_VALUE;
 187  001e 725f505a      	clr	20570
 188                     ; 123     FLASH->CR2 = FLASH_CR2_RESET_VALUE;
 190  0022 725f505b      	clr	20571
 191                     ; 124     FLASH->NCR2 = FLASH_NCR2_RESET_VALUE;
 193  0026 35ff505c      	mov	20572,#255
 194                     ; 125     FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_DUL);
 196  002a 7217505f      	bres	20575,#3
 197                     ; 126     FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_PUL);
 199  002e 7213505f      	bres	20575,#1
 200                     ; 127     (void) FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
 202  0032 c6505f        	ld	a,20575
 203                     ; 128 }
 206  0035 81            	ret
 261                     ; 136 void FLASH_ITConfig(FunctionalState NewState)
 261                     ; 137 {
 262                     	switch	.text
 263  0036               _FLASH_ITConfig:
 267                     ; 139   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 269                     ; 141     if (NewState != DISABLE)
 271  0036 4d            	tnz	a
 272  0037 2706          	jreq	L711
 273                     ; 143         FLASH->CR1 |= FLASH_CR1_IE; /* Enables the interrupt sources */
 275  0039 7212505a      	bset	20570,#1
 277  003d 2004          	jra	L121
 278  003f               L711:
 279                     ; 147         FLASH->CR1 &= (uint8_t)(~FLASH_CR1_IE); /* Disables the interrupt sources */
 281  003f 7213505a      	bres	20570,#1
 282  0043               L121:
 283                     ; 149 }
 286  0043 81            	ret
 320                     ; 158 void FLASH_EraseByte(uint32_t Address)
 320                     ; 159 {
 321                     	switch	.text
 322  0044               _FLASH_EraseByte:
 324       00000000      OFST:	set	0
 327                     ; 161     assert_param(IS_FLASH_ADDRESS_OK(Address));
 329                     ; 164    *(PointerAttr uint8_t*) (uint16_t)Address = FLASH_CLEAR_BYTE; 
 331  0044 7b05          	ld	a,(OFST+5,sp)
 332  0046 97            	ld	xl,a
 333  0047 7b06          	ld	a,(OFST+6,sp)
 334  0049 3f00          	clr	c_x
 335  004b 02            	rlwa	x,a
 336  004c 9093          	ldw	y,x
 337  004e bf01          	ldw	c_x+1,x
 338  0050 4f            	clr	a
 339  0051 92bd0000      	ldf	[c_x.e],a
 340                     ; 166 }
 343  0055 81            	ret
 386                     ; 176 void FLASH_ProgramByte(uint32_t Address, uint8_t Data)
 386                     ; 177 {
 387                     	switch	.text
 388  0056               _FLASH_ProgramByte:
 390       00000000      OFST:	set	0
 393                     ; 179     assert_param(IS_FLASH_ADDRESS_OK(Address));
 395                     ; 180     *(PointerAttr uint8_t*) (uint16_t)Address = Data;
 397  0056 7b05          	ld	a,(OFST+5,sp)
 398  0058 97            	ld	xl,a
 399  0059 7b06          	ld	a,(OFST+6,sp)
 400  005b 3f00          	clr	c_x
 401  005d 02            	rlwa	x,a
 402  005e 9093          	ldw	y,x
 403  0060 7b07          	ld	a,(OFST+7,sp)
 404  0062 bf01          	ldw	c_x+1,x
 405  0064 92bd0000      	ldf	[c_x.e],a
 406                     ; 181 }
 409  0068 81            	ret
 443                     ; 190 uint8_t FLASH_ReadByte(uint32_t Address)
 443                     ; 191 {
 444                     	switch	.text
 445  0069               _FLASH_ReadByte:
 447       00000000      OFST:	set	0
 450                     ; 193     assert_param(IS_FLASH_ADDRESS_OK(Address));
 452                     ; 196     return(*(PointerAttr uint8_t *) (uint16_t)Address); 
 454  0069 7b05          	ld	a,(OFST+5,sp)
 455  006b 97            	ld	xl,a
 456  006c 7b06          	ld	a,(OFST+6,sp)
 457  006e 3f00          	clr	c_x
 458  0070 02            	rlwa	x,a
 459  0071 9093          	ldw	y,x
 460  0073 bf01          	ldw	c_x+1,x
 461  0075 92bc0000      	ldf	a,[c_x.e]
 464  0079 81            	ret
 507                     ; 207 void FLASH_ProgramWord(uint32_t Address, uint32_t Data)
 507                     ; 208 {
 508                     	switch	.text
 509  007a               _FLASH_ProgramWord:
 511       00000000      OFST:	set	0
 514                     ; 210     assert_param(IS_FLASH_ADDRESS_OK(Address));
 516                     ; 213     FLASH->CR2 |= FLASH_CR2_WPRG;
 518  007a 721c505b      	bset	20571,#6
 519                     ; 214     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
 521  007e 721d505c      	bres	20572,#6
 522                     ; 217     *((PointerAttr uint8_t*)(uint16_t)Address)       = *((uint8_t*)(&Data));
 524  0082 7b05          	ld	a,(OFST+5,sp)
 525  0084 97            	ld	xl,a
 526  0085 7b06          	ld	a,(OFST+6,sp)
 527  0087 3f00          	clr	c_x
 528  0089 02            	rlwa	x,a
 529  008a 9093          	ldw	y,x
 530  008c 7b07          	ld	a,(OFST+7,sp)
 531  008e bf01          	ldw	c_x+1,x
 532  0090 92bd0000      	ldf	[c_x.e],a
 533                     ; 219     *(((PointerAttr uint8_t*)(uint16_t)Address) + 1) = *((uint8_t*)(&Data)+1); 
 535  0094 7b05          	ld	a,(OFST+5,sp)
 536  0096 97            	ld	xl,a
 537  0097 7b06          	ld	a,(OFST+6,sp)
 538  0099 3f00          	clr	c_x
 539  009b 02            	rlwa	x,a
 540  009c 9093          	ldw	y,x
 541  009e 90ae0001      	ldw	y,#1
 542  00a2 bf01          	ldw	c_x+1,x
 543  00a4 93            	ldw	x,y
 544  00a5 7b08          	ld	a,(OFST+8,sp)
 545  00a7 92a70000      	ldf	([c_x.e],x),a
 546                     ; 221     *(((PointerAttr uint8_t*)(uint16_t)Address) + 2) = *((uint8_t*)(&Data)+2); 
 548  00ab 7b05          	ld	a,(OFST+5,sp)
 549  00ad 97            	ld	xl,a
 550  00ae 7b06          	ld	a,(OFST+6,sp)
 551  00b0 3f00          	clr	c_x
 552  00b2 02            	rlwa	x,a
 553  00b3 9093          	ldw	y,x
 554  00b5 90ae0002      	ldw	y,#2
 555  00b9 bf01          	ldw	c_x+1,x
 556  00bb 93            	ldw	x,y
 557  00bc 7b09          	ld	a,(OFST+9,sp)
 558  00be 92a70000      	ldf	([c_x.e],x),a
 559                     ; 223     *(((PointerAttr uint8_t*)(uint16_t)Address) + 3) = *((uint8_t*)(&Data)+3); 
 561  00c2 7b05          	ld	a,(OFST+5,sp)
 562  00c4 97            	ld	xl,a
 563  00c5 7b06          	ld	a,(OFST+6,sp)
 564  00c7 3f00          	clr	c_x
 565  00c9 02            	rlwa	x,a
 566  00ca 9093          	ldw	y,x
 567  00cc 90ae0003      	ldw	y,#3
 568  00d0 bf01          	ldw	c_x+1,x
 569  00d2 93            	ldw	x,y
 570  00d3 7b0a          	ld	a,(OFST+10,sp)
 571  00d5 92a70000      	ldf	([c_x.e],x),a
 572                     ; 224 }
 575  00d9 81            	ret
 620                     ; 232 void FLASH_ProgramOptionByte(uint16_t Address, uint8_t Data)
 620                     ; 233 {
 621                     	switch	.text
 622  00da               _FLASH_ProgramOptionByte:
 624  00da 89            	pushw	x
 625       00000000      OFST:	set	0
 628                     ; 235     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 630                     ; 238     FLASH->CR2 |= FLASH_CR2_OPT;
 632  00db 721e505b      	bset	20571,#7
 633                     ; 239     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 635  00df 721f505c      	bres	20572,#7
 636                     ; 242     if (Address == 0x4800)
 638  00e3 a34800        	cpw	x,#18432
 639  00e6 2607          	jrne	L542
 640                     ; 245        *((NEAR uint8_t*)Address) = Data;
 642  00e8 7b05          	ld	a,(OFST+5,sp)
 643  00ea 1e01          	ldw	x,(OFST+1,sp)
 644  00ec f7            	ld	(x),a
 646  00ed 200c          	jra	L742
 647  00ef               L542:
 648                     ; 250        *((NEAR uint8_t*)Address) = Data;
 650  00ef 7b05          	ld	a,(OFST+5,sp)
 651  00f1 1e01          	ldw	x,(OFST+1,sp)
 652  00f3 f7            	ld	(x),a
 653                     ; 251        *((NEAR uint8_t*)((uint16_t)(Address + 1))) = (uint8_t)(~Data);
 655  00f4 7b05          	ld	a,(OFST+5,sp)
 656  00f6 43            	cpl	a
 657  00f7 1e01          	ldw	x,(OFST+1,sp)
 658  00f9 e701          	ld	(1,x),a
 659  00fb               L742:
 660                     ; 253     FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 662  00fb a6fd          	ld	a,#253
 663  00fd cd01e5        	call	_FLASH_WaitForLastOperation
 665                     ; 256     FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 667  0100 721f505b      	bres	20571,#7
 668                     ; 257     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 670  0104 721e505c      	bset	20572,#7
 671                     ; 258 }
 674  0108 85            	popw	x
 675  0109 81            	ret
 711                     ; 265 void FLASH_EraseOptionByte(uint16_t Address)
 711                     ; 266 {
 712                     	switch	.text
 713  010a               _FLASH_EraseOptionByte:
 715  010a 89            	pushw	x
 716       00000000      OFST:	set	0
 719                     ; 268     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 721                     ; 271     FLASH->CR2 |= FLASH_CR2_OPT;
 723  010b 721e505b      	bset	20571,#7
 724                     ; 272     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 726  010f 721f505c      	bres	20572,#7
 727                     ; 275      if (Address == 0x4800)
 729  0113 a34800        	cpw	x,#18432
 730  0116 2603          	jrne	L762
 731                     ; 278        *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 733  0118 7f            	clr	(x)
 735  0119 2009          	jra	L172
 736  011b               L762:
 737                     ; 283        *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 739  011b 1e01          	ldw	x,(OFST+1,sp)
 740  011d 7f            	clr	(x)
 741                     ; 284        *((NEAR uint8_t*)((uint16_t)(Address + (uint16_t)1 ))) = FLASH_SET_BYTE;
 743  011e 1e01          	ldw	x,(OFST+1,sp)
 744  0120 a6ff          	ld	a,#255
 745  0122 e701          	ld	(1,x),a
 746  0124               L172:
 747                     ; 286     FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 749  0124 a6fd          	ld	a,#253
 750  0126 cd01e5        	call	_FLASH_WaitForLastOperation
 752                     ; 289     FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 754  0129 721f505b      	bres	20571,#7
 755                     ; 290     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 757  012d 721e505c      	bset	20572,#7
 758                     ; 291 }
 761  0131 85            	popw	x
 762  0132 81            	ret
 825                     ; 297 uint16_t FLASH_ReadOptionByte(uint16_t Address)
 825                     ; 298 {
 826                     	switch	.text
 827  0133               _FLASH_ReadOptionByte:
 829  0133 5204          	subw	sp,#4
 830       00000004      OFST:	set	4
 833                     ; 299     uint8_t value_optbyte, value_optbyte_complement = 0;
 835                     ; 300     uint16_t res_value = 0;
 837                     ; 303     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 839                     ; 306     value_optbyte = *((NEAR uint8_t*)Address); /* Read option byte */
 841  0135 f6            	ld	a,(x)
 842  0136 6b01          	ld	(OFST-3,sp),a
 844                     ; 307     value_optbyte_complement = *(((NEAR uint8_t*)Address) + 1); /* Read option byte complement */
 846  0138 e601          	ld	a,(1,x)
 847  013a 6b02          	ld	(OFST-2,sp),a
 849                     ; 310     if (Address == 0x4800)	 
 851  013c a34800        	cpw	x,#18432
 852  013f 2608          	jrne	L523
 853                     ; 312         res_value =	 value_optbyte;
 855  0141 7b01          	ld	a,(OFST-3,sp)
 856  0143 5f            	clrw	x
 857  0144 97            	ld	xl,a
 858  0145 1f03          	ldw	(OFST-1,sp),x
 861  0147 2023          	jra	L723
 862  0149               L523:
 863                     ; 316         if (value_optbyte == (uint8_t)(~value_optbyte_complement))
 865  0149 7b02          	ld	a,(OFST-2,sp)
 866  014b 43            	cpl	a
 867  014c 1101          	cp	a,(OFST-3,sp)
 868  014e 2617          	jrne	L133
 869                     ; 318             res_value = (uint16_t)((uint16_t)value_optbyte << 8);
 871  0150 7b01          	ld	a,(OFST-3,sp)
 872  0152 5f            	clrw	x
 873  0153 97            	ld	xl,a
 874  0154 4f            	clr	a
 875  0155 02            	rlwa	x,a
 876  0156 1f03          	ldw	(OFST-1,sp),x
 878                     ; 319             res_value = res_value | (uint16_t)value_optbyte_complement;
 880  0158 7b02          	ld	a,(OFST-2,sp)
 881  015a 5f            	clrw	x
 882  015b 97            	ld	xl,a
 883  015c 01            	rrwa	x,a
 884  015d 1a04          	or	a,(OFST+0,sp)
 885  015f 01            	rrwa	x,a
 886  0160 1a03          	or	a,(OFST-1,sp)
 887  0162 01            	rrwa	x,a
 888  0163 1f03          	ldw	(OFST-1,sp),x
 891  0165 2005          	jra	L723
 892  0167               L133:
 893                     ; 323             res_value = FLASH_OPTIONBYTE_ERROR;
 895  0167 ae5555        	ldw	x,#21845
 896  016a 1f03          	ldw	(OFST-1,sp),x
 898  016c               L723:
 899                     ; 326     return(res_value);
 901  016c 1e03          	ldw	x,(OFST-1,sp)
 904  016e 5b04          	addw	sp,#4
 905  0170 81            	ret
 979                     ; 335 void FLASH_SetLowPowerMode(FLASH_LPMode_TypeDef FLASH_LPMode)
 979                     ; 336 {
 980                     	switch	.text
 981  0171               _FLASH_SetLowPowerMode:
 983  0171 88            	push	a
 984       00000000      OFST:	set	0
 987                     ; 338     assert_param(IS_FLASH_LOW_POWER_MODE_OK(FLASH_LPMode));
 989                     ; 341     FLASH->CR1 &= (uint8_t)(~(FLASH_CR1_HALT | FLASH_CR1_AHALT)); 
 991  0172 c6505a        	ld	a,20570
 992  0175 a4f3          	and	a,#243
 993  0177 c7505a        	ld	20570,a
 994                     ; 344     FLASH->CR1 |= (uint8_t)FLASH_LPMode; 
 996  017a c6505a        	ld	a,20570
 997  017d 1a01          	or	a,(OFST+1,sp)
 998  017f c7505a        	ld	20570,a
 999                     ; 345 }
1002  0182 84            	pop	a
1003  0183 81            	ret
1061                     ; 353 void FLASH_SetProgrammingTime(FLASH_ProgramTime_TypeDef FLASH_ProgTime)
1061                     ; 354 {
1062                     	switch	.text
1063  0184               _FLASH_SetProgrammingTime:
1067                     ; 356     assert_param(IS_FLASH_PROGRAM_TIME_OK(FLASH_ProgTime));
1069                     ; 358     FLASH->CR1 &= (uint8_t)(~FLASH_CR1_FIX);
1071  0184 7211505a      	bres	20570,#0
1072                     ; 359     FLASH->CR1 |= (uint8_t)FLASH_ProgTime;
1074  0188 ca505a        	or	a,20570
1075  018b c7505a        	ld	20570,a
1076                     ; 360 }
1079  018e 81            	ret
1104                     ; 367 FLASH_LPMode_TypeDef FLASH_GetLowPowerMode(void)
1104                     ; 368 {
1105                     	switch	.text
1106  018f               _FLASH_GetLowPowerMode:
1110                     ; 369     return((FLASH_LPMode_TypeDef)(FLASH->CR1 & (uint8_t)(FLASH_CR1_HALT | FLASH_CR1_AHALT)));
1112  018f c6505a        	ld	a,20570
1113  0192 a40c          	and	a,#12
1116  0194 81            	ret
1141                     ; 377 FLASH_ProgramTime_TypeDef FLASH_GetProgrammingTime(void)
1141                     ; 378 {
1142                     	switch	.text
1143  0195               _FLASH_GetProgrammingTime:
1147                     ; 379     return((FLASH_ProgramTime_TypeDef)(FLASH->CR1 & FLASH_CR1_FIX));
1149  0195 c6505a        	ld	a,20570
1150  0198 a401          	and	a,#1
1153  019a 81            	ret
1187                     ; 387 uint32_t FLASH_GetBootSize(void)
1187                     ; 388 {
1188                     	switch	.text
1189  019b               _FLASH_GetBootSize:
1191  019b 5204          	subw	sp,#4
1192       00000004      OFST:	set	4
1195                     ; 389     uint32_t temp = 0;
1197                     ; 392     temp = (uint32_t)((uint32_t)FLASH->FPR * (uint32_t)512);
1199  019d c6505d        	ld	a,20573
1200  01a0 5f            	clrw	x
1201  01a1 97            	ld	xl,a
1202  01a2 90ae0200      	ldw	y,#512
1203  01a6 cd0000        	call	c_umul
1205  01a9 96            	ldw	x,sp
1206  01aa 1c0001        	addw	x,#OFST-3
1207  01ad cd0000        	call	c_rtol
1210                     ; 395     if (FLASH->FPR == 0xFF)
1212  01b0 c6505d        	ld	a,20573
1213  01b3 a1ff          	cp	a,#255
1214  01b5 2611          	jrne	L354
1215                     ; 397         temp += 512;
1217  01b7 ae0200        	ldw	x,#512
1218  01ba bf02          	ldw	c_lreg+2,x
1219  01bc ae0000        	ldw	x,#0
1220  01bf bf00          	ldw	c_lreg,x
1221  01c1 96            	ldw	x,sp
1222  01c2 1c0001        	addw	x,#OFST-3
1223  01c5 cd0000        	call	c_lgadd
1226  01c8               L354:
1227                     ; 401     return(temp);
1229  01c8 96            	ldw	x,sp
1230  01c9 1c0001        	addw	x,#OFST-3
1231  01cc cd0000        	call	c_ltor
1235  01cf 5b04          	addw	sp,#4
1236  01d1 81            	ret
1345                     ; 412 FlagStatus FLASH_GetFlagStatus(FLASH_Flag_TypeDef FLASH_FLAG)
1345                     ; 413 {
1346                     	switch	.text
1347  01d2               _FLASH_GetFlagStatus:
1349  01d2 88            	push	a
1350       00000001      OFST:	set	1
1353                     ; 414     FlagStatus status = RESET;
1355                     ; 416     assert_param(IS_FLASH_FLAGS_OK(FLASH_FLAG));
1357                     ; 419     if ((FLASH->IAPSR & (uint8_t)FLASH_FLAG) != (uint8_t)RESET)
1359  01d3 c4505f        	and	a,20575
1360  01d6 2706          	jreq	L525
1361                     ; 421         status = SET; /* FLASH_FLAG is set */
1363  01d8 a601          	ld	a,#1
1364  01da 6b01          	ld	(OFST+0,sp),a
1367  01dc 2002          	jra	L725
1368  01de               L525:
1369                     ; 425         status = RESET; /* FLASH_FLAG is reset*/
1371  01de 0f01          	clr	(OFST+0,sp)
1373  01e0               L725:
1374                     ; 429     return status;
1376  01e0 7b01          	ld	a,(OFST+0,sp)
1379  01e2 5b01          	addw	sp,#1
1380  01e4 81            	ret
1473                     ; 531 IN_RAM(FLASH_Status_TypeDef FLASH_WaitForLastOperation(FLASH_MemType_TypeDef FLASH_MemType)) 
1473                     ; 532 {
1474                     	switch	.text
1475  01e5               _FLASH_WaitForLastOperation:
1477  01e5 5205          	subw	sp,#5
1478       00000005      OFST:	set	5
1481                     ; 533     uint8_t flagstatus = 0x00;
1483  01e7 0f05          	clr	(OFST+0,sp)
1485                     ; 534     uint32_t timeout = OPERATION_TIMEOUT;
1487  01e9 aeffff        	ldw	x,#65535
1488  01ec 1f03          	ldw	(OFST-2,sp),x
1489  01ee ae000f        	ldw	x,#15
1490  01f1 1f01          	ldw	(OFST-4,sp),x
1492                     ; 539     if (FLASH_MemType == FLASH_MEMTYPE_PROG)
1494  01f3 a1fd          	cp	a,#253
1495  01f5 2631          	jrne	L116
1497  01f7 2010          	jra	L775
1498  01f9               L575:
1499                     ; 543             flagstatus = (uint8_t)(FLASH->IAPSR & (uint8_t)(FLASH_IAPSR_EOP |
1499                     ; 544                                               FLASH_IAPSR_WR_PG_DIS));
1501  01f9 c6505f        	ld	a,20575
1502  01fc a405          	and	a,#5
1503  01fe 6b05          	ld	(OFST+0,sp),a
1505                     ; 545             timeout--;
1507  0200 96            	ldw	x,sp
1508  0201 1c0001        	addw	x,#OFST-4
1509  0204 a601          	ld	a,#1
1510  0206 cd0000        	call	c_lgsbc
1513  0209               L775:
1514                     ; 541         while ((flagstatus == 0x00) && (timeout != 0x00))
1516  0209 0d05          	tnz	(OFST+0,sp)
1517  020b 2628          	jrne	L506
1519  020d 96            	ldw	x,sp
1520  020e 1c0001        	addw	x,#OFST-4
1521  0211 cd0000        	call	c_lzmp
1523  0214 26e3          	jrne	L575
1524  0216 201d          	jra	L506
1525  0218               L706:
1526                     ; 552             flagstatus = (uint8_t)(FLASH->IAPSR & (uint8_t)(FLASH_IAPSR_HVOFF |
1526                     ; 553                                               FLASH_IAPSR_WR_PG_DIS));
1528  0218 c6505f        	ld	a,20575
1529  021b a441          	and	a,#65
1530  021d 6b05          	ld	(OFST+0,sp),a
1532                     ; 554             timeout--;
1534  021f 96            	ldw	x,sp
1535  0220 1c0001        	addw	x,#OFST-4
1536  0223 a601          	ld	a,#1
1537  0225 cd0000        	call	c_lgsbc
1540  0228               L116:
1541                     ; 550         while ((flagstatus == 0x00) && (timeout != 0x00))
1543  0228 0d05          	tnz	(OFST+0,sp)
1544  022a 2609          	jrne	L506
1546  022c 96            	ldw	x,sp
1547  022d 1c0001        	addw	x,#OFST-4
1548  0230 cd0000        	call	c_lzmp
1550  0233 26e3          	jrne	L706
1551  0235               L506:
1552                     ; 566     if (timeout == 0x00 )
1554  0235 96            	ldw	x,sp
1555  0236 1c0001        	addw	x,#OFST-4
1556  0239 cd0000        	call	c_lzmp
1558  023c 2604          	jrne	L716
1559                     ; 568         flagstatus = FLASH_STATUS_TIMEOUT;
1561  023e a602          	ld	a,#2
1562  0240 6b05          	ld	(OFST+0,sp),a
1564  0242               L716:
1565                     ; 571     return((FLASH_Status_TypeDef)flagstatus);
1567  0242 7b05          	ld	a,(OFST+0,sp)
1570  0244 5b05          	addw	sp,#5
1571  0246 81            	ret
1634                     ; 581 IN_RAM(void FLASH_EraseBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType))
1634                     ; 582 {
1635                     	switch	.text
1636  0247               _FLASH_EraseBlock:
1638  0247 89            	pushw	x
1639  0248 5207          	subw	sp,#7
1640       00000007      OFST:	set	7
1643                     ; 583   uint32_t startaddress = 0;
1645                     ; 593   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1647                     ; 594   if (FLASH_MemType == FLASH_MEMTYPE_PROG)
1649  024a 7b0c          	ld	a,(OFST+5,sp)
1650  024c a1fd          	cp	a,#253
1651  024e 260c          	jrne	L356
1652                     ; 596       assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1654                     ; 597       startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1656  0250 ae8000        	ldw	x,#32768
1657  0253 1f03          	ldw	(OFST-4,sp),x
1658  0255 ae0000        	ldw	x,#0
1659  0258 1f01          	ldw	(OFST-6,sp),x
1662  025a 200a          	jra	L556
1663  025c               L356:
1664                     ; 601       assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1666                     ; 602       startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1668  025c ae4000        	ldw	x,#16384
1669  025f 1f03          	ldw	(OFST-4,sp),x
1670  0261 ae0000        	ldw	x,#0
1671  0264 1f01          	ldw	(OFST-6,sp),x
1673  0266               L556:
1674                     ; 607     pwFlash = (PointerAttr uint8_t *)(uint32_t)(startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE));
1676  0266 1e08          	ldw	x,(OFST+1,sp)
1677  0268 a680          	ld	a,#128
1678  026a cd0000        	call	c_cmulx
1680  026d 96            	ldw	x,sp
1681  026e 1c0001        	addw	x,#OFST-6
1682  0271 cd0000        	call	c_ladd
1684  0274 450100        	mov	c_x,c_lreg+1
1685  0277 be02          	ldw	x,c_lreg+2
1686  0279 b600          	ld	a,c_x
1687  027b 6b05          	ld	(OFST-2,sp),a
1688  027d 1f06          	ldw	(OFST-1,sp),x
1690                     ; 614     FLASH->CR2 |= FLASH_CR2_ERASE;
1692  027f 721a505b      	bset	20571,#5
1693                     ; 615     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NERASE);
1695  0283 721b505c      	bres	20572,#5
1696                     ; 622   *pwFlash = (uint8_t)0;
1698  0287 7b05          	ld	a,(OFST-2,sp)
1699  0289 b700          	ld	c_x,a
1700  028b 1e06          	ldw	x,(OFST-1,sp)
1701  028d bf01          	ldw	c_x+1,x
1702  028f 4f            	clr	a
1703  0290 92bd0000      	ldf	[c_x.e],a
1704                     ; 623   *(pwFlash + 1) = (uint8_t)0;
1706  0294 7b05          	ld	a,(OFST-2,sp)
1707  0296 b700          	ld	c_x,a
1708  0298 1e06          	ldw	x,(OFST-1,sp)
1709  029a 90ae0001      	ldw	y,#1
1710  029e bf01          	ldw	c_x+1,x
1711  02a0 93            	ldw	x,y
1712  02a1 4f            	clr	a
1713  02a2 92a70000      	ldf	([c_x.e],x),a
1714                     ; 624   *(pwFlash + 2) = (uint8_t)0;
1716  02a6 7b05          	ld	a,(OFST-2,sp)
1717  02a8 b700          	ld	c_x,a
1718  02aa 1e06          	ldw	x,(OFST-1,sp)
1719  02ac 90ae0002      	ldw	y,#2
1720  02b0 bf01          	ldw	c_x+1,x
1721  02b2 93            	ldw	x,y
1722  02b3 4f            	clr	a
1723  02b4 92a70000      	ldf	([c_x.e],x),a
1724                     ; 625   *(pwFlash + 3) = (uint8_t)0;    
1726  02b8 7b05          	ld	a,(OFST-2,sp)
1727  02ba b700          	ld	c_x,a
1728  02bc 1e06          	ldw	x,(OFST-1,sp)
1729  02be 90ae0003      	ldw	y,#3
1730  02c2 bf01          	ldw	c_x+1,x
1731  02c4 93            	ldw	x,y
1732  02c5 4f            	clr	a
1733  02c6 92a70000      	ldf	([c_x.e],x),a
1734                     ; 627 }
1737  02ca 5b09          	addw	sp,#9
1738  02cc 81            	ret
1842                     ; 638 IN_RAM(void FLASH_ProgramBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType, 
1842                     ; 639                         FLASH_ProgramMode_TypeDef FLASH_ProgMode, uint8_t *Buffer))
1842                     ; 640 {
1843                     	switch	.text
1844  02cd               _FLASH_ProgramBlock:
1846  02cd 89            	pushw	x
1847  02ce 5206          	subw	sp,#6
1848       00000006      OFST:	set	6
1851                     ; 641     uint16_t Count = 0;
1853                     ; 642     uint32_t startaddress = 0;
1855                     ; 645     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1857                     ; 646     assert_param(IS_FLASH_PROGRAM_MODE_OK(FLASH_ProgMode));
1859                     ; 647     if (FLASH_MemType == FLASH_MEMTYPE_PROG)
1861  02d0 7b0b          	ld	a,(OFST+5,sp)
1862  02d2 a1fd          	cp	a,#253
1863  02d4 260c          	jrne	L137
1864                     ; 649         assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1866                     ; 650         startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1868  02d6 ae8000        	ldw	x,#32768
1869  02d9 1f03          	ldw	(OFST-3,sp),x
1870  02db ae0000        	ldw	x,#0
1871  02de 1f01          	ldw	(OFST-5,sp),x
1874  02e0 200a          	jra	L337
1875  02e2               L137:
1876                     ; 654         assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1878                     ; 655         startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1880  02e2 ae4000        	ldw	x,#16384
1881  02e5 1f03          	ldw	(OFST-3,sp),x
1882  02e7 ae0000        	ldw	x,#0
1883  02ea 1f01          	ldw	(OFST-5,sp),x
1885  02ec               L337:
1886                     ; 659     startaddress = startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE);
1888  02ec 1e07          	ldw	x,(OFST+1,sp)
1889  02ee a680          	ld	a,#128
1890  02f0 cd0000        	call	c_cmulx
1892  02f3 96            	ldw	x,sp
1893  02f4 1c0001        	addw	x,#OFST-5
1894  02f7 cd0000        	call	c_lgadd
1897                     ; 662     if (FLASH_ProgMode == FLASH_PROGRAMMODE_STANDARD)
1899  02fa 0d0c          	tnz	(OFST+6,sp)
1900  02fc 260a          	jrne	L537
1901                     ; 665         FLASH->CR2 |= FLASH_CR2_PRG;
1903  02fe 7210505b      	bset	20571,#0
1904                     ; 666         FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NPRG);
1906  0302 7211505c      	bres	20572,#0
1908  0306 2008          	jra	L737
1909  0308               L537:
1910                     ; 671         FLASH->CR2 |= FLASH_CR2_FPRG;
1912  0308 7218505b      	bset	20571,#4
1913                     ; 672         FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NFPRG);
1915  030c 7219505c      	bres	20572,#4
1916  0310               L737:
1917                     ; 676     for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1919  0310 5f            	clrw	x
1920  0311 1f05          	ldw	(OFST-1,sp),x
1922  0313               L147:
1923                     ; 680   *((PointerAttr uint8_t*) (uint16_t)startaddress + Count) = ((uint8_t)(Buffer[Count]));
1925  0313 7b03          	ld	a,(OFST-3,sp)
1926  0315 97            	ld	xl,a
1927  0316 7b04          	ld	a,(OFST-2,sp)
1928  0318 3f00          	clr	c_x
1929  031a 02            	rlwa	x,a
1930  031b 9093          	ldw	y,x
1931  031d 1605          	ldw	y,(OFST-1,sp)
1932  031f bf01          	ldw	c_x+1,x
1933  0321 93            	ldw	x,y
1934  0322 160d          	ldw	y,(OFST+7,sp)
1935  0324 72f905        	addw	y,(OFST-1,sp)
1936  0327 90f6          	ld	a,(y)
1937  0329 92a70000      	ldf	([c_x.e],x),a
1938                     ; 676     for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1940  032d 1e05          	ldw	x,(OFST-1,sp)
1941  032f 1c0001        	addw	x,#1
1942  0332 1f05          	ldw	(OFST-1,sp),x
1946  0334 1e05          	ldw	x,(OFST-1,sp)
1947  0336 a30080        	cpw	x,#128
1948  0339 25d8          	jrult	L147
1949                     ; 685 }
1952  033b 5b08          	addw	sp,#8
1953  033d 81            	ret
1966                     	xdef	_FLASH_WaitForLastOperation
1967                     	xdef	_FLASH_ProgramBlock
1968                     	xdef	_FLASH_EraseBlock
1969                     	xdef	_FLASH_GetFlagStatus
1970                     	xdef	_FLASH_GetBootSize
1971                     	xdef	_FLASH_GetProgrammingTime
1972                     	xdef	_FLASH_GetLowPowerMode
1973                     	xdef	_FLASH_SetProgrammingTime
1974                     	xdef	_FLASH_SetLowPowerMode
1975                     	xdef	_FLASH_EraseOptionByte
1976                     	xdef	_FLASH_ProgramOptionByte
1977                     	xdef	_FLASH_ReadOptionByte
1978                     	xdef	_FLASH_ProgramWord
1979                     	xdef	_FLASH_ReadByte
1980                     	xdef	_FLASH_ProgramByte
1981                     	xdef	_FLASH_EraseByte
1982                     	xdef	_FLASH_ITConfig
1983                     	xdef	_FLASH_DeInit
1984                     	xdef	_FLASH_Lock
1985                     	xdef	_FLASH_Unlock
1986                     	xref.b	c_lreg
1987                     	xref.b	c_x
1988                     	xref.b	c_y
2007                     	xref	c_ladd
2008                     	xref	c_cmulx
2009                     	xref	c_lzmp
2010                     	xref	c_lgsbc
2011                     	xref	c_ltor
2012                     	xref	c_lgadd
2013                     	xref	c_rtol
2014                     	xref	c_umul
2015                     	end
