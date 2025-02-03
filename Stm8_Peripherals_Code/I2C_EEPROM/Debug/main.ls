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
 182                     ; 44 void main (void)
 182                     ; 45 {
 184                     	switch	.text
 185  0000               _main:
 187  0000 52ff          	subw	sp,#255
 188  0002 5241          	subw	sp,#65
 189       00000140      OFST:	set	320
 192                     ; 46   int i = 0;
 194                     ; 47   char writeData[] = "17-01-25,14:36:00,50.000,5.000,1.230";
 196  0004 96            	ldw	x,sp
 197  0005 1c0013        	addw	x,#OFST-301
 198  0008 90ae0000      	ldw	y,#L3_writeData
 199  000c a625          	ld	a,#37
 200  000e cd0000        	call	c_xymov
 202                     ; 48 	char sample_data1[] = "17-01-25,14:36:00,FDR AMPLITUDE: 24.5";
 204  0011 96            	ldw	x,sp
 205  0012 1c0038        	addw	x,#OFST-264
 206  0015 90ae0025      	ldw	y,#L5_sample_data1
 207  0019 a626          	ld	a,#38
 208  001b cd0000        	call	c_xymov
 210                     ; 49 	char sample_data2[] = "17-01-25,14:36:00,Freq < SetFreq";
 212  001e 96            	ldw	x,sp
 213  001f 1c005e        	addw	x,#OFST-226
 214  0022 90ae004b      	ldw	y,#L7_sample_data2
 215  0026 a621          	ld	a,#33
 216  0028 cd0000        	call	c_xymov
 218                     ; 50 	char sample_data3[] = "17-01-25,14:36:00,ZeroCrosssing Detected";
 220  002b 96            	ldw	x,sp
 221  002c 1c007f        	addw	x,#OFST-193
 222  002f 90ae006c      	ldw	y,#L11_sample_data3
 223  0033 a629          	ld	a,#41
 224  0035 cd0000        	call	c_xymov
 226                     ; 51 	char sample_data4[] = "17-01-25,14:36:00 Signal 1 DC";
 228  0038 96            	ldw	x,sp
 229  0039 1c00a8        	addw	x,#OFST-152
 230  003c 90ae0095      	ldw	y,#L31_sample_data4
 231  0040 a61e          	ld	a,#30
 232  0042 cd0000        	call	c_xymov
 234                     ; 52 	char sample_data5[] = "17-01-25,14:36:00 Signal 1 AC";
 236  0045 96            	ldw	x,sp
 237  0046 1c00c6        	addw	x,#OFST-122
 238  0049 90ae00b3      	ldw	y,#L51_sample_data5
 239  004d a61e          	ld	a,#30
 240  004f cd0000        	call	c_xymov
 242                     ; 53 	char sample_data6[] = "17-01-25,14:36:00 Signal 1 AC below 10 mv";
 244  0052 96            	ldw	x,sp
 245  0053 1c00e4        	addw	x,#OFST-92
 246  0056 90ae00d1      	ldw	y,#L71_sample_data6
 247  005a a62a          	ld	a,#42
 248  005c cd0000        	call	c_xymov
 250                     ; 54 	char sample_data7[] = "17-01-25,14:36:00 pulse to Commutation Thyristor";
 252  005f 96            	ldw	x,sp
 253  0060 1c010e        	addw	x,#OFST-50
 254  0063 90ae00fb      	ldw	y,#L12_sample_data7
 255  0067 a631          	ld	a,#49
 256  0069 cd0000        	call	c_xymov
 258                     ; 56   uint16_t startAddress = 0x0000;
 260                     ; 57   clock_setup ();
 262  006c ad52          	call	_clock_setup
 264                     ; 58   TIM4_Config ();
 266  006e cd0000        	call	_TIM4_Config
 268                     ; 59   UART3_setup ();
 270  0071 ad1d          	call	_UART3_setup
 272                     ; 60   GPIO_setup ();
 274  0073 cd0105        	call	_GPIO_setup
 276                     ; 61   I2C_Configuration ();
 278  0076 cd0122        	call	_I2C_Configuration
 280                     ; 62   delay_ms(1000);
 282  0079 ae03e8        	ldw	x,#1000
 283  007c cd0000        	call	_delay_ms
 285                     ; 63   printf ("Starting:\n");
 287  007f ae026c        	ldw	x,#L311
 288  0082 cd0000        	call	_printf
 290                     ; 64 	printf("EEPROM Logging and Reading Example\n");
 292  0085 ae0248        	ldw	x,#L511
 293  0088 cd0000        	call	_printf
 295                     ; 83   EEPROM_Test();
 297  008b cd036d        	call	_EEPROM_Test
 299  008e               L711:
 301  008e 20fe          	jra	L711
 327                     ; 89 void UART3_setup (void)
 327                     ; 90 {
 328                     	switch	.text
 329  0090               _UART3_setup:
 333                     ; 91   UART3_DeInit ();
 335  0090 cd0000        	call	_UART3_DeInit
 337                     ; 94   UART3_Init (9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
 337                     ; 95               UART3_MODE_TX_ENABLE);
 339  0093 4b04          	push	#4
 340  0095 4b00          	push	#0
 341  0097 4b00          	push	#0
 342  0099 4b00          	push	#0
 343  009b ae2580        	ldw	x,#9600
 344  009e 89            	pushw	x
 345  009f ae0000        	ldw	x,#0
 346  00a2 89            	pushw	x
 347  00a3 cd0000        	call	_UART3_Init
 349  00a6 5b08          	addw	sp,#8
 350                     ; 97   UART3_Cmd (ENABLE); // Enable UART1
 352  00a8 a601          	ld	a,#1
 353  00aa cd0000        	call	_UART3_Cmd
 355                     ; 98 }
 358  00ad 81            	ret
 394                     ; 100 PUTCHAR_PROTOTYPE{
 395                     	switch	.text
 396  00ae               _putchar:
 398  00ae 88            	push	a
 399       00000000      OFST:	set	0
 402                     ; 102   UART3_SendData8 (c);
 404  00af cd0000        	call	_UART3_SendData8
 407  00b2               L351:
 408                     ; 104   while (UART3_GetFlagStatus (UART3_FLAG_TXE) == RESET);
 410  00b2 ae0080        	ldw	x,#128
 411  00b5 cd0000        	call	_UART3_GetFlagStatus
 413  00b8 4d            	tnz	a
 414  00b9 27f7          	jreq	L351
 415                     ; 106   return (c);
 417  00bb 7b01          	ld	a,(OFST+1,sp)
 420  00bd 5b01          	addw	sp,#1
 421  00bf 81            	ret
 454                     ; 109 void clock_setup (void)
 454                     ; 110 {
 455                     	switch	.text
 456  00c0               _clock_setup:
 460                     ; 111   CLK_DeInit ();
 462  00c0 cd0000        	call	_CLK_DeInit
 464                     ; 112   CLK_HSECmd (DISABLE);
 466  00c3 4f            	clr	a
 467  00c4 cd0000        	call	_CLK_HSECmd
 469                     ; 113   CLK_LSICmd (DISABLE);
 471  00c7 4f            	clr	a
 472  00c8 cd0000        	call	_CLK_LSICmd
 474                     ; 114   CLK_HSICmd (ENABLE);
 476  00cb a601          	ld	a,#1
 477  00cd cd0000        	call	_CLK_HSICmd
 480  00d0               L171:
 481                     ; 115   while (CLK_GetFlagStatus (CLK_FLAG_HSIRDY) == FALSE);
 483  00d0 ae0102        	ldw	x,#258
 484  00d3 cd0000        	call	_CLK_GetFlagStatus
 486  00d6 4d            	tnz	a
 487  00d7 27f7          	jreq	L171
 488                     ; 117   CLK_ClockSwitchCmd (ENABLE);
 490  00d9 a601          	ld	a,#1
 491  00db cd0000        	call	_CLK_ClockSwitchCmd
 493                     ; 118   CLK_HSIPrescalerConfig (CLK_PRESCALER_HSIDIV1);
 495  00de 4f            	clr	a
 496  00df cd0000        	call	_CLK_HSIPrescalerConfig
 498                     ; 119   CLK_SYSCLKConfig (CLK_PRESCALER_CPUDIV1);
 500  00e2 a680          	ld	a,#128
 501  00e4 cd0000        	call	_CLK_SYSCLKConfig
 503                     ; 121   CLK_ClockSwitchConfig (CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
 503                     ; 122                          CLK_CURRENTCLOCKSTATE_ENABLE);
 505  00e7 4b01          	push	#1
 506  00e9 4b00          	push	#0
 507  00eb ae01e1        	ldw	x,#481
 508  00ee cd0000        	call	_CLK_ClockSwitchConfig
 510  00f1 85            	popw	x
 511                     ; 124   CLK_PeripheralClockConfig (CLK_PERIPHERAL_TIMER4, ENABLE);
 513  00f2 ae0401        	ldw	x,#1025
 514  00f5 cd0000        	call	_CLK_PeripheralClockConfig
 516                     ; 125   CLK_PeripheralClockConfig (CLK_PERIPHERAL_UART3, ENABLE);
 518  00f8 ae0301        	ldw	x,#769
 519  00fb cd0000        	call	_CLK_PeripheralClockConfig
 521                     ; 126   CLK_PeripheralClockConfig (CLK_PERIPHERAL_I2C, ENABLE);
 523  00fe ae0001        	ldw	x,#1
 524  0101 cd0000        	call	_CLK_PeripheralClockConfig
 526                     ; 130 }
 529  0104 81            	ret
 554                     ; 132 void GPIO_setup (void)
 554                     ; 133 {
 555                     	switch	.text
 556  0105               _GPIO_setup:
 560                     ; 134   GPIO_DeInit (GPIOE);
 562  0105 ae5014        	ldw	x,#20500
 563  0108 cd0000        	call	_GPIO_DeInit
 565                     ; 135   GPIO_Init (GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
 567  010b 4bb0          	push	#176
 568  010d 4b02          	push	#2
 569  010f ae5014        	ldw	x,#20500
 570  0112 cd0000        	call	_GPIO_Init
 572  0115 85            	popw	x
 573                     ; 136   GPIO_Init (GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
 575  0116 4bb0          	push	#176
 576  0118 4b04          	push	#4
 577  011a ae5014        	ldw	x,#20500
 578  011d cd0000        	call	_GPIO_Init
 580  0120 85            	popw	x
 581                     ; 137 }
 584  0121 81            	ret
 610                     ; 139 void I2C_Configuration (void)
 610                     ; 140 {
 611                     	switch	.text
 612  0122               _I2C_Configuration:
 616                     ; 141   I2C_DeInit (); // Reset I2C to default state
 618  0122 cd0000        	call	_I2C_DeInit
 620                     ; 144   I2C_Init (
 620                     ; 145             100000, // I2C clock frequency (100kHz)
 620                     ; 146             0x00, // Own address (not required for master mode)
 620                     ; 147             I2C_DUTYCYCLE_2, // Fast mode Tlow/Thigh = 2
 620                     ; 148             I2C_ACK_CURR, // Enable ACK for current byte
 620                     ; 149             I2C_ADDMODE_7BIT, // 7-bit addressing mode
 620                     ; 150             16 // Input clock frequency in MHz (adjust as per your system clock)
 620                     ; 151             );
 622  0125 4b10          	push	#16
 623  0127 4b00          	push	#0
 624  0129 4b01          	push	#1
 625  012b 4b00          	push	#0
 626  012d 5f            	clrw	x
 627  012e 89            	pushw	x
 628  012f ae86a0        	ldw	x,#34464
 629  0132 89            	pushw	x
 630  0133 ae0001        	ldw	x,#1
 631  0136 89            	pushw	x
 632  0137 cd0000        	call	_I2C_Init
 634  013a 5b0a          	addw	sp,#10
 635                     ; 152   I2C_Cmd (ENABLE); // Enable the I2C peripheral
 637  013c a601          	ld	a,#1
 638  013e cd0000        	call	_I2C_Cmd
 640                     ; 153 }
 643  0141 81            	ret
 692                     ; 155 void EEPROM_WriteByte (uint16_t memoryAddress, uint8_t data)
 692                     ; 156 {
 693                     	switch	.text
 694  0142               _EEPROM_WriteByte:
 696  0142 89            	pushw	x
 697       00000000      OFST:	set	0
 700                     ; 158   I2C_GenerateSTART (ENABLE);
 702  0143 a601          	ld	a,#1
 703  0145 cd0000        	call	_I2C_GenerateSTART
 706  0148               L142:
 707                     ; 159   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 709  0148 ae0301        	ldw	x,#769
 710  014b cd0000        	call	_I2C_CheckEvent
 712  014e 4d            	tnz	a
 713  014f 27f7          	jreq	L142
 714                     ; 161   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 716  0151 aea000        	ldw	x,#40960
 717  0154 cd0000        	call	_I2C_Send7bitAddress
 720  0157               L742:
 721                     ; 162   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 723  0157 ae0782        	ldw	x,#1922
 724  015a cd0000        	call	_I2C_CheckEvent
 726  015d 4d            	tnz	a
 727  015e 27f7          	jreq	L742
 728                     ; 164   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 730  0160 7b01          	ld	a,(OFST+1,sp)
 731  0162 cd0000        	call	_I2C_SendData
 734  0165               L552:
 735                     ; 165   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 737  0165 ae0784        	ldw	x,#1924
 738  0168 cd0000        	call	_I2C_CheckEvent
 740  016b 4d            	tnz	a
 741  016c 27f7          	jreq	L552
 742                     ; 167   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 744  016e 7b02          	ld	a,(OFST+2,sp)
 745  0170 a4ff          	and	a,#255
 746  0172 cd0000        	call	_I2C_SendData
 749  0175               L362:
 750                     ; 168   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 752  0175 ae0784        	ldw	x,#1924
 753  0178 cd0000        	call	_I2C_CheckEvent
 755  017b 4d            	tnz	a
 756  017c 27f7          	jreq	L362
 757                     ; 170   I2C_SendData (data);
 759  017e 7b05          	ld	a,(OFST+5,sp)
 760  0180 cd0000        	call	_I2C_SendData
 763  0183               L172:
 764                     ; 171   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 766  0183 ae0784        	ldw	x,#1924
 767  0186 cd0000        	call	_I2C_CheckEvent
 769  0189 4d            	tnz	a
 770  018a 27f7          	jreq	L172
 771                     ; 173   I2C_GenerateSTOP (ENABLE);
 773  018c a601          	ld	a,#1
 774  018e cd0000        	call	_I2C_GenerateSTOP
 776                     ; 174   delay_ms (5);
 778  0191 ae0005        	ldw	x,#5
 779  0194 cd0000        	call	_delay_ms
 781                     ; 175 }
 784  0197 85            	popw	x
 785  0198 81            	ret
 843                     ; 177 uint8_t EEPROM_ReadByte (uint16_t memoryAddress)
 843                     ; 178 {
 844                     	switch	.text
 845  0199               _EEPROM_ReadByte:
 847  0199 89            	pushw	x
 848  019a 89            	pushw	x
 849       00000002      OFST:	set	2
 852                     ; 180   uint8_t i = 0;
 854                     ; 182   I2C_GenerateSTART (ENABLE);
 856  019b a601          	ld	a,#1
 857  019d cd0000        	call	_I2C_GenerateSTART
 860  01a0               L523:
 861                     ; 183   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 863  01a0 ae0301        	ldw	x,#769
 864  01a3 cd0000        	call	_I2C_CheckEvent
 866  01a6 4d            	tnz	a
 867  01a7 27f7          	jreq	L523
 868                     ; 185   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 870  01a9 aea000        	ldw	x,#40960
 871  01ac cd0000        	call	_I2C_Send7bitAddress
 874  01af               L333:
 875                     ; 186   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 877  01af ae0782        	ldw	x,#1922
 878  01b2 cd0000        	call	_I2C_CheckEvent
 880  01b5 4d            	tnz	a
 881  01b6 27f7          	jreq	L333
 882                     ; 188   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 884  01b8 7b03          	ld	a,(OFST+1,sp)
 885  01ba cd0000        	call	_I2C_SendData
 888  01bd               L143:
 889                     ; 189   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 891  01bd ae0784        	ldw	x,#1924
 892  01c0 cd0000        	call	_I2C_CheckEvent
 894  01c3 4d            	tnz	a
 895  01c4 27f7          	jreq	L143
 896                     ; 191   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 898  01c6 7b04          	ld	a,(OFST+2,sp)
 899  01c8 a4ff          	and	a,#255
 900  01ca cd0000        	call	_I2C_SendData
 903  01cd               L743:
 904                     ; 192   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 906  01cd ae0784        	ldw	x,#1924
 907  01d0 cd0000        	call	_I2C_CheckEvent
 909  01d3 4d            	tnz	a
 910  01d4 27f7          	jreq	L743
 911                     ; 195   I2C_GenerateSTART (ENABLE);
 913  01d6 a601          	ld	a,#1
 914  01d8 cd0000        	call	_I2C_GenerateSTART
 917  01db               L553:
 918                     ; 196   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 920  01db ae0301        	ldw	x,#769
 921  01de cd0000        	call	_I2C_CheckEvent
 923  01e1 4d            	tnz	a
 924  01e2 27f7          	jreq	L553
 925                     ; 198   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
 927  01e4 aea101        	ldw	x,#41217
 928  01e7 cd0000        	call	_I2C_Send7bitAddress
 931  01ea               L363:
 932                     ; 199   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
 934  01ea ae0302        	ldw	x,#770
 935  01ed cd0000        	call	_I2C_CheckEvent
 937  01f0 4d            	tnz	a
 938  01f1 27f7          	jreq	L363
 940  01f3               L173:
 941                     ; 201   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED) == ERROR);
 943  01f3 ae0340        	ldw	x,#832
 944  01f6 cd0000        	call	_I2C_CheckEvent
 946  01f9 4d            	tnz	a
 947  01fa 27f7          	jreq	L173
 948                     ; 202   receivedData = I2C_ReceiveData ();
 950  01fc cd0000        	call	_I2C_ReceiveData
 952  01ff 6b02          	ld	(OFST+0,sp),a
 954                     ; 204   I2C_GenerateSTOP (ENABLE);
 956  0201 a601          	ld	a,#1
 957  0203 cd0000        	call	_I2C_GenerateSTOP
 959                     ; 206   return receivedData;
 961  0206 7b02          	ld	a,(OFST+0,sp)
 964  0208 5b04          	addw	sp,#4
 965  020a 81            	ret
1043                     ; 209 void EEPROM_ReadString (uint16_t memoryAddress, char* buffer)
1043                     ; 210 {
1044                     	switch	.text
1045  020b               _EEPROM_ReadString:
1047  020b 89            	pushw	x
1048  020c 5203          	subw	sp,#3
1049       00000003      OFST:	set	3
1052                     ; 211   uint8_t tempData = 0;
1054                     ; 212   uint8_t i = 0;
1056  020e 0f03          	clr	(OFST+0,sp)
1058                     ; 214   I2C_GenerateSTART (ENABLE);
1060  0210 a601          	ld	a,#1
1061  0212 cd0000        	call	_I2C_GenerateSTART
1064  0215               L534:
1065                     ; 215   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
1067  0215 ae0301        	ldw	x,#769
1068  0218 cd0000        	call	_I2C_CheckEvent
1070  021b 4d            	tnz	a
1071  021c 27f7          	jreq	L534
1072                     ; 217   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
1074  021e aea000        	ldw	x,#40960
1075  0221 cd0000        	call	_I2C_Send7bitAddress
1078  0224               L344:
1079                     ; 218   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
1081  0224 ae0782        	ldw	x,#1922
1082  0227 cd0000        	call	_I2C_CheckEvent
1084  022a 4d            	tnz	a
1085  022b 27f7          	jreq	L344
1086                     ; 220   I2C_SendData ((uint8_t) (memoryAddress >> 8));
1088  022d 7b04          	ld	a,(OFST+1,sp)
1089  022f cd0000        	call	_I2C_SendData
1092  0232               L154:
1093                     ; 221   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
1095  0232 ae0784        	ldw	x,#1924
1096  0235 cd0000        	call	_I2C_CheckEvent
1098  0238 4d            	tnz	a
1099  0239 27f7          	jreq	L154
1100                     ; 223   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
1102  023b 7b05          	ld	a,(OFST+2,sp)
1103  023d a4ff          	and	a,#255
1104  023f cd0000        	call	_I2C_SendData
1107  0242               L754:
1108                     ; 224   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
1110  0242 ae0784        	ldw	x,#1924
1111  0245 cd0000        	call	_I2C_CheckEvent
1113  0248 4d            	tnz	a
1114  0249 27f7          	jreq	L754
1115                     ; 227   I2C_GenerateSTART (ENABLE);
1117  024b a601          	ld	a,#1
1118  024d cd0000        	call	_I2C_GenerateSTART
1121  0250               L564:
1122                     ; 228   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
1124  0250 ae0301        	ldw	x,#769
1125  0253 cd0000        	call	_I2C_CheckEvent
1127  0256 4d            	tnz	a
1128  0257 27f7          	jreq	L564
1129                     ; 230   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
1131  0259 aea101        	ldw	x,#41217
1132  025c cd0000        	call	_I2C_Send7bitAddress
1135  025f               L374:
1136                     ; 231   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
1138  025f ae0302        	ldw	x,#770
1139  0262 cd0000        	call	_I2C_CheckEvent
1141  0265 4d            	tnz	a
1142  0266 27f7          	jreq	L374
1143  0268               L774:
1144                     ; 234     if (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED))
1146  0268 ae0340        	ldw	x,#832
1147  026b cd0000        	call	_I2C_CheckEvent
1149  026e 4d            	tnz	a
1150  026f 27f7          	jreq	L774
1151                     ; 236       uint8_t tempData = I2C_ReceiveData ();
1153  0271 cd0000        	call	_I2C_ReceiveData
1155  0274 6b01          	ld	(OFST-2,sp),a
1157                     ; 237       if (tempData == '\0')
1159  0276 0d01          	tnz	(OFST-2,sp)
1160  0278 2614          	jrne	L505
1161                     ; 239         I2C_AcknowledgeConfig (I2C_ACK_NONE);
1163  027a 4f            	clr	a
1164  027b cd0000        	call	_I2C_AcknowledgeConfig
1166                     ; 240         I2C_GenerateSTOP (ENABLE);
1168  027e a601          	ld	a,#1
1169  0280 cd0000        	call	_I2C_GenerateSTOP
1171                     ; 241         break;
1172                     ; 247   buffer[i] = '\0';
1174  0283 7b03          	ld	a,(OFST+0,sp)
1175  0285 5f            	clrw	x
1176  0286 97            	ld	xl,a
1177  0287 72fb08        	addw	x,(OFST+5,sp)
1178  028a 7f            	clr	(x)
1179                     ; 250 }
1182  028b 5b05          	addw	sp,#5
1183  028d 81            	ret
1184  028e               L505:
1185                     ; 244         buffer[i++] = tempData;
1187  028e 7b03          	ld	a,(OFST+0,sp)
1188  0290 97            	ld	xl,a
1189  0291 0c03          	inc	(OFST+0,sp)
1191  0293 9f            	ld	a,xl
1192  0294 5f            	clrw	x
1193  0295 97            	ld	xl,a
1194  0296 72fb08        	addw	x,(OFST+5,sp)
1195  0299 7b01          	ld	a,(OFST-2,sp)
1196  029b f7            	ld	(x),a
1197  029c 20ca          	jra	L774
1242                     ; 252 void EEPROM_WriteString (uint16_t memoryAddress, char *data)
1242                     ; 253 {
1243                     	switch	.text
1244  029e               _EEPROM_WriteString:
1246  029e 89            	pushw	x
1247       00000000      OFST:	set	0
1250  029f 2018          	jra	L535
1251  02a1               L335:
1252                     ; 256     EEPROM_WriteByte (memoryAddress, *data); // Write one character to EEPROM
1254  02a1 1e05          	ldw	x,(OFST+5,sp)
1255  02a3 f6            	ld	a,(x)
1256  02a4 88            	push	a
1257  02a5 1e02          	ldw	x,(OFST+2,sp)
1258  02a7 cd0142        	call	_EEPROM_WriteByte
1260  02aa 84            	pop	a
1261                     ; 257     memoryAddress++; // Increment the address to write the next character
1263  02ab 1e01          	ldw	x,(OFST+1,sp)
1264  02ad 1c0001        	addw	x,#1
1265  02b0 1f01          	ldw	(OFST+1,sp),x
1266                     ; 258     data++; // Move to the next character in the string
1268  02b2 1e05          	ldw	x,(OFST+5,sp)
1269  02b4 1c0001        	addw	x,#1
1270  02b7 1f05          	ldw	(OFST+5,sp),x
1271  02b9               L535:
1272                     ; 254   while (*data)
1274  02b9 1e05          	ldw	x,(OFST+5,sp)
1275  02bb 7d            	tnz	(x)
1276  02bc 26e3          	jrne	L335
1277                     ; 261   EEPROM_WriteByte (memoryAddress, '\0');
1279  02be 4b00          	push	#0
1280  02c0 1e02          	ldw	x,(OFST+2,sp)
1281  02c2 cd0142        	call	_EEPROM_WriteByte
1283  02c5 84            	pop	a
1284                     ; 262 }
1287  02c6 85            	popw	x
1288  02c7 81            	ret
1335                     ; 264 void EEPROM_LogData(const char *data)
1335                     ; 265 {
1336                     	switch	.text
1337  02c8               _EEPROM_LogData:
1339  02c8 89            	pushw	x
1340  02c9 89            	pushw	x
1341       00000002      OFST:	set	2
1344                     ; 266 	uint16_t memoryAddress = writePointer; // Start writing at the current write pointer
1346  02ca be00          	ldw	x,_writePointer
1347  02cc 1f01          	ldw	(OFST-1,sp),x
1349                     ; 269 	EEPROM_WriteString(memoryAddress, data);
1351  02ce 1e03          	ldw	x,(OFST+1,sp)
1352  02d0 89            	pushw	x
1353  02d1 1e03          	ldw	x,(OFST+1,sp)
1354  02d3 adc9          	call	_EEPROM_WriteString
1356  02d5 85            	popw	x
1357                     ; 272 	writePointer += LOG_ENTRY_SIZE;
1359  02d6 be00          	ldw	x,_writePointer
1360  02d8 1c0025        	addw	x,#37
1361  02db bf00          	ldw	_writePointer,x
1362                     ; 275 	if (writePointer >= EEPROM_SIZE)
1364  02dd be00          	ldw	x,_writePointer
1365  02df a37d00        	cpw	x,#32000
1366  02e2 2503          	jrult	L365
1367                     ; 277 			writePointer = EEPROM_START_ADDRESS;
1369  02e4 5f            	clrw	x
1370  02e5 bf00          	ldw	_writePointer,x
1371  02e7               L365:
1372                     ; 280 	printf("Data Logged: %s at address: 0x%04X\n", data, memoryAddress);
1374  02e7 1e01          	ldw	x,(OFST-1,sp)
1375  02e9 89            	pushw	x
1376  02ea 1e05          	ldw	x,(OFST+3,sp)
1377  02ec 89            	pushw	x
1378  02ed ae0224        	ldw	x,#L565
1379  02f0 cd0000        	call	_printf
1381  02f3 5b04          	addw	sp,#4
1382                     ; 281 }
1385  02f5 5b04          	addw	sp,#4
1386  02f7 81            	ret
1431                     ; 283 void EEPROM_ReadData(void)
1431                     ; 284 {
1432                     	switch	.text
1433  02f8               _EEPROM_ReadData:
1435  02f8 5203          	subw	sp,#3
1436       00000003      OFST:	set	3
1439                     ; 285     uint16_t memoryAddress = EEPROM_START_ADDRESS; // Start at the beginning of EEPROM
1441  02fa 5f            	clrw	x
1442  02fb 1f01          	ldw	(OFST-2,sp),x
1444  02fd               L116:
1445                     ; 292         data = EEPROM_ReadByte(memoryAddress);
1447  02fd 1e01          	ldw	x,(OFST-2,sp)
1448  02ff cd0199        	call	_EEPROM_ReadByte
1450  0302 6b03          	ld	(OFST+0,sp),a
1452                     ; 295         if (data >= 33 && data <= 122) // Printable ASCII range
1454  0304 7b03          	ld	a,(OFST+0,sp)
1455  0306 a121          	cp	a,#33
1456  0308 2510          	jrult	L716
1458  030a 7b03          	ld	a,(OFST+0,sp)
1459  030c a17b          	cp	a,#123
1460  030e 240a          	jruge	L716
1461                     ; 297             printf("%c", data); // Print the character directly
1463  0310 7b03          	ld	a,(OFST+0,sp)
1464  0312 88            	push	a
1465  0313 ae0221        	ldw	x,#L126
1466  0316 cd0000        	call	_printf
1468  0319 84            	pop	a
1469  031a               L716:
1470                     ; 300         memoryAddress++;
1472  031a 1e01          	ldw	x,(OFST-2,sp)
1473  031c 1c0001        	addw	x,#1
1474  031f 1f01          	ldw	(OFST-2,sp),x
1476                     ; 289     while (memoryAddress < EEPROM_SIZE) // Loop until the end of the EEPROM
1478  0321 1e01          	ldw	x,(OFST-2,sp)
1479  0323 a37d00        	cpw	x,#32000
1480  0326 25d5          	jrult	L116
1481                     ; 302     printf("\nDone reading EEPROM.\n");
1483  0328 ae020a        	ldw	x,#L326
1484  032b cd0000        	call	_printf
1486                     ; 303 }
1489  032e 5b03          	addw	sp,#3
1490  0330 81            	ret
1536                     ; 305 void EEPROM_Init(uint16_t defaultValue)
1536                     ; 306 {
1537                     	switch	.text
1538  0331               _EEPROM_Init:
1540  0331 89            	pushw	x
1541  0332 89            	pushw	x
1542       00000002      OFST:	set	2
1545                     ; 307     uint16_t address = 0;
1547                     ; 309     printf("Initializing EEPROM...\n");
1549  0333 ae01f2        	ldw	x,#L746
1550  0336 cd0000        	call	_printf
1552                     ; 310     for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
1554  0339 5f            	clrw	x
1555  033a 1f01          	ldw	(OFST-1,sp),x
1557  033c               L156:
1558                     ; 312         EEPROM_WriteByte(address, defaultValue); // Write default value
1560  033c 7b04          	ld	a,(OFST+2,sp)
1561  033e 88            	push	a
1562  033f 1e02          	ldw	x,(OFST+0,sp)
1563  0341 cd0142        	call	_EEPROM_WriteByte
1565  0344 84            	pop	a
1566                     ; 314 				printf("%d,", address);
1568  0345 1e01          	ldw	x,(OFST-1,sp)
1569  0347 89            	pushw	x
1570  0348 ae01ee        	ldw	x,#L756
1571  034b cd0000        	call	_printf
1573  034e 85            	popw	x
1574                     ; 310     for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
1576  034f 1e01          	ldw	x,(OFST-1,sp)
1577  0351 1c0001        	addw	x,#1
1578  0354 1f01          	ldw	(OFST-1,sp),x
1582  0356 1e01          	ldw	x,(OFST-1,sp)
1583  0358 a37d00        	cpw	x,#32000
1584  035b 25df          	jrult	L156
1585                     ; 319     writePointer = EEPROM_START_ADDRESS; // Reset pointer
1587  035d 5f            	clrw	x
1588  035e bf00          	ldw	_writePointer,x
1589                     ; 320     printf("EEPROM Initialized. All values set to: 0x%02X\n", defaultValue);
1591  0360 1e03          	ldw	x,(OFST+1,sp)
1592  0362 89            	pushw	x
1593  0363 ae01bf        	ldw	x,#L166
1594  0366 cd0000        	call	_printf
1596  0369 85            	popw	x
1597                     ; 321 }
1600  036a 5b04          	addw	sp,#4
1601  036c 81            	ret
1657                     ; 323 void EEPROM_Test (void)
1657                     ; 324 {
1658                     	switch	.text
1659  036d               _EEPROM_Test:
1661  036d 5204          	subw	sp,#4
1662       00000004      OFST:	set	4
1665                     ; 325   uint16_t memoryAddress = 0x0000; // EEPROM memory address to write/read
1667  036f 5f            	clrw	x
1668  0370 1f02          	ldw	(OFST-2,sp),x
1670                     ; 326   uint8_t dataToWrite = 0xAB; // Data to write
1672  0372 a6ab          	ld	a,#171
1673  0374 6b04          	ld	(OFST+0,sp),a
1675                     ; 329   I2C_Configuration (); // Initialize I2C peripheral
1677  0376 cd0122        	call	_I2C_Configuration
1679                     ; 332   EEPROM_WriteByte (memoryAddress, dataToWrite);
1681  0379 7b04          	ld	a,(OFST+0,sp)
1682  037b 88            	push	a
1683  037c 1e03          	ldw	x,(OFST-1,sp)
1684  037e cd0142        	call	_EEPROM_WriteByte
1686  0381 84            	pop	a
1687                     ; 333   printf ("Writing Finished\n");
1689  0382 ae01ad        	ldw	x,#L117
1690  0385 cd0000        	call	_printf
1692                     ; 336   printf ("Reading Starting\n");
1694  0388 ae019b        	ldw	x,#L317
1695  038b cd0000        	call	_printf
1697                     ; 338   dataRead = EEPROM_ReadByte (memoryAddress);
1699  038e 1e02          	ldw	x,(OFST-2,sp)
1700  0390 cd0199        	call	_EEPROM_ReadByte
1702  0393 6b01          	ld	(OFST-3,sp),a
1704                     ; 341   if (dataRead == dataToWrite)
1706  0395 7b01          	ld	a,(OFST-3,sp)
1707  0397 1104          	cp	a,(OFST+0,sp)
1708  0399 2608          	jrne	L517
1709                     ; 343     printf ("Success");
1711  039b ae0193        	ldw	x,#L717
1712  039e cd0000        	call	_printf
1715  03a1 2006          	jra	L127
1716  03a3               L517:
1717                     ; 347     printf ("YOU FAIL");
1719  03a3 ae018a        	ldw	x,#L327
1720  03a6 cd0000        	call	_printf
1722  03a9               L127:
1723                     ; 349 }
1726  03a9 5b04          	addw	sp,#4
1727  03ab 81            	ret
1830                     ; 351 bool read_from_eeprom(uint16_t start_addr, char* buffer, uint16_t buffer_size) {
1831                     	switch	.text
1832  03ac               _read_from_eeprom:
1834  03ac 89            	pushw	x
1835  03ad 5205          	subw	sp,#5
1836       00000005      OFST:	set	5
1839                     ; 352     uint16_t addr = start_addr;
1841  03af 1f04          	ldw	(OFST-1,sp),x
1843                     ; 353     uint16_t i = 0;
1845  03b1 5f            	clrw	x
1846  03b2 1f02          	ldw	(OFST-3,sp),x
1848                     ; 354     memset(buffer, 0, buffer_size);		
1850  03b4 1e0a          	ldw	x,(OFST+5,sp)
1851  03b6 bf00          	ldw	c_x,x
1852  03b8 1e0c          	ldw	x,(OFST+7,sp)
1853  03ba 5d            	tnzw	x
1854  03bb 2707          	jreq	L24
1855  03bd               L44:
1856  03bd 5a            	decw	x
1857  03be 926f00        	clr	([c_x.w],x)
1858  03c1 5d            	tnzw	x
1859  03c2 26f9          	jrne	L44
1860  03c4               L24:
1862  03c4 2035          	jra	L1001
1863  03c6               L777:
1864                     ; 357         char ch = EEPROM_ReadByte(addr);
1866  03c6 1e04          	ldw	x,(OFST-1,sp)
1867  03c8 cd0199        	call	_EEPROM_ReadByte
1869  03cb 6b01          	ld	(OFST-4,sp),a
1871                     ; 358         if (ch == '\0') {
1873  03cd 0d01          	tnz	(OFST-4,sp)
1874  03cf 2731          	jreq	L3001
1875                     ; 359             break;
1877                     ; 363         if (ch < 32 && ch >126){
1879  03d1 7b01          	ld	a,(OFST-4,sp)
1880  03d3 a120          	cp	a,#32
1881  03d5 2406          	jruge	L7001
1883  03d7 7b01          	ld	a,(OFST-4,sp)
1884  03d9 a17f          	cp	a,#127
1885  03db 2425          	jruge	L3001
1886                     ; 364             break; // Exit if we encounter the default value
1888  03dd               L7001:
1889                     ; 367         if (i < (buffer_size - 1)) {
1891  03dd 1e0c          	ldw	x,(OFST+7,sp)
1892  03df 5a            	decw	x
1893  03e0 1302          	cpw	x,(OFST-3,sp)
1894  03e2 231e          	jrule	L3001
1895                     ; 368             buffer[i++] = ch;
1897  03e4 7b01          	ld	a,(OFST-4,sp)
1898  03e6 1e02          	ldw	x,(OFST-3,sp)
1899  03e8 1c0001        	addw	x,#1
1900  03eb 1f02          	ldw	(OFST-3,sp),x
1901  03ed 1d0001        	subw	x,#1
1903  03f0 72fb0a        	addw	x,(OFST+5,sp)
1904  03f3 f7            	ld	(x),a
1906                     ; 372         addr++;
1908  03f4 1e04          	ldw	x,(OFST-1,sp)
1909  03f6 1c0001        	addw	x,#1
1910  03f9 1f04          	ldw	(OFST-1,sp),x
1912  03fb               L1001:
1913                     ; 356     while (addr < EEPROM_START_ADDRESS + EEPROM_SIZE) {
1915  03fb 1e04          	ldw	x,(OFST-1,sp)
1916  03fd a37d00        	cpw	x,#32000
1917  0400 25c4          	jrult	L777
1918  0402               L3001:
1919                     ; 374     return true;
1921  0402 a601          	ld	a,#1
1924  0404 5b07          	addw	sp,#7
1925  0406 81            	ret
1975                     ; 407 void process_eeprom_logs() {
1976                     	switch	.text
1977  0407               _process_eeprom_logs:
1979  0407 5234          	subw	sp,#52
1980       00000034      OFST:	set	52
1983                     ; 409     uint16_t current_addr = EEPROM_START_ADDRESS;
1985  0409 5f            	clrw	x
1986  040a 1f01          	ldw	(OFST-51,sp),x
1988                     ; 410     printf("Reading from EEPROM:\n");
1990  040c ae0174        	ldw	x,#L7301
1991  040f cd0000        	call	_printf
1993                     ; 411 		EEPROM_ReadString(0x00, buffer);
1995  0412 96            	ldw	x,sp
1996  0413 1c0003        	addw	x,#OFST-49
1997  0416 89            	pushw	x
1998  0417 5f            	clrw	x
1999  0418 cd020b        	call	_EEPROM_ReadString
2001  041b 85            	popw	x
2003  041c 204c          	jra	L3401
2004  041e               L1401:
2005                     ; 414         if (!read_from_eeprom(current_addr, buffer, BATCH_BUFFER_SIZE)) {
2007  041e ae0032        	ldw	x,#50
2008  0421 89            	pushw	x
2009  0422 96            	ldw	x,sp
2010  0423 1c0005        	addw	x,#OFST-47
2011  0426 89            	pushw	x
2012  0427 1e05          	ldw	x,(OFST-47,sp)
2013  0429 ad81          	call	_read_from_eeprom
2015  042b 5b04          	addw	sp,#4
2016  042d 4d            	tnz	a
2017  042e 260c          	jrne	L7401
2018                     ; 415             printf("Error reading from EEPROM at address: 0x%04X\n", current_addr);
2020  0430 1e01          	ldw	x,(OFST-51,sp)
2021  0432 89            	pushw	x
2022  0433 ae0146        	ldw	x,#L1501
2023  0436 cd0000        	call	_printf
2025  0439 85            	popw	x
2026                     ; 416             break; // Stop reading on error
2028  043a 2035          	jra	L5401
2029  043c               L7401:
2030                     ; 420         if (strlen(buffer) > 0 && checkString(buffer)) {
2032  043c 96            	ldw	x,sp
2033  043d 1c0003        	addw	x,#OFST-49
2034  0440 cd0000        	call	_strlen
2036  0443 a30000        	cpw	x,#0
2037  0446 2729          	jreq	L5401
2039  0448 96            	ldw	x,sp
2040  0449 1c0003        	addw	x,#OFST-49
2041  044c ad54          	call	_checkString
2043  044e 4d            	tnz	a
2044  044f 2720          	jreq	L5401
2045                     ; 421             printf("%s\n", buffer); // Print valid log data to the serial monitor
2047  0451 96            	ldw	x,sp
2048  0452 1c0003        	addw	x,#OFST-49
2049  0455 89            	pushw	x
2050  0456 ae0142        	ldw	x,#L5501
2051  0459 cd0000        	call	_printf
2053  045c 85            	popw	x
2055                     ; 426         current_addr += strlen(buffer) + 1; // +1 to skip the null terminator
2057  045d 96            	ldw	x,sp
2058  045e 1c0003        	addw	x,#OFST-49
2059  0461 cd0000        	call	_strlen
2061  0464 5c            	incw	x
2062  0465 72fb01        	addw	x,(OFST-51,sp)
2063  0468 1f01          	ldw	(OFST-51,sp),x
2065  046a               L3401:
2066                     ; 412     while (current_addr < EEPROM_START_ADDRESS + EEPROM_SIZE) {
2068  046a 1e01          	ldw	x,(OFST-51,sp)
2069  046c a37d00        	cpw	x,#32000
2070  046f 25ad          	jrult	L1401
2071  0471               L5401:
2072                     ; 428 }
2075  0471 5b34          	addw	sp,#52
2076  0473 81            	ret
2115                     ; 462 void log_to_eeprom(const char* str) {
2116                     	switch	.text
2117  0474               _log_to_eeprom:
2119  0474 89            	pushw	x
2120       00000000      OFST:	set	0
2123                     ; 463     if ((writePointer + strlen(str) + 1) >= (EEPROM_START_ADDRESS + EEPROM_SIZE)) {
2125  0475 cd0000        	call	_strlen
2127  0478 72bb0000      	addw	x,_writePointer
2128  047c 5c            	incw	x
2129  047d a37d00        	cpw	x,#32000
2130  0480 2509          	jrult	L7701
2131                     ; 464         printf("EEPROM out of space.\n");
2133  0482 ae012c        	ldw	x,#L1011
2134  0485 cd0000        	call	_printf
2136                     ; 465 				writePointer = EEPROM_START_ADDRESS;
2138  0488 5f            	clrw	x
2139  0489 bf00          	ldw	_writePointer,x
2140  048b               L7701:
2141                     ; 467     EEPROM_WriteString(writePointer, str);
2143  048b 1e01          	ldw	x,(OFST+1,sp)
2144  048d 89            	pushw	x
2145  048e be00          	ldw	x,_writePointer
2146  0490 cd029e        	call	_EEPROM_WriteString
2148  0493 85            	popw	x
2149                     ; 468     writePointer += strlen(str) + 1;
2151  0494 1e01          	ldw	x,(OFST+1,sp)
2152  0496 cd0000        	call	_strlen
2154  0499 5c            	incw	x
2155  049a 72bb0000      	addw	x,_writePointer
2156  049e bf00          	ldw	_writePointer,x
2157                     ; 469 }
2160  04a0 85            	popw	x
2161  04a1 81            	ret
2217                     ; 471 bool checkString(const char* str)
2217                     ; 472 {
2218                     	switch	.text
2219  04a2               _checkString:
2221  04a2 89            	pushw	x
2222  04a3 89            	pushw	x
2223       00000002      OFST:	set	2
2226                     ; 473 	bool flag = 0;
2228  04a4 0f01          	clr	(OFST-1,sp)
2230                     ; 474 	uint8_t i  = 0;
2232                     ; 475 	for (i = 1; i < strlen(str); i++) {
2234  04a6 a601          	ld	a,#1
2235  04a8 6b02          	ld	(OFST+0,sp),a
2238  04aa 2018          	jra	L5311
2239  04ac               L1311:
2240                     ; 476 		if (str[i] != str[0]) {
2242  04ac 7b02          	ld	a,(OFST+0,sp)
2243  04ae 5f            	clrw	x
2244  04af 97            	ld	xl,a
2245  04b0 72fb03        	addw	x,(OFST+1,sp)
2246  04b3 f6            	ld	a,(x)
2247  04b4 1e03          	ldw	x,(OFST+1,sp)
2248  04b6 f1            	cp	a,(x)
2249  04b7 2709          	jreq	L1411
2250                     ; 477 				flag = 1;
2252  04b9 a601          	ld	a,#1
2253  04bb 6b01          	ld	(OFST-1,sp),a
2255                     ; 478 				break;
2256  04bd               L7311:
2257                     ; 481 return flag;
2259  04bd 7b01          	ld	a,(OFST-1,sp)
2262  04bf 5b04          	addw	sp,#4
2263  04c1 81            	ret
2264  04c2               L1411:
2265                     ; 475 	for (i = 1; i < strlen(str); i++) {
2267  04c2 0c02          	inc	(OFST+0,sp)
2269  04c4               L5311:
2272  04c4 1e03          	ldw	x,(OFST+1,sp)
2273  04c6 cd0000        	call	_strlen
2275  04c9 7b02          	ld	a,(OFST+0,sp)
2276  04cb 905f          	clrw	y
2277  04cd 9097          	ld	yl,a
2278  04cf 90bf00        	ldw	c_y,y
2279  04d2 b300          	cpw	x,c_y
2280  04d4 22d6          	jrugt	L1311
2281  04d6 20e5          	jra	L7311
2305                     	xdef	_main
2306                     	xdef	_checkString
2307                     	xdef	_log_to_eeprom
2308                     	xdef	_process_eeprom_logs
2309                     	xdef	_read_from_eeprom
2310                     	xdef	_EEPROM_ReadData
2311                     	xdef	_EEPROM_Test
2312                     	xdef	_EEPROM_Init
2313                     	xdef	_EEPROM_LogData
2314                     	xdef	_EEPROM_WriteString
2315                     	xdef	_EEPROM_ReadString
2316                     	xdef	_EEPROM_ReadByte
2317                     	xdef	_EEPROM_WriteByte
2318                     	xdef	_I2C_Configuration
2319                     	xdef	_GPIO_setup
2320                     	xdef	_UART3_setup
2321                     	xdef	_clock_setup
2322                     	xdef	_writePointer
2323                     	xref	_strlen
2324                     	xref	_delay_ms
2325                     	xref	_TIM4_Config
2326                     	xdef	_putchar
2327                     	xref	_printf
2328                     	xref	_UART3_GetFlagStatus
2329                     	xref	_UART3_SendData8
2330                     	xref	_UART3_Cmd
2331                     	xref	_UART3_Init
2332                     	xref	_UART3_DeInit
2333                     	xref	_I2C_CheckEvent
2334                     	xref	_I2C_SendData
2335                     	xref	_I2C_Send7bitAddress
2336                     	xref	_I2C_ReceiveData
2337                     	xref	_I2C_AcknowledgeConfig
2338                     	xref	_I2C_GenerateSTOP
2339                     	xref	_I2C_GenerateSTART
2340                     	xref	_I2C_Cmd
2341                     	xref	_I2C_Init
2342                     	xref	_I2C_DeInit
2343                     	xref	_GPIO_Init
2344                     	xref	_GPIO_DeInit
2345                     	xref	_CLK_GetFlagStatus
2346                     	xref	_CLK_SYSCLKConfig
2347                     	xref	_CLK_HSIPrescalerConfig
2348                     	xref	_CLK_ClockSwitchConfig
2349                     	xref	_CLK_PeripheralClockConfig
2350                     	xref	_CLK_ClockSwitchCmd
2351                     	xref	_CLK_LSICmd
2352                     	xref	_CLK_HSICmd
2353                     	xref	_CLK_HSECmd
2354                     	xref	_CLK_DeInit
2355                     	switch	.const
2356  012c               L1011:
2357  012c 454550524f4d  	dc.b	"EEPROM out of spac"
2358  013e 652e0a00      	dc.b	"e.",10,0
2359  0142               L5501:
2360  0142 25730a00      	dc.b	"%s",10,0
2361  0146               L1501:
2362  0146 4572726f7220  	dc.b	"Error reading from"
2363  0158 20454550524f  	dc.b	" EEPROM at address"
2364  016a 3a2030782530  	dc.b	": 0x%04X",10,0
2365  0174               L7301:
2366  0174 52656164696e  	dc.b	"Reading from EEPRO"
2367  0186 4d3a0a00      	dc.b	"M:",10,0
2368  018a               L327:
2369  018a 594f55204641  	dc.b	"YOU FAIL",0
2370  0193               L717:
2371  0193 537563636573  	dc.b	"Success",0
2372  019b               L317:
2373  019b 52656164696e  	dc.b	"Reading Starting",10,0
2374  01ad               L117:
2375  01ad 57726974696e  	dc.b	"Writing Finished",10,0
2376  01bf               L166:
2377  01bf 454550524f4d  	dc.b	"EEPROM Initialized"
2378  01d1 2e20416c6c20  	dc.b	". All values set t"
2379  01e3 6f3a20307825  	dc.b	"o: 0x%02X",10,0
2380  01ee               L756:
2381  01ee 25642c00      	dc.b	"%d,",0
2382  01f2               L746:
2383  01f2 496e69746961  	dc.b	"Initializing EEPRO"
2384  0204 4d2e2e2e0a00  	dc.b	"M...",10,0
2385  020a               L326:
2386  020a 0a446f6e6520  	dc.b	10,68,111,110,101,32
2387  0210 72656164696e  	dc.b	"reading EEPROM.",10,0
2388  0221               L126:
2389  0221 256300        	dc.b	"%c",0
2390  0224               L565:
2391  0224 44617461204c  	dc.b	"Data Logged: %s at"
2392  0236 206164647265  	dc.b	" address: 0x%04X",10,0
2393  0248               L511:
2394  0248 454550524f4d  	dc.b	"EEPROM Logging and"
2395  025a 205265616469  	dc.b	" Reading Example",10,0
2396  026c               L311:
2397  026c 537461727469  	dc.b	"Starting:",10,0
2398                     	xref.b	c_x
2399                     	xref.b	c_y
2419                     	xref	c_xymov
2420                     	end
