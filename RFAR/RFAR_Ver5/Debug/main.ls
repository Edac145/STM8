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
  27  0014               _isThyristorON:
  28  0014 00            	dc.b	0
 198                     ; 12 void main() {
 199                     	switch	.text
 200  0000               f_main:
 202  0000 5210          	subw	sp,#16
 203       00000010      OFST:	set	16
 206                     ; 14 	float VAR_frequency = 0, VAR_amplitude = 0;
 208  0002 ae0000        	ldw	x,#0
 209  0005 1f07          	ldw	(OFST-9,sp),x
 210  0007 ae0000        	ldw	x,#0
 211  000a 1f05          	ldw	(OFST-11,sp),x
 215  000c ae0000        	ldw	x,#0
 216  000f 1f0f          	ldw	(OFST-1,sp),x
 217  0011 ae0000        	ldw	x,#0
 218  0014 1f0d          	ldw	(OFST-3,sp),x
 220                     ; 15 	float FDR_amplitude = 0;
 222  0016 ae0000        	ldw	x,#0
 223  0019 1f0b          	ldw	(OFST-5,sp),x
 224  001b ae0000        	ldw	x,#0
 225  001e 1f09          	ldw	(OFST-7,sp),x
 227                     ; 17 	initialize_system();  
 229  0020 8d590159      	callf	f_initialize_system
 231                     ; 19 	FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
 233  0024 96            	ldw	x,sp
 234  0025 1c0009        	addw	x,#OFST-7
 235  0028 89            	pushw	x
 236  0029 5f            	clrw	x
 237  002a 89            	pushw	x
 238  002b a606          	ld	a,#6
 239  002d 8dc003c0      	callf	f_process_adc_signal
 241  0031 5b04          	addw	sp,#4
 242  0033 96            	ldw	x,sp
 243  0034 1c0009        	addw	x,#OFST-7
 244  0037 8d000000      	callf	d_rtol
 247                     ; 21 	if (FDR_amplitude > 0) {  // Voltage detected on Signal 2
 249  003b 9c            	rvf
 250  003c 9c            	rvf
 251  003d 0d09          	tnz	(OFST-7,sp)
 252  003f 2c04          	jrsgt	L6
 253  0041 ac560156      	jpf	L511
 254  0045               L6:
 255                     ; 22     GPIO_WriteHigh(GPIOC, GPIO_PIN_3);  // Turn on LED
 257  0045 4b08          	push	#8
 258  0047 ae500a        	ldw	x,#20490
 259  004a 8d000000      	callf	f_GPIO_WriteHigh
 261  004e 84            	pop	a
 262  004f               L711:
 263                     ; 25     VAR_amplitude = process_adc_signal(VAR_SIGNAL, &VAR_frequency, &VAR_amplitude);
 265  004f 96            	ldw	x,sp
 266  0050 1c000d        	addw	x,#OFST-3
 267  0053 89            	pushw	x
 268  0054 96            	ldw	x,sp
 269  0055 1c0007        	addw	x,#OFST-9
 270  0058 89            	pushw	x
 271  0059 a605          	ld	a,#5
 272  005b 8dc003c0      	callf	f_process_adc_signal
 274  005f 5b04          	addw	sp,#4
 275  0061 96            	ldw	x,sp
 276  0062 1c000d        	addw	x,#OFST-3
 277  0065 8d000000      	callf	d_rtol
 280                     ; 26 		printf("Signal 1 Frequency: %.2f Hz, Amplitude: %.2f V\n", VAR_frequency, VAR_amplitude);
 282  0069 1e0f          	ldw	x,(OFST-1,sp)
 283  006b 89            	pushw	x
 284  006c 1e0f          	ldw	x,(OFST-1,sp)
 285  006e 89            	pushw	x
 286  006f 1e0b          	ldw	x,(OFST-5,sp)
 287  0071 89            	pushw	x
 288  0072 1e0b          	ldw	x,(OFST-5,sp)
 289  0074 89            	pushw	x
 290  0075 ae1124        	ldw	x,#L321
 291  0078 8d000000      	callf	f_printf
 293  007c 5b08          	addw	sp,#8
 294                     ; 28     if (VAR_frequency <= SET_FREQ){
 296  007e 9c            	rvf
 297  007f a605          	ld	a,#5
 298  0081 8d000000      	callf	d_ctof
 300  0085 96            	ldw	x,sp
 301  0086 1c0001        	addw	x,#OFST-15
 302  0089 8d000000      	callf	d_rtol
 305  008d 96            	ldw	x,sp
 306  008e 1c0005        	addw	x,#OFST-11
 307  0091 8d000000      	callf	d_ltor
 309  0095 96            	ldw	x,sp
 310  0096 1c0001        	addw	x,#OFST-15
 311  0099 8d000000      	callf	d_fcmp
 313  009d 2d04          	jrsle	L01
 314  009f ac4b014b      	jpf	L521
 315  00a3               L01:
 316                     ; 30 			if(check_negative_zero_crossing()){     // Wait for negative zero crossing
 318  00a3 8da402a4      	callf	f_check_negative_zero_crossing
 320  00a7 4d            	tnz	a
 321  00a8 27a5          	jreq	L711
 322                     ; 31 				send_square_pulse(5); 
 324  00aa ae0005        	ldw	x,#5
 325  00ad 8d120612      	callf	f_send_square_pulse
 327  00b1               L75:
 328                     ; 32 				FDR_Sampling:                         // LABEL for goto
 328                     ; 33 				VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
 330  00b1 96            	ldw	x,sp
 331  00b2 1c000d        	addw	x,#OFST-3
 332  00b5 89            	pushw	x
 333  00b6 5f            	clrw	x
 334  00b7 89            	pushw	x
 335  00b8 a605          	ld	a,#5
 336  00ba 8dc003c0      	callf	f_process_adc_signal
 338  00be 5b04          	addw	sp,#4
 339  00c0 96            	ldw	x,sp
 340  00c1 1c000d        	addw	x,#OFST-3
 341  00c4 8d000000      	callf	d_rtol
 344                     ; 35 				if(check_signal_dc(VAR_amplitude)){
 346  00c8 1e0f          	ldw	x,(OFST-1,sp)
 347  00ca 89            	pushw	x
 348  00cb 1e0f          	ldw	x,(OFST-1,sp)
 349  00cd 89            	pushw	x
 350  00ce 8d2f062f      	callf	f_check_signal_dc
 352  00d2 5b04          	addw	sp,#4
 353  00d4 4d            	tnz	a
 354  00d5 2738          	jreq	L131
 355                     ; 36 					GPIO_WriteHigh(GPIOA, GPIO_PIN_1);  // Turn on LED if Signal is DC
 357  00d7 4b02          	push	#2
 358  00d9 ae5000        	ldw	x,#20480
 359  00dc 8d000000      	callf	f_GPIO_WriteHigh
 361  00e0 84            	pop	a
 362                     ; 37 					FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
 364  00e1 96            	ldw	x,sp
 365  00e2 1c0009        	addw	x,#OFST-7
 366  00e5 89            	pushw	x
 367  00e6 5f            	clrw	x
 368  00e7 89            	pushw	x
 369  00e8 a606          	ld	a,#6
 370  00ea 8dc003c0      	callf	f_process_adc_signal
 372  00ee 5b04          	addw	sp,#4
 373  00f0 96            	ldw	x,sp
 374  00f1 1c0009        	addw	x,#OFST-7
 375  00f4 8d000000      	callf	d_rtol
 378                     ; 39 					if(isThyristorON){
 380  00f8 3d14          	tnz	_isThyristorON
 381  00fa 27b5          	jreq	L75
 382                     ; 40 						send_square_pulse(3000);
 384  00fc ae0bb8        	ldw	x,#3000
 385  00ff 8d120612      	callf	f_send_square_pulse
 387                     ; 41 						GPIO_WriteHigh(GPIOA, GPIO_PIN_1);  // Turn on LED ORANGE
 389  0103 4b02          	push	#2
 390  0105 ae5000        	ldw	x,#20480
 391  0108 8d000000      	callf	f_GPIO_WriteHigh
 393  010c 84            	pop	a
 394                     ; 42 						goto FDR_Sampling;
 396  010d 20a2          	jra	L75
 397  010f               L131:
 398                     ; 50 					if (VAR_amplitude < AC_AMPLITUDE_THRESHOLD) {
 400  010f 9c            	rvf
 401  0110 96            	ldw	x,sp
 402  0111 1c000d        	addw	x,#OFST-3
 403  0114 8d000000      	callf	d_ltor
 405  0118 ae1120        	ldw	x,#L741
 406  011b 8d000000      	callf	d_fcmp
 408  011f 2e1c          	jrsge	L141
 409                     ; 51 						GPIO_WriteHigh(GPIOB, GPIO_PIN_2);  // Turn on LED if Signal is AC < 20 mV
 411  0121 4b04          	push	#4
 412  0123 ae5005        	ldw	x,#20485
 413  0126 8d000000      	callf	f_GPIO_WriteHigh
 415  012a 84            	pop	a
 416                     ; 52 						delay_ms(3000);
 418  012b ae0bb8        	ldw	x,#3000
 419  012e 8d000000      	callf	f_delay_ms
 421                     ; 53 						send_square_pulse(5);
 423  0132 ae0005        	ldw	x,#5
 424  0135 8d120612      	callf	f_send_square_pulse
 427  0139 ac4f004f      	jpf	L711
 428  013d               L141:
 429                     ; 56 						GPIO_WriteHigh(GPIOB, GPIO_PIN_2);  // Turn on LED if Signal is AC < 20 mV
 431  013d 4b04          	push	#4
 432  013f ae5005        	ldw	x,#20485
 433  0142 8d000000      	callf	f_GPIO_WriteHigh
 435  0146 84            	pop	a
 436  0147 ac4f004f      	jpf	L711
 437  014b               L521:
 438                     ; 65 			printf("Frequency above set Frequency.\n");
 440  014b ae1100        	ldw	x,#L751
 441  014e 8d000000      	callf	f_printf
 443  0152 ac4f004f      	jpf	L711
 444  0156               L511:
 445                     ; 72 }
 448  0156 5b10          	addw	sp,#16
 449  0158 87            	retf
 480                     ; 75 void initialize_system(void) {
 481                     	switch	.text
 482  0159               f_initialize_system:
 486                     ; 76 	clock_setup();          // Configure system clock
 488  0159 8d000000      	callf	f_clock_setup
 490                     ; 77 	TIM4_Config();          // Timer 4 config for delay
 492  015d 8d000000      	callf	f_TIM4_Config
 494                     ; 78 	UART3_setup();          // Setup UART communication
 496  0161 8d000000      	callf	f_UART3_setup
 498                     ; 79 	ADC2_setup();           // Setup ADC
 500  0165 8d000000      	callf	f_ADC2_setup
 502                     ; 80 	EEPROM_Config();        // Configuring EEPROM
 504  0169 8d000000      	callf	f_EEPROM_Config
 506                     ; 81 	I2CInit();
 508  016d 8d000000      	callf	f_I2CInit
 510                     ; 82 	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
 512  0171 ae500a        	ldw	x,#20490
 513  0174 8d000000      	callf	f_GPIO_DeInit
 515                     ; 83 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 517  0178 4be0          	push	#224
 518  017a 4b08          	push	#8
 519  017c ae500a        	ldw	x,#20490
 520  017f 8d000000      	callf	f_GPIO_Init
 522  0183 85            	popw	x
 523                     ; 84 	printf("System Initialization Completed\n\r");
 525  0184 ae10de        	ldw	x,#L171
 526  0187 8d000000      	callf	f_printf
 528                     ; 85 }
 531  018b 87            	retf
 604                     ; 88 bool detectZeroCross(float previousSample, float currentSample, float threshold) {
 605                     	switch	.text
 606  018c               f_detectZeroCross:
 608       00000000      OFST:	set	0
 611                     ; 89 	if (crossingType == -1) {  // If no crossing type detected, check for both positive and negative
 613  018c be10          	ldw	x,_crossingType
 614  018e a3ffff        	cpw	x,#65535
 615  0191 265a          	jrne	L132
 616                     ; 90 		if (previousSample <= threshold && currentSample > threshold) {
 618  0193 9c            	rvf
 619  0194 96            	ldw	x,sp
 620  0195 1c0004        	addw	x,#OFST+4
 621  0198 8d000000      	callf	d_ltor
 623  019c 96            	ldw	x,sp
 624  019d 1c000c        	addw	x,#OFST+12
 625  01a0 8d000000      	callf	d_fcmp
 627  01a4 2c19          	jrsgt	L332
 629  01a6 9c            	rvf
 630  01a7 96            	ldw	x,sp
 631  01a8 1c0008        	addw	x,#OFST+8
 632  01ab 8d000000      	callf	d_ltor
 634  01af 96            	ldw	x,sp
 635  01b0 1c000c        	addw	x,#OFST+12
 636  01b3 8d000000      	callf	d_fcmp
 638  01b7 2d06          	jrsle	L332
 639                     ; 91 			crossingType = 0;  // Positive zero crossing
 641  01b9 5f            	clrw	x
 642  01ba bf10          	ldw	_crossingType,x
 643                     ; 92 			return true;
 645  01bc a601          	ld	a,#1
 648  01be 87            	retf
 649  01bf               L332:
 650                     ; 93 		} else if (previousSample >= threshold && currentSample < threshold) {
 652  01bf 9c            	rvf
 653  01c0 96            	ldw	x,sp
 654  01c1 1c0004        	addw	x,#OFST+4
 655  01c4 8d000000      	callf	d_ltor
 657  01c8 96            	ldw	x,sp
 658  01c9 1c000c        	addw	x,#OFST+12
 659  01cc 8d000000      	callf	d_fcmp
 661  01d0 2f78          	jrslt	L142
 663  01d2 9c            	rvf
 664  01d3 96            	ldw	x,sp
 665  01d4 1c0008        	addw	x,#OFST+8
 666  01d7 8d000000      	callf	d_ltor
 668  01db 96            	ldw	x,sp
 669  01dc 1c000c        	addw	x,#OFST+12
 670  01df 8d000000      	callf	d_fcmp
 672  01e3 2e65          	jrsge	L142
 673                     ; 94 			crossingType = 1;  // Negative zero crossing
 675  01e5 ae0001        	ldw	x,#1
 676  01e8 bf10          	ldw	_crossingType,x
 677                     ; 95 			return true;
 679  01ea a601          	ld	a,#1
 682  01ec 87            	retf
 683  01ed               L132:
 684                     ; 97 	} else if (crossingType == 0 && previousSample <= threshold && currentSample > threshold) {
 686  01ed be10          	ldw	x,_crossingType
 687  01ef 2629          	jrne	L342
 689  01f1 9c            	rvf
 690  01f2 96            	ldw	x,sp
 691  01f3 1c0004        	addw	x,#OFST+4
 692  01f6 8d000000      	callf	d_ltor
 694  01fa 96            	ldw	x,sp
 695  01fb 1c000c        	addw	x,#OFST+12
 696  01fe 8d000000      	callf	d_fcmp
 698  0202 2c16          	jrsgt	L342
 700  0204 9c            	rvf
 701  0205 96            	ldw	x,sp
 702  0206 1c0008        	addw	x,#OFST+8
 703  0209 8d000000      	callf	d_ltor
 705  020d 96            	ldw	x,sp
 706  020e 1c000c        	addw	x,#OFST+12
 707  0211 8d000000      	callf	d_fcmp
 709  0215 2d03          	jrsle	L342
 710                     ; 98 			return true;  // Positive zero crossing
 712  0217 a601          	ld	a,#1
 715  0219 87            	retf
 716  021a               L342:
 717                     ; 99 	} else if (crossingType == 1 && previousSample >= threshold && currentSample < threshold) {
 719  021a be10          	ldw	x,_crossingType
 720  021c a30001        	cpw	x,#1
 721  021f 2629          	jrne	L142
 723  0221 9c            	rvf
 724  0222 96            	ldw	x,sp
 725  0223 1c0004        	addw	x,#OFST+4
 726  0226 8d000000      	callf	d_ltor
 728  022a 96            	ldw	x,sp
 729  022b 1c000c        	addw	x,#OFST+12
 730  022e 8d000000      	callf	d_fcmp
 732  0232 2f16          	jrslt	L142
 734  0234 9c            	rvf
 735  0235 96            	ldw	x,sp
 736  0236 1c0008        	addw	x,#OFST+8
 737  0239 8d000000      	callf	d_ltor
 739  023d 96            	ldw	x,sp
 740  023e 1c000c        	addw	x,#OFST+12
 741  0241 8d000000      	callf	d_fcmp
 743  0245 2e03          	jrsge	L142
 744                     ; 100 			return true;  // Negative zero crossing
 746  0247 a601          	ld	a,#1
 749  0249 87            	retf
 750  024a               L142:
 751                     ; 103 	return false;  // No zero crossing detected
 753  024a 4f            	clr	a
 756  024b 87            	retf
 808                     ; 107 bool detectPosZeroCross(float previousSample, float currentSample, float threshold) {
 809                     	switch	.text
 810  024c               f_detectPosZeroCross:
 812       00000000      OFST:	set	0
 815                     ; 108 	return (previousSample <= threshold && currentSample > threshold);
 817  024c 9c            	rvf
 818  024d 96            	ldw	x,sp
 819  024e 1c0004        	addw	x,#OFST+4
 820  0251 8d000000      	callf	d_ltor
 822  0255 96            	ldw	x,sp
 823  0256 1c000c        	addw	x,#OFST+12
 824  0259 8d000000      	callf	d_fcmp
 826  025d 2c17          	jrsgt	L02
 827  025f 9c            	rvf
 828  0260 96            	ldw	x,sp
 829  0261 1c0008        	addw	x,#OFST+8
 830  0264 8d000000      	callf	d_ltor
 832  0268 96            	ldw	x,sp
 833  0269 1c000c        	addw	x,#OFST+12
 834  026c 8d000000      	callf	d_fcmp
 836  0270 2d04          	jrsle	L02
 837  0272 a601          	ld	a,#1
 838  0274 2001          	jra	L22
 839  0276               L02:
 840  0276 4f            	clr	a
 841  0277               L22:
 844  0277 87            	retf
 897                     ; 112 bool detect_negative_zero_cross(float previous_sample, float current_sample, float threshold) {
 898                     	switch	.text
 899  0278               f_detect_negative_zero_cross:
 901       00000000      OFST:	set	0
 904                     ; 113     return (previous_sample > threshold && current_sample <= threshold);
 906  0278 9c            	rvf
 907  0279 96            	ldw	x,sp
 908  027a 1c0004        	addw	x,#OFST+4
 909  027d 8d000000      	callf	d_ltor
 911  0281 96            	ldw	x,sp
 912  0282 1c000c        	addw	x,#OFST+12
 913  0285 8d000000      	callf	d_fcmp
 915  0289 2d17          	jrsle	L62
 916  028b 9c            	rvf
 917  028c 96            	ldw	x,sp
 918  028d 1c0008        	addw	x,#OFST+8
 919  0290 8d000000      	callf	d_ltor
 921  0294 96            	ldw	x,sp
 922  0295 1c000c        	addw	x,#OFST+12
 923  0298 8d000000      	callf	d_fcmp
 925  029c 2c04          	jrsgt	L62
 926  029e a601          	ld	a,#1
 927  02a0 2001          	jra	L03
 928  02a2               L62:
 929  02a2 4f            	clr	a
 930  02a3               L03:
 933  02a3 87            	retf
 981                     ; 116 bool check_negative_zero_crossing(void) {
 982                     	switch	.text
 983  02a4               f_check_negative_zero_crossing:
 985  02a4 5208          	subw	sp,#8
 986       00000008      OFST:	set	8
 989                     ; 117 	float prev_adc_value = 0;  // Store previous ADC sample value
 991  02a6 ae0000        	ldw	x,#0
 992  02a9 1f03          	ldw	(OFST-5,sp),x
 993  02ab ae0000        	ldw	x,#0
 994  02ae 1f01          	ldw	(OFST-7,sp),x
 996                     ; 118 	float current_adc_value = 0;  // Store current ADC sample value
 998  02b0               L743:
 999                     ; 122 		current_adc_value = convert_adc_to_voltage(read_ADC_Channel(VAR_SIGNAL));
1001  02b0 a605          	ld	a,#5
1002  02b2 8d000000      	callf	f_read_ADC_Channel
1004  02b6 8da505a5      	callf	f_convert_adc_to_voltage
1006  02ba 96            	ldw	x,sp
1007  02bb 1c0005        	addw	x,#OFST-3
1008  02be 8d000000      	callf	d_rtol
1011                     ; 124 		if (detect_negative_zero_cross(prev_adc_value, current_adc_value, ZEROCROSS_THRESHOLD)) {
1013  02c2 ce10dc        	ldw	x,L163+2
1014  02c5 89            	pushw	x
1015  02c6 ce10da        	ldw	x,L163
1016  02c9 89            	pushw	x
1017  02ca 1e0b          	ldw	x,(OFST+3,sp)
1018  02cc 89            	pushw	x
1019  02cd 1e0b          	ldw	x,(OFST+3,sp)
1020  02cf 89            	pushw	x
1021  02d0 1e0b          	ldw	x,(OFST+3,sp)
1022  02d2 89            	pushw	x
1023  02d3 1e0b          	ldw	x,(OFST+3,sp)
1024  02d5 89            	pushw	x
1025  02d6 8d780278      	callf	f_detect_negative_zero_cross
1027  02da 5b0c          	addw	sp,#12
1028  02dc 4d            	tnz	a
1029  02dd 270c          	jreq	L353
1030                     ; 125 			printf("Negative zero crossing detected!\n");
1032  02df ae10b8        	ldw	x,#L563
1033  02e2 8d000000      	callf	f_printf
1035                     ; 126 			return true;
1037  02e6 a601          	ld	a,#1
1040  02e8 5b08          	addw	sp,#8
1041  02ea 87            	retf
1042  02eb               L353:
1043                     ; 129 		prev_adc_value = current_adc_value;
1045  02eb 1e07          	ldw	x,(OFST-1,sp)
1046  02ed 1f03          	ldw	(OFST-5,sp),x
1047  02ef 1e05          	ldw	x,(OFST-3,sp)
1048  02f1 1f01          	ldw	(OFST-7,sp),x
1051  02f3 20bb          	jra	L743
1122                     ; 135 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
1123                     	switch	.text
1124  02f5               f_calculate_amplitude:
1126  02f5 89            	pushw	x
1127  02f6 520c          	subw	sp,#12
1128       0000000c      OFST:	set	12
1131                     ; 136 	uint32_t i = 0;
1133                     ; 137 	float max_val = -V_REF, min_val = V_REF;
1135  02f8 ce10b2        	ldw	x,L134+2
1136  02fb 1f03          	ldw	(OFST-9,sp),x
1137  02fd ce10b0        	ldw	x,L134
1138  0300 1f01          	ldw	(OFST-11,sp),x
1142  0302 ce10b6        	ldw	x,L144+2
1143  0305 1f07          	ldw	(OFST-5,sp),x
1144  0307 ce10b4        	ldw	x,L144
1145  030a 1f05          	ldw	(OFST-7,sp),x
1147                     ; 139 	for (i = 0; i < sample_size; i++) {
1149  030c ae0000        	ldw	x,#0
1150  030f 1f0b          	ldw	(OFST-1,sp),x
1151  0311 ae0000        	ldw	x,#0
1152  0314 1f09          	ldw	(OFST-3,sp),x
1155  0316 2058          	jra	L154
1156  0318               L544:
1157                     ; 140 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1159  0318 9c            	rvf
1160  0319 1e0b          	ldw	x,(OFST-1,sp)
1161  031b 58            	sllw	x
1162  031c 58            	sllw	x
1163  031d 72fb0d        	addw	x,(OFST+1,sp)
1164  0320 8d000000      	callf	d_ltor
1166  0324 96            	ldw	x,sp
1167  0325 1c0001        	addw	x,#OFST-11
1168  0328 8d000000      	callf	d_fcmp
1170  032c 2d11          	jrsle	L554
1173  032e 1e0b          	ldw	x,(OFST-1,sp)
1174  0330 58            	sllw	x
1175  0331 58            	sllw	x
1176  0332 72fb0d        	addw	x,(OFST+1,sp)
1177  0335 9093          	ldw	y,x
1178  0337 ee02          	ldw	x,(2,x)
1179  0339 1f03          	ldw	(OFST-9,sp),x
1180  033b 93            	ldw	x,y
1181  033c fe            	ldw	x,(x)
1182  033d 1f01          	ldw	(OFST-11,sp),x
1184  033f               L554:
1185                     ; 141 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1187  033f 9c            	rvf
1188  0340 1e0b          	ldw	x,(OFST-1,sp)
1189  0342 58            	sllw	x
1190  0343 58            	sllw	x
1191  0344 72fb0d        	addw	x,(OFST+1,sp)
1192  0347 8d000000      	callf	d_ltor
1194  034b 96            	ldw	x,sp
1195  034c 1c0005        	addw	x,#OFST-7
1196  034f 8d000000      	callf	d_fcmp
1198  0353 2e11          	jrsge	L754
1201  0355 1e0b          	ldw	x,(OFST-1,sp)
1202  0357 58            	sllw	x
1203  0358 58            	sllw	x
1204  0359 72fb0d        	addw	x,(OFST+1,sp)
1205  035c 9093          	ldw	y,x
1206  035e ee02          	ldw	x,(2,x)
1207  0360 1f07          	ldw	(OFST-5,sp),x
1208  0362 93            	ldw	x,y
1209  0363 fe            	ldw	x,(x)
1210  0364 1f05          	ldw	(OFST-7,sp),x
1212  0366               L754:
1213                     ; 139 	for (i = 0; i < sample_size; i++) {
1215  0366 96            	ldw	x,sp
1216  0367 1c0009        	addw	x,#OFST-3
1217  036a a601          	ld	a,#1
1218  036c 8d000000      	callf	d_lgadc
1221  0370               L154:
1224  0370 96            	ldw	x,sp
1225  0371 1c0009        	addw	x,#OFST-3
1226  0374 8d000000      	callf	d_ltor
1228  0378 96            	ldw	x,sp
1229  0379 1c0012        	addw	x,#OFST+6
1230  037c 8d000000      	callf	d_lcmp
1232  0380 2596          	jrult	L544
1233                     ; 143 	return (max_val - min_val);
1235  0382 96            	ldw	x,sp
1236  0383 1c0001        	addw	x,#OFST-11
1237  0386 8d000000      	callf	d_ltor
1239  038a 96            	ldw	x,sp
1240  038b 1c0005        	addw	x,#OFST-7
1241  038e 8d000000      	callf	d_fsub
1245  0392 5b0e          	addw	sp,#14
1246  0394 87            	retf
1290                     ; 147 void initialize_adc_buffer(float buffer[]) {
1291                     	switch	.text
1292  0395               f_initialize_adc_buffer:
1294  0395 89            	pushw	x
1295  0396 89            	pushw	x
1296       00000002      OFST:	set	2
1299                     ; 148 	uint16_t i = 0;
1301                     ; 149 	for (i = 0; i < NUM_SAMPLES; i++) {
1303  0397 5f            	clrw	x
1304  0398 1f01          	ldw	(OFST-1,sp),x
1306  039a               L305:
1307                     ; 150 		buffer[i] = -1;  // Reset each element of the ADC buffer
1309  039a 1e01          	ldw	x,(OFST-1,sp)
1310  039c 58            	sllw	x
1311  039d 58            	sllw	x
1312  039e 72fb03        	addw	x,(OFST+1,sp)
1313  03a1 90aeffff      	ldw	y,#65535
1314  03a5 51            	exgw	x,y
1315  03a6 8d000000      	callf	d_itof
1317  03aa 51            	exgw	x,y
1318  03ab 8d000000      	callf	d_rtol
1320                     ; 149 	for (i = 0; i < NUM_SAMPLES; i++) {
1322  03af 1e01          	ldw	x,(OFST-1,sp)
1323  03b1 1c0001        	addw	x,#1
1324  03b4 1f01          	ldw	(OFST-1,sp),x
1328  03b6 1e01          	ldw	x,(OFST-1,sp)
1329  03b8 a30400        	cpw	x,#1024
1330  03bb 25dd          	jrult	L305
1331                     ; 152 }
1334  03bd 5b04          	addw	sp,#4
1335  03bf 87            	retf
1337                     .const:	section	.text
1338  0000               L115_buffer:
1339  0000 00000000      	dc.w	0,0
1340  0004 000000000000  	ds.b	4092
1476                     ; 154 float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
1477                     	switch	.text
1478  03c0               f_process_adc_signal:
1480  03c0 88            	push	a
1481  03c1 96            	ldw	x,sp
1482  03c2 1d1021        	subw	x,#4129
1483  03c5 94            	ldw	sp,x
1484       00001021      OFST:	set	4129
1487                     ; 155 	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
1489  03c6 96            	ldw	x,sp
1490  03c7 1c0020        	addw	x,#OFST-4097
1491  03ca 90ae0000      	ldw	y,#L115_buffer
1492  03ce bf00          	ldw	c_x,x
1493  03d0 ae1000        	ldw	x,#4096
1494  03d3 8d000000      	callf	d_xymovl
1496                     ; 156 	unsigned long currentEdgeTime = 0;
1498                     ; 157 	float freqBuff = 0;
1500  03d7 ae0000        	ldw	x,#0
1501  03da 1f17          	ldw	(OFST-4106,sp),x
1502  03dc ae0000        	ldw	x,#0
1503  03df 1f15          	ldw	(OFST-4108,sp),x
1505                     ; 158 	int freqCount = 0;
1507  03e1 5f            	clrw	x
1508  03e2 1f1e          	ldw	(OFST-4099,sp),x
1510                     ; 159 	uint16_t i = 0;
1512                     ; 160 	bool isChannel1 = (channel == VAR_SIGNAL);  // Check if the channel is for Signal 1 or Signal 2
1514  03e4 96            	ldw	x,sp
1515  03e5 d61022        	ld	a,(OFST+1,x)
1516  03e8 a105          	cp	a,#5
1517  03ea 2605          	jrne	L24
1518  03ec ae0001        	ldw	x,#1
1519  03ef 2001          	jra	L44
1520  03f1               L24:
1521  03f1 5f            	clrw	x
1522  03f2               L44:
1523  03f2 01            	rrwa	x,a
1524  03f3 6b19          	ld	(OFST-4104,sp),a
1525  03f5 02            	rlwa	x,a
1527                     ; 161 	lastEdgeTime = 0;                 // Reset last zero-crossing time
1529  03f6 ae0000        	ldw	x,#0
1530  03f9 bf0a          	ldw	_lastEdgeTime+2,x
1531  03fb ae0000        	ldw	x,#0
1532  03fe bf08          	ldw	_lastEdgeTime,x
1533                     ; 163 	initialize_adc_buffer(buffer);
1535  0400 96            	ldw	x,sp
1536  0401 1c0020        	addw	x,#OFST-4097
1537  0404 8d950395      	callf	f_initialize_adc_buffer
1539                     ; 166 	for (i = 0; i < NUM_SAMPLES; i++) {
1541  0408 96            	ldw	x,sp
1542  0409 905f          	clrw	y
1543  040b df1020        	ldw	(OFST-1,x),y
1544  040e               L106:
1545                     ; 168 	buffer[i] = convert_adc_to_voltage(read_ADC_Channel(channel));
1547  040e 96            	ldw	x,sp
1548  040f d61022        	ld	a,(OFST+1,x)
1549  0412 8d000000      	callf	f_read_ADC_Channel
1551  0416 8da505a5      	callf	f_convert_adc_to_voltage
1553  041a 96            	ldw	x,sp
1554  041b 1c0020        	addw	x,#OFST-4097
1555  041e 1f0f          	ldw	(OFST-4114,sp),x
1557  0420 96            	ldw	x,sp
1558  0421 de1020        	ldw	x,(OFST-1,x)
1559  0424 58            	sllw	x
1560  0425 58            	sllw	x
1561  0426 72fb0f        	addw	x,(OFST-4114,sp)
1562  0429 8d000000      	callf	d_rtol
1564                     ; 170 	if (isChannel1 && (frequency != NULL)) { // Only calculate frequency for Signal 1 (Channel 1)
1566  042d 0d19          	tnz	(OFST-4104,sp)
1567  042f 2604          	jrne	L25
1568  0431 acff04ff      	jpf	L706
1569  0435               L25:
1571  0435 96            	ldw	x,sp
1572  0436 d61027        	ld	a,(OFST+6,x)
1573  0439 da1026        	or	a,(OFST+5,x)
1574  043c 2604          	jrne	L45
1575  043e acff04ff      	jpf	L706
1576  0442               L45:
1577                     ; 172 		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
1579  0442 96            	ldw	x,sp
1580  0443 d61021        	ld	a,(OFST+0,x)
1581  0446 da1020        	or	a,(OFST-1,x)
1582  0449 2604          	jrne	L65
1583  044b acff04ff      	jpf	L706
1584  044f               L65:
1586  044f ce10dc        	ldw	x,L163+2
1587  0452 89            	pushw	x
1588  0453 ce10da        	ldw	x,L163
1589  0456 89            	pushw	x
1590  0457 96            	ldw	x,sp
1591  0458 1c0024        	addw	x,#OFST-4093
1592  045b 1f13          	ldw	(OFST-4110,sp),x
1594  045d 96            	ldw	x,sp
1595  045e de1024        	ldw	x,(OFST+3,x)
1596  0461 58            	sllw	x
1597  0462 58            	sllw	x
1598  0463 72fb13        	addw	x,(OFST-4110,sp)
1599  0466 9093          	ldw	y,x
1600  0468 ee02          	ldw	x,(2,x)
1601  046a 89            	pushw	x
1602  046b 93            	ldw	x,y
1603  046c fe            	ldw	x,(x)
1604  046d 89            	pushw	x
1605  046e 96            	ldw	x,sp
1606  046f 1c0028        	addw	x,#OFST-4089
1607  0472 1f15          	ldw	(OFST-4108,sp),x
1609  0474 96            	ldw	x,sp
1610  0475 de1028        	ldw	x,(OFST+7,x)
1611  0478 58            	sllw	x
1612  0479 58            	sllw	x
1613  047a 1d0004        	subw	x,#4
1614  047d 72fb15        	addw	x,(OFST-4108,sp)
1615  0480 9093          	ldw	y,x
1616  0482 ee02          	ldw	x,(2,x)
1617  0484 89            	pushw	x
1618  0485 93            	ldw	x,y
1619  0486 fe            	ldw	x,(x)
1620  0487 89            	pushw	x
1621  0488 8d8c018c      	callf	f_detectZeroCross
1623  048c 5b0c          	addw	sp,#12
1624  048e 4d            	tnz	a
1625  048f 276e          	jreq	L706
1626                     ; 173 			currentEdgeTime = micros();
1628  0491 8d000000      	callf	f_micros
1630  0495 96            	ldw	x,sp
1631  0496 1c001a        	addw	x,#OFST-4103
1632  0499 8d000000      	callf	d_rtol
1635                     ; 174 			if (lastEdgeTime > 0) {  // Zero-crossing detected; calculate period and frequency
1637  049d ae0008        	ldw	x,#_lastEdgeTime
1638  04a0 8d000000      	callf	d_lzmp
1640  04a4 2751          	jreq	L316
1641                     ; 175 				unsigned long period = currentEdgeTime - lastEdgeTime;  // Period in microseconds
1643  04a6 96            	ldw	x,sp
1644  04a7 1c001a        	addw	x,#OFST-4103
1645  04aa 8d000000      	callf	d_ltor
1647  04ae ae0008        	ldw	x,#_lastEdgeTime
1648  04b1 8d000000      	callf	d_lsub
1650  04b5 96            	ldw	x,sp
1651  04b6 1c0011        	addw	x,#OFST-4112
1652  04b9 8d000000      	callf	d_rtol
1655                     ; 176 				float singleFrequency = calculate_frequency(period);   // Calculate frequency in Hz
1657  04bd 1e13          	ldw	x,(OFST-4110,sp)
1658  04bf 89            	pushw	x
1659  04c0 1e13          	ldw	x,(OFST-4110,sp)
1660  04c2 89            	pushw	x
1661  04c3 8db105b1      	callf	f_calculate_frequency
1663  04c7 5b04          	addw	sp,#4
1664  04c9 96            	ldw	x,sp
1665  04ca 1c0011        	addw	x,#OFST-4112
1666  04cd 8d000000      	callf	d_rtol
1669                     ; 177 				freqBuff += singleFrequency;  // Accumulate frequency values
1671  04d1 96            	ldw	x,sp
1672  04d2 1c0011        	addw	x,#OFST-4112
1673  04d5 8d000000      	callf	d_ltor
1675  04d9 96            	ldw	x,sp
1676  04da 1c0015        	addw	x,#OFST-4108
1677  04dd 8d000000      	callf	d_fgadd
1680                     ; 178 				freqCount++;
1682  04e1 1e1e          	ldw	x,(OFST-4099,sp)
1683  04e3 1c0001        	addw	x,#1
1684  04e6 1f1e          	ldw	(OFST-4099,sp),x
1686                     ; 180 				if (freqCount == 2) {  // Stop after detecting 2 zero-crossings
1688  04e8 1e1e          	ldw	x,(OFST-4099,sp)
1689  04ea a30002        	cpw	x,#2
1690  04ed 2608          	jrne	L316
1691                     ; 181 					count = i;  // Limit used for amplitude calculation within this range
1693  04ef 96            	ldw	x,sp
1694  04f0 de1020        	ldw	x,(OFST-1,x)
1695  04f3 bf12          	ldw	_count,x
1696                     ; 182 					break;
1698  04f5 202d          	jra	L506
1699  04f7               L316:
1700                     ; 185 			lastEdgeTime = currentEdgeTime;  // Update last edge time
1702  04f7 1e1c          	ldw	x,(OFST-4101,sp)
1703  04f9 bf0a          	ldw	_lastEdgeTime+2,x
1704  04fb 1e1a          	ldw	x,(OFST-4103,sp)
1705  04fd bf08          	ldw	_lastEdgeTime,x
1706  04ff               L706:
1707                     ; 190 	delay_us(1000000 / SAMPLE_RATE);
1709  04ff ae1a0a        	ldw	x,#6666
1710  0502 8d000000      	callf	f_delay_us
1712                     ; 166 	for (i = 0; i < NUM_SAMPLES; i++) {
1714  0506 96            	ldw	x,sp
1715  0507 9093          	ldw	y,x
1716  0509 de1020        	ldw	x,(OFST-1,x)
1717  050c 1c0001        	addw	x,#1
1718  050f 90df1020      	ldw	(OFST-1,y),x
1721  0513 96            	ldw	x,sp
1722  0514 9093          	ldw	y,x
1723  0516 90de1020      	ldw	y,(OFST-1,y)
1724  051a 90a30400      	cpw	y,#1024
1725  051e 2404          	jruge	L06
1726  0520 ac0e040e      	jpf	L106
1727  0524               L06:
1728  0524               L506:
1729                     ; 194 	*amplitude = calculate_amplitude(buffer, (freqCount > 0 ? count : NUM_SAMPLES));
1731  0524 9c            	rvf
1732  0525 1e1e          	ldw	x,(OFST-4099,sp)
1733  0527 2d04          	jrsle	L64
1734  0529 be12          	ldw	x,_count
1735  052b 2003          	jra	L05
1736  052d               L64:
1737  052d ae0400        	ldw	x,#1024
1738  0530               L05:
1739  0530 8d000000      	callf	d_uitolx
1741  0534 be02          	ldw	x,c_lreg+2
1742  0536 89            	pushw	x
1743  0537 be00          	ldw	x,c_lreg
1744  0539 89            	pushw	x
1745  053a 96            	ldw	x,sp
1746  053b 1c0024        	addw	x,#OFST-4093
1747  053e 8df502f5      	callf	f_calculate_amplitude
1749  0542 5b04          	addw	sp,#4
1750  0544 96            	ldw	x,sp
1751  0545 de1028        	ldw	x,(OFST+7,x)
1752  0548 8d000000      	callf	d_rtol
1754                     ; 197 	if (isChannel1 && freqCount > 0) {
1756  054c 0d19          	tnz	(OFST-4104,sp)
1757  054e 272d          	jreq	L716
1759  0550 9c            	rvf
1760  0551 1e1e          	ldw	x,(OFST-4099,sp)
1761  0553 2d28          	jrsle	L716
1762                     ; 198 		*frequency = freqBuff / freqCount;  // Calculate average frequency
1764  0555 1e1e          	ldw	x,(OFST-4099,sp)
1765  0557 8d000000      	callf	d_itof
1767  055b 96            	ldw	x,sp
1768  055c 1c000d        	addw	x,#OFST-4116
1769  055f 8d000000      	callf	d_rtol
1772  0563 96            	ldw	x,sp
1773  0564 1c0015        	addw	x,#OFST-4108
1774  0567 8d000000      	callf	d_ltor
1776  056b 96            	ldw	x,sp
1777  056c 1c000d        	addw	x,#OFST-4116
1778  056f 8d000000      	callf	d_fdiv
1780  0573 96            	ldw	x,sp
1781  0574 de1026        	ldw	x,(OFST+5,x)
1782  0577 8d000000      	callf	d_rtol
1785  057b 2017          	jra	L126
1786  057d               L716:
1787                     ; 200 	else if (isChannel1) {
1789  057d 0d19          	tnz	(OFST-4104,sp)
1790  057f 2713          	jreq	L126
1791                     ; 201 		*frequency = 0;  // No crossings detected, return 0 frequency
1793  0581 96            	ldw	x,sp
1794  0582 de1026        	ldw	x,(OFST+5,x)
1795  0585 a600          	ld	a,#0
1796  0587 e703          	ld	(3,x),a
1797  0589 a600          	ld	a,#0
1798  058b e702          	ld	(2,x),a
1799  058d a600          	ld	a,#0
1800  058f e701          	ld	(1,x),a
1801  0591 a600          	ld	a,#0
1802  0593 f7            	ld	(x),a
1803  0594               L126:
1804                     ; 204 	return *amplitude;  // Always return amplitude
1806  0594 96            	ldw	x,sp
1807  0595 de1028        	ldw	x,(OFST+7,x)
1808  0598 8d000000      	callf	d_ltor
1812  059c 9096          	ldw	y,sp
1813  059e 72a91022      	addw	y,#4130
1814  05a2 9094          	ldw	sp,y
1815  05a4 87            	retf
1849                     ; 208 float convert_adc_to_voltage(unsigned int adcValue) {
1850                     	switch	.text
1851  05a5               f_convert_adc_to_voltage:
1855                     ; 209 	return adcValue * (V_REF / ADC_MAX_VALUE);
1857  05a5 8d000000      	callf	d_uitof
1859  05a9 ae10ac        	ldw	x,#L746
1860  05ac 8d000000      	callf	d_fmul
1864  05b0 87            	retf
1898                     ; 213 float calculate_frequency(unsigned long period) {
1899                     	switch	.text
1900  05b1               f_calculate_frequency:
1902  05b1 5204          	subw	sp,#4
1903       00000004      OFST:	set	4
1906                     ; 214 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
1908  05b3 96            	ldw	x,sp
1909  05b4 1c0008        	addw	x,#OFST+4
1910  05b7 8d000000      	callf	d_ltor
1912  05bb 8d000000      	callf	d_ultof
1914  05bf ae10a4        	ldw	x,#L507
1915  05c2 8d000000      	callf	d_fdiv
1917  05c6 96            	ldw	x,sp
1918  05c7 1c0001        	addw	x,#OFST-3
1919  05ca 8d000000      	callf	d_rtol
1922  05ce ae10a8        	ldw	x,#L576
1923  05d1 8d000000      	callf	d_ltor
1925  05d5 96            	ldw	x,sp
1926  05d6 1c0001        	addw	x,#OFST-3
1927  05d9 8d000000      	callf	d_fdiv
1931  05dd 5b04          	addw	sp,#4
1932  05df 87            	retf
1986                     ; 218 void output_results(float frequency, float amplitude) {
1987                     	switch	.text
1988  05e0               f_output_results:
1990  05e0 5228          	subw	sp,#40
1991       00000028      OFST:	set	40
1994                     ; 224 	sprintf(buffer, "%.3f,%.3f,%.3f\n", frequency, amplitude, amplitude);
1996  05e2 1e32          	ldw	x,(OFST+10,sp)
1997  05e4 89            	pushw	x
1998  05e5 1e32          	ldw	x,(OFST+10,sp)
1999  05e7 89            	pushw	x
2000  05e8 1e36          	ldw	x,(OFST+14,sp)
2001  05ea 89            	pushw	x
2002  05eb 1e36          	ldw	x,(OFST+14,sp)
2003  05ed 89            	pushw	x
2004  05ee 1e36          	ldw	x,(OFST+14,sp)
2005  05f0 89            	pushw	x
2006  05f1 1e36          	ldw	x,(OFST+14,sp)
2007  05f3 89            	pushw	x
2008  05f4 ae1094        	ldw	x,#L737
2009  05f7 89            	pushw	x
2010  05f8 96            	ldw	x,sp
2011  05f9 1c000f        	addw	x,#OFST-25
2012  05fc 8d000000      	callf	f_sprintf
2014  0600 5b0e          	addw	sp,#14
2015                     ; 227 	printf("%s", buffer);
2017  0602 96            	ldw	x,sp
2018  0603 1c0001        	addw	x,#OFST-39
2019  0606 89            	pushw	x
2020  0607 ae1091        	ldw	x,#L147
2021  060a 8d000000      	callf	f_printf
2023  060e 85            	popw	x
2024                     ; 229 }
2027  060f 5b28          	addw	sp,#40
2028  0611 87            	retf
2064                     ; 232 void send_square_pulse(uint16_t duration_ms) {
2065                     	switch	.text
2066  0612               f_send_square_pulse:
2068  0612 89            	pushw	x
2069       00000000      OFST:	set	0
2072                     ; 233 	GPIO_WriteHigh(GPIOC, GPIO_PIN_3); // Set square pulse pin high
2074  0613 4b08          	push	#8
2075  0615 ae500a        	ldw	x,#20490
2076  0618 8d000000      	callf	f_GPIO_WriteHigh
2078  061c 84            	pop	a
2079                     ; 234 	delay_ms(duration_ms);            // Wait for the pulse duration
2081  061d 1e01          	ldw	x,(OFST+1,sp)
2082  061f 8d000000      	callf	f_delay_ms
2084                     ; 235 	GPIO_WriteLow(GPIOC, GPIO_PIN_3); // Set square pulse pin low
2086  0623 4b08          	push	#8
2087  0625 ae500a        	ldw	x,#20490
2088  0628 8d000000      	callf	f_GPIO_WriteLow
2090  062c 84            	pop	a
2091                     ; 236 }
2094  062d 85            	popw	x
2095  062e 87            	retf
2130                     ; 239 bool check_signal_dc(float amplitude) {
2131                     	switch	.text
2132  062f               f_check_signal_dc:
2134       00000000      OFST:	set	0
2137                     ; 240 	if (amplitude == 0) {
2139  062f 9c            	rvf
2140  0630 0d04          	tnz	(OFST+4,sp)
2141  0632 2607          	jrne	L777
2142                     ; 241 		isThyristorON = true;
2144  0634 35010014      	mov	_isThyristorON,#1
2145                     ; 242 		return true;
2147  0638 a601          	ld	a,#1
2150  063a 87            	retf
2151  063b               L777:
2152                     ; 244 		isThyristorON = false;
2154  063b 3f14          	clr	_isThyristorON
2155                     ; 245 		return false;
2157  063d 4f            	clr	a
2160  063e 87            	retf
2207                     ; 249 void configure_set_frequency(void) {
2208                     	switch	.text
2209  063f               f_configure_set_frequency:
2211  063f 5218          	subw	sp,#24
2212       00000018      OFST:	set	24
2215                     ; 251 		float new_frequency = 5.0; // Convert string to float
2217                     ; 252     printf("Enter new set frequency (0.3 - 5 Hz):\n");
2219  0641 ae1066        	ldw	x,#L5301
2220  0644 8d000000      	callf	f_printf
2222                     ; 254     UART3_ReceiveString(buffer, sizeof(buffer)); // Receive user input
2224  0648 ae0014        	ldw	x,#20
2225  064b 89            	pushw	x
2226  064c 96            	ldw	x,sp
2227  064d 1c0003        	addw	x,#OFST-21
2228  0650 8d000000      	callf	f_UART3_ReceiveString
2230  0654 85            	popw	x
2231                     ; 255     new_frequency = atof(buffer); // Convert string to float
2233  0655 96            	ldw	x,sp
2234  0656 1c0001        	addw	x,#OFST-23
2235  0659 8d000000      	callf	f_atof
2237  065d 96            	ldw	x,sp
2238  065e 1c0015        	addw	x,#OFST-3
2239  0661 8d000000      	callf	d_rtol
2242                     ; 258     if (new_frequency >= 0.3 && new_frequency <= 5.0) {
2244  0665 9c            	rvf
2245  0666 96            	ldw	x,sp
2246  0667 1c0015        	addw	x,#OFST-3
2247  066a 8d000000      	callf	d_ltor
2249  066e ae1062        	ldw	x,#L5401
2250  0671 8d000000      	callf	d_fcmp
2252  0675 2f23          	jrslt	L7301
2254  0677 9c            	rvf
2255  0678 96            	ldw	x,sp
2256  0679 1c0015        	addw	x,#OFST-3
2257  067c 8d000000      	callf	d_ltor
2259  0680 ae108d        	ldw	x,#L1301
2260  0683 8d000000      	callf	d_fcmp
2262  0687 2c11          	jrsgt	L7301
2263                     ; 260         printf("Set frequency updated to: %.2f Hz\n", new_frequency);
2265  0689 1e17          	ldw	x,(OFST-1,sp)
2266  068b 89            	pushw	x
2267  068c 1e17          	ldw	x,(OFST-1,sp)
2268  068e 89            	pushw	x
2269  068f ae103f        	ldw	x,#L1501
2270  0692 8d000000      	callf	f_printf
2272  0696 5b04          	addw	sp,#4
2274  0698 2007          	jra	L3501
2275  069a               L7301:
2276                     ; 262         printf("Invalid frequency. Please enter a value between 0.3 and 5 Hz.\n");
2278  069a ae1000        	ldw	x,#L5501
2279  069d 8d000000      	callf	f_printf
2281  06a1               L3501:
2282                     ; 264 }
2285  06a1 5b18          	addw	sp,#24
2286  06a3 87            	retf
2298                     	xdef	f_main
2299                     	xdef	f_configure_set_frequency
2300                     	xdef	f_calculate_frequency
2301                     	xdef	f_convert_adc_to_voltage
2302                     	xdef	f_process_adc_signal
2303                     	xdef	f_calculate_amplitude
2304                     	xdef	f_output_results
2305                     	xdef	f_initialize_adc_buffer
2306                     	xdef	f_check_signal_dc
2307                     	xdef	f_send_square_pulse
2308                     	xdef	f_check_negative_zero_crossing
2309                     	xdef	f_detect_negative_zero_cross
2310                     	xdef	f_detectZeroCross
2311                     	xdef	f_detectPosZeroCross
2312                     	xdef	f_initialize_system
2313                     	xdef	_isThyristorON
2314                     	xdef	_count
2315                     	xdef	_crossingType
2316                     	xdef	_currentEdgeTime
2317                     	xdef	_lastEdgeTime
2318                     	xdef	_sine1_amplitude
2319                     	xdef	_sine1_frequency
2320                     	xref	f_read_ADC_Channel
2321                     	xref	f_UART3_ReceiveString
2322                     	xref	f_ADC2_setup
2323                     	xref	f_UART3_setup
2324                     	xref	f_clock_setup
2325                     	xref	f_I2CInit
2326                     	xref	f_EEPROM_Config
2327                     	xref	f_micros
2328                     	xref	f_delay_us
2329                     	xref	f_delay_ms
2330                     	xref	f_TIM4_Config
2331                     	xref	f_atof
2332                     	xref	f_sprintf
2333                     	xref	f_printf
2334                     	xref	f_GPIO_WriteLow
2335                     	xref	f_GPIO_WriteHigh
2336                     	xref	f_GPIO_Init
2337                     	xref	f_GPIO_DeInit
2338                     	switch	.const
2339  1000               L5501:
2340  1000 496e76616c69  	dc.b	"Invalid frequency."
2341  1012 20506c656173  	dc.b	" Please enter a va"
2342  1024 6c7565206265  	dc.b	"lue between 0.3 an"
2343  1036 64203520487a  	dc.b	"d 5 Hz.",10,0
2344  103f               L1501:
2345  103f 536574206672  	dc.b	"Set frequency upda"
2346  1051 74656420746f  	dc.b	"ted to: %.2f Hz",10,0
2347  1062               L5401:
2348  1062 3e999999      	dc.w	16025,-26215
2349  1066               L5301:
2350  1066 456e74657220  	dc.b	"Enter new set freq"
2351  1078 75656e637920  	dc.b	"uency (0.3 - 5 Hz)"
2352  108a 3a0a00        	dc.b	":",10,0
2353  108d               L1301:
2354  108d 40a00000      	dc.w	16544,0
2355  1091               L147:
2356  1091 257300        	dc.b	"%s",0
2357  1094               L737:
2358  1094 252e33662c25  	dc.b	"%.3f,%.3f,%.3f",10,0
2359  10a4               L507:
2360  10a4 49742400      	dc.w	18804,9216
2361  10a8               L576:
2362  10a8 3f800000      	dc.w	16256,0
2363  10ac               L746:
2364  10ac 3b954409      	dc.w	15253,17417
2365  10b0               L134:
2366  10b0 c0951eb8      	dc.w	-16235,7864
2367  10b4               L144:
2368  10b4 40951eb8      	dc.w	16533,7864
2369  10b8               L563:
2370  10b8 4e6567617469  	dc.b	"Negative zero cros"
2371  10ca 73696e672064  	dc.b	"sing detected!",10,0
2372  10da               L163:
2373  10da 401851eb      	dc.w	16408,20971
2374  10de               L171:
2375  10de 53797374656d  	dc.b	"System Initializat"
2376  10f0 696f6e20436f  	dc.b	"ion Completed",10
2377  10fe 0d00          	dc.b	13,0
2378  1100               L751:
2379  1100 467265717565  	dc.b	"Frequency above se"
2380  1112 742046726571  	dc.b	"t Frequency.",10,0
2381  1120               L741:
2382  1120 3c23d70a      	dc.w	15395,-10486
2383  1124               L321:
2384  1124 5369676e616c  	dc.b	"Signal 1 Frequency"
2385  1136 3a20252e3266  	dc.b	": %.2f Hz, Amplitu"
2386  1148 64653a20252e  	dc.b	"de: %.2f V",10,0
2387                     	xref.b	c_lreg
2388                     	xref.b	c_x
2389                     	xref.b	c_y
2409                     	xref	d_ultof
2410                     	xref	d_fmul
2411                     	xref	d_uitof
2412                     	xref	d_fdiv
2413                     	xref	d_uitolx
2414                     	xref	d_fgadd
2415                     	xref	d_lsub
2416                     	xref	d_lzmp
2417                     	xref	d_xymovl
2418                     	xref	d_itof
2419                     	xref	d_fsub
2420                     	xref	d_lcmp
2421                     	xref	d_lgadc
2422                     	xref	d_fcmp
2423                     	xref	d_ctof
2424                     	xref	d_ltor
2425                     	xref	d_rtol
2426                     	end
