   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
 108                     ; 47 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 108                     ; 48 {
 109                     	switch	.text
 110  0000               f_GPIO_DeInit:
 114                     ; 49     GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 116  0000 7f            	clr	(x)
 117                     ; 50     GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 119  0001 6f02          	clr	(2,x)
 120                     ; 51     GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 122  0003 6f03          	clr	(3,x)
 123                     ; 52     GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 125  0005 6f04          	clr	(4,x)
 126                     ; 53 }
 129  0007 87            	retf
 368                     ; 65 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 368                     ; 66 {
 369                     	switch	.text
 370  0008               f_GPIO_Init:
 372  0008 89            	pushw	x
 373       00000000      OFST:	set	0
 376                     ; 71     assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 378                     ; 72     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 380                     ; 75   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 382  0009 7b06          	ld	a,(OFST+6,sp)
 383  000b 43            	cpl	a
 384  000c e404          	and	a,(4,x)
 385  000e e704          	ld	(4,x),a
 386                     ; 81     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 388  0010 7b07          	ld	a,(OFST+7,sp)
 389  0012 a580          	bcp	a,#128
 390  0014 271d          	jreq	L771
 391                     ; 83         if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 393  0016 7b07          	ld	a,(OFST+7,sp)
 394  0018 a510          	bcp	a,#16
 395  001a 2706          	jreq	L102
 396                     ; 85             GPIOx->ODR |= (uint8_t)GPIO_Pin;
 398  001c f6            	ld	a,(x)
 399  001d 1a06          	or	a,(OFST+6,sp)
 400  001f f7            	ld	(x),a
 402  0020 2007          	jra	L302
 403  0022               L102:
 404                     ; 89             GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 406  0022 1e01          	ldw	x,(OFST+1,sp)
 407  0024 7b06          	ld	a,(OFST+6,sp)
 408  0026 43            	cpl	a
 409  0027 f4            	and	a,(x)
 410  0028 f7            	ld	(x),a
 411  0029               L302:
 412                     ; 92         GPIOx->DDR |= (uint8_t)GPIO_Pin;
 414  0029 1e01          	ldw	x,(OFST+1,sp)
 415  002b e602          	ld	a,(2,x)
 416  002d 1a06          	or	a,(OFST+6,sp)
 417  002f e702          	ld	(2,x),a
 419  0031 2009          	jra	L502
 420  0033               L771:
 421                     ; 97         GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 423  0033 1e01          	ldw	x,(OFST+1,sp)
 424  0035 7b06          	ld	a,(OFST+6,sp)
 425  0037 43            	cpl	a
 426  0038 e402          	and	a,(2,x)
 427  003a e702          	ld	(2,x),a
 428  003c               L502:
 429                     ; 104     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 431  003c 7b07          	ld	a,(OFST+7,sp)
 432  003e a540          	bcp	a,#64
 433  0040 270a          	jreq	L702
 434                     ; 106         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 436  0042 1e01          	ldw	x,(OFST+1,sp)
 437  0044 e603          	ld	a,(3,x)
 438  0046 1a06          	or	a,(OFST+6,sp)
 439  0048 e703          	ld	(3,x),a
 441  004a 2009          	jra	L112
 442  004c               L702:
 443                     ; 110         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 445  004c 1e01          	ldw	x,(OFST+1,sp)
 446  004e 7b06          	ld	a,(OFST+6,sp)
 447  0050 43            	cpl	a
 448  0051 e403          	and	a,(3,x)
 449  0053 e703          	ld	(3,x),a
 450  0055               L112:
 451                     ; 117     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 453  0055 7b07          	ld	a,(OFST+7,sp)
 454  0057 a520          	bcp	a,#32
 455  0059 270a          	jreq	L312
 456                     ; 119         GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 458  005b 1e01          	ldw	x,(OFST+1,sp)
 459  005d e604          	ld	a,(4,x)
 460  005f 1a06          	or	a,(OFST+6,sp)
 461  0061 e704          	ld	(4,x),a
 463  0063 2009          	jra	L512
 464  0065               L312:
 465                     ; 123         GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 467  0065 1e01          	ldw	x,(OFST+1,sp)
 468  0067 7b06          	ld	a,(OFST+6,sp)
 469  0069 43            	cpl	a
 470  006a e404          	and	a,(4,x)
 471  006c e704          	ld	(4,x),a
 472  006e               L512:
 473                     ; 125 }
 476  006e 85            	popw	x
 477  006f 87            	retf
 522                     ; 135 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 522                     ; 136 {
 523                     	switch	.text
 524  0070               f_GPIO_Write:
 526  0070 89            	pushw	x
 527       00000000      OFST:	set	0
 530                     ; 137     GPIOx->ODR = PortVal;
 532  0071 7b06          	ld	a,(OFST+6,sp)
 533  0073 1e01          	ldw	x,(OFST+1,sp)
 534  0075 f7            	ld	(x),a
 535                     ; 138 }
 538  0076 85            	popw	x
 539  0077 87            	retf
 585                     ; 148 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 585                     ; 149 {
 586                     	switch	.text
 587  0078               f_GPIO_WriteHigh:
 589  0078 89            	pushw	x
 590       00000000      OFST:	set	0
 593                     ; 150     GPIOx->ODR |= (uint8_t)PortPins;
 595  0079 f6            	ld	a,(x)
 596  007a 1a06          	or	a,(OFST+6,sp)
 597  007c f7            	ld	(x),a
 598                     ; 151 }
 601  007d 85            	popw	x
 602  007e 87            	retf
 648                     ; 161 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 648                     ; 162 {
 649                     	switch	.text
 650  007f               f_GPIO_WriteLow:
 652  007f 89            	pushw	x
 653       00000000      OFST:	set	0
 656                     ; 163     GPIOx->ODR &= (uint8_t)(~PortPins);
 658  0080 7b06          	ld	a,(OFST+6,sp)
 659  0082 43            	cpl	a
 660  0083 f4            	and	a,(x)
 661  0084 f7            	ld	(x),a
 662                     ; 164 }
 665  0085 85            	popw	x
 666  0086 87            	retf
 712                     ; 174 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 712                     ; 175 {
 713                     	switch	.text
 714  0087               f_GPIO_WriteReverse:
 716  0087 89            	pushw	x
 717       00000000      OFST:	set	0
 720                     ; 176     GPIOx->ODR ^= (uint8_t)PortPins;
 722  0088 f6            	ld	a,(x)
 723  0089 1806          	xor	a,(OFST+6,sp)
 724  008b f7            	ld	(x),a
 725                     ; 177 }
 728  008c 85            	popw	x
 729  008d 87            	retf
 766                     ; 185 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 766                     ; 186 {
 767                     	switch	.text
 768  008e               f_GPIO_ReadOutputData:
 772                     ; 187     return ((uint8_t)GPIOx->ODR);
 774  008e f6            	ld	a,(x)
 777  008f 87            	retf
 813                     ; 196 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 813                     ; 197 {
 814                     	switch	.text
 815  0090               f_GPIO_ReadInputData:
 819                     ; 198     return ((uint8_t)GPIOx->IDR);
 821  0090 e601          	ld	a,(1,x)
 824  0092 87            	retf
 891                     ; 207 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 891                     ; 208 {
 892                     	switch	.text
 893  0093               f_GPIO_ReadInputPin:
 895  0093 89            	pushw	x
 896       00000000      OFST:	set	0
 899                     ; 209     return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
 901  0094 e601          	ld	a,(1,x)
 902  0096 1406          	and	a,(OFST+6,sp)
 905  0098 85            	popw	x
 906  0099 87            	retf
 983                     ; 219 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
 983                     ; 220 {
 984                     	switch	.text
 985  009a               f_GPIO_ExternalPullUpConfig:
 987  009a 89            	pushw	x
 988       00000000      OFST:	set	0
 991                     ; 222     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 993                     ; 223     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 995                     ; 225     if (NewState != DISABLE) /* External Pull-Up Set*/
 997  009b 0d07          	tnz	(OFST+7,sp)
 998  009d 2708          	jreq	L374
 999                     ; 227         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
1001  009f e603          	ld	a,(3,x)
1002  00a1 1a06          	or	a,(OFST+6,sp)
1003  00a3 e703          	ld	(3,x),a
1005  00a5 2009          	jra	L574
1006  00a7               L374:
1007                     ; 230         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
1009  00a7 1e01          	ldw	x,(OFST+1,sp)
1010  00a9 7b06          	ld	a,(OFST+6,sp)
1011  00ab 43            	cpl	a
1012  00ac e403          	and	a,(3,x)
1013  00ae e703          	ld	(3,x),a
1014  00b0               L574:
1015                     ; 232 }
1018  00b0 85            	popw	x
1019  00b1 87            	retf
1031                     	xdef	f_GPIO_ExternalPullUpConfig
1032                     	xdef	f_GPIO_ReadInputPin
1033                     	xdef	f_GPIO_ReadOutputData
1034                     	xdef	f_GPIO_ReadInputData
1035                     	xdef	f_GPIO_WriteReverse
1036                     	xdef	f_GPIO_WriteLow
1037                     	xdef	f_GPIO_WriteHigh
1038                     	xdef	f_GPIO_Write
1039                     	xdef	f_GPIO_Init
1040                     	xdef	f_GPIO_DeInit
1059                     	end
