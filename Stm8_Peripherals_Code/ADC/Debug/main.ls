   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _adc_value:
  16  0000 0000          	dc.w	0
  17  0002               _prev_value:
  18  0002 0000          	dc.w	0
  19  0004               _curr_value:
  20  0004 0000          	dc.w	0
  89                     ; 13 void main() {
  90                     	switch	.text
  91  0000               f_main:
  93  0000 5208          	subw	sp,#8
  94       00000008      OFST:	set	8
  97                     ; 15 		unsigned int prev_adc_value = 0;
  99                     ; 16 		unsigned int curr_adc_value = 0;
 101                     ; 17 		float voltage = 0;
 103                     ; 18     clock_setup();
 105  0002 8d540054      	callf	f_clock_setup
 107                     ; 19 		TIM4_Config();
 109  0006 8d000000      	callf	f_TIM4_Config
 111                     ; 20 		enableInterrupts();
 114  000a 9a            rim
 116                     ; 21 		UART3_setup();
 119  000b 8d580158      	callf	f_UART3_setup
 121                     ; 23     GPIO_setup();
 123  000f 8dc600c6      	callf	f_GPIO_setup
 125                     ; 24     ADC2_setup();
 127  0013 8d050105      	callf	f_ADC2_setup
 129                     ; 26 		printf("Startin\n");
 131  0017 ae0025        	ldw	x,#L73
 132  001a 8d000000      	callf	f_printf
 134                     ; 27     delay_ms(1000);
 136  001e ae03e8        	ldw	x,#1000
 137  0021 8d000000      	callf	f_delay_ms
 139  0025               L14:
 140                     ; 29 			GPIO_WriteHigh(GPIOC, GPIO_PIN_2); // Initialize pin for GPIO
 142  0025 4b04          	push	#4
 143  0027 ae500a        	ldw	x,#20490
 144  002a 8d000000      	callf	f_GPIO_WriteHigh
 146  002e 84            	pop	a
 147                     ; 30 			delay_ms(1000);
 149  002f ae03e8        	ldw	x,#1000
 150  0032 8d000000      	callf	f_delay_ms
 152                     ; 31 			GPIO_WriteLow(GPIOC, GPIO_PIN_2); 
 154  0036 4b04          	push	#4
 155  0038 ae500a        	ldw	x,#20490
 156  003b 8d000000      	callf	f_GPIO_WriteLow
 158  003f 84            	pop	a
 159                     ; 32 			delay_ms(1000);
 161  0040 ae03e8        	ldw	x,#1000
 162  0043 8d000000      	callf	f_delay_ms
 164                     ; 51 			printf("Conversion Startin\n");
 166  0047 ae0011        	ldw	x,#L54
 167  004a 8d000000      	callf	f_printf
 169                     ; 52 			ADC2_StartConversion();	
 171  004e 8d000000      	callf	f_ADC2_StartConversion
 174  0052 20d1          	jra	L14
 206                     ; 58 void clock_setup(void) {
 207                     	switch	.text
 208  0054               f_clock_setup:
 212                     ; 59     CLK_DeInit();
 214  0054 8d000000      	callf	f_CLK_DeInit
 216                     ; 61     CLK_HSECmd(DISABLE);
 218  0058 4f            	clr	a
 219  0059 8d000000      	callf	f_CLK_HSECmd
 221                     ; 62     CLK_LSICmd(DISABLE);
 223  005d 4f            	clr	a
 224  005e 8d000000      	callf	f_CLK_LSICmd
 226                     ; 63     CLK_HSICmd(ENABLE);
 228  0062 a601          	ld	a,#1
 229  0064 8d000000      	callf	f_CLK_HSICmd
 232  0068               L16:
 233                     ; 64     while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 235  0068 ae0102        	ldw	x,#258
 236  006b 8d000000      	callf	f_CLK_GetFlagStatus
 238  006f 4d            	tnz	a
 239  0070 27f6          	jreq	L16
 240                     ; 66     CLK_ClockSwitchCmd(ENABLE);
 242  0072 a601          	ld	a,#1
 243  0074 8d000000      	callf	f_CLK_ClockSwitchCmd
 245                     ; 67     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 247  0078 4f            	clr	a
 248  0079 8d000000      	callf	f_CLK_HSIPrescalerConfig
 250                     ; 68     CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 252  007d a680          	ld	a,#128
 253  007f 8d000000      	callf	f_CLK_SYSCLKConfig
 255                     ; 70     CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI,
 255                     ; 71                           DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 257  0083 4b01          	push	#1
 258  0085 4b00          	push	#0
 259  0087 ae01e1        	ldw	x,#481
 260  008a 8d000000      	callf	f_CLK_ClockSwitchConfig
 262  008e 85            	popw	x
 263                     ; 73     CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 265  008f ae0100        	ldw	x,#256
 266  0092 8d000000      	callf	f_CLK_PeripheralClockConfig
 268                     ; 74     CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 270  0096 5f            	clrw	x
 271  0097 8d000000      	callf	f_CLK_PeripheralClockConfig
 273                     ; 75     CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 275  009b ae1301        	ldw	x,#4865
 276  009e 8d000000      	callf	f_CLK_PeripheralClockConfig
 278                     ; 76     CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 280  00a2 ae1200        	ldw	x,#4608
 281  00a5 8d000000      	callf	f_CLK_PeripheralClockConfig
 283                     ; 77     CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 285  00a9 ae0301        	ldw	x,#769
 286  00ac 8d000000      	callf	f_CLK_PeripheralClockConfig
 288                     ; 78     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 290  00b0 ae0700        	ldw	x,#1792
 291  00b3 8d000000      	callf	f_CLK_PeripheralClockConfig
 293                     ; 79     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 295  00b7 ae0500        	ldw	x,#1280
 296  00ba 8d000000      	callf	f_CLK_PeripheralClockConfig
 298                     ; 80     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 300  00be ae0401        	ldw	x,#1025
 301  00c1 8d000000      	callf	f_CLK_PeripheralClockConfig
 303                     ; 81 }
 306  00c5 87            	retf
 330                     ; 83 void GPIO_setup(void) {
 331                     	switch	.text
 332  00c6               f_GPIO_setup:
 336                     ; 84     GPIO_DeInit(GPIOB);
 338  00c6 ae5005        	ldw	x,#20485
 339  00c9 8d000000      	callf	f_GPIO_DeInit
 341                     ; 85 		GPIO_DeInit(GPIOC);
 343  00cd ae500a        	ldw	x,#20490
 344  00d0 8d000000      	callf	f_GPIO_DeInit
 346                     ; 86     GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_IN_FL_IT);
 348  00d4 4b20          	push	#32
 349  00d6 4b20          	push	#32
 350  00d8 ae5005        	ldw	x,#20485
 351  00db 8d000000      	callf	f_GPIO_Init
 353  00df 85            	popw	x
 354                     ; 87     GPIO_Init(GPIOB, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 356  00e0 4b00          	push	#0
 357  00e2 4b40          	push	#64
 358  00e4 ae5005        	ldw	x,#20485
 359  00e7 8d000000      	callf	f_GPIO_Init
 361  00eb 85            	popw	x
 362                     ; 88 		GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
 364  00ec 4be0          	push	#224
 365  00ee 4b10          	push	#16
 366  00f0 ae500a        	ldw	x,#20490
 367  00f3 8d000000      	callf	f_GPIO_Init
 369  00f7 85            	popw	x
 370                     ; 89 		GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); 
 372  00f8 4be0          	push	#224
 373  00fa 4b04          	push	#4
 374  00fc ae500a        	ldw	x,#20490
 375  00ff 8d000000      	callf	f_GPIO_Init
 377  0103 85            	popw	x
 378                     ; 90 }
 381  0104 87            	retf
 408                     ; 92 void ADC2_setup(void) {
 409                     	switch	.text
 410  0105               f_ADC2_setup:
 414                     ; 93 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 416  0105 ae1301        	ldw	x,#4865
 417  0108 8d000000      	callf	f_CLK_PeripheralClockConfig
 419                     ; 94 	ADC2_DeInit();
 421  010c 8d000000      	callf	f_ADC2_DeInit
 423                     ; 96 ADC2_Init(ADC2_CONVERSIONMODE_SINGLE,
 423                     ; 97 			ADC2_CHANNEL_5,
 423                     ; 98 			ADC2_PRESSEL_FCPU_D2,
 423                     ; 99 			ADC2_EXTTRIG_TIM,
 423                     ; 100 			DISABLE,
 423                     ; 101 			ADC2_ALIGN_RIGHT,
 423                     ; 102 			ADC2_SCHMITTTRIG_CHANNEL5,
 423                     ; 103 			DISABLE);	
 425  0110 4b00          	push	#0
 426  0112 4b05          	push	#5
 427  0114 4b08          	push	#8
 428  0116 4b00          	push	#0
 429  0118 4b00          	push	#0
 430  011a 4b00          	push	#0
 431  011c ae0005        	ldw	x,#5
 432  011f 8d000000      	callf	f_ADC2_Init
 434  0123 5b06          	addw	sp,#6
 435                     ; 104 	ADC2_ITConfig(ENABLE);
 437  0125 a601          	ld	a,#1
 438  0127 8d000000      	callf	f_ADC2_ITConfig
 440                     ; 106 	ADC2_Cmd(ENABLE);
 442  012b a601          	ld	a,#1
 443  012d 8d000000      	callf	f_ADC2_Cmd
 445                     ; 108 }
 448  0131 87            	retf
 495                     ; 110 unsigned int read_ADC_Channel(uint8_t channel) {
 496                     	switch	.text
 497  0132               f_read_ADC_Channel:
 499  0132 89            	pushw	x
 500       00000002      OFST:	set	2
 503                     ; 111     unsigned int adcValue = 0;
 505                     ; 114     ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS,
 505                     ; 115                           channel,
 505                     ; 116                           ADC2_ALIGN_RIGHT);
 507  0133 4b08          	push	#8
 508  0135 ae0100        	ldw	x,#256
 509  0138 97            	ld	xl,a
 510  0139 8d000000      	callf	f_ADC2_ConversionConfig
 512  013d 84            	pop	a
 513                     ; 119     ADC2_StartConversion();
 515  013e 8d000000      	callf	f_ADC2_StartConversion
 518  0142               L131:
 519                     ; 122     while (ADC2_GetFlagStatus() == RESET);
 521  0142 8d000000      	callf	f_ADC2_GetFlagStatus
 523  0146 4d            	tnz	a
 524  0147 27f9          	jreq	L131
 525                     ; 125     adcValue = ADC2_GetConversionValue();
 527  0149 8d000000      	callf	f_ADC2_GetConversionValue
 529  014d 1f01          	ldw	(OFST-1,sp),x
 531                     ; 128     ADC2_ClearFlag();
 533  014f 8d000000      	callf	f_ADC2_ClearFlag
 535                     ; 130     return adcValue;
 537  0153 1e01          	ldw	x,(OFST-1,sp)
 540  0155 5b02          	addw	sp,#2
 541  0157 87            	retf
 566                     ; 133 void UART3_setup(void) {
 567                     	switch	.text
 568  0158               f_UART3_setup:
 572                     ; 134     UART3_DeInit();
 574  0158 8d000000      	callf	f_UART3_DeInit
 576                     ; 137     UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
 576                     ; 138                UART3_MODE_TX_ENABLE);
 578  015c 4b04          	push	#4
 579  015e 4b00          	push	#0
 580  0160 4b00          	push	#0
 581  0162 4b00          	push	#0
 582  0164 ae2580        	ldw	x,#9600
 583  0167 89            	pushw	x
 584  0168 ae0000        	ldw	x,#0
 585  016b 89            	pushw	x
 586  016c 8d000000      	callf	f_UART3_Init
 588  0170 5b08          	addw	sp,#8
 589                     ; 140     UART3_Cmd(ENABLE);  // Enable UART3
 591  0172 a601          	ld	a,#1
 592  0174 8d000000      	callf	f_UART3_Cmd
 594                     ; 141 }
 597  0178 87            	retf
 632                     ; 143 PUTCHAR_PROTOTYPE {
 633                     	switch	.text
 634  0179               f_putchar:
 636  0179 88            	push	a
 637       00000000      OFST:	set	0
 640                     ; 145     UART3_SendData8(c);
 642  017a 8d000000      	callf	f_UART3_SendData8
 645  017e               L561:
 646                     ; 148     while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);
 648  017e ae0080        	ldw	x,#128
 649  0181 8d000000      	callf	f_UART3_GetFlagStatus
 651  0185 4d            	tnz	a
 652  0186 27f6          	jreq	L561
 653                     ; 150     return (c);
 655  0188 7b01          	ld	a,(OFST+1,sp)
 658  018a 5b01          	addw	sp,#1
 659  018c 87            	retf
 726                     ; 153 bool check_negative_zero_crossing(void) {
 727                     	switch	.text
 728  018d               f_check_negative_zero_crossing:
 730  018d 5204          	subw	sp,#4
 731       00000004      OFST:	set	4
 734                     ; 154 	unsigned int prev_adc_value = 0;  // Store previous ADC sample value
 736  018f 5f            	clrw	x
 737  0190 1f01          	ldw	(OFST-3,sp),x
 739                     ; 155 	unsigned int current_adc_value = 0;  // Store current ADC sample value
 741  0192               L322:
 742                     ; 159 		current_adc_value = read_ADC_Channel(ADC2_CHANNEL_5);
 744  0192 a605          	ld	a,#5
 745  0194 8d320132      	callf	f_read_ADC_Channel
 747  0198 1f03          	ldw	(OFST-1,sp),x
 749                     ; 161 		if (detect_negative_zero_cross(prev_adc_value, current_adc_value, 512)) {
 751  019a ae0200        	ldw	x,#512
 752  019d 89            	pushw	x
 753  019e 1e05          	ldw	x,(OFST+1,sp)
 754  01a0 89            	pushw	x
 755  01a1 1e05          	ldw	x,(OFST+1,sp)
 756  01a3 8def01ef      	callf	f_detect_negative_zero_cross
 758  01a7 5b04          	addw	sp,#4
 759  01a9 4d            	tnz	a
 760  01aa 2714          	jreq	L722
 761                     ; 162 			printf("NZC: %u, %u\n", prev_adc_value, current_adc_value);
 763  01ac 1e03          	ldw	x,(OFST-1,sp)
 764  01ae 89            	pushw	x
 765  01af 1e03          	ldw	x,(OFST-1,sp)
 766  01b1 89            	pushw	x
 767  01b2 ae0004        	ldw	x,#L132
 768  01b5 8d000000      	callf	f_printf
 770  01b9 5b04          	addw	sp,#4
 771                     ; 163 			return true;
 773  01bb a601          	ld	a,#1
 776  01bd 5b04          	addw	sp,#4
 777  01bf 87            	retf
 778  01c0               L722:
 779                     ; 166 		prev_adc_value = current_adc_value;
 781  01c0 1e03          	ldw	x,(OFST-1,sp)
 782  01c2 1f01          	ldw	(OFST-3,sp),x
 785  01c4 20cc          	jra	L322
 819                     ; 172 float convert_adc_to_voltage(unsigned int adcValue) {
 820                     	switch	.text
 821  01c6               f_convert_adc_to_voltage:
 825                     ; 173 	return adcValue * (4.60 / 1024);
 827  01c6 8d000000      	callf	d_uitof
 829  01ca ae0000        	ldw	x,#L552
 830  01cd 8d000000      	callf	d_fmul
 834  01d1 87            	retf
 870                     ; 177 void send_square_pulse(uint16_t duration_ms) {
 871                     	switch	.text
 872  01d2               f_send_square_pulse:
 874  01d2 89            	pushw	x
 875       00000000      OFST:	set	0
 878                     ; 178 	GPIO_WriteHigh(GPIOC, GPIO_PIN_4); // Set square pulse pin high
 880  01d3 4b10          	push	#16
 881  01d5 ae500a        	ldw	x,#20490
 882  01d8 8d000000      	callf	f_GPIO_WriteHigh
 884  01dc 84            	pop	a
 885                     ; 179 	delay_ms(duration_ms);            // Wait for the pulse duration
 887  01dd 1e01          	ldw	x,(OFST+1,sp)
 888  01df 8d000000      	callf	f_delay_ms
 890                     ; 180 	GPIO_WriteLow(GPIOC, GPIO_PIN_4); // Set square pulse pin low
 892  01e3 4b10          	push	#16
 893  01e5 ae500a        	ldw	x,#20490
 894  01e8 8d000000      	callf	f_GPIO_WriteLow
 896  01ec 84            	pop	a
 897                     ; 181 }
 900  01ed 85            	popw	x
 901  01ee 87            	retf
 954                     ; 189 bool detect_negative_zero_cross(unsigned int previous_sample, unsigned int current_sample, unsigned int threshold) {
 955                     	switch	.text
 956  01ef               f_detect_negative_zero_cross:
 958  01ef 89            	pushw	x
 959       00000000      OFST:	set	0
 962                     ; 191     if(previous_sample > threshold  && current_sample <= threshold )
 964  01f0 1308          	cpw	x,(OFST+8,sp)
 965  01f2 230a          	jrule	L523
 967  01f4 1e06          	ldw	x,(OFST+6,sp)
 968  01f6 1308          	cpw	x,(OFST+8,sp)
 969  01f8 2204          	jrugt	L523
 970                     ; 192 			return 1;
 972  01fa a601          	ld	a,#1
 974  01fc 2001          	jra	L23
 975  01fe               L523:
 976                     ; 194 		 return 0;
 978  01fe 4f            	clr	a
 980  01ff               L23:
 982  01ff 85            	popw	x
 983  0200 87            	retf
1024                     	xdef	f_main
1025                     	xdef	_curr_value
1026                     	xdef	_prev_value
1027                     	xdef	_adc_value
1028                     	xdef	f_send_square_pulse
1029                     	xdef	f_detect_negative_zero_cross
1030                     	xdef	f_convert_adc_to_voltage
1031                     	xdef	f_check_negative_zero_crossing
1032                     	xdef	f_read_ADC_Channel
1033                     	xdef	f_UART3_setup
1034                     	xdef	f_ADC2_setup
1035                     	xdef	f_GPIO_setup
1036                     	xdef	f_clock_setup
1037                     	xref	f_delay_ms
1038                     	xref	f_TIM4_Config
1039                     	xdef	f_putchar
1040                     	xref	f_printf
1041                     	xref	f_UART3_GetFlagStatus
1042                     	xref	f_UART3_SendData8
1043                     	xref	f_UART3_Cmd
1044                     	xref	f_UART3_Init
1045                     	xref	f_UART3_DeInit
1046                     	xref	f_GPIO_WriteLow
1047                     	xref	f_GPIO_WriteHigh
1048                     	xref	f_GPIO_Init
1049                     	xref	f_GPIO_DeInit
1050                     	xref	f_CLK_GetFlagStatus
1051                     	xref	f_CLK_SYSCLKConfig
1052                     	xref	f_CLK_HSIPrescalerConfig
1053                     	xref	f_CLK_ClockSwitchConfig
1054                     	xref	f_CLK_PeripheralClockConfig
1055                     	xref	f_CLK_ClockSwitchCmd
1056                     	xref	f_CLK_LSICmd
1057                     	xref	f_CLK_HSICmd
1058                     	xref	f_CLK_HSECmd
1059                     	xref	f_CLK_DeInit
1060                     	xref	f_ADC2_ClearFlag
1061                     	xref	f_ADC2_GetFlagStatus
1062                     	xref	f_ADC2_GetConversionValue
1063                     	xref	f_ADC2_StartConversion
1064                     	xref	f_ADC2_ConversionConfig
1065                     	xref	f_ADC2_ITConfig
1066                     	xref	f_ADC2_Cmd
1067                     	xref	f_ADC2_Init
1068                     	xref	f_ADC2_DeInit
1069                     .const:	section	.text
1070  0000               L552:
1071  0000 3b933333      	dc.w	15251,13107
1072  0004               L132:
1073  0004 4e5a433a2025  	dc.b	"NZC: %u, %u",10,0
1074  0011               L54:
1075  0011 436f6e766572  	dc.b	"Conversion Startin"
1076  0023 0a00          	dc.b	10,0
1077  0025               L73:
1078  0025 537461727469  	dc.b	"Startin",10,0
1079                     	xref.b	c_x
1099                     	xref	d_fmul
1100                     	xref	d_uitof
1101                     	end
