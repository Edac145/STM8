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
 309                     ; 47 uint8_t EEPROM_ReadByte (uint16_t memoryAddress)
 309                     ; 48 {
 310                     	switch	.text
 311  00ac               f_EEPROM_ReadByte:
 313  00ac 89            	pushw	x
 314  00ad 89            	pushw	x
 315       00000002      OFST:	set	2
 318                     ; 50   uint8_t i = 0;
 320                     ; 52   I2C_GenerateSTART (ENABLE);
 322  00ae a601          	ld	a,#1
 323  00b0 8d000000      	callf	f_I2C_GenerateSTART
 326  00b4               L131:
 327                     ; 53   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 329  00b4 ae0301        	ldw	x,#769
 330  00b7 8d000000      	callf	f_I2C_CheckEvent
 332  00bb 4d            	tnz	a
 333  00bc 27f6          	jreq	L131
 334                     ; 55   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 336  00be aea000        	ldw	x,#40960
 337  00c1 8d000000      	callf	f_I2C_Send7bitAddress
 340  00c5               L731:
 341                     ; 56   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 343  00c5 ae0782        	ldw	x,#1922
 344  00c8 8d000000      	callf	f_I2C_CheckEvent
 346  00cc 4d            	tnz	a
 347  00cd 27f6          	jreq	L731
 348                     ; 58   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 350  00cf 7b03          	ld	a,(OFST+1,sp)
 351  00d1 8d000000      	callf	f_I2C_SendData
 354  00d5               L541:
 355                     ; 59   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 357  00d5 ae0784        	ldw	x,#1924
 358  00d8 8d000000      	callf	f_I2C_CheckEvent
 360  00dc 4d            	tnz	a
 361  00dd 27f6          	jreq	L541
 362                     ; 61   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 364  00df 7b04          	ld	a,(OFST+2,sp)
 365  00e1 a4ff          	and	a,#255
 366  00e3 8d000000      	callf	f_I2C_SendData
 369  00e7               L351:
 370                     ; 62   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 372  00e7 ae0784        	ldw	x,#1924
 373  00ea 8d000000      	callf	f_I2C_CheckEvent
 375  00ee 4d            	tnz	a
 376  00ef 27f6          	jreq	L351
 377                     ; 65   I2C_GenerateSTART (ENABLE);
 379  00f1 a601          	ld	a,#1
 380  00f3 8d000000      	callf	f_I2C_GenerateSTART
 383  00f7               L161:
 384                     ; 66   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 386  00f7 ae0301        	ldw	x,#769
 387  00fa 8d000000      	callf	f_I2C_CheckEvent
 389  00fe 4d            	tnz	a
 390  00ff 27f6          	jreq	L161
 391                     ; 68   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
 393  0101 aea101        	ldw	x,#41217
 394  0104 8d000000      	callf	f_I2C_Send7bitAddress
 397  0108               L761:
 398                     ; 69   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
 400  0108 ae0302        	ldw	x,#770
 401  010b 8d000000      	callf	f_I2C_CheckEvent
 403  010f 4d            	tnz	a
 404  0110 27f6          	jreq	L761
 406  0112               L571:
 407                     ; 71   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED) == ERROR);
 409  0112 ae0340        	ldw	x,#832
 410  0115 8d000000      	callf	f_I2C_CheckEvent
 412  0119 4d            	tnz	a
 413  011a 27f6          	jreq	L571
 414                     ; 72   receivedData = I2C_ReceiveData ();
 416  011c 8d000000      	callf	f_I2C_ReceiveData
 418  0120 6b02          	ld	(OFST+0,sp),a
 420                     ; 74   I2C_GenerateSTOP (ENABLE);
 422  0122 a601          	ld	a,#1
 423  0124 8d000000      	callf	f_I2C_GenerateSTOP
 425                     ; 75   delay_ms (5);
 427  0128 ae0005        	ldw	x,#5
 428  012b 8d000000      	callf	f_delay_ms
 430                     ; 76   return receivedData;
 432  012f 7b02          	ld	a,(OFST+0,sp)
 435  0131 5b04          	addw	sp,#4
 436  0133 87            	retf
 514                     ; 79 void EEPROM_ReadString (uint16_t memoryAddress, char* buffer)
 514                     ; 80 {
 515                     	switch	.text
 516  0134               f_EEPROM_ReadString:
 518  0134 89            	pushw	x
 519  0135 5203          	subw	sp,#3
 520       00000003      OFST:	set	3
 523                     ; 81   uint8_t tempData = 0;
 525                     ; 82   uint8_t i = 0;
 527  0137 0f03          	clr	(OFST+0,sp)
 529                     ; 84   I2C_GenerateSTART (ENABLE);
 531  0139 a601          	ld	a,#1
 532  013b 8d000000      	callf	f_I2C_GenerateSTART
 535  013f               L142:
 536                     ; 85   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 538  013f ae0301        	ldw	x,#769
 539  0142 8d000000      	callf	f_I2C_CheckEvent
 541  0146 4d            	tnz	a
 542  0147 27f6          	jreq	L142
 543                     ; 87   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 545  0149 aea000        	ldw	x,#40960
 546  014c 8d000000      	callf	f_I2C_Send7bitAddress
 549  0150               L742:
 550                     ; 88   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 552  0150 ae0782        	ldw	x,#1922
 553  0153 8d000000      	callf	f_I2C_CheckEvent
 555  0157 4d            	tnz	a
 556  0158 27f6          	jreq	L742
 557                     ; 90   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 559  015a 7b04          	ld	a,(OFST+1,sp)
 560  015c 8d000000      	callf	f_I2C_SendData
 563  0160               L552:
 564                     ; 91   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 566  0160 ae0784        	ldw	x,#1924
 567  0163 8d000000      	callf	f_I2C_CheckEvent
 569  0167 4d            	tnz	a
 570  0168 27f6          	jreq	L552
 571                     ; 93   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 573  016a 7b05          	ld	a,(OFST+2,sp)
 574  016c a4ff          	and	a,#255
 575  016e 8d000000      	callf	f_I2C_SendData
 578  0172               L362:
 579                     ; 94   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 581  0172 ae0784        	ldw	x,#1924
 582  0175 8d000000      	callf	f_I2C_CheckEvent
 584  0179 4d            	tnz	a
 585  017a 27f6          	jreq	L362
 586                     ; 97   I2C_GenerateSTART (ENABLE);
 588  017c a601          	ld	a,#1
 589  017e 8d000000      	callf	f_I2C_GenerateSTART
 592  0182               L172:
 593                     ; 98   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 595  0182 ae0301        	ldw	x,#769
 596  0185 8d000000      	callf	f_I2C_CheckEvent
 598  0189 4d            	tnz	a
 599  018a 27f6          	jreq	L172
 600                     ; 100   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
 602  018c aea101        	ldw	x,#41217
 603  018f 8d000000      	callf	f_I2C_Send7bitAddress
 606  0193               L772:
 607                     ; 101   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
 609  0193 ae0302        	ldw	x,#770
 610  0196 8d000000      	callf	f_I2C_CheckEvent
 612  019a 4d            	tnz	a
 613  019b 27f6          	jreq	L772
 614  019d               L303:
 615                     ; 104     if (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED))
 617  019d ae0340        	ldw	x,#832
 618  01a0 8d000000      	callf	f_I2C_CheckEvent
 620  01a4 4d            	tnz	a
 621  01a5 27f6          	jreq	L303
 622                     ; 106       uint8_t tempData = I2C_ReceiveData ();
 624  01a7 8d000000      	callf	f_I2C_ReceiveData
 626  01ab 6b01          	ld	(OFST-2,sp),a
 628                     ; 107       if (tempData == '\0')
 630  01ad 0d01          	tnz	(OFST-2,sp)
 631  01af 261d          	jrne	L113
 632                     ; 109         I2C_AcknowledgeConfig (I2C_ACK_NONE);
 634  01b1 4f            	clr	a
 635  01b2 8d000000      	callf	f_I2C_AcknowledgeConfig
 637                     ; 110         I2C_GenerateSTOP (ENABLE);
 639  01b6 a601          	ld	a,#1
 640  01b8 8d000000      	callf	f_I2C_GenerateSTOP
 642                     ; 111         break;
 643                     ; 117   buffer[i] = '\0';
 645  01bc 7b03          	ld	a,(OFST+0,sp)
 646  01be 5f            	clrw	x
 647  01bf 97            	ld	xl,a
 648  01c0 72fb09        	addw	x,(OFST+6,sp)
 649  01c3 7f            	clr	(x)
 650                     ; 119   delay_ms (5);
 652  01c4 ae0005        	ldw	x,#5
 653  01c7 8d000000      	callf	f_delay_ms
 655                     ; 120 }
 658  01cb 5b05          	addw	sp,#5
 659  01cd 87            	retf
 660  01ce               L113:
 661                     ; 114         buffer[i++] = tempData;
 663  01ce 7b03          	ld	a,(OFST+0,sp)
 664  01d0 97            	ld	xl,a
 665  01d1 0c03          	inc	(OFST+0,sp)
 667  01d3 9f            	ld	a,xl
 668  01d4 5f            	clrw	x
 669  01d5 97            	ld	xl,a
 670  01d6 72fb09        	addw	x,(OFST+6,sp)
 671  01d9 7b01          	ld	a,(OFST-2,sp)
 672  01db f7            	ld	(x),a
 673  01dc 20bf          	jra	L303
 717                     ; 122 void EEPROM_WriteString (uint16_t memoryAddress, char *data)
 717                     ; 123 {
 718                     	switch	.text
 719  01de               f_EEPROM_WriteString:
 721  01de 89            	pushw	x
 722       00000000      OFST:	set	0
 725  01df 2019          	jra	L143
 726  01e1               L733:
 727                     ; 126     EEPROM_WriteByte (memoryAddress, *data); // Write one character to EEPROM
 729  01e1 1e06          	ldw	x,(OFST+6,sp)
 730  01e3 f6            	ld	a,(x)
 731  01e4 88            	push	a
 732  01e5 1e02          	ldw	x,(OFST+2,sp)
 733  01e7 8d490049      	callf	f_EEPROM_WriteByte
 735  01eb 84            	pop	a
 736                     ; 127     memoryAddress++; // Increment the address to write the next character
 738  01ec 1e01          	ldw	x,(OFST+1,sp)
 739  01ee 1c0001        	addw	x,#1
 740  01f1 1f01          	ldw	(OFST+1,sp),x
 741                     ; 128     data++; // Move to the next character in the string
 743  01f3 1e06          	ldw	x,(OFST+6,sp)
 744  01f5 1c0001        	addw	x,#1
 745  01f8 1f06          	ldw	(OFST+6,sp),x
 746  01fa               L143:
 747                     ; 124   while (*data)
 749  01fa 1e06          	ldw	x,(OFST+6,sp)
 750  01fc 7d            	tnz	(x)
 751  01fd 26e2          	jrne	L733
 752                     ; 131   EEPROM_WriteByte (memoryAddress, '\0');
 754  01ff 4b00          	push	#0
 755  0201 1e02          	ldw	x,(OFST+2,sp)
 756  0203 8d490049      	callf	f_EEPROM_WriteByte
 758  0207 84            	pop	a
 759                     ; 132 }
 762  0208 85            	popw	x
 763  0209 87            	retf
 809                     ; 134 void EEPROM_LogData(const char *data)
 809                     ; 135 {
 810                     	switch	.text
 811  020a               f_EEPROM_LogData:
 813  020a 89            	pushw	x
 814  020b 89            	pushw	x
 815       00000002      OFST:	set	2
 818                     ; 136 	uint16_t memoryAddress = writePointer; // Start writing at the current write pointer
 820  020c be00          	ldw	x,_writePointer
 821  020e 1f01          	ldw	(OFST-1,sp),x
 823                     ; 139 	EEPROM_WriteString(memoryAddress, data);
 825  0210 1e03          	ldw	x,(OFST+1,sp)
 826  0212 89            	pushw	x
 827  0213 1e03          	ldw	x,(OFST+1,sp)
 828  0215 8dde01de      	callf	f_EEPROM_WriteString
 830  0219 85            	popw	x
 831                     ; 142 	writePointer += LOG_ENTRY_SIZE;
 833  021a be00          	ldw	x,_writePointer
 834  021c 1c0025        	addw	x,#37
 835  021f bf00          	ldw	_writePointer,x
 836                     ; 145 	if (writePointer >= EEPROM_SIZE)
 838  0221 be00          	ldw	x,_writePointer
 839  0223 a37d00        	cpw	x,#32000
 840  0226 2503          	jrult	L763
 841                     ; 147 			writePointer = EEPROM_START_ADDRESS;
 843  0228 5f            	clrw	x
 844  0229 bf00          	ldw	_writePointer,x
 845  022b               L763:
 846                     ; 150 	printf("Data Logged: %s at address: 0x%04X\n", data, memoryAddress);
 848  022b 1e01          	ldw	x,(OFST-1,sp)
 849  022d 89            	pushw	x
 850  022e 1e05          	ldw	x,(OFST+3,sp)
 851  0230 89            	pushw	x
 852  0231 ae0064        	ldw	x,#L173
 853  0234 8d000000      	callf	f_printf
 855  0238 5b04          	addw	sp,#4
 856                     ; 151 }
 859  023a 5b04          	addw	sp,#4
 860  023c 87            	retf
 906                     ; 153 void EEPROM_Init(uint8_t defaultValue)
 906                     ; 154 {
 907                     	switch	.text
 908  023d               f_EEPROM_Init:
 910  023d 88            	push	a
 911  023e 89            	pushw	x
 912       00000002      OFST:	set	2
 915                     ; 155 	uint16_t address = 0;
 917                     ; 156 	for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
 919  023f 5f            	clrw	x
 920  0240 1f01          	ldw	(OFST-1,sp),x
 922  0242               L514:
 923                     ; 158 			EEPROM_WriteByte(address, defaultValue);
 925  0242 7b03          	ld	a,(OFST+1,sp)
 926  0244 88            	push	a
 927  0245 1e02          	ldw	x,(OFST+0,sp)
 928  0247 8d490049      	callf	f_EEPROM_WriteByte
 930  024b 84            	pop	a
 931                     ; 159 			delay_ms(5); // Ensure write delay
 933  024c ae0005        	ldw	x,#5
 934  024f 8d000000      	callf	f_delay_ms
 936                     ; 156 	for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
 938  0253 1e01          	ldw	x,(OFST-1,sp)
 939  0255 1c0001        	addw	x,#1
 940  0258 1f01          	ldw	(OFST-1,sp),x
 944  025a 1e01          	ldw	x,(OFST-1,sp)
 945  025c a37d00        	cpw	x,#32000
 946  025f 25e1          	jrult	L514
 947                     ; 161 	writePointer = EEPROM_START_ADDRESS; // Reset pointer
 949  0261 5f            	clrw	x
 950  0262 bf00          	ldw	_writePointer,x
 951                     ; 162 	printf("EEPROM Initialized. All values set to: 0x%02X\n", defaultValue);
 953  0264 7b03          	ld	a,(OFST+1,sp)
 954  0266 88            	push	a
 955  0267 ae0035        	ldw	x,#L324
 956  026a 8d000000      	callf	f_printf
 958  026e 84            	pop	a
 959                     ; 163 }
 962  026f 5b03          	addw	sp,#3
 963  0271 87            	retf
1018                     ; 165 void EEPROM_Test (void)
1018                     ; 166 {
1019                     	switch	.text
1020  0272               f_EEPROM_Test:
1022  0272 5204          	subw	sp,#4
1023       00000004      OFST:	set	4
1026                     ; 167   uint16_t memoryAddress = 0x0000; // EEPROM memory address to write/read
1028  0274 5f            	clrw	x
1029  0275 1f02          	ldw	(OFST-2,sp),x
1031                     ; 168   uint8_t dataToWrite = 0xAB; // Data to write
1033  0277 a6ab          	ld	a,#171
1034  0279 6b04          	ld	(OFST+0,sp),a
1036                     ; 171   EEPROM_Config (); // Initialize I2C peripheral
1038  027b 8d000000      	callf	f_EEPROM_Config
1040                     ; 174   EEPROM_WriteByte (memoryAddress, dataToWrite);
1042  027f 7b04          	ld	a,(OFST+0,sp)
1043  0281 88            	push	a
1044  0282 1e03          	ldw	x,(OFST-1,sp)
1045  0284 8d490049      	callf	f_EEPROM_WriteByte
1047  0288 84            	pop	a
1048                     ; 175   printf ("Writing Finished\n");
1050  0289 ae0023        	ldw	x,#L354
1051  028c 8d000000      	callf	f_printf
1053                     ; 178   printf ("Reading Starting\n");
1055  0290 ae0011        	ldw	x,#L554
1056  0293 8d000000      	callf	f_printf
1058                     ; 180   dataRead = EEPROM_ReadByte (memoryAddress);
1060  0297 1e02          	ldw	x,(OFST-2,sp)
1061  0299 8dac00ac      	callf	f_EEPROM_ReadByte
1063  029d 6b01          	ld	(OFST-3,sp),a
1065                     ; 183   if (dataRead == dataToWrite)
1067  029f 7b01          	ld	a,(OFST-3,sp)
1068  02a1 1104          	cp	a,(OFST+0,sp)
1069  02a3 2609          	jrne	L754
1070                     ; 185     printf ("Success");
1072  02a5 ae0009        	ldw	x,#L164
1073  02a8 8d000000      	callf	f_printf
1076  02ac 2007          	jra	L364
1077  02ae               L754:
1078                     ; 189     printf ("YOU FAIL");
1080  02ae ae0000        	ldw	x,#L564
1081  02b1 8d000000      	callf	f_printf
1083  02b5               L364:
1084                     ; 191 }
1087  02b5 5b04          	addw	sp,#4
1088  02b7 87            	retf
1111                     	xdef	f_EEPROM_Test
1112                     	xdef	f_EEPROM_Init
1113                     	xdef	f_EEPROM_LogData
1114                     	xdef	f_EEPROM_WriteString
1115                     	xdef	f_EEPROM_ReadString
1116                     	xdef	f_EEPROM_ReadByte
1117                     	xdef	f_EEPROM_WriteByte
1118                     	xdef	f_EEPROM_Config
1119                     	xdef	_writePointer
1120                     	xref	f_I2C_CheckEvent
1121                     	xref	f_I2C_SendData
1122                     	xref	f_I2C_Send7bitAddress
1123                     	xref	f_I2C_ReceiveData
1124                     	xref	f_I2C_AcknowledgeConfig
1125                     	xref	f_I2C_GenerateSTOP
1126                     	xref	f_I2C_GenerateSTART
1127                     	xref	f_I2C_Cmd
1128                     	xref	f_I2C_Init
1129                     	xref	f_I2C_DeInit
1130                     	xref	f_delay_ms
1131                     	xref	f_printf
1132                     	xref	f_GPIO_Init
1133                     	xref	f_GPIO_DeInit
1134                     	xref	f_CLK_PeripheralClockConfig
1135                     .const:	section	.text
1136  0000               L564:
1137  0000 594f55204641  	dc.b	"YOU FAIL",0
1138  0009               L164:
1139  0009 537563636573  	dc.b	"Success",0
1140  0011               L554:
1141  0011 52656164696e  	dc.b	"Reading Starting",10,0
1142  0023               L354:
1143  0023 57726974696e  	dc.b	"Writing Finished",10,0
1144  0035               L324:
1145  0035 454550524f4d  	dc.b	"EEPROM Initialized"
1146  0047 2e20416c6c20  	dc.b	". All values set t"
1147  0059 6f3a20307825  	dc.b	"o: 0x%02X",10,0
1148  0064               L173:
1149  0064 44617461204c  	dc.b	"Data Logged: %s at"
1150  0076 206164647265  	dc.b	" address: 0x%04X",10,0
1170                     	end
