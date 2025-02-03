   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
 111                     ; 47 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 111                     ; 48 {
 112                     	switch	.text
 113  0000               f_GPIO_DeInit:
 117                     ; 49     GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 119  0000 7f            	clr	(x)
 120                     ; 50     GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 122  0001 6f02          	clr	(2,x)
 123                     ; 51     GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 125  0003 6f03          	clr	(3,x)
 126                     ; 52     GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 128  0005 6f04          	clr	(4,x)
 129                     ; 53 }
 132  0007 87            	retf	
 371                     ; 65 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 371                     ; 66 {
 372                     	switch	.text
 373  0008               f_GPIO_Init:
 375  0008 89            	pushw	x
 376       00000000      OFST:	set	0
 379                     ; 71     assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 381                     ; 72     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 383                     ; 75   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 385  0009 7b06          	ld	a,(OFST+6,sp)
 386  000b 43            	cpl	a
 387  000c e404          	and	a,(4,x)
 388  000e e704          	ld	(4,x),a
 389                     ; 81     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 391  0010 7b07          	ld	a,(OFST+7,sp)
 392  0012 2a16          	jrpl	L771
 393                     ; 83         if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 395  0014 a510          	bcp	a,#16
 396  0016 2705          	jreq	L102
 397                     ; 85             GPIOx->ODR |= (uint8_t)GPIO_Pin;
 399  0018 f6            	ld	a,(x)
 400  0019 1a06          	or	a,(OFST+6,sp)
 402  001b 2004          	jra	L302
 403  001d               L102:
 404                     ; 89             GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 406  001d 7b06          	ld	a,(OFST+6,sp)
 407  001f 43            	cpl	a
 408  0020 f4            	and	a,(x)
 409  0021               L302:
 410  0021 f7            	ld	(x),a
 411                     ; 92         GPIOx->DDR |= (uint8_t)GPIO_Pin;
 413  0022 1e01          	ldw	x,(OFST+1,sp)
 414  0024 e602          	ld	a,(2,x)
 415  0026 1a06          	or	a,(OFST+6,sp)
 417  0028 2005          	jra	L502
 418  002a               L771:
 419                     ; 97         GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 421  002a 7b06          	ld	a,(OFST+6,sp)
 422  002c 43            	cpl	a
 423  002d e402          	and	a,(2,x)
 424  002f               L502:
 425  002f e702          	ld	(2,x),a
 426                     ; 104     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 428  0031 7b07          	ld	a,(OFST+7,sp)
 429  0033 a540          	bcp	a,#64
 430  0035 2706          	jreq	L702
 431                     ; 106         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 433  0037 e603          	ld	a,(3,x)
 434  0039 1a06          	or	a,(OFST+6,sp)
 436  003b 2005          	jra	L112
 437  003d               L702:
 438                     ; 110         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 440  003d 7b06          	ld	a,(OFST+6,sp)
 441  003f 43            	cpl	a
 442  0040 e403          	and	a,(3,x)
 443  0042               L112:
 444  0042 e703          	ld	(3,x),a
 445                     ; 117     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 447  0044 7b07          	ld	a,(OFST+7,sp)
 448  0046 a520          	bcp	a,#32
 449  0048 2706          	jreq	L312
 450                     ; 119         GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 452  004a e604          	ld	a,(4,x)
 453  004c 1a06          	or	a,(OFST+6,sp)
 455  004e 2005          	jra	L512
 456  0050               L312:
 457                     ; 123         GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 459  0050 7b06          	ld	a,(OFST+6,sp)
 460  0052 43            	cpl	a
 461  0053 e404          	and	a,(4,x)
 462  0055               L512:
 463  0055 e704          	ld	(4,x),a
 464                     ; 125 }
 467  0057 85            	popw	x
 468  0058 87            	retf	
 513                     ; 135 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 513                     ; 136 {
 514                     	switch	.text
 515  0059               f_GPIO_Write:
 517       fffffffe      OFST: set -2
 520                     ; 137     GPIOx->ODR = PortVal;
 522  0059 7b04          	ld	a,(OFST+6,sp)
 523  005b f7            	ld	(x),a
 524                     ; 138 }
 527  005c 87            	retf	
 573                     ; 148 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 573                     ; 149 {
 574                     	switch	.text
 575  005d               f_GPIO_WriteHigh:
 577       fffffffe      OFST: set -2
 580                     ; 150     GPIOx->ODR |= (uint8_t)PortPins;
 582  005d f6            	ld	a,(x)
 583  005e 1a04          	or	a,(OFST+6,sp)
 584  0060 f7            	ld	(x),a
 585                     ; 151 }
 588  0061 87            	retf	
 634                     ; 161 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 634                     ; 162 {
 635                     	switch	.text
 636  0062               f_GPIO_WriteLow:
 638       fffffffe      OFST: set -2
 641                     ; 163     GPIOx->ODR &= (uint8_t)(~PortPins);
 643  0062 7b04          	ld	a,(OFST+6,sp)
 644  0064 43            	cpl	a
 645  0065 f4            	and	a,(x)
 646  0066 f7            	ld	(x),a
 647                     ; 164 }
 650  0067 87            	retf	
 696                     ; 174 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 696                     ; 175 {
 697                     	switch	.text
 698  0068               f_GPIO_WriteReverse:
 700       fffffffe      OFST: set -2
 703                     ; 176     GPIOx->ODR ^= (uint8_t)PortPins;
 705  0068 f6            	ld	a,(x)
 706  0069 1804          	xor	a,(OFST+6,sp)
 707  006b f7            	ld	(x),a
 708                     ; 177 }
 711  006c 87            	retf	
 748                     ; 185 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 748                     ; 186 {
 749                     	switch	.text
 750  006d               f_GPIO_ReadOutputData:
 754                     ; 187     return ((uint8_t)GPIOx->ODR);
 756  006d f6            	ld	a,(x)
 759  006e 87            	retf	
 795                     ; 196 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 795                     ; 197 {
 796                     	switch	.text
 797  006f               f_GPIO_ReadInputData:
 801                     ; 198     return ((uint8_t)GPIOx->IDR);
 803  006f e601          	ld	a,(1,x)
 806  0071 87            	retf	
 873                     ; 207 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 873                     ; 208 {
 874                     	switch	.text
 875  0072               f_GPIO_ReadInputPin:
 877       fffffffe      OFST: set -2
 880                     ; 209     return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
 882  0072 e601          	ld	a,(1,x)
 883  0074 1404          	and	a,(OFST+6,sp)
 886  0076 87            	retf	
 963                     ; 219 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
 963                     ; 220 {
 964                     	switch	.text
 965  0077               f_GPIO_ExternalPullUpConfig:
 967       fffffffe      OFST: set -2
 970                     ; 222     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 972                     ; 223     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 974                     ; 225     if (NewState != DISABLE) /* External Pull-Up Set*/
 976  0077 7b05          	ld	a,(OFST+7,sp)
 977  0079 2706          	jreq	L374
 978                     ; 227         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 980  007b e603          	ld	a,(3,x)
 981  007d 1a04          	or	a,(OFST+6,sp)
 983  007f 2005          	jra	L574
 984  0081               L374:
 985                     ; 230         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 987  0081 7b04          	ld	a,(OFST+6,sp)
 988  0083 43            	cpl	a
 989  0084 e403          	and	a,(3,x)
 990  0086               L574:
 991  0086 e703          	ld	(3,x),a
 992                     ; 232 }
 995  0088 87            	retf	
1007                     	xdef	f_GPIO_ExternalPullUpConfig
1008                     	xdef	f_GPIO_ReadInputPin
1009                     	xdef	f_GPIO_ReadOutputData
1010                     	xdef	f_GPIO_ReadInputData
1011                     	xdef	f_GPIO_WriteReverse
1012                     	xdef	f_GPIO_WriteLow
1013                     	xdef	f_GPIO_WriteHigh
1014                     	xdef	f_GPIO_Write
1015                     	xdef	f_GPIO_Init
1016                     	xdef	f_GPIO_DeInit
1035                     	end
