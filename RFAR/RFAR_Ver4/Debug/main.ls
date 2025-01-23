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
  70                     ; 57 void main() {
  71                     	switch	.text
  72  0000               f_main:
  74  0000 5214          	subw	sp,#20
  75       00000014      OFST:	set	20
  78                     ; 62 	initialize_system();
  80  0002 8d290029      	callf	f_initialize_system
  82  0006               L72:
  83                     ; 89 			printf("\n\rEnter a string:\n\r");
  85  0006 ae1065        	ldw	x,#L33
  86  0009 8d000000      	callf	f_printf
  88                     ; 91         UART3_ReceiveString(ans, 20);
  90  000d ae0014        	ldw	x,#20
  91  0010 89            	pushw	x
  92  0011 96            	ldw	x,sp
  93  0012 1c0003        	addw	x,#OFST-17
  94  0015 8def05ef      	callf	f_UART3_ReceiveString
  96  0019 85            	popw	x
  97                     ; 92 				printf("\n\rReceived string: %s\n\r", ans);
  99  001a 96            	ldw	x,sp
 100  001b 1c0001        	addw	x,#OFST-19
 101  001e 89            	pushw	x
 102  001f ae104d        	ldw	x,#L53
 103  0022 8d000000      	callf	f_printf
 105  0026 85            	popw	x
 107  0027 20dd          	jra	L72
 138                     ; 103 void initialize_system(void) {
 139                     	switch	.text
 140  0029               f_initialize_system:
 144                     ; 104 	clock_setup();          // Configure system clock
 146  0029 8d5c005c      	callf	f_clock_setup
 148                     ; 105 	TIM4_Config();          // Timer 4 config for delay
 150  002d 8d000000      	callf	f_TIM4_Config
 152                     ; 106 	UART3_setup();          // Setup UART communication
 154  0031 8d9f009f      	callf	f_UART3_setup
 156                     ; 107 	ADC2_setup();           // Setup ADC
 158  0035 8dc000c0      	callf	f_ADC2_setup
 160                     ; 108 	EEPROM_Config();        // Configuring EEPROM
 162  0039 8d000000      	callf	f_EEPROM_Config
 164                     ; 109 	I2CInit();
 166  003d 8d000000      	callf	f_I2CInit
 168                     ; 110 	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
 170  0041 ae500a        	ldw	x,#20490
 171  0044 8d000000      	callf	f_GPIO_DeInit
 173                     ; 111 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 175  0048 4be0          	push	#224
 176  004a 4b08          	push	#8
 177  004c ae500a        	ldw	x,#20490
 178  004f 8d000000      	callf	f_GPIO_Init
 180  0053 85            	popw	x
 181                     ; 112 	printf("System Initialization Completed\n\r");
 183  0054 ae102b        	ldw	x,#L74
 184  0057 8d000000      	callf	f_printf
 186                     ; 113 }
 189  005b 87            	retf
 221                     ; 116 void clock_setup(void) {
 222                     	switch	.text
 223  005c               f_clock_setup:
 227                     ; 117 	CLK_DeInit();
 229  005c 8d000000      	callf	f_CLK_DeInit
 231                     ; 118 	CLK_HSECmd(DISABLE);
 233  0060 4f            	clr	a
 234  0061 8d000000      	callf	f_CLK_HSECmd
 236                     ; 119 	CLK_LSICmd(DISABLE);
 238  0065 4f            	clr	a
 239  0066 8d000000      	callf	f_CLK_LSICmd
 241                     ; 120 	CLK_HSICmd(ENABLE);
 243  006a a601          	ld	a,#1
 244  006c 8d000000      	callf	f_CLK_HSICmd
 247  0070               L36:
 248                     ; 121 	while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 250  0070 ae0102        	ldw	x,#258
 251  0073 8d000000      	callf	f_CLK_GetFlagStatus
 253  0077 4d            	tnz	a
 254  0078 27f6          	jreq	L36
 255                     ; 124 	CLK_ClockSwitchCmd(ENABLE);
 257  007a a601          	ld	a,#1
 258  007c 8d000000      	callf	f_CLK_ClockSwitchCmd
 260                     ; 125 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 262  0080 4f            	clr	a
 263  0081 8d000000      	callf	f_CLK_HSIPrescalerConfig
 265                     ; 126 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 267  0085 a680          	ld	a,#128
 268  0087 8d000000      	callf	f_CLK_SYSCLKConfig
 270                     ; 127 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 272  008b 4b01          	push	#1
 273  008d 4b00          	push	#0
 274  008f ae01e1        	ldw	x,#481
 275  0092 8d000000      	callf	f_CLK_ClockSwitchConfig
 277  0096 85            	popw	x
 278                     ; 131 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 280  0097 ae0301        	ldw	x,#769
 281  009a 8d000000      	callf	f_CLK_PeripheralClockConfig
 283                     ; 132 }
 286  009e 87            	retf
 311                     ; 135 void UART3_setup(void) {
 312                     	switch	.text
 313  009f               f_UART3_setup:
 317                     ; 136 	UART3_DeInit();
 319  009f 8d000000      	callf	f_UART3_DeInit
 321                     ; 137 	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TXRX_ENABLE);
 323  00a3 4b0c          	push	#12
 324  00a5 4b00          	push	#0
 325  00a7 4b00          	push	#0
 326  00a9 4b00          	push	#0
 327  00ab ae2580        	ldw	x,#9600
 328  00ae 89            	pushw	x
 329  00af ae0000        	ldw	x,#0
 330  00b2 89            	pushw	x
 331  00b3 8d000000      	callf	f_UART3_Init
 333  00b7 5b08          	addw	sp,#8
 334                     ; 138 	UART3_Cmd(ENABLE);
 336  00b9 a601          	ld	a,#1
 337  00bb 8d000000      	callf	f_UART3_Cmd
 339                     ; 139 }
 342  00bf 87            	retf
 368                     ; 142 void ADC2_setup(void) {
 369                     	switch	.text
 370  00c0               f_ADC2_setup:
 374                     ; 143 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 376  00c0 ae1301        	ldw	x,#4865
 377  00c3 8d000000      	callf	f_CLK_PeripheralClockConfig
 379                     ; 144 	ADC2_DeInit();
 381  00c7 8d000000      	callf	f_ADC2_DeInit
 383                     ; 146 	ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
 383                     ; 147 						ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6, DISABLE);
 385  00cb 4b00          	push	#0
 386  00cd 4b07          	push	#7
 387  00cf 4b08          	push	#8
 388  00d1 4b00          	push	#0
 389  00d3 4b01          	push	#1
 390  00d5 4b00          	push	#0
 391  00d7 ae0105        	ldw	x,#261
 392  00da 8d000000      	callf	f_ADC2_Init
 394  00de 5b06          	addw	sp,#6
 395                     ; 149 	ADC2_Cmd(ENABLE);
 397  00e0 a601          	ld	a,#1
 398  00e2 8d000000      	callf	f_ADC2_Cmd
 400                     ; 150 }
 403  00e6 87            	retf
 405                     .const:	section	.text
 406  0000               L701_adc_buffer_1:
 407  0000 bf800000      	dc.w	-16512,0
 408  0004 000000000000  	ds.b	4092
 464                     ; 153 void main_loop(void) {
 465                     	switch	.text
 466  00e7               f_main_loop:
 468  00e7 96            	ldw	x,sp
 469  00e8 1d1018        	subw	x,#4120
 470  00eb 94            	ldw	sp,x
 471       00001018      OFST:	set	4120
 474  00ec               L731:
 475                     ; 156 	float adc_buffer_1[NUM_SAMPLES] = { -1 };
 477  00ec 96            	ldw	x,sp
 478  00ed 1c0019        	addw	x,#OFST-4095
 479  00f0 90ae0000      	ldw	y,#L701_adc_buffer_1
 480  00f4 bf00          	ldw	c_x,x
 481  00f6 ae1000        	ldw	x,#4096
 482  00f9 8d000000      	callf	d_xymovl
 484                     ; 157 	float sine1_frequency = 0;
 486                     ; 158 	float sine1_amplitude = 0;
 488                     ; 161 	initialize_adc_buffer(adc_buffer_1);
 490  00fd 96            	ldw	x,sp
 491  00fe 1c0019        	addw	x,#OFST-4095
 492  0101 8d460346      	callf	f_initialize_adc_buffer
 494                     ; 164 	sine1_frequency = process_adc_samples(adc_buffer_1);
 496  0105 96            	ldw	x,sp
 497  0106 1c0019        	addw	x,#OFST-4095
 498  0109 8d710371      	callf	f_process_adc_samples
 500  010d 96            	ldw	x,sp
 501  010e 1c0011        	addw	x,#OFST-4103
 502  0111 8d000000      	callf	d_rtol
 505                     ; 166 	sine1_amplitude = calculate_amplitude(adc_buffer_1, count);
 507  0115 be12          	ldw	x,_count
 508  0117 8d000000      	callf	d_uitolx
 510  011b be02          	ldw	x,c_lreg+2
 511  011d 89            	pushw	x
 512  011e be00          	ldw	x,c_lreg
 513  0120 89            	pushw	x
 514  0121 96            	ldw	x,sp
 515  0122 1c001d        	addw	x,#OFST-4091
 516  0125 8da602a6      	callf	f_calculate_amplitude
 518  0129 5b04          	addw	sp,#4
 519  012b 96            	ldw	x,sp
 520  012c 1c0015        	addw	x,#OFST-4099
 521  012f 8d000000      	callf	d_rtol
 524                     ; 169 	output_results(sine1_frequency, sine1_amplitude);
 526  0133 1e17          	ldw	x,(OFST-4097,sp)
 527  0135 89            	pushw	x
 528  0136 1e17          	ldw	x,(OFST-4097,sp)
 529  0138 89            	pushw	x
 530  0139 1e17          	ldw	x,(OFST-4097,sp)
 531  013b 89            	pushw	x
 532  013c 1e17          	ldw	x,(OFST-4097,sp)
 533  013e 89            	pushw	x
 534  013f 8d820582      	callf	f_output_results
 536  0143 5b08          	addw	sp,#8
 538  0145 20a5          	jra	L731
 580                     ; 178 uint32_t elapsedTime(uint32_t start, uint32_t end) {
 581                     	switch	.text
 582  0147               f_elapsedTime:
 584       00000000      OFST:	set	0
 587                     ; 179 	return (end >= start) ? (end - start) : ((0xffffffff - start + 1) + end);
 589  0147 96            	ldw	x,sp
 590  0148 1c0008        	addw	x,#OFST+8
 591  014b 8d000000      	callf	d_ltor
 593  014f 96            	ldw	x,sp
 594  0150 1c0004        	addw	x,#OFST+4
 595  0153 8d000000      	callf	d_lcmp
 597  0157 2512          	jrult	L22
 598  0159 96            	ldw	x,sp
 599  015a 1c0008        	addw	x,#OFST+8
 600  015d 8d000000      	callf	d_ltor
 602  0161 96            	ldw	x,sp
 603  0162 1c0004        	addw	x,#OFST+4
 604  0165 8d000000      	callf	d_lsub
 606  0169 2014          	jra	L42
 607  016b               L22:
 608  016b 96            	ldw	x,sp
 609  016c 1c0004        	addw	x,#OFST+4
 610  016f 8d000000      	callf	d_ltor
 612  0173 8d000000      	callf	d_lneg
 614  0177 96            	ldw	x,sp
 615  0178 1c0008        	addw	x,#OFST+8
 616  017b 8d000000      	callf	d_ladd
 618  017f               L42:
 621  017f 87            	retf
 668                     ; 183 unsigned int read_ADC_Channel(uint8_t channel) {
 669                     	switch	.text
 670  0180               f_read_ADC_Channel:
 672  0180 89            	pushw	x
 673       00000002      OFST:	set	2
 676                     ; 184 	unsigned int adcValue = 0;
 678                     ; 185 	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, channel, ADC2_ALIGN_RIGHT);
 680  0181 4b08          	push	#8
 681  0183 ae0100        	ldw	x,#256
 682  0186 97            	ld	xl,a
 683  0187 8d000000      	callf	f_ADC2_ConversionConfig
 685  018b 84            	pop	a
 686                     ; 186 	ADC2_StartConversion();
 688  018c 8d000000      	callf	f_ADC2_StartConversion
 691  0190               L112:
 692                     ; 188 	while (ADC2_GetFlagStatus() == RESET);
 694  0190 8d000000      	callf	f_ADC2_GetFlagStatus
 696  0194 4d            	tnz	a
 697  0195 27f9          	jreq	L112
 698                     ; 190 	adcValue = ADC2_GetConversionValue();
 700  0197 8d000000      	callf	f_ADC2_GetConversionValue
 702  019b 1f01          	ldw	(OFST-1,sp),x
 704                     ; 191 	ADC2_ClearFlag();
 706  019d 8d000000      	callf	f_ADC2_ClearFlag
 708                     ; 192 	return adcValue;
 710  01a1 1e01          	ldw	x,(OFST-1,sp)
 713  01a3 5b02          	addw	sp,#2
 714  01a5 87            	retf
 787                     ; 196 bool detectZeroCross(float previousSample, float currentSample, float threshold) {
 788                     	switch	.text
 789  01a6               f_detectZeroCross:
 791       00000000      OFST:	set	0
 794                     ; 197 	if (crossingType == -1) {  // If no crossing type detected, check for both positive and negative
 796  01a6 be10          	ldw	x,_crossingType
 797  01a8 a3ffff        	cpw	x,#65535
 798  01ab 2666          	jrne	L352
 799                     ; 198 		if (previousSample <= threshold && currentSample > threshold) {
 801  01ad 9c            	rvf
 802  01ae 96            	ldw	x,sp
 803  01af 1c0004        	addw	x,#OFST+4
 804  01b2 8d000000      	callf	d_ltor
 806  01b6 96            	ldw	x,sp
 807  01b7 1c000c        	addw	x,#OFST+12
 808  01ba 8d000000      	callf	d_fcmp
 810  01be 2c19          	jrsgt	L552
 812  01c0 9c            	rvf
 813  01c1 96            	ldw	x,sp
 814  01c2 1c0008        	addw	x,#OFST+8
 815  01c5 8d000000      	callf	d_ltor
 817  01c9 96            	ldw	x,sp
 818  01ca 1c000c        	addw	x,#OFST+12
 819  01cd 8d000000      	callf	d_fcmp
 821  01d1 2d06          	jrsle	L552
 822                     ; 199 			crossingType = 0;  // Positive zero crossing
 824  01d3 5f            	clrw	x
 825  01d4 bf10          	ldw	_crossingType,x
 826                     ; 200 			return true;
 828  01d6 a601          	ld	a,#1
 831  01d8 87            	retf
 832  01d9               L552:
 833                     ; 201 		} else if (previousSample >= -threshold && currentSample < -threshold) {
 835  01d9 9c            	rvf
 836  01da 96            	ldw	x,sp
 837  01db 1c000c        	addw	x,#OFST+12
 838  01de 8d000000      	callf	d_ltor
 840  01e2 8d000000      	callf	d_fneg
 842  01e6 96            	ldw	x,sp
 843  01e7 1c0004        	addw	x,#OFST+4
 844  01ea 8d000000      	callf	d_fcmp
 846  01ee 2d04          	jrsle	L23
 847  01f0 ac780278      	jpf	L362
 848  01f4               L23:
 850  01f4 9c            	rvf
 851  01f5 96            	ldw	x,sp
 852  01f6 1c000c        	addw	x,#OFST+12
 853  01f9 8d000000      	callf	d_ltor
 855  01fd 8d000000      	callf	d_fneg
 857  0201 96            	ldw	x,sp
 858  0202 1c0008        	addw	x,#OFST+8
 859  0205 8d000000      	callf	d_fcmp
 861  0209 2d6d          	jrsle	L362
 862                     ; 202 			crossingType = 1;  // Negative zero crossing
 864  020b ae0001        	ldw	x,#1
 865  020e bf10          	ldw	_crossingType,x
 866                     ; 203 			return true;
 868  0210 a601          	ld	a,#1
 871  0212 87            	retf
 872  0213               L352:
 873                     ; 205 	} else if (crossingType == 0 && previousSample <= threshold && currentSample > threshold) {
 875  0213 be10          	ldw	x,_crossingType
 876  0215 2629          	jrne	L562
 878  0217 9c            	rvf
 879  0218 96            	ldw	x,sp
 880  0219 1c0004        	addw	x,#OFST+4
 881  021c 8d000000      	callf	d_ltor
 883  0220 96            	ldw	x,sp
 884  0221 1c000c        	addw	x,#OFST+12
 885  0224 8d000000      	callf	d_fcmp
 887  0228 2c16          	jrsgt	L562
 889  022a 9c            	rvf
 890  022b 96            	ldw	x,sp
 891  022c 1c0008        	addw	x,#OFST+8
 892  022f 8d000000      	callf	d_ltor
 894  0233 96            	ldw	x,sp
 895  0234 1c000c        	addw	x,#OFST+12
 896  0237 8d000000      	callf	d_fcmp
 898  023b 2d03          	jrsle	L562
 899                     ; 206 			return true;  // Positive zero crossing
 901  023d a601          	ld	a,#1
 904  023f 87            	retf
 905  0240               L562:
 906                     ; 207 	} else if (crossingType == 1 && previousSample >= -threshold && currentSample < -threshold) {
 908  0240 be10          	ldw	x,_crossingType
 909  0242 a30001        	cpw	x,#1
 910  0245 2631          	jrne	L362
 912  0247 9c            	rvf
 913  0248 96            	ldw	x,sp
 914  0249 1c000c        	addw	x,#OFST+12
 915  024c 8d000000      	callf	d_ltor
 917  0250 8d000000      	callf	d_fneg
 919  0254 96            	ldw	x,sp
 920  0255 1c0004        	addw	x,#OFST+4
 921  0258 8d000000      	callf	d_fcmp
 923  025c 2c1a          	jrsgt	L362
 925  025e 9c            	rvf
 926  025f 96            	ldw	x,sp
 927  0260 1c000c        	addw	x,#OFST+12
 928  0263 8d000000      	callf	d_ltor
 930  0267 8d000000      	callf	d_fneg
 932  026b 96            	ldw	x,sp
 933  026c 1c0008        	addw	x,#OFST+8
 934  026f 8d000000      	callf	d_fcmp
 936  0273 2d03          	jrsle	L362
 937                     ; 208 			return true;  // Negative zero crossing
 939  0275 a601          	ld	a,#1
 942  0277 87            	retf
 943  0278               L362:
 944                     ; 211 	return false;  // No zero crossing detected
 946  0278 4f            	clr	a
 949  0279 87            	retf
1001                     ; 215 bool detectPosZeroCross(float previousSample, float currentSample, float threshold) {
1002                     	switch	.text
1003  027a               f_detectPosZeroCross:
1005       00000000      OFST:	set	0
1008                     ; 216 	return (previousSample <= threshold && currentSample > threshold);
1010  027a 9c            	rvf
1011  027b 96            	ldw	x,sp
1012  027c 1c0004        	addw	x,#OFST+4
1013  027f 8d000000      	callf	d_ltor
1015  0283 96            	ldw	x,sp
1016  0284 1c000c        	addw	x,#OFST+12
1017  0287 8d000000      	callf	d_fcmp
1019  028b 2c17          	jrsgt	L63
1020  028d 9c            	rvf
1021  028e 96            	ldw	x,sp
1022  028f 1c0008        	addw	x,#OFST+8
1023  0292 8d000000      	callf	d_ltor
1025  0296 96            	ldw	x,sp
1026  0297 1c000c        	addw	x,#OFST+12
1027  029a 8d000000      	callf	d_fcmp
1029  029e 2d04          	jrsle	L63
1030  02a0 a601          	ld	a,#1
1031  02a2 2001          	jra	L04
1032  02a4               L63:
1033  02a4 4f            	clr	a
1034  02a5               L04:
1037  02a5 87            	retf
1108                     ; 220 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
1109                     	switch	.text
1110  02a6               f_calculate_amplitude:
1112  02a6 89            	pushw	x
1113  02a7 520c          	subw	sp,#12
1114       0000000c      OFST:	set	12
1117                     ; 221 	uint32_t i = 0;
1119                     ; 222 	float max_val = -V_REF, min_val = V_REF;
1121  02a9 ce1025        	ldw	x,L363+2
1122  02ac 1f03          	ldw	(OFST-9,sp),x
1123  02ae ce1023        	ldw	x,L363
1124  02b1 1f01          	ldw	(OFST-11,sp),x
1128  02b3 ce1029        	ldw	x,L373+2
1129  02b6 1f07          	ldw	(OFST-5,sp),x
1130  02b8 ce1027        	ldw	x,L373
1131  02bb 1f05          	ldw	(OFST-7,sp),x
1133                     ; 224 	for (i = 0; i < sample_size; i++) {
1135  02bd ae0000        	ldw	x,#0
1136  02c0 1f0b          	ldw	(OFST-1,sp),x
1137  02c2 ae0000        	ldw	x,#0
1138  02c5 1f09          	ldw	(OFST-3,sp),x
1141  02c7 2058          	jra	L304
1142  02c9               L773:
1143                     ; 225 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1145  02c9 9c            	rvf
1146  02ca 1e0b          	ldw	x,(OFST-1,sp)
1147  02cc 58            	sllw	x
1148  02cd 58            	sllw	x
1149  02ce 72fb0d        	addw	x,(OFST+1,sp)
1150  02d1 8d000000      	callf	d_ltor
1152  02d5 96            	ldw	x,sp
1153  02d6 1c0001        	addw	x,#OFST-11
1154  02d9 8d000000      	callf	d_fcmp
1156  02dd 2d11          	jrsle	L704
1159  02df 1e0b          	ldw	x,(OFST-1,sp)
1160  02e1 58            	sllw	x
1161  02e2 58            	sllw	x
1162  02e3 72fb0d        	addw	x,(OFST+1,sp)
1163  02e6 9093          	ldw	y,x
1164  02e8 ee02          	ldw	x,(2,x)
1165  02ea 1f03          	ldw	(OFST-9,sp),x
1166  02ec 93            	ldw	x,y
1167  02ed fe            	ldw	x,(x)
1168  02ee 1f01          	ldw	(OFST-11,sp),x
1170  02f0               L704:
1171                     ; 226 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1173  02f0 9c            	rvf
1174  02f1 1e0b          	ldw	x,(OFST-1,sp)
1175  02f3 58            	sllw	x
1176  02f4 58            	sllw	x
1177  02f5 72fb0d        	addw	x,(OFST+1,sp)
1178  02f8 8d000000      	callf	d_ltor
1180  02fc 96            	ldw	x,sp
1181  02fd 1c0005        	addw	x,#OFST-7
1182  0300 8d000000      	callf	d_fcmp
1184  0304 2e11          	jrsge	L114
1187  0306 1e0b          	ldw	x,(OFST-1,sp)
1188  0308 58            	sllw	x
1189  0309 58            	sllw	x
1190  030a 72fb0d        	addw	x,(OFST+1,sp)
1191  030d 9093          	ldw	y,x
1192  030f ee02          	ldw	x,(2,x)
1193  0311 1f07          	ldw	(OFST-5,sp),x
1194  0313 93            	ldw	x,y
1195  0314 fe            	ldw	x,(x)
1196  0315 1f05          	ldw	(OFST-7,sp),x
1198  0317               L114:
1199                     ; 224 	for (i = 0; i < sample_size; i++) {
1201  0317 96            	ldw	x,sp
1202  0318 1c0009        	addw	x,#OFST-3
1203  031b a601          	ld	a,#1
1204  031d 8d000000      	callf	d_lgadc
1207  0321               L304:
1210  0321 96            	ldw	x,sp
1211  0322 1c0009        	addw	x,#OFST-3
1212  0325 8d000000      	callf	d_ltor
1214  0329 96            	ldw	x,sp
1215  032a 1c0012        	addw	x,#OFST+6
1216  032d 8d000000      	callf	d_lcmp
1218  0331 2596          	jrult	L773
1219                     ; 229 	return (max_val - min_val);
1221  0333 96            	ldw	x,sp
1222  0334 1c0001        	addw	x,#OFST-11
1223  0337 8d000000      	callf	d_ltor
1225  033b 96            	ldw	x,sp
1226  033c 1c0005        	addw	x,#OFST-7
1227  033f 8d000000      	callf	d_fsub
1231  0343 5b0e          	addw	sp,#14
1232  0345 87            	retf
1276                     ; 233 void initialize_adc_buffer(float buffer[]) {
1277                     	switch	.text
1278  0346               f_initialize_adc_buffer:
1280  0346 89            	pushw	x
1281  0347 89            	pushw	x
1282       00000002      OFST:	set	2
1285                     ; 234 	uint16_t i = 0;
1287                     ; 235 	for (i = 0; i < NUM_SAMPLES; i++) {
1289  0348 5f            	clrw	x
1290  0349 1f01          	ldw	(OFST-1,sp),x
1292  034b               L534:
1293                     ; 236 		buffer[i] = -1;  // Reset each element of the ADC buffer
1295  034b 1e01          	ldw	x,(OFST-1,sp)
1296  034d 58            	sllw	x
1297  034e 58            	sllw	x
1298  034f 72fb03        	addw	x,(OFST+1,sp)
1299  0352 90aeffff      	ldw	y,#65535
1300  0356 51            	exgw	x,y
1301  0357 8d000000      	callf	d_itof
1303  035b 51            	exgw	x,y
1304  035c 8d000000      	callf	d_rtol
1306                     ; 235 	for (i = 0; i < NUM_SAMPLES; i++) {
1308  0360 1e01          	ldw	x,(OFST-1,sp)
1309  0362 1c0001        	addw	x,#1
1310  0365 1f01          	ldw	(OFST-1,sp),x
1314  0367 1e01          	ldw	x,(OFST-1,sp)
1315  0369 a30400        	cpw	x,#1024
1316  036c 25dd          	jrult	L534
1317                     ; 238 }
1320  036e 5b04          	addw	sp,#4
1321  0370 87            	retf
1418                     ; 241 float process_adc_samples(float buffer[]) {
1419                     	switch	.text
1420  0371               f_process_adc_samples:
1422  0371 89            	pushw	x
1423  0372 5214          	subw	sp,#20
1424       00000014      OFST:	set	20
1427                     ; 242 	unsigned long currentEdgeTime = 0;
1429                     ; 243 	float freqBuff = 0;
1431  0374 ae0000        	ldw	x,#0
1432  0377 1f0b          	ldw	(OFST-9,sp),x
1433  0379 ae0000        	ldw	x,#0
1434  037c 1f09          	ldw	(OFST-11,sp),x
1436                     ; 244 	int freqCount = 0;
1438  037e 5f            	clrw	x
1439  037f 1f0d          	ldw	(OFST-7,sp),x
1441                     ; 245 	uint16_t i = 0;
1443                     ; 246 	lastEdgeTime = 0;           // Reset last zero-crossing time
1445  0381 ae0000        	ldw	x,#0
1446  0384 bf0a          	ldw	_lastEdgeTime+2,x
1447  0386 ae0000        	ldw	x,#0
1448  0389 bf08          	ldw	_lastEdgeTime,x
1449                     ; 247 	for (i = 0; i < NUM_SAMPLES; i++) {
1451  038b 5f            	clrw	x
1452  038c 1f13          	ldw	(OFST-1,sp),x
1454  038e               L115:
1455                     ; 249 		buffer[i] = convert_adc_to_voltage(read_ADC_Channel(ADC2_CHANNEL_5));
1457  038e a605          	ld	a,#5
1458  0390 8d800180      	callf	f_read_ADC_Channel
1460  0394 8d470547      	callf	f_convert_adc_to_voltage
1462  0398 1e13          	ldw	x,(OFST-1,sp)
1463  039a 58            	sllw	x
1464  039b 58            	sllw	x
1465  039c 72fb15        	addw	x,(OFST+1,sp)
1466  039f 8d000000      	callf	d_rtol
1468                     ; 251 		delay_us(1000000 / SAMPLE_RATE);
1470  03a3 ae1a0a        	ldw	x,#6666
1471  03a6 8d000000      	callf	f_delay_us
1473                     ; 253 		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
1475  03aa 1e13          	ldw	x,(OFST-1,sp)
1476  03ac 2604          	jrne	L45
1477  03ae ac500450      	jpf	L715
1478  03b2               L45:
1480  03b2 ce1021        	ldw	x,L525+2
1481  03b5 89            	pushw	x
1482  03b6 ce101f        	ldw	x,L525
1483  03b9 89            	pushw	x
1484  03ba 1e17          	ldw	x,(OFST+3,sp)
1485  03bc 58            	sllw	x
1486  03bd 58            	sllw	x
1487  03be 72fb19        	addw	x,(OFST+5,sp)
1488  03c1 9093          	ldw	y,x
1489  03c3 ee02          	ldw	x,(2,x)
1490  03c5 89            	pushw	x
1491  03c6 93            	ldw	x,y
1492  03c7 fe            	ldw	x,(x)
1493  03c8 89            	pushw	x
1494  03c9 1e1b          	ldw	x,(OFST+7,sp)
1495  03cb 58            	sllw	x
1496  03cc 58            	sllw	x
1497  03cd 1d0004        	subw	x,#4
1498  03d0 72fb1d        	addw	x,(OFST+9,sp)
1499  03d3 9093          	ldw	y,x
1500  03d5 ee02          	ldw	x,(2,x)
1501  03d7 89            	pushw	x
1502  03d8 93            	ldw	x,y
1503  03d9 fe            	ldw	x,(x)
1504  03da 89            	pushw	x
1505  03db 8da601a6      	callf	f_detectZeroCross
1507  03df 5b0c          	addw	sp,#12
1508  03e1 4d            	tnz	a
1509  03e2 276c          	jreq	L715
1510                     ; 254 			currentEdgeTime = micros();
1512  03e4 8d000000      	callf	f_micros
1514  03e8 96            	ldw	x,sp
1515  03e9 1c000f        	addw	x,#OFST-5
1516  03ec 8d000000      	callf	d_rtol
1519                     ; 255 			if (lastEdgeTime > 0) {  // Ensure a previous edge exists
1521  03f0 ae0008        	ldw	x,#_lastEdgeTime
1522  03f3 8d000000      	callf	d_lzmp
1524  03f7 274f          	jreq	L135
1525                     ; 256 				unsigned long period = currentEdgeTime - lastEdgeTime;   // Calculate period
1527  03f9 96            	ldw	x,sp
1528  03fa 1c000f        	addw	x,#OFST-5
1529  03fd 8d000000      	callf	d_ltor
1531  0401 ae0008        	ldw	x,#_lastEdgeTime
1532  0404 8d000000      	callf	d_lsub
1534  0408 96            	ldw	x,sp
1535  0409 1c0005        	addw	x,#OFST-15
1536  040c 8d000000      	callf	d_rtol
1539                     ; 257 				float frequency = calculate_frequency(period);
1541  0410 1e07          	ldw	x,(OFST-13,sp)
1542  0412 89            	pushw	x
1543  0413 1e07          	ldw	x,(OFST-13,sp)
1544  0415 89            	pushw	x
1545  0416 8d530553      	callf	f_calculate_frequency
1547  041a 5b04          	addw	sp,#4
1548  041c 96            	ldw	x,sp
1549  041d 1c0005        	addw	x,#OFST-15
1550  0420 8d000000      	callf	d_rtol
1553                     ; 258 				freqBuff += frequency;
1555  0424 96            	ldw	x,sp
1556  0425 1c0005        	addw	x,#OFST-15
1557  0428 8d000000      	callf	d_ltor
1559  042c 96            	ldw	x,sp
1560  042d 1c0009        	addw	x,#OFST-11
1561  0430 8d000000      	callf	d_fgadd
1564                     ; 259 				freqCount++;
1566  0434 1e0d          	ldw	x,(OFST-7,sp)
1567  0436 1c0001        	addw	x,#1
1568  0439 1f0d          	ldw	(OFST-7,sp),x
1570                     ; 260 				if (freqCount == 2)
1572  043b 1e0d          	ldw	x,(OFST-7,sp)
1573  043d a30002        	cpw	x,#2
1574  0440 2606          	jrne	L135
1575                     ; 262 					count = i;    // for amplitude calculation limit bound
1577  0442 1e13          	ldw	x,(OFST-1,sp)
1578  0444 bf12          	ldw	_count,x
1579                     ; 263 					break;        // break when zeroCrossing detection is two
1581  0446 201a          	jra	L515
1582  0448               L135:
1583                     ; 267 			lastEdgeTime = currentEdgeTime;  // Update last edge time
1585  0448 1e11          	ldw	x,(OFST-3,sp)
1586  044a bf0a          	ldw	_lastEdgeTime+2,x
1587  044c 1e0f          	ldw	x,(OFST-5,sp)
1588  044e bf08          	ldw	_lastEdgeTime,x
1589  0450               L715:
1590                     ; 247 	for (i = 0; i < NUM_SAMPLES; i++) {
1592  0450 1e13          	ldw	x,(OFST-1,sp)
1593  0452 1c0001        	addw	x,#1
1594  0455 1f13          	ldw	(OFST-1,sp),x
1598  0457 1e13          	ldw	x,(OFST-1,sp)
1599  0459 a30400        	cpw	x,#1024
1600  045c 2404          	jruge	L65
1601  045e ac8e038e      	jpf	L115
1602  0462               L65:
1603  0462               L515:
1604                     ; 272 	return (freqCount > 0) ? (freqBuff / freqCount) : 0.0;
1606  0462 9c            	rvf
1607  0463 1e0d          	ldw	x,(OFST-7,sp)
1608  0465 2d20          	jrsle	L05
1609  0467 1e0d          	ldw	x,(OFST-7,sp)
1610  0469 8d000000      	callf	d_itof
1612  046d 96            	ldw	x,sp
1613  046e 1c0001        	addw	x,#OFST-19
1614  0471 8d000000      	callf	d_rtol
1617  0475 96            	ldw	x,sp
1618  0476 1c0009        	addw	x,#OFST-11
1619  0479 8d000000      	callf	d_ltor
1621  047d 96            	ldw	x,sp
1622  047e 1c0001        	addw	x,#OFST-19
1623  0481 8d000000      	callf	d_fdiv
1625  0485 2007          	jra	L25
1626  0487               L05:
1627  0487 ae1079        	ldw	x,#L145
1628  048a 8d000000      	callf	d_ltor
1630  048e               L25:
1633  048e 5b16          	addw	sp,#22
1634  0490 87            	retf
1713                     ; 276 float process_FDR_samples(float buffer[]) {
1714                     	switch	.text
1715  0491               f_process_FDR_samples:
1717  0491 89            	pushw	x
1718  0492 520c          	subw	sp,#12
1719       0000000c      OFST:	set	12
1722                     ; 277 	int ZCount = 0;
1724  0494 5f            	clrw	x
1725  0495 1f09          	ldw	(OFST-3,sp),x
1727                     ; 278 	uint16_t i = 0;
1729                     ; 280 	for (i = 0; i < NUM_SAMPLES; i++) {
1731  0497 5f            	clrw	x
1732  0498 1f0b          	ldw	(OFST-1,sp),x
1734  049a               L306:
1735                     ; 282 		buffer[i] = convert_adc_to_voltage(read_ADC_Channel(ADC2_CHANNEL_6));
1737  049a a606          	ld	a,#6
1738  049c 8d800180      	callf	f_read_ADC_Channel
1740  04a0 8d470547      	callf	f_convert_adc_to_voltage
1742  04a4 1e0b          	ldw	x,(OFST-1,sp)
1743  04a6 58            	sllw	x
1744  04a7 58            	sllw	x
1745  04a8 72fb0d        	addw	x,(OFST+1,sp)
1746  04ab 8d000000      	callf	d_rtol
1748                     ; 284 		delay_us(1000000 / SAMPLE_RATE);
1750  04af ae1a0a        	ldw	x,#6666
1751  04b2 8d000000      	callf	f_delay_us
1753                     ; 286 		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
1755  04b6 1e0b          	ldw	x,(OFST-1,sp)
1756  04b8 2754          	jreq	L116
1758  04ba ce1021        	ldw	x,L525+2
1759  04bd 89            	pushw	x
1760  04be ce101f        	ldw	x,L525
1761  04c1 89            	pushw	x
1762  04c2 1e0f          	ldw	x,(OFST+3,sp)
1763  04c4 58            	sllw	x
1764  04c5 58            	sllw	x
1765  04c6 72fb11        	addw	x,(OFST+5,sp)
1766  04c9 9093          	ldw	y,x
1767  04cb ee02          	ldw	x,(2,x)
1768  04cd 89            	pushw	x
1769  04ce 93            	ldw	x,y
1770  04cf fe            	ldw	x,(x)
1771  04d0 89            	pushw	x
1772  04d1 1e13          	ldw	x,(OFST+7,sp)
1773  04d3 58            	sllw	x
1774  04d4 58            	sllw	x
1775  04d5 1d0004        	subw	x,#4
1776  04d8 72fb15        	addw	x,(OFST+9,sp)
1777  04db 9093          	ldw	y,x
1778  04dd ee02          	ldw	x,(2,x)
1779  04df 89            	pushw	x
1780  04e0 93            	ldw	x,y
1781  04e1 fe            	ldw	x,(x)
1782  04e2 89            	pushw	x
1783  04e3 8da601a6      	callf	f_detectZeroCross
1785  04e7 5b0c          	addw	sp,#12
1786  04e9 4d            	tnz	a
1787  04ea 2722          	jreq	L116
1788                     ; 287 				unsigned long period = currentEdgeTime - lastEdgeTime;   // Calculate period
1790  04ec ae000c        	ldw	x,#_currentEdgeTime
1791  04ef 8d000000      	callf	d_ltor
1793  04f3 ae0008        	ldw	x,#_lastEdgeTime
1794  04f6 8d000000      	callf	d_lsub
1796                     ; 288 				ZCount++;
1798  04fa 1e09          	ldw	x,(OFST-3,sp)
1799  04fc 1c0001        	addw	x,#1
1800  04ff 1f09          	ldw	(OFST-3,sp),x
1802                     ; 289 				if (ZCount == 2)
1804  0501 1e09          	ldw	x,(OFST-3,sp)
1805  0503 a30002        	cpw	x,#2
1806  0506 2606          	jrne	L116
1807                     ; 291 					count = i;    // for amplitude calculation limit bound
1809  0508 1e0b          	ldw	x,(OFST-1,sp)
1810  050a bf12          	ldw	_count,x
1811                     ; 292 					break;        // break when zeroCrossing detection is two
1813  050c 2012          	jra	L706
1814  050e               L116:
1815                     ; 280 	for (i = 0; i < NUM_SAMPLES; i++) {
1817  050e 1e0b          	ldw	x,(OFST-1,sp)
1818  0510 1c0001        	addw	x,#1
1819  0513 1f0b          	ldw	(OFST-1,sp),x
1823  0515 1e0b          	ldw	x,(OFST-1,sp)
1824  0517 a30400        	cpw	x,#1024
1825  051a 2404ac9a049a  	jrult	L306
1826  0520               L706:
1827                     ; 296 	amplitude = calculate_amplitude(buffer, count);
1829  0520 be12          	ldw	x,_count
1830  0522 8d000000      	callf	d_uitolx
1832  0526 be02          	ldw	x,c_lreg+2
1833  0528 89            	pushw	x
1834  0529 be00          	ldw	x,c_lreg
1835  052b 89            	pushw	x
1836  052c 1e11          	ldw	x,(OFST+5,sp)
1837  052e 8da602a6      	callf	f_calculate_amplitude
1839  0532 5b04          	addw	sp,#4
1840  0534 96            	ldw	x,sp
1841  0535 1c0005        	addw	x,#OFST-7
1842  0538 8d000000      	callf	d_rtol
1845                     ; 298 	return amplitude;
1847  053c 96            	ldw	x,sp
1848  053d 1c0005        	addw	x,#OFST-7
1849  0540 8d000000      	callf	d_ltor
1853  0544 5b0e          	addw	sp,#14
1854  0546 87            	retf
1888                     ; 302 float convert_adc_to_voltage(unsigned int adcValue) {
1889                     	switch	.text
1890  0547               f_convert_adc_to_voltage:
1894                     ; 303 	return adcValue * (V_REF / ADC_MAX_VALUE);
1896  0547 8d000000      	callf	d_uitof
1898  054b ae101b        	ldw	x,#L736
1899  054e 8d000000      	callf	d_fmul
1903  0552 87            	retf
1937                     ; 307 float calculate_frequency(unsigned long period) {
1938                     	switch	.text
1939  0553               f_calculate_frequency:
1941  0553 5204          	subw	sp,#4
1942       00000004      OFST:	set	4
1945                     ; 308 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
1947  0555 96            	ldw	x,sp
1948  0556 1c0008        	addw	x,#OFST+4
1949  0559 8d000000      	callf	d_ltor
1951  055d 8d000000      	callf	d_ultof
1953  0561 ae1013        	ldw	x,#L576
1954  0564 8d000000      	callf	d_fdiv
1956  0568 96            	ldw	x,sp
1957  0569 1c0001        	addw	x,#OFST-3
1958  056c 8d000000      	callf	d_rtol
1961  0570 ae1017        	ldw	x,#L566
1962  0573 8d000000      	callf	d_ltor
1964  0577 96            	ldw	x,sp
1965  0578 1c0001        	addw	x,#OFST-3
1966  057b 8d000000      	callf	d_fdiv
1970  057f 5b04          	addw	sp,#4
1971  0581 87            	retf
2025                     ; 312 void output_results(float frequency, float amplitude) {
2026                     	switch	.text
2027  0582               f_output_results:
2029  0582 5228          	subw	sp,#40
2030       00000028      OFST:	set	40
2033                     ; 318 	sprintf(buffer, "%.3f,%.3f,%.3f\n", frequency, amplitude, amplitude);
2035  0584 1e32          	ldw	x,(OFST+10,sp)
2036  0586 89            	pushw	x
2037  0587 1e32          	ldw	x,(OFST+10,sp)
2038  0589 89            	pushw	x
2039  058a 1e36          	ldw	x,(OFST+14,sp)
2040  058c 89            	pushw	x
2041  058d 1e36          	ldw	x,(OFST+14,sp)
2042  058f 89            	pushw	x
2043  0590 1e36          	ldw	x,(OFST+14,sp)
2044  0592 89            	pushw	x
2045  0593 1e36          	ldw	x,(OFST+14,sp)
2046  0595 89            	pushw	x
2047  0596 ae1003        	ldw	x,#L727
2048  0599 89            	pushw	x
2049  059a 96            	ldw	x,sp
2050  059b 1c000f        	addw	x,#OFST-25
2051  059e 8d000000      	callf	f_sprintf
2053  05a2 5b0e          	addw	sp,#14
2054                     ; 321 	printf("%s", buffer);
2056  05a4 96            	ldw	x,sp
2057  05a5 1c0001        	addw	x,#OFST-39
2058  05a8 89            	pushw	x
2059  05a9 ae1000        	ldw	x,#L137
2060  05ac 8d000000      	callf	f_printf
2062  05b0 85            	popw	x
2063                     ; 323 }
2066  05b1 5b28          	addw	sp,#40
2067  05b3 87            	retf
2102                     ; 326 PUTCHAR_PROTOTYPE {
2103                     	switch	.text
2104  05b4               f_putchar:
2106  05b4 88            	push	a
2107       00000000      OFST:	set	0
2110                     ; 327 	UART3_SendData8(c);
2112  05b5 8d000000      	callf	f_UART3_SendData8
2115  05b9               L357:
2116                     ; 328 	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
2118  05b9 ae0080        	ldw	x,#128
2119  05bc 8d000000      	callf	f_UART3_GetFlagStatus
2121  05c0 4d            	tnz	a
2122  05c1 27f6          	jreq	L357
2123                     ; 329 	return c;
2125  05c3 7b01          	ld	a,(OFST+1,sp)
2128  05c5 5b01          	addw	sp,#1
2129  05c7 87            	retf
2164                     ; 332 GETCHAR_PROTOTYPE
2164                     ; 333 {
2165                     	switch	.text
2166  05c8               f_getchar:
2168  05c8 88            	push	a
2169       00000001      OFST:	set	1
2172                     ; 334   char c = 0;
2175  05c9               L777:
2176                     ; 336   while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
2178  05c9 ae0020        	ldw	x,#32
2179  05cc 8d000000      	callf	f_UART3_GetFlagStatus
2181  05d0 4d            	tnz	a
2182  05d1 27f6          	jreq	L777
2183                     ; 337 	c = UART3_ReceiveData8();
2185  05d3 8d000000      	callf	f_UART3_ReceiveData8
2187  05d7 6b01          	ld	(OFST+0,sp),a
2189                     ; 338   return (c);
2191  05d9 7b01          	ld	a,(OFST+0,sp)
2194  05db 5b01          	addw	sp,#1
2195  05dd 87            	retf
2219                     ; 341 void UART3_ClearBuffer(void) {
2220                     	switch	.text
2221  05de               f_UART3_ClearBuffer:
2225  05de 2004          	jra	L5101
2226  05e0               L3101:
2227                     ; 343         (void)UART3_ReceiveData8(); // Clear any preexisting data
2229  05e0 8d000000      	callf	f_UART3_ReceiveData8
2231  05e4               L5101:
2232                     ; 342     while (UART3_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
2234  05e4 ae0020        	ldw	x,#32
2235  05e7 8d000000      	callf	f_UART3_GetFlagStatus
2237  05eb 4d            	tnz	a
2238  05ec 26f2          	jrne	L3101
2239                     ; 345 }
2242  05ee 87            	retf
2306                     ; 347 void UART3_ReceiveString(char *buffer, uint16_t max_length) {
2307                     	switch	.text
2308  05ef               f_UART3_ReceiveString:
2310  05ef 89            	pushw	x
2311  05f0 5203          	subw	sp,#3
2312       00000003      OFST:	set	3
2315                     ; 348     uint16_t i = 0;
2317                     ; 351     for (i = 0; i < max_length; i++) {
2319  05f2 5f            	clrw	x
2320  05f3 1f02          	ldw	(OFST-1,sp),x
2323  05f5 200d          	jra	L7501
2324  05f7               L3501:
2325                     ; 352         buffer[i] = '\0';
2327  05f7 1e04          	ldw	x,(OFST+1,sp)
2328  05f9 72fb02        	addw	x,(OFST-1,sp)
2329  05fc 7f            	clr	(x)
2330                     ; 351     for (i = 0; i < max_length; i++) {
2332  05fd 1e02          	ldw	x,(OFST-1,sp)
2333  05ff 1c0001        	addw	x,#1
2334  0602 1f02          	ldw	(OFST-1,sp),x
2336  0604               L7501:
2339  0604 1e02          	ldw	x,(OFST-1,sp)
2340  0606 1309          	cpw	x,(OFST+6,sp)
2341  0608 25ed          	jrult	L3501
2342                     ; 354     i = 0;
2344  060a 5f            	clrw	x
2345  060b 1f02          	ldw	(OFST-1,sp),x
2348  060d 202c          	jra	L7601
2349  060f               L5701:
2350                     ; 358         while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
2352  060f ae0020        	ldw	x,#32
2353  0612 8d000000      	callf	f_UART3_GetFlagStatus
2355  0616 4d            	tnz	a
2356  0617 27f6          	jreq	L5701
2357                     ; 360         receivedChar = UART3_ReceiveData8();
2359  0619 8d000000      	callf	f_UART3_ReceiveData8
2361  061d 6b01          	ld	(OFST-2,sp),a
2363                     ; 362         if (receivedChar == '\n' || receivedChar == '\r') {
2365  061f 7b01          	ld	a,(OFST-2,sp)
2366  0621 a10a          	cp	a,#10
2367  0623 271d          	jreq	L1701
2369  0625 7b01          	ld	a,(OFST-2,sp)
2370  0627 a10d          	cp	a,#13
2371  0629 2717          	jreq	L1701
2372                     ; 366         buffer[i++] = receivedChar;
2374  062b 7b01          	ld	a,(OFST-2,sp)
2375  062d 1e02          	ldw	x,(OFST-1,sp)
2376  062f 1c0001        	addw	x,#1
2377  0632 1f02          	ldw	(OFST-1,sp),x
2378  0634 1d0001        	subw	x,#1
2380  0637 72fb04        	addw	x,(OFST+1,sp)
2381  063a f7            	ld	(x),a
2382  063b               L7601:
2383                     ; 357     while (i < max_length - 1) {
2385  063b 1e09          	ldw	x,(OFST+6,sp)
2386  063d 5a            	decw	x
2387  063e 1302          	cpw	x,(OFST-1,sp)
2388  0640 22cd          	jrugt	L5701
2389  0642               L1701:
2390                     ; 369     buffer[i] = '\0'; // Null-terminate the string
2392  0642 1e04          	ldw	x,(OFST+1,sp)
2393  0644 72fb02        	addw	x,(OFST-1,sp)
2394  0647 7f            	clr	(x)
2395                     ; 370 }
2398  0648 5b05          	addw	sp,#5
2399  064a 87            	retf
2467                     	xdef	f_main
2468                     	xdef	f_UART3_ReceiveString
2469                     	xdef	f_UART3_ClearBuffer
2470                     	xdef	f_process_FDR_samples
2471                     	xdef	f_calculate_frequency
2472                     	xdef	f_convert_adc_to_voltage
2473                     	xdef	f_process_adc_samples
2474                     	xdef	f_calculate_amplitude
2475                     	xdef	f_output_results
2476                     	xdef	f_initialize_adc_buffer
2477                     	xdef	f_detectZeroCross
2478                     	xdef	f_detectPosZeroCross
2479                     	xdef	f_read_ADC_Channel
2480                     	xdef	f_elapsedTime
2481                     	xdef	f_ADC2_setup
2482                     	xdef	f_UART3_setup
2483                     	xdef	f_clock_setup
2484                     	xdef	f_main_loop
2485                     	xdef	f_initialize_system
2486                     	xdef	_count
2487                     	xdef	_crossingType
2488                     	xdef	_currentEdgeTime
2489                     	xdef	_lastEdgeTime
2490                     	xdef	_sine1_amplitude
2491                     	xdef	_sine1_frequency
2492                     	xref	f_I2CInit
2493                     	xref	f_EEPROM_Config
2494                     	xref	f_micros
2495                     	xref	f_delay_us
2496                     	xref	f_TIM4_Config
2497                     	xref	f_sprintf
2498                     	xdef	f_putchar
2499                     	xref	f_printf
2500                     	xdef	f_getchar
2501                     	xref	f_UART3_GetFlagStatus
2502                     	xref	f_UART3_SendData8
2503                     	xref	f_UART3_ReceiveData8
2504                     	xref	f_UART3_Cmd
2505                     	xref	f_UART3_Init
2506                     	xref	f_UART3_DeInit
2507                     	xref	f_GPIO_Init
2508                     	xref	f_GPIO_DeInit
2509                     	xref	f_CLK_GetFlagStatus
2510                     	xref	f_CLK_SYSCLKConfig
2511                     	xref	f_CLK_HSIPrescalerConfig
2512                     	xref	f_CLK_ClockSwitchConfig
2513                     	xref	f_CLK_PeripheralClockConfig
2514                     	xref	f_CLK_ClockSwitchCmd
2515                     	xref	f_CLK_LSICmd
2516                     	xref	f_CLK_HSICmd
2517                     	xref	f_CLK_HSECmd
2518                     	xref	f_CLK_DeInit
2519                     	xref	f_ADC2_ClearFlag
2520                     	xref	f_ADC2_GetFlagStatus
2521                     	xref	f_ADC2_GetConversionValue
2522                     	xref	f_ADC2_StartConversion
2523                     	xref	f_ADC2_ConversionConfig
2524                     	xref	f_ADC2_Cmd
2525                     	xref	f_ADC2_Init
2526                     	xref	f_ADC2_DeInit
2527                     	switch	.const
2528  1000               L137:
2529  1000 257300        	dc.b	"%s",0
2530  1003               L727:
2531  1003 252e33662c25  	dc.b	"%.3f,%.3f,%.3f",10,0
2532  1013               L576:
2533  1013 49742400      	dc.w	18804,9216
2534  1017               L566:
2535  1017 3f800000      	dc.w	16256,0
2536  101b               L736:
2537  101b 3b954409      	dc.w	15253,17417
2538  101f               L525:
2539  101f 401851eb      	dc.w	16408,20971
2540  1023               L363:
2541  1023 c0951eb8      	dc.w	-16235,7864
2542  1027               L373:
2543  1027 40951eb8      	dc.w	16533,7864
2544  102b               L74:
2545  102b 53797374656d  	dc.b	"System Initializat"
2546  103d 696f6e20436f  	dc.b	"ion Completed",10
2547  104b 0d00          	dc.b	13,0
2548  104d               L53:
2549  104d 0a0d52656365  	dc.b	10,13,82,101,99,101
2550  1053 697665642073  	dc.b	"ived string: %s",10
2551  1063 0d00          	dc.b	13,0
2552  1065               L33:
2553  1065 0a0d456e7465  	dc.b	10,13,69,110,116,101
2554  106b 722061207374  	dc.b	"r a string:",10
2555  1077 0d00          	dc.b	13,0
2556  1079               L145:
2557  1079 00000000      	dc.w	0,0
2558                     	xref.b	c_lreg
2559                     	xref.b	c_x
2560                     	xref.b	c_y
2580                     	xref	d_ultof
2581                     	xref	d_fmul
2582                     	xref	d_uitof
2583                     	xref	d_fdiv
2584                     	xref	d_fgadd
2585                     	xref	d_lzmp
2586                     	xref	d_itof
2587                     	xref	d_fsub
2588                     	xref	d_lgadc
2589                     	xref	d_fneg
2590                     	xref	d_fcmp
2591                     	xref	d_ladd
2592                     	xref	d_lneg
2593                     	xref	d_lsub
2594                     	xref	d_lcmp
2595                     	xref	d_ltor
2596                     	xref	d_uitolx
2597                     	xref	d_rtol
2598                     	xref	d_xymovl
2599                     	end
