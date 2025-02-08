   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _writePointer:
  16  0000 0000          	dc.w	0
  17                     .const:	section	.text
  18  0000               L3_writeData:
  19  0000 31372d30312d  	dc.b	"17-01-25,14:36:00,"
  20  0012 35302e303030  	dc.b	"50.000,5.000,1.230",0
  21  0025               L5_sample_data1:
  22  0025 31372d30312d  	dc.b	"17-01-25,14:36:00,"
  23  0037 46445220414d  	dc.b	"FDR AMPLITUDE: 24."
  24  0049 3500          	dc.b	"5",0
  25  004b               L7_sample_data2:
  26  004b 31372d30312d  	dc.b	"17-01-25,14:36:00,"
  27  005d 46726571203c  	dc.b	"Freq < SetFreq",0
  28  006c               L11_sample_data3:
  29  006c 31372d30312d  	dc.b	"17-01-25,14:36:00,"
  30  007e 5a65726f4372  	dc.b	"ZeroCrosssing Dete"
  31  0090 6374656400    	dc.b	"cted",0
  32  0095               L31_sample_data4:
  33  0095 31372d30312d  	dc.b	"17-01-25,14:36:00 "
  34  00a7 5369676e616c  	dc.b	"Signal 1 DC",0
  35  00b3               L51_sample_data5:
  36  00b3 31372d30312d  	dc.b	"17-01-25,14:36:00 "
  37  00c5 5369676e616c  	dc.b	"Signal 1 AC",0
  38  00d1               L71_sample_data6:
  39  00d1 31372d30312d  	dc.b	"17-01-25,14:36:00 "
  40  00e3 5369676e616c  	dc.b	"Signal 1 AC below "
  41  00f5 3130206d7600  	dc.b	"10 mv",0
  42  00fb               L12_sample_data7:
  43  00fb 31372d30312d  	dc.b	"17-01-25,14:36:00 "
  44  010d 70756c736520  	dc.b	"pulse to Commutati"
  45  011f 6f6e20546879  	dc.b	"on Thyristor",0
 183                     ; 44 void main (void)
 183                     ; 45 {
 185                     	switch	.text
 186  0000               _main:
 188  0000 52ff          	subw	sp,#255
 189  0002 5241          	subw	sp,#65
 190       00000140      OFST:	set	320
 193                     ; 46   int i = 0;
 195                     ; 47   char writeData[] = "17-01-25,14:36:00,50.000,5.000,1.230";
 197  0004 96            	ldw	x,sp
 198  0005 1c0013        	addw	x,#OFST-301
 199  0008 90ae0000      	ldw	y,#L3_writeData
 200  000c a625          	ld	a,#37
 201  000e cd0000        	call	c_xymov
 203                     ; 48 	char sample_data1[] = "17-01-25,14:36:00,FDR AMPLITUDE: 24.5";
 205  0011 96            	ldw	x,sp
 206  0012 1c0038        	addw	x,#OFST-264
 207  0015 90ae0025      	ldw	y,#L5_sample_data1
 208  0019 a626          	ld	a,#38
 209  001b cd0000        	call	c_xymov
 211                     ; 49 	char sample_data2[] = "17-01-25,14:36:00,Freq < SetFreq";
 213  001e 96            	ldw	x,sp
 214  001f 1c005e        	addw	x,#OFST-226
 215  0022 90ae004b      	ldw	y,#L7_sample_data2
 216  0026 a621          	ld	a,#33
 217  0028 cd0000        	call	c_xymov
 219                     ; 50 	char sample_data3[] = "17-01-25,14:36:00,ZeroCrosssing Detected";
 221  002b 96            	ldw	x,sp
 222  002c 1c007f        	addw	x,#OFST-193
 223  002f 90ae006c      	ldw	y,#L11_sample_data3
 224  0033 a629          	ld	a,#41
 225  0035 cd0000        	call	c_xymov
 227                     ; 51 	char sample_data4[] = "17-01-25,14:36:00 Signal 1 DC";
 229  0038 96            	ldw	x,sp
 230  0039 1c00a8        	addw	x,#OFST-152
 231  003c 90ae0095      	ldw	y,#L31_sample_data4
 232  0040 a61e          	ld	a,#30
 233  0042 cd0000        	call	c_xymov
 235                     ; 52 	char sample_data5[] = "17-01-25,14:36:00 Signal 1 AC";
 237  0045 96            	ldw	x,sp
 238  0046 1c00c6        	addw	x,#OFST-122
 239  0049 90ae00b3      	ldw	y,#L51_sample_data5
 240  004d a61e          	ld	a,#30
 241  004f cd0000        	call	c_xymov
 243                     ; 53 	char sample_data6[] = "17-01-25,14:36:00 Signal 1 AC below 10 mv";
 245  0052 96            	ldw	x,sp
 246  0053 1c00e4        	addw	x,#OFST-92
 247  0056 90ae00d1      	ldw	y,#L71_sample_data6
 248  005a a62a          	ld	a,#42
 249  005c cd0000        	call	c_xymov
 251                     ; 54 	char sample_data7[] = "17-01-25,14:36:00 pulse to Commutation Thyristor";
 253  005f 96            	ldw	x,sp
 254  0060 1c010e        	addw	x,#OFST-50
 255  0063 90ae00fb      	ldw	y,#L12_sample_data7
 256  0067 a631          	ld	a,#49
 257  0069 cd0000        	call	c_xymov
 259                     ; 56   uint16_t startAddress = 0x0000;
 261                     ; 57   clock_setup ();
 263  006c ad55          	call	_clock_setup
 265                     ; 58   TIM4_Config ();
 267  006e cd0000        	call	_TIM4_Config
 269                     ; 59   UART3_setup ();
 271  0071 ad20          	call	_UART3_setup
 273                     ; 60   GPIO_setup ();
 275  0073 cd0108        	call	_GPIO_setup
 277                     ; 61   I2C_Configuration ();
 279  0076 cd0125        	call	_I2C_Configuration
 281                     ; 62   delay_ms(1000);
 283  0079 ae03e8        	ldw	x,#1000
 284  007c cd0000        	call	_delay_ms
 286                     ; 63   printf ("Starting:\n");
 288  007f ae026c        	ldw	x,#L311
 289  0082 cd0000        	call	_printf
 291                     ; 64 	printf("EEPROM Logging and Reading Example\n");
 293  0085 ae0248        	ldw	x,#L511
 294  0088 cd0000        	call	_printf
 296                     ; 81 	process_eeprom_logs();
 298  008b cd040a        	call	_process_eeprom_logs
 300                     ; 83   EEPROM_Test();
 302  008e cd0370        	call	_EEPROM_Test
 304  0091               L711:
 306  0091 20fe          	jra	L711
 332                     ; 89 void UART3_setup (void)
 332                     ; 90 {
 333                     	switch	.text
 334  0093               _UART3_setup:
 338                     ; 91   UART3_DeInit ();
 340  0093 cd0000        	call	_UART3_DeInit
 342                     ; 94   UART3_Init (9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
 342                     ; 95               UART3_MODE_TX_ENABLE);
 344  0096 4b04          	push	#4
 345  0098 4b00          	push	#0
 346  009a 4b00          	push	#0
 347  009c 4b00          	push	#0
 348  009e ae2580        	ldw	x,#9600
 349  00a1 89            	pushw	x
 350  00a2 ae0000        	ldw	x,#0
 351  00a5 89            	pushw	x
 352  00a6 cd0000        	call	_UART3_Init
 354  00a9 5b08          	addw	sp,#8
 355                     ; 97   UART3_Cmd (ENABLE); // Enable UART1
 357  00ab a601          	ld	a,#1
 358  00ad cd0000        	call	_UART3_Cmd
 360                     ; 98 }
 363  00b0 81            	ret
 399                     ; 100 PUTCHAR_PROTOTYPE{
 400                     	switch	.text
 401  00b1               _putchar:
 403  00b1 88            	push	a
 404       00000000      OFST:	set	0
 407                     ; 102   UART3_SendData8 (c);
 409  00b2 cd0000        	call	_UART3_SendData8
 412  00b5               L351:
 413                     ; 104   while (UART3_GetFlagStatus (UART3_FLAG_TXE) == RESET);
 415  00b5 ae0080        	ldw	x,#128
 416  00b8 cd0000        	call	_UART3_GetFlagStatus
 418  00bb 4d            	tnz	a
 419  00bc 27f7          	jreq	L351
 420                     ; 106   return (c);
 422  00be 7b01          	ld	a,(OFST+1,sp)
 425  00c0 5b01          	addw	sp,#1
 426  00c2 81            	ret
 459                     ; 109 void clock_setup (void)
 459                     ; 110 {
 460                     	switch	.text
 461  00c3               _clock_setup:
 465                     ; 111   CLK_DeInit ();
 467  00c3 cd0000        	call	_CLK_DeInit
 469                     ; 112   CLK_HSECmd (DISABLE);
 471  00c6 4f            	clr	a
 472  00c7 cd0000        	call	_CLK_HSECmd
 474                     ; 113   CLK_LSICmd (DISABLE);
 476  00ca 4f            	clr	a
 477  00cb cd0000        	call	_CLK_LSICmd
 479                     ; 114   CLK_HSICmd (ENABLE);
 481  00ce a601          	ld	a,#1
 482  00d0 cd0000        	call	_CLK_HSICmd
 485  00d3               L171:
 486                     ; 115   while (CLK_GetFlagStatus (CLK_FLAG_HSIRDY) == FALSE);
 488  00d3 ae0102        	ldw	x,#258
 489  00d6 cd0000        	call	_CLK_GetFlagStatus
 491  00d9 4d            	tnz	a
 492  00da 27f7          	jreq	L171
 493                     ; 117   CLK_ClockSwitchCmd (ENABLE);
 495  00dc a601          	ld	a,#1
 496  00de cd0000        	call	_CLK_ClockSwitchCmd
 498                     ; 118   CLK_HSIPrescalerConfig (CLK_PRESCALER_HSIDIV1);
 500  00e1 4f            	clr	a
 501  00e2 cd0000        	call	_CLK_HSIPrescalerConfig
 503                     ; 119   CLK_SYSCLKConfig (CLK_PRESCALER_CPUDIV1);
 505  00e5 a680          	ld	a,#128
 506  00e7 cd0000        	call	_CLK_SYSCLKConfig
 508                     ; 121   CLK_ClockSwitchConfig (CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
 508                     ; 122                          CLK_CURRENTCLOCKSTATE_ENABLE);
 510  00ea 4b01          	push	#1
 511  00ec 4b00          	push	#0
 512  00ee ae01e1        	ldw	x,#481
 513  00f1 cd0000        	call	_CLK_ClockSwitchConfig
 515  00f4 85            	popw	x
 516                     ; 124   CLK_PeripheralClockConfig (CLK_PERIPHERAL_TIMER4, ENABLE);
 518  00f5 ae0401        	ldw	x,#1025
 519  00f8 cd0000        	call	_CLK_PeripheralClockConfig
 521                     ; 125   CLK_PeripheralClockConfig (CLK_PERIPHERAL_UART3, ENABLE);
 523  00fb ae0301        	ldw	x,#769
 524  00fe cd0000        	call	_CLK_PeripheralClockConfig
 526                     ; 126   CLK_PeripheralClockConfig (CLK_PERIPHERAL_I2C, ENABLE);
 528  0101 ae0001        	ldw	x,#1
 529  0104 cd0000        	call	_CLK_PeripheralClockConfig
 531                     ; 130 }
 534  0107 81            	ret
 559                     ; 132 void GPIO_setup (void)
 559                     ; 133 {
 560                     	switch	.text
 561  0108               _GPIO_setup:
 565                     ; 134   GPIO_DeInit (GPIOE);
 567  0108 ae5014        	ldw	x,#20500
 568  010b cd0000        	call	_GPIO_DeInit
 570                     ; 135   GPIO_Init (GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
 572  010e 4bb0          	push	#176
 573  0110 4b02          	push	#2
 574  0112 ae5014        	ldw	x,#20500
 575  0115 cd0000        	call	_GPIO_Init
 577  0118 85            	popw	x
 578                     ; 136   GPIO_Init (GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
 580  0119 4bb0          	push	#176
 581  011b 4b04          	push	#4
 582  011d ae5014        	ldw	x,#20500
 583  0120 cd0000        	call	_GPIO_Init
 585  0123 85            	popw	x
 586                     ; 137 }
 589  0124 81            	ret
 615                     ; 139 void I2C_Configuration (void)
 615                     ; 140 {
 616                     	switch	.text
 617  0125               _I2C_Configuration:
 621                     ; 141   I2C_DeInit (); // Reset I2C to default state
 623  0125 cd0000        	call	_I2C_DeInit
 625                     ; 144   I2C_Init (
 625                     ; 145             100000, // I2C clock frequency (100kHz)
 625                     ; 146             0x00, // Own address (not required for master mode)
 625                     ; 147             I2C_DUTYCYCLE_2, // Fast mode Tlow/Thigh = 2
 625                     ; 148             I2C_ACK_CURR, // Enable ACK for current byte
 625                     ; 149             I2C_ADDMODE_7BIT, // 7-bit addressing mode
 625                     ; 150             16 // Input clock frequency in MHz (adjust as per your system clock)
 625                     ; 151             );
 627  0128 4b10          	push	#16
 628  012a 4b00          	push	#0
 629  012c 4b01          	push	#1
 630  012e 4b00          	push	#0
 631  0130 5f            	clrw	x
 632  0131 89            	pushw	x
 633  0132 ae86a0        	ldw	x,#34464
 634  0135 89            	pushw	x
 635  0136 ae0001        	ldw	x,#1
 636  0139 89            	pushw	x
 637  013a cd0000        	call	_I2C_Init
 639  013d 5b0a          	addw	sp,#10
 640                     ; 152   I2C_Cmd (ENABLE); // Enable the I2C peripheral
 642  013f a601          	ld	a,#1
 643  0141 cd0000        	call	_I2C_Cmd
 645                     ; 153 }
 648  0144 81            	ret
 697                     ; 155 void EEPROM_WriteByte (uint16_t memoryAddress, uint8_t data)
 697                     ; 156 {
 698                     	switch	.text
 699  0145               _EEPROM_WriteByte:
 701  0145 89            	pushw	x
 702       00000000      OFST:	set	0
 705                     ; 158   I2C_GenerateSTART (ENABLE);
 707  0146 a601          	ld	a,#1
 708  0148 cd0000        	call	_I2C_GenerateSTART
 711  014b               L142:
 712                     ; 159   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 714  014b ae0301        	ldw	x,#769
 715  014e cd0000        	call	_I2C_CheckEvent
 717  0151 4d            	tnz	a
 718  0152 27f7          	jreq	L142
 719                     ; 161   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 721  0154 aea000        	ldw	x,#40960
 722  0157 cd0000        	call	_I2C_Send7bitAddress
 725  015a               L742:
 726                     ; 162   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 728  015a ae0782        	ldw	x,#1922
 729  015d cd0000        	call	_I2C_CheckEvent
 731  0160 4d            	tnz	a
 732  0161 27f7          	jreq	L742
 733                     ; 164   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 735  0163 7b01          	ld	a,(OFST+1,sp)
 736  0165 cd0000        	call	_I2C_SendData
 739  0168               L552:
 740                     ; 165   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 742  0168 ae0784        	ldw	x,#1924
 743  016b cd0000        	call	_I2C_CheckEvent
 745  016e 4d            	tnz	a
 746  016f 27f7          	jreq	L552
 747                     ; 167   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 749  0171 7b02          	ld	a,(OFST+2,sp)
 750  0173 a4ff          	and	a,#255
 751  0175 cd0000        	call	_I2C_SendData
 754  0178               L362:
 755                     ; 168   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 757  0178 ae0784        	ldw	x,#1924
 758  017b cd0000        	call	_I2C_CheckEvent
 760  017e 4d            	tnz	a
 761  017f 27f7          	jreq	L362
 762                     ; 170   I2C_SendData (data);
 764  0181 7b05          	ld	a,(OFST+5,sp)
 765  0183 cd0000        	call	_I2C_SendData
 768  0186               L172:
 769                     ; 171   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 771  0186 ae0784        	ldw	x,#1924
 772  0189 cd0000        	call	_I2C_CheckEvent
 774  018c 4d            	tnz	a
 775  018d 27f7          	jreq	L172
 776                     ; 173   I2C_GenerateSTOP (ENABLE);
 778  018f a601          	ld	a,#1
 779  0191 cd0000        	call	_I2C_GenerateSTOP
 781                     ; 174   delay_ms (5);
 783  0194 ae0005        	ldw	x,#5
 784  0197 cd0000        	call	_delay_ms
 786                     ; 175 }
 789  019a 85            	popw	x
 790  019b 81            	ret
 848                     ; 177 uint8_t EEPROM_ReadByte (uint16_t memoryAddress)
 848                     ; 178 {
 849                     	switch	.text
 850  019c               _EEPROM_ReadByte:
 852  019c 89            	pushw	x
 853  019d 89            	pushw	x
 854       00000002      OFST:	set	2
 857                     ; 180   uint8_t i = 0;
 859                     ; 182   I2C_GenerateSTART (ENABLE);
 861  019e a601          	ld	a,#1
 862  01a0 cd0000        	call	_I2C_GenerateSTART
 865  01a3               L523:
 866                     ; 183   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 868  01a3 ae0301        	ldw	x,#769
 869  01a6 cd0000        	call	_I2C_CheckEvent
 871  01a9 4d            	tnz	a
 872  01aa 27f7          	jreq	L523
 873                     ; 185   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 875  01ac aea000        	ldw	x,#40960
 876  01af cd0000        	call	_I2C_Send7bitAddress
 879  01b2               L333:
 880                     ; 186   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 882  01b2 ae0782        	ldw	x,#1922
 883  01b5 cd0000        	call	_I2C_CheckEvent
 885  01b8 4d            	tnz	a
 886  01b9 27f7          	jreq	L333
 887                     ; 188   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 889  01bb 7b03          	ld	a,(OFST+1,sp)
 890  01bd cd0000        	call	_I2C_SendData
 893  01c0               L143:
 894                     ; 189   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 896  01c0 ae0784        	ldw	x,#1924
 897  01c3 cd0000        	call	_I2C_CheckEvent
 899  01c6 4d            	tnz	a
 900  01c7 27f7          	jreq	L143
 901                     ; 191   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 903  01c9 7b04          	ld	a,(OFST+2,sp)
 904  01cb a4ff          	and	a,#255
 905  01cd cd0000        	call	_I2C_SendData
 908  01d0               L743:
 909                     ; 192   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 911  01d0 ae0784        	ldw	x,#1924
 912  01d3 cd0000        	call	_I2C_CheckEvent
 914  01d6 4d            	tnz	a
 915  01d7 27f7          	jreq	L743
 916                     ; 195   I2C_GenerateSTART (ENABLE);
 918  01d9 a601          	ld	a,#1
 919  01db cd0000        	call	_I2C_GenerateSTART
 922  01de               L553:
 923                     ; 196   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 925  01de ae0301        	ldw	x,#769
 926  01e1 cd0000        	call	_I2C_CheckEvent
 928  01e4 4d            	tnz	a
 929  01e5 27f7          	jreq	L553
 930                     ; 198   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
 932  01e7 aea101        	ldw	x,#41217
 933  01ea cd0000        	call	_I2C_Send7bitAddress
 936  01ed               L363:
 937                     ; 199   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
 939  01ed ae0302        	ldw	x,#770
 940  01f0 cd0000        	call	_I2C_CheckEvent
 942  01f3 4d            	tnz	a
 943  01f4 27f7          	jreq	L363
 945  01f6               L173:
 946                     ; 201   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED) == ERROR);
 948  01f6 ae0340        	ldw	x,#832
 949  01f9 cd0000        	call	_I2C_CheckEvent
 951  01fc 4d            	tnz	a
 952  01fd 27f7          	jreq	L173
 953                     ; 202   receivedData = I2C_ReceiveData ();
 955  01ff cd0000        	call	_I2C_ReceiveData
 957  0202 6b02          	ld	(OFST+0,sp),a
 959                     ; 204   I2C_GenerateSTOP (ENABLE);
 961  0204 a601          	ld	a,#1
 962  0206 cd0000        	call	_I2C_GenerateSTOP
 964                     ; 206   return receivedData;
 966  0209 7b02          	ld	a,(OFST+0,sp)
 969  020b 5b04          	addw	sp,#4
 970  020d 81            	ret
1048                     ; 209 void EEPROM_ReadString (uint16_t memoryAddress, char* buffer)
1048                     ; 210 {
1049                     	switch	.text
1050  020e               _EEPROM_ReadString:
1052  020e 89            	pushw	x
1053  020f 5203          	subw	sp,#3
1054       00000003      OFST:	set	3
1057                     ; 211   uint8_t tempData = 0;
1059                     ; 212   uint8_t i = 0;
1061  0211 0f03          	clr	(OFST+0,sp)
1063                     ; 214   I2C_GenerateSTART (ENABLE);
1065  0213 a601          	ld	a,#1
1066  0215 cd0000        	call	_I2C_GenerateSTART
1069  0218               L534:
1070                     ; 215   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
1072  0218 ae0301        	ldw	x,#769
1073  021b cd0000        	call	_I2C_CheckEvent
1075  021e 4d            	tnz	a
1076  021f 27f7          	jreq	L534
1077                     ; 217   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
1079  0221 aea000        	ldw	x,#40960
1080  0224 cd0000        	call	_I2C_Send7bitAddress
1083  0227               L344:
1084                     ; 218   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
1086  0227 ae0782        	ldw	x,#1922
1087  022a cd0000        	call	_I2C_CheckEvent
1089  022d 4d            	tnz	a
1090  022e 27f7          	jreq	L344
1091                     ; 220   I2C_SendData ((uint8_t) (memoryAddress >> 8));
1093  0230 7b04          	ld	a,(OFST+1,sp)
1094  0232 cd0000        	call	_I2C_SendData
1097  0235               L154:
1098                     ; 221   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
1100  0235 ae0784        	ldw	x,#1924
1101  0238 cd0000        	call	_I2C_CheckEvent
1103  023b 4d            	tnz	a
1104  023c 27f7          	jreq	L154
1105                     ; 223   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
1107  023e 7b05          	ld	a,(OFST+2,sp)
1108  0240 a4ff          	and	a,#255
1109  0242 cd0000        	call	_I2C_SendData
1112  0245               L754:
1113                     ; 224   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
1115  0245 ae0784        	ldw	x,#1924
1116  0248 cd0000        	call	_I2C_CheckEvent
1118  024b 4d            	tnz	a
1119  024c 27f7          	jreq	L754
1120                     ; 227   I2C_GenerateSTART (ENABLE);
1122  024e a601          	ld	a,#1
1123  0250 cd0000        	call	_I2C_GenerateSTART
1126  0253               L564:
1127                     ; 228   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
1129  0253 ae0301        	ldw	x,#769
1130  0256 cd0000        	call	_I2C_CheckEvent
1132  0259 4d            	tnz	a
1133  025a 27f7          	jreq	L564
1134                     ; 230   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
1136  025c aea101        	ldw	x,#41217
1137  025f cd0000        	call	_I2C_Send7bitAddress
1140  0262               L374:
1141                     ; 231   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
1143  0262 ae0302        	ldw	x,#770
1144  0265 cd0000        	call	_I2C_CheckEvent
1146  0268 4d            	tnz	a
1147  0269 27f7          	jreq	L374
1148  026b               L774:
1149                     ; 234     if (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED))
1151  026b ae0340        	ldw	x,#832
1152  026e cd0000        	call	_I2C_CheckEvent
1154  0271 4d            	tnz	a
1155  0272 27f7          	jreq	L774
1156                     ; 236       uint8_t tempData = I2C_ReceiveData ();
1158  0274 cd0000        	call	_I2C_ReceiveData
1160  0277 6b01          	ld	(OFST-2,sp),a
1162                     ; 237       if (tempData == '\0')
1164  0279 0d01          	tnz	(OFST-2,sp)
1165  027b 2614          	jrne	L505
1166                     ; 239         I2C_AcknowledgeConfig (I2C_ACK_NONE);
1168  027d 4f            	clr	a
1169  027e cd0000        	call	_I2C_AcknowledgeConfig
1171                     ; 240         I2C_GenerateSTOP (ENABLE);
1173  0281 a601          	ld	a,#1
1174  0283 cd0000        	call	_I2C_GenerateSTOP
1176                     ; 241         break;
1177                     ; 247   buffer[i] = '\0';
1179  0286 7b03          	ld	a,(OFST+0,sp)
1180  0288 5f            	clrw	x
1181  0289 97            	ld	xl,a
1182  028a 72fb08        	addw	x,(OFST+5,sp)
1183  028d 7f            	clr	(x)
1184                     ; 250 }
1187  028e 5b05          	addw	sp,#5
1188  0290 81            	ret
1189  0291               L505:
1190                     ; 244         buffer[i++] = tempData;
1192  0291 7b03          	ld	a,(OFST+0,sp)
1193  0293 97            	ld	xl,a
1194  0294 0c03          	inc	(OFST+0,sp)
1196  0296 9f            	ld	a,xl
1197  0297 5f            	clrw	x
1198  0298 97            	ld	xl,a
1199  0299 72fb08        	addw	x,(OFST+5,sp)
1200  029c 7b01          	ld	a,(OFST-2,sp)
1201  029e f7            	ld	(x),a
1202  029f 20ca          	jra	L774
1247                     ; 252 void EEPROM_WriteString (uint16_t memoryAddress, char *data)
1247                     ; 253 {
1248                     	switch	.text
1249  02a1               _EEPROM_WriteString:
1251  02a1 89            	pushw	x
1252       00000000      OFST:	set	0
1255  02a2 2018          	jra	L535
1256  02a4               L335:
1257                     ; 256     EEPROM_WriteByte (memoryAddress, *data); // Write one character to EEPROM
1259  02a4 1e05          	ldw	x,(OFST+5,sp)
1260  02a6 f6            	ld	a,(x)
1261  02a7 88            	push	a
1262  02a8 1e02          	ldw	x,(OFST+2,sp)
1263  02aa cd0145        	call	_EEPROM_WriteByte
1265  02ad 84            	pop	a
1266                     ; 257     memoryAddress++; // Increment the address to write the next character
1268  02ae 1e01          	ldw	x,(OFST+1,sp)
1269  02b0 1c0001        	addw	x,#1
1270  02b3 1f01          	ldw	(OFST+1,sp),x
1271                     ; 258     data++; // Move to the next character in the string
1273  02b5 1e05          	ldw	x,(OFST+5,sp)
1274  02b7 1c0001        	addw	x,#1
1275  02ba 1f05          	ldw	(OFST+5,sp),x
1276  02bc               L535:
1277                     ; 254   while (*data)
1279  02bc 1e05          	ldw	x,(OFST+5,sp)
1280  02be 7d            	tnz	(x)
1281  02bf 26e3          	jrne	L335
1282                     ; 261   EEPROM_WriteByte (memoryAddress, '\0');
1284  02c1 4b00          	push	#0
1285  02c3 1e02          	ldw	x,(OFST+2,sp)
1286  02c5 cd0145        	call	_EEPROM_WriteByte
1288  02c8 84            	pop	a
1289                     ; 262 }
1292  02c9 85            	popw	x
1293  02ca 81            	ret
1340                     ; 264 void EEPROM_LogData(const char *data)
1340                     ; 265 {
1341                     	switch	.text
1342  02cb               _EEPROM_LogData:
1344  02cb 89            	pushw	x
1345  02cc 89            	pushw	x
1346       00000002      OFST:	set	2
1349                     ; 266 	uint16_t memoryAddress = writePointer; // Start writing at the current write pointer
1351  02cd be00          	ldw	x,_writePointer
1352  02cf 1f01          	ldw	(OFST-1,sp),x
1354                     ; 269 	EEPROM_WriteString(memoryAddress, data);
1356  02d1 1e03          	ldw	x,(OFST+1,sp)
1357  02d3 89            	pushw	x
1358  02d4 1e03          	ldw	x,(OFST+1,sp)
1359  02d6 adc9          	call	_EEPROM_WriteString
1361  02d8 85            	popw	x
1362                     ; 272 	writePointer += LOG_ENTRY_SIZE;
1364  02d9 be00          	ldw	x,_writePointer
1365  02db 1c0025        	addw	x,#37
1366  02de bf00          	ldw	_writePointer,x
1367                     ; 275 	if (writePointer >= EEPROM_SIZE)
1369  02e0 be00          	ldw	x,_writePointer
1370  02e2 a37d00        	cpw	x,#32000
1371  02e5 2503          	jrult	L365
1372                     ; 277 			writePointer = EEPROM_START_ADDRESS;
1374  02e7 5f            	clrw	x
1375  02e8 bf00          	ldw	_writePointer,x
1376  02ea               L365:
1377                     ; 280 	printf("Data Logged: %s at address: 0x%04X\n", data, memoryAddress);
1379  02ea 1e01          	ldw	x,(OFST-1,sp)
1380  02ec 89            	pushw	x
1381  02ed 1e05          	ldw	x,(OFST+3,sp)
1382  02ef 89            	pushw	x
1383  02f0 ae0224        	ldw	x,#L565
1384  02f3 cd0000        	call	_printf
1386  02f6 5b04          	addw	sp,#4
1387                     ; 281 }
1390  02f8 5b04          	addw	sp,#4
1391  02fa 81            	ret
1436                     ; 283 void EEPROM_ReadData(void)
1436                     ; 284 {
1437                     	switch	.text
1438  02fb               _EEPROM_ReadData:
1440  02fb 5203          	subw	sp,#3
1441       00000003      OFST:	set	3
1444                     ; 285     uint16_t memoryAddress = EEPROM_START_ADDRESS; // Start at the beginning of EEPROM
1446  02fd 5f            	clrw	x
1447  02fe 1f01          	ldw	(OFST-2,sp),x
1449  0300               L116:
1450                     ; 292         data = EEPROM_ReadByte(memoryAddress);
1452  0300 1e01          	ldw	x,(OFST-2,sp)
1453  0302 cd019c        	call	_EEPROM_ReadByte
1455  0305 6b03          	ld	(OFST+0,sp),a
1457                     ; 295         if (data >= 33 && data <= 122) // Printable ASCII range
1459  0307 7b03          	ld	a,(OFST+0,sp)
1460  0309 a121          	cp	a,#33
1461  030b 2510          	jrult	L716
1463  030d 7b03          	ld	a,(OFST+0,sp)
1464  030f a17b          	cp	a,#123
1465  0311 240a          	jruge	L716
1466                     ; 297             printf("%c", data); // Print the character directly
1468  0313 7b03          	ld	a,(OFST+0,sp)
1469  0315 88            	push	a
1470  0316 ae0221        	ldw	x,#L126
1471  0319 cd0000        	call	_printf
1473  031c 84            	pop	a
1474  031d               L716:
1475                     ; 300         memoryAddress++;
1477  031d 1e01          	ldw	x,(OFST-2,sp)
1478  031f 1c0001        	addw	x,#1
1479  0322 1f01          	ldw	(OFST-2,sp),x
1481                     ; 289     while (memoryAddress < EEPROM_SIZE) // Loop until the end of the EEPROM
1483  0324 1e01          	ldw	x,(OFST-2,sp)
1484  0326 a37d00        	cpw	x,#32000
1485  0329 25d5          	jrult	L116
1486                     ; 302     printf("\nDone reading EEPROM.\n");
1488  032b ae020a        	ldw	x,#L326
1489  032e cd0000        	call	_printf
1491                     ; 303 }
1494  0331 5b03          	addw	sp,#3
1495  0333 81            	ret
1541                     ; 305 void EEPROM_Init(uint16_t defaultValue)
1541                     ; 306 {
1542                     	switch	.text
1543  0334               _EEPROM_Init:
1545  0334 89            	pushw	x
1546  0335 89            	pushw	x
1547       00000002      OFST:	set	2
1550                     ; 307     uint16_t address = 0;
1552                     ; 309     printf("Initializing EEPROM...\n");
1554  0336 ae01f2        	ldw	x,#L746
1555  0339 cd0000        	call	_printf
1557                     ; 310     for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
1559  033c 5f            	clrw	x
1560  033d 1f01          	ldw	(OFST-1,sp),x
1562  033f               L156:
1563                     ; 312         EEPROM_WriteByte(address, defaultValue); // Write default value
1565  033f 7b04          	ld	a,(OFST+2,sp)
1566  0341 88            	push	a
1567  0342 1e02          	ldw	x,(OFST+0,sp)
1568  0344 cd0145        	call	_EEPROM_WriteByte
1570  0347 84            	pop	a
1571                     ; 314 				printf("%d,", address);
1573  0348 1e01          	ldw	x,(OFST-1,sp)
1574  034a 89            	pushw	x
1575  034b ae01ee        	ldw	x,#L756
1576  034e cd0000        	call	_printf
1578  0351 85            	popw	x
1579                     ; 310     for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
1581  0352 1e01          	ldw	x,(OFST-1,sp)
1582  0354 1c0001        	addw	x,#1
1583  0357 1f01          	ldw	(OFST-1,sp),x
1587  0359 1e01          	ldw	x,(OFST-1,sp)
1588  035b a37d00        	cpw	x,#32000
1589  035e 25df          	jrult	L156
1590                     ; 319     writePointer = EEPROM_START_ADDRESS; // Reset pointer
1592  0360 5f            	clrw	x
1593  0361 bf00          	ldw	_writePointer,x
1594                     ; 320     printf("EEPROM Initialized. All values set to: 0x%02X\n", defaultValue);
1596  0363 1e03          	ldw	x,(OFST+1,sp)
1597  0365 89            	pushw	x
1598  0366 ae01bf        	ldw	x,#L166
1599  0369 cd0000        	call	_printf
1601  036c 85            	popw	x
1602                     ; 321 }
1605  036d 5b04          	addw	sp,#4
1606  036f 81            	ret
1662                     ; 323 void EEPROM_Test (void)
1662                     ; 324 {
1663                     	switch	.text
1664  0370               _EEPROM_Test:
1666  0370 5204          	subw	sp,#4
1667       00000004      OFST:	set	4
1670                     ; 325   uint16_t memoryAddress = 0x0000; // EEPROM memory address to write/read
1672  0372 5f            	clrw	x
1673  0373 1f02          	ldw	(OFST-2,sp),x
1675                     ; 326   uint8_t dataToWrite = 0xAB; // Data to write
1677  0375 a6ab          	ld	a,#171
1678  0377 6b04          	ld	(OFST+0,sp),a
1680                     ; 329   I2C_Configuration (); // Initialize I2C peripheral
1682  0379 cd0125        	call	_I2C_Configuration
1684                     ; 332   EEPROM_WriteByte (memoryAddress, dataToWrite);
1686  037c 7b04          	ld	a,(OFST+0,sp)
1687  037e 88            	push	a
1688  037f 1e03          	ldw	x,(OFST-1,sp)
1689  0381 cd0145        	call	_EEPROM_WriteByte
1691  0384 84            	pop	a
1692                     ; 333   printf ("Writing Finished\n");
1694  0385 ae01ad        	ldw	x,#L117
1695  0388 cd0000        	call	_printf
1697                     ; 336   printf ("Reading Starting\n");
1699  038b ae019b        	ldw	x,#L317
1700  038e cd0000        	call	_printf
1702                     ; 338   dataRead = EEPROM_ReadByte (memoryAddress);
1704  0391 1e02          	ldw	x,(OFST-2,sp)
1705  0393 cd019c        	call	_EEPROM_ReadByte
1707  0396 6b01          	ld	(OFST-3,sp),a
1709                     ; 341   if (dataRead == dataToWrite)
1711  0398 7b01          	ld	a,(OFST-3,sp)
1712  039a 1104          	cp	a,(OFST+0,sp)
1713  039c 2608          	jrne	L517
1714                     ; 343     printf ("Success");
1716  039e ae0193        	ldw	x,#L717
1717  03a1 cd0000        	call	_printf
1720  03a4 2006          	jra	L127
1721  03a6               L517:
1722                     ; 347     printf ("YOU FAIL");
1724  03a6 ae018a        	ldw	x,#L327
1725  03a9 cd0000        	call	_printf
1727  03ac               L127:
1728                     ; 349 }
1731  03ac 5b04          	addw	sp,#4
1732  03ae 81            	ret
1835                     ; 351 bool read_from_eeprom(uint16_t start_addr, char* buffer, uint16_t buffer_size) {
1836                     	switch	.text
1837  03af               _read_from_eeprom:
1839  03af 89            	pushw	x
1840  03b0 5205          	subw	sp,#5
1841       00000005      OFST:	set	5
1844                     ; 352     uint16_t addr = start_addr;
1846  03b2 1f04          	ldw	(OFST-1,sp),x
1848                     ; 353     uint16_t i = 0;
1850  03b4 5f            	clrw	x
1851  03b5 1f02          	ldw	(OFST-3,sp),x
1853                     ; 354     memset(buffer, 0, buffer_size);		
1855  03b7 1e0a          	ldw	x,(OFST+5,sp)
1856  03b9 bf00          	ldw	c_x,x
1857  03bb 1e0c          	ldw	x,(OFST+7,sp)
1858  03bd 5d            	tnzw	x
1859  03be 2707          	jreq	L24
1860  03c0               L44:
1861  03c0 5a            	decw	x
1862  03c1 926f00        	clr	([c_x.w],x)
1863  03c4 5d            	tnzw	x
1864  03c5 26f9          	jrne	L44
1865  03c7               L24:
1867  03c7 2035          	jra	L1001
1868  03c9               L777:
1869                     ; 357         char ch = EEPROM_ReadByte(addr);
1871  03c9 1e04          	ldw	x,(OFST-1,sp)
1872  03cb cd019c        	call	_EEPROM_ReadByte
1874  03ce 6b01          	ld	(OFST-4,sp),a
1876                     ; 358         if (ch == '\0') {
1878  03d0 0d01          	tnz	(OFST-4,sp)
1879  03d2 2731          	jreq	L3001
1880                     ; 359             break;
1882                     ; 363         if (ch < 32 && ch >126){
1884  03d4 7b01          	ld	a,(OFST-4,sp)
1885  03d6 a120          	cp	a,#32
1886  03d8 2406          	jruge	L7001
1888  03da 7b01          	ld	a,(OFST-4,sp)
1889  03dc a17f          	cp	a,#127
1890  03de 2425          	jruge	L3001
1891                     ; 364             break; // Exit if we encounter the default value
1893  03e0               L7001:
1894                     ; 367         if (i < (buffer_size - 1)) {
1896  03e0 1e0c          	ldw	x,(OFST+7,sp)
1897  03e2 5a            	decw	x
1898  03e3 1302          	cpw	x,(OFST-3,sp)
1899  03e5 231e          	jrule	L3001
1900                     ; 368             buffer[i++] = ch;
1902  03e7 7b01          	ld	a,(OFST-4,sp)
1903  03e9 1e02          	ldw	x,(OFST-3,sp)
1904  03eb 1c0001        	addw	x,#1
1905  03ee 1f02          	ldw	(OFST-3,sp),x
1906  03f0 1d0001        	subw	x,#1
1908  03f3 72fb0a        	addw	x,(OFST+5,sp)
1909  03f6 f7            	ld	(x),a
1911                     ; 372         addr++;
1913  03f7 1e04          	ldw	x,(OFST-1,sp)
1914  03f9 1c0001        	addw	x,#1
1915  03fc 1f04          	ldw	(OFST-1,sp),x
1917  03fe               L1001:
1918                     ; 356     while (addr < EEPROM_START_ADDRESS + EEPROM_SIZE) {
1920  03fe 1e04          	ldw	x,(OFST-1,sp)
1921  0400 a37d00        	cpw	x,#32000
1922  0403 25c4          	jrult	L777
1923  0405               L3001:
1924                     ; 374     return true;
1926  0405 a601          	ld	a,#1
1929  0407 5b07          	addw	sp,#7
1930  0409 81            	ret
1980                     ; 407 void process_eeprom_logs() {
1981                     	switch	.text
1982  040a               _process_eeprom_logs:
1984  040a 5234          	subw	sp,#52
1985       00000034      OFST:	set	52
1988                     ; 409     uint16_t current_addr = EEPROM_START_ADDRESS;
1990  040c 5f            	clrw	x
1991  040d 1f01          	ldw	(OFST-51,sp),x
1993                     ; 410     printf("Reading from EEPROM:\n");
1995  040f ae0174        	ldw	x,#L7301
1996  0412 cd0000        	call	_printf
1998                     ; 411 		EEPROM_ReadString(0x00, buffer);
2000  0415 96            	ldw	x,sp
2001  0416 1c0003        	addw	x,#OFST-49
2002  0419 89            	pushw	x
2003  041a 5f            	clrw	x
2004  041b cd020e        	call	_EEPROM_ReadString
2006  041e 85            	popw	x
2008  041f 204c          	jra	L3401
2009  0421               L1401:
2010                     ; 414         if (!read_from_eeprom(current_addr, buffer, BATCH_BUFFER_SIZE)) {
2012  0421 ae0032        	ldw	x,#50
2013  0424 89            	pushw	x
2014  0425 96            	ldw	x,sp
2015  0426 1c0005        	addw	x,#OFST-47
2016  0429 89            	pushw	x
2017  042a 1e05          	ldw	x,(OFST-47,sp)
2018  042c ad81          	call	_read_from_eeprom
2020  042e 5b04          	addw	sp,#4
2021  0430 4d            	tnz	a
2022  0431 260c          	jrne	L7401
2023                     ; 415             printf("Error reading from EEPROM at address: 0x%04X\n", current_addr);
2025  0433 1e01          	ldw	x,(OFST-51,sp)
2026  0435 89            	pushw	x
2027  0436 ae0146        	ldw	x,#L1501
2028  0439 cd0000        	call	_printf
2030  043c 85            	popw	x
2031                     ; 416             break; // Stop reading on error
2033  043d 2035          	jra	L5401
2034  043f               L7401:
2035                     ; 420         if (strlen(buffer) > 0 && checkString(buffer)) {
2037  043f 96            	ldw	x,sp
2038  0440 1c0003        	addw	x,#OFST-49
2039  0443 cd0000        	call	_strlen
2041  0446 a30000        	cpw	x,#0
2042  0449 2729          	jreq	L5401
2044  044b 96            	ldw	x,sp
2045  044c 1c0003        	addw	x,#OFST-49
2046  044f ad54          	call	_checkString
2048  0451 4d            	tnz	a
2049  0452 2720          	jreq	L5401
2050                     ; 421             printf("%s\n", buffer); // Print valid log data to the serial monitor
2052  0454 96            	ldw	x,sp
2053  0455 1c0003        	addw	x,#OFST-49
2054  0458 89            	pushw	x
2055  0459 ae0142        	ldw	x,#L5501
2056  045c cd0000        	call	_printf
2058  045f 85            	popw	x
2060                     ; 426         current_addr += strlen(buffer) + 1; // +1 to skip the null terminator
2062  0460 96            	ldw	x,sp
2063  0461 1c0003        	addw	x,#OFST-49
2064  0464 cd0000        	call	_strlen
2066  0467 5c            	incw	x
2067  0468 72fb01        	addw	x,(OFST-51,sp)
2068  046b 1f01          	ldw	(OFST-51,sp),x
2070  046d               L3401:
2071                     ; 412     while (current_addr < EEPROM_START_ADDRESS + EEPROM_SIZE) {
2073  046d 1e01          	ldw	x,(OFST-51,sp)
2074  046f a37d00        	cpw	x,#32000
2075  0472 25ad          	jrult	L1401
2076  0474               L5401:
2077                     ; 428 }
2080  0474 5b34          	addw	sp,#52
2081  0476 81            	ret
2120                     ; 462 void log_to_eeprom(const char* str) {
2121                     	switch	.text
2122  0477               _log_to_eeprom:
2124  0477 89            	pushw	x
2125       00000000      OFST:	set	0
2128                     ; 463     if ((writePointer + strlen(str) + 1) >= (EEPROM_START_ADDRESS + EEPROM_SIZE)) {
2130  0478 cd0000        	call	_strlen
2132  047b 72bb0000      	addw	x,_writePointer
2133  047f 5c            	incw	x
2134  0480 a37d00        	cpw	x,#32000
2135  0483 2509          	jrult	L7701
2136                     ; 464         printf("EEPROM out of space.\n");
2138  0485 ae012c        	ldw	x,#L1011
2139  0488 cd0000        	call	_printf
2141                     ; 465 				writePointer = EEPROM_START_ADDRESS;
2143  048b 5f            	clrw	x
2144  048c bf00          	ldw	_writePointer,x
2145  048e               L7701:
2146                     ; 467     EEPROM_WriteString(writePointer, str);
2148  048e 1e01          	ldw	x,(OFST+1,sp)
2149  0490 89            	pushw	x
2150  0491 be00          	ldw	x,_writePointer
2151  0493 cd02a1        	call	_EEPROM_WriteString
2153  0496 85            	popw	x
2154                     ; 468     writePointer += strlen(str) + 1;
2156  0497 1e01          	ldw	x,(OFST+1,sp)
2157  0499 cd0000        	call	_strlen
2159  049c 5c            	incw	x
2160  049d 72bb0000      	addw	x,_writePointer
2161  04a1 bf00          	ldw	_writePointer,x
2162                     ; 469 }
2165  04a3 85            	popw	x
2166  04a4 81            	ret
2222                     ; 471 bool checkString(const char* str)
2222                     ; 472 {
2223                     	switch	.text
2224  04a5               _checkString:
2226  04a5 89            	pushw	x
2227  04a6 89            	pushw	x
2228       00000002      OFST:	set	2
2231                     ; 473 	bool flag = 0;
2233  04a7 0f01          	clr	(OFST-1,sp)
2235                     ; 474 	uint8_t i  = 0;
2237                     ; 475 	for (i = 1; i < strlen(str); i++) {
2239  04a9 a601          	ld	a,#1
2240  04ab 6b02          	ld	(OFST+0,sp),a
2243  04ad 2018          	jra	L5311
2244  04af               L1311:
2245                     ; 476 		if (str[i] != str[0]) {
2247  04af 7b02          	ld	a,(OFST+0,sp)
2248  04b1 5f            	clrw	x
2249  04b2 97            	ld	xl,a
2250  04b3 72fb03        	addw	x,(OFST+1,sp)
2251  04b6 f6            	ld	a,(x)
2252  04b7 1e03          	ldw	x,(OFST+1,sp)
2253  04b9 f1            	cp	a,(x)
2254  04ba 2709          	jreq	L1411
2255                     ; 477 				flag = 1;
2257  04bc a601          	ld	a,#1
2258  04be 6b01          	ld	(OFST-1,sp),a
2260                     ; 478 				break;
2261  04c0               L7311:
2262                     ; 481 return flag;
2264  04c0 7b01          	ld	a,(OFST-1,sp)
2267  04c2 5b04          	addw	sp,#4
2268  04c4 81            	ret
2269  04c5               L1411:
2270                     ; 475 	for (i = 1; i < strlen(str); i++) {
2272  04c5 0c02          	inc	(OFST+0,sp)
2274  04c7               L5311:
2277  04c7 1e03          	ldw	x,(OFST+1,sp)
2278  04c9 cd0000        	call	_strlen
2280  04cc 7b02          	ld	a,(OFST+0,sp)
2281  04ce 905f          	clrw	y
2282  04d0 9097          	ld	yl,a
2283  04d2 90bf00        	ldw	c_y,y
2284  04d5 b300          	cpw	x,c_y
2285  04d7 22d6          	jrugt	L1311
2286  04d9 20e5          	jra	L7311
2310                     	xdef	_main
2311                     	xdef	_checkString
2312                     	xdef	_log_to_eeprom
2313                     	xdef	_process_eeprom_logs
2314                     	xdef	_read_from_eeprom
2315                     	xdef	_EEPROM_ReadData
2316                     	xdef	_EEPROM_Test
2317                     	xdef	_EEPROM_Init
2318                     	xdef	_EEPROM_LogData
2319                     	xdef	_EEPROM_WriteString
2320                     	xdef	_EEPROM_ReadString
2321                     	xdef	_EEPROM_ReadByte
2322                     	xdef	_EEPROM_WriteByte
2323                     	xdef	_I2C_Configuration
2324                     	xdef	_GPIO_setup
2325                     	xdef	_UART3_setup
2326                     	xdef	_clock_setup
2327                     	xdef	_writePointer
2328                     	xref	_strlen
2329                     	xref	_delay_ms
2330                     	xref	_TIM4_Config
2331                     	xdef	_putchar
2332                     	xref	_printf
2333                     	xref	_UART3_GetFlagStatus
2334                     	xref	_UART3_SendData8
2335                     	xref	_UART3_Cmd
2336                     	xref	_UART3_Init
2337                     	xref	_UART3_DeInit
2338                     	xref	_I2C_CheckEvent
2339                     	xref	_I2C_SendData
2340                     	xref	_I2C_Send7bitAddress
2341                     	xref	_I2C_ReceiveData
2342                     	xref	_I2C_AcknowledgeConfig
2343                     	xref	_I2C_GenerateSTOP
2344                     	xref	_I2C_GenerateSTART
2345                     	xref	_I2C_Cmd
2346                     	xref	_I2C_Init
2347                     	xref	_I2C_DeInit
2348                     	xref	_GPIO_Init
2349                     	xref	_GPIO_DeInit
2350                     	xref	_CLK_GetFlagStatus
2351                     	xref	_CLK_SYSCLKConfig
2352                     	xref	_CLK_HSIPrescalerConfig
2353                     	xref	_CLK_ClockSwitchConfig
2354                     	xref	_CLK_PeripheralClockConfig
2355                     	xref	_CLK_ClockSwitchCmd
2356                     	xref	_CLK_LSICmd
2357                     	xref	_CLK_HSICmd
2358                     	xref	_CLK_HSECmd
2359                     	xref	_CLK_DeInit
2360                     	switch	.const
2361  012c               L1011:
2362  012c 454550524f4d  	dc.b	"EEPROM out of spac"
2363  013e 652e0a00      	dc.b	"e.",10,0
2364  0142               L5501:
2365  0142 25730a00      	dc.b	"%s",10,0
2366  0146               L1501:
2367  0146 4572726f7220  	dc.b	"Error reading from"
2368  0158 20454550524f  	dc.b	" EEPROM at address"
2369  016a 3a2030782530  	dc.b	": 0x%04X",10,0
2370  0174               L7301:
2371  0174 52656164696e  	dc.b	"Reading from EEPRO"
2372  0186 4d3a0a00      	dc.b	"M:",10,0
2373  018a               L327:
2374  018a 594f55204641  	dc.b	"YOU FAIL",0
2375  0193               L717:
2376  0193 537563636573  	dc.b	"Success",0
2377  019b               L317:
2378  019b 52656164696e  	dc.b	"Reading Starting",10,0
2379  01ad               L117:
2380  01ad 57726974696e  	dc.b	"Writing Finished",10,0
2381  01bf               L166:
2382  01bf 454550524f4d  	dc.b	"EEPROM Initialized"
2383  01d1 2e20416c6c20  	dc.b	". All values set t"
2384  01e3 6f3a20307825  	dc.b	"o: 0x%02X",10,0
2385  01ee               L756:
2386  01ee 25642c00      	dc.b	"%d,",0
2387  01f2               L746:
2388  01f2 496e69746961  	dc.b	"Initializing EEPRO"
2389  0204 4d2e2e2e0a00  	dc.b	"M...",10,0
2390  020a               L326:
2391  020a 0a446f6e6520  	dc.b	10,68,111,110,101,32
2392  0210 72656164696e  	dc.b	"reading EEPROM.",10,0
2393  0221               L126:
2394  0221 256300        	dc.b	"%c",0
2395  0224               L565:
2396  0224 44617461204c  	dc.b	"Data Logged: %s at"
2397  0236 206164647265  	dc.b	" address: 0x%04X",10,0
2398  0248               L511:
2399  0248 454550524f4d  	dc.b	"EEPROM Logging and"
2400  025a 205265616469  	dc.b	" Reading Example",10,0
2401  026c               L311:
2402  026c 537461727469  	dc.b	"Starting:",10,0
2403                     	xref.b	c_x
2404                     	xref.b	c_y
2424                     	xref	c_xymov
2425                     	end
