   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	switch	.data
  15  0000               _sine1_frequency:
  16  0000 00000000      	dc.w	0,0
  17  0004               _sine1_amplitude:
  18  0004 00000000      	dc.w	0,0
  19  0008               _count:
  20  0008 0000          	dc.w	0
  21  000a               _isThyristorON:
  22  000a 00            	dc.b	0
  23  000b               _state:
  24  000b 00            	dc.b	0
  25  000c               _pulseFlag:
  26  000c 00            	dc.b	0
  27  000d               _overflow_count:
  28  000d 0000          	dc.w	0
  29  000f               _pulse_ticks:
  30  000f 0000          	dc.w	0
  31  0011               _start_time:
  32  0011 00000000      	dc.l	0
  33  0015               _end_time:
  34  0015 00000000      	dc.l	0
  35  0019               _last_cross_time:
  36  0019 00000000      	dc.l	0
  37  001d               _set_frequency:
  38  001d 424c0000      	dc.w	16972,0
  39  0021               _frequency:
  40  0021 00000000      	dc.w	0,0
  41  0025               _set_freq:
  42  0025 00000000      	dc.w	0,0
  43  0029               _buffer:
  44  0029 00            	dc.b	0
  45  002a 000000000000  	ds.b	49
 254                     ; 5 void main() {
 255                     	switch	.text
 256  0000               f_main:
 258  0000 5204          	subw	sp,#4
 259       00000004      OFST:	set	4
 262                     ; 6   float FDR_amplitude = 0.0;
 264  0002 ce0aff        	ldw	x,L721+2
 265  0005 1f03          	ldw	(OFST-1,sp),x
 266  0007 ce0afd        	ldw	x,L721
 267  000a 1f01          	ldw	(OFST-3,sp),x
 269                     ; 9 	initialize_system();
 271  000c 8d5e005e      	callf	f_initialize_system
 273                     ; 13 	read_set_frequency(&set_freq);
 275  0010 ae0025        	ldw	x,#_set_freq
 276  0013 8dd307d3      	callf	f_read_set_frequency
 278                     ; 15 	FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
 280  0017 96            	ldw	x,sp
 281  0018 1c0001        	addw	x,#OFST-3
 282  001b 89            	pushw	x
 283  001c 5f            	clrw	x
 284  001d 89            	pushw	x
 285  001e a606          	ld	a,#6
 286  0020 8d170517      	callf	f_process_adc_signal
 288  0024 5b04          	addw	sp,#4
 289  0026 96            	ldw	x,sp
 290  0027 1c0001        	addw	x,#OFST-3
 291  002a 8d000000      	callf	d_rtol
 294                     ; 17 	if (FDR_amplitude > 0) { // Voltage detected on Signal 2
 296  002e 9c            	rvf
 297  002f 9c            	rvf
 298  0030 0d01          	tnz	(OFST-3,sp)
 299  0032 2d27          	jrsle	L331
 300                     ; 18 		printf("FDR Voltage Exists");
 302  0034 ae0aea        	ldw	x,#L531
 303  0037 8d000000      	callf	f_printf
 305                     ; 19 		GPIO_WriteHigh(LED_RED); // Turn on LED
 307  003b 4b08          	push	#8
 308  003d ae5000        	ldw	x,#20480
 309  0040 8d000000      	callf	f_GPIO_WriteHigh
 311  0044 84            	pop	a
 312                     ; 20 		GPIO_WriteHigh(GPIOD, GPIO_PIN_4);
 314  0045 4b10          	push	#16
 315  0047 ae500f        	ldw	x,#20495
 316  004a 8d000000      	callf	f_GPIO_WriteHigh
 318  004e 84            	pop	a
 319                     ; 21 		process_VAR_signal(FDR_amplitude); // Handle Signal 1
 321  004f 1e03          	ldw	x,(OFST-1,sp)
 322  0051 89            	pushw	x
 323  0052 1e03          	ldw	x,(OFST-1,sp)
 324  0054 89            	pushw	x
 325  0055 8d400140      	callf	f_process_VAR_signal
 327  0059 5b04          	addw	sp,#4
 328  005b               L331:
 329                     ; 23 }
 332  005b 5b04          	addw	sp,#4
 333  005d 87            	retf
 366                     ; 26 void initialize_system(void) {
 367                     	switch	.text
 368  005e               f_initialize_system:
 372                     ; 27 	clock_setup();          // Configure system clock
 374  005e 8d000000      	callf	f_clock_setup
 376                     ; 28 	TIM4_Config(); 	// Timer 4 config for delay
 378  0062 8d000000      	callf	f_TIM4_Config
 380                     ; 29 	GPIO_setup();
 382  0066 8d000000      	callf	f_GPIO_setup
 384                     ; 30 	TIM1_setup();
 386  006a 8d000000      	callf	f_TIM1_setup
 388                     ; 31 	UART3_setup();          // Setup UART communication
 390  006e 8d000000      	callf	f_UART3_setup
 392                     ; 32 	UART1_setup();
 394  0072 8d000000      	callf	f_UART1_setup
 396                     ; 33 	ADC2_setup();						// Setup ADC
 398  0076 8d000000      	callf	f_ADC2_setup
 400                     ; 34 	EEPROM_Config();        // Configuring EEPROM
 402  007a 8d000000      	callf	f_EEPROM_Config
 404                     ; 35 	I2CInit();  // for Configuring RTC
 406  007e 8d000000      	callf	f_I2CInit
 408                     ; 36 	INT_EEPROM_Setup();
 410  0082 8d000000      	callf	f_INT_EEPROM_Setup
 412                     ; 37 	printf("System Initialization Completed\n\r");
 414  0086 ae0ac8        	ldw	x,#L741
 415  0089 8d000000      	callf	f_printf
 417                     ; 38 }
 420  008d 87            	retf
 475                     ; 40 float process_FDR_signal(void) {
 476                     	switch	.text
 477  008e               f_process_FDR_signal:
 479  008e 523a          	subw	sp,#58
 480       0000003a      OFST:	set	58
 483                     ; 41 	float FDR_Amplitude = 0, VAR_amplitude = 0;
 485  0090 ae0000        	ldw	x,#0
 486  0093 1f35          	ldw	(OFST-5,sp),x
 487  0095 ae0000        	ldw	x,#0
 488  0098 1f33          	ldw	(OFST-7,sp),x
 492  009a ae0000        	ldw	x,#0
 493  009d 1f39          	ldw	(OFST-1,sp),x
 494  009f ae0000        	ldw	x,#0
 495  00a2 1f37          	ldw	(OFST-3,sp),x
 497  00a4               L371:
 498                     ; 44 		VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
 500  00a4 96            	ldw	x,sp
 501  00a5 1c0037        	addw	x,#OFST-3
 502  00a8 89            	pushw	x
 503  00a9 5f            	clrw	x
 504  00aa 89            	pushw	x
 505  00ab a605          	ld	a,#5
 506  00ad 8d170517      	callf	f_process_adc_signal
 508  00b1 5b04          	addw	sp,#4
 509  00b3 96            	ldw	x,sp
 510  00b4 1c0037        	addw	x,#OFST-3
 511  00b7 8d000000      	callf	d_rtol
 514                     ; 45 		FDR_Amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_Amplitude);
 516  00bb 96            	ldw	x,sp
 517  00bc 1c0033        	addw	x,#OFST-7
 518  00bf 89            	pushw	x
 519  00c0 5f            	clrw	x
 520  00c1 89            	pushw	x
 521  00c2 a606          	ld	a,#6
 522  00c4 8d170517      	callf	f_process_adc_signal
 524  00c8 5b04          	addw	sp,#4
 525  00ca 96            	ldw	x,sp
 526  00cb 1c0033        	addw	x,#OFST-7
 527  00ce 8d000000      	callf	d_rtol
 530                     ; 46     sprintf(buffer, "Freq: %.3f, Field_Volt: %.3f, FDR_Volt: %.3f\n", frequency, VAR_amplitude, FDR_Amplitude);
 532  00d2 1e35          	ldw	x,(OFST-5,sp)
 533  00d4 89            	pushw	x
 534  00d5 1e35          	ldw	x,(OFST-5,sp)
 535  00d7 89            	pushw	x
 536  00d8 1e3d          	ldw	x,(OFST+3,sp)
 537  00da 89            	pushw	x
 538  00db 1e3d          	ldw	x,(OFST+3,sp)
 539  00dd 89            	pushw	x
 540  00de ce0023        	ldw	x,_frequency+2
 541  00e1 89            	pushw	x
 542  00e2 ce0021        	ldw	x,_frequency
 543  00e5 89            	pushw	x
 544  00e6 ae0a9a        	ldw	x,#L771
 545  00e9 89            	pushw	x
 546  00ea 96            	ldw	x,sp
 547  00eb 1c000f        	addw	x,#OFST-43
 548  00ee 8d000000      	callf	f_sprintf
 550  00f2 5b0e          	addw	sp,#14
 551                     ; 47 	  printf("%s", buffer);
 553  00f4 96            	ldw	x,sp
 554  00f5 1c0001        	addw	x,#OFST-57
 555  00f8 89            	pushw	x
 556  00f9 ae0a97        	ldw	x,#L102
 557  00fc 8d000000      	callf	f_printf
 559  0100 85            	popw	x
 560                     ; 48 		logResults(buffer);
 562  0101 96            	ldw	x,sp
 563  0102 1c0001        	addw	x,#OFST-57
 564  0105 8dc406c4      	callf	f_logResults
 566                     ; 49 		if ((FDR_Amplitude > 1.1) && (VAR_amplitude > 0.7)) {
 568  0109 9c            	rvf
 569  010a 96            	ldw	x,sp
 570  010b 1c0033        	addw	x,#OFST-7
 571  010e 8d000000      	callf	d_ltor
 573  0112 ae0a93        	ldw	x,#L112
 574  0115 8d000000      	callf	d_fcmp
 576  0119 2d89          	jrsle	L371
 578  011b 9c            	rvf
 579  011c 96            	ldw	x,sp
 580  011d 1c0037        	addw	x,#OFST-3
 581  0120 8d000000      	callf	d_ltor
 583  0124 ae0a8f        	ldw	x,#L122
 584  0127 8d000000      	callf	d_fcmp
 586  012b 2c04          	jrsgt	L21
 587  012d aca400a4      	jpf	L371
 588  0131               L21:
 589  0131               L522:
 590                     ; 51 				handle_commutation_pulse(); // Execute the pulse sending
 592  0131 8d0d070d      	callf	f_handle_commutation_pulse
 594                     ; 52 			} while (check_FDR_amplitude()); // Repeat if FDR_amplitude is still non-zero
 596  0135 8d3a073a      	callf	f_check_FDR_amplitude
 598  0139 4d            	tnz	a
 599  013a 26f5          	jrne	L522
 600  013c aca400a4      	jpf	L371
 674                     ; 58 void process_VAR_signal(float FDR_amplitude) {
 675                     	switch	.text
 676  0140               f_process_VAR_signal:
 678  0140 5266          	subw	sp,#102
 679       00000066      OFST:	set	102
 682                     ; 59 	float VAR_frequency = 0.0, VAR_amplitude = 0.0;
 686  0142 ce0aff        	ldw	x,L721+2
 687  0145 1f65          	ldw	(OFST-1,sp),x
 688  0147 ce0afd        	ldw	x,L721
 689  014a 1f63          	ldw	(OFST-3,sp),x
 691  014c               L362:
 692                     ; 62 		VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
 694  014c 96            	ldw	x,sp
 695  014d 1c0063        	addw	x,#OFST-3
 696  0150 89            	pushw	x
 697  0151 5f            	clrw	x
 698  0152 89            	pushw	x
 699  0153 a605          	ld	a,#5
 700  0155 8d170517      	callf	f_process_adc_signal
 702  0159 5b04          	addw	sp,#4
 703  015b 96            	ldw	x,sp
 704  015c 1c0063        	addw	x,#OFST-3
 705  015f 8d000000      	callf	d_rtol
 708                     ; 63 		VAR_frequency = frequency;
 710  0163 ce0023        	ldw	x,_frequency+2
 711  0166 1f61          	ldw	(OFST-5,sp),x
 712  0168 ce0021        	ldw	x,_frequency
 713  016b 1f5f          	ldw	(OFST-7,sp),x
 715                     ; 64 		printDateTime();
 717  016d 8d000000      	callf	f_printDateTime
 719                     ; 67 		printf(" Frequency: %.3f, Amplitude: %.3f, Current: %.3f, FDR_Voltage: %.3f\n",
 719                     ; 68 					 VAR_frequency, VAR_amplitude, VAR_amplitude / 4.7, FDR_amplitude);
 721  0171 1e6c          	ldw	x,(OFST+6,sp)
 722  0173 89            	pushw	x
 723  0174 1e6c          	ldw	x,(OFST+6,sp)
 724  0176 89            	pushw	x
 725  0177 96            	ldw	x,sp
 726  0178 1c0067        	addw	x,#OFST+1
 727  017b 8d000000      	callf	d_ltor
 729  017f ae0a46        	ldw	x,#L572
 730  0182 8d000000      	callf	d_fdiv
 732  0186 be02          	ldw	x,c_lreg+2
 733  0188 89            	pushw	x
 734  0189 be00          	ldw	x,c_lreg
 735  018b 89            	pushw	x
 736  018c 1e6d          	ldw	x,(OFST+7,sp)
 737  018e 89            	pushw	x
 738  018f 1e6d          	ldw	x,(OFST+7,sp)
 739  0191 89            	pushw	x
 740  0192 1e6d          	ldw	x,(OFST+7,sp)
 741  0194 89            	pushw	x
 742  0195 1e6d          	ldw	x,(OFST+7,sp)
 743  0197 89            	pushw	x
 744  0198 ae0a4a        	ldw	x,#L762
 745  019b 8d000000      	callf	f_printf
 747  019f 5b10          	addw	sp,#16
 748                     ; 69     sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", frequency, VAR_amplitude, VAR_amplitude/4.7, FDR_amplitude);
 750  01a1 1e6c          	ldw	x,(OFST+6,sp)
 751  01a3 89            	pushw	x
 752  01a4 1e6c          	ldw	x,(OFST+6,sp)
 753  01a6 89            	pushw	x
 754  01a7 96            	ldw	x,sp
 755  01a8 1c0067        	addw	x,#OFST+1
 756  01ab 8d000000      	callf	d_ltor
 758  01af ae0a46        	ldw	x,#L572
 759  01b2 8d000000      	callf	d_fdiv
 761  01b6 be02          	ldw	x,c_lreg+2
 762  01b8 89            	pushw	x
 763  01b9 be00          	ldw	x,c_lreg
 764  01bb 89            	pushw	x
 765  01bc 1e6d          	ldw	x,(OFST+7,sp)
 766  01be 89            	pushw	x
 767  01bf 1e6d          	ldw	x,(OFST+7,sp)
 768  01c1 89            	pushw	x
 769  01c2 ce0023        	ldw	x,_frequency+2
 770  01c5 89            	pushw	x
 771  01c6 ce0021        	ldw	x,_frequency
 772  01c9 89            	pushw	x
 773  01ca ae0a2f        	ldw	x,#L103
 774  01cd 89            	pushw	x
 775  01ce 96            	ldw	x,sp
 776  01cf 1c003f        	addw	x,#OFST-39
 777  01d2 8d000000      	callf	f_sprintf
 779  01d6 5b12          	addw	sp,#18
 780                     ; 70 		logResults(buffer);
 782  01d8 96            	ldw	x,sp
 783  01d9 1c002d        	addw	x,#OFST-57
 784  01dc 8dc406c4      	callf	f_logResults
 786                     ; 71 		output_results(VAR_frequency, VAR_amplitude, FDR_amplitude);
 788  01e0 1e6c          	ldw	x,(OFST+6,sp)
 789  01e2 89            	pushw	x
 790  01e3 1e6c          	ldw	x,(OFST+6,sp)
 791  01e5 89            	pushw	x
 792  01e6 1e69          	ldw	x,(OFST+3,sp)
 793  01e8 89            	pushw	x
 794  01e9 1e69          	ldw	x,(OFST+3,sp)
 795  01eb 89            	pushw	x
 796  01ec 1e69          	ldw	x,(OFST+3,sp)
 797  01ee 89            	pushw	x
 798  01ef 1e69          	ldw	x,(OFST+3,sp)
 799  01f1 89            	pushw	x
 800  01f2 8d750675      	callf	f_output_results
 802  01f6 5b0c          	addw	sp,#12
 803                     ; 73 		if (VAR_frequency <= SET_FREQ) {
 805  01f8 9c            	rvf
 806  01f9 a633          	ld	a,#51
 807  01fb 8d000000      	callf	d_ctof
 809  01ff 96            	ldw	x,sp
 810  0200 1c0001        	addw	x,#OFST-101
 811  0203 8d000000      	callf	d_rtol
 814  0207 96            	ldw	x,sp
 815  0208 1c005f        	addw	x,#OFST-7
 816  020b 8d000000      	callf	d_ltor
 818  020f 96            	ldw	x,sp
 819  0210 1c0001        	addw	x,#OFST-101
 820  0213 8d000000      	callf	d_fcmp
 822  0217 2d04          	jrsle	L61
 823  0219 ac4c014c      	jpf	L362
 824  021d               L61:
 825                     ; 75 			pulseFlag = 1;
 827  021d 3501000c      	mov	_pulseFlag,#1
 828                     ; 76 			printf("Frequency Below Set Frequency.\n");
 830  0221 ae0a0f        	ldw	x,#L503
 831  0224 8d000000      	callf	f_printf
 833                     ; 78 			sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", VAR_frequency, VAR_amplitude, VAR_amplitude/4.7, FDR_amplitude);
 835  0228 1e6c          	ldw	x,(OFST+6,sp)
 836  022a 89            	pushw	x
 837  022b 1e6c          	ldw	x,(OFST+6,sp)
 838  022d 89            	pushw	x
 839  022e 96            	ldw	x,sp
 840  022f 1c0067        	addw	x,#OFST+1
 841  0232 8d000000      	callf	d_ltor
 843  0236 ae0a46        	ldw	x,#L572
 844  0239 8d000000      	callf	d_fdiv
 846  023d be02          	ldw	x,c_lreg+2
 847  023f 89            	pushw	x
 848  0240 be00          	ldw	x,c_lreg
 849  0242 89            	pushw	x
 850  0243 1e6d          	ldw	x,(OFST+7,sp)
 851  0245 89            	pushw	x
 852  0246 1e6d          	ldw	x,(OFST+7,sp)
 853  0248 89            	pushw	x
 854  0249 1e6d          	ldw	x,(OFST+7,sp)
 855  024b 89            	pushw	x
 856  024c 1e6d          	ldw	x,(OFST+7,sp)
 857  024e 89            	pushw	x
 858  024f ae0a2f        	ldw	x,#L103
 859  0252 89            	pushw	x
 860  0253 96            	ldw	x,sp
 861  0254 1c0017        	addw	x,#OFST-79
 862  0257 8d000000      	callf	f_sprintf
 864  025b 5b12          	addw	sp,#18
 865                     ; 79 			printf("%s", buffer);
 867  025d 96            	ldw	x,sp
 868  025e 1c0005        	addw	x,#OFST-97
 869  0261 89            	pushw	x
 870  0262 ae0a97        	ldw	x,#L102
 871  0265 8d000000      	callf	f_printf
 873  0269 85            	popw	x
 874                     ; 80 			logResults(buffer);
 876  026a 96            	ldw	x,sp
 877  026b 1c0005        	addw	x,#OFST-97
 878  026e 8dc406c4      	callf	f_logResults
 880                     ; 81 			handle_Frequency_Below_Set_Freq(VAR_amplitude);
 882  0272 1e65          	ldw	x,(OFST-1,sp)
 883  0274 89            	pushw	x
 884  0275 1e65          	ldw	x,(OFST-1,sp)
 885  0277 89            	pushw	x
 886  0278 8d820282      	callf	f_handle_Frequency_Below_Set_Freq
 888  027c 5b04          	addw	sp,#4
 889  027e ac4c014c      	jpf	L362
 940                     ; 86 void handle_Frequency_Below_Set_Freq(float VAR_amplitude) {
 941                     	switch	.text
 942  0282               f_handle_Frequency_Below_Set_Freq:
 944  0282 5228          	subw	sp,#40
 945       00000028      OFST:	set	40
 948                     ; 88 	GPIO_WriteHigh(LED_BLUE); 
 950  0284 4b01          	push	#1
 951  0286 ae500f        	ldw	x,#20495
 952  0289 8d000000      	callf	f_GPIO_WriteHigh
 954  028d 84            	pop	a
 955                     ; 89 	GPIO_WriteHigh(GPIOD, GPIO_PIN_2); 
 957  028e 4b04          	push	#4
 958  0290 ae500f        	ldw	x,#20495
 959  0293 8d000000      	callf	f_GPIO_WriteHigh
 961  0297 84            	pop	a
 962                     ; 90 	VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
 964  0298 96            	ldw	x,sp
 965  0299 1c002c        	addw	x,#OFST+4
 966  029c 89            	pushw	x
 967  029d 5f            	clrw	x
 968  029e 89            	pushw	x
 969  029f a605          	ld	a,#5
 970  02a1 8d170517      	callf	f_process_adc_signal
 972  02a5 5b04          	addw	sp,#4
 973  02a7 96            	ldw	x,sp
 974  02a8 1c002c        	addw	x,#OFST+4
 975  02ab 8d000000      	callf	d_rtol
 977                     ; 91   sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", frequency, VAR_amplitude, VAR_amplitude/4.7, 0);
 979  02af 5f            	clrw	x
 980  02b0 89            	pushw	x
 981  02b1 96            	ldw	x,sp
 982  02b2 1c002e        	addw	x,#OFST+6
 983  02b5 8d000000      	callf	d_ltor
 985  02b9 ae0a46        	ldw	x,#L572
 986  02bc 8d000000      	callf	d_fdiv
 988  02c0 be02          	ldw	x,c_lreg+2
 989  02c2 89            	pushw	x
 990  02c3 be00          	ldw	x,c_lreg
 991  02c5 89            	pushw	x
 992  02c6 1e34          	ldw	x,(OFST+12,sp)
 993  02c8 89            	pushw	x
 994  02c9 1e34          	ldw	x,(OFST+12,sp)
 995  02cb 89            	pushw	x
 996  02cc ce0023        	ldw	x,_frequency+2
 997  02cf 89            	pushw	x
 998  02d0 ce0021        	ldw	x,_frequency
 999  02d3 89            	pushw	x
1000  02d4 ae0a2f        	ldw	x,#L103
1001  02d7 89            	pushw	x
1002  02d8 96            	ldw	x,sp
1003  02d9 1c0011        	addw	x,#OFST-23
1004  02dc 8d000000      	callf	f_sprintf
1006  02e0 5b10          	addw	sp,#16
1007                     ; 92 	printf("%s", buffer);
1009  02e2 96            	ldw	x,sp
1010  02e3 1c0001        	addw	x,#OFST-39
1011  02e6 89            	pushw	x
1012  02e7 ae0a97        	ldw	x,#L102
1013  02ea 8d000000      	callf	f_printf
1015  02ee 85            	popw	x
1016                     ; 93 	logResults(buffer);
1018  02ef 96            	ldw	x,sp
1019  02f0 1c0001        	addw	x,#OFST-39
1020  02f3 8dc406c4      	callf	f_logResults
1022                     ; 94 	if (check_signal_dc(VAR_amplitude)) {
1024  02f7 1e2e          	ldw	x,(OFST+6,sp)
1025  02f9 89            	pushw	x
1026  02fa 1e2e          	ldw	x,(OFST+6,sp)
1027  02fc 89            	pushw	x
1028  02fd 8db407b4      	callf	f_check_signal_dc
1030  0301 5b04          	addw	sp,#4
1031  0303 4d            	tnz	a
1032  0304 2717          	jreq	L723
1033                     ; 96 		printf("Signal 1 DC.\n");
1035  0306 ae0a01        	ldw	x,#L133
1036  0309 8d000000      	callf	f_printf
1038                     ; 97 		GPIO_WriteHigh(LED_BLUE); 
1040  030d 4b01          	push	#1
1041  030f ae500f        	ldw	x,#20495
1042  0312 8d000000      	callf	f_GPIO_WriteHigh
1044  0316 84            	pop	a
1045                     ; 98 		process_FDR_signal();
1047  0317 8d8e008e      	callf	f_process_FDR_signal
1050  031b 201b          	jra	L333
1051  031d               L723:
1052                     ; 101 		printf("Signal 1 AC and VarAmplitude: %f.\n", VAR_amplitude);
1054  031d 1e2e          	ldw	x,(OFST+6,sp)
1055  031f 89            	pushw	x
1056  0320 1e2e          	ldw	x,(OFST+6,sp)
1057  0322 89            	pushw	x
1058  0323 ae09de        	ldw	x,#L533
1059  0326 8d000000      	callf	f_printf
1061  032a 5b04          	addw	sp,#4
1062                     ; 102 		handle_signal_1_AC(VAR_amplitude);
1064  032c 1e2e          	ldw	x,(OFST+6,sp)
1065  032e 89            	pushw	x
1066  032f 1e2e          	ldw	x,(OFST+6,sp)
1067  0331 89            	pushw	x
1068  0332 8d3b033b      	callf	f_handle_signal_1_AC
1070  0336 5b04          	addw	sp,#4
1071  0338               L333:
1072                     ; 104 }
1075  0338 5b28          	addw	sp,#40
1076  033a 87            	retf
1128                     ; 106 void handle_signal_1_AC(float VAR_amplitude) {
1129                     	switch	.text
1130  033b               f_handle_signal_1_AC:
1132  033b 5228          	subw	sp,#40
1133       00000028      OFST:	set	40
1136                     ; 108 	VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
1138  033d 96            	ldw	x,sp
1139  033e 1c002c        	addw	x,#OFST+4
1140  0341 89            	pushw	x
1141  0342 5f            	clrw	x
1142  0343 89            	pushw	x
1143  0344 a605          	ld	a,#5
1144  0346 8d170517      	callf	f_process_adc_signal
1146  034a 5b04          	addw	sp,#4
1147  034c 96            	ldw	x,sp
1148  034d 1c002c        	addw	x,#OFST+4
1149  0350 8d000000      	callf	d_rtol
1151                     ; 109 	if (VAR_amplitude < AC_AMPLITUDE_THRESHOLD) {
1153  0354 9c            	rvf
1154  0355 96            	ldw	x,sp
1155  0356 1c002c        	addw	x,#OFST+4
1156  0359 8d000000      	callf	d_ltor
1158  035d ae09da        	ldw	x,#L563
1159  0360 8d000000      	callf	d_fcmp
1161  0364 2e67          	jrsge	L573
1162                     ; 111 		sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", frequency, VAR_amplitude, VAR_amplitude/4.7, 0);
1164  0366 5f            	clrw	x
1165  0367 89            	pushw	x
1166  0368 96            	ldw	x,sp
1167  0369 1c002e        	addw	x,#OFST+6
1168  036c 8d000000      	callf	d_ltor
1170  0370 ae0a46        	ldw	x,#L572
1171  0373 8d000000      	callf	d_fdiv
1173  0377 be02          	ldw	x,c_lreg+2
1174  0379 89            	pushw	x
1175  037a be00          	ldw	x,c_lreg
1176  037c 89            	pushw	x
1177  037d 1e34          	ldw	x,(OFST+12,sp)
1178  037f 89            	pushw	x
1179  0380 1e34          	ldw	x,(OFST+12,sp)
1180  0382 89            	pushw	x
1181  0383 ce0023        	ldw	x,_frequency+2
1182  0386 89            	pushw	x
1183  0387 ce0021        	ldw	x,_frequency
1184  038a 89            	pushw	x
1185  038b ae0a2f        	ldw	x,#L103
1186  038e 89            	pushw	x
1187  038f 96            	ldw	x,sp
1188  0390 1c0011        	addw	x,#OFST-23
1189  0393 8d000000      	callf	f_sprintf
1191  0397 5b10          	addw	sp,#16
1192                     ; 112 	  printf("%s", buffer);
1194  0399 96            	ldw	x,sp
1195  039a 1c0001        	addw	x,#OFST-39
1196  039d 89            	pushw	x
1197  039e ae0a97        	ldw	x,#L102
1198  03a1 8d000000      	callf	f_printf
1200  03a5 85            	popw	x
1201                     ; 113 		logResults(buffer);
1203  03a6 96            	ldw	x,sp
1204  03a7 1c0001        	addw	x,#OFST-39
1205  03aa 8dc406c4      	callf	f_logResults
1207                     ; 114 		printf("VarAmplitude below 10 mv.\n");
1209  03ae ae09bf        	ldw	x,#L173
1210  03b1 8d000000      	callf	f_printf
1212                     ; 115 		GPIO_WriteLow(LED_WHITE); // Turn on LED if Signal is AC < 20 mV
1214  03b5 4b08          	push	#8
1215  03b7 ae500a        	ldw	x,#20490
1216  03ba 8d000000      	callf	f_GPIO_WriteLow
1218  03be 84            	pop	a
1219                     ; 116 		delay_ms(3000);
1221  03bf ae0bb8        	ldw	x,#3000
1222  03c2 8d000000      	callf	f_delay_ms
1224                     ; 117 		pulseFlag = 1;
1226  03c6 3501000c      	mov	_pulseFlag,#1
1228                     ; 137 }
1231  03ca 5b28          	addw	sp,#40
1232  03cc 87            	retf
1233  03cd               L573:
1234                     ; 120 			pulseFlag = 1;
1236  03cd 3501000c      	mov	_pulseFlag,#1
1237                     ; 122 			GPIO_WriteHigh(GPIOD, GPIO_PIN_7);  // Turn on LED if Signal is AC < 20 ms
1239  03d1 4b80          	push	#128
1240  03d3 ae500f        	ldw	x,#20495
1241  03d6 8d000000      	callf	f_GPIO_WriteHigh
1243  03da 84            	pop	a
1244                     ; 123 			sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", frequency, VAR_amplitude, VAR_amplitude/4.7, 0);
1246  03db 5f            	clrw	x
1247  03dc 89            	pushw	x
1248  03dd 96            	ldw	x,sp
1249  03de 1c002e        	addw	x,#OFST+6
1250  03e1 8d000000      	callf	d_ltor
1252  03e5 ae0a46        	ldw	x,#L572
1253  03e8 8d000000      	callf	d_fdiv
1255  03ec be02          	ldw	x,c_lreg+2
1256  03ee 89            	pushw	x
1257  03ef be00          	ldw	x,c_lreg
1258  03f1 89            	pushw	x
1259  03f2 1e34          	ldw	x,(OFST+12,sp)
1260  03f4 89            	pushw	x
1261  03f5 1e34          	ldw	x,(OFST+12,sp)
1262  03f7 89            	pushw	x
1263  03f8 ce0023        	ldw	x,_frequency+2
1264  03fb 89            	pushw	x
1265  03fc ce0021        	ldw	x,_frequency
1266  03ff 89            	pushw	x
1267  0400 ae0a2f        	ldw	x,#L103
1268  0403 89            	pushw	x
1269  0404 96            	ldw	x,sp
1270  0405 1c0011        	addw	x,#OFST-23
1271  0408 8d000000      	callf	f_sprintf
1273  040c 5b10          	addw	sp,#16
1274                     ; 124 			printf("%s", buffer);
1276  040e 96            	ldw	x,sp
1277  040f 1c0001        	addw	x,#OFST-39
1278  0412 89            	pushw	x
1279  0413 ae0a97        	ldw	x,#L102
1280  0416 8d000000      	callf	f_printf
1282  041a 85            	popw	x
1283                     ; 125 			logResults(buffer);
1285  041b 96            	ldw	x,sp
1286  041c 1c0001        	addw	x,#OFST-39
1287  041f 8dc406c4      	callf	f_logResults
1289                     ; 126 			printf("VarAmplitude Not below 10 mv.\n");
1291  0423 ae09a0        	ldw	x,#L104
1292  0426 8d000000      	callf	f_printf
1294                     ; 127 			GPIO_WriteHigh(LED_WHITE);  // Turn on LED if Signal is AC < 20 ms	
1296  042a 4b08          	push	#8
1297  042c ae500a        	ldw	x,#20490
1298  042f 8d000000      	callf	f_GPIO_WriteHigh
1300  0433 84            	pop	a
1301                     ; 128 			VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
1303  0434 96            	ldw	x,sp
1304  0435 1c002c        	addw	x,#OFST+4
1305  0438 89            	pushw	x
1306  0439 5f            	clrw	x
1307  043a 89            	pushw	x
1308  043b a605          	ld	a,#5
1309  043d 8d170517      	callf	f_process_adc_signal
1311  0441 5b04          	addw	sp,#4
1312  0443 96            	ldw	x,sp
1313  0444 1c002c        	addw	x,#OFST+4
1314  0447 8d000000      	callf	d_rtol
1316                     ; 130 			if(check_signal_dc(VAR_amplitude)){
1318  044b 1e2e          	ldw	x,(OFST+6,sp)
1319  044d 89            	pushw	x
1320  044e 1e2e          	ldw	x,(OFST+6,sp)
1321  0450 89            	pushw	x
1322  0451 8db407b4      	callf	f_check_signal_dc
1324  0455 5b04          	addw	sp,#4
1325  0457 4d            	tnz	a
1326  0458 2604          	jrne	L42
1327  045a accd03cd      	jpf	L573
1328  045e               L42:
1329                     ; 131 				printf("Signal 1 DC(After AC).\n");
1331  045e ae0988        	ldw	x,#L504
1332  0461 8d000000      	callf	f_printf
1334                     ; 132 				GPIO_WriteHigh(LED_BLUE); 
1336  0465 4b01          	push	#1
1337  0467 ae500f        	ldw	x,#20495
1338  046a 8d000000      	callf	f_GPIO_WriteHigh
1340  046e 84            	pop	a
1341                     ; 133 				process_FDR_signal();
1343  046f 8d8e008e      	callf	f_process_FDR_signal
1345  0473 accd03cd      	jpf	L573
1408                     ; 140 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
1409                     	switch	.text
1410  0477               f_calculate_amplitude:
1412  0477 89            	pushw	x
1413  0478 520c          	subw	sp,#12
1414       0000000c      OFST:	set	12
1417                     ; 141 	uint32_t i = 0;
1419                     ; 142 	float max_val = -V_REF, min_val = V_REF;
1421  047a ce0982        	ldw	x,L144+2
1422  047d 1f03          	ldw	(OFST-9,sp),x
1423  047f ce0980        	ldw	x,L144
1424  0482 1f01          	ldw	(OFST-11,sp),x
1428  0484 ce0986        	ldw	x,L154+2
1429  0487 1f07          	ldw	(OFST-5,sp),x
1430  0489 ce0984        	ldw	x,L154
1431  048c 1f05          	ldw	(OFST-7,sp),x
1433                     ; 144 	for (i = 0; i < sample_size; i++) {
1435  048e ae0000        	ldw	x,#0
1436  0491 1f0b          	ldw	(OFST-1,sp),x
1437  0493 ae0000        	ldw	x,#0
1438  0496 1f09          	ldw	(OFST-3,sp),x
1441  0498 2058          	jra	L164
1442  049a               L554:
1443                     ; 145 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1445  049a 9c            	rvf
1446  049b 1e0b          	ldw	x,(OFST-1,sp)
1447  049d 58            	sllw	x
1448  049e 58            	sllw	x
1449  049f 72fb0d        	addw	x,(OFST+1,sp)
1450  04a2 8d000000      	callf	d_ltor
1452  04a6 96            	ldw	x,sp
1453  04a7 1c0001        	addw	x,#OFST-11
1454  04aa 8d000000      	callf	d_fcmp
1456  04ae 2d11          	jrsle	L564
1459  04b0 1e0b          	ldw	x,(OFST-1,sp)
1460  04b2 58            	sllw	x
1461  04b3 58            	sllw	x
1462  04b4 72fb0d        	addw	x,(OFST+1,sp)
1463  04b7 9093          	ldw	y,x
1464  04b9 ee02          	ldw	x,(2,x)
1465  04bb 1f03          	ldw	(OFST-9,sp),x
1466  04bd 93            	ldw	x,y
1467  04be fe            	ldw	x,(x)
1468  04bf 1f01          	ldw	(OFST-11,sp),x
1470  04c1               L564:
1471                     ; 146 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1473  04c1 9c            	rvf
1474  04c2 1e0b          	ldw	x,(OFST-1,sp)
1475  04c4 58            	sllw	x
1476  04c5 58            	sllw	x
1477  04c6 72fb0d        	addw	x,(OFST+1,sp)
1478  04c9 8d000000      	callf	d_ltor
1480  04cd 96            	ldw	x,sp
1481  04ce 1c0005        	addw	x,#OFST-7
1482  04d1 8d000000      	callf	d_fcmp
1484  04d5 2e11          	jrsge	L764
1487  04d7 1e0b          	ldw	x,(OFST-1,sp)
1488  04d9 58            	sllw	x
1489  04da 58            	sllw	x
1490  04db 72fb0d        	addw	x,(OFST+1,sp)
1491  04de 9093          	ldw	y,x
1492  04e0 ee02          	ldw	x,(2,x)
1493  04e2 1f07          	ldw	(OFST-5,sp),x
1494  04e4 93            	ldw	x,y
1495  04e5 fe            	ldw	x,(x)
1496  04e6 1f05          	ldw	(OFST-7,sp),x
1498  04e8               L764:
1499                     ; 144 	for (i = 0; i < sample_size; i++) {
1501  04e8 96            	ldw	x,sp
1502  04e9 1c0009        	addw	x,#OFST-3
1503  04ec a601          	ld	a,#1
1504  04ee 8d000000      	callf	d_lgadc
1507  04f2               L164:
1510  04f2 96            	ldw	x,sp
1511  04f3 1c0009        	addw	x,#OFST-3
1512  04f6 8d000000      	callf	d_ltor
1514  04fa 96            	ldw	x,sp
1515  04fb 1c0012        	addw	x,#OFST+6
1516  04fe 8d000000      	callf	d_lcmp
1518  0502 2596          	jrult	L554
1519                     ; 149 	return (max_val - min_val);
1521  0504 96            	ldw	x,sp
1522  0505 1c0001        	addw	x,#OFST-11
1523  0508 8d000000      	callf	d_ltor
1525  050c 96            	ldw	x,sp
1526  050d 1c0005        	addw	x,#OFST-7
1527  0510 8d000000      	callf	d_fsub
1531  0514 5b0e          	addw	sp,#14
1532  0516 87            	retf
1534                     .const:	section	.text
1535  0000               L174_buffer:
1536  0000 00000000      	dc.w	0,0
1537  0004 000000000000  	ds.b	2044
1673                     ; 152 float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
1674                     	switch	.text
1675  0517               f_process_adc_signal:
1677  0517 88            	push	a
1678  0518 96            	ldw	x,sp
1679  0519 1d0824        	subw	x,#2084
1680  051c 94            	ldw	sp,x
1681       00000824      OFST:	set	2084
1684                     ; 153 	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
1686  051d 96            	ldw	x,sp
1687  051e 1c001e        	addw	x,#OFST-2054
1688  0521 90ae0000      	ldw	y,#L174_buffer
1689  0525 bf00          	ldw	c_x,x
1690  0527 ae0800        	ldw	x,#2048
1691  052a 8d000000      	callf	d_xymovl
1693                     ; 154 	uint16_t i = 0, count = 0;
1697  052e 96            	ldw	x,sp
1698  052f 905f          	clrw	y
1699  0531 df0823        	ldw	(OFST-1,x),y
1700                     ; 155 	float lastStoredValue = 0.0;       // Track the last stored ADC voltage
1702  0534 96            	ldw	x,sp
1703  0535 c60b00        	ld	a,L721+3
1704  0538 d70821        	ld	(OFST-3,x),a
1705  053b c60aff        	ld	a,L721+2
1706  053e d70820        	ld	(OFST-4,x),a
1707  0541 c60afe        	ld	a,L721+1
1708  0544 d7081f        	ld	(OFST-5,x),a
1709  0547 c60afd        	ld	a,L721
1710  054a d7081e        	ld	(OFST-6,x),a
1711                     ; 156 	bool isChannel1 = (channel == VAR_SIGNAL);
1713  054d 96            	ldw	x,sp
1714  054e d60825        	ld	a,(OFST+1,x)
1715  0551 a105          	cp	a,#5
1716  0553 2605          	jrne	L23
1717  0555 ae0001        	ldw	x,#1
1718  0558 2001          	jra	L43
1719  055a               L23:
1720  055a 5f            	clrw	x
1721  055b               L43:
1722                     ; 157 	bool firstSample = true;           // Flag for first sample storage               // Reset last zero-crossing time
1724  055b 96            	ldw	x,sp
1725  055c a601          	ld	a,#1
1726  055e d70822        	ld	(OFST-2,x),a
1727                     ; 158   float dummyRead = convert_adc_to_voltage(read_ADC_Channel(channel));
1729  0561 96            	ldw	x,sp
1730  0562 d60825        	ld	a,(OFST+1,x)
1731  0565 8d000000      	callf	f_read_ADC_Channel
1733  0569 8d3a063a      	callf	f_convert_adc_to_voltage
1735                     ; 159 	uint16_t dcCount = 0;
1738  056d acf805f8      	jra	L555
1739  0571               L355:
1740                     ; 161 		float currentVoltage = convert_adc_to_voltage(read_ADC_Channel(channel));
1742  0571 96            	ldw	x,sp
1743  0572 d60825        	ld	a,(OFST+1,x)
1744  0575 8d000000      	callf	f_read_ADC_Channel
1746  0579 8d3a063a      	callf	f_convert_adc_to_voltage
1748  057d 96            	ldw	x,sp
1749  057e 1c0011        	addw	x,#OFST-2067
1750  0581 8d000000      	callf	d_rtol
1753                     ; 164 		if (fabs(currentVoltage - lastStoredValue) >= 0.01 || firstSample) {
1755  0585 9c            	rvf
1756  0586 96            	ldw	x,sp
1757  0587 1c0011        	addw	x,#OFST-2067
1758  058a 8d000000      	callf	d_ltor
1760  058e 96            	ldw	x,sp
1761  058f 1c081e        	addw	x,#OFST-6
1762  0592 8d000000      	callf	d_fsub
1764  0596 be02          	ldw	x,c_lreg+2
1765  0598 89            	pushw	x
1766  0599 be00          	ldw	x,c_lreg
1767  059b 89            	pushw	x
1768  059c 8d000000      	callf	f_fabs
1770  05a0 9c            	rvf
1771  05a1 5b04          	addw	sp,#4
1772  05a3 ae097c        	ldw	x,#L175
1773  05a6 8d000000      	callf	d_fcmp
1775  05aa 2e07          	jrsge	L365
1777  05ac 96            	ldw	x,sp
1778  05ad d60822        	ld	a,(OFST-2,x)
1779  05b0 4d            	tnz	a
1780  05b1 2745          	jreq	L555
1781  05b3               L365:
1782                     ; 165 			buffer[count] = currentVoltage;
1784  05b3 96            	ldw	x,sp
1785  05b4 1c001e        	addw	x,#OFST-2054
1786  05b7 1f0f          	ldw	(OFST-2069,sp),x
1788  05b9 96            	ldw	x,sp
1789  05ba de0823        	ldw	x,(OFST-1,x)
1790  05bd 58            	sllw	x
1791  05be 58            	sllw	x
1792  05bf 72fb0f        	addw	x,(OFST-2069,sp)
1793  05c2 7b14          	ld	a,(OFST-2064,sp)
1794  05c4 e703          	ld	(3,x),a
1795  05c6 7b13          	ld	a,(OFST-2065,sp)
1796  05c8 e702          	ld	(2,x),a
1797  05ca 7b12          	ld	a,(OFST-2066,sp)
1798  05cc e701          	ld	(1,x),a
1799  05ce 7b11          	ld	a,(OFST-2067,sp)
1800  05d0 f7            	ld	(x),a
1801                     ; 167 			lastStoredValue = currentVoltage;
1803  05d1 96            	ldw	x,sp
1804  05d2 7b14          	ld	a,(OFST-2064,sp)
1805  05d4 d70821        	ld	(OFST-3,x),a
1806  05d7 7b13          	ld	a,(OFST-2065,sp)
1807  05d9 d70820        	ld	(OFST-4,x),a
1808  05dc 7b12          	ld	a,(OFST-2066,sp)
1809  05de d7081f        	ld	(OFST-5,x),a
1810  05e1 7b11          	ld	a,(OFST-2067,sp)
1811  05e3 d7081e        	ld	(OFST-6,x),a
1812                     ; 168 			firstSample = false;  // First sample has been stored
1814  05e6 96            	ldw	x,sp
1815  05e7 724f0822      	clr	(OFST-2,x)
1816                     ; 169 			count++;
1818  05eb 96            	ldw	x,sp
1819  05ec 9093          	ldw	y,x
1820  05ee de0823        	ldw	x,(OFST-1,x)
1821  05f1 1c0001        	addw	x,#1
1822  05f4 90df0823      	ldw	(OFST-1,y),x
1823  05f8               L555:
1824                     ; 160 	while (count < NUM_SAMPLES) {  
1826  05f8 96            	ldw	x,sp
1827  05f9 9093          	ldw	y,x
1828  05fb 90de0823      	ldw	y,(OFST-1,y)
1829  05ff 90a30200      	cpw	y,#512
1830  0603 2404          	jruge	L63
1831  0605 ac710571      	jpf	L355
1832  0609               L63:
1833                     ; 173 	*amplitude = calculate_amplitude(buffer, count);
1835  0609 96            	ldw	x,sp
1836  060a de0823        	ldw	x,(OFST-1,x)
1837  060d 8d000000      	callf	d_uitolx
1839  0611 be02          	ldw	x,c_lreg+2
1840  0613 89            	pushw	x
1841  0614 be00          	ldw	x,c_lreg
1842  0616 89            	pushw	x
1843  0617 96            	ldw	x,sp
1844  0618 1c0022        	addw	x,#OFST-2050
1845  061b 8d770477      	callf	f_calculate_amplitude
1847  061f 5b04          	addw	sp,#4
1848  0621 96            	ldw	x,sp
1849  0622 de082b        	ldw	x,(OFST+7,x)
1850  0625 8d000000      	callf	d_rtol
1852                     ; 174 	return *amplitude;
1854  0629 96            	ldw	x,sp
1855  062a de082b        	ldw	x,(OFST+7,x)
1856  062d 8d000000      	callf	d_ltor
1860  0631 9096          	ldw	y,sp
1861  0633 72a90825      	addw	y,#2085
1862  0637 9094          	ldw	sp,y
1863  0639 87            	retf
1895                     ; 178 float convert_adc_to_voltage(unsigned int adcValue) {
1896                     	switch	.text
1897  063a               f_convert_adc_to_voltage:
1901                     ; 179 	return adcValue * (V_REF / ADC_MAX_VALUE);
1903  063a 8d000000      	callf	d_uitof
1905  063e ae0978        	ldw	x,#L516
1906  0641 8d000000      	callf	d_fmul
1910  0645 87            	retf
1942                     ; 183 float calculate_frequency(unsigned long period) {
1943                     	switch	.text
1944  0646               f_calculate_frequency:
1946  0646 5204          	subw	sp,#4
1947       00000004      OFST:	set	4
1950                     ; 184 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
1952  0648 96            	ldw	x,sp
1953  0649 1c0008        	addw	x,#OFST+4
1954  064c 8d000000      	callf	d_ltor
1956  0650 8d000000      	callf	d_ultof
1958  0654 ae0970        	ldw	x,#L156
1959  0657 8d000000      	callf	d_fdiv
1961  065b 96            	ldw	x,sp
1962  065c 1c0001        	addw	x,#OFST-3
1963  065f 8d000000      	callf	d_rtol
1966  0663 ae0974        	ldw	x,#L146
1967  0666 8d000000      	callf	d_ltor
1969  066a 96            	ldw	x,sp
1970  066b 1c0001        	addw	x,#OFST-3
1971  066e 8d000000      	callf	d_fdiv
1975  0672 5b04          	addw	sp,#4
1976  0674 87            	retf
2034                     ; 188 void output_results(float frequency, float amplitude, float FDR_Voltage) {
2035                     	switch	.text
2036  0675               f_output_results:
2038  0675 5228          	subw	sp,#40
2039       00000028      OFST:	set	40
2042                     ; 192 	sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,0\n", frequency, amplitude, amplitude/4.7, FDR_Voltage);
2044  0677 1e36          	ldw	x,(OFST+14,sp)
2045  0679 89            	pushw	x
2046  067a 1e36          	ldw	x,(OFST+14,sp)
2047  067c 89            	pushw	x
2048  067d 96            	ldw	x,sp
2049  067e 1c0034        	addw	x,#OFST+12
2050  0681 8d000000      	callf	d_ltor
2052  0685 ae0a46        	ldw	x,#L572
2053  0688 8d000000      	callf	d_fdiv
2055  068c be02          	ldw	x,c_lreg+2
2056  068e 89            	pushw	x
2057  068f be00          	ldw	x,c_lreg
2058  0691 89            	pushw	x
2059  0692 1e3a          	ldw	x,(OFST+18,sp)
2060  0694 89            	pushw	x
2061  0695 1e3a          	ldw	x,(OFST+18,sp)
2062  0697 89            	pushw	x
2063  0698 1e3a          	ldw	x,(OFST+18,sp)
2064  069a 89            	pushw	x
2065  069b 1e3a          	ldw	x,(OFST+18,sp)
2066  069d 89            	pushw	x
2067  069e ae0959        	ldw	x,#L107
2068  06a1 89            	pushw	x
2069  06a2 96            	ldw	x,sp
2070  06a3 1c0013        	addw	x,#OFST-21
2071  06a6 8d000000      	callf	f_sprintf
2073  06aa 5b12          	addw	sp,#18
2074                     ; 195 	printf("%s", buffer);
2076  06ac 96            	ldw	x,sp
2077  06ad 1c0001        	addw	x,#OFST-39
2078  06b0 89            	pushw	x
2079  06b1 ae0a97        	ldw	x,#L102
2080  06b4 8d000000      	callf	f_printf
2082  06b8 85            	popw	x
2083                     ; 196 	UART1_SendString(buffer);
2085  06b9 96            	ldw	x,sp
2086  06ba 1c0001        	addw	x,#OFST-39
2087  06bd 8d000000      	callf	f_UART1_SendString
2089                     ; 198 }
2092  06c1 5b28          	addw	sp,#40
2093  06c3 87            	retf
2150                     ; 201 void logResults(const char *logMessage) {
2151                     	switch	.text
2152  06c4               f_logResults:
2154  06c4 89            	pushw	x
2155  06c5 5278          	subw	sp,#120
2156       00000078      OFST:	set	120
2159                     ; 206 	sprintDateTime(datetimeBuffer);
2161  06c7 96            	ldw	x,sp
2162  06c8 1c0001        	addw	x,#OFST-119
2163  06cb 8d000000      	callf	f_sprintDateTime
2165                     ; 209 	sprintf(logBuffer, "%s - %s", datetimeBuffer, logMessage);
2167  06cf 1e79          	ldw	x,(OFST+1,sp)
2168  06d1 89            	pushw	x
2169  06d2 96            	ldw	x,sp
2170  06d3 1c0003        	addw	x,#OFST-117
2171  06d6 89            	pushw	x
2172  06d7 ae0951        	ldw	x,#L137
2173  06da 89            	pushw	x
2174  06db 96            	ldw	x,sp
2175  06dc 1c001b        	addw	x,#OFST-93
2176  06df 8d000000      	callf	f_sprintf
2178  06e3 5b06          	addw	sp,#6
2179                     ; 210 	log_to_eeprom(logBuffer);
2181  06e5 96            	ldw	x,sp
2182  06e6 1c0015        	addw	x,#OFST-99
2183  06e9 8d000000      	callf	f_log_to_eeprom
2185                     ; 212 }
2188  06ed 5b7a          	addw	sp,#122
2189  06ef 87            	retf
2223                     ; 215 void send_square_pulse(uint16_t duration_ms) {
2224                     	switch	.text
2225  06f0               f_send_square_pulse:
2227  06f0 89            	pushw	x
2228       00000000      OFST:	set	0
2231                     ; 216 	GPIO_WriteHigh(SER_THYRISTOR); // Set square pulse pin high
2233  06f1 4b04          	push	#4
2234  06f3 ae500a        	ldw	x,#20490
2235  06f6 8d000000      	callf	f_GPIO_WriteHigh
2237  06fa 84            	pop	a
2238                     ; 217 	delay_ms(duration_ms);            // Wait for the pulse duration
2240  06fb 1e01          	ldw	x,(OFST+1,sp)
2241  06fd 8d000000      	callf	f_delay_ms
2243                     ; 218 	GPIO_WriteLow(SER_THYRISTOR); // Set square pulse pin low
2245  0701 4b04          	push	#4
2246  0703 ae500a        	ldw	x,#20490
2247  0706 8d000000      	callf	f_GPIO_WriteLow
2249  070a 84            	pop	a
2250                     ; 219 }
2253  070b 85            	popw	x
2254  070c 87            	retf
2281                     ; 221 void handle_commutation_pulse(void) {
2282                     	switch	.text
2283  070d               f_handle_commutation_pulse:
2287                     ; 222 	GPIO_WriteHigh(COM_THYRISTOR); // Set square pulse pin high
2289  070d 4b10          	push	#16
2290  070f ae500a        	ldw	x,#20490
2291  0712 8d000000      	callf	f_GPIO_WriteHigh
2293  0716 84            	pop	a
2294                     ; 223 	delay_ms(3000);            // Wait for the pulse duration
2296  0717 ae0bb8        	ldw	x,#3000
2297  071a 8d000000      	callf	f_delay_ms
2299                     ; 224 	GPIO_WriteLow(COM_THYRISTOR); // Set square pulse pin low
2301  071e 4b10          	push	#16
2302  0720 ae500a        	ldw	x,#20490
2303  0723 8d000000      	callf	f_GPIO_WriteLow
2305  0727 84            	pop	a
2306                     ; 225 	GPIO_WriteHigh(LED_ORANGE); // Turn on LED ORANGE
2308  0728 4b08          	push	#8
2309  072a ae500f        	ldw	x,#20495
2310  072d 8d000000      	callf	f_GPIO_WriteHigh
2312  0731 84            	pop	a
2313                     ; 226 	printf("Commutation Thyristor Pulse Sent\n");
2315  0732 ae092f        	ldw	x,#L757
2316  0735 8d000000      	callf	f_printf
2318                     ; 227 }
2321  0739 87            	retf
2356                     ; 229 bool check_FDR_amplitude(void) {
2357                     	switch	.text
2358  073a               f_check_FDR_amplitude:
2360  073a 5204          	subw	sp,#4
2361       00000004      OFST:	set	4
2364                     ; 230     float FDR_amplitude = 0;
2366  073c ae0000        	ldw	x,#0
2367  073f 1f03          	ldw	(OFST-1,sp),x
2368  0741 ae0000        	ldw	x,#0
2369  0744 1f01          	ldw	(OFST-3,sp),x
2371                     ; 231     FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
2373  0746 96            	ldw	x,sp
2374  0747 1c0001        	addw	x,#OFST-3
2375  074a 89            	pushw	x
2376  074b 5f            	clrw	x
2377  074c 89            	pushw	x
2378  074d a606          	ld	a,#6
2379  074f 8d170517      	callf	f_process_adc_signal
2381  0753 5b04          	addw	sp,#4
2382  0755 96            	ldw	x,sp
2383  0756 1c0001        	addw	x,#OFST-3
2384  0759 8d000000      	callf	d_rtol
2387                     ; 232 		printf("Checking FDR_Amplitude: %.2f\n", FDR_amplitude);
2389  075d 1e03          	ldw	x,(OFST-1,sp)
2390  075f 89            	pushw	x
2391  0760 1e03          	ldw	x,(OFST-1,sp)
2392  0762 89            	pushw	x
2393  0763 ae0911        	ldw	x,#L577
2394  0766 8d000000      	callf	f_printf
2396  076a 5b04          	addw	sp,#4
2397                     ; 233     return (FDR_amplitude >= 1.1); // Returns true if FDR_amplitude is non-zero
2399  076c 9c            	rvf
2400  076d 96            	ldw	x,sp
2401  076e 1c0001        	addw	x,#OFST-3
2402  0771 8d000000      	callf	d_ltor
2404  0775 ae0a93        	ldw	x,#L112
2405  0778 8d000000      	callf	d_fcmp
2407  077c 2f04          	jrslt	L65
2408  077e a601          	ld	a,#1
2409  0780 2001          	jra	L06
2410  0782               L65:
2411  0782 4f            	clr	a
2412  0783               L06:
2415  0783 5b04          	addw	sp,#4
2416  0785 87            	retf
2448                     ; 236 float calc_FDR_amplitude(void) {
2449                     	switch	.text
2450  0786               f_calc_FDR_amplitude:
2452  0786 5204          	subw	sp,#4
2453       00000004      OFST:	set	4
2456                     ; 237     float FDR_amplitude = 0;
2458  0788 ae0000        	ldw	x,#0
2459  078b 1f03          	ldw	(OFST-1,sp),x
2460  078d ae0000        	ldw	x,#0
2461  0790 1f01          	ldw	(OFST-3,sp),x
2463                     ; 238     FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
2465  0792 96            	ldw	x,sp
2466  0793 1c0001        	addw	x,#OFST-3
2467  0796 89            	pushw	x
2468  0797 5f            	clrw	x
2469  0798 89            	pushw	x
2470  0799 a606          	ld	a,#6
2471  079b 8d170517      	callf	f_process_adc_signal
2473  079f 5b04          	addw	sp,#4
2474  07a1 96            	ldw	x,sp
2475  07a2 1c0001        	addw	x,#OFST-3
2476  07a5 8d000000      	callf	d_rtol
2479                     ; 239     return (FDR_amplitude); // Returns true if FDR_amplitude is non-zero
2481  07a9 96            	ldw	x,sp
2482  07aa 1c0001        	addw	x,#OFST-3
2483  07ad 8d000000      	callf	d_ltor
2487  07b1 5b04          	addw	sp,#4
2488  07b3 87            	retf
2521                     ; 243 bool check_signal_dc(float amplitude) {
2522                     	switch	.text
2523  07b4               f_check_signal_dc:
2525       00000000      OFST:	set	0
2528                     ; 244 	if (amplitude < 0.5) {
2530  07b4 9c            	rvf
2531  07b5 96            	ldw	x,sp
2532  07b6 1c0004        	addw	x,#OFST+4
2533  07b9 8d000000      	callf	d_ltor
2535  07bd ae090d        	ldw	x,#L5301
2536  07c0 8d000000      	callf	d_fcmp
2538  07c4 2e07          	jrsge	L7201
2539                     ; 245 		isThyristorON = true;
2541  07c6 3501000a      	mov	_isThyristorON,#1
2542                     ; 246 		return true;
2544  07ca a601          	ld	a,#1
2547  07cc 87            	retf
2548  07cd               L7201:
2549                     ; 248 		isThyristorON = false;
2551  07cd 725f000a      	clr	_isThyristorON
2552                     ; 249 		return false;
2554  07d1 4f            	clr	a
2557  07d2 87            	retf
2604                     ; 253 void read_set_frequency(float *set_freq) {
2605                     	switch	.text
2606  07d3               f_read_set_frequency:
2608  07d3 89            	pushw	x
2609  07d4 521e          	subw	sp,#30
2610       0000001e      OFST:	set	30
2613                     ; 255 	internal_EEPROM_ReadStr(0x4000, setFreqString,  sizeof(setFreqString));
2615  07d6 ae001e        	ldw	x,#30
2616  07d9 89            	pushw	x
2617  07da 96            	ldw	x,sp
2618  07db 1c0003        	addw	x,#OFST-27
2619  07de 89            	pushw	x
2620  07df ae4000        	ldw	x,#16384
2621  07e2 89            	pushw	x
2622  07e3 ae0000        	ldw	x,#0
2623  07e6 89            	pushw	x
2624  07e7 8d000000      	callf	f_internal_EEPROM_ReadStr
2626  07eb 5b08          	addw	sp,#8
2627                     ; 256 	printf("String read from EEPROM: %s\n\r", setFreqString);
2629  07ed 96            	ldw	x,sp
2630  07ee 1c0001        	addw	x,#OFST-29
2631  07f1 89            	pushw	x
2632  07f2 ae08ef        	ldw	x,#L5601
2633  07f5 8d000000      	callf	f_printf
2635  07f9 85            	popw	x
2636                     ; 257 	*set_freq = ConvertStringToFloat(setFreqString);
2638  07fa 96            	ldw	x,sp
2639  07fb 1c0001        	addw	x,#OFST-29
2640  07fe 8d000000      	callf	f_ConvertStringToFloat
2642  0802 1e1f          	ldw	x,(OFST+1,sp)
2643  0804 8d000000      	callf	d_rtol
2645                     ; 258 	printf("New set_freq: %f\n", *set_freq);
2647  0808 1e1f          	ldw	x,(OFST+1,sp)
2648  080a 9093          	ldw	y,x
2649  080c ee02          	ldw	x,(2,x)
2650  080e 89            	pushw	x
2651  080f 93            	ldw	x,y
2652  0810 fe            	ldw	x,(x)
2653  0811 89            	pushw	x
2654  0812 ae08dd        	ldw	x,#L7601
2655  0815 8d000000      	callf	f_printf
2657  0819 5b04          	addw	sp,#4
2658                     ; 259 }
2661  081b 5b20          	addw	sp,#32
2662  081d 87            	retf
2710                     ; 261 void  config_mode(void){
2711                     	switch	.text
2712  081e               f_config_mode:
2714  081e 522c          	subw	sp,#44
2715       0000002c      OFST:	set	44
2718                     ; 263   float value = 0;
2720  0820               L1111:
2721                     ; 268 		if (GPIO_ReadInputPin(GPIOA, GPIO_PIN_6) == RESET) {
2723  0820 4b40          	push	#64
2724  0822 ae5000        	ldw	x,#20480
2725  0825 8d000000      	callf	f_GPIO_ReadInputPin
2727  0829 5b01          	addw	sp,#1
2728  082b 4d            	tnz	a
2729  082c 2603          	jrne	L5111
2730                     ; 270 			return;
2733  082e 5b2c          	addw	sp,#44
2734  0830 87            	retf
2735  0831               L5111:
2736                     ; 273 		printf("Entering Config Mode!\n");
2738  0831 ae08c6        	ldw	x,#L7111
2739  0834 8d000000      	callf	f_printf
2741                     ; 274 		printf("Enter the Command!\n");
2743  0838 ae08b2        	ldw	x,#L1211
2744  083b 8d000000      	callf	f_printf
2746                     ; 275 		UART3_ClearBuffer();
2748  083f 8d000000      	callf	f_UART3_ClearBuffer
2750                     ; 276 		UART3_ReceiveString(buffer, sizeof(buffer)); // Receive the first string via UART
2752  0843 ae0028        	ldw	x,#40
2753  0846 89            	pushw	x
2754  0847 96            	ldw	x,sp
2755  0848 1c0007        	addw	x,#OFST-37
2756  084b 8d000000      	callf	f_UART3_ReceiveString
2758  084f 85            	popw	x
2759                     ; 278 		if (strcmp(buffer, "set") == 0) {
2761  0850 ae08ae        	ldw	x,#L5211
2762  0853 89            	pushw	x
2763  0854 96            	ldw	x,sp
2764  0855 1c0007        	addw	x,#OFST-37
2765  0858 8d000000      	callf	f_strcmp
2767  085c 5b02          	addw	sp,#2
2768  085e a30000        	cpw	x,#0
2769  0861 2630          	jrne	L3211
2770                     ; 280 			printf("SET Command Received. Waiting for new parameter...\n");
2772  0863 ae087a        	ldw	x,#L7211
2773  0866 8d000000      	callf	f_printf
2775                     ; 281 			UART3_ReceiveString(buffer, sizeof(buffer)); // Receive the parameter string
2777  086a ae0028        	ldw	x,#40
2778  086d 89            	pushw	x
2779  086e 96            	ldw	x,sp
2780  086f 1c0007        	addw	x,#OFST-37
2781  0872 8d000000      	callf	f_UART3_ReceiveString
2783  0876 85            	popw	x
2784                     ; 283 			printf("123456789\n");
2786  0877 ae086f        	ldw	x,#L1311
2787  087a 8d000000      	callf	f_printf
2789                     ; 285 			internal_EEPROM_WriteStr(0x4000, buffer); // Example address for storing string
2791  087e 96            	ldw	x,sp
2792  087f 1c0005        	addw	x,#OFST-39
2793  0882 89            	pushw	x
2794  0883 ae4000        	ldw	x,#16384
2795  0886 89            	pushw	x
2796  0887 ae0000        	ldw	x,#0
2797  088a 89            	pushw	x
2798  088b 8d000000      	callf	f_internal_EEPROM_WriteStr
2800  088f 5b06          	addw	sp,#6
2802  0891 208d          	jra	L1111
2803  0893               L3211:
2804                     ; 291 		} else if (strcmp(buffer, "ready") == 0) {
2806  0893 ae0869        	ldw	x,#L7311
2807  0896 89            	pushw	x
2808  0897 96            	ldw	x,sp
2809  0898 1c0007        	addw	x,#OFST-37
2810  089b 8d000000      	callf	f_strcmp
2812  089f 5b02          	addw	sp,#2
2813  08a1 a30000        	cpw	x,#0
2814  08a4 2616          	jrne	L5311
2815                     ; 293 			printf("READ Command Received. Reading stored values...\n");
2817  08a6 ae0838        	ldw	x,#L1411
2818  08a9 8d000000      	callf	f_printf
2820                     ; 295 			process_eeprom_logs(); // Example EEPROM address
2822  08ad 8d000000      	callf	f_process_eeprom_logs
2824                     ; 296 			printf("Finished Reading EEPROM!\n");
2826  08b1 ae081e        	ldw	x,#L3411
2827  08b4 8d000000      	callf	f_printf
2830  08b8 ac200820      	jpf	L1111
2831  08bc               L5311:
2832                     ; 300 			printf("Invalid Command Received: %s\n", buffer);
2834  08bc 96            	ldw	x,sp
2835  08bd 1c0005        	addw	x,#OFST-39
2836  08c0 89            	pushw	x
2837  08c1 ae0800        	ldw	x,#L7411
2838  08c4 8d000000      	callf	f_printf
2840  08c8 85            	popw	x
2841  08c9 ac200820      	jpf	L1111
2853                     	xdef	f_main
2854                     	xdef	f_calc_FDR_amplitude
2855                     	xdef	f_handle_commutation_pulse
2856                     	xdef	f_check_FDR_amplitude
2857                     	xdef	f_handle_signal_1_AC
2858                     	xdef	f_handle_Frequency_Below_Set_Freq
2859                     	xdef	f_process_VAR_signal
2860                     	xdef	f_process_FDR_signal
2861                     	xdef	f_logResults
2862                     	xdef	f_config_mode
2863                     	xdef	f_read_set_frequency
2864                     	xdef	f_calculate_frequency
2865                     	xdef	f_convert_adc_to_voltage
2866                     	xdef	f_process_adc_signal
2867                     	xdef	f_calculate_amplitude
2868                     	xdef	f_output_results
2869                     	xdef	f_check_signal_dc
2870                     	xdef	f_send_square_pulse
2871                     	xdef	f_initialize_system
2872                     	xdef	_buffer
2873                     	xdef	_set_freq
2874                     	xdef	_frequency
2875                     	xdef	_set_frequency
2876                     	xdef	_last_cross_time
2877                     	xdef	_end_time
2878                     	xdef	_start_time
2879                     	xdef	_pulse_ticks
2880                     	xdef	_overflow_count
2881                     	xdef	_pulseFlag
2882                     	xdef	_state
2883                     	xdef	_isThyristorON
2884                     	xdef	_count
2885                     	xdef	_sine1_amplitude
2886                     	xdef	_sine1_frequency
2887                     	xref	f_ConvertStringToFloat
2888                     	xref	f_sprintDateTime
2889                     	xref	f_printDateTime
2890                     	xref	f_internal_EEPROM_WriteStr
2891                     	xref	f_internal_EEPROM_ReadStr
2892                     	xref	f_read_ADC_Channel
2893                     	xref	f_UART1_SendString
2894                     	xref	f_UART1_setup
2895                     	xref	f_UART3_ReceiveString
2896                     	xref	f_UART3_ClearBuffer
2897                     	xref	f_INT_EEPROM_Setup
2898                     	xref	f_TIM1_setup
2899                     	xref	f_GPIO_setup
2900                     	xref	f_ADC2_setup
2901                     	xref	f_UART3_setup
2902                     	xref	f_clock_setup
2903                     	xref	f_I2CInit
2904                     	xref	f_log_to_eeprom
2905                     	xref	f_process_eeprom_logs
2906                     	xref	f_EEPROM_Config
2907                     	xref	f_sprintf
2908                     	xref	f_printf
2909                     	xref	f_fabs
2910                     	xref	f_delay_ms
2911                     	xref	f_TIM4_Config
2912                     	xref	f_strcmp
2913                     	xref	f_GPIO_ReadInputPin
2914                     	xref	f_GPIO_WriteLow
2915                     	xref	f_GPIO_WriteHigh
2916                     	switch	.const
2917  0800               L7411:
2918  0800 496e76616c69  	dc.b	"Invalid Command Re"
2919  0812 636569766564  	dc.b	"ceived: %s",10,0
2920  081e               L3411:
2921  081e 46696e697368  	dc.b	"Finished Reading E"
2922  0830 4550524f4d21  	dc.b	"EPROM!",10,0
2923  0838               L1411:
2924  0838 524541442043  	dc.b	"READ Command Recei"
2925  084a 7665642e2052  	dc.b	"ved. Reading store"
2926  085c 642076616c75  	dc.b	"d values...",10,0
2927  0869               L7311:
2928  0869 726561647900  	dc.b	"ready",0
2929  086f               L1311:
2930  086f 313233343536  	dc.b	"123456789",10,0
2931  087a               L7211:
2932  087a 53455420436f  	dc.b	"SET Command Receiv"
2933  088c 65642e205761  	dc.b	"ed. Waiting for ne"
2934  089e 772070617261  	dc.b	"w parameter...",10,0
2935  08ae               L5211:
2936  08ae 73657400      	dc.b	"set",0
2937  08b2               L1211:
2938  08b2 456e74657220  	dc.b	"Enter the Command!"
2939  08c4 0a00          	dc.b	10,0
2940  08c6               L7111:
2941  08c6 456e74657269  	dc.b	"Entering Config Mo"
2942  08d8 6465210a00    	dc.b	"de!",10,0
2943  08dd               L7601:
2944  08dd 4e6577207365  	dc.b	"New set_freq: %f",10,0
2945  08ef               L5601:
2946  08ef 537472696e67  	dc.b	"String read from E"
2947  0901 4550524f4d3a  	dc.b	"EPROM: %s",10
2948  090b 0d00          	dc.b	13,0
2949  090d               L5301:
2950  090d 3f000000      	dc.w	16128,0
2951  0911               L577:
2952  0911 436865636b69  	dc.b	"Checking FDR_Ampli"
2953  0923 747564653a20  	dc.b	"tude: %.2f",10,0
2954  092f               L757:
2955  092f 436f6d6d7574  	dc.b	"Commutation Thyris"
2956  0941 746f72205075  	dc.b	"tor Pulse Sent",10,0
2957  0951               L137:
2958  0951 2573202d2025  	dc.b	"%s - %s",0
2959  0959               L107:
2960  0959 252e33662c25  	dc.b	"%.3f,%.3f,%.3f,%.3"
2961  096b 662c300a00    	dc.b	"f,0",10,0
2962  0970               L156:
2963  0970 49742400      	dc.w	18804,9216
2964  0974               L146:
2965  0974 3f800000      	dc.w	16256,0
2966  0978               L516:
2967  0978 3b933333      	dc.w	15251,13107
2968  097c               L175:
2969  097c 3c23d70a      	dc.w	15395,-10486
2970  0980               L144:
2971  0980 c0933333      	dc.w	-16237,13107
2972  0984               L154:
2973  0984 40933333      	dc.w	16531,13107
2974  0988               L504:
2975  0988 5369676e616c  	dc.b	"Signal 1 DC(After "
2976  099a 4143292e0a00  	dc.b	"AC).",10,0
2977  09a0               L104:
2978  09a0 566172416d70  	dc.b	"VarAmplitude Not b"
2979  09b2 656c6f772031  	dc.b	"elow 10 mv.",10,0
2980  09bf               L173:
2981  09bf 566172416d70  	dc.b	"VarAmplitude below"
2982  09d1 203130206d76  	dc.b	" 10 mv.",10,0
2983  09da               L563:
2984  09da 3d4ccccc      	dc.w	15692,-13108
2985  09de               L533:
2986  09de 5369676e616c  	dc.b	"Signal 1 AC and Va"
2987  09f0 72416d706c69  	dc.b	"rAmplitude: %f.",10,0
2988  0a01               L133:
2989  0a01 5369676e616c  	dc.b	"Signal 1 DC.",10,0
2990  0a0f               L503:
2991  0a0f 467265717565  	dc.b	"Frequency Below Se"
2992  0a21 742046726571  	dc.b	"t Frequency.",10,0
2993  0a2f               L103:
2994  0a2f 252e33662c25  	dc.b	"%.3f,%.3f,%.3f,%.3"
2995  0a41 662c310a00    	dc.b	"f,1",10,0
2996  0a46               L572:
2997  0a46 40966666      	dc.w	16534,26214
2998  0a4a               L762:
2999  0a4a 204672657175  	dc.b	" Frequency: %.3f, "
3000  0a5c 416d706c6974  	dc.b	"Amplitude: %.3f, C"
3001  0a6e 757272656e74  	dc.b	"urrent: %.3f, FDR_"
3002  0a80 566f6c746167  	dc.b	"Voltage: %.3f",10,0
3003  0a8f               L122:
3004  0a8f 3f333333      	dc.w	16179,13107
3005  0a93               L112:
3006  0a93 3f8ccccc      	dc.w	16268,-13108
3007  0a97               L102:
3008  0a97 257300        	dc.b	"%s",0
3009  0a9a               L771:
3010  0a9a 467265713a20  	dc.b	"Freq: %.3f, Field_"
3011  0aac 566f6c743a20  	dc.b	"Volt: %.3f, FDR_Vo"
3012  0abe 6c743a20252e  	dc.b	"lt: %.3f",10,0
3013  0ac8               L741:
3014  0ac8 53797374656d  	dc.b	"System Initializat"
3015  0ada 696f6e20436f  	dc.b	"ion Completed",10
3016  0ae8 0d00          	dc.b	13,0
3017  0aea               L531:
3018  0aea 46445220566f  	dc.b	"FDR Voltage Exists",0
3019  0afd               L721:
3020  0afd 00000000      	dc.w	0,0
3021                     	xref.b	c_lreg
3022                     	xref.b	c_x
3023                     	xref.b	c_y
3043                     	xref	d_ultof
3044                     	xref	d_fmul
3045                     	xref	d_uitof
3046                     	xref	d_uitolx
3047                     	xref	d_xymovl
3048                     	xref	d_fsub
3049                     	xref	d_lcmp
3050                     	xref	d_lgadc
3051                     	xref	d_ctof
3052                     	xref	d_fdiv
3053                     	xref	d_fcmp
3054                     	xref	d_ltor
3055                     	xref	d_rtol
3056                     	end
