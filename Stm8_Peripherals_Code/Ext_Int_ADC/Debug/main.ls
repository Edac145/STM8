   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _state:
  16  0000 00            	dc.b	0
  17  0001               _delay_flag:
  18  0001 00            	dc.b	0
  56                     ; 31 void main()
  56                     ; 32 {
  58                     	switch	.text
  59  0000               _main:
  63                     ; 33 	clock_setup();
  65  0000 cd0094        	call	_clock_setup
  67                     ; 34 	TIM4_Config();
  69  0003 cd0000        	call	_TIM4_Config
  71                     ; 35 	GPIO_setup();
  73  0006 ad34          	call	_GPIO_setup
  75                     ; 36 	ADC2_setup();
  77  0008 cd0170        	call	_ADC2_setup
  79                     ; 37 	GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
  81  000b 4b08          	push	#8
  82  000d ae500a        	ldw	x,#20490
  83  0010 cd0000        	call	_GPIO_WriteHigh
  85  0013 84            	pop	a
  86                     ; 38 	EXTI_setup();
  88  0014 ad65          	call	_EXTI_setup
  90  0016               L12:
  91                     ; 41 		if (delay_flag)
  93  0016 3d01          	tnz	_delay_flag
  94  0018 27fc          	jreq	L12
  95                     ; 43         delay_ms(5);  // Now it's safe to use delay_ms() outside the ISR
  97  001a ae0005        	ldw	x,#5
  98  001d cd0000        	call	_delay_ms
 100                     ; 44         GPIO_WriteLow(GPIOD, GPIO_PIN_4);
 102  0020 4b10          	push	#16
 103  0022 ae500f        	ldw	x,#20495
 104  0025 cd0000        	call	_GPIO_WriteLow
 106  0028 84            	pop	a
 107                     ; 45         delay_flag = 0;  // Reset flag
 109  0029 3f01          	clr	_delay_flag
 110                     ; 46 				GPIO_WriteLow(GPIOC, GPIO_PIN_3);
 112  002b 4b08          	push	#8
 113  002d ae500a        	ldw	x,#20490
 114  0030 cd0000        	call	_GPIO_WriteLow
 116  0033 84            	pop	a
 117                     ; 47 				delay_ms(2000);
 119  0034 ae07d0        	ldw	x,#2000
 120  0037 cd0000        	call	_delay_ms
 122  003a 20da          	jra	L12
 147                     ; 54 void GPIO_setup(void)
 147                     ; 55 {
 148                     	switch	.text
 149  003c               _GPIO_setup:
 153                     ; 56 	GPIO_DeInit(GPIOB);     
 155  003c ae5005        	ldw	x,#20485
 156  003f cd0000        	call	_GPIO_DeInit
 158                     ; 57 	GPIO_DeInit(GPIOC); 
 160  0042 ae500a        	ldw	x,#20490
 161  0045 cd0000        	call	_GPIO_DeInit
 163                     ; 58 	GPIO_DeInit(GPIOD);	
 165  0048 ae500f        	ldw	x,#20495
 166  004b cd0000        	call	_GPIO_DeInit
 168                     ; 59 	GPIO_Init(GPIOB, GPIO_PIN_7, GPIO_MODE_IN_PU_IT);
 170  004e 4b60          	push	#96
 171  0050 4b80          	push	#128
 172  0052 ae5005        	ldw	x,#20485
 173  0055 cd0000        	call	_GPIO_Init
 175  0058 85            	popw	x
 176                     ; 60 	GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);
 178  0059 4be0          	push	#224
 179  005b 4b04          	push	#4
 180  005d ae500a        	ldw	x,#20490
 181  0060 cd0000        	call	_GPIO_Init
 183  0063 85            	popw	x
 184                     ; 61 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 186  0064 4be0          	push	#224
 187  0066 4b08          	push	#8
 188  0068 ae500a        	ldw	x,#20490
 189  006b cd0000        	call	_GPIO_Init
 191  006e 85            	popw	x
 192                     ; 62 	GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
 194  006f 4be0          	push	#224
 195  0071 4b10          	push	#16
 196  0073 ae500f        	ldw	x,#20495
 197  0076 cd0000        	call	_GPIO_Init
 199  0079 85            	popw	x
 200                     ; 63 }
 203  007a 81            	ret
 232                     ; 65 void EXTI_setup(void)
 232                     ; 66 {
 233                     	switch	.text
 234  007b               _EXTI_setup:
 238                     ; 67 	ITC_DeInit();
 240  007b cd0000        	call	_ITC_DeInit
 242                     ; 68 	ITC_SetSoftwarePriority(ITC_IRQ_PORTB, ITC_PRIORITYLEVEL_0);
 244  007e ae0402        	ldw	x,#1026
 245  0081 cd0000        	call	_ITC_SetSoftwarePriority
 247                     ; 70 	EXTI_DeInit();
 249  0084 cd0000        	call	_EXTI_DeInit
 251                     ; 71 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOB, EXTI_SENSITIVITY_RISE_ONLY);
 253  0087 ae0101        	ldw	x,#257
 254  008a cd0000        	call	_EXTI_SetExtIntSensitivity
 256                     ; 72 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_RISE_ONLY);
 258  008d a604          	ld	a,#4
 259  008f cd0000        	call	_EXTI_SetTLISensitivity
 261                     ; 74 	enableInterrupts();
 264  0092 9a            rim
 266                     ; 75 }
 270  0093 81            	ret
 303                     ; 77 void clock_setup(void)
 303                     ; 78 {
 304                     	switch	.text
 305  0094               _clock_setup:
 309                     ; 79     CLK_DeInit();
 311  0094 cd0000        	call	_CLK_DeInit
 313                     ; 81     CLK_HSECmd(DISABLE);
 315  0097 4f            	clr	a
 316  0098 cd0000        	call	_CLK_HSECmd
 318                     ; 82     CLK_LSICmd(DISABLE);
 320  009b 4f            	clr	a
 321  009c cd0000        	call	_CLK_LSICmd
 323                     ; 83     CLK_HSICmd(ENABLE);
 325  009f a601          	ld	a,#1
 326  00a1 cd0000        	call	_CLK_HSICmd
 329  00a4               L16:
 330                     ; 84     while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 332  00a4 ae0102        	ldw	x,#258
 333  00a7 cd0000        	call	_CLK_GetFlagStatus
 335  00aa 4d            	tnz	a
 336  00ab 27f7          	jreq	L16
 337                     ; 86     CLK_ClockSwitchCmd(ENABLE);
 339  00ad a601          	ld	a,#1
 340  00af cd0000        	call	_CLK_ClockSwitchCmd
 342                     ; 87     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 344  00b2 4f            	clr	a
 345  00b3 cd0000        	call	_CLK_HSIPrescalerConfig
 347                     ; 88     CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 349  00b6 a680          	ld	a,#128
 350  00b8 cd0000        	call	_CLK_SYSCLKConfig
 352                     ; 90     CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 352                     ; 91     DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 354  00bb 4b01          	push	#1
 355  00bd 4b00          	push	#0
 356  00bf ae01e1        	ldw	x,#481
 357  00c2 cd0000        	call	_CLK_ClockSwitchConfig
 359  00c5 85            	popw	x
 360                     ; 93     CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 362  00c6 ae0100        	ldw	x,#256
 363  00c9 cd0000        	call	_CLK_PeripheralClockConfig
 365                     ; 94     CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 367  00cc 5f            	clrw	x
 368  00cd cd0000        	call	_CLK_PeripheralClockConfig
 370                     ; 95     CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 372  00d0 ae1300        	ldw	x,#4864
 373  00d3 cd0000        	call	_CLK_PeripheralClockConfig
 375                     ; 96     CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 377  00d6 ae1200        	ldw	x,#4608
 378  00d9 cd0000        	call	_CLK_PeripheralClockConfig
 380                     ; 97     CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 382  00dc ae0301        	ldw	x,#769
 383  00df cd0000        	call	_CLK_PeripheralClockConfig
 385                     ; 98     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 387  00e2 ae0700        	ldw	x,#1792
 388  00e5 cd0000        	call	_CLK_PeripheralClockConfig
 390                     ; 99     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 392  00e8 ae0500        	ldw	x,#1280
 393  00eb cd0000        	call	_CLK_PeripheralClockConfig
 395                     ; 100     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 397  00ee ae0401        	ldw	x,#1025
 398  00f1 cd0000        	call	_CLK_PeripheralClockConfig
 400                     ; 101 }
 403  00f4 81            	ret
 438                     ; 104 float convert_adc_to_voltage(unsigned int adcValue) {
 439                     	switch	.text
 440  00f5               _convert_adc_to_voltage:
 444                     ; 105 	return adcValue * (V_REF / ADC_MAX_VALUE);
 446  00f5 cd0000        	call	c_uitof
 448  00f8 ae0008        	ldw	x,#L701
 449  00fb cd0000        	call	c_fmul
 453  00fe 81            	ret
 496                     ; 109 uint32_t elapsedTime(uint32_t start, uint32_t end) {
 497                     	switch	.text
 498  00ff               _elapsedTime:
 500       00000000      OFST:	set	0
 503                     ; 110 	return (end >= start) ? (end - start) : ((0xffffffff - start + 1) + end);
 505  00ff 96            	ldw	x,sp
 506  0100 1c0007        	addw	x,#OFST+7
 507  0103 cd0000        	call	c_ltor
 509  0106 96            	ldw	x,sp
 510  0107 1c0003        	addw	x,#OFST+3
 511  010a cd0000        	call	c_lcmp
 513  010d 2510          	jrult	L02
 514  010f 96            	ldw	x,sp
 515  0110 1c0007        	addw	x,#OFST+7
 516  0113 cd0000        	call	c_ltor
 518  0116 96            	ldw	x,sp
 519  0117 1c0003        	addw	x,#OFST+3
 520  011a cd0000        	call	c_lsub
 522  011d 2011          	jra	L22
 523  011f               L02:
 524  011f 96            	ldw	x,sp
 525  0120 1c0003        	addw	x,#OFST+3
 526  0123 cd0000        	call	c_ltor
 528  0126 cd0000        	call	c_lneg
 530  0129 96            	ldw	x,sp
 531  012a 1c0007        	addw	x,#OFST+7
 532  012d cd0000        	call	c_ladd
 534  0130               L22:
 537  0130 81            	ret
 585                     ; 114 unsigned int read_ADC_Channel(uint8_t channel) {
 586                     	switch	.text
 587  0131               _read_ADC_Channel:
 589  0131 89            	pushw	x
 590       00000002      OFST:	set	2
 593                     ; 115 	unsigned int adcValue = 0;
 595                     ; 116 	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, channel, ADC2_ALIGN_RIGHT);
 597  0132 4b08          	push	#8
 598  0134 ae0100        	ldw	x,#256
 599  0137 97            	ld	xl,a
 600  0138 cd0000        	call	_ADC2_ConversionConfig
 602  013b 84            	pop	a
 603                     ; 117 	ADC2_StartConversion();
 605  013c cd0000        	call	_ADC2_StartConversion
 608  013f               L161:
 609                     ; 119 	while (ADC2_GetFlagStatus() == RESET);
 611  013f cd0000        	call	_ADC2_GetFlagStatus
 613  0142 4d            	tnz	a
 614  0143 27fa          	jreq	L161
 615                     ; 121 	adcValue = ADC2_GetConversionValue();
 617  0145 cd0000        	call	_ADC2_GetConversionValue
 619  0148 1f01          	ldw	(OFST-1,sp),x
 621                     ; 122 	ADC2_ClearFlag();
 623  014a cd0000        	call	_ADC2_ClearFlag
 625                     ; 123 	return adcValue;
 627  014d 1e01          	ldw	x,(OFST-1,sp)
 630  014f 5b02          	addw	sp,#2
 631  0151 81            	ret
 657                     ; 127 void UART3_setup(void) {
 658                     	switch	.text
 659  0152               _UART3_setup:
 663                     ; 128 	UART3_DeInit();
 665  0152 cd0000        	call	_UART3_DeInit
 667                     ; 129 	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TX_ENABLE);
 669  0155 4b04          	push	#4
 670  0157 4b00          	push	#0
 671  0159 4b00          	push	#0
 672  015b 4b00          	push	#0
 673  015d ae2580        	ldw	x,#9600
 674  0160 89            	pushw	x
 675  0161 ae0000        	ldw	x,#0
 676  0164 89            	pushw	x
 677  0165 cd0000        	call	_UART3_Init
 679  0168 5b08          	addw	sp,#8
 680                     ; 130 	UART3_Cmd(ENABLE);
 682  016a a601          	ld	a,#1
 683  016c cd0000        	call	_UART3_Cmd
 685                     ; 131 }
 688  016f 81            	ret
 715                     ; 134 void ADC2_setup(void) {
 716                     	switch	.text
 717  0170               _ADC2_setup:
 721                     ; 135 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 723  0170 ae1301        	ldw	x,#4865
 724  0173 cd0000        	call	_CLK_PeripheralClockConfig
 726                     ; 136 	ADC2_DeInit();
 728  0176 cd0000        	call	_ADC2_DeInit
 730                     ; 138 	ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
 730                     ; 139 						ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5, DISABLE);
 732  0179 4b00          	push	#0
 733  017b 4b05          	push	#5
 734  017d 4b08          	push	#8
 735  017f 4b00          	push	#0
 736  0181 4b01          	push	#1
 737  0183 4b00          	push	#0
 738  0185 ae0105        	ldw	x,#261
 739  0188 cd0000        	call	_ADC2_Init
 741  018b 5b06          	addw	sp,#6
 742                     ; 141 	ADC2_Cmd(ENABLE);
 744  018d a601          	ld	a,#1
 745  018f cd0000        	call	_ADC2_Cmd
 747                     ; 142 }
 750  0192 81            	ret
 778                     .const:	section	.text
 779  0000               L43:
 780  0000 00000008      	dc.l	8
 781  0004               L63:
 782  0004 00000064      	dc.l	100
 783                     ; 144 void EXTI1_IRQHandler(void)
 783                     ; 145 {
 784                     	scross	on
 785                     	switch	.text
 786  0193               f_EXTI1_IRQHandler:
 788  0193 8a            	push	cc
 789  0194 84            	pop	a
 790  0195 a4bf          	and	a,#191
 791  0197 88            	push	a
 792  0198 86            	pop	cc
 793  0199 3b0002        	push	c_x+2
 794  019c be00          	ldw	x,c_x
 795  019e 89            	pushw	x
 796  019f 3b0002        	push	c_y+2
 797  01a2 be00          	ldw	x,c_y
 798  01a4 89            	pushw	x
 799  01a5 be02          	ldw	x,c_lreg+2
 800  01a7 89            	pushw	x
 801  01a8 be00          	ldw	x,c_lreg
 802  01aa 89            	pushw	x
 805                     ; 146 	state = 1;
 807  01ab 35010000      	mov	_state,#1
 808                     ; 147 	GPIO_WriteHigh(GPIOD, GPIO_PIN_4);
 810  01af 4b10          	push	#16
 811  01b1 ae500f        	ldw	x,#20495
 812  01b4 cd0000        	call	_GPIO_WriteHigh
 814  01b7 84            	pop	a
 815                     ; 148 	delay_flag = 1;  // Set flag to indicate delay should happen
 817  01b8 35010001      	mov	_delay_flag,#1
 818                     ; 149 	for(i = 0; i < 100; i++)
 820  01bc ae0000        	ldw	x,#0
 821  01bf bf06          	ldw	_i+2,x
 822  01c1 ae0000        	ldw	x,#0
 823  01c4 bf04          	ldw	_i,x
 824  01c6               L512:
 825                     ; 151 		for(j = 0; j < 8; j++)
 827  01c6 ae0000        	ldw	x,#0
 828  01c9 bf02          	ldw	_j+2,x
 829  01cb ae0000        	ldw	x,#0
 830  01ce bf00          	ldw	_j,x
 831  01d0               L322:
 834  01d0 ae0000        	ldw	x,#_j
 835  01d3 a601          	ld	a,#1
 836  01d5 cd0000        	call	c_lgadc
 840  01d8 ae0000        	ldw	x,#_j
 841  01db cd0000        	call	c_ltor
 843  01de ae0000        	ldw	x,#L43
 844  01e1 cd0000        	call	c_lcmp
 846  01e4 25ea          	jrult	L322
 847                     ; 149 	for(i = 0; i < 100; i++)
 849  01e6 ae0004        	ldw	x,#_i
 850  01e9 a601          	ld	a,#1
 851  01eb cd0000        	call	c_lgadc
 855  01ee ae0004        	ldw	x,#_i
 856  01f1 cd0000        	call	c_ltor
 858  01f4 ae0004        	ldw	x,#L63
 859  01f7 cd0000        	call	c_lcmp
 861  01fa 25ca          	jrult	L512
 862                     ; 159 }
 865  01fc 85            	popw	x
 866  01fd bf00          	ldw	c_lreg,x
 867  01ff 85            	popw	x
 868  0200 bf02          	ldw	c_lreg+2,x
 869  0202 85            	popw	x
 870  0203 bf00          	ldw	c_y,x
 871  0205 320002        	pop	c_y+2
 872  0208 85            	popw	x
 873  0209 bf00          	ldw	c_x,x
 874  020b 320002        	pop	c_x+2
 875  020e 80            	iret
 946                     	xdef	_read_ADC_Channel
 947                     	xdef	_elapsedTime
 948                     	xdef	_convert_adc_to_voltage
 949                     	xdef	_main
 950                     	xdef	f_EXTI1_IRQHandler
 951                     	xdef	_ADC2_setup
 952                     	xdef	_UART3_setup
 953                     	xdef	_clock_setup
 954                     	xdef	_EXTI_setup
 955                     	xdef	_GPIO_setup
 956                     	xdef	_delay_flag
 957                     	switch	.ubsct
 958  0000               _j:
 959  0000 00000000      	ds.b	4
 960                     	xdef	_j
 961  0004               _i:
 962  0004 00000000      	ds.b	4
 963                     	xdef	_i
 964                     	xdef	_state
 965                     	xref	_delay_ms
 966                     	xref	_TIM4_Config
 967                     	xref	_UART3_Cmd
 968                     	xref	_UART3_Init
 969                     	xref	_UART3_DeInit
 970                     	xref	_ITC_SetSoftwarePriority
 971                     	xref	_ITC_DeInit
 972                     	xref	_GPIO_WriteLow
 973                     	xref	_GPIO_WriteHigh
 974                     	xref	_GPIO_Init
 975                     	xref	_GPIO_DeInit
 976                     	xref	_EXTI_SetTLISensitivity
 977                     	xref	_EXTI_SetExtIntSensitivity
 978                     	xref	_EXTI_DeInit
 979                     	xref	_CLK_GetFlagStatus
 980                     	xref	_CLK_SYSCLKConfig
 981                     	xref	_CLK_HSIPrescalerConfig
 982                     	xref	_CLK_ClockSwitchConfig
 983                     	xref	_CLK_PeripheralClockConfig
 984                     	xref	_CLK_ClockSwitchCmd
 985                     	xref	_CLK_LSICmd
 986                     	xref	_CLK_HSICmd
 987                     	xref	_CLK_HSECmd
 988                     	xref	_CLK_DeInit
 989                     	xref	_ADC2_ClearFlag
 990                     	xref	_ADC2_GetFlagStatus
 991                     	xref	_ADC2_GetConversionValue
 992                     	xref	_ADC2_StartConversion
 993                     	xref	_ADC2_ConversionConfig
 994                     	xref	_ADC2_Cmd
 995                     	xref	_ADC2_Init
 996                     	xref	_ADC2_DeInit
 997                     	switch	.const
 998  0008               L701:
 999  0008 3b954409      	dc.w	15253,17417
1000                     	xref.b	c_lreg
1001                     	xref.b	c_x
1002                     	xref.b	c_y
1022                     	xref	c_lgadc
1023                     	xref	c_ladd
1024                     	xref	c_lneg
1025                     	xref	c_lsub
1026                     	xref	c_lcmp
1027                     	xref	c_ltor
1028                     	xref	c_fmul
1029                     	xref	c_uitof
1030                     	end
