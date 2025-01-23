   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  52                     ; 4 void clock_setup(void) {
  53                     	switch	.text
  54  0000               f_clock_setup:
  58                     ; 5 	CLK_DeInit();
  60  0000 8d000000      	callf	f_CLK_DeInit
  62                     ; 6 	CLK_HSECmd(DISABLE);
  64  0004 4f            	clr	a
  65  0005 8d000000      	callf	f_CLK_HSECmd
  67                     ; 7 	CLK_LSICmd(DISABLE);
  69  0009 4f            	clr	a
  70  000a 8d000000      	callf	f_CLK_LSICmd
  72                     ; 8 	CLK_HSICmd(ENABLE);
  74  000e a601          	ld	a,#1
  75  0010 8d000000      	callf	f_CLK_HSICmd
  78  0014               L32:
  79                     ; 9 	while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
  81  0014 ae0102        	ldw	x,#258
  82  0017 8d000000      	callf	f_CLK_GetFlagStatus
  84  001b 4d            	tnz	a
  85  001c 27f6          	jreq	L32
  86                     ; 12 	CLK_ClockSwitchCmd(ENABLE);
  88  001e a601          	ld	a,#1
  89  0020 8d000000      	callf	f_CLK_ClockSwitchCmd
  91                     ; 13 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  93  0024 4f            	clr	a
  94  0025 8d000000      	callf	f_CLK_HSIPrescalerConfig
  96                     ; 14 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
  98  0029 a680          	ld	a,#128
  99  002b 8d000000      	callf	f_CLK_SYSCLKConfig
 101                     ; 15 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 103  002f 4b01          	push	#1
 104  0031 4b00          	push	#0
 105  0033 ae01e1        	ldw	x,#481
 106  0036 8d000000      	callf	f_CLK_ClockSwitchConfig
 108  003a 85            	popw	x
 109                     ; 19 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 111  003b ae0301        	ldw	x,#769
 112  003e 8d000000      	callf	f_CLK_PeripheralClockConfig
 114                     ; 20 }
 117  0042 87            	retf
 142                     ; 23 void UART3_setup(void) {
 143                     	switch	.text
 144  0043               f_UART3_setup:
 148                     ; 24 	UART3_DeInit();
 150  0043 8d000000      	callf	f_UART3_DeInit
 152                     ; 25 	UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO, UART3_MODE_TXRX_ENABLE);
 154  0047 4b0c          	push	#12
 155  0049 4b00          	push	#0
 156  004b 4b00          	push	#0
 157  004d 4b00          	push	#0
 158  004f ae2580        	ldw	x,#9600
 159  0052 89            	pushw	x
 160  0053 ae0000        	ldw	x,#0
 161  0056 89            	pushw	x
 162  0057 8d000000      	callf	f_UART3_Init
 164  005b 5b08          	addw	sp,#8
 165                     ; 26 	UART3_Cmd(ENABLE);
 167  005d a601          	ld	a,#1
 168  005f 8d000000      	callf	f_UART3_Cmd
 170                     ; 27 }
 173  0063 87            	retf
 199                     ; 30 void ADC2_setup(void) {
 200                     	switch	.text
 201  0064               f_ADC2_setup:
 205                     ; 31 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 207  0064 ae1301        	ldw	x,#4865
 208  0067 8d000000      	callf	f_CLK_PeripheralClockConfig
 210                     ; 32 	ADC2_DeInit();
 212  006b 8d000000      	callf	f_ADC2_DeInit
 214                     ; 34 	ADC2_Init(ADC2_CONVERSIONMODE_CONTINUOUS, ADC2_CHANNEL_5, ADC2_PRESSEL_FCPU_D2, ADC2_EXTTRIG_GPIO, DISABLE,
 214                     ; 35 						ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL5 | ADC2_SCHMITTTRIG_CHANNEL6, DISABLE);
 216  006f 4b00          	push	#0
 217  0071 4b07          	push	#7
 218  0073 4b08          	push	#8
 219  0075 4b00          	push	#0
 220  0077 4b01          	push	#1
 221  0079 4b00          	push	#0
 222  007b ae0105        	ldw	x,#261
 223  007e 8d000000      	callf	f_ADC2_Init
 225  0082 5b06          	addw	sp,#6
 226                     ; 37 	ADC2_Cmd(ENABLE);
 228  0084 a601          	ld	a,#1
 229  0086 8d000000      	callf	f_ADC2_Cmd
 231                     ; 38 }
 234  008a 87            	retf
 269                     ; 41 PUTCHAR_PROTOTYPE {
 270                     	switch	.text
 271  008b               f_putchar:
 273  008b 88            	push	a
 274       00000000      OFST:	set	0
 277                     ; 42 	UART3_SendData8(c);
 279  008c 8d000000      	callf	f_UART3_SendData8
 282  0090               L76:
 283                     ; 43 	while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);  // Wait for transmission to complete
 285  0090 ae0080        	ldw	x,#128
 286  0093 8d000000      	callf	f_UART3_GetFlagStatus
 288  0097 4d            	tnz	a
 289  0098 27f6          	jreq	L76
 290                     ; 44 	return c;
 292  009a 7b01          	ld	a,(OFST+1,sp)
 295  009c 5b01          	addw	sp,#1
 296  009e 87            	retf
 331                     ; 47 GETCHAR_PROTOTYPE
 331                     ; 48 {
 332                     	switch	.text
 333  009f               f_getchar:
 335  009f 88            	push	a
 336       00000001      OFST:	set	1
 339                     ; 49   char c = 0;
 342  00a0               L311:
 343                     ; 51   while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
 345  00a0 ae0020        	ldw	x,#32
 346  00a3 8d000000      	callf	f_UART3_GetFlagStatus
 348  00a7 4d            	tnz	a
 349  00a8 27f6          	jreq	L311
 350                     ; 52 	c = UART3_ReceiveData8();
 352  00aa 8d000000      	callf	f_UART3_ReceiveData8
 354  00ae 6b01          	ld	(OFST+0,sp),a
 356                     ; 53   return (c);
 358  00b0 7b01          	ld	a,(OFST+0,sp)
 361  00b2 5b01          	addw	sp,#1
 362  00b4 87            	retf
 386                     ; 57 void UART3_ClearBuffer(void) {
 387                     	switch	.text
 388  00b5               f_UART3_ClearBuffer:
 392  00b5 2004          	jra	L131
 393  00b7               L721:
 394                     ; 59         (void)UART3_ReceiveData8(); // Clear any preexisting data
 396  00b7 8d000000      	callf	f_UART3_ReceiveData8
 398  00bb               L131:
 399                     ; 58     while (UART3_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
 401  00bb ae0020        	ldw	x,#32
 402  00be 8d000000      	callf	f_UART3_GetFlagStatus
 404  00c2 4d            	tnz	a
 405  00c3 26f2          	jrne	L721
 406                     ; 61 }
 409  00c5 87            	retf
 473                     ; 63 void UART3_ReceiveString(char *buffer, uint16_t max_length) {
 474                     	switch	.text
 475  00c6               f_UART3_ReceiveString:
 477  00c6 89            	pushw	x
 478  00c7 5203          	subw	sp,#3
 479       00000003      OFST:	set	3
 482                     ; 64     uint16_t i = 0;
 484                     ; 67     for (i = 0; i < max_length; i++) {
 486  00c9 5f            	clrw	x
 487  00ca 1f02          	ldw	(OFST-1,sp),x
 490  00cc 200d          	jra	L371
 491  00ce               L761:
 492                     ; 68         buffer[i] = '\0';
 494  00ce 1e04          	ldw	x,(OFST+1,sp)
 495  00d0 72fb02        	addw	x,(OFST-1,sp)
 496  00d3 7f            	clr	(x)
 497                     ; 67     for (i = 0; i < max_length; i++) {
 499  00d4 1e02          	ldw	x,(OFST-1,sp)
 500  00d6 1c0001        	addw	x,#1
 501  00d9 1f02          	ldw	(OFST-1,sp),x
 503  00db               L371:
 506  00db 1e02          	ldw	x,(OFST-1,sp)
 507  00dd 1309          	cpw	x,(OFST+6,sp)
 508  00df 25ed          	jrult	L761
 509                     ; 70     i = 0;
 511  00e1 5f            	clrw	x
 512  00e2 1f02          	ldw	(OFST-1,sp),x
 515  00e4 202c          	jra	L302
 516  00e6               L112:
 517                     ; 74         while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
 519  00e6 ae0020        	ldw	x,#32
 520  00e9 8d000000      	callf	f_UART3_GetFlagStatus
 522  00ed 4d            	tnz	a
 523  00ee 27f6          	jreq	L112
 524                     ; 76         receivedChar = UART3_ReceiveData8();
 526  00f0 8d000000      	callf	f_UART3_ReceiveData8
 528  00f4 6b01          	ld	(OFST-2,sp),a
 530                     ; 78         if (receivedChar == '\n' || receivedChar == '\r') {
 532  00f6 7b01          	ld	a,(OFST-2,sp)
 533  00f8 a10a          	cp	a,#10
 534  00fa 271d          	jreq	L502
 536  00fc 7b01          	ld	a,(OFST-2,sp)
 537  00fe a10d          	cp	a,#13
 538  0100 2717          	jreq	L502
 539                     ; 82         buffer[i++] = receivedChar;
 541  0102 7b01          	ld	a,(OFST-2,sp)
 542  0104 1e02          	ldw	x,(OFST-1,sp)
 543  0106 1c0001        	addw	x,#1
 544  0109 1f02          	ldw	(OFST-1,sp),x
 545  010b 1d0001        	subw	x,#1
 547  010e 72fb04        	addw	x,(OFST+1,sp)
 548  0111 f7            	ld	(x),a
 549  0112               L302:
 550                     ; 73     while (i < max_length - 1) {
 552  0112 1e09          	ldw	x,(OFST+6,sp)
 553  0114 5a            	decw	x
 554  0115 1302          	cpw	x,(OFST-1,sp)
 555  0117 22cd          	jrugt	L112
 556  0119               L502:
 557                     ; 85     buffer[i] = '\0'; // Null-terminate the string
 559  0119 1e04          	ldw	x,(OFST+1,sp)
 560  011b 72fb02        	addw	x,(OFST-1,sp)
 561  011e 7f            	clr	(x)
 562                     ; 86 }
 565  011f 5b05          	addw	sp,#5
 566  0121 87            	retf
 608                     ; 89 uint32_t elapsedTime(uint32_t start, uint32_t end) {
 609                     	switch	.text
 610  0122               f_elapsedTime:
 612       00000000      OFST:	set	0
 615                     ; 90 	return (end >= start) ? (end - start) : ((0xffffffff - start + 1) + end);
 617  0122 96            	ldw	x,sp
 618  0123 1c0008        	addw	x,#OFST+8
 619  0126 8d000000      	callf	d_ltor
 621  012a 96            	ldw	x,sp
 622  012b 1c0004        	addw	x,#OFST+4
 623  012e 8d000000      	callf	d_lcmp
 625  0132 2512          	jrult	L42
 626  0134 96            	ldw	x,sp
 627  0135 1c0008        	addw	x,#OFST+8
 628  0138 8d000000      	callf	d_ltor
 630  013c 96            	ldw	x,sp
 631  013d 1c0004        	addw	x,#OFST+4
 632  0140 8d000000      	callf	d_lsub
 634  0144 2014          	jra	L62
 635  0146               L42:
 636  0146 96            	ldw	x,sp
 637  0147 1c0004        	addw	x,#OFST+4
 638  014a 8d000000      	callf	d_ltor
 640  014e 8d000000      	callf	d_lneg
 642  0152 96            	ldw	x,sp
 643  0153 1c0008        	addw	x,#OFST+8
 644  0156 8d000000      	callf	d_ladd
 646  015a               L62:
 649  015a 87            	retf
 696                     ; 94 unsigned int read_ADC_Channel(uint8_t channel) {
 697                     	switch	.text
 698  015b               f_read_ADC_Channel:
 700  015b 89            	pushw	x
 701       00000002      OFST:	set	2
 704                     ; 95 	unsigned int adcValue = 0;
 706                     ; 96 	ADC2_ConversionConfig(ADC2_CONVERSIONMODE_CONTINUOUS, channel, ADC2_ALIGN_RIGHT);
 708  015c 4b08          	push	#8
 709  015e ae0100        	ldw	x,#256
 710  0161 97            	ld	xl,a
 711  0162 8d000000      	callf	f_ADC2_ConversionConfig
 713  0166 84            	pop	a
 714                     ; 97 	ADC2_StartConversion();
 716  0167 8d000000      	callf	f_ADC2_StartConversion
 719  016b               L762:
 720                     ; 99 	while (ADC2_GetFlagStatus() == RESET);
 722  016b 8d000000      	callf	f_ADC2_GetFlagStatus
 724  016f 4d            	tnz	a
 725  0170 27f9          	jreq	L762
 726                     ; 101 	adcValue = ADC2_GetConversionValue();
 728  0172 8d000000      	callf	f_ADC2_GetConversionValue
 730  0176 1f01          	ldw	(OFST-1,sp),x
 732                     ; 102 	ADC2_ClearFlag();
 734  0178 8d000000      	callf	f_ADC2_ClearFlag
 736                     ; 103 	return adcValue;
 738  017c 1e01          	ldw	x,(OFST-1,sp)
 741  017e 5b02          	addw	sp,#2
 742  0180 87            	retf
 754                     	xdef	f_getchar
 755                     	xdef	f_putchar
 756                     	xdef	f_read_ADC_Channel
 757                     	xdef	f_elapsedTime
 758                     	xdef	f_UART3_ReceiveString
 759                     	xdef	f_UART3_ClearBuffer
 760                     	xdef	f_ADC2_setup
 761                     	xdef	f_UART3_setup
 762                     	xdef	f_clock_setup
 763                     	xref	f_UART3_GetFlagStatus
 764                     	xref	f_UART3_SendData8
 765                     	xref	f_UART3_ReceiveData8
 766                     	xref	f_UART3_Cmd
 767                     	xref	f_UART3_Init
 768                     	xref	f_UART3_DeInit
 769                     	xref	f_CLK_GetFlagStatus
 770                     	xref	f_CLK_SYSCLKConfig
 771                     	xref	f_CLK_HSIPrescalerConfig
 772                     	xref	f_CLK_ClockSwitchConfig
 773                     	xref	f_CLK_PeripheralClockConfig
 774                     	xref	f_CLK_ClockSwitchCmd
 775                     	xref	f_CLK_LSICmd
 776                     	xref	f_CLK_HSICmd
 777                     	xref	f_CLK_HSECmd
 778                     	xref	f_CLK_DeInit
 779                     	xref	f_ADC2_ClearFlag
 780                     	xref	f_ADC2_GetFlagStatus
 781                     	xref	f_ADC2_GetConversionValue
 782                     	xref	f_ADC2_StartConversion
 783                     	xref	f_ADC2_ConversionConfig
 784                     	xref	f_ADC2_Cmd
 785                     	xref	f_ADC2_Init
 786                     	xref	f_ADC2_DeInit
 805                     	xref	d_ladd
 806                     	xref	d_lneg
 807                     	xref	d_lsub
 808                     	xref	d_lcmp
 809                     	xref	d_ltor
 810                     	end
