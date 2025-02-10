   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _sine1_frequency:
  16  0000 00000000      	dc.w	0,0
  17  0004               _sine1_amplitude:
  18  0004 00000000      	dc.w	0,0
  19  0008               _lastEdgeTime:
  20  0008 00000000      	dc.l	0
  21  000c               _currentEdgeTime:
  22  000c 00000000      	dc.l	0
  23  0010               _crossingType:
  24  0010 ffff          	dc.w	-1
  25  0012               _count:
  26  0012 0000          	dc.w	0
  89                     ; 56 void main() {
  90                     	switch	.text
  91  0000               f_main:
  93  0000 520a          	subw	sp,#10
  94       0000000a      OFST:	set	10
  97                     ; 57 	float frequency = 0.0, amplitude = 0.0;
  99  0002 ce10b5        	ldw	x,L34+2
 100  0005 1f03          	ldw	(OFST-7,sp),x
 101  0007 ce10b3        	ldw	x,L34
 102  000a 1f01          	ldw	(OFST-9,sp),x
 106  000c ce10b5        	ldw	x,L34+2
 107  000f 1f09          	ldw	(OFST-1,sp),x
 108  0011 ce10b3        	ldw	x,L34
 109  0014 1f07          	ldw	(OFST-3,sp),x
 111                     ; 58 	unsigned int adcValue = 0;
 113                     ; 59 	initialize_system();
 115  0016 8d730073      	callf	f_initialize_system
 117  001a               L74:
 118                     ; 62 		adcValue = read_ADC_Channel(FDR_SIGNAL);
 120  001a a606          	ld	a,#6
 121  001c 8d4a024a      	callf	f_read_ADC_Channel
 123  0020 1f05          	ldw	(OFST-5,sp),x
 125                     ; 63 		amplitude = convert_adc_to_voltage(adcValue);
 127  0022 1e05          	ldw	x,(OFST-5,sp)
 128  0024 8d250725      	callf	f_convert_adc_to_voltage
 130  0028 96            	ldw	x,sp
 131  0029 1c0007        	addw	x,#OFST-3
 132  002c 8d000000      	callf	d_rtol
 135                     ; 64 		printf("ADC Vaue: %u, Voltage: %.3f\n", adcValue, amplitude);
 137  0030 1e09          	ldw	x,(OFST-1,sp)
 138  0032 89            	pushw	x
 139  0033 1e09          	ldw	x,(OFST-1,sp)
 140  0035 89            	pushw	x
 141  0036 1e09          	ldw	x,(OFST-1,sp)
 142  0038 89            	pushw	x
 143  0039 ae1096        	ldw	x,#L35
 144  003c 8d000000      	callf	f_printf
 146  0040 5b06          	addw	sp,#6
 147                     ; 65 		amplitude = process_adc_signal(FDR_SIGNAL, &frequency, &amplitude);
 149  0042 96            	ldw	x,sp
 150  0043 1c0007        	addw	x,#OFST-3
 151  0046 89            	pushw	x
 152  0047 96            	ldw	x,sp
 153  0048 1c0003        	addw	x,#OFST-7
 154  004b 89            	pushw	x
 155  004c a606          	ld	a,#6
 156  004e 8d480448      	callf	f_process_adc_signal
 158  0052 5b04          	addw	sp,#4
 159  0054 96            	ldw	x,sp
 160  0055 1c0007        	addw	x,#OFST-3
 161  0058 8d000000      	callf	d_rtol
 164                     ; 66 		printf("frequency; %.3f, amplitude: %.3f\n\r", frequency, amplitude);
 166  005c 1e09          	ldw	x,(OFST-1,sp)
 167  005e 89            	pushw	x
 168  005f 1e09          	ldw	x,(OFST-1,sp)
 169  0061 89            	pushw	x
 170  0062 1e07          	ldw	x,(OFST-3,sp)
 171  0064 89            	pushw	x
 172  0065 1e07          	ldw	x,(OFST-3,sp)
 173  0067 89            	pushw	x
 174  0068 ae1073        	ldw	x,#L55
 175  006b 8d000000      	callf	f_printf
 177  006f 5b08          	addw	sp,#8
 179  0071 20a7          	jra	L74
 209                     ; 75 void initialize_system(void) {
 210                     	switch	.text
 211  0073               f_initialize_system:
 215                     ; 76 	clock_setup();          // Configure system clock
 217  0073 8da200a2      	callf	f_clock_setup
 219                     ; 77 	TIM4_Config();	// Timer 4 config for delay
 221  0077 8d000000      	callf	f_TIM4_Config
 223                     ; 78 	GPIO_setup();
 225  007b 8de500e5      	callf	f_GPIO_setup
 227                     ; 79 	UART3_setup();          // Setup UART communication
 229  007f 8dc901c9      	callf	f_UART3_setup
 231                     ; 80 	ADC2_setup();           // Setup ADC
 233  0083 8dea01ea      	callf	f_ADC2_setup
 235                     ; 81 	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
 237  0087 ae500a        	ldw	x,#20490
 238  008a 8d000000      	callf	f_GPIO_DeInit
 240                     ; 82 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 242  008e 4be0          	push	#224
 243  0090 4b08          	push	#8
 244  0092 ae500a        	ldw	x,#20490
 245  0095 8d000000      	callf	f_GPIO_Init
 247  0099 85            	popw	x
 248                     ; 83 	printf("System Initialization Completed\n\r");
 250  009a ae1051        	ldw	x,#L76
 251  009d 8d000000      	callf	f_printf
 253                     ; 84 }
 256  00a1 87            	retf
 288                     ; 87 void clock_setup(void) {
 289                     	switch	.text
 290  00a2               f_clock_setup:
 294                     ; 88 	CLK_DeInit();
 296  00a2 8d000000      	callf	f_CLK_DeInit
 298                     ; 89 	CLK_HSECmd(DISABLE);
 300  00a6 4f            	clr	a
 301  00a7 8d000000      	callf	f_CLK_HSECmd
 303                     ; 90 	CLK_LSICmd(DISABLE);
 305  00ab 4f            	clr	a
 306  00ac 8d000000      	callf	f_CLK_LSICmd
 308                     ; 91 	CLK_HSICmd(ENABLE);
 310  00b0 a601          	ld	a,#1
 311  00b2 8d000000      	callf	f_CLK_HSICmd
 314  00b6               L301:
 315                     ; 92 	while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 317  00b6 ae0102        	ldw	x,#258
 318  00b9 8d000000      	callf	f_CLK_GetFlagStatus
 320  00bd 4d            	tnz	a
 321  00be 27f6          	jreq	L301
 322                     ; 95 	CLK_ClockSwitchCmd(ENABLE);
 324  00c0 a601          	ld	a,#1
 325  00c2 8d000000      	callf	f_CLK_ClockSwitchCmd
 327                     ; 96 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 329  00c6 4f            	clr	a
 330  00c7 8d000000      	callf	f_CLK_HSIPrescalerConfig
 332                     ; 97 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 334  00cb a680          	ld	a,#128
 335  00cd 8d000000      	callf	f_CLK_SYSCLKConfig
 337                     ; 98 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 339  00d1 4b01          	push	#1
 340  00d3 4b00          	push	#0
 341  00d5 ae01e1        	ldw	x,#481
 342  00d8 8d000000      	callf	f_CLK_ClockSwitchConfig
 344  00dc 85            	popw	x
 345                     ; 102 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 347  00dd ae0301        	ldw	x,#769
 348  00e0 8d000000      	callf	f_CLK_PeripheralClockConfig
 350                     ; 103 }
 353  00e4 87            	retf
 377                     ; 105 void GPIO_setup(void) {
 378                     	switch	.text
 379  00e5               f_GPIO_setup:
 383                     ; 106 	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
 385  00e5 ae500a        	ldw	x,#20490
 386  00e8 8d000000      	callf	f_GPIO_DeInit
 388                     ; 107 	GPIO_DeInit(GPIOA);     // Reset GPIO settings for port C
 390  00ec ae5000        	ldw	x,#20480
 391  00ef 8d000000      	callf	f_GPIO_DeInit
 393                     ; 108 	GPIO_DeInit(GPIOB);     // Reset GPIO settings for port C
 395  00f3 ae5005        	ldw	x,#20485
 396  00f6 8d000000      	callf	f_GPIO_DeInit
 398                     ; 109 	GPIO_DeInit(GPIOD);     // Reset GPIO settings for port C
 400  00fa ae500f        	ldw	x,#20495
 401  00fd 8d000000      	callf	f_GPIO_DeInit
 403                     ; 110 	GPIO_DeInit(GPIOE);     // Reset GPIO settings for port C
 405  0101 ae5014        	ldw	x,#20500
 406  0104 8d000000      	callf	f_GPIO_DeInit
 408                     ; 111 	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_IN_FL_NO_IT);
 410  0108 4b00          	push	#0
 411  010a 4b20          	push	#32
 412  010c ae5005        	ldw	x,#20485
 413  010f 8d000000      	callf	f_GPIO_Init
 415  0113 85            	popw	x
 416                     ; 112 	GPIO_Init(GPIOB, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 418  0114 4b00          	push	#0
 419  0116 4b40          	push	#64
 420  0118 ae5005        	ldw	x,#20485
 421  011b 8d000000      	callf	f_GPIO_Init
 423  011f 85            	popw	x
 424                     ; 113 	GPIO_Init(GPIOA, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 426  0120 4b00          	push	#0
 427  0122 4b40          	push	#64
 428  0124 ae5000        	ldw	x,#20480
 429  0127 8d000000      	callf	f_GPIO_Init
 431  012b 85            	popw	x
 432                     ; 114 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 434  012c 4be0          	push	#224
 435  012e 4b08          	push	#8
 436  0130 ae500a        	ldw	x,#20490
 437  0133 8d000000      	callf	f_GPIO_Init
 439  0137 85            	popw	x
 440                     ; 115 	GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 442  0138 4be0          	push	#224
 443  013a 4b10          	push	#16
 444  013c ae500a        	ldw	x,#20490
 445  013f 8d000000      	callf	f_GPIO_Init
 447  0143 85            	popw	x
 448                     ; 116 	GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 450  0144 4be0          	push	#224
 451  0146 4b04          	push	#4
 452  0148 ae500a        	ldw	x,#20490
 453  014b 8d000000      	callf	f_GPIO_Init
 455  014f 85            	popw	x
 456                     ; 117 	GPIO_Init(GPIOE, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 458  0150 4be0          	push	#224
 459  0152 4b08          	push	#8
 460  0154 ae5014        	ldw	x,#20500
 461  0157 8d000000      	callf	f_GPIO_Init
 463  015b 85            	popw	x
 464                     ; 118 	GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 466  015c 4be0          	push	#224
 467  015e 4b01          	push	#1
 468  0160 ae500f        	ldw	x,#20495
 469  0163 8d000000      	callf	f_GPIO_Init
 471  0167 85            	popw	x
 472                     ; 119 	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 474  0168 4be0          	push	#224
 475  016a 4b08          	push	#8
 476  016c ae500f        	ldw	x,#20495
 477  016f 8d000000      	callf	f_GPIO_Init
 479  0173 85            	popw	x
 480                     ; 120 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 482  0174 4be0          	push	#224
 483  0176 4b08          	push	#8
 484  0178 ae5000        	ldw	x,#20480
 485  017b 8d000000      	callf	f_GPIO_Init
 487  017f 85            	popw	x
 488                     ; 122 	GPIO_Init(GPIOD, GPIO_PIN_7, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 490  0180 4be0          	push	#224
 491  0182 4b80          	push	#128
 492  0184 ae500f        	ldw	x,#20495
 493  0187 8d000000      	callf	f_GPIO_Init
 495  018b 85            	popw	x
 496                     ; 123 	GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 498  018c 4be0          	push	#224
 499  018e 4b10          	push	#16
 500  0190 ae500f        	ldw	x,#20495
 501  0193 8d000000      	callf	f_GPIO_Init
 503  0197 85            	popw	x
 504                     ; 124 	GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 506  0198 4be0          	push	#224
 507  019a 4b04          	push	#4
 508  019c ae500f        	ldw	x,#20495
 509  019f 8d000000      	callf	f_GPIO_Init
 511  01a3 85            	popw	x
 512                     ; 125 	GPIO_Init(GPIOE, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 514  01a4 4be0          	push	#224
 515  01a6 4b01          	push	#1
 516  01a8 ae5014        	ldw	x,#20500
 517  01ab 8d000000      	callf	f_GPIO_Init
 519  01af 85            	popw	x
 520                     ; 127   GPIO_Init (GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
 522  01b0 4bb0          	push	#176
 523  01b2 4b02          	push	#2
 524  01b4 ae5014        	ldw	x,#20500
 525  01b7 8d000000      	callf	f_GPIO_Init
 527  01bb 85            	popw	x
 528                     ; 128   GPIO_Init (GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
 530  01bc 4bb0          	push	#176
 531  01be 4b04          	push	#4
 532  01c0 ae5014        	ldw	x,#20500
 533  01c3 8d000000      	callf	f_GPIO_Init
 535  01c7 85            	popw	x
 536                     ; 129 }
 539  01c8 87            	retf
 564                     ; 132 void UART3_setup(void) {
 565                     	switch	.text
 566  01c9               f_UART3_setup:
 570                     ; 133 	UART3_DeInit();
 572  01c9 8d000000      	callf	f_UART3_DeInit
 574                     ; 134 	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TXRX_ENABLE);
 576  01cd 4b0c          	push	#12
 577  01cf 4b00          	push	#0
 578  01d1 4b00          	push	#0
 579  01d3 4b00          	push	#0
 580  01d5 ae2580        	ldw	x,#9600
 581  01d8 89            	pushw	x
 582  01d9 ae0000        	ldw	x,#0
 583  01dc 89            	pushw	x
 584  01dd 8d000000      	callf	f_UART3_Init
 586  01e1 5b08          	addw	sp,#8
 587                     ; 135 	UART3_Cmd(ENABLE);
 589  01e3 a601          	ld	a,#1
 590  01e5 8d000000      	callf	f_UART3_Cmd
 592                     ; 136 }
 595  01e9 87            	retf
 621                     ; 139 void ADC2_setup(void) {
 622                     	switch	.text
 623  01ea               f_ADC2_setup:
 627                     ; 140 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 629  01ea ae1301        	ldw	x,#4865
 630  01ed 8d000000      	callf	f_CLK_PeripheralClockConfig
 632                     ; 141 	ADC2_DeInit();
 634  01f1 8d000000      	callf	f_ADC2_DeInit
 636                     ; 143 	ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
 636                     ; 144 						ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6, DISABLE);
 638  01f5 4b00          	push	#0
 639  01f7 4b07          	push	#7
 640  01f9 4b08          	push	#8
 641  01fb 4b00          	push	#0
 642  01fd 4b01          	push	#1
 643  01ff 4b00          	push	#0
 644  0201 ae0105        	ldw	x,#261
 645  0204 8d000000      	callf	f_ADC2_Init
 647  0208 5b06          	addw	sp,#6
 648                     ; 146 	ADC2_Cmd(ENABLE);
 650  020a a601          	ld	a,#1
 651  020c 8d000000      	callf	f_ADC2_Cmd
 653                     ; 147 }
 656  0210 87            	retf
 698                     ; 150 uint32_t elapsedTime(uint32_t start, uint32_t end) {
 699                     	switch	.text
 700  0211               f_elapsedTime:
 702       00000000      OFST:	set	0
 705                     ; 151 	return (end >= start) ? (end - start) : ((0xffffffff - start + 1) + end);
 707  0211 96            	ldw	x,sp
 708  0212 1c0008        	addw	x,#OFST+8
 709  0215 8d000000      	callf	d_ltor
 711  0219 96            	ldw	x,sp
 712  021a 1c0004        	addw	x,#OFST+4
 713  021d 8d000000      	callf	d_lcmp
 715  0221 2512          	jrult	L22
 716  0223 96            	ldw	x,sp
 717  0224 1c0008        	addw	x,#OFST+8
 718  0227 8d000000      	callf	d_ltor
 720  022b 96            	ldw	x,sp
 721  022c 1c0004        	addw	x,#OFST+4
 722  022f 8d000000      	callf	d_lsub
 724  0233 2014          	jra	L42
 725  0235               L22:
 726  0235 96            	ldw	x,sp
 727  0236 1c0004        	addw	x,#OFST+4
 728  0239 8d000000      	callf	d_ltor
 730  023d 8d000000      	callf	d_lneg
 732  0241 96            	ldw	x,sp
 733  0242 1c0008        	addw	x,#OFST+8
 734  0245 8d000000      	callf	d_ladd
 736  0249               L42:
 739  0249 87            	retf
 786                     ; 155 unsigned int read_ADC_Channel(uint8_t channel) {
 787                     	switch	.text
 788  024a               f_read_ADC_Channel:
 790  024a 89            	pushw	x
 791       00000002      OFST:	set	2
 794                     ; 156 	unsigned int adcValue = 0;
 796                     ; 157 	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, channel, ADC2_ALIGN_RIGHT);
 798  024b 4b08          	push	#8
 799  024d ae0100        	ldw	x,#256
 800  0250 97            	ld	xl,a
 801  0251 8d000000      	callf	f_ADC2_ConversionConfig
 803  0255 84            	pop	a
 804                     ; 158 	ADC2_StartConversion();
 806  0256 8d000000      	callf	f_ADC2_StartConversion
 809  025a               L502:
 810                     ; 160 	while (ADC2_GetFlagStatus() == RESET);
 812  025a 8d000000      	callf	f_ADC2_GetFlagStatus
 814  025e 4d            	tnz	a
 815  025f 27f9          	jreq	L502
 816                     ; 162 	adcValue = ADC2_GetConversionValue();
 818  0261 8d000000      	callf	f_ADC2_GetConversionValue
 820  0265 1f01          	ldw	(OFST-1,sp),x
 822                     ; 163 	ADC2_ClearFlag();
 824  0267 8d000000      	callf	f_ADC2_ClearFlag
 826                     ; 164 	return adcValue;
 828  026b 1e01          	ldw	x,(OFST-1,sp)
 831  026d 5b02          	addw	sp,#2
 832  026f 87            	retf
 905                     ; 168 bool detectZeroCross(float previousSample, float currentSample, float threshold) {
 906                     	switch	.text
 907  0270               f_detectZeroCross:
 909       00000000      OFST:	set	0
 912                     ; 169 	if (crossingType == -1) {  // If no crossing type detected, check for both positive and negative
 914  0270 be10          	ldw	x,_crossingType
 915  0272 a3ffff        	cpw	x,#65535
 916  0275 2666          	jrne	L742
 917                     ; 170 		if (previousSample <= threshold && currentSample > threshold) {
 919  0277 9c            	rvf
 920  0278 96            	ldw	x,sp
 921  0279 1c0004        	addw	x,#OFST+4
 922  027c 8d000000      	callf	d_ltor
 924  0280 96            	ldw	x,sp
 925  0281 1c000c        	addw	x,#OFST+12
 926  0284 8d000000      	callf	d_fcmp
 928  0288 2c19          	jrsgt	L152
 930  028a 9c            	rvf
 931  028b 96            	ldw	x,sp
 932  028c 1c0008        	addw	x,#OFST+8
 933  028f 8d000000      	callf	d_ltor
 935  0293 96            	ldw	x,sp
 936  0294 1c000c        	addw	x,#OFST+12
 937  0297 8d000000      	callf	d_fcmp
 939  029b 2d06          	jrsle	L152
 940                     ; 171 			crossingType = 0;  // Positive zero crossing
 942  029d 5f            	clrw	x
 943  029e bf10          	ldw	_crossingType,x
 944                     ; 172 			return true;
 946  02a0 a601          	ld	a,#1
 949  02a2 87            	retf
 950  02a3               L152:
 951                     ; 173 		} else if (previousSample >= -threshold && currentSample < -threshold) {
 953  02a3 9c            	rvf
 954  02a4 96            	ldw	x,sp
 955  02a5 1c000c        	addw	x,#OFST+12
 956  02a8 8d000000      	callf	d_ltor
 958  02ac 8d000000      	callf	d_fneg
 960  02b0 96            	ldw	x,sp
 961  02b1 1c0004        	addw	x,#OFST+4
 962  02b4 8d000000      	callf	d_fcmp
 964  02b8 2d04ac3a033a  	jrsgt	L752
 966  02be 9c            	rvf
 967  02bf 96            	ldw	x,sp
 968  02c0 1c000c        	addw	x,#OFST+12
 969  02c3 8d000000      	callf	d_ltor
 971  02c7 8d000000      	callf	d_fneg
 973  02cb 96            	ldw	x,sp
 974  02cc 1c0008        	addw	x,#OFST+8
 975  02cf 8d000000      	callf	d_fcmp
 977  02d3 2d65          	jrsle	L752
 978                     ; 174 			crossingType = 1;  // Negative zero crossing
 980  02d5 ae0001        	ldw	x,#1
 981  02d8 bf10          	ldw	_crossingType,x
 982                     ; 175 			return true;
 984  02da a601          	ld	a,#1
 987  02dc 87            	retf
 988  02dd               L742:
 989                     ; 177 	} else if (crossingType == 0 && previousSample <= threshold && currentSample > threshold) {
 991  02dd be10          	ldw	x,_crossingType
 992  02df 2629          	jrne	L162
 994  02e1 9c            	rvf
 995  02e2 96            	ldw	x,sp
 996  02e3 1c0004        	addw	x,#OFST+4
 997  02e6 8d000000      	callf	d_ltor
 999  02ea 96            	ldw	x,sp
1000  02eb 1c000c        	addw	x,#OFST+12
1001  02ee 8d000000      	callf	d_fcmp
1003  02f2 2c16          	jrsgt	L162
1005  02f4 9c            	rvf
1006  02f5 96            	ldw	x,sp
1007  02f6 1c0008        	addw	x,#OFST+8
1008  02f9 8d000000      	callf	d_ltor
1010  02fd 96            	ldw	x,sp
1011  02fe 1c000c        	addw	x,#OFST+12
1012  0301 8d000000      	callf	d_fcmp
1014  0305 2d03          	jrsle	L162
1015                     ; 178 			return true;  // Positive zero crossing
1017  0307 a601          	ld	a,#1
1020  0309 87            	retf
1021  030a               L162:
1022                     ; 179 	} else if (crossingType == 1 && previousSample >= threshold && currentSample < threshold) {
1024  030a be10          	ldw	x,_crossingType
1025  030c a30001        	cpw	x,#1
1026  030f 2629          	jrne	L752
1028  0311 9c            	rvf
1029  0312 96            	ldw	x,sp
1030  0313 1c0004        	addw	x,#OFST+4
1031  0316 8d000000      	callf	d_ltor
1033  031a 96            	ldw	x,sp
1034  031b 1c000c        	addw	x,#OFST+12
1035  031e 8d000000      	callf	d_fcmp
1037  0322 2f16          	jrslt	L752
1039  0324 9c            	rvf
1040  0325 96            	ldw	x,sp
1041  0326 1c0008        	addw	x,#OFST+8
1042  0329 8d000000      	callf	d_ltor
1044  032d 96            	ldw	x,sp
1045  032e 1c000c        	addw	x,#OFST+12
1046  0331 8d000000      	callf	d_fcmp
1048  0335 2e03          	jrsge	L752
1049                     ; 180 			return true;  // Negative zero crossing
1051  0337 a601          	ld	a,#1
1054  0339 87            	retf
1055  033a               L752:
1056                     ; 183 	return false;  // No zero crossing detected
1058  033a 4f            	clr	a
1061  033b 87            	retf
1113                     ; 187 bool detectPosZeroCross(float previousSample, float currentSample, float threshold) {
1114                     	switch	.text
1115  033c               f_detectPosZeroCross:
1117       00000000      OFST:	set	0
1120                     ; 188 	return (previousSample <= threshold && currentSample > threshold);
1122  033c 9c            	rvf
1123  033d 96            	ldw	x,sp
1124  033e 1c0004        	addw	x,#OFST+4
1125  0341 8d000000      	callf	d_ltor
1127  0345 96            	ldw	x,sp
1128  0346 1c000c        	addw	x,#OFST+12
1129  0349 8d000000      	callf	d_fcmp
1131  034d 2c17          	jrsgt	L43
1132  034f 9c            	rvf
1133  0350 96            	ldw	x,sp
1134  0351 1c0008        	addw	x,#OFST+8
1135  0354 8d000000      	callf	d_ltor
1137  0358 96            	ldw	x,sp
1138  0359 1c000c        	addw	x,#OFST+12
1139  035c 8d000000      	callf	d_fcmp
1141  0360 2d04          	jrsle	L43
1142  0362 a601          	ld	a,#1
1143  0364 2001          	jra	L63
1144  0366               L43:
1145  0366 4f            	clr	a
1146  0367               L63:
1149  0367 87            	retf
1221                     ; 192 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
1222                     	switch	.text
1223  0368               f_calculate_amplitude:
1225  0368 89            	pushw	x
1226  0369 520c          	subw	sp,#12
1227       0000000c      OFST:	set	12
1230                     ; 193 	uint32_t i = 0;
1232                     ; 194 	float max_val = -V_REF, min_val = V_REF;
1234  036b ce104b        	ldw	x,L753+2
1235  036e 1f03          	ldw	(OFST-9,sp),x
1236  0370 ce1049        	ldw	x,L753
1237  0373 1f01          	ldw	(OFST-11,sp),x
1241  0375 ce104f        	ldw	x,L763+2
1242  0378 1f07          	ldw	(OFST-5,sp),x
1243  037a ce104d        	ldw	x,L763
1244  037d 1f05          	ldw	(OFST-7,sp),x
1246                     ; 196 	for (i = 0; i < sample_size; i++) {
1248  037f ae0000        	ldw	x,#0
1249  0382 1f0b          	ldw	(OFST-1,sp),x
1250  0384 ae0000        	ldw	x,#0
1251  0387 1f09          	ldw	(OFST-3,sp),x
1254  0389 2058          	jra	L773
1255  038b               L373:
1256                     ; 197 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1258  038b 9c            	rvf
1259  038c 1e0b          	ldw	x,(OFST-1,sp)
1260  038e 58            	sllw	x
1261  038f 58            	sllw	x
1262  0390 72fb0d        	addw	x,(OFST+1,sp)
1263  0393 8d000000      	callf	d_ltor
1265  0397 96            	ldw	x,sp
1266  0398 1c0001        	addw	x,#OFST-11
1267  039b 8d000000      	callf	d_fcmp
1269  039f 2d11          	jrsle	L304
1272  03a1 1e0b          	ldw	x,(OFST-1,sp)
1273  03a3 58            	sllw	x
1274  03a4 58            	sllw	x
1275  03a5 72fb0d        	addw	x,(OFST+1,sp)
1276  03a8 9093          	ldw	y,x
1277  03aa ee02          	ldw	x,(2,x)
1278  03ac 1f03          	ldw	(OFST-9,sp),x
1279  03ae 93            	ldw	x,y
1280  03af fe            	ldw	x,(x)
1281  03b0 1f01          	ldw	(OFST-11,sp),x
1283  03b2               L304:
1284                     ; 198 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1286  03b2 9c            	rvf
1287  03b3 1e0b          	ldw	x,(OFST-1,sp)
1288  03b5 58            	sllw	x
1289  03b6 58            	sllw	x
1290  03b7 72fb0d        	addw	x,(OFST+1,sp)
1291  03ba 8d000000      	callf	d_ltor
1293  03be 96            	ldw	x,sp
1294  03bf 1c0005        	addw	x,#OFST-7
1295  03c2 8d000000      	callf	d_fcmp
1297  03c6 2e11          	jrsge	L504
1300  03c8 1e0b          	ldw	x,(OFST-1,sp)
1301  03ca 58            	sllw	x
1302  03cb 58            	sllw	x
1303  03cc 72fb0d        	addw	x,(OFST+1,sp)
1304  03cf 9093          	ldw	y,x
1305  03d1 ee02          	ldw	x,(2,x)
1306  03d3 1f07          	ldw	(OFST-5,sp),x
1307  03d5 93            	ldw	x,y
1308  03d6 fe            	ldw	x,(x)
1309  03d7 1f05          	ldw	(OFST-7,sp),x
1311  03d9               L504:
1312                     ; 196 	for (i = 0; i < sample_size; i++) {
1314  03d9 96            	ldw	x,sp
1315  03da 1c0009        	addw	x,#OFST-3
1316  03dd a601          	ld	a,#1
1317  03df 8d000000      	callf	d_lgadc
1320  03e3               L773:
1323  03e3 96            	ldw	x,sp
1324  03e4 1c0009        	addw	x,#OFST-3
1325  03e7 8d000000      	callf	d_ltor
1327  03eb 96            	ldw	x,sp
1328  03ec 1c0012        	addw	x,#OFST+6
1329  03ef 8d000000      	callf	d_lcmp
1331  03f3 2596          	jrult	L373
1332                     ; 200   printf("Max Vaue: %.4f,  Min Value: %.4f\n", max_val, min_val);
1334  03f5 1e07          	ldw	x,(OFST-5,sp)
1335  03f7 89            	pushw	x
1336  03f8 1e07          	ldw	x,(OFST-5,sp)
1337  03fa 89            	pushw	x
1338  03fb 1e07          	ldw	x,(OFST-5,sp)
1339  03fd 89            	pushw	x
1340  03fe 1e07          	ldw	x,(OFST-5,sp)
1341  0400 89            	pushw	x
1342  0401 ae1027        	ldw	x,#L704
1343  0404 8d000000      	callf	f_printf
1345  0408 5b08          	addw	sp,#8
1346                     ; 201 	return (max_val - min_val);
1348  040a 96            	ldw	x,sp
1349  040b 1c0001        	addw	x,#OFST-11
1350  040e 8d000000      	callf	d_ltor
1352  0412 96            	ldw	x,sp
1353  0413 1c0005        	addw	x,#OFST-7
1354  0416 8d000000      	callf	d_fsub
1358  041a 5b0e          	addw	sp,#14
1359  041c 87            	retf
1403                     ; 205 void initialize_adc_buffer(float buffer[]) {
1404                     	switch	.text
1405  041d               f_initialize_adc_buffer:
1407  041d 89            	pushw	x
1408  041e 89            	pushw	x
1409       00000002      OFST:	set	2
1412                     ; 206 	uint16_t i = 0;
1414                     ; 207 	for (i = 0; i < NUM_SAMPLES; i++) {
1416  041f 5f            	clrw	x
1417  0420 1f01          	ldw	(OFST-1,sp),x
1419  0422               L334:
1420                     ; 208 		buffer[i] = -1;  // Reset each element of the ADC buffer
1422  0422 1e01          	ldw	x,(OFST-1,sp)
1423  0424 58            	sllw	x
1424  0425 58            	sllw	x
1425  0426 72fb03        	addw	x,(OFST+1,sp)
1426  0429 90aeffff      	ldw	y,#65535
1427  042d 51            	exgw	x,y
1428  042e 8d000000      	callf	d_itof
1430  0432 51            	exgw	x,y
1431  0433 8d000000      	callf	d_rtol
1433                     ; 207 	for (i = 0; i < NUM_SAMPLES; i++) {
1435  0437 1e01          	ldw	x,(OFST-1,sp)
1436  0439 1c0001        	addw	x,#1
1437  043c 1f01          	ldw	(OFST-1,sp),x
1441  043e 1e01          	ldw	x,(OFST-1,sp)
1442  0440 a30400        	cpw	x,#1024
1443  0443 25dd          	jrult	L334
1444                     ; 210 }
1447  0445 5b04          	addw	sp,#4
1448  0447 87            	retf
1450                     .const:	section	.text
1451  0000               L144_buffer:
1452  0000 00000000      	dc.w	0,0
1453  0004 000000000000  	ds.b	4092
1624                     ; 212 float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
1625                     	switch	.text
1626  0448               f_process_adc_signal:
1628  0448 88            	push	a
1629  0449 96            	ldw	x,sp
1630  044a 1d102c        	subw	x,#4140
1631  044d 94            	ldw	sp,x
1632       0000102c      OFST:	set	4140
1635                     ; 213 	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
1637  044e 96            	ldw	x,sp
1638  044f 1c0027        	addw	x,#OFST-4101
1639  0452 90ae0000      	ldw	y,#L144_buffer
1640  0456 bf00          	ldw	c_x,x
1641  0458 ae1000        	ldw	x,#4096
1642  045b 8d000000      	callf	d_xymovl
1644                     ; 214 	unsigned long currentEdgeTime = 0;
1646                     ; 215 	float freqBuff = 0;
1648  045f ae0000        	ldw	x,#0
1649  0462 1f1d          	ldw	(OFST-4111,sp),x
1650  0464 ae0000        	ldw	x,#0
1651  0467 1f1b          	ldw	(OFST-4113,sp),x
1653                     ; 216 	int freqCount = 0;
1655  0469 5f            	clrw	x
1656  046a 1f1f          	ldw	(OFST-4109,sp),x
1658                     ; 217 	uint16_t i = 0, count = 0;
1662  046c 96            	ldw	x,sp
1663  046d 905f          	clrw	y
1664  046f df1027        	ldw	(OFST-5,x),y
1665                     ; 218 	float lastStoredValue = 0.0;       // Track the last stored ADC voltage
1667  0472 ce10b5        	ldw	x,L34+2
1668  0475 1f24          	ldw	(OFST-4104,sp),x
1669  0477 ce10b3        	ldw	x,L34
1670  047a 1f22          	ldw	(OFST-4106,sp),x
1672                     ; 219 	bool isChannel1 = (channel == VAR_SIGNAL);
1674  047c 96            	ldw	x,sp
1675  047d d6102d        	ld	a,(OFST+1,x)
1676  0480 a105          	cp	a,#5
1677  0482 2605          	jrne	L64
1678  0484 ae0001        	ldw	x,#1
1679  0487 2001          	jra	L05
1680  0489               L64:
1681  0489 5f            	clrw	x
1682  048a               L05:
1683  048a 01            	rrwa	x,a
1684  048b 6b21          	ld	(OFST-4107,sp),a
1685  048d 02            	rlwa	x,a
1687                     ; 220 	bool firstSample = true;           // Flag for first sample storage
1689  048e a601          	ld	a,#1
1690  0490 6b26          	ld	(OFST-4102,sp),a
1692                     ; 221 	lastEdgeTime = 0;                 // Reset last zero-crossing time
1694  0492 ae0000        	ldw	x,#0
1695  0495 bf0a          	ldw	_lastEdgeTime+2,x
1696  0497 ae0000        	ldw	x,#0
1697  049a bf08          	ldw	_lastEdgeTime,x
1699  049c ace505e5      	jpf	L555
1700  04a0               L155:
1701                     ; 226 		float currentVoltage = convert_adc_to_voltage(read_ADC_Channel(channel));
1703  04a0 96            	ldw	x,sp
1704  04a1 d6102d        	ld	a,(OFST+1,x)
1705  04a4 8d4a024a      	callf	f_read_ADC_Channel
1707  04a8 8d250725      	callf	f_convert_adc_to_voltage
1709  04ac 96            	ldw	x,sp
1710  04ad 1c1029        	addw	x,#OFST-3
1711  04b0 8d000000      	callf	d_rtol
1713                     ; 229 		if (firstSample || fabs(currentVoltage - lastStoredValue) >= 0.05) {
1715  04b4 0d26          	tnz	(OFST-4102,sp)
1716  04b6 262b          	jrne	L365
1718  04b8 9c            	rvf
1719  04b9 96            	ldw	x,sp
1720  04ba 1c1029        	addw	x,#OFST-3
1721  04bd 8d000000      	callf	d_ltor
1723  04c1 96            	ldw	x,sp
1724  04c2 1c0022        	addw	x,#OFST-4106
1725  04c5 8d000000      	callf	d_fsub
1727  04c9 be02          	ldw	x,c_lreg+2
1728  04cb 89            	pushw	x
1729  04cc be00          	ldw	x,c_lreg
1730  04ce 89            	pushw	x
1731  04cf 8d000000      	callf	f_fabs
1733  04d3 9c            	rvf
1734  04d4 5b04          	addw	sp,#4
1735  04d6 ae1023        	ldw	x,#L175
1736  04d9 8d000000      	callf	d_fcmp
1738  04dd 2e04          	jrsge	L25
1739  04df ace505e5      	jpf	L555
1740  04e3               L25:
1741  04e3               L365:
1742                     ; 230 			buffer[count] = currentVoltage;
1744  04e3 96            	ldw	x,sp
1745  04e4 9096          	ldw	y,sp
1746  04e6 72a90027      	addw	y,#OFST-4101
1747  04ea 170f          	ldw	(OFST-4125,sp),y
1749  04ec 9096          	ldw	y,sp
1750  04ee 90de1027      	ldw	y,(OFST-5,y)
1751  04f2 9058          	sllw	y
1752  04f4 9058          	sllw	y
1753  04f6 72f90f        	addw	y,(OFST-4125,sp)
1754  04f9 d6102c        	ld	a,(OFST+0,x)
1755  04fc 90e703        	ld	(3,y),a
1756  04ff d6102b        	ld	a,(OFST-1,x)
1757  0502 90e702        	ld	(2,y),a
1758  0505 d6102a        	ld	a,(OFST-2,x)
1759  0508 90e701        	ld	(1,y),a
1760  050b d61029        	ld	a,(OFST-3,x)
1761  050e 90f7          	ld	(y),a
1762                     ; 233 			lastStoredValue = currentVoltage;
1764  0510 96            	ldw	x,sp
1765  0511 9093          	ldw	y,x
1766  0513 de102b        	ldw	x,(OFST-1,x)
1767  0516 1f24          	ldw	(OFST-4104,sp),x
1768  0518 93            	ldw	x,y
1769  0519 de1029        	ldw	x,(OFST-3,x)
1770  051c 1f22          	ldw	(OFST-4106,sp),x
1772                     ; 234 			firstSample = false;  // First sample has been stored
1774  051e 0f26          	clr	(OFST-4102,sp)
1776                     ; 235 			count++;
1778  0520 96            	ldw	x,sp
1779  0521 9093          	ldw	y,x
1780  0523 de1027        	ldw	x,(OFST-5,x)
1781  0526 1c0001        	addw	x,#1
1782  0529 90df1027      	ldw	(OFST-5,y),x
1783                     ; 238 			if (isChannel1 && (frequency != NULL) && count > 1) {
1785  052d 0d21          	tnz	(OFST-4107,sp)
1786  052f 2604          	jrne	L45
1787  0531 ace505e5      	jpf	L555
1788  0535               L45:
1790  0535 96            	ldw	x,sp
1791  0536 d61032        	ld	a,(OFST+6,x)
1792  0539 da1031        	or	a,(OFST+5,x)
1793  053c 2604          	jrne	L65
1794  053e ace505e5      	jpf	L555
1795  0542               L65:
1797  0542 96            	ldw	x,sp
1798  0543 9093          	ldw	y,x
1799  0545 90de1027      	ldw	y,(OFST-5,y)
1800  0549 90a30002      	cpw	y,#2
1801  054d 2404          	jruge	L06
1802  054f ace505e5      	jpf	L555
1803  0553               L06:
1804                     ; 239 				if (detectZeroCross(buffer[count - 2], buffer[count - 1], ZEROCROSS_THRESHOLD)) {
1806  0553 ce1021        	ldw	x,L506+2
1807  0556 89            	pushw	x
1808  0557 ce101f        	ldw	x,L506
1809  055a 89            	pushw	x
1810  055b 96            	ldw	x,sp
1811  055c 1c002b        	addw	x,#OFST-4097
1812  055f 1f13          	ldw	(OFST-4121,sp),x
1814  0561 96            	ldw	x,sp
1815  0562 de102b        	ldw	x,(OFST-1,x)
1816  0565 58            	sllw	x
1817  0566 58            	sllw	x
1818  0567 1d0004        	subw	x,#4
1819  056a 72fb13        	addw	x,(OFST-4121,sp)
1820  056d 9093          	ldw	y,x
1821  056f ee02          	ldw	x,(2,x)
1822  0571 89            	pushw	x
1823  0572 93            	ldw	x,y
1824  0573 fe            	ldw	x,(x)
1825  0574 89            	pushw	x
1826  0575 96            	ldw	x,sp
1827  0576 1c002f        	addw	x,#OFST-4093
1828  0579 1f15          	ldw	(OFST-4119,sp),x
1830  057b 96            	ldw	x,sp
1831  057c de102f        	ldw	x,(OFST+3,x)
1832  057f 58            	sllw	x
1833  0580 58            	sllw	x
1834  0581 1d0008        	subw	x,#8
1835  0584 72fb15        	addw	x,(OFST-4119,sp)
1836  0587 9093          	ldw	y,x
1837  0589 ee02          	ldw	x,(2,x)
1838  058b 89            	pushw	x
1839  058c 93            	ldw	x,y
1840  058d fe            	ldw	x,(x)
1841  058e 89            	pushw	x
1842  058f 8d700270      	callf	f_detectZeroCross
1844  0593 5b0c          	addw	sp,#12
1845  0595 4d            	tnz	a
1846  0596 274d          	jreq	L555
1847                     ; 240 					currentEdgeTime = micros();
1849  0598 8d000000      	callf	f_micros
1851  059c 96            	ldw	x,sp
1852  059d 1c1029        	addw	x,#OFST-3
1853  05a0 8d000000      	callf	d_rtol
1855                     ; 241 					if (lastEdgeTime > 0) {  
1857  05a4 ae0008        	ldw	x,#_lastEdgeTime
1858  05a7 8d000000      	callf	d_lzmp
1860  05ab 272a          	jreq	L116
1861                     ; 242 						unsigned long period = currentEdgeTime - lastEdgeTime;
1863  05ad 96            	ldw	x,sp
1864  05ae 1c1029        	addw	x,#OFST-3
1865  05b1 8d000000      	callf	d_ltor
1867  05b5 ae0008        	ldw	x,#_lastEdgeTime
1868  05b8 8d000000      	callf	d_lsub
1870  05bc 96            	ldw	x,sp
1871  05bd 1c0015        	addw	x,#OFST-4119
1872  05c0 8d000000      	callf	d_rtol
1875                     ; 243 						float singleFrequency = calculate_frequency(period);
1877  05c4 1e17          	ldw	x,(OFST-4117,sp)
1878  05c6 89            	pushw	x
1879  05c7 1e17          	ldw	x,(OFST-4117,sp)
1880  05c9 89            	pushw	x
1881  05ca 8d310731      	callf	f_calculate_frequency
1883  05ce 5b04          	addw	sp,#4
1884                     ; 244 						freqCount++;
1886  05d0 1e1f          	ldw	x,(OFST-4109,sp)
1887  05d2 1c0001        	addw	x,#1
1888  05d5 1f1f          	ldw	(OFST-4109,sp),x
1890  05d7               L116:
1891                     ; 258 					lastEdgeTime = currentEdgeTime;
1893  05d7 96            	ldw	x,sp
1894  05d8 9093          	ldw	y,x
1895  05da de102b        	ldw	x,(OFST-1,x)
1896  05dd bf0a          	ldw	_lastEdgeTime+2,x
1897  05df 93            	ldw	x,y
1898  05e0 de1029        	ldw	x,(OFST-3,x)
1899  05e3 bf08          	ldw	_lastEdgeTime,x
1900  05e5               L555:
1901                     ; 225 	while (count < NUM_SAMPLES) {  
1903  05e5 96            	ldw	x,sp
1904  05e6 9093          	ldw	y,x
1905  05e8 90de1027      	ldw	y,(OFST-5,y)
1906  05ec 90a30400      	cpw	y,#1024
1907  05f0 2404          	jruge	L26
1908  05f2 aca004a0      	jpf	L155
1909  05f6               L26:
1910                     ; 265 	*amplitude = calculate_amplitude(buffer, count);
1912  05f6 96            	ldw	x,sp
1913  05f7 de1027        	ldw	x,(OFST-5,x)
1914  05fa 8d000000      	callf	d_uitolx
1916  05fe be02          	ldw	x,c_lreg+2
1917  0600 89            	pushw	x
1918  0601 be00          	ldw	x,c_lreg
1919  0603 89            	pushw	x
1920  0604 96            	ldw	x,sp
1921  0605 1c002b        	addw	x,#OFST-4097
1922  0608 8d680368      	callf	f_calculate_amplitude
1924  060c 5b04          	addw	sp,#4
1925  060e 96            	ldw	x,sp
1926  060f de1033        	ldw	x,(OFST+7,x)
1927  0612 8d000000      	callf	d_rtol
1929                     ; 267 	if (isChannel1 && freqCount > 0) {
1931  0616 0d21          	tnz	(OFST-4107,sp)
1932  0618 272d          	jreq	L316
1934  061a 9c            	rvf
1935  061b 1e1f          	ldw	x,(OFST-4109,sp)
1936  061d 2d28          	jrsle	L316
1937                     ; 268 		*frequency = freqBuff / freqCount;
1939  061f 1e1f          	ldw	x,(OFST-4109,sp)
1940  0621 8d000000      	callf	d_itof
1942  0625 96            	ldw	x,sp
1943  0626 1c000d        	addw	x,#OFST-4127
1944  0629 8d000000      	callf	d_rtol
1947  062d 96            	ldw	x,sp
1948  062e 1c001b        	addw	x,#OFST-4113
1949  0631 8d000000      	callf	d_ltor
1951  0635 96            	ldw	x,sp
1952  0636 1c000d        	addw	x,#OFST-4127
1953  0639 8d000000      	callf	d_fdiv
1955  063d 96            	ldw	x,sp
1956  063e de1031        	ldw	x,(OFST+5,x)
1957  0641 8d000000      	callf	d_rtol
1960  0645 2017          	jra	L516
1961  0647               L316:
1962                     ; 269 	} else if (isChannel1) {
1964  0647 0d21          	tnz	(OFST-4107,sp)
1965  0649 2713          	jreq	L516
1966                     ; 270 		*frequency = 0;
1968  064b 96            	ldw	x,sp
1969  064c de1031        	ldw	x,(OFST+5,x)
1970  064f a600          	ld	a,#0
1971  0651 e703          	ld	(3,x),a
1972  0653 a600          	ld	a,#0
1973  0655 e702          	ld	(2,x),a
1974  0657 a600          	ld	a,#0
1975  0659 e701          	ld	(1,x),a
1976  065b a600          	ld	a,#0
1977  065d f7            	ld	(x),a
1978  065e               L516:
1979                     ; 273 	return *amplitude;
1981  065e 96            	ldw	x,sp
1982  065f de1033        	ldw	x,(OFST+7,x)
1983  0662 8d000000      	callf	d_ltor
1987  0666 9096          	ldw	y,sp
1988  0668 72a9102d      	addw	y,#4141
1989  066c 9094          	ldw	sp,y
1990  066e 87            	retf
2069                     ; 278 float process_FDR_samples(float buffer[]) {
2070                     	switch	.text
2071  066f               f_process_FDR_samples:
2073  066f 89            	pushw	x
2074  0670 520c          	subw	sp,#12
2075       0000000c      OFST:	set	12
2078                     ; 279 	int ZCount = 0;
2080  0672 5f            	clrw	x
2081  0673 1f09          	ldw	(OFST-3,sp),x
2083                     ; 280 	uint16_t i = 0;
2085                     ; 282 	for (i = 0; i < NUM_SAMPLES; i++) {
2087  0675 5f            	clrw	x
2088  0676 1f0b          	ldw	(OFST-1,sp),x
2090  0678               L756:
2091                     ; 284 		buffer[i] = convert_adc_to_voltage(read_ADC_Channel(ADC2_CHANNEL_6));
2093  0678 a606          	ld	a,#6
2094  067a 8d4a024a      	callf	f_read_ADC_Channel
2096  067e 8d250725      	callf	f_convert_adc_to_voltage
2098  0682 1e0b          	ldw	x,(OFST-1,sp)
2099  0684 58            	sllw	x
2100  0685 58            	sllw	x
2101  0686 72fb0d        	addw	x,(OFST+1,sp)
2102  0689 8d000000      	callf	d_rtol
2104                     ; 286 		delay_us(1000000 / SAMPLE_RATE);
2106  068d ae1a0a        	ldw	x,#6666
2107  0690 8d000000      	callf	f_delay_us
2109                     ; 288 		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
2111  0694 1e0b          	ldw	x,(OFST-1,sp)
2112  0696 2754          	jreq	L566
2114  0698 ce1021        	ldw	x,L506+2
2115  069b 89            	pushw	x
2116  069c ce101f        	ldw	x,L506
2117  069f 89            	pushw	x
2118  06a0 1e0f          	ldw	x,(OFST+3,sp)
2119  06a2 58            	sllw	x
2120  06a3 58            	sllw	x
2121  06a4 72fb11        	addw	x,(OFST+5,sp)
2122  06a7 9093          	ldw	y,x
2123  06a9 ee02          	ldw	x,(2,x)
2124  06ab 89            	pushw	x
2125  06ac 93            	ldw	x,y
2126  06ad fe            	ldw	x,(x)
2127  06ae 89            	pushw	x
2128  06af 1e13          	ldw	x,(OFST+7,sp)
2129  06b1 58            	sllw	x
2130  06b2 58            	sllw	x
2131  06b3 1d0004        	subw	x,#4
2132  06b6 72fb15        	addw	x,(OFST+9,sp)
2133  06b9 9093          	ldw	y,x
2134  06bb ee02          	ldw	x,(2,x)
2135  06bd 89            	pushw	x
2136  06be 93            	ldw	x,y
2137  06bf fe            	ldw	x,(x)
2138  06c0 89            	pushw	x
2139  06c1 8d700270      	callf	f_detectZeroCross
2141  06c5 5b0c          	addw	sp,#12
2142  06c7 4d            	tnz	a
2143  06c8 2722          	jreq	L566
2144                     ; 289 				unsigned long period = currentEdgeTime - lastEdgeTime;   // Calculate period
2146  06ca ae000c        	ldw	x,#_currentEdgeTime
2147  06cd 8d000000      	callf	d_ltor
2149  06d1 ae0008        	ldw	x,#_lastEdgeTime
2150  06d4 8d000000      	callf	d_lsub
2152                     ; 290 				ZCount++;
2154  06d8 1e09          	ldw	x,(OFST-3,sp)
2155  06da 1c0001        	addw	x,#1
2156  06dd 1f09          	ldw	(OFST-3,sp),x
2158                     ; 291 				if (ZCount == 2)
2160  06df 1e09          	ldw	x,(OFST-3,sp)
2161  06e1 a30002        	cpw	x,#2
2162  06e4 2606          	jrne	L566
2163                     ; 293 					count = i;    // for amplitude calculation limit bound
2165  06e6 1e0b          	ldw	x,(OFST-1,sp)
2166  06e8 bf12          	ldw	_count,x
2167                     ; 294 					break;        // break when zeroCrossing detection is two
2169  06ea 2012          	jra	L366
2170  06ec               L566:
2171                     ; 282 	for (i = 0; i < NUM_SAMPLES; i++) {
2173  06ec 1e0b          	ldw	x,(OFST-1,sp)
2174  06ee 1c0001        	addw	x,#1
2175  06f1 1f0b          	ldw	(OFST-1,sp),x
2179  06f3 1e0b          	ldw	x,(OFST-1,sp)
2180  06f5 a30400        	cpw	x,#1024
2181  06f8 2404ac780678  	jrult	L756
2182  06fe               L366:
2183                     ; 298 	amplitude = calculate_amplitude(buffer, count);
2185  06fe be12          	ldw	x,_count
2186  0700 8d000000      	callf	d_uitolx
2188  0704 be02          	ldw	x,c_lreg+2
2189  0706 89            	pushw	x
2190  0707 be00          	ldw	x,c_lreg
2191  0709 89            	pushw	x
2192  070a 1e11          	ldw	x,(OFST+5,sp)
2193  070c 8d680368      	callf	f_calculate_amplitude
2195  0710 5b04          	addw	sp,#4
2196  0712 96            	ldw	x,sp
2197  0713 1c0005        	addw	x,#OFST-7
2198  0716 8d000000      	callf	d_rtol
2201                     ; 300 	return amplitude;
2203  071a 96            	ldw	x,sp
2204  071b 1c0005        	addw	x,#OFST-7
2205  071e 8d000000      	callf	d_ltor
2209  0722 5b0e          	addw	sp,#14
2210  0724 87            	retf
2244                     ; 304 float convert_adc_to_voltage(unsigned int adcValue) {
2245                     	switch	.text
2246  0725               f_convert_adc_to_voltage:
2250                     ; 305 	return adcValue * (V_REF / ADC_MAX_VALUE);
2252  0725 8d000000      	callf	d_uitof
2254  0729 ae101b        	ldw	x,#L317
2255  072c 8d000000      	callf	d_fmul
2259  0730 87            	retf
2293                     ; 309 float calculate_frequency(unsigned long period) {
2294                     	switch	.text
2295  0731               f_calculate_frequency:
2297  0731 5204          	subw	sp,#4
2298       00000004      OFST:	set	4
2301                     ; 310 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
2303  0733 96            	ldw	x,sp
2304  0734 1c0008        	addw	x,#OFST+4
2305  0737 8d000000      	callf	d_ltor
2307  073b 8d000000      	callf	d_ultof
2309  073f ae1013        	ldw	x,#L157
2310  0742 8d000000      	callf	d_fdiv
2312  0746 96            	ldw	x,sp
2313  0747 1c0001        	addw	x,#OFST-3
2314  074a 8d000000      	callf	d_rtol
2317  074e ae1017        	ldw	x,#L147
2318  0751 8d000000      	callf	d_ltor
2320  0755 96            	ldw	x,sp
2321  0756 1c0001        	addw	x,#OFST-3
2322  0759 8d000000      	callf	d_fdiv
2326  075d 5b04          	addw	sp,#4
2327  075f 87            	retf
2381                     ; 314 void output_results(float frequency, float amplitude) {
2382                     	switch	.text
2383  0760               f_output_results:
2385  0760 5228          	subw	sp,#40
2386       00000028      OFST:	set	40
2389                     ; 320 	sprintf(buffer, "%.3f,%.3f,%.3f\n", frequency, amplitude, amplitude);
2391  0762 1e32          	ldw	x,(OFST+10,sp)
2392  0764 89            	pushw	x
2393  0765 1e32          	ldw	x,(OFST+10,sp)
2394  0767 89            	pushw	x
2395  0768 1e36          	ldw	x,(OFST+14,sp)
2396  076a 89            	pushw	x
2397  076b 1e36          	ldw	x,(OFST+14,sp)
2398  076d 89            	pushw	x
2399  076e 1e36          	ldw	x,(OFST+14,sp)
2400  0770 89            	pushw	x
2401  0771 1e36          	ldw	x,(OFST+14,sp)
2402  0773 89            	pushw	x
2403  0774 ae1003        	ldw	x,#L3001
2404  0777 89            	pushw	x
2405  0778 96            	ldw	x,sp
2406  0779 1c000f        	addw	x,#OFST-25
2407  077c 8d000000      	callf	f_sprintf
2409  0780 5b0e          	addw	sp,#14
2410                     ; 323 	printf("%s", buffer);
2412  0782 96            	ldw	x,sp
2413  0783 1c0001        	addw	x,#OFST-39
2414  0786 89            	pushw	x
2415  0787 ae1000        	ldw	x,#L5001
2416  078a 8d000000      	callf	f_printf
2418  078e 85            	popw	x
2419                     ; 325 }
2422  078f 5b28          	addw	sp,#40
2423  0791 87            	retf
2458                     ; 328 PUTCHAR_PROTOTYPE {
2459                     	switch	.text
2460  0792               f_putchar:
2462  0792 88            	push	a
2463       00000000      OFST:	set	0
2466                     ; 329 	UART3_SendData8(c);
2468  0793 8d000000      	callf	f_UART3_SendData8
2471  0797               L7201:
2472                     ; 330 	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
2474  0797 ae0080        	ldw	x,#128
2475  079a 8d000000      	callf	f_UART3_GetFlagStatus
2477  079e 4d            	tnz	a
2478  079f 27f6          	jreq	L7201
2479                     ; 331 	return c;
2481  07a1 7b01          	ld	a,(OFST+1,sp)
2484  07a3 5b01          	addw	sp,#1
2485  07a5 87            	retf
2520                     ; 334 GETCHAR_PROTOTYPE
2520                     ; 335 {
2521                     	switch	.text
2522  07a6               f_getchar:
2524  07a6 88            	push	a
2525       00000001      OFST:	set	1
2528                     ; 336   char c = 0;
2531  07a7               L3501:
2532                     ; 338   while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
2534  07a7 ae0020        	ldw	x,#32
2535  07aa 8d000000      	callf	f_UART3_GetFlagStatus
2537  07ae 4d            	tnz	a
2538  07af 27f6          	jreq	L3501
2539                     ; 339 	c = UART3_ReceiveData8();
2541  07b1 8d000000      	callf	f_UART3_ReceiveData8
2543  07b5 6b01          	ld	(OFST+0,sp),a
2545                     ; 340   return (c);
2547  07b7 7b01          	ld	a,(OFST+0,sp)
2550  07b9 5b01          	addw	sp,#1
2551  07bb 87            	retf
2575                     ; 343 void UART3_ClearBuffer(void) {
2576                     	switch	.text
2577  07bc               f_UART3_ClearBuffer:
2581  07bc 2004          	jra	L1701
2582  07be               L7601:
2583                     ; 345         (void)UART3_ReceiveData8(); // Clear any preexisting data
2585  07be 8d000000      	callf	f_UART3_ReceiveData8
2587  07c2               L1701:
2588                     ; 344     while (UART3_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
2590  07c2 ae0020        	ldw	x,#32
2591  07c5 8d000000      	callf	f_UART3_GetFlagStatus
2593  07c9 4d            	tnz	a
2594  07ca 26f2          	jrne	L7601
2595                     ; 347 }
2598  07cc 87            	retf
2662                     ; 349 void UART3_ReceiveString(char *buffer, uint16_t max_length) {
2663                     	switch	.text
2664  07cd               f_UART3_ReceiveString:
2666  07cd 89            	pushw	x
2667  07ce 5203          	subw	sp,#3
2668       00000003      OFST:	set	3
2671                     ; 350     uint16_t i = 0;
2673                     ; 353     for (i = 0; i < max_length; i++) {
2675  07d0 5f            	clrw	x
2676  07d1 1f02          	ldw	(OFST-1,sp),x
2679  07d3 200d          	jra	L3311
2680  07d5               L7211:
2681                     ; 354         buffer[i] = '\0';
2683  07d5 1e04          	ldw	x,(OFST+1,sp)
2684  07d7 72fb02        	addw	x,(OFST-1,sp)
2685  07da 7f            	clr	(x)
2686                     ; 353     for (i = 0; i < max_length; i++) {
2688  07db 1e02          	ldw	x,(OFST-1,sp)
2689  07dd 1c0001        	addw	x,#1
2690  07e0 1f02          	ldw	(OFST-1,sp),x
2692  07e2               L3311:
2695  07e2 1e02          	ldw	x,(OFST-1,sp)
2696  07e4 1309          	cpw	x,(OFST+6,sp)
2697  07e6 25ed          	jrult	L7211
2698                     ; 356     i = 0;
2700  07e8 5f            	clrw	x
2701  07e9 1f02          	ldw	(OFST-1,sp),x
2704  07eb 202c          	jra	L3411
2705  07ed               L1511:
2706                     ; 360         while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
2708  07ed ae0020        	ldw	x,#32
2709  07f0 8d000000      	callf	f_UART3_GetFlagStatus
2711  07f4 4d            	tnz	a
2712  07f5 27f6          	jreq	L1511
2713                     ; 362         receivedChar = UART3_ReceiveData8();
2715  07f7 8d000000      	callf	f_UART3_ReceiveData8
2717  07fb 6b01          	ld	(OFST-2,sp),a
2719                     ; 364         if (receivedChar == '\n' || receivedChar == '\r') {
2721  07fd 7b01          	ld	a,(OFST-2,sp)
2722  07ff a10a          	cp	a,#10
2723  0801 271d          	jreq	L5411
2725  0803 7b01          	ld	a,(OFST-2,sp)
2726  0805 a10d          	cp	a,#13
2727  0807 2717          	jreq	L5411
2728                     ; 368         buffer[i++] = receivedChar;
2730  0809 7b01          	ld	a,(OFST-2,sp)
2731  080b 1e02          	ldw	x,(OFST-1,sp)
2732  080d 1c0001        	addw	x,#1
2733  0810 1f02          	ldw	(OFST-1,sp),x
2734  0812 1d0001        	subw	x,#1
2736  0815 72fb04        	addw	x,(OFST+1,sp)
2737  0818 f7            	ld	(x),a
2738  0819               L3411:
2739                     ; 359     while (i < max_length - 1) {
2741  0819 1e09          	ldw	x,(OFST+6,sp)
2742  081b 5a            	decw	x
2743  081c 1302          	cpw	x,(OFST-1,sp)
2744  081e 22cd          	jrugt	L1511
2745  0820               L5411:
2746                     ; 371     buffer[i] = '\0'; // Null-terminate the string
2748  0820 1e04          	ldw	x,(OFST+1,sp)
2749  0822 72fb02        	addw	x,(OFST-1,sp)
2750  0825 7f            	clr	(x)
2751                     ; 372 }
2754  0826 5b05          	addw	sp,#5
2755  0828 87            	retf
2823                     	xdef	f_main
2824                     	xdef	f_UART3_ReceiveString
2825                     	xdef	f_UART3_ClearBuffer
2826                     	xdef	f_process_FDR_samples
2827                     	xdef	f_calculate_frequency
2828                     	xdef	f_convert_adc_to_voltage
2829                     	xdef	f_process_adc_signal
2830                     	xdef	f_calculate_amplitude
2831                     	xdef	f_output_results
2832                     	xdef	f_initialize_adc_buffer
2833                     	xdef	f_detectZeroCross
2834                     	xdef	f_detectPosZeroCross
2835                     	xdef	f_read_ADC_Channel
2836                     	xdef	f_elapsedTime
2837                     	xdef	f_GPIO_setup
2838                     	xdef	f_ADC2_setup
2839                     	xdef	f_UART3_setup
2840                     	xdef	f_clock_setup
2841                     	xdef	f_initialize_system
2842                     	xdef	_count
2843                     	xdef	_crossingType
2844                     	xdef	_currentEdgeTime
2845                     	xdef	_lastEdgeTime
2846                     	xdef	_sine1_amplitude
2847                     	xdef	_sine1_frequency
2848                     	xref	f_fabs
2849                     	xref	f_micros
2850                     	xref	f_delay_us
2851                     	xref	f_TIM4_Config
2852                     	xref	f_sprintf
2853                     	xdef	f_putchar
2854                     	xref	f_printf
2855                     	xdef	f_getchar
2856                     	xref	f_UART3_GetFlagStatus
2857                     	xref	f_UART3_SendData8
2858                     	xref	f_UART3_ReceiveData8
2859                     	xref	f_UART3_Cmd
2860                     	xref	f_UART3_Init
2861                     	xref	f_UART3_DeInit
2862                     	xref	f_GPIO_Init
2863                     	xref	f_GPIO_DeInit
2864                     	xref	f_CLK_GetFlagStatus
2865                     	xref	f_CLK_SYSCLKConfig
2866                     	xref	f_CLK_HSIPrescalerConfig
2867                     	xref	f_CLK_ClockSwitchConfig
2868                     	xref	f_CLK_PeripheralClockConfig
2869                     	xref	f_CLK_ClockSwitchCmd
2870                     	xref	f_CLK_LSICmd
2871                     	xref	f_CLK_HSICmd
2872                     	xref	f_CLK_HSECmd
2873                     	xref	f_CLK_DeInit
2874                     	xref	f_ADC2_ClearFlag
2875                     	xref	f_ADC2_GetFlagStatus
2876                     	xref	f_ADC2_GetConversionValue
2877                     	xref	f_ADC2_StartConversion
2878                     	xref	f_ADC2_ConversionConfig
2879                     	xref	f_ADC2_Cmd
2880                     	xref	f_ADC2_Init
2881                     	xref	f_ADC2_DeInit
2882                     	switch	.const
2883  1000               L5001:
2884  1000 257300        	dc.b	"%s",0
2885  1003               L3001:
2886  1003 252e33662c25  	dc.b	"%.3f,%.3f,%.3f",10,0
2887  1013               L157:
2888  1013 49742400      	dc.w	18804,9216
2889  1017               L147:
2890  1017 3f800000      	dc.w	16256,0
2891  101b               L317:
2892  101b 3b954409      	dc.w	15253,17417
2893  101f               L506:
2894  101f 3f8ccccc      	dc.w	16268,-13108
2895  1023               L175:
2896  1023 3d4ccccc      	dc.w	15692,-13108
2897  1027               L704:
2898  1027 4d6178205661  	dc.b	"Max Vaue: %.4f,  M"
2899  1039 696e2056616c  	dc.b	"in Value: %.4f",10,0
2900  1049               L753:
2901  1049 c0951eb8      	dc.w	-16235,7864
2902  104d               L763:
2903  104d 40951eb8      	dc.w	16533,7864
2904  1051               L76:
2905  1051 53797374656d  	dc.b	"System Initializat"
2906  1063 696f6e20436f  	dc.b	"ion Completed",10
2907  1071 0d00          	dc.b	13,0
2908  1073               L55:
2909  1073 667265717565  	dc.b	"frequency; %.3f, a"
2910  1085 6d706c697475  	dc.b	"mplitude: %.3f",10
2911  1094 0d00          	dc.b	13,0
2912  1096               L35:
2913  1096 414443205661  	dc.b	"ADC Vaue: %u, Volt"
2914  10a8 6167653a2025  	dc.b	"age: %.3f",10,0
2915  10b3               L34:
2916  10b3 00000000      	dc.w	0,0
2917                     	xref.b	c_lreg
2918                     	xref.b	c_x
2919                     	xref.b	c_y
2939                     	xref	d_ultof
2940                     	xref	d_fmul
2941                     	xref	d_uitof
2942                     	xref	d_fdiv
2943                     	xref	d_uitolx
2944                     	xref	d_lzmp
2945                     	xref	d_xymovl
2946                     	xref	d_itof
2947                     	xref	d_fsub
2948                     	xref	d_lgadc
2949                     	xref	d_fneg
2950                     	xref	d_fcmp
2951                     	xref	d_ladd
2952                     	xref	d_lneg
2953                     	xref	d_lsub
2954                     	xref	d_lcmp
2955                     	xref	d_ltor
2956                     	xref	d_rtol
2957                     	end
