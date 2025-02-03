   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _Status:
  16  0000 0000          	dc.w	0
  17  0002               _TxBuffer:
  18  0002 53544d385320  	dc.b	"STM8S SPI Firmware"
  19  0014 204c69627261  	dc.b	" Library Example: "
  20  0026 636f6d6d756e  	dc.b	"communication with"
  21  0038 2061206d6963  	dc.b	" a microSD card",0
  22  0048               _RxBuffer:
  23  0048 00            	dc.b	0
  24  0049 000000000000  	ds.b	68
  25  008d               _TransferStatus:
  26  008d 00            	dc.b	0
  92                     ; 71 void main(void)
  92                     ; 72 {
  93                     	switch	.text
  94  0000               f_main:
  96  0000 89            	pushw	x
  97       00000002      OFST:	set	2
 100                     ; 73 	uint8_t testByte = 0xA5;  // Example test byte
 102  0001 a6a5          	ld	a,#165
 103  0003 6b01          	ld	(OFST-1,sp),a
 105                     ; 74 	uint8_t readByte = 0;
 107                     ; 76 	CLK_Config();
 109  0005 8de500e5      	callf	L5f_CLK_Config
 111                     ; 77 	TIM4_Config();
 113  0009 8d000000      	callf	f_TIM4_Config
 115                     ; 79 	GPIO_Config();
 117  000d 8d570157      	callf	L7f_GPIO_Config
 119                     ; 80   SD_LowLevel_Init();
 121  0011 8d000000      	callf	f_SD_LowLevel_Init
 123                     ; 84 	Delay(0xFFFF);
 125  0015 aeffff        	ldw	x,#65535
 126  0018 8d0a020a      	callf	f_Delay
 128                     ; 86 	Status = SD_Init();
 130  001c 8d000000      	callf	f_SD_Init
 132  0020 5f            	clrw	x
 133  0021 97            	ld	xl,a
 134  0022 bf00          	ldw	_Status,x
 135                     ; 88 	SD_CS_LOW(); // Select SD card
 137  0024 4b01          	push	#1
 138  0026 ae5005        	ldw	x,#20485
 139  0029 8d000000      	callf	f_GPIO_WriteLow
 141  002d 84            	pop	a
 142                     ; 89 	readByte = SD_WriteByte(testByte);
 144  002e 7b01          	ld	a,(OFST-1,sp)
 145  0030 8d000000      	callf	f_SD_WriteByte
 147  0034 6b02          	ld	(OFST+0,sp),a
 149                     ; 90 	SD_CS_HIGH(); // Deselect SD card
 151  0036 4b01          	push	#1
 152  0038 ae5005        	ldw	x,#20485
 153  003b 8d000000      	callf	f_GPIO_WriteHigh
 155  003f 84            	pop	a
 156                     ; 93 	if(readByte == testByte)
 158  0040 7b02          	ld	a,(OFST+0,sp)
 159  0042 1101          	cp	a,(OFST-1,sp)
 160  0044 260a          	jrne	L14
 161                     ; 95 		GPIO_WriteReverse(LED2);
 163  0046 4b08          	push	#8
 164  0048 ae5014        	ldw	x,#20500
 165  004b 8d000000      	callf	f_GPIO_WriteReverse
 167  004f 84            	pop	a
 168  0050               L14:
 169                     ; 101 	SD_WriteBlock(TxBuffer, 0, BUFFER_SIZE);
 171  0050 ae0045        	ldw	x,#69
 172  0053 89            	pushw	x
 173  0054 ae0000        	ldw	x,#0
 174  0057 89            	pushw	x
 175  0058 ae0000        	ldw	x,#0
 176  005b 89            	pushw	x
 177  005c ae0002        	ldw	x,#_TxBuffer
 178  005f 8d000000      	callf	f_SD_WriteBlock
 180  0063 5b06          	addw	sp,#6
 181                     ; 104 	SD_ReadBlock(RxBuffer, 0, BUFFER_SIZE);
 183  0065 ae0045        	ldw	x,#69
 184  0068 89            	pushw	x
 185  0069 ae0000        	ldw	x,#0
 186  006c 89            	pushw	x
 187  006d ae0000        	ldw	x,#0
 188  0070 89            	pushw	x
 189  0071 ae0048        	ldw	x,#_RxBuffer
 190  0074 8d000000      	callf	f_SD_ReadBlock
 192  0078 5b06          	addw	sp,#6
 193                     ; 107 	TransferStatus = Buffercmp(TxBuffer, RxBuffer, BUFFER_SIZE);
 195  007a ae0045        	ldw	x,#69
 196  007d 89            	pushw	x
 197  007e ae0048        	ldw	x,#_RxBuffer
 198  0081 89            	pushw	x
 199  0082 ae0002        	ldw	x,#_TxBuffer
 200  0085 8ddb01db      	callf	L3f_Buffercmp
 202  0089 5b04          	addw	sp,#4
 203  008b b78d          	ld	_TransferStatus,a
 204                     ; 108 	if (TransferStatus != SUCCESS)
 206  008d b68d          	ld	a,_TransferStatus
 207  008f a101          	cp	a,#1
 208  0091 271a          	jreq	L15
 209  0093               L54:
 210                     ; 112 			GPIO_WriteReverse(LED1);
 212  0093 4b08          	push	#8
 213  0095 ae500a        	ldw	x,#20490
 214  0098 8d000000      	callf	f_GPIO_WriteReverse
 216  009c 84            	pop	a
 217                     ; 113 			Delay((uint16_t)0xFFFF);
 219  009d aeffff        	ldw	x,#65535
 220  00a0 8d0a020a      	callf	f_Delay
 222                     ; 114 			Delay((uint16_t)0xFFFF);
 224  00a4 aeffff        	ldw	x,#65535
 225  00a7 8d0a020a      	callf	f_Delay
 228  00ab 20e6          	jra	L54
 229  00ad               L15:
 230                     ; 119 		GPIO_WriteReverse(LED1);
 232  00ad 4b08          	push	#8
 233  00af ae500a        	ldw	x,#20490
 234  00b2 8d000000      	callf	f_GPIO_WriteReverse
 236  00b6 84            	pop	a
 237                     ; 120 		GPIO_WriteReverse(LED2);
 239  00b7 4b08          	push	#8
 240  00b9 ae5014        	ldw	x,#20500
 241  00bc 8d000000      	callf	f_GPIO_WriteReverse
 243  00c0 84            	pop	a
 244                     ; 121 		GPIO_WriteReverse(LED3);
 246  00c1 4b01          	push	#1
 247  00c3 ae500f        	ldw	x,#20495
 248  00c6 8d000000      	callf	f_GPIO_WriteReverse
 250  00ca 84            	pop	a
 251                     ; 122 		GPIO_WriteReverse(LED4);
 253  00cb 4b08          	push	#8
 254  00cd ae500f        	ldw	x,#20495
 255  00d0 8d000000      	callf	f_GPIO_WriteReverse
 257  00d4 84            	pop	a
 258                     ; 123 		Delay((uint16_t)0xFFFF);
 260  00d5 aeffff        	ldw	x,#65535
 261  00d8 8d0a020a      	callf	f_Delay
 263                     ; 124 		Delay((uint16_t)0xFFFF);
 265  00dc aeffff        	ldw	x,#65535
 266  00df 8d0a020a      	callf	f_Delay
 269  00e3 20c8          	jra	L15
 301                     ; 133 static void CLK_Config(void)
 301                     ; 134 {
 302                     	switch	.text
 303  00e5               L5f_CLK_Config:
 307                     ; 137 	CLK_DeInit();
 309  00e5 8d000000      	callf	f_CLK_DeInit
 311                     ; 139   CLK_HSECmd(DISABLE);
 313  00e9 4f            	clr	a
 314  00ea 8d000000      	callf	f_CLK_HSECmd
 316                     ; 140   CLK_LSICmd(DISABLE);
 318  00ee 4f            	clr	a
 319  00ef 8d000000      	callf	f_CLK_LSICmd
 321                     ; 141   CLK_HSICmd(ENABLE);
 323  00f3 a601          	ld	a,#1
 324  00f5 8d000000      	callf	f_CLK_HSICmd
 327  00f9               L76:
 328                     ; 142   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 330  00f9 ae0102        	ldw	x,#258
 331  00fc 8d000000      	callf	f_CLK_GetFlagStatus
 333  0100 4d            	tnz	a
 334  0101 27f6          	jreq	L76
 335                     ; 144   CLK_ClockSwitchCmd(ENABLE);
 337  0103 a601          	ld	a,#1
 338  0105 8d000000      	callf	f_CLK_ClockSwitchCmd
 340                     ; 145   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 342  0109 4f            	clr	a
 343  010a 8d000000      	callf	f_CLK_HSIPrescalerConfig
 345                     ; 146   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 347  010e a680          	ld	a,#128
 348  0110 8d000000      	callf	f_CLK_SYSCLKConfig
 350                     ; 148   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 350                     ; 149   DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 352  0114 4b01          	push	#1
 353  0116 4b00          	push	#0
 354  0118 ae01e1        	ldw	x,#481
 355  011b 8d000000      	callf	f_CLK_ClockSwitchConfig
 357  011f 85            	popw	x
 358                     ; 151   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
 360  0120 ae0101        	ldw	x,#257
 361  0123 8d000000      	callf	f_CLK_PeripheralClockConfig
 363                     ; 152   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 365  0127 5f            	clrw	x
 366  0128 8d000000      	callf	f_CLK_PeripheralClockConfig
 368                     ; 153   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 370  012c ae1300        	ldw	x,#4864
 371  012f 8d000000      	callf	f_CLK_PeripheralClockConfig
 373                     ; 154   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 375  0133 ae1200        	ldw	x,#4608
 376  0136 8d000000      	callf	f_CLK_PeripheralClockConfig
 378                     ; 155   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 380  013a ae0301        	ldw	x,#769
 381  013d 8d000000      	callf	f_CLK_PeripheralClockConfig
 383                     ; 156   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 385  0141 ae0700        	ldw	x,#1792
 386  0144 8d000000      	callf	f_CLK_PeripheralClockConfig
 388                     ; 157   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 390  0148 ae0500        	ldw	x,#1280
 391  014b 8d000000      	callf	f_CLK_PeripheralClockConfig
 393                     ; 158   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 395  014f ae0401        	ldw	x,#1025
 396  0152 8d000000      	callf	f_CLK_PeripheralClockConfig
 398                     ; 159 }
 401  0156 87            	retf
 425                     ; 161 static void GPIO_Config(void)
 425                     ; 162 {
 426                     	switch	.text
 427  0157               L7f_GPIO_Config:
 431                     ; 163 	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
 433  0157 ae500a        	ldw	x,#20490
 434  015a 8d000000      	callf	f_GPIO_DeInit
 436                     ; 164 	GPIO_DeInit(GPIOA);     // Reset GPIO settings for port C
 438  015e ae5000        	ldw	x,#20480
 439  0161 8d000000      	callf	f_GPIO_DeInit
 441                     ; 165 	GPIO_DeInit(GPIOB);     // Reset GPIO settings for port C
 443  0165 ae5005        	ldw	x,#20485
 444  0168 8d000000      	callf	f_GPIO_DeInit
 446                     ; 166 	GPIO_DeInit(GPIOD);     // Reset GPIO settings for port C
 448  016c ae500f        	ldw	x,#20495
 449  016f 8d000000      	callf	f_GPIO_DeInit
 451                     ; 167 	GPIO_DeInit(GPIOE);     // Reset GPIO settings for port C
 453  0173 ae5014        	ldw	x,#20500
 454  0176 8d000000      	callf	f_GPIO_DeInit
 456                     ; 168 	GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 458  017a 4be0          	push	#224
 459  017c 4b01          	push	#1
 460  017e ae5005        	ldw	x,#20485
 461  0181 8d000000      	callf	f_GPIO_Init
 463  0185 85            	popw	x
 464                     ; 169 	GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 466  0186 4be0          	push	#224
 467  0188 4b10          	push	#16
 468  018a ae500a        	ldw	x,#20490
 469  018d 8d000000      	callf	f_GPIO_Init
 471  0191 85            	popw	x
 472                     ; 170 	GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 474  0192 4be0          	push	#224
 475  0194 4b04          	push	#4
 476  0196 ae500a        	ldw	x,#20490
 477  0199 8d000000      	callf	f_GPIO_Init
 479  019d 85            	popw	x
 480                     ; 171 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 482  019e 4be0          	push	#224
 483  01a0 4b08          	push	#8
 484  01a2 ae500a        	ldw	x,#20490
 485  01a5 8d000000      	callf	f_GPIO_Init
 487  01a9 85            	popw	x
 488                     ; 172 	GPIO_Init(GPIOE, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 490  01aa 4be0          	push	#224
 491  01ac 4b08          	push	#8
 492  01ae ae5014        	ldw	x,#20500
 493  01b1 8d000000      	callf	f_GPIO_Init
 495  01b5 85            	popw	x
 496                     ; 173 	GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 498  01b6 4be0          	push	#224
 499  01b8 4b01          	push	#1
 500  01ba ae500f        	ldw	x,#20495
 501  01bd 8d000000      	callf	f_GPIO_Init
 503  01c1 85            	popw	x
 504                     ; 174 	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 506  01c2 4be0          	push	#224
 507  01c4 4b08          	push	#8
 508  01c6 ae500f        	ldw	x,#20495
 509  01c9 8d000000      	callf	f_GPIO_Init
 511  01cd 85            	popw	x
 512                     ; 175 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 514  01ce 4be0          	push	#224
 515  01d0 4b08          	push	#8
 516  01d2 ae5000        	ldw	x,#20480
 517  01d5 8d000000      	callf	f_GPIO_Init
 519  01d9 85            	popw	x
 520                     ; 176 }
 523  01da 87            	retf
 597                     ; 178 ErrorStatus Buffercmp(uint8_t* pBuffer1, uint8_t* pBuffer2, uint16_t BufferLength)
 597                     ; 179 {
 598                     	switch	.text
 599  01db               L3f_Buffercmp:
 601  01db 89            	pushw	x
 602       00000000      OFST:	set	0
 605  01dc 2019          	jra	L341
 606  01de               L141:
 607                     ; 182         if (*pBuffer1 != *pBuffer2)
 609  01de 1e01          	ldw	x,(OFST+1,sp)
 610  01e0 f6            	ld	a,(x)
 611  01e1 1e06          	ldw	x,(OFST+6,sp)
 612  01e3 f1            	cp	a,(x)
 613  01e4 2703          	jreq	L741
 614                     ; 184             return ERROR;
 616  01e6 4f            	clr	a
 618  01e7 201f          	jra	L41
 619  01e9               L741:
 620                     ; 187         pBuffer1++;
 622  01e9 1e01          	ldw	x,(OFST+1,sp)
 623  01eb 1c0001        	addw	x,#1
 624  01ee 1f01          	ldw	(OFST+1,sp),x
 625                     ; 188         pBuffer2++;
 627  01f0 1e06          	ldw	x,(OFST+6,sp)
 628  01f2 1c0001        	addw	x,#1
 629  01f5 1f06          	ldw	(OFST+6,sp),x
 630  01f7               L341:
 631                     ; 180     while (BufferLength--)
 633  01f7 1e08          	ldw	x,(OFST+8,sp)
 634  01f9 1d0001        	subw	x,#1
 635  01fc 1f08          	ldw	(OFST+8,sp),x
 636  01fe 1c0001        	addw	x,#1
 637  0201 a30000        	cpw	x,#0
 638  0204 26d8          	jrne	L141
 639                     ; 191     return SUCCESS;
 641  0206 a601          	ld	a,#1
 643  0208               L41:
 645  0208 85            	popw	x
 646  0209 87            	retf
 679                     ; 199 void Delay(uint16_t nCount)
 679                     ; 200 {
 680                     	switch	.text
 681  020a               f_Delay:
 683  020a 89            	pushw	x
 684       00000000      OFST:	set	0
 687  020b 2007          	jra	L171
 688  020d               L761:
 689                     ; 204     nCount--;
 691  020d 1e01          	ldw	x,(OFST+1,sp)
 692  020f 1d0001        	subw	x,#1
 693  0212 1f01          	ldw	(OFST+1,sp),x
 694  0214               L171:
 695                     ; 202   while (nCount != 0)
 697  0214 1e01          	ldw	x,(OFST+1,sp)
 698  0216 26f5          	jrne	L761
 699                     ; 206 }
 702  0218 85            	popw	x
 703  0219 87            	retf
 756                     	xdef	f_main
 757                     	xdef	f_Delay
 758                     	xdef	_TransferStatus
 759                     	xdef	_RxBuffer
 760                     	xdef	_TxBuffer
 761                     	xdef	_Status
 762                     	xref	f_TIM4_Config
 763                     	xref	f_SD_WriteByte
 764                     	xref	f_SD_WriteBlock
 765                     	xref	f_SD_ReadBlock
 766                     	xref	f_SD_Init
 767                     	xref	f_SD_LowLevel_Init
 768                     	xref	f_GPIO_WriteReverse
 769                     	xref	f_GPIO_WriteLow
 770                     	xref	f_GPIO_WriteHigh
 771                     	xref	f_GPIO_Init
 772                     	xref	f_GPIO_DeInit
 773                     	xref	f_CLK_GetFlagStatus
 774                     	xref	f_CLK_SYSCLKConfig
 775                     	xref	f_CLK_HSIPrescalerConfig
 776                     	xref	f_CLK_ClockSwitchConfig
 777                     	xref	f_CLK_PeripheralClockConfig
 778                     	xref	f_CLK_ClockSwitchCmd
 779                     	xref	f_CLK_LSICmd
 780                     	xref	f_CLK_HSICmd
 781                     	xref	f_CLK_HSECmd
 782                     	xref	f_CLK_DeInit
 801                     	end
