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
 188                     ; 31 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 190  007e 4be0          	push	#224
 191  0080 4b08          	push	#8
 192  0082 ae500a        	ldw	x,#20490
 193  0085 8d000000      	callf	f_GPIO_Init
 195  0089 85            	popw	x
 196                     ; 32 	GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 198  008a 4be0          	push	#224
 199  008c 4b10          	push	#16
 200  008e ae500a        	ldw	x,#20490
 201  0091 8d000000      	callf	f_GPIO_Init
 203  0095 85            	popw	x
 204                     ; 33 	GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 206  0096 4be0          	push	#224
 207  0098 4b04          	push	#4
 208  009a ae500a        	ldw	x,#20490
 209  009d 8d000000      	callf	f_GPIO_Init
 211  00a1 85            	popw	x
 212                     ; 34 	GPIO_Init(GPIOE, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 214  00a2 4be0          	push	#224
 215  00a4 4b08          	push	#8
 216  00a6 ae5014        	ldw	x,#20500
 217  00a9 8d000000      	callf	f_GPIO_Init
 219  00ad 85            	popw	x
 220                     ; 35 	GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 222  00ae 4be0          	push	#224
 223  00b0 4b01          	push	#1
 224  00b2 ae500f        	ldw	x,#20495
 225  00b5 8d000000      	callf	f_GPIO_Init
 227  00b9 85            	popw	x
 228                     ; 36 	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 230  00ba 4be0          	push	#224
 231  00bc 4b08          	push	#8
 232  00be ae500f        	ldw	x,#20495
 233  00c1 8d000000      	callf	f_GPIO_Init
 235  00c5 85            	popw	x
 236                     ; 37 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 238  00c6 4be0          	push	#224
 239  00c8 4b08          	push	#8
 240  00ca ae5000        	ldw	x,#20480
 241  00cd 8d000000      	callf	f_GPIO_Init
 243  00d1 85            	popw	x
 244                     ; 38 }
 247  00d2 87            	retf
 272                     ; 41 void UART3_setup(void) {
 273                     	switch	.text
 274  00d3               f_UART3_setup:
 278                     ; 42 	UART3_DeInit();
 280  00d3 8d000000      	callf	f_UART3_DeInit
 282                     ; 43 	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TXRX_ENABLE);
 284  00d7 4b0c          	push	#12
 285  00d9 4b00          	push	#0
 286  00db 4b00          	push	#0
 287  00dd 4b00          	push	#0
 288  00df ae2580        	ldw	x,#9600
 289  00e2 89            	pushw	x
 290  00e3 ae0000        	ldw	x,#0
 291  00e6 89            	pushw	x
 292  00e7 8d000000      	callf	f_UART3_Init
 294  00eb 5b08          	addw	sp,#8
 295                     ; 44 	UART3_Cmd(ENABLE);
 297  00ed a601          	ld	a,#1
 298  00ef 8d000000      	callf	f_UART3_Cmd
 300                     ; 45 }
 303  00f3 87            	retf
 329                     ; 48 void ADC2_setup(void) {
 330                     	switch	.text
 331  00f4               f_ADC2_setup:
 335                     ; 49 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 337  00f4 ae1301        	ldw	x,#4865
 338  00f7 8d000000      	callf	f_CLK_PeripheralClockConfig
 340                     ; 50 	ADC2_DeInit();
 342  00fb 8d000000      	callf	f_ADC2_DeInit
 344                     ; 52 	ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
 344                     ; 53 						ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6, DISABLE);
 346  00ff 4b00          	push	#0
 347  0101 4b07          	push	#7
 348  0103 4b08          	push	#8
 349  0105 4b00          	push	#0
 350  0107 4b01          	push	#1
 351  0109 4b00          	push	#0
 352  010b ae0105        	ldw	x,#261
 353  010e 8d000000      	callf	f_ADC2_Init
 355  0112 5b06          	addw	sp,#6
 356                     ; 55 	ADC2_Cmd(ENABLE);
 358  0114 a601          	ld	a,#1
 359  0116 8d000000      	callf	f_ADC2_Cmd
 361                     ; 56 }
 364  011a 87            	retf
 399                     ; 59 PUTCHAR_PROTOTYPE {
 400                     	switch	.text
 401  011b               f_putchar:
 403  011b 88            	push	a
 404       00000000      OFST:	set	0
 407                     ; 60 	UART3_SendData8(c);
 409  011c 8d000000      	callf	f_UART3_SendData8
 412  0120               L77:
 413                     ; 61 	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
 415  0120 ae0080        	ldw	x,#128
 416  0123 8d000000      	callf	f_UART3_GetFlagStatus
 418  0127 4d            	tnz	a
 419  0128 27f6          	jreq	L77
 420                     ; 62 	return c;
 422  012a 7b01          	ld	a,(OFST+1,sp)
 425  012c 5b01          	addw	sp,#1
 426  012e 87            	retf
 461                     ; 65 GETCHAR_PROTOTYPE
 461                     ; 66 {
 462                     	switch	.text
 463  012f               f_getchar:
 465  012f 88            	push	a
 466       00000001      OFST:	set	1
 469                     ; 67   char c = 0;
 472  0130               L321:
 473                     ; 69   while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
 475  0130 ae0020        	ldw	x,#32
 476  0133 8d000000      	callf	f_UART3_GetFlagStatus
 478  0137 4d            	tnz	a
 479  0138 27f6          	jreq	L321
 480                     ; 70 	c = UART3_ReceiveData8();
 482  013a 8d000000      	callf	f_UART3_ReceiveData8
 484  013e 6b01          	ld	(OFST+0,sp),a
 486                     ; 71   return (c);
 488  0140 7b01          	ld	a,(OFST+0,sp)
 491  0142 5b01          	addw	sp,#1
 492  0144 87            	retf
 516                     ; 75 void UART3_ClearBuffer(void) {
 517                     	switch	.text
 518  0145               f_UART3_ClearBuffer:
 522  0145 2004          	jra	L141
 523  0147               L731:
 524                     ; 77         (void)UART3_ReceiveData8(); // Clear any preexisting data
 526  0147 8d000000      	callf	f_UART3_ReceiveData8
 528  014b               L141:
 529                     ; 76     while (UART3_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
 531  014b ae0020        	ldw	x,#32
 532  014e 8d000000      	callf	f_UART3_GetFlagStatus
 534  0152 4d            	tnz	a
 535  0153 26f2          	jrne	L731
 536                     ; 79 }
 539  0155 87            	retf
 603                     ; 81 void UART3_ReceiveString(char *buffer, uint16_t max_length) {
 604                     	switch	.text
 605  0156               f_UART3_ReceiveString:
 607  0156 89            	pushw	x
 608  0157 5203          	subw	sp,#3
 609       00000003      OFST:	set	3
 612                     ; 82 	uint16_t i = 0;
 614                     ; 85 	for (i = 0; i < max_length; i++) {
 616  0159 5f            	clrw	x
 617  015a 1f02          	ldw	(OFST-1,sp),x
 620  015c 200d          	jra	L302
 621  015e               L771:
 622                     ; 86 			buffer[i] = '\0';
 624  015e 1e04          	ldw	x,(OFST+1,sp)
 625  0160 72fb02        	addw	x,(OFST-1,sp)
 626  0163 7f            	clr	(x)
 627                     ; 85 	for (i = 0; i < max_length; i++) {
 629  0164 1e02          	ldw	x,(OFST-1,sp)
 630  0166 1c0001        	addw	x,#1
 631  0169 1f02          	ldw	(OFST-1,sp),x
 633  016b               L302:
 636  016b 1e02          	ldw	x,(OFST-1,sp)
 637  016d 1309          	cpw	x,(OFST+6,sp)
 638  016f 25ed          	jrult	L771
 639                     ; 88 	i = 0;
 641  0171 5f            	clrw	x
 642  0172 1f02          	ldw	(OFST-1,sp),x
 645  0174 202c          	jra	L312
 646  0176               L122:
 647                     ; 92 			while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
 649  0176 ae0020        	ldw	x,#32
 650  0179 8d000000      	callf	f_UART3_GetFlagStatus
 652  017d 4d            	tnz	a
 653  017e 27f6          	jreq	L122
 654                     ; 94 			receivedChar = UART3_ReceiveData8();
 656  0180 8d000000      	callf	f_UART3_ReceiveData8
 658  0184 6b01          	ld	(OFST-2,sp),a
 660                     ; 96 			if (receivedChar == '\n' || receivedChar == '\r') {
 662  0186 7b01          	ld	a,(OFST-2,sp)
 663  0188 a10a          	cp	a,#10
 664  018a 271d          	jreq	L512
 666  018c 7b01          	ld	a,(OFST-2,sp)
 667  018e a10d          	cp	a,#13
 668  0190 2717          	jreq	L512
 669                     ; 99 			buffer[i++] = receivedChar;
 671  0192 7b01          	ld	a,(OFST-2,sp)
 672  0194 1e02          	ldw	x,(OFST-1,sp)
 673  0196 1c0001        	addw	x,#1
 674  0199 1f02          	ldw	(OFST-1,sp),x
 675  019b 1d0001        	subw	x,#1
 677  019e 72fb04        	addw	x,(OFST+1,sp)
 678  01a1 f7            	ld	(x),a
 679  01a2               L312:
 680                     ; 91 	while (i < max_length - 1) {
 682  01a2 1e09          	ldw	x,(OFST+6,sp)
 683  01a4 5a            	decw	x
 684  01a5 1302          	cpw	x,(OFST-1,sp)
 685  01a7 22cd          	jrugt	L122
 686  01a9               L512:
 687                     ; 102 	buffer[i] = '\0'; // Null-terminate the string
 689  01a9 1e04          	ldw	x,(OFST+1,sp)
 690  01ab 72fb02        	addw	x,(OFST-1,sp)
 691  01ae 7f            	clr	(x)
 692                     ; 103 }
 695  01af 5b05          	addw	sp,#5
 696  01b1 87            	retf
 738                     ; 106 uint32_t elapsedTime(uint32_t start, uint32_t end) {
 739                     	switch	.text
 740  01b2               f_elapsedTime:
 742       00000000      OFST:	set	0
 745                     ; 107 	return (end >= start) ? (end - start) : ((0xffffffff - start + 1) + end);
 747  01b2 96            	ldw	x,sp
 748  01b3 1c0008        	addw	x,#OFST+8
 749  01b6 8d000000      	callf	d_ltor
 751  01ba 96            	ldw	x,sp
 752  01bb 1c0004        	addw	x,#OFST+4
 753  01be 8d000000      	callf	d_lcmp
 755  01c2 2512          	jrult	L62
 756  01c4 96            	ldw	x,sp
 757  01c5 1c0008        	addw	x,#OFST+8
 758  01c8 8d000000      	callf	d_ltor
 760  01cc 96            	ldw	x,sp
 761  01cd 1c0004        	addw	x,#OFST+4
 762  01d0 8d000000      	callf	d_lsub
 764  01d4 2014          	jra	L03
 765  01d6               L62:
 766  01d6 96            	ldw	x,sp
 767  01d7 1c0004        	addw	x,#OFST+4
 768  01da 8d000000      	callf	d_ltor
 770  01de 8d000000      	callf	d_lneg
 772  01e2 96            	ldw	x,sp
 773  01e3 1c0008        	addw	x,#OFST+8
 774  01e6 8d000000      	callf	d_ladd
 776  01ea               L03:
 779  01ea 87            	retf
 826                     ; 111 unsigned int read_ADC_Channel(uint8_t channel) {
 827                     	switch	.text
 828  01eb               f_read_ADC_Channel:
 830  01eb 89            	pushw	x
 831       00000002      OFST:	set	2
 834                     ; 112 	unsigned int adcValue = 0;
 836                     ; 113 	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, channel, ADC2_ALIGN_RIGHT);
 838  01ec 4b08          	push	#8
 839  01ee ae0100        	ldw	x,#256
 840  01f1 97            	ld	xl,a
 841  01f2 8d000000      	callf	f_ADC2_ConversionConfig
 843  01f6 84            	pop	a
 844                     ; 114 	ADC2_StartConversion();
 846  01f7 8d000000      	callf	f_ADC2_StartConversion
 849  01fb               L772:
 850                     ; 116 	while (ADC2_GetFlagStatus() == RESET);
 852  01fb 8d000000      	callf	f_ADC2_GetFlagStatus
 854  01ff 4d            	tnz	a
 855  0200 27f9          	jreq	L772
 856                     ; 118 	adcValue = ADC2_GetConversionValue();
 858  0202 8d000000      	callf	f_ADC2_GetConversionValue
 860  0206 1f01          	ldw	(OFST-1,sp),x
 862                     ; 119 	ADC2_ClearFlag();
 864  0208 8d000000      	callf	f_ADC2_ClearFlag
 866                     ; 121 	return adcValue;
 868  020c 1e01          	ldw	x,(OFST-1,sp)
 871  020e 5b02          	addw	sp,#2
 872  0210 87            	retf
 908                     ; 123 void printDateTime(void){
 909                     	switch	.text
 910  0211               f_printDateTime:
 912  0211 520a          	subw	sp,#10
 913       0000000a      OFST:	set	10
 916                     ; 126 	DS3231_GetTime(rtc_buf, 7);
 918  0213 4b07          	push	#7
 919  0215 96            	ldw	x,sp
 920  0216 1c0005        	addw	x,#OFST-5
 921  0219 8d000000      	callf	f_DS3231_GetTime
 923  021d 84            	pop	a
 924                     ; 127 	printf("%02d/%02d/%02d ",
 924                     ; 128 		(rtc_buf[4] >> 4) * 10 + (rtc_buf[4] & 0x0F), // Convert Hours from BCD
 924                     ; 129 		(rtc_buf[5] >> 4) * 10 + (rtc_buf[5] & 0x0F), // Convert Minutes from BCD
 924                     ; 130 		(rtc_buf[6] >> 4) * 10 + (rtc_buf[6] & 0x0F)  // Convert Seconds from BCD
 924                     ; 131 		);
 926  021e 7b0a          	ld	a,(OFST+0,sp)
 927  0220 a40f          	and	a,#15
 928  0222 6b03          	ld	(OFST-7,sp),a
 930  0224 7b0a          	ld	a,(OFST+0,sp)
 931  0226 4e            	swap	a
 932  0227 a40f          	and	a,#15
 933  0229 5f            	clrw	x
 934  022a 97            	ld	xl,a
 935  022b a60a          	ld	a,#10
 936  022d 8d000000      	callf	d_bmulx
 938  0231 01            	rrwa	x,a
 939  0232 1b03          	add	a,(OFST-7,sp)
 940  0234 2401          	jrnc	L63
 941  0236 5c            	incw	x
 942  0237               L63:
 943  0237 02            	rlwa	x,a
 944  0238 89            	pushw	x
 945  0239 01            	rrwa	x,a
 946  023a 7b0b          	ld	a,(OFST+1,sp)
 947  023c a40f          	and	a,#15
 948  023e 6b04          	ld	(OFST-6,sp),a
 950  0240 7b0b          	ld	a,(OFST+1,sp)
 951  0242 4e            	swap	a
 952  0243 a40f          	and	a,#15
 953  0245 5f            	clrw	x
 954  0246 97            	ld	xl,a
 955  0247 a60a          	ld	a,#10
 956  0249 8d000000      	callf	d_bmulx
 958  024d 01            	rrwa	x,a
 959  024e 1b04          	add	a,(OFST-6,sp)
 960  0250 2401          	jrnc	L04
 961  0252 5c            	incw	x
 962  0253               L04:
 963  0253 02            	rlwa	x,a
 964  0254 89            	pushw	x
 965  0255 01            	rrwa	x,a
 966  0256 7b0c          	ld	a,(OFST+2,sp)
 967  0258 a40f          	and	a,#15
 968  025a 6b05          	ld	(OFST-5,sp),a
 970  025c 7b0c          	ld	a,(OFST+2,sp)
 971  025e 4e            	swap	a
 972  025f a40f          	and	a,#15
 973  0261 5f            	clrw	x
 974  0262 97            	ld	xl,a
 975  0263 a60a          	ld	a,#10
 976  0265 8d000000      	callf	d_bmulx
 978  0269 01            	rrwa	x,a
 979  026a 1b05          	add	a,(OFST-5,sp)
 980  026c 2401          	jrnc	L24
 981  026e 5c            	incw	x
 982  026f               L24:
 983  026f 02            	rlwa	x,a
 984  0270 89            	pushw	x
 985  0271 01            	rrwa	x,a
 986  0272 ae002d        	ldw	x,#L123
 987  0275 8d000000      	callf	f_printf
 989  0279 5b06          	addw	sp,#6
 990                     ; 132 	printf("%02d:%02d:%02d",
 990                     ; 133 			(rtc_buf[2] >> 4) * 10 + (rtc_buf[2] & 0x0F), // Convert Hours from BCD
 990                     ; 134 			(rtc_buf[1] >> 4) * 10 + (rtc_buf[1] & 0x0F), // Convert Minutes from BCD
 990                     ; 135 			(rtc_buf[0] >> 4) * 10 + (rtc_buf[0] & 0x0F)  // Convert Seconds from BCD
 990                     ; 136 		);
 992  027b 7b04          	ld	a,(OFST-6,sp)
 993  027d a40f          	and	a,#15
 994  027f 6b03          	ld	(OFST-7,sp),a
 996  0281 7b04          	ld	a,(OFST-6,sp)
 997  0283 4e            	swap	a
 998  0284 a40f          	and	a,#15
 999  0286 5f            	clrw	x
1000  0287 97            	ld	xl,a
1001  0288 a60a          	ld	a,#10
1002  028a 8d000000      	callf	d_bmulx
1004  028e 01            	rrwa	x,a
1005  028f 1b03          	add	a,(OFST-7,sp)
1006  0291 2401          	jrnc	L44
1007  0293 5c            	incw	x
1008  0294               L44:
1009  0294 02            	rlwa	x,a
1010  0295 89            	pushw	x
1011  0296 01            	rrwa	x,a
1012  0297 7b07          	ld	a,(OFST-3,sp)
1013  0299 a40f          	and	a,#15
1014  029b 6b04          	ld	(OFST-6,sp),a
1016  029d 7b07          	ld	a,(OFST-3,sp)
1017  029f 4e            	swap	a
1018  02a0 a40f          	and	a,#15
1019  02a2 5f            	clrw	x
1020  02a3 97            	ld	xl,a
1021  02a4 a60a          	ld	a,#10
1022  02a6 8d000000      	callf	d_bmulx
1024  02aa 01            	rrwa	x,a
1025  02ab 1b04          	add	a,(OFST-6,sp)
1026  02ad 2401          	jrnc	L64
1027  02af 5c            	incw	x
1028  02b0               L64:
1029  02b0 02            	rlwa	x,a
1030  02b1 89            	pushw	x
1031  02b2 01            	rrwa	x,a
1032  02b3 7b0a          	ld	a,(OFST+0,sp)
1033  02b5 a40f          	and	a,#15
1034  02b7 6b05          	ld	(OFST-5,sp),a
1036  02b9 7b0a          	ld	a,(OFST+0,sp)
1037  02bb 4e            	swap	a
1038  02bc a40f          	and	a,#15
1039  02be 5f            	clrw	x
1040  02bf 97            	ld	xl,a
1041  02c0 a60a          	ld	a,#10
1042  02c2 8d000000      	callf	d_bmulx
1044  02c6 01            	rrwa	x,a
1045  02c7 1b05          	add	a,(OFST-5,sp)
1046  02c9 2401          	jrnc	L05
1047  02cb 5c            	incw	x
1048  02cc               L05:
1049  02cc 02            	rlwa	x,a
1050  02cd 89            	pushw	x
1051  02ce 01            	rrwa	x,a
1052  02cf ae001e        	ldw	x,#L323
1053  02d2 8d000000      	callf	f_printf
1055  02d6 5b06          	addw	sp,#6
1056                     ; 137 }
1059  02d8 5b0a          	addw	sp,#10
1060  02da 87            	retf
1106                     ; 139 void sprintDateTime(char *buffer) {
1107                     	switch	.text
1108  02db               f_sprintDateTime:
1110  02db 89            	pushw	x
1111  02dc 520d          	subw	sp,#13
1112       0000000d      OFST:	set	13
1115                     ; 143     DS3231_GetTime(rtc_buf, 7);
1117  02de 4b07          	push	#7
1118  02e0 96            	ldw	x,sp
1119  02e1 1c0008        	addw	x,#OFST-5
1120  02e4 8d000000      	callf	f_DS3231_GetTime
1122  02e8 84            	pop	a
1123                     ; 146     sprintf(buffer, "%02d/%02d/%02d %02d:%02d:%02d",
1123                     ; 147         (rtc_buf[4] >> 4) * 10 + (rtc_buf[4] & 0x0F), // Convert Hours from BCD
1123                     ; 148         (rtc_buf[5] >> 4) * 10 + (rtc_buf[5] & 0x0F), // Convert Minutes from BCD
1123                     ; 149         (rtc_buf[6] >> 4) * 10 + (rtc_buf[6] & 0x0F), // Convert Seconds from BCD
1123                     ; 150         (rtc_buf[2] >> 4) * 10 + (rtc_buf[2] & 0x0F), // Convert Hours from BCD
1123                     ; 151         (rtc_buf[1] >> 4) * 10 + (rtc_buf[1] & 0x0F), // Convert Minutes from BCD
1123                     ; 152         (rtc_buf[0] >> 4) * 10 + (rtc_buf[0] & 0x0F)  // Convert Seconds from BCD
1123                     ; 153     );
1125  02e9 7b07          	ld	a,(OFST-6,sp)
1126  02eb a40f          	and	a,#15
1127  02ed 6b06          	ld	(OFST-7,sp),a
1129  02ef 7b07          	ld	a,(OFST-6,sp)
1130  02f1 4e            	swap	a
1131  02f2 a40f          	and	a,#15
1132  02f4 5f            	clrw	x
1133  02f5 97            	ld	xl,a
1134  02f6 a60a          	ld	a,#10
1135  02f8 8d000000      	callf	d_bmulx
1137  02fc 01            	rrwa	x,a
1138  02fd 1b06          	add	a,(OFST-7,sp)
1139  02ff 2401          	jrnc	L45
1140  0301 5c            	incw	x
1141  0302               L45:
1142  0302 02            	rlwa	x,a
1143  0303 89            	pushw	x
1144  0304 01            	rrwa	x,a
1145  0305 7b0a          	ld	a,(OFST-3,sp)
1146  0307 a40f          	and	a,#15
1147  0309 6b07          	ld	(OFST-6,sp),a
1149  030b 7b0a          	ld	a,(OFST-3,sp)
1150  030d 4e            	swap	a
1151  030e a40f          	and	a,#15
1152  0310 5f            	clrw	x
1153  0311 97            	ld	xl,a
1154  0312 a60a          	ld	a,#10
1155  0314 8d000000      	callf	d_bmulx
1157  0318 01            	rrwa	x,a
1158  0319 1b07          	add	a,(OFST-6,sp)
1159  031b 2401          	jrnc	L65
1160  031d 5c            	incw	x
1161  031e               L65:
1162  031e 02            	rlwa	x,a
1163  031f 89            	pushw	x
1164  0320 01            	rrwa	x,a
1165  0321 7b0d          	ld	a,(OFST+0,sp)
1166  0323 a40f          	and	a,#15
1167  0325 6b08          	ld	(OFST-5,sp),a
1169  0327 7b0d          	ld	a,(OFST+0,sp)
1170  0329 4e            	swap	a
1171  032a a40f          	and	a,#15
1172  032c 5f            	clrw	x
1173  032d 97            	ld	xl,a
1174  032e a60a          	ld	a,#10
1175  0330 8d000000      	callf	d_bmulx
1177  0334 01            	rrwa	x,a
1178  0335 1b08          	add	a,(OFST-5,sp)
1179  0337 2401          	jrnc	L06
1180  0339 5c            	incw	x
1181  033a               L06:
1182  033a 02            	rlwa	x,a
1183  033b 89            	pushw	x
1184  033c 01            	rrwa	x,a
1185  033d 7b13          	ld	a,(OFST+6,sp)
1186  033f a40f          	and	a,#15
1187  0341 6b09          	ld	(OFST-4,sp),a
1189  0343 7b13          	ld	a,(OFST+6,sp)
1190  0345 4e            	swap	a
1191  0346 a40f          	and	a,#15
1192  0348 5f            	clrw	x
1193  0349 97            	ld	xl,a
1194  034a a60a          	ld	a,#10
1195  034c 8d000000      	callf	d_bmulx
1197  0350 01            	rrwa	x,a
1198  0351 1b09          	add	a,(OFST-4,sp)
1199  0353 2401          	jrnc	L26
1200  0355 5c            	incw	x
1201  0356               L26:
1202  0356 02            	rlwa	x,a
1203  0357 89            	pushw	x
1204  0358 01            	rrwa	x,a
1205  0359 7b14          	ld	a,(OFST+7,sp)
1206  035b a40f          	and	a,#15
1207  035d 6b0a          	ld	(OFST-3,sp),a
1209  035f 7b14          	ld	a,(OFST+7,sp)
1210  0361 4e            	swap	a
1211  0362 a40f          	and	a,#15
1212  0364 5f            	clrw	x
1213  0365 97            	ld	xl,a
1214  0366 a60a          	ld	a,#10
1215  0368 8d000000      	callf	d_bmulx
1217  036c 01            	rrwa	x,a
1218  036d 1b0a          	add	a,(OFST-3,sp)
1219  036f 2401          	jrnc	L46
1220  0371 5c            	incw	x
1221  0372               L46:
1222  0372 02            	rlwa	x,a
1223  0373 89            	pushw	x
1224  0374 01            	rrwa	x,a
1225  0375 7b15          	ld	a,(OFST+8,sp)
1226  0377 a40f          	and	a,#15
1227  0379 6b0b          	ld	(OFST-2,sp),a
1229  037b 7b15          	ld	a,(OFST+8,sp)
1230  037d 4e            	swap	a
1231  037e a40f          	and	a,#15
1232  0380 5f            	clrw	x
1233  0381 97            	ld	xl,a
1234  0382 a60a          	ld	a,#10
1235  0384 8d000000      	callf	d_bmulx
1237  0388 01            	rrwa	x,a
1238  0389 1b0b          	add	a,(OFST-2,sp)
1239  038b 2401          	jrnc	L66
1240  038d 5c            	incw	x
1241  038e               L66:
1242  038e 02            	rlwa	x,a
1243  038f 89            	pushw	x
1244  0390 01            	rrwa	x,a
1245  0391 ae0000        	ldw	x,#L743
1246  0394 89            	pushw	x
1247  0395 1e1c          	ldw	x,(OFST+15,sp)
1248  0397 8d000000      	callf	f_sprintf
1250  039b 5b0e          	addw	sp,#14
1251                     ; 154 }
1254  039d 5b0f          	addw	sp,#15
1255  039f 87            	retf
1267                     	xdef	f_sprintDateTime
1268                     	xdef	f_printDateTime
1269                     	xdef	f_read_ADC_Channel
1270                     	xdef	f_elapsedTime
1271                     	xdef	f_UART3_ReceiveString
1272                     	xdef	f_UART3_ClearBuffer
1273                     	xdef	f_GPIO_setup
1274                     	xdef	f_ADC2_setup
1275                     	xdef	f_UART3_setup
1276                     	xdef	f_clock_setup
1277                     	xref	f_DS3231_GetTime
1278                     	xref	f_sprintf
1279                     	xdef	f_putchar
1280                     	xref	f_printf
1281                     	xdef	f_getchar
1282                     	xref	f_UART3_GetFlagStatus
1283                     	xref	f_UART3_SendData8
1284                     	xref	f_UART3_ReceiveData8
1285                     	xref	f_UART3_Cmd
1286                     	xref	f_UART3_Init
1287                     	xref	f_UART3_DeInit
1288                     	xref	f_GPIO_Init
1289                     	xref	f_GPIO_DeInit
1290                     	xref	f_CLK_GetFlagStatus
1291                     	xref	f_CLK_SYSCLKConfig
1292                     	xref	f_CLK_HSIPrescalerConfig
1293                     	xref	f_CLK_ClockSwitchConfig
1294                     	xref	f_CLK_PeripheralClockConfig
1295                     	xref	f_CLK_ClockSwitchCmd
1296                     	xref	f_CLK_LSICmd
1297                     	xref	f_CLK_HSICmd
1298                     	xref	f_CLK_HSECmd
1299                     	xref	f_CLK_DeInit
1300                     	xref	f_ADC2_ClearFlag
1301                     	xref	f_ADC2_GetFlagStatus
1302                     	xref	f_ADC2_GetConversionValue
1303                     	xref	f_ADC2_StartConversion
1304                     	xref	f_ADC2_ConversionConfig
1305                     	xref	f_ADC2_Cmd
1306                     	xref	f_ADC2_Init
1307                     	xref	f_ADC2_DeInit
1308                     .const:	section	.text
1309  0000               L743:
1310  0000 253032642f25  	dc.b	"%02d/%02d/%02d %02"
1311  0012 643a25303264  	dc.b	"d:%02d:%02d",0
1312  001e               L323:
1313  001e 253032643a25  	dc.b	"%02d:%02d:%02d",0
1314  002d               L123:
1315  002d 253032642f25  	dc.b	"%02d/%02d/%02d ",0
1316                     	xref.b	c_x
1336                     	xref	d_bmulx
1337                     	xref	d_ladd
1338                     	xref	d_lneg
1339                     	xref	d_lsub
1340                     	xref	d_lcmp
1341                     	xref	d_ltor
1342                     	end
