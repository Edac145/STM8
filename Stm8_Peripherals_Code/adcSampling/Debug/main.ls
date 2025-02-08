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
  78                     ; 55 void main() {
  79                     	switch	.text
  80  0000               f_main:
  82  0000 5208          	subw	sp,#8
  83       00000008      OFST:	set	8
  86                     ; 56 	float frequency = 0.0, amplitude = 0.0;
  88  0002 ce107c        	ldw	x,L73+2
  89  0005 1f03          	ldw	(OFST-5,sp),x
  90  0007 ce107a        	ldw	x,L73
  91  000a 1f01          	ldw	(OFST-7,sp),x
  95  000c ce107c        	ldw	x,L73+2
  96  000f 1f07          	ldw	(OFST-1,sp),x
  97  0011 ce107a        	ldw	x,L73
  98  0014 1f05          	ldw	(OFST-3,sp),x
 100                     ; 57 	initialize_system();
 102  0016 8d4b004b      	callf	f_initialize_system
 104  001a               L34:
 105                     ; 60 		amplitude = process_adc_signal(VAR_SIGNAL, &frequency, &amplitude);
 107  001a 96            	ldw	x,sp
 108  001b 1c0005        	addw	x,#OFST-3
 109  001e 89            	pushw	x
 110  001f 96            	ldw	x,sp
 111  0020 1c0003        	addw	x,#OFST-5
 112  0023 89            	pushw	x
 113  0024 a605          	ld	a,#5
 114  0026 8d230323      	callf	f_process_adc_signal
 116  002a 5b04          	addw	sp,#4
 117  002c 96            	ldw	x,sp
 118  002d 1c0005        	addw	x,#OFST-3
 119  0030 8d000000      	callf	d_rtol
 122                     ; 61 		printf("frequency; %.3f, amplitude: %.3f\n\r", frequency, amplitude);
 124  0034 1e07          	ldw	x,(OFST-1,sp)
 125  0036 89            	pushw	x
 126  0037 1e07          	ldw	x,(OFST-1,sp)
 127  0039 89            	pushw	x
 128  003a 1e07          	ldw	x,(OFST-1,sp)
 129  003c 89            	pushw	x
 130  003d 1e07          	ldw	x,(OFST-1,sp)
 131  003f 89            	pushw	x
 132  0040 ae1057        	ldw	x,#L74
 133  0043 8d000000      	callf	f_printf
 135  0047 5b08          	addw	sp,#8
 137  0049 20cf          	jra	L34
 166                     ; 70 void initialize_system(void) {
 167                     	switch	.text
 168  004b               f_initialize_system:
 172                     ; 71 	clock_setup();          // Configure system clock
 174  004b 8d760076      	callf	f_clock_setup
 176                     ; 72 	TIM4_Config();          // Timer 4 config for delay
 178  004f 8d000000      	callf	f_TIM4_Config
 180                     ; 73 	UART3_setup();          // Setup UART communication
 182  0053 8db900b9      	callf	f_UART3_setup
 184                     ; 74 	ADC2_setup();           // Setup ADC
 186  0057 8dda00da      	callf	f_ADC2_setup
 188                     ; 75 	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
 190  005b ae500a        	ldw	x,#20490
 191  005e 8d000000      	callf	f_GPIO_DeInit
 193                     ; 76 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 195  0062 4be0          	push	#224
 196  0064 4b08          	push	#8
 197  0066 ae500a        	ldw	x,#20490
 198  0069 8d000000      	callf	f_GPIO_Init
 200  006d 85            	popw	x
 201                     ; 77 	printf("System Initialization Completed\n\r");
 203  006e ae1035        	ldw	x,#L16
 204  0071 8d000000      	callf	f_printf
 206                     ; 78 }
 209  0075 87            	retf
 241                     ; 81 void clock_setup(void) {
 242                     	switch	.text
 243  0076               f_clock_setup:
 247                     ; 82 	CLK_DeInit();
 249  0076 8d000000      	callf	f_CLK_DeInit
 251                     ; 83 	CLK_HSECmd(DISABLE);
 253  007a 4f            	clr	a
 254  007b 8d000000      	callf	f_CLK_HSECmd
 256                     ; 84 	CLK_LSICmd(DISABLE);
 258  007f 4f            	clr	a
 259  0080 8d000000      	callf	f_CLK_LSICmd
 261                     ; 85 	CLK_HSICmd(ENABLE);
 263  0084 a601          	ld	a,#1
 264  0086 8d000000      	callf	f_CLK_HSICmd
 267  008a               L57:
 268                     ; 86 	while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 270  008a ae0102        	ldw	x,#258
 271  008d 8d000000      	callf	f_CLK_GetFlagStatus
 273  0091 4d            	tnz	a
 274  0092 27f6          	jreq	L57
 275                     ; 89 	CLK_ClockSwitchCmd(ENABLE);
 277  0094 a601          	ld	a,#1
 278  0096 8d000000      	callf	f_CLK_ClockSwitchCmd
 280                     ; 90 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 282  009a 4f            	clr	a
 283  009b 8d000000      	callf	f_CLK_HSIPrescalerConfig
 285                     ; 91 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 287  009f a680          	ld	a,#128
 288  00a1 8d000000      	callf	f_CLK_SYSCLKConfig
 290                     ; 92 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 292  00a5 4b01          	push	#1
 293  00a7 4b00          	push	#0
 294  00a9 ae01e1        	ldw	x,#481
 295  00ac 8d000000      	callf	f_CLK_ClockSwitchConfig
 297  00b0 85            	popw	x
 298                     ; 96 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 300  00b1 ae0301        	ldw	x,#769
 301  00b4 8d000000      	callf	f_CLK_PeripheralClockConfig
 303                     ; 97 }
 306  00b8 87            	retf
 331                     ; 100 void UART3_setup(void) {
 332                     	switch	.text
 333  00b9               f_UART3_setup:
 337                     ; 101 	UART3_DeInit();
 339  00b9 8d000000      	callf	f_UART3_DeInit
 341                     ; 102 	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TXRX_ENABLE);
 343  00bd 4b0c          	push	#12
 344  00bf 4b00          	push	#0
 345  00c1 4b00          	push	#0
 346  00c3 4b00          	push	#0
 347  00c5 ae2580        	ldw	x,#9600
 348  00c8 89            	pushw	x
 349  00c9 ae0000        	ldw	x,#0
 350  00cc 89            	pushw	x
 351  00cd 8d000000      	callf	f_UART3_Init
 353  00d1 5b08          	addw	sp,#8
 354                     ; 103 	UART3_Cmd(ENABLE);
 356  00d3 a601          	ld	a,#1
 357  00d5 8d000000      	callf	f_UART3_Cmd
 359                     ; 104 }
 362  00d9 87            	retf
 388                     ; 107 void ADC2_setup(void) {
 389                     	switch	.text
 390  00da               f_ADC2_setup:
 394                     ; 108 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 396  00da ae1301        	ldw	x,#4865
 397  00dd 8d000000      	callf	f_CLK_PeripheralClockConfig
 399                     ; 109 	ADC2_DeInit();
 401  00e1 8d000000      	callf	f_ADC2_DeInit
 403                     ; 111 	ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
 403                     ; 112 						ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6, DISABLE);
 405  00e5 4b00          	push	#0
 406  00e7 4b07          	push	#7
 407  00e9 4b08          	push	#8
 408  00eb 4b00          	push	#0
 409  00ed 4b01          	push	#1
 410  00ef 4b00          	push	#0
 411  00f1 ae0105        	ldw	x,#261
 412  00f4 8d000000      	callf	f_ADC2_Init
 414  00f8 5b06          	addw	sp,#6
 415                     ; 114 	ADC2_Cmd(ENABLE);
 417  00fa a601          	ld	a,#1
 418  00fc 8d000000      	callf	f_ADC2_Cmd
 420                     ; 115 }
 423  0100 87            	retf
 465                     ; 118 uint32_t elapsedTime(uint32_t start, uint32_t end) {
 466                     	switch	.text
 467  0101               f_elapsedTime:
 469       00000000      OFST:	set	0
 472                     ; 119 	return (end >= start) ? (end - start) : ((0xffffffff - start + 1) + end);
 474  0101 96            	ldw	x,sp
 475  0102 1c0008        	addw	x,#OFST+8
 476  0105 8d000000      	callf	d_ltor
 478  0109 96            	ldw	x,sp
 479  010a 1c0004        	addw	x,#OFST+4
 480  010d 8d000000      	callf	d_lcmp
 482  0111 2512          	jrult	L02
 483  0113 96            	ldw	x,sp
 484  0114 1c0008        	addw	x,#OFST+8
 485  0117 8d000000      	callf	d_ltor
 487  011b 96            	ldw	x,sp
 488  011c 1c0004        	addw	x,#OFST+4
 489  011f 8d000000      	callf	d_lsub
 491  0123 2014          	jra	L22
 492  0125               L02:
 493  0125 96            	ldw	x,sp
 494  0126 1c0004        	addw	x,#OFST+4
 495  0129 8d000000      	callf	d_ltor
 497  012d 8d000000      	callf	d_lneg
 499  0131 96            	ldw	x,sp
 500  0132 1c0008        	addw	x,#OFST+8
 501  0135 8d000000      	callf	d_ladd
 503  0139               L22:
 506  0139 87            	retf
 553                     ; 123 unsigned int read_ADC_Channel(uint8_t channel) {
 554                     	switch	.text
 555  013a               f_read_ADC_Channel:
 557  013a 89            	pushw	x
 558       00000002      OFST:	set	2
 561                     ; 124 	unsigned int adcValue = 0;
 563                     ; 125 	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, channel, ADC2_ALIGN_RIGHT);
 565  013b 4b08          	push	#8
 566  013d ae0100        	ldw	x,#256
 567  0140 97            	ld	xl,a
 568  0141 8d000000      	callf	f_ADC2_ConversionConfig
 570  0145 84            	pop	a
 571                     ; 126 	ADC2_StartConversion();
 573  0146 8d000000      	callf	f_ADC2_StartConversion
 576  014a               L761:
 577                     ; 128 	while (ADC2_GetFlagStatus() == RESET);
 579  014a 8d000000      	callf	f_ADC2_GetFlagStatus
 581  014e 4d            	tnz	a
 582  014f 27f9          	jreq	L761
 583                     ; 130 	adcValue = ADC2_GetConversionValue();
 585  0151 8d000000      	callf	f_ADC2_GetConversionValue
 587  0155 1f01          	ldw	(OFST-1,sp),x
 589                     ; 131 	ADC2_ClearFlag();
 591  0157 8d000000      	callf	f_ADC2_ClearFlag
 593                     ; 132 	return adcValue;
 595  015b 1e01          	ldw	x,(OFST-1,sp)
 598  015d 5b02          	addw	sp,#2
 599  015f 87            	retf
 672                     ; 136 bool detectZeroCross(float previousSample, float currentSample, float threshold) {
 673                     	switch	.text
 674  0160               f_detectZeroCross:
 676       00000000      OFST:	set	0
 679                     ; 137 	if (crossingType == -1) {  // If no crossing type detected, check for both positive and negative
 681  0160 be10          	ldw	x,_crossingType
 682  0162 a3ffff        	cpw	x,#65535
 683  0165 2666          	jrne	L132
 684                     ; 138 		if (previousSample <= threshold && currentSample > threshold) {
 686  0167 9c            	rvf
 687  0168 96            	ldw	x,sp
 688  0169 1c0004        	addw	x,#OFST+4
 689  016c 8d000000      	callf	d_ltor
 691  0170 96            	ldw	x,sp
 692  0171 1c000c        	addw	x,#OFST+12
 693  0174 8d000000      	callf	d_fcmp
 695  0178 2c19          	jrsgt	L332
 697  017a 9c            	rvf
 698  017b 96            	ldw	x,sp
 699  017c 1c0008        	addw	x,#OFST+8
 700  017f 8d000000      	callf	d_ltor
 702  0183 96            	ldw	x,sp
 703  0184 1c000c        	addw	x,#OFST+12
 704  0187 8d000000      	callf	d_fcmp
 706  018b 2d06          	jrsle	L332
 707                     ; 139 			crossingType = 0;  // Positive zero crossing
 709  018d 5f            	clrw	x
 710  018e bf10          	ldw	_crossingType,x
 711                     ; 140 			return true;
 713  0190 a601          	ld	a,#1
 716  0192 87            	retf
 717  0193               L332:
 718                     ; 141 		} else if (previousSample >= -threshold && currentSample < -threshold) {
 720  0193 9c            	rvf
 721  0194 96            	ldw	x,sp
 722  0195 1c000c        	addw	x,#OFST+12
 723  0198 8d000000      	callf	d_ltor
 725  019c 8d000000      	callf	d_fneg
 727  01a0 96            	ldw	x,sp
 728  01a1 1c0004        	addw	x,#OFST+4
 729  01a4 8d000000      	callf	d_fcmp
 731  01a8 2d04ac2a022a  	jrsgt	L142
 733  01ae 9c            	rvf
 734  01af 96            	ldw	x,sp
 735  01b0 1c000c        	addw	x,#OFST+12
 736  01b3 8d000000      	callf	d_ltor
 738  01b7 8d000000      	callf	d_fneg
 740  01bb 96            	ldw	x,sp
 741  01bc 1c0008        	addw	x,#OFST+8
 742  01bf 8d000000      	callf	d_fcmp
 744  01c3 2d65          	jrsle	L142
 745                     ; 142 			crossingType = 1;  // Negative zero crossing
 747  01c5 ae0001        	ldw	x,#1
 748  01c8 bf10          	ldw	_crossingType,x
 749                     ; 143 			return true;
 751  01ca a601          	ld	a,#1
 754  01cc 87            	retf
 755  01cd               L132:
 756                     ; 145 	} else if (crossingType == 0 && previousSample <= threshold && currentSample > threshold) {
 758  01cd be10          	ldw	x,_crossingType
 759  01cf 2629          	jrne	L342
 761  01d1 9c            	rvf
 762  01d2 96            	ldw	x,sp
 763  01d3 1c0004        	addw	x,#OFST+4
 764  01d6 8d000000      	callf	d_ltor
 766  01da 96            	ldw	x,sp
 767  01db 1c000c        	addw	x,#OFST+12
 768  01de 8d000000      	callf	d_fcmp
 770  01e2 2c16          	jrsgt	L342
 772  01e4 9c            	rvf
 773  01e5 96            	ldw	x,sp
 774  01e6 1c0008        	addw	x,#OFST+8
 775  01e9 8d000000      	callf	d_ltor
 777  01ed 96            	ldw	x,sp
 778  01ee 1c000c        	addw	x,#OFST+12
 779  01f1 8d000000      	callf	d_fcmp
 781  01f5 2d03          	jrsle	L342
 782                     ; 146 			return true;  // Positive zero crossing
 784  01f7 a601          	ld	a,#1
 787  01f9 87            	retf
 788  01fa               L342:
 789                     ; 147 	} else if (crossingType == 1 && previousSample >= threshold && currentSample < threshold) {
 791  01fa be10          	ldw	x,_crossingType
 792  01fc a30001        	cpw	x,#1
 793  01ff 2629          	jrne	L142
 795  0201 9c            	rvf
 796  0202 96            	ldw	x,sp
 797  0203 1c0004        	addw	x,#OFST+4
 798  0206 8d000000      	callf	d_ltor
 800  020a 96            	ldw	x,sp
 801  020b 1c000c        	addw	x,#OFST+12
 802  020e 8d000000      	callf	d_fcmp
 804  0212 2f16          	jrslt	L142
 806  0214 9c            	rvf
 807  0215 96            	ldw	x,sp
 808  0216 1c0008        	addw	x,#OFST+8
 809  0219 8d000000      	callf	d_ltor
 811  021d 96            	ldw	x,sp
 812  021e 1c000c        	addw	x,#OFST+12
 813  0221 8d000000      	callf	d_fcmp
 815  0225 2e03          	jrsge	L142
 816                     ; 148 			return true;  // Negative zero crossing
 818  0227 a601          	ld	a,#1
 821  0229 87            	retf
 822  022a               L142:
 823                     ; 151 	return false;  // No zero crossing detected
 825  022a 4f            	clr	a
 828  022b 87            	retf
 880                     ; 155 bool detectPosZeroCross(float previousSample, float currentSample, float threshold) {
 881                     	switch	.text
 882  022c               f_detectPosZeroCross:
 884       00000000      OFST:	set	0
 887                     ; 156 	return (previousSample <= threshold && currentSample > threshold);
 889  022c 9c            	rvf
 890  022d 96            	ldw	x,sp
 891  022e 1c0004        	addw	x,#OFST+4
 892  0231 8d000000      	callf	d_ltor
 894  0235 96            	ldw	x,sp
 895  0236 1c000c        	addw	x,#OFST+12
 896  0239 8d000000      	callf	d_fcmp
 898  023d 2c17          	jrsgt	L23
 899  023f 9c            	rvf
 900  0240 96            	ldw	x,sp
 901  0241 1c0008        	addw	x,#OFST+8
 902  0244 8d000000      	callf	d_ltor
 904  0248 96            	ldw	x,sp
 905  0249 1c000c        	addw	x,#OFST+12
 906  024c 8d000000      	callf	d_fcmp
 908  0250 2d04          	jrsle	L23
 909  0252 a601          	ld	a,#1
 910  0254 2001          	jra	L43
 911  0256               L23:
 912  0256 4f            	clr	a
 913  0257               L43:
 916  0257 87            	retf
 987                     ; 160 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
 988                     	switch	.text
 989  0258               f_calculate_amplitude:
 991  0258 89            	pushw	x
 992  0259 520c          	subw	sp,#12
 993       0000000c      OFST:	set	12
 996                     ; 161 	uint32_t i = 0;
 998                     ; 162 	float max_val = -V_REF, min_val = V_REF;
1000  025b ce102f        	ldw	x,L143+2
1001  025e 1f03          	ldw	(OFST-9,sp),x
1002  0260 ce102d        	ldw	x,L143
1003  0263 1f01          	ldw	(OFST-11,sp),x
1007  0265 ce1033        	ldw	x,L153+2
1008  0268 1f07          	ldw	(OFST-5,sp),x
1009  026a ce1031        	ldw	x,L153
1010  026d 1f05          	ldw	(OFST-7,sp),x
1012                     ; 164 	for (i = 0; i < sample_size; i++) {
1014  026f ae0000        	ldw	x,#0
1015  0272 1f0b          	ldw	(OFST-1,sp),x
1016  0274 ae0000        	ldw	x,#0
1017  0277 1f09          	ldw	(OFST-3,sp),x
1020  0279 2058          	jra	L163
1021  027b               L553:
1022                     ; 165 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1024  027b 9c            	rvf
1025  027c 1e0b          	ldw	x,(OFST-1,sp)
1026  027e 58            	sllw	x
1027  027f 58            	sllw	x
1028  0280 72fb0d        	addw	x,(OFST+1,sp)
1029  0283 8d000000      	callf	d_ltor
1031  0287 96            	ldw	x,sp
1032  0288 1c0001        	addw	x,#OFST-11
1033  028b 8d000000      	callf	d_fcmp
1035  028f 2d11          	jrsle	L563
1038  0291 1e0b          	ldw	x,(OFST-1,sp)
1039  0293 58            	sllw	x
1040  0294 58            	sllw	x
1041  0295 72fb0d        	addw	x,(OFST+1,sp)
1042  0298 9093          	ldw	y,x
1043  029a ee02          	ldw	x,(2,x)
1044  029c 1f03          	ldw	(OFST-9,sp),x
1045  029e 93            	ldw	x,y
1046  029f fe            	ldw	x,(x)
1047  02a0 1f01          	ldw	(OFST-11,sp),x
1049  02a2               L563:
1050                     ; 166 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1052  02a2 9c            	rvf
1053  02a3 1e0b          	ldw	x,(OFST-1,sp)
1054  02a5 58            	sllw	x
1055  02a6 58            	sllw	x
1056  02a7 72fb0d        	addw	x,(OFST+1,sp)
1057  02aa 8d000000      	callf	d_ltor
1059  02ae 96            	ldw	x,sp
1060  02af 1c0005        	addw	x,#OFST-7
1061  02b2 8d000000      	callf	d_fcmp
1063  02b6 2e11          	jrsge	L763
1066  02b8 1e0b          	ldw	x,(OFST-1,sp)
1067  02ba 58            	sllw	x
1068  02bb 58            	sllw	x
1069  02bc 72fb0d        	addw	x,(OFST+1,sp)
1070  02bf 9093          	ldw	y,x
1071  02c1 ee02          	ldw	x,(2,x)
1072  02c3 1f07          	ldw	(OFST-5,sp),x
1073  02c5 93            	ldw	x,y
1074  02c6 fe            	ldw	x,(x)
1075  02c7 1f05          	ldw	(OFST-7,sp),x
1077  02c9               L763:
1078                     ; 164 	for (i = 0; i < sample_size; i++) {
1080  02c9 96            	ldw	x,sp
1081  02ca 1c0009        	addw	x,#OFST-3
1082  02cd a601          	ld	a,#1
1083  02cf 8d000000      	callf	d_lgadc
1086  02d3               L163:
1089  02d3 96            	ldw	x,sp
1090  02d4 1c0009        	addw	x,#OFST-3
1091  02d7 8d000000      	callf	d_ltor
1093  02db 96            	ldw	x,sp
1094  02dc 1c0012        	addw	x,#OFST+6
1095  02df 8d000000      	callf	d_lcmp
1097  02e3 2596          	jrult	L553
1098                     ; 169 	return (max_val - min_val);
1100  02e5 96            	ldw	x,sp
1101  02e6 1c0001        	addw	x,#OFST-11
1102  02e9 8d000000      	callf	d_ltor
1104  02ed 96            	ldw	x,sp
1105  02ee 1c0005        	addw	x,#OFST-7
1106  02f1 8d000000      	callf	d_fsub
1110  02f5 5b0e          	addw	sp,#14
1111  02f7 87            	retf
1155                     ; 173 void initialize_adc_buffer(float buffer[]) {
1156                     	switch	.text
1157  02f8               f_initialize_adc_buffer:
1159  02f8 89            	pushw	x
1160  02f9 89            	pushw	x
1161       00000002      OFST:	set	2
1164                     ; 174 	uint16_t i = 0;
1166                     ; 175 	for (i = 0; i < NUM_SAMPLES; i++) {
1168  02fa 5f            	clrw	x
1169  02fb 1f01          	ldw	(OFST-1,sp),x
1171  02fd               L314:
1172                     ; 176 		buffer[i] = -1;  // Reset each element of the ADC buffer
1174  02fd 1e01          	ldw	x,(OFST-1,sp)
1175  02ff 58            	sllw	x
1176  0300 58            	sllw	x
1177  0301 72fb03        	addw	x,(OFST+1,sp)
1178  0304 90aeffff      	ldw	y,#65535
1179  0308 51            	exgw	x,y
1180  0309 8d000000      	callf	d_itof
1182  030d 51            	exgw	x,y
1183  030e 8d000000      	callf	d_rtol
1185                     ; 175 	for (i = 0; i < NUM_SAMPLES; i++) {
1187  0312 1e01          	ldw	x,(OFST-1,sp)
1188  0314 1c0001        	addw	x,#1
1189  0317 1f01          	ldw	(OFST-1,sp),x
1193  0319 1e01          	ldw	x,(OFST-1,sp)
1194  031b a30400        	cpw	x,#1024
1195  031e 25dd          	jrult	L314
1196                     ; 178 }
1199  0320 5b04          	addw	sp,#4
1200  0322 87            	retf
1202                     .const:	section	.text
1203  0000               L124_buffer:
1204  0000 00000000      	dc.w	0,0
1205  0004 000000000000  	ds.b	4092
1377                     ; 180 float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
1378                     	switch	.text
1379  0323               f_process_adc_signal:
1381  0323 88            	push	a
1382  0324 96            	ldw	x,sp
1383  0325 1d102c        	subw	x,#4140
1384  0328 94            	ldw	sp,x
1385       0000102c      OFST:	set	4140
1388                     ; 181 	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
1390  0329 96            	ldw	x,sp
1391  032a 1c0027        	addw	x,#OFST-4101
1392  032d 90ae0000      	ldw	y,#L124_buffer
1393  0331 bf00          	ldw	c_x,x
1394  0333 ae1000        	ldw	x,#4096
1395  0336 8d000000      	callf	d_xymovl
1397                     ; 182 	unsigned long currentEdgeTime = 0;
1399                     ; 183 	float freqBuff = 0;
1401  033a ae0000        	ldw	x,#0
1402  033d 1f1d          	ldw	(OFST-4111,sp),x
1403  033f ae0000        	ldw	x,#0
1404  0342 1f1b          	ldw	(OFST-4113,sp),x
1406                     ; 184 	int freqCount = 0;
1408  0344 5f            	clrw	x
1409  0345 1f1f          	ldw	(OFST-4109,sp),x
1411                     ; 185 	uint16_t i = 0, count = 0;
1415  0347 96            	ldw	x,sp
1416  0348 905f          	clrw	y
1417  034a df1027        	ldw	(OFST-5,x),y
1418                     ; 186 	float lastStoredValue = 0.0;       // Track the last stored ADC voltage
1420  034d ce107c        	ldw	x,L73+2
1421  0350 1f24          	ldw	(OFST-4104,sp),x
1422  0352 ce107a        	ldw	x,L73
1423  0355 1f22          	ldw	(OFST-4106,sp),x
1425                     ; 187 	bool isChannel1 = (channel == VAR_SIGNAL);
1427  0357 96            	ldw	x,sp
1428  0358 d6102d        	ld	a,(OFST+1,x)
1429  035b a105          	cp	a,#5
1430  035d 2605          	jrne	L44
1431  035f ae0001        	ldw	x,#1
1432  0362 2001          	jra	L64
1433  0364               L44:
1434  0364 5f            	clrw	x
1435  0365               L64:
1436  0365 01            	rrwa	x,a
1437  0366 6b21          	ld	(OFST-4107,sp),a
1438  0368 02            	rlwa	x,a
1440                     ; 188 	bool firstSample = true;           // Flag for first sample storage
1442  0369 a601          	ld	a,#1
1443  036b 6b26          	ld	(OFST-4102,sp),a
1445                     ; 189 	lastEdgeTime = 0;                 // Reset last zero-crossing time
1447  036d ae0000        	ldw	x,#0
1448  0370 bf0a          	ldw	_lastEdgeTime+2,x
1449  0372 ae0000        	ldw	x,#0
1450  0375 bf08          	ldw	_lastEdgeTime,x
1452  0377 acd504d5      	jpf	L535
1453  037b               L135:
1454                     ; 194 		float currentVoltage = convert_adc_to_voltage(read_ADC_Channel(channel));
1456  037b 96            	ldw	x,sp
1457  037c d6102d        	ld	a,(OFST+1,x)
1458  037f 8d3a013a      	callf	f_read_ADC_Channel
1460  0383 8d150615      	callf	f_convert_adc_to_voltage
1462  0387 96            	ldw	x,sp
1463  0388 1c1029        	addw	x,#OFST-3
1464  038b 8d000000      	callf	d_rtol
1466                     ; 195     printf("%.4f " , currentVoltage); 
1468  038f 96            	ldw	x,sp
1469  0390 9093          	ldw	y,x
1470  0392 de102b        	ldw	x,(OFST-1,x)
1471  0395 89            	pushw	x
1472  0396 93            	ldw	x,y
1473  0397 de1029        	ldw	x,(OFST-3,x)
1474  039a 89            	pushw	x
1475  039b ae1027        	ldw	x,#L145
1476  039e 8d000000      	callf	f_printf
1478  03a2 5b04          	addw	sp,#4
1479                     ; 197 		if (firstSample || fabs(currentVoltage - lastStoredValue) >= 0.01) {
1481  03a4 0d26          	tnz	(OFST-4102,sp)
1482  03a6 262b          	jrne	L545
1484  03a8 9c            	rvf
1485  03a9 96            	ldw	x,sp
1486  03aa 1c1029        	addw	x,#OFST-3
1487  03ad 8d000000      	callf	d_ltor
1489  03b1 96            	ldw	x,sp
1490  03b2 1c0022        	addw	x,#OFST-4106
1491  03b5 8d000000      	callf	d_fsub
1493  03b9 be02          	ldw	x,c_lreg+2
1494  03bb 89            	pushw	x
1495  03bc be00          	ldw	x,c_lreg
1496  03be 89            	pushw	x
1497  03bf 8d000000      	callf	f_fabs
1499  03c3 9c            	rvf
1500  03c4 5b04          	addw	sp,#4
1501  03c6 ae1023        	ldw	x,#L355
1502  03c9 8d000000      	callf	d_fcmp
1504  03cd 2e04          	jrsge	L05
1505  03cf acd504d5      	jpf	L535
1506  03d3               L05:
1507  03d3               L545:
1508                     ; 198 			buffer[count] = currentVoltage;
1510  03d3 96            	ldw	x,sp
1511  03d4 9096          	ldw	y,sp
1512  03d6 72a90027      	addw	y,#OFST-4101
1513  03da 170f          	ldw	(OFST-4125,sp),y
1515  03dc 9096          	ldw	y,sp
1516  03de 90de1027      	ldw	y,(OFST-5,y)
1517  03e2 9058          	sllw	y
1518  03e4 9058          	sllw	y
1519  03e6 72f90f        	addw	y,(OFST-4125,sp)
1520  03e9 d6102c        	ld	a,(OFST+0,x)
1521  03ec 90e703        	ld	(3,y),a
1522  03ef d6102b        	ld	a,(OFST-1,x)
1523  03f2 90e702        	ld	(2,y),a
1524  03f5 d6102a        	ld	a,(OFST-2,x)
1525  03f8 90e701        	ld	(1,y),a
1526  03fb d61029        	ld	a,(OFST-3,x)
1527  03fe 90f7          	ld	(y),a
1528                     ; 200 			lastStoredValue = currentVoltage;
1530  0400 96            	ldw	x,sp
1531  0401 9093          	ldw	y,x
1532  0403 de102b        	ldw	x,(OFST-1,x)
1533  0406 1f24          	ldw	(OFST-4104,sp),x
1534  0408 93            	ldw	x,y
1535  0409 de1029        	ldw	x,(OFST-3,x)
1536  040c 1f22          	ldw	(OFST-4106,sp),x
1538                     ; 201 			firstSample = false;  // First sample has been stored
1540  040e 0f26          	clr	(OFST-4102,sp)
1542                     ; 202 			count++;
1544  0410 96            	ldw	x,sp
1545  0411 9093          	ldw	y,x
1546  0413 de1027        	ldw	x,(OFST-5,x)
1547  0416 1c0001        	addw	x,#1
1548  0419 90df1027      	ldw	(OFST-5,y),x
1549                     ; 205 			if (isChannel1 && (frequency != NULL) && count > 1) {
1551  041d 0d21          	tnz	(OFST-4107,sp)
1552  041f 2604          	jrne	L25
1553  0421 acd504d5      	jpf	L535
1554  0425               L25:
1556  0425 96            	ldw	x,sp
1557  0426 d61032        	ld	a,(OFST+6,x)
1558  0429 da1031        	or	a,(OFST+5,x)
1559  042c 2604          	jrne	L45
1560  042e acd504d5      	jpf	L535
1561  0432               L45:
1563  0432 96            	ldw	x,sp
1564  0433 9093          	ldw	y,x
1565  0435 90de1027      	ldw	y,(OFST-5,y)
1566  0439 90a30002      	cpw	y,#2
1567  043d 2404          	jruge	L65
1568  043f acd504d5      	jpf	L535
1569  0443               L65:
1570                     ; 206 				if (detectZeroCross(buffer[count - 2], buffer[count - 1], ZEROCROSS_THRESHOLD)) {
1572  0443 ce1021        	ldw	x,L765+2
1573  0446 89            	pushw	x
1574  0447 ce101f        	ldw	x,L765
1575  044a 89            	pushw	x
1576  044b 96            	ldw	x,sp
1577  044c 1c002b        	addw	x,#OFST-4097
1578  044f 1f13          	ldw	(OFST-4121,sp),x
1580  0451 96            	ldw	x,sp
1581  0452 de102b        	ldw	x,(OFST-1,x)
1582  0455 58            	sllw	x
1583  0456 58            	sllw	x
1584  0457 1d0004        	subw	x,#4
1585  045a 72fb13        	addw	x,(OFST-4121,sp)
1586  045d 9093          	ldw	y,x
1587  045f ee02          	ldw	x,(2,x)
1588  0461 89            	pushw	x
1589  0462 93            	ldw	x,y
1590  0463 fe            	ldw	x,(x)
1591  0464 89            	pushw	x
1592  0465 96            	ldw	x,sp
1593  0466 1c002f        	addw	x,#OFST-4093
1594  0469 1f15          	ldw	(OFST-4119,sp),x
1596  046b 96            	ldw	x,sp
1597  046c de102f        	ldw	x,(OFST+3,x)
1598  046f 58            	sllw	x
1599  0470 58            	sllw	x
1600  0471 1d0008        	subw	x,#8
1601  0474 72fb15        	addw	x,(OFST-4119,sp)
1602  0477 9093          	ldw	y,x
1603  0479 ee02          	ldw	x,(2,x)
1604  047b 89            	pushw	x
1605  047c 93            	ldw	x,y
1606  047d fe            	ldw	x,(x)
1607  047e 89            	pushw	x
1608  047f 8d600160      	callf	f_detectZeroCross
1610  0483 5b0c          	addw	sp,#12
1611  0485 4d            	tnz	a
1612  0486 274d          	jreq	L535
1613                     ; 207 					currentEdgeTime = micros();
1615  0488 8d000000      	callf	f_micros
1617  048c 96            	ldw	x,sp
1618  048d 1c1029        	addw	x,#OFST-3
1619  0490 8d000000      	callf	d_rtol
1621                     ; 208 					if (lastEdgeTime > 0) {  
1623  0494 ae0008        	ldw	x,#_lastEdgeTime
1624  0497 8d000000      	callf	d_lzmp
1626  049b 272a          	jreq	L375
1627                     ; 209 						unsigned long period = currentEdgeTime - lastEdgeTime;
1629  049d 96            	ldw	x,sp
1630  049e 1c1029        	addw	x,#OFST-3
1631  04a1 8d000000      	callf	d_ltor
1633  04a5 ae0008        	ldw	x,#_lastEdgeTime
1634  04a8 8d000000      	callf	d_lsub
1636  04ac 96            	ldw	x,sp
1637  04ad 1c0015        	addw	x,#OFST-4119
1638  04b0 8d000000      	callf	d_rtol
1641                     ; 210 						float singleFrequency = calculate_frequency(period);
1643  04b4 1e17          	ldw	x,(OFST-4117,sp)
1644  04b6 89            	pushw	x
1645  04b7 1e17          	ldw	x,(OFST-4117,sp)
1646  04b9 89            	pushw	x
1647  04ba 8d210621      	callf	f_calculate_frequency
1649  04be 5b04          	addw	sp,#4
1650                     ; 211 						freqCount++;
1652  04c0 1e1f          	ldw	x,(OFST-4109,sp)
1653  04c2 1c0001        	addw	x,#1
1654  04c5 1f1f          	ldw	(OFST-4109,sp),x
1656  04c7               L375:
1657                     ; 225 					lastEdgeTime = currentEdgeTime;
1659  04c7 96            	ldw	x,sp
1660  04c8 9093          	ldw	y,x
1661  04ca de102b        	ldw	x,(OFST-1,x)
1662  04cd bf0a          	ldw	_lastEdgeTime+2,x
1663  04cf 93            	ldw	x,y
1664  04d0 de1029        	ldw	x,(OFST-3,x)
1665  04d3 bf08          	ldw	_lastEdgeTime,x
1666  04d5               L535:
1667                     ; 193 	while (count < NUM_SAMPLES) {  
1669  04d5 96            	ldw	x,sp
1670  04d6 9093          	ldw	y,x
1671  04d8 90de1027      	ldw	y,(OFST-5,y)
1672  04dc 90a30400      	cpw	y,#1024
1673  04e0 2404          	jruge	L06
1674  04e2 ac7b037b      	jpf	L135
1675  04e6               L06:
1676                     ; 232 	*amplitude = calculate_amplitude(buffer, count);
1678  04e6 96            	ldw	x,sp
1679  04e7 de1027        	ldw	x,(OFST-5,x)
1680  04ea 8d000000      	callf	d_uitolx
1682  04ee be02          	ldw	x,c_lreg+2
1683  04f0 89            	pushw	x
1684  04f1 be00          	ldw	x,c_lreg
1685  04f3 89            	pushw	x
1686  04f4 96            	ldw	x,sp
1687  04f5 1c002b        	addw	x,#OFST-4097
1688  04f8 8d580258      	callf	f_calculate_amplitude
1690  04fc 5b04          	addw	sp,#4
1691  04fe 96            	ldw	x,sp
1692  04ff de1033        	ldw	x,(OFST+7,x)
1693  0502 8d000000      	callf	d_rtol
1695                     ; 234 	if (isChannel1 && freqCount > 0) {
1697  0506 0d21          	tnz	(OFST-4107,sp)
1698  0508 272d          	jreq	L575
1700  050a 9c            	rvf
1701  050b 1e1f          	ldw	x,(OFST-4109,sp)
1702  050d 2d28          	jrsle	L575
1703                     ; 235 		*frequency = freqBuff / freqCount;
1705  050f 1e1f          	ldw	x,(OFST-4109,sp)
1706  0511 8d000000      	callf	d_itof
1708  0515 96            	ldw	x,sp
1709  0516 1c000d        	addw	x,#OFST-4127
1710  0519 8d000000      	callf	d_rtol
1713  051d 96            	ldw	x,sp
1714  051e 1c001b        	addw	x,#OFST-4113
1715  0521 8d000000      	callf	d_ltor
1717  0525 96            	ldw	x,sp
1718  0526 1c000d        	addw	x,#OFST-4127
1719  0529 8d000000      	callf	d_fdiv
1721  052d 96            	ldw	x,sp
1722  052e de1031        	ldw	x,(OFST+5,x)
1723  0531 8d000000      	callf	d_rtol
1726  0535 2017          	jra	L775
1727  0537               L575:
1728                     ; 236 	} else if (isChannel1) {
1730  0537 0d21          	tnz	(OFST-4107,sp)
1731  0539 2713          	jreq	L775
1732                     ; 237 		*frequency = 0;
1734  053b 96            	ldw	x,sp
1735  053c de1031        	ldw	x,(OFST+5,x)
1736  053f a600          	ld	a,#0
1737  0541 e703          	ld	(3,x),a
1738  0543 a600          	ld	a,#0
1739  0545 e702          	ld	(2,x),a
1740  0547 a600          	ld	a,#0
1741  0549 e701          	ld	(1,x),a
1742  054b a600          	ld	a,#0
1743  054d f7            	ld	(x),a
1744  054e               L775:
1745                     ; 240 	return *amplitude;
1747  054e 96            	ldw	x,sp
1748  054f de1033        	ldw	x,(OFST+7,x)
1749  0552 8d000000      	callf	d_ltor
1753  0556 9096          	ldw	y,sp
1754  0558 72a9102d      	addw	y,#4141
1755  055c 9094          	ldw	sp,y
1756  055e 87            	retf
1835                     ; 245 float process_FDR_samples(float buffer[]) {
1836                     	switch	.text
1837  055f               f_process_FDR_samples:
1839  055f 89            	pushw	x
1840  0560 520c          	subw	sp,#12
1841       0000000c      OFST:	set	12
1844                     ; 246 	int ZCount = 0;
1846  0562 5f            	clrw	x
1847  0563 1f09          	ldw	(OFST-3,sp),x
1849                     ; 247 	uint16_t i = 0;
1851                     ; 249 	for (i = 0; i < NUM_SAMPLES; i++) {
1853  0565 5f            	clrw	x
1854  0566 1f0b          	ldw	(OFST-1,sp),x
1856  0568               L146:
1857                     ; 251 		buffer[i] = convert_adc_to_voltage(read_ADC_Channel(ADC2_CHANNEL_6));
1859  0568 a606          	ld	a,#6
1860  056a 8d3a013a      	callf	f_read_ADC_Channel
1862  056e 8d150615      	callf	f_convert_adc_to_voltage
1864  0572 1e0b          	ldw	x,(OFST-1,sp)
1865  0574 58            	sllw	x
1866  0575 58            	sllw	x
1867  0576 72fb0d        	addw	x,(OFST+1,sp)
1868  0579 8d000000      	callf	d_rtol
1870                     ; 253 		delay_us(1000000 / SAMPLE_RATE);
1872  057d ae1a0a        	ldw	x,#6666
1873  0580 8d000000      	callf	f_delay_us
1875                     ; 255 		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
1877  0584 1e0b          	ldw	x,(OFST-1,sp)
1878  0586 2754          	jreq	L746
1880  0588 ce1021        	ldw	x,L765+2
1881  058b 89            	pushw	x
1882  058c ce101f        	ldw	x,L765
1883  058f 89            	pushw	x
1884  0590 1e0f          	ldw	x,(OFST+3,sp)
1885  0592 58            	sllw	x
1886  0593 58            	sllw	x
1887  0594 72fb11        	addw	x,(OFST+5,sp)
1888  0597 9093          	ldw	y,x
1889  0599 ee02          	ldw	x,(2,x)
1890  059b 89            	pushw	x
1891  059c 93            	ldw	x,y
1892  059d fe            	ldw	x,(x)
1893  059e 89            	pushw	x
1894  059f 1e13          	ldw	x,(OFST+7,sp)
1895  05a1 58            	sllw	x
1896  05a2 58            	sllw	x
1897  05a3 1d0004        	subw	x,#4
1898  05a6 72fb15        	addw	x,(OFST+9,sp)
1899  05a9 9093          	ldw	y,x
1900  05ab ee02          	ldw	x,(2,x)
1901  05ad 89            	pushw	x
1902  05ae 93            	ldw	x,y
1903  05af fe            	ldw	x,(x)
1904  05b0 89            	pushw	x
1905  05b1 8d600160      	callf	f_detectZeroCross
1907  05b5 5b0c          	addw	sp,#12
1908  05b7 4d            	tnz	a
1909  05b8 2722          	jreq	L746
1910                     ; 256 				unsigned long period = currentEdgeTime - lastEdgeTime;   // Calculate period
1912  05ba ae000c        	ldw	x,#_currentEdgeTime
1913  05bd 8d000000      	callf	d_ltor
1915  05c1 ae0008        	ldw	x,#_lastEdgeTime
1916  05c4 8d000000      	callf	d_lsub
1918                     ; 257 				ZCount++;
1920  05c8 1e09          	ldw	x,(OFST-3,sp)
1921  05ca 1c0001        	addw	x,#1
1922  05cd 1f09          	ldw	(OFST-3,sp),x
1924                     ; 258 				if (ZCount == 2)
1926  05cf 1e09          	ldw	x,(OFST-3,sp)
1927  05d1 a30002        	cpw	x,#2
1928  05d4 2606          	jrne	L746
1929                     ; 260 					count = i;    // for amplitude calculation limit bound
1931  05d6 1e0b          	ldw	x,(OFST-1,sp)
1932  05d8 bf12          	ldw	_count,x
1933                     ; 261 					break;        // break when zeroCrossing detection is two
1935  05da 2012          	jra	L546
1936  05dc               L746:
1937                     ; 249 	for (i = 0; i < NUM_SAMPLES; i++) {
1939  05dc 1e0b          	ldw	x,(OFST-1,sp)
1940  05de 1c0001        	addw	x,#1
1941  05e1 1f0b          	ldw	(OFST-1,sp),x
1945  05e3 1e0b          	ldw	x,(OFST-1,sp)
1946  05e5 a30400        	cpw	x,#1024
1947  05e8 2404ac680568  	jrult	L146
1948  05ee               L546:
1949                     ; 265 	amplitude = calculate_amplitude(buffer, count);
1951  05ee be12          	ldw	x,_count
1952  05f0 8d000000      	callf	d_uitolx
1954  05f4 be02          	ldw	x,c_lreg+2
1955  05f6 89            	pushw	x
1956  05f7 be00          	ldw	x,c_lreg
1957  05f9 89            	pushw	x
1958  05fa 1e11          	ldw	x,(OFST+5,sp)
1959  05fc 8d580258      	callf	f_calculate_amplitude
1961  0600 5b04          	addw	sp,#4
1962  0602 96            	ldw	x,sp
1963  0603 1c0005        	addw	x,#OFST-7
1964  0606 8d000000      	callf	d_rtol
1967                     ; 267 	return amplitude;
1969  060a 96            	ldw	x,sp
1970  060b 1c0005        	addw	x,#OFST-7
1971  060e 8d000000      	callf	d_ltor
1975  0612 5b0e          	addw	sp,#14
1976  0614 87            	retf
2010                     ; 271 float convert_adc_to_voltage(unsigned int adcValue) {
2011                     	switch	.text
2012  0615               f_convert_adc_to_voltage:
2016                     ; 272 	return adcValue * (V_REF / ADC_MAX_VALUE);
2018  0615 8d000000      	callf	d_uitof
2020  0619 ae101b        	ldw	x,#L576
2021  061c 8d000000      	callf	d_fmul
2025  0620 87            	retf
2059                     ; 276 float calculate_frequency(unsigned long period) {
2060                     	switch	.text
2061  0621               f_calculate_frequency:
2063  0621 5204          	subw	sp,#4
2064       00000004      OFST:	set	4
2067                     ; 277 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
2069  0623 96            	ldw	x,sp
2070  0624 1c0008        	addw	x,#OFST+4
2071  0627 8d000000      	callf	d_ltor
2073  062b 8d000000      	callf	d_ultof
2075  062f ae1013        	ldw	x,#L337
2076  0632 8d000000      	callf	d_fdiv
2078  0636 96            	ldw	x,sp
2079  0637 1c0001        	addw	x,#OFST-3
2080  063a 8d000000      	callf	d_rtol
2083  063e ae1017        	ldw	x,#L327
2084  0641 8d000000      	callf	d_ltor
2086  0645 96            	ldw	x,sp
2087  0646 1c0001        	addw	x,#OFST-3
2088  0649 8d000000      	callf	d_fdiv
2092  064d 5b04          	addw	sp,#4
2093  064f 87            	retf
2147                     ; 281 void output_results(float frequency, float amplitude) {
2148                     	switch	.text
2149  0650               f_output_results:
2151  0650 5228          	subw	sp,#40
2152       00000028      OFST:	set	40
2155                     ; 287 	sprintf(buffer, "%.3f,%.3f,%.3f\n", frequency, amplitude, amplitude);
2157  0652 1e32          	ldw	x,(OFST+10,sp)
2158  0654 89            	pushw	x
2159  0655 1e32          	ldw	x,(OFST+10,sp)
2160  0657 89            	pushw	x
2161  0658 1e36          	ldw	x,(OFST+14,sp)
2162  065a 89            	pushw	x
2163  065b 1e36          	ldw	x,(OFST+14,sp)
2164  065d 89            	pushw	x
2165  065e 1e36          	ldw	x,(OFST+14,sp)
2166  0660 89            	pushw	x
2167  0661 1e36          	ldw	x,(OFST+14,sp)
2168  0663 89            	pushw	x
2169  0664 ae1003        	ldw	x,#L567
2170  0667 89            	pushw	x
2171  0668 96            	ldw	x,sp
2172  0669 1c000f        	addw	x,#OFST-25
2173  066c 8d000000      	callf	f_sprintf
2175  0670 5b0e          	addw	sp,#14
2176                     ; 290 	printf("%s", buffer);
2178  0672 96            	ldw	x,sp
2179  0673 1c0001        	addw	x,#OFST-39
2180  0676 89            	pushw	x
2181  0677 ae1000        	ldw	x,#L767
2182  067a 8d000000      	callf	f_printf
2184  067e 85            	popw	x
2185                     ; 292 }
2188  067f 5b28          	addw	sp,#40
2189  0681 87            	retf
2224                     ; 295 PUTCHAR_PROTOTYPE {
2225                     	switch	.text
2226  0682               f_putchar:
2228  0682 88            	push	a
2229       00000000      OFST:	set	0
2232                     ; 296 	UART3_SendData8(c);
2234  0683 8d000000      	callf	f_UART3_SendData8
2237  0687               L1101:
2238                     ; 297 	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
2240  0687 ae0080        	ldw	x,#128
2241  068a 8d000000      	callf	f_UART3_GetFlagStatus
2243  068e 4d            	tnz	a
2244  068f 27f6          	jreq	L1101
2245                     ; 298 	return c;
2247  0691 7b01          	ld	a,(OFST+1,sp)
2250  0693 5b01          	addw	sp,#1
2251  0695 87            	retf
2286                     ; 301 GETCHAR_PROTOTYPE
2286                     ; 302 {
2287                     	switch	.text
2288  0696               f_getchar:
2290  0696 88            	push	a
2291       00000001      OFST:	set	1
2294                     ; 303   char c = 0;
2297  0697               L5301:
2298                     ; 305   while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
2300  0697 ae0020        	ldw	x,#32
2301  069a 8d000000      	callf	f_UART3_GetFlagStatus
2303  069e 4d            	tnz	a
2304  069f 27f6          	jreq	L5301
2305                     ; 306 	c = UART3_ReceiveData8();
2307  06a1 8d000000      	callf	f_UART3_ReceiveData8
2309  06a5 6b01          	ld	(OFST+0,sp),a
2311                     ; 307   return (c);
2313  06a7 7b01          	ld	a,(OFST+0,sp)
2316  06a9 5b01          	addw	sp,#1
2317  06ab 87            	retf
2341                     ; 310 void UART3_ClearBuffer(void) {
2342                     	switch	.text
2343  06ac               f_UART3_ClearBuffer:
2347  06ac 2004          	jra	L3501
2348  06ae               L1501:
2349                     ; 312         (void)UART3_ReceiveData8(); // Clear any preexisting data
2351  06ae 8d000000      	callf	f_UART3_ReceiveData8
2353  06b2               L3501:
2354                     ; 311     while (UART3_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
2356  06b2 ae0020        	ldw	x,#32
2357  06b5 8d000000      	callf	f_UART3_GetFlagStatus
2359  06b9 4d            	tnz	a
2360  06ba 26f2          	jrne	L1501
2361                     ; 314 }
2364  06bc 87            	retf
2428                     ; 316 void UART3_ReceiveString(char *buffer, uint16_t max_length) {
2429                     	switch	.text
2430  06bd               f_UART3_ReceiveString:
2432  06bd 89            	pushw	x
2433  06be 5203          	subw	sp,#3
2434       00000003      OFST:	set	3
2437                     ; 317     uint16_t i = 0;
2439                     ; 320     for (i = 0; i < max_length; i++) {
2441  06c0 5f            	clrw	x
2442  06c1 1f02          	ldw	(OFST-1,sp),x
2445  06c3 200d          	jra	L5111
2446  06c5               L1111:
2447                     ; 321         buffer[i] = '\0';
2449  06c5 1e04          	ldw	x,(OFST+1,sp)
2450  06c7 72fb02        	addw	x,(OFST-1,sp)
2451  06ca 7f            	clr	(x)
2452                     ; 320     for (i = 0; i < max_length; i++) {
2454  06cb 1e02          	ldw	x,(OFST-1,sp)
2455  06cd 1c0001        	addw	x,#1
2456  06d0 1f02          	ldw	(OFST-1,sp),x
2458  06d2               L5111:
2461  06d2 1e02          	ldw	x,(OFST-1,sp)
2462  06d4 1309          	cpw	x,(OFST+6,sp)
2463  06d6 25ed          	jrult	L1111
2464                     ; 323     i = 0;
2466  06d8 5f            	clrw	x
2467  06d9 1f02          	ldw	(OFST-1,sp),x
2470  06db 202c          	jra	L5211
2471  06dd               L3311:
2472                     ; 327         while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
2474  06dd ae0020        	ldw	x,#32
2475  06e0 8d000000      	callf	f_UART3_GetFlagStatus
2477  06e4 4d            	tnz	a
2478  06e5 27f6          	jreq	L3311
2479                     ; 329         receivedChar = UART3_ReceiveData8();
2481  06e7 8d000000      	callf	f_UART3_ReceiveData8
2483  06eb 6b01          	ld	(OFST-2,sp),a
2485                     ; 331         if (receivedChar == '\n' || receivedChar == '\r') {
2487  06ed 7b01          	ld	a,(OFST-2,sp)
2488  06ef a10a          	cp	a,#10
2489  06f1 271d          	jreq	L7211
2491  06f3 7b01          	ld	a,(OFST-2,sp)
2492  06f5 a10d          	cp	a,#13
2493  06f7 2717          	jreq	L7211
2494                     ; 335         buffer[i++] = receivedChar;
2496  06f9 7b01          	ld	a,(OFST-2,sp)
2497  06fb 1e02          	ldw	x,(OFST-1,sp)
2498  06fd 1c0001        	addw	x,#1
2499  0700 1f02          	ldw	(OFST-1,sp),x
2500  0702 1d0001        	subw	x,#1
2502  0705 72fb04        	addw	x,(OFST+1,sp)
2503  0708 f7            	ld	(x),a
2504  0709               L5211:
2505                     ; 326     while (i < max_length - 1) {
2507  0709 1e09          	ldw	x,(OFST+6,sp)
2508  070b 5a            	decw	x
2509  070c 1302          	cpw	x,(OFST-1,sp)
2510  070e 22cd          	jrugt	L3311
2511  0710               L7211:
2512                     ; 338     buffer[i] = '\0'; // Null-terminate the string
2514  0710 1e04          	ldw	x,(OFST+1,sp)
2515  0712 72fb02        	addw	x,(OFST-1,sp)
2516  0715 7f            	clr	(x)
2517                     ; 339 }
2520  0716 5b05          	addw	sp,#5
2521  0718 87            	retf
2589                     	xdef	f_main
2590                     	xdef	f_UART3_ReceiveString
2591                     	xdef	f_UART3_ClearBuffer
2592                     	xdef	f_process_FDR_samples
2593                     	xdef	f_calculate_frequency
2594                     	xdef	f_convert_adc_to_voltage
2595                     	xdef	f_process_adc_signal
2596                     	xdef	f_calculate_amplitude
2597                     	xdef	f_output_results
2598                     	xdef	f_initialize_adc_buffer
2599                     	xdef	f_detectZeroCross
2600                     	xdef	f_detectPosZeroCross
2601                     	xdef	f_read_ADC_Channel
2602                     	xdef	f_elapsedTime
2603                     	xdef	f_ADC2_setup
2604                     	xdef	f_UART3_setup
2605                     	xdef	f_clock_setup
2606                     	xdef	f_initialize_system
2607                     	xdef	_count
2608                     	xdef	_crossingType
2609                     	xdef	_currentEdgeTime
2610                     	xdef	_lastEdgeTime
2611                     	xdef	_sine1_amplitude
2612                     	xdef	_sine1_frequency
2613                     	xref	f_fabs
2614                     	xref	f_micros
2615                     	xref	f_delay_us
2616                     	xref	f_TIM4_Config
2617                     	xref	f_sprintf
2618                     	xdef	f_putchar
2619                     	xref	f_printf
2620                     	xdef	f_getchar
2621                     	xref	f_UART3_GetFlagStatus
2622                     	xref	f_UART3_SendData8
2623                     	xref	f_UART3_ReceiveData8
2624                     	xref	f_UART3_Cmd
2625                     	xref	f_UART3_Init
2626                     	xref	f_UART3_DeInit
2627                     	xref	f_GPIO_Init
2628                     	xref	f_GPIO_DeInit
2629                     	xref	f_CLK_GetFlagStatus
2630                     	xref	f_CLK_SYSCLKConfig
2631                     	xref	f_CLK_HSIPrescalerConfig
2632                     	xref	f_CLK_ClockSwitchConfig
2633                     	xref	f_CLK_PeripheralClockConfig
2634                     	xref	f_CLK_ClockSwitchCmd
2635                     	xref	f_CLK_LSICmd
2636                     	xref	f_CLK_HSICmd
2637                     	xref	f_CLK_HSECmd
2638                     	xref	f_CLK_DeInit
2639                     	xref	f_ADC2_ClearFlag
2640                     	xref	f_ADC2_GetFlagStatus
2641                     	xref	f_ADC2_GetConversionValue
2642                     	xref	f_ADC2_StartConversion
2643                     	xref	f_ADC2_ConversionConfig
2644                     	xref	f_ADC2_Cmd
2645                     	xref	f_ADC2_Init
2646                     	xref	f_ADC2_DeInit
2647                     	switch	.const
2648  1000               L767:
2649  1000 257300        	dc.b	"%s",0
2650  1003               L567:
2651  1003 252e33662c25  	dc.b	"%.3f,%.3f,%.3f",10,0
2652  1013               L337:
2653  1013 49742400      	dc.w	18804,9216
2654  1017               L327:
2655  1017 3f800000      	dc.w	16256,0
2656  101b               L576:
2657  101b 3b954409      	dc.w	15253,17417
2658  101f               L765:
2659  101f 3f8ccccc      	dc.w	16268,-13108
2660  1023               L355:
2661  1023 3c23d70a      	dc.w	15395,-10486
2662  1027               L145:
2663  1027 252e34662000  	dc.b	"%.4f ",0
2664  102d               L143:
2665  102d c0951eb8      	dc.w	-16235,7864
2666  1031               L153:
2667  1031 40951eb8      	dc.w	16533,7864
2668  1035               L16:
2669  1035 53797374656d  	dc.b	"System Initializat"
2670  1047 696f6e20436f  	dc.b	"ion Completed",10
2671  1055 0d00          	dc.b	13,0
2672  1057               L74:
2673  1057 667265717565  	dc.b	"frequency; %.3f, a"
2674  1069 6d706c697475  	dc.b	"mplitude: %.3f",10
2675  1078 0d00          	dc.b	13,0
2676  107a               L73:
2677  107a 00000000      	dc.w	0,0
2678                     	xref.b	c_lreg
2679                     	xref.b	c_x
2680                     	xref.b	c_y
2700                     	xref	d_ultof
2701                     	xref	d_fmul
2702                     	xref	d_uitof
2703                     	xref	d_fdiv
2704                     	xref	d_uitolx
2705                     	xref	d_lzmp
2706                     	xref	d_xymovl
2707                     	xref	d_itof
2708                     	xref	d_fsub
2709                     	xref	d_lgadc
2710                     	xref	d_fneg
2711                     	xref	d_fcmp
2712                     	xref	d_ladd
2713                     	xref	d_lneg
2714                     	xref	d_lsub
2715                     	xref	d_lcmp
2716                     	xref	d_ltor
2717                     	xref	d_rtol
2718                     	end
