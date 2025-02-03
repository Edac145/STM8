   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  52                     ; 4 void clock_setup(void) {
  53                     	switch	.text
  54  0000               f_clock_setup:
  58                     ; 5 	CLK_DeInit();
  60  0000 8d000000      	callf	f_CLK_DeInit
  62                     ; 6 	CLK_HSECmd(DISABLE);
  64  0004 4f            	clr	a
  65  0005 8d000000      	callf	f_CLK_HSECmd
  67                     ; 7 	CLK_LSICmd(DISABLE);
  69  0009 4f            	clr	a
  70  000a 8d000000      	callf	f_CLK_LSICmd
  72                     ; 8 	CLK_HSICmd(ENABLE);
  74  000e a601          	ld	a,#1
  75  0010 8d000000      	callf	f_CLK_HSICmd
  78  0014               L32:
  79                     ; 9 	while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
  81  0014 ae0102        	ldw	x,#258
  82  0017 8d000000      	callf	f_CLK_GetFlagStatus
  84  001b 4d            	tnz	a
  85  001c 27f6          	jreq	L32
  86                     ; 12 	CLK_ClockSwitchCmd(ENABLE);
  88  001e a601          	ld	a,#1
  89  0020 8d000000      	callf	f_CLK_ClockSwitchCmd
  91                     ; 13 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  93  0024 4f            	clr	a
  94  0025 8d000000      	callf	f_CLK_HSIPrescalerConfig
  96                     ; 14 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
  98  0029 a680          	ld	a,#128
  99  002b 8d000000      	callf	f_CLK_SYSCLKConfig
 101                     ; 15 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 103  002f 4b01          	push	#1
 104  0031 4b00          	push	#0
 105  0033 ae01e1        	ldw	x,#481
 106  0036 8d000000      	callf	f_CLK_ClockSwitchConfig
 108  003a 85            	popw	x
 109                     ; 19 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 111  003b ae0301        	ldw	x,#769
 112  003e 8d000000      	callf	f_CLK_PeripheralClockConfig
 114                     ; 20 }
 117  0042 87            	retf
 141                     ; 23 void GPIO_setup(void) {
 142                     	switch	.text
 143  0043               f_GPIO_setup:
 147                     ; 24 	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
 149  0043 ae500a        	ldw	x,#20490
 150  0046 8d000000      	callf	f_GPIO_DeInit
 152                     ; 25 	GPIO_DeInit(GPIOA);     // Reset GPIO settings for port C
 154  004a ae5000        	ldw	x,#20480
 155  004d 8d000000      	callf	f_GPIO_DeInit
 157                     ; 26 	GPIO_DeInit(GPIOB);     // Reset GPIO settings for port C
 159  0051 ae5005        	ldw	x,#20485
 160  0054 8d000000      	callf	f_GPIO_DeInit
 162                     ; 27 	GPIO_DeInit(GPIOD);     // Reset GPIO settings for port C
 164  0058 ae500f        	ldw	x,#20495
 165  005b 8d000000      	callf	f_GPIO_DeInit
 167                     ; 28 	GPIO_DeInit(GPIOE);     // Reset GPIO settings for port C
 169  005f ae5014        	ldw	x,#20500
 170  0062 8d000000      	callf	f_GPIO_DeInit
 172                     ; 29 	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_IN_FL_NO_IT);
 174  0066 4b00          	push	#0
 175  0068 4b20          	push	#32
 176  006a ae5005        	ldw	x,#20485
 177  006d 8d000000      	callf	f_GPIO_Init
 179  0071 85            	popw	x
 180                     ; 30 	GPIO_Init(GPIOB, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 182  0072 4b00          	push	#0
 183  0074 4b40          	push	#64
 184  0076 ae5005        	ldw	x,#20485
 185  0079 8d000000      	callf	f_GPIO_Init
 187  007d 85            	popw	x
 188                     ; 31 	GPIO_Init(GPIOA, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 190  007e 4b00          	push	#0
 191  0080 4b40          	push	#64
 192  0082 ae5000        	ldw	x,#20480
 193  0085 8d000000      	callf	f_GPIO_Init
 195  0089 85            	popw	x
 196                     ; 32 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 198  008a 4be0          	push	#224
 199  008c 4b08          	push	#8
 200  008e ae500a        	ldw	x,#20490
 201  0091 8d000000      	callf	f_GPIO_Init
 203  0095 85            	popw	x
 204                     ; 33 	GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 206  0096 4be0          	push	#224
 207  0098 4b10          	push	#16
 208  009a ae500a        	ldw	x,#20490
 209  009d 8d000000      	callf	f_GPIO_Init
 211  00a1 85            	popw	x
 212                     ; 34 	GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 214  00a2 4be0          	push	#224
 215  00a4 4b04          	push	#4
 216  00a6 ae500a        	ldw	x,#20490
 217  00a9 8d000000      	callf	f_GPIO_Init
 219  00ad 85            	popw	x
 220                     ; 35 	GPIO_Init(GPIOE, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 222  00ae 4be0          	push	#224
 223  00b0 4b08          	push	#8
 224  00b2 ae5014        	ldw	x,#20500
 225  00b5 8d000000      	callf	f_GPIO_Init
 227  00b9 85            	popw	x
 228                     ; 36 	GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 230  00ba 4be0          	push	#224
 231  00bc 4b01          	push	#1
 232  00be ae500f        	ldw	x,#20495
 233  00c1 8d000000      	callf	f_GPIO_Init
 235  00c5 85            	popw	x
 236                     ; 37 	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 238  00c6 4be0          	push	#224
 239  00c8 4b08          	push	#8
 240  00ca ae500f        	ldw	x,#20495
 241  00cd 8d000000      	callf	f_GPIO_Init
 243  00d1 85            	popw	x
 244                     ; 38 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 246  00d2 4be0          	push	#224
 247  00d4 4b08          	push	#8
 248  00d6 ae5000        	ldw	x,#20480
 249  00d9 8d000000      	callf	f_GPIO_Init
 251  00dd 85            	popw	x
 252                     ; 40 	GPIO_Init(GPIOD, GPIO_PIN_7, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 254  00de 4be0          	push	#224
 255  00e0 4b80          	push	#128
 256  00e2 ae500f        	ldw	x,#20495
 257  00e5 8d000000      	callf	f_GPIO_Init
 259  00e9 85            	popw	x
 260                     ; 41 	GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 262  00ea 4be0          	push	#224
 263  00ec 4b10          	push	#16
 264  00ee ae500f        	ldw	x,#20495
 265  00f1 8d000000      	callf	f_GPIO_Init
 267  00f5 85            	popw	x
 268                     ; 42 	GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 270  00f6 4be0          	push	#224
 271  00f8 4b04          	push	#4
 272  00fa ae500f        	ldw	x,#20495
 273  00fd 8d000000      	callf	f_GPIO_Init
 275  0101 85            	popw	x
 276                     ; 43 	GPIO_Init(GPIOE, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 278  0102 4be0          	push	#224
 279  0104 4b01          	push	#1
 280  0106 ae5014        	ldw	x,#20500
 281  0109 8d000000      	callf	f_GPIO_Init
 283  010d 85            	popw	x
 284                     ; 44 }
 287  010e 87            	retf
 313                     ; 47 void UART3_setup(void) {
 314                     	switch	.text
 315  010f               f_UART3_setup:
 319                     ; 48 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 321  010f ae0301        	ldw	x,#769
 322  0112 8d000000      	callf	f_CLK_PeripheralClockConfig
 324                     ; 49 	UART3_DeInit();
 326  0116 8d000000      	callf	f_UART3_DeInit
 328                     ; 50 	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TXRX_ENABLE);
 330  011a 4b0c          	push	#12
 331  011c 4b00          	push	#0
 332  011e 4b00          	push	#0
 333  0120 4b00          	push	#0
 334  0122 ae2580        	ldw	x,#9600
 335  0125 89            	pushw	x
 336  0126 ae0000        	ldw	x,#0
 337  0129 89            	pushw	x
 338  012a 8d000000      	callf	f_UART3_Init
 340  012e 5b08          	addw	sp,#8
 341                     ; 51 	UART3_Cmd(ENABLE);
 343  0130 a601          	ld	a,#1
 344  0132 8d000000      	callf	f_UART3_Cmd
 346                     ; 52 }
 349  0136 87            	retf
 375                     ; 54 void UART1_setup(void) {
 376                     	switch	.text
 377  0137               f_UART1_setup:
 381                     ; 55 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
 383  0137 ae0201        	ldw	x,#513
 384  013a 8d000000      	callf	f_CLK_PeripheralClockConfig
 386                     ; 56 	UART1_DeInit();
 388  013e 8d000000      	callf	f_UART1_DeInit
 390                     ; 57 	UART1_Init(9600, 
 390                     ; 58                 UART1_WORDLENGTH_8D, 
 390                     ; 59                 UART1_STOPBITS_1, 
 390                     ; 60                 UART1_PARITY_NO, 
 390                     ; 61                 UART1_SYNCMODE_CLOCK_DISABLE, 
 390                     ; 62                 UART1_MODE_TXRX_ENABLE);
 392  0142 4b0c          	push	#12
 393  0144 4b80          	push	#128
 394  0146 4b00          	push	#0
 395  0148 4b00          	push	#0
 396  014a 4b00          	push	#0
 397  014c ae2580        	ldw	x,#9600
 398  014f 89            	pushw	x
 399  0150 ae0000        	ldw	x,#0
 400  0153 89            	pushw	x
 401  0154 8d000000      	callf	f_UART1_Init
 403  0158 5b09          	addw	sp,#9
 404                     ; 63 	UART1_Cmd(ENABLE);
 406  015a a601          	ld	a,#1
 407  015c 8d000000      	callf	f_UART1_Cmd
 409                     ; 64 }
 412  0160 87            	retf
 438                     ; 67 void ADC2_setup(void) {
 439                     	switch	.text
 440  0161               f_ADC2_setup:
 444                     ; 68 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 446  0161 ae1301        	ldw	x,#4865
 447  0164 8d000000      	callf	f_CLK_PeripheralClockConfig
 449                     ; 69 	ADC2_DeInit();
 451  0168 8d000000      	callf	f_ADC2_DeInit
 453                     ; 71 	ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
 453                     ; 72 						ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6, DISABLE);
 455  016c 4b00          	push	#0
 456  016e 4b07          	push	#7
 457  0170 4b08          	push	#8
 458  0172 4b00          	push	#0
 459  0174 4b01          	push	#1
 460  0176 4b00          	push	#0
 461  0178 ae0105        	ldw	x,#261
 462  017b 8d000000      	callf	f_ADC2_Init
 464  017f 5b06          	addw	sp,#6
 465                     ; 74 	ADC2_Cmd(ENABLE);
 467  0181 a601          	ld	a,#1
 468  0183 8d000000      	callf	f_ADC2_Cmd
 470                     ; 75 }
 473  0187 87            	retf
 498                     ; 77 void internal_EEPROM_Setup(void){
 499                     	switch	.text
 500  0188               f_internal_EEPROM_Setup:
 504                     ; 78 	FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
 506  0188 4f            	clr	a
 507  0189 8d000000      	callf	f_FLASH_SetProgrammingTime
 509                     ; 80 	FLASH_Unlock(FLASH_MEMTYPE_DATA);
 511  018d a6f7          	ld	a,#247
 512  018f 8d000000      	callf	f_FLASH_Unlock
 514                     ; 81 }
 517  0193 87            	retf
 552                     ; 84 PUTCHAR_PROTOTYPE {
 553                     	switch	.text
 554  0194               f_putchar:
 556  0194 88            	push	a
 557       00000000      OFST:	set	0
 560                     ; 85 	UART3_SendData8(c);
 562  0195 8d000000      	callf	f_UART3_SendData8
 565  0199               L711:
 566                     ; 86 	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
 568  0199 ae0080        	ldw	x,#128
 569  019c 8d000000      	callf	f_UART3_GetFlagStatus
 571  01a0 4d            	tnz	a
 572  01a1 27f6          	jreq	L711
 573                     ; 87 	return c;
 575  01a3 7b01          	ld	a,(OFST+1,sp)
 578  01a5 5b01          	addw	sp,#1
 579  01a7 87            	retf
 614                     ; 90 GETCHAR_PROTOTYPE
 614                     ; 91 {
 615                     	switch	.text
 616  01a8               f_getchar:
 618  01a8 88            	push	a
 619       00000001      OFST:	set	1
 622                     ; 92   char c = 0;
 625  01a9               L341:
 626                     ; 94   while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
 628  01a9 ae0020        	ldw	x,#32
 629  01ac 8d000000      	callf	f_UART3_GetFlagStatus
 631  01b0 4d            	tnz	a
 632  01b1 27f6          	jreq	L341
 633                     ; 95 	c = UART3_ReceiveData8();
 635  01b3 8d000000      	callf	f_UART3_ReceiveData8
 637  01b7 6b01          	ld	(OFST+0,sp),a
 639                     ; 96   return (c);
 641  01b9 7b01          	ld	a,(OFST+0,sp)
 644  01bb 5b01          	addw	sp,#1
 645  01bd 87            	retf
 669                     ; 99 void UART3_ClearBuffer(void) {
 670                     	switch	.text
 671  01be               f_UART3_ClearBuffer:
 675  01be 2004          	jra	L161
 676  01c0               L751:
 677                     ; 101         (void)UART3_ReceiveData8(); // Clear any preexisting data
 679  01c0 8d000000      	callf	f_UART3_ReceiveData8
 681  01c4               L161:
 682                     ; 100     while (UART3_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
 684  01c4 ae0020        	ldw	x,#32
 685  01c7 8d000000      	callf	f_UART3_GetFlagStatus
 687  01cb 4d            	tnz	a
 688  01cc 26f2          	jrne	L751
 689                     ; 103 }
 692  01ce 87            	retf
 716                     ; 105 void UART1_ClearBuffer(void) {
 717                     	switch	.text
 718  01cf               f_UART1_ClearBuffer:
 722  01cf 2004          	jra	L771
 723  01d1               L571:
 724                     ; 107         (void)UART1_ReceiveData8(); // Clear any preexisting data
 726  01d1 8d000000      	callf	f_UART1_ReceiveData8
 728  01d5               L771:
 729                     ; 106     while (UART1_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
 731  01d5 ae0020        	ldw	x,#32
 732  01d8 8d000000      	callf	f_UART1_GetFlagStatus
 734  01dc 4d            	tnz	a
 735  01dd 26f2          	jrne	L571
 736                     ; 109 }
 739  01df 87            	retf
 803                     ; 111 void UART3_ReceiveString(char *buffer, uint16_t max_length) {
 804                     	switch	.text
 805  01e0               f_UART3_ReceiveString:
 807  01e0 89            	pushw	x
 808  01e1 5203          	subw	sp,#3
 809       00000003      OFST:	set	3
 812                     ; 112 	uint16_t i = 0;
 814                     ; 115 	for (i = 0; i < max_length; i++) {
 816  01e3 5f            	clrw	x
 817  01e4 1f02          	ldw	(OFST-1,sp),x
 820  01e6 200d          	jra	L142
 821  01e8               L532:
 822                     ; 116 			buffer[i] = '\0';
 824  01e8 1e04          	ldw	x,(OFST+1,sp)
 825  01ea 72fb02        	addw	x,(OFST-1,sp)
 826  01ed 7f            	clr	(x)
 827                     ; 115 	for (i = 0; i < max_length; i++) {
 829  01ee 1e02          	ldw	x,(OFST-1,sp)
 830  01f0 1c0001        	addw	x,#1
 831  01f3 1f02          	ldw	(OFST-1,sp),x
 833  01f5               L142:
 836  01f5 1e02          	ldw	x,(OFST-1,sp)
 837  01f7 1309          	cpw	x,(OFST+6,sp)
 838  01f9 25ed          	jrult	L532
 839                     ; 118 	i = 0;
 841  01fb 5f            	clrw	x
 842  01fc 1f02          	ldw	(OFST-1,sp),x
 845  01fe 202c          	jra	L152
 846  0200               L752:
 847                     ; 122 			while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
 849  0200 ae0020        	ldw	x,#32
 850  0203 8d000000      	callf	f_UART3_GetFlagStatus
 852  0207 4d            	tnz	a
 853  0208 27f6          	jreq	L752
 854                     ; 124 			receivedChar = UART3_ReceiveData8();
 856  020a 8d000000      	callf	f_UART3_ReceiveData8
 858  020e 6b01          	ld	(OFST-2,sp),a
 860                     ; 126 			if (receivedChar == '\n' || receivedChar == '\r') {
 862  0210 7b01          	ld	a,(OFST-2,sp)
 863  0212 a10a          	cp	a,#10
 864  0214 271d          	jreq	L352
 866  0216 7b01          	ld	a,(OFST-2,sp)
 867  0218 a10d          	cp	a,#13
 868  021a 2717          	jreq	L352
 869                     ; 129 			buffer[i++] = receivedChar;
 871  021c 7b01          	ld	a,(OFST-2,sp)
 872  021e 1e02          	ldw	x,(OFST-1,sp)
 873  0220 1c0001        	addw	x,#1
 874  0223 1f02          	ldw	(OFST-1,sp),x
 875  0225 1d0001        	subw	x,#1
 877  0228 72fb04        	addw	x,(OFST+1,sp)
 878  022b f7            	ld	(x),a
 879  022c               L152:
 880                     ; 121 	while (i < max_length - 1) {
 882  022c 1e09          	ldw	x,(OFST+6,sp)
 883  022e 5a            	decw	x
 884  022f 1302          	cpw	x,(OFST-1,sp)
 885  0231 22cd          	jrugt	L752
 886  0233               L352:
 887                     ; 132 	buffer[i] = '\0'; // Null-terminate the string
 889  0233 1e04          	ldw	x,(OFST+1,sp)
 890  0235 72fb02        	addw	x,(OFST-1,sp)
 891  0238 7f            	clr	(x)
 892                     ; 133 }
 895  0239 5b05          	addw	sp,#5
 896  023b 87            	retf
 932                     ; 135 void UART1_SendString(char *str)
 932                     ; 136 {
 933                     	switch	.text
 934  023c               f_UART1_SendString:
 936  023c 89            	pushw	x
 937       00000000      OFST:	set	0
 940  023d 2018          	jra	L703
 941  023f               L503:
 942                     ; 139 			UART1_SendData8(*str);
 944  023f 1e01          	ldw	x,(OFST+1,sp)
 945  0241 f6            	ld	a,(x)
 946  0242 8d000000      	callf	f_UART1_SendData8
 949  0246               L513:
 950                     ; 140 			while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 952  0246 ae0080        	ldw	x,#128
 953  0249 8d000000      	callf	f_UART1_GetFlagStatus
 955  024d 4d            	tnz	a
 956  024e 27f6          	jreq	L513
 957                     ; 141 			str++;
 959  0250 1e01          	ldw	x,(OFST+1,sp)
 960  0252 1c0001        	addw	x,#1
 961  0255 1f01          	ldw	(OFST+1,sp),x
 962  0257               L703:
 963                     ; 137 	while (*str)
 965  0257 1e01          	ldw	x,(OFST+1,sp)
 966  0259 7d            	tnz	(x)
 967  025a 26e3          	jrne	L503
 968                     ; 143 }
 971  025c 85            	popw	x
 972  025d 87            	retf
1036                     ; 145 void UART1_ReceiveString(char *buffer, uint16_t max_length) {
1037                     	switch	.text
1038  025e               f_UART1_ReceiveString:
1040  025e 89            	pushw	x
1041  025f 5203          	subw	sp,#3
1042       00000003      OFST:	set	3
1045                     ; 146 	uint16_t i = 0;
1047                     ; 149 	for (i = 0; i < max_length; i++) {
1049  0261 5f            	clrw	x
1050  0262 1f02          	ldw	(OFST-1,sp),x
1053  0264 200d          	jra	L753
1054  0266               L353:
1055                     ; 150 			buffer[i] = '\0';
1057  0266 1e04          	ldw	x,(OFST+1,sp)
1058  0268 72fb02        	addw	x,(OFST-1,sp)
1059  026b 7f            	clr	(x)
1060                     ; 149 	for (i = 0; i < max_length; i++) {
1062  026c 1e02          	ldw	x,(OFST-1,sp)
1063  026e 1c0001        	addw	x,#1
1064  0271 1f02          	ldw	(OFST-1,sp),x
1066  0273               L753:
1069  0273 1e02          	ldw	x,(OFST-1,sp)
1070  0275 1309          	cpw	x,(OFST+6,sp)
1071  0277 25ed          	jrult	L353
1072                     ; 152 	i = 0;
1074  0279 5f            	clrw	x
1075  027a 1f02          	ldw	(OFST-1,sp),x
1078  027c 202c          	jra	L763
1079  027e               L573:
1080                     ; 156 			while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == RESET);
1082  027e ae0020        	ldw	x,#32
1083  0281 8d000000      	callf	f_UART1_GetFlagStatus
1085  0285 4d            	tnz	a
1086  0286 27f6          	jreq	L573
1087                     ; 158 			receivedChar = UART1_ReceiveData8();
1089  0288 8d000000      	callf	f_UART1_ReceiveData8
1091  028c 6b01          	ld	(OFST-2,sp),a
1093                     ; 160 			if (receivedChar == '\n' || receivedChar == '\r') {
1095  028e 7b01          	ld	a,(OFST-2,sp)
1096  0290 a10a          	cp	a,#10
1097  0292 271d          	jreq	L173
1099  0294 7b01          	ld	a,(OFST-2,sp)
1100  0296 a10d          	cp	a,#13
1101  0298 2717          	jreq	L173
1102                     ; 163 			buffer[i++] = receivedChar;
1104  029a 7b01          	ld	a,(OFST-2,sp)
1105  029c 1e02          	ldw	x,(OFST-1,sp)
1106  029e 1c0001        	addw	x,#1
1107  02a1 1f02          	ldw	(OFST-1,sp),x
1108  02a3 1d0001        	subw	x,#1
1110  02a6 72fb04        	addw	x,(OFST+1,sp)
1111  02a9 f7            	ld	(x),a
1112  02aa               L763:
1113                     ; 155 	while (i < max_length - 1) {
1115  02aa 1e09          	ldw	x,(OFST+6,sp)
1116  02ac 5a            	decw	x
1117  02ad 1302          	cpw	x,(OFST-1,sp)
1118  02af 22cd          	jrugt	L573
1119  02b1               L173:
1120                     ; 166 	buffer[i] = '\0'; // Null-terminate the string
1122  02b1 1e04          	ldw	x,(OFST+1,sp)
1123  02b3 72fb02        	addw	x,(OFST-1,sp)
1124  02b6 7f            	clr	(x)
1125                     ; 167 }
1128  02b7 5b05          	addw	sp,#5
1129  02b9 87            	retf
1171                     ; 170 uint32_t elapsedTime(uint32_t start, uint32_t end) {
1172                     	switch	.text
1173  02ba               f_elapsedTime:
1175       00000000      OFST:	set	0
1178                     ; 171 	return (end >= start) ? (end - start) : ((0xffffffff - start + 1) + end);
1180  02ba 96            	ldw	x,sp
1181  02bb 1c0008        	addw	x,#OFST+8
1182  02be 8d000000      	callf	d_ltor
1184  02c2 96            	ldw	x,sp
1185  02c3 1c0004        	addw	x,#OFST+4
1186  02c6 8d000000      	callf	d_lcmp
1188  02ca 2512          	jrult	L04
1189  02cc 96            	ldw	x,sp
1190  02cd 1c0008        	addw	x,#OFST+8
1191  02d0 8d000000      	callf	d_ltor
1193  02d4 96            	ldw	x,sp
1194  02d5 1c0004        	addw	x,#OFST+4
1195  02d8 8d000000      	callf	d_lsub
1197  02dc 2014          	jra	L24
1198  02de               L04:
1199  02de 96            	ldw	x,sp
1200  02df 1c0004        	addw	x,#OFST+4
1201  02e2 8d000000      	callf	d_ltor
1203  02e6 8d000000      	callf	d_lneg
1205  02ea 96            	ldw	x,sp
1206  02eb 1c0008        	addw	x,#OFST+8
1207  02ee 8d000000      	callf	d_ladd
1209  02f2               L24:
1212  02f2 87            	retf
1259                     ; 175 unsigned int read_ADC_Channel(uint8_t channel) {
1260                     	switch	.text
1261  02f3               f_read_ADC_Channel:
1263  02f3 89            	pushw	x
1264       00000002      OFST:	set	2
1267                     ; 176 	unsigned int adcValue = 0;
1269                     ; 177 	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, channel, ADC2_ALIGN_RIGHT);
1271  02f4 4b08          	push	#8
1272  02f6 ae0100        	ldw	x,#256
1273  02f9 97            	ld	xl,a
1274  02fa 8d000000      	callf	f_ADC2_ConversionConfig
1276  02fe 84            	pop	a
1277                     ; 178 	ADC2_StartConversion();
1279  02ff 8d000000      	callf	f_ADC2_StartConversion
1282  0303               L354:
1283                     ; 180 	while (ADC2_GetFlagStatus() == RESET);
1285  0303 8d000000      	callf	f_ADC2_GetFlagStatus
1287  0307 4d            	tnz	a
1288  0308 27f9          	jreq	L354
1289                     ; 182 	adcValue = ADC2_GetConversionValue();
1291  030a 8d000000      	callf	f_ADC2_GetConversionValue
1293  030e 1f01          	ldw	(OFST-1,sp),x
1295                     ; 183 	ADC2_ClearFlag();
1297  0310 8d000000      	callf	f_ADC2_ClearFlag
1299                     ; 185 	return adcValue;
1301  0314 1e01          	ldw	x,(OFST-1,sp)
1304  0316 5b02          	addw	sp,#2
1305  0318 87            	retf
1341                     ; 187 void printDateTime(void){
1342                     	switch	.text
1343  0319               f_printDateTime:
1345  0319 520a          	subw	sp,#10
1346       0000000a      OFST:	set	10
1349                     ; 190 	DS3231_GetTime(rtc_buf, 7);
1351  031b 4b07          	push	#7
1352  031d 96            	ldw	x,sp
1353  031e 1c0005        	addw	x,#OFST-5
1354  0321 8d000000      	callf	f_DS3231_GetTime
1356  0325 84            	pop	a
1357                     ; 191 	printf("%02d/%02d/%02d ",
1357                     ; 192 		(rtc_buf[4] >> 4) * 10 + (rtc_buf[4] & 0x0F), // Convert Hours from BCD
1357                     ; 193 		(rtc_buf[5] >> 4) * 10 + (rtc_buf[5] & 0x0F), // Convert Minutes from BCD
1357                     ; 194 		(rtc_buf[6] >> 4) * 10 + (rtc_buf[6] & 0x0F)  // Convert Seconds from BCD
1357                     ; 195 		);
1359  0326 7b0a          	ld	a,(OFST+0,sp)
1360  0328 a40f          	and	a,#15
1361  032a 6b03          	ld	(OFST-7,sp),a
1363  032c 7b0a          	ld	a,(OFST+0,sp)
1364  032e 4e            	swap	a
1365  032f a40f          	and	a,#15
1366  0331 5f            	clrw	x
1367  0332 97            	ld	xl,a
1368  0333 a60a          	ld	a,#10
1369  0335 8d000000      	callf	d_bmulx
1371  0339 01            	rrwa	x,a
1372  033a 1b03          	add	a,(OFST-7,sp)
1373  033c 2401          	jrnc	L05
1374  033e 5c            	incw	x
1375  033f               L05:
1376  033f 02            	rlwa	x,a
1377  0340 89            	pushw	x
1378  0341 01            	rrwa	x,a
1379  0342 7b0b          	ld	a,(OFST+1,sp)
1380  0344 a40f          	and	a,#15
1381  0346 6b04          	ld	(OFST-6,sp),a
1383  0348 7b0b          	ld	a,(OFST+1,sp)
1384  034a 4e            	swap	a
1385  034b a40f          	and	a,#15
1386  034d 5f            	clrw	x
1387  034e 97            	ld	xl,a
1388  034f a60a          	ld	a,#10
1389  0351 8d000000      	callf	d_bmulx
1391  0355 01            	rrwa	x,a
1392  0356 1b04          	add	a,(OFST-6,sp)
1393  0358 2401          	jrnc	L25
1394  035a 5c            	incw	x
1395  035b               L25:
1396  035b 02            	rlwa	x,a
1397  035c 89            	pushw	x
1398  035d 01            	rrwa	x,a
1399  035e 7b0c          	ld	a,(OFST+2,sp)
1400  0360 a40f          	and	a,#15
1401  0362 6b05          	ld	(OFST-5,sp),a
1403  0364 7b0c          	ld	a,(OFST+2,sp)
1404  0366 4e            	swap	a
1405  0367 a40f          	and	a,#15
1406  0369 5f            	clrw	x
1407  036a 97            	ld	xl,a
1408  036b a60a          	ld	a,#10
1409  036d 8d000000      	callf	d_bmulx
1411  0371 01            	rrwa	x,a
1412  0372 1b05          	add	a,(OFST-5,sp)
1413  0374 2401          	jrnc	L45
1414  0376 5c            	incw	x
1415  0377               L45:
1416  0377 02            	rlwa	x,a
1417  0378 89            	pushw	x
1418  0379 01            	rrwa	x,a
1419  037a ae015a        	ldw	x,#L574
1420  037d 8d000000      	callf	f_printf
1422  0381 5b06          	addw	sp,#6
1423                     ; 196 	printf("%02d:%02d:%02d",
1423                     ; 197 			(rtc_buf[2] >> 4) * 10 + (rtc_buf[2] & 0x0F), // Convert Hours from BCD
1423                     ; 198 			(rtc_buf[1] >> 4) * 10 + (rtc_buf[1] & 0x0F), // Convert Minutes from BCD
1423                     ; 199 			(rtc_buf[0] >> 4) * 10 + (rtc_buf[0] & 0x0F)  // Convert Seconds from BCD
1423                     ; 200 		);
1425  0383 7b04          	ld	a,(OFST-6,sp)
1426  0385 a40f          	and	a,#15
1427  0387 6b03          	ld	(OFST-7,sp),a
1429  0389 7b04          	ld	a,(OFST-6,sp)
1430  038b 4e            	swap	a
1431  038c a40f          	and	a,#15
1432  038e 5f            	clrw	x
1433  038f 97            	ld	xl,a
1434  0390 a60a          	ld	a,#10
1435  0392 8d000000      	callf	d_bmulx
1437  0396 01            	rrwa	x,a
1438  0397 1b03          	add	a,(OFST-7,sp)
1439  0399 2401          	jrnc	L65
1440  039b 5c            	incw	x
1441  039c               L65:
1442  039c 02            	rlwa	x,a
1443  039d 89            	pushw	x
1444  039e 01            	rrwa	x,a
1445  039f 7b07          	ld	a,(OFST-3,sp)
1446  03a1 a40f          	and	a,#15
1447  03a3 6b04          	ld	(OFST-6,sp),a
1449  03a5 7b07          	ld	a,(OFST-3,sp)
1450  03a7 4e            	swap	a
1451  03a8 a40f          	and	a,#15
1452  03aa 5f            	clrw	x
1453  03ab 97            	ld	xl,a
1454  03ac a60a          	ld	a,#10
1455  03ae 8d000000      	callf	d_bmulx
1457  03b2 01            	rrwa	x,a
1458  03b3 1b04          	add	a,(OFST-6,sp)
1459  03b5 2401          	jrnc	L06
1460  03b7 5c            	incw	x
1461  03b8               L06:
1462  03b8 02            	rlwa	x,a
1463  03b9 89            	pushw	x
1464  03ba 01            	rrwa	x,a
1465  03bb 7b0a          	ld	a,(OFST+0,sp)
1466  03bd a40f          	and	a,#15
1467  03bf 6b05          	ld	(OFST-5,sp),a
1469  03c1 7b0a          	ld	a,(OFST+0,sp)
1470  03c3 4e            	swap	a
1471  03c4 a40f          	and	a,#15
1472  03c6 5f            	clrw	x
1473  03c7 97            	ld	xl,a
1474  03c8 a60a          	ld	a,#10
1475  03ca 8d000000      	callf	d_bmulx
1477  03ce 01            	rrwa	x,a
1478  03cf 1b05          	add	a,(OFST-5,sp)
1479  03d1 2401          	jrnc	L26
1480  03d3 5c            	incw	x
1481  03d4               L26:
1482  03d4 02            	rlwa	x,a
1483  03d5 89            	pushw	x
1484  03d6 01            	rrwa	x,a
1485  03d7 ae014b        	ldw	x,#L774
1486  03da 8d000000      	callf	f_printf
1488  03de 5b06          	addw	sp,#6
1489                     ; 201 }
1492  03e0 5b0a          	addw	sp,#10
1493  03e2 87            	retf
1539                     ; 203 void sprintDateTime(char *buffer) {
1540                     	switch	.text
1541  03e3               f_sprintDateTime:
1543  03e3 89            	pushw	x
1544  03e4 520d          	subw	sp,#13
1545       0000000d      OFST:	set	13
1548                     ; 207     DS3231_GetTime(rtc_buf, 7);
1550  03e6 4b07          	push	#7
1551  03e8 96            	ldw	x,sp
1552  03e9 1c0008        	addw	x,#OFST-5
1553  03ec 8d000000      	callf	f_DS3231_GetTime
1555  03f0 84            	pop	a
1556                     ; 210     sprintf(buffer, "%02d/%02d/%02d %02d:%02d:%02d",
1556                     ; 211         (rtc_buf[4] >> 4) * 10 + (rtc_buf[4] & 0x0F), // Convert Hours from BCD
1556                     ; 212         (rtc_buf[5] >> 4) * 10 + (rtc_buf[5] & 0x0F), // Convert Minutes from BCD
1556                     ; 213         (rtc_buf[6] >> 4) * 10 + (rtc_buf[6] & 0x0F), // Convert Seconds from BCD
1556                     ; 214         (rtc_buf[2] >> 4) * 10 + (rtc_buf[2] & 0x0F), // Convert Hours from BCD
1556                     ; 215         (rtc_buf[1] >> 4) * 10 + (rtc_buf[1] & 0x0F), // Convert Minutes from BCD
1556                     ; 216         (rtc_buf[0] >> 4) * 10 + (rtc_buf[0] & 0x0F)  // Convert Seconds from BCD
1556                     ; 217     );
1558  03f1 7b07          	ld	a,(OFST-6,sp)
1559  03f3 a40f          	and	a,#15
1560  03f5 6b06          	ld	(OFST-7,sp),a
1562  03f7 7b07          	ld	a,(OFST-6,sp)
1563  03f9 4e            	swap	a
1564  03fa a40f          	and	a,#15
1565  03fc 5f            	clrw	x
1566  03fd 97            	ld	xl,a
1567  03fe a60a          	ld	a,#10
1568  0400 8d000000      	callf	d_bmulx
1570  0404 01            	rrwa	x,a
1571  0405 1b06          	add	a,(OFST-7,sp)
1572  0407 2401          	jrnc	L66
1573  0409 5c            	incw	x
1574  040a               L66:
1575  040a 02            	rlwa	x,a
1576  040b 89            	pushw	x
1577  040c 01            	rrwa	x,a
1578  040d 7b0a          	ld	a,(OFST-3,sp)
1579  040f a40f          	and	a,#15
1580  0411 6b07          	ld	(OFST-6,sp),a
1582  0413 7b0a          	ld	a,(OFST-3,sp)
1583  0415 4e            	swap	a
1584  0416 a40f          	and	a,#15
1585  0418 5f            	clrw	x
1586  0419 97            	ld	xl,a
1587  041a a60a          	ld	a,#10
1588  041c 8d000000      	callf	d_bmulx
1590  0420 01            	rrwa	x,a
1591  0421 1b07          	add	a,(OFST-6,sp)
1592  0423 2401          	jrnc	L07
1593  0425 5c            	incw	x
1594  0426               L07:
1595  0426 02            	rlwa	x,a
1596  0427 89            	pushw	x
1597  0428 01            	rrwa	x,a
1598  0429 7b0d          	ld	a,(OFST+0,sp)
1599  042b a40f          	and	a,#15
1600  042d 6b08          	ld	(OFST-5,sp),a
1602  042f 7b0d          	ld	a,(OFST+0,sp)
1603  0431 4e            	swap	a
1604  0432 a40f          	and	a,#15
1605  0434 5f            	clrw	x
1606  0435 97            	ld	xl,a
1607  0436 a60a          	ld	a,#10
1608  0438 8d000000      	callf	d_bmulx
1610  043c 01            	rrwa	x,a
1611  043d 1b08          	add	a,(OFST-5,sp)
1612  043f 2401          	jrnc	L27
1613  0441 5c            	incw	x
1614  0442               L27:
1615  0442 02            	rlwa	x,a
1616  0443 89            	pushw	x
1617  0444 01            	rrwa	x,a
1618  0445 7b13          	ld	a,(OFST+6,sp)
1619  0447 a40f          	and	a,#15
1620  0449 6b09          	ld	(OFST-4,sp),a
1622  044b 7b13          	ld	a,(OFST+6,sp)
1623  044d 4e            	swap	a
1624  044e a40f          	and	a,#15
1625  0450 5f            	clrw	x
1626  0451 97            	ld	xl,a
1627  0452 a60a          	ld	a,#10
1628  0454 8d000000      	callf	d_bmulx
1630  0458 01            	rrwa	x,a
1631  0459 1b09          	add	a,(OFST-4,sp)
1632  045b 2401          	jrnc	L47
1633  045d 5c            	incw	x
1634  045e               L47:
1635  045e 02            	rlwa	x,a
1636  045f 89            	pushw	x
1637  0460 01            	rrwa	x,a
1638  0461 7b14          	ld	a,(OFST+7,sp)
1639  0463 a40f          	and	a,#15
1640  0465 6b0a          	ld	(OFST-3,sp),a
1642  0467 7b14          	ld	a,(OFST+7,sp)
1643  0469 4e            	swap	a
1644  046a a40f          	and	a,#15
1645  046c 5f            	clrw	x
1646  046d 97            	ld	xl,a
1647  046e a60a          	ld	a,#10
1648  0470 8d000000      	callf	d_bmulx
1650  0474 01            	rrwa	x,a
1651  0475 1b0a          	add	a,(OFST-3,sp)
1652  0477 2401          	jrnc	L67
1653  0479 5c            	incw	x
1654  047a               L67:
1655  047a 02            	rlwa	x,a
1656  047b 89            	pushw	x
1657  047c 01            	rrwa	x,a
1658  047d 7b15          	ld	a,(OFST+8,sp)
1659  047f a40f          	and	a,#15
1660  0481 6b0b          	ld	(OFST-2,sp),a
1662  0483 7b15          	ld	a,(OFST+8,sp)
1663  0485 4e            	swap	a
1664  0486 a40f          	and	a,#15
1665  0488 5f            	clrw	x
1666  0489 97            	ld	xl,a
1667  048a a60a          	ld	a,#10
1668  048c 8d000000      	callf	d_bmulx
1670  0490 01            	rrwa	x,a
1671  0491 1b0b          	add	a,(OFST-2,sp)
1672  0493 2401          	jrnc	L001
1673  0495 5c            	incw	x
1674  0496               L001:
1675  0496 02            	rlwa	x,a
1676  0497 89            	pushw	x
1677  0498 01            	rrwa	x,a
1678  0499 ae012d        	ldw	x,#L325
1679  049c 89            	pushw	x
1680  049d 1e1c          	ldw	x,(OFST+15,sp)
1681  049f 8d000000      	callf	f_sprintf
1683  04a3 5b0e          	addw	sp,#14
1684                     ; 218 }
1687  04a5 5b0f          	addw	sp,#15
1688  04a7 87            	retf
1744                     ; 220 float ConvertStringToFloat(char *str) {
1745                     	switch	.text
1746  04a8               f_ConvertStringToFloat:
1748  04a8 89            	pushw	x
1749  04a9 5214          	subw	sp,#20
1750       00000014      OFST:	set	20
1753                     ; 221     float value = 0.0f;
1755  04ab ce012b        	ldw	x,L755+2
1756  04ae 1f13          	ldw	(OFST-1,sp),x
1757  04b0 ce0129        	ldw	x,L755
1758  04b3 1f11          	ldw	(OFST-3,sp),x
1760                     ; 224     sscanf(str, "%f", &value);
1762  04b5 96            	ldw	x,sp
1763  04b6 1c0011        	addw	x,#OFST-3
1764  04b9 89            	pushw	x
1765  04ba ae0126        	ldw	x,#L365
1766  04bd 89            	pushw	x
1767  04be 1e19          	ldw	x,(OFST+5,sp)
1768  04c0 8d000000      	callf	f_sscanf
1770  04c4 5b04          	addw	sp,#4
1771                     ; 227     sprintf(formattedStr, "%.3f", value); // Format float with %.3f
1773  04c6 1e13          	ldw	x,(OFST-1,sp)
1774  04c8 89            	pushw	x
1775  04c9 1e13          	ldw	x,(OFST-1,sp)
1776  04cb 89            	pushw	x
1777  04cc ae0121        	ldw	x,#L565
1778  04cf 89            	pushw	x
1779  04d0 96            	ldw	x,sp
1780  04d1 1c0007        	addw	x,#OFST-13
1781  04d4 8d000000      	callf	f_sprintf
1783  04d8 5b06          	addw	sp,#6
1784                     ; 228     sscanf(formattedStr, "%f", &value); // Re-convert to float for uniformity
1786  04da 96            	ldw	x,sp
1787  04db 1c0011        	addw	x,#OFST-3
1788  04de 89            	pushw	x
1789  04df ae0126        	ldw	x,#L365
1790  04e2 89            	pushw	x
1791  04e3 96            	ldw	x,sp
1792  04e4 1c0005        	addw	x,#OFST-15
1793  04e7 8d000000      	callf	f_sscanf
1795  04eb 5b04          	addw	sp,#4
1796                     ; 230     return value;
1798  04ed 96            	ldw	x,sp
1799  04ee 1c0011        	addw	x,#OFST-3
1800  04f1 8d000000      	callf	d_ltor
1804  04f5 5b16          	addw	sp,#22
1805  04f7 87            	retf
1850                     ; 233 void ConvertFloatToString(float value, char *str, uint16_t maxLength) {
1851                     	switch	.text
1852  04f8               f_ConvertFloatToString:
1854       00000000      OFST:	set	0
1857                     ; 235     sprintf(str, "%.3f", value);
1859  04f8 1e06          	ldw	x,(OFST+6,sp)
1860  04fa 89            	pushw	x
1861  04fb 1e06          	ldw	x,(OFST+6,sp)
1862  04fd 89            	pushw	x
1863  04fe ae0121        	ldw	x,#L565
1864  0501 89            	pushw	x
1865  0502 1e0e          	ldw	x,(OFST+14,sp)
1866  0504 8d000000      	callf	f_sprintf
1868  0508 5b06          	addw	sp,#6
1869                     ; 236 }
1872  050a 87            	retf
1980                     ; 239 void LED_Write(GPIO_TypeDef* GPIOx, uint16_t GPIO_PIN, uint8_t state) {
1981                     	switch	.text
1982  050b               f_LED_Write:
1984  050b 89            	pushw	x
1985       00000000      OFST:	set	0
1988                     ; 240     if (state) {
1990  050c 0d08          	tnz	(OFST+8,sp)
1991  050e 270a          	jreq	L176
1992                     ; 241         GPIO_WriteHigh(GPIOx, GPIO_PIN); // Turn LED ON
1994  0510 7b07          	ld	a,(OFST+7,sp)
1995  0512 88            	push	a
1996  0513 8d000000      	callf	f_GPIO_WriteHigh
1998  0517 84            	pop	a
2000  0518 200a          	jra	L376
2001  051a               L176:
2002                     ; 243         GPIO_WriteLow(GPIOx, GPIO_PIN); // Turn LED OFF
2004  051a 7b07          	ld	a,(OFST+7,sp)
2005  051c 88            	push	a
2006  051d 1e02          	ldw	x,(OFST+2,sp)
2007  051f 8d000000      	callf	f_GPIO_WriteLow
2009  0523 84            	pop	a
2010  0524               L376:
2011                     ; 245 }
2014  0524 85            	popw	x
2015  0525 87            	retf
2017                     .const:	section	.text
2018  0000               L576_buffer:
2019  0000 00            	dc.b	0
2020  0001 000000000000  	ds.b	199
2113                     ; 249 void createFormattedLog(float frequency, float fieldVoltage, float fieldCurrent, float fdrVoltage, const char *message) {
2114                     	switch	.text
2115  0526               f_createFormattedLog:
2117  0526 52fe          	subw	sp,#254
2118       000000fe      OFST:	set	254
2121                     ; 250     char buffer[200] = ""; // Buffer to hold the resulting formatted string
2123  0528 96            	ldw	x,sp
2124  0529 1c0037        	addw	x,#OFST-199
2125  052c 90ae0000      	ldw	y,#L576_buffer
2126  0530 a6c8          	ld	a,#200
2127  0532 8d000000      	callf	d_xymov
2129                     ; 254     if (frequency != -1) {
2131  0536 aeffff        	ldw	x,#65535
2132  0539 8d000000      	callf	d_itof
2134  053d 96            	ldw	x,sp
2135  053e 1c0001        	addw	x,#OFST-253
2136  0541 8d000000      	callf	d_rtol
2139  0545 96            	ldw	x,sp
2140  0546 1c0102        	addw	x,#OFST+4
2141  0549 8d000000      	callf	d_ltor
2143  054d 96            	ldw	x,sp
2144  054e 1c0001        	addw	x,#OFST-253
2145  0551 8d000000      	callf	d_fcmp
2147  0555 2728          	jreq	L547
2148                     ; 255         sprintf(temp, "Freq: %.3f Hz", frequency);
2150  0557 96            	ldw	x,sp
2151  0558 9093          	ldw	y,x
2152  055a de0104        	ldw	x,(OFST+6,x)
2153  055d 89            	pushw	x
2154  055e 93            	ldw	x,y
2155  055f de0102        	ldw	x,(OFST+4,x)
2156  0562 89            	pushw	x
2157  0563 ae0113        	ldw	x,#L747
2158  0566 89            	pushw	x
2159  0567 96            	ldw	x,sp
2160  0568 1c000b        	addw	x,#OFST-243
2161  056b 8d000000      	callf	f_sprintf
2163  056f 5b06          	addw	sp,#6
2164                     ; 256         strcat(buffer, temp);
2166  0571 96            	ldw	x,sp
2167  0572 1c0005        	addw	x,#OFST-249
2168  0575 89            	pushw	x
2169  0576 96            	ldw	x,sp
2170  0577 1c0039        	addw	x,#OFST-197
2171  057a 8d000000      	callf	f_strcat
2173  057e 85            	popw	x
2174  057f               L547:
2175                     ; 260     if (fieldVoltage != -1) {
2177  057f aeffff        	ldw	x,#65535
2178  0582 8d000000      	callf	d_itof
2180  0586 96            	ldw	x,sp
2181  0587 1c0001        	addw	x,#OFST-253
2182  058a 8d000000      	callf	d_rtol
2185  058e 96            	ldw	x,sp
2186  058f 1c0106        	addw	x,#OFST+8
2187  0592 8d000000      	callf	d_ltor
2189  0596 96            	ldw	x,sp
2190  0597 1c0001        	addw	x,#OFST-253
2191  059a 8d000000      	callf	d_fcmp
2193  059e 2742          	jreq	L157
2194                     ; 261         if (strlen(buffer) > 0) strcat(buffer, ", "); // Add separator if needed
2196  05a0 96            	ldw	x,sp
2197  05a1 1c0037        	addw	x,#OFST-199
2198  05a4 8d000000      	callf	f_strlen
2200  05a8 a30000        	cpw	x,#0
2201  05ab 270d          	jreq	L357
2204  05ad ae0110        	ldw	x,#L557
2205  05b0 89            	pushw	x
2206  05b1 96            	ldw	x,sp
2207  05b2 1c0039        	addw	x,#OFST-197
2208  05b5 8d000000      	callf	f_strcat
2210  05b9 85            	popw	x
2211  05ba               L357:
2212                     ; 262         sprintf(temp, "FieldVolt: %.2f V", fieldVoltage);
2214  05ba 96            	ldw	x,sp
2215  05bb 9093          	ldw	y,x
2216  05bd de0108        	ldw	x,(OFST+10,x)
2217  05c0 89            	pushw	x
2218  05c1 93            	ldw	x,y
2219  05c2 de0106        	ldw	x,(OFST+8,x)
2220  05c5 89            	pushw	x
2221  05c6 ae00fe        	ldw	x,#L757
2222  05c9 89            	pushw	x
2223  05ca 96            	ldw	x,sp
2224  05cb 1c000b        	addw	x,#OFST-243
2225  05ce 8d000000      	callf	f_sprintf
2227  05d2 5b06          	addw	sp,#6
2228                     ; 263         strcat(buffer, temp);
2230  05d4 96            	ldw	x,sp
2231  05d5 1c0005        	addw	x,#OFST-249
2232  05d8 89            	pushw	x
2233  05d9 96            	ldw	x,sp
2234  05da 1c0039        	addw	x,#OFST-197
2235  05dd 8d000000      	callf	f_strcat
2237  05e1 85            	popw	x
2238  05e2               L157:
2239                     ; 267     if (fieldCurrent != -1) {
2241  05e2 aeffff        	ldw	x,#65535
2242  05e5 8d000000      	callf	d_itof
2244  05e9 96            	ldw	x,sp
2245  05ea 1c0001        	addw	x,#OFST-253
2246  05ed 8d000000      	callf	d_rtol
2249  05f1 96            	ldw	x,sp
2250  05f2 1c010a        	addw	x,#OFST+12
2251  05f5 8d000000      	callf	d_ltor
2253  05f9 96            	ldw	x,sp
2254  05fa 1c0001        	addw	x,#OFST-253
2255  05fd 8d000000      	callf	d_fcmp
2257  0601 2742          	jreq	L167
2258                     ; 268         if (strlen(buffer) > 0) strcat(buffer, ", "); // Add separator if needed
2260  0603 96            	ldw	x,sp
2261  0604 1c0037        	addw	x,#OFST-199
2262  0607 8d000000      	callf	f_strlen
2264  060b a30000        	cpw	x,#0
2265  060e 270d          	jreq	L367
2268  0610 ae0110        	ldw	x,#L557
2269  0613 89            	pushw	x
2270  0614 96            	ldw	x,sp
2271  0615 1c0039        	addw	x,#OFST-197
2272  0618 8d000000      	callf	f_strcat
2274  061c 85            	popw	x
2275  061d               L367:
2276                     ; 269         sprintf(temp, "FieldCurrent: %.2f A", fieldCurrent);
2278  061d 96            	ldw	x,sp
2279  061e 9093          	ldw	y,x
2280  0620 de010c        	ldw	x,(OFST+14,x)
2281  0623 89            	pushw	x
2282  0624 93            	ldw	x,y
2283  0625 de010a        	ldw	x,(OFST+12,x)
2284  0628 89            	pushw	x
2285  0629 ae00e9        	ldw	x,#L567
2286  062c 89            	pushw	x
2287  062d 96            	ldw	x,sp
2288  062e 1c000b        	addw	x,#OFST-243
2289  0631 8d000000      	callf	f_sprintf
2291  0635 5b06          	addw	sp,#6
2292                     ; 270         strcat(buffer, temp);
2294  0637 96            	ldw	x,sp
2295  0638 1c0005        	addw	x,#OFST-249
2296  063b 89            	pushw	x
2297  063c 96            	ldw	x,sp
2298  063d 1c0039        	addw	x,#OFST-197
2299  0640 8d000000      	callf	f_strcat
2301  0644 85            	popw	x
2302  0645               L167:
2303                     ; 274     if (fdrVoltage != -1) {
2305  0645 aeffff        	ldw	x,#65535
2306  0648 8d000000      	callf	d_itof
2308  064c 96            	ldw	x,sp
2309  064d 1c0001        	addw	x,#OFST-253
2310  0650 8d000000      	callf	d_rtol
2313  0654 96            	ldw	x,sp
2314  0655 1c010e        	addw	x,#OFST+16
2315  0658 8d000000      	callf	d_ltor
2317  065c 96            	ldw	x,sp
2318  065d 1c0001        	addw	x,#OFST-253
2319  0660 8d000000      	callf	d_fcmp
2321  0664 2742          	jreq	L767
2322                     ; 275         if (strlen(buffer) > 0) strcat(buffer, ", "); // Add separator if needed
2324  0666 96            	ldw	x,sp
2325  0667 1c0037        	addw	x,#OFST-199
2326  066a 8d000000      	callf	f_strlen
2328  066e a30000        	cpw	x,#0
2329  0671 270d          	jreq	L177
2332  0673 ae0110        	ldw	x,#L557
2333  0676 89            	pushw	x
2334  0677 96            	ldw	x,sp
2335  0678 1c0039        	addw	x,#OFST-197
2336  067b 8d000000      	callf	f_strcat
2338  067f 85            	popw	x
2339  0680               L177:
2340                     ; 276         sprintf(temp, "FDR_Volt: %.2f V", fdrVoltage);
2342  0680 96            	ldw	x,sp
2343  0681 9093          	ldw	y,x
2344  0683 de0110        	ldw	x,(OFST+18,x)
2345  0686 89            	pushw	x
2346  0687 93            	ldw	x,y
2347  0688 de010e        	ldw	x,(OFST+16,x)
2348  068b 89            	pushw	x
2349  068c ae00d8        	ldw	x,#L377
2350  068f 89            	pushw	x
2351  0690 96            	ldw	x,sp
2352  0691 1c000b        	addw	x,#OFST-243
2353  0694 8d000000      	callf	f_sprintf
2355  0698 5b06          	addw	sp,#6
2356                     ; 277         strcat(buffer, temp);
2358  069a 96            	ldw	x,sp
2359  069b 1c0005        	addw	x,#OFST-249
2360  069e 89            	pushw	x
2361  069f 96            	ldw	x,sp
2362  06a0 1c0039        	addw	x,#OFST-197
2363  06a3 8d000000      	callf	f_strcat
2365  06a7 85            	popw	x
2366  06a8               L767:
2367                     ; 281     if (message != NULL && message[0] != '\0') {
2369  06a8 96            	ldw	x,sp
2370  06a9 d60113        	ld	a,(OFST+21,x)
2371  06ac da0112        	or	a,(OFST+20,x)
2372  06af 272f          	jreq	L577
2374  06b1 96            	ldw	x,sp
2375  06b2 de0112        	ldw	x,(OFST+20,x)
2376  06b5 7d            	tnz	(x)
2377  06b6 2728          	jreq	L577
2378                     ; 282         if (strlen(buffer) > 0) strcat(buffer, " - "); // Add separator to separate numeric data and message
2380  06b8 96            	ldw	x,sp
2381  06b9 1c0037        	addw	x,#OFST-199
2382  06bc 8d000000      	callf	f_strlen
2384  06c0 a30000        	cpw	x,#0
2385  06c3 270d          	jreq	L777
2388  06c5 ae00d4        	ldw	x,#L1001
2389  06c8 89            	pushw	x
2390  06c9 96            	ldw	x,sp
2391  06ca 1c0039        	addw	x,#OFST-197
2392  06cd 8d000000      	callf	f_strcat
2394  06d1 85            	popw	x
2395  06d2               L777:
2396                     ; 283         strcat(buffer, message);
2398  06d2 96            	ldw	x,sp
2399  06d3 de0112        	ldw	x,(OFST+20,x)
2400  06d6 89            	pushw	x
2401  06d7 96            	ldw	x,sp
2402  06d8 1c0039        	addw	x,#OFST-197
2403  06db 8d000000      	callf	f_strcat
2405  06df 85            	popw	x
2406  06e0               L577:
2407                     ; 287     printf("Result: %s\n", buffer);
2409  06e0 96            	ldw	x,sp
2410  06e1 1c0037        	addw	x,#OFST-199
2411  06e4 89            	pushw	x
2412  06e5 ae00c8        	ldw	x,#L3001
2413  06e8 8d000000      	callf	f_printf
2415  06ec 85            	popw	x
2416                     ; 288 }
2419  06ed 5bfe          	addw	sp,#254
2420  06ef 87            	retf
2432                     	xdef	f_createFormattedLog
2433                     	xdef	f_ConvertStringToFloat
2434                     	xdef	f_ConvertFloatToString
2435                     	xdef	f_sprintDateTime
2436                     	xdef	f_printDateTime
2437                     	xdef	f_read_ADC_Channel
2438                     	xdef	f_elapsedTime
2439                     	xdef	f_LED_Write
2440                     	xdef	f_UART1_ReceiveString
2441                     	xdef	f_UART1_SendString
2442                     	xdef	f_UART1_ClearBuffer
2443                     	xdef	f_UART1_setup
2444                     	xdef	f_UART3_ReceiveString
2445                     	xdef	f_UART3_ClearBuffer
2446                     	xdef	f_internal_EEPROM_Setup
2447                     	xdef	f_GPIO_setup
2448                     	xdef	f_ADC2_setup
2449                     	xdef	f_UART3_setup
2450                     	xdef	f_clock_setup
2451                     	xref	f_FLASH_SetProgrammingTime
2452                     	xref	f_FLASH_Unlock
2453                     	xref	f_DS3231_GetTime
2454                     	xref	f_strlen
2455                     	xref	f_strcat
2456                     	xref	f_sprintf
2457                     	xref	f_sscanf
2458                     	xdef	f_putchar
2459                     	xref	f_printf
2460                     	xdef	f_getchar
2461                     	xref	f_UART3_GetFlagStatus
2462                     	xref	f_UART3_SendData8
2463                     	xref	f_UART3_ReceiveData8
2464                     	xref	f_UART3_Cmd
2465                     	xref	f_UART3_Init
2466                     	xref	f_UART3_DeInit
2467                     	xref	f_UART1_GetFlagStatus
2468                     	xref	f_UART1_SendData8
2469                     	xref	f_UART1_ReceiveData8
2470                     	xref	f_UART1_Cmd
2471                     	xref	f_UART1_Init
2472                     	xref	f_UART1_DeInit
2473                     	xref	f_GPIO_WriteLow
2474                     	xref	f_GPIO_WriteHigh
2475                     	xref	f_GPIO_Init
2476                     	xref	f_GPIO_DeInit
2477                     	xref	f_CLK_GetFlagStatus
2478                     	xref	f_CLK_SYSCLKConfig
2479                     	xref	f_CLK_HSIPrescalerConfig
2480                     	xref	f_CLK_ClockSwitchConfig
2481                     	xref	f_CLK_PeripheralClockConfig
2482                     	xref	f_CLK_ClockSwitchCmd
2483                     	xref	f_CLK_LSICmd
2484                     	xref	f_CLK_HSICmd
2485                     	xref	f_CLK_HSECmd
2486                     	xref	f_CLK_DeInit
2487                     	xref	f_ADC2_ClearFlag
2488                     	xref	f_ADC2_GetFlagStatus
2489                     	xref	f_ADC2_GetConversionValue
2490                     	xref	f_ADC2_StartConversion
2491                     	xref	f_ADC2_ConversionConfig
2492                     	xref	f_ADC2_Cmd
2493                     	xref	f_ADC2_Init
2494                     	xref	f_ADC2_DeInit
2495                     	switch	.const
2496  00c8               L3001:
2497  00c8 526573756c74  	dc.b	"Result: %s",10,0
2498  00d4               L1001:
2499  00d4 202d2000      	dc.b	" - ",0
2500  00d8               L377:
2501  00d8 4644525f566f  	dc.b	"FDR_Volt: %.2f V",0
2502  00e9               L567:
2503  00e9 4669656c6443  	dc.b	"FieldCurrent: %.2f"
2504  00fb 204100        	dc.b	" A",0
2505  00fe               L757:
2506  00fe 4669656c6456  	dc.b	"FieldVolt: %.2f V",0
2507  0110               L557:
2508  0110 2c2000        	dc.b	", ",0
2509  0113               L747:
2510  0113 467265713a20  	dc.b	"Freq: %.3f Hz",0
2511  0121               L565:
2512  0121 252e336600    	dc.b	"%.3f",0
2513  0126               L365:
2514  0126 256600        	dc.b	"%f",0
2515  0129               L755:
2516  0129 00000000      	dc.w	0,0
2517  012d               L325:
2518  012d 253032642f25  	dc.b	"%02d/%02d/%02d %02"
2519  013f 643a25303264  	dc.b	"d:%02d:%02d",0
2520  014b               L774:
2521  014b 253032643a25  	dc.b	"%02d:%02d:%02d",0
2522  015a               L574:
2523  015a 253032642f25  	dc.b	"%02d/%02d/%02d ",0
2524                     	xref.b	c_x
2544                     	xref	d_fcmp
2545                     	xref	d_rtol
2546                     	xref	d_itof
2547                     	xref	d_xymov
2548                     	xref	d_bmulx
2549                     	xref	d_ladd
2550                     	xref	d_lneg
2551                     	xref	d_lsub
2552                     	xref	d_lcmp
2553                     	xref	d_ltor
2554                     	end
