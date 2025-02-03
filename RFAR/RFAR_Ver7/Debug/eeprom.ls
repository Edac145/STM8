   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _writePointer:
  16  0000 0000          	dc.w	0
  51                     ; 5 void EEPROM_Config (void)
  51                     ; 6 { 
  52                     	switch	.text
  53  0000               f_EEPROM_Config:
  57                     ; 7   CLK_PeripheralClockConfig (CLK_PERIPHERAL_I2C, ENABLE);
  59  0000 ae0001        	ldw	x,#1
  60  0003 8d000000      	callf	f_CLK_PeripheralClockConfig
  62                     ; 8   GPIO_DeInit (GPIOE);
  64  0007 ae5014        	ldw	x,#20500
  65  000a 8d000000      	callf	f_GPIO_DeInit
  67                     ; 9   GPIO_Init (GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
  69  000e 4bb0          	push	#176
  70  0010 4b02          	push	#2
  71  0012 ae5014        	ldw	x,#20500
  72  0015 8d000000      	callf	f_GPIO_Init
  74  0019 85            	popw	x
  75                     ; 10   GPIO_Init (GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
  77  001a 4bb0          	push	#176
  78  001c 4b04          	push	#4
  79  001e ae5014        	ldw	x,#20500
  80  0021 8d000000      	callf	f_GPIO_Init
  82  0025 85            	popw	x
  83                     ; 11   I2C_DeInit (); // Reset I2C to default state
  85  0026 8d000000      	callf	f_I2C_DeInit
  87                     ; 14   I2C_Init (
  87                     ; 15             100000, // I2C clock frequency (100kHz)
  87                     ; 16             0x00, // Own address (not required for master mode)
  87                     ; 17             I2C_DUTYCYCLE_2, // Fast mode Tlow/Thigh = 2
  87                     ; 18             I2C_ACK_CURR, // Enable ACK for current byte
  87                     ; 19             I2C_ADDMODE_7BIT, // 7-bit addressing mode
  87                     ; 20             16 // Input clock frequency in MHz (adjust as per your system clock)
  87                     ; 21             );
  89  002a 4b10          	push	#16
  90  002c 4b00          	push	#0
  91  002e 4b01          	push	#1
  92  0030 4b00          	push	#0
  93  0032 5f            	clrw	x
  94  0033 89            	pushw	x
  95  0034 ae86a0        	ldw	x,#34464
  96  0037 89            	pushw	x
  97  0038 ae0001        	ldw	x,#1
  98  003b 89            	pushw	x
  99  003c 8d000000      	callf	f_I2C_Init
 101  0040 5b0a          	addw	sp,#10
 102                     ; 22   I2C_Cmd (ENABLE); // Enable the I2C peripheral
 104  0042 a601          	ld	a,#1
 105  0044 8d000000      	callf	f_I2C_Cmd
 107                     ; 23 }
 110  0048 87            	retf
 158                     ; 25 void EEPROM_WriteByte (uint16_t memoryAddress, uint8_t data)
 158                     ; 26 {
 159                     	switch	.text
 160  0049               f_EEPROM_WriteByte:
 162  0049 89            	pushw	x
 163       00000000      OFST:	set	0
 166                     ; 28   I2C_GenerateSTART (ENABLE);
 168  004a a601          	ld	a,#1
 169  004c 8d000000      	callf	f_I2C_GenerateSTART
 172  0050               L54:
 173                     ; 29   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 175  0050 ae0301        	ldw	x,#769
 176  0053 8d000000      	callf	f_I2C_CheckEvent
 178  0057 4d            	tnz	a
 179  0058 27f6          	jreq	L54
 180                     ; 31   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 182  005a aea000        	ldw	x,#40960
 183  005d 8d000000      	callf	f_I2C_Send7bitAddress
 186  0061               L35:
 187                     ; 32   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 189  0061 ae0782        	ldw	x,#1922
 190  0064 8d000000      	callf	f_I2C_CheckEvent
 192  0068 4d            	tnz	a
 193  0069 27f6          	jreq	L35
 194                     ; 34   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 196  006b 7b01          	ld	a,(OFST+1,sp)
 197  006d 8d000000      	callf	f_I2C_SendData
 200  0071               L16:
 201                     ; 35   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 203  0071 ae0784        	ldw	x,#1924
 204  0074 8d000000      	callf	f_I2C_CheckEvent
 206  0078 4d            	tnz	a
 207  0079 27f6          	jreq	L16
 208                     ; 37   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 210  007b 7b02          	ld	a,(OFST+2,sp)
 211  007d a4ff          	and	a,#255
 212  007f 8d000000      	callf	f_I2C_SendData
 215  0083               L76:
 216                     ; 38   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 218  0083 ae0784        	ldw	x,#1924
 219  0086 8d000000      	callf	f_I2C_CheckEvent
 221  008a 4d            	tnz	a
 222  008b 27f6          	jreq	L76
 223                     ; 40   I2C_SendData (data);
 225  008d 7b06          	ld	a,(OFST+6,sp)
 226  008f 8d000000      	callf	f_I2C_SendData
 229  0093               L57:
 230                     ; 41   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 232  0093 ae0784        	ldw	x,#1924
 233  0096 8d000000      	callf	f_I2C_CheckEvent
 235  009a 4d            	tnz	a
 236  009b 27f6          	jreq	L57
 237                     ; 43   I2C_GenerateSTOP (ENABLE);
 239  009d a601          	ld	a,#1
 240  009f 8d000000      	callf	f_I2C_GenerateSTOP
 242                     ; 44   delay_ms (5); 
 244  00a3 ae0005        	ldw	x,#5
 245  00a6 8d000000      	callf	f_delay_ms
 247                     ; 45 }
 250  00aa 85            	popw	x
 251  00ab 87            	retf
 308                     ; 47 uint8_t EEPROM_ReadByte (uint16_t memoryAddress)
 308                     ; 48 {
 309                     	switch	.text
 310  00ac               f_EEPROM_ReadByte:
 312  00ac 89            	pushw	x
 313  00ad 89            	pushw	x
 314       00000002      OFST:	set	2
 317                     ; 50   uint8_t i = 0;
 319                     ; 52   I2C_GenerateSTART (ENABLE);
 321  00ae a601          	ld	a,#1
 322  00b0 8d000000      	callf	f_I2C_GenerateSTART
 325  00b4               L131:
 326                     ; 53   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 328  00b4 ae0301        	ldw	x,#769
 329  00b7 8d000000      	callf	f_I2C_CheckEvent
 331  00bb 4d            	tnz	a
 332  00bc 27f6          	jreq	L131
 333                     ; 55   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 335  00be aea000        	ldw	x,#40960
 336  00c1 8d000000      	callf	f_I2C_Send7bitAddress
 339  00c5               L731:
 340                     ; 56   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 342  00c5 ae0782        	ldw	x,#1922
 343  00c8 8d000000      	callf	f_I2C_CheckEvent
 345  00cc 4d            	tnz	a
 346  00cd 27f6          	jreq	L731
 347                     ; 58   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 349  00cf 7b03          	ld	a,(OFST+1,sp)
 350  00d1 8d000000      	callf	f_I2C_SendData
 353  00d5               L541:
 354                     ; 59   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 356  00d5 ae0784        	ldw	x,#1924
 357  00d8 8d000000      	callf	f_I2C_CheckEvent
 359  00dc 4d            	tnz	a
 360  00dd 27f6          	jreq	L541
 361                     ; 61   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 363  00df 7b04          	ld	a,(OFST+2,sp)
 364  00e1 a4ff          	and	a,#255
 365  00e3 8d000000      	callf	f_I2C_SendData
 368  00e7               L351:
 369                     ; 62   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 371  00e7 ae0784        	ldw	x,#1924
 372  00ea 8d000000      	callf	f_I2C_CheckEvent
 374  00ee 4d            	tnz	a
 375  00ef 27f6          	jreq	L351
 376                     ; 65   I2C_GenerateSTART (ENABLE);
 378  00f1 a601          	ld	a,#1
 379  00f3 8d000000      	callf	f_I2C_GenerateSTART
 382  00f7               L161:
 383                     ; 66   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 385  00f7 ae0301        	ldw	x,#769
 386  00fa 8d000000      	callf	f_I2C_CheckEvent
 388  00fe 4d            	tnz	a
 389  00ff 27f6          	jreq	L161
 390                     ; 68   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
 392  0101 aea101        	ldw	x,#41217
 393  0104 8d000000      	callf	f_I2C_Send7bitAddress
 396  0108               L761:
 397                     ; 69   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
 399  0108 ae0302        	ldw	x,#770
 400  010b 8d000000      	callf	f_I2C_CheckEvent
 402  010f 4d            	tnz	a
 403  0110 27f6          	jreq	L761
 405  0112               L571:
 406                     ; 71   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED) == ERROR);
 408  0112 ae0340        	ldw	x,#832
 409  0115 8d000000      	callf	f_I2C_CheckEvent
 411  0119 4d            	tnz	a
 412  011a 27f6          	jreq	L571
 413                     ; 72   receivedData = I2C_ReceiveData ();
 415  011c 8d000000      	callf	f_I2C_ReceiveData
 417  0120 6b02          	ld	(OFST+0,sp),a
 419                     ; 74   I2C_GenerateSTOP (ENABLE);
 421  0122 a601          	ld	a,#1
 422  0124 8d000000      	callf	f_I2C_GenerateSTOP
 424                     ; 76   return receivedData;
 426  0128 7b02          	ld	a,(OFST+0,sp)
 429  012a 5b04          	addw	sp,#4
 430  012c 87            	retf
 509                     ; 79 char* EEPROM_ReadString (uint16_t memoryAddress, char* buffer)  //Changed from no return to char*
 509                     ; 80 {
 510                     	switch	.text
 511  012d               f_EEPROM_ReadString:
 513  012d 89            	pushw	x
 514  012e 5203          	subw	sp,#3
 515       00000003      OFST:	set	3
 518                     ; 81   uint8_t tempData = 0;
 520                     ; 82   uint8_t i = 0;
 522  0130 0f03          	clr	(OFST+0,sp)
 524                     ; 84   I2C_GenerateSTART (ENABLE);
 526  0132 a601          	ld	a,#1
 527  0134 8d000000      	callf	f_I2C_GenerateSTART
 530  0138               L142:
 531                     ; 85   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 533  0138 ae0301        	ldw	x,#769
 534  013b 8d000000      	callf	f_I2C_CheckEvent
 536  013f 4d            	tnz	a
 537  0140 27f6          	jreq	L142
 538                     ; 87   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 540  0142 aea000        	ldw	x,#40960
 541  0145 8d000000      	callf	f_I2C_Send7bitAddress
 544  0149               L742:
 545                     ; 88   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 547  0149 ae0782        	ldw	x,#1922
 548  014c 8d000000      	callf	f_I2C_CheckEvent
 550  0150 4d            	tnz	a
 551  0151 27f6          	jreq	L742
 552                     ; 90   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 554  0153 7b04          	ld	a,(OFST+1,sp)
 555  0155 8d000000      	callf	f_I2C_SendData
 558  0159               L552:
 559                     ; 91   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 561  0159 ae0784        	ldw	x,#1924
 562  015c 8d000000      	callf	f_I2C_CheckEvent
 564  0160 4d            	tnz	a
 565  0161 27f6          	jreq	L552
 566                     ; 93   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 568  0163 7b05          	ld	a,(OFST+2,sp)
 569  0165 a4ff          	and	a,#255
 570  0167 8d000000      	callf	f_I2C_SendData
 573  016b               L362:
 574                     ; 94   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 576  016b ae0784        	ldw	x,#1924
 577  016e 8d000000      	callf	f_I2C_CheckEvent
 579  0172 4d            	tnz	a
 580  0173 27f6          	jreq	L362
 581                     ; 97   I2C_GenerateSTART (ENABLE);
 583  0175 a601          	ld	a,#1
 584  0177 8d000000      	callf	f_I2C_GenerateSTART
 587  017b               L172:
 588                     ; 98   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 590  017b ae0301        	ldw	x,#769
 591  017e 8d000000      	callf	f_I2C_CheckEvent
 593  0182 4d            	tnz	a
 594  0183 27f6          	jreq	L172
 595                     ; 100   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
 597  0185 aea101        	ldw	x,#41217
 598  0188 8d000000      	callf	f_I2C_Send7bitAddress
 601  018c               L772:
 602                     ; 101   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
 604  018c ae0302        	ldw	x,#770
 605  018f 8d000000      	callf	f_I2C_CheckEvent
 607  0193 4d            	tnz	a
 608  0194 27f6          	jreq	L772
 609  0196               L303:
 610                     ; 104     if (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED))
 612  0196 ae0340        	ldw	x,#832
 613  0199 8d000000      	callf	f_I2C_CheckEvent
 615  019d 4d            	tnz	a
 616  019e 27f6          	jreq	L303
 617                     ; 106       uint8_t tempData = I2C_ReceiveData ();
 619  01a0 8d000000      	callf	f_I2C_ReceiveData
 621  01a4 6b01          	ld	(OFST-2,sp),a
 623                     ; 107       if (tempData == '\0')
 625  01a6 0d01          	tnz	(OFST-2,sp)
 626  01a8 261d          	jrne	L113
 627                     ; 109         I2C_AcknowledgeConfig (I2C_ACK_NONE);
 629  01aa 4f            	clr	a
 630  01ab 8d000000      	callf	f_I2C_AcknowledgeConfig
 632                     ; 110         I2C_GenerateSTOP (ENABLE);
 634  01af a601          	ld	a,#1
 635  01b1 8d000000      	callf	f_I2C_GenerateSTOP
 637                     ; 111         break;
 638                     ; 117   buffer[i] = '\0';
 640  01b5 7b03          	ld	a,(OFST+0,sp)
 641  01b7 5f            	clrw	x
 642  01b8 97            	ld	xl,a
 643  01b9 72fb09        	addw	x,(OFST+6,sp)
 644  01bc 7f            	clr	(x)
 645                     ; 119   delay_ms (5);
 647  01bd ae0005        	ldw	x,#5
 648  01c0 8d000000      	callf	f_delay_ms
 650                     ; 120 }
 653  01c4 5b05          	addw	sp,#5
 654  01c6 87            	retf
 655  01c7               L113:
 656                     ; 114         buffer[i++] = tempData;
 658  01c7 7b03          	ld	a,(OFST+0,sp)
 659  01c9 97            	ld	xl,a
 660  01ca 0c03          	inc	(OFST+0,sp)
 662  01cc 9f            	ld	a,xl
 663  01cd 5f            	clrw	x
 664  01ce 97            	ld	xl,a
 665  01cf 72fb09        	addw	x,(OFST+6,sp)
 666  01d2 7b01          	ld	a,(OFST-2,sp)
 667  01d4 f7            	ld	(x),a
 668  01d5 20bf          	jra	L303
 712                     ; 122 void EEPROM_WriteString (uint16_t memoryAddress, char *data)
 712                     ; 123 {
 713                     	switch	.text
 714  01d7               f_EEPROM_WriteString:
 716  01d7 89            	pushw	x
 717       00000000      OFST:	set	0
 720  01d8 2019          	jra	L143
 721  01da               L733:
 722                     ; 126     EEPROM_WriteByte (memoryAddress, *data); // Write one character to EEPROM
 724  01da 1e06          	ldw	x,(OFST+6,sp)
 725  01dc f6            	ld	a,(x)
 726  01dd 88            	push	a
 727  01de 1e02          	ldw	x,(OFST+2,sp)
 728  01e0 8d490049      	callf	f_EEPROM_WriteByte
 730  01e4 84            	pop	a
 731                     ; 127     memoryAddress++; // Increment the address to write the next character
 733  01e5 1e01          	ldw	x,(OFST+1,sp)
 734  01e7 1c0001        	addw	x,#1
 735  01ea 1f01          	ldw	(OFST+1,sp),x
 736                     ; 128     data++; // Move to the next character in the string
 738  01ec 1e06          	ldw	x,(OFST+6,sp)
 739  01ee 1c0001        	addw	x,#1
 740  01f1 1f06          	ldw	(OFST+6,sp),x
 741  01f3               L143:
 742                     ; 124   while (*data)
 744  01f3 1e06          	ldw	x,(OFST+6,sp)
 745  01f5 7d            	tnz	(x)
 746  01f6 26e2          	jrne	L733
 747                     ; 131   EEPROM_WriteByte (memoryAddress, '\0');
 749  01f8 4b00          	push	#0
 750  01fa 1e02          	ldw	x,(OFST+2,sp)
 751  01fc 8d490049      	callf	f_EEPROM_WriteByte
 753  0200 84            	pop	a
 754                     ; 132 }
 757  0201 85            	popw	x
 758  0202 87            	retf
 804                     ; 134 void EEPROM_LogData(const char *data)
 804                     ; 135 {
 805                     	switch	.text
 806  0203               f_EEPROM_LogData:
 808  0203 89            	pushw	x
 809  0204 89            	pushw	x
 810       00000002      OFST:	set	2
 813                     ; 136 	uint16_t memoryAddress = writePointer; // Start writing at the current write pointer
 815  0205 be00          	ldw	x,_writePointer
 816  0207 1f01          	ldw	(OFST-1,sp),x
 818                     ; 139 	EEPROM_WriteString(memoryAddress, data);
 820  0209 1e03          	ldw	x,(OFST+1,sp)
 821  020b 89            	pushw	x
 822  020c 1e03          	ldw	x,(OFST+1,sp)
 823  020e 8dd701d7      	callf	f_EEPROM_WriteString
 825  0212 85            	popw	x
 826                     ; 142 	writePointer += LOG_ENTRY_SIZE;
 828  0213 be00          	ldw	x,_writePointer
 829  0215 1c0025        	addw	x,#37
 830  0218 bf00          	ldw	_writePointer,x
 831                     ; 145 	if (writePointer >= EEPROM_SIZE)
 833  021a be00          	ldw	x,_writePointer
 834  021c a37d00        	cpw	x,#32000
 835  021f 2503          	jrult	L763
 836                     ; 147 			writePointer = EEPROM_START_ADDRESS;
 838  0221 5f            	clrw	x
 839  0222 bf00          	ldw	_writePointer,x
 840  0224               L763:
 841                     ; 150 	printf("Data Logged: %s at address: 0x%04X\n", data, memoryAddress);
 843  0224 1e01          	ldw	x,(OFST-1,sp)
 844  0226 89            	pushw	x
 845  0227 1e05          	ldw	x,(OFST+3,sp)
 846  0229 89            	pushw	x
 847  022a ae00dc        	ldw	x,#L173
 848  022d 8d000000      	callf	f_printf
 850  0231 5b04          	addw	sp,#4
 851                     ; 151 }
 854  0233 5b04          	addw	sp,#4
 855  0235 87            	retf
 899                     ; 153 void EEPROM_ReadData(void)
 899                     ; 154 {
 900                     	switch	.text
 901  0236               f_EEPROM_ReadData:
 903  0236 5203          	subw	sp,#3
 904       00000003      OFST:	set	3
 907                     ; 155     uint16_t memoryAddress = EEPROM_START_ADDRESS; // Start at the beginning of EEPROM
 909  0238 5f            	clrw	x
 910  0239 1f01          	ldw	(OFST-2,sp),x
 912  023b               L514:
 913                     ; 162         data = EEPROM_ReadByte(memoryAddress);
 915  023b 1e01          	ldw	x,(OFST-2,sp)
 916  023d 8dac00ac      	callf	f_EEPROM_ReadByte
 918  0241 6b03          	ld	(OFST+0,sp),a
 920                     ; 165         if (data >= 33 && data <= 122) // Printable ASCII range
 922  0243 7b03          	ld	a,(OFST+0,sp)
 923  0245 a121          	cp	a,#33
 924  0247 2511          	jrult	L324
 926  0249 7b03          	ld	a,(OFST+0,sp)
 927  024b a17b          	cp	a,#123
 928  024d 240b          	jruge	L324
 929                     ; 167             printf("%c", data); // Print the character directly
 931  024f 7b03          	ld	a,(OFST+0,sp)
 932  0251 88            	push	a
 933  0252 ae00d9        	ldw	x,#L524
 934  0255 8d000000      	callf	f_printf
 936  0259 84            	pop	a
 937  025a               L324:
 938                     ; 170         memoryAddress++;
 940  025a 1e01          	ldw	x,(OFST-2,sp)
 941  025c 1c0001        	addw	x,#1
 942  025f 1f01          	ldw	(OFST-2,sp),x
 944                     ; 159     while (memoryAddress < EEPROM_SIZE) // Loop until the end of the EEPROM
 946  0261 1e01          	ldw	x,(OFST-2,sp)
 947  0263 a37d00        	cpw	x,#32000
 948  0266 25d3          	jrult	L514
 949                     ; 172     printf("\nDone reading EEPROM.\n");
 951  0268 ae00c2        	ldw	x,#L724
 952  026b 8d000000      	callf	f_printf
 954                     ; 173 }
 957  026f 5b03          	addw	sp,#3
 958  0271 87            	retf
1003                     ; 175 void EEPROM_Init(uint8_t defaultValue)
1003                     ; 176 {
1004                     	switch	.text
1005  0272               f_EEPROM_Init:
1007  0272 88            	push	a
1008  0273 89            	pushw	x
1009       00000002      OFST:	set	2
1012                     ; 177 	uint16_t address = 0;
1014                     ; 178 	for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
1016  0274 5f            	clrw	x
1017  0275 1f01          	ldw	(OFST-1,sp),x
1019  0277               L354:
1020                     ; 180 			EEPROM_WriteByte(address, defaultValue);
1022  0277 7b03          	ld	a,(OFST+1,sp)
1023  0279 88            	push	a
1024  027a 1e02          	ldw	x,(OFST+0,sp)
1025  027c 8d490049      	callf	f_EEPROM_WriteByte
1027  0280 84            	pop	a
1028                     ; 178 	for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
1030  0281 1e01          	ldw	x,(OFST-1,sp)
1031  0283 1c0001        	addw	x,#1
1032  0286 1f01          	ldw	(OFST-1,sp),x
1036  0288 1e01          	ldw	x,(OFST-1,sp)
1037  028a a37d00        	cpw	x,#32000
1038  028d 25e8          	jrult	L354
1039                     ; 183 	writePointer = EEPROM_START_ADDRESS; // Reset pointer
1041  028f 5f            	clrw	x
1042  0290 bf00          	ldw	_writePointer,x
1043                     ; 184 	printf("EEPROM Initialized. All values set to: 0x%02X\n", defaultValue);
1045  0292 7b03          	ld	a,(OFST+1,sp)
1046  0294 88            	push	a
1047  0295 ae0093        	ldw	x,#L164
1048  0298 8d000000      	callf	f_printf
1050  029c 84            	pop	a
1051                     ; 185 }
1054  029d 5b03          	addw	sp,#3
1055  029f 87            	retf
1110                     ; 187 void EEPROM_Test (void)
1110                     ; 188 {
1111                     	switch	.text
1112  02a0               f_EEPROM_Test:
1114  02a0 5204          	subw	sp,#4
1115       00000004      OFST:	set	4
1118                     ; 189   uint16_t memoryAddress = 0x0000; // EEPROM memory address to write/read
1120  02a2 5f            	clrw	x
1121  02a3 1f02          	ldw	(OFST-2,sp),x
1123                     ; 190   uint8_t dataToWrite = 0xAB; // Data to write
1125  02a5 a6ab          	ld	a,#171
1126  02a7 6b04          	ld	(OFST+0,sp),a
1128                     ; 193   EEPROM_Config (); // Initialize I2C peripheral
1130  02a9 8d000000      	callf	f_EEPROM_Config
1132                     ; 196   EEPROM_WriteByte (memoryAddress, dataToWrite);
1134  02ad 7b04          	ld	a,(OFST+0,sp)
1135  02af 88            	push	a
1136  02b0 1e03          	ldw	x,(OFST-1,sp)
1137  02b2 8d490049      	callf	f_EEPROM_WriteByte
1139  02b6 84            	pop	a
1140                     ; 197   printf ("Writing Finished\n");
1142  02b7 ae0081        	ldw	x,#L115
1143  02ba 8d000000      	callf	f_printf
1145                     ; 200   printf ("Reading Starting\n");
1147  02be ae006f        	ldw	x,#L315
1148  02c1 8d000000      	callf	f_printf
1150                     ; 202   dataRead = EEPROM_ReadByte (memoryAddress);
1152  02c5 1e02          	ldw	x,(OFST-2,sp)
1153  02c7 8dac00ac      	callf	f_EEPROM_ReadByte
1155  02cb 6b01          	ld	(OFST-3,sp),a
1157                     ; 205   if (dataRead == dataToWrite)
1159  02cd 7b01          	ld	a,(OFST-3,sp)
1160  02cf 1104          	cp	a,(OFST+0,sp)
1161  02d1 2609          	jrne	L515
1162                     ; 207     printf ("Success");
1164  02d3 ae0067        	ldw	x,#L715
1165  02d6 8d000000      	callf	f_printf
1168  02da 2007          	jra	L125
1169  02dc               L515:
1170                     ; 211     printf ("YOU FAIL");
1172  02dc ae005e        	ldw	x,#L325
1173  02df 8d000000      	callf	f_printf
1175  02e3               L125:
1176                     ; 213 }
1179  02e3 5b04          	addw	sp,#4
1180  02e5 87            	retf
1282                     ; 216 bool read_from_eeprom(uint16_t start_addr, char* buffer, uint16_t buffer_size) {
1283                     	switch	.text
1284  02e6               f_read_from_eeprom:
1286  02e6 89            	pushw	x
1287  02e7 5205          	subw	sp,#5
1288       00000005      OFST:	set	5
1291                     ; 217     uint16_t addr = start_addr;
1293  02e9 1f04          	ldw	(OFST-1,sp),x
1295                     ; 218     uint16_t i = 0;
1297  02eb 5f            	clrw	x
1298  02ec 1f02          	ldw	(OFST-3,sp),x
1300                     ; 219     memset(buffer, 0, buffer_size);		
1302  02ee 1e0b          	ldw	x,(OFST+6,sp)
1303  02f0 bf00          	ldw	c_x,x
1304  02f2 1e0d          	ldw	x,(OFST+8,sp)
1305  02f4 5d            	tnzw	x
1306  02f5 2707          	jreq	L03
1307  02f7               L23:
1308  02f7 5a            	decw	x
1309  02f8 926f00        	clr	([c_x.w],x)
1310  02fb 5d            	tnzw	x
1311  02fc 26f9          	jrne	L23
1312  02fe               L03:
1314  02fe 2036          	jra	L106
1315  0300               L775:
1316                     ; 222         char ch = EEPROM_ReadByte(addr);
1318  0300 1e04          	ldw	x,(OFST-1,sp)
1319  0302 8dac00ac      	callf	f_EEPROM_ReadByte
1321  0306 6b01          	ld	(OFST-4,sp),a
1323                     ; 223         if (ch == '\0') {
1325  0308 0d01          	tnz	(OFST-4,sp)
1326  030a 2731          	jreq	L306
1327                     ; 224             break;
1329                     ; 228         if (ch < 32 && ch >126){
1331  030c 7b01          	ld	a,(OFST-4,sp)
1332  030e a120          	cp	a,#32
1333  0310 2406          	jruge	L706
1335  0312 7b01          	ld	a,(OFST-4,sp)
1336  0314 a17f          	cp	a,#127
1337  0316 2425          	jruge	L306
1338                     ; 229             break; // Exit if we encounter the default value
1340  0318               L706:
1341                     ; 232         if (i < (buffer_size - 1)) {
1343  0318 1e0d          	ldw	x,(OFST+8,sp)
1344  031a 5a            	decw	x
1345  031b 1302          	cpw	x,(OFST-3,sp)
1346  031d 231e          	jrule	L306
1347                     ; 233             buffer[i++] = ch;
1349  031f 7b01          	ld	a,(OFST-4,sp)
1350  0321 1e02          	ldw	x,(OFST-3,sp)
1351  0323 1c0001        	addw	x,#1
1352  0326 1f02          	ldw	(OFST-3,sp),x
1353  0328 1d0001        	subw	x,#1
1355  032b 72fb0b        	addw	x,(OFST+6,sp)
1356  032e f7            	ld	(x),a
1358                     ; 237         addr++;
1360  032f 1e04          	ldw	x,(OFST-1,sp)
1361  0331 1c0001        	addw	x,#1
1362  0334 1f04          	ldw	(OFST-1,sp),x
1364  0336               L106:
1365                     ; 221     while (addr < EEPROM_START_ADDRESS + EEPROM_SIZE) {
1367  0336 1e04          	ldw	x,(OFST-1,sp)
1368  0338 a37d00        	cpw	x,#32000
1369  033b 25c3          	jrult	L775
1370  033d               L306:
1371                     ; 239     return true;
1373  033d a601          	ld	a,#1
1376  033f 5b07          	addw	sp,#7
1377  0341 87            	retf
1426                     ; 242 void process_eeprom_logs() {
1427                     	switch	.text
1428  0342               f_process_eeprom_logs:
1430  0342 5234          	subw	sp,#52
1431       00000034      OFST:	set	52
1434                     ; 244     uint16_t current_addr = EEPROM_START_ADDRESS;
1436  0344 5f            	clrw	x
1437  0345 1f01          	ldw	(OFST-51,sp),x
1439                     ; 245     printf("Reading from EEPROM:\n");
1441  0347 ae0048        	ldw	x,#L736
1442  034a 8d000000      	callf	f_printf
1444                     ; 246 		EEPROM_ReadString(0x00, buffer);
1446  034e 96            	ldw	x,sp
1447  034f 1c0003        	addw	x,#OFST-49
1448  0352 89            	pushw	x
1449  0353 5f            	clrw	x
1450  0354 8d2d012d      	callf	f_EEPROM_ReadString
1452  0358 85            	popw	x
1454  0359 2054          	jra	L346
1455  035b               L146:
1456                     ; 249 			if (!read_from_eeprom(current_addr, buffer, BATCH_BUFFER_SIZE)) {
1458  035b ae0032        	ldw	x,#50
1459  035e 89            	pushw	x
1460  035f 96            	ldw	x,sp
1461  0360 1c0005        	addw	x,#OFST-47
1462  0363 89            	pushw	x
1463  0364 1e05          	ldw	x,(OFST-47,sp)
1464  0366 8de602e6      	callf	f_read_from_eeprom
1466  036a 5b04          	addw	sp,#4
1467  036c 4d            	tnz	a
1468  036d 260d          	jrne	L746
1469                     ; 250 					printf("Error reading from EEPROM at address: 0x%04X\n", current_addr);
1471  036f 1e01          	ldw	x,(OFST-51,sp)
1472  0371 89            	pushw	x
1473  0372 ae001a        	ldw	x,#L156
1474  0375 8d000000      	callf	f_printf
1476  0379 85            	popw	x
1477                     ; 251 					break; // Stop reading on error
1479  037a 203a          	jra	L546
1480  037c               L746:
1481                     ; 255 			if (strlen(buffer) > 0 && checkString(buffer)) {
1483  037c 96            	ldw	x,sp
1484  037d 1c0003        	addw	x,#OFST-49
1485  0380 8d000000      	callf	f_strlen
1487  0384 a30000        	cpw	x,#0
1488  0387 272d          	jreq	L546
1490  0389 96            	ldw	x,sp
1491  038a 1c0003        	addw	x,#OFST-49
1492  038d 8df003f0      	callf	f_checkString
1494  0391 4d            	tnz	a
1495  0392 2722          	jreq	L546
1496                     ; 256 					printf("%s\n", buffer); // Print valid log data to the serial monitor
1498  0394 96            	ldw	x,sp
1499  0395 1c0003        	addw	x,#OFST-49
1500  0398 89            	pushw	x
1501  0399 ae0016        	ldw	x,#L556
1502  039c 8d000000      	callf	f_printf
1504  03a0 85            	popw	x
1506                     ; 261 			current_addr += strlen(buffer) + 1; // +1 to skip the null terminator
1508  03a1 96            	ldw	x,sp
1509  03a2 1c0003        	addw	x,#OFST-49
1510  03a5 8d000000      	callf	f_strlen
1512  03a9 5c            	incw	x
1513  03aa 72fb01        	addw	x,(OFST-51,sp)
1514  03ad 1f01          	ldw	(OFST-51,sp),x
1516  03af               L346:
1517                     ; 247     while (current_addr < EEPROM_START_ADDRESS + EEPROM_SIZE) {
1519  03af 1e01          	ldw	x,(OFST-51,sp)
1520  03b1 a37d00        	cpw	x,#32000
1521  03b4 25a5          	jrult	L146
1522  03b6               L546:
1523                     ; 263 }
1526  03b6 5b34          	addw	sp,#52
1527  03b8 87            	retf
1565                     ; 265 void log_to_eeprom(const char* str) {
1566                     	switch	.text
1567  03b9               f_log_to_eeprom:
1569  03b9 89            	pushw	x
1570  03ba 89            	pushw	x
1571       00000002      OFST:	set	2
1574                     ; 266     if ((writePointer + strlen(str) + 1) >= (EEPROM_START_ADDRESS + EEPROM_SIZE)) {
1576  03bb 8d000000      	callf	f_strlen
1578  03bf 72bb0000      	addw	x,_writePointer
1579  03c3 5c            	incw	x
1580  03c4 a37d00        	cpw	x,#32000
1581  03c7 250a          	jrult	L776
1582                     ; 267 			  writePointer = EEPROM_START_ADDRESS;
1584  03c9 5f            	clrw	x
1585  03ca bf00          	ldw	_writePointer,x
1586                     ; 268         printf("EEPROM out of space.\n");
1588  03cc ae0000        	ldw	x,#L107
1589  03cf 8d000000      	callf	f_printf
1591  03d3               L776:
1592                     ; 270     EEPROM_WriteString(writePointer, str);
1594  03d3 1e03          	ldw	x,(OFST+1,sp)
1595  03d5 89            	pushw	x
1596  03d6 be00          	ldw	x,_writePointer
1597  03d8 8dd701d7      	callf	f_EEPROM_WriteString
1599  03dc 85            	popw	x
1600                     ; 271     writePointer += strlen(str) + 1;
1602  03dd 1e03          	ldw	x,(OFST+1,sp)
1603  03df 8d000000      	callf	f_strlen
1605  03e3 5c            	incw	x
1606  03e4 1f01          	ldw	(OFST-1,sp),x
1608  03e6 be00          	ldw	x,_writePointer
1609  03e8 72fb01        	addw	x,(OFST-1,sp)
1610  03eb bf00          	ldw	_writePointer,x
1611                     ; 272 }
1614  03ed 5b04          	addw	sp,#4
1615  03ef 87            	retf
1670                     ; 274 bool checkString(const char* str)
1670                     ; 275 {
1671                     	switch	.text
1672  03f0               f_checkString:
1674  03f0 89            	pushw	x
1675  03f1 89            	pushw	x
1676       00000002      OFST:	set	2
1679                     ; 276 	bool flag = 0;
1681  03f2 0f01          	clr	(OFST-1,sp)
1683                     ; 277 	uint8_t i  = 0;
1685                     ; 278 	for (i = 1; i < strlen(str); i++) {
1687  03f4 a601          	ld	a,#1
1688  03f6 6b02          	ld	(OFST+0,sp),a
1691  03f8 2018          	jra	L537
1692  03fa               L137:
1693                     ; 279 		if (str[i] != str[0]) {
1695  03fa 7b02          	ld	a,(OFST+0,sp)
1696  03fc 5f            	clrw	x
1697  03fd 97            	ld	xl,a
1698  03fe 72fb03        	addw	x,(OFST+1,sp)
1699  0401 f6            	ld	a,(x)
1700  0402 1e03          	ldw	x,(OFST+1,sp)
1701  0404 f1            	cp	a,(x)
1702  0405 2709          	jreq	L147
1703                     ; 280 				flag = 1;
1705  0407 a601          	ld	a,#1
1706  0409 6b01          	ld	(OFST-1,sp),a
1708                     ; 281 				break;
1709  040b               L737:
1710                     ; 284 return flag;
1712  040b 7b01          	ld	a,(OFST-1,sp)
1715  040d 5b04          	addw	sp,#4
1716  040f 87            	retf
1717  0410               L147:
1718                     ; 278 	for (i = 1; i < strlen(str); i++) {
1720  0410 0c02          	inc	(OFST+0,sp)
1722  0412               L537:
1725  0412 1e03          	ldw	x,(OFST+1,sp)
1726  0414 8d000000      	callf	f_strlen
1728  0418 7b02          	ld	a,(OFST+0,sp)
1729  041a 905f          	clrw	y
1730  041c 9097          	ld	yl,a
1731  041e 90bf00        	ldw	c_y,y
1732  0421 b300          	cpw	x,c_y
1733  0423 22d5          	jrugt	L137
1734  0425 20e4          	jra	L737
1757                     	xdef	f_checkString
1758                     	xdef	f_log_to_eeprom
1759                     	xdef	f_process_eeprom_logs
1760                     	xdef	f_read_from_eeprom
1761                     	xdef	f_EEPROM_Test
1762                     	xdef	f_EEPROM_Init
1763                     	xdef	f_EEPROM_LogData
1764                     	xdef	f_EEPROM_ReadData
1765                     	xdef	f_EEPROM_WriteString
1766                     	xdef	f_EEPROM_ReadString
1767                     	xdef	f_EEPROM_ReadByte
1768                     	xdef	f_EEPROM_WriteByte
1769                     	xdef	f_EEPROM_Config
1770                     	xdef	_writePointer
1771                     	xref	f_strlen
1772                     	xref	f_I2C_CheckEvent
1773                     	xref	f_I2C_SendData
1774                     	xref	f_I2C_Send7bitAddress
1775                     	xref	f_I2C_ReceiveData
1776                     	xref	f_I2C_AcknowledgeConfig
1777                     	xref	f_I2C_GenerateSTOP
1778                     	xref	f_I2C_GenerateSTART
1779                     	xref	f_I2C_Cmd
1780                     	xref	f_I2C_Init
1781                     	xref	f_I2C_DeInit
1782                     	xref	f_delay_ms
1783                     	xref	f_printf
1784                     	xref	f_GPIO_Init
1785                     	xref	f_GPIO_DeInit
1786                     	xref	f_CLK_PeripheralClockConfig
1787                     .const:	section	.text
1788  0000               L107:
1789  0000 454550524f4d  	dc.b	"EEPROM out of spac"
1790  0012 652e0a00      	dc.b	"e.",10,0
1791  0016               L556:
1792  0016 25730a00      	dc.b	"%s",10,0
1793  001a               L156:
1794  001a 4572726f7220  	dc.b	"Error reading from"
1795  002c 20454550524f  	dc.b	" EEPROM at address"
1796  003e 3a2030782530  	dc.b	": 0x%04X",10,0
1797  0048               L736:
1798  0048 52656164696e  	dc.b	"Reading from EEPRO"
1799  005a 4d3a0a00      	dc.b	"M:",10,0
1800  005e               L325:
1801  005e 594f55204641  	dc.b	"YOU FAIL",0
1802  0067               L715:
1803  0067 537563636573  	dc.b	"Success",0
1804  006f               L315:
1805  006f 52656164696e  	dc.b	"Reading Starting",10,0
1806  0081               L115:
1807  0081 57726974696e  	dc.b	"Writing Finished",10,0
1808  0093               L164:
1809  0093 454550524f4d  	dc.b	"EEPROM Initialized"
1810  00a5 2e20416c6c20  	dc.b	". All values set t"
1811  00b7 6f3a20307825  	dc.b	"o: 0x%02X",10,0
1812  00c2               L724:
1813  00c2 0a446f6e6520  	dc.b	10,68,111,110,101,32
1814  00c8 72656164696e  	dc.b	"reading EEPROM.",10,0
1815  00d9               L524:
1816  00d9 256300        	dc.b	"%c",0
1817  00dc               L173:
1818  00dc 44617461204c  	dc.b	"Data Logged: %s at"
1819  00ee 206164647265  	dc.b	" address: 0x%04X",10,0
1820                     	xref.b	c_x
1821                     	xref.b	c_y
1841                     	end
