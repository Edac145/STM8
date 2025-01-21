   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _lastEdgeTime:
  16  0000 00000000      	dc.l	0
  17  0004               _currentEdgeTime:
  18  0004 00000000      	dc.l	0
  19  0008               _sine1_frequency:
  20  0008 00000000      	dc.w	0,0
 124                     ; 33 void main()
 124                     ; 34 {
 126                     	switch	.text
 127  0000               _main:
 129  0000 5279          	subw	sp,#121
 130       00000079      OFST:	set	121
 133                     ; 35 	unsigned int A0 = 0x0000; // ADC Channel 0 Value
 135                     ; 36 	unsigned int A1 = 0x0000; // ADC Channel 1 Value
 137                     ; 39 	clock_setup();
 139  0002 ad17          	call	_clock_setup
 141                     ; 40 	ADC2_setup();
 143  0004 ad76          	call	_ADC2_setup
 145                     ; 41 	UART1_setup();
 147  0006 cd021c        	call	_UART1_setup
 149  0009               L75:
 150                     ; 44 		unsigned char length = UART1_ReceiveString(rxBuffer); // Receive the string
 152  0009 96            	ldw	x,sp
 153  000a 1c0016        	addw	x,#OFST-99
 154  000d cd025c        	call	_UART1_ReceiveString
 156                     ; 46 	 struct sineWave obj = adc_sampling();
 158  0010 96            	ldw	x,sp
 159  0011 1c000a        	addw	x,#OFST-111
 160  0014 89            	pushw	x
 161  0015 cd00ba        	call	_adc_sampling
 163  0018 85            	popw	x
 165  0019 20ee          	jra	L75
 198                     ; 52 void clock_setup(void)
 198                     ; 53 {
 199                     	switch	.text
 200  001b               _clock_setup:
 204                     ; 54      CLK_DeInit();
 206  001b cd0000        	call	_CLK_DeInit
 208                     ; 56      CLK_HSECmd(DISABLE); 
 210  001e 4f            	clr	a
 211  001f cd0000        	call	_CLK_HSECmd
 213                     ; 57      CLK_LSICmd(DISABLE);
 215  0022 4f            	clr	a
 216  0023 cd0000        	call	_CLK_LSICmd
 218                     ; 58      CLK_HSICmd(ENABLE);
 220  0026 a601          	ld	a,#1
 221  0028 cd0000        	call	_CLK_HSICmd
 224  002b               L57:
 225                     ; 59      while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 227  002b ae0102        	ldw	x,#258
 228  002e cd0000        	call	_CLK_GetFlagStatus
 230  0031 4d            	tnz	a
 231  0032 27f7          	jreq	L57
 232                     ; 61      CLK_ClockSwitchCmd(ENABLE);
 234  0034 a601          	ld	a,#1
 235  0036 cd0000        	call	_CLK_ClockSwitchCmd
 237                     ; 62      CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 239  0039 4f            	clr	a
 240  003a cd0000        	call	_CLK_HSIPrescalerConfig
 242                     ; 63      CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 244  003d a680          	ld	a,#128
 245  003f cd0000        	call	_CLK_SYSCLKConfig
 247                     ; 64 		 CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 247                     ; 65      DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 249  0042 4b01          	push	#1
 250  0044 4b00          	push	#0
 251  0046 ae01e1        	ldw	x,#481
 252  0049 cd0000        	call	_CLK_ClockSwitchConfig
 254  004c 85            	popw	x
 255                     ; 67      CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 257  004d ae0100        	ldw	x,#256
 258  0050 cd0000        	call	_CLK_PeripheralClockConfig
 260                     ; 68      CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 262  0053 5f            	clrw	x
 263  0054 cd0000        	call	_CLK_PeripheralClockConfig
 265                     ; 69      CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 267  0057 ae1300        	ldw	x,#4864
 268  005a cd0000        	call	_CLK_PeripheralClockConfig
 270                     ; 70      CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 272  005d ae1200        	ldw	x,#4608
 273  0060 cd0000        	call	_CLK_PeripheralClockConfig
 275                     ; 71      CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 277  0063 ae0200        	ldw	x,#512
 278  0066 cd0000        	call	_CLK_PeripheralClockConfig
 280                     ; 72      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 282  0069 ae0700        	ldw	x,#1792
 283  006c cd0000        	call	_CLK_PeripheralClockConfig
 285                     ; 73      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 287  006f ae0500        	ldw	x,#1280
 288  0072 cd0000        	call	_CLK_PeripheralClockConfig
 290                     ; 74      CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 292  0075 ae0401        	ldw	x,#1025
 293  0078 cd0000        	call	_CLK_PeripheralClockConfig
 295                     ; 75 }
 298  007b 81            	ret
 324                     ; 77 void ADC2_setup(void)
 324                     ; 78 {
 325                     	switch	.text
 326  007c               _ADC2_setup:
 330                     ; 79    ADC2_DeInit();         
 332  007c cd0000        	call	_ADC2_DeInit
 334                     ; 81    ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, 
 334                     ; 82              ADC2_CHANNEL_0,
 334                     ; 83              ADC2_PRESSEL_FCPU_D18, 
 334                     ; 84              ADC2_EXTTRIG_GPIO, 
 334                     ; 85              DISABLE, 
 334                     ; 86              ADC2_ALIGN_RIGHT, 
 334                     ; 87              ADC2_SCHMITTTRIG_CHANNEL0 | ADC2_SCHMITTTRIG_CHANNEL1, 
 334                     ; 88              DISABLE);
 336  007f 4b00          	push	#0
 337  0081 4b01          	push	#1
 338  0083 4b08          	push	#8
 339  0085 4b00          	push	#0
 340  0087 4b01          	push	#1
 341  0089 4b70          	push	#112
 342  008b ae0100        	ldw	x,#256
 343  008e cd0000        	call	_ADC2_Init
 345  0091 5b06          	addw	sp,#6
 346                     ; 91    ADC2_Cmd(ENABLE);
 348  0093 a601          	ld	a,#1
 349  0095 cd0000        	call	_ADC2_Cmd
 351                     ; 92 }
 354  0098 81            	ret
 402                     ; 94 unsigned int ADC_Conversion(uint8_t adcChannel)
 402                     ; 95 {
 403                     	switch	.text
 404  0099               _ADC_Conversion:
 406  0099 89            	pushw	x
 407       00000002      OFST:	set	2
 410                     ; 96 	unsigned int adcValue = 0;
 412                     ; 98 	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, 
 412                     ; 99 												adcChannel, 
 412                     ; 100 												ADC2_ALIGN_RIGHT);
 414  009a 4b08          	push	#8
 415  009c ae0100        	ldw	x,#256
 416  009f 97            	ld	xl,a
 417  00a0 cd0000        	call	_ADC2_ConversionConfig
 419  00a3 84            	pop	a
 420                     ; 101 	ADC2_StartConversion();
 422  00a4 cd0000        	call	_ADC2_StartConversion
 425  00a7               L531:
 426                     ; 102 	while (ADC2_GetFlagStatus() == FALSE);
 428  00a7 cd0000        	call	_ADC2_GetFlagStatus
 430  00aa 4d            	tnz	a
 431  00ab 27fa          	jreq	L531
 432                     ; 103 	adcValue = ADC2_GetConversionValue();
 434  00ad cd0000        	call	_ADC2_GetConversionValue
 436  00b0 1f01          	ldw	(OFST-1,sp),x
 438                     ; 104 	ADC2_ClearFlag();
 440  00b2 cd0000        	call	_ADC2_ClearFlag
 442                     ; 105 	return adcValue;	
 444  00b5 1e01          	ldw	x,(OFST-1,sp)
 447  00b7 5b02          	addw	sp,#2
 448  00b9 81            	ret
 451                     .const:	section	.text
 452  0000               L141_adc_buffer_1:
 453  0000 bf800000      	dc.w	-16512,0
 454  0004 000000000000  	ds.b	1020
 540                     ; 108 struct sineWave adc_sampling(void)
 540                     ; 109 {
 541                     	switch	.text
 542  00ba               _adc_sampling:
 544  00ba 96            	ldw	x,sp
 545  00bb 1d0424        	subw	x,#1060
 546  00be 94            	ldw	sp,x
 547       00000424      OFST:	set	1060
 550                     ; 112     float adc_buffer_1[256] = { -1 };  // ADC buffer for sine wave 1
 552  00bf 96            	ldw	x,sp
 553  00c0 1c0023        	addw	x,#OFST-1025
 554  00c3 90ae0000      	ldw	y,#L141_adc_buffer_1
 555  00c7 bf00          	ldw	c_x,x
 556  00c9 ae0400        	ldw	x,#1024
 557  00cc cd0000        	call	c_xymovl
 559                     ; 115     int freqCount = 0;                        // Frequency count
 561  00cf 5f            	clrw	x
 562  00d0 1f19          	ldw	(OFST-1035,sp),x
 564                     ; 116     float freqBuff = 0.0;                     // Frequency buffer
 566  00d2 ce040e        	ldw	x,L112+2
 567  00d5 1f1d          	ldw	(OFST-1031,sp),x
 568  00d7 ce040c        	ldw	x,L112
 569  00da 1f1b          	ldw	(OFST-1033,sp),x
 571                     ; 117     lastEdgeTime = 0;                         // Initialize last edge time
 573  00dc ae0000        	ldw	x,#0
 574  00df bf02          	ldw	_lastEdgeTime+2,x
 575  00e1 ae0000        	ldw	x,#0
 576  00e4 bf00          	ldw	_lastEdgeTime,x
 577                     ; 120     for (i = 0; i < 256; i++) {
 579  00e6 96            	ldw	x,sp
 580  00e7 905f          	clrw	y
 581  00e9 df0423        	ldw	(OFST-1,x),y
 582  00ec               L512:
 583                     ; 121         adc_buffer_1[i] = (ADC_Conversion(ADC2_CHANNEL_0) * (5 / 1023.0));  // Convert ADC value to voltage
 585  00ec 4f            	clr	a
 586  00ed adaa          	call	_ADC_Conversion
 588  00ef cd0000        	call	c_uitof
 590  00f2 ae0408        	ldw	x,#L722
 591  00f5 cd0000        	call	c_fmul
 593  00f8 96            	ldw	x,sp
 594  00f9 1c0023        	addw	x,#OFST-1025
 595  00fc 1f0f          	ldw	(OFST-1045,sp),x
 597  00fe 96            	ldw	x,sp
 598  00ff de0423        	ldw	x,(OFST-1,x)
 599  0102 58            	sllw	x
 600  0103 58            	sllw	x
 601  0104 72fb0f        	addw	x,(OFST-1045,sp)
 602  0107 cd0000        	call	c_rtol
 604                     ; 123         if (i > 0 && detectPosZeroCross(adc_buffer_1[i - 1], adc_buffer_1[i])) {
 606  010a 96            	ldw	x,sp
 607  010b d60424        	ld	a,(OFST+0,x)
 608  010e da0423        	or	a,(OFST-1,x)
 609  0111 2603          	jrne	L61
 610  0113 cc01b9        	jp	L332
 611  0116               L61:
 613  0116 96            	ldw	x,sp
 614  0117 1c0023        	addw	x,#OFST-1025
 615  011a 1f0f          	ldw	(OFST-1045,sp),x
 617  011c 96            	ldw	x,sp
 618  011d de0423        	ldw	x,(OFST-1,x)
 619  0120 58            	sllw	x
 620  0121 58            	sllw	x
 621  0122 72fb0f        	addw	x,(OFST-1045,sp)
 622  0125 9093          	ldw	y,x
 623  0127 ee02          	ldw	x,(2,x)
 624  0129 89            	pushw	x
 625  012a 93            	ldw	x,y
 626  012b fe            	ldw	x,(x)
 627  012c 89            	pushw	x
 628  012d 96            	ldw	x,sp
 629  012e 1c0027        	addw	x,#OFST-1021
 630  0131 1f11          	ldw	(OFST-1043,sp),x
 632  0133 96            	ldw	x,sp
 633  0134 de0427        	ldw	x,(OFST+3,x)
 634  0137 58            	sllw	x
 635  0138 58            	sllw	x
 636  0139 1d0004        	subw	x,#4
 637  013c 72fb11        	addw	x,(OFST-1043,sp)
 638  013f 9093          	ldw	y,x
 639  0141 ee02          	ldw	x,(2,x)
 640  0143 89            	pushw	x
 641  0144 93            	ldw	x,y
 642  0145 fe            	ldw	x,(x)
 643  0146 89            	pushw	x
 644  0147 cd020c        	call	_detectPosZeroCross
 646  014a 5b08          	addw	sp,#8
 647  014c 4d            	tnz	a
 648  014d 276a          	jreq	L332
 649                     ; 124             currentEdgeTime = micros();                               // Record current time
 651  014f cd0000        	call	_micros
 653  0152 ae0004        	ldw	x,#_currentEdgeTime
 654  0155 cd0000        	call	c_rtol
 656                     ; 125             if (lastEdgeTime > 0) {                                   // Ensure a previous edge exists
 658  0158 ae0000        	ldw	x,#_lastEdgeTime
 659  015b cd0000        	call	c_lzmp
 661  015e 2751          	jreq	L532
 662                     ; 126                 period = currentEdgeTime - lastEdgeTime;              // Calculate period
 664  0160 ae0004        	ldw	x,#_currentEdgeTime
 665  0163 cd0000        	call	c_ltor
 667  0166 ae0000        	ldw	x,#_lastEdgeTime
 668  0169 cd0000        	call	c_lsub
 670  016c 96            	ldw	x,sp
 671  016d 1c001f        	addw	x,#OFST-1029
 672  0170 cd0000        	call	c_rtol
 675                     ; 127                 freqCount++;
 677  0173 1e19          	ldw	x,(OFST-1035,sp)
 678  0175 1c0001        	addw	x,#1
 679  0178 1f19          	ldw	(OFST-1035,sp),x
 681                     ; 128                 sine1_frequency = 1.0 / (period / 1e6);               // Convert period to frequency (Hz)
 683  017a 96            	ldw	x,sp
 684  017b 1c001f        	addw	x,#OFST-1029
 685  017e cd0000        	call	c_ltor
 687  0181 cd0000        	call	c_ultof
 689  0184 ae0400        	ldw	x,#L352
 690  0187 cd0000        	call	c_fdiv
 692  018a 96            	ldw	x,sp
 693  018b 1c000d        	addw	x,#OFST-1047
 694  018e cd0000        	call	c_rtol
 697  0191 ae0404        	ldw	x,#L342
 698  0194 cd0000        	call	c_ltor
 700  0197 96            	ldw	x,sp
 701  0198 1c000d        	addw	x,#OFST-1047
 702  019b cd0000        	call	c_fdiv
 704  019e ae0008        	ldw	x,#_sine1_frequency
 705  01a1 cd0000        	call	c_rtol
 707                     ; 129                 freqBuff += sine1_frequency;
 709  01a4 ae0008        	ldw	x,#_sine1_frequency
 710  01a7 cd0000        	call	c_ltor
 712  01aa 96            	ldw	x,sp
 713  01ab 1c001b        	addw	x,#OFST-1033
 714  01ae cd0000        	call	c_fgadd
 717  01b1               L532:
 718                     ; 131             lastEdgeTime = currentEdgeTime;  // Update last edge time
 720  01b1 be06          	ldw	x,_currentEdgeTime+2
 721  01b3 bf02          	ldw	_lastEdgeTime+2,x
 722  01b5 be04          	ldw	x,_currentEdgeTime
 723  01b7 bf00          	ldw	_lastEdgeTime,x
 724  01b9               L332:
 725                     ; 120     for (i = 0; i < 256; i++) {
 727  01b9 96            	ldw	x,sp
 728  01ba 9093          	ldw	y,x
 729  01bc de0423        	ldw	x,(OFST-1,x)
 730  01bf 1c0001        	addw	x,#1
 731  01c2 90df0423      	ldw	(OFST-1,y),x
 734  01c6 96            	ldw	x,sp
 735  01c7 9093          	ldw	y,x
 736  01c9 90de0423      	ldw	y,(OFST-1,y)
 737  01cd 90a30100      	cpw	y,#256
 738  01d1 2403          	jruge	L02
 739  01d3 cc00ec        	jp	L512
 740  01d6               L02:
 741                     ; 136   sinewave.frequency = freqBuff / freqCount;
 743  01d6 1e19          	ldw	x,(OFST-1035,sp)
 744  01d8 cd0000        	call	c_itof
 746  01db 96            	ldw	x,sp
 747  01dc 1c000d        	addw	x,#OFST-1047
 748  01df cd0000        	call	c_rtol
 751  01e2 96            	ldw	x,sp
 752  01e3 1c001b        	addw	x,#OFST-1033
 753  01e6 cd0000        	call	c_ltor
 755  01e9 96            	ldw	x,sp
 756  01ea 1c000d        	addw	x,#OFST-1047
 757  01ed cd0000        	call	c_fdiv
 759  01f0 96            	ldw	x,sp
 760  01f1 1c0011        	addw	x,#OFST-1043
 761  01f4 cd0000        	call	c_rtol
 764                     ; 138 	return sinewave; 
 766  01f7 96            	ldw	x,sp
 767  01f8 de0427        	ldw	x,(OFST+3,x)
 768  01fb 9096          	ldw	y,sp
 769  01fd 72a90011      	addw	y,#OFST-1043
 770  0201 a608          	ld	a,#8
 771  0203 cd0000        	call	c_xymov
 775  0206 96            	ldw	x,sp
 776  0207 1c0424        	addw	x,#1060
 777  020a 94            	ldw	sp,x
 778  020b 81            	ret
 842                     ; 141  bool detectPosZeroCross(float adcPrev, float adcCurrent) 
 842                     ; 142 {
 843                     	switch	.text
 844  020c               _detectPosZeroCross:
 846       00000000      OFST:	set	0
 849                     ; 143   if (adcPrev == 0 && adcCurrent > 0) 
 851  020c 9c            	rvf
 852  020d 0d03          	tnz	(OFST+3,sp)
 853  020f 2609          	jrne	L113
 855  0211 9c            	rvf
 856  0212 9c            	rvf
 857  0213 0d07          	tnz	(OFST+7,sp)
 858  0215 2d03          	jrsle	L113
 859                     ; 145     return 1;
 861  0217 a601          	ld	a,#1
 864  0219 81            	ret
 865  021a               L113:
 866                     ; 148     return 0;
 868  021a 4f            	clr	a
 871  021b 81            	ret
 897                     ; 151 void UART1_setup(void)
 897                     ; 152 {
 898                     	switch	.text
 899  021c               _UART1_setup:
 903                     ; 153      UART1_DeInit();
 905  021c cd0000        	call	_UART1_DeInit
 907                     ; 155      UART1_Init(9600, 
 907                     ; 156                 UART1_WORDLENGTH_8D, 
 907                     ; 157                 UART1_STOPBITS_1, 
 907                     ; 158                 UART1_PARITY_NO, 
 907                     ; 159                 UART1_SYNCMODE_CLOCK_DISABLE, 
 907                     ; 160                 UART1_MODE_TXRX_ENABLE);
 909  021f 4b0c          	push	#12
 910  0221 4b80          	push	#128
 911  0223 4b00          	push	#0
 912  0225 4b00          	push	#0
 913  0227 4b00          	push	#0
 914  0229 ae2580        	ldw	x,#9600
 915  022c 89            	pushw	x
 916  022d ae0000        	ldw	x,#0
 917  0230 89            	pushw	x
 918  0231 cd0000        	call	_UART1_Init
 920  0234 5b09          	addw	sp,#9
 921                     ; 162      UART1_Cmd(ENABLE);
 923  0236 a601          	ld	a,#1
 924  0238 cd0000        	call	_UART1_Cmd
 926                     ; 163 		 return;
 929  023b 81            	ret
 966                     ; 166 void UART1_SendString(char *str)
 966                     ; 167 {
 967                     	switch	.text
 968  023c               _UART1_SendString:
 970  023c 89            	pushw	x
 971       00000000      OFST:	set	0
 974  023d 2016          	jra	L543
 975  023f               L343:
 976                     ; 170         UART1_SendData8(*str); // Send the current character
 978  023f 1e01          	ldw	x,(OFST+1,sp)
 979  0241 f6            	ld	a,(x)
 980  0242 cd0000        	call	_UART1_SendData8
 983  0245               L353:
 984                     ; 171         while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); // Wait for TXE flag
 986  0245 ae0080        	ldw	x,#128
 987  0248 cd0000        	call	_UART1_GetFlagStatus
 989  024b 4d            	tnz	a
 990  024c 27f7          	jreq	L353
 991                     ; 172         str++; // Move to the next character
 993  024e 1e01          	ldw	x,(OFST+1,sp)
 994  0250 1c0001        	addw	x,#1
 995  0253 1f01          	ldw	(OFST+1,sp),x
 996  0255               L543:
 997                     ; 168     while (*str) // Loop until the null terminator is encountered
 999  0255 1e01          	ldw	x,(OFST+1,sp)
1000  0257 7d            	tnz	(x)
1001  0258 26e5          	jrne	L343
1002                     ; 174 }
1005  025a 85            	popw	x
1006  025b 81            	ret
1064                     ; 176 char UART1_ReceiveString(char *buffer)
1064                     ; 177 {
1065                     	switch	.text
1066  025c               _UART1_ReceiveString:
1068  025c 89            	pushw	x
1069  025d 89            	pushw	x
1070       00000002      OFST:	set	2
1073                     ; 179     unsigned char index = 0;
1075  025e 0f02          	clr	(OFST+0,sp)
1077                     ; 182     memset(buffer, 0, UART_RECEIVE_BUFFER_SIZE);
1079  0260 bf00          	ldw	c_x,x
1080  0262 ae0064        	ldw	x,#100
1081  0265               L23:
1082  0265 5a            	decw	x
1083  0266 926f00        	clr	([c_x.w],x)
1084  0269 5d            	tnzw	x
1085  026a 26f9          	jrne	L23
1086  026c               L504:
1087                     ; 187         if (UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE)
1089  026c ae0020        	ldw	x,#32
1090  026f cd0000        	call	_UART1_GetFlagStatus
1092  0272 a101          	cp	a,#1
1093  0274 26f6          	jrne	L504
1094                     ; 189             ch = UART1_ReceiveData8(); // Receive the character
1096  0276 cd0000        	call	_UART1_ReceiveData8
1098  0279 6b01          	ld	(OFST-1,sp),a
1100                     ; 190             UART1_ClearFlag(UART1_FLAG_RXNE);
1102  027b ae0020        	ldw	x,#32
1103  027e cd0000        	call	_UART1_ClearFlag
1105                     ; 192             if (ch == TERMINATION_CHAR || index >= (UART_RECEIVE_BUFFER_SIZE - 1))
1107  0281 7b01          	ld	a,(OFST-1,sp)
1108  0283 a10a          	cp	a,#10
1109  0285 2706          	jreq	L514
1111  0287 7b02          	ld	a,(OFST+0,sp)
1112  0289 a163          	cp	a,#99
1113  028b 250d          	jrult	L314
1114  028d               L514:
1115                     ; 194                 buffer[index] = '\0'; // Null-terminate the string
1117  028d 7b02          	ld	a,(OFST+0,sp)
1118  028f 5f            	clrw	x
1119  0290 97            	ld	xl,a
1120  0291 72fb03        	addw	x,(OFST+1,sp)
1121  0294 7f            	clr	(x)
1122                     ; 195                 return index;        // Return the length of the string
1124  0295 7b02          	ld	a,(OFST+0,sp)
1127  0297 5b04          	addw	sp,#4
1128  0299 81            	ret
1129  029a               L314:
1130                     ; 198             buffer[index++] = ch; // Store the character and increment the index
1132  029a 7b02          	ld	a,(OFST+0,sp)
1133  029c 97            	ld	xl,a
1134  029d 0c02          	inc	(OFST+0,sp)
1136  029f 9f            	ld	a,xl
1137  02a0 5f            	clrw	x
1138  02a1 97            	ld	xl,a
1139  02a2 72fb03        	addw	x,(OFST+1,sp)
1140  02a5 7b01          	ld	a,(OFST-1,sp)
1141  02a7 f7            	ld	(x),a
1142  02a8 20c2          	jra	L504
1184                     	xdef	_UART1_SendString
1185                     	xdef	_main
1186                     	xdef	_detectPosZeroCross
1187                     	xdef	_adc_sampling
1188                     	xdef	_UART1_ReceiveString
1189                     	xdef	_ADC_Conversion
1190                     	xdef	_UART1_setup
1191                     	xdef	_ADC2_setup
1192                     	xdef	_clock_setup
1193                     	xdef	_sine1_frequency
1194                     	xdef	_currentEdgeTime
1195                     	xdef	_lastEdgeTime
1196                     	xref	_micros
1197                     	xref	_UART1_ClearFlag
1198                     	xref	_UART1_GetFlagStatus
1199                     	xref	_UART1_SendData8
1200                     	xref	_UART1_ReceiveData8
1201                     	xref	_UART1_Cmd
1202                     	xref	_UART1_Init
1203                     	xref	_UART1_DeInit
1204                     	xref	_CLK_GetFlagStatus
1205                     	xref	_CLK_SYSCLKConfig
1206                     	xref	_CLK_HSIPrescalerConfig
1207                     	xref	_CLK_ClockSwitchConfig
1208                     	xref	_CLK_PeripheralClockConfig
1209                     	xref	_CLK_ClockSwitchCmd
1210                     	xref	_CLK_LSICmd
1211                     	xref	_CLK_HSICmd
1212                     	xref	_CLK_HSECmd
1213                     	xref	_CLK_DeInit
1214                     	xref	_ADC2_ClearFlag
1215                     	xref	_ADC2_GetFlagStatus
1216                     	xref	_ADC2_GetConversionValue
1217                     	xref	_ADC2_StartConversion
1218                     	xref	_ADC2_ConversionConfig
1219                     	xref	_ADC2_Cmd
1220                     	xref	_ADC2_Init
1221                     	xref	_ADC2_DeInit
1222                     	switch	.const
1223  0400               L352:
1224  0400 49742400      	dc.w	18804,9216
1225  0404               L342:
1226  0404 3f800000      	dc.w	16256,0
1227  0408               L722:
1228  0408 3ba0280a      	dc.w	15264,10250
1229  040c               L112:
1230  040c 00000000      	dc.w	0,0
1231                     	xref.b	c_x
1232                     	xref.b	c_y
1252                     	xref	c_xymov
1253                     	xref	c_itof
1254                     	xref	c_fgadd
1255                     	xref	c_fdiv
1256                     	xref	c_ultof
1257                     	xref	c_lsub
1258                     	xref	c_ltor
1259                     	xref	c_lzmp
1260                     	xref	c_rtol
1261                     	xref	c_fmul
1262                     	xref	c_uitof
1263                     	xref	c_xymovl
1264                     	end
