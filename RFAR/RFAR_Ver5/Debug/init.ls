   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  55                     ; 4 void clock_setup(void) {
  56                     	switch	.text
  57  0000               f_clock_setup:
  61                     ; 5 	CLK_DeInit();
  63  0000 8d000000      	callf	f_CLK_DeInit
  65                     ; 6 	CLK_HSECmd(DISABLE);
  67  0004 4f            	clr	a
  68  0005 8d000000      	callf	f_CLK_HSECmd
  70                     ; 7 	CLK_LSICmd(DISABLE);
  72  0009 4f            	clr	a
  73  000a 8d000000      	callf	f_CLK_LSICmd
  75                     ; 8 	CLK_HSICmd(ENABLE);
  77  000e a601          	ld	a,#1
  78  0010 8d000000      	callf	f_CLK_HSICmd
  81  0014               L32:
  82                     ; 9 	while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
  84  0014 ae0102        	ldw	x,#258
  85  0017 8d000000      	callf	f_CLK_GetFlagStatus
  87  001b 4d            	tnz	a
  88  001c 27f6          	jreq	L32
  89                     ; 12 	CLK_ClockSwitchCmd(ENABLE);
  91  001e a601          	ld	a,#1
  92  0020 8d000000      	callf	f_CLK_ClockSwitchCmd
  94                     ; 13 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  96  0024 4f            	clr	a
  97  0025 8d000000      	callf	f_CLK_HSIPrescalerConfig
  99                     ; 14 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 101  0029 a680          	ld	a,#128
 102  002b 8d000000      	callf	f_CLK_SYSCLKConfig
 104                     ; 15 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 106  002f 4b01          	push	#1
 107  0031 4b00          	push	#0
 108  0033 ae01e1        	ldw	x,#481
 109  0036 8d000000      	callf	f_CLK_ClockSwitchConfig
 111  003a 85            	popw	x
 112                     ; 19 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 114  003b ae0301        	ldw	x,#769
 116                     ; 20 }
 119  003e ac000000      	jpf	f_CLK_PeripheralClockConfig
 143                     ; 23 void GPIO_setup(void) {
 144                     	switch	.text
 145  0042               f_GPIO_setup:
 149                     ; 24 	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
 151  0042 ae500a        	ldw	x,#20490
 152  0045 8d000000      	callf	f_GPIO_DeInit
 154                     ; 25 	GPIO_DeInit(GPIOA);     // Reset GPIO settings for port C
 156  0049 ae5000        	ldw	x,#20480
 157  004c 8d000000      	callf	f_GPIO_DeInit
 159                     ; 26 	GPIO_DeInit(GPIOB);     // Reset GPIO settings for port C
 161  0050 ae5005        	ldw	x,#20485
 162  0053 8d000000      	callf	f_GPIO_DeInit
 164                     ; 27 	GPIO_DeInit(GPIOD);     // Reset GPIO settings for port C
 166  0057 ae500f        	ldw	x,#20495
 167  005a 8d000000      	callf	f_GPIO_DeInit
 169                     ; 28 	GPIO_DeInit(GPIOE);     // Reset GPIO settings for port C
 171  005e ae5014        	ldw	x,#20500
 172  0061 8d000000      	callf	f_GPIO_DeInit
 174                     ; 29 	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_IN_FL_NO_IT);
 176  0065 4b00          	push	#0
 177  0067 4b20          	push	#32
 178  0069 ae5005        	ldw	x,#20485
 179  006c 8d000000      	callf	f_GPIO_Init
 181  0070 85            	popw	x
 182                     ; 30 	GPIO_Init(GPIOB, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 184  0071 4b00          	push	#0
 185  0073 4b40          	push	#64
 186  0075 ae5005        	ldw	x,#20485
 187  0078 8d000000      	callf	f_GPIO_Init
 189  007c 85            	popw	x
 190                     ; 31 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 192  007d 4be0          	push	#224
 193  007f 4b08          	push	#8
 194  0081 ae500a        	ldw	x,#20490
 195  0084 8d000000      	callf	f_GPIO_Init
 197  0088 85            	popw	x
 198                     ; 32 	GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 200  0089 4be0          	push	#224
 201  008b 4b10          	push	#16
 202  008d ae500a        	ldw	x,#20490
 203  0090 8d000000      	callf	f_GPIO_Init
 205  0094 85            	popw	x
 206                     ; 33 	GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 208  0095 4be0          	push	#224
 209  0097 4b04          	push	#4
 210  0099 ae500a        	ldw	x,#20490
 211  009c 8d000000      	callf	f_GPIO_Init
 213  00a0 85            	popw	x
 214                     ; 34 	GPIO_Init(GPIOE, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 216  00a1 4be0          	push	#224
 217  00a3 4b08          	push	#8
 218  00a5 ae5014        	ldw	x,#20500
 219  00a8 8d000000      	callf	f_GPIO_Init
 221  00ac 85            	popw	x
 222                     ; 35 	GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 224  00ad 4be0          	push	#224
 225  00af 4b01          	push	#1
 226  00b1 ae500f        	ldw	x,#20495
 227  00b4 8d000000      	callf	f_GPIO_Init
 229  00b8 85            	popw	x
 230                     ; 36 	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 232  00b9 4be0          	push	#224
 233  00bb 4b08          	push	#8
 234  00bd ae500f        	ldw	x,#20495
 235  00c0 8d000000      	callf	f_GPIO_Init
 237  00c4 85            	popw	x
 238                     ; 37 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 240  00c5 4be0          	push	#224
 241  00c7 4b08          	push	#8
 242  00c9 ae5000        	ldw	x,#20480
 243  00cc 8d000000      	callf	f_GPIO_Init
 245  00d0 85            	popw	x
 246                     ; 38 }
 249  00d1 87            	retf	
 274                     ; 41 void UART3_setup(void) {
 275                     	switch	.text
 276  00d2               f_UART3_setup:
 280                     ; 42 	UART3_DeInit();
 282  00d2 8d000000      	callf	f_UART3_DeInit
 284                     ; 43 	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TXRX_ENABLE);
 286  00d6 4b0c          	push	#12
 287  00d8 4b00          	push	#0
 288  00da 4b00          	push	#0
 289  00dc 4b00          	push	#0
 290  00de ae2580        	ldw	x,#9600
 291  00e1 89            	pushw	x
 292  00e2 5f            	clrw	x
 293  00e3 89            	pushw	x
 294  00e4 8d000000      	callf	f_UART3_Init
 296  00e8 5b08          	addw	sp,#8
 297                     ; 44 	UART3_Cmd(ENABLE);
 299  00ea a601          	ld	a,#1
 301                     ; 45 }
 304  00ec ac000000      	jpf	f_UART3_Cmd
 330                     ; 48 void ADC2_setup(void) {
 331                     	switch	.text
 332  00f0               f_ADC2_setup:
 336                     ; 49 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 338  00f0 ae1301        	ldw	x,#4865
 339  00f3 8d000000      	callf	f_CLK_PeripheralClockConfig
 341                     ; 50 	ADC2_DeInit();
 343  00f7 8d000000      	callf	f_ADC2_DeInit
 345                     ; 52 	ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
 345                     ; 53 						ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6, DISABLE);
 347  00fb 4b00          	push	#0
 348  00fd 4b07          	push	#7
 349  00ff 4b08          	push	#8
 350  0101 4b00          	push	#0
 351  0103 4b01          	push	#1
 352  0105 4b00          	push	#0
 353  0107 ae0105        	ldw	x,#261
 354  010a 8d000000      	callf	f_ADC2_Init
 356  010e 5b06          	addw	sp,#6
 357                     ; 55 	ADC2_Cmd(ENABLE);
 359  0110 a601          	ld	a,#1
 361                     ; 56 }
 364  0112 ac000000      	jpf	f_ADC2_Cmd
 399                     ; 59 PUTCHAR_PROTOTYPE {
 400                     	switch	.text
 401  0116               f_putchar:
 403  0116 88            	push	a
 404       00000000      OFST:	set	0
 407                     ; 60 	UART3_SendData8(c);
 409  0117 8d000000      	callf	f_UART3_SendData8
 412  011b               L77:
 413                     ; 61 	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
 415  011b ae0080        	ldw	x,#128
 416  011e 8d000000      	callf	f_UART3_GetFlagStatus
 418  0122 4d            	tnz	a
 419  0123 27f6          	jreq	L77
 420                     ; 62 	return c;
 422  0125 7b01          	ld	a,(OFST+1,sp)
 425  0127 5b01          	addw	sp,#1
 426  0129 87            	retf	
 461                     ; 65 GETCHAR_PROTOTYPE
 461                     ; 66 {
 462                     	switch	.text
 463  012a               f_getchar:
 465  012a 88            	push	a
 466       00000001      OFST:	set	1
 469                     ; 67   char c = 0;
 472  012b               L321:
 473                     ; 69   while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
 475  012b ae0020        	ldw	x,#32
 476  012e 8d000000      	callf	f_UART3_GetFlagStatus
 478  0132 4d            	tnz	a
 479  0133 27f6          	jreq	L321
 480                     ; 70 	c = UART3_ReceiveData8();
 482  0135 8d000000      	callf	f_UART3_ReceiveData8
 485                     ; 71   return (c);
 489  0139 5b01          	addw	sp,#1
 490  013b 87            	retf	
 514                     ; 75 void UART3_ClearBuffer(void) {
 515                     	switch	.text
 516  013c               f_UART3_ClearBuffer:
 520  013c 2004          	jra	L141
 521  013e               L731:
 522                     ; 77         (void)UART3_ReceiveData8(); // Clear any preexisting data
 524  013e 8d000000      	callf	f_UART3_ReceiveData8
 526  0142               L141:
 527                     ; 76     while (UART3_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
 529  0142 ae0020        	ldw	x,#32
 530  0145 8d000000      	callf	f_UART3_GetFlagStatus
 532  0149 4d            	tnz	a
 533  014a 26f2          	jrne	L731
 534                     ; 79 }
 537  014c 87            	retf	
 601                     ; 81 void UART3_ReceiveString(char *buffer, uint16_t max_length) {
 602                     	switch	.text
 603  014d               f_UART3_ReceiveString:
 605  014d 89            	pushw	x
 606  014e 5203          	subw	sp,#3
 607       00000003      OFST:	set	3
 610                     ; 82 	uint16_t i = 0;
 612                     ; 85 	for (i = 0; i < max_length; i++) {
 614  0150 5f            	clrw	x
 616  0151 2009          	jra	L302
 617  0153               L771:
 618                     ; 86 			buffer[i] = '\0';
 620  0153 1e04          	ldw	x,(OFST+1,sp)
 621  0155 72fb02        	addw	x,(OFST-1,sp)
 622  0158 7f            	clr	(x)
 623                     ; 85 	for (i = 0; i < max_length; i++) {
 625  0159 1e02          	ldw	x,(OFST-1,sp)
 626  015b 5c            	incw	x
 627  015c               L302:
 628  015c 1f02          	ldw	(OFST-1,sp),x
 632  015e 1309          	cpw	x,(OFST+6,sp)
 633  0160 25f1          	jrult	L771
 634                     ; 88 	i = 0;
 636  0162 5f            	clrw	x
 637  0163 1f02          	ldw	(OFST-1,sp),x
 640  0165 2022          	jra	L312
 641  0167               L122:
 642                     ; 92 			while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
 644  0167 ae0020        	ldw	x,#32
 645  016a 8d000000      	callf	f_UART3_GetFlagStatus
 647  016e 4d            	tnz	a
 648  016f 27f6          	jreq	L122
 649                     ; 94 			receivedChar = UART3_ReceiveData8();
 651  0171 8d000000      	callf	f_UART3_ReceiveData8
 653  0175 6b01          	ld	(OFST-2,sp),a
 655                     ; 96 			if (receivedChar == '\n' || receivedChar == '\r') {
 657  0177 a10a          	cp	a,#10
 658  0179 2715          	jreq	L512
 660  017b a10d          	cp	a,#13
 661  017d 2711          	jreq	L512
 662                     ; 99 			buffer[i++] = receivedChar;
 664  017f 1e02          	ldw	x,(OFST-1,sp)
 665  0181 5c            	incw	x
 666  0182 1f02          	ldw	(OFST-1,sp),x
 667  0184 5a            	decw	x
 669  0185 72fb04        	addw	x,(OFST+1,sp)
 670  0188 f7            	ld	(x),a
 671  0189               L312:
 672                     ; 91 	while (i < max_length - 1) {
 674  0189 1e09          	ldw	x,(OFST+6,sp)
 675  018b 5a            	decw	x
 676  018c 1302          	cpw	x,(OFST-1,sp)
 677  018e 22d7          	jrugt	L122
 678  0190               L512:
 679                     ; 102 	buffer[i] = '\0'; // Null-terminate the string
 681  0190 1e04          	ldw	x,(OFST+1,sp)
 682  0192 72fb02        	addw	x,(OFST-1,sp)
 683  0195 7f            	clr	(x)
 684                     ; 103 }
 687  0196 5b05          	addw	sp,#5
 688  0198 87            	retf	
 730                     ; 106 uint32_t elapsedTime(uint32_t start, uint32_t end) {
 731                     	switch	.text
 732  0199               f_elapsedTime:
 734       00000000      OFST:	set	0
 737                     ; 107 	return (end >= start) ? (end - start) : ((0xffffffff - start + 1) + end);
 739  0199 96            	ldw	x,sp
 740  019a 1c0008        	addw	x,#OFST+8
 741  019d 8d000000      	callf	d_ltor
 743  01a1 96            	ldw	x,sp
 744  01a2 1c0004        	addw	x,#OFST+4
 745  01a5 8d000000      	callf	d_lcmp
 747  01a9 96            	ldw	x,sp
 748  01aa 250f          	jrult	L441
 749  01ac 1c0008        	addw	x,#OFST+8
 750  01af 8d000000      	callf	d_ltor
 752  01b3 96            	ldw	x,sp
 753  01b4 1c0004        	addw	x,#OFST+4
 756  01b7 ac000000      	jpf	d_lsub
 757  01bb               L441:
 758  01bb 1c0004        	addw	x,#OFST+4
 759  01be 8d000000      	callf	d_ltor
 761  01c2 8d000000      	callf	d_lneg
 763  01c6 96            	ldw	x,sp
 764  01c7 1c0008        	addw	x,#OFST+8
 768  01ca ac000000      	jpf	d_ladd
 815                     ; 111 unsigned int read_ADC_Channel(uint8_t channel) {
 816                     	switch	.text
 817  01ce               f_read_ADC_Channel:
 819  01ce 89            	pushw	x
 820       00000002      OFST:	set	2
 823                     ; 112 	unsigned int adcValue = 0;
 825                     ; 113 	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, channel, ADC2_ALIGN_RIGHT);
 827  01cf 4b08          	push	#8
 828  01d1 ae0100        	ldw	x,#256
 829  01d4 97            	ld	xl,a
 830  01d5 8d000000      	callf	f_ADC2_ConversionConfig
 832  01d9 84            	pop	a
 833                     ; 114 	ADC2_StartConversion();
 835  01da 8d000000      	callf	f_ADC2_StartConversion
 838  01de               L772:
 839                     ; 116 	while (ADC2_GetFlagStatus() == RESET);
 841  01de 8d000000      	callf	f_ADC2_GetFlagStatus
 843  01e2 4d            	tnz	a
 844  01e3 27f9          	jreq	L772
 845                     ; 118 	adcValue = ADC2_GetConversionValue();
 847  01e5 8d000000      	callf	f_ADC2_GetConversionValue
 849  01e9 1f01          	ldw	(OFST-1,sp),x
 851                     ; 119 	ADC2_ClearFlag();
 853  01eb 8d000000      	callf	f_ADC2_ClearFlag
 855                     ; 121 	return adcValue;
 857  01ef 1e01          	ldw	x,(OFST-1,sp)
 860  01f1 5b02          	addw	sp,#2
 861  01f3 87            	retf	
 897                     ; 124 void printDateTime(void){
 898                     	switch	.text
 899  01f4               f_printDateTime:
 901  01f4 520a          	subw	sp,#10
 902       0000000a      OFST:	set	10
 905                     ; 127 	DS3231_GetTime(rtc_buf, 7);
 907  01f6 4b07          	push	#7
 908  01f8 96            	ldw	x,sp
 909  01f9 1c0005        	addw	x,#OFST-5
 910  01fc 8d000000      	callf	f_DS3231_GetTime
 912  0200 84            	pop	a
 913                     ; 128 	printf("%02d/%02d/%02d ",
 913                     ; 129 		(rtc_buf[4] >> 4) * 10 + (rtc_buf[4] & 0x0F), // Convert Hours from BCD
 913                     ; 130 		(rtc_buf[5] >> 4) * 10 + (rtc_buf[5] & 0x0F), // Convert Minutes from BCD
 913                     ; 131 		(rtc_buf[6] >> 4) * 10 + (rtc_buf[6] & 0x0F)  // Convert Seconds from BCD
 913                     ; 132 		);
 915  0201 7b0a          	ld	a,(OFST+0,sp)
 916  0203 a40f          	and	a,#15
 917  0205 6b03          	ld	(OFST-7,sp),a
 919  0207 7b0a          	ld	a,(OFST+0,sp)
 920  0209 4e            	swap	a
 921  020a a40f          	and	a,#15
 922  020c 5f            	clrw	x
 923  020d 97            	ld	xl,a
 924  020e a60a          	ld	a,#10
 925  0210 8d000000      	callf	d_bmulx
 927  0214 01            	rrwa	x,a
 928  0215 1b03          	add	a,(OFST-7,sp)
 929  0217 2401          	jrnc	L271
 930  0219 5c            	incw	x
 931  021a               L271:
 932  021a 02            	rlwa	x,a
 933  021b 89            	pushw	x
 934  021c 7b0b          	ld	a,(OFST+1,sp)
 935  021e a40f          	and	a,#15
 936  0220 6b04          	ld	(OFST-6,sp),a
 938  0222 7b0b          	ld	a,(OFST+1,sp)
 939  0224 4e            	swap	a
 940  0225 a40f          	and	a,#15
 941  0227 5f            	clrw	x
 942  0228 97            	ld	xl,a
 943  0229 a60a          	ld	a,#10
 944  022b 8d000000      	callf	d_bmulx
 946  022f 01            	rrwa	x,a
 947  0230 1b04          	add	a,(OFST-6,sp)
 948  0232 2401          	jrnc	L471
 949  0234 5c            	incw	x
 950  0235               L471:
 951  0235 02            	rlwa	x,a
 952  0236 89            	pushw	x
 953  0237 7b0c          	ld	a,(OFST+2,sp)
 954  0239 a40f          	and	a,#15
 955  023b 6b05          	ld	(OFST-5,sp),a
 957  023d 7b0c          	ld	a,(OFST+2,sp)
 958  023f 4e            	swap	a
 959  0240 a40f          	and	a,#15
 960  0242 5f            	clrw	x
 961  0243 97            	ld	xl,a
 962  0244 a60a          	ld	a,#10
 963  0246 8d000000      	callf	d_bmulx
 965  024a 01            	rrwa	x,a
 966  024b 1b05          	add	a,(OFST-5,sp)
 967  024d 2401          	jrnc	L671
 968  024f 5c            	incw	x
 969  0250               L671:
 970  0250 02            	rlwa	x,a
 971  0251 89            	pushw	x
 972  0252 ae000f        	ldw	x,#L123
 973  0255 8d000000      	callf	f_printf
 975  0259 5b06          	addw	sp,#6
 976                     ; 133 		printf("%02d:%02d:%02d",
 976                     ; 134 			(rtc_buf[2] >> 4) * 10 + (rtc_buf[2] & 0x0F), // Convert Hours from BCD
 976                     ; 135 			(rtc_buf[1] >> 4) * 10 + (rtc_buf[1] & 0x0F), // Convert Minutes from BCD
 976                     ; 136 			(rtc_buf[0] >> 4) * 10 + (rtc_buf[0] & 0x0F)  // Convert Seconds from BCD
 976                     ; 137 		);
 978  025b 7b04          	ld	a,(OFST-6,sp)
 979  025d a40f          	and	a,#15
 980  025f 6b03          	ld	(OFST-7,sp),a
 982  0261 7b04          	ld	a,(OFST-6,sp)
 983  0263 4e            	swap	a
 984  0264 a40f          	and	a,#15
 985  0266 5f            	clrw	x
 986  0267 97            	ld	xl,a
 987  0268 a60a          	ld	a,#10
 988  026a 8d000000      	callf	d_bmulx
 990  026e 01            	rrwa	x,a
 991  026f 1b03          	add	a,(OFST-7,sp)
 992  0271 2401          	jrnc	L202
 993  0273 5c            	incw	x
 994  0274               L202:
 995  0274 02            	rlwa	x,a
 996  0275 89            	pushw	x
 997  0276 7b07          	ld	a,(OFST-3,sp)
 998  0278 a40f          	and	a,#15
 999  027a 6b04          	ld	(OFST-6,sp),a
1001  027c 7b07          	ld	a,(OFST-3,sp)
1002  027e 4e            	swap	a
1003  027f a40f          	and	a,#15
1004  0281 5f            	clrw	x
1005  0282 97            	ld	xl,a
1006  0283 a60a          	ld	a,#10
1007  0285 8d000000      	callf	d_bmulx
1009  0289 01            	rrwa	x,a
1010  028a 1b04          	add	a,(OFST-6,sp)
1011  028c 2401          	jrnc	L402
1012  028e 5c            	incw	x
1013  028f               L402:
1014  028f 02            	rlwa	x,a
1015  0290 89            	pushw	x
1016  0291 7b0a          	ld	a,(OFST+0,sp)
1017  0293 a40f          	and	a,#15
1018  0295 6b05          	ld	(OFST-5,sp),a
1020  0297 7b0a          	ld	a,(OFST+0,sp)
1021  0299 4e            	swap	a
1022  029a a40f          	and	a,#15
1023  029c 5f            	clrw	x
1024  029d 97            	ld	xl,a
1025  029e a60a          	ld	a,#10
1026  02a0 8d000000      	callf	d_bmulx
1028  02a4 01            	rrwa	x,a
1029  02a5 1b05          	add	a,(OFST-5,sp)
1030  02a7 2401          	jrnc	L602
1031  02a9 5c            	incw	x
1032  02aa               L602:
1033  02aa 02            	rlwa	x,a
1034  02ab 89            	pushw	x
1035  02ac ae0000        	ldw	x,#L323
1036  02af 8d000000      	callf	f_printf
1038  02b3 5b10          	addw	sp,#16
1039                     ; 138 }
1042  02b5 87            	retf	
1054                     	xdef	f_printDateTime
1055                     	xdef	f_read_ADC_Channel
1056                     	xdef	f_elapsedTime
1057                     	xdef	f_UART3_ReceiveString
1058                     	xdef	f_UART3_ClearBuffer
1059                     	xdef	f_GPIO_setup
1060                     	xdef	f_ADC2_setup
1061                     	xdef	f_UART3_setup
1062                     	xdef	f_clock_setup
1063                     	xref	f_DS3231_GetTime
1064                     	xdef	f_putchar
1065                     	xref	f_printf
1066                     	xdef	f_getchar
1067                     	xref	f_UART3_GetFlagStatus
1068                     	xref	f_UART3_SendData8
1069                     	xref	f_UART3_ReceiveData8
1070                     	xref	f_UART3_Cmd
1071                     	xref	f_UART3_Init
1072                     	xref	f_UART3_DeInit
1073                     	xref	f_GPIO_Init
1074                     	xref	f_GPIO_DeInit
1075                     	xref	f_CLK_GetFlagStatus
1076                     	xref	f_CLK_SYSCLKConfig
1077                     	xref	f_CLK_HSIPrescalerConfig
1078                     	xref	f_CLK_ClockSwitchConfig
1079                     	xref	f_CLK_PeripheralClockConfig
1080                     	xref	f_CLK_ClockSwitchCmd
1081                     	xref	f_CLK_LSICmd
1082                     	xref	f_CLK_HSICmd
1083                     	xref	f_CLK_HSECmd
1084                     	xref	f_CLK_DeInit
1085                     	xref	f_ADC2_ClearFlag
1086                     	xref	f_ADC2_GetFlagStatus
1087                     	xref	f_ADC2_GetConversionValue
1088                     	xref	f_ADC2_StartConversion
1089                     	xref	f_ADC2_ConversionConfig
1090                     	xref	f_ADC2_Cmd
1091                     	xref	f_ADC2_Init
1092                     	xref	f_ADC2_DeInit
1093                     .const:	section	.text
1094  0000               L323:
1095  0000 253032643a25  	dc.b	"%02d:%02d:%02d",0
1096  000f               L123:
1097  000f 253032642f25  	dc.b	"%02d/%02d/%02d ",0
1098                     	xref.b	c_x
1118                     	xref	d_bmulx
1119                     	xref	d_ladd
1120                     	xref	d_lneg
1121                     	xref	d_lsub
1122                     	xref	d_lcmp
1123                     	xref	d_ltor
1124                     	end
