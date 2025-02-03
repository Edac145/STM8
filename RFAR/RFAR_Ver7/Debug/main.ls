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
 133                     	bsct
 134  0015               _set_freq:
 135  0015 00000000      	dc.w	0,0
 183                     ; 13 void main() {
 184                     	switch	.text
 185  0000               f_main:
 187  0000 5204          	subw	sp,#4
 188       00000004      OFST:	set	4
 191                     ; 14   float FDR_amplitude = 0.0;
 193  0002 ce131e        	ldw	x,L701+2
 194  0005 1f03          	ldw	(OFST-1,sp),x
 195  0007 ce131c        	ldw	x,L701
 196  000a 1f01          	ldw	(OFST-3,sp),x
 198                     ; 16 	initialize_system();
 200  000c 8d610061      	callf	f_initialize_system
 202                     ; 17   config_mode();
 204  0010 8de609e6      	callf	f_config_mode
 206                     ; 18 	read_set_frequency(&set_freq);
 208  0014 ae0015        	ldw	x,#_set_freq
 209  0017 8d9b099b      	callf	f_read_set_frequency
 211  001b               L311:
 212                     ; 21 		FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
 214  001b 96            	ldw	x,sp
 215  001c 1c0001        	addw	x,#OFST-3
 216  001f 89            	pushw	x
 217  0020 5f            	clrw	x
 218  0021 89            	pushw	x
 219  0022 a606          	ld	a,#6
 220  0024 8dd505d5      	callf	f_process_adc_signal
 222  0028 5b04          	addw	sp,#4
 223  002a 96            	ldw	x,sp
 224  002b 1c0001        	addw	x,#OFST-3
 225  002e 8d000000      	callf	d_rtol
 228                     ; 23 		if (FDR_amplitude > 0) { // Voltage detected on Signal 2
 230  0032 9c            	rvf
 231  0033 9c            	rvf
 232  0034 0d01          	tnz	(OFST-3,sp)
 233  0036 2de3          	jrsle	L311
 234                     ; 24 		  printf("FDR Voltage Exists\n");
 236  0038 ae1308        	ldw	x,#L121
 237  003b 8d000000      	callf	f_printf
 239                     ; 25 		  GPIO_WriteHigh(LED_RED); // Turn on LED
 241  003f 4b08          	push	#8
 242  0041 ae5000        	ldw	x,#20480
 243  0044 8d000000      	callf	f_GPIO_WriteHigh
 245  0048 84            	pop	a
 246                     ; 26 			GPIO_WriteHigh(GPIOD, GPIO_PIN_4);
 248  0049 4b10          	push	#16
 249  004b ae500f        	ldw	x,#20495
 250  004e 8d000000      	callf	f_GPIO_WriteHigh
 252  0052 84            	pop	a
 253                     ; 27 			process_VAR_signal(FDR_amplitude); // Handle Signal 1
 255  0053 1e03          	ldw	x,(OFST-1,sp)
 256  0055 89            	pushw	x
 257  0056 1e03          	ldw	x,(OFST-1,sp)
 258  0058 89            	pushw	x
 259  0059 8d280128      	callf	f_process_VAR_signal
 261  005d 5b04          	addw	sp,#4
 262  005f 20ba          	jra	L311
 294                     ; 33 void initialize_system(void) {
 295                     	switch	.text
 296  0061               f_initialize_system:
 300                     ; 34 	clock_setup();          // Configure system clock
 302  0061 8d000000      	callf	f_clock_setup
 304                     ; 35 	TIM4_Config();          // Timer 4 config for delay
 306  0065 8d000000      	callf	f_TIM4_Config
 308                     ; 36 	GPIO_setup();
 310  0069 8d000000      	callf	f_GPIO_setup
 312                     ; 37 	UART3_setup();          // Setup UART communication
 314  006d 8d000000      	callf	f_UART3_setup
 316                     ; 38 	UART1_setup();
 318  0071 8d000000      	callf	f_UART1_setup
 320                     ; 39 	ADC2_setup();						// Setup ADC
 322  0075 8d000000      	callf	f_ADC2_setup
 324                     ; 40 	EEPROM_Config();        // Configuring EEPROM
 326  0079 8d000000      	callf	f_EEPROM_Config
 328                     ; 41 	I2CInit();  // for Configuring RTC
 330  007d 8d000000      	callf	f_I2CInit
 332                     ; 42 	internal_EEPROM_Setup();
 334  0081 8d000000      	callf	f_internal_EEPROM_Setup
 336                     ; 43 	printf("System Initialization Completed\n\r");
 338  0085 ae12e6        	ldw	x,#L331
 339  0088 8d000000      	callf	f_printf
 341                     ; 44 }
 344  008c 87            	retf
 401                     ; 46 float process_FDR_signal(void) {
 402                     	switch	.text
 403  008d               f_process_FDR_signal:
 405  008d 5230          	subw	sp,#48
 406       00000030      OFST:	set	48
 409                     ; 47 	float FDR_amplitude = 0, VAR_amplitude = 0;
 411  008f ae0000        	ldw	x,#0
 412  0092 1f2b          	ldw	(OFST-5,sp),x
 413  0094 ae0000        	ldw	x,#0
 414  0097 1f29          	ldw	(OFST-7,sp),x
 418  0099 ae0000        	ldw	x,#0
 419  009c 1f2f          	ldw	(OFST-1,sp),x
 420  009e ae0000        	ldw	x,#0
 421  00a1 1f2d          	ldw	(OFST-3,sp),x
 423  00a3               L361:
 424                     ; 50 		VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
 426  00a3 96            	ldw	x,sp
 427  00a4 1c002d        	addw	x,#OFST-3
 428  00a7 89            	pushw	x
 429  00a8 5f            	clrw	x
 430  00a9 89            	pushw	x
 431  00aa a605          	ld	a,#5
 432  00ac 8dd505d5      	callf	f_process_adc_signal
 434  00b0 5b04          	addw	sp,#4
 435  00b2 96            	ldw	x,sp
 436  00b3 1c002d        	addw	x,#OFST-3
 437  00b6 8d000000      	callf	d_rtol
 440                     ; 51 		FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
 442  00ba 96            	ldw	x,sp
 443  00bb 1c0029        	addw	x,#OFST-7
 444  00be 89            	pushw	x
 445  00bf 5f            	clrw	x
 446  00c0 89            	pushw	x
 447  00c1 a606          	ld	a,#6
 448  00c3 8dd505d5      	callf	f_process_adc_signal
 450  00c7 5b04          	addw	sp,#4
 451  00c9 96            	ldw	x,sp
 452  00ca 1c0029        	addw	x,#OFST-7
 453  00cd 8d000000      	callf	d_rtol
 456                     ; 52     sprintf(buffer, "0.000,%.3f,%.3f,%.3f,1\n", VAR_amplitude, VAR_amplitude/4.7, FDR_amplitude);
 458  00d1 1e2b          	ldw	x,(OFST-5,sp)
 459  00d3 89            	pushw	x
 460  00d4 1e2b          	ldw	x,(OFST-5,sp)
 461  00d6 89            	pushw	x
 462  00d7 96            	ldw	x,sp
 463  00d8 1c0031        	addw	x,#OFST+1
 464  00db 8d000000      	callf	d_ltor
 466  00df ae12ca        	ldw	x,#L571
 467  00e2 8d000000      	callf	d_fdiv
 469  00e6 be02          	ldw	x,c_lreg+2
 470  00e8 89            	pushw	x
 471  00e9 be00          	ldw	x,c_lreg
 472  00eb 89            	pushw	x
 473  00ec 1e37          	ldw	x,(OFST+7,sp)
 474  00ee 89            	pushw	x
 475  00ef 1e37          	ldw	x,(OFST+7,sp)
 476  00f1 89            	pushw	x
 477  00f2 ae12ce        	ldw	x,#L761
 478  00f5 89            	pushw	x
 479  00f6 96            	ldw	x,sp
 480  00f7 1c000f        	addw	x,#OFST-33
 481  00fa 8d000000      	callf	f_sprintf
 483  00fe 5b0e          	addw	sp,#14
 484                     ; 53 	  printf("%s", buffer);
 486  0100 96            	ldw	x,sp
 487  0101 1c0001        	addw	x,#OFST-47
 488  0104 89            	pushw	x
 489  0105 ae12c7        	ldw	x,#L102
 490  0108 8d000000      	callf	f_printf
 492  010c 85            	popw	x
 493                     ; 54 		if ((FDR_amplitude > 0) && (VAR_amplitude > 0)) {
 495  010d 9c            	rvf
 496  010e 9c            	rvf
 497  010f 0d29          	tnz	(OFST-7,sp)
 498  0111 2d90          	jrsle	L361
 500  0113 9c            	rvf
 501  0114 9c            	rvf
 502  0115 0d2d          	tnz	(OFST-3,sp)
 503  0117 2d8a          	jrsle	L361
 504  0119               L502:
 505                     ; 56 				handle_commutation_pulse(); // Execute the pulse sending
 507  0119 8d210921      	callf	f_handle_commutation_pulse
 509                     ; 57 			} while (check_FDR_amplitude()); // Repeat if FDR_amplitude is still non-zero
 511  011d 8d4e094e      	callf	f_check_FDR_amplitude
 513  0121 4d            	tnz	a
 514  0122 26f5          	jrne	L502
 515  0124 aca300a3      	jpf	L361
 581                     ; 63 void process_VAR_signal(float FDR_amplitude) {
 582                     	switch	.text
 583  0128               f_process_VAR_signal:
 585  0128 5230          	subw	sp,#48
 586       00000030      OFST:	set	48
 589                     ; 64 	float VAR_frequency = 0.0, VAR_amplitude = 0.0;
 591  012a ce131e        	ldw	x,L701+2
 592  012d 1f2b          	ldw	(OFST-5,sp),x
 593  012f ce131c        	ldw	x,L701
 594  0132 1f29          	ldw	(OFST-7,sp),x
 598  0134 ce131e        	ldw	x,L701+2
 599  0137 1f2f          	ldw	(OFST-1,sp),x
 600  0139 ce131c        	ldw	x,L701
 601  013c 1f2d          	ldw	(OFST-3,sp),x
 603  013e               L542:
 604                     ; 67 		VAR_amplitude = process_adc_signal(VAR_SIGNAL, &VAR_frequency, &VAR_amplitude);
 606  013e 96            	ldw	x,sp
 607  013f 1c002d        	addw	x,#OFST-3
 608  0142 89            	pushw	x
 609  0143 96            	ldw	x,sp
 610  0144 1c002b        	addw	x,#OFST-5
 611  0147 89            	pushw	x
 612  0148 a605          	ld	a,#5
 613  014a 8dd505d5      	callf	f_process_adc_signal
 615  014e 5b04          	addw	sp,#4
 616  0150 96            	ldw	x,sp
 617  0151 1c002d        	addw	x,#OFST-3
 618  0154 8d000000      	callf	d_rtol
 621                     ; 71 		printf(" Frequency: %.3f, Amplitude: %.3f, Current: %.3f, FDR_Voltage: %.3f\n",
 621                     ; 72 					 VAR_frequency, VAR_amplitude, VAR_amplitude / 4.7, FDR_amplitude);
 623  0158 1e36          	ldw	x,(OFST+6,sp)
 624  015a 89            	pushw	x
 625  015b 1e36          	ldw	x,(OFST+6,sp)
 626  015d 89            	pushw	x
 627  015e 96            	ldw	x,sp
 628  015f 1c0031        	addw	x,#OFST+1
 629  0162 8d000000      	callf	d_ltor
 631  0166 ae12ca        	ldw	x,#L571
 632  0169 8d000000      	callf	d_fdiv
 634  016d be02          	ldw	x,c_lreg+2
 635  016f 89            	pushw	x
 636  0170 be00          	ldw	x,c_lreg
 637  0172 89            	pushw	x
 638  0173 1e37          	ldw	x,(OFST+7,sp)
 639  0175 89            	pushw	x
 640  0176 1e37          	ldw	x,(OFST+7,sp)
 641  0178 89            	pushw	x
 642  0179 1e37          	ldw	x,(OFST+7,sp)
 643  017b 89            	pushw	x
 644  017c 1e37          	ldw	x,(OFST+7,sp)
 645  017e 89            	pushw	x
 646  017f ae1282        	ldw	x,#L152
 647  0182 8d000000      	callf	f_printf
 649  0186 5b10          	addw	sp,#16
 650                     ; 74 		output_results(VAR_frequency, VAR_amplitude, FDR_amplitude);
 652  0188 1e36          	ldw	x,(OFST+6,sp)
 653  018a 89            	pushw	x
 654  018b 1e36          	ldw	x,(OFST+6,sp)
 655  018d 89            	pushw	x
 656  018e 1e33          	ldw	x,(OFST+3,sp)
 657  0190 89            	pushw	x
 658  0191 1e33          	ldw	x,(OFST+3,sp)
 659  0193 89            	pushw	x
 660  0194 1e33          	ldw	x,(OFST+3,sp)
 661  0196 89            	pushw	x
 662  0197 1e33          	ldw	x,(OFST+3,sp)
 663  0199 89            	pushw	x
 664  019a 8d890889      	callf	f_output_results
 666  019e 5b0c          	addw	sp,#12
 667                     ; 76 		if (VAR_frequency <= SET_FREQ) {
 669  01a0 9c            	rvf
 670  01a1 96            	ldw	x,sp
 671  01a2 1c0029        	addw	x,#OFST-7
 672  01a5 8d000000      	callf	d_ltor
 674  01a9 ae127e        	ldw	x,#L162
 675  01ac 8d000000      	callf	d_fcmp
 677  01b0 2c8c          	jrsgt	L542
 678                     ; 78 			printf("Frequency Below Set Frequency.\n");
 680  01b2 ae125e        	ldw	x,#L562
 681  01b5 8d000000      	callf	f_printf
 683                     ; 80 			sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", VAR_frequency, VAR_amplitude, VAR_amplitude/4.7, FDR_amplitude);
 685  01b9 1e36          	ldw	x,(OFST+6,sp)
 686  01bb 89            	pushw	x
 687  01bc 1e36          	ldw	x,(OFST+6,sp)
 688  01be 89            	pushw	x
 689  01bf 96            	ldw	x,sp
 690  01c0 1c0031        	addw	x,#OFST+1
 691  01c3 8d000000      	callf	d_ltor
 693  01c7 ae12ca        	ldw	x,#L571
 694  01ca 8d000000      	callf	d_fdiv
 696  01ce be02          	ldw	x,c_lreg+2
 697  01d0 89            	pushw	x
 698  01d1 be00          	ldw	x,c_lreg
 699  01d3 89            	pushw	x
 700  01d4 1e37          	ldw	x,(OFST+7,sp)
 701  01d6 89            	pushw	x
 702  01d7 1e37          	ldw	x,(OFST+7,sp)
 703  01d9 89            	pushw	x
 704  01da 1e37          	ldw	x,(OFST+7,sp)
 705  01dc 89            	pushw	x
 706  01dd 1e37          	ldw	x,(OFST+7,sp)
 707  01df 89            	pushw	x
 708  01e0 ae1247        	ldw	x,#L762
 709  01e3 89            	pushw	x
 710  01e4 96            	ldw	x,sp
 711  01e5 1c0013        	addw	x,#OFST-29
 712  01e8 8d000000      	callf	f_sprintf
 714  01ec 5b12          	addw	sp,#18
 715                     ; 81 			printf("%s", buffer);
 717  01ee 96            	ldw	x,sp
 718  01ef 1c0001        	addw	x,#OFST-47
 719  01f2 89            	pushw	x
 720  01f3 ae12c7        	ldw	x,#L102
 721  01f6 8d000000      	callf	f_printf
 723  01fa 85            	popw	x
 724                     ; 82 			handle_Frequency_Below_Set_Freq(VAR_amplitude);
 726  01fb 1e2f          	ldw	x,(OFST-1,sp)
 727  01fd 89            	pushw	x
 728  01fe 1e2f          	ldw	x,(OFST-1,sp)
 729  0200 89            	pushw	x
 730  0201 8d130213      	callf	f_handle_Frequency_Below_Set_Freq
 732  0205 5b04          	addw	sp,#4
 733  0207 ac3e013e      	jpf	L542
 757                     ; 87 void wait_for_negative_zero_crossing(void) {
 758                     	switch	.text
 759  020b               f_wait_for_negative_zero_crossing:
 763  020b               L303:
 764                     ; 88 	while (!check_negative_zero_crossing()) {
 766  020b 8db904b9      	callf	f_check_negative_zero_crossing
 768  020f 4d            	tnz	a
 769  0210 27f9          	jreq	L303
 770                     ; 92 }
 773  0212 87            	retf
 826                     ; 94 void handle_Frequency_Below_Set_Freq(float VAR_amplitude) {
 827                     	switch	.text
 828  0213               f_handle_Frequency_Below_Set_Freq:
 830  0213 5228          	subw	sp,#40
 831       00000028      OFST:	set	40
 834                     ; 96 	wait_for_negative_zero_crossing();
 836  0215 8d0b020b      	callf	f_wait_for_negative_zero_crossing
 838                     ; 97 	printf("Sending Square Pulse.\n");
 840  0219 ae1230        	ldw	x,#L133
 841  021c 8d000000      	callf	f_printf
 843                     ; 98 	send_square_pulse(5);
 845  0220 ae0005        	ldw	x,#5
 846  0223 8d040904      	callf	f_send_square_pulse
 848                     ; 99 	GPIO_WriteHigh(LED_BLUE); 
 850  0227 4b01          	push	#1
 851  0229 ae500f        	ldw	x,#20495
 852  022c 8d000000      	callf	f_GPIO_WriteHigh
 854  0230 84            	pop	a
 855                     ; 100 	GPIO_WriteHigh(GPIOD, GPIO_PIN_2); 
 857  0231 4b04          	push	#4
 858  0233 ae500f        	ldw	x,#20495
 859  0236 8d000000      	callf	f_GPIO_WriteHigh
 861  023a 84            	pop	a
 862                     ; 101 	VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
 864  023b 96            	ldw	x,sp
 865  023c 1c002c        	addw	x,#OFST+4
 866  023f 89            	pushw	x
 867  0240 5f            	clrw	x
 868  0241 89            	pushw	x
 869  0242 a605          	ld	a,#5
 870  0244 8dd505d5      	callf	f_process_adc_signal
 872  0248 5b04          	addw	sp,#4
 873  024a 96            	ldw	x,sp
 874  024b 1c002c        	addw	x,#OFST+4
 875  024e 8d000000      	callf	d_rtol
 877                     ; 102   sprintf(buffer, "0.000,%.3f,%.3f,%.3f,1\n", VAR_amplitude, VAR_amplitude/4.7, 0);
 879  0252 5f            	clrw	x
 880  0253 89            	pushw	x
 881  0254 96            	ldw	x,sp
 882  0255 1c002e        	addw	x,#OFST+6
 883  0258 8d000000      	callf	d_ltor
 885  025c ae12ca        	ldw	x,#L571
 886  025f 8d000000      	callf	d_fdiv
 888  0263 be02          	ldw	x,c_lreg+2
 889  0265 89            	pushw	x
 890  0266 be00          	ldw	x,c_lreg
 891  0268 89            	pushw	x
 892  0269 1e34          	ldw	x,(OFST+12,sp)
 893  026b 89            	pushw	x
 894  026c 1e34          	ldw	x,(OFST+12,sp)
 895  026e 89            	pushw	x
 896  026f ae12ce        	ldw	x,#L761
 897  0272 89            	pushw	x
 898  0273 96            	ldw	x,sp
 899  0274 1c000d        	addw	x,#OFST-27
 900  0277 8d000000      	callf	f_sprintf
 902  027b 5b0c          	addw	sp,#12
 903                     ; 103 	printf("%s", buffer);
 905  027d 96            	ldw	x,sp
 906  027e 1c0001        	addw	x,#OFST-39
 907  0281 89            	pushw	x
 908  0282 ae12c7        	ldw	x,#L102
 909  0285 8d000000      	callf	f_printf
 911  0289 85            	popw	x
 912                     ; 104 	if (check_signal_dc(VAR_amplitude)) {
 914  028a 1e2e          	ldw	x,(OFST+6,sp)
 915  028c 89            	pushw	x
 916  028d 1e2e          	ldw	x,(OFST+6,sp)
 917  028f 89            	pushw	x
 918  0290 8d7e097e      	callf	f_check_signal_dc
 920  0294 5b04          	addw	sp,#4
 921  0296 4d            	tnz	a
 922  0297 2717          	jreq	L333
 923                     ; 106 		printf("Signal 1 DC.\n");
 925  0299 ae1222        	ldw	x,#L533
 926  029c 8d000000      	callf	f_printf
 928                     ; 107 		GPIO_WriteHigh(LED_BLUE); 
 930  02a0 4b01          	push	#1
 931  02a2 ae500f        	ldw	x,#20495
 932  02a5 8d000000      	callf	f_GPIO_WriteHigh
 934  02a9 84            	pop	a
 935                     ; 108 		process_FDR_signal();
 937  02aa 8d8d008d      	callf	f_process_FDR_signal
 940  02ae 201b          	jra	L733
 941  02b0               L333:
 942                     ; 111 		printf("Signal 1 AC and VarAmplitude: %f.\n", VAR_amplitude);
 944  02b0 1e2e          	ldw	x,(OFST+6,sp)
 945  02b2 89            	pushw	x
 946  02b3 1e2e          	ldw	x,(OFST+6,sp)
 947  02b5 89            	pushw	x
 948  02b6 ae11ff        	ldw	x,#L143
 949  02b9 8d000000      	callf	f_printf
 951  02bd 5b04          	addw	sp,#4
 952                     ; 112 		handle_signal_1_AC(VAR_amplitude);
 954  02bf 1e2e          	ldw	x,(OFST+6,sp)
 955  02c1 89            	pushw	x
 956  02c2 1e2e          	ldw	x,(OFST+6,sp)
 957  02c4 89            	pushw	x
 958  02c5 8dce02ce      	callf	f_handle_signal_1_AC
 960  02c9 5b04          	addw	sp,#4
 961  02cb               L733:
 962                     ; 114 }
 965  02cb 5b28          	addw	sp,#40
 966  02cd 87            	retf
1016                     ; 117 void handle_signal_1_AC(float VAR_amplitude) {
1017                     	switch	.text
1018  02ce               f_handle_signal_1_AC:
1020  02ce 5228          	subw	sp,#40
1021       00000028      OFST:	set	40
1024                     ; 119 	if (VAR_amplitude < AC_AMPLITUDE_THRESHOLD) {
1026  02d0 9c            	rvf
1027  02d1 96            	ldw	x,sp
1028  02d2 1c002c        	addw	x,#OFST+4
1029  02d5 8d000000      	callf	d_ltor
1031  02d9 ae11fb        	ldw	x,#L373
1032  02dc 8d000000      	callf	d_fcmp
1034  02e0 2e59          	jrsge	L563
1035                     ; 121 		sprintf(buffer, "0.000,%.3f,%.3f,%.3f,1\n", VAR_amplitude, VAR_amplitude/4.7, 0);
1037  02e2 5f            	clrw	x
1038  02e3 89            	pushw	x
1039  02e4 96            	ldw	x,sp
1040  02e5 1c002e        	addw	x,#OFST+6
1041  02e8 8d000000      	callf	d_ltor
1043  02ec ae12ca        	ldw	x,#L571
1044  02ef 8d000000      	callf	d_fdiv
1046  02f3 be02          	ldw	x,c_lreg+2
1047  02f5 89            	pushw	x
1048  02f6 be00          	ldw	x,c_lreg
1049  02f8 89            	pushw	x
1050  02f9 1e34          	ldw	x,(OFST+12,sp)
1051  02fb 89            	pushw	x
1052  02fc 1e34          	ldw	x,(OFST+12,sp)
1053  02fe 89            	pushw	x
1054  02ff ae12ce        	ldw	x,#L761
1055  0302 89            	pushw	x
1056  0303 96            	ldw	x,sp
1057  0304 1c000d        	addw	x,#OFST-27
1058  0307 8d000000      	callf	f_sprintf
1060  030b 5b0c          	addw	sp,#12
1061                     ; 122 	  printf("%s", buffer);
1063  030d 96            	ldw	x,sp
1064  030e 1c0001        	addw	x,#OFST-39
1065  0311 89            	pushw	x
1066  0312 ae12c7        	ldw	x,#L102
1067  0315 8d000000      	callf	f_printf
1069  0319 85            	popw	x
1070                     ; 123 		printf("VarAmplitude below 10 mv.\n");
1072  031a ae11e0        	ldw	x,#L773
1073  031d 8d000000      	callf	f_printf
1075                     ; 124 		GPIO_WriteLow(LED_WHITE); // Turn on LED if Signal is AC < 20 mV
1077  0321 4b08          	push	#8
1078  0323 ae500a        	ldw	x,#20490
1079  0326 8d000000      	callf	f_GPIO_WriteLow
1081  032a 84            	pop	a
1082                     ; 125 		delay_ms(3000);
1084  032b ae0bb8        	ldw	x,#3000
1085  032e 8d000000      	callf	f_delay_ms
1087                     ; 126 		send_square_pulse(5);
1089  0332 ae0005        	ldw	x,#5
1090  0335 8d040904      	callf	f_send_square_pulse
1093  0339 205f          	jra	L104
1094  033b               L563:
1095                     ; 129 		GPIO_WriteHigh(GPIOD, GPIO_PIN_7);  // Turn on LED if Signal is AC < 20 ms
1097  033b 4b80          	push	#128
1098  033d ae500f        	ldw	x,#20495
1099  0340 8d000000      	callf	f_GPIO_WriteHigh
1101  0344 84            	pop	a
1102                     ; 130 		sprintf(buffer, "%0.000,%.3f,%.3f,%.3f,1\n", VAR_amplitude, VAR_amplitude/4.7, 0);
1104  0345 5f            	clrw	x
1105  0346 89            	pushw	x
1106  0347 96            	ldw	x,sp
1107  0348 1c002e        	addw	x,#OFST+6
1108  034b 8d000000      	callf	d_ltor
1110  034f ae12ca        	ldw	x,#L571
1111  0352 8d000000      	callf	d_fdiv
1113  0356 be02          	ldw	x,c_lreg+2
1114  0358 89            	pushw	x
1115  0359 be00          	ldw	x,c_lreg
1116  035b 89            	pushw	x
1117  035c 1e34          	ldw	x,(OFST+12,sp)
1118  035e 89            	pushw	x
1119  035f 1e34          	ldw	x,(OFST+12,sp)
1120  0361 89            	pushw	x
1121  0362 ae11c7        	ldw	x,#L304
1122  0365 89            	pushw	x
1123  0366 96            	ldw	x,sp
1124  0367 1c000d        	addw	x,#OFST-27
1125  036a 8d000000      	callf	f_sprintf
1127  036e 5b0c          	addw	sp,#12
1128                     ; 131 	  printf("%s", buffer);
1130  0370 96            	ldw	x,sp
1131  0371 1c0001        	addw	x,#OFST-39
1132  0374 89            	pushw	x
1133  0375 ae12c7        	ldw	x,#L102
1134  0378 8d000000      	callf	f_printf
1136  037c 85            	popw	x
1137                     ; 132 		printf("VarAmplitude Not below 10 mv.\n");
1139  037d ae11a8        	ldw	x,#L504
1140  0380 8d000000      	callf	f_printf
1142                     ; 133 		handle_Frequency_Below_Set_Freq(VAR_amplitude);
1144  0384 1e2e          	ldw	x,(OFST+6,sp)
1145  0386 89            	pushw	x
1146  0387 1e2e          	ldw	x,(OFST+6,sp)
1147  0389 89            	pushw	x
1148  038a 8d130213      	callf	f_handle_Frequency_Below_Set_Freq
1150  038e 5b04          	addw	sp,#4
1151                     ; 134 		GPIO_WriteHigh(LED_WHITE);  // Turn on LED if Signal is AC < 20 ms		
1153  0390 4b08          	push	#8
1154  0392 ae500a        	ldw	x,#20490
1155  0395 8d000000      	callf	f_GPIO_WriteHigh
1157  0399 84            	pop	a
1158  039a               L104:
1159                     ; 136 }
1162  039a 5b28          	addw	sp,#40
1163  039c 87            	retf
1236                     ; 139 bool detectZeroCross(float previousSample, float currentSample, float threshold) {
1237                     	switch	.text
1238  039d               f_detectZeroCross:
1240       00000000      OFST:	set	0
1243                     ; 140 	if (crossingType == -1) {  // If no crossing type detected, check for both positive and negative
1245  039d be10          	ldw	x,_crossingType
1246  039f a3ffff        	cpw	x,#65535
1247  03a2 265a          	jrne	L544
1248                     ; 141 		if (previousSample <= threshold && currentSample > threshold) {
1250  03a4 9c            	rvf
1251  03a5 96            	ldw	x,sp
1252  03a6 1c0004        	addw	x,#OFST+4
1253  03a9 8d000000      	callf	d_ltor
1255  03ad 96            	ldw	x,sp
1256  03ae 1c000c        	addw	x,#OFST+12
1257  03b1 8d000000      	callf	d_fcmp
1259  03b5 2c19          	jrsgt	L744
1261  03b7 9c            	rvf
1262  03b8 96            	ldw	x,sp
1263  03b9 1c0008        	addw	x,#OFST+8
1264  03bc 8d000000      	callf	d_ltor
1266  03c0 96            	ldw	x,sp
1267  03c1 1c000c        	addw	x,#OFST+12
1268  03c4 8d000000      	callf	d_fcmp
1270  03c8 2d06          	jrsle	L744
1271                     ; 142 			crossingType = 0;  // Positive zero crossing
1273  03ca 5f            	clrw	x
1274  03cb bf10          	ldw	_crossingType,x
1275                     ; 143 			return true;
1277  03cd a601          	ld	a,#1
1280  03cf 87            	retf
1281  03d0               L744:
1282                     ; 144 		} else if (previousSample >= threshold && currentSample < threshold) {
1284  03d0 9c            	rvf
1285  03d1 96            	ldw	x,sp
1286  03d2 1c0004        	addw	x,#OFST+4
1287  03d5 8d000000      	callf	d_ltor
1289  03d9 96            	ldw	x,sp
1290  03da 1c000c        	addw	x,#OFST+12
1291  03dd 8d000000      	callf	d_fcmp
1293  03e1 2f78          	jrslt	L554
1295  03e3 9c            	rvf
1296  03e4 96            	ldw	x,sp
1297  03e5 1c0008        	addw	x,#OFST+8
1298  03e8 8d000000      	callf	d_ltor
1300  03ec 96            	ldw	x,sp
1301  03ed 1c000c        	addw	x,#OFST+12
1302  03f0 8d000000      	callf	d_fcmp
1304  03f4 2e65          	jrsge	L554
1305                     ; 145 			crossingType = 1;  // Negative zero crossing
1307  03f6 ae0001        	ldw	x,#1
1308  03f9 bf10          	ldw	_crossingType,x
1309                     ; 146 			return true;
1311  03fb a601          	ld	a,#1
1314  03fd 87            	retf
1315  03fe               L544:
1316                     ; 148 	} else if (crossingType == 0 && previousSample <= threshold && currentSample > threshold) {
1318  03fe be10          	ldw	x,_crossingType
1319  0400 2629          	jrne	L754
1321  0402 9c            	rvf
1322  0403 96            	ldw	x,sp
1323  0404 1c0004        	addw	x,#OFST+4
1324  0407 8d000000      	callf	d_ltor
1326  040b 96            	ldw	x,sp
1327  040c 1c000c        	addw	x,#OFST+12
1328  040f 8d000000      	callf	d_fcmp
1330  0413 2c16          	jrsgt	L754
1332  0415 9c            	rvf
1333  0416 96            	ldw	x,sp
1334  0417 1c0008        	addw	x,#OFST+8
1335  041a 8d000000      	callf	d_ltor
1337  041e 96            	ldw	x,sp
1338  041f 1c000c        	addw	x,#OFST+12
1339  0422 8d000000      	callf	d_fcmp
1341  0426 2d03          	jrsle	L754
1342                     ; 149 			return true;  // Positive zero crossing
1344  0428 a601          	ld	a,#1
1347  042a 87            	retf
1348  042b               L754:
1349                     ; 150 	} else if (crossingType == 1 && previousSample >= threshold && currentSample < threshold) {
1351  042b be10          	ldw	x,_crossingType
1352  042d a30001        	cpw	x,#1
1353  0430 2629          	jrne	L554
1355  0432 9c            	rvf
1356  0433 96            	ldw	x,sp
1357  0434 1c0004        	addw	x,#OFST+4
1358  0437 8d000000      	callf	d_ltor
1360  043b 96            	ldw	x,sp
1361  043c 1c000c        	addw	x,#OFST+12
1362  043f 8d000000      	callf	d_fcmp
1364  0443 2f16          	jrslt	L554
1366  0445 9c            	rvf
1367  0446 96            	ldw	x,sp
1368  0447 1c0008        	addw	x,#OFST+8
1369  044a 8d000000      	callf	d_ltor
1371  044e 96            	ldw	x,sp
1372  044f 1c000c        	addw	x,#OFST+12
1373  0452 8d000000      	callf	d_fcmp
1375  0456 2e03          	jrsge	L554
1376                     ; 151 			return true;  // Negative zero crossing
1378  0458 a601          	ld	a,#1
1381  045a 87            	retf
1382  045b               L554:
1383                     ; 154 	return false;  // No zero crossing detected
1385  045b 4f            	clr	a
1388  045c 87            	retf
1440                     ; 158 bool detectPosZeroCross(float previousSample, float currentSample, float threshold) {
1441                     	switch	.text
1442  045d               f_detectPosZeroCross:
1444       00000000      OFST:	set	0
1447                     ; 159 	return (previousSample <= threshold && currentSample > threshold);
1449  045d 9c            	rvf
1450  045e 96            	ldw	x,sp
1451  045f 1c0004        	addw	x,#OFST+4
1452  0462 8d000000      	callf	d_ltor
1454  0466 96            	ldw	x,sp
1455  0467 1c000c        	addw	x,#OFST+12
1456  046a 8d000000      	callf	d_fcmp
1458  046e 2c17          	jrsgt	L62
1459  0470 9c            	rvf
1460  0471 96            	ldw	x,sp
1461  0472 1c0008        	addw	x,#OFST+8
1462  0475 8d000000      	callf	d_ltor
1464  0479 96            	ldw	x,sp
1465  047a 1c000c        	addw	x,#OFST+12
1466  047d 8d000000      	callf	d_fcmp
1468  0481 2d04          	jrsle	L62
1469  0483 a601          	ld	a,#1
1470  0485 2001          	jra	L03
1471  0487               L62:
1472  0487 4f            	clr	a
1473  0488               L03:
1476  0488 87            	retf
1538                     ; 163 bool detect_negative_zero_cross(float previous_sample, float current_sample, float threshold) {
1539                     	switch	.text
1540  0489               f_detect_negative_zero_cross:
1542  0489 5204          	subw	sp,#4
1543       00000004      OFST:	set	4
1546                     ; 164 	float hyst = 0.5;
1548                     ; 165 	return (previous_sample > threshold && current_sample <= threshold);
1550  048b 9c            	rvf
1551  048c 96            	ldw	x,sp
1552  048d 1c0008        	addw	x,#OFST+4
1553  0490 8d000000      	callf	d_ltor
1555  0494 96            	ldw	x,sp
1556  0495 1c0010        	addw	x,#OFST+12
1557  0498 8d000000      	callf	d_fcmp
1559  049c 2d17          	jrsle	L43
1560  049e 9c            	rvf
1561  049f 96            	ldw	x,sp
1562  04a0 1c000c        	addw	x,#OFST+8
1563  04a3 8d000000      	callf	d_ltor
1565  04a7 96            	ldw	x,sp
1566  04a8 1c0010        	addw	x,#OFST+12
1567  04ab 8d000000      	callf	d_fcmp
1569  04af 2c04          	jrsgt	L43
1570  04b1 a601          	ld	a,#1
1571  04b3 2001          	jra	L63
1572  04b5               L43:
1573  04b5 4f            	clr	a
1574  04b6               L63:
1577  04b6 5b04          	addw	sp,#4
1578  04b8 87            	retf
1626                     ; 168 bool check_negative_zero_crossing(void) {
1627                     	switch	.text
1628  04b9               f_check_negative_zero_crossing:
1630  04b9 5208          	subw	sp,#8
1631       00000008      OFST:	set	8
1634                     ; 169 	float prev_adc_value = 0;  // Store previous ADC sample value
1636  04bb ae0000        	ldw	x,#0
1637  04be 1f03          	ldw	(OFST-5,sp),x
1638  04c0 ae0000        	ldw	x,#0
1639  04c3 1f01          	ldw	(OFST-7,sp),x
1641                     ; 170 	float current_adc_value = 0;  // Store current ADC sample value
1643  04c5               L775:
1644                     ; 174 		current_adc_value = convert_adc_to_voltage(read_ADC_Channel(VAR_SIGNAL));
1646  04c5 a605          	ld	a,#5
1647  04c7 8d000000      	callf	f_read_ADC_Channel
1649  04cb 8d4e084e      	callf	f_convert_adc_to_voltage
1651  04cf 96            	ldw	x,sp
1652  04d0 1c0005        	addw	x,#OFST-3
1653  04d3 8d000000      	callf	d_rtol
1656                     ; 176 		if (detect_negative_zero_cross(prev_adc_value, current_adc_value, ZEROCROSS_THRESHOLD)) {
1658  04d7 ce11a2        	ldw	x,L116+2
1659  04da 89            	pushw	x
1660  04db ce11a0        	ldw	x,L116
1661  04de 89            	pushw	x
1662  04df 1e0b          	ldw	x,(OFST+3,sp)
1663  04e1 89            	pushw	x
1664  04e2 1e0b          	ldw	x,(OFST+3,sp)
1665  04e4 89            	pushw	x
1666  04e5 1e0b          	ldw	x,(OFST+3,sp)
1667  04e7 89            	pushw	x
1668  04e8 1e0b          	ldw	x,(OFST+3,sp)
1669  04ea 89            	pushw	x
1670  04eb 8d890489      	callf	f_detect_negative_zero_cross
1672  04ef 5b0c          	addw	sp,#12
1673  04f1 4d            	tnz	a
1674  04f2 270c          	jreq	L306
1675                     ; 178 			printf(" Negative zero crossing detected!\n");
1677  04f4 ae117d        	ldw	x,#L516
1678  04f7 8d000000      	callf	f_printf
1680                     ; 179 			return true;
1682  04fb a601          	ld	a,#1
1685  04fd 5b08          	addw	sp,#8
1686  04ff 87            	retf
1687  0500               L306:
1688                     ; 182 		prev_adc_value = current_adc_value;
1690  0500 1e07          	ldw	x,(OFST-1,sp)
1691  0502 1f03          	ldw	(OFST-5,sp),x
1692  0504 1e05          	ldw	x,(OFST-3,sp)
1693  0506 1f01          	ldw	(OFST-7,sp),x
1696  0508 20bb          	jra	L775
1767                     ; 188 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
1768                     	switch	.text
1769  050a               f_calculate_amplitude:
1771  050a 89            	pushw	x
1772  050b 520c          	subw	sp,#12
1773       0000000c      OFST:	set	12
1776                     ; 189 	uint32_t i = 0;
1778                     ; 190 	float max_val = -V_REF, min_val = V_REF;
1780  050d ce1177        	ldw	x,L166+2
1781  0510 1f03          	ldw	(OFST-9,sp),x
1782  0512 ce1175        	ldw	x,L166
1783  0515 1f01          	ldw	(OFST-11,sp),x
1787  0517 ce117b        	ldw	x,L176+2
1788  051a 1f07          	ldw	(OFST-5,sp),x
1789  051c ce1179        	ldw	x,L176
1790  051f 1f05          	ldw	(OFST-7,sp),x
1792                     ; 192 	for (i = 0; i < sample_size; i++) {
1794  0521 ae0000        	ldw	x,#0
1795  0524 1f0b          	ldw	(OFST-1,sp),x
1796  0526 ae0000        	ldw	x,#0
1797  0529 1f09          	ldw	(OFST-3,sp),x
1800  052b 2058          	jra	L107
1801  052d               L576:
1802                     ; 193 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1804  052d 9c            	rvf
1805  052e 1e0b          	ldw	x,(OFST-1,sp)
1806  0530 58            	sllw	x
1807  0531 58            	sllw	x
1808  0532 72fb0d        	addw	x,(OFST+1,sp)
1809  0535 8d000000      	callf	d_ltor
1811  0539 96            	ldw	x,sp
1812  053a 1c0001        	addw	x,#OFST-11
1813  053d 8d000000      	callf	d_fcmp
1815  0541 2d11          	jrsle	L507
1818  0543 1e0b          	ldw	x,(OFST-1,sp)
1819  0545 58            	sllw	x
1820  0546 58            	sllw	x
1821  0547 72fb0d        	addw	x,(OFST+1,sp)
1822  054a 9093          	ldw	y,x
1823  054c ee02          	ldw	x,(2,x)
1824  054e 1f03          	ldw	(OFST-9,sp),x
1825  0550 93            	ldw	x,y
1826  0551 fe            	ldw	x,(x)
1827  0552 1f01          	ldw	(OFST-11,sp),x
1829  0554               L507:
1830                     ; 194 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1832  0554 9c            	rvf
1833  0555 1e0b          	ldw	x,(OFST-1,sp)
1834  0557 58            	sllw	x
1835  0558 58            	sllw	x
1836  0559 72fb0d        	addw	x,(OFST+1,sp)
1837  055c 8d000000      	callf	d_ltor
1839  0560 96            	ldw	x,sp
1840  0561 1c0005        	addw	x,#OFST-7
1841  0564 8d000000      	callf	d_fcmp
1843  0568 2e11          	jrsge	L707
1846  056a 1e0b          	ldw	x,(OFST-1,sp)
1847  056c 58            	sllw	x
1848  056d 58            	sllw	x
1849  056e 72fb0d        	addw	x,(OFST+1,sp)
1850  0571 9093          	ldw	y,x
1851  0573 ee02          	ldw	x,(2,x)
1852  0575 1f07          	ldw	(OFST-5,sp),x
1853  0577 93            	ldw	x,y
1854  0578 fe            	ldw	x,(x)
1855  0579 1f05          	ldw	(OFST-7,sp),x
1857  057b               L707:
1858                     ; 192 	for (i = 0; i < sample_size; i++) {
1860  057b 96            	ldw	x,sp
1861  057c 1c0009        	addw	x,#OFST-3
1862  057f a601          	ld	a,#1
1863  0581 8d000000      	callf	d_lgadc
1866  0585               L107:
1869  0585 96            	ldw	x,sp
1870  0586 1c0009        	addw	x,#OFST-3
1871  0589 8d000000      	callf	d_ltor
1873  058d 96            	ldw	x,sp
1874  058e 1c0012        	addw	x,#OFST+6
1875  0591 8d000000      	callf	d_lcmp
1877  0595 2596          	jrult	L576
1878                     ; 197 	return (max_val - min_val);
1880  0597 96            	ldw	x,sp
1881  0598 1c0001        	addw	x,#OFST-11
1882  059b 8d000000      	callf	d_ltor
1884  059f 96            	ldw	x,sp
1885  05a0 1c0005        	addw	x,#OFST-7
1886  05a3 8d000000      	callf	d_fsub
1890  05a7 5b0e          	addw	sp,#14
1891  05a9 87            	retf
1935                     ; 201 void initialize_adc_buffer(float buffer[]) {
1936                     	switch	.text
1937  05aa               f_initialize_adc_buffer:
1939  05aa 89            	pushw	x
1940  05ab 89            	pushw	x
1941       00000002      OFST:	set	2
1944                     ; 202 	uint16_t i = 0;
1946                     ; 203 	for (i = 0; i < NUM_SAMPLES; i++) {
1948  05ac 5f            	clrw	x
1949  05ad 1f01          	ldw	(OFST-1,sp),x
1951  05af               L337:
1952                     ; 204 		buffer[i] = -1;  // Reset each element of the ADC buffer
1954  05af 1e01          	ldw	x,(OFST-1,sp)
1955  05b1 58            	sllw	x
1956  05b2 58            	sllw	x
1957  05b3 72fb03        	addw	x,(OFST+1,sp)
1958  05b6 90aeffff      	ldw	y,#65535
1959  05ba 51            	exgw	x,y
1960  05bb 8d000000      	callf	d_itof
1962  05bf 51            	exgw	x,y
1963  05c0 8d000000      	callf	d_rtol
1965                     ; 203 	for (i = 0; i < NUM_SAMPLES; i++) {
1967  05c4 1e01          	ldw	x,(OFST-1,sp)
1968  05c6 1c0001        	addw	x,#1
1969  05c9 1f01          	ldw	(OFST-1,sp),x
1973  05cb 1e01          	ldw	x,(OFST-1,sp)
1974  05cd a30400        	cpw	x,#1024
1975  05d0 25dd          	jrult	L337
1976                     ; 206 }
1979  05d2 5b04          	addw	sp,#4
1980  05d4 87            	retf
1982                     .const:	section	.text
1983  0000               L147_buffer:
1984  0000 00000000      	dc.w	0,0
1985  0004 000000000000  	ds.b	4092
2120                     ; 208 float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
2121                     	switch	.text
2122  05d5               f_process_adc_signal:
2124  05d5 88            	push	a
2125  05d6 96            	ldw	x,sp
2126  05d7 1d1021        	subw	x,#4129
2127  05da 94            	ldw	sp,x
2128       00001021      OFST:	set	4129
2131                     ; 209 	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
2133  05db 96            	ldw	x,sp
2134  05dc 1c001e        	addw	x,#OFST-4099
2135  05df 90ae0000      	ldw	y,#L147_buffer
2136  05e3 bf00          	ldw	c_x,x
2137  05e5 ae1000        	ldw	x,#4096
2138  05e8 8d000000      	callf	d_xymovl
2140                     ; 210 	unsigned long currentEdgeTime = 0;
2142                     ; 211 	float freqBuff = 0;
2144  05ec ae0000        	ldw	x,#0
2145  05ef 1f17          	ldw	(OFST-4106,sp),x
2146  05f1 ae0000        	ldw	x,#0
2147  05f4 1f15          	ldw	(OFST-4108,sp),x
2149                     ; 212 	int freqCount = 0;
2151  05f6 96            	ldw	x,sp
2152  05f7 905f          	clrw	y
2153  05f9 df101e        	ldw	(OFST-3,x),y
2154                     ; 213 	uint16_t i = 0;
2156                     ; 214 	bool isChannel1 = (channel == VAR_SIGNAL);  // Check if the channel is for Signal 1 or Signal 2
2158  05fc 96            	ldw	x,sp
2159  05fd d61022        	ld	a,(OFST+1,x)
2160  0600 a105          	cp	a,#5
2161  0602 2605          	jrne	L05
2162  0604 ae0001        	ldw	x,#1
2163  0607 2001          	jra	L25
2164  0609               L05:
2165  0609 5f            	clrw	x
2166  060a               L25:
2167  060a 01            	rrwa	x,a
2168  060b 6b1d          	ld	(OFST-4100,sp),a
2169  060d 02            	rlwa	x,a
2171                     ; 215 	lastEdgeTime = 0;                 // Reset last zero-crossing time
2173  060e ae0000        	ldw	x,#0
2174  0611 bf0a          	ldw	_lastEdgeTime+2,x
2175  0613 ae0000        	ldw	x,#0
2176  0616 bf08          	ldw	_lastEdgeTime,x
2177                     ; 220 	for (i = 0; i < NUM_SAMPLES; i++) {
2179  0618 96            	ldw	x,sp
2180  0619 905f          	clrw	y
2181  061b df1020        	ldw	(OFST-1,x),y
2182  061e               L1301:
2183                     ; 222 	buffer[i] = convert_adc_to_voltage(read_ADC_Channel(channel));
2185  061e 96            	ldw	x,sp
2186  061f d61022        	ld	a,(OFST+1,x)
2187  0622 8d000000      	callf	f_read_ADC_Channel
2189  0626 8d4e084e      	callf	f_convert_adc_to_voltage
2191  062a 96            	ldw	x,sp
2192  062b 1c001e        	addw	x,#OFST-4099
2193  062e 1f0f          	ldw	(OFST-4114,sp),x
2195  0630 96            	ldw	x,sp
2196  0631 de1020        	ldw	x,(OFST-1,x)
2197  0634 58            	sllw	x
2198  0635 58            	sllw	x
2199  0636 72fb0f        	addw	x,(OFST-4114,sp)
2200  0639 8d000000      	callf	d_rtol
2202                     ; 224 	if (isChannel1 && (frequency != NULL)) { // Only calculate frequency for Signal 1 (Channel 1)
2204  063d 0d1d          	tnz	(OFST-4100,sp)
2205  063f 2604          	jrne	L66
2206  0641 ac900790      	jpf	L7301
2207  0645               L66:
2209  0645 96            	ldw	x,sp
2210  0646 d61027        	ld	a,(OFST+6,x)
2211  0649 da1026        	or	a,(OFST+5,x)
2212  064c 2604          	jrne	L07
2213  064e ac900790      	jpf	L7301
2214  0652               L07:
2215                     ; 226 		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
2217  0652 96            	ldw	x,sp
2218  0653 d61021        	ld	a,(OFST+0,x)
2219  0656 da1020        	or	a,(OFST-1,x)
2220  0659 2604          	jrne	L27
2221  065b ac900790      	jpf	L7301
2222  065f               L27:
2224  065f ce11a2        	ldw	x,L116+2
2225  0662 89            	pushw	x
2226  0663 ce11a0        	ldw	x,L116
2227  0666 89            	pushw	x
2228  0667 96            	ldw	x,sp
2229  0668 1c0022        	addw	x,#OFST-4095
2230  066b 1f13          	ldw	(OFST-4110,sp),x
2232  066d 96            	ldw	x,sp
2233  066e de1024        	ldw	x,(OFST+3,x)
2234  0671 58            	sllw	x
2235  0672 58            	sllw	x
2236  0673 72fb13        	addw	x,(OFST-4110,sp)
2237  0676 9093          	ldw	y,x
2238  0678 ee02          	ldw	x,(2,x)
2239  067a 89            	pushw	x
2240  067b 93            	ldw	x,y
2241  067c fe            	ldw	x,(x)
2242  067d 89            	pushw	x
2243  067e 96            	ldw	x,sp
2244  067f 1c0026        	addw	x,#OFST-4091
2245  0682 1f15          	ldw	(OFST-4108,sp),x
2247  0684 96            	ldw	x,sp
2248  0685 de1028        	ldw	x,(OFST+7,x)
2249  0688 58            	sllw	x
2250  0689 58            	sllw	x
2251  068a 1d0004        	subw	x,#4
2252  068d 72fb15        	addw	x,(OFST-4108,sp)
2253  0690 9093          	ldw	y,x
2254  0692 ee02          	ldw	x,(2,x)
2255  0694 89            	pushw	x
2256  0695 93            	ldw	x,y
2257  0696 fe            	ldw	x,(x)
2258  0697 89            	pushw	x
2259  0698 8d9d039d      	callf	f_detectZeroCross
2261  069c 5b0c          	addw	sp,#12
2262  069e 4d            	tnz	a
2263  069f 2604          	jrne	L47
2264  06a1 ac900790      	jpf	L7301
2265  06a5               L47:
2266                     ; 227 			currentEdgeTime = micros();
2268  06a5 8d000000      	callf	f_micros
2270  06a9 96            	ldw	x,sp
2271  06aa 1c0019        	addw	x,#OFST-4104
2272  06ad 8d000000      	callf	d_rtol
2275                     ; 228 			if (lastEdgeTime > 0) {  // Zero-crossing detected; calculate period and frequency
2277  06b1 ae0008        	ldw	x,#_lastEdgeTime
2278  06b4 8d000000      	callf	d_lzmp
2280  06b8 2604          	jrne	L67
2281  06ba ac880788      	jpf	L3401
2282  06be               L67:
2283                     ; 229 				unsigned long period = currentEdgeTime - lastEdgeTime;  // Period in microseconds
2285  06be 96            	ldw	x,sp
2286  06bf 1c0019        	addw	x,#OFST-4104
2287  06c2 8d000000      	callf	d_ltor
2289  06c6 ae0008        	ldw	x,#_lastEdgeTime
2290  06c9 8d000000      	callf	d_lsub
2292  06cd 96            	ldw	x,sp
2293  06ce 1c0011        	addw	x,#OFST-4112
2294  06d1 8d000000      	callf	d_rtol
2297                     ; 230 				float singleFrequency = calculate_frequency(period);   // Calculate frequency in Hz
2299  06d5 1e13          	ldw	x,(OFST-4110,sp)
2300  06d7 89            	pushw	x
2301  06d8 1e13          	ldw	x,(OFST-4110,sp)
2302  06da 89            	pushw	x
2303  06db 8d5a085a      	callf	f_calculate_frequency
2305  06df 5b04          	addw	sp,#4
2306  06e1 96            	ldw	x,sp
2307  06e2 1c0011        	addw	x,#OFST-4112
2308  06e5 8d000000      	callf	d_rtol
2311                     ; 232 				freqCount++;
2313  06e9 96            	ldw	x,sp
2314  06ea 9093          	ldw	y,x
2315  06ec de101e        	ldw	x,(OFST-3,x)
2316  06ef 1c0001        	addw	x,#1
2317  06f2 90df101e      	ldw	(OFST-3,y),x
2318                     ; 234 				if (freqCount == 2) {  // Stop after detecting 2 zero-crossings
2320  06f6 96            	ldw	x,sp
2321  06f7 9093          	ldw	y,x
2322  06f9 90de101e      	ldw	y,(OFST-3,y)
2323  06fd 90a30002      	cpw	y,#2
2324  0701 26b7          	jrne	L3401
2325                     ; 235 					count = i;  // Limit used for amplitude calculation within this range
2327  0703 96            	ldw	x,sp
2328  0704 de1020        	ldw	x,(OFST-1,x)
2329  0707 bf12          	ldw	_count,x
2330                     ; 237 					*amplitude = calculate_amplitude(buffer, (freqCount > 0 ? count : NUM_SAMPLES));
2332  0709 9c            	rvf
2333  070a 5f            	clrw	x
2334  070b 1f0f          	ldw	(OFST-4114,sp),x
2336  070d 96            	ldw	x,sp
2337  070e 9093          	ldw	y,x
2338  0710 51            	exgw	x,y
2339  0711 de101e        	ldw	x,(OFST-3,x)
2340  0714 130f          	cpw	x,(OFST-4114,sp)
2341  0716 51            	exgw	x,y
2342  0717 2d04          	jrsle	L45
2343  0719 be12          	ldw	x,_count
2344  071b 2003          	jra	L65
2345  071d               L45:
2346  071d ae0400        	ldw	x,#1024
2347  0720               L65:
2348  0720 8d000000      	callf	d_uitolx
2350  0724 be02          	ldw	x,c_lreg+2
2351  0726 89            	pushw	x
2352  0727 be00          	ldw	x,c_lreg
2353  0729 89            	pushw	x
2354  072a 96            	ldw	x,sp
2355  072b 1c0022        	addw	x,#OFST-4095
2356  072e 8d0a050a      	callf	f_calculate_amplitude
2358  0732 5b04          	addw	sp,#4
2359  0734 96            	ldw	x,sp
2360  0735 de1028        	ldw	x,(OFST+7,x)
2361  0738 8d000000      	callf	d_rtol
2363                     ; 240 					if (isChannel1 && freqCount > 0) {
2365  073c 0d1d          	tnz	(OFST-4100,sp)
2366  073e 2725          	jreq	L7401
2368  0740 9c            	rvf
2369  0741 5f            	clrw	x
2370  0742 1f0f          	ldw	(OFST-4114,sp),x
2372  0744 96            	ldw	x,sp
2373  0745 9093          	ldw	y,x
2374  0747 51            	exgw	x,y
2375  0748 de101e        	ldw	x,(OFST-3,x)
2376  074b 130f          	cpw	x,(OFST-4114,sp)
2377  074d 51            	exgw	x,y
2378  074e 2d15          	jrsle	L7401
2379                     ; 241 						*frequency = singleFrequency;  // Calculate average frequency
2381  0750 96            	ldw	x,sp
2382  0751 de1026        	ldw	x,(OFST+5,x)
2383  0754 7b14          	ld	a,(OFST-4109,sp)
2384  0756 e703          	ld	(3,x),a
2385  0758 7b13          	ld	a,(OFST-4110,sp)
2386  075a e702          	ld	(2,x),a
2387  075c 7b12          	ld	a,(OFST-4111,sp)
2388  075e e701          	ld	(1,x),a
2389  0760 7b11          	ld	a,(OFST-4112,sp)
2390  0762 f7            	ld	(x),a
2392  0763 2017          	jra	L1501
2393  0765               L7401:
2394                     ; 243 					else if (isChannel1) {
2396  0765 0d1d          	tnz	(OFST-4100,sp)
2397  0767 2713          	jreq	L1501
2398                     ; 244 						*frequency = 0;  // No crossings detected, return 0 frequency
2400  0769 96            	ldw	x,sp
2401  076a de1026        	ldw	x,(OFST+5,x)
2402  076d a600          	ld	a,#0
2403  076f e703          	ld	(3,x),a
2404  0771 a600          	ld	a,#0
2405  0773 e702          	ld	(2,x),a
2406  0775 a600          	ld	a,#0
2407  0777 e701          	ld	(1,x),a
2408  0779 a600          	ld	a,#0
2409  077b f7            	ld	(x),a
2410  077c               L1501:
2411                     ; 246 					return *amplitude;
2413  077c 96            	ldw	x,sp
2414  077d de1028        	ldw	x,(OFST+7,x)
2415  0780 8d000000      	callf	d_ltor
2418  0784 ac450845      	jpf	L46
2419  0788               L3401:
2420                     ; 249 			lastEdgeTime = currentEdgeTime;  // Update last edge time
2422  0788 1e1b          	ldw	x,(OFST-4102,sp)
2423  078a bf0a          	ldw	_lastEdgeTime+2,x
2424  078c 1e19          	ldw	x,(OFST-4104,sp)
2425  078e bf08          	ldw	_lastEdgeTime,x
2426  0790               L7301:
2427                     ; 254 	delay_us(1000000 / SAMPLE_RATE);
2429  0790 ae1a0a        	ldw	x,#6666
2430  0793 8d000000      	callf	f_delay_us
2432                     ; 220 	for (i = 0; i < NUM_SAMPLES; i++) {
2434  0797 96            	ldw	x,sp
2435  0798 9093          	ldw	y,x
2436  079a de1020        	ldw	x,(OFST-1,x)
2437  079d 1c0001        	addw	x,#1
2438  07a0 90df1020      	ldw	(OFST-1,y),x
2441  07a4 96            	ldw	x,sp
2442  07a5 9093          	ldw	y,x
2443  07a7 90de1020      	ldw	y,(OFST-1,y)
2444  07ab 90a30400      	cpw	y,#1024
2445  07af 2404          	jruge	L001
2446  07b1 ac1e061e      	jpf	L1301
2447  07b5               L001:
2448                     ; 259 	*amplitude = calculate_amplitude(buffer, (freqCount > 0 ? count : NUM_SAMPLES));
2450  07b5 9c            	rvf
2451  07b6 5f            	clrw	x
2452  07b7 1f0f          	ldw	(OFST-4114,sp),x
2454  07b9 96            	ldw	x,sp
2455  07ba 9093          	ldw	y,x
2456  07bc 51            	exgw	x,y
2457  07bd de101e        	ldw	x,(OFST-3,x)
2458  07c0 130f          	cpw	x,(OFST-4114,sp)
2459  07c2 51            	exgw	x,y
2460  07c3 2d04          	jrsle	L06
2461  07c5 be12          	ldw	x,_count
2462  07c7 2003          	jra	L26
2463  07c9               L06:
2464  07c9 ae0400        	ldw	x,#1024
2465  07cc               L26:
2466  07cc 8d000000      	callf	d_uitolx
2468  07d0 be02          	ldw	x,c_lreg+2
2469  07d2 89            	pushw	x
2470  07d3 be00          	ldw	x,c_lreg
2471  07d5 89            	pushw	x
2472  07d6 96            	ldw	x,sp
2473  07d7 1c0022        	addw	x,#OFST-4095
2474  07da 8d0a050a      	callf	f_calculate_amplitude
2476  07de 5b04          	addw	sp,#4
2477  07e0 96            	ldw	x,sp
2478  07e1 de1028        	ldw	x,(OFST+7,x)
2479  07e4 8d000000      	callf	d_rtol
2481                     ; 262 	if (isChannel1 && freqCount > 0) {
2483  07e8 0d1d          	tnz	(OFST-4100,sp)
2484  07ea 273a          	jreq	L5501
2486  07ec 9c            	rvf
2487  07ed 5f            	clrw	x
2488  07ee 1f0f          	ldw	(OFST-4114,sp),x
2490  07f0 96            	ldw	x,sp
2491  07f1 9093          	ldw	y,x
2492  07f3 51            	exgw	x,y
2493  07f4 de101e        	ldw	x,(OFST-3,x)
2494  07f7 130f          	cpw	x,(OFST-4114,sp)
2495  07f9 51            	exgw	x,y
2496  07fa 2d2a          	jrsle	L5501
2497                     ; 263 		*frequency = freqBuff / freqCount;  // Calculate average frequency
2499  07fc 96            	ldw	x,sp
2500  07fd de101e        	ldw	x,(OFST-3,x)
2501  0800 8d000000      	callf	d_itof
2503  0804 96            	ldw	x,sp
2504  0805 1c000d        	addw	x,#OFST-4116
2505  0808 8d000000      	callf	d_rtol
2508  080c 96            	ldw	x,sp
2509  080d 1c0015        	addw	x,#OFST-4108
2510  0810 8d000000      	callf	d_ltor
2512  0814 96            	ldw	x,sp
2513  0815 1c000d        	addw	x,#OFST-4116
2514  0818 8d000000      	callf	d_fdiv
2516  081c 96            	ldw	x,sp
2517  081d de1026        	ldw	x,(OFST+5,x)
2518  0820 8d000000      	callf	d_rtol
2521  0824 2017          	jra	L7501
2522  0826               L5501:
2523                     ; 265 	else if (isChannel1) {
2525  0826 0d1d          	tnz	(OFST-4100,sp)
2526  0828 2713          	jreq	L7501
2527                     ; 266 		*frequency = 0;  // No crossings detected, return 0 frequency
2529  082a 96            	ldw	x,sp
2530  082b de1026        	ldw	x,(OFST+5,x)
2531  082e a600          	ld	a,#0
2532  0830 e703          	ld	(3,x),a
2533  0832 a600          	ld	a,#0
2534  0834 e702          	ld	(2,x),a
2535  0836 a600          	ld	a,#0
2536  0838 e701          	ld	(1,x),a
2537  083a a600          	ld	a,#0
2538  083c f7            	ld	(x),a
2539  083d               L7501:
2540                     ; 269 	return *amplitude;  // Always return amplitude
2542  083d 96            	ldw	x,sp
2543  083e de1028        	ldw	x,(OFST+7,x)
2544  0841 8d000000      	callf	d_ltor
2547  0845               L46:
2549  0845 9096          	ldw	y,sp
2550  0847 72a91022      	addw	y,#4130
2551  084b 9094          	ldw	sp,y
2552  084d 87            	retf
2586                     ; 273 float convert_adc_to_voltage(unsigned int adcValue) {
2587                     	switch	.text
2588  084e               f_convert_adc_to_voltage:
2592                     ; 274 	return adcValue * (V_REF / ADC_MAX_VALUE);
2594  084e 8d000000      	callf	d_uitof
2596  0852 ae1171        	ldw	x,#L5011
2597  0855 8d000000      	callf	d_fmul
2601  0859 87            	retf
2635                     ; 278 float calculate_frequency(unsigned long period) {
2636                     	switch	.text
2637  085a               f_calculate_frequency:
2639  085a 5204          	subw	sp,#4
2640       00000004      OFST:	set	4
2643                     ; 279 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
2645  085c 96            	ldw	x,sp
2646  085d 1c0008        	addw	x,#OFST+4
2647  0860 8d000000      	callf	d_ltor
2649  0864 8d000000      	callf	d_ultof
2651  0868 ae1169        	ldw	x,#L3411
2652  086b 8d000000      	callf	d_fdiv
2654  086f 96            	ldw	x,sp
2655  0870 1c0001        	addw	x,#OFST-3
2656  0873 8d000000      	callf	d_rtol
2659  0877 ae116d        	ldw	x,#L3311
2660  087a 8d000000      	callf	d_ltor
2662  087e 96            	ldw	x,sp
2663  087f 1c0001        	addw	x,#OFST-3
2664  0882 8d000000      	callf	d_fdiv
2668  0886 5b04          	addw	sp,#4
2669  0888 87            	retf
2733                     ; 283 void output_results(float frequency, float amplitude, float FDR_Voltage) {
2734                     	switch	.text
2735  0889               f_output_results:
2737  0889 5228          	subw	sp,#40
2738       00000028      OFST:	set	40
2741                     ; 287 	sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,0\n", frequency, amplitude, amplitude/4.7, FDR_Voltage);
2743  088b 1e36          	ldw	x,(OFST+14,sp)
2744  088d 89            	pushw	x
2745  088e 1e36          	ldw	x,(OFST+14,sp)
2746  0890 89            	pushw	x
2747  0891 96            	ldw	x,sp
2748  0892 1c0034        	addw	x,#OFST+12
2749  0895 8d000000      	callf	d_ltor
2751  0899 ae12ca        	ldw	x,#L571
2752  089c 8d000000      	callf	d_fdiv
2754  08a0 be02          	ldw	x,c_lreg+2
2755  08a2 89            	pushw	x
2756  08a3 be00          	ldw	x,c_lreg
2757  08a5 89            	pushw	x
2758  08a6 1e3a          	ldw	x,(OFST+18,sp)
2759  08a8 89            	pushw	x
2760  08a9 1e3a          	ldw	x,(OFST+18,sp)
2761  08ab 89            	pushw	x
2762  08ac 1e3a          	ldw	x,(OFST+18,sp)
2763  08ae 89            	pushw	x
2764  08af 1e3a          	ldw	x,(OFST+18,sp)
2765  08b1 89            	pushw	x
2766  08b2 ae1152        	ldw	x,#L1021
2767  08b5 89            	pushw	x
2768  08b6 96            	ldw	x,sp
2769  08b7 1c0013        	addw	x,#OFST-21
2770  08ba 8d000000      	callf	f_sprintf
2772  08be 5b12          	addw	sp,#18
2773                     ; 290 	printf("%s", buffer);
2775  08c0 96            	ldw	x,sp
2776  08c1 1c0001        	addw	x,#OFST-39
2777  08c4 89            	pushw	x
2778  08c5 ae12c7        	ldw	x,#L102
2779  08c8 8d000000      	callf	f_printf
2781  08cc 85            	popw	x
2782                     ; 291 	UART1_SendString(buffer);
2784  08cd 96            	ldw	x,sp
2785  08ce 1c0001        	addw	x,#OFST-39
2786  08d1 8d000000      	callf	f_UART1_SendString
2788                     ; 293 }
2791  08d5 5b28          	addw	sp,#40
2792  08d7 87            	retf
2849                     ; 296 void logResults(const char *logMessage) {
2850                     	switch	.text
2851  08d8               f_logResults:
2853  08d8 89            	pushw	x
2854  08d9 5278          	subw	sp,#120
2855       00000078      OFST:	set	120
2858                     ; 301 	sprintDateTime(datetimeBuffer);
2860  08db 96            	ldw	x,sp
2861  08dc 1c0001        	addw	x,#OFST-119
2862  08df 8d000000      	callf	f_sprintDateTime
2864                     ; 304 	sprintf(logBuffer, "%s - %s", datetimeBuffer, logMessage);
2866  08e3 1e79          	ldw	x,(OFST+1,sp)
2867  08e5 89            	pushw	x
2868  08e6 96            	ldw	x,sp
2869  08e7 1c0003        	addw	x,#OFST-117
2870  08ea 89            	pushw	x
2871  08eb ae114a        	ldw	x,#L1321
2872  08ee 89            	pushw	x
2873  08ef 96            	ldw	x,sp
2874  08f0 1c001b        	addw	x,#OFST-93
2875  08f3 8d000000      	callf	f_sprintf
2877  08f7 5b06          	addw	sp,#6
2878                     ; 305 	log_to_eeprom(logBuffer);
2880  08f9 96            	ldw	x,sp
2881  08fa 1c0015        	addw	x,#OFST-99
2882  08fd 8d000000      	callf	f_log_to_eeprom
2884                     ; 307 }
2887  0901 5b7a          	addw	sp,#122
2888  0903 87            	retf
2924                     ; 310 void send_square_pulse(uint16_t duration_ms) {
2925                     	switch	.text
2926  0904               f_send_square_pulse:
2928  0904 89            	pushw	x
2929       00000000      OFST:	set	0
2932                     ; 311 	GPIO_WriteHigh(SER_THYRISTOR); // Set square pulse pin high
2934  0905 4b04          	push	#4
2935  0907 ae500a        	ldw	x,#20490
2936  090a 8d000000      	callf	f_GPIO_WriteHigh
2938  090e 84            	pop	a
2939                     ; 312 	delay_ms(duration_ms);            // Wait for the pulse duration
2941  090f 1e01          	ldw	x,(OFST+1,sp)
2942  0911 8d000000      	callf	f_delay_ms
2944                     ; 313 	GPIO_WriteLow(SER_THYRISTOR); // Set square pulse pin low
2946  0915 4b04          	push	#4
2947  0917 ae500a        	ldw	x,#20490
2948  091a 8d000000      	callf	f_GPIO_WriteLow
2950  091e 84            	pop	a
2951                     ; 314 }
2954  091f 85            	popw	x
2955  0920 87            	retf
2982                     ; 316 void handle_commutation_pulse(void) {
2983                     	switch	.text
2984  0921               f_handle_commutation_pulse:
2988                     ; 317 	GPIO_WriteHigh(COM_THYRISTOR); // Set square pulse pin high
2990  0921 4b02          	push	#2
2991  0923 ae500a        	ldw	x,#20490
2992  0926 8d000000      	callf	f_GPIO_WriteHigh
2994  092a 84            	pop	a
2995                     ; 318 	delay_ms(3000);            // Wait for the pulse duration
2997  092b ae0bb8        	ldw	x,#3000
2998  092e 8d000000      	callf	f_delay_ms
3000                     ; 319 	GPIO_WriteLow(COM_THYRISTOR); // Set square pulse pin low
3002  0932 4b02          	push	#2
3003  0934 ae500a        	ldw	x,#20490
3004  0937 8d000000      	callf	f_GPIO_WriteLow
3006  093b 84            	pop	a
3007                     ; 320 	GPIO_WriteHigh(LED_ORANGE); // Turn on LED ORANGE
3009  093c 4b08          	push	#8
3010  093e ae500f        	ldw	x,#20495
3011  0941 8d000000      	callf	f_GPIO_WriteHigh
3013  0945 84            	pop	a
3014                     ; 321 	printf("Commutation Thyristor Pulse Sent\n");
3016  0946 ae1128        	ldw	x,#L1621
3017  0949 8d000000      	callf	f_printf
3019                     ; 322 }
3022  094d 87            	retf
3058                     ; 324 bool check_FDR_amplitude(void) {
3059                     	switch	.text
3060  094e               f_check_FDR_amplitude:
3062  094e 5204          	subw	sp,#4
3063       00000004      OFST:	set	4
3066                     ; 325     float FDR_amplitude = 0;
3068  0950 ae0000        	ldw	x,#0
3069  0953 1f03          	ldw	(OFST-1,sp),x
3070  0955 ae0000        	ldw	x,#0
3071  0958 1f01          	ldw	(OFST-3,sp),x
3073                     ; 326     FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
3075  095a 96            	ldw	x,sp
3076  095b 1c0001        	addw	x,#OFST-3
3077  095e 89            	pushw	x
3078  095f 5f            	clrw	x
3079  0960 89            	pushw	x
3080  0961 a606          	ld	a,#6
3081  0963 8dd505d5      	callf	f_process_adc_signal
3083  0967 5b04          	addw	sp,#4
3084  0969 96            	ldw	x,sp
3085  096a 1c0001        	addw	x,#OFST-3
3086  096d 8d000000      	callf	d_rtol
3089                     ; 327     return (FDR_amplitude != 0); // Returns true if FDR_amplitude is non-zero
3091  0971 9c            	rvf
3092  0972 0d01          	tnz	(OFST-3,sp)
3093  0974 2704          	jreq	L021
3094  0976 a601          	ld	a,#1
3095  0978 2001          	jra	L221
3096  097a               L021:
3097  097a 4f            	clr	a
3098  097b               L221:
3101  097b 5b04          	addw	sp,#4
3102  097d 87            	retf
3137                     ; 331 bool check_signal_dc(float amplitude) {
3138                     	switch	.text
3139  097e               f_check_signal_dc:
3141       00000000      OFST:	set	0
3144                     ; 332 	if (amplitude < 0.5) {
3146  097e 9c            	rvf
3147  097f 96            	ldw	x,sp
3148  0980 1c0004        	addw	x,#OFST+4
3149  0983 8d000000      	callf	d_ltor
3151  0987 ae11a4        	ldw	x,#L155
3152  098a 8d000000      	callf	d_fcmp
3154  098e 2e07          	jrsge	L7131
3155                     ; 333 		isThyristorON = true;
3157  0990 35010014      	mov	_isThyristorON,#1
3158                     ; 334 		return true;
3160  0994 a601          	ld	a,#1
3163  0996 87            	retf
3164  0997               L7131:
3165                     ; 336 		isThyristorON = false;
3167  0997 3f14          	clr	_isThyristorON
3168                     ; 337 		return false;
3170  0999 4f            	clr	a
3173  099a 87            	retf
3220                     ; 341 void read_set_frequency(float *set_freq) {
3221                     	switch	.text
3222  099b               f_read_set_frequency:
3224  099b 89            	pushw	x
3225  099c 521e          	subw	sp,#30
3226       0000001e      OFST:	set	30
3229                     ; 343 	internal_EEPROM_ReadStr(0x4000, setFreqString,  sizeof(setFreqString));
3231  099e ae001e        	ldw	x,#30
3232  09a1 89            	pushw	x
3233  09a2 96            	ldw	x,sp
3234  09a3 1c0003        	addw	x,#OFST-27
3235  09a6 89            	pushw	x
3236  09a7 ae4000        	ldw	x,#16384
3237  09aa 89            	pushw	x
3238  09ab ae0000        	ldw	x,#0
3239  09ae 89            	pushw	x
3240  09af 8d030b03      	callf	f_internal_EEPROM_ReadStr
3242  09b3 5b08          	addw	sp,#8
3243                     ; 344 	printf("String read from EEPROM: %s\n\r", setFreqString);
3245  09b5 96            	ldw	x,sp
3246  09b6 1c0001        	addw	x,#OFST-29
3247  09b9 89            	pushw	x
3248  09ba ae110a        	ldw	x,#L5431
3249  09bd 8d000000      	callf	f_printf
3251  09c1 85            	popw	x
3252                     ; 345 	*set_freq = ConvertStringToFloat(setFreqString);
3254  09c2 96            	ldw	x,sp
3255  09c3 1c0001        	addw	x,#OFST-29
3256  09c6 8d000000      	callf	f_ConvertStringToFloat
3258  09ca 1e1f          	ldw	x,(OFST+1,sp)
3259  09cc 8d000000      	callf	d_rtol
3261                     ; 346 	printf("New set_freq: %f\n", *set_freq);
3263  09d0 1e1f          	ldw	x,(OFST+1,sp)
3264  09d2 9093          	ldw	y,x
3265  09d4 ee02          	ldw	x,(2,x)
3266  09d6 89            	pushw	x
3267  09d7 93            	ldw	x,y
3268  09d8 fe            	ldw	x,(x)
3269  09d9 89            	pushw	x
3270  09da ae10f8        	ldw	x,#L7431
3271  09dd 8d000000      	callf	f_printf
3273  09e1 5b04          	addw	sp,#4
3274                     ; 347 }
3277  09e3 5b20          	addw	sp,#32
3278  09e5 87            	retf
3329                     ; 349 void  config_mode(void){
3330                     	switch	.text
3331  09e6               f_config_mode:
3333  09e6 522c          	subw	sp,#44
3334       0000002c      OFST:	set	44
3337                     ; 351   float value = 0;
3339  09e8               L3731:
3340                     ; 356 		if (GPIO_ReadInputPin(GPIOA, GPIO_PIN_6) == RESET) {
3342  09e8 4b40          	push	#64
3343  09ea ae5000        	ldw	x,#20480
3344  09ed 8d000000      	callf	f_GPIO_ReadInputPin
3346  09f1 5b01          	addw	sp,#1
3347  09f3 4d            	tnz	a
3348  09f4 2603          	jrne	L7731
3349                     ; 358 			return;
3352  09f6 5b2c          	addw	sp,#44
3353  09f8 87            	retf
3354  09f9               L7731:
3355                     ; 361 		printf("Entering Config Mode!\n");
3357  09f9 ae10e1        	ldw	x,#L1041
3358  09fc 8d000000      	callf	f_printf
3360                     ; 362 		printf("Enter the Command!\n");
3362  0a00 ae10cd        	ldw	x,#L3041
3363  0a03 8d000000      	callf	f_printf
3365                     ; 363 		UART3_ClearBuffer();
3367  0a07 8d000000      	callf	f_UART3_ClearBuffer
3369                     ; 364 		UART3_ReceiveString(buffer, sizeof(buffer)); // Receive the first string via UART
3371  0a0b ae0028        	ldw	x,#40
3372  0a0e 89            	pushw	x
3373  0a0f 96            	ldw	x,sp
3374  0a10 1c0007        	addw	x,#OFST-37
3375  0a13 8d000000      	callf	f_UART3_ReceiveString
3377  0a17 85            	popw	x
3378                     ; 366 		if (strcmp(buffer, "set") == 0) {
3380  0a18 ae10c9        	ldw	x,#L7041
3381  0a1b 89            	pushw	x
3382  0a1c 96            	ldw	x,sp
3383  0a1d 1c0007        	addw	x,#OFST-37
3384  0a20 8d000000      	callf	f_strcmp
3386  0a24 5b02          	addw	sp,#2
3387  0a26 a30000        	cpw	x,#0
3388  0a29 265e          	jrne	L5041
3389                     ; 368 			printf("SET Command Received. Waiting for new parameter...\n");
3391  0a2b ae1095        	ldw	x,#L1141
3392  0a2e 8d000000      	callf	f_printf
3394                     ; 369 			UART3_ReceiveString(buffer, sizeof(buffer)); // Receive the parameter string
3396  0a32 ae0028        	ldw	x,#40
3397  0a35 89            	pushw	x
3398  0a36 96            	ldw	x,sp
3399  0a37 1c0007        	addw	x,#OFST-37
3400  0a3a 8d000000      	callf	f_UART3_ReceiveString
3402  0a3e 85            	popw	x
3403                     ; 370 			printf("New Parameter: %s\n", buffer);
3405  0a3f 96            	ldw	x,sp
3406  0a40 1c0005        	addw	x,#OFST-39
3407  0a43 89            	pushw	x
3408  0a44 ae1082        	ldw	x,#L3141
3409  0a47 8d000000      	callf	f_printf
3411  0a4b 85            	popw	x
3412                     ; 371 			value = ConvertStringToFloat(buffer);
3414  0a4c 96            	ldw	x,sp
3415  0a4d 1c0005        	addw	x,#OFST-39
3416  0a50 8d000000      	callf	f_ConvertStringToFloat
3418  0a54 96            	ldw	x,sp
3419  0a55 1c0001        	addw	x,#OFST-43
3420  0a58 8d000000      	callf	d_rtol
3423                     ; 372 			printf("Value: %f\n", value);
3425  0a5c 1e03          	ldw	x,(OFST-41,sp)
3426  0a5e 89            	pushw	x
3427  0a5f 1e03          	ldw	x,(OFST-41,sp)
3428  0a61 89            	pushw	x
3429  0a62 ae1077        	ldw	x,#L5141
3430  0a65 8d000000      	callf	f_printf
3432  0a69 5b04          	addw	sp,#4
3433                     ; 374 			internal_EEPROM_WriteStr(0x4000, buffer); // Example address for storing string
3435  0a6b 96            	ldw	x,sp
3436  0a6c 1c0005        	addw	x,#OFST-39
3437  0a6f 89            	pushw	x
3438  0a70 ae4000        	ldw	x,#16384
3439  0a73 89            	pushw	x
3440  0a74 ae0000        	ldw	x,#0
3441  0a77 89            	pushw	x
3442  0a78 8dc30ac3      	callf	f_internal_EEPROM_WriteStr
3444  0a7c 5b06          	addw	sp,#6
3445                     ; 375 			printf("success\n");
3447  0a7e ae106e        	ldw	x,#L7141
3448  0a81 8d000000      	callf	f_printf
3451  0a85 ace809e8      	jpf	L3731
3452  0a89               L5041:
3453                     ; 377 		} else if (strcmp(buffer, "read") == 0) {
3455  0a89 ae1069        	ldw	x,#L5241
3456  0a8c 89            	pushw	x
3457  0a8d 96            	ldw	x,sp
3458  0a8e 1c0007        	addw	x,#OFST-37
3459  0a91 8d000000      	callf	f_strcmp
3461  0a95 5b02          	addw	sp,#2
3462  0a97 a30000        	cpw	x,#0
3463  0a9a 2616          	jrne	L3241
3464                     ; 379 			printf("READ Command Received. Reading stored values...\n");
3466  0a9c ae1038        	ldw	x,#L7241
3467  0a9f 8d000000      	callf	f_printf
3469                     ; 381 			process_eeprom_logs(); // Example EEPROM address
3471  0aa3 8d000000      	callf	f_process_eeprom_logs
3473                     ; 382 			printf("Finished Reading EEPROM!\n");
3475  0aa7 ae101e        	ldw	x,#L1341
3476  0aaa 8d000000      	callf	f_printf
3479  0aae ace809e8      	jpf	L3731
3480  0ab2               L3241:
3481                     ; 386 			printf("Invalid Command Received: %s\n", buffer);
3483  0ab2 96            	ldw	x,sp
3484  0ab3 1c0005        	addw	x,#OFST-39
3485  0ab6 89            	pushw	x
3486  0ab7 ae1000        	ldw	x,#L5341
3487  0aba 8d000000      	callf	f_printf
3489  0abe 85            	popw	x
3490  0abf ace809e8      	jpf	L3731
3535                     ; 391 void internal_EEPROM_WriteStr(uint32_t address, char *str) {
3536                     	switch	.text
3537  0ac3               f_internal_EEPROM_WriteStr:
3539       00000000      OFST:	set	0
3542  0ac3 202a          	jra	L3641
3543  0ac5               L1641:
3544                     ; 393 		FLASH_ProgramByte(address++, (uint8_t)(*str++));
3546  0ac5 1e08          	ldw	x,(OFST+8,sp)
3547  0ac7 1c0001        	addw	x,#1
3548  0aca 1f08          	ldw	(OFST+8,sp),x
3549  0acc 1d0001        	subw	x,#1
3550  0acf f6            	ld	a,(x)
3551  0ad0 88            	push	a
3552  0ad1 96            	ldw	x,sp
3553  0ad2 1c0005        	addw	x,#OFST+5
3554  0ad5 8d000000      	callf	d_ltor
3556  0ad9 96            	ldw	x,sp
3557  0ada 1c0005        	addw	x,#OFST+5
3558  0add a601          	ld	a,#1
3559  0adf 8d000000      	callf	d_lgadc
3561  0ae3 be02          	ldw	x,c_lreg+2
3562  0ae5 89            	pushw	x
3563  0ae6 be00          	ldw	x,c_lreg
3564  0ae8 89            	pushw	x
3565  0ae9 8d000000      	callf	f_FLASH_ProgramByte
3567  0aed 5b05          	addw	sp,#5
3568  0aef               L3641:
3569                     ; 392 	while (*str) {
3571  0aef 1e08          	ldw	x,(OFST+8,sp)
3572  0af1 7d            	tnz	(x)
3573  0af2 26d1          	jrne	L1641
3574                     ; 395 	FLASH_ProgramByte(address, '\0'); // Write a null terminator
3576  0af4 4b00          	push	#0
3577  0af6 1e07          	ldw	x,(OFST+7,sp)
3578  0af8 89            	pushw	x
3579  0af9 1e07          	ldw	x,(OFST+7,sp)
3580  0afb 89            	pushw	x
3581  0afc 8d000000      	callf	f_FLASH_ProgramByte
3583  0b00 5b05          	addw	sp,#5
3584                     ; 396 }
3587  0b02 87            	retf
3659                     ; 398 void internal_EEPROM_ReadStr(uint32_t address, char *buffer, uint16_t max_length) {
3660                     	switch	.text
3661  0b03               f_internal_EEPROM_ReadStr:
3663  0b03 5203          	subw	sp,#3
3664       00000003      OFST:	set	3
3667                     ; 399 	uint16_t i = 0;
3669  0b05 5f            	clrw	x
3670  0b06 1f01          	ldw	(OFST-2,sp),x
3673  0b08 203d          	jra	L1351
3674  0b0a               L5251:
3675                     ; 403 		c = (char)FLASH_ReadByte(address++); // Read a byte
3677  0b0a 96            	ldw	x,sp
3678  0b0b 1c0007        	addw	x,#OFST+4
3679  0b0e 8d000000      	callf	d_ltor
3681  0b12 96            	ldw	x,sp
3682  0b13 1c0007        	addw	x,#OFST+4
3683  0b16 a601          	ld	a,#1
3684  0b18 8d000000      	callf	d_lgadc
3686  0b1c be02          	ldw	x,c_lreg+2
3687  0b1e 89            	pushw	x
3688  0b1f be00          	ldw	x,c_lreg
3689  0b21 89            	pushw	x
3690  0b22 8d000000      	callf	f_FLASH_ReadByte
3692  0b26 5b04          	addw	sp,#4
3693  0b28 6b03          	ld	(OFST+0,sp),a
3695                     ; 404 		if (c == '\0') {
3697  0b2a 0d03          	tnz	(OFST+0,sp)
3698  0b2c 2609          	jrne	L5351
3699                     ; 405 				break; // Stop if null terminator is encountered
3700  0b2e               L3351:
3701                     ; 409 	buffer[i] = '\0'; // Null-terminate the string
3703  0b2e 1e0b          	ldw	x,(OFST+8,sp)
3704  0b30 72fb01        	addw	x,(OFST-2,sp)
3705  0b33 7f            	clr	(x)
3706                     ; 410 }
3709  0b34 5b03          	addw	sp,#3
3710  0b36 87            	retf
3711  0b37               L5351:
3712                     ; 407 		buffer[i++] = c; // Store the character in the buffer
3714  0b37 7b03          	ld	a,(OFST+0,sp)
3715  0b39 1e01          	ldw	x,(OFST-2,sp)
3716  0b3b 1c0001        	addw	x,#1
3717  0b3e 1f01          	ldw	(OFST-2,sp),x
3718  0b40 1d0001        	subw	x,#1
3720  0b43 72fb0b        	addw	x,(OFST+8,sp)
3721  0b46 f7            	ld	(x),a
3722  0b47               L1351:
3723                     ; 402 	while (i < max_length - 1) {
3725  0b47 1e0d          	ldw	x,(OFST+10,sp)
3726  0b49 5a            	decw	x
3727  0b4a 1301          	cpw	x,(OFST-2,sp)
3728  0b4c 22bc          	jrugt	L5251
3729  0b4e 20de          	jra	L3351
3752                     	xdef	f_main
3753                     	xdef	_set_freq
3754                     	xdef	f_internal_EEPROM_WriteStr
3755                     	xdef	f_internal_EEPROM_ReadStr
3756                     	xdef	f_handle_commutation_pulse
3757                     	xdef	f_check_FDR_amplitude
3758                     	xdef	f_handle_signal_1_AC
3759                     	xdef	f_wait_for_negative_zero_crossing
3760                     	xdef	f_handle_Frequency_Below_Set_Freq
3761                     	xdef	f_process_VAR_signal
3762                     	xdef	f_process_FDR_signal
3763                     	xdef	f_logResults
3764                     	xdef	f_config_mode
3765                     	xdef	f_read_set_frequency
3766                     	xdef	f_calculate_frequency
3767                     	xdef	f_convert_adc_to_voltage
3768                     	xdef	f_process_adc_signal
3769                     	xdef	f_calculate_amplitude
3770                     	xdef	f_output_results
3771                     	xdef	f_initialize_adc_buffer
3772                     	xdef	f_check_signal_dc
3773                     	xdef	f_send_square_pulse
3774                     	xdef	f_check_negative_zero_crossing
3775                     	xdef	f_detect_negative_zero_cross
3776                     	xdef	f_detectZeroCross
3777                     	xdef	f_detectPosZeroCross
3778                     	xdef	f_initialize_system
3779                     	xdef	_isThyristorON
3780                     	xdef	_count
3781                     	xdef	_crossingType
3782                     	xdef	_currentEdgeTime
3783                     	xdef	_lastEdgeTime
3784                     	xdef	_sine1_amplitude
3785                     	xdef	_sine1_frequency
3786                     	xref	f_ConvertStringToFloat
3787                     	xref	f_sprintDateTime
3788                     	xref	f_read_ADC_Channel
3789                     	xref	f_UART1_SendString
3790                     	xref	f_UART1_setup
3791                     	xref	f_UART3_ReceiveString
3792                     	xref	f_UART3_ClearBuffer
3793                     	xref	f_internal_EEPROM_Setup
3794                     	xref	f_GPIO_setup
3795                     	xref	f_ADC2_setup
3796                     	xref	f_UART3_setup
3797                     	xref	f_clock_setup
3798                     	xref	f_FLASH_ReadByte
3799                     	xref	f_FLASH_ProgramByte
3800                     	xref	f_I2CInit
3801                     	xref	f_log_to_eeprom
3802                     	xref	f_process_eeprom_logs
3803                     	xref	f_EEPROM_Config
3804                     	xref	f_strcmp
3805                     	xref	f_micros
3806                     	xref	f_delay_us
3807                     	xref	f_delay_ms
3808                     	xref	f_TIM4_Config
3809                     	xref	f_sprintf
3810                     	xref	f_printf
3811                     	xref	f_GPIO_ReadInputPin
3812                     	xref	f_GPIO_WriteLow
3813                     	xref	f_GPIO_WriteHigh
3814                     	switch	.const
3815  1000               L5341:
3816  1000 496e76616c69  	dc.b	"Invalid Command Re"
3817  1012 636569766564  	dc.b	"ceived: %s",10,0
3818  101e               L1341:
3819  101e 46696e697368  	dc.b	"Finished Reading E"
3820  1030 4550524f4d21  	dc.b	"EPROM!",10,0
3821  1038               L7241:
3822  1038 524541442043  	dc.b	"READ Command Recei"
3823  104a 7665642e2052  	dc.b	"ved. Reading store"
3824  105c 642076616c75  	dc.b	"d values...",10,0
3825  1069               L5241:
3826  1069 7265616400    	dc.b	"read",0
3827  106e               L7141:
3828  106e 737563636573  	dc.b	"success",10,0
3829  1077               L5141:
3830  1077 56616c75653a  	dc.b	"Value: %f",10,0
3831  1082               L3141:
3832  1082 4e6577205061  	dc.b	"New Parameter: %s",10,0
3833  1095               L1141:
3834  1095 53455420436f  	dc.b	"SET Command Receiv"
3835  10a7 65642e205761  	dc.b	"ed. Waiting for ne"
3836  10b9 772070617261  	dc.b	"w parameter...",10,0
3837  10c9               L7041:
3838  10c9 73657400      	dc.b	"set",0
3839  10cd               L3041:
3840  10cd 456e74657220  	dc.b	"Enter the Command!"
3841  10df 0a00          	dc.b	10,0
3842  10e1               L1041:
3843  10e1 456e74657269  	dc.b	"Entering Config Mo"
3844  10f3 6465210a00    	dc.b	"de!",10,0
3845  10f8               L7431:
3846  10f8 4e6577207365  	dc.b	"New set_freq: %f",10,0
3847  110a               L5431:
3848  110a 537472696e67  	dc.b	"String read from E"
3849  111c 4550524f4d3a  	dc.b	"EPROM: %s",10
3850  1126 0d00          	dc.b	13,0
3851  1128               L1621:
3852  1128 436f6d6d7574  	dc.b	"Commutation Thyris"
3853  113a 746f72205075  	dc.b	"tor Pulse Sent",10,0
3854  114a               L1321:
3855  114a 2573202d2025  	dc.b	"%s - %s",0
3856  1152               L1021:
3857  1152 252e33662c25  	dc.b	"%.3f,%.3f,%.3f,%.3"
3858  1164 662c300a00    	dc.b	"f,0",10,0
3859  1169               L3411:
3860  1169 49742400      	dc.w	18804,9216
3861  116d               L3311:
3862  116d 3f800000      	dc.w	16256,0
3863  1171               L5011:
3864  1171 3b933333      	dc.w	15251,13107
3865  1175               L166:
3866  1175 c0933333      	dc.w	-16237,13107
3867  1179               L176:
3868  1179 40933333      	dc.w	16531,13107
3869  117d               L516:
3870  117d 204e65676174  	dc.b	" Negative zero cro"
3871  118f 7373696e6720  	dc.b	"ssing detected!",10,0
3872  11a0               L116:
3873  11a0 3f8ccccc      	dc.w	16268,-13108
3874  11a4               L155:
3875  11a4 3f000000      	dc.w	16128,0
3876  11a8               L504:
3877  11a8 566172416d70  	dc.b	"VarAmplitude Not b"
3878  11ba 656c6f772031  	dc.b	"elow 10 mv.",10,0
3879  11c7               L304:
3880  11c7 25302e303030  	dc.b	"%0.000,%.3f,%.3f,%"
3881  11d9 2e33662c310a  	dc.b	".3f,1",10,0
3882  11e0               L773:
3883  11e0 566172416d70  	dc.b	"VarAmplitude below"
3884  11f2 203130206d76  	dc.b	" 10 mv.",10,0
3885  11fb               L373:
3886  11fb 3c23d70a      	dc.w	15395,-10486
3887  11ff               L143:
3888  11ff 5369676e616c  	dc.b	"Signal 1 AC and Va"
3889  1211 72416d706c69  	dc.b	"rAmplitude: %f.",10,0
3890  1222               L533:
3891  1222 5369676e616c  	dc.b	"Signal 1 DC.",10,0
3892  1230               L133:
3893  1230 53656e64696e  	dc.b	"Sending Square Pul"
3894  1242 73652e0a00    	dc.b	"se.",10,0
3895  1247               L762:
3896  1247 252e33662c25  	dc.b	"%.3f,%.3f,%.3f,%.3"
3897  1259 662c310a00    	dc.b	"f,1",10,0
3898  125e               L562:
3899  125e 467265717565  	dc.b	"Frequency Below Se"
3900  1270 742046726571  	dc.b	"t Frequency.",10,0
3901  127e               L162:
3902  127e 40a00000      	dc.w	16544,0
3903  1282               L152:
3904  1282 204672657175  	dc.b	" Frequency: %.3f, "
3905  1294 416d706c6974  	dc.b	"Amplitude: %.3f, C"
3906  12a6 757272656e74  	dc.b	"urrent: %.3f, FDR_"
3907  12b8 566f6c746167  	dc.b	"Voltage: %.3f",10,0
3908  12c7               L102:
3909  12c7 257300        	dc.b	"%s",0
3910  12ca               L571:
3911  12ca 40966666      	dc.w	16534,26214
3912  12ce               L761:
3913  12ce 302e3030302c  	dc.b	"0.000,%.3f,%.3f,%."
3914  12e0 33662c310a00  	dc.b	"3f,1",10,0
3915  12e6               L331:
3916  12e6 53797374656d  	dc.b	"System Initializat"
3917  12f8 696f6e20436f  	dc.b	"ion Completed",10
3918  1306 0d00          	dc.b	13,0
3919  1308               L121:
3920  1308 46445220566f  	dc.b	"FDR Voltage Exists"
3921  131a 0a00          	dc.b	10,0
3922  131c               L701:
3923  131c 00000000      	dc.w	0,0
3924                     	xref.b	c_lreg
3925                     	xref.b	c_x
3926                     	xref.b	c_y
3946                     	xref	d_ultof
3947                     	xref	d_fmul
3948                     	xref	d_uitof
3949                     	xref	d_uitolx
3950                     	xref	d_lsub
3951                     	xref	d_lzmp
3952                     	xref	d_xymovl
3953                     	xref	d_itof
3954                     	xref	d_fsub
3955                     	xref	d_lcmp
3956                     	xref	d_lgadc
3957                     	xref	d_fcmp
3958                     	xref	d_fdiv
3959                     	xref	d_ltor
3960                     	xref	d_rtol
3961                     	end
