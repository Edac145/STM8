   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  52                     ; 5 void clock_setup(void) {
  53                     	switch	.text
  54  0000               f_clock_setup:
  58                     ; 6 	CLK_DeInit();
  60  0000 8d000000      	callf	f_CLK_DeInit
  62                     ; 7 	CLK_HSECmd(DISABLE);
  64  0004 4f            	clr	a
  65  0005 8d000000      	callf	f_CLK_HSECmd
  67                     ; 8 	CLK_LSICmd(DISABLE);
  69  0009 4f            	clr	a
  70  000a 8d000000      	callf	f_CLK_LSICmd
  72                     ; 9 	CLK_HSICmd(ENABLE);
  74  000e a601          	ld	a,#1
  75  0010 8d000000      	callf	f_CLK_HSICmd
  78  0014               L32:
  79                     ; 10 	while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
  81  0014 ae0102        	ldw	x,#258
  82  0017 8d000000      	callf	f_CLK_GetFlagStatus
  84  001b 4d            	tnz	a
  85  001c 27f6          	jreq	L32
  86                     ; 13 	CLK_ClockSwitchCmd(ENABLE);
  88  001e a601          	ld	a,#1
  89  0020 8d000000      	callf	f_CLK_ClockSwitchCmd
  91                     ; 14 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  93  0024 4f            	clr	a
  94  0025 8d000000      	callf	f_CLK_HSIPrescalerConfig
  96                     ; 15 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
  98  0029 a680          	ld	a,#128
  99  002b 8d000000      	callf	f_CLK_SYSCLKConfig
 101                     ; 16 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 103  002f 4b01          	push	#1
 104  0031 4b00          	push	#0
 105  0033 ae01e1        	ldw	x,#481
 106  0036 8d000000      	callf	f_CLK_ClockSwitchConfig
 108  003a 85            	popw	x
 109                     ; 20 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 111  003b ae0301        	ldw	x,#769
 112  003e 8d000000      	callf	f_CLK_PeripheralClockConfig
 114                     ; 21 }
 117  0042 87            	retf
 141                     ; 24 void GPIO_setup(void) {
 142                     	switch	.text
 143  0043               f_GPIO_setup:
 147                     ; 25 	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
 149  0043 ae500a        	ldw	x,#20490
 150  0046 8d000000      	callf	f_GPIO_DeInit
 152                     ; 26 	GPIO_DeInit(GPIOA);     // Reset GPIO settings for port C
 154  004a ae5000        	ldw	x,#20480
 155  004d 8d000000      	callf	f_GPIO_DeInit
 157                     ; 27 	GPIO_DeInit(GPIOB);     // Reset GPIO settings for port C
 159  0051 ae5005        	ldw	x,#20485
 160  0054 8d000000      	callf	f_GPIO_DeInit
 162                     ; 28 	GPIO_DeInit(GPIOD);     // Reset GPIO settings for port C
 164  0058 ae500f        	ldw	x,#20495
 165  005b 8d000000      	callf	f_GPIO_DeInit
 167                     ; 29 	GPIO_DeInit(GPIOE);     // Reset GPIO settings for port C
 169  005f ae5014        	ldw	x,#20500
 170  0062 8d000000      	callf	f_GPIO_DeInit
 172                     ; 30 	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_IN_FL_NO_IT);
 174  0066 4b00          	push	#0
 175  0068 4b20          	push	#32
 176  006a ae5005        	ldw	x,#20485
 177  006d 8d000000      	callf	f_GPIO_Init
 179  0071 85            	popw	x
 180                     ; 31 	GPIO_Init(GPIOB, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 182  0072 4b00          	push	#0
 183  0074 4b40          	push	#64
 184  0076 ae5005        	ldw	x,#20485
 185  0079 8d000000      	callf	f_GPIO_Init
 187  007d 85            	popw	x
 188                     ; 32 	GPIO_Init(GPIOA, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 190  007e 4b00          	push	#0
 191  0080 4b40          	push	#64
 192  0082 ae5000        	ldw	x,#20480
 193  0085 8d000000      	callf	f_GPIO_Init
 195  0089 85            	popw	x
 196                     ; 33 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 198  008a 4be0          	push	#224
 199  008c 4b08          	push	#8
 200  008e ae500a        	ldw	x,#20490
 201  0091 8d000000      	callf	f_GPIO_Init
 203  0095 85            	popw	x
 204                     ; 34 	GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 206  0096 4be0          	push	#224
 207  0098 4b10          	push	#16
 208  009a ae500a        	ldw	x,#20490
 209  009d 8d000000      	callf	f_GPIO_Init
 211  00a1 85            	popw	x
 212                     ; 35 	GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 214  00a2 4be0          	push	#224
 215  00a4 4b04          	push	#4
 216  00a6 ae500a        	ldw	x,#20490
 217  00a9 8d000000      	callf	f_GPIO_Init
 219  00ad 85            	popw	x
 220                     ; 36 	GPIO_Init(GPIOE, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 222  00ae 4be0          	push	#224
 223  00b0 4b08          	push	#8
 224  00b2 ae5014        	ldw	x,#20500
 225  00b5 8d000000      	callf	f_GPIO_Init
 227  00b9 85            	popw	x
 228                     ; 37 	GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 230  00ba 4be0          	push	#224
 231  00bc 4b01          	push	#1
 232  00be ae500f        	ldw	x,#20495
 233  00c1 8d000000      	callf	f_GPIO_Init
 235  00c5 85            	popw	x
 236                     ; 38 	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 238  00c6 4be0          	push	#224
 239  00c8 4b08          	push	#8
 240  00ca ae500f        	ldw	x,#20495
 241  00cd 8d000000      	callf	f_GPIO_Init
 243  00d1 85            	popw	x
 244                     ; 39 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 246  00d2 4be0          	push	#224
 247  00d4 4b08          	push	#8
 248  00d6 ae5000        	ldw	x,#20480
 249  00d9 8d000000      	callf	f_GPIO_Init
 251  00dd 85            	popw	x
 252                     ; 41 	GPIO_Init(GPIOD, GPIO_PIN_7, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 254  00de 4be0          	push	#224
 255  00e0 4b80          	push	#128
 256  00e2 ae500f        	ldw	x,#20495
 257  00e5 8d000000      	callf	f_GPIO_Init
 259  00e9 85            	popw	x
 260                     ; 42 	GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 262  00ea 4be0          	push	#224
 263  00ec 4b10          	push	#16
 264  00ee ae500f        	ldw	x,#20495
 265  00f1 8d000000      	callf	f_GPIO_Init
 267  00f5 85            	popw	x
 268                     ; 43 	GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 270  00f6 4be0          	push	#224
 271  00f8 4b04          	push	#4
 272  00fa ae500f        	ldw	x,#20495
 273  00fd 8d000000      	callf	f_GPIO_Init
 275  0101 85            	popw	x
 276                     ; 44 	GPIO_Init(GPIOE, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 278  0102 4be0          	push	#224
 279  0104 4b01          	push	#1
 280  0106 ae5014        	ldw	x,#20500
 281  0109 8d000000      	callf	f_GPIO_Init
 283  010d 85            	popw	x
 284                     ; 46   GPIO_Init (GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
 286  010e 4bb0          	push	#176
 287  0110 4b02          	push	#2
 288  0112 ae5014        	ldw	x,#20500
 289  0115 8d000000      	callf	f_GPIO_Init
 291  0119 85            	popw	x
 292                     ; 47   GPIO_Init (GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
 294  011a 4bb0          	push	#176
 295  011c 4b04          	push	#4
 296  011e ae5014        	ldw	x,#20500
 297  0121 8d000000      	callf	f_GPIO_Init
 299  0125 85            	popw	x
 300                     ; 48 }
 303  0126 87            	retf
 329                     ; 51 void UART3_setup(void) {
 330                     	switch	.text
 331  0127               f_UART3_setup:
 335                     ; 52 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 337  0127 ae0301        	ldw	x,#769
 338  012a 8d000000      	callf	f_CLK_PeripheralClockConfig
 340                     ; 53 	UART3_DeInit();
 342  012e 8d000000      	callf	f_UART3_DeInit
 344                     ; 54 	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TXRX_ENABLE);
 346  0132 4b0c          	push	#12
 347  0134 4b00          	push	#0
 348  0136 4b00          	push	#0
 349  0138 4b00          	push	#0
 350  013a ae2580        	ldw	x,#9600
 351  013d 89            	pushw	x
 352  013e ae0000        	ldw	x,#0
 353  0141 89            	pushw	x
 354  0142 8d000000      	callf	f_UART3_Init
 356  0146 5b08          	addw	sp,#8
 357                     ; 55 	UART3_Cmd(ENABLE);
 359  0148 a601          	ld	a,#1
 360  014a 8d000000      	callf	f_UART3_Cmd
 362                     ; 56 }
 365  014e 87            	retf
 391                     ; 58 void UART1_setup(void) {
 392                     	switch	.text
 393  014f               f_UART1_setup:
 397                     ; 59 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
 399  014f ae0201        	ldw	x,#513
 400  0152 8d000000      	callf	f_CLK_PeripheralClockConfig
 402                     ; 60 	UART1_DeInit();
 404  0156 8d000000      	callf	f_UART1_DeInit
 406                     ; 61 	UART1_Init(9600, 
 406                     ; 62                 UART1_WORDLENGTH_8D, 
 406                     ; 63                 UART1_STOPBITS_1, 
 406                     ; 64                 UART1_PARITY_NO, 
 406                     ; 65                 UART1_SYNCMODE_CLOCK_DISABLE, 
 406                     ; 66                 UART1_MODE_TXRX_ENABLE);
 408  015a 4b0c          	push	#12
 409  015c 4b80          	push	#128
 410  015e 4b00          	push	#0
 411  0160 4b00          	push	#0
 412  0162 4b00          	push	#0
 413  0164 ae2580        	ldw	x,#9600
 414  0167 89            	pushw	x
 415  0168 ae0000        	ldw	x,#0
 416  016b 89            	pushw	x
 417  016c 8d000000      	callf	f_UART1_Init
 419  0170 5b09          	addw	sp,#9
 420                     ; 67 	UART1_Cmd(ENABLE);
 422  0172 a601          	ld	a,#1
 423  0174 8d000000      	callf	f_UART1_Cmd
 425                     ; 68 }
 428  0178 87            	retf
 454                     ; 71 void ADC2_setup(void) {
 455                     	switch	.text
 456  0179               f_ADC2_setup:
 460                     ; 72 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 462  0179 ae1301        	ldw	x,#4865
 463  017c 8d000000      	callf	f_CLK_PeripheralClockConfig
 465                     ; 73 	ADC2_DeInit();
 467  0180 8d000000      	callf	f_ADC2_DeInit
 469                     ; 75 	ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
 469                     ; 76 						ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6, DISABLE);
 471  0184 4b00          	push	#0
 472  0186 4b07          	push	#7
 473  0188 4b08          	push	#8
 474  018a 4b00          	push	#0
 475  018c 4b01          	push	#1
 476  018e 4b00          	push	#0
 477  0190 ae0105        	ldw	x,#261
 478  0193 8d000000      	callf	f_ADC2_Init
 480  0197 5b06          	addw	sp,#6
 481                     ; 78 	ADC2_Cmd(ENABLE);
 483  0199 a601          	ld	a,#1
 484  019b 8d000000      	callf	f_ADC2_Cmd
 486                     ; 79 }
 489  019f 87            	retf
 518                     ; 81 void TIM1_setup(void)
 518                     ; 82 {
 519                     	switch	.text
 520  01a0               f_TIM1_setup:
 524                     ; 83 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
 526  01a0 ae0701        	ldw	x,#1793
 527  01a3 8d000000      	callf	f_CLK_PeripheralClockConfig
 529                     ; 84      TIM1_DeInit();
 531  01a7 8d000000      	callf	f_TIM1_DeInit
 533                     ; 87 		 TIM1_TimeBaseInit(1600, TIM1_COUNTERMODE_UP, 65535, 1);
 535  01ab 4b01          	push	#1
 536  01ad aeffff        	ldw	x,#65535
 537  01b0 89            	pushw	x
 538  01b1 4b00          	push	#0
 539  01b3 ae0640        	ldw	x,#1600
 540  01b6 8d000000      	callf	f_TIM1_TimeBaseInit
 542  01ba 5b04          	addw	sp,#4
 543                     ; 88      TIM1_ICInit(TIM1_CHANNEL_1, TIM1_ICPOLARITY_RISING, 
 543                     ; 89                  TIM1_ICSELECTION_DIRECTTI, 1, 1);
 545  01bc 4b01          	push	#1
 546  01be 4b01          	push	#1
 547  01c0 4b01          	push	#1
 548  01c2 5f            	clrw	x
 549  01c3 8d000000      	callf	f_TIM1_ICInit
 551  01c7 5b03          	addw	sp,#3
 552                     ; 90      TIM1_ITConfig(TIM1_IT_UPDATE, ENABLE);
 554  01c9 ae0101        	ldw	x,#257
 555  01cc 8d000000      	callf	f_TIM1_ITConfig
 557                     ; 91      TIM1_ITConfig(TIM1_IT_CC1, ENABLE);
 559  01d0 ae0201        	ldw	x,#513
 560  01d3 8d000000      	callf	f_TIM1_ITConfig
 562                     ; 92      TIM1_Cmd(ENABLE);
 564  01d7 a601          	ld	a,#1
 565  01d9 8d000000      	callf	f_TIM1_Cmd
 567                     ; 94      enableInterrupts();
 570  01dd 9a            rim
 572                     ; 95 }
 576  01de 87            	retf
 600                     ; 97 void INT_EEPROM_Setup(void){
 601                     	switch	.text
 602  01df               f_INT_EEPROM_Setup:
 606                     ; 98 	FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
 608  01df 4f            	clr	a
 609  01e0 8d000000      	callf	f_FLASH_SetProgrammingTime
 611                     ; 100 	FLASH_Unlock(FLASH_MEMTYPE_DATA);
 613  01e4 a6f7          	ld	a,#247
 614  01e6 8d000000      	callf	f_FLASH_Unlock
 616                     ; 101 }
 619  01ea 87            	retf
 652                     ; 104 PUTCHAR_PROTOTYPE {
 653                     	switch	.text
 654  01eb               f_putchar:
 656  01eb 88            	push	a
 657       00000000      OFST:	set	0
 660                     ; 105 	UART3_SendData8(c);
 662  01ec 8d000000      	callf	f_UART3_SendData8
 665  01f0               L521:
 666                     ; 106 	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
 668  01f0 ae0080        	ldw	x,#128
 669  01f3 8d000000      	callf	f_UART3_GetFlagStatus
 671  01f7 4d            	tnz	a
 672  01f8 27f6          	jreq	L521
 673                     ; 107 	return c;
 675  01fa 7b01          	ld	a,(OFST+1,sp)
 678  01fc 5b01          	addw	sp,#1
 679  01fe 87            	retf
 712                     ; 110 GETCHAR_PROTOTYPE
 712                     ; 111 {
 713                     	switch	.text
 714  01ff               f_getchar:
 716  01ff 88            	push	a
 717       00000001      OFST:	set	1
 720                     ; 112   char c = 0;
 723  0200               L741:
 724                     ; 114   while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
 726  0200 ae0020        	ldw	x,#32
 727  0203 8d000000      	callf	f_UART3_GetFlagStatus
 729  0207 4d            	tnz	a
 730  0208 27f6          	jreq	L741
 731                     ; 115 	c = UART3_ReceiveData8();
 733  020a 8d000000      	callf	f_UART3_ReceiveData8
 735  020e 6b01          	ld	(OFST+0,sp),a
 737                     ; 116   return (c);
 739  0210 7b01          	ld	a,(OFST+0,sp)
 742  0212 5b01          	addw	sp,#1
 743  0214 87            	retf
 767                     ; 119 void UART3_ClearBuffer(void) {
 768                     	switch	.text
 769  0215               f_UART3_ClearBuffer:
 773  0215 2004          	jra	L561
 774  0217               L361:
 775                     ; 121         (void)UART3_ReceiveData8(); // Clear any preexisting data
 777  0217 8d000000      	callf	f_UART3_ReceiveData8
 779  021b               L561:
 780                     ; 120     while (UART3_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
 782  021b ae0020        	ldw	x,#32
 783  021e 8d000000      	callf	f_UART3_GetFlagStatus
 785  0222 4d            	tnz	a
 786  0223 26f2          	jrne	L361
 787                     ; 123 }
 790  0225 87            	retf
 814                     ; 125 void UART1_ClearBuffer(void) {
 815                     	switch	.text
 816  0226               f_UART1_ClearBuffer:
 820  0226 2004          	jra	L302
 821  0228               L102:
 822                     ; 127         (void)UART1_ReceiveData8(); // Clear any preexisting data
 824  0228 8d000000      	callf	f_UART1_ReceiveData8
 826  022c               L302:
 827                     ; 126     while (UART1_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
 829  022c ae0020        	ldw	x,#32
 830  022f 8d000000      	callf	f_UART1_GetFlagStatus
 832  0233 4d            	tnz	a
 833  0234 26f2          	jrne	L102
 834                     ; 129 }
 837  0236 87            	retf
 895                     ; 131 void UART3_ReceiveString(char *buffer, uint16_t max_length) {
 896                     	switch	.text
 897  0237               f_UART3_ReceiveString:
 899  0237 89            	pushw	x
 900  0238 5203          	subw	sp,#3
 901       00000003      OFST:	set	3
 904                     ; 132 	uint16_t i = 0;
 906                     ; 135 	for (i = 0; i < max_length; i++) {
 908  023a 5f            	clrw	x
 909  023b 1f02          	ldw	(OFST-1,sp),x
 912  023d 200d          	jra	L732
 913  023f               L332:
 914                     ; 136 			buffer[i] = '\0';
 916  023f 1e04          	ldw	x,(OFST+1,sp)
 917  0241 72fb02        	addw	x,(OFST-1,sp)
 918  0244 7f            	clr	(x)
 919                     ; 135 	for (i = 0; i < max_length; i++) {
 921  0245 1e02          	ldw	x,(OFST-1,sp)
 922  0247 1c0001        	addw	x,#1
 923  024a 1f02          	ldw	(OFST-1,sp),x
 925  024c               L732:
 928  024c 1e02          	ldw	x,(OFST-1,sp)
 929  024e 1309          	cpw	x,(OFST+6,sp)
 930  0250 25ed          	jrult	L332
 931                     ; 138 	i = 0;
 933  0252 5f            	clrw	x
 934  0253 1f02          	ldw	(OFST-1,sp),x
 937  0255 202c          	jra	L742
 938  0257               L552:
 939                     ; 142 			while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
 941  0257 ae0020        	ldw	x,#32
 942  025a 8d000000      	callf	f_UART3_GetFlagStatus
 944  025e 4d            	tnz	a
 945  025f 27f6          	jreq	L552
 946                     ; 144 			receivedChar = UART3_ReceiveData8();
 948  0261 8d000000      	callf	f_UART3_ReceiveData8
 950  0265 6b01          	ld	(OFST-2,sp),a
 952                     ; 146 			if (receivedChar == '\n' || receivedChar == '\r') {
 954  0267 7b01          	ld	a,(OFST-2,sp)
 955  0269 a10a          	cp	a,#10
 956  026b 271d          	jreq	L152
 958  026d 7b01          	ld	a,(OFST-2,sp)
 959  026f a10d          	cp	a,#13
 960  0271 2717          	jreq	L152
 961                     ; 149 			buffer[i++] = receivedChar;
 963  0273 7b01          	ld	a,(OFST-2,sp)
 964  0275 1e02          	ldw	x,(OFST-1,sp)
 965  0277 1c0001        	addw	x,#1
 966  027a 1f02          	ldw	(OFST-1,sp),x
 967  027c 1d0001        	subw	x,#1
 969  027f 72fb04        	addw	x,(OFST+1,sp)
 970  0282 f7            	ld	(x),a
 971  0283               L742:
 972                     ; 141 	while (i < max_length - 1) {
 974  0283 1e09          	ldw	x,(OFST+6,sp)
 975  0285 5a            	decw	x
 976  0286 1302          	cpw	x,(OFST-1,sp)
 977  0288 22cd          	jrugt	L552
 978  028a               L152:
 979                     ; 152 	buffer[i] = '\0'; // Null-terminate the string
 981  028a 1e04          	ldw	x,(OFST+1,sp)
 982  028c 72fb02        	addw	x,(OFST-1,sp)
 983  028f 7f            	clr	(x)
 984                     ; 153 }
 987  0290 5b05          	addw	sp,#5
 988  0292 87            	retf
1024                     ; 155 void UART1_SendString(char *str)
1024                     ; 156 {
1025                     	switch	.text
1026  0293               f_UART1_SendString:
1028  0293 89            	pushw	x
1029       00000000      OFST:	set	0
1032  0294 2018          	jra	L503
1033  0296               L303:
1034                     ; 159 			UART1_SendData8(*str);
1036  0296 1e01          	ldw	x,(OFST+1,sp)
1037  0298 f6            	ld	a,(x)
1038  0299 8d000000      	callf	f_UART1_SendData8
1041  029d               L313:
1042                     ; 160 			while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
1044  029d ae0080        	ldw	x,#128
1045  02a0 8d000000      	callf	f_UART1_GetFlagStatus
1047  02a4 4d            	tnz	a
1048  02a5 27f6          	jreq	L313
1049                     ; 161 			str++;
1051  02a7 1e01          	ldw	x,(OFST+1,sp)
1052  02a9 1c0001        	addw	x,#1
1053  02ac 1f01          	ldw	(OFST+1,sp),x
1054  02ae               L503:
1055                     ; 157 	while (*str)
1057  02ae 1e01          	ldw	x,(OFST+1,sp)
1058  02b0 7d            	tnz	(x)
1059  02b1 26e3          	jrne	L303
1060                     ; 163 }
1063  02b3 85            	popw	x
1064  02b4 87            	retf
1122                     ; 165 void UART1_ReceiveString(char *buffer, uint16_t max_length) {
1123                     	switch	.text
1124  02b5               f_UART1_ReceiveString:
1126  02b5 89            	pushw	x
1127  02b6 5203          	subw	sp,#3
1128       00000003      OFST:	set	3
1131                     ; 166 	uint16_t i = 0;
1133                     ; 169 	for (i = 0; i < max_length; i++) {
1135  02b8 5f            	clrw	x
1136  02b9 1f02          	ldw	(OFST-1,sp),x
1139  02bb 200d          	jra	L743
1140  02bd               L343:
1141                     ; 170 			buffer[i] = '\0';
1143  02bd 1e04          	ldw	x,(OFST+1,sp)
1144  02bf 72fb02        	addw	x,(OFST-1,sp)
1145  02c2 7f            	clr	(x)
1146                     ; 169 	for (i = 0; i < max_length; i++) {
1148  02c3 1e02          	ldw	x,(OFST-1,sp)
1149  02c5 1c0001        	addw	x,#1
1150  02c8 1f02          	ldw	(OFST-1,sp),x
1152  02ca               L743:
1155  02ca 1e02          	ldw	x,(OFST-1,sp)
1156  02cc 1309          	cpw	x,(OFST+6,sp)
1157  02ce 25ed          	jrult	L343
1158                     ; 172 	i = 0;
1160  02d0 5f            	clrw	x
1161  02d1 1f02          	ldw	(OFST-1,sp),x
1164  02d3 202c          	jra	L753
1165  02d5               L563:
1166                     ; 176 			while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == RESET);
1168  02d5 ae0020        	ldw	x,#32
1169  02d8 8d000000      	callf	f_UART1_GetFlagStatus
1171  02dc 4d            	tnz	a
1172  02dd 27f6          	jreq	L563
1173                     ; 178 			receivedChar = UART1_ReceiveData8();
1175  02df 8d000000      	callf	f_UART1_ReceiveData8
1177  02e3 6b01          	ld	(OFST-2,sp),a
1179                     ; 180 			if (receivedChar == '\n' || receivedChar == '\r') {
1181  02e5 7b01          	ld	a,(OFST-2,sp)
1182  02e7 a10a          	cp	a,#10
1183  02e9 271d          	jreq	L163
1185  02eb 7b01          	ld	a,(OFST-2,sp)
1186  02ed a10d          	cp	a,#13
1187  02ef 2717          	jreq	L163
1188                     ; 183 			buffer[i++] = receivedChar;
1190  02f1 7b01          	ld	a,(OFST-2,sp)
1191  02f3 1e02          	ldw	x,(OFST-1,sp)
1192  02f5 1c0001        	addw	x,#1
1193  02f8 1f02          	ldw	(OFST-1,sp),x
1194  02fa 1d0001        	subw	x,#1
1196  02fd 72fb04        	addw	x,(OFST+1,sp)
1197  0300 f7            	ld	(x),a
1198  0301               L753:
1199                     ; 175 	while (i < max_length - 1) {
1201  0301 1e09          	ldw	x,(OFST+6,sp)
1202  0303 5a            	decw	x
1203  0304 1302          	cpw	x,(OFST-1,sp)
1204  0306 22cd          	jrugt	L563
1205  0308               L163:
1206                     ; 186 	buffer[i] = '\0'; // Null-terminate the string
1208  0308 1e04          	ldw	x,(OFST+1,sp)
1209  030a 72fb02        	addw	x,(OFST-1,sp)
1210  030d 7f            	clr	(x)
1211                     ; 187 }
1214  030e 5b05          	addw	sp,#5
1215  0310 87            	retf
1253                     ; 190 uint32_t elapsedTime(uint32_t start, uint32_t end) {
1254                     	switch	.text
1255  0311               f_elapsedTime:
1257       00000000      OFST:	set	0
1260                     ; 191 	return (end >= start) ? (end - start) : ((0xffffffff - start + 1) + end);
1262  0311 96            	ldw	x,sp
1263  0312 1c0008        	addw	x,#OFST+8
1264  0315 8d000000      	callf	d_ltor
1266  0319 96            	ldw	x,sp
1267  031a 1c0004        	addw	x,#OFST+4
1268  031d 8d000000      	callf	d_lcmp
1270  0321 2512          	jrult	L24
1271  0323 96            	ldw	x,sp
1272  0324 1c0008        	addw	x,#OFST+8
1273  0327 8d000000      	callf	d_ltor
1275  032b 96            	ldw	x,sp
1276  032c 1c0004        	addw	x,#OFST+4
1277  032f 8d000000      	callf	d_lsub
1279  0333 2014          	jra	L44
1280  0335               L24:
1281  0335 96            	ldw	x,sp
1282  0336 1c0004        	addw	x,#OFST+4
1283  0339 8d000000      	callf	d_ltor
1285  033d 8d000000      	callf	d_lneg
1287  0341 96            	ldw	x,sp
1288  0342 1c0008        	addw	x,#OFST+8
1289  0345 8d000000      	callf	d_ladd
1291  0349               L44:
1294  0349 87            	retf
1337                     ; 195 unsigned int read_ADC_Channel(uint8_t channel) {
1338                     	switch	.text
1339  034a               f_read_ADC_Channel:
1341  034a 89            	pushw	x
1342       00000002      OFST:	set	2
1345                     ; 196 	unsigned int adcValue = 0;
1347                     ; 197 	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, channel, ADC2_ALIGN_RIGHT);
1349  034b 4b08          	push	#8
1350  034d ae0100        	ldw	x,#256
1351  0350 97            	ld	xl,a
1352  0351 8d000000      	callf	f_ADC2_ConversionConfig
1354  0355 84            	pop	a
1355                     ; 198 	ADC2_StartConversion();
1357  0356 8d000000      	callf	f_ADC2_StartConversion
1360  035a               L334:
1361                     ; 200 	while (ADC2_GetFlagStatus() == RESET);
1363  035a 8d000000      	callf	f_ADC2_GetFlagStatus
1365  035e 4d            	tnz	a
1366  035f 27f9          	jreq	L334
1367                     ; 202 	adcValue = ADC2_GetConversionValue();
1369  0361 8d000000      	callf	f_ADC2_GetConversionValue
1371  0365 1f01          	ldw	(OFST-1,sp),x
1373                     ; 203 	ADC2_ClearFlag();
1375  0367 8d000000      	callf	f_ADC2_ClearFlag
1377                     ; 205 	return adcValue;
1379  036b 1e01          	ldw	x,(OFST-1,sp)
1382  036d 5b02          	addw	sp,#2
1383  036f 87            	retf
1426                     ; 208 void internal_EEPROM_WriteStr(uint32_t address, char *str) {
1427                     	switch	.text
1428  0370               f_internal_EEPROM_WriteStr:
1430       00000000      OFST:	set	0
1433  0370 202a          	jra	L164
1434  0372               L754:
1435                     ; 210 		FLASH_ProgramByte(address++, (uint8_t)(*str++));
1437  0372 1e08          	ldw	x,(OFST+8,sp)
1438  0374 1c0001        	addw	x,#1
1439  0377 1f08          	ldw	(OFST+8,sp),x
1440  0379 1d0001        	subw	x,#1
1441  037c f6            	ld	a,(x)
1442  037d 88            	push	a
1443  037e 96            	ldw	x,sp
1444  037f 1c0005        	addw	x,#OFST+5
1445  0382 8d000000      	callf	d_ltor
1447  0386 96            	ldw	x,sp
1448  0387 1c0005        	addw	x,#OFST+5
1449  038a a601          	ld	a,#1
1450  038c 8d000000      	callf	d_lgadc
1452  0390 be02          	ldw	x,c_lreg+2
1453  0392 89            	pushw	x
1454  0393 be00          	ldw	x,c_lreg
1455  0395 89            	pushw	x
1456  0396 8d000000      	callf	f_FLASH_ProgramByte
1458  039a 5b05          	addw	sp,#5
1459  039c               L164:
1460                     ; 209 	while (*str) {
1462  039c 1e08          	ldw	x,(OFST+8,sp)
1463  039e 7d            	tnz	(x)
1464  039f 26d1          	jrne	L754
1465                     ; 212 	FLASH_ProgramByte(address, '\0'); // Write a null terminator
1467  03a1 4b00          	push	#0
1468  03a3 1e07          	ldw	x,(OFST+7,sp)
1469  03a5 89            	pushw	x
1470  03a6 1e07          	ldw	x,(OFST+7,sp)
1471  03a8 89            	pushw	x
1472  03a9 8d000000      	callf	f_FLASH_ProgramByte
1474  03ad 5b05          	addw	sp,#5
1475                     ; 213 }
1478  03af 87            	retf
1542                     ; 215 void internal_EEPROM_ReadStr(uint32_t address, char *buffer, uint16_t max_length) {
1543                     	switch	.text
1544  03b0               f_internal_EEPROM_ReadStr:
1546  03b0 5203          	subw	sp,#3
1547       00000003      OFST:	set	3
1550                     ; 216 	uint16_t i = 0;
1552  03b2 5f            	clrw	x
1553  03b3 1f01          	ldw	(OFST-2,sp),x
1556  03b5 203d          	jra	L715
1557  03b7               L315:
1558                     ; 220 		c = (char)FLASH_ReadByte(address++); // Read a byte
1560  03b7 96            	ldw	x,sp
1561  03b8 1c0007        	addw	x,#OFST+4
1562  03bb 8d000000      	callf	d_ltor
1564  03bf 96            	ldw	x,sp
1565  03c0 1c0007        	addw	x,#OFST+4
1566  03c3 a601          	ld	a,#1
1567  03c5 8d000000      	callf	d_lgadc
1569  03c9 be02          	ldw	x,c_lreg+2
1570  03cb 89            	pushw	x
1571  03cc be00          	ldw	x,c_lreg
1572  03ce 89            	pushw	x
1573  03cf 8d000000      	callf	f_FLASH_ReadByte
1575  03d3 5b04          	addw	sp,#4
1576  03d5 6b03          	ld	(OFST+0,sp),a
1578                     ; 221 		if (c == '\0') {
1580  03d7 0d03          	tnz	(OFST+0,sp)
1581  03d9 2609          	jrne	L325
1582                     ; 222 				break; // Stop if null terminator is encountered
1583  03db               L125:
1584                     ; 226 	buffer[i] = '\0'; // Null-terminate the string
1586  03db 1e0b          	ldw	x,(OFST+8,sp)
1587  03dd 72fb01        	addw	x,(OFST-2,sp)
1588  03e0 7f            	clr	(x)
1589                     ; 227 }
1592  03e1 5b03          	addw	sp,#3
1593  03e3 87            	retf
1594  03e4               L325:
1595                     ; 224 		buffer[i++] = c; // Store the character in the buffer
1597  03e4 7b03          	ld	a,(OFST+0,sp)
1598  03e6 1e01          	ldw	x,(OFST-2,sp)
1599  03e8 1c0001        	addw	x,#1
1600  03eb 1f01          	ldw	(OFST-2,sp),x
1601  03ed 1d0001        	subw	x,#1
1603  03f0 72fb0b        	addw	x,(OFST+8,sp)
1604  03f3 f7            	ld	(x),a
1605  03f4               L715:
1606                     ; 219 	while (i < max_length - 1) {
1608  03f4 1e0d          	ldw	x,(OFST+10,sp)
1609  03f6 5a            	decw	x
1610  03f7 1301          	cpw	x,(OFST-2,sp)
1611  03f9 22bc          	jrugt	L315
1612  03fb 20de          	jra	L125
1648                     ; 229 void printDateTime(void){
1649                     	switch	.text
1650  03fd               f_printDateTime:
1652  03fd 520a          	subw	sp,#10
1653       0000000a      OFST:	set	10
1656                     ; 232 	DS3231_GetTime(rtc_buf, 7);
1658  03ff 4b07          	push	#7
1659  0401 96            	ldw	x,sp
1660  0402 1c0005        	addw	x,#OFST-5
1661  0405 8d000000      	callf	f_DS3231_GetTime
1663  0409 84            	pop	a
1664                     ; 233 	printf("%02d/%02d/%02d ",
1664                     ; 234 		(rtc_buf[4] >> 4) * 10 + (rtc_buf[4] & 0x0F), // Convert Hours from BCD
1664                     ; 235 		(rtc_buf[5] >> 4) * 10 + (rtc_buf[5] & 0x0F), // Convert Minutes from BCD
1664                     ; 236 		(rtc_buf[6] >> 4) * 10 + (rtc_buf[6] & 0x0F)  // Convert Seconds from BCD
1664                     ; 237 		);
1666  040a 7b0a          	ld	a,(OFST+0,sp)
1667  040c a40f          	and	a,#15
1668  040e 6b03          	ld	(OFST-7,sp),a
1670  0410 7b0a          	ld	a,(OFST+0,sp)
1671  0412 4e            	swap	a
1672  0413 a40f          	and	a,#15
1673  0415 5f            	clrw	x
1674  0416 97            	ld	xl,a
1675  0417 a60a          	ld	a,#10
1676  0419 8d000000      	callf	d_bmulx
1678  041d 01            	rrwa	x,a
1679  041e 1b03          	add	a,(OFST-7,sp)
1680  0420 2401          	jrnc	L65
1681  0422 5c            	incw	x
1682  0423               L65:
1683  0423 02            	rlwa	x,a
1684  0424 89            	pushw	x
1685  0425 01            	rrwa	x,a
1686  0426 7b0b          	ld	a,(OFST+1,sp)
1687  0428 a40f          	and	a,#15
1688  042a 6b04          	ld	(OFST-6,sp),a
1690  042c 7b0b          	ld	a,(OFST+1,sp)
1691  042e 4e            	swap	a
1692  042f a40f          	and	a,#15
1693  0431 5f            	clrw	x
1694  0432 97            	ld	xl,a
1695  0433 a60a          	ld	a,#10
1696  0435 8d000000      	callf	d_bmulx
1698  0439 01            	rrwa	x,a
1699  043a 1b04          	add	a,(OFST-6,sp)
1700  043c 2401          	jrnc	L06
1701  043e 5c            	incw	x
1702  043f               L06:
1703  043f 02            	rlwa	x,a
1704  0440 89            	pushw	x
1705  0441 01            	rrwa	x,a
1706  0442 7b0c          	ld	a,(OFST+2,sp)
1707  0444 a40f          	and	a,#15
1708  0446 6b05          	ld	(OFST-5,sp),a
1710  0448 7b0c          	ld	a,(OFST+2,sp)
1711  044a 4e            	swap	a
1712  044b a40f          	and	a,#15
1713  044d 5f            	clrw	x
1714  044e 97            	ld	xl,a
1715  044f a60a          	ld	a,#10
1716  0451 8d000000      	callf	d_bmulx
1718  0455 01            	rrwa	x,a
1719  0456 1b05          	add	a,(OFST-5,sp)
1720  0458 2401          	jrnc	L26
1721  045a 5c            	incw	x
1722  045b               L26:
1723  045b 02            	rlwa	x,a
1724  045c 89            	pushw	x
1725  045d 01            	rrwa	x,a
1726  045e ae015a        	ldw	x,#L345
1727  0461 8d000000      	callf	f_printf
1729  0465 5b06          	addw	sp,#6
1730                     ; 238 	printf("%02d:%02d:%02d",
1730                     ; 239 			(rtc_buf[2] >> 4) * 10 + (rtc_buf[2] & 0x0F), // Convert Hours from BCD
1730                     ; 240 			(rtc_buf[1] >> 4) * 10 + (rtc_buf[1] & 0x0F), // Convert Minutes from BCD
1730                     ; 241 			(rtc_buf[0] >> 4) * 10 + (rtc_buf[0] & 0x0F)  // Convert Seconds from BCD
1730                     ; 242 		);
1732  0467 7b04          	ld	a,(OFST-6,sp)
1733  0469 a40f          	and	a,#15
1734  046b 6b03          	ld	(OFST-7,sp),a
1736  046d 7b04          	ld	a,(OFST-6,sp)
1737  046f 4e            	swap	a
1738  0470 a40f          	and	a,#15
1739  0472 5f            	clrw	x
1740  0473 97            	ld	xl,a
1741  0474 a60a          	ld	a,#10
1742  0476 8d000000      	callf	d_bmulx
1744  047a 01            	rrwa	x,a
1745  047b 1b03          	add	a,(OFST-7,sp)
1746  047d 2401          	jrnc	L46
1747  047f 5c            	incw	x
1748  0480               L46:
1749  0480 02            	rlwa	x,a
1750  0481 89            	pushw	x
1751  0482 01            	rrwa	x,a
1752  0483 7b07          	ld	a,(OFST-3,sp)
1753  0485 a40f          	and	a,#15
1754  0487 6b04          	ld	(OFST-6,sp),a
1756  0489 7b07          	ld	a,(OFST-3,sp)
1757  048b 4e            	swap	a
1758  048c a40f          	and	a,#15
1759  048e 5f            	clrw	x
1760  048f 97            	ld	xl,a
1761  0490 a60a          	ld	a,#10
1762  0492 8d000000      	callf	d_bmulx
1764  0496 01            	rrwa	x,a
1765  0497 1b04          	add	a,(OFST-6,sp)
1766  0499 2401          	jrnc	L66
1767  049b 5c            	incw	x
1768  049c               L66:
1769  049c 02            	rlwa	x,a
1770  049d 89            	pushw	x
1771  049e 01            	rrwa	x,a
1772  049f 7b0a          	ld	a,(OFST+0,sp)
1773  04a1 a40f          	and	a,#15
1774  04a3 6b05          	ld	(OFST-5,sp),a
1776  04a5 7b0a          	ld	a,(OFST+0,sp)
1777  04a7 4e            	swap	a
1778  04a8 a40f          	and	a,#15
1779  04aa 5f            	clrw	x
1780  04ab 97            	ld	xl,a
1781  04ac a60a          	ld	a,#10
1782  04ae 8d000000      	callf	d_bmulx
1784  04b2 01            	rrwa	x,a
1785  04b3 1b05          	add	a,(OFST-5,sp)
1786  04b5 2401          	jrnc	L07
1787  04b7 5c            	incw	x
1788  04b8               L07:
1789  04b8 02            	rlwa	x,a
1790  04b9 89            	pushw	x
1791  04ba 01            	rrwa	x,a
1792  04bb ae014b        	ldw	x,#L545
1793  04be 8d000000      	callf	f_printf
1795  04c2 5b06          	addw	sp,#6
1796                     ; 243 }
1799  04c4 5b0a          	addw	sp,#10
1800  04c6 87            	retf
1846                     ; 245 void sprintDateTime(char *buffer) {
1847                     	switch	.text
1848  04c7               f_sprintDateTime:
1850  04c7 89            	pushw	x
1851  04c8 520d          	subw	sp,#13
1852       0000000d      OFST:	set	13
1855                     ; 249     DS3231_GetTime(rtc_buf, 7);
1857  04ca 4b07          	push	#7
1858  04cc 96            	ldw	x,sp
1859  04cd 1c0008        	addw	x,#OFST-5
1860  04d0 8d000000      	callf	f_DS3231_GetTime
1862  04d4 84            	pop	a
1863                     ; 252     sprintf(buffer, "%02d/%02d/%02d %02d:%02d:%02d",
1863                     ; 253         (rtc_buf[4] >> 4) * 10 + (rtc_buf[4] & 0x0F), // Convert Hours from BCD
1863                     ; 254         (rtc_buf[5] >> 4) * 10 + (rtc_buf[5] & 0x0F), // Convert Minutes from BCD
1863                     ; 255         (rtc_buf[6] >> 4) * 10 + (rtc_buf[6] & 0x0F), // Convert Seconds from BCD
1863                     ; 256         (rtc_buf[2] >> 4) * 10 + (rtc_buf[2] & 0x0F), // Convert Hours from BCD
1863                     ; 257         (rtc_buf[1] >> 4) * 10 + (rtc_buf[1] & 0x0F), // Convert Minutes from BCD
1863                     ; 258         (rtc_buf[0] >> 4) * 10 + (rtc_buf[0] & 0x0F)  // Convert Seconds from BCD
1863                     ; 259     );
1865  04d5 7b07          	ld	a,(OFST-6,sp)
1866  04d7 a40f          	and	a,#15
1867  04d9 6b06          	ld	(OFST-7,sp),a
1869  04db 7b07          	ld	a,(OFST-6,sp)
1870  04dd 4e            	swap	a
1871  04de a40f          	and	a,#15
1872  04e0 5f            	clrw	x
1873  04e1 97            	ld	xl,a
1874  04e2 a60a          	ld	a,#10
1875  04e4 8d000000      	callf	d_bmulx
1877  04e8 01            	rrwa	x,a
1878  04e9 1b06          	add	a,(OFST-7,sp)
1879  04eb 2401          	jrnc	L47
1880  04ed 5c            	incw	x
1881  04ee               L47:
1882  04ee 02            	rlwa	x,a
1883  04ef 89            	pushw	x
1884  04f0 01            	rrwa	x,a
1885  04f1 7b0a          	ld	a,(OFST-3,sp)
1886  04f3 a40f          	and	a,#15
1887  04f5 6b07          	ld	(OFST-6,sp),a
1889  04f7 7b0a          	ld	a,(OFST-3,sp)
1890  04f9 4e            	swap	a
1891  04fa a40f          	and	a,#15
1892  04fc 5f            	clrw	x
1893  04fd 97            	ld	xl,a
1894  04fe a60a          	ld	a,#10
1895  0500 8d000000      	callf	d_bmulx
1897  0504 01            	rrwa	x,a
1898  0505 1b07          	add	a,(OFST-6,sp)
1899  0507 2401          	jrnc	L67
1900  0509 5c            	incw	x
1901  050a               L67:
1902  050a 02            	rlwa	x,a
1903  050b 89            	pushw	x
1904  050c 01            	rrwa	x,a
1905  050d 7b0d          	ld	a,(OFST+0,sp)
1906  050f a40f          	and	a,#15
1907  0511 6b08          	ld	(OFST-5,sp),a
1909  0513 7b0d          	ld	a,(OFST+0,sp)
1910  0515 4e            	swap	a
1911  0516 a40f          	and	a,#15
1912  0518 5f            	clrw	x
1913  0519 97            	ld	xl,a
1914  051a a60a          	ld	a,#10
1915  051c 8d000000      	callf	d_bmulx
1917  0520 01            	rrwa	x,a
1918  0521 1b08          	add	a,(OFST-5,sp)
1919  0523 2401          	jrnc	L001
1920  0525 5c            	incw	x
1921  0526               L001:
1922  0526 02            	rlwa	x,a
1923  0527 89            	pushw	x
1924  0528 01            	rrwa	x,a
1925  0529 7b13          	ld	a,(OFST+6,sp)
1926  052b a40f          	and	a,#15
1927  052d 6b09          	ld	(OFST-4,sp),a
1929  052f 7b13          	ld	a,(OFST+6,sp)
1930  0531 4e            	swap	a
1931  0532 a40f          	and	a,#15
1932  0534 5f            	clrw	x
1933  0535 97            	ld	xl,a
1934  0536 a60a          	ld	a,#10
1935  0538 8d000000      	callf	d_bmulx
1937  053c 01            	rrwa	x,a
1938  053d 1b09          	add	a,(OFST-4,sp)
1939  053f 2401          	jrnc	L201
1940  0541 5c            	incw	x
1941  0542               L201:
1942  0542 02            	rlwa	x,a
1943  0543 89            	pushw	x
1944  0544 01            	rrwa	x,a
1945  0545 7b14          	ld	a,(OFST+7,sp)
1946  0547 a40f          	and	a,#15
1947  0549 6b0a          	ld	(OFST-3,sp),a
1949  054b 7b14          	ld	a,(OFST+7,sp)
1950  054d 4e            	swap	a
1951  054e a40f          	and	a,#15
1952  0550 5f            	clrw	x
1953  0551 97            	ld	xl,a
1954  0552 a60a          	ld	a,#10
1955  0554 8d000000      	callf	d_bmulx
1957  0558 01            	rrwa	x,a
1958  0559 1b0a          	add	a,(OFST-3,sp)
1959  055b 2401          	jrnc	L401
1960  055d 5c            	incw	x
1961  055e               L401:
1962  055e 02            	rlwa	x,a
1963  055f 89            	pushw	x
1964  0560 01            	rrwa	x,a
1965  0561 7b15          	ld	a,(OFST+8,sp)
1966  0563 a40f          	and	a,#15
1967  0565 6b0b          	ld	(OFST-2,sp),a
1969  0567 7b15          	ld	a,(OFST+8,sp)
1970  0569 4e            	swap	a
1971  056a a40f          	and	a,#15
1972  056c 5f            	clrw	x
1973  056d 97            	ld	xl,a
1974  056e a60a          	ld	a,#10
1975  0570 8d000000      	callf	d_bmulx
1977  0574 01            	rrwa	x,a
1978  0575 1b0b          	add	a,(OFST-2,sp)
1979  0577 2401          	jrnc	L601
1980  0579 5c            	incw	x
1981  057a               L601:
1982  057a 02            	rlwa	x,a
1983  057b 89            	pushw	x
1984  057c 01            	rrwa	x,a
1985  057d ae012d        	ldw	x,#L175
1986  0580 89            	pushw	x
1987  0581 1e1c          	ldw	x,(OFST+15,sp)
1988  0583 8d000000      	callf	f_sprintf
1990  0587 5b0e          	addw	sp,#14
1991                     ; 260 }
1994  0589 5b0f          	addw	sp,#15
1995  058b 87            	retf
2049                     ; 262 float ConvertStringToFloat(char *str) {
2050                     	switch	.text
2051  058c               f_ConvertStringToFloat:
2053  058c 89            	pushw	x
2054  058d 5214          	subw	sp,#20
2055       00000014      OFST:	set	20
2058                     ; 263     float value = 0.0f;
2060  058f ce012b        	ldw	x,L326+2
2061  0592 1f13          	ldw	(OFST-1,sp),x
2062  0594 ce0129        	ldw	x,L326
2063  0597 1f11          	ldw	(OFST-3,sp),x
2065                     ; 266     sscanf(str, "%f", &value);
2067  0599 96            	ldw	x,sp
2068  059a 1c0011        	addw	x,#OFST-3
2069  059d 89            	pushw	x
2070  059e ae0126        	ldw	x,#L726
2071  05a1 89            	pushw	x
2072  05a2 1e19          	ldw	x,(OFST+5,sp)
2073  05a4 8d000000      	callf	f_sscanf
2075  05a8 5b04          	addw	sp,#4
2076                     ; 269     sprintf(formattedStr, "%.3f", value); // Format float with %.3f
2078  05aa 1e13          	ldw	x,(OFST-1,sp)
2079  05ac 89            	pushw	x
2080  05ad 1e13          	ldw	x,(OFST-1,sp)
2081  05af 89            	pushw	x
2082  05b0 ae0121        	ldw	x,#L136
2083  05b3 89            	pushw	x
2084  05b4 96            	ldw	x,sp
2085  05b5 1c0007        	addw	x,#OFST-13
2086  05b8 8d000000      	callf	f_sprintf
2088  05bc 5b06          	addw	sp,#6
2089                     ; 270     sscanf(formattedStr, "%f", &value); // Re-convert to float for uniformity
2091  05be 96            	ldw	x,sp
2092  05bf 1c0011        	addw	x,#OFST-3
2093  05c2 89            	pushw	x
2094  05c3 ae0126        	ldw	x,#L726
2095  05c6 89            	pushw	x
2096  05c7 96            	ldw	x,sp
2097  05c8 1c0005        	addw	x,#OFST-15
2098  05cb 8d000000      	callf	f_sscanf
2100  05cf 5b04          	addw	sp,#4
2101                     ; 272     return value;
2103  05d1 96            	ldw	x,sp
2104  05d2 1c0011        	addw	x,#OFST-3
2105  05d5 8d000000      	callf	d_ltor
2109  05d9 5b16          	addw	sp,#22
2110  05db 87            	retf
2153                     ; 275 void ConvertFloatToString(float value, char *str, uint16_t maxLength) {
2154                     	switch	.text
2155  05dc               f_ConvertFloatToString:
2157       00000000      OFST:	set	0
2160                     ; 277     sprintf(str, "%.3f", value);
2162  05dc 1e06          	ldw	x,(OFST+6,sp)
2163  05de 89            	pushw	x
2164  05df 1e06          	ldw	x,(OFST+6,sp)
2165  05e1 89            	pushw	x
2166  05e2 ae0121        	ldw	x,#L136
2167  05e5 89            	pushw	x
2168  05e6 1e0e          	ldw	x,(OFST+14,sp)
2169  05e8 8d000000      	callf	f_sprintf
2171  05ec 5b06          	addw	sp,#6
2172                     ; 278 }
2175  05ee 87            	retf
2279                     ; 281 void LED_Write(GPIO_TypeDef* GPIOx, uint16_t GPIO_PIN, uint8_t state) {
2280                     	switch	.text
2281  05ef               f_LED_Write:
2283  05ef 89            	pushw	x
2284       00000000      OFST:	set	0
2287                     ; 282     if (state) {
2289  05f0 0d08          	tnz	(OFST+8,sp)
2290  05f2 270a          	jreq	L727
2291                     ; 283         GPIO_WriteHigh(GPIOx, GPIO_PIN); // Turn LED ON
2293  05f4 7b07          	ld	a,(OFST+7,sp)
2294  05f6 88            	push	a
2295  05f7 8d000000      	callf	f_GPIO_WriteHigh
2297  05fb 84            	pop	a
2299  05fc 200a          	jra	L137
2300  05fe               L727:
2301                     ; 285         GPIO_WriteLow(GPIOx, GPIO_PIN); // Turn LED OFF
2303  05fe 7b07          	ld	a,(OFST+7,sp)
2304  0600 88            	push	a
2305  0601 1e02          	ldw	x,(OFST+2,sp)
2306  0603 8d000000      	callf	f_GPIO_WriteLow
2308  0607 84            	pop	a
2309  0608               L137:
2310                     ; 287 }
2313  0608 85            	popw	x
2314  0609 87            	retf
2316                     .const:	section	.text
2317  0000               L337_buffer:
2318  0000 00            	dc.b	0
2319  0001 000000000000  	ds.b	199
2404                     ; 291 void createFormattedLog(float frequency, float fieldVoltage, float fieldCurrent, float fdrVoltage, const char *message) {
2405                     	switch	.text
2406  060a               f_createFormattedLog:
2408  060a 52fe          	subw	sp,#254
2409       000000fe      OFST:	set	254
2412                     ; 292     char buffer[200] = ""; // Buffer to hold the resulting formatted string
2414  060c 96            	ldw	x,sp
2415  060d 1c0037        	addw	x,#OFST-199
2416  0610 90ae0000      	ldw	y,#L337_buffer
2417  0614 a6c8          	ld	a,#200
2418  0616 8d000000      	callf	d_xymov
2420                     ; 296     if (frequency != -1) {
2422  061a aeffff        	ldw	x,#65535
2423  061d 8d000000      	callf	d_itof
2425  0621 96            	ldw	x,sp
2426  0622 1c0001        	addw	x,#OFST-253
2427  0625 8d000000      	callf	d_rtol
2430  0629 96            	ldw	x,sp
2431  062a 1c0102        	addw	x,#OFST+4
2432  062d 8d000000      	callf	d_ltor
2434  0631 96            	ldw	x,sp
2435  0632 1c0001        	addw	x,#OFST-253
2436  0635 8d000000      	callf	d_fcmp
2438  0639 2728          	jreq	L377
2439                     ; 297         sprintf(temp, "Freq: %.3f Hz", frequency);
2441  063b 96            	ldw	x,sp
2442  063c 9093          	ldw	y,x
2443  063e de0104        	ldw	x,(OFST+6,x)
2444  0641 89            	pushw	x
2445  0642 93            	ldw	x,y
2446  0643 de0102        	ldw	x,(OFST+4,x)
2447  0646 89            	pushw	x
2448  0647 ae0113        	ldw	x,#L577
2449  064a 89            	pushw	x
2450  064b 96            	ldw	x,sp
2451  064c 1c000b        	addw	x,#OFST-243
2452  064f 8d000000      	callf	f_sprintf
2454  0653 5b06          	addw	sp,#6
2455                     ; 298         strcat(buffer, temp);
2457  0655 96            	ldw	x,sp
2458  0656 1c0005        	addw	x,#OFST-249
2459  0659 89            	pushw	x
2460  065a 96            	ldw	x,sp
2461  065b 1c0039        	addw	x,#OFST-197
2462  065e 8d000000      	callf	f_strcat
2464  0662 85            	popw	x
2465  0663               L377:
2466                     ; 302     if (fieldVoltage != -1) {
2468  0663 aeffff        	ldw	x,#65535
2469  0666 8d000000      	callf	d_itof
2471  066a 96            	ldw	x,sp
2472  066b 1c0001        	addw	x,#OFST-253
2473  066e 8d000000      	callf	d_rtol
2476  0672 96            	ldw	x,sp
2477  0673 1c0106        	addw	x,#OFST+8
2478  0676 8d000000      	callf	d_ltor
2480  067a 96            	ldw	x,sp
2481  067b 1c0001        	addw	x,#OFST-253
2482  067e 8d000000      	callf	d_fcmp
2484  0682 2742          	jreq	L777
2485                     ; 303         if (strlen(buffer) > 0) strcat(buffer, ", "); // Add separator if needed
2487  0684 96            	ldw	x,sp
2488  0685 1c0037        	addw	x,#OFST-199
2489  0688 8d000000      	callf	f_strlen
2491  068c a30000        	cpw	x,#0
2492  068f 270d          	jreq	L1001
2495  0691 ae0110        	ldw	x,#L3001
2496  0694 89            	pushw	x
2497  0695 96            	ldw	x,sp
2498  0696 1c0039        	addw	x,#OFST-197
2499  0699 8d000000      	callf	f_strcat
2501  069d 85            	popw	x
2502  069e               L1001:
2503                     ; 304         sprintf(temp, "FieldVolt: %.2f V", fieldVoltage);
2505  069e 96            	ldw	x,sp
2506  069f 9093          	ldw	y,x
2507  06a1 de0108        	ldw	x,(OFST+10,x)
2508  06a4 89            	pushw	x
2509  06a5 93            	ldw	x,y
2510  06a6 de0106        	ldw	x,(OFST+8,x)
2511  06a9 89            	pushw	x
2512  06aa ae00fe        	ldw	x,#L5001
2513  06ad 89            	pushw	x
2514  06ae 96            	ldw	x,sp
2515  06af 1c000b        	addw	x,#OFST-243
2516  06b2 8d000000      	callf	f_sprintf
2518  06b6 5b06          	addw	sp,#6
2519                     ; 305         strcat(buffer, temp);
2521  06b8 96            	ldw	x,sp
2522  06b9 1c0005        	addw	x,#OFST-249
2523  06bc 89            	pushw	x
2524  06bd 96            	ldw	x,sp
2525  06be 1c0039        	addw	x,#OFST-197
2526  06c1 8d000000      	callf	f_strcat
2528  06c5 85            	popw	x
2529  06c6               L777:
2530                     ; 309     if (fieldCurrent != -1) {
2532  06c6 aeffff        	ldw	x,#65535
2533  06c9 8d000000      	callf	d_itof
2535  06cd 96            	ldw	x,sp
2536  06ce 1c0001        	addw	x,#OFST-253
2537  06d1 8d000000      	callf	d_rtol
2540  06d5 96            	ldw	x,sp
2541  06d6 1c010a        	addw	x,#OFST+12
2542  06d9 8d000000      	callf	d_ltor
2544  06dd 96            	ldw	x,sp
2545  06de 1c0001        	addw	x,#OFST-253
2546  06e1 8d000000      	callf	d_fcmp
2548  06e5 2742          	jreq	L7001
2549                     ; 310         if (strlen(buffer) > 0) strcat(buffer, ", "); // Add separator if needed
2551  06e7 96            	ldw	x,sp
2552  06e8 1c0037        	addw	x,#OFST-199
2553  06eb 8d000000      	callf	f_strlen
2555  06ef a30000        	cpw	x,#0
2556  06f2 270d          	jreq	L1101
2559  06f4 ae0110        	ldw	x,#L3001
2560  06f7 89            	pushw	x
2561  06f8 96            	ldw	x,sp
2562  06f9 1c0039        	addw	x,#OFST-197
2563  06fc 8d000000      	callf	f_strcat
2565  0700 85            	popw	x
2566  0701               L1101:
2567                     ; 311         sprintf(temp, "FieldCurrent: %.2f A", fieldCurrent);
2569  0701 96            	ldw	x,sp
2570  0702 9093          	ldw	y,x
2571  0704 de010c        	ldw	x,(OFST+14,x)
2572  0707 89            	pushw	x
2573  0708 93            	ldw	x,y
2574  0709 de010a        	ldw	x,(OFST+12,x)
2575  070c 89            	pushw	x
2576  070d ae00e9        	ldw	x,#L3101
2577  0710 89            	pushw	x
2578  0711 96            	ldw	x,sp
2579  0712 1c000b        	addw	x,#OFST-243
2580  0715 8d000000      	callf	f_sprintf
2582  0719 5b06          	addw	sp,#6
2583                     ; 312         strcat(buffer, temp);
2585  071b 96            	ldw	x,sp
2586  071c 1c0005        	addw	x,#OFST-249
2587  071f 89            	pushw	x
2588  0720 96            	ldw	x,sp
2589  0721 1c0039        	addw	x,#OFST-197
2590  0724 8d000000      	callf	f_strcat
2592  0728 85            	popw	x
2593  0729               L7001:
2594                     ; 316     if (fdrVoltage != -1) {
2596  0729 aeffff        	ldw	x,#65535
2597  072c 8d000000      	callf	d_itof
2599  0730 96            	ldw	x,sp
2600  0731 1c0001        	addw	x,#OFST-253
2601  0734 8d000000      	callf	d_rtol
2604  0738 96            	ldw	x,sp
2605  0739 1c010e        	addw	x,#OFST+16
2606  073c 8d000000      	callf	d_ltor
2608  0740 96            	ldw	x,sp
2609  0741 1c0001        	addw	x,#OFST-253
2610  0744 8d000000      	callf	d_fcmp
2612  0748 2742          	jreq	L5101
2613                     ; 317         if (strlen(buffer) > 0) strcat(buffer, ", "); // Add separator if needed
2615  074a 96            	ldw	x,sp
2616  074b 1c0037        	addw	x,#OFST-199
2617  074e 8d000000      	callf	f_strlen
2619  0752 a30000        	cpw	x,#0
2620  0755 270d          	jreq	L7101
2623  0757 ae0110        	ldw	x,#L3001
2624  075a 89            	pushw	x
2625  075b 96            	ldw	x,sp
2626  075c 1c0039        	addw	x,#OFST-197
2627  075f 8d000000      	callf	f_strcat
2629  0763 85            	popw	x
2630  0764               L7101:
2631                     ; 318         sprintf(temp, "FDR_Volt: %.2f V", fdrVoltage);
2633  0764 96            	ldw	x,sp
2634  0765 9093          	ldw	y,x
2635  0767 de0110        	ldw	x,(OFST+18,x)
2636  076a 89            	pushw	x
2637  076b 93            	ldw	x,y
2638  076c de010e        	ldw	x,(OFST+16,x)
2639  076f 89            	pushw	x
2640  0770 ae00d8        	ldw	x,#L1201
2641  0773 89            	pushw	x
2642  0774 96            	ldw	x,sp
2643  0775 1c000b        	addw	x,#OFST-243
2644  0778 8d000000      	callf	f_sprintf
2646  077c 5b06          	addw	sp,#6
2647                     ; 319         strcat(buffer, temp);
2649  077e 96            	ldw	x,sp
2650  077f 1c0005        	addw	x,#OFST-249
2651  0782 89            	pushw	x
2652  0783 96            	ldw	x,sp
2653  0784 1c0039        	addw	x,#OFST-197
2654  0787 8d000000      	callf	f_strcat
2656  078b 85            	popw	x
2657  078c               L5101:
2658                     ; 323     if (message != NULL && message[0] != '\0') {
2660  078c 96            	ldw	x,sp
2661  078d d60113        	ld	a,(OFST+21,x)
2662  0790 da0112        	or	a,(OFST+20,x)
2663  0793 272f          	jreq	L3201
2665  0795 96            	ldw	x,sp
2666  0796 de0112        	ldw	x,(OFST+20,x)
2667  0799 7d            	tnz	(x)
2668  079a 2728          	jreq	L3201
2669                     ; 324         if (strlen(buffer) > 0) strcat(buffer, " - "); // Add separator to separate numeric data and message
2671  079c 96            	ldw	x,sp
2672  079d 1c0037        	addw	x,#OFST-199
2673  07a0 8d000000      	callf	f_strlen
2675  07a4 a30000        	cpw	x,#0
2676  07a7 270d          	jreq	L5201
2679  07a9 ae00d4        	ldw	x,#L7201
2680  07ac 89            	pushw	x
2681  07ad 96            	ldw	x,sp
2682  07ae 1c0039        	addw	x,#OFST-197
2683  07b1 8d000000      	callf	f_strcat
2685  07b5 85            	popw	x
2686  07b6               L5201:
2687                     ; 325         strcat(buffer, message);
2689  07b6 96            	ldw	x,sp
2690  07b7 de0112        	ldw	x,(OFST+20,x)
2691  07ba 89            	pushw	x
2692  07bb 96            	ldw	x,sp
2693  07bc 1c0039        	addw	x,#OFST-197
2694  07bf 8d000000      	callf	f_strcat
2696  07c3 85            	popw	x
2697  07c4               L3201:
2698                     ; 329     printf("Result: %s\n", buffer);
2700  07c4 96            	ldw	x,sp
2701  07c5 1c0037        	addw	x,#OFST-199
2702  07c8 89            	pushw	x
2703  07c9 ae00c8        	ldw	x,#L1301
2704  07cc 8d000000      	callf	f_printf
2706  07d0 85            	popw	x
2707                     ; 330 }
2710  07d1 5bfe          	addw	sp,#254
2711  07d3 87            	retf
2723                     	xdef	f_createFormattedLog
2724                     	xdef	f_ConvertStringToFloat
2725                     	xdef	f_ConvertFloatToString
2726                     	xdef	f_sprintDateTime
2727                     	xdef	f_printDateTime
2728                     	xdef	f_internal_EEPROM_WriteStr
2729                     	xdef	f_internal_EEPROM_ReadStr
2730                     	xdef	f_read_ADC_Channel
2731                     	xdef	f_elapsedTime
2732                     	xdef	f_LED_Write
2733                     	xdef	f_UART1_ReceiveString
2734                     	xdef	f_UART1_SendString
2735                     	xdef	f_UART1_ClearBuffer
2736                     	xdef	f_UART1_setup
2737                     	xdef	f_UART3_ReceiveString
2738                     	xdef	f_UART3_ClearBuffer
2739                     	xdef	f_INT_EEPROM_Setup
2740                     	xdef	f_TIM1_setup
2741                     	xdef	f_GPIO_setup
2742                     	xdef	f_ADC2_setup
2743                     	xdef	f_UART3_setup
2744                     	xdef	f_clock_setup
2745                     	xref	f_FLASH_SetProgrammingTime
2746                     	xref	f_FLASH_ReadByte
2747                     	xref	f_FLASH_ProgramByte
2748                     	xref	f_FLASH_Unlock
2749                     	xref	f_DS3231_GetTime
2750                     	xref	f_strlen
2751                     	xref	f_strcat
2752                     	xref	f_sprintf
2753                     	xref	f_sscanf
2754                     	xdef	f_putchar
2755                     	xref	f_printf
2756                     	xdef	f_getchar
2757                     	xref	f_UART3_GetFlagStatus
2758                     	xref	f_UART3_SendData8
2759                     	xref	f_UART3_ReceiveData8
2760                     	xref	f_UART3_Cmd
2761                     	xref	f_UART3_Init
2762                     	xref	f_UART3_DeInit
2763                     	xref	f_UART1_GetFlagStatus
2764                     	xref	f_UART1_SendData8
2765                     	xref	f_UART1_ReceiveData8
2766                     	xref	f_UART1_Cmd
2767                     	xref	f_UART1_Init
2768                     	xref	f_UART1_DeInit
2769                     	xref	f_TIM1_ITConfig
2770                     	xref	f_TIM1_Cmd
2771                     	xref	f_TIM1_ICInit
2772                     	xref	f_TIM1_TimeBaseInit
2773                     	xref	f_TIM1_DeInit
2774                     	xref	f_GPIO_WriteLow
2775                     	xref	f_GPIO_WriteHigh
2776                     	xref	f_GPIO_Init
2777                     	xref	f_GPIO_DeInit
2778                     	xref	f_CLK_GetFlagStatus
2779                     	xref	f_CLK_SYSCLKConfig
2780                     	xref	f_CLK_HSIPrescalerConfig
2781                     	xref	f_CLK_ClockSwitchConfig
2782                     	xref	f_CLK_PeripheralClockConfig
2783                     	xref	f_CLK_ClockSwitchCmd
2784                     	xref	f_CLK_LSICmd
2785                     	xref	f_CLK_HSICmd
2786                     	xref	f_CLK_HSECmd
2787                     	xref	f_CLK_DeInit
2788                     	xref	f_ADC2_ClearFlag
2789                     	xref	f_ADC2_GetFlagStatus
2790                     	xref	f_ADC2_GetConversionValue
2791                     	xref	f_ADC2_StartConversion
2792                     	xref	f_ADC2_ConversionConfig
2793                     	xref	f_ADC2_Cmd
2794                     	xref	f_ADC2_Init
2795                     	xref	f_ADC2_DeInit
2796                     	switch	.const
2797  00c8               L1301:
2798  00c8 526573756c74  	dc.b	"Result: %s",10,0
2799  00d4               L7201:
2800  00d4 202d2000      	dc.b	" - ",0
2801  00d8               L1201:
2802  00d8 4644525f566f  	dc.b	"FDR_Volt: %.2f V",0
2803  00e9               L3101:
2804  00e9 4669656c6443  	dc.b	"FieldCurrent: %.2f"
2805  00fb 204100        	dc.b	" A",0
2806  00fe               L5001:
2807  00fe 4669656c6456  	dc.b	"FieldVolt: %.2f V",0
2808  0110               L3001:
2809  0110 2c2000        	dc.b	", ",0
2810  0113               L577:
2811  0113 467265713a20  	dc.b	"Freq: %.3f Hz",0
2812  0121               L136:
2813  0121 252e336600    	dc.b	"%.3f",0
2814  0126               L726:
2815  0126 256600        	dc.b	"%f",0
2816  0129               L326:
2817  0129 00000000      	dc.w	0,0
2818  012d               L175:
2819  012d 253032642f25  	dc.b	"%02d/%02d/%02d %02"
2820  013f 643a25303264  	dc.b	"d:%02d:%02d",0
2821  014b               L545:
2822  014b 253032643a25  	dc.b	"%02d:%02d:%02d",0
2823  015a               L345:
2824  015a 253032642f25  	dc.b	"%02d/%02d/%02d ",0
2825                     	xref.b	c_lreg
2826                     	xref.b	c_x
2846                     	xref	d_fcmp
2847                     	xref	d_rtol
2848                     	xref	d_itof
2849                     	xref	d_xymov
2850                     	xref	d_bmulx
2851                     	xref	d_lgadc
2852                     	xref	d_ladd
2853                     	xref	d_lneg
2854                     	xref	d_lsub
2855                     	xref	d_lcmp
2856                     	xref	d_ltor
2857                     	end
