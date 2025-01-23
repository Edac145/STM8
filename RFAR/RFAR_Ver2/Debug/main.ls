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
  69  0004 8dbf00bf      	callf	f_main_loop
  71                     ; 57 }
  74  0008 87            	retf
 103                     ; 64 void initialize_system(void) {
 104                     	switch	.text
 105  0009               f_initialize_system:
 109                     ; 65     clock_setup();          // Configure system clock
 111  0009 8d340034      	callf	f_clock_setup
 113                     ; 66 		TIM4_Config();          // Timer 4 config for delay
 115  000d 8d000000      	callf	f_TIM4_Config
 117                     ; 67     UART3_setup();          // Setup UART communication
 119  0011 8d770077      	callf	f_UART3_setup
 121                     ; 68     ADC2_setup();           // Setup ADC
 123  0015 8d980098      	callf	f_ADC2_setup
 125                     ; 69     GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
 127  0019 ae500a        	ldw	x,#20490
 128  001c 8d000000      	callf	f_GPIO_DeInit
 130                     ; 70     GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 132  0020 4be0          	push	#224
 133  0022 4b08          	push	#8
 134  0024 ae500a        	ldw	x,#20490
 135  0027 8d000000      	callf	f_GPIO_Init
 137  002b 85            	popw	x
 138                     ; 71     printf("System Initialization Completed\n\r");
 140  002c ae102e        	ldw	x,#L13
 141  002f 8d000000      	callf	f_printf
 143                     ; 72 }
 146  0033 87            	retf
 178                     ; 75 void clock_setup(void) {
 179                     	switch	.text
 180  0034               f_clock_setup:
 184                     ; 76     CLK_DeInit();
 186  0034 8d000000      	callf	f_CLK_DeInit
 188                     ; 77     CLK_HSECmd(DISABLE);
 190  0038 4f            	clr	a
 191  0039 8d000000      	callf	f_CLK_HSECmd
 193                     ; 78     CLK_LSICmd(DISABLE);
 195  003d 4f            	clr	a
 196  003e 8d000000      	callf	f_CLK_LSICmd
 198                     ; 79     CLK_HSICmd(ENABLE);
 200  0042 a601          	ld	a,#1
 201  0044 8d000000      	callf	f_CLK_HSICmd
 204  0048               L54:
 205                     ; 80     while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 207  0048 ae0102        	ldw	x,#258
 208  004b 8d000000      	callf	f_CLK_GetFlagStatus
 210  004f 4d            	tnz	a
 211  0050 27f6          	jreq	L54
 212                     ; 83     CLK_ClockSwitchCmd(ENABLE);
 214  0052 a601          	ld	a,#1
 215  0054 8d000000      	callf	f_CLK_ClockSwitchCmd
 217                     ; 84     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 219  0058 4f            	clr	a
 220  0059 8d000000      	callf	f_CLK_HSIPrescalerConfig
 222                     ; 85     CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 224  005d a680          	ld	a,#128
 225  005f 8d000000      	callf	f_CLK_SYSCLKConfig
 227                     ; 86     CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 229  0063 4b01          	push	#1
 230  0065 4b00          	push	#0
 231  0067 ae01e1        	ldw	x,#481
 232  006a 8d000000      	callf	f_CLK_ClockSwitchConfig
 234  006e 85            	popw	x
 235                     ; 90     CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 237  006f ae0301        	ldw	x,#769
 238  0072 8d000000      	callf	f_CLK_PeripheralClockConfig
 240                     ; 91 }
 243  0076 87            	retf
 268                     ; 94 void UART3_setup(void) {
 269                     	switch	.text
 270  0077               f_UART3_setup:
 274                     ; 95     UART3_DeInit();
 276  0077 8d000000      	callf	f_UART3_DeInit
 278                     ; 96     UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TX_ENABLE);
 280  007b 4b04          	push	#4
 281  007d 4b00          	push	#0
 282  007f 4b00          	push	#0
 283  0081 4b00          	push	#0
 284  0083 ae2580        	ldw	x,#9600
 285  0086 89            	pushw	x
 286  0087 ae0000        	ldw	x,#0
 287  008a 89            	pushw	x
 288  008b 8d000000      	callf	f_UART3_Init
 290  008f 5b08          	addw	sp,#8
 291                     ; 97     UART3_Cmd(ENABLE);
 293  0091 a601          	ld	a,#1
 294  0093 8d000000      	callf	f_UART3_Cmd
 296                     ; 98 }
 299  0097 87            	retf
 325                     ; 101 void ADC2_setup(void) {
 326                     	switch	.text
 327  0098               f_ADC2_setup:
 331                     ; 102     CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 333  0098 ae1301        	ldw	x,#4865
 334  009b 8d000000      	callf	f_CLK_PeripheralClockConfig
 336                     ; 103     ADC2_DeInit();
 338  009f 8d000000      	callf	f_ADC2_DeInit
 340                     ; 105     ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
 340                     ; 106               ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6, DISABLE);
 342  00a3 4b00          	push	#0
 343  00a5 4b07          	push	#7
 344  00a7 4b08          	push	#8
 345  00a9 4b00          	push	#0
 346  00ab 4b01          	push	#1
 347  00ad 4b00          	push	#0
 348  00af ae0105        	ldw	x,#261
 349  00b2 8d000000      	callf	f_ADC2_Init
 351  00b6 5b06          	addw	sp,#6
 352                     ; 108     ADC2_Cmd(ENABLE);
 354  00b8 a601          	ld	a,#1
 355  00ba 8d000000      	callf	f_ADC2_Cmd
 357                     ; 109 }
 360  00be 87            	retf
 362                     .const:	section	.text
 363  0000               L17_adc_buffer_1:
 364  0000 bf800000      	dc.w	-16512,0
 365  0004 000000000000  	ds.b	4092
 421                     ; 112 void main_loop(void) {
 422                     	switch	.text
 423  00bf               f_main_loop:
 425  00bf 96            	ldw	x,sp
 426  00c0 1d1018        	subw	x,#4120
 427  00c3 94            	ldw	sp,x
 428       00001018      OFST:	set	4120
 431  00c4               L121:
 432                     ; 115 		float adc_buffer_1[NUM_SAMPLES] = { -1 };
 434  00c4 96            	ldw	x,sp
 435  00c5 1c0019        	addw	x,#OFST-4095
 436  00c8 90ae0000      	ldw	y,#L17_adc_buffer_1
 437  00cc bf00          	ldw	c_x,x
 438  00ce ae1000        	ldw	x,#4096
 439  00d1 8d000000      	callf	d_xymovl
 441                     ; 116 		float sine1_frequency = 0;
 443                     ; 117 		float sine1_amplitude = 0;
 445                     ; 119 		initialize_adc_buffer(adc_buffer_1);
 447  00d5 96            	ldw	x,sp
 448  00d6 1c0019        	addw	x,#OFST-4095
 449  00d9 8d1e031e      	callf	f_initialize_adc_buffer
 451                     ; 122 		sine1_frequency = process_adc_samples(adc_buffer_1);
 453  00dd 96            	ldw	x,sp
 454  00de 1c0019        	addw	x,#OFST-4095
 455  00e1 8d490349      	callf	f_process_adc_samples
 457  00e5 96            	ldw	x,sp
 458  00e6 1c0011        	addw	x,#OFST-4103
 459  00e9 8d000000      	callf	d_rtol
 462                     ; 124 		sine1_amplitude = calculate_amplitude(adc_buffer_1, count);
 464  00ed be12          	ldw	x,_count
 465  00ef 8d000000      	callf	d_uitolx
 467  00f3 be02          	ldw	x,c_lreg+2
 468  00f5 89            	pushw	x
 469  00f6 be00          	ldw	x,c_lreg
 470  00f8 89            	pushw	x
 471  00f9 96            	ldw	x,sp
 472  00fa 1c001d        	addw	x,#OFST-4091
 473  00fd 8d7e027e      	callf	f_calculate_amplitude
 475  0101 5b04          	addw	sp,#4
 476  0103 96            	ldw	x,sp
 477  0104 1c0015        	addw	x,#OFST-4099
 478  0107 8d000000      	callf	d_rtol
 481                     ; 127 		output_results(sine1_frequency, sine1_amplitude);
 483  010b 1e17          	ldw	x,(OFST-4097,sp)
 484  010d 89            	pushw	x
 485  010e 1e17          	ldw	x,(OFST-4097,sp)
 486  0110 89            	pushw	x
 487  0111 1e17          	ldw	x,(OFST-4097,sp)
 488  0113 89            	pushw	x
 489  0114 1e17          	ldw	x,(OFST-4097,sp)
 490  0116 89            	pushw	x
 491  0117 8da404a4      	callf	f_output_results
 493  011b 5b08          	addw	sp,#8
 495  011d 20a5          	jra	L121
 537                     ; 136 uint32_t elapsedTime(uint32_t start, uint32_t end) {
 538                     	switch	.text
 539  011f               f_elapsedTime:
 541       00000000      OFST:	set	0
 544                     ; 137 	return (end >= start) ? (end - start) : ((0xffffffff - start + 1) + end);
 546  011f 96            	ldw	x,sp
 547  0120 1c0008        	addw	x,#OFST+8
 548  0123 8d000000      	callf	d_ltor
 550  0127 96            	ldw	x,sp
 551  0128 1c0004        	addw	x,#OFST+4
 552  012b 8d000000      	callf	d_lcmp
 554  012f 2512          	jrult	L22
 555  0131 96            	ldw	x,sp
 556  0132 1c0008        	addw	x,#OFST+8
 557  0135 8d000000      	callf	d_ltor
 559  0139 96            	ldw	x,sp
 560  013a 1c0004        	addw	x,#OFST+4
 561  013d 8d000000      	callf	d_lsub
 563  0141 2014          	jra	L42
 564  0143               L22:
 565  0143 96            	ldw	x,sp
 566  0144 1c0004        	addw	x,#OFST+4
 567  0147 8d000000      	callf	d_ltor
 569  014b 8d000000      	callf	d_lneg
 571  014f 96            	ldw	x,sp
 572  0150 1c0008        	addw	x,#OFST+8
 573  0153 8d000000      	callf	d_ladd
 575  0157               L42:
 578  0157 87            	retf
 625                     ; 141 unsigned int read_ADC_Channel(uint8_t channel) {
 626                     	switch	.text
 627  0158               f_read_ADC_Channel:
 629  0158 89            	pushw	x
 630       00000002      OFST:	set	2
 633                     ; 142 	unsigned int adcValue = 0;
 635                     ; 143 	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, channel, ADC2_ALIGN_RIGHT);
 637  0159 4b08          	push	#8
 638  015b ae0100        	ldw	x,#256
 639  015e 97            	ld	xl,a
 640  015f 8d000000      	callf	f_ADC2_ConversionConfig
 642  0163 84            	pop	a
 643                     ; 144 	ADC2_StartConversion();
 645  0164 8d000000      	callf	f_ADC2_StartConversion
 648  0168               L371:
 649                     ; 146 	while (ADC2_GetFlagStatus() == RESET);
 651  0168 8d000000      	callf	f_ADC2_GetFlagStatus
 653  016c 4d            	tnz	a
 654  016d 27f9          	jreq	L371
 655                     ; 148 	adcValue = ADC2_GetConversionValue();
 657  016f 8d000000      	callf	f_ADC2_GetConversionValue
 659  0173 1f01          	ldw	(OFST-1,sp),x
 661                     ; 149 	ADC2_ClearFlag();
 663  0175 8d000000      	callf	f_ADC2_ClearFlag
 665                     ; 150 	return adcValue;
 667  0179 1e01          	ldw	x,(OFST-1,sp)
 670  017b 5b02          	addw	sp,#2
 671  017d 87            	retf
 744                     ; 154 bool detectZeroCross(float previousSample, float currentSample, float threshold) {
 745                     	switch	.text
 746  017e               f_detectZeroCross:
 748       00000000      OFST:	set	0
 751                     ; 155 	if (crossingType == -1) {  // If no crossing type detected, check for both positive and negative
 753  017e be10          	ldw	x,_crossingType
 754  0180 a3ffff        	cpw	x,#65535
 755  0183 2666          	jrne	L532
 756                     ; 156 			if (previousSample <= threshold && currentSample > threshold) {
 758  0185 9c            	rvf
 759  0186 96            	ldw	x,sp
 760  0187 1c0004        	addw	x,#OFST+4
 761  018a 8d000000      	callf	d_ltor
 763  018e 96            	ldw	x,sp
 764  018f 1c000c        	addw	x,#OFST+12
 765  0192 8d000000      	callf	d_fcmp
 767  0196 2c19          	jrsgt	L732
 769  0198 9c            	rvf
 770  0199 96            	ldw	x,sp
 771  019a 1c0008        	addw	x,#OFST+8
 772  019d 8d000000      	callf	d_ltor
 774  01a1 96            	ldw	x,sp
 775  01a2 1c000c        	addw	x,#OFST+12
 776  01a5 8d000000      	callf	d_fcmp
 778  01a9 2d06          	jrsle	L732
 779                     ; 157 					crossingType = 0;  // Positive zero crossing
 781  01ab 5f            	clrw	x
 782  01ac bf10          	ldw	_crossingType,x
 783                     ; 158 					return true;
 785  01ae a601          	ld	a,#1
 788  01b0 87            	retf
 789  01b1               L732:
 790                     ; 159 			} else if (previousSample >= -threshold && currentSample < -threshold) {
 792  01b1 9c            	rvf
 793  01b2 96            	ldw	x,sp
 794  01b3 1c000c        	addw	x,#OFST+12
 795  01b6 8d000000      	callf	d_ltor
 797  01ba 8d000000      	callf	d_fneg
 799  01be 96            	ldw	x,sp
 800  01bf 1c0004        	addw	x,#OFST+4
 801  01c2 8d000000      	callf	d_fcmp
 803  01c6 2d04          	jrsle	L23
 804  01c8 ac500250      	jpf	L542
 805  01cc               L23:
 807  01cc 9c            	rvf
 808  01cd 96            	ldw	x,sp
 809  01ce 1c000c        	addw	x,#OFST+12
 810  01d1 8d000000      	callf	d_ltor
 812  01d5 8d000000      	callf	d_fneg
 814  01d9 96            	ldw	x,sp
 815  01da 1c0008        	addw	x,#OFST+8
 816  01dd 8d000000      	callf	d_fcmp
 818  01e1 2d6d          	jrsle	L542
 819                     ; 160 					crossingType = 1;  // Negative zero crossing
 821  01e3 ae0001        	ldw	x,#1
 822  01e6 bf10          	ldw	_crossingType,x
 823                     ; 161 					return true;
 825  01e8 a601          	ld	a,#1
 828  01ea 87            	retf
 829  01eb               L532:
 830                     ; 163 	} else if (crossingType == 0 && previousSample <= threshold && currentSample > threshold) {
 832  01eb be10          	ldw	x,_crossingType
 833  01ed 2629          	jrne	L742
 835  01ef 9c            	rvf
 836  01f0 96            	ldw	x,sp
 837  01f1 1c0004        	addw	x,#OFST+4
 838  01f4 8d000000      	callf	d_ltor
 840  01f8 96            	ldw	x,sp
 841  01f9 1c000c        	addw	x,#OFST+12
 842  01fc 8d000000      	callf	d_fcmp
 844  0200 2c16          	jrsgt	L742
 846  0202 9c            	rvf
 847  0203 96            	ldw	x,sp
 848  0204 1c0008        	addw	x,#OFST+8
 849  0207 8d000000      	callf	d_ltor
 851  020b 96            	ldw	x,sp
 852  020c 1c000c        	addw	x,#OFST+12
 853  020f 8d000000      	callf	d_fcmp
 855  0213 2d03          	jrsle	L742
 856                     ; 164 			return true;  // Positive zero crossing
 858  0215 a601          	ld	a,#1
 861  0217 87            	retf
 862  0218               L742:
 863                     ; 165 	} else if (crossingType == 1 && previousSample >= -threshold && currentSample < -threshold) {
 865  0218 be10          	ldw	x,_crossingType
 866  021a a30001        	cpw	x,#1
 867  021d 2631          	jrne	L542
 869  021f 9c            	rvf
 870  0220 96            	ldw	x,sp
 871  0221 1c000c        	addw	x,#OFST+12
 872  0224 8d000000      	callf	d_ltor
 874  0228 8d000000      	callf	d_fneg
 876  022c 96            	ldw	x,sp
 877  022d 1c0004        	addw	x,#OFST+4
 878  0230 8d000000      	callf	d_fcmp
 880  0234 2c1a          	jrsgt	L542
 882  0236 9c            	rvf
 883  0237 96            	ldw	x,sp
 884  0238 1c000c        	addw	x,#OFST+12
 885  023b 8d000000      	callf	d_ltor
 887  023f 8d000000      	callf	d_fneg
 889  0243 96            	ldw	x,sp
 890  0244 1c0008        	addw	x,#OFST+8
 891  0247 8d000000      	callf	d_fcmp
 893  024b 2d03          	jrsle	L542
 894                     ; 166 			return true;  // Negative zero crossing
 896  024d a601          	ld	a,#1
 899  024f 87            	retf
 900  0250               L542:
 901                     ; 169 	return false;  // No zero crossing detected
 903  0250 4f            	clr	a
 906  0251 87            	retf
 958                     ; 173 bool detectPosZeroCross(float previousSample, float currentSample, float threshold) {
 959                     	switch	.text
 960  0252               f_detectPosZeroCross:
 962       00000000      OFST:	set	0
 965                     ; 174 	return (previousSample <= threshold && currentSample > threshold);
 967  0252 9c            	rvf
 968  0253 96            	ldw	x,sp
 969  0254 1c0004        	addw	x,#OFST+4
 970  0257 8d000000      	callf	d_ltor
 972  025b 96            	ldw	x,sp
 973  025c 1c000c        	addw	x,#OFST+12
 974  025f 8d000000      	callf	d_fcmp
 976  0263 2c17          	jrsgt	L63
 977  0265 9c            	rvf
 978  0266 96            	ldw	x,sp
 979  0267 1c0008        	addw	x,#OFST+8
 980  026a 8d000000      	callf	d_ltor
 982  026e 96            	ldw	x,sp
 983  026f 1c000c        	addw	x,#OFST+12
 984  0272 8d000000      	callf	d_fcmp
 986  0276 2d04          	jrsle	L63
 987  0278 a601          	ld	a,#1
 988  027a 2001          	jra	L04
 989  027c               L63:
 990  027c 4f            	clr	a
 991  027d               L04:
 994  027d 87            	retf
1065                     ; 178 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
1066                     	switch	.text
1067  027e               f_calculate_amplitude:
1069  027e 89            	pushw	x
1070  027f 520c          	subw	sp,#12
1071       0000000c      OFST:	set	12
1074                     ; 179 	uint32_t i = 0;
1076                     ; 180 	float max_val = -V_REF, min_val = V_REF;
1078  0281 ce1028        	ldw	x,L543+2
1079  0284 1f03          	ldw	(OFST-9,sp),x
1080  0286 ce1026        	ldw	x,L543
1081  0289 1f01          	ldw	(OFST-11,sp),x
1085  028b ce102c        	ldw	x,L553+2
1086  028e 1f07          	ldw	(OFST-5,sp),x
1087  0290 ce102a        	ldw	x,L553
1088  0293 1f05          	ldw	(OFST-7,sp),x
1090                     ; 182 	for (i = 0; i < sample_size; i++) {
1092  0295 ae0000        	ldw	x,#0
1093  0298 1f0b          	ldw	(OFST-1,sp),x
1094  029a ae0000        	ldw	x,#0
1095  029d 1f09          	ldw	(OFST-3,sp),x
1098  029f 2058          	jra	L563
1099  02a1               L163:
1100                     ; 183 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1102  02a1 9c            	rvf
1103  02a2 1e0b          	ldw	x,(OFST-1,sp)
1104  02a4 58            	sllw	x
1105  02a5 58            	sllw	x
1106  02a6 72fb0d        	addw	x,(OFST+1,sp)
1107  02a9 8d000000      	callf	d_ltor
1109  02ad 96            	ldw	x,sp
1110  02ae 1c0001        	addw	x,#OFST-11
1111  02b1 8d000000      	callf	d_fcmp
1113  02b5 2d11          	jrsle	L173
1116  02b7 1e0b          	ldw	x,(OFST-1,sp)
1117  02b9 58            	sllw	x
1118  02ba 58            	sllw	x
1119  02bb 72fb0d        	addw	x,(OFST+1,sp)
1120  02be 9093          	ldw	y,x
1121  02c0 ee02          	ldw	x,(2,x)
1122  02c2 1f03          	ldw	(OFST-9,sp),x
1123  02c4 93            	ldw	x,y
1124  02c5 fe            	ldw	x,(x)
1125  02c6 1f01          	ldw	(OFST-11,sp),x
1127  02c8               L173:
1128                     ; 184 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1130  02c8 9c            	rvf
1131  02c9 1e0b          	ldw	x,(OFST-1,sp)
1132  02cb 58            	sllw	x
1133  02cc 58            	sllw	x
1134  02cd 72fb0d        	addw	x,(OFST+1,sp)
1135  02d0 8d000000      	callf	d_ltor
1137  02d4 96            	ldw	x,sp
1138  02d5 1c0005        	addw	x,#OFST-7
1139  02d8 8d000000      	callf	d_fcmp
1141  02dc 2e11          	jrsge	L373
1144  02de 1e0b          	ldw	x,(OFST-1,sp)
1145  02e0 58            	sllw	x
1146  02e1 58            	sllw	x
1147  02e2 72fb0d        	addw	x,(OFST+1,sp)
1148  02e5 9093          	ldw	y,x
1149  02e7 ee02          	ldw	x,(2,x)
1150  02e9 1f07          	ldw	(OFST-5,sp),x
1151  02eb 93            	ldw	x,y
1152  02ec fe            	ldw	x,(x)
1153  02ed 1f05          	ldw	(OFST-7,sp),x
1155  02ef               L373:
1156                     ; 182 	for (i = 0; i < sample_size; i++) {
1158  02ef 96            	ldw	x,sp
1159  02f0 1c0009        	addw	x,#OFST-3
1160  02f3 a601          	ld	a,#1
1161  02f5 8d000000      	callf	d_lgadc
1164  02f9               L563:
1167  02f9 96            	ldw	x,sp
1168  02fa 1c0009        	addw	x,#OFST-3
1169  02fd 8d000000      	callf	d_ltor
1171  0301 96            	ldw	x,sp
1172  0302 1c0012        	addw	x,#OFST+6
1173  0305 8d000000      	callf	d_lcmp
1175  0309 2596          	jrult	L163
1176                     ; 187 	return (max_val - min_val);
1178  030b 96            	ldw	x,sp
1179  030c 1c0001        	addw	x,#OFST-11
1180  030f 8d000000      	callf	d_ltor
1182  0313 96            	ldw	x,sp
1183  0314 1c0005        	addw	x,#OFST-7
1184  0317 8d000000      	callf	d_fsub
1188  031b 5b0e          	addw	sp,#14
1189  031d 87            	retf
1233                     ; 191 void initialize_adc_buffer(float buffer[]) {
1234                     	switch	.text
1235  031e               f_initialize_adc_buffer:
1237  031e 89            	pushw	x
1238  031f 89            	pushw	x
1239       00000002      OFST:	set	2
1242                     ; 192 	uint16_t i = 0;
1244                     ; 193 	for (i = 0; i < NUM_SAMPLES; i++) {
1246  0320 5f            	clrw	x
1247  0321 1f01          	ldw	(OFST-1,sp),x
1249  0323               L714:
1250                     ; 194 		buffer[i] = -1;  // Reset each element of the ADC buffer
1252  0323 1e01          	ldw	x,(OFST-1,sp)
1253  0325 58            	sllw	x
1254  0326 58            	sllw	x
1255  0327 72fb03        	addw	x,(OFST+1,sp)
1256  032a 90aeffff      	ldw	y,#65535
1257  032e 51            	exgw	x,y
1258  032f 8d000000      	callf	d_itof
1260  0333 51            	exgw	x,y
1261  0334 8d000000      	callf	d_rtol
1263                     ; 193 	for (i = 0; i < NUM_SAMPLES; i++) {
1265  0338 1e01          	ldw	x,(OFST-1,sp)
1266  033a 1c0001        	addw	x,#1
1267  033d 1f01          	ldw	(OFST-1,sp),x
1271  033f 1e01          	ldw	x,(OFST-1,sp)
1272  0341 a30400        	cpw	x,#1024
1273  0344 25dd          	jrult	L714
1274                     ; 196 }
1277  0346 5b04          	addw	sp,#4
1278  0348 87            	retf
1375                     ; 199 float process_adc_samples(float buffer[]) {
1376                     	switch	.text
1377  0349               f_process_adc_samples:
1379  0349 89            	pushw	x
1380  034a 5214          	subw	sp,#20
1381       00000014      OFST:	set	20
1384                     ; 200 	unsigned long currentEdgeTime = 0;
1386                     ; 201 	float freqBuff = 0;
1388  034c ae0000        	ldw	x,#0
1389  034f 1f0b          	ldw	(OFST-9,sp),x
1390  0351 ae0000        	ldw	x,#0
1391  0354 1f09          	ldw	(OFST-11,sp),x
1393                     ; 202 	int freqCount = 0;
1395  0356 5f            	clrw	x
1396  0357 1f0d          	ldw	(OFST-7,sp),x
1398                     ; 203 	uint16_t i = 0;
1400                     ; 204 	lastEdgeTime = 0;           // Reset last zero-crossing time
1402  0359 ae0000        	ldw	x,#0
1403  035c bf0a          	ldw	_lastEdgeTime+2,x
1404  035e ae0000        	ldw	x,#0
1405  0361 bf08          	ldw	_lastEdgeTime,x
1406                     ; 205 	for (i = 0; i < NUM_SAMPLES; i++) {
1408  0363 5f            	clrw	x
1409  0364 1f13          	ldw	(OFST-1,sp),x
1411  0366               L374:
1412                     ; 207 		buffer[i] = convert_adc_to_voltage(read_ADC_Channel(ADC2_CHANNEL_5));
1414  0366 a605          	ld	a,#5
1415  0368 8d580158      	callf	f_read_ADC_Channel
1417  036c 8d690469      	callf	f_convert_adc_to_voltage
1419  0370 1e13          	ldw	x,(OFST-1,sp)
1420  0372 58            	sllw	x
1421  0373 58            	sllw	x
1422  0374 72fb15        	addw	x,(OFST+1,sp)
1423  0377 8d000000      	callf	d_rtol
1425                     ; 209 		delay_us(1000000 / SAMPLE_RATE);
1427  037b ae1a0a        	ldw	x,#6666
1428  037e 8d000000      	callf	f_delay_us
1430                     ; 211 		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
1432  0382 1e13          	ldw	x,(OFST-1,sp)
1433  0384 2604          	jrne	L45
1434  0386 ac280428      	jpf	L105
1435  038a               L45:
1437  038a ce1024        	ldw	x,L705+2
1438  038d 89            	pushw	x
1439  038e ce1022        	ldw	x,L705
1440  0391 89            	pushw	x
1441  0392 1e17          	ldw	x,(OFST+3,sp)
1442  0394 58            	sllw	x
1443  0395 58            	sllw	x
1444  0396 72fb19        	addw	x,(OFST+5,sp)
1445  0399 9093          	ldw	y,x
1446  039b ee02          	ldw	x,(2,x)
1447  039d 89            	pushw	x
1448  039e 93            	ldw	x,y
1449  039f fe            	ldw	x,(x)
1450  03a0 89            	pushw	x
1451  03a1 1e1b          	ldw	x,(OFST+7,sp)
1452  03a3 58            	sllw	x
1453  03a4 58            	sllw	x
1454  03a5 1d0004        	subw	x,#4
1455  03a8 72fb1d        	addw	x,(OFST+9,sp)
1456  03ab 9093          	ldw	y,x
1457  03ad ee02          	ldw	x,(2,x)
1458  03af 89            	pushw	x
1459  03b0 93            	ldw	x,y
1460  03b1 fe            	ldw	x,(x)
1461  03b2 89            	pushw	x
1462  03b3 8d7e017e      	callf	f_detectZeroCross
1464  03b7 5b0c          	addw	sp,#12
1465  03b9 4d            	tnz	a
1466  03ba 276c          	jreq	L105
1467                     ; 212 			currentEdgeTime = micros();
1469  03bc 8d000000      	callf	f_micros
1471  03c0 96            	ldw	x,sp
1472  03c1 1c000f        	addw	x,#OFST-5
1473  03c4 8d000000      	callf	d_rtol
1476                     ; 213 			if (lastEdgeTime > 0) {  // Ensure a previous edge exists
1478  03c8 ae0008        	ldw	x,#_lastEdgeTime
1479  03cb 8d000000      	callf	d_lzmp
1481  03cf 274f          	jreq	L315
1482                     ; 214 				unsigned long period = currentEdgeTime - lastEdgeTime;   // Calculate period
1484  03d1 96            	ldw	x,sp
1485  03d2 1c000f        	addw	x,#OFST-5
1486  03d5 8d000000      	callf	d_ltor
1488  03d9 ae0008        	ldw	x,#_lastEdgeTime
1489  03dc 8d000000      	callf	d_lsub
1491  03e0 96            	ldw	x,sp
1492  03e1 1c0005        	addw	x,#OFST-15
1493  03e4 8d000000      	callf	d_rtol
1496                     ; 215 				float frequency = calculate_frequency(period);
1498  03e8 1e07          	ldw	x,(OFST-13,sp)
1499  03ea 89            	pushw	x
1500  03eb 1e07          	ldw	x,(OFST-13,sp)
1501  03ed 89            	pushw	x
1502  03ee 8d750475      	callf	f_calculate_frequency
1504  03f2 5b04          	addw	sp,#4
1505  03f4 96            	ldw	x,sp
1506  03f5 1c0005        	addw	x,#OFST-15
1507  03f8 8d000000      	callf	d_rtol
1510                     ; 216 				freqBuff += frequency;
1512  03fc 96            	ldw	x,sp
1513  03fd 1c0005        	addw	x,#OFST-15
1514  0400 8d000000      	callf	d_ltor
1516  0404 96            	ldw	x,sp
1517  0405 1c0009        	addw	x,#OFST-11
1518  0408 8d000000      	callf	d_fgadd
1521                     ; 217 				freqCount++;
1523  040c 1e0d          	ldw	x,(OFST-7,sp)
1524  040e 1c0001        	addw	x,#1
1525  0411 1f0d          	ldw	(OFST-7,sp),x
1527                     ; 218 				if (freqCount == 2)
1529  0413 1e0d          	ldw	x,(OFST-7,sp)
1530  0415 a30002        	cpw	x,#2
1531  0418 2606          	jrne	L315
1532                     ; 220 					count = i;    // for amplitude calculation limit bound
1534  041a 1e13          	ldw	x,(OFST-1,sp)
1535  041c bf12          	ldw	_count,x
1536                     ; 221 					break;        // break when zeroCrossing detection is two
1538  041e 201a          	jra	L774
1539  0420               L315:
1540                     ; 225 			lastEdgeTime = currentEdgeTime;  // Update last edge time
1542  0420 1e11          	ldw	x,(OFST-3,sp)
1543  0422 bf0a          	ldw	_lastEdgeTime+2,x
1544  0424 1e0f          	ldw	x,(OFST-5,sp)
1545  0426 bf08          	ldw	_lastEdgeTime,x
1546  0428               L105:
1547                     ; 205 	for (i = 0; i < NUM_SAMPLES; i++) {
1549  0428 1e13          	ldw	x,(OFST-1,sp)
1550  042a 1c0001        	addw	x,#1
1551  042d 1f13          	ldw	(OFST-1,sp),x
1555  042f 1e13          	ldw	x,(OFST-1,sp)
1556  0431 a30400        	cpw	x,#1024
1557  0434 2404          	jruge	L65
1558  0436 ac660366      	jpf	L374
1559  043a               L65:
1560  043a               L774:
1561                     ; 230 	return (freqCount > 0) ? (freqBuff / freqCount) : 0.0;
1563  043a 9c            	rvf
1564  043b 1e0d          	ldw	x,(OFST-7,sp)
1565  043d 2d20          	jrsle	L05
1566  043f 1e0d          	ldw	x,(OFST-7,sp)
1567  0441 8d000000      	callf	d_itof
1569  0445 96            	ldw	x,sp
1570  0446 1c0001        	addw	x,#OFST-19
1571  0449 8d000000      	callf	d_rtol
1574  044d 96            	ldw	x,sp
1575  044e 1c0009        	addw	x,#OFST-11
1576  0451 8d000000      	callf	d_ltor
1578  0455 96            	ldw	x,sp
1579  0456 1c0001        	addw	x,#OFST-19
1580  0459 8d000000      	callf	d_fdiv
1582  045d 2007          	jra	L25
1583  045f               L05:
1584  045f ae1050        	ldw	x,#L325
1585  0462 8d000000      	callf	d_ltor
1587  0466               L25:
1590  0466 5b16          	addw	sp,#22
1591  0468 87            	retf
1625                     ; 234 float convert_adc_to_voltage(unsigned int adcValue) {
1626                     	switch	.text
1627  0469               f_convert_adc_to_voltage:
1631                     ; 235 	return adcValue * (V_REF / ADC_MAX_VALUE);
1633  0469 8d000000      	callf	d_uitof
1635  046d ae101e        	ldw	x,#L155
1636  0470 8d000000      	callf	d_fmul
1640  0474 87            	retf
1674                     ; 239 float calculate_frequency(unsigned long period) {
1675                     	switch	.text
1676  0475               f_calculate_frequency:
1678  0475 5204          	subw	sp,#4
1679       00000004      OFST:	set	4
1682                     ; 240 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
1684  0477 96            	ldw	x,sp
1685  0478 1c0008        	addw	x,#OFST+4
1686  047b 8d000000      	callf	d_ltor
1688  047f 8d000000      	callf	d_ultof
1690  0483 ae1016        	ldw	x,#L706
1691  0486 8d000000      	callf	d_fdiv
1693  048a 96            	ldw	x,sp
1694  048b 1c0001        	addw	x,#OFST-3
1695  048e 8d000000      	callf	d_rtol
1698  0492 ae101a        	ldw	x,#L775
1699  0495 8d000000      	callf	d_ltor
1701  0499 96            	ldw	x,sp
1702  049a 1c0001        	addw	x,#OFST-3
1703  049d 8d000000      	callf	d_fdiv
1707  04a1 5b04          	addw	sp,#4
1708  04a3 87            	retf
1762                     ; 244 void output_results(float frequency, float amplitude) {
1763                     	switch	.text
1764  04a4               f_output_results:
1766  04a4 5228          	subw	sp,#40
1767       00000028      OFST:	set	40
1770                     ; 250 	sprintf(buffer, "%.3f, %.3f, %.3f\n\r", frequency, amplitude, amplitude);
1772  04a6 1e32          	ldw	x,(OFST+10,sp)
1773  04a8 89            	pushw	x
1774  04a9 1e32          	ldw	x,(OFST+10,sp)
1775  04ab 89            	pushw	x
1776  04ac 1e36          	ldw	x,(OFST+14,sp)
1777  04ae 89            	pushw	x
1778  04af 1e36          	ldw	x,(OFST+14,sp)
1779  04b1 89            	pushw	x
1780  04b2 1e36          	ldw	x,(OFST+14,sp)
1781  04b4 89            	pushw	x
1782  04b5 1e36          	ldw	x,(OFST+14,sp)
1783  04b7 89            	pushw	x
1784  04b8 ae1003        	ldw	x,#L146
1785  04bb 89            	pushw	x
1786  04bc 96            	ldw	x,sp
1787  04bd 1c000f        	addw	x,#OFST-25
1788  04c0 8d000000      	callf	f_sprintf
1790  04c4 5b0e          	addw	sp,#14
1791                     ; 253 	printf("%s", buffer);
1793  04c6 96            	ldw	x,sp
1794  04c7 1c0001        	addw	x,#OFST-39
1795  04ca 89            	pushw	x
1796  04cb ae1000        	ldw	x,#L346
1797  04ce 8d000000      	callf	f_printf
1799  04d2 85            	popw	x
1800                     ; 254 }
1803  04d3 5b28          	addw	sp,#40
1804  04d5 87            	retf
1839                     ; 257 PUTCHAR_PROTOTYPE {
1840                     	switch	.text
1841  04d6               f_putchar:
1843  04d6 88            	push	a
1844       00000000      OFST:	set	0
1847                     ; 258 	UART3_SendData8(c);
1849  04d7 8d000000      	callf	f_UART3_SendData8
1852  04db               L566:
1853                     ; 259 	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
1855  04db ae0080        	ldw	x,#128
1856  04de 8d000000      	callf	f_UART3_GetFlagStatus
1858  04e2 4d            	tnz	a
1859  04e3 27f6          	jreq	L566
1860                     ; 260 	return c;
1862  04e5 7b01          	ld	a,(OFST+1,sp)
1865  04e7 5b01          	addw	sp,#1
1866  04e9 87            	retf
1934                     	xdef	f_main
1935                     	xdef	f_output_results
1936                     	xdef	f_calculate_frequency
1937                     	xdef	f_convert_adc_to_voltage
1938                     	xdef	f_process_adc_samples
1939                     	xdef	f_initialize_adc_buffer
1940                     	xdef	f_calculate_amplitude
1941                     	xdef	f_detectZeroCross
1942                     	xdef	f_detectPosZeroCross
1943                     	xdef	f_read_ADC_Channel
1944                     	xdef	f_elapsedTime
1945                     	xdef	f_ADC2_setup
1946                     	xdef	f_UART3_setup
1947                     	xdef	f_clock_setup
1948                     	xdef	f_main_loop
1949                     	xdef	f_initialize_system
1950                     	xdef	_count
1951                     	xdef	_crossingType
1952                     	xdef	_currentEdgeTime
1953                     	xdef	_lastEdgeTime
1954                     	xdef	_sine1_amplitude
1955                     	xdef	_sine1_frequency
1956                     	xref	f_micros
1957                     	xref	f_delay_us
1958                     	xref	f_TIM4_Config
1959                     	xref	f_sprintf
1960                     	xdef	f_putchar
1961                     	xref	f_printf
1962                     	xref	f_UART3_GetFlagStatus
1963                     	xref	f_UART3_SendData8
1964                     	xref	f_UART3_Cmd
1965                     	xref	f_UART3_Init
1966                     	xref	f_UART3_DeInit
1967                     	xref	f_GPIO_Init
1968                     	xref	f_GPIO_DeInit
1969                     	xref	f_CLK_GetFlagStatus
1970                     	xref	f_CLK_SYSCLKConfig
1971                     	xref	f_CLK_HSIPrescalerConfig
1972                     	xref	f_CLK_ClockSwitchConfig
1973                     	xref	f_CLK_PeripheralClockConfig
1974                     	xref	f_CLK_ClockSwitchCmd
1975                     	xref	f_CLK_LSICmd
1976                     	xref	f_CLK_HSICmd
1977                     	xref	f_CLK_HSECmd
1978                     	xref	f_CLK_DeInit
1979                     	xref	f_ADC2_ClearFlag
1980                     	xref	f_ADC2_GetFlagStatus
1981                     	xref	f_ADC2_GetConversionValue
1982                     	xref	f_ADC2_StartConversion
1983                     	xref	f_ADC2_ConversionConfig
1984                     	xref	f_ADC2_Cmd
1985                     	xref	f_ADC2_Init
1986                     	xref	f_ADC2_DeInit
1987                     	switch	.const
1988  1000               L346:
1989  1000 257300        	dc.b	"%s",0
1990  1003               L146:
1991  1003 252e33662c20  	dc.b	"%.3f, %.3f, %.3f",10
1992  1014 0d00          	dc.b	13,0
1993  1016               L706:
1994  1016 49742400      	dc.w	18804,9216
1995  101a               L775:
1996  101a 3f800000      	dc.w	16256,0
1997  101e               L155:
1998  101e 3b954409      	dc.w	15253,17417
1999  1022               L705:
2000  1022 401851eb      	dc.w	16408,20971
2001  1026               L543:
2002  1026 c0951eb8      	dc.w	-16235,7864
2003  102a               L553:
2004  102a 40951eb8      	dc.w	16533,7864
2005  102e               L13:
2006  102e 53797374656d  	dc.b	"System Initializat"
2007  1040 696f6e20436f  	dc.b	"ion Completed",10
2008  104e 0d00          	dc.b	13,0
2009  1050               L325:
2010  1050 00000000      	dc.w	0,0
2011                     	xref.b	c_lreg
2012                     	xref.b	c_x
2013                     	xref.b	c_y
2033                     	xref	d_ultof
2034                     	xref	d_fmul
2035                     	xref	d_uitof
2036                     	xref	d_fdiv
2037                     	xref	d_fgadd
2038                     	xref	d_lzmp
2039                     	xref	d_itof
2040                     	xref	d_fsub
2041                     	xref	d_lgadc
2042                     	xref	d_fneg
2043                     	xref	d_fcmp
2044                     	xref	d_ladd
2045                     	xref	d_lneg
2046                     	xref	d_lsub
2047                     	xref	d_lcmp
2048                     	xref	d_ltor
2049                     	xref	d_uitolx
2050                     	xref	d_rtol
2051                     	xref	d_xymovl
2052                     	end
