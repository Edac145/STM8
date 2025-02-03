   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  17                     	bsct
  18  0000               _writePointer:
  19  0000 0000          	dc.w	0
  54                     ; 5 void EEPROM_Config (void)
  54                     ; 6 { 
  55                     	switch	.text
  56  0000               f_EEPROM_Config:
  60                     ; 7   CLK_PeripheralClockConfig (CLK_PERIPHERAL_I2C, ENABLE);
  62  0000 ae0001        	ldw	x,#1
  63  0003 8d000000      	callf	f_CLK_PeripheralClockConfig
  65                     ; 8   GPIO_DeInit (GPIOE);
  67  0007 ae5014        	ldw	x,#20500
  68  000a 8d000000      	callf	f_GPIO_DeInit
  70                     ; 9   GPIO_Init (GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
  72  000e 4bb0          	push	#176
  73  0010 4b02          	push	#2
  74  0012 ae5014        	ldw	x,#20500
  75  0015 8d000000      	callf	f_GPIO_Init
  77  0019 85            	popw	x
  78                     ; 10   GPIO_Init (GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
  80  001a 4bb0          	push	#176
  81  001c 4b04          	push	#4
  82  001e ae5014        	ldw	x,#20500
  83  0021 8d000000      	callf	f_GPIO_Init
  85  0025 85            	popw	x
  86                     ; 11   I2C_DeInit (); // Reset I2C to default state
  88  0026 8d000000      	callf	f_I2C_DeInit
  90                     ; 14   I2C_Init (
  90                     ; 15             100000, // I2C clock frequency (100kHz)
  90                     ; 16             0x00, // Own address (not required for master mode)
  90                     ; 17             I2C_DUTYCYCLE_2, // Fast mode Tlow/Thigh = 2
  90                     ; 18             I2C_ACK_CURR, // Enable ACK for current byte
  90                     ; 19             I2C_ADDMODE_7BIT, // 7-bit addressing mode
  90                     ; 20             16 // Input clock frequency in MHz (adjust as per your system clock)
  90                     ; 21             );
  92  002a 4b10          	push	#16
  93  002c 4b00          	push	#0
  94  002e 4b01          	push	#1
  95  0030 4b00          	push	#0
  96  0032 5f            	clrw	x
  97  0033 89            	pushw	x
  98  0034 ae86a0        	ldw	x,#34464
  99  0037 89            	pushw	x
 100  0038 ae0001        	ldw	x,#1
 101  003b 89            	pushw	x
 102  003c 8d000000      	callf	f_I2C_Init
 104  0040 5b0a          	addw	sp,#10
 105                     ; 22   I2C_Cmd (ENABLE); // Enable the I2C peripheral
 107  0042 a601          	ld	a,#1
 109                     ; 23 }
 112  0044 ac000000      	jpf	f_I2C_Cmd
 160                     ; 25 void EEPROM_WriteByte (uint16_t memoryAddress, uint8_t data)
 160                     ; 26 {
 161                     	switch	.text
 162  0048               f_EEPROM_WriteByte:
 164  0048 89            	pushw	x
 165       00000000      OFST:	set	0
 168                     ; 28   I2C_GenerateSTART (ENABLE);
 170  0049 a601          	ld	a,#1
 171  004b 8d000000      	callf	f_I2C_GenerateSTART
 174  004f               L54:
 175                     ; 29   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 177  004f ae0301        	ldw	x,#769
 178  0052 8d000000      	callf	f_I2C_CheckEvent
 180  0056 4d            	tnz	a
 181  0057 27f6          	jreq	L54
 182                     ; 31   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 184  0059 aea000        	ldw	x,#40960
 185  005c 8d000000      	callf	f_I2C_Send7bitAddress
 188  0060               L35:
 189                     ; 32   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 191  0060 ae0782        	ldw	x,#1922
 192  0063 8d000000      	callf	f_I2C_CheckEvent
 194  0067 4d            	tnz	a
 195  0068 27f6          	jreq	L35
 196                     ; 34   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 198  006a 7b01          	ld	a,(OFST+1,sp)
 199  006c 8d000000      	callf	f_I2C_SendData
 202  0070               L16:
 203                     ; 35   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 205  0070 ae0784        	ldw	x,#1924
 206  0073 8d000000      	callf	f_I2C_CheckEvent
 208  0077 4d            	tnz	a
 209  0078 27f6          	jreq	L16
 210                     ; 37   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 212  007a 7b02          	ld	a,(OFST+2,sp)
 213  007c 8d000000      	callf	f_I2C_SendData
 216  0080               L76:
 217                     ; 38   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 219  0080 ae0784        	ldw	x,#1924
 220  0083 8d000000      	callf	f_I2C_CheckEvent
 222  0087 4d            	tnz	a
 223  0088 27f6          	jreq	L76
 224                     ; 40   I2C_SendData (data);
 226  008a 7b06          	ld	a,(OFST+6,sp)
 227  008c 8d000000      	callf	f_I2C_SendData
 230  0090               L57:
 231                     ; 41   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 233  0090 ae0784        	ldw	x,#1924
 234  0093 8d000000      	callf	f_I2C_CheckEvent
 236  0097 4d            	tnz	a
 237  0098 27f6          	jreq	L57
 238                     ; 43   I2C_GenerateSTOP (ENABLE);
 240  009a a601          	ld	a,#1
 241  009c 8d000000      	callf	f_I2C_GenerateSTOP
 243                     ; 44   delay_ms (5);
 245  00a0 ae0005        	ldw	x,#5
 246  00a3 8d000000      	callf	f_delay_ms
 248                     ; 45 }
 251  00a7 85            	popw	x
 252  00a8 87            	retf	
 310                     ; 47 uint8_t EEPROM_ReadByte (uint16_t memoryAddress)
 310                     ; 48 {
 311                     	switch	.text
 312  00a9               f_EEPROM_ReadByte:
 314  00a9 89            	pushw	x
 315  00aa 89            	pushw	x
 316       00000002      OFST:	set	2
 319                     ; 50   uint8_t i = 0;
 321                     ; 52   I2C_GenerateSTART (ENABLE);
 323  00ab a601          	ld	a,#1
 324  00ad 8d000000      	callf	f_I2C_GenerateSTART
 327  00b1               L131:
 328                     ; 53   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 330  00b1 ae0301        	ldw	x,#769
 331  00b4 8d000000      	callf	f_I2C_CheckEvent
 333  00b8 4d            	tnz	a
 334  00b9 27f6          	jreq	L131
 335                     ; 55   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 337  00bb aea000        	ldw	x,#40960
 338  00be 8d000000      	callf	f_I2C_Send7bitAddress
 341  00c2               L731:
 342                     ; 56   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 344  00c2 ae0782        	ldw	x,#1922
 345  00c5 8d000000      	callf	f_I2C_CheckEvent
 347  00c9 4d            	tnz	a
 348  00ca 27f6          	jreq	L731
 349                     ; 58   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 351  00cc 7b03          	ld	a,(OFST+1,sp)
 352  00ce 8d000000      	callf	f_I2C_SendData
 355  00d2               L541:
 356                     ; 59   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 358  00d2 ae0784        	ldw	x,#1924
 359  00d5 8d000000      	callf	f_I2C_CheckEvent
 361  00d9 4d            	tnz	a
 362  00da 27f6          	jreq	L541
 363                     ; 61   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 365  00dc 7b04          	ld	a,(OFST+2,sp)
 366  00de 8d000000      	callf	f_I2C_SendData
 369  00e2               L351:
 370                     ; 62   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 372  00e2 ae0784        	ldw	x,#1924
 373  00e5 8d000000      	callf	f_I2C_CheckEvent
 375  00e9 4d            	tnz	a
 376  00ea 27f6          	jreq	L351
 377                     ; 65   I2C_GenerateSTART (ENABLE);
 379  00ec a601          	ld	a,#1
 380  00ee 8d000000      	callf	f_I2C_GenerateSTART
 383  00f2               L161:
 384                     ; 66   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 386  00f2 ae0301        	ldw	x,#769
 387  00f5 8d000000      	callf	f_I2C_CheckEvent
 389  00f9 4d            	tnz	a
 390  00fa 27f6          	jreq	L161
 391                     ; 68   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
 393  00fc aea101        	ldw	x,#41217
 394  00ff 8d000000      	callf	f_I2C_Send7bitAddress
 397  0103               L761:
 398                     ; 69   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
 400  0103 ae0302        	ldw	x,#770
 401  0106 8d000000      	callf	f_I2C_CheckEvent
 403  010a 4d            	tnz	a
 404  010b 27f6          	jreq	L761
 406  010d               L571:
 407                     ; 71   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED) == ERROR);
 409  010d ae0340        	ldw	x,#832
 410  0110 8d000000      	callf	f_I2C_CheckEvent
 412  0114 4d            	tnz	a
 413  0115 27f6          	jreq	L571
 414                     ; 72   receivedData = I2C_ReceiveData ();
 416  0117 8d000000      	callf	f_I2C_ReceiveData
 418  011b 6b02          	ld	(OFST+0,sp),a
 420                     ; 74   I2C_GenerateSTOP (ENABLE);
 422  011d a601          	ld	a,#1
 423  011f 8d000000      	callf	f_I2C_GenerateSTOP
 425                     ; 75   delay_ms (5);
 427  0123 ae0005        	ldw	x,#5
 428  0126 8d000000      	callf	f_delay_ms
 430                     ; 76   return receivedData;
 432  012a 7b02          	ld	a,(OFST+0,sp)
 435  012c 5b04          	addw	sp,#4
 436  012e 87            	retf	
 515                     ; 79 char* EEPROM_ReadString (uint16_t memoryAddress, char* buffer)  //Changed from no return to char*
 515                     ; 80 {
 516                     	switch	.text
 517  012f               f_EEPROM_ReadString:
 519  012f 89            	pushw	x
 520  0130 5203          	subw	sp,#3
 521       00000003      OFST:	set	3
 524                     ; 81   uint8_t tempData = 0;
 526                     ; 82   uint8_t i = 0;
 528  0132 0f03          	clr	(OFST+0,sp)
 530                     ; 84   I2C_GenerateSTART (ENABLE);
 532  0134 a601          	ld	a,#1
 533  0136 8d000000      	callf	f_I2C_GenerateSTART
 536  013a               L142:
 537                     ; 85   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 539  013a ae0301        	ldw	x,#769
 540  013d 8d000000      	callf	f_I2C_CheckEvent
 542  0141 4d            	tnz	a
 543  0142 27f6          	jreq	L142
 544                     ; 87   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 546  0144 aea000        	ldw	x,#40960
 547  0147 8d000000      	callf	f_I2C_Send7bitAddress
 550  014b               L742:
 551                     ; 88   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 553  014b ae0782        	ldw	x,#1922
 554  014e 8d000000      	callf	f_I2C_CheckEvent
 556  0152 4d            	tnz	a
 557  0153 27f6          	jreq	L742
 558                     ; 90   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 560  0155 7b04          	ld	a,(OFST+1,sp)
 561  0157 8d000000      	callf	f_I2C_SendData
 564  015b               L552:
 565                     ; 91   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 567  015b ae0784        	ldw	x,#1924
 568  015e 8d000000      	callf	f_I2C_CheckEvent
 570  0162 4d            	tnz	a
 571  0163 27f6          	jreq	L552
 572                     ; 93   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 574  0165 7b05          	ld	a,(OFST+2,sp)
 575  0167 8d000000      	callf	f_I2C_SendData
 578  016b               L362:
 579                     ; 94   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 581  016b ae0784        	ldw	x,#1924
 582  016e 8d000000      	callf	f_I2C_CheckEvent
 584  0172 4d            	tnz	a
 585  0173 27f6          	jreq	L362
 586                     ; 97   I2C_GenerateSTART (ENABLE);
 588  0175 a601          	ld	a,#1
 589  0177 8d000000      	callf	f_I2C_GenerateSTART
 592  017b               L172:
 593                     ; 98   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 595  017b ae0301        	ldw	x,#769
 596  017e 8d000000      	callf	f_I2C_CheckEvent
 598  0182 4d            	tnz	a
 599  0183 27f6          	jreq	L172
 600                     ; 100   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
 602  0185 aea101        	ldw	x,#41217
 603  0188 8d000000      	callf	f_I2C_Send7bitAddress
 606  018c               L772:
 607                     ; 101   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
 609  018c ae0302        	ldw	x,#770
 610  018f 8d000000      	callf	f_I2C_CheckEvent
 612  0193 4d            	tnz	a
 613  0194 27f6          	jreq	L772
 614  0196               L303:
 615                     ; 104     if (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED))
 617  0196 ae0340        	ldw	x,#832
 618  0199 8d000000      	callf	f_I2C_CheckEvent
 620  019d 4d            	tnz	a
 621  019e 27f6          	jreq	L303
 622                     ; 106       uint8_t tempData = I2C_ReceiveData ();
 624  01a0 8d000000      	callf	f_I2C_ReceiveData
 626  01a4 6b01          	ld	(OFST-2,sp),a
 628                     ; 107       if (tempData == '\0')
 630  01a6 261c          	jrne	L113
 631                     ; 109         I2C_AcknowledgeConfig (I2C_ACK_NONE);
 633  01a8 8d000000      	callf	f_I2C_AcknowledgeConfig
 635                     ; 110         I2C_GenerateSTOP (ENABLE);
 637  01ac a601          	ld	a,#1
 638  01ae 8d000000      	callf	f_I2C_GenerateSTOP
 640                     ; 111         break;
 641                     ; 117   buffer[i] = '\0';
 643  01b2 7b03          	ld	a,(OFST+0,sp)
 644  01b4 5f            	clrw	x
 645  01b5 97            	ld	xl,a
 646  01b6 72fb09        	addw	x,(OFST+6,sp)
 647  01b9 7f            	clr	(x)
 648                     ; 119   delay_ms (5);
 650  01ba ae0005        	ldw	x,#5
 651  01bd 8d000000      	callf	f_delay_ms
 653                     ; 120 }
 656  01c1 5b05          	addw	sp,#5
 657  01c3 87            	retf	
 658  01c4               L113:
 659                     ; 114         buffer[i++] = tempData;
 661  01c4 7b03          	ld	a,(OFST+0,sp)
 662  01c6 0c03          	inc	(OFST+0,sp)
 664  01c8 5f            	clrw	x
 665  01c9 97            	ld	xl,a
 666  01ca 72fb09        	addw	x,(OFST+6,sp)
 667  01cd 7b01          	ld	a,(OFST-2,sp)
 668  01cf f7            	ld	(x),a
 669  01d0 20c4          	jra	L303
 713                     ; 122 void EEPROM_WriteString (uint16_t memoryAddress, char *data)
 713                     ; 123 {
 714                     	switch	.text
 715  01d2               f_EEPROM_WriteString:
 717  01d2 89            	pushw	x
 718       00000000      OFST:	set	0
 721  01d3 1e06          	ldw	x,(OFST+6,sp)
 722  01d5 2012          	jra	L143
 723  01d7               L733:
 724                     ; 126     EEPROM_WriteByte (memoryAddress, *data); // Write one character to EEPROM
 726  01d7 88            	push	a
 727  01d8 1e02          	ldw	x,(OFST+2,sp)
 728  01da 8d480048      	callf	f_EEPROM_WriteByte
 730  01de 84            	pop	a
 731                     ; 127     memoryAddress++; // Increment the address to write the next character
 733  01df 1e01          	ldw	x,(OFST+1,sp)
 734  01e1 5c            	incw	x
 735  01e2 1f01          	ldw	(OFST+1,sp),x
 736                     ; 128     data++; // Move to the next character in the string
 738  01e4 1e06          	ldw	x,(OFST+6,sp)
 739  01e6 5c            	incw	x
 740  01e7 1f06          	ldw	(OFST+6,sp),x
 741  01e9               L143:
 742                     ; 124   while (*data)
 744  01e9 f6            	ld	a,(x)
 745  01ea 26eb          	jrne	L733
 746                     ; 131   EEPROM_WriteByte (memoryAddress, '\0');
 748  01ec 4b00          	push	#0
 749  01ee 1e02          	ldw	x,(OFST+2,sp)
 750  01f0 8d480048      	callf	f_EEPROM_WriteByte
 752                     ; 132 }
 755  01f4 5b03          	addw	sp,#3
 756  01f6 87            	retf	
 802                     ; 134 void EEPROM_LogData(const char *data)
 802                     ; 135 {
 803                     	switch	.text
 804  01f7               f_EEPROM_LogData:
 806  01f7 89            	pushw	x
 807  01f8 89            	pushw	x
 808       00000002      OFST:	set	2
 811                     ; 136 	uint16_t memoryAddress = writePointer; // Start writing at the current write pointer
 813  01f9 be00          	ldw	x,_writePointer
 814  01fb 1f01          	ldw	(OFST-1,sp),x
 816                     ; 139 	EEPROM_WriteString(memoryAddress, data);
 818  01fd 1e03          	ldw	x,(OFST+1,sp)
 819  01ff 89            	pushw	x
 820  0200 1e03          	ldw	x,(OFST+1,sp)
 821  0202 8dd201d2      	callf	f_EEPROM_WriteString
 823  0206 85            	popw	x
 824                     ; 142 	writePointer += LOG_ENTRY_SIZE;
 826  0207 be00          	ldw	x,_writePointer
 827  0209 1c0025        	addw	x,#37
 828  020c bf00          	ldw	_writePointer,x
 829                     ; 145 	if (writePointer >= EEPROM_SIZE)
 831  020e be00          	ldw	x,_writePointer
 832  0210 a37d00        	cpw	x,#32000
 833  0213 2503          	jrult	L763
 834                     ; 147 			writePointer = EEPROM_START_ADDRESS;
 836  0215 5f            	clrw	x
 837  0216 bf00          	ldw	_writePointer,x
 838  0218               L763:
 839                     ; 150 	printf("Data Logged: %s at address: 0x%04X\n", data, memoryAddress);
 841  0218 1e01          	ldw	x,(OFST-1,sp)
 842  021a 89            	pushw	x
 843  021b 1e05          	ldw	x,(OFST+3,sp)
 844  021d 89            	pushw	x
 845  021e ae007e        	ldw	x,#L173
 846  0221 8d000000      	callf	f_printf
 848  0225 5b08          	addw	sp,#8
 849                     ; 151 }
 852  0227 87            	retf	
 896                     ; 195 void EEPROM_ReadData(void)
 896                     ; 196 {
 897                     	switch	.text
 898  0228               f_EEPROM_ReadData:
 900  0228 5203          	subw	sp,#3
 901       00000003      OFST:	set	3
 904                     ; 197     uint16_t memoryAddress = EEPROM_START_ADDRESS; // Start at the beginning of EEPROM
 906  022a 5f            	clrw	x
 907  022b 1f01          	ldw	(OFST-2,sp),x
 909  022d               L514:
 910                     ; 204         data = EEPROM_ReadByte(memoryAddress);
 912  022d 8da900a9      	callf	f_EEPROM_ReadByte
 914  0231 6b03          	ld	(OFST+0,sp),a
 916                     ; 207         if (data >= 33 && data <= 122) // Printable ASCII range
 918  0233 a121          	cp	a,#33
 919  0235 250d          	jrult	L324
 921  0237 a17b          	cp	a,#123
 922  0239 2409          	jruge	L324
 923                     ; 209             printf("%c", data); // Print the character directly
 925  023b 88            	push	a
 926  023c ae007b        	ldw	x,#L524
 927  023f 8d000000      	callf	f_printf
 929  0243 84            	pop	a
 930  0244               L324:
 931                     ; 212         memoryAddress++;
 933  0244 1e01          	ldw	x,(OFST-2,sp)
 934  0246 5c            	incw	x
 935  0247 1f01          	ldw	(OFST-2,sp),x
 937                     ; 201     while (memoryAddress < EEPROM_SIZE) // Loop until the end of the EEPROM
 939  0249 a37d00        	cpw	x,#32000
 940  024c 25df          	jrult	L514
 941                     ; 214     printf("\nDone reading EEPROM.\n");
 943  024e ae0064        	ldw	x,#L724
 944  0251 8d000000      	callf	f_printf
 946                     ; 215 }
 949  0255 5b03          	addw	sp,#3
 950  0257 87            	retf	
 996                     ; 219 void EEPROM_Init(uint8_t defaultValue)
 996                     ; 220 {
 997                     	switch	.text
 998  0258               f_EEPROM_Init:
1000  0258 88            	push	a
1001  0259 89            	pushw	x
1002       00000002      OFST:	set	2
1005                     ; 221 	uint16_t address = 0;
1007                     ; 222 	for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
1009  025a 5f            	clrw	x
1010  025b 1f01          	ldw	(OFST-1,sp),x
1012  025d               L354:
1013                     ; 224 			EEPROM_WriteByte(address, defaultValue);
1015  025d 7b03          	ld	a,(OFST+1,sp)
1016  025f 88            	push	a
1017  0260 1e02          	ldw	x,(OFST+0,sp)
1018  0262 8d480048      	callf	f_EEPROM_WriteByte
1020  0266 ae0005        	ldw	x,#5
1021  0269 84            	pop	a
1022                     ; 225 			delay_ms(5); // Ensure write delay
1024  026a 8d000000      	callf	f_delay_ms
1026                     ; 222 	for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
1028  026e 1e01          	ldw	x,(OFST-1,sp)
1029  0270 5c            	incw	x
1030  0271 1f01          	ldw	(OFST-1,sp),x
1034  0273 a37d00        	cpw	x,#32000
1035  0276 25e5          	jrult	L354
1036                     ; 227 	writePointer = EEPROM_START_ADDRESS; // Reset pointer
1038  0278 5f            	clrw	x
1039  0279 bf00          	ldw	_writePointer,x
1040                     ; 228 	printf("EEPROM Initialized. All values set to: 0x%02X\n", defaultValue);
1042  027b 7b03          	ld	a,(OFST+1,sp)
1043  027d 88            	push	a
1044  027e ae0035        	ldw	x,#L164
1045  0281 8d000000      	callf	f_printf
1047  0285 5b04          	addw	sp,#4
1048                     ; 229 }
1051  0287 87            	retf	
1106                     ; 231 void EEPROM_Test (void)
1106                     ; 232 {
1107                     	switch	.text
1108  0288               f_EEPROM_Test:
1110  0288 5204          	subw	sp,#4
1111       00000004      OFST:	set	4
1114                     ; 233   uint16_t memoryAddress = 0x0000; // EEPROM memory address to write/read
1116  028a 5f            	clrw	x
1117  028b 1f02          	ldw	(OFST-2,sp),x
1119                     ; 234   uint8_t dataToWrite = 0xAB; // Data to write
1121  028d a6ab          	ld	a,#171
1122  028f 6b04          	ld	(OFST+0,sp),a
1124                     ; 237   EEPROM_Config (); // Initialize I2C peripheral
1126  0291 8d000000      	callf	f_EEPROM_Config
1128                     ; 240   EEPROM_WriteByte (memoryAddress, dataToWrite);
1130  0295 7b04          	ld	a,(OFST+0,sp)
1131  0297 88            	push	a
1132  0298 1e03          	ldw	x,(OFST-1,sp)
1133  029a 8d480048      	callf	f_EEPROM_WriteByte
1135  029e ae0023        	ldw	x,#L115
1136  02a1 84            	pop	a
1137                     ; 241   printf ("Writing Finished\n");
1139  02a2 8d000000      	callf	f_printf
1141                     ; 244   printf ("Reading Starting\n");
1143  02a6 ae0011        	ldw	x,#L315
1144  02a9 8d000000      	callf	f_printf
1146                     ; 246   dataRead = EEPROM_ReadByte (memoryAddress);
1148  02ad 1e02          	ldw	x,(OFST-2,sp)
1149  02af 8da900a9      	callf	f_EEPROM_ReadByte
1151  02b3 6b01          	ld	(OFST-3,sp),a
1153                     ; 249   if (dataRead == dataToWrite)
1155  02b5 1104          	cp	a,(OFST+0,sp)
1156  02b7 2605          	jrne	L515
1157                     ; 251     printf ("Success");
1159  02b9 ae0009        	ldw	x,#L715
1162  02bc 2003          	jra	L125
1163  02be               L515:
1164                     ; 255     printf ("YOU FAIL");
1166  02be ae0000        	ldw	x,#L325
1168  02c1               L125:
1169  02c1 8d000000      	callf	f_printf
1170                     ; 257 }
1173  02c5 5b04          	addw	sp,#4
1174  02c7 87            	retf	
1197                     	xdef	f_EEPROM_Test
1198                     	xdef	f_EEPROM_Init
1199                     	xdef	f_EEPROM_LogData
1200                     	xdef	f_EEPROM_ReadData
1201                     	xdef	f_EEPROM_WriteString
1202                     	xdef	f_EEPROM_ReadString
1203                     	xdef	f_EEPROM_ReadByte
1204                     	xdef	f_EEPROM_WriteByte
1205                     	xdef	f_EEPROM_Config
1206                     	xdef	_writePointer
1207                     	xref	f_I2C_CheckEvent
1208                     	xref	f_I2C_SendData
1209                     	xref	f_I2C_Send7bitAddress
1210                     	xref	f_I2C_ReceiveData
1211                     	xref	f_I2C_AcknowledgeConfig
1212                     	xref	f_I2C_GenerateSTOP
1213                     	xref	f_I2C_GenerateSTART
1214                     	xref	f_I2C_Cmd
1215                     	xref	f_I2C_Init
1216                     	xref	f_I2C_DeInit
1217                     	xref	f_delay_ms
1218                     	xref	f_printf
1219                     	xref	f_GPIO_Init
1220                     	xref	f_GPIO_DeInit
1221                     	xref	f_CLK_PeripheralClockConfig
1222                     .const:	section	.text
1223  0000               L325:
1224  0000 594f55204641  	dc.b	"YOU FAIL",0
1225  0009               L715:
1226  0009 537563636573  	dc.b	"Success",0
1227  0011               L315:
1228  0011 52656164696e  	dc.b	"Reading Starting",10,0
1229  0023               L115:
1230  0023 57726974696e  	dc.b	"Writing Finished",10,0
1231  0035               L164:
1232  0035 454550524f4d  	dc.b	"EEPROM Initialized"
1233  0047 2e20416c6c20  	dc.b	". All values set t"
1234  0059 6f3a20307825  	dc.b	"o: 0x%02X",10,0
1235  0064               L724:
1236  0064 0a446f6e6520  	dc.b	10,68,111,110,101,32
1237  006a 72656164696e  	dc.b	"reading EEPROM.",10,0
1238  007b               L524:
1239  007b 256300        	dc.b	"%c",0
1240  007e               L173:
1241  007e 44617461204c  	dc.b	"Data Logged: %s at"
1242  0090 206164647265  	dc.b	" address: 0x%04X",10,0
1262                     	end
