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
 240  001c 8db503b5      	callf	f_process_adc_signal
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
 269  0044 8db503b5      	callf	f_process_adc_signal
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
 287  0060 ae118e        	ldw	x,#L731
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
 302  0079 ae1192        	ldw	x,#L131
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
 320  0094 8d1d061d      	callf	f_output_results
 322  0098 5b0c          	addw	sp,#12
 323                     ; 31 			if (VAR_frequency <= SET_FREQ){
 325  009a 96            	ldw	x,sp
 326  009b 5c            	incw	x
 327  009c 8d000000      	callf	d_ltor
 329  00a0 ae118a        	ldw	x,#L151
 330  00a3 8d000000      	callf	d_fcmp
 332  00a7 2c90          	jrsgt	L521
 333                     ; 32 				printf("Frequency Below Set Frequency.\n");
 335  00a9 ae116a        	ldw	x,#L551
 336  00ac 8d000000      	callf	f_printf
 338  00b0               L75:
 339                     ; 35 				NEG_Cross:
 339                     ; 36 				if(check_negative_zero_crossing()){     // Wait for negative zero crossing
 341  00b0 8db102b1      	callf	f_check_negative_zero_crossing
 343  00b4 4d            	tnz	a
 344  00b5 27f9          	jreq	L75
 345                     ; 37 					send_square_pulse(5); 
 347  00b7 ae0005        	ldw	x,#5
 348  00ba 8d550655      	callf	f_send_square_pulse
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
 365  00d1 8db503b5      	callf	f_process_adc_signal
 367  00d5 5b04          	addw	sp,#4
 368  00d7 96            	ldw	x,sp
 369  00d8 1c0009        	addw	x,#OFST-3
 370  00db 8d000000      	callf	d_rtol
 373                     ; 42 					if(check_signal_dc(VAR_amplitude)){
 375  00df 1e0b          	ldw	x,(OFST-1,sp)
 376  00e1 89            	pushw	x
 377  00e2 1e0b          	ldw	x,(OFST-1,sp)
 378  00e4 89            	pushw	x
 379  00e5 8d8f068f      	callf	f_check_signal_dc
 381  00e9 5b04          	addw	sp,#4
 382  00eb 4d            	tnz	a
 383  00ec 2742          	jreq	L161
 384                     ; 43 						printf("Signal 1 DC.\n");
 386  00ee ae115c        	ldw	x,#L361
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
 406  0108 8db503b5      	callf	f_process_adc_signal
 408  010c 5b04          	addw	sp,#4
 409  010e 96            	ldw	x,sp
 410  010f 1c0005        	addw	x,#OFST-7
 411  0112 8d000000      	callf	d_rtol
 414                     ; 49 							if(isThyristorON){
 416  0116 b614          	ld	a,_isThyristorON
 417  0118 270b          	jreq	L171
 418                     ; 50 								send_square_pulse(3000);
 420  011a ae0bb8        	ldw	x,#3000
 421  011d 8d550655      	callf	f_send_square_pulse
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
 447  0136 ae1139        	ldw	x,#L771
 448  0139 8d000000      	callf	f_printf
 450  013d 5b04          	addw	sp,#4
 451                     ; 64 							if (VAR_amplitude < AC_AMPLITUDE_THRESHOLD) {
 453  013f 96            	ldw	x,sp
 454  0140 1c0009        	addw	x,#OFST-3
 455  0143 8d000000      	callf	d_ltor
 457  0147 ae1135        	ldw	x,#L702
 458  014a 8d000000      	callf	d_fcmp
 460  014e 2e23          	jrsge	L102
 461                     ; 65 								printf("VarAmplitude below 10 mv.\n");
 463  0150 ae111a        	ldw	x,#L312
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
 481  016b 8d550655      	callf	f_send_square_pulse
 484  016f acb000b0      	jra	L75
 485  0173               L102:
 486                     ; 71 								printf("VarAmplitude Not below 10 mv.\n");
 488  0173 ae10fb        	ldw	x,#L712
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
 564  01a4 ae10d9        	ldw	x,#L132
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
1007                     ; 130 bool check_negative_zero_crossing(void) {
1008                     	switch	.text
1009  02b1               f_check_negative_zero_crossing:
1011  02b1 5208          	subw	sp,#8
1012       00000008      OFST:	set	8
1015                     ; 131 	float prev_adc_value = 0;  // Store previous ADC sample value
1017  02b3 5f            	clrw	x
1018  02b4 1f03          	ldw	(OFST-5,sp),x
1019                     ; 132 	float current_adc_value = 0;  // Store current ADC sample value
1021  02b6               L704:
1022  02b6 1f01          	ldw	(OFST-7,sp),x
1024                     ; 136 		current_adc_value = convert_adc_to_voltage(read_ADC_Channel(VAR_SIGNAL));
1026  02b8 a605          	ld	a,#5
1027  02ba 8d000000      	callf	f_read_ADC_Channel
1029  02be 8de705e7      	callf	f_convert_adc_to_voltage
1031  02c2 96            	ldw	x,sp
1032  02c3 1c0005        	addw	x,#OFST-3
1033  02c6 8d000000      	callf	d_rtol
1036                     ; 138 		if (detect_negative_zero_cross(prev_adc_value, current_adc_value, ZEROCROSS_THRESHOLD)) {
1038  02ca ce10d7        	ldw	x,L124+2
1039  02cd 89            	pushw	x
1040  02ce ce10d5        	ldw	x,L124
1041  02d1 89            	pushw	x
1042  02d2 1e0b          	ldw	x,(OFST+3,sp)
1043  02d4 89            	pushw	x
1044  02d5 1e0b          	ldw	x,(OFST+3,sp)
1045  02d7 89            	pushw	x
1046  02d8 1e0b          	ldw	x,(OFST+3,sp)
1047  02da 89            	pushw	x
1048  02db 1e0b          	ldw	x,(OFST+3,sp)
1049  02dd 89            	pushw	x
1050  02de 8d880288      	callf	f_detect_negative_zero_cross
1052  02e2 5b0c          	addw	sp,#12
1053  02e4 4d            	tnz	a
1054  02e5 270c          	jreq	L314
1055                     ; 139 			printf("Negative zero crossing detected!\n");
1057  02e7 ae10b3        	ldw	x,#L524
1058  02ea 8d000000      	callf	f_printf
1060                     ; 140 			return true;
1062  02ee a601          	ld	a,#1
1065  02f0 5b08          	addw	sp,#8
1066  02f2 87            	retf	
1067  02f3               L314:
1068                     ; 143 		prev_adc_value = current_adc_value;
1070  02f3 1e07          	ldw	x,(OFST-1,sp)
1071  02f5 1f03          	ldw	(OFST-5,sp),x
1072  02f7 1e05          	ldw	x,(OFST-3,sp)
1074  02f9 20bb          	jra	L704
1145                     ; 149 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
1146                     	switch	.text
1147  02fb               f_calculate_amplitude:
1149  02fb 89            	pushw	x
1150  02fc 520c          	subw	sp,#12
1151       0000000c      OFST:	set	12
1154                     ; 150 	uint32_t i = 0;
1156                     ; 151 	float max_val = -V_REF, min_val = V_REF;
1158  02fe ce10b1        	ldw	x,L174+2
1159  0301 1f03          	ldw	(OFST-9,sp),x
1160  0303 ce10af        	ldw	x,L174
1161  0306 1f01          	ldw	(OFST-11,sp),x
1165  0308 ce118c        	ldw	x,L151+2
1166  030b 1f07          	ldw	(OFST-5,sp),x
1167  030d ce118a        	ldw	x,L151
1168  0310 1f05          	ldw	(OFST-7,sp),x
1170                     ; 153 	for (i = 0; i < sample_size; i++) {
1172  0312 5f            	clrw	x
1173  0313 1f0b          	ldw	(OFST-1,sp),x
1174  0315 1f09          	ldw	(OFST-3,sp),x
1177  0317 2054          	jra	L105
1178  0319               L574:
1179                     ; 154 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1181  0319 1e0b          	ldw	x,(OFST-1,sp)
1182  031b 58            	sllw	x
1183  031c 58            	sllw	x
1184  031d 72fb0d        	addw	x,(OFST+1,sp)
1185  0320 8d000000      	callf	d_ltor
1187  0324 96            	ldw	x,sp
1188  0325 5c            	incw	x
1189  0326 8d000000      	callf	d_fcmp
1191  032a 2d11          	jrsle	L505
1194  032c 1e0b          	ldw	x,(OFST-1,sp)
1195  032e 58            	sllw	x
1196  032f 58            	sllw	x
1197  0330 72fb0d        	addw	x,(OFST+1,sp)
1198  0333 9093          	ldw	y,x
1199  0335 ee02          	ldw	x,(2,x)
1200  0337 1f03          	ldw	(OFST-9,sp),x
1201  0339 93            	ldw	x,y
1202  033a fe            	ldw	x,(x)
1203  033b 1f01          	ldw	(OFST-11,sp),x
1205  033d               L505:
1206                     ; 155 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1208  033d 1e0b          	ldw	x,(OFST-1,sp)
1209  033f 58            	sllw	x
1210  0340 58            	sllw	x
1211  0341 72fb0d        	addw	x,(OFST+1,sp)
1212  0344 8d000000      	callf	d_ltor
1214  0348 96            	ldw	x,sp
1215  0349 1c0005        	addw	x,#OFST-7
1216  034c 8d000000      	callf	d_fcmp
1218  0350 2e11          	jrsge	L705
1221  0352 1e0b          	ldw	x,(OFST-1,sp)
1222  0354 58            	sllw	x
1223  0355 58            	sllw	x
1224  0356 72fb0d        	addw	x,(OFST+1,sp)
1225  0359 9093          	ldw	y,x
1226  035b ee02          	ldw	x,(2,x)
1227  035d 1f07          	ldw	(OFST-5,sp),x
1228  035f 93            	ldw	x,y
1229  0360 fe            	ldw	x,(x)
1230  0361 1f05          	ldw	(OFST-7,sp),x
1232  0363               L705:
1233                     ; 153 	for (i = 0; i < sample_size; i++) {
1235  0363 96            	ldw	x,sp
1236  0364 1c0009        	addw	x,#OFST-3
1237  0367 a601          	ld	a,#1
1238  0369 8d000000      	callf	d_lgadc
1241  036d               L105:
1244  036d 96            	ldw	x,sp
1245  036e 1c0009        	addw	x,#OFST-3
1246  0371 8d000000      	callf	d_ltor
1248  0375 96            	ldw	x,sp
1249  0376 1c0012        	addw	x,#OFST+6
1250  0379 8d000000      	callf	d_lcmp
1252  037d 259a          	jrult	L574
1253                     ; 157 	return (max_val - min_val);
1255  037f 96            	ldw	x,sp
1256  0380 5c            	incw	x
1257  0381 8d000000      	callf	d_ltor
1259  0385 96            	ldw	x,sp
1260  0386 1c0005        	addw	x,#OFST-7
1261  0389 8d000000      	callf	d_fsub
1265  038d 5b0e          	addw	sp,#14
1266  038f 87            	retf	
1310                     ; 161 void initialize_adc_buffer(float buffer[]) {
1311                     	switch	.text
1312  0390               f_initialize_adc_buffer:
1314  0390 89            	pushw	x
1315  0391 89            	pushw	x
1316       00000002      OFST:	set	2
1319                     ; 162 	uint16_t i = 0;
1321                     ; 163 	for (i = 0; i < NUM_SAMPLES; i++) {
1323  0392 5f            	clrw	x
1324  0393 1f01          	ldw	(OFST-1,sp),x
1326  0395               L335:
1327                     ; 164 		buffer[i] = -1;  // Reset each element of the ADC buffer
1329  0395 58            	sllw	x
1330  0396 58            	sllw	x
1331  0397 72fb03        	addw	x,(OFST+1,sp)
1332  039a 9093          	ldw	y,x
1333  039c aeffff        	ldw	x,#65535
1334  039f 8d000000      	callf	d_itof
1336  03a3 93            	ldw	x,y
1337  03a4 8d000000      	callf	d_rtol
1339                     ; 163 	for (i = 0; i < NUM_SAMPLES; i++) {
1341  03a8 1e01          	ldw	x,(OFST-1,sp)
1342  03aa 5c            	incw	x
1343  03ab 1f01          	ldw	(OFST-1,sp),x
1347  03ad a30400        	cpw	x,#1024
1348  03b0 25e3          	jrult	L335
1349                     ; 166 }
1352  03b2 5b04          	addw	sp,#4
1353  03b4 87            	retf	
1355                     .const:	section	.text
1356  0000               L145_buffer:
1357  0000 00000000      	dc.w	0,0
1358  0004 000000000000  	ds.b	4092
1494                     ; 168 float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
1495                     	switch	.text
1496  03b5               f_process_adc_signal:
1498  03b5 88            	push	a
1499  03b6 96            	ldw	x,sp
1500  03b7 1d1021        	subw	x,#4129
1501  03ba 94            	ldw	sp,x
1502       00001021      OFST:	set	4129
1505                     ; 169 	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
1507  03bb 96            	ldw	x,sp
1508  03bc 1c001e        	addw	x,#OFST-4099
1509  03bf 90ae0000      	ldw	y,#L145_buffer
1510  03c3 bf00          	ldw	c_x,x
1511  03c5 ae1000        	ldw	x,#4096
1512  03c8 8d000000      	callf	d_xymovl
1514                     ; 170 	unsigned long currentEdgeTime = 0;
1516                     ; 171 	float freqBuff = 0;
1518  03cc 5f            	clrw	x
1519  03cd 1f17          	ldw	(OFST-4106,sp),x
1520  03cf 1f15          	ldw	(OFST-4108,sp),x
1522                     ; 172 	int freqCount = 0;
1524  03d1 96            	ldw	x,sp
1525  03d2 905f          	clrw	y
1526  03d4 df101e        	ldw	(OFST-3,x),y
1527                     ; 173 	uint16_t i = 0;
1529                     ; 174 	bool isChannel1 = (channel == VAR_SIGNAL);  // Check if the channel is for Signal 1 or Signal 2
1531  03d7 d61022        	ld	a,(OFST+1,x)
1532  03da a105          	cp	a,#5
1533  03dc 2605          	jrne	L051
1534  03de ae0001        	ldw	x,#1
1535  03e1 2001          	jra	L251
1536  03e3               L051:
1537  03e3 5f            	clrw	x
1538  03e4               L251:
1539  03e4 01            	rrwa	x,a
1540  03e5 6b1d          	ld	(OFST-4100,sp),a
1542                     ; 175 	lastEdgeTime = 0;                 // Reset last zero-crossing time
1544  03e7 5f            	clrw	x
1545  03e8 bf0a          	ldw	_lastEdgeTime+2,x
1546  03ea bf08          	ldw	_lastEdgeTime,x
1547                     ; 177 	initialize_adc_buffer(buffer);
1549  03ec 96            	ldw	x,sp
1550  03ed 1c001e        	addw	x,#OFST-4099
1551  03f0 8d900390      	callf	f_initialize_adc_buffer
1553                     ; 180 	for (i = 0; i < NUM_SAMPLES; i++) {
1555  03f4 96            	ldw	x,sp
1556  03f5 905f          	clrw	y
1557  03f7 df1020        	ldw	(OFST-1,x),y
1558  03fa               L136:
1559                     ; 182 	buffer[i] = convert_adc_to_voltage(read_ADC_Channel(channel));
1561  03fa 96            	ldw	x,sp
1562  03fb d61022        	ld	a,(OFST+1,x)
1563  03fe 8d000000      	callf	f_read_ADC_Channel
1565  0402 8de705e7      	callf	f_convert_adc_to_voltage
1567  0406 96            	ldw	x,sp
1568  0407 1c001e        	addw	x,#OFST-4099
1569  040a 1f0f          	ldw	(OFST-4114,sp),x
1571  040c 96            	ldw	x,sp
1572  040d de1020        	ldw	x,(OFST-1,x)
1573  0410 58            	sllw	x
1574  0411 58            	sllw	x
1575  0412 72fb0f        	addw	x,(OFST-4114,sp)
1576  0415 8d000000      	callf	d_rtol
1578                     ; 184 	if (isChannel1 && (frequency != NULL)) { // Only calculate frequency for Signal 1 (Channel 1)
1580  0419 7b1d          	ld	a,(OFST-4100,sp)
1581  041b 2604ac3c053c  	jreq	L736
1583  0421 96            	ldw	x,sp
1584  0422 d61027        	ld	a,(OFST+6,x)
1585  0425 da1026        	or	a,(OFST+5,x)
1586  0428 27f3          	jreq	L736
1587                     ; 186 		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
1589  042a d61021        	ld	a,(OFST+0,x)
1590  042d da1020        	or	a,(OFST-1,x)
1591  0430 27eb          	jreq	L736
1593  0432 ce10d7        	ldw	x,L124+2
1594  0435 89            	pushw	x
1595  0436 ce10d5        	ldw	x,L124
1596  0439 89            	pushw	x
1597  043a 96            	ldw	x,sp
1598  043b 1c0022        	addw	x,#OFST-4095
1599  043e 1f13          	ldw	(OFST-4110,sp),x
1601  0440 96            	ldw	x,sp
1602  0441 de1024        	ldw	x,(OFST+3,x)
1603  0444 58            	sllw	x
1604  0445 58            	sllw	x
1605  0446 72fb13        	addw	x,(OFST-4110,sp)
1606  0449 9093          	ldw	y,x
1607  044b ee02          	ldw	x,(2,x)
1608  044d 89            	pushw	x
1609  044e 93            	ldw	x,y
1610  044f fe            	ldw	x,(x)
1611  0450 89            	pushw	x
1612  0451 96            	ldw	x,sp
1613  0452 1c0026        	addw	x,#OFST-4091
1614  0455 1f15          	ldw	(OFST-4108,sp),x
1616  0457 96            	ldw	x,sp
1617  0458 de1028        	ldw	x,(OFST+7,x)
1618  045b 58            	sllw	x
1619  045c 58            	sllw	x
1620  045d 1d0004        	subw	x,#4
1621  0460 72fb15        	addw	x,(OFST-4108,sp)
1622  0463 9093          	ldw	y,x
1623  0465 ee02          	ldw	x,(2,x)
1624  0467 89            	pushw	x
1625  0468 93            	ldw	x,y
1626  0469 fe            	ldw	x,(x)
1627  046a 89            	pushw	x
1628  046b 8dab01ab      	callf	f_detectZeroCross
1630  046f 5b0c          	addw	sp,#12
1631  0471 4d            	tnz	a
1632  0472 27a9          	jreq	L736
1633                     ; 187 			currentEdgeTime = micros();
1635  0474 8d000000      	callf	f_micros
1637  0478 96            	ldw	x,sp
1638  0479 1c0019        	addw	x,#OFST-4104
1639  047c 8d000000      	callf	d_rtol
1642                     ; 188 			if (lastEdgeTime > 0) {  // Zero-crossing detected; calculate period and frequency
1644  0480 ae0008        	ldw	x,#_lastEdgeTime
1645  0483 8d000000      	callf	d_lzmp
1647  0487 2604ac340534  	jreq	L346
1648                     ; 189 				unsigned long period = currentEdgeTime - lastEdgeTime;  // Period in microseconds
1650  048d 96            	ldw	x,sp
1651  048e 1c0019        	addw	x,#OFST-4104
1652  0491 8d000000      	callf	d_ltor
1654  0495 ae0008        	ldw	x,#_lastEdgeTime
1655  0498 8d000000      	callf	d_lsub
1657  049c 96            	ldw	x,sp
1658  049d 1c0011        	addw	x,#OFST-4112
1659  04a0 8d000000      	callf	d_rtol
1662                     ; 190 				float singleFrequency = calculate_frequency(period);   // Calculate frequency in Hz
1664  04a4 1e13          	ldw	x,(OFST-4110,sp)
1665  04a6 89            	pushw	x
1666  04a7 1e13          	ldw	x,(OFST-4110,sp)
1667  04a9 89            	pushw	x
1668  04aa 8df205f2      	callf	f_calculate_frequency
1670  04ae 5b04          	addw	sp,#4
1671  04b0 96            	ldw	x,sp
1672  04b1 1c0011        	addw	x,#OFST-4112
1673  04b4 8d000000      	callf	d_rtol
1676                     ; 192 				freqCount++;
1678  04b8 96            	ldw	x,sp
1679  04b9 9093          	ldw	y,x
1680  04bb de101e        	ldw	x,(OFST-3,x)
1681  04be 5c            	incw	x
1682  04bf 90df101e      	ldw	(OFST-3,y),x
1683                     ; 194 				if (freqCount == 2) {  // Stop after detecting 2 zero-crossings
1685  04c3 96            	ldw	x,sp
1686  04c4 9093          	ldw	y,x
1687  04c6 90de101e      	ldw	y,(OFST-3,y)
1688  04ca 90a30002      	cpw	y,#2
1689  04ce 2664          	jrne	L346
1690                     ; 195 					count = i;  // Limit used for amplitude calculation within this range
1692  04d0 de1020        	ldw	x,(OFST-1,x)
1693  04d3 bf12          	ldw	_count,x
1694                     ; 197 					*amplitude = calculate_amplitude(buffer, (freqCount > 0 ? count : NUM_SAMPLES));
1696  04d5 5f            	clrw	x
1697  04d6 1f0f          	ldw	(OFST-4114,sp),x
1699  04d8 96            	ldw	x,sp
1700  04d9 de101e        	ldw	x,(OFST-3,x)
1701  04dc 130f          	cpw	x,(OFST-4114,sp)
1702  04de 2d04          	jrsle	L271
1703  04e0 be12          	ldw	x,_count
1704  04e2 2003          	jra	L471
1705  04e4               L271:
1706  04e4 ae0400        	ldw	x,#1024
1707  04e7               L471:
1708  04e7 8d000000      	callf	d_uitolx
1710  04eb be02          	ldw	x,c_lreg+2
1711  04ed 89            	pushw	x
1712  04ee be00          	ldw	x,c_lreg
1713  04f0 89            	pushw	x
1714  04f1 96            	ldw	x,sp
1715  04f2 1c0022        	addw	x,#OFST-4095
1716  04f5 8dfb02fb      	callf	f_calculate_amplitude
1718  04f9 5b04          	addw	sp,#4
1719  04fb 96            	ldw	x,sp
1720  04fc de1028        	ldw	x,(OFST+7,x)
1721  04ff 8d000000      	callf	d_rtol
1723                     ; 200 					if (isChannel1 && freqCount > 0) {
1725  0503 7b1d          	ld	a,(OFST-4100,sp)
1726  0505 2721          	jreq	L746
1728  0507 5f            	clrw	x
1729  0508 1f0f          	ldw	(OFST-4114,sp),x
1731  050a 96            	ldw	x,sp
1732  050b de101e        	ldw	x,(OFST-3,x)
1733  050e 130f          	cpw	x,(OFST-4114,sp)
1734  0510 2d16          	jrsle	L746
1735                     ; 201 						*frequency = singleFrequency;  // Calculate average frequency
1737  0512 96            	ldw	x,sp
1738  0513 de1026        	ldw	x,(OFST+5,x)
1739  0516 7b14          	ld	a,(OFST-4109,sp)
1740  0518 e703          	ld	(3,x),a
1741  051a 7b13          	ld	a,(OFST-4110,sp)
1742  051c e702          	ld	(2,x),a
1743  051e 7b12          	ld	a,(OFST-4111,sp)
1744  0520 e701          	ld	(1,x),a
1745  0522 7b11          	ld	a,(OFST-4112,sp)
1747  0524 acd505d5      	jpf	LC003
1748  0528               L746:
1749                     ; 203 					else if (isChannel1) {
1751  0528 7b1d          	ld	a,(OFST-4100,sp)
1752  052a 2604acd605d6  	jreq	L756
1753                     ; 204 						*frequency = 0;  // No crossings detected, return 0 frequency
1754                     ; 206 					return *amplitude;
1757  0530 acca05ca      	jpf	LC004
1758  0534               L346:
1759                     ; 209 			lastEdgeTime = currentEdgeTime;  // Update last edge time
1761  0534 1e1b          	ldw	x,(OFST-4102,sp)
1762  0536 bf0a          	ldw	_lastEdgeTime+2,x
1763  0538 1e19          	ldw	x,(OFST-4104,sp)
1764  053a bf08          	ldw	_lastEdgeTime,x
1765  053c               L736:
1766                     ; 214 	delay_us(1000000 / SAMPLE_RATE);
1768  053c ae1a0a        	ldw	x,#6666
1769  053f 8d000000      	callf	f_delay_us
1771                     ; 180 	for (i = 0; i < NUM_SAMPLES; i++) {
1773  0543 96            	ldw	x,sp
1774  0544 9093          	ldw	y,x
1775  0546 de1020        	ldw	x,(OFST-1,x)
1776  0549 5c            	incw	x
1777  054a 90df1020      	ldw	(OFST-1,y),x
1780  054e 96            	ldw	x,sp
1781  054f 9093          	ldw	y,x
1782  0551 90de1020      	ldw	y,(OFST-1,y)
1783  0555 90a30400      	cpw	y,#1024
1784  0559 2404acfa03fa  	jrult	L136
1785                     ; 218 	*amplitude = calculate_amplitude(buffer, (freqCount > 0 ? count : NUM_SAMPLES));
1787  055f 5f            	clrw	x
1788  0560 1f0f          	ldw	(OFST-4114,sp),x
1790  0562 96            	ldw	x,sp
1791  0563 de101e        	ldw	x,(OFST-3,x)
1792  0566 130f          	cpw	x,(OFST-4114,sp)
1793  0568 2d04          	jrsle	L202
1794  056a be12          	ldw	x,_count
1795  056c 2003          	jra	L402
1796  056e               L202:
1797  056e ae0400        	ldw	x,#1024
1798  0571               L402:
1799  0571 8d000000      	callf	d_uitolx
1801  0575 be02          	ldw	x,c_lreg+2
1802  0577 89            	pushw	x
1803  0578 be00          	ldw	x,c_lreg
1804  057a 89            	pushw	x
1805  057b 96            	ldw	x,sp
1806  057c 1c0022        	addw	x,#OFST-4095
1807  057f 8dfb02fb      	callf	f_calculate_amplitude
1809  0583 5b04          	addw	sp,#4
1810  0585 96            	ldw	x,sp
1811  0586 de1028        	ldw	x,(OFST+7,x)
1812  0589 8d000000      	callf	d_rtol
1814                     ; 221 	if (isChannel1 && freqCount > 0) {
1816  058d 0d1d          	tnz	(OFST-4100,sp)
1817  058f 2735          	jreq	L556
1819  0591 5f            	clrw	x
1820  0592 1f0f          	ldw	(OFST-4114,sp),x
1822  0594 96            	ldw	x,sp
1823  0595 de101e        	ldw	x,(OFST-3,x)
1824  0598 130f          	cpw	x,(OFST-4114,sp)
1825  059a 2d2a          	jrsle	L556
1826                     ; 222 		*frequency = freqBuff / freqCount;  // Calculate average frequency
1828  059c 96            	ldw	x,sp
1829  059d de101e        	ldw	x,(OFST-3,x)
1830  05a0 8d000000      	callf	d_itof
1832  05a4 96            	ldw	x,sp
1833  05a5 1c000d        	addw	x,#OFST-4116
1834  05a8 8d000000      	callf	d_rtol
1837  05ac 96            	ldw	x,sp
1838  05ad 1c0015        	addw	x,#OFST-4108
1839  05b0 8d000000      	callf	d_ltor
1841  05b4 96            	ldw	x,sp
1842  05b5 1c000d        	addw	x,#OFST-4116
1843  05b8 8d000000      	callf	d_fdiv
1845  05bc 96            	ldw	x,sp
1846  05bd de1026        	ldw	x,(OFST+5,x)
1847  05c0 8d000000      	callf	d_rtol
1850  05c4 2010          	jra	L756
1851  05c6               L556:
1852                     ; 224 	else if (isChannel1) {
1854  05c6 7b1d          	ld	a,(OFST-4100,sp)
1855  05c8 270c          	jreq	L756
1856                     ; 225 		*frequency = 0;  // No crossings detected, return 0 frequency
1858  05ca               LC004:
1860  05ca 96            	ldw	x,sp
1861  05cb de1026        	ldw	x,(OFST+5,x)
1862  05ce 4f            	clr	a
1863  05cf e703          	ld	(3,x),a
1864  05d1 e702          	ld	(2,x),a
1865  05d3 e701          	ld	(1,x),a
1866  05d5               LC003:
1867  05d5 f7            	ld	(x),a
1868  05d6               L756:
1869                     ; 228 	return *amplitude;  // Always return amplitude
1874  05d6 96            	ldw	x,sp
1875  05d7 de1028        	ldw	x,(OFST+7,x)
1876  05da 8d000000      	callf	d_ltor
1878  05de 9096          	ldw	y,sp
1879  05e0 72a91022      	addw	y,#4130
1880  05e4 9094          	ldw	sp,y
1881  05e6 87            	retf	
1915                     ; 232 float convert_adc_to_voltage(unsigned int adcValue) {
1916                     	switch	.text
1917  05e7               f_convert_adc_to_voltage:
1921                     ; 233 	return adcValue * (V_REF / ADC_MAX_VALUE);
1923  05e7 8d000000      	callf	d_uitof
1925  05eb ae10ab        	ldw	x,#L507
1929  05ee ac000000      	jpf	d_fmul
1963                     ; 237 float calculate_frequency(unsigned long period) {
1964                     	switch	.text
1965  05f2               f_calculate_frequency:
1967  05f2 5204          	subw	sp,#4
1968       00000004      OFST:	set	4
1971                     ; 238 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
1973  05f4 96            	ldw	x,sp
1974  05f5 1c0008        	addw	x,#OFST+4
1975  05f8 8d000000      	callf	d_ltor
1977  05fc 8d000000      	callf	d_ultof
1979  0600 ae10a3        	ldw	x,#L347
1980  0603 8d000000      	callf	d_fdiv
1982  0607 96            	ldw	x,sp
1983  0608 5c            	incw	x
1984  0609 8d000000      	callf	d_rtol
1987  060d ae10a7        	ldw	x,#L337
1988  0610 8d000000      	callf	d_ltor
1990  0614 96            	ldw	x,sp
1991  0615 5c            	incw	x
1992  0616 8d000000      	callf	d_fdiv
1996  061a 5b04          	addw	sp,#4
1997  061c 87            	retf	
2059                     ; 242 void output_results(float frequency, float amplitude, float FDR_Voltage) {
2060                     	switch	.text
2061  061d               f_output_results:
2063  061d 5228          	subw	sp,#40
2064       00000028      OFST:	set	40
2067                     ; 248 	sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,\0", frequency, amplitude, amplitude/4.7, FDR_Voltage);
2069  061f 1e36          	ldw	x,(OFST+14,sp)
2070  0621 89            	pushw	x
2071  0622 1e36          	ldw	x,(OFST+14,sp)
2072  0624 89            	pushw	x
2073  0625 96            	ldw	x,sp
2074  0626 1c0034        	addw	x,#OFST+12
2075  0629 8d000000      	callf	d_ltor
2077  062d ae118e        	ldw	x,#L731
2078  0630 8d000000      	callf	d_fdiv
2080  0634 be02          	ldw	x,c_lreg+2
2081  0636 89            	pushw	x
2082  0637 be00          	ldw	x,c_lreg
2083  0639 89            	pushw	x
2084  063a 1e3a          	ldw	x,(OFST+18,sp)
2085  063c 89            	pushw	x
2086  063d 1e3a          	ldw	x,(OFST+18,sp)
2087  063f 89            	pushw	x
2088  0640 1e3a          	ldw	x,(OFST+18,sp)
2089  0642 89            	pushw	x
2090  0643 1e3a          	ldw	x,(OFST+18,sp)
2091  0645 89            	pushw	x
2092  0646 ae108d        	ldw	x,#L1001
2093  0649 89            	pushw	x
2094  064a 96            	ldw	x,sp
2095  064b 1c0013        	addw	x,#OFST-21
2096  064e 8d000000      	callf	f_sprintf
2098  0652 5b3a          	addw	sp,#58
2099                     ; 253 }
2102  0654 87            	retf	
2138                     ; 256 void send_square_pulse(uint16_t duration_ms) {
2139                     	switch	.text
2140  0655               f_send_square_pulse:
2142  0655 89            	pushw	x
2143       00000000      OFST:	set	0
2146                     ; 257 	GPIO_WriteHigh(GPIOC, GPIO_PIN_4); // Set square pulse pin high
2148  0656 4b10          	push	#16
2149  0658 ae500a        	ldw	x,#20490
2150  065b 8d000000      	callf	f_GPIO_WriteHigh
2152  065f 84            	pop	a
2153                     ; 258 	delay_ms(duration_ms);            // Wait for the pulse duration
2155  0660 1e01          	ldw	x,(OFST+1,sp)
2156  0662 8d000000      	callf	f_delay_ms
2158                     ; 259 	GPIO_WriteLow(GPIOC, GPIO_PIN_4); // Set square pulse pin low
2160  0666 4b10          	push	#16
2161  0668 ae500a        	ldw	x,#20490
2162  066b 8d000000      	callf	f_GPIO_WriteLow
2164                     ; 260 }
2167  066f 5b03          	addw	sp,#3
2168  0671 87            	retf	
2205                     ; 263 void send_pulse_commutation(uint16_t duration_ms) {
2206                     	switch	.text
2207  0672               f_send_pulse_commutation:
2209  0672 89            	pushw	x
2210       00000000      OFST:	set	0
2213                     ; 264 	GPIO_WriteHigh(GPIOC, GPIO_PIN_2); // Set square pulse pin high
2215  0673 4b04          	push	#4
2216  0675 ae500a        	ldw	x,#20490
2217  0678 8d000000      	callf	f_GPIO_WriteHigh
2219  067c 84            	pop	a
2220                     ; 265 	delay_ms(duration_ms);            // Wait for the pulse duration
2222  067d 1e01          	ldw	x,(OFST+1,sp)
2223  067f 8d000000      	callf	f_delay_ms
2225                     ; 266 	GPIO_WriteLow(GPIOC, GPIO_PIN_2); // Set square pulse pin low
2227  0683 4b04          	push	#4
2228  0685 ae500a        	ldw	x,#20490
2229  0688 8d000000      	callf	f_GPIO_WriteLow
2231                     ; 267 }
2234  068c 5b03          	addw	sp,#3
2235  068e 87            	retf	
2270                     ; 270 bool check_signal_dc(float amplitude) {
2271                     	switch	.text
2272  068f               f_check_signal_dc:
2274       00000000      OFST:	set	0
2277                     ; 271 	if (amplitude == 0) {
2279  068f 7b04          	ld	a,(OFST+4,sp)
2280  0691 2606          	jrne	L5501
2281                     ; 272 		isThyristorON = true;
2283  0693 35010014      	mov	_isThyristorON,#1
2284                     ; 273 		return true;
2286  0697 4c            	inc	a
2289  0698 87            	retf	
2290  0699               L5501:
2291                     ; 275 		isThyristorON = false;
2293  0699 3f14          	clr	_isThyristorON
2294                     ; 276 		return false;
2296  069b 4f            	clr	a
2299  069c 87            	retf	
2346                     ; 280 void configure_set_frequency(void) {
2347                     	switch	.text
2348  069d               f_configure_set_frequency:
2350  069d 5218          	subw	sp,#24
2351       00000018      OFST:	set	24
2354                     ; 282 		float new_frequency = 5.0; // Convert string to float
2356                     ; 283     printf("Enter new set frequency (0.3 - 5 Hz):\n");
2358  069f ae1066        	ldw	x,#L3011
2359  06a2 8d000000      	callf	f_printf
2361                     ; 285     UART3_ReceiveString(buffer, sizeof(buffer)); // Receive user input
2363  06a6 ae0014        	ldw	x,#20
2364  06a9 89            	pushw	x
2365  06aa 96            	ldw	x,sp
2366  06ab 1c0003        	addw	x,#OFST-21
2367  06ae 8d000000      	callf	f_UART3_ReceiveString
2369  06b2 85            	popw	x
2370                     ; 286     new_frequency = atof(buffer); // Convert string to float
2372  06b3 96            	ldw	x,sp
2373  06b4 5c            	incw	x
2374  06b5 8d000000      	callf	f_atof
2376  06b9 96            	ldw	x,sp
2377  06ba 1c0015        	addw	x,#OFST-3
2378  06bd 8d000000      	callf	d_rtol
2381                     ; 289     if (new_frequency >= 0.3 && new_frequency <= 5.0) {
2383  06c1 96            	ldw	x,sp
2384  06c2 1c0015        	addw	x,#OFST-3
2385  06c5 8d000000      	callf	d_ltor
2387  06c9 ae1062        	ldw	x,#L3111
2388  06cc 8d000000      	callf	d_fcmp
2390  06d0 2f22          	jrslt	L5011
2392  06d2 96            	ldw	x,sp
2393  06d3 1c0015        	addw	x,#OFST-3
2394  06d6 8d000000      	callf	d_ltor
2396  06da ae118a        	ldw	x,#L151
2397  06dd 8d000000      	callf	d_fcmp
2399  06e1 2c11          	jrsgt	L5011
2400                     ; 291         printf("Set frequency updated to: %.2f Hz\n", new_frequency);
2402  06e3 1e17          	ldw	x,(OFST-1,sp)
2403  06e5 89            	pushw	x
2404  06e6 1e17          	ldw	x,(OFST-1,sp)
2405  06e8 89            	pushw	x
2406  06e9 ae103f        	ldw	x,#L7111
2407  06ec 8d000000      	callf	f_printf
2409  06f0 5b04          	addw	sp,#4
2411  06f2 2007          	jra	L1211
2412  06f4               L5011:
2413                     ; 293         printf("Invalid frequency. Please enter a value between 0.3 and 5 Hz.\n");
2415  06f4 ae1000        	ldw	x,#L3211
2416  06f7 8d000000      	callf	f_printf
2418  06fb               L1211:
2419                     ; 295 }
2422  06fb 5b18          	addw	sp,#24
2423  06fd 87            	retf	
2435                     	xdef	f_main
2436                     	xdef	f_configure_set_frequency
2437                     	xdef	f_calculate_frequency
2438                     	xdef	f_convert_adc_to_voltage
2439                     	xdef	f_process_adc_signal
2440                     	xdef	f_calculate_amplitude
2441                     	xdef	f_output_results
2442                     	xdef	f_initialize_adc_buffer
2443                     	xdef	f_check_signal_dc
2444                     	xdef	f_send_pulse_commutation
2445                     	xdef	f_send_square_pulse
2446                     	xdef	f_check_negative_zero_crossing
2447                     	xdef	f_detect_negative_zero_cross
2448                     	xdef	f_detectZeroCross
2449                     	xdef	f_detectPosZeroCross
2450                     	xdef	f_initialize_system
2451                     	xdef	_isThyristorON
2452                     	xdef	_count
2453                     	xdef	_crossingType
2454                     	xdef	_currentEdgeTime
2455                     	xdef	_lastEdgeTime
2456                     	xdef	_sine1_amplitude
2457                     	xdef	_sine1_frequency
2458                     	xref	f_read_ADC_Channel
2459                     	xref	f_UART3_ReceiveString
2460                     	xref	f_GPIO_setup
2461                     	xref	f_ADC2_setup
2462                     	xref	f_UART3_setup
2463                     	xref	f_clock_setup
2464                     	xref	f_I2CInit
2465                     	xref	f_EEPROM_Config
2466                     	xref	f_micros
2467                     	xref	f_delay_us
2468                     	xref	f_delay_ms
2469                     	xref	f_TIM4_Config
2470                     	xref	f_atof
2471                     	xref	f_sprintf
2472                     	xref	f_printf
2473                     	xref	f_GPIO_WriteLow
2474                     	xref	f_GPIO_WriteHigh
2475                     	switch	.const
2476  1000               L3211:
2477  1000 496e76616c69  	dc.b	"Invalid frequency."
2478  1012 20506c656173  	dc.b	" Please enter a va"
2479  1024 6c7565206265  	dc.b	"lue between 0.3 an"
2480  1036 64203520487a  	dc.b	"d 5 Hz.",10,0
2481  103f               L7111:
2482  103f 536574206672  	dc.b	"Set frequency upda"
2483  1051 74656420746f  	dc.b	"ted to: %.2f Hz",10,0
2484  1062               L3111:
2485  1062 3e999999      	dc.w	16025,-26215
2486  1066               L3011:
2487  1066 456e74657220  	dc.b	"Enter new set freq"
2488  1078 75656e637920  	dc.b	"uency (0.3 - 5 Hz)"
2489  108a 3a0a00        	dc.b	":",10,0
2490  108d               L1001:
2491  108d 252e33662c25  	dc.b	"%.3f,%.3f,%.3f,%.3"
2492  109f 662c0000      	dc.b	"f,",0,0
2493  10a3               L347:
2494  10a3 49742400      	dc.w	18804,9216
2495  10a7               L337:
2496  10a7 3f800000      	dc.w	16256,0
2497  10ab               L507:
2498  10ab 3ba0280a      	dc.w	15264,10250
2499  10af               L174:
2500  10af c0a00000      	dc.w	-16224,0
2501  10b3               L524:
2502  10b3 4e6567617469  	dc.b	"Negative zero cros"
2503  10c5 73696e672064  	dc.b	"sing detected!",10,0
2504  10d5               L124:
2505  10d5 40199999      	dc.w	16409,-26215
2506  10d9               L132:
2507  10d9 53797374656d  	dc.b	"System Initializat"
2508  10eb 696f6e20436f  	dc.b	"ion Completed",10
2509  10f9 0d00          	dc.b	13,0
2510  10fb               L712:
2511  10fb 566172416d70  	dc.b	"VarAmplitude Not b"
2512  110d 656c6f772031  	dc.b	"elow 10 mv.",10,0
2513  111a               L312:
2514  111a 566172416d70  	dc.b	"VarAmplitude below"
2515  112c 203130206d76  	dc.b	" 10 mv.",10,0
2516  1135               L702:
2517  1135 3c23d70a      	dc.w	15395,-10486
2518  1139               L771:
2519  1139 5369676e616c  	dc.b	"Signal 1 AC and Va"
2520  114b 72416d706c69  	dc.b	"rAmplitude: %f.",10,0
2521  115c               L361:
2522  115c 5369676e616c  	dc.b	"Signal 1 DC.",10,0
2523  116a               L551:
2524  116a 467265717565  	dc.b	"Frequency Below Se"
2525  117c 742046726571  	dc.b	"t Frequency.",10,0
2526  118a               L151:
2527  118a 40a00000      	dc.w	16544,0
2528  118e               L731:
2529  118e 40966666      	dc.w	16534,26214
2530  1192               L131:
2531  1192 204672657175  	dc.b	" Frequency: %.3f, "
2532  11a4 416d706c6974  	dc.b	"Amplitude: %.3f, C"
2533  11b6 757272656e74  	dc.b	"urrent: %.3f, FDR_"
2534  11c8 566f6c746167  	dc.b	"Voltage: %.3f",10,0
2535                     	xref.b	c_lreg
2536                     	xref.b	c_x
2537                     	xref.b	c_y
2557                     	xref	d_ultof
2558                     	xref	d_fmul
2559                     	xref	d_uitof
2560                     	xref	d_uitolx
2561                     	xref	d_lsub
2562                     	xref	d_lzmp
2563                     	xref	d_xymovl
2564                     	xref	d_itof
2565                     	xref	d_fsub
2566                     	xref	d_lcmp
2567                     	xref	d_lgadc
2568                     	xref	d_fcmp
2569                     	xref	d_fdiv
2570                     	xref	d_ltor
2571                     	xref	d_rtol
2572                     	end
