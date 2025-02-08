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
  38  001d 40a00000      	dc.w	16544,0
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
 264  0002 ce0a93        	ldw	x,L721+2
 265  0005 1f03          	ldw	(OFST-1,sp),x
 266  0007 ce0a91        	ldw	x,L721
 267  000a 1f01          	ldw	(OFST-3,sp),x
 269                     ; 9 	initialize_system();
 271  000c 8d5e005e      	callf	f_initialize_system
 273                     ; 13 	read_set_frequency(&set_freq);
 275  0010 ae0025        	ldw	x,#_set_freq
 276  0013 8d650765      	callf	f_read_set_frequency
 278                     ; 15 	FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
 280  0017 96            	ldw	x,sp
 281  0018 1c0001        	addw	x,#OFST-3
 282  001b 89            	pushw	x
 283  001c 5f            	clrw	x
 284  001d 89            	pushw	x
 285  001e a606          	ld	a,#6
 286  0020 8dff04ff      	callf	f_process_adc_signal
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
 302  0034 ae0a7e        	ldw	x,#L531
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
 325  0055 8d3d013d      	callf	f_process_VAR_signal
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
 414  0086 ae0a5c        	ldw	x,#L741
 415  0089 8d000000      	callf	f_printf
 417                     ; 38 }
 420  008d 87            	retf
 475                     ; 40 float process_FDR_signal(void) {
 476                     	switch	.text
 477  008e               f_process_FDR_signal:
 479  008e 5230          	subw	sp,#48
 480       00000030      OFST:	set	48
 483                     ; 41 	float FDR_amplitude = 0, VAR_amplitude = 0;
 485  0090 ae0000        	ldw	x,#0
 486  0093 1f2b          	ldw	(OFST-5,sp),x
 487  0095 ae0000        	ldw	x,#0
 488  0098 1f29          	ldw	(OFST-7,sp),x
 492  009a ae0000        	ldw	x,#0
 493  009d 1f2f          	ldw	(OFST-1,sp),x
 494  009f ae0000        	ldw	x,#0
 495  00a2 1f2d          	ldw	(OFST-3,sp),x
 497  00a4               L371:
 498                     ; 44 		VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
 500  00a4 96            	ldw	x,sp
 501  00a5 1c002d        	addw	x,#OFST-3
 502  00a8 89            	pushw	x
 503  00a9 5f            	clrw	x
 504  00aa 89            	pushw	x
 505  00ab a605          	ld	a,#5
 506  00ad 8dff04ff      	callf	f_process_adc_signal
 508  00b1 5b04          	addw	sp,#4
 509  00b3 96            	ldw	x,sp
 510  00b4 1c002d        	addw	x,#OFST-3
 511  00b7 8d000000      	callf	d_rtol
 514                     ; 45 		FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
 516  00bb 96            	ldw	x,sp
 517  00bc 1c0029        	addw	x,#OFST-7
 518  00bf 89            	pushw	x
 519  00c0 5f            	clrw	x
 520  00c1 89            	pushw	x
 521  00c2 a606          	ld	a,#6
 522  00c4 8dff04ff      	callf	f_process_adc_signal
 524  00c8 5b04          	addw	sp,#4
 525  00ca 96            	ldw	x,sp
 526  00cb 1c0029        	addw	x,#OFST-7
 527  00ce 8d000000      	callf	d_rtol
 530                     ; 46     sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", frequency, VAR_amplitude, VAR_amplitude/4.7, FDR_amplitude);
 532  00d2 1e2b          	ldw	x,(OFST-5,sp)
 533  00d4 89            	pushw	x
 534  00d5 1e2b          	ldw	x,(OFST-5,sp)
 535  00d7 89            	pushw	x
 536  00d8 96            	ldw	x,sp
 537  00d9 1c0031        	addw	x,#OFST+1
 538  00dc 8d000000      	callf	d_ltor
 540  00e0 ae0a41        	ldw	x,#L502
 541  00e3 8d000000      	callf	d_fdiv
 543  00e7 be02          	ldw	x,c_lreg+2
 544  00e9 89            	pushw	x
 545  00ea be00          	ldw	x,c_lreg
 546  00ec 89            	pushw	x
 547  00ed 1e37          	ldw	x,(OFST+7,sp)
 548  00ef 89            	pushw	x
 549  00f0 1e37          	ldw	x,(OFST+7,sp)
 550  00f2 89            	pushw	x
 551  00f3 ce0023        	ldw	x,_frequency+2
 552  00f6 89            	pushw	x
 553  00f7 ce0021        	ldw	x,_frequency
 554  00fa 89            	pushw	x
 555  00fb ae0a45        	ldw	x,#L771
 556  00fe 89            	pushw	x
 557  00ff 96            	ldw	x,sp
 558  0100 1c0013        	addw	x,#OFST-29
 559  0103 8d000000      	callf	f_sprintf
 561  0107 5b12          	addw	sp,#18
 562                     ; 47 	  printf("%s", buffer);
 564  0109 96            	ldw	x,sp
 565  010a 1c0001        	addw	x,#OFST-47
 566  010d 89            	pushw	x
 567  010e ae0a3e        	ldw	x,#L112
 568  0111 8d000000      	callf	f_printf
 570  0115 85            	popw	x
 571                     ; 48 		logResults(buffer);
 573  0116 96            	ldw	x,sp
 574  0117 1c0001        	addw	x,#OFST-47
 575  011a 8da006a0      	callf	f_logResults
 577                     ; 49 		if ((FDR_amplitude > 0) && (VAR_amplitude > 0)) {
 579  011e 9c            	rvf
 580  011f 9c            	rvf
 581  0120 0d29          	tnz	(OFST-7,sp)
 582  0122 2d80          	jrsle	L371
 584  0124 9c            	rvf
 585  0125 9c            	rvf
 586  0126 0d2d          	tnz	(OFST-3,sp)
 587  0128 2c04          	jrsgt	L21
 588  012a aca400a4      	jpf	L371
 589  012e               L21:
 590  012e               L512:
 591                     ; 51 				handle_commutation_pulse(); // Execute the pulse sending
 593  012e 8de906e9      	callf	f_handle_commutation_pulse
 595                     ; 52 			} while (check_FDR_amplitude()); // Repeat if FDR_amplitude is still non-zero
 597  0132 8d160716      	callf	f_check_FDR_amplitude
 599  0136 4d            	tnz	a
 600  0137 26f5          	jrne	L512
 601  0139 aca400a4      	jpf	L371
 675                     ; 58 void process_VAR_signal(float FDR_amplitude) {
 676                     	switch	.text
 677  013d               f_process_VAR_signal:
 679  013d 5266          	subw	sp,#102
 680       00000066      OFST:	set	102
 683                     ; 59 	float VAR_frequency = 0.0, VAR_amplitude = 0.0;
 687  013f ce0a93        	ldw	x,L721+2
 688  0142 1f65          	ldw	(OFST-1,sp),x
 689  0144 ce0a91        	ldw	x,L721
 690  0147 1f63          	ldw	(OFST-3,sp),x
 692  0149               L352:
 693                     ; 62 		VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
 695  0149 96            	ldw	x,sp
 696  014a 1c0063        	addw	x,#OFST-3
 697  014d 89            	pushw	x
 698  014e 5f            	clrw	x
 699  014f 89            	pushw	x
 700  0150 a605          	ld	a,#5
 701  0152 8dff04ff      	callf	f_process_adc_signal
 703  0156 5b04          	addw	sp,#4
 704  0158 96            	ldw	x,sp
 705  0159 1c0063        	addw	x,#OFST-3
 706  015c 8d000000      	callf	d_rtol
 709                     ; 63 		VAR_frequency = frequency;
 711  0160 ce0023        	ldw	x,_frequency+2
 712  0163 1f61          	ldw	(OFST-5,sp),x
 713  0165 ce0021        	ldw	x,_frequency
 714  0168 1f5f          	ldw	(OFST-7,sp),x
 716                     ; 64 		printDateTime();
 718  016a 8d000000      	callf	f_printDateTime
 720                     ; 67 		printf(" Frequency: %.3f, Amplitude: %.3f, Current: %.3f, FDR_Voltage: %.3f\n",
 720                     ; 68 					 VAR_frequency, VAR_amplitude, VAR_amplitude / 4.7, FDR_amplitude);
 722  016e 1e6c          	ldw	x,(OFST+6,sp)
 723  0170 89            	pushw	x
 724  0171 1e6c          	ldw	x,(OFST+6,sp)
 725  0173 89            	pushw	x
 726  0174 96            	ldw	x,sp
 727  0175 1c0067        	addw	x,#OFST+1
 728  0178 8d000000      	callf	d_ltor
 730  017c ae0a41        	ldw	x,#L502
 731  017f 8d000000      	callf	d_fdiv
 733  0183 be02          	ldw	x,c_lreg+2
 734  0185 89            	pushw	x
 735  0186 be00          	ldw	x,c_lreg
 736  0188 89            	pushw	x
 737  0189 1e6d          	ldw	x,(OFST+7,sp)
 738  018b 89            	pushw	x
 739  018c 1e6d          	ldw	x,(OFST+7,sp)
 740  018e 89            	pushw	x
 741  018f 1e6d          	ldw	x,(OFST+7,sp)
 742  0191 89            	pushw	x
 743  0192 1e6d          	ldw	x,(OFST+7,sp)
 744  0194 89            	pushw	x
 745  0195 ae09f9        	ldw	x,#L752
 746  0198 8d000000      	callf	f_printf
 748  019c 5b10          	addw	sp,#16
 749                     ; 69     sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", frequency, VAR_amplitude, VAR_amplitude/4.7, FDR_amplitude);
 751  019e 1e6c          	ldw	x,(OFST+6,sp)
 752  01a0 89            	pushw	x
 753  01a1 1e6c          	ldw	x,(OFST+6,sp)
 754  01a3 89            	pushw	x
 755  01a4 96            	ldw	x,sp
 756  01a5 1c0067        	addw	x,#OFST+1
 757  01a8 8d000000      	callf	d_ltor
 759  01ac ae0a41        	ldw	x,#L502
 760  01af 8d000000      	callf	d_fdiv
 762  01b3 be02          	ldw	x,c_lreg+2
 763  01b5 89            	pushw	x
 764  01b6 be00          	ldw	x,c_lreg
 765  01b8 89            	pushw	x
 766  01b9 1e6d          	ldw	x,(OFST+7,sp)
 767  01bb 89            	pushw	x
 768  01bc 1e6d          	ldw	x,(OFST+7,sp)
 769  01be 89            	pushw	x
 770  01bf ce0023        	ldw	x,_frequency+2
 771  01c2 89            	pushw	x
 772  01c3 ce0021        	ldw	x,_frequency
 773  01c6 89            	pushw	x
 774  01c7 ae0a45        	ldw	x,#L771
 775  01ca 89            	pushw	x
 776  01cb 96            	ldw	x,sp
 777  01cc 1c003f        	addw	x,#OFST-39
 778  01cf 8d000000      	callf	f_sprintf
 780  01d3 5b12          	addw	sp,#18
 781                     ; 70 		logResults(buffer);
 783  01d5 96            	ldw	x,sp
 784  01d6 1c002d        	addw	x,#OFST-57
 785  01d9 8da006a0      	callf	f_logResults
 787                     ; 71 		output_results(VAR_frequency, VAR_amplitude, FDR_amplitude);
 789  01dd 1e6c          	ldw	x,(OFST+6,sp)
 790  01df 89            	pushw	x
 791  01e0 1e6c          	ldw	x,(OFST+6,sp)
 792  01e2 89            	pushw	x
 793  01e3 1e69          	ldw	x,(OFST+3,sp)
 794  01e5 89            	pushw	x
 795  01e6 1e69          	ldw	x,(OFST+3,sp)
 796  01e8 89            	pushw	x
 797  01e9 1e69          	ldw	x,(OFST+3,sp)
 798  01eb 89            	pushw	x
 799  01ec 1e69          	ldw	x,(OFST+3,sp)
 800  01ee 89            	pushw	x
 801  01ef 8d510651      	callf	f_output_results
 803  01f3 5b0c          	addw	sp,#12
 804                     ; 73 		if (VAR_frequency <= SET_FREQ) {
 806  01f5 9c            	rvf
 807  01f6 a605          	ld	a,#5
 808  01f8 8d000000      	callf	d_ctof
 810  01fc 96            	ldw	x,sp
 811  01fd 1c0001        	addw	x,#OFST-101
 812  0200 8d000000      	callf	d_rtol
 815  0204 96            	ldw	x,sp
 816  0205 1c005f        	addw	x,#OFST-7
 817  0208 8d000000      	callf	d_ltor
 819  020c 96            	ldw	x,sp
 820  020d 1c0001        	addw	x,#OFST-101
 821  0210 8d000000      	callf	d_fcmp
 823  0214 2d04          	jrsle	L61
 824  0216 ac490149      	jpf	L352
 825  021a               L61:
 826                     ; 75 			pulseFlag = 1;
 828  021a 3501000c      	mov	_pulseFlag,#1
 829                     ; 76 			printf("Frequency Below Set Frequency.\n");
 831  021e ae09d9        	ldw	x,#L362
 832  0221 8d000000      	callf	f_printf
 834                     ; 78 			sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", VAR_frequency, VAR_amplitude, VAR_amplitude/4.7, FDR_amplitude);
 836  0225 1e6c          	ldw	x,(OFST+6,sp)
 837  0227 89            	pushw	x
 838  0228 1e6c          	ldw	x,(OFST+6,sp)
 839  022a 89            	pushw	x
 840  022b 96            	ldw	x,sp
 841  022c 1c0067        	addw	x,#OFST+1
 842  022f 8d000000      	callf	d_ltor
 844  0233 ae0a41        	ldw	x,#L502
 845  0236 8d000000      	callf	d_fdiv
 847  023a be02          	ldw	x,c_lreg+2
 848  023c 89            	pushw	x
 849  023d be00          	ldw	x,c_lreg
 850  023f 89            	pushw	x
 851  0240 1e6d          	ldw	x,(OFST+7,sp)
 852  0242 89            	pushw	x
 853  0243 1e6d          	ldw	x,(OFST+7,sp)
 854  0245 89            	pushw	x
 855  0246 1e6d          	ldw	x,(OFST+7,sp)
 856  0248 89            	pushw	x
 857  0249 1e6d          	ldw	x,(OFST+7,sp)
 858  024b 89            	pushw	x
 859  024c ae0a45        	ldw	x,#L771
 860  024f 89            	pushw	x
 861  0250 96            	ldw	x,sp
 862  0251 1c0017        	addw	x,#OFST-79
 863  0254 8d000000      	callf	f_sprintf
 865  0258 5b12          	addw	sp,#18
 866                     ; 79 			printf("%s", buffer);
 868  025a 96            	ldw	x,sp
 869  025b 1c0005        	addw	x,#OFST-97
 870  025e 89            	pushw	x
 871  025f ae0a3e        	ldw	x,#L112
 872  0262 8d000000      	callf	f_printf
 874  0266 85            	popw	x
 875                     ; 80 			logResults(buffer);
 877  0267 96            	ldw	x,sp
 878  0268 1c0005        	addw	x,#OFST-97
 879  026b 8da006a0      	callf	f_logResults
 881                     ; 81 			handle_Frequency_Below_Set_Freq(VAR_amplitude);
 883  026f 1e65          	ldw	x,(OFST-1,sp)
 884  0271 89            	pushw	x
 885  0272 1e65          	ldw	x,(OFST-1,sp)
 886  0274 89            	pushw	x
 887  0275 8d7f027f      	callf	f_handle_Frequency_Below_Set_Freq
 889  0279 5b04          	addw	sp,#4
 890  027b ac490149      	jpf	L352
 941                     ; 86 void handle_Frequency_Below_Set_Freq(float VAR_amplitude) {
 942                     	switch	.text
 943  027f               f_handle_Frequency_Below_Set_Freq:
 945  027f 5228          	subw	sp,#40
 946       00000028      OFST:	set	40
 949                     ; 88 	GPIO_WriteHigh(LED_BLUE); 
 951  0281 4b01          	push	#1
 952  0283 ae500f        	ldw	x,#20495
 953  0286 8d000000      	callf	f_GPIO_WriteHigh
 955  028a 84            	pop	a
 956                     ; 89 	GPIO_WriteHigh(GPIOD, GPIO_PIN_2); 
 958  028b 4b04          	push	#4
 959  028d ae500f        	ldw	x,#20495
 960  0290 8d000000      	callf	f_GPIO_WriteHigh
 962  0294 84            	pop	a
 963                     ; 90 	VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
 965  0295 96            	ldw	x,sp
 966  0296 1c002c        	addw	x,#OFST+4
 967  0299 89            	pushw	x
 968  029a 5f            	clrw	x
 969  029b 89            	pushw	x
 970  029c a605          	ld	a,#5
 971  029e 8dff04ff      	callf	f_process_adc_signal
 973  02a2 5b04          	addw	sp,#4
 974  02a4 96            	ldw	x,sp
 975  02a5 1c002c        	addw	x,#OFST+4
 976  02a8 8d000000      	callf	d_rtol
 978                     ; 91   sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", frequency, VAR_amplitude, VAR_amplitude/4.7, 0);
 980  02ac 5f            	clrw	x
 981  02ad 89            	pushw	x
 982  02ae 96            	ldw	x,sp
 983  02af 1c002e        	addw	x,#OFST+6
 984  02b2 8d000000      	callf	d_ltor
 986  02b6 ae0a41        	ldw	x,#L502
 987  02b9 8d000000      	callf	d_fdiv
 989  02bd be02          	ldw	x,c_lreg+2
 990  02bf 89            	pushw	x
 991  02c0 be00          	ldw	x,c_lreg
 992  02c2 89            	pushw	x
 993  02c3 1e34          	ldw	x,(OFST+12,sp)
 994  02c5 89            	pushw	x
 995  02c6 1e34          	ldw	x,(OFST+12,sp)
 996  02c8 89            	pushw	x
 997  02c9 ce0023        	ldw	x,_frequency+2
 998  02cc 89            	pushw	x
 999  02cd ce0021        	ldw	x,_frequency
1000  02d0 89            	pushw	x
1001  02d1 ae0a45        	ldw	x,#L771
1002  02d4 89            	pushw	x
1003  02d5 96            	ldw	x,sp
1004  02d6 1c0011        	addw	x,#OFST-23
1005  02d9 8d000000      	callf	f_sprintf
1007  02dd 5b10          	addw	sp,#16
1008                     ; 92 	printf("%s", buffer);
1010  02df 96            	ldw	x,sp
1011  02e0 1c0001        	addw	x,#OFST-39
1012  02e3 89            	pushw	x
1013  02e4 ae0a3e        	ldw	x,#L112
1014  02e7 8d000000      	callf	f_printf
1016  02eb 85            	popw	x
1017                     ; 93 	logResults(buffer);
1019  02ec 96            	ldw	x,sp
1020  02ed 1c0001        	addw	x,#OFST-39
1021  02f0 8da006a0      	callf	f_logResults
1023                     ; 94 	if (check_signal_dc(VAR_amplitude)) {
1025  02f4 1e2e          	ldw	x,(OFST+6,sp)
1026  02f6 89            	pushw	x
1027  02f7 1e2e          	ldw	x,(OFST+6,sp)
1028  02f9 89            	pushw	x
1029  02fa 8d460746      	callf	f_check_signal_dc
1031  02fe 5b04          	addw	sp,#4
1032  0300 4d            	tnz	a
1033  0301 2717          	jreq	L503
1034                     ; 96 		printf("Signal 1 DC.\n");
1036  0303 ae09cb        	ldw	x,#L703
1037  0306 8d000000      	callf	f_printf
1039                     ; 97 		GPIO_WriteHigh(LED_BLUE); 
1041  030a 4b01          	push	#1
1042  030c ae500f        	ldw	x,#20495
1043  030f 8d000000      	callf	f_GPIO_WriteHigh
1045  0313 84            	pop	a
1046                     ; 98 		process_FDR_signal();
1048  0314 8d8e008e      	callf	f_process_FDR_signal
1051  0318 201b          	jra	L113
1052  031a               L503:
1053                     ; 101 		printf("Signal 1 AC and VarAmplitude: %f.\n", VAR_amplitude);
1055  031a 1e2e          	ldw	x,(OFST+6,sp)
1056  031c 89            	pushw	x
1057  031d 1e2e          	ldw	x,(OFST+6,sp)
1058  031f 89            	pushw	x
1059  0320 ae09a8        	ldw	x,#L313
1060  0323 8d000000      	callf	f_printf
1062  0327 5b04          	addw	sp,#4
1063                     ; 102 		handle_signal_1_AC(VAR_amplitude);
1065  0329 1e2e          	ldw	x,(OFST+6,sp)
1066  032b 89            	pushw	x
1067  032c 1e2e          	ldw	x,(OFST+6,sp)
1068  032e 89            	pushw	x
1069  032f 8d380338      	callf	f_handle_signal_1_AC
1071  0333 5b04          	addw	sp,#4
1072  0335               L113:
1073                     ; 104 }
1076  0335 5b28          	addw	sp,#40
1077  0337 87            	retf
1128                     ; 107 void handle_signal_1_AC(float VAR_amplitude) {
1129                     	switch	.text
1130  0338               f_handle_signal_1_AC:
1132  0338 5228          	subw	sp,#40
1133       00000028      OFST:	set	40
1136                     ; 109 	VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
1138  033a 96            	ldw	x,sp
1139  033b 1c002c        	addw	x,#OFST+4
1140  033e 89            	pushw	x
1141  033f 5f            	clrw	x
1142  0340 89            	pushw	x
1143  0341 a605          	ld	a,#5
1144  0343 8dff04ff      	callf	f_process_adc_signal
1146  0347 5b04          	addw	sp,#4
1147  0349 96            	ldw	x,sp
1148  034a 1c002c        	addw	x,#OFST+4
1149  034d 8d000000      	callf	d_rtol
1151                     ; 110 	if (VAR_amplitude < AC_AMPLITUDE_THRESHOLD) {
1153  0351 9c            	rvf
1154  0352 96            	ldw	x,sp
1155  0353 1c002c        	addw	x,#OFST+4
1156  0356 8d000000      	callf	d_ltor
1158  035a ae09a4        	ldw	x,#L343
1159  035d 8d000000      	callf	d_fcmp
1161  0361 2e68          	jrsge	L353
1162                     ; 112 		sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", frequency, VAR_amplitude, VAR_amplitude/4.7, 0);
1164  0363 5f            	clrw	x
1165  0364 89            	pushw	x
1166  0365 96            	ldw	x,sp
1167  0366 1c002e        	addw	x,#OFST+6
1168  0369 8d000000      	callf	d_ltor
1170  036d ae0a41        	ldw	x,#L502
1171  0370 8d000000      	callf	d_fdiv
1173  0374 be02          	ldw	x,c_lreg+2
1174  0376 89            	pushw	x
1175  0377 be00          	ldw	x,c_lreg
1176  0379 89            	pushw	x
1177  037a 1e34          	ldw	x,(OFST+12,sp)
1178  037c 89            	pushw	x
1179  037d 1e34          	ldw	x,(OFST+12,sp)
1180  037f 89            	pushw	x
1181  0380 ce0023        	ldw	x,_frequency+2
1182  0383 89            	pushw	x
1183  0384 ce0021        	ldw	x,_frequency
1184  0387 89            	pushw	x
1185  0388 ae0a45        	ldw	x,#L771
1186  038b 89            	pushw	x
1187  038c 96            	ldw	x,sp
1188  038d 1c0011        	addw	x,#OFST-23
1189  0390 8d000000      	callf	f_sprintf
1191  0394 5b10          	addw	sp,#16
1192                     ; 113 	  printf("%s", buffer);
1194  0396 96            	ldw	x,sp
1195  0397 1c0001        	addw	x,#OFST-39
1196  039a 89            	pushw	x
1197  039b ae0a3e        	ldw	x,#L112
1198  039e 8d000000      	callf	f_printf
1200  03a2 85            	popw	x
1201                     ; 114 		logResults(buffer);
1203  03a3 96            	ldw	x,sp
1204  03a4 1c0001        	addw	x,#OFST-39
1205  03a7 8da006a0      	callf	f_logResults
1207                     ; 115 		printf("VarAmplitude below 10 mv.\n");
1209  03ab ae0989        	ldw	x,#L743
1210  03ae 8d000000      	callf	f_printf
1212                     ; 116 		GPIO_WriteLow(LED_WHITE); // Turn on LED if Signal is AC < 20 mV
1214  03b2 4b08          	push	#8
1215  03b4 ae500a        	ldw	x,#20490
1216  03b7 8d000000      	callf	f_GPIO_WriteLow
1218  03bb 84            	pop	a
1219                     ; 117 		delay_ms(3000);
1221  03bc ae0bb8        	ldw	x,#3000
1222  03bf 8d000000      	callf	f_delay_ms
1224                     ; 118 		pulseFlag = 1;
1226  03c3 3501000c      	mov	_pulseFlag,#1
1228  03c7 ac5c045c      	jpf	L153
1229  03cb               L353:
1230                     ; 121 			pulseFlag = 1;
1232  03cb 3501000c      	mov	_pulseFlag,#1
1233                     ; 123 			GPIO_WriteHigh(GPIOD, GPIO_PIN_7);  // Turn on LED if Signal is AC < 20 ms
1235  03cf 4b80          	push	#128
1236  03d1 ae500f        	ldw	x,#20495
1237  03d4 8d000000      	callf	f_GPIO_WriteHigh
1239  03d8 84            	pop	a
1240                     ; 124 			sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", frequency, VAR_amplitude, VAR_amplitude/4.7, 0);
1242  03d9 5f            	clrw	x
1243  03da 89            	pushw	x
1244  03db 96            	ldw	x,sp
1245  03dc 1c002e        	addw	x,#OFST+6
1246  03df 8d000000      	callf	d_ltor
1248  03e3 ae0a41        	ldw	x,#L502
1249  03e6 8d000000      	callf	d_fdiv
1251  03ea be02          	ldw	x,c_lreg+2
1252  03ec 89            	pushw	x
1253  03ed be00          	ldw	x,c_lreg
1254  03ef 89            	pushw	x
1255  03f0 1e34          	ldw	x,(OFST+12,sp)
1256  03f2 89            	pushw	x
1257  03f3 1e34          	ldw	x,(OFST+12,sp)
1258  03f5 89            	pushw	x
1259  03f6 ce0023        	ldw	x,_frequency+2
1260  03f9 89            	pushw	x
1261  03fa ce0021        	ldw	x,_frequency
1262  03fd 89            	pushw	x
1263  03fe ae0a45        	ldw	x,#L771
1264  0401 89            	pushw	x
1265  0402 96            	ldw	x,sp
1266  0403 1c0011        	addw	x,#OFST-23
1267  0406 8d000000      	callf	f_sprintf
1269  040a 5b10          	addw	sp,#16
1270                     ; 125 			printf("%s", buffer);
1272  040c 96            	ldw	x,sp
1273  040d 1c0001        	addw	x,#OFST-39
1274  0410 89            	pushw	x
1275  0411 ae0a3e        	ldw	x,#L112
1276  0414 8d000000      	callf	f_printf
1278  0418 85            	popw	x
1279                     ; 126 			logResults(buffer);
1281  0419 96            	ldw	x,sp
1282  041a 1c0001        	addw	x,#OFST-39
1283  041d 8da006a0      	callf	f_logResults
1285                     ; 127 			printf("VarAmplitude Not below 10 mv.\n");
1287  0421 ae096a        	ldw	x,#L753
1288  0424 8d000000      	callf	f_printf
1290                     ; 128 			GPIO_WriteHigh(LED_WHITE);  // Turn on LED if Signal is AC < 20 ms	
1292  0428 4b08          	push	#8
1293  042a ae500a        	ldw	x,#20490
1294  042d 8d000000      	callf	f_GPIO_WriteHigh
1296  0431 84            	pop	a
1297                     ; 129 			VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
1299  0432 96            	ldw	x,sp
1300  0433 1c002c        	addw	x,#OFST+4
1301  0436 89            	pushw	x
1302  0437 5f            	clrw	x
1303  0438 89            	pushw	x
1304  0439 a605          	ld	a,#5
1305  043b 8dff04ff      	callf	f_process_adc_signal
1307  043f 5b04          	addw	sp,#4
1308  0441 96            	ldw	x,sp
1309  0442 1c002c        	addw	x,#OFST+4
1310  0445 8d000000      	callf	d_rtol
1312                     ; 131 			if(check_signal_dc(VAR_amplitude))
1314  0449 1e2e          	ldw	x,(OFST+6,sp)
1315  044b 89            	pushw	x
1316  044c 1e2e          	ldw	x,(OFST+6,sp)
1317  044e 89            	pushw	x
1318  044f 8d460746      	callf	f_check_signal_dc
1320  0453 5b04          	addw	sp,#4
1321  0455 4d            	tnz	a
1322  0456 2604          	jrne	L42
1323  0458 accb03cb      	jpf	L353
1324  045c               L42:
1325                     ; 132 				break;
1326  045c               L153:
1327                     ; 135 }
1330  045c 5b28          	addw	sp,#40
1331  045e 87            	retf
1394                     ; 138 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
1395                     	switch	.text
1396  045f               f_calculate_amplitude:
1398  045f 89            	pushw	x
1399  0460 520c          	subw	sp,#12
1400       0000000c      OFST:	set	12
1403                     ; 139 	uint32_t i = 0;
1405                     ; 140 	float max_val = -V_REF, min_val = V_REF;
1407  0462 ce0964        	ldw	x,L514+2
1408  0465 1f03          	ldw	(OFST-9,sp),x
1409  0467 ce0962        	ldw	x,L514
1410  046a 1f01          	ldw	(OFST-11,sp),x
1414  046c ce0968        	ldw	x,L524+2
1415  046f 1f07          	ldw	(OFST-5,sp),x
1416  0471 ce0966        	ldw	x,L524
1417  0474 1f05          	ldw	(OFST-7,sp),x
1419                     ; 142 	for (i = 0; i < sample_size; i++) {
1421  0476 ae0000        	ldw	x,#0
1422  0479 1f0b          	ldw	(OFST-1,sp),x
1423  047b ae0000        	ldw	x,#0
1424  047e 1f09          	ldw	(OFST-3,sp),x
1427  0480 2058          	jra	L534
1428  0482               L134:
1429                     ; 143 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1431  0482 9c            	rvf
1432  0483 1e0b          	ldw	x,(OFST-1,sp)
1433  0485 58            	sllw	x
1434  0486 58            	sllw	x
1435  0487 72fb0d        	addw	x,(OFST+1,sp)
1436  048a 8d000000      	callf	d_ltor
1438  048e 96            	ldw	x,sp
1439  048f 1c0001        	addw	x,#OFST-11
1440  0492 8d000000      	callf	d_fcmp
1442  0496 2d11          	jrsle	L144
1445  0498 1e0b          	ldw	x,(OFST-1,sp)
1446  049a 58            	sllw	x
1447  049b 58            	sllw	x
1448  049c 72fb0d        	addw	x,(OFST+1,sp)
1449  049f 9093          	ldw	y,x
1450  04a1 ee02          	ldw	x,(2,x)
1451  04a3 1f03          	ldw	(OFST-9,sp),x
1452  04a5 93            	ldw	x,y
1453  04a6 fe            	ldw	x,(x)
1454  04a7 1f01          	ldw	(OFST-11,sp),x
1456  04a9               L144:
1457                     ; 144 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1459  04a9 9c            	rvf
1460  04aa 1e0b          	ldw	x,(OFST-1,sp)
1461  04ac 58            	sllw	x
1462  04ad 58            	sllw	x
1463  04ae 72fb0d        	addw	x,(OFST+1,sp)
1464  04b1 8d000000      	callf	d_ltor
1466  04b5 96            	ldw	x,sp
1467  04b6 1c0005        	addw	x,#OFST-7
1468  04b9 8d000000      	callf	d_fcmp
1470  04bd 2e11          	jrsge	L344
1473  04bf 1e0b          	ldw	x,(OFST-1,sp)
1474  04c1 58            	sllw	x
1475  04c2 58            	sllw	x
1476  04c3 72fb0d        	addw	x,(OFST+1,sp)
1477  04c6 9093          	ldw	y,x
1478  04c8 ee02          	ldw	x,(2,x)
1479  04ca 1f07          	ldw	(OFST-5,sp),x
1480  04cc 93            	ldw	x,y
1481  04cd fe            	ldw	x,(x)
1482  04ce 1f05          	ldw	(OFST-7,sp),x
1484  04d0               L344:
1485                     ; 142 	for (i = 0; i < sample_size; i++) {
1487  04d0 96            	ldw	x,sp
1488  04d1 1c0009        	addw	x,#OFST-3
1489  04d4 a601          	ld	a,#1
1490  04d6 8d000000      	callf	d_lgadc
1493  04da               L534:
1496  04da 96            	ldw	x,sp
1497  04db 1c0009        	addw	x,#OFST-3
1498  04de 8d000000      	callf	d_ltor
1500  04e2 96            	ldw	x,sp
1501  04e3 1c0012        	addw	x,#OFST+6
1502  04e6 8d000000      	callf	d_lcmp
1504  04ea 2596          	jrult	L134
1505                     ; 147 	return (max_val - min_val);
1507  04ec 96            	ldw	x,sp
1508  04ed 1c0001        	addw	x,#OFST-11
1509  04f0 8d000000      	callf	d_ltor
1511  04f4 96            	ldw	x,sp
1512  04f5 1c0005        	addw	x,#OFST-7
1513  04f8 8d000000      	callf	d_fsub
1517  04fc 5b0e          	addw	sp,#14
1518  04fe 87            	retf
1520                     .const:	section	.text
1521  0000               L544_buffer:
1522  0000 00000000      	dc.w	0,0
1523  0004 000000000000  	ds.b	2044
1645                     ; 150 float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
1646                     	switch	.text
1647  04ff               f_process_adc_signal:
1649  04ff 88            	push	a
1650  0500 96            	ldw	x,sp
1651  0501 1d081e        	subw	x,#2078
1652  0504 94            	ldw	sp,x
1653       0000081e      OFST:	set	2078
1656                     ; 151 	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
1658  0505 96            	ldw	x,sp
1659  0506 1c0018        	addw	x,#OFST-2054
1660  0509 90ae0000      	ldw	y,#L544_buffer
1661  050d bf00          	ldw	c_x,x
1662  050f ae0800        	ldw	x,#2048
1663  0512 8d000000      	callf	d_xymovl
1665                     ; 152 	uint16_t i = 0, count = 0;
1669  0516 96            	ldw	x,sp
1670  0517 905f          	clrw	y
1671  0519 df081d        	ldw	(OFST-1,x),y
1672                     ; 153 	float lastStoredValue = 0.0;       // Track the last stored ADC voltage
1674  051c 96            	ldw	x,sp
1675  051d c60a94        	ld	a,L721+3
1676  0520 d7081b        	ld	(OFST-3,x),a
1677  0523 c60a93        	ld	a,L721+2
1678  0526 d7081a        	ld	(OFST-4,x),a
1679  0529 c60a92        	ld	a,L721+1
1680  052c d70819        	ld	(OFST-5,x),a
1681  052f c60a91        	ld	a,L721
1682  0532 d70818        	ld	(OFST-6,x),a
1683                     ; 154 	bool isChannel1 = (channel == VAR_SIGNAL);
1685  0535 96            	ldw	x,sp
1686  0536 d6081f        	ld	a,(OFST+1,x)
1687  0539 a105          	cp	a,#5
1688  053b 2605          	jrne	L23
1689  053d ae0001        	ldw	x,#1
1690  0540 2001          	jra	L43
1691  0542               L23:
1692  0542 5f            	clrw	x
1693  0543               L43:
1694                     ; 155 	bool firstSample = true;           // Flag for first sample storage               // Reset last zero-crossing time
1696  0543 96            	ldw	x,sp
1697  0544 a601          	ld	a,#1
1698  0546 d7081c        	ld	(OFST-2,x),a
1700  0549 acd405d4      	jra	L725
1701  054d               L325:
1702                     ; 160 		float currentVoltage = convert_adc_to_voltage(read_ADC_Channel(channel));
1704  054d 96            	ldw	x,sp
1705  054e d6081f        	ld	a,(OFST+1,x)
1706  0551 8d000000      	callf	f_read_ADC_Channel
1708  0555 8d160616      	callf	f_convert_adc_to_voltage
1710  0559 96            	ldw	x,sp
1711  055a 1c0011        	addw	x,#OFST-2061
1712  055d 8d000000      	callf	d_rtol
1715                     ; 163 		if (firstSample || fabs(currentVoltage - lastStoredValue) >= 0.1) {
1717  0561 96            	ldw	x,sp
1718  0562 d6081c        	ld	a,(OFST-2,x)
1719  0565 4d            	tnz	a
1720  0566 2627          	jrne	L535
1722  0568 9c            	rvf
1723  0569 96            	ldw	x,sp
1724  056a 1c0011        	addw	x,#OFST-2061
1725  056d 8d000000      	callf	d_ltor
1727  0571 96            	ldw	x,sp
1728  0572 1c0818        	addw	x,#OFST-6
1729  0575 8d000000      	callf	d_fsub
1731  0579 be02          	ldw	x,c_lreg+2
1732  057b 89            	pushw	x
1733  057c be00          	ldw	x,c_lreg
1734  057e 89            	pushw	x
1735  057f 8d000000      	callf	f_fabs
1737  0583 9c            	rvf
1738  0584 5b04          	addw	sp,#4
1739  0586 ae095e        	ldw	x,#L345
1740  0589 8d000000      	callf	d_fcmp
1742  058d 2f45          	jrslt	L725
1743  058f               L535:
1744                     ; 164 			buffer[count] = currentVoltage;
1746  058f 96            	ldw	x,sp
1747  0590 1c0018        	addw	x,#OFST-2054
1748  0593 1f0f          	ldw	(OFST-2063,sp),x
1750  0595 96            	ldw	x,sp
1751  0596 de081d        	ldw	x,(OFST-1,x)
1752  0599 58            	sllw	x
1753  059a 58            	sllw	x
1754  059b 72fb0f        	addw	x,(OFST-2063,sp)
1755  059e 7b14          	ld	a,(OFST-2058,sp)
1756  05a0 e703          	ld	(3,x),a
1757  05a2 7b13          	ld	a,(OFST-2059,sp)
1758  05a4 e702          	ld	(2,x),a
1759  05a6 7b12          	ld	a,(OFST-2060,sp)
1760  05a8 e701          	ld	(1,x),a
1761  05aa 7b11          	ld	a,(OFST-2061,sp)
1762  05ac f7            	ld	(x),a
1763                     ; 166 			lastStoredValue = currentVoltage;
1765  05ad 96            	ldw	x,sp
1766  05ae 7b14          	ld	a,(OFST-2058,sp)
1767  05b0 d7081b        	ld	(OFST-3,x),a
1768  05b3 7b13          	ld	a,(OFST-2059,sp)
1769  05b5 d7081a        	ld	(OFST-4,x),a
1770  05b8 7b12          	ld	a,(OFST-2060,sp)
1771  05ba d70819        	ld	(OFST-5,x),a
1772  05bd 7b11          	ld	a,(OFST-2061,sp)
1773  05bf d70818        	ld	(OFST-6,x),a
1774                     ; 167 			firstSample = false;  // First sample has been stored
1776  05c2 96            	ldw	x,sp
1777  05c3 724f081c      	clr	(OFST-2,x)
1778                     ; 168 			count++;
1780  05c7 96            	ldw	x,sp
1781  05c8 9093          	ldw	y,x
1782  05ca de081d        	ldw	x,(OFST-1,x)
1783  05cd 1c0001        	addw	x,#1
1784  05d0 90df081d      	ldw	(OFST-1,y),x
1785  05d4               L725:
1786                     ; 159 	while (count < NUM_SAMPLES) {  
1788  05d4 96            	ldw	x,sp
1789  05d5 9093          	ldw	y,x
1790  05d7 90de081d      	ldw	y,(OFST-1,y)
1791  05db 90a30200      	cpw	y,#512
1792  05df 2404          	jruge	L63
1793  05e1 ac4d054d      	jpf	L325
1794  05e5               L63:
1795                     ; 173 	*amplitude = calculate_amplitude(buffer, count);
1797  05e5 96            	ldw	x,sp
1798  05e6 de081d        	ldw	x,(OFST-1,x)
1799  05e9 8d000000      	callf	d_uitolx
1801  05ed be02          	ldw	x,c_lreg+2
1802  05ef 89            	pushw	x
1803  05f0 be00          	ldw	x,c_lreg
1804  05f2 89            	pushw	x
1805  05f3 96            	ldw	x,sp
1806  05f4 1c001c        	addw	x,#OFST-2050
1807  05f7 8d5f045f      	callf	f_calculate_amplitude
1809  05fb 5b04          	addw	sp,#4
1810  05fd 96            	ldw	x,sp
1811  05fe de0825        	ldw	x,(OFST+7,x)
1812  0601 8d000000      	callf	d_rtol
1814                     ; 174 	return *amplitude;
1816  0605 96            	ldw	x,sp
1817  0606 de0825        	ldw	x,(OFST+7,x)
1818  0609 8d000000      	callf	d_ltor
1822  060d 9096          	ldw	y,sp
1823  060f 72a9081f      	addw	y,#2079
1824  0613 9094          	ldw	sp,y
1825  0615 87            	retf
1857                     ; 178 float convert_adc_to_voltage(unsigned int adcValue) {
1858                     	switch	.text
1859  0616               f_convert_adc_to_voltage:
1863                     ; 179 	return adcValue * (V_REF / ADC_MAX_VALUE);
1865  0616 8d000000      	callf	d_uitof
1867  061a ae095a        	ldw	x,#L765
1868  061d 8d000000      	callf	d_fmul
1872  0621 87            	retf
1904                     ; 183 float calculate_frequency(unsigned long period) {
1905                     	switch	.text
1906  0622               f_calculate_frequency:
1908  0622 5204          	subw	sp,#4
1909       00000004      OFST:	set	4
1912                     ; 184 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
1914  0624 96            	ldw	x,sp
1915  0625 1c0008        	addw	x,#OFST+4
1916  0628 8d000000      	callf	d_ltor
1918  062c 8d000000      	callf	d_ultof
1920  0630 ae0952        	ldw	x,#L326
1921  0633 8d000000      	callf	d_fdiv
1923  0637 96            	ldw	x,sp
1924  0638 1c0001        	addw	x,#OFST-3
1925  063b 8d000000      	callf	d_rtol
1928  063f ae0956        	ldw	x,#L316
1929  0642 8d000000      	callf	d_ltor
1931  0646 96            	ldw	x,sp
1932  0647 1c0001        	addw	x,#OFST-3
1933  064a 8d000000      	callf	d_fdiv
1937  064e 5b04          	addw	sp,#4
1938  0650 87            	retf
1996                     ; 188 void output_results(float frequency, float amplitude, float FDR_Voltage) {
1997                     	switch	.text
1998  0651               f_output_results:
2000  0651 5228          	subw	sp,#40
2001       00000028      OFST:	set	40
2004                     ; 192 	sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,0\n", frequency, amplitude, amplitude/4.7, FDR_Voltage);
2006  0653 1e36          	ldw	x,(OFST+14,sp)
2007  0655 89            	pushw	x
2008  0656 1e36          	ldw	x,(OFST+14,sp)
2009  0658 89            	pushw	x
2010  0659 96            	ldw	x,sp
2011  065a 1c0034        	addw	x,#OFST+12
2012  065d 8d000000      	callf	d_ltor
2014  0661 ae0a41        	ldw	x,#L502
2015  0664 8d000000      	callf	d_fdiv
2017  0668 be02          	ldw	x,c_lreg+2
2018  066a 89            	pushw	x
2019  066b be00          	ldw	x,c_lreg
2020  066d 89            	pushw	x
2021  066e 1e3a          	ldw	x,(OFST+18,sp)
2022  0670 89            	pushw	x
2023  0671 1e3a          	ldw	x,(OFST+18,sp)
2024  0673 89            	pushw	x
2025  0674 1e3a          	ldw	x,(OFST+18,sp)
2026  0676 89            	pushw	x
2027  0677 1e3a          	ldw	x,(OFST+18,sp)
2028  0679 89            	pushw	x
2029  067a ae093b        	ldw	x,#L356
2030  067d 89            	pushw	x
2031  067e 96            	ldw	x,sp
2032  067f 1c0013        	addw	x,#OFST-21
2033  0682 8d000000      	callf	f_sprintf
2035  0686 5b12          	addw	sp,#18
2036                     ; 195 	printf("%s", buffer);
2038  0688 96            	ldw	x,sp
2039  0689 1c0001        	addw	x,#OFST-39
2040  068c 89            	pushw	x
2041  068d ae0a3e        	ldw	x,#L112
2042  0690 8d000000      	callf	f_printf
2044  0694 85            	popw	x
2045                     ; 196 	UART1_SendString(buffer);
2047  0695 96            	ldw	x,sp
2048  0696 1c0001        	addw	x,#OFST-39
2049  0699 8d000000      	callf	f_UART1_SendString
2051                     ; 198 }
2054  069d 5b28          	addw	sp,#40
2055  069f 87            	retf
2112                     ; 201 void logResults(const char *logMessage) {
2113                     	switch	.text
2114  06a0               f_logResults:
2116  06a0 89            	pushw	x
2117  06a1 5278          	subw	sp,#120
2118       00000078      OFST:	set	120
2121                     ; 206 	sprintDateTime(datetimeBuffer);
2123  06a3 96            	ldw	x,sp
2124  06a4 1c0001        	addw	x,#OFST-119
2125  06a7 8d000000      	callf	f_sprintDateTime
2127                     ; 209 	sprintf(logBuffer, "%s - %s", datetimeBuffer, logMessage);
2129  06ab 1e79          	ldw	x,(OFST+1,sp)
2130  06ad 89            	pushw	x
2131  06ae 96            	ldw	x,sp
2132  06af 1c0003        	addw	x,#OFST-117
2133  06b2 89            	pushw	x
2134  06b3 ae0933        	ldw	x,#L307
2135  06b6 89            	pushw	x
2136  06b7 96            	ldw	x,sp
2137  06b8 1c001b        	addw	x,#OFST-93
2138  06bb 8d000000      	callf	f_sprintf
2140  06bf 5b06          	addw	sp,#6
2141                     ; 210 	log_to_eeprom(logBuffer);
2143  06c1 96            	ldw	x,sp
2144  06c2 1c0015        	addw	x,#OFST-99
2145  06c5 8d000000      	callf	f_log_to_eeprom
2147                     ; 212 }
2150  06c9 5b7a          	addw	sp,#122
2151  06cb 87            	retf
2185                     ; 215 void send_square_pulse(uint16_t duration_ms) {
2186                     	switch	.text
2187  06cc               f_send_square_pulse:
2189  06cc 89            	pushw	x
2190       00000000      OFST:	set	0
2193                     ; 216 	GPIO_WriteHigh(SER_THYRISTOR); // Set square pulse pin high
2195  06cd 4b04          	push	#4
2196  06cf ae500a        	ldw	x,#20490
2197  06d2 8d000000      	callf	f_GPIO_WriteHigh
2199  06d6 84            	pop	a
2200                     ; 217 	delay_ms(duration_ms);            // Wait for the pulse duration
2202  06d7 1e01          	ldw	x,(OFST+1,sp)
2203  06d9 8d000000      	callf	f_delay_ms
2205                     ; 218 	GPIO_WriteLow(SER_THYRISTOR); // Set square pulse pin low
2207  06dd 4b04          	push	#4
2208  06df ae500a        	ldw	x,#20490
2209  06e2 8d000000      	callf	f_GPIO_WriteLow
2211  06e6 84            	pop	a
2212                     ; 219 }
2215  06e7 85            	popw	x
2216  06e8 87            	retf
2243                     ; 221 void handle_commutation_pulse(void) {
2244                     	switch	.text
2245  06e9               f_handle_commutation_pulse:
2249                     ; 222 	GPIO_WriteHigh(COM_THYRISTOR); // Set square pulse pin high
2251  06e9 4b02          	push	#2
2252  06eb ae500a        	ldw	x,#20490
2253  06ee 8d000000      	callf	f_GPIO_WriteHigh
2255  06f2 84            	pop	a
2256                     ; 223 	delay_ms(3000);            // Wait for the pulse duration
2258  06f3 ae0bb8        	ldw	x,#3000
2259  06f6 8d000000      	callf	f_delay_ms
2261                     ; 224 	GPIO_WriteLow(COM_THYRISTOR); // Set square pulse pin low
2263  06fa 4b02          	push	#2
2264  06fc ae500a        	ldw	x,#20490
2265  06ff 8d000000      	callf	f_GPIO_WriteLow
2267  0703 84            	pop	a
2268                     ; 225 	GPIO_WriteHigh(LED_ORANGE); // Turn on LED ORANGE
2270  0704 4b08          	push	#8
2271  0706 ae500f        	ldw	x,#20495
2272  0709 8d000000      	callf	f_GPIO_WriteHigh
2274  070d 84            	pop	a
2275                     ; 226 	printf("Commutation Thyristor Pulse Sent\n");
2277  070e ae0911        	ldw	x,#L137
2278  0711 8d000000      	callf	f_printf
2280                     ; 227 }
2283  0715 87            	retf
2317                     ; 229 bool check_FDR_amplitude(void) {
2318                     	switch	.text
2319  0716               f_check_FDR_amplitude:
2321  0716 5204          	subw	sp,#4
2322       00000004      OFST:	set	4
2325                     ; 230     float FDR_amplitude = 0;
2327  0718 ae0000        	ldw	x,#0
2328  071b 1f03          	ldw	(OFST-1,sp),x
2329  071d ae0000        	ldw	x,#0
2330  0720 1f01          	ldw	(OFST-3,sp),x
2332                     ; 231     FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
2334  0722 96            	ldw	x,sp
2335  0723 1c0001        	addw	x,#OFST-3
2336  0726 89            	pushw	x
2337  0727 5f            	clrw	x
2338  0728 89            	pushw	x
2339  0729 a606          	ld	a,#6
2340  072b 8dff04ff      	callf	f_process_adc_signal
2342  072f 5b04          	addw	sp,#4
2343  0731 96            	ldw	x,sp
2344  0732 1c0001        	addw	x,#OFST-3
2345  0735 8d000000      	callf	d_rtol
2348                     ; 232     return (FDR_amplitude != 0); // Returns true if FDR_amplitude is non-zero
2350  0739 9c            	rvf
2351  073a 0d01          	tnz	(OFST-3,sp)
2352  073c 2704          	jreq	L65
2353  073e a601          	ld	a,#1
2354  0740 2001          	jra	L06
2355  0742               L65:
2356  0742 4f            	clr	a
2357  0743               L06:
2360  0743 5b04          	addw	sp,#4
2361  0745 87            	retf
2394                     ; 236 bool check_signal_dc(float amplitude) {
2395                     	switch	.text
2396  0746               f_check_signal_dc:
2398       00000000      OFST:	set	0
2401                     ; 237 	if (amplitude < 0.5) {
2403  0746 9c            	rvf
2404  0747 96            	ldw	x,sp
2405  0748 1c0004        	addw	x,#OFST+4
2406  074b 8d000000      	callf	d_ltor
2408  074f ae090d        	ldw	x,#L177
2409  0752 8d000000      	callf	d_fcmp
2411  0756 2e07          	jrsge	L367
2412                     ; 238 		isThyristorON = true;
2414  0758 3501000a      	mov	_isThyristorON,#1
2415                     ; 239 		return true;
2417  075c a601          	ld	a,#1
2420  075e 87            	retf
2421  075f               L367:
2422                     ; 241 		isThyristorON = false;
2424  075f 725f000a      	clr	_isThyristorON
2425                     ; 242 		return false;
2427  0763 4f            	clr	a
2430  0764 87            	retf
2477                     ; 246 void read_set_frequency(float *set_freq) {
2478                     	switch	.text
2479  0765               f_read_set_frequency:
2481  0765 89            	pushw	x
2482  0766 521e          	subw	sp,#30
2483       0000001e      OFST:	set	30
2486                     ; 248 	internal_EEPROM_ReadStr(0x4000, setFreqString,  sizeof(setFreqString));
2488  0768 ae001e        	ldw	x,#30
2489  076b 89            	pushw	x
2490  076c 96            	ldw	x,sp
2491  076d 1c0003        	addw	x,#OFST-27
2492  0770 89            	pushw	x
2493  0771 ae4000        	ldw	x,#16384
2494  0774 89            	pushw	x
2495  0775 ae0000        	ldw	x,#0
2496  0778 89            	pushw	x
2497  0779 8d000000      	callf	f_internal_EEPROM_ReadStr
2499  077d 5b08          	addw	sp,#8
2500                     ; 249 	printf("String read from EEPROM: %s\n\r", setFreqString);
2502  077f 96            	ldw	x,sp
2503  0780 1c0001        	addw	x,#OFST-29
2504  0783 89            	pushw	x
2505  0784 ae08ef        	ldw	x,#L1201
2506  0787 8d000000      	callf	f_printf
2508  078b 85            	popw	x
2509                     ; 250 	*set_freq = ConvertStringToFloat(setFreqString);
2511  078c 96            	ldw	x,sp
2512  078d 1c0001        	addw	x,#OFST-29
2513  0790 8d000000      	callf	f_ConvertStringToFloat
2515  0794 1e1f          	ldw	x,(OFST+1,sp)
2516  0796 8d000000      	callf	d_rtol
2518                     ; 251 	printf("New set_freq: %f\n", *set_freq);
2520  079a 1e1f          	ldw	x,(OFST+1,sp)
2521  079c 9093          	ldw	y,x
2522  079e ee02          	ldw	x,(2,x)
2523  07a0 89            	pushw	x
2524  07a1 93            	ldw	x,y
2525  07a2 fe            	ldw	x,(x)
2526  07a3 89            	pushw	x
2527  07a4 ae08dd        	ldw	x,#L3201
2528  07a7 8d000000      	callf	f_printf
2530  07ab 5b04          	addw	sp,#4
2531                     ; 252 }
2534  07ad 5b20          	addw	sp,#32
2535  07af 87            	retf
2583                     ; 254 void  config_mode(void){
2584                     	switch	.text
2585  07b0               f_config_mode:
2587  07b0 522c          	subw	sp,#44
2588       0000002c      OFST:	set	44
2591                     ; 256   float value = 0;
2593  07b2               L5401:
2594                     ; 261 		if (GPIO_ReadInputPin(GPIOA, GPIO_PIN_6) == RESET) {
2596  07b2 4b40          	push	#64
2597  07b4 ae5000        	ldw	x,#20480
2598  07b7 8d000000      	callf	f_GPIO_ReadInputPin
2600  07bb 5b01          	addw	sp,#1
2601  07bd 4d            	tnz	a
2602  07be 2603          	jrne	L1501
2603                     ; 263 			return;
2606  07c0 5b2c          	addw	sp,#44
2607  07c2 87            	retf
2608  07c3               L1501:
2609                     ; 266 		printf("Entering Config Mode!\n");
2611  07c3 ae08c6        	ldw	x,#L3501
2612  07c6 8d000000      	callf	f_printf
2614                     ; 267 		printf("Enter the Command!\n");
2616  07ca ae08b2        	ldw	x,#L5501
2617  07cd 8d000000      	callf	f_printf
2619                     ; 268 		UART3_ClearBuffer();
2621  07d1 8d000000      	callf	f_UART3_ClearBuffer
2623                     ; 269 		UART3_ReceiveString(buffer, sizeof(buffer)); // Receive the first string via UART
2625  07d5 ae0028        	ldw	x,#40
2626  07d8 89            	pushw	x
2627  07d9 96            	ldw	x,sp
2628  07da 1c0007        	addw	x,#OFST-37
2629  07dd 8d000000      	callf	f_UART3_ReceiveString
2631  07e1 85            	popw	x
2632                     ; 271 		if (strcmp(buffer, "set") == 0) {
2634  07e2 ae08ae        	ldw	x,#L1601
2635  07e5 89            	pushw	x
2636  07e6 96            	ldw	x,sp
2637  07e7 1c0007        	addw	x,#OFST-37
2638  07ea 8d000000      	callf	f_strcmp
2640  07ee 5b02          	addw	sp,#2
2641  07f0 a30000        	cpw	x,#0
2642  07f3 2630          	jrne	L7501
2643                     ; 273 			printf("SET Command Received. Waiting for new parameter...\n");
2645  07f5 ae087a        	ldw	x,#L3601
2646  07f8 8d000000      	callf	f_printf
2648                     ; 274 			UART3_ReceiveString(buffer, sizeof(buffer)); // Receive the parameter string
2650  07fc ae0028        	ldw	x,#40
2651  07ff 89            	pushw	x
2652  0800 96            	ldw	x,sp
2653  0801 1c0007        	addw	x,#OFST-37
2654  0804 8d000000      	callf	f_UART3_ReceiveString
2656  0808 85            	popw	x
2657                     ; 276 			printf("123456789\n");
2659  0809 ae086f        	ldw	x,#L5601
2660  080c 8d000000      	callf	f_printf
2662                     ; 278 			internal_EEPROM_WriteStr(0x4000, buffer); // Example address for storing string
2664  0810 96            	ldw	x,sp
2665  0811 1c0005        	addw	x,#OFST-39
2666  0814 89            	pushw	x
2667  0815 ae4000        	ldw	x,#16384
2668  0818 89            	pushw	x
2669  0819 ae0000        	ldw	x,#0
2670  081c 89            	pushw	x
2671  081d 8d000000      	callf	f_internal_EEPROM_WriteStr
2673  0821 5b06          	addw	sp,#6
2675  0823 208d          	jra	L5401
2676  0825               L7501:
2677                     ; 284 		} else if (strcmp(buffer, "ready") == 0) {
2679  0825 ae0869        	ldw	x,#L3701
2680  0828 89            	pushw	x
2681  0829 96            	ldw	x,sp
2682  082a 1c0007        	addw	x,#OFST-37
2683  082d 8d000000      	callf	f_strcmp
2685  0831 5b02          	addw	sp,#2
2686  0833 a30000        	cpw	x,#0
2687  0836 2616          	jrne	L1701
2688                     ; 286 			printf("READ Command Received. Reading stored values...\n");
2690  0838 ae0838        	ldw	x,#L5701
2691  083b 8d000000      	callf	f_printf
2693                     ; 288 			process_eeprom_logs(); // Example EEPROM address
2695  083f 8d000000      	callf	f_process_eeprom_logs
2697                     ; 289 			printf("Finished Reading EEPROM!\n");
2699  0843 ae081e        	ldw	x,#L7701
2700  0846 8d000000      	callf	f_printf
2703  084a acb207b2      	jpf	L5401
2704  084e               L1701:
2705                     ; 293 			printf("Invalid Command Received: %s\n", buffer);
2707  084e 96            	ldw	x,sp
2708  084f 1c0005        	addw	x,#OFST-39
2709  0852 89            	pushw	x
2710  0853 ae0800        	ldw	x,#L3011
2711  0856 8d000000      	callf	f_printf
2713  085a 85            	popw	x
2714  085b acb207b2      	jpf	L5401
2726                     	xdef	f_main
2727                     	xdef	f_handle_commutation_pulse
2728                     	xdef	f_check_FDR_amplitude
2729                     	xdef	f_handle_signal_1_AC
2730                     	xdef	f_handle_Frequency_Below_Set_Freq
2731                     	xdef	f_process_VAR_signal
2732                     	xdef	f_process_FDR_signal
2733                     	xdef	f_logResults
2734                     	xdef	f_config_mode
2735                     	xdef	f_read_set_frequency
2736                     	xdef	f_calculate_frequency
2737                     	xdef	f_convert_adc_to_voltage
2738                     	xdef	f_process_adc_signal
2739                     	xdef	f_calculate_amplitude
2740                     	xdef	f_output_results
2741                     	xdef	f_check_signal_dc
2742                     	xdef	f_send_square_pulse
2743                     	xdef	f_initialize_system
2744                     	xdef	_buffer
2745                     	xdef	_set_freq
2746                     	xdef	_frequency
2747                     	xdef	_set_frequency
2748                     	xdef	_last_cross_time
2749                     	xdef	_end_time
2750                     	xdef	_start_time
2751                     	xdef	_pulse_ticks
2752                     	xdef	_overflow_count
2753                     	xdef	_pulseFlag
2754                     	xdef	_state
2755                     	xdef	_isThyristorON
2756                     	xdef	_count
2757                     	xdef	_sine1_amplitude
2758                     	xdef	_sine1_frequency
2759                     	xref	f_ConvertStringToFloat
2760                     	xref	f_sprintDateTime
2761                     	xref	f_printDateTime
2762                     	xref	f_internal_EEPROM_WriteStr
2763                     	xref	f_internal_EEPROM_ReadStr
2764                     	xref	f_read_ADC_Channel
2765                     	xref	f_UART1_SendString
2766                     	xref	f_UART1_setup
2767                     	xref	f_UART3_ReceiveString
2768                     	xref	f_UART3_ClearBuffer
2769                     	xref	f_INT_EEPROM_Setup
2770                     	xref	f_TIM1_setup
2771                     	xref	f_GPIO_setup
2772                     	xref	f_ADC2_setup
2773                     	xref	f_UART3_setup
2774                     	xref	f_clock_setup
2775                     	xref	f_I2CInit
2776                     	xref	f_log_to_eeprom
2777                     	xref	f_process_eeprom_logs
2778                     	xref	f_EEPROM_Config
2779                     	xref	f_sprintf
2780                     	xref	f_printf
2781                     	xref	f_fabs
2782                     	xref	f_delay_ms
2783                     	xref	f_TIM4_Config
2784                     	xref	f_strcmp
2785                     	xref	f_GPIO_ReadInputPin
2786                     	xref	f_GPIO_WriteLow
2787                     	xref	f_GPIO_WriteHigh
2788                     	switch	.const
2789  0800               L3011:
2790  0800 496e76616c69  	dc.b	"Invalid Command Re"
2791  0812 636569766564  	dc.b	"ceived: %s",10,0
2792  081e               L7701:
2793  081e 46696e697368  	dc.b	"Finished Reading E"
2794  0830 4550524f4d21  	dc.b	"EPROM!",10,0
2795  0838               L5701:
2796  0838 524541442043  	dc.b	"READ Command Recei"
2797  084a 7665642e2052  	dc.b	"ved. Reading store"
2798  085c 642076616c75  	dc.b	"d values...",10,0
2799  0869               L3701:
2800  0869 726561647900  	dc.b	"ready",0
2801  086f               L5601:
2802  086f 313233343536  	dc.b	"123456789",10,0
2803  087a               L3601:
2804  087a 53455420436f  	dc.b	"SET Command Receiv"
2805  088c 65642e205761  	dc.b	"ed. Waiting for ne"
2806  089e 772070617261  	dc.b	"w parameter...",10,0
2807  08ae               L1601:
2808  08ae 73657400      	dc.b	"set",0
2809  08b2               L5501:
2810  08b2 456e74657220  	dc.b	"Enter the Command!"
2811  08c4 0a00          	dc.b	10,0
2812  08c6               L3501:
2813  08c6 456e74657269  	dc.b	"Entering Config Mo"
2814  08d8 6465210a00    	dc.b	"de!",10,0
2815  08dd               L3201:
2816  08dd 4e6577207365  	dc.b	"New set_freq: %f",10,0
2817  08ef               L1201:
2818  08ef 537472696e67  	dc.b	"String read from E"
2819  0901 4550524f4d3a  	dc.b	"EPROM: %s",10
2820  090b 0d00          	dc.b	13,0
2821  090d               L177:
2822  090d 3f000000      	dc.w	16128,0
2823  0911               L137:
2824  0911 436f6d6d7574  	dc.b	"Commutation Thyris"
2825  0923 746f72205075  	dc.b	"tor Pulse Sent",10,0
2826  0933               L307:
2827  0933 2573202d2025  	dc.b	"%s - %s",0
2828  093b               L356:
2829  093b 252e33662c25  	dc.b	"%.3f,%.3f,%.3f,%.3"
2830  094d 662c300a00    	dc.b	"f,0",10,0
2831  0952               L326:
2832  0952 49742400      	dc.w	18804,9216
2833  0956               L316:
2834  0956 3f800000      	dc.w	16256,0
2835  095a               L765:
2836  095a 3b933333      	dc.w	15251,13107
2837  095e               L345:
2838  095e 3dcccccc      	dc.w	15820,-13108
2839  0962               L514:
2840  0962 c0933333      	dc.w	-16237,13107
2841  0966               L524:
2842  0966 40933333      	dc.w	16531,13107
2843  096a               L753:
2844  096a 566172416d70  	dc.b	"VarAmplitude Not b"
2845  097c 656c6f772031  	dc.b	"elow 10 mv.",10,0
2846  0989               L743:
2847  0989 566172416d70  	dc.b	"VarAmplitude below"
2848  099b 203130206d76  	dc.b	" 10 mv.",10,0
2849  09a4               L343:
2850  09a4 3d4ccccc      	dc.w	15692,-13108
2851  09a8               L313:
2852  09a8 5369676e616c  	dc.b	"Signal 1 AC and Va"
2853  09ba 72416d706c69  	dc.b	"rAmplitude: %f.",10,0
2854  09cb               L703:
2855  09cb 5369676e616c  	dc.b	"Signal 1 DC.",10,0
2856  09d9               L362:
2857  09d9 467265717565  	dc.b	"Frequency Below Se"
2858  09eb 742046726571  	dc.b	"t Frequency.",10,0
2859  09f9               L752:
2860  09f9 204672657175  	dc.b	" Frequency: %.3f, "
2861  0a0b 416d706c6974  	dc.b	"Amplitude: %.3f, C"
2862  0a1d 757272656e74  	dc.b	"urrent: %.3f, FDR_"
2863  0a2f 566f6c746167  	dc.b	"Voltage: %.3f",10,0
2864  0a3e               L112:
2865  0a3e 257300        	dc.b	"%s",0
2866  0a41               L502:
2867  0a41 40966666      	dc.w	16534,26214
2868  0a45               L771:
2869  0a45 252e33662c25  	dc.b	"%.3f,%.3f,%.3f,%.3"
2870  0a57 662c310a00    	dc.b	"f,1",10,0
2871  0a5c               L741:
2872  0a5c 53797374656d  	dc.b	"System Initializat"
2873  0a6e 696f6e20436f  	dc.b	"ion Completed",10
2874  0a7c 0d00          	dc.b	13,0
2875  0a7e               L531:
2876  0a7e 46445220566f  	dc.b	"FDR Voltage Exists",0
2877  0a91               L721:
2878  0a91 00000000      	dc.w	0,0
2879                     	xref.b	c_lreg
2880                     	xref.b	c_x
2881                     	xref.b	c_y
2901                     	xref	d_ultof
2902                     	xref	d_fmul
2903                     	xref	d_uitof
2904                     	xref	d_uitolx
2905                     	xref	d_xymovl
2906                     	xref	d_fsub
2907                     	xref	d_lcmp
2908                     	xref	d_lgadc
2909                     	xref	d_fcmp
2910                     	xref	d_ctof
2911                     	xref	d_fdiv
2912                     	xref	d_ltor
2913                     	xref	d_rtol
2914                     	end
