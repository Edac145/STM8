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
  57                     ; 52 void main() {
  58                     	switch	.text
  59  0000               f_main:
  63                     ; 54     initialize_system();
  65  0000 8d090009      	callf	f_initialize_system
  67                     ; 56     main_loop();
  69  0004 8dc300c3      	callf	f_main_loop
  71                     ; 57 }
  74  0008 87            	retf
 104                     ; 64 void initialize_system(void) {
 105                     	switch	.text
 106  0009               f_initialize_system:
 110                     ; 65 	clock_setup();          // Configure system clock
 112  0009 8d380038      	callf	f_clock_setup
 114                     ; 66 	TIM4_Config();          // Timer 4 config for delay
 116  000d 8d000000      	callf	f_TIM4_Config
 118                     ; 67 	UART3_setup();          // Setup UART communication
 120  0011 8d7b007b      	callf	f_UART3_setup
 122                     ; 68 	ADC2_setup();           // Setup ADC
 124  0015 8d9c009c      	callf	f_ADC2_setup
 126                     ; 69 	EEPROM_Config();        // Configuring EEPROM
 128  0019 8d000000      	callf	f_EEPROM_Config
 130                     ; 70 	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
 132  001d ae500a        	ldw	x,#20490
 133  0020 8d000000      	callf	f_GPIO_DeInit
 135                     ; 71 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 137  0024 4be0          	push	#224
 138  0026 4b08          	push	#8
 139  0028 ae500a        	ldw	x,#20490
 140  002b 8d000000      	callf	f_GPIO_Init
 142  002f 85            	popw	x
 143                     ; 72 	printf("System Initialization Completed\n\r");
 145  0030 ae102b        	ldw	x,#L13
 146  0033 8d000000      	callf	f_printf
 148                     ; 73 }
 151  0037 87            	retf
 183                     ; 76 void clock_setup(void) {
 184                     	switch	.text
 185  0038               f_clock_setup:
 189                     ; 77 	CLK_DeInit();
 191  0038 8d000000      	callf	f_CLK_DeInit
 193                     ; 78 	CLK_HSECmd(DISABLE);
 195  003c 4f            	clr	a
 196  003d 8d000000      	callf	f_CLK_HSECmd
 198                     ; 79 	CLK_LSICmd(DISABLE);
 200  0041 4f            	clr	a
 201  0042 8d000000      	callf	f_CLK_LSICmd
 203                     ; 80 	CLK_HSICmd(ENABLE);
 205  0046 a601          	ld	a,#1
 206  0048 8d000000      	callf	f_CLK_HSICmd
 209  004c               L54:
 210                     ; 81 	while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 212  004c ae0102        	ldw	x,#258
 213  004f 8d000000      	callf	f_CLK_GetFlagStatus
 215  0053 4d            	tnz	a
 216  0054 27f6          	jreq	L54
 217                     ; 84 	CLK_ClockSwitchCmd(ENABLE);
 219  0056 a601          	ld	a,#1
 220  0058 8d000000      	callf	f_CLK_ClockSwitchCmd
 222                     ; 85 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 224  005c 4f            	clr	a
 225  005d 8d000000      	callf	f_CLK_HSIPrescalerConfig
 227                     ; 86 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 229  0061 a680          	ld	a,#128
 230  0063 8d000000      	callf	f_CLK_SYSCLKConfig
 232                     ; 87 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 234  0067 4b01          	push	#1
 235  0069 4b00          	push	#0
 236  006b ae01e1        	ldw	x,#481
 237  006e 8d000000      	callf	f_CLK_ClockSwitchConfig
 239  0072 85            	popw	x
 240                     ; 91 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 242  0073 ae0301        	ldw	x,#769
 243  0076 8d000000      	callf	f_CLK_PeripheralClockConfig
 245                     ; 92 }
 248  007a 87            	retf
 273                     ; 95 void UART3_setup(void) {
 274                     	switch	.text
 275  007b               f_UART3_setup:
 279                     ; 96 	UART3_DeInit();
 281  007b 8d000000      	callf	f_UART3_DeInit
 283                     ; 97 	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TX_ENABLE);
 285  007f 4b04          	push	#4
 286  0081 4b00          	push	#0
 287  0083 4b00          	push	#0
 288  0085 4b00          	push	#0
 289  0087 ae2580        	ldw	x,#9600
 290  008a 89            	pushw	x
 291  008b ae0000        	ldw	x,#0
 292  008e 89            	pushw	x
 293  008f 8d000000      	callf	f_UART3_Init
 295  0093 5b08          	addw	sp,#8
 296                     ; 98 	UART3_Cmd(ENABLE);
 298  0095 a601          	ld	a,#1
 299  0097 8d000000      	callf	f_UART3_Cmd
 301                     ; 99 }
 304  009b 87            	retf
 330                     ; 102 void ADC2_setup(void) {
 331                     	switch	.text
 332  009c               f_ADC2_setup:
 336                     ; 103 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 338  009c ae1301        	ldw	x,#4865
 339  009f 8d000000      	callf	f_CLK_PeripheralClockConfig
 341                     ; 104 	ADC2_DeInit();
 343  00a3 8d000000      	callf	f_ADC2_DeInit
 345                     ; 106 	ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
 345                     ; 107 						ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6, DISABLE);
 347  00a7 4b00          	push	#0
 348  00a9 4b07          	push	#7
 349  00ab 4b08          	push	#8
 350  00ad 4b00          	push	#0
 351  00af 4b01          	push	#1
 352  00b1 4b00          	push	#0
 353  00b3 ae0105        	ldw	x,#261
 354  00b6 8d000000      	callf	f_ADC2_Init
 356  00ba 5b06          	addw	sp,#6
 357                     ; 109 	ADC2_Cmd(ENABLE);
 359  00bc a601          	ld	a,#1
 360  00be 8d000000      	callf	f_ADC2_Cmd
 362                     ; 110 }
 365  00c2 87            	retf
 367                     .const:	section	.text
 368  0000               L17_adc_buffer_1:
 369  0000 bf800000      	dc.w	-16512,0
 370  0004 000000000000  	ds.b	4092
 426                     ; 113 void main_loop(void) {
 427                     	switch	.text
 428  00c3               f_main_loop:
 430  00c3 96            	ldw	x,sp
 431  00c4 1d1018        	subw	x,#4120
 432  00c7 94            	ldw	sp,x
 433       00001018      OFST:	set	4120
 436  00c8               L121:
 437                     ; 116 	float adc_buffer_1[NUM_SAMPLES] = { -1 };
 439  00c8 96            	ldw	x,sp
 440  00c9 1c0019        	addw	x,#OFST-4095
 441  00cc 90ae0000      	ldw	y,#L17_adc_buffer_1
 442  00d0 bf00          	ldw	c_x,x
 443  00d2 ae1000        	ldw	x,#4096
 444  00d5 8d000000      	callf	d_xymovl
 446                     ; 117 	float sine1_frequency = 0;
 448                     ; 118 	float sine1_amplitude = 0;
 450                     ; 121 	initialize_adc_buffer(adc_buffer_1);
 452  00d9 96            	ldw	x,sp
 453  00da 1c0019        	addw	x,#OFST-4095
 454  00dd 8d220322      	callf	f_initialize_adc_buffer
 456                     ; 124 	sine1_frequency = process_adc_samples(adc_buffer_1);
 458  00e1 96            	ldw	x,sp
 459  00e2 1c0019        	addw	x,#OFST-4095
 460  00e5 8d4d034d      	callf	f_process_adc_samples
 462  00e9 96            	ldw	x,sp
 463  00ea 1c0011        	addw	x,#OFST-4103
 464  00ed 8d000000      	callf	d_rtol
 467                     ; 126 	sine1_amplitude = calculate_amplitude(adc_buffer_1, count);
 469  00f1 be12          	ldw	x,_count
 470  00f3 8d000000      	callf	d_uitolx
 472  00f7 be02          	ldw	x,c_lreg+2
 473  00f9 89            	pushw	x
 474  00fa be00          	ldw	x,c_lreg
 475  00fc 89            	pushw	x
 476  00fd 96            	ldw	x,sp
 477  00fe 1c001d        	addw	x,#OFST-4091
 478  0101 8d820282      	callf	f_calculate_amplitude
 480  0105 5b04          	addw	sp,#4
 481  0107 96            	ldw	x,sp
 482  0108 1c0015        	addw	x,#OFST-4099
 483  010b 8d000000      	callf	d_rtol
 486                     ; 129 	output_results(sine1_frequency, sine1_amplitude);
 488  010f 1e17          	ldw	x,(OFST-4097,sp)
 489  0111 89            	pushw	x
 490  0112 1e17          	ldw	x,(OFST-4097,sp)
 491  0114 89            	pushw	x
 492  0115 1e17          	ldw	x,(OFST-4097,sp)
 493  0117 89            	pushw	x
 494  0118 1e17          	ldw	x,(OFST-4097,sp)
 495  011a 89            	pushw	x
 496  011b 8da804a8      	callf	f_output_results
 498  011f 5b08          	addw	sp,#8
 500  0121 20a5          	jra	L121
 542                     ; 138 uint32_t elapsedTime(uint32_t start, uint32_t end) {
 543                     	switch	.text
 544  0123               f_elapsedTime:
 546       00000000      OFST:	set	0
 549                     ; 139 	return (end >= start) ? (end - start) : ((0xffffffff - start + 1) + end);
 551  0123 96            	ldw	x,sp
 552  0124 1c0008        	addw	x,#OFST+8
 553  0127 8d000000      	callf	d_ltor
 555  012b 96            	ldw	x,sp
 556  012c 1c0004        	addw	x,#OFST+4
 557  012f 8d000000      	callf	d_lcmp
 559  0133 2512          	jrult	L22
 560  0135 96            	ldw	x,sp
 561  0136 1c0008        	addw	x,#OFST+8
 562  0139 8d000000      	callf	d_ltor
 564  013d 96            	ldw	x,sp
 565  013e 1c0004        	addw	x,#OFST+4
 566  0141 8d000000      	callf	d_lsub
 568  0145 2014          	jra	L42
 569  0147               L22:
 570  0147 96            	ldw	x,sp
 571  0148 1c0004        	addw	x,#OFST+4
 572  014b 8d000000      	callf	d_ltor
 574  014f 8d000000      	callf	d_lneg
 576  0153 96            	ldw	x,sp
 577  0154 1c0008        	addw	x,#OFST+8
 578  0157 8d000000      	callf	d_ladd
 580  015b               L42:
 583  015b 87            	retf
 630                     ; 143 unsigned int read_ADC_Channel(uint8_t channel) {
 631                     	switch	.text
 632  015c               f_read_ADC_Channel:
 634  015c 89            	pushw	x
 635       00000002      OFST:	set	2
 638                     ; 144 	unsigned int adcValue = 0;
 640                     ; 145 	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, channel, ADC2_ALIGN_RIGHT);
 642  015d 4b08          	push	#8
 643  015f ae0100        	ldw	x,#256
 644  0162 97            	ld	xl,a
 645  0163 8d000000      	callf	f_ADC2_ConversionConfig
 647  0167 84            	pop	a
 648                     ; 146 	ADC2_StartConversion();
 650  0168 8d000000      	callf	f_ADC2_StartConversion
 653  016c               L371:
 654                     ; 148 	while (ADC2_GetFlagStatus() == RESET);
 656  016c 8d000000      	callf	f_ADC2_GetFlagStatus
 658  0170 4d            	tnz	a
 659  0171 27f9          	jreq	L371
 660                     ; 150 	adcValue = ADC2_GetConversionValue();
 662  0173 8d000000      	callf	f_ADC2_GetConversionValue
 664  0177 1f01          	ldw	(OFST-1,sp),x
 666                     ; 151 	ADC2_ClearFlag();
 668  0179 8d000000      	callf	f_ADC2_ClearFlag
 670                     ; 152 	return adcValue;
 672  017d 1e01          	ldw	x,(OFST-1,sp)
 675  017f 5b02          	addw	sp,#2
 676  0181 87            	retf
 749                     ; 156 bool detectZeroCross(float previousSample, float currentSample, float threshold) {
 750                     	switch	.text
 751  0182               f_detectZeroCross:
 753       00000000      OFST:	set	0
 756                     ; 157 	if (crossingType == -1) {  // If no crossing type detected, check for both positive and negative
 758  0182 be10          	ldw	x,_crossingType
 759  0184 a3ffff        	cpw	x,#65535
 760  0187 2666          	jrne	L532
 761                     ; 158 		if (previousSample <= threshold && currentSample > threshold) {
 763  0189 9c            	rvf
 764  018a 96            	ldw	x,sp
 765  018b 1c0004        	addw	x,#OFST+4
 766  018e 8d000000      	callf	d_ltor
 768  0192 96            	ldw	x,sp
 769  0193 1c000c        	addw	x,#OFST+12
 770  0196 8d000000      	callf	d_fcmp
 772  019a 2c19          	jrsgt	L732
 774  019c 9c            	rvf
 775  019d 96            	ldw	x,sp
 776  019e 1c0008        	addw	x,#OFST+8
 777  01a1 8d000000      	callf	d_ltor
 779  01a5 96            	ldw	x,sp
 780  01a6 1c000c        	addw	x,#OFST+12
 781  01a9 8d000000      	callf	d_fcmp
 783  01ad 2d06          	jrsle	L732
 784                     ; 159 			crossingType = 0;  // Positive zero crossing
 786  01af 5f            	clrw	x
 787  01b0 bf10          	ldw	_crossingType,x
 788                     ; 160 			return true;
 790  01b2 a601          	ld	a,#1
 793  01b4 87            	retf
 794  01b5               L732:
 795                     ; 161 		} else if (previousSample >= -threshold && currentSample < -threshold) {
 797  01b5 9c            	rvf
 798  01b6 96            	ldw	x,sp
 799  01b7 1c000c        	addw	x,#OFST+12
 800  01ba 8d000000      	callf	d_ltor
 802  01be 8d000000      	callf	d_fneg
 804  01c2 96            	ldw	x,sp
 805  01c3 1c0004        	addw	x,#OFST+4
 806  01c6 8d000000      	callf	d_fcmp
 808  01ca 2d04          	jrsle	L23
 809  01cc ac540254      	jpf	L542
 810  01d0               L23:
 812  01d0 9c            	rvf
 813  01d1 96            	ldw	x,sp
 814  01d2 1c000c        	addw	x,#OFST+12
 815  01d5 8d000000      	callf	d_ltor
 817  01d9 8d000000      	callf	d_fneg
 819  01dd 96            	ldw	x,sp
 820  01de 1c0008        	addw	x,#OFST+8
 821  01e1 8d000000      	callf	d_fcmp
 823  01e5 2d6d          	jrsle	L542
 824                     ; 162 			crossingType = 1;  // Negative zero crossing
 826  01e7 ae0001        	ldw	x,#1
 827  01ea bf10          	ldw	_crossingType,x
 828                     ; 163 			return true;
 830  01ec a601          	ld	a,#1
 833  01ee 87            	retf
 834  01ef               L532:
 835                     ; 165 	} else if (crossingType == 0 && previousSample <= threshold && currentSample > threshold) {
 837  01ef be10          	ldw	x,_crossingType
 838  01f1 2629          	jrne	L742
 840  01f3 9c            	rvf
 841  01f4 96            	ldw	x,sp
 842  01f5 1c0004        	addw	x,#OFST+4
 843  01f8 8d000000      	callf	d_ltor
 845  01fc 96            	ldw	x,sp
 846  01fd 1c000c        	addw	x,#OFST+12
 847  0200 8d000000      	callf	d_fcmp
 849  0204 2c16          	jrsgt	L742
 851  0206 9c            	rvf
 852  0207 96            	ldw	x,sp
 853  0208 1c0008        	addw	x,#OFST+8
 854  020b 8d000000      	callf	d_ltor
 856  020f 96            	ldw	x,sp
 857  0210 1c000c        	addw	x,#OFST+12
 858  0213 8d000000      	callf	d_fcmp
 860  0217 2d03          	jrsle	L742
 861                     ; 166 			return true;  // Positive zero crossing
 863  0219 a601          	ld	a,#1
 866  021b 87            	retf
 867  021c               L742:
 868                     ; 167 	} else if (crossingType == 1 && previousSample >= -threshold && currentSample < -threshold) {
 870  021c be10          	ldw	x,_crossingType
 871  021e a30001        	cpw	x,#1
 872  0221 2631          	jrne	L542
 874  0223 9c            	rvf
 875  0224 96            	ldw	x,sp
 876  0225 1c000c        	addw	x,#OFST+12
 877  0228 8d000000      	callf	d_ltor
 879  022c 8d000000      	callf	d_fneg
 881  0230 96            	ldw	x,sp
 882  0231 1c0004        	addw	x,#OFST+4
 883  0234 8d000000      	callf	d_fcmp
 885  0238 2c1a          	jrsgt	L542
 887  023a 9c            	rvf
 888  023b 96            	ldw	x,sp
 889  023c 1c000c        	addw	x,#OFST+12
 890  023f 8d000000      	callf	d_ltor
 892  0243 8d000000      	callf	d_fneg
 894  0247 96            	ldw	x,sp
 895  0248 1c0008        	addw	x,#OFST+8
 896  024b 8d000000      	callf	d_fcmp
 898  024f 2d03          	jrsle	L542
 899                     ; 168 			return true;  // Negative zero crossing
 901  0251 a601          	ld	a,#1
 904  0253 87            	retf
 905  0254               L542:
 906                     ; 171 	return false;  // No zero crossing detected
 908  0254 4f            	clr	a
 911  0255 87            	retf
 963                     ; 175 bool detectPosZeroCross(float previousSample, float currentSample, float threshold) {
 964                     	switch	.text
 965  0256               f_detectPosZeroCross:
 967       00000000      OFST:	set	0
 970                     ; 176 	return (previousSample <= threshold && currentSample > threshold);
 972  0256 9c            	rvf
 973  0257 96            	ldw	x,sp
 974  0258 1c0004        	addw	x,#OFST+4
 975  025b 8d000000      	callf	d_ltor
 977  025f 96            	ldw	x,sp
 978  0260 1c000c        	addw	x,#OFST+12
 979  0263 8d000000      	callf	d_fcmp
 981  0267 2c17          	jrsgt	L63
 982  0269 9c            	rvf
 983  026a 96            	ldw	x,sp
 984  026b 1c0008        	addw	x,#OFST+8
 985  026e 8d000000      	callf	d_ltor
 987  0272 96            	ldw	x,sp
 988  0273 1c000c        	addw	x,#OFST+12
 989  0276 8d000000      	callf	d_fcmp
 991  027a 2d04          	jrsle	L63
 992  027c a601          	ld	a,#1
 993  027e 2001          	jra	L04
 994  0280               L63:
 995  0280 4f            	clr	a
 996  0281               L04:
 999  0281 87            	retf
1070                     ; 180 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
1071                     	switch	.text
1072  0282               f_calculate_amplitude:
1074  0282 89            	pushw	x
1075  0283 520c          	subw	sp,#12
1076       0000000c      OFST:	set	12
1079                     ; 181 	uint32_t i = 0;
1081                     ; 182 	float max_val = -V_REF, min_val = V_REF;
1083  0285 ce1025        	ldw	x,L543+2
1084  0288 1f03          	ldw	(OFST-9,sp),x
1085  028a ce1023        	ldw	x,L543
1086  028d 1f01          	ldw	(OFST-11,sp),x
1090  028f ce1029        	ldw	x,L553+2
1091  0292 1f07          	ldw	(OFST-5,sp),x
1092  0294 ce1027        	ldw	x,L553
1093  0297 1f05          	ldw	(OFST-7,sp),x
1095                     ; 184 	for (i = 0; i < sample_size; i++) {
1097  0299 ae0000        	ldw	x,#0
1098  029c 1f0b          	ldw	(OFST-1,sp),x
1099  029e ae0000        	ldw	x,#0
1100  02a1 1f09          	ldw	(OFST-3,sp),x
1103  02a3 2058          	jra	L563
1104  02a5               L163:
1105                     ; 185 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1107  02a5 9c            	rvf
1108  02a6 1e0b          	ldw	x,(OFST-1,sp)
1109  02a8 58            	sllw	x
1110  02a9 58            	sllw	x
1111  02aa 72fb0d        	addw	x,(OFST+1,sp)
1112  02ad 8d000000      	callf	d_ltor
1114  02b1 96            	ldw	x,sp
1115  02b2 1c0001        	addw	x,#OFST-11
1116  02b5 8d000000      	callf	d_fcmp
1118  02b9 2d11          	jrsle	L173
1121  02bb 1e0b          	ldw	x,(OFST-1,sp)
1122  02bd 58            	sllw	x
1123  02be 58            	sllw	x
1124  02bf 72fb0d        	addw	x,(OFST+1,sp)
1125  02c2 9093          	ldw	y,x
1126  02c4 ee02          	ldw	x,(2,x)
1127  02c6 1f03          	ldw	(OFST-9,sp),x
1128  02c8 93            	ldw	x,y
1129  02c9 fe            	ldw	x,(x)
1130  02ca 1f01          	ldw	(OFST-11,sp),x
1132  02cc               L173:
1133                     ; 186 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1135  02cc 9c            	rvf
1136  02cd 1e0b          	ldw	x,(OFST-1,sp)
1137  02cf 58            	sllw	x
1138  02d0 58            	sllw	x
1139  02d1 72fb0d        	addw	x,(OFST+1,sp)
1140  02d4 8d000000      	callf	d_ltor
1142  02d8 96            	ldw	x,sp
1143  02d9 1c0005        	addw	x,#OFST-7
1144  02dc 8d000000      	callf	d_fcmp
1146  02e0 2e11          	jrsge	L373
1149  02e2 1e0b          	ldw	x,(OFST-1,sp)
1150  02e4 58            	sllw	x
1151  02e5 58            	sllw	x
1152  02e6 72fb0d        	addw	x,(OFST+1,sp)
1153  02e9 9093          	ldw	y,x
1154  02eb ee02          	ldw	x,(2,x)
1155  02ed 1f07          	ldw	(OFST-5,sp),x
1156  02ef 93            	ldw	x,y
1157  02f0 fe            	ldw	x,(x)
1158  02f1 1f05          	ldw	(OFST-7,sp),x
1160  02f3               L373:
1161                     ; 184 	for (i = 0; i < sample_size; i++) {
1163  02f3 96            	ldw	x,sp
1164  02f4 1c0009        	addw	x,#OFST-3
1165  02f7 a601          	ld	a,#1
1166  02f9 8d000000      	callf	d_lgadc
1169  02fd               L563:
1172  02fd 96            	ldw	x,sp
1173  02fe 1c0009        	addw	x,#OFST-3
1174  0301 8d000000      	callf	d_ltor
1176  0305 96            	ldw	x,sp
1177  0306 1c0012        	addw	x,#OFST+6
1178  0309 8d000000      	callf	d_lcmp
1180  030d 2596          	jrult	L163
1181                     ; 189 	return (max_val - min_val);
1183  030f 96            	ldw	x,sp
1184  0310 1c0001        	addw	x,#OFST-11
1185  0313 8d000000      	callf	d_ltor
1187  0317 96            	ldw	x,sp
1188  0318 1c0005        	addw	x,#OFST-7
1189  031b 8d000000      	callf	d_fsub
1193  031f 5b0e          	addw	sp,#14
1194  0321 87            	retf
1238                     ; 193 void initialize_adc_buffer(float buffer[]) {
1239                     	switch	.text
1240  0322               f_initialize_adc_buffer:
1242  0322 89            	pushw	x
1243  0323 89            	pushw	x
1244       00000002      OFST:	set	2
1247                     ; 194 	uint16_t i = 0;
1249                     ; 195 	for (i = 0; i < NUM_SAMPLES; i++) {
1251  0324 5f            	clrw	x
1252  0325 1f01          	ldw	(OFST-1,sp),x
1254  0327               L714:
1255                     ; 196 		buffer[i] = -1;  // Reset each element of the ADC buffer
1257  0327 1e01          	ldw	x,(OFST-1,sp)
1258  0329 58            	sllw	x
1259  032a 58            	sllw	x
1260  032b 72fb03        	addw	x,(OFST+1,sp)
1261  032e 90aeffff      	ldw	y,#65535
1262  0332 51            	exgw	x,y
1263  0333 8d000000      	callf	d_itof
1265  0337 51            	exgw	x,y
1266  0338 8d000000      	callf	d_rtol
1268                     ; 195 	for (i = 0; i < NUM_SAMPLES; i++) {
1270  033c 1e01          	ldw	x,(OFST-1,sp)
1271  033e 1c0001        	addw	x,#1
1272  0341 1f01          	ldw	(OFST-1,sp),x
1276  0343 1e01          	ldw	x,(OFST-1,sp)
1277  0345 a30400        	cpw	x,#1024
1278  0348 25dd          	jrult	L714
1279                     ; 198 }
1282  034a 5b04          	addw	sp,#4
1283  034c 87            	retf
1380                     ; 201 float process_adc_samples(float buffer[]) {
1381                     	switch	.text
1382  034d               f_process_adc_samples:
1384  034d 89            	pushw	x
1385  034e 5214          	subw	sp,#20
1386       00000014      OFST:	set	20
1389                     ; 202 	unsigned long currentEdgeTime = 0;
1391                     ; 203 	float freqBuff = 0;
1393  0350 ae0000        	ldw	x,#0
1394  0353 1f0b          	ldw	(OFST-9,sp),x
1395  0355 ae0000        	ldw	x,#0
1396  0358 1f09          	ldw	(OFST-11,sp),x
1398                     ; 204 	int freqCount = 0;
1400  035a 5f            	clrw	x
1401  035b 1f0d          	ldw	(OFST-7,sp),x
1403                     ; 205 	uint16_t i = 0;
1405                     ; 206 	lastEdgeTime = 0;           // Reset last zero-crossing time
1407  035d ae0000        	ldw	x,#0
1408  0360 bf0a          	ldw	_lastEdgeTime+2,x
1409  0362 ae0000        	ldw	x,#0
1410  0365 bf08          	ldw	_lastEdgeTime,x
1411                     ; 207 	for (i = 0; i < NUM_SAMPLES; i++) {
1413  0367 5f            	clrw	x
1414  0368 1f13          	ldw	(OFST-1,sp),x
1416  036a               L374:
1417                     ; 209 		buffer[i] = convert_adc_to_voltage(read_ADC_Channel(ADC2_CHANNEL_5));
1419  036a a605          	ld	a,#5
1420  036c 8d5c015c      	callf	f_read_ADC_Channel
1422  0370 8d6d046d      	callf	f_convert_adc_to_voltage
1424  0374 1e13          	ldw	x,(OFST-1,sp)
1425  0376 58            	sllw	x
1426  0377 58            	sllw	x
1427  0378 72fb15        	addw	x,(OFST+1,sp)
1428  037b 8d000000      	callf	d_rtol
1430                     ; 211 		delay_us(1000000 / SAMPLE_RATE);
1432  037f ae1a0a        	ldw	x,#6666
1433  0382 8d000000      	callf	f_delay_us
1435                     ; 213 		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
1437  0386 1e13          	ldw	x,(OFST-1,sp)
1438  0388 2604          	jrne	L45
1439  038a ac2c042c      	jpf	L105
1440  038e               L45:
1442  038e ce1021        	ldw	x,L705+2
1443  0391 89            	pushw	x
1444  0392 ce101f        	ldw	x,L705
1445  0395 89            	pushw	x
1446  0396 1e17          	ldw	x,(OFST+3,sp)
1447  0398 58            	sllw	x
1448  0399 58            	sllw	x
1449  039a 72fb19        	addw	x,(OFST+5,sp)
1450  039d 9093          	ldw	y,x
1451  039f ee02          	ldw	x,(2,x)
1452  03a1 89            	pushw	x
1453  03a2 93            	ldw	x,y
1454  03a3 fe            	ldw	x,(x)
1455  03a4 89            	pushw	x
1456  03a5 1e1b          	ldw	x,(OFST+7,sp)
1457  03a7 58            	sllw	x
1458  03a8 58            	sllw	x
1459  03a9 1d0004        	subw	x,#4
1460  03ac 72fb1d        	addw	x,(OFST+9,sp)
1461  03af 9093          	ldw	y,x
1462  03b1 ee02          	ldw	x,(2,x)
1463  03b3 89            	pushw	x
1464  03b4 93            	ldw	x,y
1465  03b5 fe            	ldw	x,(x)
1466  03b6 89            	pushw	x
1467  03b7 8d820182      	callf	f_detectZeroCross
1469  03bb 5b0c          	addw	sp,#12
1470  03bd 4d            	tnz	a
1471  03be 276c          	jreq	L105
1472                     ; 214 			currentEdgeTime = micros();
1474  03c0 8d000000      	callf	f_micros
1476  03c4 96            	ldw	x,sp
1477  03c5 1c000f        	addw	x,#OFST-5
1478  03c8 8d000000      	callf	d_rtol
1481                     ; 215 			if (lastEdgeTime > 0) {  // Ensure a previous edge exists
1483  03cc ae0008        	ldw	x,#_lastEdgeTime
1484  03cf 8d000000      	callf	d_lzmp
1486  03d3 274f          	jreq	L315
1487                     ; 216 				unsigned long period = currentEdgeTime - lastEdgeTime;   // Calculate period
1489  03d5 96            	ldw	x,sp
1490  03d6 1c000f        	addw	x,#OFST-5
1491  03d9 8d000000      	callf	d_ltor
1493  03dd ae0008        	ldw	x,#_lastEdgeTime
1494  03e0 8d000000      	callf	d_lsub
1496  03e4 96            	ldw	x,sp
1497  03e5 1c0005        	addw	x,#OFST-15
1498  03e8 8d000000      	callf	d_rtol
1501                     ; 217 				float frequency = calculate_frequency(period);
1503  03ec 1e07          	ldw	x,(OFST-13,sp)
1504  03ee 89            	pushw	x
1505  03ef 1e07          	ldw	x,(OFST-13,sp)
1506  03f1 89            	pushw	x
1507  03f2 8d790479      	callf	f_calculate_frequency
1509  03f6 5b04          	addw	sp,#4
1510  03f8 96            	ldw	x,sp
1511  03f9 1c0005        	addw	x,#OFST-15
1512  03fc 8d000000      	callf	d_rtol
1515                     ; 218 				freqBuff += frequency;
1517  0400 96            	ldw	x,sp
1518  0401 1c0005        	addw	x,#OFST-15
1519  0404 8d000000      	callf	d_ltor
1521  0408 96            	ldw	x,sp
1522  0409 1c0009        	addw	x,#OFST-11
1523  040c 8d000000      	callf	d_fgadd
1526                     ; 219 				freqCount++;
1528  0410 1e0d          	ldw	x,(OFST-7,sp)
1529  0412 1c0001        	addw	x,#1
1530  0415 1f0d          	ldw	(OFST-7,sp),x
1532                     ; 220 				if (freqCount == 2)
1534  0417 1e0d          	ldw	x,(OFST-7,sp)
1535  0419 a30002        	cpw	x,#2
1536  041c 2606          	jrne	L315
1537                     ; 222 					count = i;    // for amplitude calculation limit bound
1539  041e 1e13          	ldw	x,(OFST-1,sp)
1540  0420 bf12          	ldw	_count,x
1541                     ; 223 					break;        // break when zeroCrossing detection is two
1543  0422 201a          	jra	L774
1544  0424               L315:
1545                     ; 227 			lastEdgeTime = currentEdgeTime;  // Update last edge time
1547  0424 1e11          	ldw	x,(OFST-3,sp)
1548  0426 bf0a          	ldw	_lastEdgeTime+2,x
1549  0428 1e0f          	ldw	x,(OFST-5,sp)
1550  042a bf08          	ldw	_lastEdgeTime,x
1551  042c               L105:
1552                     ; 207 	for (i = 0; i < NUM_SAMPLES; i++) {
1554  042c 1e13          	ldw	x,(OFST-1,sp)
1555  042e 1c0001        	addw	x,#1
1556  0431 1f13          	ldw	(OFST-1,sp),x
1560  0433 1e13          	ldw	x,(OFST-1,sp)
1561  0435 a30400        	cpw	x,#1024
1562  0438 2404          	jruge	L65
1563  043a ac6a036a      	jpf	L374
1564  043e               L65:
1565  043e               L774:
1566                     ; 232 	return (freqCount > 0) ? (freqBuff / freqCount) : 0.0;
1568  043e 9c            	rvf
1569  043f 1e0d          	ldw	x,(OFST-7,sp)
1570  0441 2d20          	jrsle	L05
1571  0443 1e0d          	ldw	x,(OFST-7,sp)
1572  0445 8d000000      	callf	d_itof
1574  0449 96            	ldw	x,sp
1575  044a 1c0001        	addw	x,#OFST-19
1576  044d 8d000000      	callf	d_rtol
1579  0451 96            	ldw	x,sp
1580  0452 1c0009        	addw	x,#OFST-11
1581  0455 8d000000      	callf	d_ltor
1583  0459 96            	ldw	x,sp
1584  045a 1c0001        	addw	x,#OFST-19
1585  045d 8d000000      	callf	d_fdiv
1587  0461 2007          	jra	L25
1588  0463               L05:
1589  0463 ae104d        	ldw	x,#L325
1590  0466 8d000000      	callf	d_ltor
1592  046a               L25:
1595  046a 5b16          	addw	sp,#22
1596  046c 87            	retf
1630                     ; 236 float convert_adc_to_voltage(unsigned int adcValue) {
1631                     	switch	.text
1632  046d               f_convert_adc_to_voltage:
1636                     ; 237 	return adcValue * (V_REF / ADC_MAX_VALUE);
1638  046d 8d000000      	callf	d_uitof
1640  0471 ae101b        	ldw	x,#L155
1641  0474 8d000000      	callf	d_fmul
1645  0478 87            	retf
1679                     ; 241 float calculate_frequency(unsigned long period) {
1680                     	switch	.text
1681  0479               f_calculate_frequency:
1683  0479 5204          	subw	sp,#4
1684       00000004      OFST:	set	4
1687                     ; 242 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
1689  047b 96            	ldw	x,sp
1690  047c 1c0008        	addw	x,#OFST+4
1691  047f 8d000000      	callf	d_ltor
1693  0483 8d000000      	callf	d_ultof
1695  0487 ae1013        	ldw	x,#L706
1696  048a 8d000000      	callf	d_fdiv
1698  048e 96            	ldw	x,sp
1699  048f 1c0001        	addw	x,#OFST-3
1700  0492 8d000000      	callf	d_rtol
1703  0496 ae1017        	ldw	x,#L775
1704  0499 8d000000      	callf	d_ltor
1706  049d 96            	ldw	x,sp
1707  049e 1c0001        	addw	x,#OFST-3
1708  04a1 8d000000      	callf	d_fdiv
1712  04a5 5b04          	addw	sp,#4
1713  04a7 87            	retf
1767                     ; 246 void output_results(float frequency, float amplitude) {
1768                     	switch	.text
1769  04a8               f_output_results:
1771  04a8 5228          	subw	sp,#40
1772       00000028      OFST:	set	40
1775                     ; 252 	sprintf(buffer, "%.3f,%.3f,%.3f\n", frequency, amplitude, amplitude);
1777  04aa 1e32          	ldw	x,(OFST+10,sp)
1778  04ac 89            	pushw	x
1779  04ad 1e32          	ldw	x,(OFST+10,sp)
1780  04af 89            	pushw	x
1781  04b0 1e36          	ldw	x,(OFST+14,sp)
1782  04b2 89            	pushw	x
1783  04b3 1e36          	ldw	x,(OFST+14,sp)
1784  04b5 89            	pushw	x
1785  04b6 1e36          	ldw	x,(OFST+14,sp)
1786  04b8 89            	pushw	x
1787  04b9 1e36          	ldw	x,(OFST+14,sp)
1788  04bb 89            	pushw	x
1789  04bc ae1003        	ldw	x,#L146
1790  04bf 89            	pushw	x
1791  04c0 96            	ldw	x,sp
1792  04c1 1c000f        	addw	x,#OFST-25
1793  04c4 8d000000      	callf	f_sprintf
1795  04c8 5b0e          	addw	sp,#14
1796                     ; 255 	printf("%s", buffer);
1798  04ca 96            	ldw	x,sp
1799  04cb 1c0001        	addw	x,#OFST-39
1800  04ce 89            	pushw	x
1801  04cf ae1000        	ldw	x,#L346
1802  04d2 8d000000      	callf	f_printf
1804  04d6 85            	popw	x
1805                     ; 257 }
1808  04d7 5b28          	addw	sp,#40
1809  04d9 87            	retf
1844                     ; 260 PUTCHAR_PROTOTYPE {
1845                     	switch	.text
1846  04da               f_putchar:
1848  04da 88            	push	a
1849       00000000      OFST:	set	0
1852                     ; 261 	UART3_SendData8(c);
1854  04db 8d000000      	callf	f_UART3_SendData8
1857  04df               L566:
1858                     ; 262 	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
1860  04df ae0080        	ldw	x,#128
1861  04e2 8d000000      	callf	f_UART3_GetFlagStatus
1863  04e6 4d            	tnz	a
1864  04e7 27f6          	jreq	L566
1865                     ; 263 	return c;
1867  04e9 7b01          	ld	a,(OFST+1,sp)
1870  04eb 5b01          	addw	sp,#1
1871  04ed 87            	retf
1906                     ; 266 GETCHAR_PROTOTYPE
1906                     ; 267 {
1907                     	switch	.text
1908  04ee               f_getchar:
1910  04ee 88            	push	a
1911       00000001      OFST:	set	1
1914                     ; 268   char c = 0;
1917  04ef               L117:
1918                     ; 270   while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
1920  04ef ae0020        	ldw	x,#32
1921  04f2 8d000000      	callf	f_UART3_GetFlagStatus
1923  04f6 4d            	tnz	a
1924  04f7 27f6          	jreq	L117
1925                     ; 271 	c = UART3_ReceiveData8();
1927  04f9 8d000000      	callf	f_UART3_ReceiveData8
1929  04fd 6b01          	ld	(OFST+0,sp),a
1931                     ; 272   return (c);
1933  04ff 7b01          	ld	a,(OFST+0,sp)
1936  0501 5b01          	addw	sp,#1
1937  0503 87            	retf
2005                     	xdef	f_main
2006                     	xdef	f_calculate_frequency
2007                     	xdef	f_convert_adc_to_voltage
2008                     	xdef	f_process_adc_samples
2009                     	xdef	f_calculate_amplitude
2010                     	xdef	f_output_results
2011                     	xdef	f_initialize_adc_buffer
2012                     	xdef	f_detectZeroCross
2013                     	xdef	f_detectPosZeroCross
2014                     	xdef	f_read_ADC_Channel
2015                     	xdef	f_elapsedTime
2016                     	xdef	f_ADC2_setup
2017                     	xdef	f_UART3_setup
2018                     	xdef	f_clock_setup
2019                     	xdef	f_main_loop
2020                     	xdef	f_initialize_system
2021                     	xdef	_count
2022                     	xdef	_crossingType
2023                     	xdef	_currentEdgeTime
2024                     	xdef	_lastEdgeTime
2025                     	xdef	_sine1_amplitude
2026                     	xdef	_sine1_frequency
2027                     	xref	f_EEPROM_Config
2028                     	xref	f_micros
2029                     	xref	f_delay_us
2030                     	xref	f_TIM4_Config
2031                     	xref	f_sprintf
2032                     	xdef	f_putchar
2033                     	xref	f_printf
2034                     	xdef	f_getchar
2035                     	xref	f_UART3_GetFlagStatus
2036                     	xref	f_UART3_SendData8
2037                     	xref	f_UART3_ReceiveData8
2038                     	xref	f_UART3_Cmd
2039                     	xref	f_UART3_Init
2040                     	xref	f_UART3_DeInit
2041                     	xref	f_GPIO_Init
2042                     	xref	f_GPIO_DeInit
2043                     	xref	f_CLK_GetFlagStatus
2044                     	xref	f_CLK_SYSCLKConfig
2045                     	xref	f_CLK_HSIPrescalerConfig
2046                     	xref	f_CLK_ClockSwitchConfig
2047                     	xref	f_CLK_PeripheralClockConfig
2048                     	xref	f_CLK_ClockSwitchCmd
2049                     	xref	f_CLK_LSICmd
2050                     	xref	f_CLK_HSICmd
2051                     	xref	f_CLK_HSECmd
2052                     	xref	f_CLK_DeInit
2053                     	xref	f_ADC2_ClearFlag
2054                     	xref	f_ADC2_GetFlagStatus
2055                     	xref	f_ADC2_GetConversionValue
2056                     	xref	f_ADC2_StartConversion
2057                     	xref	f_ADC2_ConversionConfig
2058                     	xref	f_ADC2_Cmd
2059                     	xref	f_ADC2_Init
2060                     	xref	f_ADC2_DeInit
2061                     	switch	.const
2062  1000               L346:
2063  1000 257300        	dc.b	"%s",0
2064  1003               L146:
2065  1003 252e33662c25  	dc.b	"%.3f,%.3f,%.3f",10,0
2066  1013               L706:
2067  1013 49742400      	dc.w	18804,9216
2068  1017               L775:
2069  1017 3f800000      	dc.w	16256,0
2070  101b               L155:
2071  101b 3b954409      	dc.w	15253,17417
2072  101f               L705:
2073  101f 401851eb      	dc.w	16408,20971
2074  1023               L543:
2075  1023 c0951eb8      	dc.w	-16235,7864
2076  1027               L553:
2077  1027 40951eb8      	dc.w	16533,7864
2078  102b               L13:
2079  102b 53797374656d  	dc.b	"System Initializat"
2080  103d 696f6e20436f  	dc.b	"ion Completed",10
2081  104b 0d00          	dc.b	13,0
2082  104d               L325:
2083  104d 00000000      	dc.w	0,0
2084                     	xref.b	c_lreg
2085                     	xref.b	c_x
2086                     	xref.b	c_y
2106                     	xref	d_ultof
2107                     	xref	d_fmul
2108                     	xref	d_uitof
2109                     	xref	d_fdiv
2110                     	xref	d_fgadd
2111                     	xref	d_lzmp
2112                     	xref	d_itof
2113                     	xref	d_fsub
2114                     	xref	d_lgadc
2115                     	xref	d_fneg
2116                     	xref	d_fcmp
2117                     	xref	d_ladd
2118                     	xref	d_lneg
2119                     	xref	d_lsub
2120                     	xref	d_lcmp
2121                     	xref	d_ltor
2122                     	xref	d_uitolx
2123                     	xref	d_rtol
2124                     	xref	d_xymovl
2125                     	end
