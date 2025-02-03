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
 203                     ; 12 void main() {
 204                     	switch	.text
 205  0000               f_main:
 207  0000 520c          	subw	sp,#12
 208       0000000c      OFST:	set	12
 211                     ; 14 	float VAR_frequency = 0, VAR_amplitude = 0;
 213  0002 5f            	clrw	x
 214  0003 1f03          	ldw	(OFST-9,sp),x
 215  0005 1f01          	ldw	(OFST-11,sp),x
 219  0007 1f0b          	ldw	(OFST-1,sp),x
 220  0009 1f09          	ldw	(OFST-3,sp),x
 222                     ; 15 	float FDR_amplitude = 0;
 224  000b 1f07          	ldw	(OFST-5,sp),x
 225  000d 1f05          	ldw	(OFST-7,sp),x
 227                     ; 17 	initialize_system(); 
 229  000f 8d880188      	callf	f_initialize_system
 231  0013               L711:
 232                     ; 21 		FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
 234  0013 96            	ldw	x,sp
 235  0014 1c0005        	addw	x,#OFST-7
 236  0017 89            	pushw	x
 237  0018 5f            	clrw	x
 238  0019 89            	pushw	x
 239  001a a606          	ld	a,#6
 240  001c 8dae03ae      	callf	f_process_adc_signal
 242  0020 5b04          	addw	sp,#4
 243  0022 96            	ldw	x,sp
 244  0023 1c0005        	addw	x,#OFST-7
 245  0026 8d000000      	callf	d_rtol
 248                     ; 23 		if(FDR_amplitude > 0) {  // Voltage detected on Signal 2
 250  002a 9c            	rvf	
 251  002b 7b05          	ld	a,(OFST-7,sp)
 252  002d 2de4          	jrsle	L711
 253                     ; 24 			GPIO_WriteHigh(GPIOC, GPIO_PIN_3);  // Turn on LED
 255  002f 4b08          	push	#8
 256  0031 ae500a        	ldw	x,#20490
 257  0034 8d000000      	callf	f_GPIO_WriteHigh
 259  0038 84            	pop	a
 260  0039               L521:
 261                     ; 27 			VAR_amplitude = process_adc_signal(VAR_SIGNAL, &VAR_frequency, &VAR_amplitude);
 263  0039 96            	ldw	x,sp
 264  003a 1c0009        	addw	x,#OFST-3
 265  003d 89            	pushw	x
 266  003e 1d0008        	subw	x,#8
 267  0041 89            	pushw	x
 268  0042 a605          	ld	a,#5
 269  0044 8dae03ae      	callf	f_process_adc_signal
 271  0048 5b04          	addw	sp,#4
 272  004a 96            	ldw	x,sp
 273  004b 1c0009        	addw	x,#OFST-3
 274  004e 8d000000      	callf	d_rtol
 277                     ; 29 			printf(" Frequency: %.3f, Amplitude: %.3f, Current: %.3f, FDR_Voltage: %.3f\n", VAR_frequency, VAR_amplitude, VAR_amplitude/4.7, 							FDR_amplitude);
 279  0052 1e07          	ldw	x,(OFST-5,sp)
 280  0054 89            	pushw	x
 281  0055 1e07          	ldw	x,(OFST-5,sp)
 282  0057 89            	pushw	x
 283  0058 96            	ldw	x,sp
 284  0059 1c000d        	addw	x,#OFST+1
 285  005c 8d000000      	callf	d_ltor
 287  0060 ae1170        	ldw	x,#L731
 288  0063 8d000000      	callf	d_fdiv
 290  0067 be02          	ldw	x,c_lreg+2
 291  0069 89            	pushw	x
 292  006a be00          	ldw	x,c_lreg
 293  006c 89            	pushw	x
 294  006d 1e13          	ldw	x,(OFST+7,sp)
 295  006f 89            	pushw	x
 296  0070 1e13          	ldw	x,(OFST+7,sp)
 297  0072 89            	pushw	x
 298  0073 1e0f          	ldw	x,(OFST+3,sp)
 299  0075 89            	pushw	x
 300  0076 1e0f          	ldw	x,(OFST+3,sp)
 301  0078 89            	pushw	x
 302  0079 ae1174        	ldw	x,#L131
 303  007c 8d000000      	callf	f_printf
 305  0080 5b10          	addw	sp,#16
 306                     ; 30 			output_results(VAR_frequency, VAR_amplitude, FDR_amplitude);
 308  0082 1e07          	ldw	x,(OFST-5,sp)
 309  0084 89            	pushw	x
 310  0085 1e07          	ldw	x,(OFST-5,sp)
 311  0087 89            	pushw	x
 312  0088 1e0f          	ldw	x,(OFST+3,sp)
 313  008a 89            	pushw	x
 314  008b 1e0f          	ldw	x,(OFST+3,sp)
 315  008d 89            	pushw	x
 316  008e 1e0b          	ldw	x,(OFST-1,sp)
 317  0090 89            	pushw	x
 318  0091 1e0b          	ldw	x,(OFST-1,sp)
 319  0093 89            	pushw	x
 320  0094 8d160616      	callf	f_output_results
 322  0098 5b0c          	addw	sp,#12
 323                     ; 31 			if (VAR_frequency <= SET_FREQ){
 325  009a 96            	ldw	x,sp
 326  009b 5c            	incw	x
 327  009c 8d000000      	callf	d_ltor
 329  00a0 ae116c        	ldw	x,#L151
 330  00a3 8d000000      	callf	d_fcmp
 332  00a7 2c90          	jrsgt	L521
 333                     ; 32 				printf("Frequency Below Set Frequency.\n");
 335  00a9 ae114c        	ldw	x,#L551
 336  00ac 8d000000      	callf	f_printf
 338  00b0               L75:
 339                     ; 35 				NEG_Cross:
 339                     ; 36 				if(check_negative_zero_crossing()){     // Wait for negative zero crossing
 341  00b0 8db102b1      	callf	f_check_negative_zero_crossing
 343  00b4 4d            	tnz	a
 344  00b5 27f9          	jreq	L75
 345                     ; 37 					send_square_pulse(5); 
 347  00b7 ae0005        	ldw	x,#5
 348  00ba 8d4e064e      	callf	f_send_square_pulse
 350                     ; 38 					GPIO_WriteHigh(GPIOA, GPIO_PIN_3);  // Turn on LED if Signal is DC
 352  00be 4b08          	push	#8
 353  00c0 ae5000        	ldw	x,#20480
 354  00c3 8d000000      	callf	f_GPIO_WriteHigh
 356  00c7 84            	pop	a
 357                     ; 39 					VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
 359  00c8 96            	ldw	x,sp
 360  00c9 1c0009        	addw	x,#OFST-3
 361  00cc 89            	pushw	x
 362  00cd 5f            	clrw	x
 363  00ce 89            	pushw	x
 364  00cf a605          	ld	a,#5
 365  00d1 8dae03ae      	callf	f_process_adc_signal
 367  00d5 5b04          	addw	sp,#4
 368  00d7 96            	ldw	x,sp
 369  00d8 1c0009        	addw	x,#OFST-3
 370  00db 8d000000      	callf	d_rtol
 373                     ; 42 					if(check_signal_dc(VAR_amplitude)){
 375  00df 1e0b          	ldw	x,(OFST-1,sp)
 376  00e1 89            	pushw	x
 377  00e2 1e0b          	ldw	x,(OFST-1,sp)
 378  00e4 89            	pushw	x
 379  00e5 8d880688      	callf	f_check_signal_dc
 381  00e9 5b04          	addw	sp,#4
 382  00eb 4d            	tnz	a
 383  00ec 2742          	jreq	L161
 384                     ; 43 						printf("Signal 1 DC.\n");
 386  00ee ae113e        	ldw	x,#L361
 387  00f1 8d000000      	callf	f_printf
 389                     ; 44 						GPIO_WriteHigh(GPIOD, GPIO_PIN_3);  // Turn on LED if Signal is DC
 391  00f5 4b08          	push	#8
 392  00f7               LC001:
 393  00f7 ae500f        	ldw	x,#20495
 394  00fa 8d000000      	callf	f_GPIO_WriteHigh
 396  00fe               L16:
 397  00fe 84            	pop	a
 398                     ; 46 							FDR_Sampling:                         // LABEL for goto
 398                     ; 47 							FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
 400  00ff 96            	ldw	x,sp
 401  0100 1c0005        	addw	x,#OFST-7
 402  0103 89            	pushw	x
 403  0104 5f            	clrw	x
 404  0105 89            	pushw	x
 405  0106 a606          	ld	a,#6
 406  0108 8dae03ae      	callf	f_process_adc_signal
 408  010c 5b04          	addw	sp,#4
 409  010e 96            	ldw	x,sp
 410  010f 1c0005        	addw	x,#OFST-7
 411  0112 8d000000      	callf	d_rtol
 414                     ; 49 							if(isThyristorON){
 416  0116 b614          	ld	a,_isThyristorON
 417  0118 270b          	jreq	L171
 418                     ; 50 								send_square_pulse(3000);
 420  011a ae0bb8        	ldw	x,#3000
 421  011d 8d4e064e      	callf	f_send_square_pulse
 423                     ; 51 								GPIO_WriteHigh(GPIOD, GPIO_PIN_0);  // Turn on LED ORANGE
 425  0121 4b01          	push	#1
 427                     ; 52 								goto FDR_Sampling;
 429  0123 20d2          	jpf	LC001
 430  0125               L171:
 431                     ; 55 								GPIO_WriteLow(GPIOD, GPIO_PIN_0);  // Turn on LED ORANGE
 433  0125 4b01          	push	#1
 434  0127 ae500f        	ldw	x,#20495
 435  012a 8d000000      	callf	f_GPIO_WriteLow
 437                     ; 56 								goto FDR_Sampling;
 439  012e 20ce          	jra	L16
 440  0130               L161:
 441                     ; 63 							printf("Signal 1 AC and VarAmplitude: %f.\n", VAR_amplitude);
 443  0130 1e0b          	ldw	x,(OFST-1,sp)
 444  0132 89            	pushw	x
 445  0133 1e0b          	ldw	x,(OFST-1,sp)
 446  0135 89            	pushw	x
 447  0136 ae111b        	ldw	x,#L771
 448  0139 8d000000      	callf	f_printf
 450  013d 5b04          	addw	sp,#4
 451                     ; 64 							if (VAR_amplitude < AC_AMPLITUDE_THRESHOLD) {
 453  013f 96            	ldw	x,sp
 454  0140 1c0009        	addw	x,#OFST-3
 455  0143 8d000000      	callf	d_ltor
 457  0147 ae1117        	ldw	x,#L702
 458  014a 8d000000      	callf	d_fcmp
 460  014e 2e23          	jrsge	L102
 461                     ; 65 								printf("VarAmplitude below 10 mv.\n");
 463  0150 ae10fc        	ldw	x,#L312
 464  0153 8d000000      	callf	f_printf
 466                     ; 66 								GPIO_WriteLow(GPIOE, GPIO_PIN_3);  // Turn on LED if Signal is AC < 20 mV
 468  0157 4b08          	push	#8
 469  0159 ae5014        	ldw	x,#20500
 470  015c 8d000000      	callf	f_GPIO_WriteLow
 472  0160 ae0bb8        	ldw	x,#3000
 473  0163 84            	pop	a
 474                     ; 67 								delay_ms(3000);
 476  0164 8d000000      	callf	f_delay_ms
 478                     ; 68 								send_square_pulse(5);
 480  0168 ae0005        	ldw	x,#5
 481  016b 8d4e064e      	callf	f_send_square_pulse
 484  016f acb000b0      	jra	L75
 485  0173               L102:
 486                     ; 71 								printf("VarAmplitude Not below 10 mv.\n");
 488  0173 ae10dd        	ldw	x,#L712
 489  0176 8d000000      	callf	f_printf
 491                     ; 72 								GPIO_WriteHigh(GPIOE, GPIO_PIN_3);  // Turn on LED if Signal is AC < 20 ms
 493  017a 4b08          	push	#8
 494  017c ae5014        	ldw	x,#20500
 495  017f 8d000000      	callf	f_GPIO_WriteHigh
 497  0183 84            	pop	a
 498  0184 acb000b0      	jra	L75
 528                     ; 90 void initialize_system(void) {
 529                     	switch	.text
 530  0188               f_initialize_system:
 534                     ; 91 	clock_setup();          // Configure system clock
 536  0188 8d000000      	callf	f_clock_setup
 538                     ; 92 	TIM4_Config();          // Timer 4 config for delay
 540  018c 8d000000      	callf	f_TIM4_Config
 542                     ; 93 	GPIO_setup();
 544  0190 8d000000      	callf	f_GPIO_setup
 546                     ; 94 	UART3_setup();          // Setup UART communication
 548  0194 8d000000      	callf	f_UART3_setup
 550                     ; 95 	ADC2_setup();						// Setup ADC
 552  0198 8d000000      	callf	f_ADC2_setup
 554                     ; 96 	EEPROM_Config();        // Configuring EEPROM
 556  019c 8d000000      	callf	f_EEPROM_Config
 558                     ; 97 	I2CInit();              // for Configuring RTC
 560  01a0 8d000000      	callf	f_I2CInit
 562                     ; 98 	printf("System Initialization Completed\n\r");
 564  01a4 ae10bb        	ldw	x,#L132
 566                     ; 99 }
 569  01a7 ac000000      	jpf	f_printf
 642                     ; 102 bool detectZeroCross(float previousSample, float currentSample, float threshold) {
 643                     	switch	.text
 644  01ab               f_detectZeroCross:
 646       00000000      OFST:	set	0
 649                     ; 103 	if (crossingType == -1) {  // If no crossing type detected, check for both positive and negative
 651  01ab be10          	ldw	x,_crossingType
 652  01ad 5c            	incw	x
 653  01ae 2656          	jrne	L172
 654                     ; 104 		if (previousSample <= threshold && currentSample > threshold) {
 656  01b0 96            	ldw	x,sp
 657  01b1 1c0004        	addw	x,#OFST+4
 658  01b4 8d000000      	callf	d_ltor
 660  01b8 96            	ldw	x,sp
 661  01b9 1c000c        	addw	x,#OFST+12
 662  01bc 8d000000      	callf	d_fcmp
 664  01c0 2c18          	jrsgt	L372
 666  01c2 96            	ldw	x,sp
 667  01c3 1c0008        	addw	x,#OFST+8
 668  01c6 8d000000      	callf	d_ltor
 670  01ca 96            	ldw	x,sp
 671  01cb 1c000c        	addw	x,#OFST+12
 672  01ce 8d000000      	callf	d_fcmp
 674  01d2 2d06          	jrsle	L372
 675                     ; 105 			crossingType = 0;  // Positive zero crossing
 677  01d4 5f            	clrw	x
 678  01d5 bf10          	ldw	_crossingType,x
 679                     ; 106 			return true;
 681  01d7 a601          	ld	a,#1
 684  01d9 87            	retf	
 685  01da               L372:
 686                     ; 107 		} else if (previousSample >= threshold && currentSample < threshold) {
 688  01da 96            	ldw	x,sp
 689  01db 1c0004        	addw	x,#OFST+4
 690  01de 8d000000      	callf	d_ltor
 692  01e2 96            	ldw	x,sp
 693  01e3 1c000c        	addw	x,#OFST+12
 694  01e6 8d000000      	callf	d_fcmp
 696  01ea 2f71          	jrslt	L103
 698  01ec 96            	ldw	x,sp
 699  01ed 1c0008        	addw	x,#OFST+8
 700  01f0 8d000000      	callf	d_ltor
 702  01f4 96            	ldw	x,sp
 703  01f5 1c000c        	addw	x,#OFST+12
 704  01f8 8d000000      	callf	d_fcmp
 706  01fc 2e5f          	jrsge	L103
 707                     ; 108 			crossingType = 1;  // Negative zero crossing
 709  01fe ae0001        	ldw	x,#1
 710  0201 bf10          	ldw	_crossingType,x
 711                     ; 109 			return true;
 713  0203 a601          	ld	a,#1
 716  0205 87            	retf	
 717  0206               L172:
 718                     ; 111 	} else if (crossingType == 0 && previousSample <= threshold && currentSample > threshold) {
 720  0206 be10          	ldw	x,_crossingType
 721  0208 2627          	jrne	L303
 723  020a 96            	ldw	x,sp
 724  020b 1c0004        	addw	x,#OFST+4
 725  020e 8d000000      	callf	d_ltor
 727  0212 96            	ldw	x,sp
 728  0213 1c000c        	addw	x,#OFST+12
 729  0216 8d000000      	callf	d_fcmp
 731  021a 2c15          	jrsgt	L303
 733  021c 96            	ldw	x,sp
 734  021d 1c0008        	addw	x,#OFST+8
 735  0220 8d000000      	callf	d_ltor
 737  0224 96            	ldw	x,sp
 738  0225 1c000c        	addw	x,#OFST+12
 739  0228 8d000000      	callf	d_fcmp
 741  022c 2d03          	jrsle	L303
 742                     ; 112 			return true;  // Positive zero crossing
 744  022e a601          	ld	a,#1
 747  0230 87            	retf	
 748  0231               L303:
 749                     ; 113 	} else if (crossingType == 1 && previousSample >= threshold && currentSample < threshold) {
 751  0231 be10          	ldw	x,_crossingType
 752  0233 5a            	decw	x
 753  0234 2627          	jrne	L103
 755  0236 96            	ldw	x,sp
 756  0237 1c0004        	addw	x,#OFST+4
 757  023a 8d000000      	callf	d_ltor
 759  023e 96            	ldw	x,sp
 760  023f 1c000c        	addw	x,#OFST+12
 761  0242 8d000000      	callf	d_fcmp
 763  0246 2f15          	jrslt	L103
 765  0248 96            	ldw	x,sp
 766  0249 1c0008        	addw	x,#OFST+8
 767  024c 8d000000      	callf	d_ltor
 769  0250 96            	ldw	x,sp
 770  0251 1c000c        	addw	x,#OFST+12
 771  0254 8d000000      	callf	d_fcmp
 773  0258 2e03          	jrsge	L103
 774                     ; 114 			return true;  // Negative zero crossing
 776  025a a601          	ld	a,#1
 779  025c 87            	retf	
 780  025d               L103:
 781                     ; 117 	return false;  // No zero crossing detected
 783  025d 4f            	clr	a
 786  025e 87            	retf	
 838                     ; 121 bool detectPosZeroCross(float previousSample, float currentSample, float threshold) {
 839                     	switch	.text
 840  025f               f_detectPosZeroCross:
 842       00000000      OFST:	set	0
 845                     ; 122 	return (previousSample <= threshold && currentSample > threshold);
 847  025f 96            	ldw	x,sp
 848  0260 1c0004        	addw	x,#OFST+4
 849  0263 8d000000      	callf	d_ltor
 851  0267 96            	ldw	x,sp
 852  0268 1c000c        	addw	x,#OFST+12
 853  026b 8d000000      	callf	d_fcmp
 855  026f 2c15          	jrsgt	L611
 856  0271 96            	ldw	x,sp
 857  0272 1c0008        	addw	x,#OFST+8
 858  0275 8d000000      	callf	d_ltor
 860  0279 96            	ldw	x,sp
 861  027a 1c000c        	addw	x,#OFST+12
 862  027d 8d000000      	callf	d_fcmp
 864  0281 2d03          	jrsle	L611
 865  0283 a601          	ld	a,#1
 867  0285 87            	retf	
 868  0286               L611:
 869  0286 4f            	clr	a
 872  0287 87            	retf	
 925                     ; 126 bool detect_negative_zero_cross(float previous_sample, float current_sample, float threshold) {
 926                     	switch	.text
 927  0288               f_detect_negative_zero_cross:
 929       00000000      OFST:	set	0
 932                     ; 127     return (previous_sample > threshold && current_sample <= threshold);
 934  0288 96            	ldw	x,sp
 935  0289 1c0004        	addw	x,#OFST+4
 936  028c 8d000000      	callf	d_ltor
 938  0290 96            	ldw	x,sp
 939  0291 1c000c        	addw	x,#OFST+12
 940  0294 8d000000      	callf	d_fcmp
 942  0298 2d15          	jrsle	L421
 943  029a 96            	ldw	x,sp
 944  029b 1c0008        	addw	x,#OFST+8
 945  029e 8d000000      	callf	d_ltor
 947  02a2 96            	ldw	x,sp
 948  02a3 1c000c        	addw	x,#OFST+12
 949  02a6 8d000000      	callf	d_fcmp
 951  02aa 2c03          	jrsgt	L421
 952  02ac a601          	ld	a,#1
 954  02ae 87            	retf	
 955  02af               L421:
 956  02af 4f            	clr	a
 959  02b0 87            	retf	
1006                     ; 130 bool check_negative_zero_crossing(void) {
1007                     	switch	.text
1008  02b1               f_check_negative_zero_crossing:
1010  02b1 5208          	subw	sp,#8
1011       00000008      OFST:	set	8
1014                     ; 131 	float prev_adc_value = 0;  // Store previous ADC sample value
1016  02b3 5f            	clrw	x
1017  02b4 1f03          	ldw	(OFST-5,sp),x
1018                     ; 132 	float current_adc_value = 0;  // Store current ADC sample value
1020  02b6               L704:
1021  02b6 1f01          	ldw	(OFST-7,sp),x
1023                     ; 136 		current_adc_value = convert_adc_to_voltage(read_ADC_Channel(VAR_SIGNAL));
1025  02b8 a605          	ld	a,#5
1026  02ba 8d000000      	callf	f_read_ADC_Channel
1028  02be 8de005e0      	callf	f_convert_adc_to_voltage
1030  02c2 96            	ldw	x,sp
1031  02c3 1c0005        	addw	x,#OFST-3
1032  02c6 8d000000      	callf	d_rtol
1035                     ; 138 		if (detect_negative_zero_cross(prev_adc_value, current_adc_value, ZEROCROSS_THRESHOLD)) {
1037  02ca ce10b9        	ldw	x,L124+2
1038  02cd 89            	pushw	x
1039  02ce ce10b7        	ldw	x,L124
1040  02d1 89            	pushw	x
1041  02d2 1e0b          	ldw	x,(OFST+3,sp)
1042  02d4 89            	pushw	x
1043  02d5 1e0b          	ldw	x,(OFST+3,sp)
1044  02d7 89            	pushw	x
1045  02d8 1e0b          	ldw	x,(OFST+3,sp)
1046  02da 89            	pushw	x
1047  02db 1e0b          	ldw	x,(OFST+3,sp)
1048  02dd 89            	pushw	x
1049  02de 8d880288      	callf	f_detect_negative_zero_cross
1051  02e2 5b0c          	addw	sp,#12
1052  02e4 4d            	tnz	a
1053  02e5 2705          	jreq	L314
1054                     ; 140 			return true;
1056  02e7 a601          	ld	a,#1
1059  02e9 5b08          	addw	sp,#8
1060  02eb 87            	retf	
1061  02ec               L314:
1062                     ; 143 		prev_adc_value = current_adc_value;
1064  02ec 1e07          	ldw	x,(OFST-1,sp)
1065  02ee 1f03          	ldw	(OFST-5,sp),x
1066  02f0 1e05          	ldw	x,(OFST-3,sp)
1068  02f2 20c2          	jra	L704
1139                     ; 149 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
1140                     	switch	.text
1141  02f4               f_calculate_amplitude:
1143  02f4 89            	pushw	x
1144  02f5 520c          	subw	sp,#12
1145       0000000c      OFST:	set	12
1148                     ; 150 	uint32_t i = 0;
1150                     ; 151 	float max_val = -V_REF, min_val = V_REF;
1152  02f7 ce10b1        	ldw	x,L764+2
1153  02fa 1f03          	ldw	(OFST-9,sp),x
1154  02fc ce10af        	ldw	x,L764
1155  02ff 1f01          	ldw	(OFST-11,sp),x
1159  0301 ce10b5        	ldw	x,L774+2
1160  0304 1f07          	ldw	(OFST-5,sp),x
1161  0306 ce10b3        	ldw	x,L774
1162  0309 1f05          	ldw	(OFST-7,sp),x
1164                     ; 153 	for (i = 0; i < sample_size; i++) {
1166  030b 5f            	clrw	x
1167  030c 1f0b          	ldw	(OFST-1,sp),x
1168  030e 1f09          	ldw	(OFST-3,sp),x
1171  0310 2054          	jra	L705
1172  0312               L305:
1173                     ; 154 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1175  0312 1e0b          	ldw	x,(OFST-1,sp)
1176  0314 58            	sllw	x
1177  0315 58            	sllw	x
1178  0316 72fb0d        	addw	x,(OFST+1,sp)
1179  0319 8d000000      	callf	d_ltor
1181  031d 96            	ldw	x,sp
1182  031e 5c            	incw	x
1183  031f 8d000000      	callf	d_fcmp
1185  0323 2d11          	jrsle	L315
1188  0325 1e0b          	ldw	x,(OFST-1,sp)
1189  0327 58            	sllw	x
1190  0328 58            	sllw	x
1191  0329 72fb0d        	addw	x,(OFST+1,sp)
1192  032c 9093          	ldw	y,x
1193  032e ee02          	ldw	x,(2,x)
1194  0330 1f03          	ldw	(OFST-9,sp),x
1195  0332 93            	ldw	x,y
1196  0333 fe            	ldw	x,(x)
1197  0334 1f01          	ldw	(OFST-11,sp),x
1199  0336               L315:
1200                     ; 155 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1202  0336 1e0b          	ldw	x,(OFST-1,sp)
1203  0338 58            	sllw	x
1204  0339 58            	sllw	x
1205  033a 72fb0d        	addw	x,(OFST+1,sp)
1206  033d 8d000000      	callf	d_ltor
1208  0341 96            	ldw	x,sp
1209  0342 1c0005        	addw	x,#OFST-7
1210  0345 8d000000      	callf	d_fcmp
1212  0349 2e11          	jrsge	L515
1215  034b 1e0b          	ldw	x,(OFST-1,sp)
1216  034d 58            	sllw	x
1217  034e 58            	sllw	x
1218  034f 72fb0d        	addw	x,(OFST+1,sp)
1219  0352 9093          	ldw	y,x
1220  0354 ee02          	ldw	x,(2,x)
1221  0356 1f07          	ldw	(OFST-5,sp),x
1222  0358 93            	ldw	x,y
1223  0359 fe            	ldw	x,(x)
1224  035a 1f05          	ldw	(OFST-7,sp),x
1226  035c               L515:
1227                     ; 153 	for (i = 0; i < sample_size; i++) {
1229  035c 96            	ldw	x,sp
1230  035d 1c0009        	addw	x,#OFST-3
1231  0360 a601          	ld	a,#1
1232  0362 8d000000      	callf	d_lgadc
1235  0366               L705:
1238  0366 96            	ldw	x,sp
1239  0367 1c0009        	addw	x,#OFST-3
1240  036a 8d000000      	callf	d_ltor
1242  036e 96            	ldw	x,sp
1243  036f 1c0012        	addw	x,#OFST+6
1244  0372 8d000000      	callf	d_lcmp
1246  0376 259a          	jrult	L305
1247                     ; 157 	return (max_val - min_val);
1249  0378 96            	ldw	x,sp
1250  0379 5c            	incw	x
1251  037a 8d000000      	callf	d_ltor
1253  037e 96            	ldw	x,sp
1254  037f 1c0005        	addw	x,#OFST-7
1255  0382 8d000000      	callf	d_fsub
1259  0386 5b0e          	addw	sp,#14
1260  0388 87            	retf	
1304                     ; 161 void initialize_adc_buffer(float buffer[]) {
1305                     	switch	.text
1306  0389               f_initialize_adc_buffer:
1308  0389 89            	pushw	x
1309  038a 89            	pushw	x
1310       00000002      OFST:	set	2
1313                     ; 162 	uint16_t i = 0;
1315                     ; 163 	for (i = 0; i < NUM_SAMPLES; i++) {
1317  038b 5f            	clrw	x
1318  038c 1f01          	ldw	(OFST-1,sp),x
1320  038e               L145:
1321                     ; 164 		buffer[i] = -1;  // Reset each element of the ADC buffer
1323  038e 58            	sllw	x
1324  038f 58            	sllw	x
1325  0390 72fb03        	addw	x,(OFST+1,sp)
1326  0393 9093          	ldw	y,x
1327  0395 aeffff        	ldw	x,#65535
1328  0398 8d000000      	callf	d_itof
1330  039c 93            	ldw	x,y
1331  039d 8d000000      	callf	d_rtol
1333                     ; 163 	for (i = 0; i < NUM_SAMPLES; i++) {
1335  03a1 1e01          	ldw	x,(OFST-1,sp)
1336  03a3 5c            	incw	x
1337  03a4 1f01          	ldw	(OFST-1,sp),x
1341  03a6 a30400        	cpw	x,#1024
1342  03a9 25e3          	jrult	L145
1343                     ; 166 }
1346  03ab 5b04          	addw	sp,#4
1347  03ad 87            	retf	
1349                     .const:	section	.text
1350  0000               L745_buffer:
1351  0000 00000000      	dc.w	0,0
1352  0004 000000000000  	ds.b	4092
1488                     ; 168 float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
1489                     	switch	.text
1490  03ae               f_process_adc_signal:
1492  03ae 88            	push	a
1493  03af 96            	ldw	x,sp
1494  03b0 1d1021        	subw	x,#4129
1495  03b3 94            	ldw	sp,x
1496       00001021      OFST:	set	4129
1499                     ; 169 	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
1501  03b4 96            	ldw	x,sp
1502  03b5 1c001e        	addw	x,#OFST-4099
1503  03b8 90ae0000      	ldw	y,#L745_buffer
1504  03bc bf00          	ldw	c_x,x
1505  03be ae1000        	ldw	x,#4096
1506  03c1 8d000000      	callf	d_xymovl
1508                     ; 170 	unsigned long currentEdgeTime = 0;
1510                     ; 171 	float freqBuff = 0;
1512  03c5 5f            	clrw	x
1513  03c6 1f17          	ldw	(OFST-4106,sp),x
1514  03c8 1f15          	ldw	(OFST-4108,sp),x
1516                     ; 172 	int freqCount = 0;
1518  03ca 96            	ldw	x,sp
1519  03cb 905f          	clrw	y
1520  03cd df101e        	ldw	(OFST-3,x),y
1521                     ; 173 	uint16_t i = 0;
1523                     ; 174 	bool isChannel1 = (channel == VAR_SIGNAL);  // Check if the channel is for Signal 1 or Signal 2
1525  03d0 d61022        	ld	a,(OFST+1,x)
1526  03d3 a105          	cp	a,#5
1527  03d5 2605          	jrne	L641
1528  03d7 ae0001        	ldw	x,#1
1529  03da 2001          	jra	L051
1530  03dc               L641:
1531  03dc 5f            	clrw	x
1532  03dd               L051:
1533  03dd 01            	rrwa	x,a
1534  03de 6b1d          	ld	(OFST-4100,sp),a
1536                     ; 175 	lastEdgeTime = 0;                 // Reset last zero-crossing time
1538  03e0 5f            	clrw	x
1539  03e1 bf0a          	ldw	_lastEdgeTime+2,x
1540  03e3 bf08          	ldw	_lastEdgeTime,x
1541                     ; 177 	initialize_adc_buffer(buffer);
1543  03e5 96            	ldw	x,sp
1544  03e6 1c001e        	addw	x,#OFST-4099
1545  03e9 8d890389      	callf	f_initialize_adc_buffer
1547                     ; 180 	for (i = 0; i < NUM_SAMPLES; i++) {
1549  03ed 96            	ldw	x,sp
1550  03ee 905f          	clrw	y
1551  03f0 df1020        	ldw	(OFST-1,x),y
1552  03f3               L736:
1553                     ; 182 	buffer[i] = convert_adc_to_voltage(read_ADC_Channel(channel));
1555  03f3 96            	ldw	x,sp
1556  03f4 d61022        	ld	a,(OFST+1,x)
1557  03f7 8d000000      	callf	f_read_ADC_Channel
1559  03fb 8de005e0      	callf	f_convert_adc_to_voltage
1561  03ff 96            	ldw	x,sp
1562  0400 1c001e        	addw	x,#OFST-4099
1563  0403 1f0f          	ldw	(OFST-4114,sp),x
1565  0405 96            	ldw	x,sp
1566  0406 de1020        	ldw	x,(OFST-1,x)
1567  0409 58            	sllw	x
1568  040a 58            	sllw	x
1569  040b 72fb0f        	addw	x,(OFST-4114,sp)
1570  040e 8d000000      	callf	d_rtol
1572                     ; 184 	if (isChannel1 && (frequency != NULL)) { // Only calculate frequency for Signal 1 (Channel 1)
1574  0412 7b1d          	ld	a,(OFST-4100,sp)
1575  0414 2604ac350535  	jreq	L546
1577  041a 96            	ldw	x,sp
1578  041b d61027        	ld	a,(OFST+6,x)
1579  041e da1026        	or	a,(OFST+5,x)
1580  0421 27f3          	jreq	L546
1581                     ; 186 		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
1583  0423 d61021        	ld	a,(OFST+0,x)
1584  0426 da1020        	or	a,(OFST-1,x)
1585  0429 27eb          	jreq	L546
1587  042b ce10b9        	ldw	x,L124+2
1588  042e 89            	pushw	x
1589  042f ce10b7        	ldw	x,L124
1590  0432 89            	pushw	x
1591  0433 96            	ldw	x,sp
1592  0434 1c0022        	addw	x,#OFST-4095
1593  0437 1f13          	ldw	(OFST-4110,sp),x
1595  0439 96            	ldw	x,sp
1596  043a de1024        	ldw	x,(OFST+3,x)
1597  043d 58            	sllw	x
1598  043e 58            	sllw	x
1599  043f 72fb13        	addw	x,(OFST-4110,sp)
1600  0442 9093          	ldw	y,x
1601  0444 ee02          	ldw	x,(2,x)
1602  0446 89            	pushw	x
1603  0447 93            	ldw	x,y
1604  0448 fe            	ldw	x,(x)
1605  0449 89            	pushw	x
1606  044a 96            	ldw	x,sp
1607  044b 1c0026        	addw	x,#OFST-4091
1608  044e 1f15          	ldw	(OFST-4108,sp),x
1610  0450 96            	ldw	x,sp
1611  0451 de1028        	ldw	x,(OFST+7,x)
1612  0454 58            	sllw	x
1613  0455 58            	sllw	x
1614  0456 1d0004        	subw	x,#4
1615  0459 72fb15        	addw	x,(OFST-4108,sp)
1616  045c 9093          	ldw	y,x
1617  045e ee02          	ldw	x,(2,x)
1618  0460 89            	pushw	x
1619  0461 93            	ldw	x,y
1620  0462 fe            	ldw	x,(x)
1621  0463 89            	pushw	x
1622  0464 8dab01ab      	callf	f_detectZeroCross
1624  0468 5b0c          	addw	sp,#12
1625  046a 4d            	tnz	a
1626  046b 27a9          	jreq	L546
1627                     ; 187 			currentEdgeTime = micros();
1629  046d 8d000000      	callf	f_micros
1631  0471 96            	ldw	x,sp
1632  0472 1c0019        	addw	x,#OFST-4104
1633  0475 8d000000      	callf	d_rtol
1636                     ; 188 			if (lastEdgeTime > 0) {  // Zero-crossing detected; calculate period and frequency
1638  0479 ae0008        	ldw	x,#_lastEdgeTime
1639  047c 8d000000      	callf	d_lzmp
1641  0480 2604ac2d052d  	jreq	L156
1642                     ; 189 				unsigned long period = currentEdgeTime - lastEdgeTime;  // Period in microseconds
1644  0486 96            	ldw	x,sp
1645  0487 1c0019        	addw	x,#OFST-4104
1646  048a 8d000000      	callf	d_ltor
1648  048e ae0008        	ldw	x,#_lastEdgeTime
1649  0491 8d000000      	callf	d_lsub
1651  0495 96            	ldw	x,sp
1652  0496 1c0011        	addw	x,#OFST-4112
1653  0499 8d000000      	callf	d_rtol
1656                     ; 190 				float singleFrequency = calculate_frequency(period);   // Calculate frequency in Hz
1658  049d 1e13          	ldw	x,(OFST-4110,sp)
1659  049f 89            	pushw	x
1660  04a0 1e13          	ldw	x,(OFST-4110,sp)
1661  04a2 89            	pushw	x
1662  04a3 8deb05eb      	callf	f_calculate_frequency
1664  04a7 5b04          	addw	sp,#4
1665  04a9 96            	ldw	x,sp
1666  04aa 1c0011        	addw	x,#OFST-4112
1667  04ad 8d000000      	callf	d_rtol
1670                     ; 192 				freqCount++;
1672  04b1 96            	ldw	x,sp
1673  04b2 9093          	ldw	y,x
1674  04b4 de101e        	ldw	x,(OFST-3,x)
1675  04b7 5c            	incw	x
1676  04b8 90df101e      	ldw	(OFST-3,y),x
1677                     ; 194 				if (freqCount == 2) {  // Stop after detecting 2 zero-crossings
1679  04bc 96            	ldw	x,sp
1680  04bd 9093          	ldw	y,x
1681  04bf 90de101e      	ldw	y,(OFST-3,y)
1682  04c3 90a30002      	cpw	y,#2
1683  04c7 2664          	jrne	L156
1684                     ; 195 					count = i;  // Limit used for amplitude calculation within this range
1686  04c9 de1020        	ldw	x,(OFST-1,x)
1687  04cc bf12          	ldw	_count,x
1688                     ; 197 					*amplitude = calculate_amplitude(buffer, (freqCount > 0 ? count : NUM_SAMPLES));
1690  04ce 5f            	clrw	x
1691  04cf 1f0f          	ldw	(OFST-4114,sp),x
1693  04d1 96            	ldw	x,sp
1694  04d2 de101e        	ldw	x,(OFST-3,x)
1695  04d5 130f          	cpw	x,(OFST-4114,sp)
1696  04d7 2d04          	jrsle	L071
1697  04d9 be12          	ldw	x,_count
1698  04db 2003          	jra	L271
1699  04dd               L071:
1700  04dd ae0400        	ldw	x,#1024
1701  04e0               L271:
1702  04e0 8d000000      	callf	d_uitolx
1704  04e4 be02          	ldw	x,c_lreg+2
1705  04e6 89            	pushw	x
1706  04e7 be00          	ldw	x,c_lreg
1707  04e9 89            	pushw	x
1708  04ea 96            	ldw	x,sp
1709  04eb 1c0022        	addw	x,#OFST-4095
1710  04ee 8df402f4      	callf	f_calculate_amplitude
1712  04f2 5b04          	addw	sp,#4
1713  04f4 96            	ldw	x,sp
1714  04f5 de1028        	ldw	x,(OFST+7,x)
1715  04f8 8d000000      	callf	d_rtol
1717                     ; 200 					if (isChannel1 && freqCount > 0) {
1719  04fc 7b1d          	ld	a,(OFST-4100,sp)
1720  04fe 2721          	jreq	L556
1722  0500 5f            	clrw	x
1723  0501 1f0f          	ldw	(OFST-4114,sp),x
1725  0503 96            	ldw	x,sp
1726  0504 de101e        	ldw	x,(OFST-3,x)
1727  0507 130f          	cpw	x,(OFST-4114,sp)
1728  0509 2d16          	jrsle	L556
1729                     ; 201 						*frequency = singleFrequency;  // Calculate average frequency
1731  050b 96            	ldw	x,sp
1732  050c de1026        	ldw	x,(OFST+5,x)
1733  050f 7b14          	ld	a,(OFST-4109,sp)
1734  0511 e703          	ld	(3,x),a
1735  0513 7b13          	ld	a,(OFST-4110,sp)
1736  0515 e702          	ld	(2,x),a
1737  0517 7b12          	ld	a,(OFST-4111,sp)
1738  0519 e701          	ld	(1,x),a
1739  051b 7b11          	ld	a,(OFST-4112,sp)
1741  051d acce05ce      	jpf	LC003
1742  0521               L556:
1743                     ; 203 					else if (isChannel1) {
1745  0521 7b1d          	ld	a,(OFST-4100,sp)
1746  0523 2604accf05cf  	jreq	L566
1747                     ; 204 						*frequency = 0;  // No crossings detected, return 0 frequency
1748                     ; 206 					return *amplitude;
1751  0529 acc305c3      	jpf	LC004
1752  052d               L156:
1753                     ; 209 			lastEdgeTime = currentEdgeTime;  // Update last edge time
1755  052d 1e1b          	ldw	x,(OFST-4102,sp)
1756  052f bf0a          	ldw	_lastEdgeTime+2,x
1757  0531 1e19          	ldw	x,(OFST-4104,sp)
1758  0533 bf08          	ldw	_lastEdgeTime,x
1759  0535               L546:
1760                     ; 214 	delay_us(1000000 / SAMPLE_RATE);
1762  0535 ae1a0a        	ldw	x,#6666
1763  0538 8d000000      	callf	f_delay_us
1765                     ; 180 	for (i = 0; i < NUM_SAMPLES; i++) {
1767  053c 96            	ldw	x,sp
1768  053d 9093          	ldw	y,x
1769  053f de1020        	ldw	x,(OFST-1,x)
1770  0542 5c            	incw	x
1771  0543 90df1020      	ldw	(OFST-1,y),x
1774  0547 96            	ldw	x,sp
1775  0548 9093          	ldw	y,x
1776  054a 90de1020      	ldw	y,(OFST-1,y)
1777  054e 90a30400      	cpw	y,#1024
1778  0552 2404acf303f3  	jrult	L736
1779                     ; 218 	*amplitude = calculate_amplitude(buffer, (freqCount > 0 ? count : NUM_SAMPLES));
1781  0558 5f            	clrw	x
1782  0559 1f0f          	ldw	(OFST-4114,sp),x
1784  055b 96            	ldw	x,sp
1785  055c de101e        	ldw	x,(OFST-3,x)
1786  055f 130f          	cpw	x,(OFST-4114,sp)
1787  0561 2d04          	jrsle	L002
1788  0563 be12          	ldw	x,_count
1789  0565 2003          	jra	L202
1790  0567               L002:
1791  0567 ae0400        	ldw	x,#1024
1792  056a               L202:
1793  056a 8d000000      	callf	d_uitolx
1795  056e be02          	ldw	x,c_lreg+2
1796  0570 89            	pushw	x
1797  0571 be00          	ldw	x,c_lreg
1798  0573 89            	pushw	x
1799  0574 96            	ldw	x,sp
1800  0575 1c0022        	addw	x,#OFST-4095
1801  0578 8df402f4      	callf	f_calculate_amplitude
1803  057c 5b04          	addw	sp,#4
1804  057e 96            	ldw	x,sp
1805  057f de1028        	ldw	x,(OFST+7,x)
1806  0582 8d000000      	callf	d_rtol
1808                     ; 221 	if (isChannel1 && freqCount > 0) {
1810  0586 0d1d          	tnz	(OFST-4100,sp)
1811  0588 2735          	jreq	L366
1813  058a 5f            	clrw	x
1814  058b 1f0f          	ldw	(OFST-4114,sp),x
1816  058d 96            	ldw	x,sp
1817  058e de101e        	ldw	x,(OFST-3,x)
1818  0591 130f          	cpw	x,(OFST-4114,sp)
1819  0593 2d2a          	jrsle	L366
1820                     ; 222 		*frequency = freqBuff / freqCount;  // Calculate average frequency
1822  0595 96            	ldw	x,sp
1823  0596 de101e        	ldw	x,(OFST-3,x)
1824  0599 8d000000      	callf	d_itof
1826  059d 96            	ldw	x,sp
1827  059e 1c000d        	addw	x,#OFST-4116
1828  05a1 8d000000      	callf	d_rtol
1831  05a5 96            	ldw	x,sp
1832  05a6 1c0015        	addw	x,#OFST-4108
1833  05a9 8d000000      	callf	d_ltor
1835  05ad 96            	ldw	x,sp
1836  05ae 1c000d        	addw	x,#OFST-4116
1837  05b1 8d000000      	callf	d_fdiv
1839  05b5 96            	ldw	x,sp
1840  05b6 de1026        	ldw	x,(OFST+5,x)
1841  05b9 8d000000      	callf	d_rtol
1844  05bd 2010          	jra	L566
1845  05bf               L366:
1846                     ; 224 	else if (isChannel1) {
1848  05bf 7b1d          	ld	a,(OFST-4100,sp)
1849  05c1 270c          	jreq	L566
1850                     ; 225 		*frequency = 0;  // No crossings detected, return 0 frequency
1852  05c3               LC004:
1854  05c3 96            	ldw	x,sp
1855  05c4 de1026        	ldw	x,(OFST+5,x)
1856  05c7 4f            	clr	a
1857  05c8 e703          	ld	(3,x),a
1858  05ca e702          	ld	(2,x),a
1859  05cc e701          	ld	(1,x),a
1860  05ce               LC003:
1861  05ce f7            	ld	(x),a
1862  05cf               L566:
1863                     ; 228 	return *amplitude;  // Always return amplitude
1868  05cf 96            	ldw	x,sp
1869  05d0 de1028        	ldw	x,(OFST+7,x)
1870  05d3 8d000000      	callf	d_ltor
1872  05d7 9096          	ldw	y,sp
1873  05d9 72a91022      	addw	y,#4130
1874  05dd 9094          	ldw	sp,y
1875  05df 87            	retf	
1909                     ; 232 float convert_adc_to_voltage(unsigned int adcValue) {
1910                     	switch	.text
1911  05e0               f_convert_adc_to_voltage:
1915                     ; 233 	return adcValue * (V_REF / ADC_MAX_VALUE);
1917  05e0 8d000000      	callf	d_uitof
1919  05e4 ae10ab        	ldw	x,#L317
1923  05e7 ac000000      	jpf	d_fmul
1957                     ; 237 float calculate_frequency(unsigned long period) {
1958                     	switch	.text
1959  05eb               f_calculate_frequency:
1961  05eb 5204          	subw	sp,#4
1962       00000004      OFST:	set	4
1965                     ; 238 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
1967  05ed 96            	ldw	x,sp
1968  05ee 1c0008        	addw	x,#OFST+4
1969  05f1 8d000000      	callf	d_ltor
1971  05f5 8d000000      	callf	d_ultof
1973  05f9 ae10a3        	ldw	x,#L157
1974  05fc 8d000000      	callf	d_fdiv
1976  0600 96            	ldw	x,sp
1977  0601 5c            	incw	x
1978  0602 8d000000      	callf	d_rtol
1981  0606 ae10a7        	ldw	x,#L147
1982  0609 8d000000      	callf	d_ltor
1984  060d 96            	ldw	x,sp
1985  060e 5c            	incw	x
1986  060f 8d000000      	callf	d_fdiv
1990  0613 5b04          	addw	sp,#4
1991  0615 87            	retf	
2053                     ; 242 void output_results(float frequency, float amplitude, float FDR_Voltage) {
2054                     	switch	.text
2055  0616               f_output_results:
2057  0616 5228          	subw	sp,#40
2058       00000028      OFST:	set	40
2061                     ; 248 	sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,\0", frequency, amplitude, amplitude/4.7, FDR_Voltage);
2063  0618 1e36          	ldw	x,(OFST+14,sp)
2064  061a 89            	pushw	x
2065  061b 1e36          	ldw	x,(OFST+14,sp)
2066  061d 89            	pushw	x
2067  061e 96            	ldw	x,sp
2068  061f 1c0034        	addw	x,#OFST+12
2069  0622 8d000000      	callf	d_ltor
2071  0626 ae1170        	ldw	x,#L731
2072  0629 8d000000      	callf	d_fdiv
2074  062d be02          	ldw	x,c_lreg+2
2075  062f 89            	pushw	x
2076  0630 be00          	ldw	x,c_lreg
2077  0632 89            	pushw	x
2078  0633 1e3a          	ldw	x,(OFST+18,sp)
2079  0635 89            	pushw	x
2080  0636 1e3a          	ldw	x,(OFST+18,sp)
2081  0638 89            	pushw	x
2082  0639 1e3a          	ldw	x,(OFST+18,sp)
2083  063b 89            	pushw	x
2084  063c 1e3a          	ldw	x,(OFST+18,sp)
2085  063e 89            	pushw	x
2086  063f ae108d        	ldw	x,#L7001
2087  0642 89            	pushw	x
2088  0643 96            	ldw	x,sp
2089  0644 1c0013        	addw	x,#OFST-21
2090  0647 8d000000      	callf	f_sprintf
2092  064b 5b3a          	addw	sp,#58
2093                     ; 253 }
2096  064d 87            	retf	
2132                     ; 256 void send_square_pulse(uint16_t duration_ms) {
2133                     	switch	.text
2134  064e               f_send_square_pulse:
2136  064e 89            	pushw	x
2137       00000000      OFST:	set	0
2140                     ; 257 	GPIO_WriteHigh(GPIOC, GPIO_PIN_4); // Set square pulse pin high
2142  064f 4b10          	push	#16
2143  0651 ae500a        	ldw	x,#20490
2144  0654 8d000000      	callf	f_GPIO_WriteHigh
2146  0658 84            	pop	a
2147                     ; 258 	delay_ms(duration_ms);            // Wait for the pulse duration
2149  0659 1e01          	ldw	x,(OFST+1,sp)
2150  065b 8d000000      	callf	f_delay_ms
2152                     ; 259 	GPIO_WriteLow(GPIOC, GPIO_PIN_4); // Set square pulse pin low
2154  065f 4b10          	push	#16
2155  0661 ae500a        	ldw	x,#20490
2156  0664 8d000000      	callf	f_GPIO_WriteLow
2158                     ; 260 }
2161  0668 5b03          	addw	sp,#3
2162  066a 87            	retf	
2199                     ; 263 void send_pulse_commutation(uint16_t duration_ms) {
2200                     	switch	.text
2201  066b               f_send_pulse_commutation:
2203  066b 89            	pushw	x
2204       00000000      OFST:	set	0
2207                     ; 264 	GPIO_WriteHigh(GPIOC, GPIO_PIN_2); // Set square pulse pin high
2209  066c 4b04          	push	#4
2210  066e ae500a        	ldw	x,#20490
2211  0671 8d000000      	callf	f_GPIO_WriteHigh
2213  0675 84            	pop	a
2214                     ; 265 	delay_ms(duration_ms);            // Wait for the pulse duration
2216  0676 1e01          	ldw	x,(OFST+1,sp)
2217  0678 8d000000      	callf	f_delay_ms
2219                     ; 266 	GPIO_WriteLow(GPIOC, GPIO_PIN_2); // Set square pulse pin low
2221  067c 4b04          	push	#4
2222  067e ae500a        	ldw	x,#20490
2223  0681 8d000000      	callf	f_GPIO_WriteLow
2225                     ; 267 }
2228  0685 5b03          	addw	sp,#3
2229  0687 87            	retf	
2264                     ; 270 bool check_signal_dc(float amplitude) {
2265                     	switch	.text
2266  0688               f_check_signal_dc:
2268       00000000      OFST:	set	0
2271                     ; 271 	if (amplitude == 0) {
2273  0688 7b04          	ld	a,(OFST+4,sp)
2274  068a 2606          	jrne	L3601
2275                     ; 272 		isThyristorON = true;
2277  068c 35010014      	mov	_isThyristorON,#1
2278                     ; 273 		return true;
2280  0690 4c            	inc	a
2283  0691 87            	retf	
2284  0692               L3601:
2285                     ; 275 		isThyristorON = false;
2287  0692 3f14          	clr	_isThyristorON
2288                     ; 276 		return false;
2290  0694 4f            	clr	a
2293  0695 87            	retf	
2340                     ; 280 void configure_set_frequency(void) {
2341                     	switch	.text
2342  0696               f_configure_set_frequency:
2344  0696 5218          	subw	sp,#24
2345       00000018      OFST:	set	24
2348                     ; 282 		float new_frequency = 5.0; // Convert string to float
2350                     ; 283     printf("Enter new set frequency (0.3 - 5 Hz):\n");
2352  0698 ae1066        	ldw	x,#L1111
2353  069b 8d000000      	callf	f_printf
2355                     ; 285     UART3_ReceiveString(buffer, sizeof(buffer)); // Receive user input
2357  069f ae0014        	ldw	x,#20
2358  06a2 89            	pushw	x
2359  06a3 96            	ldw	x,sp
2360  06a4 1c0003        	addw	x,#OFST-21
2361  06a7 8d000000      	callf	f_UART3_ReceiveString
2363  06ab 85            	popw	x
2364                     ; 286     new_frequency = atof(buffer); // Convert string to float
2366  06ac 96            	ldw	x,sp
2367  06ad 5c            	incw	x
2368  06ae 8d000000      	callf	f_atof
2370  06b2 96            	ldw	x,sp
2371  06b3 1c0015        	addw	x,#OFST-3
2372  06b6 8d000000      	callf	d_rtol
2375                     ; 289     if (new_frequency >= 0.3 && new_frequency <= 5.0) {
2377  06ba 96            	ldw	x,sp
2378  06bb 1c0015        	addw	x,#OFST-3
2379  06be 8d000000      	callf	d_ltor
2381  06c2 ae1062        	ldw	x,#L1211
2382  06c5 8d000000      	callf	d_fcmp
2384  06c9 2f22          	jrslt	L3111
2386  06cb 96            	ldw	x,sp
2387  06cc 1c0015        	addw	x,#OFST-3
2388  06cf 8d000000      	callf	d_ltor
2390  06d3 ae116c        	ldw	x,#L151
2391  06d6 8d000000      	callf	d_fcmp
2393  06da 2c11          	jrsgt	L3111
2394                     ; 291         printf("Set frequency updated to: %.2f Hz\n", new_frequency);
2396  06dc 1e17          	ldw	x,(OFST-1,sp)
2397  06de 89            	pushw	x
2398  06df 1e17          	ldw	x,(OFST-1,sp)
2399  06e1 89            	pushw	x
2400  06e2 ae103f        	ldw	x,#L5211
2401  06e5 8d000000      	callf	f_printf
2403  06e9 5b04          	addw	sp,#4
2405  06eb 2007          	jra	L7211
2406  06ed               L3111:
2407                     ; 293         printf("Invalid frequency. Please enter a value between 0.3 and 5 Hz.\n");
2409  06ed ae1000        	ldw	x,#L1311
2410  06f0 8d000000      	callf	f_printf
2412  06f4               L7211:
2413                     ; 295 }
2416  06f4 5b18          	addw	sp,#24
2417  06f6 87            	retf	
2429                     	xdef	f_main
2430                     	xdef	f_configure_set_frequency
2431                     	xdef	f_calculate_frequency
2432                     	xdef	f_convert_adc_to_voltage
2433                     	xdef	f_process_adc_signal
2434                     	xdef	f_calculate_amplitude
2435                     	xdef	f_output_results
2436                     	xdef	f_initialize_adc_buffer
2437                     	xdef	f_check_signal_dc
2438                     	xdef	f_send_pulse_commutation
2439                     	xdef	f_send_square_pulse
2440                     	xdef	f_check_negative_zero_crossing
2441                     	xdef	f_detect_negative_zero_cross
2442                     	xdef	f_detectZeroCross
2443                     	xdef	f_detectPosZeroCross
2444                     	xdef	f_initialize_system
2445                     	xdef	_isThyristorON
2446                     	xdef	_count
2447                     	xdef	_crossingType
2448                     	xdef	_currentEdgeTime
2449                     	xdef	_lastEdgeTime
2450                     	xdef	_sine1_amplitude
2451                     	xdef	_sine1_frequency
2452                     	xref	f_read_ADC_Channel
2453                     	xref	f_UART3_ReceiveString
2454                     	xref	f_GPIO_setup
2455                     	xref	f_ADC2_setup
2456                     	xref	f_UART3_setup
2457                     	xref	f_clock_setup
2458                     	xref	f_I2CInit
2459                     	xref	f_EEPROM_Config
2460                     	xref	f_micros
2461                     	xref	f_delay_us
2462                     	xref	f_delay_ms
2463                     	xref	f_TIM4_Config
2464                     	xref	f_atof
2465                     	xref	f_sprintf
2466                     	xref	f_printf
2467                     	xref	f_GPIO_WriteLow
2468                     	xref	f_GPIO_WriteHigh
2469                     	switch	.const
2470  1000               L1311:
2471  1000 496e76616c69  	dc.b	"Invalid frequency."
2472  1012 20506c656173  	dc.b	" Please enter a va"
2473  1024 6c7565206265  	dc.b	"lue between 0.3 an"
2474  1036 64203520487a  	dc.b	"d 5 Hz.",10,0
2475  103f               L5211:
2476  103f 536574206672  	dc.b	"Set frequency upda"
2477  1051 74656420746f  	dc.b	"ted to: %.2f Hz",10,0
2478  1062               L1211:
2479  1062 3e999999      	dc.w	16025,-26215
2480  1066               L1111:
2481  1066 456e74657220  	dc.b	"Enter new set freq"
2482  1078 75656e637920  	dc.b	"uency (0.3 - 5 Hz)"
2483  108a 3a0a00        	dc.b	":",10,0
2484  108d               L7001:
2485  108d 252e33662c25  	dc.b	"%.3f,%.3f,%.3f,%.3"
2486  109f 662c0000      	dc.b	"f,",0,0
2487  10a3               L157:
2488  10a3 49742400      	dc.w	18804,9216
2489  10a7               L147:
2490  10a7 3f800000      	dc.w	16256,0
2491  10ab               L317:
2492  10ab 3b935809      	dc.w	15251,22537
2493  10af               L764:
2494  10af c0933333      	dc.w	-16237,13107
2495  10b3               L774:
2496  10b3 40933333      	dc.w	16531,13107
2497  10b7               L124:
2498  10b7 4028f5c2      	dc.w	16424,-2622
2499  10bb               L132:
2500  10bb 53797374656d  	dc.b	"System Initializat"
2501  10cd 696f6e20436f  	dc.b	"ion Completed",10
2502  10db 0d00          	dc.b	13,0
2503  10dd               L712:
2504  10dd 566172416d70  	dc.b	"VarAmplitude Not b"
2505  10ef 656c6f772031  	dc.b	"elow 10 mv.",10,0
2506  10fc               L312:
2507  10fc 566172416d70  	dc.b	"VarAmplitude below"
2508  110e 203130206d76  	dc.b	" 10 mv.",10,0
2509  1117               L702:
2510  1117 3c23d70a      	dc.w	15395,-10486
2511  111b               L771:
2512  111b 5369676e616c  	dc.b	"Signal 1 AC and Va"
2513  112d 72416d706c69  	dc.b	"rAmplitude: %f.",10,0
2514  113e               L361:
2515  113e 5369676e616c  	dc.b	"Signal 1 DC.",10,0
2516  114c               L551:
2517  114c 467265717565  	dc.b	"Frequency Below Se"
2518  115e 742046726571  	dc.b	"t Frequency.",10,0
2519  116c               L151:
2520  116c 40a00000      	dc.w	16544,0
2521  1170               L731:
2522  1170 40966666      	dc.w	16534,26214
2523  1174               L131:
2524  1174 204672657175  	dc.b	" Frequency: %.3f, "
2525  1186 416d706c6974  	dc.b	"Amplitude: %.3f, C"
2526  1198 757272656e74  	dc.b	"urrent: %.3f, FDR_"
2527  11aa 566f6c746167  	dc.b	"Voltage: %.3f",10,0
2528                     	xref.b	c_lreg
2529                     	xref.b	c_x
2530                     	xref.b	c_y
2550                     	xref	d_ultof
2551                     	xref	d_fmul
2552                     	xref	d_uitof
2553                     	xref	d_uitolx
2554                     	xref	d_lsub
2555                     	xref	d_lzmp
2556                     	xref	d_xymovl
2557                     	xref	d_itof
2558                     	xref	d_fsub
2559                     	xref	d_lcmp
2560                     	xref	d_lgadc
2561                     	xref	d_fcmp
2562                     	xref	d_fdiv
2563                     	xref	d_ltor
2564                     	xref	d_rtol
2565                     	end
