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
  98                     ; 32 void main (void)
  98                     ; 33 {
 100                     	switch	.text
 101  0000               _main:
 103  0000 5250          	subw	sp,#80
 104       00000050      OFST:	set	80
 107                     ; 34   uint8_t i = 0;
 109                     ; 35   char writeData[] = "17-01-25,14:36:00,50.000,5.000,1.230";
 111  0002 96            	ldw	x,sp
 112  0003 1c0002        	addw	x,#OFST-78
 113  0006 90ae0000      	ldw	y,#L3_writeData
 114  000a a625          	ld	a,#37
 115  000c cd0000        	call	c_xymov
 117                     ; 37   uint16_t startAddress = 0x0000;
 119  000f 5f            	clrw	x
 120  0010 1f4f          	ldw	(OFST-1,sp),x
 122                     ; 38   clock_setup ();
 124  0012 ad7d          	call	_clock_setup
 126                     ; 39   TIM4_Config ();
 128  0014 cd0000        	call	_TIM4_Config
 130                     ; 40   UART3_setup ();
 132  0017 ad48          	call	_UART3_setup
 134                     ; 41   GPIO_setup ();
 136  0019 cd00d6        	call	_GPIO_setup
 138                     ; 42   I2C_Configuration ();
 140  001c cd00f3        	call	_I2C_Configuration
 142                     ; 44   printf ("Starting:\n");
 144  001f ae0113        	ldw	x,#L54
 145  0022 cd0000        	call	_printf
 147                     ; 47   printf ("Writing string to EEPROM...\n");
 149  0025 ae00f6        	ldw	x,#L74
 150  0028 cd0000        	call	_printf
 152                     ; 48   EEPROM_WriteString (startAddress, writeData);
 154  002b 96            	ldw	x,sp
 155  002c 1c0002        	addw	x,#OFST-78
 156  002f 89            	pushw	x
 157  0030 1e51          	ldw	x,(OFST+1,sp)
 158  0032 cd027b        	call	_EEPROM_WriteString
 160  0035 85            	popw	x
 161                     ; 49   printf ("Write Complete.\n");
 163  0036 ae00e5        	ldw	x,#L15
 164  0039 cd0000        	call	_printf
 166                     ; 52   printf ("Reading string from EEPROM...\n");
 168  003c ae00c6        	ldw	x,#L35
 169  003f cd0000        	call	_printf
 171                     ; 53   delay_ms (10);
 173  0042 ae000a        	ldw	x,#10
 174  0045 cd0000        	call	_delay_ms
 176                     ; 54   EEPROM_ReadString (startAddress, readData);
 178  0048 96            	ldw	x,sp
 179  0049 1c0027        	addw	x,#OFST-41
 180  004c 89            	pushw	x
 181  004d 1e51          	ldw	x,(OFST+1,sp)
 182  004f cd01e2        	call	_EEPROM_ReadString
 184  0052 85            	popw	x
 185                     ; 55   printf ("Read Complete. Data: %s\n", readData);
 187  0053 96            	ldw	x,sp
 188  0054 1c0027        	addw	x,#OFST-41
 189  0057 89            	pushw	x
 190  0058 ae00ad        	ldw	x,#L55
 191  005b cd0000        	call	_printf
 193  005e 85            	popw	x
 194  005f               L75:
 196  005f 20fe          	jra	L75
 222                     ; 62 void UART3_setup (void)
 222                     ; 63 {
 223                     	switch	.text
 224  0061               _UART3_setup:
 228                     ; 64   UART3_DeInit ();
 230  0061 cd0000        	call	_UART3_DeInit
 232                     ; 67   UART3_Init (9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
 232                     ; 68               UART3_MODE_TX_ENABLE);
 234  0064 4b04          	push	#4
 235  0066 4b00          	push	#0
 236  0068 4b00          	push	#0
 237  006a 4b00          	push	#0
 238  006c ae2580        	ldw	x,#9600
 239  006f 89            	pushw	x
 240  0070 ae0000        	ldw	x,#0
 241  0073 89            	pushw	x
 242  0074 cd0000        	call	_UART3_Init
 244  0077 5b08          	addw	sp,#8
 245                     ; 70   UART3_Cmd (ENABLE); // Enable UART1
 247  0079 a601          	ld	a,#1
 248  007b cd0000        	call	_UART3_Cmd
 250                     ; 71 }
 253  007e 81            	ret
 289                     ; 73 PUTCHAR_PROTOTYPE{
 290                     	switch	.text
 291  007f               _putchar:
 293  007f 88            	push	a
 294       00000000      OFST:	set	0
 297                     ; 75   UART3_SendData8 (c);
 299  0080 cd0000        	call	_UART3_SendData8
 302  0083               L311:
 303                     ; 77   while (UART3_GetFlagStatus (UART3_FLAG_TXE) == RESET);
 305  0083 ae0080        	ldw	x,#128
 306  0086 cd0000        	call	_UART3_GetFlagStatus
 308  0089 4d            	tnz	a
 309  008a 27f7          	jreq	L311
 310                     ; 79   return (c);
 312  008c 7b01          	ld	a,(OFST+1,sp)
 315  008e 5b01          	addw	sp,#1
 316  0090 81            	ret
 349                     ; 82 void clock_setup (void)
 349                     ; 83 {
 350                     	switch	.text
 351  0091               _clock_setup:
 355                     ; 84   CLK_DeInit ();
 357  0091 cd0000        	call	_CLK_DeInit
 359                     ; 85   CLK_HSECmd (DISABLE);
 361  0094 4f            	clr	a
 362  0095 cd0000        	call	_CLK_HSECmd
 364                     ; 86   CLK_LSICmd (DISABLE);
 366  0098 4f            	clr	a
 367  0099 cd0000        	call	_CLK_LSICmd
 369                     ; 87   CLK_HSICmd (ENABLE);
 371  009c a601          	ld	a,#1
 372  009e cd0000        	call	_CLK_HSICmd
 375  00a1               L131:
 376                     ; 88   while (CLK_GetFlagStatus (CLK_FLAG_HSIRDY) == FALSE);
 378  00a1 ae0102        	ldw	x,#258
 379  00a4 cd0000        	call	_CLK_GetFlagStatus
 381  00a7 4d            	tnz	a
 382  00a8 27f7          	jreq	L131
 383                     ; 90   CLK_ClockSwitchCmd (ENABLE);
 385  00aa a601          	ld	a,#1
 386  00ac cd0000        	call	_CLK_ClockSwitchCmd
 388                     ; 91   CLK_HSIPrescalerConfig (CLK_PRESCALER_HSIDIV1);
 390  00af 4f            	clr	a
 391  00b0 cd0000        	call	_CLK_HSIPrescalerConfig
 393                     ; 92   CLK_SYSCLKConfig (CLK_PRESCALER_CPUDIV1);
 395  00b3 a680          	ld	a,#128
 396  00b5 cd0000        	call	_CLK_SYSCLKConfig
 398                     ; 94   CLK_ClockSwitchConfig (CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
 398                     ; 95                          CLK_CURRENTCLOCKSTATE_ENABLE);
 400  00b8 4b01          	push	#1
 401  00ba 4b00          	push	#0
 402  00bc ae01e1        	ldw	x,#481
 403  00bf cd0000        	call	_CLK_ClockSwitchConfig
 405  00c2 85            	popw	x
 406                     ; 97   CLK_PeripheralClockConfig (CLK_PERIPHERAL_TIMER4, ENABLE);
 408  00c3 ae0401        	ldw	x,#1025
 409  00c6 cd0000        	call	_CLK_PeripheralClockConfig
 411                     ; 98   CLK_PeripheralClockConfig (CLK_PERIPHERAL_UART3, ENABLE);
 413  00c9 ae0301        	ldw	x,#769
 414  00cc cd0000        	call	_CLK_PeripheralClockConfig
 416                     ; 99   CLK_PeripheralClockConfig (CLK_PERIPHERAL_I2C, ENABLE);
 418  00cf ae0001        	ldw	x,#1
 419  00d2 cd0000        	call	_CLK_PeripheralClockConfig
 421                     ; 103 }
 424  00d5 81            	ret
 449                     ; 105 void GPIO_setup (void)
 449                     ; 106 {
 450                     	switch	.text
 451  00d6               _GPIO_setup:
 455                     ; 107   GPIO_DeInit (GPIOE);
 457  00d6 ae5014        	ldw	x,#20500
 458  00d9 cd0000        	call	_GPIO_DeInit
 460                     ; 108   GPIO_Init (GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
 462  00dc 4bb0          	push	#176
 463  00de 4b02          	push	#2
 464  00e0 ae5014        	ldw	x,#20500
 465  00e3 cd0000        	call	_GPIO_Init
 467  00e6 85            	popw	x
 468                     ; 109   GPIO_Init (GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
 470  00e7 4bb0          	push	#176
 471  00e9 4b04          	push	#4
 472  00eb ae5014        	ldw	x,#20500
 473  00ee cd0000        	call	_GPIO_Init
 475  00f1 85            	popw	x
 476                     ; 110 }
 479  00f2 81            	ret
 505                     ; 112 void I2C_Configuration (void)
 505                     ; 113 {
 506                     	switch	.text
 507  00f3               _I2C_Configuration:
 511                     ; 114   I2C_DeInit (); // Reset I2C to default state
 513  00f3 cd0000        	call	_I2C_DeInit
 515                     ; 117   I2C_Init (
 515                     ; 118             100000, // I2C clock frequency (100kHz)
 515                     ; 119             0x00, // Own address (not required for master mode)
 515                     ; 120             I2C_DUTYCYCLE_2, // Fast mode Tlow/Thigh = 2
 515                     ; 121             I2C_ACK_CURR, // Enable ACK for current byte
 515                     ; 122             I2C_ADDMODE_7BIT, // 7-bit addressing mode
 515                     ; 123             16 // Input clock frequency in MHz (adjust as per your system clock)
 515                     ; 124             );
 517  00f6 4b10          	push	#16
 518  00f8 4b00          	push	#0
 519  00fa 4b01          	push	#1
 520  00fc 4b00          	push	#0
 521  00fe 5f            	clrw	x
 522  00ff 89            	pushw	x
 523  0100 ae86a0        	ldw	x,#34464
 524  0103 89            	pushw	x
 525  0104 ae0001        	ldw	x,#1
 526  0107 89            	pushw	x
 527  0108 cd0000        	call	_I2C_Init
 529  010b 5b0a          	addw	sp,#10
 530                     ; 125   I2C_Cmd (ENABLE); // Enable the I2C peripheral
 532  010d a601          	ld	a,#1
 533  010f cd0000        	call	_I2C_Cmd
 535                     ; 126 }
 538  0112 81            	ret
 587                     ; 128 void EEPROM_WriteByte (uint16_t memoryAddress, uint8_t data)
 587                     ; 129 {
 588                     	switch	.text
 589  0113               _EEPROM_WriteByte:
 591  0113 89            	pushw	x
 592       00000000      OFST:	set	0
 595                     ; 131   I2C_GenerateSTART (ENABLE);
 597  0114 a601          	ld	a,#1
 598  0116 cd0000        	call	_I2C_GenerateSTART
 601  0119               L102:
 602                     ; 132   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 604  0119 ae0301        	ldw	x,#769
 605  011c cd0000        	call	_I2C_CheckEvent
 607  011f 4d            	tnz	a
 608  0120 27f7          	jreq	L102
 609                     ; 134   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 611  0122 aea000        	ldw	x,#40960
 612  0125 cd0000        	call	_I2C_Send7bitAddress
 615  0128               L702:
 616                     ; 135   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 618  0128 ae0782        	ldw	x,#1922
 619  012b cd0000        	call	_I2C_CheckEvent
 621  012e 4d            	tnz	a
 622  012f 27f7          	jreq	L702
 623                     ; 137   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 625  0131 7b01          	ld	a,(OFST+1,sp)
 626  0133 cd0000        	call	_I2C_SendData
 629  0136               L512:
 630                     ; 138   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 632  0136 ae0784        	ldw	x,#1924
 633  0139 cd0000        	call	_I2C_CheckEvent
 635  013c 4d            	tnz	a
 636  013d 27f7          	jreq	L512
 637                     ; 140   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 639  013f 7b02          	ld	a,(OFST+2,sp)
 640  0141 a4ff          	and	a,#255
 641  0143 cd0000        	call	_I2C_SendData
 644  0146               L322:
 645                     ; 141   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 647  0146 ae0784        	ldw	x,#1924
 648  0149 cd0000        	call	_I2C_CheckEvent
 650  014c 4d            	tnz	a
 651  014d 27f7          	jreq	L322
 652                     ; 143   I2C_SendData (data);
 654  014f 7b05          	ld	a,(OFST+5,sp)
 655  0151 cd0000        	call	_I2C_SendData
 658  0154               L132:
 659                     ; 144   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 661  0154 ae0784        	ldw	x,#1924
 662  0157 cd0000        	call	_I2C_CheckEvent
 664  015a 4d            	tnz	a
 665  015b 27f7          	jreq	L132
 666                     ; 146   I2C_GenerateSTOP (ENABLE);
 668  015d a601          	ld	a,#1
 669  015f cd0000        	call	_I2C_GenerateSTOP
 671                     ; 147   delay_ms (5);
 673  0162 ae0005        	ldw	x,#5
 674  0165 cd0000        	call	_delay_ms
 676                     ; 148 }
 679  0168 85            	popw	x
 680  0169 81            	ret
 739                     ; 150 uint8_t EEPROM_ReadByte (uint16_t memoryAddress)
 739                     ; 151 {
 740                     	switch	.text
 741  016a               _EEPROM_ReadByte:
 743  016a 89            	pushw	x
 744  016b 89            	pushw	x
 745       00000002      OFST:	set	2
 748                     ; 153   uint8_t i = 0;
 750                     ; 155   I2C_GenerateSTART (ENABLE);
 752  016c a601          	ld	a,#1
 753  016e cd0000        	call	_I2C_GenerateSTART
 756  0171               L562:
 757                     ; 156   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 759  0171 ae0301        	ldw	x,#769
 760  0174 cd0000        	call	_I2C_CheckEvent
 762  0177 4d            	tnz	a
 763  0178 27f7          	jreq	L562
 764                     ; 158   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 766  017a aea000        	ldw	x,#40960
 767  017d cd0000        	call	_I2C_Send7bitAddress
 770  0180               L372:
 771                     ; 159   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 773  0180 ae0782        	ldw	x,#1922
 774  0183 cd0000        	call	_I2C_CheckEvent
 776  0186 4d            	tnz	a
 777  0187 27f7          	jreq	L372
 778                     ; 161   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 780  0189 7b03          	ld	a,(OFST+1,sp)
 781  018b cd0000        	call	_I2C_SendData
 784  018e               L103:
 785                     ; 162   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 787  018e ae0784        	ldw	x,#1924
 788  0191 cd0000        	call	_I2C_CheckEvent
 790  0194 4d            	tnz	a
 791  0195 27f7          	jreq	L103
 792                     ; 164   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 794  0197 7b04          	ld	a,(OFST+2,sp)
 795  0199 a4ff          	and	a,#255
 796  019b cd0000        	call	_I2C_SendData
 799  019e               L703:
 800                     ; 165   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 802  019e ae0784        	ldw	x,#1924
 803  01a1 cd0000        	call	_I2C_CheckEvent
 805  01a4 4d            	tnz	a
 806  01a5 27f7          	jreq	L703
 807                     ; 168   I2C_GenerateSTART (ENABLE);
 809  01a7 a601          	ld	a,#1
 810  01a9 cd0000        	call	_I2C_GenerateSTART
 813  01ac               L513:
 814                     ; 169   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 816  01ac ae0301        	ldw	x,#769
 817  01af cd0000        	call	_I2C_CheckEvent
 819  01b2 4d            	tnz	a
 820  01b3 27f7          	jreq	L513
 821                     ; 171   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
 823  01b5 aea101        	ldw	x,#41217
 824  01b8 cd0000        	call	_I2C_Send7bitAddress
 827  01bb               L323:
 828                     ; 172   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
 830  01bb ae0302        	ldw	x,#770
 831  01be cd0000        	call	_I2C_CheckEvent
 833  01c1 4d            	tnz	a
 834  01c2 27f7          	jreq	L323
 836  01c4               L133:
 837                     ; 174   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED) == ERROR);
 839  01c4 ae0340        	ldw	x,#832
 840  01c7 cd0000        	call	_I2C_CheckEvent
 842  01ca 4d            	tnz	a
 843  01cb 27f7          	jreq	L133
 844                     ; 175   receivedData = I2C_ReceiveData ();
 846  01cd cd0000        	call	_I2C_ReceiveData
 848  01d0 6b02          	ld	(OFST+0,sp),a
 850                     ; 177   I2C_GenerateSTOP (ENABLE);
 852  01d2 a601          	ld	a,#1
 853  01d4 cd0000        	call	_I2C_GenerateSTOP
 855                     ; 178   delay_ms (5);
 857  01d7 ae0005        	ldw	x,#5
 858  01da cd0000        	call	_delay_ms
 860                     ; 179   return receivedData;
 862  01dd 7b02          	ld	a,(OFST+0,sp)
 865  01df 5b04          	addw	sp,#4
 866  01e1 81            	ret
 945                     ; 182 void EEPROM_ReadString (uint16_t memoryAddress, char* buffer)
 945                     ; 183 {
 946                     	switch	.text
 947  01e2               _EEPROM_ReadString:
 949  01e2 89            	pushw	x
 950  01e3 5203          	subw	sp,#3
 951       00000003      OFST:	set	3
 954                     ; 184   uint8_t tempData = 0;
 956                     ; 185   uint8_t i = 0;
 958  01e5 0f03          	clr	(OFST+0,sp)
 960                     ; 187   I2C_GenerateSTART (ENABLE);
 962  01e7 a601          	ld	a,#1
 963  01e9 cd0000        	call	_I2C_GenerateSTART
 966  01ec               L573:
 967                     ; 188   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 969  01ec ae0301        	ldw	x,#769
 970  01ef cd0000        	call	_I2C_CheckEvent
 972  01f2 4d            	tnz	a
 973  01f3 27f7          	jreq	L573
 974                     ; 190   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 976  01f5 aea000        	ldw	x,#40960
 977  01f8 cd0000        	call	_I2C_Send7bitAddress
 980  01fb               L304:
 981                     ; 191   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 983  01fb ae0782        	ldw	x,#1922
 984  01fe cd0000        	call	_I2C_CheckEvent
 986  0201 4d            	tnz	a
 987  0202 27f7          	jreq	L304
 988                     ; 193   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 990  0204 7b04          	ld	a,(OFST+1,sp)
 991  0206 cd0000        	call	_I2C_SendData
 994  0209               L114:
 995                     ; 194   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 997  0209 ae0784        	ldw	x,#1924
 998  020c cd0000        	call	_I2C_CheckEvent
1000  020f 4d            	tnz	a
1001  0210 27f7          	jreq	L114
1002                     ; 196   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
1004  0212 7b05          	ld	a,(OFST+2,sp)
1005  0214 a4ff          	and	a,#255
1006  0216 cd0000        	call	_I2C_SendData
1009  0219               L714:
1010                     ; 197   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
1012  0219 ae0784        	ldw	x,#1924
1013  021c cd0000        	call	_I2C_CheckEvent
1015  021f 4d            	tnz	a
1016  0220 27f7          	jreq	L714
1017                     ; 200   I2C_GenerateSTART (ENABLE);
1019  0222 a601          	ld	a,#1
1020  0224 cd0000        	call	_I2C_GenerateSTART
1023  0227               L524:
1024                     ; 201   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
1026  0227 ae0301        	ldw	x,#769
1027  022a cd0000        	call	_I2C_CheckEvent
1029  022d 4d            	tnz	a
1030  022e 27f7          	jreq	L524
1031                     ; 203   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
1033  0230 aea101        	ldw	x,#41217
1034  0233 cd0000        	call	_I2C_Send7bitAddress
1037  0236               L334:
1038                     ; 204   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
1040  0236 ae0302        	ldw	x,#770
1041  0239 cd0000        	call	_I2C_CheckEvent
1043  023c 4d            	tnz	a
1044  023d 27f7          	jreq	L334
1045  023f               L734:
1046                     ; 207     if (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED))
1048  023f ae0340        	ldw	x,#832
1049  0242 cd0000        	call	_I2C_CheckEvent
1051  0245 4d            	tnz	a
1052  0246 27f7          	jreq	L734
1053                     ; 209       uint8_t tempData = I2C_ReceiveData ();
1055  0248 cd0000        	call	_I2C_ReceiveData
1057  024b 6b01          	ld	(OFST-2,sp),a
1059                     ; 210       if (tempData == '\0')
1061  024d 0d01          	tnz	(OFST-2,sp)
1062  024f 261a          	jrne	L544
1063                     ; 212         I2C_AcknowledgeConfig (I2C_ACK_NONE);
1065  0251 4f            	clr	a
1066  0252 cd0000        	call	_I2C_AcknowledgeConfig
1068                     ; 213         I2C_GenerateSTOP (ENABLE);
1070  0255 a601          	ld	a,#1
1071  0257 cd0000        	call	_I2C_GenerateSTOP
1073                     ; 214         break;
1074                     ; 220   buffer[i] = '\0';
1076  025a 7b03          	ld	a,(OFST+0,sp)
1077  025c 5f            	clrw	x
1078  025d 97            	ld	xl,a
1079  025e 72fb08        	addw	x,(OFST+5,sp)
1080  0261 7f            	clr	(x)
1081                     ; 222   delay_ms (5);
1083  0262 ae0005        	ldw	x,#5
1084  0265 cd0000        	call	_delay_ms
1086                     ; 223 }
1089  0268 5b05          	addw	sp,#5
1090  026a 81            	ret
1091  026b               L544:
1092                     ; 217         buffer[i++] = tempData;
1094  026b 7b03          	ld	a,(OFST+0,sp)
1095  026d 97            	ld	xl,a
1096  026e 0c03          	inc	(OFST+0,sp)
1098  0270 9f            	ld	a,xl
1099  0271 5f            	clrw	x
1100  0272 97            	ld	xl,a
1101  0273 72fb08        	addw	x,(OFST+5,sp)
1102  0276 7b01          	ld	a,(OFST-2,sp)
1103  0278 f7            	ld	(x),a
1104  0279 20c4          	jra	L734
1149                     ; 225 void EEPROM_WriteString (uint16_t memoryAddress, char *data)
1149                     ; 226 {
1150                     	switch	.text
1151  027b               _EEPROM_WriteString:
1153  027b 89            	pushw	x
1154       00000000      OFST:	set	0
1157  027c 2018          	jra	L574
1158  027e               L374:
1159                     ; 229     EEPROM_WriteByte (memoryAddress, *data); // Write one character to EEPROM
1161  027e 1e05          	ldw	x,(OFST+5,sp)
1162  0280 f6            	ld	a,(x)
1163  0281 88            	push	a
1164  0282 1e02          	ldw	x,(OFST+2,sp)
1165  0284 cd0113        	call	_EEPROM_WriteByte
1167  0287 84            	pop	a
1168                     ; 230     memoryAddress++; // Increment the address to write the next character
1170  0288 1e01          	ldw	x,(OFST+1,sp)
1171  028a 1c0001        	addw	x,#1
1172  028d 1f01          	ldw	(OFST+1,sp),x
1173                     ; 231     data++; // Move to the next character in the string
1175  028f 1e05          	ldw	x,(OFST+5,sp)
1176  0291 1c0001        	addw	x,#1
1177  0294 1f05          	ldw	(OFST+5,sp),x
1178  0296               L574:
1179                     ; 227   while (*data)
1181  0296 1e05          	ldw	x,(OFST+5,sp)
1182  0298 7d            	tnz	(x)
1183  0299 26e3          	jrne	L374
1184                     ; 234   EEPROM_WriteByte (memoryAddress, '\0');
1186  029b 4b00          	push	#0
1187  029d 1e02          	ldw	x,(OFST+2,sp)
1188  029f cd0113        	call	_EEPROM_WriteByte
1190  02a2 84            	pop	a
1191                     ; 235 }
1194  02a3 85            	popw	x
1195  02a4 81            	ret
1242                     ; 237 void EEPROM_LogData(const char *data)
1242                     ; 238 {
1243                     	switch	.text
1244  02a5               _EEPROM_LogData:
1246  02a5 89            	pushw	x
1247  02a6 89            	pushw	x
1248       00000002      OFST:	set	2
1251                     ; 239 	uint16_t memoryAddress = writePointer; // Start writing at the current write pointer
1253  02a7 be00          	ldw	x,_writePointer
1254  02a9 1f01          	ldw	(OFST-1,sp),x
1256                     ; 242 	EEPROM_WriteString(memoryAddress, data);
1258  02ab 1e03          	ldw	x,(OFST+1,sp)
1259  02ad 89            	pushw	x
1260  02ae 1e03          	ldw	x,(OFST+1,sp)
1261  02b0 adc9          	call	_EEPROM_WriteString
1263  02b2 85            	popw	x
1264                     ; 245 	writePointer += LOG_ENTRY_SIZE;
1266  02b3 be00          	ldw	x,_writePointer
1267  02b5 1c0025        	addw	x,#37
1268  02b8 bf00          	ldw	_writePointer,x
1269                     ; 248 	if (writePointer >= EEPROM_SIZE)
1271  02ba be00          	ldw	x,_writePointer
1272  02bc a37d00        	cpw	x,#32000
1273  02bf 2503          	jrult	L325
1274                     ; 250 			writePointer = EEPROM_START_ADDRESS;
1276  02c1 5f            	clrw	x
1277  02c2 bf00          	ldw	_writePointer,x
1278  02c4               L325:
1279                     ; 253 	printf("Data Logged: %s at address: 0x%04X\n", data, memoryAddress);
1281  02c4 1e01          	ldw	x,(OFST-1,sp)
1282  02c6 89            	pushw	x
1283  02c7 1e05          	ldw	x,(OFST+3,sp)
1284  02c9 89            	pushw	x
1285  02ca ae0089        	ldw	x,#L525
1286  02cd cd0000        	call	_printf
1288  02d0 5b04          	addw	sp,#4
1289                     ; 254 }
1292  02d2 5b04          	addw	sp,#4
1293  02d4 81            	ret
1340                     ; 256 void EEPROM_Init(uint8_t defaultValue)
1340                     ; 257 {
1341                     	switch	.text
1342  02d5               _EEPROM_Init:
1344  02d5 88            	push	a
1345  02d6 89            	pushw	x
1346       00000002      OFST:	set	2
1349                     ; 258 	uint16_t address = 0;
1351                     ; 259 	for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
1353  02d7 5f            	clrw	x
1354  02d8 1f01          	ldw	(OFST-1,sp),x
1356  02da               L155:
1357                     ; 261 			EEPROM_WriteByte(address, defaultValue);
1359  02da 7b03          	ld	a,(OFST+1,sp)
1360  02dc 88            	push	a
1361  02dd 1e02          	ldw	x,(OFST+0,sp)
1362  02df cd0113        	call	_EEPROM_WriteByte
1364  02e2 84            	pop	a
1365                     ; 262 			delay_ms(5); // Ensure write delay
1367  02e3 ae0005        	ldw	x,#5
1368  02e6 cd0000        	call	_delay_ms
1370                     ; 259 	for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
1372  02e9 1e01          	ldw	x,(OFST-1,sp)
1373  02eb 1c0001        	addw	x,#1
1374  02ee 1f01          	ldw	(OFST-1,sp),x
1378  02f0 1e01          	ldw	x,(OFST-1,sp)
1379  02f2 a37d00        	cpw	x,#32000
1380  02f5 25e3          	jrult	L155
1381                     ; 264 	writePointer = EEPROM_START_ADDRESS; // Reset pointer
1383  02f7 5f            	clrw	x
1384  02f8 bf00          	ldw	_writePointer,x
1385                     ; 265 	printf("EEPROM Initialized. All values set to: 0x%02X\n", defaultValue);
1387  02fa 7b03          	ld	a,(OFST+1,sp)
1388  02fc 88            	push	a
1389  02fd ae005a        	ldw	x,#L755
1390  0300 cd0000        	call	_printf
1392  0303 84            	pop	a
1393                     ; 266 }
1396  0304 5b03          	addw	sp,#3
1397  0306 81            	ret
1453                     ; 268 void EEPROM_Test (void)
1453                     ; 269 {
1454                     	switch	.text
1455  0307               _EEPROM_Test:
1457  0307 5204          	subw	sp,#4
1458       00000004      OFST:	set	4
1461                     ; 270   uint16_t memoryAddress = 0x0000; // EEPROM memory address to write/read
1463  0309 5f            	clrw	x
1464  030a 1f02          	ldw	(OFST-2,sp),x
1466                     ; 271   uint8_t dataToWrite = 0xAB; // Data to write
1468  030c a6ab          	ld	a,#171
1469  030e 6b04          	ld	(OFST+0,sp),a
1471                     ; 274   I2C_Configuration (); // Initialize I2C peripheral
1473  0310 cd00f3        	call	_I2C_Configuration
1475                     ; 277   EEPROM_WriteByte (memoryAddress, dataToWrite);
1477  0313 7b04          	ld	a,(OFST+0,sp)
1478  0315 88            	push	a
1479  0316 1e03          	ldw	x,(OFST-1,sp)
1480  0318 cd0113        	call	_EEPROM_WriteByte
1482  031b 84            	pop	a
1483                     ; 278   printf ("Writing Finished\n");
1485  031c ae0048        	ldw	x,#L706
1486  031f cd0000        	call	_printf
1488                     ; 281   printf ("Reading Starting\n");
1490  0322 ae0036        	ldw	x,#L116
1491  0325 cd0000        	call	_printf
1493                     ; 283   dataRead = EEPROM_ReadByte (memoryAddress);
1495  0328 1e02          	ldw	x,(OFST-2,sp)
1496  032a cd016a        	call	_EEPROM_ReadByte
1498  032d 6b01          	ld	(OFST-3,sp),a
1500                     ; 286   if (dataRead == dataToWrite)
1502  032f 7b01          	ld	a,(OFST-3,sp)
1503  0331 1104          	cp	a,(OFST+0,sp)
1504  0333 2608          	jrne	L316
1505                     ; 288     printf ("Success");
1507  0335 ae002e        	ldw	x,#L516
1508  0338 cd0000        	call	_printf
1511  033b 2006          	jra	L716
1512  033d               L316:
1513                     ; 292     printf ("YOU FAIL");
1515  033d ae0025        	ldw	x,#L126
1516  0340 cd0000        	call	_printf
1518  0343               L716:
1519                     ; 294 }
1522  0343 5b04          	addw	sp,#4
1523  0345 81            	ret
1547                     	xdef	_main
1548                     	xdef	_EEPROM_Test
1549                     	xdef	_EEPROM_Init
1550                     	xdef	_EEPROM_LogData
1551                     	xdef	_EEPROM_WriteString
1552                     	xdef	_EEPROM_ReadString
1553                     	xdef	_EEPROM_ReadByte
1554                     	xdef	_EEPROM_WriteByte
1555                     	xdef	_I2C_Configuration
1556                     	xdef	_GPIO_setup
1557                     	xdef	_UART3_setup
1558                     	xdef	_clock_setup
1559                     	xdef	_writePointer
1560                     	xref	_delay_ms
1561                     	xref	_TIM4_Config
1562                     	xdef	_putchar
1563                     	xref	_printf
1564                     	xref	_UART3_GetFlagStatus
1565                     	xref	_UART3_SendData8
1566                     	xref	_UART3_Cmd
1567                     	xref	_UART3_Init
1568                     	xref	_UART3_DeInit
1569                     	xref	_I2C_CheckEvent
1570                     	xref	_I2C_SendData
1571                     	xref	_I2C_Send7bitAddress
1572                     	xref	_I2C_ReceiveData
1573                     	xref	_I2C_AcknowledgeConfig
1574                     	xref	_I2C_GenerateSTOP
1575                     	xref	_I2C_GenerateSTART
1576                     	xref	_I2C_Cmd
1577                     	xref	_I2C_Init
1578                     	xref	_I2C_DeInit
1579                     	xref	_GPIO_Init
1580                     	xref	_GPIO_DeInit
1581                     	xref	_CLK_GetFlagStatus
1582                     	xref	_CLK_SYSCLKConfig
1583                     	xref	_CLK_HSIPrescalerConfig
1584                     	xref	_CLK_ClockSwitchConfig
1585                     	xref	_CLK_PeripheralClockConfig
1586                     	xref	_CLK_ClockSwitchCmd
1587                     	xref	_CLK_LSICmd
1588                     	xref	_CLK_HSICmd
1589                     	xref	_CLK_HSECmd
1590                     	xref	_CLK_DeInit
1591                     	switch	.const
1592  0025               L126:
1593  0025 594f55204641  	dc.b	"YOU FAIL",0
1594  002e               L516:
1595  002e 537563636573  	dc.b	"Success",0
1596  0036               L116:
1597  0036 52656164696e  	dc.b	"Reading Starting",10,0
1598  0048               L706:
1599  0048 57726974696e  	dc.b	"Writing Finished",10,0
1600  005a               L755:
1601  005a 454550524f4d  	dc.b	"EEPROM Initialized"
1602  006c 2e20416c6c20  	dc.b	". All values set t"
1603  007e 6f3a20307825  	dc.b	"o: 0x%02X",10,0
1604  0089               L525:
1605  0089 44617461204c  	dc.b	"Data Logged: %s at"
1606  009b 206164647265  	dc.b	" address: 0x%04X",10,0
1607  00ad               L55:
1608  00ad 526561642043  	dc.b	"Read Complete. Dat"
1609  00bf 613a2025730a  	dc.b	"a: %s",10,0
1610  00c6               L35:
1611  00c6 52656164696e  	dc.b	"Reading string fro"
1612  00d8 6d2045455052  	dc.b	"m EEPROM...",10,0
1613  00e5               L15:
1614  00e5 577269746520  	dc.b	"Write Complete.",10,0
1615  00f6               L74:
1616  00f6 57726974696e  	dc.b	"Writing string to "
1617  0108 454550524f4d  	dc.b	"EEPROM...",10,0
1618  0113               L54:
1619  0113 537461727469  	dc.b	"Starting:",10,0
1620                     	xref.b	c_x
1640                     	xref	c_xymov
1641                     	end
