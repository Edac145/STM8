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
 175                     ; 12 void main() {
 176                     	switch	.text
 177  0000               f_main:
 179  0000 5204          	subw	sp,#4
 180       00000004      OFST:	set	4
 183                     ; 13 float FDR_amplitude = 0.0;
 185  0002 ce1138        	ldw	x,L701+2
 186  0005 1f03          	ldw	(OFST-1,sp),x
 187  0007 ce1136        	ldw	x,L701
 188  000a 1f01          	ldw	(OFST-3,sp),x
 190                     ; 16 	initialize_system();
 192  000c 8d450045      	callf	f_initialize_system
 194  0010               L311:
 195                     ; 20 			FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
 197  0010 96            	ldw	x,sp
 198  0011 1c0001        	addw	x,#OFST-3
 199  0014 89            	pushw	x
 200  0015 5f            	clrw	x
 201  0016 89            	pushw	x
 202  0017 a606          	ld	a,#6
 203  0019 8d550455      	callf	f_process_adc_signal
 205  001d 5b04          	addw	sp,#4
 206  001f 96            	ldw	x,sp
 207  0020 1c0001        	addw	x,#OFST-3
 208  0023 8d000000      	callf	d_rtol
 211                     ; 22 			if (FDR_amplitude > 0) { // Voltage detected on Signal 2
 213  0027 9c            	rvf
 214  0028 9c            	rvf
 215  0029 0d01          	tnz	(OFST-3,sp)
 216  002b 2de3          	jrsle	L311
 217                     ; 23 					GPIO_WriteHigh(GPIOC, GPIO_PIN_3); // Turn on LED
 219  002d 4b08          	push	#8
 220  002f ae500a        	ldw	x,#20490
 221  0032 8d000000      	callf	f_GPIO_WriteHigh
 223  0036 84            	pop	a
 224                     ; 24 					process_VAR_signal(FDR_amplitude); // Handle Signal 1
 226  0037 1e03          	ldw	x,(OFST-1,sp)
 227  0039 89            	pushw	x
 228  003a 1e03          	ldw	x,(OFST-1,sp)
 229  003c 89            	pushw	x
 230  003d 8da800a8      	callf	f_process_VAR_signal
 232  0041 5b04          	addw	sp,#4
 233  0043 20cb          	jra	L311
 262                     ; 30 void initialize_system(void) {
 263                     	switch	.text
 264  0045               f_initialize_system:
 268                     ; 31 	clock_setup();          // Configure system clock
 270  0045 8d000000      	callf	f_clock_setup
 272                     ; 32 	TIM4_Config();          // Timer 4 config for delay
 274  0049 8d000000      	callf	f_TIM4_Config
 276                     ; 33 	GPIO_setup();
 278  004d 8d000000      	callf	f_GPIO_setup
 280                     ; 34 	UART3_setup();          // Setup UART communication
 282  0051 8d000000      	callf	f_UART3_setup
 284                     ; 35 	ADC2_setup();						// Setup ADC
 286  0055 8d000000      	callf	f_ADC2_setup
 288                     ; 36 	EEPROM_Config();        // Configuring EEPROM
 290  0059 8d000000      	callf	f_EEPROM_Config
 292                     ; 37 	I2CInit();              // for Configuring RTC
 294  005d 8d000000      	callf	f_I2CInit
 296                     ; 39 }
 299  0061 87            	retf
 337                     ; 42 float process_FDR_signal(void) {
 338                     	switch	.text
 339  0062               f_process_FDR_signal:
 341  0062 5204          	subw	sp,#4
 342       00000004      OFST:	set	4
 345                     ; 43 	  float current_amplitude = 0;
 347  0064 ae0000        	ldw	x,#0
 348  0067 1f03          	ldw	(OFST-1,sp),x
 349  0069 ae0000        	ldw	x,#0
 350  006c 1f01          	ldw	(OFST-3,sp),x
 352  006e               L741:
 353                     ; 45         current_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &current_amplitude);
 355  006e 96            	ldw	x,sp
 356  006f 1c0001        	addw	x,#OFST-3
 357  0072 89            	pushw	x
 358  0073 5f            	clrw	x
 359  0074 89            	pushw	x
 360  0075 a606          	ld	a,#6
 361  0077 8d550455      	callf	f_process_adc_signal
 363  007b 5b04          	addw	sp,#4
 364  007d 96            	ldw	x,sp
 365  007e 1c0001        	addw	x,#OFST-3
 366  0081 8d000000      	callf	d_rtol
 369                     ; 47         if (isThyristorON) {
 371  0085 3d14          	tnz	_isThyristorON
 372  0087 2713          	jreq	L351
 373                     ; 48             send_square_pulse(3000);
 375  0089 ae0bb8        	ldw	x,#3000
 376  008c 8d580758      	callf	f_send_square_pulse
 378                     ; 49             GPIO_WriteHigh(GPIOD, GPIO_PIN_0); // Turn on LED ORANGE
 380  0090 4b01          	push	#1
 381  0092 ae500f        	ldw	x,#20495
 382  0095 8d000000      	callf	f_GPIO_WriteHigh
 384  0099 84            	pop	a
 386  009a 20d2          	jra	L741
 387  009c               L351:
 388                     ; 52             GPIO_WriteLow(GPIOD, GPIO_PIN_0);
 390  009c 4b01          	push	#1
 391  009e ae500f        	ldw	x,#20495
 392  00a1 8d000000      	callf	f_GPIO_WriteLow
 394  00a5 84            	pop	a
 395  00a6 20c6          	jra	L741
 461                     ; 58 void process_VAR_signal(float FDR_amplitude) {
 462                     	switch	.text
 463  00a8               f_process_VAR_signal:
 465  00a8 5230          	subw	sp,#48
 466       00000030      OFST:	set	48
 469                     ; 59     float VAR_frequency = 0.0, VAR_amplitude = 0.0;
 471  00aa ce1138        	ldw	x,L701+2
 472  00ad 1f2b          	ldw	(OFST-5,sp),x
 473  00af ce1136        	ldw	x,L701
 474  00b2 1f29          	ldw	(OFST-7,sp),x
 478  00b4 ce1138        	ldw	x,L701+2
 479  00b7 1f2f          	ldw	(OFST-1,sp),x
 480  00b9 ce1136        	ldw	x,L701
 481  00bc 1f2d          	ldw	(OFST-3,sp),x
 483  00be               L112:
 484                     ; 62         VAR_amplitude = process_adc_signal(VAR_SIGNAL, &VAR_frequency, &VAR_amplitude);
 486  00be 96            	ldw	x,sp
 487  00bf 1c002d        	addw	x,#OFST-3
 488  00c2 89            	pushw	x
 489  00c3 96            	ldw	x,sp
 490  00c4 1c002b        	addw	x,#OFST-5
 491  00c7 89            	pushw	x
 492  00c8 a605          	ld	a,#5
 493  00ca 8d550455      	callf	f_process_adc_signal
 495  00ce 5b04          	addw	sp,#4
 496  00d0 96            	ldw	x,sp
 497  00d1 1c002d        	addw	x,#OFST-3
 498  00d4 8d000000      	callf	d_rtol
 501                     ; 67         output_results(VAR_frequency, VAR_amplitude, FDR_amplitude);
 503  00d8 1e36          	ldw	x,(OFST+6,sp)
 504  00da 89            	pushw	x
 505  00db 1e36          	ldw	x,(OFST+6,sp)
 506  00dd 89            	pushw	x
 507  00de 1e33          	ldw	x,(OFST+3,sp)
 508  00e0 89            	pushw	x
 509  00e1 1e33          	ldw	x,(OFST+3,sp)
 510  00e3 89            	pushw	x
 511  00e4 1e33          	ldw	x,(OFST+3,sp)
 512  00e6 89            	pushw	x
 513  00e7 1e33          	ldw	x,(OFST+3,sp)
 514  00e9 89            	pushw	x
 515  00ea 8d110711      	callf	f_output_results
 517  00ee 5b0c          	addw	sp,#12
 518                     ; 69         if (VAR_frequency <= SET_FREQ) {
 520  00f0 9c            	rvf
 521  00f1 96            	ldw	x,sp
 522  00f2 1c0029        	addw	x,#OFST-7
 523  00f5 8d000000      	callf	d_ltor
 525  00f9 ae1132        	ldw	x,#L322
 526  00fc 8d000000      	callf	d_fcmp
 528  0100 2cbc          	jrsgt	L112
 529                     ; 73 						sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", VAR_frequency, VAR_amplitude, VAR_amplitude/4.7, FDR_amplitude);
 531  0102 1e36          	ldw	x,(OFST+6,sp)
 532  0104 89            	pushw	x
 533  0105 1e36          	ldw	x,(OFST+6,sp)
 534  0107 89            	pushw	x
 535  0108 96            	ldw	x,sp
 536  0109 1c0031        	addw	x,#OFST+1
 537  010c 8d000000      	callf	d_ltor
 539  0110 ae1117        	ldw	x,#L532
 540  0113 8d000000      	callf	d_fdiv
 542  0117 be02          	ldw	x,c_lreg+2
 543  0119 89            	pushw	x
 544  011a be00          	ldw	x,c_lreg
 545  011c 89            	pushw	x
 546  011d 1e37          	ldw	x,(OFST+7,sp)
 547  011f 89            	pushw	x
 548  0120 1e37          	ldw	x,(OFST+7,sp)
 549  0122 89            	pushw	x
 550  0123 1e37          	ldw	x,(OFST+7,sp)
 551  0125 89            	pushw	x
 552  0126 1e37          	ldw	x,(OFST+7,sp)
 553  0128 89            	pushw	x
 554  0129 ae111b        	ldw	x,#L722
 555  012c 89            	pushw	x
 556  012d 96            	ldw	x,sp
 557  012e 1c0013        	addw	x,#OFST-29
 558  0131 8d000000      	callf	f_sprintf
 560  0135 5b12          	addw	sp,#18
 561                     ; 74 						printf("%s", buffer);
 563  0137 96            	ldw	x,sp
 564  0138 1c0001        	addw	x,#OFST-47
 565  013b 89            	pushw	x
 566  013c ae1114        	ldw	x,#L142
 567  013f 8d000000      	callf	f_printf
 569  0143 85            	popw	x
 570                     ; 75             handle_Frequency_Below_Set_Freq(VAR_amplitude);
 572  0144 1e2f          	ldw	x,(OFST-1,sp)
 573  0146 89            	pushw	x
 574  0147 1e2f          	ldw	x,(OFST-1,sp)
 575  0149 89            	pushw	x
 576  014a 8d5c015c      	callf	f_handle_Frequency_Below_Set_Freq
 578  014e 5b04          	addw	sp,#4
 579  0150 acbe00be      	jpf	L112
 603                     ; 80 void wait_for_negative_zero_crossing(void) {
 604                     	switch	.text
 605  0154               f_wait_for_negative_zero_crossing:
 609  0154               L552:
 610                     ; 81     while (!check_negative_zero_crossing()) {
 612  0154 8d400340      	callf	f_check_negative_zero_crossing
 614  0158 4d            	tnz	a
 615  0159 27f9          	jreq	L552
 616                     ; 85 }
 619  015b 87            	retf
 662                     ; 87 void handle_Frequency_Below_Set_Freq(float VAR_amplitude) {
 663                     	switch	.text
 664  015c               f_handle_Frequency_Below_Set_Freq:
 666       00000000      OFST:	set	0
 669                     ; 88     wait_for_negative_zero_crossing();
 671  015c 8d540154      	callf	f_wait_for_negative_zero_crossing
 673                     ; 90     send_square_pulse(5);
 675  0160 ae0005        	ldw	x,#5
 676  0163 8d580758      	callf	f_send_square_pulse
 678                     ; 91     GPIO_WriteHigh(GPIOA, GPIO_PIN_3); // Turn on LED if Signal is DC
 680  0167 4b08          	push	#8
 681  0169 ae5000        	ldw	x,#20480
 682  016c 8d000000      	callf	f_GPIO_WriteHigh
 684  0170 84            	pop	a
 685                     ; 92     VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
 687  0171 96            	ldw	x,sp
 688  0172 1c0004        	addw	x,#OFST+4
 689  0175 89            	pushw	x
 690  0176 5f            	clrw	x
 691  0177 89            	pushw	x
 692  0178 a605          	ld	a,#5
 693  017a 8d550455      	callf	f_process_adc_signal
 695  017e 5b04          	addw	sp,#4
 696  0180 96            	ldw	x,sp
 697  0181 1c0004        	addw	x,#OFST+4
 698  0184 8d000000      	callf	d_rtol
 700                     ; 94     if (check_signal_dc(VAR_amplitude)) {
 702  0188 1e06          	ldw	x,(OFST+6,sp)
 703  018a 89            	pushw	x
 704  018b 1e06          	ldw	x,(OFST+6,sp)
 705  018d 89            	pushw	x
 706  018e 8d920792      	callf	f_check_signal_dc
 708  0192 5b04          	addw	sp,#4
 709  0194 4d            	tnz	a
 710  0195 271b          	jreq	L772
 711                     ; 95 				printDateTime();
 713  0197 8d000000      	callf	f_printDateTime
 715                     ; 96         printf("Signal 1 DC.\n");
 717  019b ae1106        	ldw	x,#L103
 718  019e 8d000000      	callf	f_printf
 720                     ; 97         GPIO_WriteHigh(GPIOD, GPIO_PIN_3); // Turn on LED if Signal is DC
 722  01a2 4b08          	push	#8
 723  01a4 ae500f        	ldw	x,#20495
 724  01a7 8d000000      	callf	f_GPIO_WriteHigh
 726  01ab 84            	pop	a
 727                     ; 98         process_FDR_signal();
 729  01ac 8d620062      	callf	f_process_FDR_signal
 732  01b0 201f          	jra	L303
 733  01b2               L772:
 734                     ; 100 				printDateTime();
 736  01b2 8d000000      	callf	f_printDateTime
 738                     ; 101         printf("Signal 1 AC and VarAmplitude: %f.\n", VAR_amplitude);
 740  01b6 1e06          	ldw	x,(OFST+6,sp)
 741  01b8 89            	pushw	x
 742  01b9 1e06          	ldw	x,(OFST+6,sp)
 743  01bb 89            	pushw	x
 744  01bc ae10e3        	ldw	x,#L503
 745  01bf 8d000000      	callf	f_printf
 747  01c3 5b04          	addw	sp,#4
 748                     ; 102         handle_signal_1_AC(VAR_amplitude);
 750  01c5 1e06          	ldw	x,(OFST+6,sp)
 751  01c7 89            	pushw	x
 752  01c8 1e06          	ldw	x,(OFST+6,sp)
 753  01ca 89            	pushw	x
 754  01cb 8dd201d2      	callf	f_handle_signal_1_AC
 756  01cf 5b04          	addw	sp,#4
 757  01d1               L303:
 758                     ; 104 }
 761  01d1 87            	retf
 801                     ; 107 void handle_signal_1_AC(float VAR_amplitude) {
 802                     	switch	.text
 803  01d2               f_handle_signal_1_AC:
 805       00000000      OFST:	set	0
 808                     ; 108     if (VAR_amplitude < AC_AMPLITUDE_THRESHOLD) {
 810  01d2 9c            	rvf
 811  01d3 96            	ldw	x,sp
 812  01d4 1c0004        	addw	x,#OFST+4
 813  01d7 8d000000      	callf	d_ltor
 815  01db ae10df        	ldw	x,#L333
 816  01de 8d000000      	callf	d_fcmp
 818  01e2 2e1e          	jrsge	L523
 819                     ; 109 				printDateTime();
 821  01e4 8d000000      	callf	f_printDateTime
 823                     ; 111         GPIO_WriteLow(GPIOE, GPIO_PIN_3); // Turn on LED if Signal is AC < 20 mV
 825  01e8 4b08          	push	#8
 826  01ea ae5014        	ldw	x,#20500
 827  01ed 8d000000      	callf	f_GPIO_WriteLow
 829  01f1 84            	pop	a
 830                     ; 112         delay_ms(3000);
 832  01f2 ae0bb8        	ldw	x,#3000
 833  01f5 8d000000      	callf	f_delay_ms
 835                     ; 113         send_square_pulse(5);
 837  01f9 ae0005        	ldw	x,#5
 838  01fc 8d580758      	callf	f_send_square_pulse
 841  0200 2021          	jra	L733
 842  0202               L523:
 843                     ; 115 				printDateTime();
 845  0202 8d000000      	callf	f_printDateTime
 847                     ; 116 				printf("VarAmplitude Not below 10 mv.\n");
 849  0206 ae10c0        	ldw	x,#L143
 850  0209 8d000000      	callf	f_printf
 852                     ; 117 			  handle_Frequency_Below_Set_Freq(VAR_amplitude);
 854  020d 1e06          	ldw	x,(OFST+6,sp)
 855  020f 89            	pushw	x
 856  0210 1e06          	ldw	x,(OFST+6,sp)
 857  0212 89            	pushw	x
 858  0213 8d5c015c      	callf	f_handle_Frequency_Below_Set_Freq
 860  0217 5b04          	addw	sp,#4
 861                     ; 118 				GPIO_WriteHigh(GPIOE, GPIO_PIN_3); // Turn on LED if Signal is AC < 20 ms
 863  0219 4b08          	push	#8
 864  021b ae5014        	ldw	x,#20500
 865  021e 8d000000      	callf	f_GPIO_WriteHigh
 867  0222 84            	pop	a
 868  0223               L733:
 869                     ; 120 }
 872  0223 87            	retf
 945                     ; 123 bool detectZeroCross(float previousSample, float currentSample, float threshold) {
 946                     	switch	.text
 947  0224               f_detectZeroCross:
 949       00000000      OFST:	set	0
 952                     ; 124 	if (crossingType == -1) {  // If no crossing type detected, check for both positive and negative
 954  0224 be10          	ldw	x,_crossingType
 955  0226 a3ffff        	cpw	x,#65535
 956  0229 265a          	jrne	L104
 957                     ; 125 		if (previousSample <= threshold && currentSample > threshold) {
 959  022b 9c            	rvf
 960  022c 96            	ldw	x,sp
 961  022d 1c0004        	addw	x,#OFST+4
 962  0230 8d000000      	callf	d_ltor
 964  0234 96            	ldw	x,sp
 965  0235 1c000c        	addw	x,#OFST+12
 966  0238 8d000000      	callf	d_fcmp
 968  023c 2c19          	jrsgt	L304
 970  023e 9c            	rvf
 971  023f 96            	ldw	x,sp
 972  0240 1c0008        	addw	x,#OFST+8
 973  0243 8d000000      	callf	d_ltor
 975  0247 96            	ldw	x,sp
 976  0248 1c000c        	addw	x,#OFST+12
 977  024b 8d000000      	callf	d_fcmp
 979  024f 2d06          	jrsle	L304
 980                     ; 126 			crossingType = 0;  // Positive zero crossing
 982  0251 5f            	clrw	x
 983  0252 bf10          	ldw	_crossingType,x
 984                     ; 127 			return true;
 986  0254 a601          	ld	a,#1
 989  0256 87            	retf
 990  0257               L304:
 991                     ; 128 		} else if (previousSample >= threshold && currentSample < threshold) {
 993  0257 9c            	rvf
 994  0258 96            	ldw	x,sp
 995  0259 1c0004        	addw	x,#OFST+4
 996  025c 8d000000      	callf	d_ltor
 998  0260 96            	ldw	x,sp
 999  0261 1c000c        	addw	x,#OFST+12
1000  0264 8d000000      	callf	d_fcmp
1002  0268 2f78          	jrslt	L114
1004  026a 9c            	rvf
1005  026b 96            	ldw	x,sp
1006  026c 1c0008        	addw	x,#OFST+8
1007  026f 8d000000      	callf	d_ltor
1009  0273 96            	ldw	x,sp
1010  0274 1c000c        	addw	x,#OFST+12
1011  0277 8d000000      	callf	d_fcmp
1013  027b 2e65          	jrsge	L114
1014                     ; 129 			crossingType = 1;  // Negative zero crossing
1016  027d ae0001        	ldw	x,#1
1017  0280 bf10          	ldw	_crossingType,x
1018                     ; 130 			return true;
1020  0282 a601          	ld	a,#1
1023  0284 87            	retf
1024  0285               L104:
1025                     ; 132 	} else if (crossingType == 0 && previousSample <= threshold && currentSample > threshold) {
1027  0285 be10          	ldw	x,_crossingType
1028  0287 2629          	jrne	L314
1030  0289 9c            	rvf
1031  028a 96            	ldw	x,sp
1032  028b 1c0004        	addw	x,#OFST+4
1033  028e 8d000000      	callf	d_ltor
1035  0292 96            	ldw	x,sp
1036  0293 1c000c        	addw	x,#OFST+12
1037  0296 8d000000      	callf	d_fcmp
1039  029a 2c16          	jrsgt	L314
1041  029c 9c            	rvf
1042  029d 96            	ldw	x,sp
1043  029e 1c0008        	addw	x,#OFST+8
1044  02a1 8d000000      	callf	d_ltor
1046  02a5 96            	ldw	x,sp
1047  02a6 1c000c        	addw	x,#OFST+12
1048  02a9 8d000000      	callf	d_fcmp
1050  02ad 2d03          	jrsle	L314
1051                     ; 133 			return true;  // Positive zero crossing
1053  02af a601          	ld	a,#1
1056  02b1 87            	retf
1057  02b2               L314:
1058                     ; 134 	} else if (crossingType == 1 && previousSample >= threshold && currentSample < threshold) {
1060  02b2 be10          	ldw	x,_crossingType
1061  02b4 a30001        	cpw	x,#1
1062  02b7 2629          	jrne	L114
1064  02b9 9c            	rvf
1065  02ba 96            	ldw	x,sp
1066  02bb 1c0004        	addw	x,#OFST+4
1067  02be 8d000000      	callf	d_ltor
1069  02c2 96            	ldw	x,sp
1070  02c3 1c000c        	addw	x,#OFST+12
1071  02c6 8d000000      	callf	d_fcmp
1073  02ca 2f16          	jrslt	L114
1075  02cc 9c            	rvf
1076  02cd 96            	ldw	x,sp
1077  02ce 1c0008        	addw	x,#OFST+8
1078  02d1 8d000000      	callf	d_ltor
1080  02d5 96            	ldw	x,sp
1081  02d6 1c000c        	addw	x,#OFST+12
1082  02d9 8d000000      	callf	d_fcmp
1084  02dd 2e03          	jrsge	L114
1085                     ; 135 			return true;  // Negative zero crossing
1087  02df a601          	ld	a,#1
1090  02e1 87            	retf
1091  02e2               L114:
1092                     ; 138 	return false;  // No zero crossing detected
1094  02e2 4f            	clr	a
1097  02e3 87            	retf
1149                     ; 142 bool detectPosZeroCross(float previousSample, float currentSample, float threshold) {
1150                     	switch	.text
1151  02e4               f_detectPosZeroCross:
1153       00000000      OFST:	set	0
1156                     ; 143 	return (previousSample <= threshold && currentSample > threshold);
1158  02e4 9c            	rvf
1159  02e5 96            	ldw	x,sp
1160  02e6 1c0004        	addw	x,#OFST+4
1161  02e9 8d000000      	callf	d_ltor
1163  02ed 96            	ldw	x,sp
1164  02ee 1c000c        	addw	x,#OFST+12
1165  02f1 8d000000      	callf	d_fcmp
1167  02f5 2c17          	jrsgt	L62
1168  02f7 9c            	rvf
1169  02f8 96            	ldw	x,sp
1170  02f9 1c0008        	addw	x,#OFST+8
1171  02fc 8d000000      	callf	d_ltor
1173  0300 96            	ldw	x,sp
1174  0301 1c000c        	addw	x,#OFST+12
1175  0304 8d000000      	callf	d_fcmp
1177  0308 2d04          	jrsle	L62
1178  030a a601          	ld	a,#1
1179  030c 2001          	jra	L03
1180  030e               L62:
1181  030e 4f            	clr	a
1182  030f               L03:
1185  030f 87            	retf
1247                     ; 147 bool detect_negative_zero_cross(float previous_sample, float current_sample, float threshold) {
1248                     	switch	.text
1249  0310               f_detect_negative_zero_cross:
1251  0310 5204          	subw	sp,#4
1252       00000004      OFST:	set	4
1255                     ; 148 	  float hyst = 0.5;
1257                     ; 149     return (previous_sample > threshold && current_sample <= threshold);
1259  0312 9c            	rvf
1260  0313 96            	ldw	x,sp
1261  0314 1c0008        	addw	x,#OFST+4
1262  0317 8d000000      	callf	d_ltor
1264  031b 96            	ldw	x,sp
1265  031c 1c0010        	addw	x,#OFST+12
1266  031f 8d000000      	callf	d_fcmp
1268  0323 2d17          	jrsle	L43
1269  0325 9c            	rvf
1270  0326 96            	ldw	x,sp
1271  0327 1c000c        	addw	x,#OFST+8
1272  032a 8d000000      	callf	d_ltor
1274  032e 96            	ldw	x,sp
1275  032f 1c0010        	addw	x,#OFST+12
1276  0332 8d000000      	callf	d_fcmp
1278  0336 2c04          	jrsgt	L43
1279  0338 a601          	ld	a,#1
1280  033a 2001          	jra	L63
1281  033c               L43:
1282  033c 4f            	clr	a
1283  033d               L63:
1286  033d 5b04          	addw	sp,#4
1287  033f 87            	retf
1334                     ; 152 bool check_negative_zero_crossing(void) {
1335                     	switch	.text
1336  0340               f_check_negative_zero_crossing:
1338  0340 5208          	subw	sp,#8
1339       00000008      OFST:	set	8
1342                     ; 153 	float prev_adc_value = 0;  // Store previous ADC sample value
1344  0342 ae0000        	ldw	x,#0
1345  0345 1f03          	ldw	(OFST-5,sp),x
1346  0347 ae0000        	ldw	x,#0
1347  034a 1f01          	ldw	(OFST-7,sp),x
1349                     ; 154 	float current_adc_value = 0;  // Store current ADC sample value
1351  034c               L335:
1352                     ; 158 		current_adc_value = convert_adc_to_voltage(read_ADC_Channel(VAR_SIGNAL));
1354  034c a605          	ld	a,#5
1355  034e 8d000000      	callf	f_read_ADC_Channel
1357  0352 8dd606d6      	callf	f_convert_adc_to_voltage
1359  0356 96            	ldw	x,sp
1360  0357 1c0005        	addw	x,#OFST-3
1361  035a 8d000000      	callf	d_rtol
1364                     ; 160 		if (detect_negative_zero_cross(prev_adc_value, current_adc_value, ZEROCROSS_THRESHOLD)) {
1366  035e ce10ba        	ldw	x,L545+2
1367  0361 89            	pushw	x
1368  0362 ce10b8        	ldw	x,L545
1369  0365 89            	pushw	x
1370  0366 1e0b          	ldw	x,(OFST+3,sp)
1371  0368 89            	pushw	x
1372  0369 1e0b          	ldw	x,(OFST+3,sp)
1373  036b 89            	pushw	x
1374  036c 1e0b          	ldw	x,(OFST+3,sp)
1375  036e 89            	pushw	x
1376  036f 1e0b          	ldw	x,(OFST+3,sp)
1377  0371 89            	pushw	x
1378  0372 8d100310      	callf	f_detect_negative_zero_cross
1380  0376 5b0c          	addw	sp,#12
1381  0378 4d            	tnz	a
1382  0379 2705          	jreq	L735
1383                     ; 163 			return true;
1385  037b a601          	ld	a,#1
1388  037d 5b08          	addw	sp,#8
1389  037f 87            	retf
1390  0380               L735:
1391                     ; 166 		prev_adc_value = current_adc_value;
1393  0380 1e07          	ldw	x,(OFST-1,sp)
1394  0382 1f03          	ldw	(OFST-5,sp),x
1395  0384 1e05          	ldw	x,(OFST-3,sp)
1396  0386 1f01          	ldw	(OFST-7,sp),x
1399  0388 20c2          	jra	L335
1470                     ; 172 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
1471                     	switch	.text
1472  038a               f_calculate_amplitude:
1474  038a 89            	pushw	x
1475  038b 520c          	subw	sp,#12
1476       0000000c      OFST:	set	12
1479                     ; 173 	uint32_t i = 0;
1481                     ; 174 	float max_val = -V_REF, min_val = V_REF;
1483  038d ce10b2        	ldw	x,L316+2
1484  0390 1f03          	ldw	(OFST-9,sp),x
1485  0392 ce10b0        	ldw	x,L316
1486  0395 1f01          	ldw	(OFST-11,sp),x
1490  0397 ce10b6        	ldw	x,L326+2
1491  039a 1f07          	ldw	(OFST-5,sp),x
1492  039c ce10b4        	ldw	x,L326
1493  039f 1f05          	ldw	(OFST-7,sp),x
1495                     ; 176 	for (i = 0; i < sample_size; i++) {
1497  03a1 ae0000        	ldw	x,#0
1498  03a4 1f0b          	ldw	(OFST-1,sp),x
1499  03a6 ae0000        	ldw	x,#0
1500  03a9 1f09          	ldw	(OFST-3,sp),x
1503  03ab 2058          	jra	L336
1504  03ad               L726:
1505                     ; 177 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1507  03ad 9c            	rvf
1508  03ae 1e0b          	ldw	x,(OFST-1,sp)
1509  03b0 58            	sllw	x
1510  03b1 58            	sllw	x
1511  03b2 72fb0d        	addw	x,(OFST+1,sp)
1512  03b5 8d000000      	callf	d_ltor
1514  03b9 96            	ldw	x,sp
1515  03ba 1c0001        	addw	x,#OFST-11
1516  03bd 8d000000      	callf	d_fcmp
1518  03c1 2d11          	jrsle	L736
1521  03c3 1e0b          	ldw	x,(OFST-1,sp)
1522  03c5 58            	sllw	x
1523  03c6 58            	sllw	x
1524  03c7 72fb0d        	addw	x,(OFST+1,sp)
1525  03ca 9093          	ldw	y,x
1526  03cc ee02          	ldw	x,(2,x)
1527  03ce 1f03          	ldw	(OFST-9,sp),x
1528  03d0 93            	ldw	x,y
1529  03d1 fe            	ldw	x,(x)
1530  03d2 1f01          	ldw	(OFST-11,sp),x
1532  03d4               L736:
1533                     ; 178 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1535  03d4 9c            	rvf
1536  03d5 1e0b          	ldw	x,(OFST-1,sp)
1537  03d7 58            	sllw	x
1538  03d8 58            	sllw	x
1539  03d9 72fb0d        	addw	x,(OFST+1,sp)
1540  03dc 8d000000      	callf	d_ltor
1542  03e0 96            	ldw	x,sp
1543  03e1 1c0005        	addw	x,#OFST-7
1544  03e4 8d000000      	callf	d_fcmp
1546  03e8 2e11          	jrsge	L146
1549  03ea 1e0b          	ldw	x,(OFST-1,sp)
1550  03ec 58            	sllw	x
1551  03ed 58            	sllw	x
1552  03ee 72fb0d        	addw	x,(OFST+1,sp)
1553  03f1 9093          	ldw	y,x
1554  03f3 ee02          	ldw	x,(2,x)
1555  03f5 1f07          	ldw	(OFST-5,sp),x
1556  03f7 93            	ldw	x,y
1557  03f8 fe            	ldw	x,(x)
1558  03f9 1f05          	ldw	(OFST-7,sp),x
1560  03fb               L146:
1561                     ; 176 	for (i = 0; i < sample_size; i++) {
1563  03fb 96            	ldw	x,sp
1564  03fc 1c0009        	addw	x,#OFST-3
1565  03ff a601          	ld	a,#1
1566  0401 8d000000      	callf	d_lgadc
1569  0405               L336:
1572  0405 96            	ldw	x,sp
1573  0406 1c0009        	addw	x,#OFST-3
1574  0409 8d000000      	callf	d_ltor
1576  040d 96            	ldw	x,sp
1577  040e 1c0012        	addw	x,#OFST+6
1578  0411 8d000000      	callf	d_lcmp
1580  0415 2596          	jrult	L726
1581                     ; 181 	return (max_val - min_val);
1583  0417 96            	ldw	x,sp
1584  0418 1c0001        	addw	x,#OFST-11
1585  041b 8d000000      	callf	d_ltor
1587  041f 96            	ldw	x,sp
1588  0420 1c0005        	addw	x,#OFST-7
1589  0423 8d000000      	callf	d_fsub
1593  0427 5b0e          	addw	sp,#14
1594  0429 87            	retf
1638                     ; 185 void initialize_adc_buffer(float buffer[]) {
1639                     	switch	.text
1640  042a               f_initialize_adc_buffer:
1642  042a 89            	pushw	x
1643  042b 89            	pushw	x
1644       00000002      OFST:	set	2
1647                     ; 186 	uint16_t i = 0;
1649                     ; 187 	for (i = 0; i < NUM_SAMPLES; i++) {
1651  042c 5f            	clrw	x
1652  042d 1f01          	ldw	(OFST-1,sp),x
1654  042f               L566:
1655                     ; 188 		buffer[i] = -1;  // Reset each element of the ADC buffer
1657  042f 1e01          	ldw	x,(OFST-1,sp)
1658  0431 58            	sllw	x
1659  0432 58            	sllw	x
1660  0433 72fb03        	addw	x,(OFST+1,sp)
1661  0436 90aeffff      	ldw	y,#65535
1662  043a 51            	exgw	x,y
1663  043b 8d000000      	callf	d_itof
1665  043f 51            	exgw	x,y
1666  0440 8d000000      	callf	d_rtol
1668                     ; 187 	for (i = 0; i < NUM_SAMPLES; i++) {
1670  0444 1e01          	ldw	x,(OFST-1,sp)
1671  0446 1c0001        	addw	x,#1
1672  0449 1f01          	ldw	(OFST-1,sp),x
1676  044b 1e01          	ldw	x,(OFST-1,sp)
1677  044d a30400        	cpw	x,#1024
1678  0450 25dd          	jrult	L566
1679                     ; 190 }
1682  0452 5b04          	addw	sp,#4
1683  0454 87            	retf
1685                     .const:	section	.text
1686  0000               L376_buffer:
1687  0000 00000000      	dc.w	0,0
1688  0004 000000000000  	ds.b	4092
1824                     ; 192 float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
1825                     	switch	.text
1826  0455               f_process_adc_signal:
1828  0455 88            	push	a
1829  0456 96            	ldw	x,sp
1830  0457 1d1021        	subw	x,#4129
1831  045a 94            	ldw	sp,x
1832       00001021      OFST:	set	4129
1835                     ; 193 	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
1837  045b 96            	ldw	x,sp
1838  045c 1c001e        	addw	x,#OFST-4099
1839  045f 90ae0000      	ldw	y,#L376_buffer
1840  0463 bf00          	ldw	c_x,x
1841  0465 ae1000        	ldw	x,#4096
1842  0468 8d000000      	callf	d_xymovl
1844                     ; 194 	unsigned long currentEdgeTime = 0;
1846                     ; 195 	float freqBuff = 0;
1848  046c ae0000        	ldw	x,#0
1849  046f 1f17          	ldw	(OFST-4106,sp),x
1850  0471 ae0000        	ldw	x,#0
1851  0474 1f15          	ldw	(OFST-4108,sp),x
1853                     ; 196 	int freqCount = 0;
1855  0476 96            	ldw	x,sp
1856  0477 905f          	clrw	y
1857  0479 df101e        	ldw	(OFST-3,x),y
1858                     ; 197 	uint16_t i = 0;
1860                     ; 198 	bool isChannel1 = (channel == VAR_SIGNAL);  // Check if the channel is for Signal 1 or Signal 2
1862  047c 96            	ldw	x,sp
1863  047d d61022        	ld	a,(OFST+1,x)
1864  0480 a105          	cp	a,#5
1865  0482 2605          	jrne	L05
1866  0484 ae0001        	ldw	x,#1
1867  0487 2001          	jra	L25
1868  0489               L05:
1869  0489 5f            	clrw	x
1870  048a               L25:
1871  048a 01            	rrwa	x,a
1872  048b 6b1d          	ld	(OFST-4100,sp),a
1873  048d 02            	rlwa	x,a
1875                     ; 199 	lastEdgeTime = 0;                 // Reset last zero-crossing time
1877  048e ae0000        	ldw	x,#0
1878  0491 bf0a          	ldw	_lastEdgeTime+2,x
1879  0493 ae0000        	ldw	x,#0
1880  0496 bf08          	ldw	_lastEdgeTime,x
1881                     ; 201 	initialize_adc_buffer(buffer);
1883  0498 96            	ldw	x,sp
1884  0499 1c001e        	addw	x,#OFST-4099
1885  049c 8d2a042a      	callf	f_initialize_adc_buffer
1887                     ; 204 	for (i = 0; i < NUM_SAMPLES; i++) {
1889  04a0 96            	ldw	x,sp
1890  04a1 905f          	clrw	y
1891  04a3 df1020        	ldw	(OFST-1,x),y
1892  04a6               L367:
1893                     ; 206 	buffer[i] = convert_adc_to_voltage(read_ADC_Channel(channel));
1895  04a6 96            	ldw	x,sp
1896  04a7 d61022        	ld	a,(OFST+1,x)
1897  04aa 8d000000      	callf	f_read_ADC_Channel
1899  04ae 8dd606d6      	callf	f_convert_adc_to_voltage
1901  04b2 96            	ldw	x,sp
1902  04b3 1c001e        	addw	x,#OFST-4099
1903  04b6 1f0f          	ldw	(OFST-4114,sp),x
1905  04b8 96            	ldw	x,sp
1906  04b9 de1020        	ldw	x,(OFST-1,x)
1907  04bc 58            	sllw	x
1908  04bd 58            	sllw	x
1909  04be 72fb0f        	addw	x,(OFST-4114,sp)
1910  04c1 8d000000      	callf	d_rtol
1912                     ; 208 	if (isChannel1 && (frequency != NULL)) { // Only calculate frequency for Signal 1 (Channel 1)
1914  04c5 0d1d          	tnz	(OFST-4100,sp)
1915  04c7 2604          	jrne	L66
1916  04c9 ac180618      	jpf	L177
1917  04cd               L66:
1919  04cd 96            	ldw	x,sp
1920  04ce d61027        	ld	a,(OFST+6,x)
1921  04d1 da1026        	or	a,(OFST+5,x)
1922  04d4 2604          	jrne	L07
1923  04d6 ac180618      	jpf	L177
1924  04da               L07:
1925                     ; 210 		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
1927  04da 96            	ldw	x,sp
1928  04db d61021        	ld	a,(OFST+0,x)
1929  04de da1020        	or	a,(OFST-1,x)
1930  04e1 2604          	jrne	L27
1931  04e3 ac180618      	jpf	L177
1932  04e7               L27:
1934  04e7 ce10ba        	ldw	x,L545+2
1935  04ea 89            	pushw	x
1936  04eb ce10b8        	ldw	x,L545
1937  04ee 89            	pushw	x
1938  04ef 96            	ldw	x,sp
1939  04f0 1c0022        	addw	x,#OFST-4095
1940  04f3 1f13          	ldw	(OFST-4110,sp),x
1942  04f5 96            	ldw	x,sp
1943  04f6 de1024        	ldw	x,(OFST+3,x)
1944  04f9 58            	sllw	x
1945  04fa 58            	sllw	x
1946  04fb 72fb13        	addw	x,(OFST-4110,sp)
1947  04fe 9093          	ldw	y,x
1948  0500 ee02          	ldw	x,(2,x)
1949  0502 89            	pushw	x
1950  0503 93            	ldw	x,y
1951  0504 fe            	ldw	x,(x)
1952  0505 89            	pushw	x
1953  0506 96            	ldw	x,sp
1954  0507 1c0026        	addw	x,#OFST-4091
1955  050a 1f15          	ldw	(OFST-4108,sp),x
1957  050c 96            	ldw	x,sp
1958  050d de1028        	ldw	x,(OFST+7,x)
1959  0510 58            	sllw	x
1960  0511 58            	sllw	x
1961  0512 1d0004        	subw	x,#4
1962  0515 72fb15        	addw	x,(OFST-4108,sp)
1963  0518 9093          	ldw	y,x
1964  051a ee02          	ldw	x,(2,x)
1965  051c 89            	pushw	x
1966  051d 93            	ldw	x,y
1967  051e fe            	ldw	x,(x)
1968  051f 89            	pushw	x
1969  0520 8d240224      	callf	f_detectZeroCross
1971  0524 5b0c          	addw	sp,#12
1972  0526 4d            	tnz	a
1973  0527 2604          	jrne	L47
1974  0529 ac180618      	jpf	L177
1975  052d               L47:
1976                     ; 211 			currentEdgeTime = micros();
1978  052d 8d000000      	callf	f_micros
1980  0531 96            	ldw	x,sp
1981  0532 1c0019        	addw	x,#OFST-4104
1982  0535 8d000000      	callf	d_rtol
1985                     ; 212 			if (lastEdgeTime > 0) {  // Zero-crossing detected; calculate period and frequency
1987  0539 ae0008        	ldw	x,#_lastEdgeTime
1988  053c 8d000000      	callf	d_lzmp
1990  0540 2604          	jrne	L67
1991  0542 ac100610      	jpf	L577
1992  0546               L67:
1993                     ; 213 				unsigned long period = currentEdgeTime - lastEdgeTime;  // Period in microseconds
1995  0546 96            	ldw	x,sp
1996  0547 1c0019        	addw	x,#OFST-4104
1997  054a 8d000000      	callf	d_ltor
1999  054e ae0008        	ldw	x,#_lastEdgeTime
2000  0551 8d000000      	callf	d_lsub
2002  0555 96            	ldw	x,sp
2003  0556 1c0011        	addw	x,#OFST-4112
2004  0559 8d000000      	callf	d_rtol
2007                     ; 214 				float singleFrequency = calculate_frequency(period);   // Calculate frequency in Hz
2009  055d 1e13          	ldw	x,(OFST-4110,sp)
2010  055f 89            	pushw	x
2011  0560 1e13          	ldw	x,(OFST-4110,sp)
2012  0562 89            	pushw	x
2013  0563 8de206e2      	callf	f_calculate_frequency
2015  0567 5b04          	addw	sp,#4
2016  0569 96            	ldw	x,sp
2017  056a 1c0011        	addw	x,#OFST-4112
2018  056d 8d000000      	callf	d_rtol
2021                     ; 216 				freqCount++;
2023  0571 96            	ldw	x,sp
2024  0572 9093          	ldw	y,x
2025  0574 de101e        	ldw	x,(OFST-3,x)
2026  0577 1c0001        	addw	x,#1
2027  057a 90df101e      	ldw	(OFST-3,y),x
2028                     ; 218 				if (freqCount == 2) {  // Stop after detecting 2 zero-crossings
2030  057e 96            	ldw	x,sp
2031  057f 9093          	ldw	y,x
2032  0581 90de101e      	ldw	y,(OFST-3,y)
2033  0585 90a30002      	cpw	y,#2
2034  0589 26b7          	jrne	L577
2035                     ; 219 					count = i;  // Limit used for amplitude calculation within this range
2037  058b 96            	ldw	x,sp
2038  058c de1020        	ldw	x,(OFST-1,x)
2039  058f bf12          	ldw	_count,x
2040                     ; 221 					*amplitude = calculate_amplitude(buffer, (freqCount > 0 ? count : NUM_SAMPLES));
2042  0591 9c            	rvf
2043  0592 5f            	clrw	x
2044  0593 1f0f          	ldw	(OFST-4114,sp),x
2046  0595 96            	ldw	x,sp
2047  0596 9093          	ldw	y,x
2048  0598 51            	exgw	x,y
2049  0599 de101e        	ldw	x,(OFST-3,x)
2050  059c 130f          	cpw	x,(OFST-4114,sp)
2051  059e 51            	exgw	x,y
2052  059f 2d04          	jrsle	L45
2053  05a1 be12          	ldw	x,_count
2054  05a3 2003          	jra	L65
2055  05a5               L45:
2056  05a5 ae0400        	ldw	x,#1024
2057  05a8               L65:
2058  05a8 8d000000      	callf	d_uitolx
2060  05ac be02          	ldw	x,c_lreg+2
2061  05ae 89            	pushw	x
2062  05af be00          	ldw	x,c_lreg
2063  05b1 89            	pushw	x
2064  05b2 96            	ldw	x,sp
2065  05b3 1c0022        	addw	x,#OFST-4095
2066  05b6 8d8a038a      	callf	f_calculate_amplitude
2068  05ba 5b04          	addw	sp,#4
2069  05bc 96            	ldw	x,sp
2070  05bd de1028        	ldw	x,(OFST+7,x)
2071  05c0 8d000000      	callf	d_rtol
2073                     ; 224 					if (isChannel1 && freqCount > 0) {
2075  05c4 0d1d          	tnz	(OFST-4100,sp)
2076  05c6 2725          	jreq	L1001
2078  05c8 9c            	rvf
2079  05c9 5f            	clrw	x
2080  05ca 1f0f          	ldw	(OFST-4114,sp),x
2082  05cc 96            	ldw	x,sp
2083  05cd 9093          	ldw	y,x
2084  05cf 51            	exgw	x,y
2085  05d0 de101e        	ldw	x,(OFST-3,x)
2086  05d3 130f          	cpw	x,(OFST-4114,sp)
2087  05d5 51            	exgw	x,y
2088  05d6 2d15          	jrsle	L1001
2089                     ; 225 						*frequency = singleFrequency;  // Calculate average frequency
2091  05d8 96            	ldw	x,sp
2092  05d9 de1026        	ldw	x,(OFST+5,x)
2093  05dc 7b14          	ld	a,(OFST-4109,sp)
2094  05de e703          	ld	(3,x),a
2095  05e0 7b13          	ld	a,(OFST-4110,sp)
2096  05e2 e702          	ld	(2,x),a
2097  05e4 7b12          	ld	a,(OFST-4111,sp)
2098  05e6 e701          	ld	(1,x),a
2099  05e8 7b11          	ld	a,(OFST-4112,sp)
2100  05ea f7            	ld	(x),a
2102  05eb 2017          	jra	L3001
2103  05ed               L1001:
2104                     ; 227 					else if (isChannel1) {
2106  05ed 0d1d          	tnz	(OFST-4100,sp)
2107  05ef 2713          	jreq	L3001
2108                     ; 228 						*frequency = 0;  // No crossings detected, return 0 frequency
2110  05f1 96            	ldw	x,sp
2111  05f2 de1026        	ldw	x,(OFST+5,x)
2112  05f5 a600          	ld	a,#0
2113  05f7 e703          	ld	(3,x),a
2114  05f9 a600          	ld	a,#0
2115  05fb e702          	ld	(2,x),a
2116  05fd a600          	ld	a,#0
2117  05ff e701          	ld	(1,x),a
2118  0601 a600          	ld	a,#0
2119  0603 f7            	ld	(x),a
2120  0604               L3001:
2121                     ; 230 					return *amplitude;
2123  0604 96            	ldw	x,sp
2124  0605 de1028        	ldw	x,(OFST+7,x)
2125  0608 8d000000      	callf	d_ltor
2128  060c accd06cd      	jpf	L46
2129  0610               L577:
2130                     ; 233 			lastEdgeTime = currentEdgeTime;  // Update last edge time
2132  0610 1e1b          	ldw	x,(OFST-4102,sp)
2133  0612 bf0a          	ldw	_lastEdgeTime+2,x
2134  0614 1e19          	ldw	x,(OFST-4104,sp)
2135  0616 bf08          	ldw	_lastEdgeTime,x
2136  0618               L177:
2137                     ; 238 	delay_us(1000000 / SAMPLE_RATE);
2139  0618 ae1a0a        	ldw	x,#6666
2140  061b 8d000000      	callf	f_delay_us
2142                     ; 204 	for (i = 0; i < NUM_SAMPLES; i++) {
2144  061f 96            	ldw	x,sp
2145  0620 9093          	ldw	y,x
2146  0622 de1020        	ldw	x,(OFST-1,x)
2147  0625 1c0001        	addw	x,#1
2148  0628 90df1020      	ldw	(OFST-1,y),x
2151  062c 96            	ldw	x,sp
2152  062d 9093          	ldw	y,x
2153  062f 90de1020      	ldw	y,(OFST-1,y)
2154  0633 90a30400      	cpw	y,#1024
2155  0637 2404          	jruge	L001
2156  0639 aca604a6      	jpf	L367
2157  063d               L001:
2158                     ; 242 	*amplitude = calculate_amplitude(buffer, (freqCount > 0 ? count : NUM_SAMPLES));
2160  063d 9c            	rvf
2161  063e 5f            	clrw	x
2162  063f 1f0f          	ldw	(OFST-4114,sp),x
2164  0641 96            	ldw	x,sp
2165  0642 9093          	ldw	y,x
2166  0644 51            	exgw	x,y
2167  0645 de101e        	ldw	x,(OFST-3,x)
2168  0648 130f          	cpw	x,(OFST-4114,sp)
2169  064a 51            	exgw	x,y
2170  064b 2d04          	jrsle	L06
2171  064d be12          	ldw	x,_count
2172  064f 2003          	jra	L26
2173  0651               L06:
2174  0651 ae0400        	ldw	x,#1024
2175  0654               L26:
2176  0654 8d000000      	callf	d_uitolx
2178  0658 be02          	ldw	x,c_lreg+2
2179  065a 89            	pushw	x
2180  065b be00          	ldw	x,c_lreg
2181  065d 89            	pushw	x
2182  065e 96            	ldw	x,sp
2183  065f 1c0022        	addw	x,#OFST-4095
2184  0662 8d8a038a      	callf	f_calculate_amplitude
2186  0666 5b04          	addw	sp,#4
2187  0668 96            	ldw	x,sp
2188  0669 de1028        	ldw	x,(OFST+7,x)
2189  066c 8d000000      	callf	d_rtol
2191                     ; 245 	if (isChannel1 && freqCount > 0) {
2193  0670 0d1d          	tnz	(OFST-4100,sp)
2194  0672 273a          	jreq	L7001
2196  0674 9c            	rvf
2197  0675 5f            	clrw	x
2198  0676 1f0f          	ldw	(OFST-4114,sp),x
2200  0678 96            	ldw	x,sp
2201  0679 9093          	ldw	y,x
2202  067b 51            	exgw	x,y
2203  067c de101e        	ldw	x,(OFST-3,x)
2204  067f 130f          	cpw	x,(OFST-4114,sp)
2205  0681 51            	exgw	x,y
2206  0682 2d2a          	jrsle	L7001
2207                     ; 246 		*frequency = freqBuff / freqCount;  // Calculate average frequency
2209  0684 96            	ldw	x,sp
2210  0685 de101e        	ldw	x,(OFST-3,x)
2211  0688 8d000000      	callf	d_itof
2213  068c 96            	ldw	x,sp
2214  068d 1c000d        	addw	x,#OFST-4116
2215  0690 8d000000      	callf	d_rtol
2218  0694 96            	ldw	x,sp
2219  0695 1c0015        	addw	x,#OFST-4108
2220  0698 8d000000      	callf	d_ltor
2222  069c 96            	ldw	x,sp
2223  069d 1c000d        	addw	x,#OFST-4116
2224  06a0 8d000000      	callf	d_fdiv
2226  06a4 96            	ldw	x,sp
2227  06a5 de1026        	ldw	x,(OFST+5,x)
2228  06a8 8d000000      	callf	d_rtol
2231  06ac 2017          	jra	L1101
2232  06ae               L7001:
2233                     ; 248 	else if (isChannel1) {
2235  06ae 0d1d          	tnz	(OFST-4100,sp)
2236  06b0 2713          	jreq	L1101
2237                     ; 249 		*frequency = 0;  // No crossings detected, return 0 frequency
2239  06b2 96            	ldw	x,sp
2240  06b3 de1026        	ldw	x,(OFST+5,x)
2241  06b6 a600          	ld	a,#0
2242  06b8 e703          	ld	(3,x),a
2243  06ba a600          	ld	a,#0
2244  06bc e702          	ld	(2,x),a
2245  06be a600          	ld	a,#0
2246  06c0 e701          	ld	(1,x),a
2247  06c2 a600          	ld	a,#0
2248  06c4 f7            	ld	(x),a
2249  06c5               L1101:
2250                     ; 252 	return *amplitude;  // Always return amplitude
2252  06c5 96            	ldw	x,sp
2253  06c6 de1028        	ldw	x,(OFST+7,x)
2254  06c9 8d000000      	callf	d_ltor
2257  06cd               L46:
2259  06cd 9096          	ldw	y,sp
2260  06cf 72a91022      	addw	y,#4130
2261  06d3 9094          	ldw	sp,y
2262  06d5 87            	retf
2296                     ; 256 float convert_adc_to_voltage(unsigned int adcValue) {
2297                     	switch	.text
2298  06d6               f_convert_adc_to_voltage:
2302                     ; 257 	return adcValue * (V_REF / ADC_MAX_VALUE);
2304  06d6 8d000000      	callf	d_uitof
2306  06da ae10ac        	ldw	x,#L7301
2307  06dd 8d000000      	callf	d_fmul
2311  06e1 87            	retf
2345                     ; 261 float calculate_frequency(unsigned long period) {
2346                     	switch	.text
2347  06e2               f_calculate_frequency:
2349  06e2 5204          	subw	sp,#4
2350       00000004      OFST:	set	4
2353                     ; 262 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
2355  06e4 96            	ldw	x,sp
2356  06e5 1c0008        	addw	x,#OFST+4
2357  06e8 8d000000      	callf	d_ltor
2359  06ec 8d000000      	callf	d_ultof
2361  06f0 ae10a4        	ldw	x,#L5701
2362  06f3 8d000000      	callf	d_fdiv
2364  06f7 96            	ldw	x,sp
2365  06f8 1c0001        	addw	x,#OFST-3
2366  06fb 8d000000      	callf	d_rtol
2369  06ff ae10a8        	ldw	x,#L5601
2370  0702 8d000000      	callf	d_ltor
2372  0706 96            	ldw	x,sp
2373  0707 1c0001        	addw	x,#OFST-3
2374  070a 8d000000      	callf	d_fdiv
2378  070e 5b04          	addw	sp,#4
2379  0710 87            	retf
2442                     ; 266 void output_results(float frequency, float amplitude, float FDR_Voltage) {
2443                     	switch	.text
2444  0711               f_output_results:
2446  0711 5228          	subw	sp,#40
2447       00000028      OFST:	set	40
2450                     ; 272 	sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,0\n", frequency, amplitude, amplitude/4.7, FDR_Voltage);
2452  0713 1e36          	ldw	x,(OFST+14,sp)
2453  0715 89            	pushw	x
2454  0716 1e36          	ldw	x,(OFST+14,sp)
2455  0718 89            	pushw	x
2456  0719 96            	ldw	x,sp
2457  071a 1c0034        	addw	x,#OFST+12
2458  071d 8d000000      	callf	d_ltor
2460  0721 ae1117        	ldw	x,#L532
2461  0724 8d000000      	callf	d_fdiv
2463  0728 be02          	ldw	x,c_lreg+2
2464  072a 89            	pushw	x
2465  072b be00          	ldw	x,c_lreg
2466  072d 89            	pushw	x
2467  072e 1e3a          	ldw	x,(OFST+18,sp)
2468  0730 89            	pushw	x
2469  0731 1e3a          	ldw	x,(OFST+18,sp)
2470  0733 89            	pushw	x
2471  0734 1e3a          	ldw	x,(OFST+18,sp)
2472  0736 89            	pushw	x
2473  0737 1e3a          	ldw	x,(OFST+18,sp)
2474  0739 89            	pushw	x
2475  073a ae108d        	ldw	x,#L3311
2476  073d 89            	pushw	x
2477  073e 96            	ldw	x,sp
2478  073f 1c0013        	addw	x,#OFST-21
2479  0742 8d000000      	callf	f_sprintf
2481  0746 5b12          	addw	sp,#18
2482                     ; 275 	printf("%s", buffer);
2484  0748 96            	ldw	x,sp
2485  0749 1c0001        	addw	x,#OFST-39
2486  074c 89            	pushw	x
2487  074d ae1114        	ldw	x,#L142
2488  0750 8d000000      	callf	f_printf
2490  0754 85            	popw	x
2491                     ; 277 }
2494  0755 5b28          	addw	sp,#40
2495  0757 87            	retf
2531                     ; 280 void send_square_pulse(uint16_t duration_ms) {
2532                     	switch	.text
2533  0758               f_send_square_pulse:
2535  0758 89            	pushw	x
2536       00000000      OFST:	set	0
2539                     ; 281 	GPIO_WriteHigh(GPIOC, GPIO_PIN_4); // Set square pulse pin high
2541  0759 4b10          	push	#16
2542  075b ae500a        	ldw	x,#20490
2543  075e 8d000000      	callf	f_GPIO_WriteHigh
2545  0762 84            	pop	a
2546                     ; 282 	delay_ms(duration_ms);            // Wait for the pulse duration
2548  0763 1e01          	ldw	x,(OFST+1,sp)
2549  0765 8d000000      	callf	f_delay_ms
2551                     ; 283 	GPIO_WriteLow(GPIOC, GPIO_PIN_4); // Set square pulse pin low
2553  0769 4b10          	push	#16
2554  076b ae500a        	ldw	x,#20490
2555  076e 8d000000      	callf	f_GPIO_WriteLow
2557  0772 84            	pop	a
2558                     ; 284 }
2561  0773 85            	popw	x
2562  0774 87            	retf
2599                     ; 287 void send_pulse_commutation(uint16_t duration_ms) {
2600                     	switch	.text
2601  0775               f_send_pulse_commutation:
2603  0775 89            	pushw	x
2604       00000000      OFST:	set	0
2607                     ; 288 	GPIO_WriteHigh(GPIOC, GPIO_PIN_2); // Set square pulse pin high
2609  0776 4b04          	push	#4
2610  0778 ae500a        	ldw	x,#20490
2611  077b 8d000000      	callf	f_GPIO_WriteHigh
2613  077f 84            	pop	a
2614                     ; 289 	delay_ms(duration_ms);            // Wait for the pulse duration
2616  0780 1e01          	ldw	x,(OFST+1,sp)
2617  0782 8d000000      	callf	f_delay_ms
2619                     ; 290 	GPIO_WriteLow(GPIOC, GPIO_PIN_2); // Set square pulse pin low
2621  0786 4b04          	push	#4
2622  0788 ae500a        	ldw	x,#20490
2623  078b 8d000000      	callf	f_GPIO_WriteLow
2625  078f 84            	pop	a
2626                     ; 291 }
2629  0790 85            	popw	x
2630  0791 87            	retf
2665                     ; 294 bool check_signal_dc(float amplitude) {
2666                     	switch	.text
2667  0792               f_check_signal_dc:
2669       00000000      OFST:	set	0
2672                     ; 295 	if (amplitude == 0) {
2674  0792 9c            	rvf
2675  0793 0d04          	tnz	(OFST+4,sp)
2676  0795 2607          	jrne	L7021
2677                     ; 296 		isThyristorON = true;
2679  0797 35010014      	mov	_isThyristorON,#1
2680                     ; 297 		return true;
2682  079b a601          	ld	a,#1
2685  079d 87            	retf
2686  079e               L7021:
2687                     ; 299 		isThyristorON = false;
2689  079e 3f14          	clr	_isThyristorON
2690                     ; 300 		return false;
2692  07a0 4f            	clr	a
2695  07a1 87            	retf
2742                     ; 304 void configure_set_frequency(void) {
2743                     	switch	.text
2744  07a2               f_configure_set_frequency:
2746  07a2 5218          	subw	sp,#24
2747       00000018      OFST:	set	24
2750                     ; 306 		float new_frequency = 5.0; // Convert string to float
2752                     ; 307     printf("Enter new set frequency (0.3 - 5 Hz):\n");
2754  07a4 ae1066        	ldw	x,#L5321
2755  07a7 8d000000      	callf	f_printf
2757                     ; 309     UART3_ReceiveString(buffer, sizeof(buffer)); // Receive user input
2759  07ab ae0014        	ldw	x,#20
2760  07ae 89            	pushw	x
2761  07af 96            	ldw	x,sp
2762  07b0 1c0003        	addw	x,#OFST-21
2763  07b3 8d000000      	callf	f_UART3_ReceiveString
2765  07b7 85            	popw	x
2766                     ; 310     new_frequency = atof(buffer); // Convert string to float
2768  07b8 96            	ldw	x,sp
2769  07b9 1c0001        	addw	x,#OFST-23
2770  07bc 8d000000      	callf	f_atof
2772  07c0 96            	ldw	x,sp
2773  07c1 1c0015        	addw	x,#OFST-3
2774  07c4 8d000000      	callf	d_rtol
2777                     ; 313     if (new_frequency >= 0.3 && new_frequency <= 5.0) {
2779  07c8 9c            	rvf
2780  07c9 96            	ldw	x,sp
2781  07ca 1c0015        	addw	x,#OFST-3
2782  07cd 8d000000      	callf	d_ltor
2784  07d1 ae1062        	ldw	x,#L5421
2785  07d4 8d000000      	callf	d_fcmp
2787  07d8 2f23          	jrslt	L7321
2789  07da 9c            	rvf
2790  07db 96            	ldw	x,sp
2791  07dc 1c0015        	addw	x,#OFST-3
2792  07df 8d000000      	callf	d_ltor
2794  07e3 ae1132        	ldw	x,#L322
2795  07e6 8d000000      	callf	d_fcmp
2797  07ea 2c11          	jrsgt	L7321
2798                     ; 315         printf("Set frequency updated to: %.2f Hz\n", new_frequency);
2800  07ec 1e17          	ldw	x,(OFST-1,sp)
2801  07ee 89            	pushw	x
2802  07ef 1e17          	ldw	x,(OFST-1,sp)
2803  07f1 89            	pushw	x
2804  07f2 ae103f        	ldw	x,#L1521
2805  07f5 8d000000      	callf	f_printf
2807  07f9 5b04          	addw	sp,#4
2809  07fb 2007          	jra	L3521
2810  07fd               L7321:
2811                     ; 317         printf("Invalid frequency. Please enter a value between 0.3 and 5 Hz.\n");
2813  07fd ae1000        	ldw	x,#L5521
2814  0800 8d000000      	callf	f_printf
2816  0804               L3521:
2817                     ; 319 }
2820  0804 5b18          	addw	sp,#24
2821  0806 87            	retf
2833                     	xdef	f_main
2834                     	xdef	f_handle_signal_1_AC
2835                     	xdef	f_wait_for_negative_zero_crossing
2836                     	xdef	f_handle_Frequency_Below_Set_Freq
2837                     	xdef	f_process_VAR_signal
2838                     	xdef	f_process_FDR_signal
2839                     	xdef	f_configure_set_frequency
2840                     	xdef	f_calculate_frequency
2841                     	xdef	f_convert_adc_to_voltage
2842                     	xdef	f_process_adc_signal
2843                     	xdef	f_calculate_amplitude
2844                     	xdef	f_output_results
2845                     	xdef	f_initialize_adc_buffer
2846                     	xdef	f_check_signal_dc
2847                     	xdef	f_send_pulse_commutation
2848                     	xdef	f_send_square_pulse
2849                     	xdef	f_check_negative_zero_crossing
2850                     	xdef	f_detect_negative_zero_cross
2851                     	xdef	f_detectZeroCross
2852                     	xdef	f_detectPosZeroCross
2853                     	xdef	f_initialize_system
2854                     	xdef	_isThyristorON
2855                     	xdef	_count
2856                     	xdef	_crossingType
2857                     	xdef	_currentEdgeTime
2858                     	xdef	_lastEdgeTime
2859                     	xdef	_sine1_amplitude
2860                     	xdef	_sine1_frequency
2861                     	xref	f_printDateTime
2862                     	xref	f_read_ADC_Channel
2863                     	xref	f_UART3_ReceiveString
2864                     	xref	f_GPIO_setup
2865                     	xref	f_ADC2_setup
2866                     	xref	f_UART3_setup
2867                     	xref	f_clock_setup
2868                     	xref	f_I2CInit
2869                     	xref	f_EEPROM_Config
2870                     	xref	f_micros
2871                     	xref	f_delay_us
2872                     	xref	f_delay_ms
2873                     	xref	f_TIM4_Config
2874                     	xref	f_atof
2875                     	xref	f_sprintf
2876                     	xref	f_printf
2877                     	xref	f_GPIO_WriteLow
2878                     	xref	f_GPIO_WriteHigh
2879                     	switch	.const
2880  1000               L5521:
2881  1000 496e76616c69  	dc.b	"Invalid frequency."
2882  1012 20506c656173  	dc.b	" Please enter a va"
2883  1024 6c7565206265  	dc.b	"lue between 0.3 an"
2884  1036 64203520487a  	dc.b	"d 5 Hz.",10,0
2885  103f               L1521:
2886  103f 536574206672  	dc.b	"Set frequency upda"
2887  1051 74656420746f  	dc.b	"ted to: %.2f Hz",10,0
2888  1062               L5421:
2889  1062 3e999999      	dc.w	16025,-26215
2890  1066               L5321:
2891  1066 456e74657220  	dc.b	"Enter new set freq"
2892  1078 75656e637920  	dc.b	"uency (0.3 - 5 Hz)"
2893  108a 3a0a00        	dc.b	":",10,0
2894  108d               L3311:
2895  108d 252e33662c25  	dc.b	"%.3f,%.3f,%.3f,%.3"
2896  109f 662c300a00    	dc.b	"f,0",10,0
2897  10a4               L5701:
2898  10a4 49742400      	dc.w	18804,9216
2899  10a8               L5601:
2900  10a8 3f800000      	dc.w	16256,0
2901  10ac               L7301:
2902  10ac 3b933333      	dc.w	15251,13107
2903  10b0               L316:
2904  10b0 c0933333      	dc.w	-16237,13107
2905  10b4               L326:
2906  10b4 40933333      	dc.w	16531,13107
2907  10b8               L545:
2908  10b8 3fc00000      	dc.w	16320,0
2909  10bc               L505:
2910  10bc 3f000000      	dc.w	16128,0
2911  10c0               L143:
2912  10c0 566172416d70  	dc.b	"VarAmplitude Not b"
2913  10d2 656c6f772031  	dc.b	"elow 10 mv.",10,0
2914  10df               L333:
2915  10df 3c23d70a      	dc.w	15395,-10486
2916  10e3               L503:
2917  10e3 5369676e616c  	dc.b	"Signal 1 AC and Va"
2918  10f5 72416d706c69  	dc.b	"rAmplitude: %f.",10,0
2919  1106               L103:
2920  1106 5369676e616c  	dc.b	"Signal 1 DC.",10,0
2921  1114               L142:
2922  1114 257300        	dc.b	"%s",0
2923  1117               L532:
2924  1117 40966666      	dc.w	16534,26214
2925  111b               L722:
2926  111b 252e33662c25  	dc.b	"%.3f,%.3f,%.3f,%.3"
2927  112d 662c310a00    	dc.b	"f,1",10,0
2928  1132               L322:
2929  1132 40a00000      	dc.w	16544,0
2930  1136               L701:
2931  1136 00000000      	dc.w	0,0
2932                     	xref.b	c_lreg
2933                     	xref.b	c_x
2934                     	xref.b	c_y
2954                     	xref	d_ultof
2955                     	xref	d_fmul
2956                     	xref	d_uitof
2957                     	xref	d_uitolx
2958                     	xref	d_lsub
2959                     	xref	d_lzmp
2960                     	xref	d_xymovl
2961                     	xref	d_itof
2962                     	xref	d_fsub
2963                     	xref	d_lcmp
2964                     	xref	d_lgadc
2965                     	xref	d_fdiv
2966                     	xref	d_fcmp
2967                     	xref	d_ltor
2968                     	xref	d_rtol
2969                     	end
