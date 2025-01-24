   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  17                     	bsct
  18  0000               _sine1_frequency:
  19  0000 00000000      	dc.w	0,0
  20  0004               _sine1_amplitude:
  21  0004 00000000      	dc.w	0,0
  22  0008               _lastEdgeTime:
  23  0008 00000000      	dc.l	0
  24  000c               _currentEdgeTime:
  25  000c 00000000      	dc.l	0
  26  0010               _crossingType:
  27  0010 ffff          	dc.w	-1
  28  0012               _count:
  29  0012 0000          	dc.w	0
  30  0014               _isThyristorON:
  31  0014 00            	dc.b	0
 202                     ; 12 void main() {
 203                     	switch	.text
 204  0000               f_main:
 206  0000 520c          	subw	sp,#12
 207       0000000c      OFST:	set	12
 210                     ; 14 	float VAR_frequency = 0, VAR_amplitude = 0;
 212  0002 5f            	clrw	x
 213  0003 1f03          	ldw	(OFST-9,sp),x
 214  0005 1f01          	ldw	(OFST-11,sp),x
 218  0007 1f0b          	ldw	(OFST-1,sp),x
 219  0009 1f09          	ldw	(OFST-3,sp),x
 221                     ; 15 	float FDR_amplitude = 0;
 223  000b 1f07          	ldw	(OFST-5,sp),x
 224  000d 1f05          	ldw	(OFST-7,sp),x
 226                     ; 17 	initialize_system(); 
 228  000f 8d320132      	callf	f_initialize_system
 230  0013               L511:
 231                     ; 20 		FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
 233  0013 96            	ldw	x,sp
 234  0014 1c0005        	addw	x,#OFST-7
 235  0017 89            	pushw	x
 236  0018 5f            	clrw	x
 237  0019 89            	pushw	x
 238  001a a606          	ld	a,#6
 239  001c 8d5f035f      	callf	f_process_adc_signal
 241  0020 5b04          	addw	sp,#4
 242  0022 96            	ldw	x,sp
 243  0023 1c0005        	addw	x,#OFST-7
 244  0026 8d000000      	callf	d_rtol
 247                     ; 22 		if(FDR_amplitude > 0) {  // Voltage detected on Signal 2
 249  002a 9c            	rvf	
 250  002b 7b05          	ld	a,(OFST-7,sp)
 251  002d 2de4          	jrsle	L511
 252                     ; 23 			GPIO_WriteHigh(GPIOC, GPIO_PIN_3);  // Turn on LED
 254  002f 4b08          	push	#8
 255  0031 ae500a        	ldw	x,#20490
 257  0034               LC001:
 258  0034 8d000000      	callf	f_GPIO_WriteHigh
 259  0038 84            	pop	a
 260  0039               L321:
 261                     ; 26 			VAR_amplitude = process_adc_signal(VAR_SIGNAL, &VAR_frequency, &VAR_amplitude);
 263  0039 96            	ldw	x,sp
 264  003a 1c0009        	addw	x,#OFST-3
 265  003d 89            	pushw	x
 266  003e 1d0008        	subw	x,#8
 267  0041 89            	pushw	x
 268  0042 a605          	ld	a,#5
 269  0044 8d5f035f      	callf	f_process_adc_signal
 271  0048 5b04          	addw	sp,#4
 272  004a 96            	ldw	x,sp
 273  004b 1c0009        	addw	x,#OFST-3
 274  004e 8d000000      	callf	d_rtol
 277                     ; 30 			if (VAR_frequency <= SET_FREQ){
 279  0052 96            	ldw	x,sp
 280  0053 5c            	incw	x
 281  0054 8d000000      	callf	d_ltor
 283  0058 ae1174        	ldw	x,#L531
 284  005b 8d000000      	callf	d_fcmp
 286  005f 2cd8          	jrsgt	L321
 287                     ; 34 				if(check_negative_zero_crossing()){     // Wait for negative zero crossing
 289  0061 8d5b025b      	callf	f_check_negative_zero_crossing
 291  0065 4d            	tnz	a
 292  0066 27d1          	jreq	L321
 293                     ; 35 					send_square_pulse(5); 
 295  0068 ae0005        	ldw	x,#5
 296  006b 8d780578      	callf	f_send_square_pulse
 298                     ; 36 					GPIO_WriteHigh(GPIOA, GPIO_PIN_3);  // Turn on LED if Signal is DC
 300  006f 4b08          	push	#8
 301  0071 ae5000        	ldw	x,#20480
 302  0074 8d000000      	callf	f_GPIO_WriteHigh
 304  0078 84            	pop	a
 305                     ; 37 					VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
 307  0079 96            	ldw	x,sp
 308  007a 1c0009        	addw	x,#OFST-3
 309  007d 89            	pushw	x
 310  007e 5f            	clrw	x
 311  007f 89            	pushw	x
 312  0080 a605          	ld	a,#5
 313  0082 8d5f035f      	callf	f_process_adc_signal
 315  0086 5b04          	addw	sp,#4
 316  0088 96            	ldw	x,sp
 317  0089 1c0009        	addw	x,#OFST-3
 318  008c 8d000000      	callf	d_rtol
 321                     ; 40 					if(check_signal_dc(VAR_amplitude)){
 323  0090 1e0b          	ldw	x,(OFST-1,sp)
 324  0092 89            	pushw	x
 325  0093 1e0b          	ldw	x,(OFST-1,sp)
 326  0095 89            	pushw	x
 327  0096 8db205b2      	callf	f_check_signal_dc
 329  009a 5b04          	addw	sp,#4
 330  009c 4d            	tnz	a
 331  009d 2742          	jreq	L161
 332                     ; 41 						printf("Signal 1 DC.\n");
 334  009f ae1166        	ldw	x,#L541
 335  00a2 8d000000      	callf	f_printf
 337                     ; 42 						GPIO_WriteHigh(GPIOD, GPIO_PIN_3);  // Turn on LED if Signal is DC
 339  00a6 4b08          	push	#8
 340  00a8               LC002:
 341  00a8 ae500f        	ldw	x,#20495
 342  00ab 8d000000      	callf	f_GPIO_WriteHigh
 344  00af               L75:
 345  00af 84            	pop	a
 346                     ; 44 							FDR_Sampling:                         // LABEL for goto
 346                     ; 45 							FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
 348  00b0 96            	ldw	x,sp
 349  00b1 1c0005        	addw	x,#OFST-7
 350  00b4 89            	pushw	x
 351  00b5 5f            	clrw	x
 352  00b6 89            	pushw	x
 353  00b7 a606          	ld	a,#6
 354  00b9 8d5f035f      	callf	f_process_adc_signal
 356  00bd 5b04          	addw	sp,#4
 357  00bf 96            	ldw	x,sp
 358  00c0 1c0005        	addw	x,#OFST-7
 359  00c3 8d000000      	callf	d_rtol
 362                     ; 47 							if(isThyristorON){
 364  00c7 b614          	ld	a,_isThyristorON
 365  00c9 270b          	jreq	L351
 366                     ; 48 								send_square_pulse(3000);
 368  00cb ae0bb8        	ldw	x,#3000
 369  00ce 8d780578      	callf	f_send_square_pulse
 371                     ; 49 								GPIO_WriteHigh(GPIOD, GPIO_PIN_0);  // Turn on LED ORANGE
 373  00d2 4b01          	push	#1
 375                     ; 50 								goto FDR_Sampling;
 377  00d4 20d2          	jpf	LC002
 378  00d6               L351:
 379                     ; 53 								GPIO_WriteLow(GPIOD, GPIO_PIN_0);  // Turn on LED ORANGE
 381  00d6 4b01          	push	#1
 382  00d8 ae500f        	ldw	x,#20495
 383  00db 8d000000      	callf	f_GPIO_WriteLow
 385                     ; 54 								goto FDR_Sampling;
 387  00df 20ce          	jra	L75
 388  00e1               L161:
 389                     ; 61 							printf("Signal 1 AC and VarAmplitude: %f.\n", VAR_amplitude);
 391  00e1 1e0b          	ldw	x,(OFST-1,sp)
 392  00e3 89            	pushw	x
 393  00e4 1e0b          	ldw	x,(OFST-1,sp)
 394  00e6 89            	pushw	x
 395  00e7 ae1143        	ldw	x,#L561
 396  00ea 8d000000      	callf	f_printf
 398  00ee 5b04          	addw	sp,#4
 399                     ; 62 							if (VAR_amplitude < AC_AMPLITUDE_THRESHOLD) {
 401  00f0 96            	ldw	x,sp
 402  00f1 1c0009        	addw	x,#OFST-3
 403  00f4 8d000000      	callf	d_ltor
 405  00f8 ae113f        	ldw	x,#L571
 406  00fb 8d000000      	callf	d_fcmp
 408  00ff 2e21          	jrsge	L761
 409                     ; 63 								printf("VarAmplitude below 10 mv.\n");
 411  0101 ae1124        	ldw	x,#L102
 412  0104 8d000000      	callf	f_printf
 414                     ; 64 								GPIO_WriteLow(GPIOE, GPIO_PIN_3);  // Turn on LED if Signal is AC < 20 mV
 416  0108 4b08          	push	#8
 417  010a ae5014        	ldw	x,#20500
 418  010d 8d000000      	callf	f_GPIO_WriteLow
 420  0111 ae0bb8        	ldw	x,#3000
 421  0114 84            	pop	a
 422                     ; 65 								delay_ms(3000);
 424  0115 8d000000      	callf	f_delay_ms
 426                     ; 66 								send_square_pulse(5);
 428  0119 ae0005        	ldw	x,#5
 429  011c 8d780578      	callf	f_send_square_pulse
 432  0120 20bf          	jra	L161
 433  0122               L761:
 434                     ; 69 								printf("VarAmplitude Not below 10 mv.\n");
 436  0122 ae1105        	ldw	x,#L502
 437  0125 8d000000      	callf	f_printf
 439                     ; 70 								GPIO_WriteHigh(GPIOE, GPIO_PIN_3);  // Turn on LED if Signal is AC < 20 mV
 441  0129 4b08          	push	#8
 442  012b ae5014        	ldw	x,#20500
 444                     ; 71 								break;
 446  012e ac340034      	jpf	LC001
 476                     ; 88 void initialize_system(void) {
 477                     	switch	.text
 478  0132               f_initialize_system:
 482                     ; 89 	clock_setup();          // Configure system clock
 484  0132 8d000000      	callf	f_clock_setup
 486                     ; 90 	TIM4_Config();          // Timer 4 config for delay
 488  0136 8d000000      	callf	f_TIM4_Config
 490                     ; 91 	UART3_setup();          // Setup UART communication
 492  013a 8d000000      	callf	f_UART3_setup
 494                     ; 92 	ADC2_setup();						// Setup ADC
 496  013e 8d000000      	callf	f_ADC2_setup
 498                     ; 93 	GPIO_setup();
 500  0142 8d000000      	callf	f_GPIO_setup
 502                     ; 94 	EEPROM_Config();        // Configuring EEPROM
 504  0146 8d000000      	callf	f_EEPROM_Config
 506                     ; 95 	I2CInit();              // for Configuring RTC
 508  014a 8d000000      	callf	f_I2CInit
 510                     ; 96 	printf("System Initialization Completed\n\r");
 512  014e ae10e3        	ldw	x,#L712
 514                     ; 97 }
 517  0151 ac000000      	jpf	f_printf
 590                     ; 100 bool detectZeroCross(float previousSample, float currentSample, float threshold) {
 591                     	switch	.text
 592  0155               f_detectZeroCross:
 594       00000000      OFST:	set	0
 597                     ; 101 	if (crossingType == -1) {  // If no crossing type detected, check for both positive and negative
 599  0155 be10          	ldw	x,_crossingType
 600  0157 5c            	incw	x
 601  0158 2656          	jrne	L752
 602                     ; 102 		if (previousSample <= threshold && currentSample > threshold) {
 604  015a 96            	ldw	x,sp
 605  015b 1c0004        	addw	x,#OFST+4
 606  015e 8d000000      	callf	d_ltor
 608  0162 96            	ldw	x,sp
 609  0163 1c000c        	addw	x,#OFST+12
 610  0166 8d000000      	callf	d_fcmp
 612  016a 2c18          	jrsgt	L162
 614  016c 96            	ldw	x,sp
 615  016d 1c0008        	addw	x,#OFST+8
 616  0170 8d000000      	callf	d_ltor
 618  0174 96            	ldw	x,sp
 619  0175 1c000c        	addw	x,#OFST+12
 620  0178 8d000000      	callf	d_fcmp
 622  017c 2d06          	jrsle	L162
 623                     ; 103 			crossingType = 0;  // Positive zero crossing
 625  017e 5f            	clrw	x
 626  017f bf10          	ldw	_crossingType,x
 627                     ; 104 			return true;
 629  0181 a601          	ld	a,#1
 632  0183 87            	retf	
 633  0184               L162:
 634                     ; 105 		} else if (previousSample >= threshold && currentSample < threshold) {
 636  0184 96            	ldw	x,sp
 637  0185 1c0004        	addw	x,#OFST+4
 638  0188 8d000000      	callf	d_ltor
 640  018c 96            	ldw	x,sp
 641  018d 1c000c        	addw	x,#OFST+12
 642  0190 8d000000      	callf	d_fcmp
 644  0194 2f71          	jrslt	L762
 646  0196 96            	ldw	x,sp
 647  0197 1c0008        	addw	x,#OFST+8
 648  019a 8d000000      	callf	d_ltor
 650  019e 96            	ldw	x,sp
 651  019f 1c000c        	addw	x,#OFST+12
 652  01a2 8d000000      	callf	d_fcmp
 654  01a6 2e5f          	jrsge	L762
 655                     ; 106 			crossingType = 1;  // Negative zero crossing
 657  01a8 ae0001        	ldw	x,#1
 658  01ab bf10          	ldw	_crossingType,x
 659                     ; 107 			return true;
 661  01ad a601          	ld	a,#1
 664  01af 87            	retf	
 665  01b0               L752:
 666                     ; 109 	} else if (crossingType == 0 && previousSample <= threshold && currentSample > threshold) {
 668  01b0 be10          	ldw	x,_crossingType
 669  01b2 2627          	jrne	L172
 671  01b4 96            	ldw	x,sp
 672  01b5 1c0004        	addw	x,#OFST+4
 673  01b8 8d000000      	callf	d_ltor
 675  01bc 96            	ldw	x,sp
 676  01bd 1c000c        	addw	x,#OFST+12
 677  01c0 8d000000      	callf	d_fcmp
 679  01c4 2c15          	jrsgt	L172
 681  01c6 96            	ldw	x,sp
 682  01c7 1c0008        	addw	x,#OFST+8
 683  01ca 8d000000      	callf	d_ltor
 685  01ce 96            	ldw	x,sp
 686  01cf 1c000c        	addw	x,#OFST+12
 687  01d2 8d000000      	callf	d_fcmp
 689  01d6 2d03          	jrsle	L172
 690                     ; 110 			return true;  // Positive zero crossing
 692  01d8 a601          	ld	a,#1
 695  01da 87            	retf	
 696  01db               L172:
 697                     ; 111 	} else if (crossingType == 1 && previousSample >= threshold && currentSample < threshold) {
 699  01db be10          	ldw	x,_crossingType
 700  01dd 5a            	decw	x
 701  01de 2627          	jrne	L762
 703  01e0 96            	ldw	x,sp
 704  01e1 1c0004        	addw	x,#OFST+4
 705  01e4 8d000000      	callf	d_ltor
 707  01e8 96            	ldw	x,sp
 708  01e9 1c000c        	addw	x,#OFST+12
 709  01ec 8d000000      	callf	d_fcmp
 711  01f0 2f15          	jrslt	L762
 713  01f2 96            	ldw	x,sp
 714  01f3 1c0008        	addw	x,#OFST+8
 715  01f6 8d000000      	callf	d_ltor
 717  01fa 96            	ldw	x,sp
 718  01fb 1c000c        	addw	x,#OFST+12
 719  01fe 8d000000      	callf	d_fcmp
 721  0202 2e03          	jrsge	L762
 722                     ; 112 			return true;  // Negative zero crossing
 724  0204 a601          	ld	a,#1
 727  0206 87            	retf	
 728  0207               L762:
 729                     ; 115 	return false;  // No zero crossing detected
 731  0207 4f            	clr	a
 734  0208 87            	retf	
 786                     ; 119 bool detectPosZeroCross(float previousSample, float currentSample, float threshold) {
 787                     	switch	.text
 788  0209               f_detectPosZeroCross:
 790       00000000      OFST:	set	0
 793                     ; 120 	return (previousSample <= threshold && currentSample > threshold);
 795  0209 96            	ldw	x,sp
 796  020a 1c0004        	addw	x,#OFST+4
 797  020d 8d000000      	callf	d_ltor
 799  0211 96            	ldw	x,sp
 800  0212 1c000c        	addw	x,#OFST+12
 801  0215 8d000000      	callf	d_fcmp
 803  0219 2c15          	jrsgt	L011
 804  021b 96            	ldw	x,sp
 805  021c 1c0008        	addw	x,#OFST+8
 806  021f 8d000000      	callf	d_ltor
 808  0223 96            	ldw	x,sp
 809  0224 1c000c        	addw	x,#OFST+12
 810  0227 8d000000      	callf	d_fcmp
 812  022b 2d03          	jrsle	L011
 813  022d a601          	ld	a,#1
 815  022f 87            	retf	
 816  0230               L011:
 817  0230 4f            	clr	a
 820  0231 87            	retf	
 873                     ; 124 bool detect_negative_zero_cross(float previous_sample, float current_sample, float threshold) {
 874                     	switch	.text
 875  0232               f_detect_negative_zero_cross:
 877       00000000      OFST:	set	0
 880                     ; 125     return (previous_sample > threshold && current_sample <= threshold);
 882  0232 96            	ldw	x,sp
 883  0233 1c0004        	addw	x,#OFST+4
 884  0236 8d000000      	callf	d_ltor
 886  023a 96            	ldw	x,sp
 887  023b 1c000c        	addw	x,#OFST+12
 888  023e 8d000000      	callf	d_fcmp
 890  0242 2d15          	jrsle	L611
 891  0244 96            	ldw	x,sp
 892  0245 1c0008        	addw	x,#OFST+8
 893  0248 8d000000      	callf	d_ltor
 895  024c 96            	ldw	x,sp
 896  024d 1c000c        	addw	x,#OFST+12
 897  0250 8d000000      	callf	d_fcmp
 899  0254 2c03          	jrsgt	L611
 900  0256 a601          	ld	a,#1
 902  0258 87            	retf	
 903  0259               L611:
 904  0259 4f            	clr	a
 907  025a 87            	retf	
 955                     ; 128 bool check_negative_zero_crossing(void) {
 956                     	switch	.text
 957  025b               f_check_negative_zero_crossing:
 959  025b 5208          	subw	sp,#8
 960       00000008      OFST:	set	8
 963                     ; 129 	float prev_adc_value = 0;  // Store previous ADC sample value
 965  025d 5f            	clrw	x
 966  025e 1f03          	ldw	(OFST-5,sp),x
 967                     ; 130 	float current_adc_value = 0;  // Store current ADC sample value
 969  0260               L573:
 970  0260 1f01          	ldw	(OFST-7,sp),x
 972                     ; 134 		current_adc_value = convert_adc_to_voltage(read_ADC_Channel(VAR_SIGNAL));
 974  0262 a605          	ld	a,#5
 975  0264 8d000000      	callf	f_read_ADC_Channel
 977  0268 8dfe04fe      	callf	f_convert_adc_to_voltage
 979  026c 96            	ldw	x,sp
 980  026d 1c0005        	addw	x,#OFST-3
 981  0270 8d000000      	callf	d_rtol
 984                     ; 136 		if (detect_negative_zero_cross(prev_adc_value, current_adc_value, ZEROCROSS_THRESHOLD)) {
 986  0274 ce10e1        	ldw	x,L704+2
 987  0277 89            	pushw	x
 988  0278 ce10df        	ldw	x,L704
 989  027b 89            	pushw	x
 990  027c 1e0b          	ldw	x,(OFST+3,sp)
 991  027e 89            	pushw	x
 992  027f 1e0b          	ldw	x,(OFST+3,sp)
 993  0281 89            	pushw	x
 994  0282 1e0b          	ldw	x,(OFST+3,sp)
 995  0284 89            	pushw	x
 996  0285 1e0b          	ldw	x,(OFST+3,sp)
 997  0287 89            	pushw	x
 998  0288 8d320232      	callf	f_detect_negative_zero_cross
1000  028c 5b0c          	addw	sp,#12
1001  028e 4d            	tnz	a
1002  028f 270c          	jreq	L104
1003                     ; 137 			printf("Negative zero crossing detected!\n");
1005  0291 ae10bd        	ldw	x,#L314
1006  0294 8d000000      	callf	f_printf
1008                     ; 138 			return true;
1010  0298 a601          	ld	a,#1
1013  029a 5b08          	addw	sp,#8
1014  029c 87            	retf	
1015  029d               L104:
1016                     ; 141 		prev_adc_value = current_adc_value;
1018  029d 1e07          	ldw	x,(OFST-1,sp)
1019  029f 1f03          	ldw	(OFST-5,sp),x
1020  02a1 1e05          	ldw	x,(OFST-3,sp)
1022  02a3 20bb          	jra	L573
1093                     ; 147 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
1094                     	switch	.text
1095  02a5               f_calculate_amplitude:
1097  02a5 89            	pushw	x
1098  02a6 520c          	subw	sp,#12
1099       0000000c      OFST:	set	12
1102                     ; 148 	uint32_t i = 0;
1104                     ; 149 	float max_val = -V_REF, min_val = V_REF;
1106  02a8 ce10b7        	ldw	x,L754+2
1107  02ab 1f03          	ldw	(OFST-9,sp),x
1108  02ad ce10b5        	ldw	x,L754
1109  02b0 1f01          	ldw	(OFST-11,sp),x
1113  02b2 ce10bb        	ldw	x,L764+2
1114  02b5 1f07          	ldw	(OFST-5,sp),x
1115  02b7 ce10b9        	ldw	x,L764
1116  02ba 1f05          	ldw	(OFST-7,sp),x
1118                     ; 151 	for (i = 0; i < sample_size; i++) {
1120  02bc 5f            	clrw	x
1121  02bd 1f0b          	ldw	(OFST-1,sp),x
1122  02bf 1f09          	ldw	(OFST-3,sp),x
1125  02c1 2054          	jra	L774
1126  02c3               L374:
1127                     ; 152 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1129  02c3 1e0b          	ldw	x,(OFST-1,sp)
1130  02c5 58            	sllw	x
1131  02c6 58            	sllw	x
1132  02c7 72fb0d        	addw	x,(OFST+1,sp)
1133  02ca 8d000000      	callf	d_ltor
1135  02ce 96            	ldw	x,sp
1136  02cf 5c            	incw	x
1137  02d0 8d000000      	callf	d_fcmp
1139  02d4 2d11          	jrsle	L305
1142  02d6 1e0b          	ldw	x,(OFST-1,sp)
1143  02d8 58            	sllw	x
1144  02d9 58            	sllw	x
1145  02da 72fb0d        	addw	x,(OFST+1,sp)
1146  02dd 9093          	ldw	y,x
1147  02df ee02          	ldw	x,(2,x)
1148  02e1 1f03          	ldw	(OFST-9,sp),x
1149  02e3 93            	ldw	x,y
1150  02e4 fe            	ldw	x,(x)
1151  02e5 1f01          	ldw	(OFST-11,sp),x
1153  02e7               L305:
1154                     ; 153 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1156  02e7 1e0b          	ldw	x,(OFST-1,sp)
1157  02e9 58            	sllw	x
1158  02ea 58            	sllw	x
1159  02eb 72fb0d        	addw	x,(OFST+1,sp)
1160  02ee 8d000000      	callf	d_ltor
1162  02f2 96            	ldw	x,sp
1163  02f3 1c0005        	addw	x,#OFST-7
1164  02f6 8d000000      	callf	d_fcmp
1166  02fa 2e11          	jrsge	L505
1169  02fc 1e0b          	ldw	x,(OFST-1,sp)
1170  02fe 58            	sllw	x
1171  02ff 58            	sllw	x
1172  0300 72fb0d        	addw	x,(OFST+1,sp)
1173  0303 9093          	ldw	y,x
1174  0305 ee02          	ldw	x,(2,x)
1175  0307 1f07          	ldw	(OFST-5,sp),x
1176  0309 93            	ldw	x,y
1177  030a fe            	ldw	x,(x)
1178  030b 1f05          	ldw	(OFST-7,sp),x
1180  030d               L505:
1181                     ; 151 	for (i = 0; i < sample_size; i++) {
1183  030d 96            	ldw	x,sp
1184  030e 1c0009        	addw	x,#OFST-3
1185  0311 a601          	ld	a,#1
1186  0313 8d000000      	callf	d_lgadc
1189  0317               L774:
1192  0317 96            	ldw	x,sp
1193  0318 1c0009        	addw	x,#OFST-3
1194  031b 8d000000      	callf	d_ltor
1196  031f 96            	ldw	x,sp
1197  0320 1c0012        	addw	x,#OFST+6
1198  0323 8d000000      	callf	d_lcmp
1200  0327 259a          	jrult	L374
1201                     ; 155 	return (max_val - min_val);
1203  0329 96            	ldw	x,sp
1204  032a 5c            	incw	x
1205  032b 8d000000      	callf	d_ltor
1207  032f 96            	ldw	x,sp
1208  0330 1c0005        	addw	x,#OFST-7
1209  0333 8d000000      	callf	d_fsub
1213  0337 5b0e          	addw	sp,#14
1214  0339 87            	retf	
1258                     ; 159 void initialize_adc_buffer(float buffer[]) {
1259                     	switch	.text
1260  033a               f_initialize_adc_buffer:
1262  033a 89            	pushw	x
1263  033b 89            	pushw	x
1264       00000002      OFST:	set	2
1267                     ; 160 	uint16_t i = 0;
1269                     ; 161 	for (i = 0; i < NUM_SAMPLES; i++) {
1271  033c 5f            	clrw	x
1272  033d 1f01          	ldw	(OFST-1,sp),x
1274  033f               L135:
1275                     ; 162 		buffer[i] = -1;  // Reset each element of the ADC buffer
1277  033f 58            	sllw	x
1278  0340 58            	sllw	x
1279  0341 72fb03        	addw	x,(OFST+1,sp)
1280  0344 9093          	ldw	y,x
1281  0346 aeffff        	ldw	x,#65535
1282  0349 8d000000      	callf	d_itof
1284  034d 93            	ldw	x,y
1285  034e 8d000000      	callf	d_rtol
1287                     ; 161 	for (i = 0; i < NUM_SAMPLES; i++) {
1289  0352 1e01          	ldw	x,(OFST-1,sp)
1290  0354 5c            	incw	x
1291  0355 1f01          	ldw	(OFST-1,sp),x
1295  0357 a30400        	cpw	x,#1024
1296  035a 25e3          	jrult	L135
1297                     ; 164 }
1300  035c 5b04          	addw	sp,#4
1301  035e 87            	retf	
1303                     .const:	section	.text
1304  0000               L735_buffer:
1305  0000 00000000      	dc.w	0,0
1306  0004 000000000000  	ds.b	4092
1442                     ; 166 float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
1443                     	switch	.text
1444  035f               f_process_adc_signal:
1446  035f 88            	push	a
1447  0360 96            	ldw	x,sp
1448  0361 1d1021        	subw	x,#4129
1449  0364 94            	ldw	sp,x
1450       00001021      OFST:	set	4129
1453                     ; 167 	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
1455  0365 96            	ldw	x,sp
1456  0366 1c0020        	addw	x,#OFST-4097
1457  0369 90ae0000      	ldw	y,#L735_buffer
1458  036d bf00          	ldw	c_x,x
1459  036f ae1000        	ldw	x,#4096
1460  0372 8d000000      	callf	d_xymovl
1462                     ; 168 	unsigned long currentEdgeTime = 0;
1464                     ; 169 	float freqBuff = 0;
1466                     ; 170 	int freqCount = 0;
1468  0376 5f            	clrw	x
1469  0377 1f1e          	ldw	(OFST-4099,sp),x
1471                     ; 171 	uint16_t i = 0;
1473                     ; 172 	bool isChannel1 = (channel == VAR_SIGNAL);  // Check if the channel is for Signal 1 or Signal 2
1475  0379 96            	ldw	x,sp
1476  037a d61022        	ld	a,(OFST+1,x)
1477  037d a105          	cp	a,#5
1478  037f 2605          	jrne	L241
1479  0381 ae0001        	ldw	x,#1
1480  0384 2001          	jra	L441
1481  0386               L241:
1482  0386 5f            	clrw	x
1483  0387               L441:
1484  0387 01            	rrwa	x,a
1485  0388 6b1d          	ld	(OFST-4100,sp),a
1487                     ; 173 	lastEdgeTime = 0;                 // Reset last zero-crossing time
1489  038a 5f            	clrw	x
1490  038b bf0a          	ldw	_lastEdgeTime+2,x
1491  038d bf08          	ldw	_lastEdgeTime,x
1492                     ; 175 	initialize_adc_buffer(buffer);
1494  038f 96            	ldw	x,sp
1495  0390 1c0020        	addw	x,#OFST-4097
1496  0393 8d3a033a      	callf	f_initialize_adc_buffer
1498                     ; 178 	for (i = 0; i < NUM_SAMPLES; i++) {
1500  0397 96            	ldw	x,sp
1501  0398 905f          	clrw	y
1502  039a df1020        	ldw	(OFST-1,x),y
1503  039d               L726:
1504                     ; 180 	buffer[i] = convert_adc_to_voltage(read_ADC_Channel(channel));
1506  039d 96            	ldw	x,sp
1507  039e d61022        	ld	a,(OFST+1,x)
1508  03a1 8d000000      	callf	f_read_ADC_Channel
1510  03a5 8dfe04fe      	callf	f_convert_adc_to_voltage
1512  03a9 96            	ldw	x,sp
1513  03aa 1c0020        	addw	x,#OFST-4097
1514  03ad 1f0f          	ldw	(OFST-4114,sp),x
1516  03af 96            	ldw	x,sp
1517  03b0 de1020        	ldw	x,(OFST-1,x)
1518  03b3 58            	sllw	x
1519  03b4 58            	sllw	x
1520  03b5 72fb0f        	addw	x,(OFST-4114,sp)
1521  03b8 8d000000      	callf	d_rtol
1523                     ; 182 	if (isChannel1 && (frequency != NULL)) { // Only calculate frequency for Signal 1 (Channel 1)
1525  03bc 7b1d          	ld	a,(OFST-4100,sp)
1526  03be 2604acd204d2  	jreq	L536
1528  03c4 96            	ldw	x,sp
1529  03c5 d61027        	ld	a,(OFST+6,x)
1530  03c8 da1026        	or	a,(OFST+5,x)
1531  03cb 27f3          	jreq	L536
1532                     ; 184 		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
1534  03cd d61021        	ld	a,(OFST+0,x)
1535  03d0 da1020        	or	a,(OFST-1,x)
1536  03d3 27eb          	jreq	L536
1538  03d5 ce10e1        	ldw	x,L704+2
1539  03d8 89            	pushw	x
1540  03d9 ce10df        	ldw	x,L704
1541  03dc 89            	pushw	x
1542  03dd 96            	ldw	x,sp
1543  03de 1c0024        	addw	x,#OFST-4093
1544  03e1 1f13          	ldw	(OFST-4110,sp),x
1546  03e3 96            	ldw	x,sp
1547  03e4 de1024        	ldw	x,(OFST+3,x)
1548  03e7 58            	sllw	x
1549  03e8 58            	sllw	x
1550  03e9 72fb13        	addw	x,(OFST-4110,sp)
1551  03ec 9093          	ldw	y,x
1552  03ee ee02          	ldw	x,(2,x)
1553  03f0 89            	pushw	x
1554  03f1 93            	ldw	x,y
1555  03f2 fe            	ldw	x,(x)
1556  03f3 89            	pushw	x
1557  03f4 96            	ldw	x,sp
1558  03f5 1c0028        	addw	x,#OFST-4089
1559  03f8 1f15          	ldw	(OFST-4108,sp),x
1561  03fa 96            	ldw	x,sp
1562  03fb de1028        	ldw	x,(OFST+7,x)
1563  03fe 58            	sllw	x
1564  03ff 58            	sllw	x
1565  0400 1d0004        	subw	x,#4
1566  0403 72fb15        	addw	x,(OFST-4108,sp)
1567  0406 9093          	ldw	y,x
1568  0408 ee02          	ldw	x,(2,x)
1569  040a 89            	pushw	x
1570  040b 93            	ldw	x,y
1571  040c fe            	ldw	x,(x)
1572  040d 89            	pushw	x
1573  040e 8d550155      	callf	f_detectZeroCross
1575  0412 5b0c          	addw	sp,#12
1576  0414 4d            	tnz	a
1577  0415 27a9          	jreq	L536
1578                     ; 185 			currentEdgeTime = micros();
1580  0417 8d000000      	callf	f_micros
1582  041b 96            	ldw	x,sp
1583  041c 1c0019        	addw	x,#OFST-4104
1584  041f 8d000000      	callf	d_rtol
1587                     ; 186 			if (lastEdgeTime > 0) {  // Zero-crossing detected; calculate period and frequency
1589  0423 ae0008        	ldw	x,#_lastEdgeTime
1590  0426 8d000000      	callf	d_lzmp
1592  042a 2604acca04ca  	jreq	L146
1593                     ; 187 				unsigned long period = currentEdgeTime - lastEdgeTime;  // Period in microseconds
1595  0430 96            	ldw	x,sp
1596  0431 1c0019        	addw	x,#OFST-4104
1597  0434 8d000000      	callf	d_ltor
1599  0438 ae0008        	ldw	x,#_lastEdgeTime
1600  043b 8d000000      	callf	d_lsub
1602  043f 96            	ldw	x,sp
1603  0440 1c0011        	addw	x,#OFST-4112
1604  0443 8d000000      	callf	d_rtol
1607                     ; 188 				float singleFrequency = calculate_frequency(period);   // Calculate frequency in Hz
1609  0447 1e13          	ldw	x,(OFST-4110,sp)
1610  0449 89            	pushw	x
1611  044a 1e13          	ldw	x,(OFST-4110,sp)
1612  044c 89            	pushw	x
1613  044d 8d090509      	callf	f_calculate_frequency
1615  0451 5b04          	addw	sp,#4
1616  0453 96            	ldw	x,sp
1617  0454 1c0011        	addw	x,#OFST-4112
1618  0457 8d000000      	callf	d_rtol
1621                     ; 190 				freqCount++;
1623  045b 1e1e          	ldw	x,(OFST-4099,sp)
1624  045d 5c            	incw	x
1625  045e 1f1e          	ldw	(OFST-4099,sp),x
1627                     ; 192 				if (freqCount == 2) {  // Stop after detecting 2 zero-crossings
1629  0460 a30002        	cpw	x,#2
1630  0463 2665          	jrne	L146
1631                     ; 193 					count = i;  // Limit used for amplitude calculation within this range
1633  0465 96            	ldw	x,sp
1634  0466 de1020        	ldw	x,(OFST-1,x)
1635  0469 bf12          	ldw	_count,x
1636                     ; 195 					*amplitude = calculate_amplitude(buffer, (freqCount > 0 ? count : NUM_SAMPLES));
1638  046b 9c            	rvf	
1639  046c 1e1e          	ldw	x,(OFST-4099,sp)
1640  046e 2d04          	jrsle	L461
1641  0470 be12          	ldw	x,_count
1642  0472 2003          	jra	L661
1643  0474               L461:
1644  0474 ae0400        	ldw	x,#1024
1645  0477               L661:
1646  0477 8d000000      	callf	d_uitolx
1648  047b be02          	ldw	x,c_lreg+2
1649  047d 89            	pushw	x
1650  047e be00          	ldw	x,c_lreg
1651  0480 89            	pushw	x
1652  0481 96            	ldw	x,sp
1653  0482 1c0024        	addw	x,#OFST-4093
1654  0485 8da502a5      	callf	f_calculate_amplitude
1656  0489 5b04          	addw	sp,#4
1657  048b 96            	ldw	x,sp
1658  048c de1028        	ldw	x,(OFST+7,x)
1659  048f 8d000000      	callf	d_rtol
1661                     ; 198 					if (isChannel1 && freqCount > 0) {
1663  0493 7b1d          	ld	a,(OFST-4100,sp)
1664  0495 2719          	jreq	L546
1666  0497 9c            	rvf	
1667  0498 1e1e          	ldw	x,(OFST-4099,sp)
1668  049a 2d14          	jrsle	L546
1669                     ; 199 						*frequency = singleFrequency;  // Calculate average frequency
1671  049c 96            	ldw	x,sp
1672  049d de1026        	ldw	x,(OFST+5,x)
1673  04a0 7b14          	ld	a,(OFST-4109,sp)
1674  04a2 e703          	ld	(3,x),a
1675  04a4 7b13          	ld	a,(OFST-4110,sp)
1676  04a6 e702          	ld	(2,x),a
1677  04a8 7b12          	ld	a,(OFST-4111,sp)
1678  04aa e701          	ld	(1,x),a
1679  04ac 7b11          	ld	a,(OFST-4112,sp)
1681  04ae 200f          	jpf	LC003
1682  04b0               L546:
1683                     ; 201 					else if (isChannel1) {
1685  04b0 7b1d          	ld	a,(OFST-4100,sp)
1686  04b2 270c          	jreq	L746
1687                     ; 202 						*frequency = 0;  // No crossings detected, return 0 frequency
1689  04b4 96            	ldw	x,sp
1690  04b5 de1026        	ldw	x,(OFST+5,x)
1691  04b8 4f            	clr	a
1692  04b9 e703          	ld	(3,x),a
1693  04bb e702          	ld	(2,x),a
1694  04bd e701          	ld	(1,x),a
1695  04bf               LC003:
1696  04bf f7            	ld	(x),a
1697  04c0               L746:
1698                     ; 204 					return *amplitude;
1700  04c0 96            	ldw	x,sp
1701  04c1 de1028        	ldw	x,(OFST+7,x)
1702  04c4 8d000000      	callf	d_ltor
1705  04c8 202b          	jra	L271
1706  04ca               L146:
1707                     ; 207 			lastEdgeTime = currentEdgeTime;  // Update last edge time
1709  04ca 1e1b          	ldw	x,(OFST-4102,sp)
1710  04cc bf0a          	ldw	_lastEdgeTime+2,x
1711  04ce 1e19          	ldw	x,(OFST-4104,sp)
1712  04d0 bf08          	ldw	_lastEdgeTime,x
1713  04d2               L536:
1714                     ; 212 	delay_us(1000000 / SAMPLE_RATE);
1716  04d2 ae1a0a        	ldw	x,#6666
1717  04d5 8d000000      	callf	f_delay_us
1719                     ; 178 	for (i = 0; i < NUM_SAMPLES; i++) {
1721  04d9 96            	ldw	x,sp
1722  04da 9093          	ldw	y,x
1723  04dc de1020        	ldw	x,(OFST-1,x)
1724  04df 5c            	incw	x
1725  04e0 90df1020      	ldw	(OFST-1,y),x
1728  04e4 96            	ldw	x,sp
1729  04e5 9093          	ldw	y,x
1730  04e7 90de1020      	ldw	y,(OFST-1,y)
1731  04eb 90a30400      	cpw	y,#1024
1732  04ef 2404ac9d039d  	jrult	L726
1733                     ; 227 }
1734  04f5               L271:
1737  04f5 9096          	ldw	y,sp
1738  04f7 72a91022      	addw	y,#4130
1739  04fb 9094          	ldw	sp,y
1740  04fd 87            	retf	
1774                     ; 230 float convert_adc_to_voltage(unsigned int adcValue) {
1775                     	switch	.text
1776  04fe               f_convert_adc_to_voltage:
1780                     ; 231 	return adcValue * (V_REF / ADC_MAX_VALUE);
1782  04fe 8d000000      	callf	d_uitof
1784  0502 ae10b1        	ldw	x,#L576
1788  0505 ac000000      	jpf	d_fmul
1822                     ; 235 float calculate_frequency(unsigned long period) {
1823                     	switch	.text
1824  0509               f_calculate_frequency:
1826  0509 5204          	subw	sp,#4
1827       00000004      OFST:	set	4
1830                     ; 236 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
1832  050b 96            	ldw	x,sp
1833  050c 1c0008        	addw	x,#OFST+4
1834  050f 8d000000      	callf	d_ltor
1836  0513 8d000000      	callf	d_ultof
1838  0517 ae10a9        	ldw	x,#L337
1839  051a 8d000000      	callf	d_fdiv
1841  051e 96            	ldw	x,sp
1842  051f 5c            	incw	x
1843  0520 8d000000      	callf	d_rtol
1846  0524 ae10ad        	ldw	x,#L327
1847  0527 8d000000      	callf	d_ltor
1849  052b 96            	ldw	x,sp
1850  052c 5c            	incw	x
1851  052d 8d000000      	callf	d_fdiv
1855  0531 5b04          	addw	sp,#4
1856  0533 87            	retf	
1919                     ; 240 void output_results(float frequency, float amplitude, float FDR_Voltage) {
1920                     	switch	.text
1921  0534               f_output_results:
1923  0534 5228          	subw	sp,#40
1924       00000028      OFST:	set	40
1927                     ; 246 	sprintf(buffer, "%.3f,%.3f,%.3f,%.3f\n", frequency, amplitude, amplitude/4.7, FDR_Voltage);
1929  0536 1e36          	ldw	x,(OFST+14,sp)
1930  0538 89            	pushw	x
1931  0539 1e36          	ldw	x,(OFST+14,sp)
1932  053b 89            	pushw	x
1933  053c 96            	ldw	x,sp
1934  053d 1c0034        	addw	x,#OFST+12
1935  0540 8d000000      	callf	d_ltor
1937  0544 ae1090        	ldw	x,#L777
1938  0547 8d000000      	callf	d_fdiv
1940  054b be02          	ldw	x,c_lreg+2
1941  054d 89            	pushw	x
1942  054e be00          	ldw	x,c_lreg
1943  0550 89            	pushw	x
1944  0551 1e3a          	ldw	x,(OFST+18,sp)
1945  0553 89            	pushw	x
1946  0554 1e3a          	ldw	x,(OFST+18,sp)
1947  0556 89            	pushw	x
1948  0557 1e3a          	ldw	x,(OFST+18,sp)
1949  0559 89            	pushw	x
1950  055a 1e3a          	ldw	x,(OFST+18,sp)
1951  055c 89            	pushw	x
1952  055d ae1094        	ldw	x,#L177
1953  0560 89            	pushw	x
1954  0561 96            	ldw	x,sp
1955  0562 1c0013        	addw	x,#OFST-21
1956  0565 8d000000      	callf	f_sprintf
1958  0569 5b12          	addw	sp,#18
1959                     ; 249 	printf("%s", buffer);
1961  056b 96            	ldw	x,sp
1962  056c 5c            	incw	x
1963  056d 89            	pushw	x
1964  056e ae108d        	ldw	x,#L3001
1965  0571 8d000000      	callf	f_printf
1967  0575 5b2a          	addw	sp,#42
1968                     ; 251 }
1971  0577 87            	retf	
2007                     ; 254 void send_square_pulse(uint16_t duration_ms) {
2008                     	switch	.text
2009  0578               f_send_square_pulse:
2011  0578 89            	pushw	x
2012       00000000      OFST:	set	0
2015                     ; 255 	GPIO_WriteHigh(GPIOC, GPIO_PIN_4); // Set square pulse pin high
2017  0579 4b10          	push	#16
2018  057b ae500a        	ldw	x,#20490
2019  057e 8d000000      	callf	f_GPIO_WriteHigh
2021  0582 84            	pop	a
2022                     ; 256 	delay_ms(duration_ms);            // Wait for the pulse duration
2024  0583 1e01          	ldw	x,(OFST+1,sp)
2025  0585 8d000000      	callf	f_delay_ms
2027                     ; 257 	GPIO_WriteLow(GPIOC, GPIO_PIN_4); // Set square pulse pin low
2029  0589 4b10          	push	#16
2030  058b ae500a        	ldw	x,#20490
2031  058e 8d000000      	callf	f_GPIO_WriteLow
2033                     ; 258 }
2036  0592 5b03          	addw	sp,#3
2037  0594 87            	retf	
2074                     ; 261 void send_pulse_commutation(uint16_t duration_ms) {
2075                     	switch	.text
2076  0595               f_send_pulse_commutation:
2078  0595 89            	pushw	x
2079       00000000      OFST:	set	0
2082                     ; 262 	GPIO_WriteHigh(GPIOC, GPIO_PIN_2); // Set square pulse pin high
2084  0596 4b04          	push	#4
2085  0598 ae500a        	ldw	x,#20490
2086  059b 8d000000      	callf	f_GPIO_WriteHigh
2088  059f 84            	pop	a
2089                     ; 263 	delay_ms(duration_ms);            // Wait for the pulse duration
2091  05a0 1e01          	ldw	x,(OFST+1,sp)
2092  05a2 8d000000      	callf	f_delay_ms
2094                     ; 264 	GPIO_WriteLow(GPIOC, GPIO_PIN_2); // Set square pulse pin low
2096  05a6 4b04          	push	#4
2097  05a8 ae500a        	ldw	x,#20490
2098  05ab 8d000000      	callf	f_GPIO_WriteLow
2100                     ; 265 }
2103  05af 5b03          	addw	sp,#3
2104  05b1 87            	retf	
2139                     ; 268 bool check_signal_dc(float amplitude) {
2140                     	switch	.text
2141  05b2               f_check_signal_dc:
2143       00000000      OFST:	set	0
2146                     ; 269 	if (amplitude < 1.5) {
2148  05b2 96            	ldw	x,sp
2149  05b3 1c0004        	addw	x,#OFST+4
2150  05b6 8d000000      	callf	d_ltor
2152  05ba ae1174        	ldw	x,#L531
2153  05bd 8d000000      	callf	d_fcmp
2155  05c1 2e07          	jrsge	L7501
2156                     ; 270 		isThyristorON = true;
2158  05c3 35010014      	mov	_isThyristorON,#1
2159                     ; 271 		return true;
2161  05c7 a601          	ld	a,#1
2164  05c9 87            	retf	
2165  05ca               L7501:
2166                     ; 273 		isThyristorON = false;
2168  05ca 3f14          	clr	_isThyristorON
2169                     ; 274 		return false;
2171  05cc 4f            	clr	a
2174  05cd 87            	retf	
2221                     ; 278 void configure_set_frequency(void) {
2222                     	switch	.text
2223  05ce               f_configure_set_frequency:
2225  05ce 5218          	subw	sp,#24
2226       00000018      OFST:	set	24
2229                     ; 280 		float new_frequency = 5.0; // Convert string to float
2231                     ; 281     printf("Enter new set frequency (0.3 - 5 Hz):\n");
2233  05d0 ae1066        	ldw	x,#L5011
2234  05d3 8d000000      	callf	f_printf
2236                     ; 283     UART3_ReceiveString(buffer, sizeof(buffer)); // Receive user input
2238  05d7 ae0014        	ldw	x,#20
2239  05da 89            	pushw	x
2240  05db 96            	ldw	x,sp
2241  05dc 1c0003        	addw	x,#OFST-21
2242  05df 8d000000      	callf	f_UART3_ReceiveString
2244  05e3 85            	popw	x
2245                     ; 284     new_frequency = atof(buffer); // Convert string to float
2247  05e4 96            	ldw	x,sp
2248  05e5 5c            	incw	x
2249  05e6 8d000000      	callf	f_atof
2251  05ea 96            	ldw	x,sp
2252  05eb 1c0015        	addw	x,#OFST-3
2253  05ee 8d000000      	callf	d_rtol
2256                     ; 287     if (new_frequency >= 0.3 && new_frequency <= 5.0) {
2258  05f2 96            	ldw	x,sp
2259  05f3 1c0015        	addw	x,#OFST-3
2260  05f6 8d000000      	callf	d_ltor
2262  05fa ae1062        	ldw	x,#L5111
2263  05fd 8d000000      	callf	d_fcmp
2265  0601 2f22          	jrslt	L7011
2267  0603 96            	ldw	x,sp
2268  0604 1c0015        	addw	x,#OFST-3
2269  0607 8d000000      	callf	d_ltor
2271  060b ae10b9        	ldw	x,#L764
2272  060e 8d000000      	callf	d_fcmp
2274  0612 2c11          	jrsgt	L7011
2275                     ; 289         printf("Set frequency updated to: %.2f Hz\n", new_frequency);
2277  0614 1e17          	ldw	x,(OFST-1,sp)
2278  0616 89            	pushw	x
2279  0617 1e17          	ldw	x,(OFST-1,sp)
2280  0619 89            	pushw	x
2281  061a ae103f        	ldw	x,#L1211
2282  061d 8d000000      	callf	f_printf
2284  0621 5b04          	addw	sp,#4
2286  0623 2007          	jra	L3211
2287  0625               L7011:
2288                     ; 291         printf("Invalid frequency. Please enter a value between 0.3 and 5 Hz.\n");
2290  0625 ae1000        	ldw	x,#L5211
2291  0628 8d000000      	callf	f_printf
2293  062c               L3211:
2294                     ; 293 }
2297  062c 5b18          	addw	sp,#24
2298  062e 87            	retf	
2310                     	xdef	f_main
2311                     	xdef	f_configure_set_frequency
2312                     	xdef	f_calculate_frequency
2313                     	xdef	f_convert_adc_to_voltage
2314                     	xdef	f_process_adc_signal
2315                     	xdef	f_calculate_amplitude
2316                     	xdef	f_output_results
2317                     	xdef	f_initialize_adc_buffer
2318                     	xdef	f_check_signal_dc
2319                     	xdef	f_send_pulse_commutation
2320                     	xdef	f_send_square_pulse
2321                     	xdef	f_check_negative_zero_crossing
2322                     	xdef	f_detect_negative_zero_cross
2323                     	xdef	f_detectZeroCross
2324                     	xdef	f_detectPosZeroCross
2325                     	xdef	f_initialize_system
2326                     	xdef	_isThyristorON
2327                     	xdef	_count
2328                     	xdef	_crossingType
2329                     	xdef	_currentEdgeTime
2330                     	xdef	_lastEdgeTime
2331                     	xdef	_sine1_amplitude
2332                     	xdef	_sine1_frequency
2333                     	xref	f_read_ADC_Channel
2334                     	xref	f_UART3_ReceiveString
2335                     	xref	f_GPIO_setup
2336                     	xref	f_ADC2_setup
2337                     	xref	f_UART3_setup
2338                     	xref	f_clock_setup
2339                     	xref	f_I2CInit
2340                     	xref	f_EEPROM_Config
2341                     	xref	f_micros
2342                     	xref	f_delay_us
2343                     	xref	f_delay_ms
2344                     	xref	f_TIM4_Config
2345                     	xref	f_atof
2346                     	xref	f_sprintf
2347                     	xref	f_printf
2348                     	xref	f_GPIO_WriteLow
2349                     	xref	f_GPIO_WriteHigh
2350                     	switch	.const
2351  1000               L5211:
2352  1000 496e76616c69  	dc.b	"Invalid frequency."
2353  1012 20506c656173  	dc.b	" Please enter a va"
2354  1024 6c7565206265  	dc.b	"lue between 0.3 an"
2355  1036 64203520487a  	dc.b	"d 5 Hz.",10,0
2356  103f               L1211:
2357  103f 536574206672  	dc.b	"Set frequency upda"
2358  1051 74656420746f  	dc.b	"ted to: %.2f Hz",10,0
2359  1062               L5111:
2360  1062 3e999999      	dc.w	16025,-26215
2361  1066               L5011:
2362  1066 456e74657220  	dc.b	"Enter new set freq"
2363  1078 75656e637920  	dc.b	"uency (0.3 - 5 Hz)"
2364  108a 3a0a00        	dc.b	":",10,0
2365  108d               L3001:
2366  108d 257300        	dc.b	"%s",0
2367  1090               L777:
2368  1090 40966666      	dc.w	16534,26214
2369  1094               L177:
2370  1094 252e33662c25  	dc.b	"%.3f,%.3f,%.3f,%.3"
2371  10a6 660a00        	dc.b	"f",10,0
2372  10a9               L337:
2373  10a9 49742400      	dc.w	18804,9216
2374  10ad               L327:
2375  10ad 3f800000      	dc.w	16256,0
2376  10b1               L576:
2377  10b1 3ba0280a      	dc.w	15264,10250
2378  10b5               L754:
2379  10b5 c0a00000      	dc.w	-16224,0
2380  10b9               L764:
2381  10b9 40a00000      	dc.w	16544,0
2382  10bd               L314:
2383  10bd 4e6567617469  	dc.b	"Negative zero cros"
2384  10cf 73696e672064  	dc.b	"sing detected!",10,0
2385  10df               L704:
2386  10df 40199999      	dc.w	16409,-26215
2387  10e3               L712:
2388  10e3 53797374656d  	dc.b	"System Initializat"
2389  10f5 696f6e20436f  	dc.b	"ion Completed",10
2390  1103 0d00          	dc.b	13,0
2391  1105               L502:
2392  1105 566172416d70  	dc.b	"VarAmplitude Not b"
2393  1117 656c6f772031  	dc.b	"elow 10 mv.",10,0
2394  1124               L102:
2395  1124 566172416d70  	dc.b	"VarAmplitude below"
2396  1136 203130206d76  	dc.b	" 10 mv.",10,0
2397  113f               L571:
2398  113f 3c23d70a      	dc.w	15395,-10486
2399  1143               L561:
2400  1143 5369676e616c  	dc.b	"Signal 1 AC and Va"
2401  1155 72416d706c69  	dc.b	"rAmplitude: %f.",10,0
2402  1166               L541:
2403  1166 5369676e616c  	dc.b	"Signal 1 DC.",10,0
2404  1174               L531:
2405  1174 3fc00000      	dc.w	16320,0
2406                     	xref.b	c_lreg
2407                     	xref.b	c_x
2408                     	xref.b	c_y
2428                     	xref	d_fdiv
2429                     	xref	d_ultof
2430                     	xref	d_fmul
2431                     	xref	d_uitof
2432                     	xref	d_uitolx
2433                     	xref	d_lsub
2434                     	xref	d_lzmp
2435                     	xref	d_xymovl
2436                     	xref	d_itof
2437                     	xref	d_fsub
2438                     	xref	d_lcmp
2439                     	xref	d_lgadc
2440                     	xref	d_fcmp
2441                     	xref	d_ltor
2442                     	xref	d_rtol
2443                     	end
