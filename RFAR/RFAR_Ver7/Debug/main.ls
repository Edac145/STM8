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
 182                     ; 13 void main() {
 183                     	switch	.text
 184  0000               f_main:
 186  0000 5204          	subw	sp,#4
 187       00000004      OFST:	set	4
 190                     ; 14   float FDR_amplitude = 0.0;
 192  0002 ce1303        	ldw	x,L701+2
 193  0005 1f03          	ldw	(OFST-1,sp),x
 194  0007 ce1301        	ldw	x,L701
 195  000a 1f01          	ldw	(OFST-3,sp),x
 197                     ; 16 	initialize_system();
 199  000c 8d5d005d      	callf	f_initialize_system
 201                     ; 18 	read_set_frequency(&set_freq);
 203  0010 ae0015        	ldw	x,#_set_freq
 204  0013 8d970997      	callf	f_read_set_frequency
 206  0017               L311:
 207                     ; 21 		FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
 209  0017 96            	ldw	x,sp
 210  0018 1c0001        	addw	x,#OFST-3
 211  001b 89            	pushw	x
 212  001c 5f            	clrw	x
 213  001d 89            	pushw	x
 214  001e a606          	ld	a,#6
 215  0020 8dd105d1      	callf	f_process_adc_signal
 217  0024 5b04          	addw	sp,#4
 218  0026 96            	ldw	x,sp
 219  0027 1c0001        	addw	x,#OFST-3
 220  002a 8d000000      	callf	d_rtol
 223                     ; 23 		if (FDR_amplitude > 0) { // Voltage detected on Signal 2
 225  002e 9c            	rvf
 226  002f 9c            	rvf
 227  0030 0d01          	tnz	(OFST-3,sp)
 228  0032 2de3          	jrsle	L311
 229                     ; 24 		  printf("FDR Voltage Exists\n");
 231  0034 ae12ed        	ldw	x,#L121
 232  0037 8d000000      	callf	f_printf
 234                     ; 25 		  GPIO_WriteHigh(LED_RED); // Turn on LED
 236  003b 4b08          	push	#8
 237  003d ae5000        	ldw	x,#20480
 238  0040 8d000000      	callf	f_GPIO_WriteHigh
 240  0044 84            	pop	a
 241                     ; 26 			GPIO_WriteHigh(GPIOD, GPIO_PIN_4);
 243  0045 4b10          	push	#16
 244  0047 ae500f        	ldw	x,#20495
 245  004a 8d000000      	callf	f_GPIO_WriteHigh
 247  004e 84            	pop	a
 248                     ; 27 			process_VAR_signal(FDR_amplitude); // Handle Signal 1
 250  004f 1e03          	ldw	x,(OFST-1,sp)
 251  0051 89            	pushw	x
 252  0052 1e03          	ldw	x,(OFST-1,sp)
 253  0054 89            	pushw	x
 254  0055 8d240124      	callf	f_process_VAR_signal
 256  0059 5b04          	addw	sp,#4
 257  005b 20ba          	jra	L311
 289                     ; 33 void initialize_system(void) {
 290                     	switch	.text
 291  005d               f_initialize_system:
 295                     ; 34 	clock_setup();          // Configure system clock
 297  005d 8d000000      	callf	f_clock_setup
 299                     ; 35 	TIM4_Config();          // Timer 4 config for delay
 301  0061 8d000000      	callf	f_TIM4_Config
 303                     ; 36 	GPIO_setup();
 305  0065 8d000000      	callf	f_GPIO_setup
 307                     ; 37 	UART3_setup();          // Setup UART communication
 309  0069 8d000000      	callf	f_UART3_setup
 311                     ; 38 	UART1_setup();
 313  006d 8d000000      	callf	f_UART1_setup
 315                     ; 39 	ADC2_setup();						// Setup ADC
 317  0071 8d000000      	callf	f_ADC2_setup
 319                     ; 40 	EEPROM_Config();        // Configuring EEPROM
 321  0075 8d000000      	callf	f_EEPROM_Config
 323                     ; 41 	I2CInit();  // for Configuring RTC
 325  0079 8d000000      	callf	f_I2CInit
 327                     ; 42 	internal_EEPROM_Setup();
 329  007d 8d000000      	callf	f_internal_EEPROM_Setup
 331                     ; 43 	printf("System Initialization Completed\n\r");
 333  0081 ae12cb        	ldw	x,#L331
 334  0084 8d000000      	callf	f_printf
 336                     ; 44 }
 339  0088 87            	retf
 396                     ; 46 float process_FDR_signal(void) {
 397                     	switch	.text
 398  0089               f_process_FDR_signal:
 400  0089 5230          	subw	sp,#48
 401       00000030      OFST:	set	48
 404                     ; 47 	float FDR_amplitude = 0, VAR_amplitude = 0;
 406  008b ae0000        	ldw	x,#0
 407  008e 1f2b          	ldw	(OFST-5,sp),x
 408  0090 ae0000        	ldw	x,#0
 409  0093 1f29          	ldw	(OFST-7,sp),x
 413  0095 ae0000        	ldw	x,#0
 414  0098 1f2f          	ldw	(OFST-1,sp),x
 415  009a ae0000        	ldw	x,#0
 416  009d 1f2d          	ldw	(OFST-3,sp),x
 418  009f               L361:
 419                     ; 50 		VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
 421  009f 96            	ldw	x,sp
 422  00a0 1c002d        	addw	x,#OFST-3
 423  00a3 89            	pushw	x
 424  00a4 5f            	clrw	x
 425  00a5 89            	pushw	x
 426  00a6 a605          	ld	a,#5
 427  00a8 8dd105d1      	callf	f_process_adc_signal
 429  00ac 5b04          	addw	sp,#4
 430  00ae 96            	ldw	x,sp
 431  00af 1c002d        	addw	x,#OFST-3
 432  00b2 8d000000      	callf	d_rtol
 435                     ; 51 		FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
 437  00b6 96            	ldw	x,sp
 438  00b7 1c0029        	addw	x,#OFST-7
 439  00ba 89            	pushw	x
 440  00bb 5f            	clrw	x
 441  00bc 89            	pushw	x
 442  00bd a606          	ld	a,#6
 443  00bf 8dd105d1      	callf	f_process_adc_signal
 445  00c3 5b04          	addw	sp,#4
 446  00c5 96            	ldw	x,sp
 447  00c6 1c0029        	addw	x,#OFST-7
 448  00c9 8d000000      	callf	d_rtol
 451                     ; 52     sprintf(buffer, "0.000,%.3f,%.3f,%.3f,1\n", VAR_amplitude, VAR_amplitude/4.7, FDR_amplitude);
 453  00cd 1e2b          	ldw	x,(OFST-5,sp)
 454  00cf 89            	pushw	x
 455  00d0 1e2b          	ldw	x,(OFST-5,sp)
 456  00d2 89            	pushw	x
 457  00d3 96            	ldw	x,sp
 458  00d4 1c0031        	addw	x,#OFST+1
 459  00d7 8d000000      	callf	d_ltor
 461  00db ae12af        	ldw	x,#L571
 462  00de 8d000000      	callf	d_fdiv
 464  00e2 be02          	ldw	x,c_lreg+2
 465  00e4 89            	pushw	x
 466  00e5 be00          	ldw	x,c_lreg
 467  00e7 89            	pushw	x
 468  00e8 1e37          	ldw	x,(OFST+7,sp)
 469  00ea 89            	pushw	x
 470  00eb 1e37          	ldw	x,(OFST+7,sp)
 471  00ed 89            	pushw	x
 472  00ee ae12b3        	ldw	x,#L761
 473  00f1 89            	pushw	x
 474  00f2 96            	ldw	x,sp
 475  00f3 1c000f        	addw	x,#OFST-33
 476  00f6 8d000000      	callf	f_sprintf
 478  00fa 5b0e          	addw	sp,#14
 479                     ; 53 	  printf("%s", buffer);
 481  00fc 96            	ldw	x,sp
 482  00fd 1c0001        	addw	x,#OFST-47
 483  0100 89            	pushw	x
 484  0101 ae12ac        	ldw	x,#L102
 485  0104 8d000000      	callf	f_printf
 487  0108 85            	popw	x
 488                     ; 54 		if ((FDR_amplitude > 0) && (VAR_amplitude > 0)) {
 490  0109 9c            	rvf
 491  010a 9c            	rvf
 492  010b 0d29          	tnz	(OFST-7,sp)
 493  010d 2d90          	jrsle	L361
 495  010f 9c            	rvf
 496  0110 9c            	rvf
 497  0111 0d2d          	tnz	(OFST-3,sp)
 498  0113 2d8a          	jrsle	L361
 499  0115               L502:
 500                     ; 56 				handle_commutation_pulse(); // Execute the pulse sending
 502  0115 8d1d091d      	callf	f_handle_commutation_pulse
 504                     ; 57 			} while (check_FDR_amplitude()); // Repeat if FDR_amplitude is still non-zero
 506  0119 8d4a094a      	callf	f_check_FDR_amplitude
 508  011d 4d            	tnz	a
 509  011e 26f5          	jrne	L502
 510  0120 ac9f009f      	jpf	L361
 576                     ; 63 void process_VAR_signal(float FDR_amplitude) {
 577                     	switch	.text
 578  0124               f_process_VAR_signal:
 580  0124 5230          	subw	sp,#48
 581       00000030      OFST:	set	48
 584                     ; 64 	float VAR_frequency = 0.0, VAR_amplitude = 0.0;
 586  0126 ce1303        	ldw	x,L701+2
 587  0129 1f2b          	ldw	(OFST-5,sp),x
 588  012b ce1301        	ldw	x,L701
 589  012e 1f29          	ldw	(OFST-7,sp),x
 593  0130 ce1303        	ldw	x,L701+2
 594  0133 1f2f          	ldw	(OFST-1,sp),x
 595  0135 ce1301        	ldw	x,L701
 596  0138 1f2d          	ldw	(OFST-3,sp),x
 598  013a               L542:
 599                     ; 67 		VAR_amplitude = process_adc_signal(VAR_SIGNAL, &VAR_frequency, &VAR_amplitude);
 601  013a 96            	ldw	x,sp
 602  013b 1c002d        	addw	x,#OFST-3
 603  013e 89            	pushw	x
 604  013f 96            	ldw	x,sp
 605  0140 1c002b        	addw	x,#OFST-5
 606  0143 89            	pushw	x
 607  0144 a605          	ld	a,#5
 608  0146 8dd105d1      	callf	f_process_adc_signal
 610  014a 5b04          	addw	sp,#4
 611  014c 96            	ldw	x,sp
 612  014d 1c002d        	addw	x,#OFST-3
 613  0150 8d000000      	callf	d_rtol
 616                     ; 71 		printf(" Frequency: %.3f, Amplitude: %.3f, Current: %.3f, FDR_Voltage: %.3f\n",
 616                     ; 72 					 VAR_frequency, VAR_amplitude, VAR_amplitude / 4.7, FDR_amplitude);
 618  0154 1e36          	ldw	x,(OFST+6,sp)
 619  0156 89            	pushw	x
 620  0157 1e36          	ldw	x,(OFST+6,sp)
 621  0159 89            	pushw	x
 622  015a 96            	ldw	x,sp
 623  015b 1c0031        	addw	x,#OFST+1
 624  015e 8d000000      	callf	d_ltor
 626  0162 ae12af        	ldw	x,#L571
 627  0165 8d000000      	callf	d_fdiv
 629  0169 be02          	ldw	x,c_lreg+2
 630  016b 89            	pushw	x
 631  016c be00          	ldw	x,c_lreg
 632  016e 89            	pushw	x
 633  016f 1e37          	ldw	x,(OFST+7,sp)
 634  0171 89            	pushw	x
 635  0172 1e37          	ldw	x,(OFST+7,sp)
 636  0174 89            	pushw	x
 637  0175 1e37          	ldw	x,(OFST+7,sp)
 638  0177 89            	pushw	x
 639  0178 1e37          	ldw	x,(OFST+7,sp)
 640  017a 89            	pushw	x
 641  017b ae1267        	ldw	x,#L152
 642  017e 8d000000      	callf	f_printf
 644  0182 5b10          	addw	sp,#16
 645                     ; 74 		output_results(VAR_frequency, VAR_amplitude, FDR_amplitude);
 647  0184 1e36          	ldw	x,(OFST+6,sp)
 648  0186 89            	pushw	x
 649  0187 1e36          	ldw	x,(OFST+6,sp)
 650  0189 89            	pushw	x
 651  018a 1e33          	ldw	x,(OFST+3,sp)
 652  018c 89            	pushw	x
 653  018d 1e33          	ldw	x,(OFST+3,sp)
 654  018f 89            	pushw	x
 655  0190 1e33          	ldw	x,(OFST+3,sp)
 656  0192 89            	pushw	x
 657  0193 1e33          	ldw	x,(OFST+3,sp)
 658  0195 89            	pushw	x
 659  0196 8d850885      	callf	f_output_results
 661  019a 5b0c          	addw	sp,#12
 662                     ; 76 		if (VAR_frequency <= SET_FREQ) {
 664  019c 9c            	rvf
 665  019d 96            	ldw	x,sp
 666  019e 1c0029        	addw	x,#OFST-7
 667  01a1 8d000000      	callf	d_ltor
 669  01a5 ae1263        	ldw	x,#L162
 670  01a8 8d000000      	callf	d_fcmp
 672  01ac 2c8c          	jrsgt	L542
 673                     ; 78 			printf("Frequency Below Set Frequency.\n");
 675  01ae ae1243        	ldw	x,#L562
 676  01b1 8d000000      	callf	f_printf
 678                     ; 80 			sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,1\n", VAR_frequency, VAR_amplitude, VAR_amplitude/4.7, FDR_amplitude);
 680  01b5 1e36          	ldw	x,(OFST+6,sp)
 681  01b7 89            	pushw	x
 682  01b8 1e36          	ldw	x,(OFST+6,sp)
 683  01ba 89            	pushw	x
 684  01bb 96            	ldw	x,sp
 685  01bc 1c0031        	addw	x,#OFST+1
 686  01bf 8d000000      	callf	d_ltor
 688  01c3 ae12af        	ldw	x,#L571
 689  01c6 8d000000      	callf	d_fdiv
 691  01ca be02          	ldw	x,c_lreg+2
 692  01cc 89            	pushw	x
 693  01cd be00          	ldw	x,c_lreg
 694  01cf 89            	pushw	x
 695  01d0 1e37          	ldw	x,(OFST+7,sp)
 696  01d2 89            	pushw	x
 697  01d3 1e37          	ldw	x,(OFST+7,sp)
 698  01d5 89            	pushw	x
 699  01d6 1e37          	ldw	x,(OFST+7,sp)
 700  01d8 89            	pushw	x
 701  01d9 1e37          	ldw	x,(OFST+7,sp)
 702  01db 89            	pushw	x
 703  01dc ae122c        	ldw	x,#L762
 704  01df 89            	pushw	x
 705  01e0 96            	ldw	x,sp
 706  01e1 1c0013        	addw	x,#OFST-29
 707  01e4 8d000000      	callf	f_sprintf
 709  01e8 5b12          	addw	sp,#18
 710                     ; 81 			printf("%s", buffer);
 712  01ea 96            	ldw	x,sp
 713  01eb 1c0001        	addw	x,#OFST-47
 714  01ee 89            	pushw	x
 715  01ef ae12ac        	ldw	x,#L102
 716  01f2 8d000000      	callf	f_printf
 718  01f6 85            	popw	x
 719                     ; 82 			handle_Frequency_Below_Set_Freq(VAR_amplitude);
 721  01f7 1e2f          	ldw	x,(OFST-1,sp)
 722  01f9 89            	pushw	x
 723  01fa 1e2f          	ldw	x,(OFST-1,sp)
 724  01fc 89            	pushw	x
 725  01fd 8d0f020f      	callf	f_handle_Frequency_Below_Set_Freq
 727  0201 5b04          	addw	sp,#4
 728  0203 ac3a013a      	jpf	L542
 752                     ; 87 void wait_for_negative_zero_crossing(void) {
 753                     	switch	.text
 754  0207               f_wait_for_negative_zero_crossing:
 758  0207               L303:
 759                     ; 88 	while (!check_negative_zero_crossing()) {
 761  0207 8db504b5      	callf	f_check_negative_zero_crossing
 763  020b 4d            	tnz	a
 764  020c 27f9          	jreq	L303
 765                     ; 92 }
 768  020e 87            	retf
 821                     ; 94 void handle_Frequency_Below_Set_Freq(float VAR_amplitude) {
 822                     	switch	.text
 823  020f               f_handle_Frequency_Below_Set_Freq:
 825  020f 5228          	subw	sp,#40
 826       00000028      OFST:	set	40
 829                     ; 96 	wait_for_negative_zero_crossing();
 831  0211 8d070207      	callf	f_wait_for_negative_zero_crossing
 833                     ; 97 	printf("Sending Square Pulse.\n");
 835  0215 ae1215        	ldw	x,#L133
 836  0218 8d000000      	callf	f_printf
 838                     ; 98 	send_square_pulse(5);
 840  021c ae0005        	ldw	x,#5
 841  021f 8d000900      	callf	f_send_square_pulse
 843                     ; 99 	GPIO_WriteHigh(LED_BLUE); 
 845  0223 4b01          	push	#1
 846  0225 ae500f        	ldw	x,#20495
 847  0228 8d000000      	callf	f_GPIO_WriteHigh
 849  022c 84            	pop	a
 850                     ; 100 	GPIO_WriteHigh(GPIOD, GPIO_PIN_2); 
 852  022d 4b04          	push	#4
 853  022f ae500f        	ldw	x,#20495
 854  0232 8d000000      	callf	f_GPIO_WriteHigh
 856  0236 84            	pop	a
 857                     ; 101 	VAR_amplitude = process_adc_signal(VAR_SIGNAL, NULL, &VAR_amplitude);
 859  0237 96            	ldw	x,sp
 860  0238 1c002c        	addw	x,#OFST+4
 861  023b 89            	pushw	x
 862  023c 5f            	clrw	x
 863  023d 89            	pushw	x
 864  023e a605          	ld	a,#5
 865  0240 8dd105d1      	callf	f_process_adc_signal
 867  0244 5b04          	addw	sp,#4
 868  0246 96            	ldw	x,sp
 869  0247 1c002c        	addw	x,#OFST+4
 870  024a 8d000000      	callf	d_rtol
 872                     ; 102   sprintf(buffer, "0.000,%.3f,%.3f,%.3f,1\n", VAR_amplitude, VAR_amplitude/4.7, 0);
 874  024e 5f            	clrw	x
 875  024f 89            	pushw	x
 876  0250 96            	ldw	x,sp
 877  0251 1c002e        	addw	x,#OFST+6
 878  0254 8d000000      	callf	d_ltor
 880  0258 ae12af        	ldw	x,#L571
 881  025b 8d000000      	callf	d_fdiv
 883  025f be02          	ldw	x,c_lreg+2
 884  0261 89            	pushw	x
 885  0262 be00          	ldw	x,c_lreg
 886  0264 89            	pushw	x
 887  0265 1e34          	ldw	x,(OFST+12,sp)
 888  0267 89            	pushw	x
 889  0268 1e34          	ldw	x,(OFST+12,sp)
 890  026a 89            	pushw	x
 891  026b ae12b3        	ldw	x,#L761
 892  026e 89            	pushw	x
 893  026f 96            	ldw	x,sp
 894  0270 1c000d        	addw	x,#OFST-27
 895  0273 8d000000      	callf	f_sprintf
 897  0277 5b0c          	addw	sp,#12
 898                     ; 103 	printf("%s", buffer);
 900  0279 96            	ldw	x,sp
 901  027a 1c0001        	addw	x,#OFST-39
 902  027d 89            	pushw	x
 903  027e ae12ac        	ldw	x,#L102
 904  0281 8d000000      	callf	f_printf
 906  0285 85            	popw	x
 907                     ; 104 	if (check_signal_dc(VAR_amplitude)) {
 909  0286 1e2e          	ldw	x,(OFST+6,sp)
 910  0288 89            	pushw	x
 911  0289 1e2e          	ldw	x,(OFST+6,sp)
 912  028b 89            	pushw	x
 913  028c 8d7a097a      	callf	f_check_signal_dc
 915  0290 5b04          	addw	sp,#4
 916  0292 4d            	tnz	a
 917  0293 2717          	jreq	L333
 918                     ; 106 		printf("Signal 1 DC.\n");
 920  0295 ae1207        	ldw	x,#L533
 921  0298 8d000000      	callf	f_printf
 923                     ; 107 		GPIO_WriteHigh(LED_BLUE); 
 925  029c 4b01          	push	#1
 926  029e ae500f        	ldw	x,#20495
 927  02a1 8d000000      	callf	f_GPIO_WriteHigh
 929  02a5 84            	pop	a
 930                     ; 108 		process_FDR_signal();
 932  02a6 8d890089      	callf	f_process_FDR_signal
 935  02aa 201b          	jra	L733
 936  02ac               L333:
 937                     ; 111 		printf("Signal 1 AC and VarAmplitude: %f.\n", VAR_amplitude);
 939  02ac 1e2e          	ldw	x,(OFST+6,sp)
 940  02ae 89            	pushw	x
 941  02af 1e2e          	ldw	x,(OFST+6,sp)
 942  02b1 89            	pushw	x
 943  02b2 ae11e4        	ldw	x,#L143
 944  02b5 8d000000      	callf	f_printf
 946  02b9 5b04          	addw	sp,#4
 947                     ; 112 		handle_signal_1_AC(VAR_amplitude);
 949  02bb 1e2e          	ldw	x,(OFST+6,sp)
 950  02bd 89            	pushw	x
 951  02be 1e2e          	ldw	x,(OFST+6,sp)
 952  02c0 89            	pushw	x
 953  02c1 8dca02ca      	callf	f_handle_signal_1_AC
 955  02c5 5b04          	addw	sp,#4
 956  02c7               L733:
 957                     ; 114 }
 960  02c7 5b28          	addw	sp,#40
 961  02c9 87            	retf
1011                     ; 117 void handle_signal_1_AC(float VAR_amplitude) {
1012                     	switch	.text
1013  02ca               f_handle_signal_1_AC:
1015  02ca 5228          	subw	sp,#40
1016       00000028      OFST:	set	40
1019                     ; 119 	if (VAR_amplitude < AC_AMPLITUDE_THRESHOLD) {
1021  02cc 9c            	rvf
1022  02cd 96            	ldw	x,sp
1023  02ce 1c002c        	addw	x,#OFST+4
1024  02d1 8d000000      	callf	d_ltor
1026  02d5 ae11e0        	ldw	x,#L373
1027  02d8 8d000000      	callf	d_fcmp
1029  02dc 2e59          	jrsge	L563
1030                     ; 121 		sprintf(buffer, "0.000,%.3f,%.3f,%.3f,1\n", VAR_amplitude, VAR_amplitude/4.7, 0);
1032  02de 5f            	clrw	x
1033  02df 89            	pushw	x
1034  02e0 96            	ldw	x,sp
1035  02e1 1c002e        	addw	x,#OFST+6
1036  02e4 8d000000      	callf	d_ltor
1038  02e8 ae12af        	ldw	x,#L571
1039  02eb 8d000000      	callf	d_fdiv
1041  02ef be02          	ldw	x,c_lreg+2
1042  02f1 89            	pushw	x
1043  02f2 be00          	ldw	x,c_lreg
1044  02f4 89            	pushw	x
1045  02f5 1e34          	ldw	x,(OFST+12,sp)
1046  02f7 89            	pushw	x
1047  02f8 1e34          	ldw	x,(OFST+12,sp)
1048  02fa 89            	pushw	x
1049  02fb ae12b3        	ldw	x,#L761
1050  02fe 89            	pushw	x
1051  02ff 96            	ldw	x,sp
1052  0300 1c000d        	addw	x,#OFST-27
1053  0303 8d000000      	callf	f_sprintf
1055  0307 5b0c          	addw	sp,#12
1056                     ; 122 	  printf("%s", buffer);
1058  0309 96            	ldw	x,sp
1059  030a 1c0001        	addw	x,#OFST-39
1060  030d 89            	pushw	x
1061  030e ae12ac        	ldw	x,#L102
1062  0311 8d000000      	callf	f_printf
1064  0315 85            	popw	x
1065                     ; 123 		printf("VarAmplitude below 10 mv.\n");
1067  0316 ae11c5        	ldw	x,#L773
1068  0319 8d000000      	callf	f_printf
1070                     ; 124 		GPIO_WriteLow(LED_WHITE); // Turn on LED if Signal is AC < 20 mV
1072  031d 4b08          	push	#8
1073  031f ae500a        	ldw	x,#20490
1074  0322 8d000000      	callf	f_GPIO_WriteLow
1076  0326 84            	pop	a
1077                     ; 125 		delay_ms(3000);
1079  0327 ae0bb8        	ldw	x,#3000
1080  032a 8d000000      	callf	f_delay_ms
1082                     ; 126 		send_square_pulse(5);
1084  032e ae0005        	ldw	x,#5
1085  0331 8d000900      	callf	f_send_square_pulse
1088  0335 205f          	jra	L104
1089  0337               L563:
1090                     ; 129 		GPIO_WriteHigh(GPIOD, GPIO_PIN_7);  // Turn on LED if Signal is AC < 20 ms
1092  0337 4b80          	push	#128
1093  0339 ae500f        	ldw	x,#20495
1094  033c 8d000000      	callf	f_GPIO_WriteHigh
1096  0340 84            	pop	a
1097                     ; 130 		sprintf(buffer, "%0.000,%.3f,%.3f,%.3f,1\n", VAR_amplitude, VAR_amplitude/4.7, 0);
1099  0341 5f            	clrw	x
1100  0342 89            	pushw	x
1101  0343 96            	ldw	x,sp
1102  0344 1c002e        	addw	x,#OFST+6
1103  0347 8d000000      	callf	d_ltor
1105  034b ae12af        	ldw	x,#L571
1106  034e 8d000000      	callf	d_fdiv
1108  0352 be02          	ldw	x,c_lreg+2
1109  0354 89            	pushw	x
1110  0355 be00          	ldw	x,c_lreg
1111  0357 89            	pushw	x
1112  0358 1e34          	ldw	x,(OFST+12,sp)
1113  035a 89            	pushw	x
1114  035b 1e34          	ldw	x,(OFST+12,sp)
1115  035d 89            	pushw	x
1116  035e ae11ac        	ldw	x,#L304
1117  0361 89            	pushw	x
1118  0362 96            	ldw	x,sp
1119  0363 1c000d        	addw	x,#OFST-27
1120  0366 8d000000      	callf	f_sprintf
1122  036a 5b0c          	addw	sp,#12
1123                     ; 131 	  printf("%s", buffer);
1125  036c 96            	ldw	x,sp
1126  036d 1c0001        	addw	x,#OFST-39
1127  0370 89            	pushw	x
1128  0371 ae12ac        	ldw	x,#L102
1129  0374 8d000000      	callf	f_printf
1131  0378 85            	popw	x
1132                     ; 132 		printf("VarAmplitude Not below 10 mv.\n");
1134  0379 ae118d        	ldw	x,#L504
1135  037c 8d000000      	callf	f_printf
1137                     ; 133 		handle_Frequency_Below_Set_Freq(VAR_amplitude);
1139  0380 1e2e          	ldw	x,(OFST+6,sp)
1140  0382 89            	pushw	x
1141  0383 1e2e          	ldw	x,(OFST+6,sp)
1142  0385 89            	pushw	x
1143  0386 8d0f020f      	callf	f_handle_Frequency_Below_Set_Freq
1145  038a 5b04          	addw	sp,#4
1146                     ; 134 		GPIO_WriteHigh(LED_WHITE);  // Turn on LED if Signal is AC < 20 ms		
1148  038c 4b08          	push	#8
1149  038e ae500a        	ldw	x,#20490
1150  0391 8d000000      	callf	f_GPIO_WriteHigh
1152  0395 84            	pop	a
1153  0396               L104:
1154                     ; 136 }
1157  0396 5b28          	addw	sp,#40
1158  0398 87            	retf
1231                     ; 139 bool detectZeroCross(float previousSample, float currentSample, float threshold) {
1232                     	switch	.text
1233  0399               f_detectZeroCross:
1235       00000000      OFST:	set	0
1238                     ; 140 	if (crossingType == -1) {  // If no crossing type detected, check for both positive and negative
1240  0399 be10          	ldw	x,_crossingType
1241  039b a3ffff        	cpw	x,#65535
1242  039e 265a          	jrne	L544
1243                     ; 141 		if (previousSample <= threshold && currentSample > threshold) {
1245  03a0 9c            	rvf
1246  03a1 96            	ldw	x,sp
1247  03a2 1c0004        	addw	x,#OFST+4
1248  03a5 8d000000      	callf	d_ltor
1250  03a9 96            	ldw	x,sp
1251  03aa 1c000c        	addw	x,#OFST+12
1252  03ad 8d000000      	callf	d_fcmp
1254  03b1 2c19          	jrsgt	L744
1256  03b3 9c            	rvf
1257  03b4 96            	ldw	x,sp
1258  03b5 1c0008        	addw	x,#OFST+8
1259  03b8 8d000000      	callf	d_ltor
1261  03bc 96            	ldw	x,sp
1262  03bd 1c000c        	addw	x,#OFST+12
1263  03c0 8d000000      	callf	d_fcmp
1265  03c4 2d06          	jrsle	L744
1266                     ; 142 			crossingType = 0;  // Positive zero crossing
1268  03c6 5f            	clrw	x
1269  03c7 bf10          	ldw	_crossingType,x
1270                     ; 143 			return true;
1272  03c9 a601          	ld	a,#1
1275  03cb 87            	retf
1276  03cc               L744:
1277                     ; 144 		} else if (previousSample >= threshold && currentSample < threshold) {
1279  03cc 9c            	rvf
1280  03cd 96            	ldw	x,sp
1281  03ce 1c0004        	addw	x,#OFST+4
1282  03d1 8d000000      	callf	d_ltor
1284  03d5 96            	ldw	x,sp
1285  03d6 1c000c        	addw	x,#OFST+12
1286  03d9 8d000000      	callf	d_fcmp
1288  03dd 2f78          	jrslt	L554
1290  03df 9c            	rvf
1291  03e0 96            	ldw	x,sp
1292  03e1 1c0008        	addw	x,#OFST+8
1293  03e4 8d000000      	callf	d_ltor
1295  03e8 96            	ldw	x,sp
1296  03e9 1c000c        	addw	x,#OFST+12
1297  03ec 8d000000      	callf	d_fcmp
1299  03f0 2e65          	jrsge	L554
1300                     ; 145 			crossingType = 1;  // Negative zero crossing
1302  03f2 ae0001        	ldw	x,#1
1303  03f5 bf10          	ldw	_crossingType,x
1304                     ; 146 			return true;
1306  03f7 a601          	ld	a,#1
1309  03f9 87            	retf
1310  03fa               L544:
1311                     ; 148 	} else if (crossingType == 0 && previousSample <= threshold && currentSample > threshold) {
1313  03fa be10          	ldw	x,_crossingType
1314  03fc 2629          	jrne	L754
1316  03fe 9c            	rvf
1317  03ff 96            	ldw	x,sp
1318  0400 1c0004        	addw	x,#OFST+4
1319  0403 8d000000      	callf	d_ltor
1321  0407 96            	ldw	x,sp
1322  0408 1c000c        	addw	x,#OFST+12
1323  040b 8d000000      	callf	d_fcmp
1325  040f 2c16          	jrsgt	L754
1327  0411 9c            	rvf
1328  0412 96            	ldw	x,sp
1329  0413 1c0008        	addw	x,#OFST+8
1330  0416 8d000000      	callf	d_ltor
1332  041a 96            	ldw	x,sp
1333  041b 1c000c        	addw	x,#OFST+12
1334  041e 8d000000      	callf	d_fcmp
1336  0422 2d03          	jrsle	L754
1337                     ; 149 			return true;  // Positive zero crossing
1339  0424 a601          	ld	a,#1
1342  0426 87            	retf
1343  0427               L754:
1344                     ; 150 	} else if (crossingType == 1 && previousSample >= threshold && currentSample < threshold) {
1346  0427 be10          	ldw	x,_crossingType
1347  0429 a30001        	cpw	x,#1
1348  042c 2629          	jrne	L554
1350  042e 9c            	rvf
1351  042f 96            	ldw	x,sp
1352  0430 1c0004        	addw	x,#OFST+4
1353  0433 8d000000      	callf	d_ltor
1355  0437 96            	ldw	x,sp
1356  0438 1c000c        	addw	x,#OFST+12
1357  043b 8d000000      	callf	d_fcmp
1359  043f 2f16          	jrslt	L554
1361  0441 9c            	rvf
1362  0442 96            	ldw	x,sp
1363  0443 1c0008        	addw	x,#OFST+8
1364  0446 8d000000      	callf	d_ltor
1366  044a 96            	ldw	x,sp
1367  044b 1c000c        	addw	x,#OFST+12
1368  044e 8d000000      	callf	d_fcmp
1370  0452 2e03          	jrsge	L554
1371                     ; 151 			return true;  // Negative zero crossing
1373  0454 a601          	ld	a,#1
1376  0456 87            	retf
1377  0457               L554:
1378                     ; 154 	return false;  // No zero crossing detected
1380  0457 4f            	clr	a
1383  0458 87            	retf
1435                     ; 158 bool detectPosZeroCross(float previousSample, float currentSample, float threshold) {
1436                     	switch	.text
1437  0459               f_detectPosZeroCross:
1439       00000000      OFST:	set	0
1442                     ; 159 	return (previousSample <= threshold && currentSample > threshold);
1444  0459 9c            	rvf
1445  045a 96            	ldw	x,sp
1446  045b 1c0004        	addw	x,#OFST+4
1447  045e 8d000000      	callf	d_ltor
1449  0462 96            	ldw	x,sp
1450  0463 1c000c        	addw	x,#OFST+12
1451  0466 8d000000      	callf	d_fcmp
1453  046a 2c17          	jrsgt	L62
1454  046c 9c            	rvf
1455  046d 96            	ldw	x,sp
1456  046e 1c0008        	addw	x,#OFST+8
1457  0471 8d000000      	callf	d_ltor
1459  0475 96            	ldw	x,sp
1460  0476 1c000c        	addw	x,#OFST+12
1461  0479 8d000000      	callf	d_fcmp
1463  047d 2d04          	jrsle	L62
1464  047f a601          	ld	a,#1
1465  0481 2001          	jra	L03
1466  0483               L62:
1467  0483 4f            	clr	a
1468  0484               L03:
1471  0484 87            	retf
1533                     ; 163 bool detect_negative_zero_cross(float previous_sample, float current_sample, float threshold) {
1534                     	switch	.text
1535  0485               f_detect_negative_zero_cross:
1537  0485 5204          	subw	sp,#4
1538       00000004      OFST:	set	4
1541                     ; 164 	float hyst = 0.5;
1543                     ; 165 	return (previous_sample > threshold && current_sample <= threshold);
1545  0487 9c            	rvf
1546  0488 96            	ldw	x,sp
1547  0489 1c0008        	addw	x,#OFST+4
1548  048c 8d000000      	callf	d_ltor
1550  0490 96            	ldw	x,sp
1551  0491 1c0010        	addw	x,#OFST+12
1552  0494 8d000000      	callf	d_fcmp
1554  0498 2d17          	jrsle	L43
1555  049a 9c            	rvf
1556  049b 96            	ldw	x,sp
1557  049c 1c000c        	addw	x,#OFST+8
1558  049f 8d000000      	callf	d_ltor
1560  04a3 96            	ldw	x,sp
1561  04a4 1c0010        	addw	x,#OFST+12
1562  04a7 8d000000      	callf	d_fcmp
1564  04ab 2c04          	jrsgt	L43
1565  04ad a601          	ld	a,#1
1566  04af 2001          	jra	L63
1567  04b1               L43:
1568  04b1 4f            	clr	a
1569  04b2               L63:
1572  04b2 5b04          	addw	sp,#4
1573  04b4 87            	retf
1621                     ; 168 bool check_negative_zero_crossing(void) {
1622                     	switch	.text
1623  04b5               f_check_negative_zero_crossing:
1625  04b5 5208          	subw	sp,#8
1626       00000008      OFST:	set	8
1629                     ; 169 	float prev_adc_value = 0;  // Store previous ADC sample value
1631  04b7 ae0000        	ldw	x,#0
1632  04ba 1f03          	ldw	(OFST-5,sp),x
1633  04bc ae0000        	ldw	x,#0
1634  04bf 1f01          	ldw	(OFST-7,sp),x
1636                     ; 170 	float current_adc_value = 0;  // Store current ADC sample value
1638  04c1               L775:
1639                     ; 174 		current_adc_value = convert_adc_to_voltage(read_ADC_Channel(VAR_SIGNAL));
1641  04c1 a605          	ld	a,#5
1642  04c3 8d000000      	callf	f_read_ADC_Channel
1644  04c7 8d4a084a      	callf	f_convert_adc_to_voltage
1646  04cb 96            	ldw	x,sp
1647  04cc 1c0005        	addw	x,#OFST-3
1648  04cf 8d000000      	callf	d_rtol
1651                     ; 176 		if (detect_negative_zero_cross(prev_adc_value, current_adc_value, ZEROCROSS_THRESHOLD)) {
1653  04d3 ce1187        	ldw	x,L116+2
1654  04d6 89            	pushw	x
1655  04d7 ce1185        	ldw	x,L116
1656  04da 89            	pushw	x
1657  04db 1e0b          	ldw	x,(OFST+3,sp)
1658  04dd 89            	pushw	x
1659  04de 1e0b          	ldw	x,(OFST+3,sp)
1660  04e0 89            	pushw	x
1661  04e1 1e0b          	ldw	x,(OFST+3,sp)
1662  04e3 89            	pushw	x
1663  04e4 1e0b          	ldw	x,(OFST+3,sp)
1664  04e6 89            	pushw	x
1665  04e7 8d850485      	callf	f_detect_negative_zero_cross
1667  04eb 5b0c          	addw	sp,#12
1668  04ed 4d            	tnz	a
1669  04ee 270c          	jreq	L306
1670                     ; 178 			printf(" Negative zero crossing detected!\n");
1672  04f0 ae1162        	ldw	x,#L516
1673  04f3 8d000000      	callf	f_printf
1675                     ; 179 			return true;
1677  04f7 a601          	ld	a,#1
1680  04f9 5b08          	addw	sp,#8
1681  04fb 87            	retf
1682  04fc               L306:
1683                     ; 182 		prev_adc_value = current_adc_value;
1685  04fc 1e07          	ldw	x,(OFST-1,sp)
1686  04fe 1f03          	ldw	(OFST-5,sp),x
1687  0500 1e05          	ldw	x,(OFST-3,sp)
1688  0502 1f01          	ldw	(OFST-7,sp),x
1691  0504 20bb          	jra	L775
1762                     ; 188 float calculate_amplitude(float adc_signal[], uint32_t sample_size) {
1763                     	switch	.text
1764  0506               f_calculate_amplitude:
1766  0506 89            	pushw	x
1767  0507 520c          	subw	sp,#12
1768       0000000c      OFST:	set	12
1771                     ; 189 	uint32_t i = 0;
1773                     ; 190 	float max_val = -V_REF, min_val = V_REF;
1775  0509 ce115c        	ldw	x,L166+2
1776  050c 1f03          	ldw	(OFST-9,sp),x
1777  050e ce115a        	ldw	x,L166
1778  0511 1f01          	ldw	(OFST-11,sp),x
1782  0513 ce1160        	ldw	x,L176+2
1783  0516 1f07          	ldw	(OFST-5,sp),x
1784  0518 ce115e        	ldw	x,L176
1785  051b 1f05          	ldw	(OFST-7,sp),x
1787                     ; 192 	for (i = 0; i < sample_size; i++) {
1789  051d ae0000        	ldw	x,#0
1790  0520 1f0b          	ldw	(OFST-1,sp),x
1791  0522 ae0000        	ldw	x,#0
1792  0525 1f09          	ldw	(OFST-3,sp),x
1795  0527 2058          	jra	L107
1796  0529               L576:
1797                     ; 193 		if (adc_signal[i] > max_val) max_val = adc_signal[i];
1799  0529 9c            	rvf
1800  052a 1e0b          	ldw	x,(OFST-1,sp)
1801  052c 58            	sllw	x
1802  052d 58            	sllw	x
1803  052e 72fb0d        	addw	x,(OFST+1,sp)
1804  0531 8d000000      	callf	d_ltor
1806  0535 96            	ldw	x,sp
1807  0536 1c0001        	addw	x,#OFST-11
1808  0539 8d000000      	callf	d_fcmp
1810  053d 2d11          	jrsle	L507
1813  053f 1e0b          	ldw	x,(OFST-1,sp)
1814  0541 58            	sllw	x
1815  0542 58            	sllw	x
1816  0543 72fb0d        	addw	x,(OFST+1,sp)
1817  0546 9093          	ldw	y,x
1818  0548 ee02          	ldw	x,(2,x)
1819  054a 1f03          	ldw	(OFST-9,sp),x
1820  054c 93            	ldw	x,y
1821  054d fe            	ldw	x,(x)
1822  054e 1f01          	ldw	(OFST-11,sp),x
1824  0550               L507:
1825                     ; 194 		if (adc_signal[i] < min_val) min_val = adc_signal[i];
1827  0550 9c            	rvf
1828  0551 1e0b          	ldw	x,(OFST-1,sp)
1829  0553 58            	sllw	x
1830  0554 58            	sllw	x
1831  0555 72fb0d        	addw	x,(OFST+1,sp)
1832  0558 8d000000      	callf	d_ltor
1834  055c 96            	ldw	x,sp
1835  055d 1c0005        	addw	x,#OFST-7
1836  0560 8d000000      	callf	d_fcmp
1838  0564 2e11          	jrsge	L707
1841  0566 1e0b          	ldw	x,(OFST-1,sp)
1842  0568 58            	sllw	x
1843  0569 58            	sllw	x
1844  056a 72fb0d        	addw	x,(OFST+1,sp)
1845  056d 9093          	ldw	y,x
1846  056f ee02          	ldw	x,(2,x)
1847  0571 1f07          	ldw	(OFST-5,sp),x
1848  0573 93            	ldw	x,y
1849  0574 fe            	ldw	x,(x)
1850  0575 1f05          	ldw	(OFST-7,sp),x
1852  0577               L707:
1853                     ; 192 	for (i = 0; i < sample_size; i++) {
1855  0577 96            	ldw	x,sp
1856  0578 1c0009        	addw	x,#OFST-3
1857  057b a601          	ld	a,#1
1858  057d 8d000000      	callf	d_lgadc
1861  0581               L107:
1864  0581 96            	ldw	x,sp
1865  0582 1c0009        	addw	x,#OFST-3
1866  0585 8d000000      	callf	d_ltor
1868  0589 96            	ldw	x,sp
1869  058a 1c0012        	addw	x,#OFST+6
1870  058d 8d000000      	callf	d_lcmp
1872  0591 2596          	jrult	L576
1873                     ; 197 	return (max_val - min_val);
1875  0593 96            	ldw	x,sp
1876  0594 1c0001        	addw	x,#OFST-11
1877  0597 8d000000      	callf	d_ltor
1879  059b 96            	ldw	x,sp
1880  059c 1c0005        	addw	x,#OFST-7
1881  059f 8d000000      	callf	d_fsub
1885  05a3 5b0e          	addw	sp,#14
1886  05a5 87            	retf
1930                     ; 201 void initialize_adc_buffer(float buffer[]) {
1931                     	switch	.text
1932  05a6               f_initialize_adc_buffer:
1934  05a6 89            	pushw	x
1935  05a7 89            	pushw	x
1936       00000002      OFST:	set	2
1939                     ; 202 	uint16_t i = 0;
1941                     ; 203 	for (i = 0; i < NUM_SAMPLES; i++) {
1943  05a8 5f            	clrw	x
1944  05a9 1f01          	ldw	(OFST-1,sp),x
1946  05ab               L337:
1947                     ; 204 		buffer[i] = -1;  // Reset each element of the ADC buffer
1949  05ab 1e01          	ldw	x,(OFST-1,sp)
1950  05ad 58            	sllw	x
1951  05ae 58            	sllw	x
1952  05af 72fb03        	addw	x,(OFST+1,sp)
1953  05b2 90aeffff      	ldw	y,#65535
1954  05b6 51            	exgw	x,y
1955  05b7 8d000000      	callf	d_itof
1957  05bb 51            	exgw	x,y
1958  05bc 8d000000      	callf	d_rtol
1960                     ; 203 	for (i = 0; i < NUM_SAMPLES; i++) {
1962  05c0 1e01          	ldw	x,(OFST-1,sp)
1963  05c2 1c0001        	addw	x,#1
1964  05c5 1f01          	ldw	(OFST-1,sp),x
1968  05c7 1e01          	ldw	x,(OFST-1,sp)
1969  05c9 a30400        	cpw	x,#1024
1970  05cc 25dd          	jrult	L337
1971                     ; 206 }
1974  05ce 5b04          	addw	sp,#4
1975  05d0 87            	retf
1977                     .const:	section	.text
1978  0000               L147_buffer:
1979  0000 00000000      	dc.w	0,0
1980  0004 000000000000  	ds.b	4092
2115                     ; 208 float process_adc_signal(uint8_t channel, float *frequency, float *amplitude) {
2116                     	switch	.text
2117  05d1               f_process_adc_signal:
2119  05d1 88            	push	a
2120  05d2 96            	ldw	x,sp
2121  05d3 1d1021        	subw	x,#4129
2122  05d6 94            	ldw	sp,x
2123       00001021      OFST:	set	4129
2126                     ; 209 	float buffer[NUM_SAMPLES] = {0};  // Initialize ADC buffer
2128  05d7 96            	ldw	x,sp
2129  05d8 1c001e        	addw	x,#OFST-4099
2130  05db 90ae0000      	ldw	y,#L147_buffer
2131  05df bf00          	ldw	c_x,x
2132  05e1 ae1000        	ldw	x,#4096
2133  05e4 8d000000      	callf	d_xymovl
2135                     ; 210 	unsigned long currentEdgeTime = 0;
2137                     ; 211 	float freqBuff = 0;
2139  05e8 ae0000        	ldw	x,#0
2140  05eb 1f17          	ldw	(OFST-4106,sp),x
2141  05ed ae0000        	ldw	x,#0
2142  05f0 1f15          	ldw	(OFST-4108,sp),x
2144                     ; 212 	int freqCount = 0;
2146  05f2 96            	ldw	x,sp
2147  05f3 905f          	clrw	y
2148  05f5 df101e        	ldw	(OFST-3,x),y
2149                     ; 213 	uint16_t i = 0;
2151                     ; 214 	bool isChannel1 = (channel == VAR_SIGNAL);  // Check if the channel is for Signal 1 or Signal 2
2153  05f8 96            	ldw	x,sp
2154  05f9 d61022        	ld	a,(OFST+1,x)
2155  05fc a105          	cp	a,#5
2156  05fe 2605          	jrne	L05
2157  0600 ae0001        	ldw	x,#1
2158  0603 2001          	jra	L25
2159  0605               L05:
2160  0605 5f            	clrw	x
2161  0606               L25:
2162  0606 01            	rrwa	x,a
2163  0607 6b1d          	ld	(OFST-4100,sp),a
2164  0609 02            	rlwa	x,a
2166                     ; 215 	lastEdgeTime = 0;                 // Reset last zero-crossing time
2168  060a ae0000        	ldw	x,#0
2169  060d bf0a          	ldw	_lastEdgeTime+2,x
2170  060f ae0000        	ldw	x,#0
2171  0612 bf08          	ldw	_lastEdgeTime,x
2172                     ; 220 	for (i = 0; i < NUM_SAMPLES; i++) {
2174  0614 96            	ldw	x,sp
2175  0615 905f          	clrw	y
2176  0617 df1020        	ldw	(OFST-1,x),y
2177  061a               L1301:
2178                     ; 222 	buffer[i] = convert_adc_to_voltage(read_ADC_Channel(channel));
2180  061a 96            	ldw	x,sp
2181  061b d61022        	ld	a,(OFST+1,x)
2182  061e 8d000000      	callf	f_read_ADC_Channel
2184  0622 8d4a084a      	callf	f_convert_adc_to_voltage
2186  0626 96            	ldw	x,sp
2187  0627 1c001e        	addw	x,#OFST-4099
2188  062a 1f0f          	ldw	(OFST-4114,sp),x
2190  062c 96            	ldw	x,sp
2191  062d de1020        	ldw	x,(OFST-1,x)
2192  0630 58            	sllw	x
2193  0631 58            	sllw	x
2194  0632 72fb0f        	addw	x,(OFST-4114,sp)
2195  0635 8d000000      	callf	d_rtol
2197                     ; 224 	if (isChannel1 && (frequency != NULL)) { // Only calculate frequency for Signal 1 (Channel 1)
2199  0639 0d1d          	tnz	(OFST-4100,sp)
2200  063b 2604          	jrne	L66
2201  063d ac8c078c      	jpf	L7301
2202  0641               L66:
2204  0641 96            	ldw	x,sp
2205  0642 d61027        	ld	a,(OFST+6,x)
2206  0645 da1026        	or	a,(OFST+5,x)
2207  0648 2604          	jrne	L07
2208  064a ac8c078c      	jpf	L7301
2209  064e               L07:
2210                     ; 226 		if (i > 0 && detectZeroCross(buffer[i - 1], buffer[i], ZEROCROSS_THRESHOLD)) {
2212  064e 96            	ldw	x,sp
2213  064f d61021        	ld	a,(OFST+0,x)
2214  0652 da1020        	or	a,(OFST-1,x)
2215  0655 2604          	jrne	L27
2216  0657 ac8c078c      	jpf	L7301
2217  065b               L27:
2219  065b ce1187        	ldw	x,L116+2
2220  065e 89            	pushw	x
2221  065f ce1185        	ldw	x,L116
2222  0662 89            	pushw	x
2223  0663 96            	ldw	x,sp
2224  0664 1c0022        	addw	x,#OFST-4095
2225  0667 1f13          	ldw	(OFST-4110,sp),x
2227  0669 96            	ldw	x,sp
2228  066a de1024        	ldw	x,(OFST+3,x)
2229  066d 58            	sllw	x
2230  066e 58            	sllw	x
2231  066f 72fb13        	addw	x,(OFST-4110,sp)
2232  0672 9093          	ldw	y,x
2233  0674 ee02          	ldw	x,(2,x)
2234  0676 89            	pushw	x
2235  0677 93            	ldw	x,y
2236  0678 fe            	ldw	x,(x)
2237  0679 89            	pushw	x
2238  067a 96            	ldw	x,sp
2239  067b 1c0026        	addw	x,#OFST-4091
2240  067e 1f15          	ldw	(OFST-4108,sp),x
2242  0680 96            	ldw	x,sp
2243  0681 de1028        	ldw	x,(OFST+7,x)
2244  0684 58            	sllw	x
2245  0685 58            	sllw	x
2246  0686 1d0004        	subw	x,#4
2247  0689 72fb15        	addw	x,(OFST-4108,sp)
2248  068c 9093          	ldw	y,x
2249  068e ee02          	ldw	x,(2,x)
2250  0690 89            	pushw	x
2251  0691 93            	ldw	x,y
2252  0692 fe            	ldw	x,(x)
2253  0693 89            	pushw	x
2254  0694 8d990399      	callf	f_detectZeroCross
2256  0698 5b0c          	addw	sp,#12
2257  069a 4d            	tnz	a
2258  069b 2604          	jrne	L47
2259  069d ac8c078c      	jpf	L7301
2260  06a1               L47:
2261                     ; 227 			currentEdgeTime = micros();
2263  06a1 8d000000      	callf	f_micros
2265  06a5 96            	ldw	x,sp
2266  06a6 1c0019        	addw	x,#OFST-4104
2267  06a9 8d000000      	callf	d_rtol
2270                     ; 228 			if (lastEdgeTime > 0) {  // Zero-crossing detected; calculate period and frequency
2272  06ad ae0008        	ldw	x,#_lastEdgeTime
2273  06b0 8d000000      	callf	d_lzmp
2275  06b4 2604          	jrne	L67
2276  06b6 ac840784      	jpf	L3401
2277  06ba               L67:
2278                     ; 229 				unsigned long period = currentEdgeTime - lastEdgeTime;  // Period in microseconds
2280  06ba 96            	ldw	x,sp
2281  06bb 1c0019        	addw	x,#OFST-4104
2282  06be 8d000000      	callf	d_ltor
2284  06c2 ae0008        	ldw	x,#_lastEdgeTime
2285  06c5 8d000000      	callf	d_lsub
2287  06c9 96            	ldw	x,sp
2288  06ca 1c0011        	addw	x,#OFST-4112
2289  06cd 8d000000      	callf	d_rtol
2292                     ; 230 				float singleFrequency = calculate_frequency(period);   // Calculate frequency in Hz
2294  06d1 1e13          	ldw	x,(OFST-4110,sp)
2295  06d3 89            	pushw	x
2296  06d4 1e13          	ldw	x,(OFST-4110,sp)
2297  06d6 89            	pushw	x
2298  06d7 8d560856      	callf	f_calculate_frequency
2300  06db 5b04          	addw	sp,#4
2301  06dd 96            	ldw	x,sp
2302  06de 1c0011        	addw	x,#OFST-4112
2303  06e1 8d000000      	callf	d_rtol
2306                     ; 232 				freqCount++;
2308  06e5 96            	ldw	x,sp
2309  06e6 9093          	ldw	y,x
2310  06e8 de101e        	ldw	x,(OFST-3,x)
2311  06eb 1c0001        	addw	x,#1
2312  06ee 90df101e      	ldw	(OFST-3,y),x
2313                     ; 234 				if (freqCount == 2) {  // Stop after detecting 2 zero-crossings
2315  06f2 96            	ldw	x,sp
2316  06f3 9093          	ldw	y,x
2317  06f5 90de101e      	ldw	y,(OFST-3,y)
2318  06f9 90a30002      	cpw	y,#2
2319  06fd 26b7          	jrne	L3401
2320                     ; 235 					count = i;  // Limit used for amplitude calculation within this range
2322  06ff 96            	ldw	x,sp
2323  0700 de1020        	ldw	x,(OFST-1,x)
2324  0703 bf12          	ldw	_count,x
2325                     ; 237 					*amplitude = calculate_amplitude(buffer, (freqCount > 0 ? count : NUM_SAMPLES));
2327  0705 9c            	rvf
2328  0706 5f            	clrw	x
2329  0707 1f0f          	ldw	(OFST-4114,sp),x
2331  0709 96            	ldw	x,sp
2332  070a 9093          	ldw	y,x
2333  070c 51            	exgw	x,y
2334  070d de101e        	ldw	x,(OFST-3,x)
2335  0710 130f          	cpw	x,(OFST-4114,sp)
2336  0712 51            	exgw	x,y
2337  0713 2d04          	jrsle	L45
2338  0715 be12          	ldw	x,_count
2339  0717 2003          	jra	L65
2340  0719               L45:
2341  0719 ae0400        	ldw	x,#1024
2342  071c               L65:
2343  071c 8d000000      	callf	d_uitolx
2345  0720 be02          	ldw	x,c_lreg+2
2346  0722 89            	pushw	x
2347  0723 be00          	ldw	x,c_lreg
2348  0725 89            	pushw	x
2349  0726 96            	ldw	x,sp
2350  0727 1c0022        	addw	x,#OFST-4095
2351  072a 8d060506      	callf	f_calculate_amplitude
2353  072e 5b04          	addw	sp,#4
2354  0730 96            	ldw	x,sp
2355  0731 de1028        	ldw	x,(OFST+7,x)
2356  0734 8d000000      	callf	d_rtol
2358                     ; 240 					if (isChannel1 && freqCount > 0) {
2360  0738 0d1d          	tnz	(OFST-4100,sp)
2361  073a 2725          	jreq	L7401
2363  073c 9c            	rvf
2364  073d 5f            	clrw	x
2365  073e 1f0f          	ldw	(OFST-4114,sp),x
2367  0740 96            	ldw	x,sp
2368  0741 9093          	ldw	y,x
2369  0743 51            	exgw	x,y
2370  0744 de101e        	ldw	x,(OFST-3,x)
2371  0747 130f          	cpw	x,(OFST-4114,sp)
2372  0749 51            	exgw	x,y
2373  074a 2d15          	jrsle	L7401
2374                     ; 241 						*frequency = singleFrequency;  // Calculate average frequency
2376  074c 96            	ldw	x,sp
2377  074d de1026        	ldw	x,(OFST+5,x)
2378  0750 7b14          	ld	a,(OFST-4109,sp)
2379  0752 e703          	ld	(3,x),a
2380  0754 7b13          	ld	a,(OFST-4110,sp)
2381  0756 e702          	ld	(2,x),a
2382  0758 7b12          	ld	a,(OFST-4111,sp)
2383  075a e701          	ld	(1,x),a
2384  075c 7b11          	ld	a,(OFST-4112,sp)
2385  075e f7            	ld	(x),a
2387  075f 2017          	jra	L1501
2388  0761               L7401:
2389                     ; 243 					else if (isChannel1) {
2391  0761 0d1d          	tnz	(OFST-4100,sp)
2392  0763 2713          	jreq	L1501
2393                     ; 244 						*frequency = 0;  // No crossings detected, return 0 frequency
2395  0765 96            	ldw	x,sp
2396  0766 de1026        	ldw	x,(OFST+5,x)
2397  0769 a600          	ld	a,#0
2398  076b e703          	ld	(3,x),a
2399  076d a600          	ld	a,#0
2400  076f e702          	ld	(2,x),a
2401  0771 a600          	ld	a,#0
2402  0773 e701          	ld	(1,x),a
2403  0775 a600          	ld	a,#0
2404  0777 f7            	ld	(x),a
2405  0778               L1501:
2406                     ; 246 					return *amplitude;
2408  0778 96            	ldw	x,sp
2409  0779 de1028        	ldw	x,(OFST+7,x)
2410  077c 8d000000      	callf	d_ltor
2413  0780 ac410841      	jpf	L46
2414  0784               L3401:
2415                     ; 249 			lastEdgeTime = currentEdgeTime;  // Update last edge time
2417  0784 1e1b          	ldw	x,(OFST-4102,sp)
2418  0786 bf0a          	ldw	_lastEdgeTime+2,x
2419  0788 1e19          	ldw	x,(OFST-4104,sp)
2420  078a bf08          	ldw	_lastEdgeTime,x
2421  078c               L7301:
2422                     ; 254 	delay_us(1000000 / SAMPLE_RATE);
2424  078c ae1a0a        	ldw	x,#6666
2425  078f 8d000000      	callf	f_delay_us
2427                     ; 220 	for (i = 0; i < NUM_SAMPLES; i++) {
2429  0793 96            	ldw	x,sp
2430  0794 9093          	ldw	y,x
2431  0796 de1020        	ldw	x,(OFST-1,x)
2432  0799 1c0001        	addw	x,#1
2433  079c 90df1020      	ldw	(OFST-1,y),x
2436  07a0 96            	ldw	x,sp
2437  07a1 9093          	ldw	y,x
2438  07a3 90de1020      	ldw	y,(OFST-1,y)
2439  07a7 90a30400      	cpw	y,#1024
2440  07ab 2404          	jruge	L001
2441  07ad ac1a061a      	jpf	L1301
2442  07b1               L001:
2443                     ; 259 	*amplitude = calculate_amplitude(buffer, (freqCount > 0 ? count : NUM_SAMPLES));
2445  07b1 9c            	rvf
2446  07b2 5f            	clrw	x
2447  07b3 1f0f          	ldw	(OFST-4114,sp),x
2449  07b5 96            	ldw	x,sp
2450  07b6 9093          	ldw	y,x
2451  07b8 51            	exgw	x,y
2452  07b9 de101e        	ldw	x,(OFST-3,x)
2453  07bc 130f          	cpw	x,(OFST-4114,sp)
2454  07be 51            	exgw	x,y
2455  07bf 2d04          	jrsle	L06
2456  07c1 be12          	ldw	x,_count
2457  07c3 2003          	jra	L26
2458  07c5               L06:
2459  07c5 ae0400        	ldw	x,#1024
2460  07c8               L26:
2461  07c8 8d000000      	callf	d_uitolx
2463  07cc be02          	ldw	x,c_lreg+2
2464  07ce 89            	pushw	x
2465  07cf be00          	ldw	x,c_lreg
2466  07d1 89            	pushw	x
2467  07d2 96            	ldw	x,sp
2468  07d3 1c0022        	addw	x,#OFST-4095
2469  07d6 8d060506      	callf	f_calculate_amplitude
2471  07da 5b04          	addw	sp,#4
2472  07dc 96            	ldw	x,sp
2473  07dd de1028        	ldw	x,(OFST+7,x)
2474  07e0 8d000000      	callf	d_rtol
2476                     ; 262 	if (isChannel1 && freqCount > 0) {
2478  07e4 0d1d          	tnz	(OFST-4100,sp)
2479  07e6 273a          	jreq	L5501
2481  07e8 9c            	rvf
2482  07e9 5f            	clrw	x
2483  07ea 1f0f          	ldw	(OFST-4114,sp),x
2485  07ec 96            	ldw	x,sp
2486  07ed 9093          	ldw	y,x
2487  07ef 51            	exgw	x,y
2488  07f0 de101e        	ldw	x,(OFST-3,x)
2489  07f3 130f          	cpw	x,(OFST-4114,sp)
2490  07f5 51            	exgw	x,y
2491  07f6 2d2a          	jrsle	L5501
2492                     ; 263 		*frequency = freqBuff / freqCount;  // Calculate average frequency
2494  07f8 96            	ldw	x,sp
2495  07f9 de101e        	ldw	x,(OFST-3,x)
2496  07fc 8d000000      	callf	d_itof
2498  0800 96            	ldw	x,sp
2499  0801 1c000d        	addw	x,#OFST-4116
2500  0804 8d000000      	callf	d_rtol
2503  0808 96            	ldw	x,sp
2504  0809 1c0015        	addw	x,#OFST-4108
2505  080c 8d000000      	callf	d_ltor
2507  0810 96            	ldw	x,sp
2508  0811 1c000d        	addw	x,#OFST-4116
2509  0814 8d000000      	callf	d_fdiv
2511  0818 96            	ldw	x,sp
2512  0819 de1026        	ldw	x,(OFST+5,x)
2513  081c 8d000000      	callf	d_rtol
2516  0820 2017          	jra	L7501
2517  0822               L5501:
2518                     ; 265 	else if (isChannel1) {
2520  0822 0d1d          	tnz	(OFST-4100,sp)
2521  0824 2713          	jreq	L7501
2522                     ; 266 		*frequency = 0;  // No crossings detected, return 0 frequency
2524  0826 96            	ldw	x,sp
2525  0827 de1026        	ldw	x,(OFST+5,x)
2526  082a a600          	ld	a,#0
2527  082c e703          	ld	(3,x),a
2528  082e a600          	ld	a,#0
2529  0830 e702          	ld	(2,x),a
2530  0832 a600          	ld	a,#0
2531  0834 e701          	ld	(1,x),a
2532  0836 a600          	ld	a,#0
2533  0838 f7            	ld	(x),a
2534  0839               L7501:
2535                     ; 269 	return *amplitude;  // Always return amplitude
2537  0839 96            	ldw	x,sp
2538  083a de1028        	ldw	x,(OFST+7,x)
2539  083d 8d000000      	callf	d_ltor
2542  0841               L46:
2544  0841 9096          	ldw	y,sp
2545  0843 72a91022      	addw	y,#4130
2546  0847 9094          	ldw	sp,y
2547  0849 87            	retf
2581                     ; 273 float convert_adc_to_voltage(unsigned int adcValue) {
2582                     	switch	.text
2583  084a               f_convert_adc_to_voltage:
2587                     ; 274 	return adcValue * (V_REF / ADC_MAX_VALUE);
2589  084a 8d000000      	callf	d_uitof
2591  084e ae1156        	ldw	x,#L5011
2592  0851 8d000000      	callf	d_fmul
2596  0855 87            	retf
2630                     ; 278 float calculate_frequency(unsigned long period) {
2631                     	switch	.text
2632  0856               f_calculate_frequency:
2634  0856 5204          	subw	sp,#4
2635       00000004      OFST:	set	4
2638                     ; 279 	return 1.0 / (period / 1e6);  // Convert period (in microseconds) to frequency (Hz)
2640  0858 96            	ldw	x,sp
2641  0859 1c0008        	addw	x,#OFST+4
2642  085c 8d000000      	callf	d_ltor
2644  0860 8d000000      	callf	d_ultof
2646  0864 ae114e        	ldw	x,#L3411
2647  0867 8d000000      	callf	d_fdiv
2649  086b 96            	ldw	x,sp
2650  086c 1c0001        	addw	x,#OFST-3
2651  086f 8d000000      	callf	d_rtol
2654  0873 ae1152        	ldw	x,#L3311
2655  0876 8d000000      	callf	d_ltor
2657  087a 96            	ldw	x,sp
2658  087b 1c0001        	addw	x,#OFST-3
2659  087e 8d000000      	callf	d_fdiv
2663  0882 5b04          	addw	sp,#4
2664  0884 87            	retf
2728                     ; 283 void output_results(float frequency, float amplitude, float FDR_Voltage) {
2729                     	switch	.text
2730  0885               f_output_results:
2732  0885 5228          	subw	sp,#40
2733       00000028      OFST:	set	40
2736                     ; 287 	sprintf(buffer, "%.3f,%.3f,%.3f,%.3f,0\n", frequency, amplitude, amplitude/4.7, FDR_Voltage);
2738  0887 1e36          	ldw	x,(OFST+14,sp)
2739  0889 89            	pushw	x
2740  088a 1e36          	ldw	x,(OFST+14,sp)
2741  088c 89            	pushw	x
2742  088d 96            	ldw	x,sp
2743  088e 1c0034        	addw	x,#OFST+12
2744  0891 8d000000      	callf	d_ltor
2746  0895 ae12af        	ldw	x,#L571
2747  0898 8d000000      	callf	d_fdiv
2749  089c be02          	ldw	x,c_lreg+2
2750  089e 89            	pushw	x
2751  089f be00          	ldw	x,c_lreg
2752  08a1 89            	pushw	x
2753  08a2 1e3a          	ldw	x,(OFST+18,sp)
2754  08a4 89            	pushw	x
2755  08a5 1e3a          	ldw	x,(OFST+18,sp)
2756  08a7 89            	pushw	x
2757  08a8 1e3a          	ldw	x,(OFST+18,sp)
2758  08aa 89            	pushw	x
2759  08ab 1e3a          	ldw	x,(OFST+18,sp)
2760  08ad 89            	pushw	x
2761  08ae ae1137        	ldw	x,#L1021
2762  08b1 89            	pushw	x
2763  08b2 96            	ldw	x,sp
2764  08b3 1c0013        	addw	x,#OFST-21
2765  08b6 8d000000      	callf	f_sprintf
2767  08ba 5b12          	addw	sp,#18
2768                     ; 290 	printf("%s", buffer);
2770  08bc 96            	ldw	x,sp
2771  08bd 1c0001        	addw	x,#OFST-39
2772  08c0 89            	pushw	x
2773  08c1 ae12ac        	ldw	x,#L102
2774  08c4 8d000000      	callf	f_printf
2776  08c8 85            	popw	x
2777                     ; 291 	UART1_SendString(buffer);
2779  08c9 96            	ldw	x,sp
2780  08ca 1c0001        	addw	x,#OFST-39
2781  08cd 8d000000      	callf	f_UART1_SendString
2783                     ; 293 }
2786  08d1 5b28          	addw	sp,#40
2787  08d3 87            	retf
2844                     ; 296 void logResults(const char *logMessage) {
2845                     	switch	.text
2846  08d4               f_logResults:
2848  08d4 89            	pushw	x
2849  08d5 5278          	subw	sp,#120
2850       00000078      OFST:	set	120
2853                     ; 301 	sprintDateTime(datetimeBuffer);
2855  08d7 96            	ldw	x,sp
2856  08d8 1c0001        	addw	x,#OFST-119
2857  08db 8d000000      	callf	f_sprintDateTime
2859                     ; 304 	sprintf(logBuffer, "%s - %s", datetimeBuffer, logMessage);
2861  08df 1e79          	ldw	x,(OFST+1,sp)
2862  08e1 89            	pushw	x
2863  08e2 96            	ldw	x,sp
2864  08e3 1c0003        	addw	x,#OFST-117
2865  08e6 89            	pushw	x
2866  08e7 ae112f        	ldw	x,#L1321
2867  08ea 89            	pushw	x
2868  08eb 96            	ldw	x,sp
2869  08ec 1c001b        	addw	x,#OFST-93
2870  08ef 8d000000      	callf	f_sprintf
2872  08f3 5b06          	addw	sp,#6
2873                     ; 305 	log_to_eeprom(logBuffer);
2875  08f5 96            	ldw	x,sp
2876  08f6 1c0015        	addw	x,#OFST-99
2877  08f9 8d000000      	callf	f_log_to_eeprom
2879                     ; 307 }
2882  08fd 5b7a          	addw	sp,#122
2883  08ff 87            	retf
2919                     ; 310 void send_square_pulse(uint16_t duration_ms) {
2920                     	switch	.text
2921  0900               f_send_square_pulse:
2923  0900 89            	pushw	x
2924       00000000      OFST:	set	0
2927                     ; 311 	GPIO_WriteHigh(SER_THYRISTOR); // Set square pulse pin high
2929  0901 4b04          	push	#4
2930  0903 ae500a        	ldw	x,#20490
2931  0906 8d000000      	callf	f_GPIO_WriteHigh
2933  090a 84            	pop	a
2934                     ; 312 	delay_ms(duration_ms);            // Wait for the pulse duration
2936  090b 1e01          	ldw	x,(OFST+1,sp)
2937  090d 8d000000      	callf	f_delay_ms
2939                     ; 313 	GPIO_WriteLow(SER_THYRISTOR); // Set square pulse pin low
2941  0911 4b04          	push	#4
2942  0913 ae500a        	ldw	x,#20490
2943  0916 8d000000      	callf	f_GPIO_WriteLow
2945  091a 84            	pop	a
2946                     ; 314 }
2949  091b 85            	popw	x
2950  091c 87            	retf
2977                     ; 316 void handle_commutation_pulse(void) {
2978                     	switch	.text
2979  091d               f_handle_commutation_pulse:
2983                     ; 317 	GPIO_WriteHigh(COM_THYRISTOR); // Set square pulse pin high
2985  091d 4b02          	push	#2
2986  091f ae500a        	ldw	x,#20490
2987  0922 8d000000      	callf	f_GPIO_WriteHigh
2989  0926 84            	pop	a
2990                     ; 318 	delay_ms(3000);            // Wait for the pulse duration
2992  0927 ae0bb8        	ldw	x,#3000
2993  092a 8d000000      	callf	f_delay_ms
2995                     ; 319 	GPIO_WriteLow(COM_THYRISTOR); // Set square pulse pin low
2997  092e 4b02          	push	#2
2998  0930 ae500a        	ldw	x,#20490
2999  0933 8d000000      	callf	f_GPIO_WriteLow
3001  0937 84            	pop	a
3002                     ; 320 	GPIO_WriteHigh(LED_ORANGE); // Turn on LED ORANGE
3004  0938 4b08          	push	#8
3005  093a ae500f        	ldw	x,#20495
3006  093d 8d000000      	callf	f_GPIO_WriteHigh
3008  0941 84            	pop	a
3009                     ; 321 	printf("Commutation Thyristor Pulse Sent\n");
3011  0942 ae110d        	ldw	x,#L1621
3012  0945 8d000000      	callf	f_printf
3014                     ; 322 }
3017  0949 87            	retf
3053                     ; 324 bool check_FDR_amplitude(void) {
3054                     	switch	.text
3055  094a               f_check_FDR_amplitude:
3057  094a 5204          	subw	sp,#4
3058       00000004      OFST:	set	4
3061                     ; 325     float FDR_amplitude = 0;
3063  094c ae0000        	ldw	x,#0
3064  094f 1f03          	ldw	(OFST-1,sp),x
3065  0951 ae0000        	ldw	x,#0
3066  0954 1f01          	ldw	(OFST-3,sp),x
3068                     ; 326     FDR_amplitude = process_adc_signal(FDR_SIGNAL, NULL, &FDR_amplitude);
3070  0956 96            	ldw	x,sp
3071  0957 1c0001        	addw	x,#OFST-3
3072  095a 89            	pushw	x
3073  095b 5f            	clrw	x
3074  095c 89            	pushw	x
3075  095d a606          	ld	a,#6
3076  095f 8dd105d1      	callf	f_process_adc_signal
3078  0963 5b04          	addw	sp,#4
3079  0965 96            	ldw	x,sp
3080  0966 1c0001        	addw	x,#OFST-3
3081  0969 8d000000      	callf	d_rtol
3084                     ; 327     return (FDR_amplitude != 0); // Returns true if FDR_amplitude is non-zero
3086  096d 9c            	rvf
3087  096e 0d01          	tnz	(OFST-3,sp)
3088  0970 2704          	jreq	L021
3089  0972 a601          	ld	a,#1
3090  0974 2001          	jra	L221
3091  0976               L021:
3092  0976 4f            	clr	a
3093  0977               L221:
3096  0977 5b04          	addw	sp,#4
3097  0979 87            	retf
3132                     ; 331 bool check_signal_dc(float amplitude) {
3133                     	switch	.text
3134  097a               f_check_signal_dc:
3136       00000000      OFST:	set	0
3139                     ; 332 	if (amplitude < 0.5) {
3141  097a 9c            	rvf
3142  097b 96            	ldw	x,sp
3143  097c 1c0004        	addw	x,#OFST+4
3144  097f 8d000000      	callf	d_ltor
3146  0983 ae1189        	ldw	x,#L155
3147  0986 8d000000      	callf	d_fcmp
3149  098a 2e07          	jrsge	L7131
3150                     ; 333 		isThyristorON = true;
3152  098c 35010014      	mov	_isThyristorON,#1
3153                     ; 334 		return true;
3155  0990 a601          	ld	a,#1
3158  0992 87            	retf
3159  0993               L7131:
3160                     ; 336 		isThyristorON = false;
3162  0993 3f14          	clr	_isThyristorON
3163                     ; 337 		return false;
3165  0995 4f            	clr	a
3168  0996 87            	retf
3215                     ; 341 void read_set_frequency(float *set_freq) {
3216                     	switch	.text
3217  0997               f_read_set_frequency:
3219  0997 89            	pushw	x
3220  0998 521e          	subw	sp,#30
3221       0000001e      OFST:	set	30
3224                     ; 343 	internal_EEPROM_ReadStr(0x4000, setFreqString,  sizeof(setFreqString));
3226  099a ae001e        	ldw	x,#30
3227  099d 89            	pushw	x
3228  099e 96            	ldw	x,sp
3229  099f 1c0003        	addw	x,#OFST-27
3230  09a2 89            	pushw	x
3231  09a3 ae4000        	ldw	x,#16384
3232  09a6 89            	pushw	x
3233  09a7 ae0000        	ldw	x,#0
3234  09aa 89            	pushw	x
3235  09ab 8dd10ad1      	callf	f_internal_EEPROM_ReadStr
3237  09af 5b08          	addw	sp,#8
3238                     ; 344 	printf("String read from EEPROM: %s\n\r", setFreqString);
3240  09b1 96            	ldw	x,sp
3241  09b2 1c0001        	addw	x,#OFST-29
3242  09b5 89            	pushw	x
3243  09b6 ae10ef        	ldw	x,#L5431
3244  09b9 8d000000      	callf	f_printf
3246  09bd 85            	popw	x
3247                     ; 345 	*set_freq = ConvertStringToFloat(setFreqString);
3249  09be 96            	ldw	x,sp
3250  09bf 1c0001        	addw	x,#OFST-29
3251  09c2 8d000000      	callf	f_ConvertStringToFloat
3253  09c6 1e1f          	ldw	x,(OFST+1,sp)
3254  09c8 8d000000      	callf	d_rtol
3256                     ; 346 	printf("New set_freq: %f\n", *set_freq);
3258  09cc 1e1f          	ldw	x,(OFST+1,sp)
3259  09ce 9093          	ldw	y,x
3260  09d0 ee02          	ldw	x,(2,x)
3261  09d2 89            	pushw	x
3262  09d3 93            	ldw	x,y
3263  09d4 fe            	ldw	x,(x)
3264  09d5 89            	pushw	x
3265  09d6 ae10dd        	ldw	x,#L7431
3266  09d9 8d000000      	callf	f_printf
3268  09dd 5b04          	addw	sp,#4
3269                     ; 347 }
3272  09df 5b20          	addw	sp,#32
3273  09e1 87            	retf
3323                     ; 349 void  config_mode(void){
3324                     	switch	.text
3325  09e2               f_config_mode:
3327  09e2 522c          	subw	sp,#44
3328       0000002c      OFST:	set	44
3331                     ; 351   float value = 0;
3333  09e4               L3731:
3334                     ; 356 		if (GPIO_ReadInputPin(GPIOA, GPIO_PIN_6) == RESET) {
3336  09e4 4b40          	push	#64
3337  09e6 ae5000        	ldw	x,#20480
3338  09e9 8d000000      	callf	f_GPIO_ReadInputPin
3340  09ed 5b01          	addw	sp,#1
3341  09ef 4d            	tnz	a
3342  09f0 2603          	jrne	L7731
3343                     ; 358 			return;
3346  09f2 5b2c          	addw	sp,#44
3347  09f4 87            	retf
3348  09f5               L7731:
3349                     ; 361 		printf("Entering Config Mode!\n");
3351  09f5 ae10c6        	ldw	x,#L1041
3352  09f8 8d000000      	callf	f_printf
3354                     ; 362 		printf("Enter the Command!\n");
3356  09fc ae10b2        	ldw	x,#L3041
3357  09ff 8d000000      	callf	f_printf
3359                     ; 363 		UART3_ClearBuffer();
3361  0a03 8d000000      	callf	f_UART3_ClearBuffer
3363                     ; 364 		UART3_ReceiveString(buffer, sizeof(buffer)); // Receive the first string via UART
3365  0a07 ae0028        	ldw	x,#40
3366  0a0a 89            	pushw	x
3367  0a0b 96            	ldw	x,sp
3368  0a0c 1c0007        	addw	x,#OFST-37
3369  0a0f 8d000000      	callf	f_UART3_ReceiveString
3371  0a13 85            	popw	x
3372                     ; 366 		if (strcmp(buffer, "set") == 0) {
3374  0a14 ae10ae        	ldw	x,#L7041
3375  0a17 89            	pushw	x
3376  0a18 96            	ldw	x,sp
3377  0a19 1c0007        	addw	x,#OFST-37
3378  0a1c 8d000000      	callf	f_strcmp
3380  0a20 5b02          	addw	sp,#2
3381  0a22 a30000        	cpw	x,#0
3382  0a25 2630          	jrne	L5041
3383                     ; 368 			printf("SET Command Received. Waiting for new parameter...\n");
3385  0a27 ae107a        	ldw	x,#L1141
3386  0a2a 8d000000      	callf	f_printf
3388                     ; 369 			UART3_ReceiveString(buffer, sizeof(buffer)); // Receive the parameter string
3390  0a2e ae0028        	ldw	x,#40
3391  0a31 89            	pushw	x
3392  0a32 96            	ldw	x,sp
3393  0a33 1c0007        	addw	x,#OFST-37
3394  0a36 8d000000      	callf	f_UART3_ReceiveString
3396  0a3a 85            	popw	x
3397                     ; 371 			printf("123456789\n");
3399  0a3b ae106f        	ldw	x,#L3141
3400  0a3e 8d000000      	callf	f_printf
3402                     ; 373 			internal_EEPROM_WriteStr(0x4000, buffer); // Example address for storing string
3404  0a42 96            	ldw	x,sp
3405  0a43 1c0005        	addw	x,#OFST-39
3406  0a46 89            	pushw	x
3407  0a47 ae4000        	ldw	x,#16384
3408  0a4a 89            	pushw	x
3409  0a4b ae0000        	ldw	x,#0
3410  0a4e 89            	pushw	x
3411  0a4f 8d910a91      	callf	f_internal_EEPROM_WriteStr
3413  0a53 5b06          	addw	sp,#6
3415  0a55 208d          	jra	L3731
3416  0a57               L5041:
3417                     ; 379 		} else if (strcmp(buffer, "ready") == 0) {
3419  0a57 ae1069        	ldw	x,#L1241
3420  0a5a 89            	pushw	x
3421  0a5b 96            	ldw	x,sp
3422  0a5c 1c0007        	addw	x,#OFST-37
3423  0a5f 8d000000      	callf	f_strcmp
3425  0a63 5b02          	addw	sp,#2
3426  0a65 a30000        	cpw	x,#0
3427  0a68 2616          	jrne	L7141
3428                     ; 381 			printf("READ Command Received. Reading stored values...\n");
3430  0a6a ae1038        	ldw	x,#L3241
3431  0a6d 8d000000      	callf	f_printf
3433                     ; 383 			process_eeprom_logs(); // Example EEPROM address
3435  0a71 8d000000      	callf	f_process_eeprom_logs
3437                     ; 384 			printf("Finished Reading EEPROM!\n");
3439  0a75 ae101e        	ldw	x,#L5241
3440  0a78 8d000000      	callf	f_printf
3443  0a7c ace409e4      	jpf	L3731
3444  0a80               L7141:
3445                     ; 388 			printf("Invalid Command Received: %s\n", buffer);
3447  0a80 96            	ldw	x,sp
3448  0a81 1c0005        	addw	x,#OFST-39
3449  0a84 89            	pushw	x
3450  0a85 ae1000        	ldw	x,#L1341
3451  0a88 8d000000      	callf	f_printf
3453  0a8c 85            	popw	x
3454  0a8d ace409e4      	jpf	L3731
3499                     ; 393 void internal_EEPROM_WriteStr(uint32_t address, char *str) {
3500                     	switch	.text
3501  0a91               f_internal_EEPROM_WriteStr:
3503       00000000      OFST:	set	0
3506  0a91 202a          	jra	L7541
3507  0a93               L5541:
3508                     ; 395 		FLASH_ProgramByte(address++, (uint8_t)(*str++));
3510  0a93 1e08          	ldw	x,(OFST+8,sp)
3511  0a95 1c0001        	addw	x,#1
3512  0a98 1f08          	ldw	(OFST+8,sp),x
3513  0a9a 1d0001        	subw	x,#1
3514  0a9d f6            	ld	a,(x)
3515  0a9e 88            	push	a
3516  0a9f 96            	ldw	x,sp
3517  0aa0 1c0005        	addw	x,#OFST+5
3518  0aa3 8d000000      	callf	d_ltor
3520  0aa7 96            	ldw	x,sp
3521  0aa8 1c0005        	addw	x,#OFST+5
3522  0aab a601          	ld	a,#1
3523  0aad 8d000000      	callf	d_lgadc
3525  0ab1 be02          	ldw	x,c_lreg+2
3526  0ab3 89            	pushw	x
3527  0ab4 be00          	ldw	x,c_lreg
3528  0ab6 89            	pushw	x
3529  0ab7 8d000000      	callf	f_FLASH_ProgramByte
3531  0abb 5b05          	addw	sp,#5
3532  0abd               L7541:
3533                     ; 394 	while (*str) {
3535  0abd 1e08          	ldw	x,(OFST+8,sp)
3536  0abf 7d            	tnz	(x)
3537  0ac0 26d1          	jrne	L5541
3538                     ; 397 	FLASH_ProgramByte(address, '\0'); // Write a null terminator
3540  0ac2 4b00          	push	#0
3541  0ac4 1e07          	ldw	x,(OFST+7,sp)
3542  0ac6 89            	pushw	x
3543  0ac7 1e07          	ldw	x,(OFST+7,sp)
3544  0ac9 89            	pushw	x
3545  0aca 8d000000      	callf	f_FLASH_ProgramByte
3547  0ace 5b05          	addw	sp,#5
3548                     ; 398 }
3551  0ad0 87            	retf
3623                     ; 400 void internal_EEPROM_ReadStr(uint32_t address, char *buffer, uint16_t max_length) {
3624                     	switch	.text
3625  0ad1               f_internal_EEPROM_ReadStr:
3627  0ad1 5203          	subw	sp,#3
3628       00000003      OFST:	set	3
3631                     ; 401 	uint16_t i = 0;
3633  0ad3 5f            	clrw	x
3634  0ad4 1f01          	ldw	(OFST-2,sp),x
3637  0ad6 203d          	jra	L5251
3638  0ad8               L1251:
3639                     ; 405 		c = (char)FLASH_ReadByte(address++); // Read a byte
3641  0ad8 96            	ldw	x,sp
3642  0ad9 1c0007        	addw	x,#OFST+4
3643  0adc 8d000000      	callf	d_ltor
3645  0ae0 96            	ldw	x,sp
3646  0ae1 1c0007        	addw	x,#OFST+4
3647  0ae4 a601          	ld	a,#1
3648  0ae6 8d000000      	callf	d_lgadc
3650  0aea be02          	ldw	x,c_lreg+2
3651  0aec 89            	pushw	x
3652  0aed be00          	ldw	x,c_lreg
3653  0aef 89            	pushw	x
3654  0af0 8d000000      	callf	f_FLASH_ReadByte
3656  0af4 5b04          	addw	sp,#4
3657  0af6 6b03          	ld	(OFST+0,sp),a
3659                     ; 406 		if (c == '\0') {
3661  0af8 0d03          	tnz	(OFST+0,sp)
3662  0afa 2609          	jrne	L1351
3663                     ; 407 				break; // Stop if null terminator is encountered
3664  0afc               L7251:
3665                     ; 411 	buffer[i] = '\0'; // Null-terminate the string
3667  0afc 1e0b          	ldw	x,(OFST+8,sp)
3668  0afe 72fb01        	addw	x,(OFST-2,sp)
3669  0b01 7f            	clr	(x)
3670                     ; 412 }
3673  0b02 5b03          	addw	sp,#3
3674  0b04 87            	retf
3675  0b05               L1351:
3676                     ; 409 		buffer[i++] = c; // Store the character in the buffer
3678  0b05 7b03          	ld	a,(OFST+0,sp)
3679  0b07 1e01          	ldw	x,(OFST-2,sp)
3680  0b09 1c0001        	addw	x,#1
3681  0b0c 1f01          	ldw	(OFST-2,sp),x
3682  0b0e 1d0001        	subw	x,#1
3684  0b11 72fb0b        	addw	x,(OFST+8,sp)
3685  0b14 f7            	ld	(x),a
3686  0b15               L5251:
3687                     ; 404 	while (i < max_length - 1) {
3689  0b15 1e0d          	ldw	x,(OFST+10,sp)
3690  0b17 5a            	decw	x
3691  0b18 1301          	cpw	x,(OFST-2,sp)
3692  0b1a 22bc          	jrugt	L1251
3693  0b1c 20de          	jra	L7251
3716                     	xdef	f_main
3717                     	xdef	_set_freq
3718                     	xdef	f_internal_EEPROM_WriteStr
3719                     	xdef	f_internal_EEPROM_ReadStr
3720                     	xdef	f_handle_commutation_pulse
3721                     	xdef	f_check_FDR_amplitude
3722                     	xdef	f_handle_signal_1_AC
3723                     	xdef	f_wait_for_negative_zero_crossing
3724                     	xdef	f_handle_Frequency_Below_Set_Freq
3725                     	xdef	f_process_VAR_signal
3726                     	xdef	f_process_FDR_signal
3727                     	xdef	f_logResults
3728                     	xdef	f_config_mode
3729                     	xdef	f_read_set_frequency
3730                     	xdef	f_calculate_frequency
3731                     	xdef	f_convert_adc_to_voltage
3732                     	xdef	f_process_adc_signal
3733                     	xdef	f_calculate_amplitude
3734                     	xdef	f_output_results
3735                     	xdef	f_initialize_adc_buffer
3736                     	xdef	f_check_signal_dc
3737                     	xdef	f_send_square_pulse
3738                     	xdef	f_check_negative_zero_crossing
3739                     	xdef	f_detect_negative_zero_cross
3740                     	xdef	f_detectZeroCross
3741                     	xdef	f_detectPosZeroCross
3742                     	xdef	f_initialize_system
3743                     	xdef	_isThyristorON
3744                     	xdef	_count
3745                     	xdef	_crossingType
3746                     	xdef	_currentEdgeTime
3747                     	xdef	_lastEdgeTime
3748                     	xdef	_sine1_amplitude
3749                     	xdef	_sine1_frequency
3750                     	xref	f_ConvertStringToFloat
3751                     	xref	f_sprintDateTime
3752                     	xref	f_read_ADC_Channel
3753                     	xref	f_UART1_SendString
3754                     	xref	f_UART1_setup
3755                     	xref	f_UART3_ReceiveString
3756                     	xref	f_UART3_ClearBuffer
3757                     	xref	f_internal_EEPROM_Setup
3758                     	xref	f_GPIO_setup
3759                     	xref	f_ADC2_setup
3760                     	xref	f_UART3_setup
3761                     	xref	f_clock_setup
3762                     	xref	f_FLASH_ReadByte
3763                     	xref	f_FLASH_ProgramByte
3764                     	xref	f_I2CInit
3765                     	xref	f_log_to_eeprom
3766                     	xref	f_process_eeprom_logs
3767                     	xref	f_EEPROM_Config
3768                     	xref	f_strcmp
3769                     	xref	f_micros
3770                     	xref	f_delay_us
3771                     	xref	f_delay_ms
3772                     	xref	f_TIM4_Config
3773                     	xref	f_sprintf
3774                     	xref	f_printf
3775                     	xref	f_GPIO_ReadInputPin
3776                     	xref	f_GPIO_WriteLow
3777                     	xref	f_GPIO_WriteHigh
3778                     	switch	.const
3779  1000               L1341:
3780  1000 496e76616c69  	dc.b	"Invalid Command Re"
3781  1012 636569766564  	dc.b	"ceived: %s",10,0
3782  101e               L5241:
3783  101e 46696e697368  	dc.b	"Finished Reading E"
3784  1030 4550524f4d21  	dc.b	"EPROM!",10,0
3785  1038               L3241:
3786  1038 524541442043  	dc.b	"READ Command Recei"
3787  104a 7665642e2052  	dc.b	"ved. Reading store"
3788  105c 642076616c75  	dc.b	"d values...",10,0
3789  1069               L1241:
3790  1069 726561647900  	dc.b	"ready",0
3791  106f               L3141:
3792  106f 313233343536  	dc.b	"123456789",10,0
3793  107a               L1141:
3794  107a 53455420436f  	dc.b	"SET Command Receiv"
3795  108c 65642e205761  	dc.b	"ed. Waiting for ne"
3796  109e 772070617261  	dc.b	"w parameter...",10,0
3797  10ae               L7041:
3798  10ae 73657400      	dc.b	"set",0
3799  10b2               L3041:
3800  10b2 456e74657220  	dc.b	"Enter the Command!"
3801  10c4 0a00          	dc.b	10,0
3802  10c6               L1041:
3803  10c6 456e74657269  	dc.b	"Entering Config Mo"
3804  10d8 6465210a00    	dc.b	"de!",10,0
3805  10dd               L7431:
3806  10dd 4e6577207365  	dc.b	"New set_freq: %f",10,0
3807  10ef               L5431:
3808  10ef 537472696e67  	dc.b	"String read from E"
3809  1101 4550524f4d3a  	dc.b	"EPROM: %s",10
3810  110b 0d00          	dc.b	13,0
3811  110d               L1621:
3812  110d 436f6d6d7574  	dc.b	"Commutation Thyris"
3813  111f 746f72205075  	dc.b	"tor Pulse Sent",10,0
3814  112f               L1321:
3815  112f 2573202d2025  	dc.b	"%s - %s",0
3816  1137               L1021:
3817  1137 252e33662c25  	dc.b	"%.3f,%.3f,%.3f,%.3"
3818  1149 662c300a00    	dc.b	"f,0",10,0
3819  114e               L3411:
3820  114e 49742400      	dc.w	18804,9216
3821  1152               L3311:
3822  1152 3f800000      	dc.w	16256,0
3823  1156               L5011:
3824  1156 3b933333      	dc.w	15251,13107
3825  115a               L166:
3826  115a c0933333      	dc.w	-16237,13107
3827  115e               L176:
3828  115e 40933333      	dc.w	16531,13107
3829  1162               L516:
3830  1162 204e65676174  	dc.b	" Negative zero cro"
3831  1174 7373696e6720  	dc.b	"ssing detected!",10,0
3832  1185               L116:
3833  1185 3f8ccccc      	dc.w	16268,-13108
3834  1189               L155:
3835  1189 3f000000      	dc.w	16128,0
3836  118d               L504:
3837  118d 566172416d70  	dc.b	"VarAmplitude Not b"
3838  119f 656c6f772031  	dc.b	"elow 10 mv.",10,0
3839  11ac               L304:
3840  11ac 25302e303030  	dc.b	"%0.000,%.3f,%.3f,%"
3841  11be 2e33662c310a  	dc.b	".3f,1",10,0
3842  11c5               L773:
3843  11c5 566172416d70  	dc.b	"VarAmplitude below"
3844  11d7 203130206d76  	dc.b	" 10 mv.",10,0
3845  11e0               L373:
3846  11e0 3d4ccccc      	dc.w	15692,-13108
3847  11e4               L143:
3848  11e4 5369676e616c  	dc.b	"Signal 1 AC and Va"
3849  11f6 72416d706c69  	dc.b	"rAmplitude: %f.",10,0
3850  1207               L533:
3851  1207 5369676e616c  	dc.b	"Signal 1 DC.",10,0
3852  1215               L133:
3853  1215 53656e64696e  	dc.b	"Sending Square Pul"
3854  1227 73652e0a00    	dc.b	"se.",10,0
3855  122c               L762:
3856  122c 252e33662c25  	dc.b	"%.3f,%.3f,%.3f,%.3"
3857  123e 662c310a00    	dc.b	"f,1",10,0
3858  1243               L562:
3859  1243 467265717565  	dc.b	"Frequency Below Se"
3860  1255 742046726571  	dc.b	"t Frequency.",10,0
3861  1263               L162:
3862  1263 40a00000      	dc.w	16544,0
3863  1267               L152:
3864  1267 204672657175  	dc.b	" Frequency: %.3f, "
3865  1279 416d706c6974  	dc.b	"Amplitude: %.3f, C"
3866  128b 757272656e74  	dc.b	"urrent: %.3f, FDR_"
3867  129d 566f6c746167  	dc.b	"Voltage: %.3f",10,0
3868  12ac               L102:
3869  12ac 257300        	dc.b	"%s",0
3870  12af               L571:
3871  12af 40966666      	dc.w	16534,26214
3872  12b3               L761:
3873  12b3 302e3030302c  	dc.b	"0.000,%.3f,%.3f,%."
3874  12c5 33662c310a00  	dc.b	"3f,1",10,0
3875  12cb               L331:
3876  12cb 53797374656d  	dc.b	"System Initializat"
3877  12dd 696f6e20436f  	dc.b	"ion Completed",10
3878  12eb 0d00          	dc.b	13,0
3879  12ed               L121:
3880  12ed 46445220566f  	dc.b	"FDR Voltage Exists"
3881  12ff 0a00          	dc.b	10,0
3882  1301               L701:
3883  1301 00000000      	dc.w	0,0
3884                     	xref.b	c_lreg
3885                     	xref.b	c_x
3886                     	xref.b	c_y
3906                     	xref	d_ultof
3907                     	xref	d_fmul
3908                     	xref	d_uitof
3909                     	xref	d_uitolx
3910                     	xref	d_lsub
3911                     	xref	d_lzmp
3912                     	xref	d_xymovl
3913                     	xref	d_itof
3914                     	xref	d_fsub
3915                     	xref	d_lcmp
3916                     	xref	d_lgadc
3917                     	xref	d_fcmp
3918                     	xref	d_fdiv
3919                     	xref	d_ltor
3920                     	xref	d_rtol
3921                     	end
