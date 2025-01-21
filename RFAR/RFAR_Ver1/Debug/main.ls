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
  25                     .const:	section	.text
  26  0000               L3_adc_buffer_1:
  27  0000 bf800000      	dc.w	-16512,0
  28  0004 000000000000  	ds.b	2044
 139                     ; 33 void main()
 139                     ; 34 {
 140                     	switch	.text
 141  0000               f_main:
 143  0000 96            	ldw	x,sp
 144  0001 1d0822        	subw	x,#2082
 145  0004 94            	ldw	sp,x
 146       00000822      OFST:	set	2082
 149                     ; 35 	clock_setup();
 151  0005 8deb01eb      	callf	f_clock_setup
 153                     ; 36 	TIM4_Config();
 155  0009 8d000000      	callf	f_TIM4_Config
 157                     ; 37   UART3_setup();
 159  000d 8d6d026d      	callf	f_UART3_setup
 161                     ; 38 	ADC2_setup();
 163  0011 8da202a2      	callf	f_ADC2_setup
 165                     ; 39   GPIO_DeInit(GPIOC);
 167  0015 ae500a        	ldw	x,#20490
 168  0018 8d000000      	callf	f_GPIO_DeInit
 170                     ; 40   GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 172  001c 4be0          	push	#224
 173  001e 4b08          	push	#8
 174  0020 ae500a        	ldw	x,#20490
 175  0023 8d000000      	callf	f_GPIO_Init
 177  0027 85            	popw	x
 178                     ; 41   printf("Initializing Uart Starting:\n\r");
 180  0028 ae0836        	ldw	x,#L16
 181  002b 8d000000      	callf	f_printf
 183  002f               L36:
 184                     ; 44 		float adc_buffer_1[NUM_SAMPLES] = { -1 };  // ADC buffer for sine wave 1
 186  002f 96            	ldw	x,sp
 187  0030 1c0021        	addw	x,#OFST-2049
 188  0033 90ae0000      	ldw	y,#L3_adc_buffer_1
 189  0037 bf00          	ldw	c_x,x
 190  0039 ae0800        	ldw	x,#2048
 191  003c 8d000000      	callf	d_xymovl
 193                     ; 45 		uint16_t i = 0;
 195                     ; 46 		unsigned int adcValue = 0;
 197                     ; 47 		int freqCount = 0;
 199  0040 5f            	clrw	x
 200  0041 1f1b          	ldw	(OFST-2055,sp),x
 202                     ; 48 		float freqBuff = 0;
 204  0043 ae0000        	ldw	x,#0
 205  0046 1f1f          	ldw	(OFST-2051,sp),x
 206  0048 ae0000        	ldw	x,#0
 207  004b 1f1d          	ldw	(OFST-2053,sp),x
 209                     ; 49 		float voltage = 0;
 211                     ; 50 		lastEdgeTime = 0;
 213  004d ae0000        	ldw	x,#0
 214  0050 bf0a          	ldw	_lastEdgeTime+2,x
 215  0052 ae0000        	ldw	x,#0
 216  0055 bf08          	ldw	_lastEdgeTime,x
 217                     ; 53 		for (i = 0; i < NUM_SAMPLES; i++) 
 219  0057 96            	ldw	x,sp
 220  0058 905f          	clrw	y
 221  005a df0821        	ldw	(OFST-1,x),y
 222  005d               L76:
 223                     ; 55 			adc_buffer_1[i] = (read_ADC_Channel(ADC2_CHANNEL_5) * (4.66 / 1023.0));  // Convert ADC value to voltage
 225  005d a605          	ld	a,#5
 226  005f 8dc902c9      	callf	f_read_ADC_Channel
 228  0063 8d000000      	callf	d_uitof
 230  0067 ae0832        	ldw	x,#L101
 231  006a 8d000000      	callf	d_fmul
 233  006e 96            	ldw	x,sp
 234  006f 1c0021        	addw	x,#OFST-2049
 235  0072 1f0f          	ldw	(OFST-2067,sp),x
 237  0074 96            	ldw	x,sp
 238  0075 de0821        	ldw	x,(OFST-1,x)
 239  0078 58            	sllw	x
 240  0079 58            	sllw	x
 241  007a 72fb0f        	addw	x,(OFST-2067,sp)
 242  007d 8d000000      	callf	d_rtol
 244                     ; 56 			delay_us(1000000 / SAMPLE_RATE);             // Maintain sample rate
 246  0081 ae2710        	ldw	x,#10000
 247  0084 8d000000      	callf	f_delay_us
 249                     ; 57 			if (i > 0 && detectZeroCross(adc_buffer_1[i - 1], adc_buffer_1[i], 2.38)) 
 251  0088 96            	ldw	x,sp
 252  0089 d60822        	ld	a,(OFST+0,x)
 253  008c da0821        	or	a,(OFST-1,x)
 254  008f 2604          	jrne	L6
 255  0091 ac520152      	jpf	L501
 256  0095               L6:
 258  0095 ce0830        	ldw	x,L311+2
 259  0098 89            	pushw	x
 260  0099 ce082e        	ldw	x,L311
 261  009c 89            	pushw	x
 262  009d 96            	ldw	x,sp
 263  009e 1c0025        	addw	x,#OFST-2045
 264  00a1 1f13          	ldw	(OFST-2063,sp),x
 266  00a3 96            	ldw	x,sp
 267  00a4 de0825        	ldw	x,(OFST+3,x)
 268  00a7 58            	sllw	x
 269  00a8 58            	sllw	x
 270  00a9 72fb13        	addw	x,(OFST-2063,sp)
 271  00ac 9093          	ldw	y,x
 272  00ae ee02          	ldw	x,(2,x)
 273  00b0 89            	pushw	x
 274  00b1 93            	ldw	x,y
 275  00b2 fe            	ldw	x,(x)
 276  00b3 89            	pushw	x
 277  00b4 96            	ldw	x,sp
 278  00b5 1c0029        	addw	x,#OFST-2041
 279  00b8 1f15          	ldw	(OFST-2061,sp),x
 281  00ba 96            	ldw	x,sp
 282  00bb de0829        	ldw	x,(OFST+7,x)
 283  00be 58            	sllw	x
 284  00bf 58            	sllw	x
 285  00c0 1d0004        	subw	x,#4
 286  00c3 72fb15        	addw	x,(OFST-2061,sp)
 287  00c6 9093          	ldw	y,x
 288  00c8 ee02          	ldw	x,(2,x)
 289  00ca 89            	pushw	x
 290  00cb 93            	ldw	x,y
 291  00cc fe            	ldw	x,(x)
 292  00cd 89            	pushw	x
 293  00ce 8def02ef      	callf	f_detectZeroCross
 295  00d2 5b0c          	addw	sp,#12
 296  00d4 4d            	tnz	a
 297  00d5 2602          	jrne	L01
 298  00d7 2079          	jpf	L501
 299  00d9               L01:
 300                     ; 59 				currentEdgeTime = micros();                               // Record current time
 302  00d9 8d000000      	callf	f_micros
 304  00dd ae000c        	ldw	x,#_currentEdgeTime
 305  00e0 8d000000      	callf	d_rtol
 307                     ; 60 				if (lastEdgeTime > 0) 
 309  00e4 ae0008        	ldw	x,#_lastEdgeTime
 310  00e7 8d000000      	callf	d_lzmp
 312  00eb 275d          	jreq	L711
 313                     ; 62 					unsigned long period = currentEdgeTime - lastEdgeTime;  // Calculate period
 315  00ed ae000c        	ldw	x,#_currentEdgeTime
 316  00f0 8d000000      	callf	d_ltor
 318  00f4 ae0008        	ldw	x,#_lastEdgeTime
 319  00f7 8d000000      	callf	d_lsub
 321  00fb 96            	ldw	x,sp
 322  00fc 1c0011        	addw	x,#OFST-2065
 323  00ff 8d000000      	callf	d_rtol
 326                     ; 63 					freqCount++;
 328  0103 1e1b          	ldw	x,(OFST-2055,sp)
 329  0105 1c0001        	addw	x,#1
 330  0108 1f1b          	ldw	(OFST-2055,sp),x
 332                     ; 64 					sine1_frequency = 1.0 / (period / 1e6);  // Convert period to frequency (Hz)
 334  010a 96            	ldw	x,sp
 335  010b 1c0011        	addw	x,#OFST-2065
 336  010e 8d000000      	callf	d_ltor
 338  0112 8d000000      	callf	d_ultof
 340  0116 ae0826        	ldw	x,#L531
 341  0119 8d000000      	callf	d_fdiv
 343  011d 96            	ldw	x,sp
 344  011e 1c000d        	addw	x,#OFST-2069
 345  0121 8d000000      	callf	d_rtol
 348  0125 ae082a        	ldw	x,#L521
 349  0128 8d000000      	callf	d_ltor
 351  012c 96            	ldw	x,sp
 352  012d 1c000d        	addw	x,#OFST-2069
 353  0130 8d000000      	callf	d_fdiv
 355  0134 ae0000        	ldw	x,#_sine1_frequency
 356  0137 8d000000      	callf	d_rtol
 358                     ; 65 					freqBuff += sine1_frequency;
 360  013b ae0000        	ldw	x,#_sine1_frequency
 361  013e 8d000000      	callf	d_ltor
 363  0142 96            	ldw	x,sp
 364  0143 1c001d        	addw	x,#OFST-2053
 365  0146 8d000000      	callf	d_fgadd
 368  014a               L711:
 369                     ; 67 				lastEdgeTime = currentEdgeTime;  // Update last edge time
 371  014a be0e          	ldw	x,_currentEdgeTime+2
 372  014c bf0a          	ldw	_lastEdgeTime+2,x
 373  014e be0c          	ldw	x,_currentEdgeTime
 374  0150 bf08          	ldw	_lastEdgeTime,x
 375  0152               L501:
 376                     ; 53 		for (i = 0; i < NUM_SAMPLES; i++) 
 378  0152 96            	ldw	x,sp
 379  0153 9093          	ldw	y,x
 380  0155 de0821        	ldw	x,(OFST-1,x)
 381  0158 1c0001        	addw	x,#1
 382  015b 90df0821      	ldw	(OFST-1,y),x
 385  015f 96            	ldw	x,sp
 386  0160 9093          	ldw	y,x
 387  0162 90de0821      	ldw	y,(OFST-1,y)
 388  0166 90a30200      	cpw	y,#512
 389  016a 2404          	jruge	L21
 390  016c ac5d005d      	jpf	L76
 391  0170               L21:
 392                     ; 71 		for (i = 0; i < NUM_SAMPLES; i++) 
 394  0170 96            	ldw	x,sp
 395  0171 905f          	clrw	y
 396  0173 df0821        	ldw	(OFST-1,x),y
 397  0176               L141:
 398                     ; 72 			printf("%f, ", adc_buffer_1[i]);
 400  0176 96            	ldw	x,sp
 401  0177 1c0021        	addw	x,#OFST-2049
 402  017a 1f0f          	ldw	(OFST-2067,sp),x
 404  017c 96            	ldw	x,sp
 405  017d de0821        	ldw	x,(OFST-1,x)
 406  0180 58            	sllw	x
 407  0181 58            	sllw	x
 408  0182 72fb0f        	addw	x,(OFST-2067,sp)
 409  0185 9093          	ldw	y,x
 410  0187 ee02          	ldw	x,(2,x)
 411  0189 89            	pushw	x
 412  018a 93            	ldw	x,y
 413  018b fe            	ldw	x,(x)
 414  018c 89            	pushw	x
 415  018d ae0821        	ldw	x,#L741
 416  0190 8d000000      	callf	f_printf
 418  0194 5b04          	addw	sp,#4
 419                     ; 71 		for (i = 0; i < NUM_SAMPLES; i++) 
 421  0196 96            	ldw	x,sp
 422  0197 9093          	ldw	y,x
 423  0199 de0821        	ldw	x,(OFST-1,x)
 424  019c 1c0001        	addw	x,#1
 425  019f 90df0821      	ldw	(OFST-1,y),x
 428  01a3 96            	ldw	x,sp
 429  01a4 9093          	ldw	y,x
 430  01a6 90de0821      	ldw	y,(OFST-1,y)
 431  01aa 90a30200      	cpw	y,#512
 432  01ae 25c6          	jrult	L141
 433                     ; 74 		sine1_amplitude = calculate_amplitude(adc_buffer_1, NUM_SAMPLES);
 435  01b0 ae0200        	ldw	x,#512
 436  01b3 89            	pushw	x
 437  01b4 ae0000        	ldw	x,#0
 438  01b7 89            	pushw	x
 439  01b8 96            	ldw	x,sp
 440  01b9 1c0025        	addw	x,#OFST-2045
 441  01bc 8ded03ed      	callf	f_calculate_amplitude
 443  01c0 5b04          	addw	sp,#4
 444  01c2 ae0004        	ldw	x,#_sine1_amplitude
 445  01c5 8d000000      	callf	d_rtol
 447                     ; 76 		printf("\nFrequency: %f\n\r", sine1_frequency);
 449  01c9 be02          	ldw	x,_sine1_frequency+2
 450  01cb 89            	pushw	x
 451  01cc be00          	ldw	x,_sine1_frequency
 452  01ce 89            	pushw	x
 453  01cf ae0810        	ldw	x,#L151
 454  01d2 8d000000      	callf	f_printf
 456  01d6 5b04          	addw	sp,#4
 457                     ; 78 		printf("Amplitude: %f\n\r", sine1_amplitude);
 459  01d8 be06          	ldw	x,_sine1_amplitude+2
 460  01da 89            	pushw	x
 461  01db be04          	ldw	x,_sine1_amplitude
 462  01dd 89            	pushw	x
 463  01de ae0800        	ldw	x,#L351
 464  01e1 8d000000      	callf	f_printf
 466  01e5 5b04          	addw	sp,#4
 468  01e7 ac2f002f      	jpf	L36
 500                     ; 83 void clock_setup(void) {
 501                     	switch	.text
 502  01eb               f_clock_setup:
 506                     ; 84   CLK_DeInit();
 508  01eb 8d000000      	callf	f_CLK_DeInit
 510                     ; 85   CLK_HSECmd(DISABLE);
 512  01ef 4f            	clr	a
 513  01f0 8d000000      	callf	f_CLK_HSECmd
 515                     ; 86   CLK_LSICmd(DISABLE);
 517  01f4 4f            	clr	a
 518  01f5 8d000000      	callf	f_CLK_LSICmd
 520                     ; 87   CLK_HSICmd(ENABLE);
 522  01f9 a601          	ld	a,#1
 523  01fb 8d000000      	callf	f_CLK_HSICmd
 526  01ff               L761:
 527                     ; 88   while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 529  01ff ae0102        	ldw	x,#258
 530  0202 8d000000      	callf	f_CLK_GetFlagStatus
 532  0206 4d            	tnz	a
 533  0207 27f6          	jreq	L761
 534                     ; 90   CLK_ClockSwitchCmd(ENABLE);
 536  0209 a601          	ld	a,#1
 537  020b 8d000000      	callf	f_CLK_ClockSwitchCmd
 539                     ; 91   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 541  020f 4f            	clr	a
 542  0210 8d000000      	callf	f_CLK_HSIPrescalerConfig
 544                     ; 92   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 546  0214 a680          	ld	a,#128
 547  0216 8d000000      	callf	f_CLK_SYSCLKConfig
 549                     ; 94   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
 549                     ; 95                         CLK_CURRENTCLOCKSTATE_ENABLE);
 551  021a 4b01          	push	#1
 552  021c 4b00          	push	#0
 553  021e ae01e1        	ldw	x,#481
 554  0221 8d000000      	callf	f_CLK_ClockSwitchConfig
 556  0225 85            	popw	x
 557                     ; 97   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 559  0226 ae0401        	ldw	x,#1025
 560  0229 8d000000      	callf	f_CLK_PeripheralClockConfig
 562                     ; 98   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 564  022d ae0301        	ldw	x,#769
 565  0230 8d000000      	callf	f_CLK_PeripheralClockConfig
 567                     ; 99 }
 570  0234 87            	retf
 612                     ; 101 uint32_t elapsedTime(uint32_t start, uint32_t end) {
 613                     	switch	.text
 614  0235               f_elapsedTime:
 616       00000000      OFST:	set	0
 619                     ; 102   if (end >= start) 
 621  0235 96            	ldw	x,sp
 622  0236 1c0008        	addw	x,#OFST+8
 623  0239 8d000000      	callf	d_ltor
 625  023d 96            	ldw	x,sp
 626  023e 1c0004        	addw	x,#OFST+4
 627  0241 8d000000      	callf	d_lcmp
 629  0245 2511          	jrult	L512
 630                     ; 105     return end - start;
 632  0247 96            	ldw	x,sp
 633  0248 1c0008        	addw	x,#OFST+8
 634  024b 8d000000      	callf	d_ltor
 636  024f 96            	ldw	x,sp
 637  0250 1c0004        	addw	x,#OFST+4
 638  0253 8d000000      	callf	d_lsub
 642  0257 87            	retf
 643  0258               L512:
 644                     ; 109     return (0xffffffff - start + 1) + end;
 646  0258 96            	ldw	x,sp
 647  0259 1c0004        	addw	x,#OFST+4
 648  025c 8d000000      	callf	d_ltor
 650  0260 8d000000      	callf	d_lneg
 652  0264 96            	ldw	x,sp
 653  0265 1c0008        	addw	x,#OFST+8
 654  0268 8d000000      	callf	d_ladd
 658  026c 87            	retf
 683                     ; 114 void UART3_setup(void) {
 684                     	switch	.text
 685  026d               f_UART3_setup:
 689                     ; 115   UART3_DeInit();
 691  026d 8d000000      	callf	f_UART3_DeInit
 693                     ; 118   UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
 693                     ; 119              UART3_MODE_TX_ENABLE);
 695  0271 4b04          	push	#4
 696  0273 4b00          	push	#0
 697  0275 4b00          	push	#0
 698  0277 4b00          	push	#0
 699  0279 ae2580        	ldw	x,#9600
 700  027c 89            	pushw	x
 701  027d ae0000        	ldw	x,#0
 702  0280 89            	pushw	x
 703  0281 8d000000      	callf	f_UART3_Init
 705  0285 5b08          	addw	sp,#8
 706                     ; 121   UART3_Cmd(ENABLE);  // Enable UART1
 708  0287 a601          	ld	a,#1
 709  0289 8d000000      	callf	f_UART3_Cmd
 711                     ; 122 }
 714  028d 87            	retf
 749                     ; 124 PUTCHAR_PROTOTYPE {
 750                     	switch	.text
 751  028e               f_putchar:
 753  028e 88            	push	a
 754       00000000      OFST:	set	0
 757                     ; 126   UART3_SendData8(c);
 759  028f 8d000000      	callf	f_UART3_SendData8
 762  0293               L152:
 763                     ; 128   while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);
 765  0293 ae0080        	ldw	x,#128
 766  0296 8d000000      	callf	f_UART3_GetFlagStatus
 768  029a 4d            	tnz	a
 769  029b 27f6          	jreq	L152
 770                     ; 130   return (c);
 772  029d 7b01          	ld	a,(OFST+1,sp)
 775  029f 5b01          	addw	sp,#1
 776  02a1 87            	retf
 802                     ; 133 void ADC2_setup(void) {
 803                     	switch	.text
 804  02a2               f_ADC2_setup:
 808                     ; 134 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 810  02a2 ae1301        	ldw	x,#4865
 811  02a5 8d000000      	callf	f_CLK_PeripheralClockConfig
 813                     ; 135     ADC2_DeInit();
 815  02a9 8d000000      	callf	f_ADC2_DeInit
 817                     ; 137     ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS,
 817                     ; 138               ADC2_CHANNEL_5,
 817                     ; 139               ADC2_PRESSEL_FCPU_D2,
 817                     ; 140               ADC2_EXTTRIG_GPIO,
 817                     ; 141               DISABLE,
 817                     ; 142               ADC2_ALIGN_RIGHT,
 817                     ; 143               ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6,
 817                     ; 144               DISABLE);
 819  02ad 4b00          	push	#0
 820  02af 4b07          	push	#7
 821  02b1 4b08          	push	#8
 822  02b3 4b00          	push	#0
 823  02b5 4b01          	push	#1
 824  02b7 4b00          	push	#0
 825  02b9 ae0105        	ldw	x,#261
 826  02bc 8d000000      	callf	f_ADC2_Init
 828  02c0 5b06          	addw	sp,#6
 829                     ; 146     ADC2_Cmd(ENABLE);
 831  02c2 a601          	ld	a,#1
 832  02c4 8d000000      	callf	f_ADC2_Cmd
 834                     ; 147 }
 837  02c8 87            	retf
 884                     ; 149 unsigned int read_ADC_Channel(uint8_t channel) {
 885                     	switch	.text
 886  02c9               f_read_ADC_Channel:
 888  02c9 89            	pushw	x
 889       00000002      OFST:	set	2
 892                     ; 150     unsigned int adcValue = 0;
 894                     ; 153     ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS,
 894                     ; 154                           channel,
 894                     ; 155                           ADC2_ALIGN_RIGHT);
 896  02ca 4b08          	push	#8
 897  02cc ae0100        	ldw	x,#256
 898  02cf 97            	ld	xl,a
 899  02d0 8d000000      	callf	f_ADC2_ConversionConfig
 901  02d4 84            	pop	a
 902                     ; 158     ADC2_StartConversion();
 904  02d5 8d000000      	callf	f_ADC2_StartConversion
 907  02d9               L113:
 908                     ; 161     while (ADC2_GetFlagStatus() == RESET);
 910  02d9 8d000000      	callf	f_ADC2_GetFlagStatus
 912  02dd 4d            	tnz	a
 913  02de 27f9          	jreq	L113
 914                     ; 164     adcValue = ADC2_GetConversionValue();
 916  02e0 8d000000      	callf	f_ADC2_GetConversionValue
 918  02e4 1f01          	ldw	(OFST-1,sp),x
 920                     ; 167     ADC2_ClearFlag();
 922  02e6 8d000000      	callf	f_ADC2_ClearFlag
 924                     ; 169     return adcValue;
 926  02ea 1e01          	ldw	x,(OFST-1,sp)
 929  02ec 5b02          	addw	sp,#2
 930  02ee 87            	retf
1003                     ; 173 bool detectZeroCross(float previousSample, float currentSample, float threshold) 
1003                     ; 174 {
1004                     	switch	.text
1005  02ef               f_detectZeroCross:
1007       00000000      OFST:	set	0
1010                     ; 176     if (crossingType == -1) 
1012  02ef be10          	ldw	x,_crossingType
1013  02f1 a3ffff        	cpw	x,#65535
1014  02f4 2665          	jrne	L353
1015                     ; 178         if (previousSample <= threshold && currentSample > threshold) 
1017  02f6 9c            	rvf
1018  02f7 96            	ldw	x,sp
1019  02f8 1c0004        	addw	x,#OFST+4
1020  02fb 8d000000      	callf	d_ltor
1022  02ff 96            	ldw	x,sp
1023  0300 1c000c        	addw	x,#OFST+12
1024  0303 8d000000      	callf	d_fcmp
1026  0307 2c19          	jrsgt	L553
1028  0309 9c            	rvf
1029  030a 96            	ldw	x,sp
1030  030b 1c0008        	addw	x,#OFST+8
1031  030e 8d000000      	callf	d_ltor
1033  0312 96            	ldw	x,sp
1034  0313 1c000c        	addw	x,#OFST+12
1035  0316 8d000000      	callf	d_fcmp
1037  031a 2d06          	jrsle	L553
1038                     ; 180             crossingType = 0; // Set to positive zero crossing detection
1040  031c 5f            	clrw	x
1041  031d bf10          	ldw	_crossingType,x
1042                     ; 181             return 1;
1044  031f a601          	ld	a,#1
1047  0321 87            	retf
1048  0322               L553:
1049                     ; 183         else if (previousSample >= -threshold && currentSample < -threshold) 
1051  0322 9c            	rvf
1052  0323 96            	ldw	x,sp
1053  0324 1c000c        	addw	x,#OFST+12
1054  0327 8d000000      	callf	d_ltor
1056  032b 8d000000      	callf	d_fneg
1058  032f 96            	ldw	x,sp
1059  0330 1c0004        	addw	x,#OFST+4
1060  0333 8d000000      	callf	d_fcmp
1062  0337 2d04          	jrsle	L23
1063  0339 acc003c0      	jpf	L363
1064  033d               L23:
1066  033d 9c            	rvf
1067  033e 96            	ldw	x,sp
1068  033f 1c000c        	addw	x,#OFST+12
1069  0342 8d000000      	callf	d_ltor
1071  0346 8d000000      	callf	d_fneg
1073  034a 96            	ldw	x,sp
1074  034b 1c0008        	addw	x,#OFST+8
1075  034e 8d000000      	callf	d_fcmp
1077  0352 2d6c          	jrsle	L363
1078                     ; 185             crossingType = 1; // Set to negative zero crossing detection
1080  0354 ae0001        	ldw	x,#1
1081  0357 bf10          	ldw	_crossingType,x
1082                     ; 186             return 0;
1084  0359 4f            	clr	a
1087  035a 87            	retf
1088  035b               L353:
1089                     ; 190     else if (crossingType == 0) // Positive zero crossing detection
1091  035b be10          	ldw	x,_crossingType
1092  035d 2629          	jrne	L563
1093                     ; 192         if (previousSample <= threshold && currentSample > threshold) 
1095  035f 9c            	rvf
1096  0360 96            	ldw	x,sp
1097  0361 1c0004        	addw	x,#OFST+4
1098  0364 8d000000      	callf	d_ltor
1100  0368 96            	ldw	x,sp
1101  0369 1c000c        	addw	x,#OFST+12
1102  036c 8d000000      	callf	d_fcmp
1104  0370 2c4e          	jrsgt	L363
1106  0372 9c            	rvf
1107  0373 96            	ldw	x,sp
1108  0374 1c0008        	addw	x,#OFST+8
1109  0377 8d000000      	callf	d_ltor
1111  037b 96            	ldw	x,sp
1112  037c 1c000c        	addw	x,#OFST+12
1113  037f 8d000000      	callf	d_fcmp
1115  0383 2d3b          	jrsle	L363
1116                     ; 194             return 1;
1118  0385 a601          	ld	a,#1
1121  0387 87            	retf
1122  0388               L563:
1123                     ; 197     else if (crossingType == 1) // Negative zero crossing detection
1125  0388 be10          	ldw	x,_crossingType
1126  038a a30001        	cpw	x,#1
1127  038d 2631          	jrne	L363
1128                     ; 199         if (previousSample >= -threshold && currentSample < -threshold) 
1130  038f 9c            	rvf
1131  0390 96            	ldw	x,sp
1132  0391 1c000c        	addw	x,#OFST+12
1133  0394 8d000000      	callf	d_ltor
1135  0398 8d000000      	callf	d_fneg
1137  039c 96            	ldw	x,sp
1138  039d 1c0004        	addw	x,#OFST+4
1139  03a0 8d000000      	callf	d_fcmp
1141  03a4 2c1a          	jrsgt	L363
1143  03a6 9c            	rvf
1144  03a7 96            	ldw	x,sp
1145  03a8 1c000c        	addw	x,#OFST+12
1146  03ab 8d000000      	callf	d_ltor
1148  03af 8d000000      	callf	d_fneg
1150  03b3 96            	ldw	x,sp
1151  03b4 1c0008        	addw	x,#OFST+8
1152  03b7 8d000000      	callf	d_fcmp
1154  03bb 2d03          	jrsle	L363
1155                     ; 201             return 1;
1157  03bd a601          	ld	a,#1
1160  03bf 87            	retf
1161  03c0               L363:
1162                     ; 206     return 0;
1164  03c0 4f            	clr	a
1167  03c1 87            	retf
1219                     ; 210 bool detectPosZeroCross(float previousSample, float currentSample, float threshold) 
1219                     ; 211 {
1220                     	switch	.text
1221  03c2               f_detectPosZeroCross:
1223       00000000      OFST:	set	0
1226                     ; 212 	if(previousSample <= threshold && currentSample > threshold)
1228  03c2 9c            	rvf
1229  03c3 96            	ldw	x,sp
1230  03c4 1c0004        	addw	x,#OFST+4
1231  03c7 8d000000      	callf	d_ltor
1233  03cb 96            	ldw	x,sp
1234  03cc 1c000c        	addw	x,#OFST+12
1235  03cf 8d000000      	callf	d_fcmp
1237  03d3 2c16          	jrsgt	L524
1239  03d5 9c            	rvf
1240  03d6 96            	ldw	x,sp
1241  03d7 1c0008        	addw	x,#OFST+8
1242  03da 8d000000      	callf	d_ltor
1244  03de 96            	ldw	x,sp
1245  03df 1c000c        	addw	x,#OFST+12
1246  03e2 8d000000      	callf	d_fcmp
1248  03e6 2d03          	jrsle	L524
1249                     ; 213 		return 1;
1251  03e8 a601          	ld	a,#1
1254  03ea 87            	retf
1255  03eb               L524:
1256                     ; 215 		return 0;
1258  03eb 4f            	clr	a
1261  03ec 87            	retf
1332                     ; 219 float calculate_amplitude(float adc_signal[], uint32_t sample_size) 
1332                     ; 220 {
1333                     	switch	.text
1334  03ed               f_calculate_amplitude:
1336  03ed 89            	pushw	x
1337  03ee 520c          	subw	sp,#12
1338       0000000c      OFST:	set	12
1341                     ; 221 	uint32_t i = 0;
1343                     ; 222   float max_val = -V_REF, min_val = V_REF;
1345  03f0 aefffb        	ldw	x,#65531
1346  03f3 8d000000      	callf	d_itof
1348  03f7 96            	ldw	x,sp
1349  03f8 1c0001        	addw	x,#OFST-11
1350  03fb 8d000000      	callf	d_rtol
1355  03ff a605          	ld	a,#5
1356  0401 8d000000      	callf	d_ctof
1358  0405 96            	ldw	x,sp
1359  0406 1c0005        	addw	x,#OFST-7
1360  0409 8d000000      	callf	d_rtol
1363                     ; 223   for (i = 0; i < sample_size; i++) 
1365  040d ae0000        	ldw	x,#0
1366  0410 1f0b          	ldw	(OFST-1,sp),x
1367  0412 ae0000        	ldw	x,#0
1368  0415 1f09          	ldw	(OFST-3,sp),x
1371  0417 2058          	jra	L374
1372  0419               L764:
1373                     ; 225     if (adc_signal[i] > max_val) max_val = adc_signal[i];
1375  0419 9c            	rvf
1376  041a 1e0b          	ldw	x,(OFST-1,sp)
1377  041c 58            	sllw	x
1378  041d 58            	sllw	x
1379  041e 72fb0d        	addw	x,(OFST+1,sp)
1380  0421 8d000000      	callf	d_ltor
1382  0425 96            	ldw	x,sp
1383  0426 1c0001        	addw	x,#OFST-11
1384  0429 8d000000      	callf	d_fcmp
1386  042d 2d11          	jrsle	L774
1389  042f 1e0b          	ldw	x,(OFST-1,sp)
1390  0431 58            	sllw	x
1391  0432 58            	sllw	x
1392  0433 72fb0d        	addw	x,(OFST+1,sp)
1393  0436 9093          	ldw	y,x
1394  0438 ee02          	ldw	x,(2,x)
1395  043a 1f03          	ldw	(OFST-9,sp),x
1396  043c 93            	ldw	x,y
1397  043d fe            	ldw	x,(x)
1398  043e 1f01          	ldw	(OFST-11,sp),x
1400  0440               L774:
1401                     ; 226     if (adc_signal[i] < min_val) min_val = adc_signal[i];
1403  0440 9c            	rvf
1404  0441 1e0b          	ldw	x,(OFST-1,sp)
1405  0443 58            	sllw	x
1406  0444 58            	sllw	x
1407  0445 72fb0d        	addw	x,(OFST+1,sp)
1408  0448 8d000000      	callf	d_ltor
1410  044c 96            	ldw	x,sp
1411  044d 1c0005        	addw	x,#OFST-7
1412  0450 8d000000      	callf	d_fcmp
1414  0454 2e11          	jrsge	L105
1417  0456 1e0b          	ldw	x,(OFST-1,sp)
1418  0458 58            	sllw	x
1419  0459 58            	sllw	x
1420  045a 72fb0d        	addw	x,(OFST+1,sp)
1421  045d 9093          	ldw	y,x
1422  045f ee02          	ldw	x,(2,x)
1423  0461 1f07          	ldw	(OFST-5,sp),x
1424  0463 93            	ldw	x,y
1425  0464 fe            	ldw	x,(x)
1426  0465 1f05          	ldw	(OFST-7,sp),x
1428  0467               L105:
1429                     ; 223   for (i = 0; i < sample_size; i++) 
1431  0467 96            	ldw	x,sp
1432  0468 1c0009        	addw	x,#OFST-3
1433  046b a601          	ld	a,#1
1434  046d 8d000000      	callf	d_lgadc
1437  0471               L374:
1440  0471 96            	ldw	x,sp
1441  0472 1c0009        	addw	x,#OFST-3
1442  0475 8d000000      	callf	d_ltor
1444  0479 96            	ldw	x,sp
1445  047a 1c0012        	addw	x,#OFST+6
1446  047d 8d000000      	callf	d_lcmp
1448  0481 2596          	jrult	L764
1449                     ; 228   return (max_val - min_val);
1451  0483 96            	ldw	x,sp
1452  0484 1c0001        	addw	x,#OFST-11
1453  0487 8d000000      	callf	d_ltor
1455  048b 96            	ldw	x,sp
1456  048c 1c0005        	addw	x,#OFST-7
1457  048f 8d000000      	callf	d_fsub
1461  0493 5b0e          	addw	sp,#14
1462  0495 87            	retf
1521                     	xdef	f_main
1522                     	xdef	f_detectZeroCross
1523                     	xdef	f_detectPosZeroCross
1524                     	xdef	f_calculate_amplitude
1525                     	xdef	f_read_ADC_Channel
1526                     	xdef	f_ADC2_setup
1527                     	xdef	f_UART3_setup
1528                     	xdef	f_elapsedTime
1529                     	xdef	f_clock_setup
1530                     	xdef	_crossingType
1531                     	xdef	_currentEdgeTime
1532                     	xdef	_lastEdgeTime
1533                     	xdef	_sine1_amplitude
1534                     	xdef	_sine1_frequency
1535                     	xref	f_micros
1536                     	xref	f_delay_us
1537                     	xref	f_TIM4_Config
1538                     	xdef	f_putchar
1539                     	xref	f_printf
1540                     	xref	f_UART3_GetFlagStatus
1541                     	xref	f_UART3_SendData8
1542                     	xref	f_UART3_Cmd
1543                     	xref	f_UART3_Init
1544                     	xref	f_UART3_DeInit
1545                     	xref	f_GPIO_Init
1546                     	xref	f_GPIO_DeInit
1547                     	xref	f_CLK_GetFlagStatus
1548                     	xref	f_CLK_SYSCLKConfig
1549                     	xref	f_CLK_HSIPrescalerConfig
1550                     	xref	f_CLK_ClockSwitchConfig
1551                     	xref	f_CLK_PeripheralClockConfig
1552                     	xref	f_CLK_ClockSwitchCmd
1553                     	xref	f_CLK_LSICmd
1554                     	xref	f_CLK_HSICmd
1555                     	xref	f_CLK_HSECmd
1556                     	xref	f_CLK_DeInit
1557                     	xref	f_ADC2_ClearFlag
1558                     	xref	f_ADC2_GetFlagStatus
1559                     	xref	f_ADC2_GetConversionValue
1560                     	xref	f_ADC2_StartConversion
1561                     	xref	f_ADC2_ConversionConfig
1562                     	xref	f_ADC2_Cmd
1563                     	xref	f_ADC2_Init
1564                     	xref	f_ADC2_DeInit
1565                     	switch	.const
1566  0800               L351:
1567  0800 416d706c6974  	dc.b	"Amplitude: %f",10
1568  080e 0d00          	dc.b	13,0
1569  0810               L151:
1570  0810 0a4672657175  	dc.b	10,70,114,101,113,117
1571  0816 656e63793a20  	dc.b	"ency: %f",10
1572  081f 0d00          	dc.b	13,0
1573  0821               L741:
1574  0821 25662c2000    	dc.b	"%f, ",0
1575  0826               L531:
1576  0826 49742400      	dc.w	18804,9216
1577  082a               L521:
1578  082a 3f800000      	dc.w	16256,0
1579  082e               L311:
1580  082e 401851eb      	dc.w	16408,20971
1581  0832               L101:
1582  0832 3b954409      	dc.w	15253,17417
1583  0836               L16:
1584  0836 496e69746961  	dc.b	"Initializing Uart "
1585  0848 537461727469  	dc.b	"Starting:",10
1586  0852 0d00          	dc.b	13,0
1587                     	xref.b	c_x
1588                     	xref.b	c_y
1608                     	xref	d_fsub
1609                     	xref	d_lgadc
1610                     	xref	d_ctof
1611                     	xref	d_itof
1612                     	xref	d_fneg
1613                     	xref	d_fcmp
1614                     	xref	d_ladd
1615                     	xref	d_lneg
1616                     	xref	d_lcmp
1617                     	xref	d_fgadd
1618                     	xref	d_fdiv
1619                     	xref	d_ultof
1620                     	xref	d_lsub
1621                     	xref	d_ltor
1622                     	xref	d_lzmp
1623                     	xref	d_rtol
1624                     	xref	d_fmul
1625                     	xref	d_uitof
1626                     	xref	d_xymovl
1627                     	end
