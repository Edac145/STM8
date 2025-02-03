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
  77                     ; 55 void main() {
  78                     	switch	.text
  79  0000               f_main:
  81  0000 5208          	subw	sp,#8
  82       00000008      OFST:	set	8
  85                     ; 56 	float frequency = 0.0, amplitude = 0.0;
  87  0002 ce1059        	ldw	x,L73+2
  88  0005 1f03          	ldw	(OFST-5,sp),x
  89  0007 ce1057        	ldw	x,L73
  90  000a 1f01          	ldw	(OFST-7,sp),x
  94  000c ce1059        	ldw	x,L73+2
  95  000f 1f07          	ldw	(OFST-1,sp),x
  96  0011 ce1057        	ldw	x,L73
  97  0014 1f05          	ldw	(OFST-3,sp),x
  99                     ; 57 	initialize_system();
 101  0016 8d360036      	callf	f_initialize_system
 103  001a               L34:
 104                     ; 60 		amplitude = process_adc_signal(VAR_SIGNAL, &frequency, &amplitude);
 106  001a 96            	ldw	x,sp
 107  001b 1c0005        	addw	x,#OFST-3
 108  001e 89            	pushw	x
 109  001f 96            	ldw	x,sp
 110  0020 1c0003        	addw	x,#OFST-5
 111  0023 89            	pushw	x
 112  0024 a605          	ld	a,#5
 113  0026 8d160316      	callf	f_process_adc_signal
 115  002a 5b04          	addw	sp,#4
 116  002c 96            	ldw	x,sp
 117  002d 1c0005        	addw	x,#OFST-3
 118  0030 8d000000      	callf	d_rtol
 122  0034 20e4          	jra	L34
 151                     ; 70 void initialize_system(void) {
 152                     	switch	.text
 153  0036               f_initialize_system:
 157                     ; 71 	clock_setup();          // Configure system clock
 159  0036 8d610061      	callf	f_clock_setup
 161                     ; 72 	TIM4_Config();          // Timer 4 config for delay
 163  003a 8d000000      	callf	f_TIM4_Config
 165                     ; 73 	UART3_setup();          // Setup UART communication
 167  003e 8da400a4      	callf	f_UART3_setup
 169                     ; 74 	ADC2_setup();           // Setup ADC
 171  0042 8dc500c5      	callf	f_ADC2_setup
 173                     ; 75 	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
 175  0046 ae500a        	ldw	x,#20490
 176  0049 8d000000      	callf	f_GPIO_DeInit
 178                     ; 76 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 180  004d 4be0          	push	#224
 181  004f 4b08          	push	#8
 182  0051 ae500a        	ldw	x,#20490
 183  0054 8d000000      	callf	f_GPIO_Init
 185  0058 85            	popw	x
 186                     ; 77 	printf("System Initialization Completed\n\r");
 188  0059 ae1035        	ldw	x,#L75
 189  005c 8d000000      	callf	f_printf
 191                     ; 78 }
 194  0060 87            	retf
 226                     ; 81 void clock_setup(void) {
 227                     	switch	.text
 228  0061               f_clock_setup:
 232                     ; 82 	CLK_DeInit();
 234  0061 8d000000      	callf	f_CLK_DeInit
 236                     ; 83 	CLK_HSECmd(DISABLE);
 238  0065 4f            	clr	a
 239  0066 8d000000      	callf	f_CLK_HSECmd
 241                     ; 84 	CLK_LSICmd(DISABLE);
 243  006a 4f            	clr	a
 244  006b 8d000000      	callf	f_CLK_LSICmd
 246                     ; 85 	CLK_HSICmd(ENABLE);
 248  006f a601          	ld	a,#1
 249  0071 8d000000      	callf	f_CLK_HSICmd
 252  0075               L37:
 253                     ; 86 	while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 255  0075 ae0102        	ldw	x,#258
 256  0078 8d000000      	callf	f_CLK_GetFlagStatus
 258  007c 4d            	tnz	a
 259  007d 27f6          	jreq	L37
 260                     ; 89 	CLK_ClockSwitchCmd(ENABLE);
 262  007f a601          	ld	a,#1
 263  0081 8d000000      	callf	f_CLK_ClockSwitchCmd
 265                     ; 90 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 267  0085 4f            	clr	a
 268  0086 8d000000      	callf	f_CLK_HSIPrescalerConfig
 270                     ; 91 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 272  008a a680          	ld	a,#128
 273  008c 8d000000      	callf	f_CLK_SYSCLKConfig
 275                     ; 92 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 277  0090 4b01          	push	#1
 278  0092 4b00          	push	#0
 279  0094 ae01e1        	ldw	x,#481
 280  0097 8d000000      	callf	f_CLK_ClockSwitchConfig
 282  009b 85            	popw	x
 283                     ; 96 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 285  009c ae0301        	ldw	x,#769
 286  009f 8d000000      	callf	f_CLK_PeripheralClockConfig
 288                     ; 97 }
 291  00a3 87            	retf
 316                     ; 100 void UART3_setup(void) {
 317                     	switch	.text
 318  00a4               f_UART3_setup:
 322                     ; 101 	UART3_DeInit();
 324  00a4 8d000000      	callf	f_UART3_DeInit
 326                     ; 102 	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TXRX_ENABLE);
 328  00a8 4b0c          	push	#12
 329  00aa 4b00          	push	#0
 330  00ac 4b00          	push	#0
 331  00ae 4b00          	push	#0
 332  00b0 ae2580        	ldw	x,#9600
 333  00b3 89            	pushw	x
 334  00b4 ae0000        	ldw	x,#0
 335  00b7 89            	pushw	x
 336  00b8 8d000000      	callf	f_UART3_Init
 338  00bc 5b08          	addw	sp,#8
 339                     ; 103 	UART3_Cmd(ENABLE);
 341  00be a601          	ld	a,#1
 342  00c0 8d000000      	callf	f_UART3_Cmd
 344                     ; 104 }
 347  00c4 87            	retf
 373                     ; 107 void ADC2_setup(void) {
 374                     	switch	.text
 375  00c5               f_ADC2_setup:
 379                     ; 108 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 381  00c5 ae1301        	ldw	x,#4865
 382  00c8 8d000000      	callf	f_CLK_PeripheralClockConfig
 384                     ; 109 	ADC2_DeInit();
 386  00cc 8d000000      	callf	f_ADC2_DeInit
 388                     ; 111 	ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
 388                     ; 112 						ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6, DISABLE);
 390  00d0 4b00          	push	#0
 391  00d2 4b07          	push	#7
 392  00d4 4b08          	push	#8
 393  00d6 4b00          	push	#0
 394  00d8 4b01          	push	#1
 395  00da 4b00          	push	#0
 396  00dc ae0105        	ldw	x,#261
 397  00df 8d000000      	callf	f_ADC2_Init
 399  00e3 5b06          	addw	sp,#6
 400                     ; 114 	ADC2_Cmd(ENABLE);
 402  00e5 a601          	ld	a,#1
 403  00e7 8d000000      	callf	f_ADC2_Cmd
 405                     ; 115 }
 408  00eb 87            	retf
 450                     ; 118 uint32_t elapsedTime(uint32_t start, uint32_t end) {
 451                     	switch	.text
 452  00ec               f_elapsedTime:
 454       00000000      OFST:	set	0
 457                     ; 119 	return (end >= start) ? (end - start) : ((0xffffffff - start + 1) + end);
 459  00ec 96            	ldw	x,sp
 460  00ed 1c0008        	addw	x,#OFST+8
 461  00f0 8d000000      	callf	d_ltor
 463  00f4 96            	ldw	x,sp
 464  00f5 1c0004        	addw	x,#OFST+4
 465  00f8 8d000000      	callf	d_lcmp
 467  00fc 2512          	jrult	L02
 468  00fe 96            	ldw	x,sp
 469  00ff 1c0008        	addw	x,#OFST+8
 470  0102 8d000000      	callf	d_ltor
 472  0106 96            	ldw	x,sp
 473  0107 1c0004        	addw	x,#OFST+4
 474  010a 8d000000      	callf	d_lsub
 476  010e 2014          	jra	L22
 477  0110               L02:
 478  0110 96            	ldw	x,sp
 479  0111 1c0004        	addw	x,#OFST+4
 480  0114 8d000000      	callf	d_ltor
 482  0118 8d000000      	callf	d_lneg
 484  011c 96            	ldw	x,sp
 485  011d 1c0008        	addw	x,#OFST+8
 486  0120 8d000000      	callf	d_ladd
 488  0124               L22:
 491  0124 87            	retf
 538                     ; 123 unsigned int read_ADC_Channel(uint8_t channel) {
 539                     	switch	.text
 540  0125               f_read_ADC_Channel:
 542  0125 89            	pushw	x
 543       00000002      OFST:	set	2
 546                     ; 124 	unsigned int adcValue = 0;
 548                     ; 125 	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, channel, ADC2_ALIGN_RIGHT);
 550  0126 4b08          	push	#8
 551  0128 ae0100        	ldw	x,#256
 552  012b 97            	ld	xl,a
 553  012c 8d000000      	callf	f_ADC2_ConversionConfig
 555  0130 84            	pop	a
 556                     ; 126 	ADC2_StartConversion();
 558  0131 8d000000      	callf	f_ADC2_StartConversion
 561  0135               L561:
 562                     ; 128 	while (ADC2_GetFlagStatus() == RESET);
 564  0135 8d000000      	callf	f_ADC2_GetFlagStatus
 566  0139 4d            	tnz	a
 567  013a 27f9          	jreq	L561
 568                     ; 130 	adcValue = ADC2_GetConversionValue();
 570  013c 8d000000      	callf	f_ADC2_GetConversionValue
 572  0140 1f01          	ldw	(OFST-1,sp),x
 574                     ; 131 	ADC2_ClearFlag();
 576  0142 8d000000      	callf	f_ADC2_ClearFlag
 578                     ; 132 	return adcValue;
 580  0146 1e01          	ldw	x,(OFST-1,sp)
 583  0148 5b02          	addw	sp,#2
 584  014a 87            	retf
 657                     ; 136 bool detectZeroCross(float previousSample, float currentSample, float threshold) {
 658                     	switch	.text
 659  014b               f_detectZeroCross:
 661       00000000      OFST:	set	0
 664                     ; 137 	if (crossingType == -1) {  // If no crossing type detected, check for both positive and negative
 666  014b be10          	ldw	x,_crossingType
 667  014d a3ffff        	cpw	x,#65535
 668  0150 2666          	jrne	L722
 669                     ; 138 		if (previousSample <= threshold && currentSample > threshold) {
 671  0152 9c            	rvf
 672  0153 96            	ldw	x,sp
 673  0154 1c0004        	addw	x,#OFST+4
 674  0157 8d000000      	callf	d_ltor
 676  015b 96            	ldw	x,sp
 677  015c 1c000c        	addw	x,#OFST+12
 678  015f 8d000000      	callf	d_fcmp
 680  0163 2c19          	jrsgt	L132
 682  0165 9c            	rvf
 683  0166 96            	ldw	x,sp
 684  0167 1c0008        	addw	x,#OFST+8
 685  016a 8d000000      	callf	d_ltor
 687  016e 96            	ldw	x,sp
 688  016f 1c000c        	addw	x,#OFST+12
 689  0172 8d000000      	callf	d_fcmp
 691  0176 2d06          	jrsle	L132
 692                     ; 139 			crossingType = 0;  // Positive zero crossing
 694  0178 5f            	clrw	x
 695  0179 bf10          	ldw	_crossingType,x
 696                     ; 140 			return true;
 698  017b a601          	ld	a,#1
 701  017d 87            	retf
 702  017e               L132:
 703                     ; 141 		} else if (previousSample >= -threshold && currentSample < -threshold) {
 705  017e 9c            	rvf
 706  017f 96            	ldw	x,sp
 707  0180 1c000c        	addw	x,#OFST+12
 708  0183 8d000000      	callf	d_ltor
 710  0187 8d000000      	callf	d_fneg
 712  018b 96            	ldw	x,sp
 713  018c 1c0004        	addw	x,#OFST+4
 714  018f 8d000000      	callf	d_fcmp
 716  0193 2d04          	jrsle	L03
 717  0195 ac1d021d      	jpf	L732
 718  0199               L03:
 720  0199 9c            	rvf
 721  019a 96            	ldw	x,sp
 722  019b 1c000c        	addw	x,#OFST+12
 723  019e 8d000000      	callf	d_ltor
 725  01a2 8d000000      	callf	d_fneg
 727  01a6 96            	ldw	x,sp
 728  01a7 1c0008        	addw	x,#OFST+8
 729  01aa 8d000000      	callf	d_fcmp
 731  01ae 2d6d          	jrsle	L732
 732                     ; 142 			crossingType = 1;  // Negative zero crossing
 734  01b0 ae0001        	ldw	x,#1
 735  01b3 bf10          	ldw	_crossingType,x
 736                     ; 143 			return true;
 738  01b5 a601          	ld	a,#1
 741  01b7 87            	retf
 742  01b8               L722:
 743                     ; 145 	} else if (crossingType == 0 && previousSample <= threshold && currentSample > threshold) {
 745  01b8 be10          	ldw	x,_crossingType
 746  01ba 2629          	jrne	L142
 748  01bc 9c            	rvf
 749  01bd 96            	ldw	x,sp
 750  01be 1c0004        	addw	x,#OFST+4
 751  01c1 8d000000      	callf	d_ltor
 753  01c5 96            	ldw	x,sp
 754  01c6 1c000c        	addw	x,#OFST+12
 755  01c9 8d000000      	callf	d_fcmp
 757  01cd 2c16          	jrsgt	L142
 759  01cf 9c            	rvf
 760  01d0 96            	ldw	x,sp
 761  01d1 1c0008        	addw	x,#OFST+8
 762  01d4 8d000000      	callf	d_ltor
 764  01d8 96            	ldw	x,sp
 765  01d9 1c000c        	addw	x,#OFST+12
 766  01dc 8d000000      	callf	d_fcmp
 768  01e0 2d03          	jrsle	L142
 769                     ; 146 			return true;  // Positive zero crossing
 771  01e2 a601          	ld	a,#1
 774  01e4 87            	retf
 775  01e5               L142:
 776                     ; 147 	} else if (crossingType == 1 && previousSample >= -threshold && currentSample < -threshold) {
 778  01e5 be10          	ldw	x,_crossingType
 779  01e7 a30001        	cpw	x,#1
 780  01ea 2631          	jrne	L732
 782  01ec 9c            	rvf
 783  01ed 96            	ldw	x,sp
 784  01ee 1c000c        	addw	x,#OFST+12
 785  01f1 8d000000      	callf	d_ltor
 787  01f5 8d000000      	callf	d_fneg
 789  01f9 96            	ldw	x,sp
 790  01fa 1c0004        	addw	x,#OFST+4
 791  01fd 8d000000      	callf	d_fcmp
 793  0201 2c1a          	jrsgt	L732
 795  0203 9c            	rvf
 796  0204 96            	ldw	x,sp
 797  0205 1c000c        	addw	x,#OFST+12
 798  0208 8d000000      	callf	d_ltor
 800  020c 8d000000      	callf	d_fneg
 802  0210 96            	ldw	x,sp
 803  0211 1c0008        	addw	x,#OFST+8
 804  0214 8d000000      	callf	d_fcmp
 806  0218 2d03          	jrsle	L732
 807                     ; 148 			return true;  // Negative zero crossing
 809  021a a601          	ld	a,#1
 812  021c 87            	retf
 813  021d               L732:
 814                     ; 151 	return false;  // No zero crossing detected
 816  021d 4f            	clr	a
 819  021e 87            	retf
 871                     ; 155 bool detectPosZeroCross(float previousSample, float currentSample, float threshold) {
 872                     	switch	.text
 873  021f               f_detectPosZeroCross:
 875       00000000      OFST:	set	0
 878                     ; 156 	return (previousSample <= threshold && currentSample > threshold);
 880  021f 9c            	rvf
 881  0220 96            	ldw	x,sp
 882  0221 1c0004        	addw	x,#OFST+4
 883  0224 8d000000      	callf	d_ltor
 885  0228 96            	ldw	x,sp
 886  0229 1c000c        	addw	x,#OFST+12
 887  022c 8d000000      	callf	d_fcmp
 889  0230 2c17          	jrsgt	L43
 890  0232 9c            	rvf
 891  0233 96            	ldw	x,sp
 892  0234 1c0008        	addw	x,#OFST+8
 893  0237 8d000000      	callf	d_ltor
 895  023b 96            	ldw	x,sp
 896  023c 1c000c        	addw	x,#OFST+12
 897  023f 8d000000      	callf	d_fcmp
 899  0243 2d04          	jrsle	L43
 900  0245 a601          	ld	a,#1
 901  0247 2001          	jra	L63
 902  0249               L43:
 903  0249 4f            	clr	a
 904  024a               L63:
 907  024a 87            	retf
 978                     ; 160 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
 979                     	switch	.text
 980  024b               f_calculate_amplitude:
 982  024b 89            	pushw	x
 983  024c 520c          	subw	sp,#12
 984       0000000c      OFST:	set	12
 987                     ; 161 	uint32_t i = 0;
 989                     ; 162 	float max_val = -V_REF, min_val = V_REF;
 991  024e ce102f        	ldw	x,L733+2
 992  0251 1f03          	ldw	(OFST-9,sp),x
 993  0253 ce102d        	ldw	x,L733
 994  0256 1f01          	ldw	(OFST-11,sp),x
 998  0258 ce1033        	ldw	x,L743+2
 999  025b 1f07          	ldw	(OFST-5,sp),x
1000  025d ce1031        	ldw	x,L743
1001  0260 1f05          	ldw	(OFST-7,sp),x
1003                     ; 164 	for (i = 0; i < sample_size; i++) {
1005  0262 ae0000        	ldw	x,#0
1006  0265 1f0b          	ldw	(OFST-1,sp),x
1007  0267 ae0000        	ldw	x,#0
1008  026a 1f09          	ldw	(OFST-3,sp),x
1011  026c 2058          	jra	L753
1012  026e               L353:
1013                     ; 165 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1015  026e 9c            	rvf
1016  026f 1e0b          	ldw	x,(OFST-1,sp)
1017  0271 58            	sllw	x
1018  0272 58            	sllw	x
1019  0273 72fb0d        	addw	x,(OFST+1,sp)
1020  0276 8d000000      	callf	d_ltor
1022  027a 96            	ldw	x,sp
1023  027b 1c0001        	addw	x,#OFST-11
1024  027e 8d000000      	callf	d_fcmp
1026  0282 2d11          	jrsle	L363
1029  0284 1e0b          	ldw	x,(OFST-1,sp)
1030  0286 58            	sllw	x
1031  0287 58            	sllw	x
1032  0288 72fb0d        	addw	x,(OFST+1,sp)
1033  028b 9093          	ldw	y,x
1034  028d ee02          	ldw	x,(2,x)
1035  028f 1f03          	ldw	(OFST-9,sp),x
1036  0291 93            	ldw	x,y
1037  0292 fe            	ldw	x,(x)
1038  0293 1f01          	ldw	(OFST-11,sp),x
1040  0295               L363:
1041                     ; 166 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1043  0295 9c            	rvf
1044  0296 1e0b          	ldw	x,(OFST-1,sp)
1045  0298 58            	sllw	x
1046  0299 58            	sllw	x
1047  029a 72fb0d        	addw	x,(OFST+1,sp)
1048  029d 8d000000      	callf	d_ltor
1050  02a1 96            	ldw	x,sp
1051  02a2 1c0005        	addw	x,#OFST-7
1052  02a5 8d000000      	callf	d_fcmp
1054  02a9 2e11          	jrsge	L563
1057  02ab 1e0b          	ldw	x,(OFST-1,sp)
1058  02ad 58            	sllw	x
1059  02ae 58            	sllw	x
1060  02af 72fb0d        	addw	x,(OFST+1,sp)
1061  02b2 9093          	ldw	y,x
1062  02b4 ee02          	ldw	x,(2,x)
1063  02b6 1f07          	ldw	(OFST-5,sp),x
1064  02b8 93            	ldw	x,y
1065  02b9 fe            	ldw	x,(x)
1066  02ba 1f05          	ldw	(OFST-7,sp),x
1068  02bc               L563:
1069                     ; 164 	for (i = 0; i < sample_size; i++) {
1071  02bc 96            	ldw	x,sp
1072  02bd 1c0009        	addw	x,#OFST-3
1073  02c0 a601          	ld	a,#1
1074  02c2 8d000000      	callf	d_lgadc
1077  02c6               L753:
1080  02c6 96            	ldw	x,sp
1081  02c7 1c0009        	addw	x,#OFST-3
1082  02ca 8d000000      	callf	d_ltor
1084  02ce 96            	ldw	x,sp
1085  02cf 1c0012        	addw	x,#OFST+6
1086  02d2 8d000000      	callf	d_lcmp
1088  02d6 2596          	jrult	L353
1089                     ; 169 	return (max_val - min_val);
1091  02d8 96            	ldw	x,sp
1092  02d9 1c0001        	addw	x,#OFST-11
1093  02dc 8d000000      	callf	d_ltor
1095  02e0 96            	ldw	x,sp
1096  02e1 1c0005        	addw	x,#OFST-7
1097  02e4 8d000000      	callf	d_fsub
1101  02e8 5b0e          	addw	sp,#14
1102  02ea 87            	retf
1146                     ; 173 void initialize_adc_buffer(float buffer[]) {
1147                     	switch	.text
1148  02eb               f_initialize_adc_buffer:
1150  02eb 89            	pushw	x
1151  02ec 89            	pushw	x
1152       00000002      OFST:	set	2
1155                     ; 174 	uint16_t i = 0;
1157                     ; 175 	for (i = 0; i < NUM_SAMPLES; i++) {
1159  02ed 5f            	clrw	x
1160  02ee 1f01          	ldw	(OFST-1,sp),x
1162  02f0               L114:
1163                     ; 176 		buffer[i] = -1;  // Reset each element of the ADC buffer
1165  02f0 1e01          	ldw	x,(OFST-1,sp)
1166  02f2 58            	sllw	x
1167  02f3 58            	sllw	x
1168  02f4 72fb03        	addw	x,(OFST+1,sp)
1169  02f7 90aeffff      	ldw	y,#65535
1170  02fb 51            	exgw	x,y
1171  02fc 8d000000      	callf	d_itof
1173  0300 51            	exgw	x,y
1174  0301 8d000000      	callf	d_rtol
1176                     ; 175 	for (i = 0; i < NUM_SAMPLES; i++) {
1178  0305 1e01          	ldw	x,(OFST-1,sp)
1179  0307 1c0001        	addw	x,#1
1180  030a 1f01          	ldw	(OFST-1,sp),x
1184  030c 1e01          	ldw	x,(OFST-1,sp)
1185  030e a30400        	cpw	x,#1024
1186  0311 25dd          	jrult	L114
1187                     ; 178 }
1190  0313 5b04          	addw	sp,#4
1191  0315 87            	retf
1193                     .const:	section	.text
1194  0000               L714_buffer:
1195  0000 00000000      	dc.w	0,0
1196  0004 000000000000  	ds.b	4092
1368                     ; 180 float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
1369                     	switch	.text
1370  0316               f_process_adc_signal:
1372  0316 88            	push	a
1373  0317 96            	ldw	x,sp
1374  0318 1d102c        	subw	x,#4140
1375  031b 94            	ldw	sp,x
1376       0000102c      OFST:	set	4140
1379                     ; 181 	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
1381  031c 96            	ldw	x,sp
1382  031d 1c0027        	addw	x,#OFST-4101
1383  0320 90ae0000      	ldw	y,#L714_buffer
1384  0324 bf00          	ldw	c_x,x
1385  0326 ae1000        	ldw	x,#4096
1386  0329 8d000000      	callf	d_xymovl
1388                     ; 182 	unsigned long currentEdgeTime = 0;
1390                     ; 183 	float freqBuff = 0;
1392  032d ae0000        	ldw	x,#0
1393  0330 1f1d          	ldw	(OFST-4111,sp),x
1394  0332 ae0000        	ldw	x,#0
1395  0335 1f1b          	ldw	(OFST-4113,sp),x
1397                     ; 184 	int freqCount = 0;
1399  0337 5f            	clrw	x
1400  0338 1f1f          	ldw	(OFST-4109,sp),x
1402                     ; 185 	uint16_t i = 0, count = 0;
1406  033a 96            	ldw	x,sp
1407  033b 905f          	clrw	y
1408  033d df1027        	ldw	(OFST-5,x),y
1409                     ; 186 	float lastStoredValue = 0.0;       // Track the last stored ADC voltage
1411  0340 ce1059        	ldw	x,L73+2
1412  0343 1f24          	ldw	(OFST-4104,sp),x
1413  0345 ce1057        	ldw	x,L73
1414  0348 1f22          	ldw	(OFST-4106,sp),x
1416                     ; 187 	bool isChannel1 = (channel == VAR_SIGNAL);
1418  034a 96            	ldw	x,sp
1419  034b d6102d        	ld	a,(OFST+1,x)
1420  034e a105          	cp	a,#5
1421  0350 2605          	jrne	L64
1422  0352 ae0001        	ldw	x,#1
1423  0355 2001          	jra	L05
1424  0357               L64:
1425  0357 5f            	clrw	x
1426  0358               L05:
1427  0358 01            	rrwa	x,a
1428  0359 6b21          	ld	(OFST-4107,sp),a
1429  035b 02            	rlwa	x,a
1431                     ; 188 	bool firstSample = true;           // Flag for first sample storage
1433  035c a601          	ld	a,#1
1434  035e 6b26          	ld	(OFST-4102,sp),a
1436                     ; 189 	lastEdgeTime = 0;                 // Reset last zero-crossing time
1438  0360 ae0000        	ldw	x,#0
1439  0363 bf0a          	ldw	_lastEdgeTime+2,x
1440  0365 ae0000        	ldw	x,#0
1441  0368 bf08          	ldw	_lastEdgeTime,x
1443  036a acc804c8      	jpf	L335
1444  036e               L725:
1445                     ; 194 		float currentVoltage = convert_adc_to_voltage(read_ADC_Channel(channel));
1447  036e 96            	ldw	x,sp
1448  036f d6102d        	ld	a,(OFST+1,x)
1449  0372 8d250125      	callf	f_read_ADC_Channel
1451  0376 8d080608      	callf	f_convert_adc_to_voltage
1453  037a 96            	ldw	x,sp
1454  037b 1c1029        	addw	x,#OFST-3
1455  037e 8d000000      	callf	d_rtol
1457                     ; 197 		if (firstSample || fabs(currentVoltage - lastStoredValue) >= 0.01) {
1459  0382 0d26          	tnz	(OFST-4102,sp)
1460  0384 262b          	jrne	L145
1462  0386 9c            	rvf
1463  0387 96            	ldw	x,sp
1464  0388 1c1029        	addw	x,#OFST-3
1465  038b 8d000000      	callf	d_ltor
1467  038f 96            	ldw	x,sp
1468  0390 1c0022        	addw	x,#OFST-4106
1469  0393 8d000000      	callf	d_fsub
1471  0397 be02          	ldw	x,c_lreg+2
1472  0399 89            	pushw	x
1473  039a be00          	ldw	x,c_lreg
1474  039c 89            	pushw	x
1475  039d 8d000000      	callf	f_fabs
1477  03a1 9c            	rvf
1478  03a2 5b04          	addw	sp,#4
1479  03a4 ae1029        	ldw	x,#L745
1480  03a7 8d000000      	callf	d_fcmp
1482  03ab 2e04          	jrsge	L25
1483  03ad acc804c8      	jpf	L335
1484  03b1               L25:
1485  03b1               L145:
1486                     ; 198 			buffer[count] = currentVoltage;
1488  03b1 96            	ldw	x,sp
1489  03b2 9096          	ldw	y,sp
1490  03b4 72a90027      	addw	y,#OFST-4101
1491  03b8 170f          	ldw	(OFST-4125,sp),y
1493  03ba 9096          	ldw	y,sp
1494  03bc 90de1027      	ldw	y,(OFST-5,y)
1495  03c0 9058          	sllw	y
1496  03c2 9058          	sllw	y
1497  03c4 72f90f        	addw	y,(OFST-4125,sp)
1498  03c7 d6102c        	ld	a,(OFST+0,x)
1499  03ca 90e703        	ld	(3,y),a
1500  03cd d6102b        	ld	a,(OFST-1,x)
1501  03d0 90e702        	ld	(2,y),a
1502  03d3 d6102a        	ld	a,(OFST-2,x)
1503  03d6 90e701        	ld	(1,y),a
1504  03d9 d61029        	ld	a,(OFST-3,x)
1505  03dc 90f7          	ld	(y),a
1506                     ; 199 			printf("%.4f " ,currentVoltage);    // Less than 0.3 fluctation in a dc signal.
1508  03de 96            	ldw	x,sp
1509  03df 9093          	ldw	y,x
1510  03e1 de102b        	ldw	x,(OFST-1,x)
1511  03e4 89            	pushw	x
1512  03e5 93            	ldw	x,y
1513  03e6 de1029        	ldw	x,(OFST-3,x)
1514  03e9 89            	pushw	x
1515  03ea ae1023        	ldw	x,#L355
1516  03ed 8d000000      	callf	f_printf
1518  03f1 5b04          	addw	sp,#4
1519                     ; 200 			lastStoredValue = currentVoltage;
1521  03f3 96            	ldw	x,sp
1522  03f4 9093          	ldw	y,x
1523  03f6 de102b        	ldw	x,(OFST-1,x)
1524  03f9 1f24          	ldw	(OFST-4104,sp),x
1525  03fb 93            	ldw	x,y
1526  03fc de1029        	ldw	x,(OFST-3,x)
1527  03ff 1f22          	ldw	(OFST-4106,sp),x
1529                     ; 201 			firstSample = false;  // First sample has been stored
1531  0401 0f26          	clr	(OFST-4102,sp)
1533                     ; 202 			count++;
1535  0403 96            	ldw	x,sp
1536  0404 9093          	ldw	y,x
1537  0406 de1027        	ldw	x,(OFST-5,x)
1538  0409 1c0001        	addw	x,#1
1539  040c 90df1027      	ldw	(OFST-5,y),x
1540                     ; 205 			if (isChannel1 && (frequency != NULL) && count > 1) {
1542  0410 0d21          	tnz	(OFST-4107,sp)
1543  0412 2604          	jrne	L45
1544  0414 acc804c8      	jpf	L335
1545  0418               L45:
1547  0418 96            	ldw	x,sp
1548  0419 d61032        	ld	a,(OFST+6,x)
1549  041c da1031        	or	a,(OFST+5,x)
1550  041f 2604          	jrne	L65
1551  0421 acc804c8      	jpf	L335
1552  0425               L65:
1554  0425 96            	ldw	x,sp
1555  0426 9093          	ldw	y,x
1556  0428 90de1027      	ldw	y,(OFST-5,y)
1557  042c 90a30002      	cpw	y,#2
1558  0430 2404          	jruge	L06
1559  0432 acc804c8      	jpf	L335
1560  0436               L06:
1561                     ; 206 				if (detectZeroCross(buffer[count - 2], buffer[count - 1], ZEROCROSS_THRESHOLD)) {
1563  0436 ce1021        	ldw	x,L565+2
1564  0439 89            	pushw	x
1565  043a ce101f        	ldw	x,L565
1566  043d 89            	pushw	x
1567  043e 96            	ldw	x,sp
1568  043f 1c002b        	addw	x,#OFST-4097
1569  0442 1f13          	ldw	(OFST-4121,sp),x
1571  0444 96            	ldw	x,sp
1572  0445 de102b        	ldw	x,(OFST-1,x)
1573  0448 58            	sllw	x
1574  0449 58            	sllw	x
1575  044a 1d0004        	subw	x,#4
1576  044d 72fb13        	addw	x,(OFST-4121,sp)
1577  0450 9093          	ldw	y,x
1578  0452 ee02          	ldw	x,(2,x)
1579  0454 89            	pushw	x
1580  0455 93            	ldw	x,y
1581  0456 fe            	ldw	x,(x)
1582  0457 89            	pushw	x
1583  0458 96            	ldw	x,sp
1584  0459 1c002f        	addw	x,#OFST-4093
1585  045c 1f15          	ldw	(OFST-4119,sp),x
1587  045e 96            	ldw	x,sp
1588  045f de102f        	ldw	x,(OFST+3,x)
1589  0462 58            	sllw	x
1590  0463 58            	sllw	x
1591  0464 1d0008        	subw	x,#8
1592  0467 72fb15        	addw	x,(OFST-4119,sp)
1593  046a 9093          	ldw	y,x
1594  046c ee02          	ldw	x,(2,x)
1595  046e 89            	pushw	x
1596  046f 93            	ldw	x,y
1597  0470 fe            	ldw	x,(x)
1598  0471 89            	pushw	x
1599  0472 8d4b014b      	callf	f_detectZeroCross
1601  0476 5b0c          	addw	sp,#12
1602  0478 4d            	tnz	a
1603  0479 274d          	jreq	L335
1604                     ; 207 					currentEdgeTime = micros();
1606  047b 8d000000      	callf	f_micros
1608  047f 96            	ldw	x,sp
1609  0480 1c1029        	addw	x,#OFST-3
1610  0483 8d000000      	callf	d_rtol
1612                     ; 208 					if (lastEdgeTime > 0) {  
1614  0487 ae0008        	ldw	x,#_lastEdgeTime
1615  048a 8d000000      	callf	d_lzmp
1617  048e 272a          	jreq	L175
1618                     ; 209 						unsigned long period = currentEdgeTime - lastEdgeTime;
1620  0490 96            	ldw	x,sp
1621  0491 1c1029        	addw	x,#OFST-3
1622  0494 8d000000      	callf	d_ltor
1624  0498 ae0008        	ldw	x,#_lastEdgeTime
1625  049b 8d000000      	callf	d_lsub
1627  049f 96            	ldw	x,sp
1628  04a0 1c0015        	addw	x,#OFST-4119
1629  04a3 8d000000      	callf	d_rtol
1632                     ; 210 						float singleFrequency = calculate_frequency(period);
1634  04a7 1e17          	ldw	x,(OFST-4117,sp)
1635  04a9 89            	pushw	x
1636  04aa 1e17          	ldw	x,(OFST-4117,sp)
1637  04ac 89            	pushw	x
1638  04ad 8d140614      	callf	f_calculate_frequency
1640  04b1 5b04          	addw	sp,#4
1641                     ; 211 						freqCount++;
1643  04b3 1e1f          	ldw	x,(OFST-4109,sp)
1644  04b5 1c0001        	addw	x,#1
1645  04b8 1f1f          	ldw	(OFST-4109,sp),x
1647  04ba               L175:
1648                     ; 225 					lastEdgeTime = currentEdgeTime;
1650  04ba 96            	ldw	x,sp
1651  04bb 9093          	ldw	y,x
1652  04bd de102b        	ldw	x,(OFST-1,x)
1653  04c0 bf0a          	ldw	_lastEdgeTime+2,x
1654  04c2 93            	ldw	x,y
1655  04c3 de1029        	ldw	x,(OFST-3,x)
1656  04c6 bf08          	ldw	_lastEdgeTime,x
1657  04c8               L335:
1658                     ; 193 	while (count < NUM_SAMPLES) {  
1660  04c8 96            	ldw	x,sp
1661  04c9 9093          	ldw	y,x
1662  04cb 90de1027      	ldw	y,(OFST-5,y)
1663  04cf 90a30400      	cpw	y,#1024
1664  04d3 2404          	jruge	L26
1665  04d5 ac6e036e      	jpf	L725
1666  04d9               L26:
1667                     ; 232 	*amplitude = calculate_amplitude(buffer, count);
1669  04d9 96            	ldw	x,sp
1670  04da de1027        	ldw	x,(OFST-5,x)
1671  04dd 8d000000      	callf	d_uitolx
1673  04e1 be02          	ldw	x,c_lreg+2
1674  04e3 89            	pushw	x
1675  04e4 be00          	ldw	x,c_lreg
1676  04e6 89            	pushw	x
1677  04e7 96            	ldw	x,sp
1678  04e8 1c002b        	addw	x,#OFST-4097
1679  04eb 8d4b024b      	callf	f_calculate_amplitude
1681  04ef 5b04          	addw	sp,#4
1682  04f1 96            	ldw	x,sp
1683  04f2 de1033        	ldw	x,(OFST+7,x)
1684  04f5 8d000000      	callf	d_rtol
1686                     ; 234 	if (isChannel1 && freqCount > 0) {
1688  04f9 0d21          	tnz	(OFST-4107,sp)
1689  04fb 272d          	jreq	L375
1691  04fd 9c            	rvf
1692  04fe 1e1f          	ldw	x,(OFST-4109,sp)
1693  0500 2d28          	jrsle	L375
1694                     ; 235 		*frequency = freqBuff / freqCount;
1696  0502 1e1f          	ldw	x,(OFST-4109,sp)
1697  0504 8d000000      	callf	d_itof
1699  0508 96            	ldw	x,sp
1700  0509 1c000d        	addw	x,#OFST-4127
1701  050c 8d000000      	callf	d_rtol
1704  0510 96            	ldw	x,sp
1705  0511 1c001b        	addw	x,#OFST-4113
1706  0514 8d000000      	callf	d_ltor
1708  0518 96            	ldw	x,sp
1709  0519 1c000d        	addw	x,#OFST-4127
1710  051c 8d000000      	callf	d_fdiv
1712  0520 96            	ldw	x,sp
1713  0521 de1031        	ldw	x,(OFST+5,x)
1714  0524 8d000000      	callf	d_rtol
1717  0528 2017          	jra	L575
1718  052a               L375:
1719                     ; 236 	} else if (isChannel1) {
1721  052a 0d21          	tnz	(OFST-4107,sp)
1722  052c 2713          	jreq	L575
1723                     ; 237 		*frequency = 0;
1725  052e 96            	ldw	x,sp
1726  052f de1031        	ldw	x,(OFST+5,x)
1727  0532 a600          	ld	a,#0
1728  0534 e703          	ld	(3,x),a
1729  0536 a600          	ld	a,#0
1730  0538 e702          	ld	(2,x),a
1731  053a a600          	ld	a,#0
1732  053c e701          	ld	(1,x),a
1733  053e a600          	ld	a,#0
1734  0540 f7            	ld	(x),a
1735  0541               L575:
1736                     ; 240 	return *amplitude;
1738  0541 96            	ldw	x,sp
1739  0542 de1033        	ldw	x,(OFST+7,x)
1740  0545 8d000000      	callf	d_ltor
1744  0549 9096          	ldw	y,sp
1745  054b 72a9102d      	addw	y,#4141
1746  054f 9094          	ldw	sp,y
1747  0551 87            	retf
1826                     ; 245 float process_FDR_samples(float buffer[]) {
1827                     	switch	.text
1828  0552               f_process_FDR_samples:
1830  0552 89            	pushw	x
1831  0553 520c          	subw	sp,#12
1832       0000000c      OFST:	set	12
1835                     ; 246 	int ZCount = 0;
1837  0555 5f            	clrw	x
1838  0556 1f09          	ldw	(OFST-3,sp),x
1840                     ; 247 	uint16_t i = 0;
1842                     ; 249 	for (i = 0; i < NUM_SAMPLES; i++) {
1844  0558 5f            	clrw	x
1845  0559 1f0b          	ldw	(OFST-1,sp),x
1847  055b               L736:
1848                     ; 251 		buffer[i] = convert_adc_to_voltage(read_ADC_Channel(ADC2_CHANNEL_6));
1850  055b a606          	ld	a,#6
1851  055d 8d250125      	callf	f_read_ADC_Channel
1853  0561 8d080608      	callf	f_convert_adc_to_voltage
1855  0565 1e0b          	ldw	x,(OFST-1,sp)
1856  0567 58            	sllw	x
1857  0568 58            	sllw	x
1858  0569 72fb0d        	addw	x,(OFST+1,sp)
1859  056c 8d000000      	callf	d_rtol
1861                     ; 253 		delay_us(1000000 / SAMPLE_RATE);
1863  0570 ae1a0a        	ldw	x,#6666
1864  0573 8d000000      	callf	f_delay_us
1866                     ; 255 		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
1868  0577 1e0b          	ldw	x,(OFST-1,sp)
1869  0579 2754          	jreq	L546
1871  057b ce1021        	ldw	x,L565+2
1872  057e 89            	pushw	x
1873  057f ce101f        	ldw	x,L565
1874  0582 89            	pushw	x
1875  0583 1e0f          	ldw	x,(OFST+3,sp)
1876  0585 58            	sllw	x
1877  0586 58            	sllw	x
1878  0587 72fb11        	addw	x,(OFST+5,sp)
1879  058a 9093          	ldw	y,x
1880  058c ee02          	ldw	x,(2,x)
1881  058e 89            	pushw	x
1882  058f 93            	ldw	x,y
1883  0590 fe            	ldw	x,(x)
1884  0591 89            	pushw	x
1885  0592 1e13          	ldw	x,(OFST+7,sp)
1886  0594 58            	sllw	x
1887  0595 58            	sllw	x
1888  0596 1d0004        	subw	x,#4
1889  0599 72fb15        	addw	x,(OFST+9,sp)
1890  059c 9093          	ldw	y,x
1891  059e ee02          	ldw	x,(2,x)
1892  05a0 89            	pushw	x
1893  05a1 93            	ldw	x,y
1894  05a2 fe            	ldw	x,(x)
1895  05a3 89            	pushw	x
1896  05a4 8d4b014b      	callf	f_detectZeroCross
1898  05a8 5b0c          	addw	sp,#12
1899  05aa 4d            	tnz	a
1900  05ab 2722          	jreq	L546
1901                     ; 256 				unsigned long period = currentEdgeTime - lastEdgeTime;   // Calculate period
1903  05ad ae000c        	ldw	x,#_currentEdgeTime
1904  05b0 8d000000      	callf	d_ltor
1906  05b4 ae0008        	ldw	x,#_lastEdgeTime
1907  05b7 8d000000      	callf	d_lsub
1909                     ; 257 				ZCount++;
1911  05bb 1e09          	ldw	x,(OFST-3,sp)
1912  05bd 1c0001        	addw	x,#1
1913  05c0 1f09          	ldw	(OFST-3,sp),x
1915                     ; 258 				if (ZCount == 2)
1917  05c2 1e09          	ldw	x,(OFST-3,sp)
1918  05c4 a30002        	cpw	x,#2
1919  05c7 2606          	jrne	L546
1920                     ; 260 					count = i;    // for amplitude calculation limit bound
1922  05c9 1e0b          	ldw	x,(OFST-1,sp)
1923  05cb bf12          	ldw	_count,x
1924                     ; 261 					break;        // break when zeroCrossing detection is two
1926  05cd 2012          	jra	L346
1927  05cf               L546:
1928                     ; 249 	for (i = 0; i < NUM_SAMPLES; i++) {
1930  05cf 1e0b          	ldw	x,(OFST-1,sp)
1931  05d1 1c0001        	addw	x,#1
1932  05d4 1f0b          	ldw	(OFST-1,sp),x
1936  05d6 1e0b          	ldw	x,(OFST-1,sp)
1937  05d8 a30400        	cpw	x,#1024
1938  05db 2404ac5b055b  	jrult	L736
1939  05e1               L346:
1940                     ; 265 	amplitude = calculate_amplitude(buffer, count);
1942  05e1 be12          	ldw	x,_count
1943  05e3 8d000000      	callf	d_uitolx
1945  05e7 be02          	ldw	x,c_lreg+2
1946  05e9 89            	pushw	x
1947  05ea be00          	ldw	x,c_lreg
1948  05ec 89            	pushw	x
1949  05ed 1e11          	ldw	x,(OFST+5,sp)
1950  05ef 8d4b024b      	callf	f_calculate_amplitude
1952  05f3 5b04          	addw	sp,#4
1953  05f5 96            	ldw	x,sp
1954  05f6 1c0005        	addw	x,#OFST-7
1955  05f9 8d000000      	callf	d_rtol
1958                     ; 267 	return amplitude;
1960  05fd 96            	ldw	x,sp
1961  05fe 1c0005        	addw	x,#OFST-7
1962  0601 8d000000      	callf	d_ltor
1966  0605 5b0e          	addw	sp,#14
1967  0607 87            	retf
2001                     ; 271 float convert_adc_to_voltage(unsigned int adcValue) {
2002                     	switch	.text
2003  0608               f_convert_adc_to_voltage:
2007                     ; 272 	return adcValue * (V_REF / ADC_MAX_VALUE);
2009  0608 8d000000      	callf	d_uitof
2011  060c ae101b        	ldw	x,#L376
2012  060f 8d000000      	callf	d_fmul
2016  0613 87            	retf
2050                     ; 276 float calculate_frequency(unsigned long period) {
2051                     	switch	.text
2052  0614               f_calculate_frequency:
2054  0614 5204          	subw	sp,#4
2055       00000004      OFST:	set	4
2058                     ; 277 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
2060  0616 96            	ldw	x,sp
2061  0617 1c0008        	addw	x,#OFST+4
2062  061a 8d000000      	callf	d_ltor
2064  061e 8d000000      	callf	d_ultof
2066  0622 ae1013        	ldw	x,#L137
2067  0625 8d000000      	callf	d_fdiv
2069  0629 96            	ldw	x,sp
2070  062a 1c0001        	addw	x,#OFST-3
2071  062d 8d000000      	callf	d_rtol
2074  0631 ae1017        	ldw	x,#L127
2075  0634 8d000000      	callf	d_ltor
2077  0638 96            	ldw	x,sp
2078  0639 1c0001        	addw	x,#OFST-3
2079  063c 8d000000      	callf	d_fdiv
2083  0640 5b04          	addw	sp,#4
2084  0642 87            	retf
2138                     ; 281 void output_results(float frequency, float amplitude) {
2139                     	switch	.text
2140  0643               f_output_results:
2142  0643 5228          	subw	sp,#40
2143       00000028      OFST:	set	40
2146                     ; 287 	sprintf(buffer, "%.3f,%.3f,%.3f\n", frequency, amplitude, amplitude);
2148  0645 1e32          	ldw	x,(OFST+10,sp)
2149  0647 89            	pushw	x
2150  0648 1e32          	ldw	x,(OFST+10,sp)
2151  064a 89            	pushw	x
2152  064b 1e36          	ldw	x,(OFST+14,sp)
2153  064d 89            	pushw	x
2154  064e 1e36          	ldw	x,(OFST+14,sp)
2155  0650 89            	pushw	x
2156  0651 1e36          	ldw	x,(OFST+14,sp)
2157  0653 89            	pushw	x
2158  0654 1e36          	ldw	x,(OFST+14,sp)
2159  0656 89            	pushw	x
2160  0657 ae1003        	ldw	x,#L367
2161  065a 89            	pushw	x
2162  065b 96            	ldw	x,sp
2163  065c 1c000f        	addw	x,#OFST-25
2164  065f 8d000000      	callf	f_sprintf
2166  0663 5b0e          	addw	sp,#14
2167                     ; 290 	printf("%s", buffer);
2169  0665 96            	ldw	x,sp
2170  0666 1c0001        	addw	x,#OFST-39
2171  0669 89            	pushw	x
2172  066a ae1000        	ldw	x,#L567
2173  066d 8d000000      	callf	f_printf
2175  0671 85            	popw	x
2176                     ; 292 }
2179  0672 5b28          	addw	sp,#40
2180  0674 87            	retf
2215                     ; 295 PUTCHAR_PROTOTYPE {
2216                     	switch	.text
2217  0675               f_putchar:
2219  0675 88            	push	a
2220       00000000      OFST:	set	0
2223                     ; 296 	UART3_SendData8(c);
2225  0676 8d000000      	callf	f_UART3_SendData8
2228  067a               L7001:
2229                     ; 297 	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
2231  067a ae0080        	ldw	x,#128
2232  067d 8d000000      	callf	f_UART3_GetFlagStatus
2234  0681 4d            	tnz	a
2235  0682 27f6          	jreq	L7001
2236                     ; 298 	return c;
2238  0684 7b01          	ld	a,(OFST+1,sp)
2241  0686 5b01          	addw	sp,#1
2242  0688 87            	retf
2277                     ; 301 GETCHAR_PROTOTYPE
2277                     ; 302 {
2278                     	switch	.text
2279  0689               f_getchar:
2281  0689 88            	push	a
2282       00000001      OFST:	set	1
2285                     ; 303   char c = 0;
2288  068a               L3301:
2289                     ; 305   while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
2291  068a ae0020        	ldw	x,#32
2292  068d 8d000000      	callf	f_UART3_GetFlagStatus
2294  0691 4d            	tnz	a
2295  0692 27f6          	jreq	L3301
2296                     ; 306 	c = UART3_ReceiveData8();
2298  0694 8d000000      	callf	f_UART3_ReceiveData8
2300  0698 6b01          	ld	(OFST+0,sp),a
2302                     ; 307   return (c);
2304  069a 7b01          	ld	a,(OFST+0,sp)
2307  069c 5b01          	addw	sp,#1
2308  069e 87            	retf
2332                     ; 310 void UART3_ClearBuffer(void) {
2333                     	switch	.text
2334  069f               f_UART3_ClearBuffer:
2338  069f 2004          	jra	L1501
2339  06a1               L7401:
2340                     ; 312         (void)UART3_ReceiveData8(); // Clear any preexisting data
2342  06a1 8d000000      	callf	f_UART3_ReceiveData8
2344  06a5               L1501:
2345                     ; 311     while (UART3_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
2347  06a5 ae0020        	ldw	x,#32
2348  06a8 8d000000      	callf	f_UART3_GetFlagStatus
2350  06ac 4d            	tnz	a
2351  06ad 26f2          	jrne	L7401
2352                     ; 314 }
2355  06af 87            	retf
2419                     ; 316 void UART3_ReceiveString(char *buffer, uint16_t max_length) {
2420                     	switch	.text
2421  06b0               f_UART3_ReceiveString:
2423  06b0 89            	pushw	x
2424  06b1 5203          	subw	sp,#3
2425       00000003      OFST:	set	3
2428                     ; 317     uint16_t i = 0;
2430                     ; 320     for (i = 0; i < max_length; i++) {
2432  06b3 5f            	clrw	x
2433  06b4 1f02          	ldw	(OFST-1,sp),x
2436  06b6 200d          	jra	L3111
2437  06b8               L7011:
2438                     ; 321         buffer[i] = '\0';
2440  06b8 1e04          	ldw	x,(OFST+1,sp)
2441  06ba 72fb02        	addw	x,(OFST-1,sp)
2442  06bd 7f            	clr	(x)
2443                     ; 320     for (i = 0; i < max_length; i++) {
2445  06be 1e02          	ldw	x,(OFST-1,sp)
2446  06c0 1c0001        	addw	x,#1
2447  06c3 1f02          	ldw	(OFST-1,sp),x
2449  06c5               L3111:
2452  06c5 1e02          	ldw	x,(OFST-1,sp)
2453  06c7 1309          	cpw	x,(OFST+6,sp)
2454  06c9 25ed          	jrult	L7011
2455                     ; 323     i = 0;
2457  06cb 5f            	clrw	x
2458  06cc 1f02          	ldw	(OFST-1,sp),x
2461  06ce 202c          	jra	L3211
2462  06d0               L1311:
2463                     ; 327         while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
2465  06d0 ae0020        	ldw	x,#32
2466  06d3 8d000000      	callf	f_UART3_GetFlagStatus
2468  06d7 4d            	tnz	a
2469  06d8 27f6          	jreq	L1311
2470                     ; 329         receivedChar = UART3_ReceiveData8();
2472  06da 8d000000      	callf	f_UART3_ReceiveData8
2474  06de 6b01          	ld	(OFST-2,sp),a
2476                     ; 331         if (receivedChar == '\n' || receivedChar == '\r') {
2478  06e0 7b01          	ld	a,(OFST-2,sp)
2479  06e2 a10a          	cp	a,#10
2480  06e4 271d          	jreq	L5211
2482  06e6 7b01          	ld	a,(OFST-2,sp)
2483  06e8 a10d          	cp	a,#13
2484  06ea 2717          	jreq	L5211
2485                     ; 335         buffer[i++] = receivedChar;
2487  06ec 7b01          	ld	a,(OFST-2,sp)
2488  06ee 1e02          	ldw	x,(OFST-1,sp)
2489  06f0 1c0001        	addw	x,#1
2490  06f3 1f02          	ldw	(OFST-1,sp),x
2491  06f5 1d0001        	subw	x,#1
2493  06f8 72fb04        	addw	x,(OFST+1,sp)
2494  06fb f7            	ld	(x),a
2495  06fc               L3211:
2496                     ; 326     while (i < max_length - 1) {
2498  06fc 1e09          	ldw	x,(OFST+6,sp)
2499  06fe 5a            	decw	x
2500  06ff 1302          	cpw	x,(OFST-1,sp)
2501  0701 22cd          	jrugt	L1311
2502  0703               L5211:
2503                     ; 338     buffer[i] = '\0'; // Null-terminate the string
2505  0703 1e04          	ldw	x,(OFST+1,sp)
2506  0705 72fb02        	addw	x,(OFST-1,sp)
2507  0708 7f            	clr	(x)
2508                     ; 339 }
2511  0709 5b05          	addw	sp,#5
2512  070b 87            	retf
2580                     	xdef	f_main
2581                     	xdef	f_UART3_ReceiveString
2582                     	xdef	f_UART3_ClearBuffer
2583                     	xdef	f_process_FDR_samples
2584                     	xdef	f_calculate_frequency
2585                     	xdef	f_convert_adc_to_voltage
2586                     	xdef	f_process_adc_signal
2587                     	xdef	f_calculate_amplitude
2588                     	xdef	f_output_results
2589                     	xdef	f_initialize_adc_buffer
2590                     	xdef	f_detectZeroCross
2591                     	xdef	f_detectPosZeroCross
2592                     	xdef	f_read_ADC_Channel
2593                     	xdef	f_elapsedTime
2594                     	xdef	f_ADC2_setup
2595                     	xdef	f_UART3_setup
2596                     	xdef	f_clock_setup
2597                     	xdef	f_initialize_system
2598                     	xdef	_count
2599                     	xdef	_crossingType
2600                     	xdef	_currentEdgeTime
2601                     	xdef	_lastEdgeTime
2602                     	xdef	_sine1_amplitude
2603                     	xdef	_sine1_frequency
2604                     	xref	f_fabs
2605                     	xref	f_micros
2606                     	xref	f_delay_us
2607                     	xref	f_TIM4_Config
2608                     	xref	f_sprintf
2609                     	xdef	f_putchar
2610                     	xref	f_printf
2611                     	xdef	f_getchar
2612                     	xref	f_UART3_GetFlagStatus
2613                     	xref	f_UART3_SendData8
2614                     	xref	f_UART3_ReceiveData8
2615                     	xref	f_UART3_Cmd
2616                     	xref	f_UART3_Init
2617                     	xref	f_UART3_DeInit
2618                     	xref	f_GPIO_Init
2619                     	xref	f_GPIO_DeInit
2620                     	xref	f_CLK_GetFlagStatus
2621                     	xref	f_CLK_SYSCLKConfig
2622                     	xref	f_CLK_HSIPrescalerConfig
2623                     	xref	f_CLK_ClockSwitchConfig
2624                     	xref	f_CLK_PeripheralClockConfig
2625                     	xref	f_CLK_ClockSwitchCmd
2626                     	xref	f_CLK_LSICmd
2627                     	xref	f_CLK_HSICmd
2628                     	xref	f_CLK_HSECmd
2629                     	xref	f_CLK_DeInit
2630                     	xref	f_ADC2_ClearFlag
2631                     	xref	f_ADC2_GetFlagStatus
2632                     	xref	f_ADC2_GetConversionValue
2633                     	xref	f_ADC2_StartConversion
2634                     	xref	f_ADC2_ConversionConfig
2635                     	xref	f_ADC2_Cmd
2636                     	xref	f_ADC2_Init
2637                     	xref	f_ADC2_DeInit
2638                     	switch	.const
2639  1000               L567:
2640  1000 257300        	dc.b	"%s",0
2641  1003               L367:
2642  1003 252e33662c25  	dc.b	"%.3f,%.3f,%.3f",10,0
2643  1013               L137:
2644  1013 49742400      	dc.w	18804,9216
2645  1017               L127:
2646  1017 3f800000      	dc.w	16256,0
2647  101b               L376:
2648  101b 3b954409      	dc.w	15253,17417
2649  101f               L565:
2650  101f 3f8ccccc      	dc.w	16268,-13108
2651  1023               L355:
2652  1023 252e34662000  	dc.b	"%.4f ",0
2653  1029               L745:
2654  1029 3c23d70a      	dc.w	15395,-10486
2655  102d               L733:
2656  102d c0951eb8      	dc.w	-16235,7864
2657  1031               L743:
2658  1031 40951eb8      	dc.w	16533,7864
2659  1035               L75:
2660  1035 53797374656d  	dc.b	"System Initializat"
2661  1047 696f6e20436f  	dc.b	"ion Completed",10
2662  1055 0d00          	dc.b	13,0
2663  1057               L73:
2664  1057 00000000      	dc.w	0,0
2665                     	xref.b	c_lreg
2666                     	xref.b	c_x
2667                     	xref.b	c_y
2687                     	xref	d_ultof
2688                     	xref	d_fmul
2689                     	xref	d_uitof
2690                     	xref	d_fdiv
2691                     	xref	d_uitolx
2692                     	xref	d_lzmp
2693                     	xref	d_xymovl
2694                     	xref	d_itof
2695                     	xref	d_fsub
2696                     	xref	d_lgadc
2697                     	xref	d_fneg
2698                     	xref	d_fcmp
2699                     	xref	d_ladd
2700                     	xref	d_lneg
2701                     	xref	d_lsub
2702                     	xref	d_lcmp
2703                     	xref	d_ltor
2704                     	xref	d_rtol
2705                     	end
