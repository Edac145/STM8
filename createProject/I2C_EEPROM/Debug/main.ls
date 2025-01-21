   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _Tx1_Buffer:
  16  0000 2f2a2053544d  	dc.b	"/* STM8S I2C Firmw"
  17  0012 617265204c69  	dc.b	"are Library EEPROM"
  18  0024 206472697665  	dc.b	" driver example:",0
  19  0035               _Tx2_Buffer:
  20  0035 2f2a2053544d  	dc.b	"/* STM8S I2C",0
  21  0042               _TransferStatus1:
  22  0042 00            	dc.b	0
  23  0043               _TransferStatus2:
  24  0043 00            	dc.b	0
  25  0044               _NumDataRead:
  26  0044 0000          	dc.w	0
  27                     .const:	section	.text
  28  0000               L3_writeData:
  29  0000 48656c6c6f2c  	dc.b	"Hello, EEPROM!",0
 104                     ; 36 void main(void)
 104                     ; 37 {
 106                     	switch	.text
 107  0000               _main:
 109  0000 5212          	subw	sp,#18
 110       00000012      OFST:	set	18
 113                     ; 38 	uint8_t i = 0;
 115                     ; 39 	char writeData[] = "Hello, EEPROM!";
 117  0002 96            	ldw	x,sp
 118  0003 1c0002        	addw	x,#OFST-16
 119  0006 90ae0000      	ldw	y,#L3_writeData
 120  000a a60f          	ld	a,#15
 121  000c cd0000        	call	c_xymov
 123                     ; 41 	uint16_t startAddress = 0x0000;
 125                     ; 42 	clock_setup();
 127  000f cd00b4        	call	_clock_setup
 129                     ; 43 	TIM4_Config();
 131  0012 cd0000        	call	_TIM4_Config
 133                     ; 44 	UART3_setup();
 135  0015 ad6d          	call	_UART3_setup
 137                     ; 45 	GPIO_setup();
 139  0017 cd00f9        	call	_GPIO_setup
 141                     ; 48 	printf("Starting:\n");
 143  001a ae0074        	ldw	x,#L14
 144  001d cd0000        	call	_printf
 146                     ; 49 	 sEE_Init();  
 148  0020 cd0000        	call	_sEE_Init
 150                     ; 53   sEE_WriteBuffer(Tx1_Buffer, sEE_WRITE_ADDRESS1, BUFFER_SIZE1); 
 152  0023 ae0034        	ldw	x,#52
 153  0026 89            	pushw	x
 154  0027 5f            	clrw	x
 155  0028 89            	pushw	x
 156  0029 ae0000        	ldw	x,#_Tx1_Buffer
 157  002c cd0000        	call	_sEE_WriteBuffer
 159  002f 5b04          	addw	sp,#4
 160                     ; 56   sEE_WaitEepromStandbyState();  
 162  0031 cd0000        	call	_sEE_WaitEepromStandbyState
 164                     ; 59   NumDataRead = BUFFER_SIZE1;
 166  0034 ae0034        	ldw	x,#52
 167  0037 bf44          	ldw	_NumDataRead,x
 168                     ; 62   sEE_ReadBuffer(Rx1_Buffer, sEE_READ_ADDRESS1, (uint16_t *)(&NumDataRead)); 
 170  0039 ae0044        	ldw	x,#_NumDataRead
 171  003c 89            	pushw	x
 172  003d 5f            	clrw	x
 173  003e 89            	pushw	x
 174  003f ae000c        	ldw	x,#_Rx1_Buffer
 175  0042 cd0000        	call	_sEE_ReadBuffer
 177  0045 5b04          	addw	sp,#4
 178                     ; 63 	printf("reading data finsished\n");
 180  0047 ae005c        	ldw	x,#L34
 181  004a cd0000        	call	_printf
 183                     ; 66 	TransferStatus1 = Buffercmp(Tx1_Buffer, Rx1_Buffer, BUFFER_SIZE1);
 185  004d ae0034        	ldw	x,#52
 186  0050 89            	pushw	x
 187  0051 ae000c        	ldw	x,#_Rx1_Buffer
 188  0054 89            	pushw	x
 189  0055 ae0000        	ldw	x,#_Tx1_Buffer
 190  0058 cd0136        	call	_Buffercmp
 192  005b 5b04          	addw	sp,#4
 193  005d b742          	ld	_TransferStatus1,a
 194                     ; 68 	if (TransferStatus1 == PASSED)
 196  005f b642          	ld	a,_TransferStatus1
 197  0061 a101          	cp	a,#1
 198  0063 260e          	jrne	L54
 199                     ; 70     printf(" EEPROM Transfer1");
 201  0065 ae004a        	ldw	x,#L74
 202  0068 cd0000        	call	_printf
 204                     ; 71     printf("     PASSED      ");
 206  006b ae0038        	ldw	x,#L15
 207  006e cd0000        	call	_printf
 210  0071 200c          	jra	L35
 211  0073               L54:
 212                     ; 75     printf(" EEPROM Transfer1");
 214  0073 ae004a        	ldw	x,#L74
 215  0076 cd0000        	call	_printf
 217                     ; 76     printf("     FAILED      ");
 219  0079 ae0026        	ldw	x,#L55
 220  007c cd0000        	call	_printf
 222  007f               L35:
 223                     ; 78 	sEE_DeInit();
 225  007f cd0000        	call	_sEE_DeInit
 227  0082               L75:
 229  0082 20fe          	jra	L75
 255                     ; 85 void UART3_setup(void) {
 256                     	switch	.text
 257  0084               _UART3_setup:
 261                     ; 86   UART3_DeInit();
 263  0084 cd0000        	call	_UART3_DeInit
 265                     ; 89   UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
 265                     ; 90              UART3_MODE_TX_ENABLE);
 267  0087 4b04          	push	#4
 268  0089 4b00          	push	#0
 269  008b 4b00          	push	#0
 270  008d 4b00          	push	#0
 271  008f ae2580        	ldw	x,#9600
 272  0092 89            	pushw	x
 273  0093 ae0000        	ldw	x,#0
 274  0096 89            	pushw	x
 275  0097 cd0000        	call	_UART3_Init
 277  009a 5b08          	addw	sp,#8
 278                     ; 92   UART3_Cmd(ENABLE);  // Enable UART1
 280  009c a601          	ld	a,#1
 281  009e cd0000        	call	_UART3_Cmd
 283                     ; 93 }
 286  00a1 81            	ret
 322                     ; 95 PUTCHAR_PROTOTYPE {
 323                     	switch	.text
 324  00a2               _putchar:
 326  00a2 88            	push	a
 327       00000000      OFST:	set	0
 330                     ; 97   UART3_SendData8(c);
 332  00a3 cd0000        	call	_UART3_SendData8
 335  00a6               L311:
 336                     ; 99   while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);
 338  00a6 ae0080        	ldw	x,#128
 339  00a9 cd0000        	call	_UART3_GetFlagStatus
 341  00ac 4d            	tnz	a
 342  00ad 27f7          	jreq	L311
 343                     ; 101   return (c);
 345  00af 7b01          	ld	a,(OFST+1,sp)
 348  00b1 5b01          	addw	sp,#1
 349  00b3 81            	ret
 382                     ; 104 void clock_setup(void) {
 383                     	switch	.text
 384  00b4               _clock_setup:
 388                     ; 105   CLK_DeInit();
 390  00b4 cd0000        	call	_CLK_DeInit
 392                     ; 106   CLK_HSECmd(DISABLE);
 394  00b7 4f            	clr	a
 395  00b8 cd0000        	call	_CLK_HSECmd
 397                     ; 107   CLK_LSICmd(DISABLE);
 399  00bb 4f            	clr	a
 400  00bc cd0000        	call	_CLK_LSICmd
 402                     ; 108   CLK_HSICmd(ENABLE);
 404  00bf a601          	ld	a,#1
 405  00c1 cd0000        	call	_CLK_HSICmd
 408  00c4               L131:
 409                     ; 109   while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 411  00c4 ae0102        	ldw	x,#258
 412  00c7 cd0000        	call	_CLK_GetFlagStatus
 414  00ca 4d            	tnz	a
 415  00cb 27f7          	jreq	L131
 416                     ; 111   CLK_ClockSwitchCmd(ENABLE);
 418  00cd a601          	ld	a,#1
 419  00cf cd0000        	call	_CLK_ClockSwitchCmd
 421                     ; 112   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 423  00d2 4f            	clr	a
 424  00d3 cd0000        	call	_CLK_HSIPrescalerConfig
 426                     ; 113   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 428  00d6 a680          	ld	a,#128
 429  00d8 cd0000        	call	_CLK_SYSCLKConfig
 431                     ; 115   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
 431                     ; 116                         CLK_CURRENTCLOCKSTATE_ENABLE);
 433  00db 4b01          	push	#1
 434  00dd 4b00          	push	#0
 435  00df ae01e1        	ldw	x,#481
 436  00e2 cd0000        	call	_CLK_ClockSwitchConfig
 438  00e5 85            	popw	x
 439                     ; 118   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 441  00e6 ae0401        	ldw	x,#1025
 442  00e9 cd0000        	call	_CLK_PeripheralClockConfig
 444                     ; 119   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
 446  00ec ae0301        	ldw	x,#769
 447  00ef cd0000        	call	_CLK_PeripheralClockConfig
 449                     ; 120 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, ENABLE);
 451  00f2 ae0001        	ldw	x,#1
 452  00f5 cd0000        	call	_CLK_PeripheralClockConfig
 454                     ; 124 }
 457  00f8 81            	ret
 482                     ; 126 void GPIO_setup(void)
 482                     ; 127 {   
 483                     	switch	.text
 484  00f9               _GPIO_setup:
 488                     ; 129 		GPIO_DeInit(GPIOE);
 490  00f9 ae5014        	ldw	x,#20500
 491  00fc cd0000        	call	_GPIO_DeInit
 493                     ; 133 		GPIO_Init(GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
 495  00ff 4bb0          	push	#176
 496  0101 4b02          	push	#2
 497  0103 ae5014        	ldw	x,#20500
 498  0106 cd0000        	call	_GPIO_Init
 500  0109 85            	popw	x
 501                     ; 134     GPIO_Init(GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
 503  010a 4bb0          	push	#176
 504  010c 4b04          	push	#4
 505  010e ae5014        	ldw	x,#20500
 506  0111 cd0000        	call	_GPIO_Init
 508  0114 85            	popw	x
 509                     ; 135 }
 512  0115 81            	ret
 538                     ; 137 void I2C_Configuration(void)
 538                     ; 138 {
 539                     	switch	.text
 540  0116               _I2C_Configuration:
 544                     ; 139     I2C_DeInit();  // Reset I2C to default state
 546  0116 cd0000        	call	_I2C_DeInit
 548                     ; 142     I2C_Init(
 548                     ; 143         100000,           // I2C clock frequency (100kHz)
 548                     ; 144         0x00,             // Own address (not required for master mode)
 548                     ; 145         I2C_DUTYCYCLE_2,  // Fast mode Tlow/Thigh = 2
 548                     ; 146         I2C_ACK_CURR,     // Enable ACK for current byte
 548                     ; 147         I2C_ADDMODE_7BIT, // 7-bit addressing mode
 548                     ; 148         16                // Input clock frequency in MHz (adjust as per your system clock)
 548                     ; 149     );
 550  0119 4b10          	push	#16
 551  011b 4b00          	push	#0
 552  011d 4b01          	push	#1
 553  011f 4b00          	push	#0
 554  0121 5f            	clrw	x
 555  0122 89            	pushw	x
 556  0123 ae86a0        	ldw	x,#34464
 557  0126 89            	pushw	x
 558  0127 ae0001        	ldw	x,#1
 559  012a 89            	pushw	x
 560  012b cd0000        	call	_I2C_Init
 562  012e 5b0a          	addw	sp,#10
 563                     ; 151     I2C_Cmd(ENABLE);  // Enable the I2C peripheral
 565  0130 a601          	ld	a,#1
 566  0132 cd0000        	call	_I2C_Cmd
 568                     ; 152 }
 571  0135 81            	ret
 647                     ; 154 TestStatus Buffercmp(uint8_t* pBuffer1, uint8_t* pBuffer2, uint16_t BufferLength)
 647                     ; 155 {
 648                     	switch	.text
 649  0136               _Buffercmp:
 651  0136 89            	pushw	x
 652       00000000      OFST:	set	0
 655  0137 2028          	jra	L512
 656  0139               L312:
 657                     ; 158 		printf("Comparing: %c with %c\n", *pBuffer1, *pBuffer2);  // Debug output
 659  0139 1e05          	ldw	x,(OFST+5,sp)
 660  013b f6            	ld	a,(x)
 661  013c 88            	push	a
 662  013d 1e02          	ldw	x,(OFST+2,sp)
 663  013f f6            	ld	a,(x)
 664  0140 88            	push	a
 665  0141 ae000f        	ldw	x,#L122
 666  0144 cd0000        	call	_printf
 668  0147 85            	popw	x
 669                     ; 159     if(*pBuffer1 != *pBuffer2)
 671  0148 1e01          	ldw	x,(OFST+1,sp)
 672  014a f6            	ld	a,(x)
 673  014b 1e05          	ldw	x,(OFST+5,sp)
 674  014d f1            	cp	a,(x)
 675  014e 2703          	jreq	L322
 676                     ; 161       return FAILED;
 678  0150 4f            	clr	a
 680  0151 201f          	jra	L22
 681  0153               L322:
 682                     ; 164     pBuffer1++;
 684  0153 1e01          	ldw	x,(OFST+1,sp)
 685  0155 1c0001        	addw	x,#1
 686  0158 1f01          	ldw	(OFST+1,sp),x
 687                     ; 165     pBuffer2++;
 689  015a 1e05          	ldw	x,(OFST+5,sp)
 690  015c 1c0001        	addw	x,#1
 691  015f 1f05          	ldw	(OFST+5,sp),x
 692  0161               L512:
 693                     ; 156   while(BufferLength--)
 695  0161 1e07          	ldw	x,(OFST+7,sp)
 696  0163 1d0001        	subw	x,#1
 697  0166 1f07          	ldw	(OFST+7,sp),x
 698  0168 1c0001        	addw	x,#1
 699  016b a30000        	cpw	x,#0
 700  016e 26c9          	jrne	L312
 701                     ; 168   return PASSED;  
 703  0170 a601          	ld	a,#1
 705  0172               L22:
 707  0172 85            	popw	x
 708  0173 81            	ret
 792                     	xdef	_main
 793                     	xdef	_Buffercmp
 794                     	xdef	_I2C_Configuration
 795                     	xdef	_GPIO_setup
 796                     	xdef	_UART3_setup
 797                     	xdef	_clock_setup
 798                     	xdef	_NumDataRead
 799                     	xdef	_TransferStatus2
 800                     	xdef	_TransferStatus1
 801                     	switch	.ubsct
 802  0000               _Rx2_Buffer:
 803  0000 000000000000  	ds.b	12
 804                     	xdef	_Rx2_Buffer
 805  000c               _Rx1_Buffer:
 806  000c 000000000000  	ds.b	52
 807                     	xdef	_Rx1_Buffer
 808                     	xdef	_Tx2_Buffer
 809                     	xdef	_Tx1_Buffer
 810                     	xref	_sEE_WaitEepromStandbyState
 811                     	xref	_sEE_WriteBuffer
 812                     	xref	_sEE_ReadBuffer
 813                     	xref	_sEE_Init
 814                     	xref	_sEE_DeInit
 815                     	xref	_TIM4_Config
 816                     	xdef	_putchar
 817                     	xref	_printf
 818                     	xref	_UART3_GetFlagStatus
 819                     	xref	_UART3_SendData8
 820                     	xref	_UART3_Cmd
 821                     	xref	_UART3_Init
 822                     	xref	_UART3_DeInit
 823                     	xref	_I2C_Cmd
 824                     	xref	_I2C_Init
 825                     	xref	_I2C_DeInit
 826                     	xref	_GPIO_Init
 827                     	xref	_GPIO_DeInit
 828                     	xref	_CLK_GetFlagStatus
 829                     	xref	_CLK_SYSCLKConfig
 830                     	xref	_CLK_HSIPrescalerConfig
 831                     	xref	_CLK_ClockSwitchConfig
 832                     	xref	_CLK_PeripheralClockConfig
 833                     	xref	_CLK_ClockSwitchCmd
 834                     	xref	_CLK_LSICmd
 835                     	xref	_CLK_HSICmd
 836                     	xref	_CLK_HSECmd
 837                     	xref	_CLK_DeInit
 838                     	switch	.const
 839  000f               L122:
 840  000f 436f6d706172  	dc.b	"Comparing: %c with"
 841  0021 2025630a00    	dc.b	" %c",10,0
 842  0026               L55:
 843  0026 202020202046  	dc.b	"     FAILED      ",0
 844  0038               L15:
 845  0038 202020202050  	dc.b	"     PASSED      ",0
 846  004a               L74:
 847  004a 20454550524f  	dc.b	" EEPROM Transfer1",0
 848  005c               L34:
 849  005c 72656164696e  	dc.b	"reading data finsi"
 850  006e 736865640a00  	dc.b	"shed",10,0
 851  0074               L14:
 852  0074 537461727469  	dc.b	"Starting:",10,0
 853                     	xref.b	c_x
 873                     	xref	c_xymov
 874                     	end
