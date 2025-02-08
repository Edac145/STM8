   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	switch	.data
  15  0000               _writePointer:
  16  0000 0000          	dc.w	0
  49                     ; 5 void EEPROM_Config (void)
  49                     ; 6 { 
  50                     	switch	.text
  51  0000               f_EEPROM_Config:
  55                     ; 7   CLK_PeripheralClockConfig (CLK_PERIPHERAL_I2C, ENABLE);
  57  0000 ae0001        	ldw	x,#1
  58  0003 8d000000      	callf	f_CLK_PeripheralClockConfig
  60                     ; 8   I2C_DeInit (); // Reset I2C to default state
  62  0007 8d000000      	callf	f_I2C_DeInit
  64                     ; 11   I2C_Init (
  64                     ; 12             100000, // I2C clock frequency (100kHz)
  64                     ; 13             0x00, // Own address (not required for master mode)
  64                     ; 14             I2C_DUTYCYCLE_2, // Fast mode Tlow/Thigh = 2
  64                     ; 15             I2C_ACK_CURR, // Enable ACK for current byte
  64                     ; 16             I2C_ADDMODE_7BIT, // 7-bit addressing mode
  64                     ; 17             16 // Input clock frequency in MHz (adjust as per your system clock)
  64                     ; 18             );
  66  000b 4b10          	push	#16
  67  000d 4b00          	push	#0
  68  000f 4b01          	push	#1
  69  0011 4b00          	push	#0
  70  0013 5f            	clrw	x
  71  0014 89            	pushw	x
  72  0015 ae86a0        	ldw	x,#34464
  73  0018 89            	pushw	x
  74  0019 ae0001        	ldw	x,#1
  75  001c 89            	pushw	x
  76  001d 8d000000      	callf	f_I2C_Init
  78  0021 5b0a          	addw	sp,#10
  79                     ; 19   I2C_Cmd (ENABLE); // Enable the I2C peripheral
  81  0023 a601          	ld	a,#1
  82  0025 8d000000      	callf	f_I2C_Cmd
  84                     ; 20 }
  87  0029 87            	retf
 131                     ; 22 void EEPROM_WriteByte (uint16_t memoryAddress, uint8_t data)
 131                     ; 23 {
 132                     	switch	.text
 133  002a               f_EEPROM_WriteByte:
 135  002a 89            	pushw	x
 136       00000000      OFST:	set	0
 139                     ; 25   I2C_GenerateSTART (ENABLE);
 141  002b a601          	ld	a,#1
 142  002d 8d000000      	callf	f_I2C_GenerateSTART
 145  0031               L14:
 146                     ; 26   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 148  0031 ae0301        	ldw	x,#769
 149  0034 8d000000      	callf	f_I2C_CheckEvent
 151  0038 4d            	tnz	a
 152  0039 27f6          	jreq	L14
 153                     ; 28   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 155  003b aea000        	ldw	x,#40960
 156  003e 8d000000      	callf	f_I2C_Send7bitAddress
 159  0042               L74:
 160                     ; 29   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 162  0042 ae0782        	ldw	x,#1922
 163  0045 8d000000      	callf	f_I2C_CheckEvent
 165  0049 4d            	tnz	a
 166  004a 27f6          	jreq	L74
 167                     ; 31   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 169  004c 7b01          	ld	a,(OFST+1,sp)
 170  004e 8d000000      	callf	f_I2C_SendData
 173  0052               L55:
 174                     ; 32   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 176  0052 ae0784        	ldw	x,#1924
 177  0055 8d000000      	callf	f_I2C_CheckEvent
 179  0059 4d            	tnz	a
 180  005a 27f6          	jreq	L55
 181                     ; 34   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 183  005c 7b02          	ld	a,(OFST+2,sp)
 184  005e a4ff          	and	a,#255
 185  0060 8d000000      	callf	f_I2C_SendData
 188  0064               L36:
 189                     ; 35   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 191  0064 ae0784        	ldw	x,#1924
 192  0067 8d000000      	callf	f_I2C_CheckEvent
 194  006b 4d            	tnz	a
 195  006c 27f6          	jreq	L36
 196                     ; 37   I2C_SendData (data);
 198  006e 7b06          	ld	a,(OFST+6,sp)
 199  0070 8d000000      	callf	f_I2C_SendData
 202  0074               L17:
 203                     ; 38   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 205  0074 ae0784        	ldw	x,#1924
 206  0077 8d000000      	callf	f_I2C_CheckEvent
 208  007b 4d            	tnz	a
 209  007c 27f6          	jreq	L17
 210                     ; 40   I2C_GenerateSTOP (ENABLE);
 212  007e a601          	ld	a,#1
 213  0080 8d000000      	callf	f_I2C_GenerateSTOP
 215                     ; 41   delay_ms (5); 
 217  0084 ae0005        	ldw	x,#5
 218  0087 8d000000      	callf	f_delay_ms
 220                     ; 42 }
 223  008b 85            	popw	x
 224  008c 87            	retf
 275                     ; 44 uint8_t EEPROM_ReadByte (uint16_t memoryAddress)
 275                     ; 45 {
 276                     	switch	.text
 277  008d               f_EEPROM_ReadByte:
 279  008d 89            	pushw	x
 280  008e 89            	pushw	x
 281       00000002      OFST:	set	2
 284                     ; 47   uint8_t i = 0;
 286                     ; 49   I2C_GenerateSTART (ENABLE);
 288  008f a601          	ld	a,#1
 289  0091 8d000000      	callf	f_I2C_GenerateSTART
 292  0095               L711:
 293                     ; 50   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 295  0095 ae0301        	ldw	x,#769
 296  0098 8d000000      	callf	f_I2C_CheckEvent
 298  009c 4d            	tnz	a
 299  009d 27f6          	jreq	L711
 300                     ; 52   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 302  009f aea000        	ldw	x,#40960
 303  00a2 8d000000      	callf	f_I2C_Send7bitAddress
 306  00a6               L521:
 307                     ; 53   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 309  00a6 ae0782        	ldw	x,#1922
 310  00a9 8d000000      	callf	f_I2C_CheckEvent
 312  00ad 4d            	tnz	a
 313  00ae 27f6          	jreq	L521
 314                     ; 55   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 316  00b0 7b03          	ld	a,(OFST+1,sp)
 317  00b2 8d000000      	callf	f_I2C_SendData
 320  00b6               L331:
 321                     ; 56   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 323  00b6 ae0784        	ldw	x,#1924
 324  00b9 8d000000      	callf	f_I2C_CheckEvent
 326  00bd 4d            	tnz	a
 327  00be 27f6          	jreq	L331
 328                     ; 58   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 330  00c0 7b04          	ld	a,(OFST+2,sp)
 331  00c2 a4ff          	and	a,#255
 332  00c4 8d000000      	callf	f_I2C_SendData
 335  00c8               L141:
 336                     ; 59   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 338  00c8 ae0784        	ldw	x,#1924
 339  00cb 8d000000      	callf	f_I2C_CheckEvent
 341  00cf 4d            	tnz	a
 342  00d0 27f6          	jreq	L141
 343                     ; 62   I2C_GenerateSTART (ENABLE);
 345  00d2 a601          	ld	a,#1
 346  00d4 8d000000      	callf	f_I2C_GenerateSTART
 349  00d8               L741:
 350                     ; 63   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 352  00d8 ae0301        	ldw	x,#769
 353  00db 8d000000      	callf	f_I2C_CheckEvent
 355  00df 4d            	tnz	a
 356  00e0 27f6          	jreq	L741
 357                     ; 65   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
 359  00e2 aea101        	ldw	x,#41217
 360  00e5 8d000000      	callf	f_I2C_Send7bitAddress
 363  00e9               L551:
 364                     ; 66   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
 366  00e9 ae0302        	ldw	x,#770
 367  00ec 8d000000      	callf	f_I2C_CheckEvent
 369  00f0 4d            	tnz	a
 370  00f1 27f6          	jreq	L551
 372  00f3               L361:
 373                     ; 68   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED) == ERROR);
 375  00f3 ae0340        	ldw	x,#832
 376  00f6 8d000000      	callf	f_I2C_CheckEvent
 378  00fa 4d            	tnz	a
 379  00fb 27f6          	jreq	L361
 380                     ; 69   receivedData = I2C_ReceiveData ();
 382  00fd 8d000000      	callf	f_I2C_ReceiveData
 384  0101 6b02          	ld	(OFST+0,sp),a
 386                     ; 71   I2C_GenerateSTOP (ENABLE);
 388  0103 a601          	ld	a,#1
 389  0105 8d000000      	callf	f_I2C_GenerateSTOP
 391                     ; 73   return receivedData;
 393  0109 7b02          	ld	a,(OFST+0,sp)
 396  010b 5b04          	addw	sp,#4
 397  010d 87            	retf
 467                     ; 76 char* EEPROM_ReadString (uint16_t memoryAddress, char* buffer)  //Changed from no return to char*
 467                     ; 77 {
 468                     	switch	.text
 469  010e               f_EEPROM_ReadString:
 471  010e 89            	pushw	x
 472  010f 5203          	subw	sp,#3
 473       00000003      OFST:	set	3
 476                     ; 78   uint8_t tempData = 0;
 478                     ; 79   uint8_t i = 0;
 480  0111 0f03          	clr	(OFST+0,sp)
 482                     ; 81   I2C_GenerateSTART (ENABLE);
 484  0113 a601          	ld	a,#1
 485  0115 8d000000      	callf	f_I2C_GenerateSTART
 488  0119               L712:
 489                     ; 82   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 491  0119 ae0301        	ldw	x,#769
 492  011c 8d000000      	callf	f_I2C_CheckEvent
 494  0120 4d            	tnz	a
 495  0121 27f6          	jreq	L712
 496                     ; 84   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 498  0123 aea000        	ldw	x,#40960
 499  0126 8d000000      	callf	f_I2C_Send7bitAddress
 502  012a               L522:
 503                     ; 85   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 505  012a ae0782        	ldw	x,#1922
 506  012d 8d000000      	callf	f_I2C_CheckEvent
 508  0131 4d            	tnz	a
 509  0132 27f6          	jreq	L522
 510                     ; 87   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 512  0134 7b04          	ld	a,(OFST+1,sp)
 513  0136 8d000000      	callf	f_I2C_SendData
 516  013a               L332:
 517                     ; 88   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 519  013a ae0784        	ldw	x,#1924
 520  013d 8d000000      	callf	f_I2C_CheckEvent
 522  0141 4d            	tnz	a
 523  0142 27f6          	jreq	L332
 524                     ; 90   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 526  0144 7b05          	ld	a,(OFST+2,sp)
 527  0146 a4ff          	and	a,#255
 528  0148 8d000000      	callf	f_I2C_SendData
 531  014c               L142:
 532                     ; 91   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 534  014c ae0784        	ldw	x,#1924
 535  014f 8d000000      	callf	f_I2C_CheckEvent
 537  0153 4d            	tnz	a
 538  0154 27f6          	jreq	L142
 539                     ; 94   I2C_GenerateSTART (ENABLE);
 541  0156 a601          	ld	a,#1
 542  0158 8d000000      	callf	f_I2C_GenerateSTART
 545  015c               L742:
 546                     ; 95   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 548  015c ae0301        	ldw	x,#769
 549  015f 8d000000      	callf	f_I2C_CheckEvent
 551  0163 4d            	tnz	a
 552  0164 27f6          	jreq	L742
 553                     ; 97   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
 555  0166 aea101        	ldw	x,#41217
 556  0169 8d000000      	callf	f_I2C_Send7bitAddress
 559  016d               L552:
 560                     ; 98   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
 562  016d ae0302        	ldw	x,#770
 563  0170 8d000000      	callf	f_I2C_CheckEvent
 565  0174 4d            	tnz	a
 566  0175 27f6          	jreq	L552
 567  0177               L162:
 568                     ; 101     if (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED))
 570  0177 ae0340        	ldw	x,#832
 571  017a 8d000000      	callf	f_I2C_CheckEvent
 573  017e 4d            	tnz	a
 574  017f 27f6          	jreq	L162
 575                     ; 103       uint8_t tempData = I2C_ReceiveData ();
 577  0181 8d000000      	callf	f_I2C_ReceiveData
 579  0185 6b01          	ld	(OFST-2,sp),a
 581                     ; 104       if (tempData == '\0')
 583  0187 0d01          	tnz	(OFST-2,sp)
 584  0189 2616          	jrne	L762
 585                     ; 106         I2C_AcknowledgeConfig (I2C_ACK_NONE);
 587  018b 4f            	clr	a
 588  018c 8d000000      	callf	f_I2C_AcknowledgeConfig
 590                     ; 107         I2C_GenerateSTOP (ENABLE);
 592  0190 a601          	ld	a,#1
 593  0192 8d000000      	callf	f_I2C_GenerateSTOP
 595                     ; 108         break;
 596                     ; 114   buffer[i] = '\0';
 598  0196 7b03          	ld	a,(OFST+0,sp)
 599  0198 5f            	clrw	x
 600  0199 97            	ld	xl,a
 601  019a 72fb09        	addw	x,(OFST+6,sp)
 602  019d 7f            	clr	(x)
 603                     ; 117 }
 606  019e 5b05          	addw	sp,#5
 607  01a0 87            	retf
 608  01a1               L762:
 609                     ; 111         buffer[i++] = tempData;
 611  01a1 7b03          	ld	a,(OFST+0,sp)
 612  01a3 97            	ld	xl,a
 613  01a4 0c03          	inc	(OFST+0,sp)
 615  01a6 9f            	ld	a,xl
 616  01a7 5f            	clrw	x
 617  01a8 97            	ld	xl,a
 618  01a9 72fb09        	addw	x,(OFST+6,sp)
 619  01ac 7b01          	ld	a,(OFST-2,sp)
 620  01ae f7            	ld	(x),a
 621  01af 20c6          	jra	L162
 663                     ; 119 void EEPROM_WriteString (uint16_t memoryAddress, char *data)
 663                     ; 120 {
 664                     	switch	.text
 665  01b1               f_EEPROM_WriteString:
 667  01b1 89            	pushw	x
 668       00000000      OFST:	set	0
 671  01b2 2019          	jra	L513
 672  01b4               L313:
 673                     ; 123     EEPROM_WriteByte (memoryAddress, *data); // Write one character to EEPROM
 675  01b4 1e06          	ldw	x,(OFST+6,sp)
 676  01b6 f6            	ld	a,(x)
 677  01b7 88            	push	a
 678  01b8 1e02          	ldw	x,(OFST+2,sp)
 679  01ba 8d2a002a      	callf	f_EEPROM_WriteByte
 681  01be 84            	pop	a
 682                     ; 124     memoryAddress++; // Increment the address to write the next character
 684  01bf 1e01          	ldw	x,(OFST+1,sp)
 685  01c1 1c0001        	addw	x,#1
 686  01c4 1f01          	ldw	(OFST+1,sp),x
 687                     ; 125     data++; // Move to the next character in the string
 689  01c6 1e06          	ldw	x,(OFST+6,sp)
 690  01c8 1c0001        	addw	x,#1
 691  01cb 1f06          	ldw	(OFST+6,sp),x
 692  01cd               L513:
 693                     ; 121   while (*data)
 695  01cd 1e06          	ldw	x,(OFST+6,sp)
 696  01cf 7d            	tnz	(x)
 697  01d0 26e2          	jrne	L313
 698                     ; 128   EEPROM_WriteByte (memoryAddress, '\0');
 700  01d2 4b00          	push	#0
 701  01d4 1e02          	ldw	x,(OFST+2,sp)
 702  01d6 8d2a002a      	callf	f_EEPROM_WriteByte
 704  01da 84            	pop	a
 705                     ; 129 }
 708  01db 85            	popw	x
 709  01dc 87            	retf
 753                     ; 131 void EEPROM_LogData(const char *data)
 753                     ; 132 {
 754                     	switch	.text
 755  01dd               f_EEPROM_LogData:
 757  01dd 89            	pushw	x
 758  01de 89            	pushw	x
 759       00000002      OFST:	set	2
 762                     ; 133 	uint16_t memoryAddress = writePointer; // Start writing at the current write pointer
 764  01df ce0000        	ldw	x,_writePointer
 765  01e2 1f01          	ldw	(OFST-1,sp),x
 767                     ; 136 	EEPROM_WriteString(memoryAddress, data);
 769  01e4 1e03          	ldw	x,(OFST+1,sp)
 770  01e6 89            	pushw	x
 771  01e7 1e03          	ldw	x,(OFST+1,sp)
 772  01e9 8db101b1      	callf	f_EEPROM_WriteString
 774  01ed 85            	popw	x
 775                     ; 139 	writePointer += LOG_ENTRY_SIZE;
 777  01ee ce0000        	ldw	x,_writePointer
 778  01f1 1c0025        	addw	x,#37
 779  01f4 cf0000        	ldw	_writePointer,x
 780                     ; 142 	if (writePointer >= EEPROM_SIZE)
 782  01f7 ce0000        	ldw	x,_writePointer
 783  01fa a37d00        	cpw	x,#32000
 784  01fd 2504          	jrult	L143
 785                     ; 144 			writePointer = EEPROM_START_ADDRESS;
 787  01ff 5f            	clrw	x
 788  0200 cf0000        	ldw	_writePointer,x
 789  0203               L143:
 790                     ; 147 	printf("Data Logged: %s at address: 0x%04X\n", data, memoryAddress);
 792  0203 1e01          	ldw	x,(OFST-1,sp)
 793  0205 89            	pushw	x
 794  0206 1e05          	ldw	x,(OFST+3,sp)
 795  0208 89            	pushw	x
 796  0209 ae00dc        	ldw	x,#L343
 797  020c 8d000000      	callf	f_printf
 799  0210 5b04          	addw	sp,#4
 800                     ; 148 }
 803  0212 5b04          	addw	sp,#4
 804  0214 87            	retf
 844                     ; 150 void EEPROM_ReadData(void)
 844                     ; 151 {
 845                     	switch	.text
 846  0215               f_EEPROM_ReadData:
 848  0215 5203          	subw	sp,#3
 849       00000003      OFST:	set	3
 852                     ; 152 	uint16_t memoryAddress = EEPROM_START_ADDRESS; // Start at the beginning of EEPROM
 854  0217 5f            	clrw	x
 855  0218 1f01          	ldw	(OFST-2,sp),x
 857  021a               L363:
 858                     ; 159 			data = EEPROM_ReadByte(memoryAddress);
 860  021a 1e01          	ldw	x,(OFST-2,sp)
 861  021c 8d8d008d      	callf	f_EEPROM_ReadByte
 863  0220 6b03          	ld	(OFST+0,sp),a
 865                     ; 162 			if (data >= 33 && data <= 122) // Printable ASCII range
 867  0222 7b03          	ld	a,(OFST+0,sp)
 868  0224 a121          	cp	a,#33
 869  0226 2511          	jrult	L173
 871  0228 7b03          	ld	a,(OFST+0,sp)
 872  022a a17b          	cp	a,#123
 873  022c 240b          	jruge	L173
 874                     ; 164 					printf("%c", data); // Print the character directly
 876  022e 7b03          	ld	a,(OFST+0,sp)
 877  0230 88            	push	a
 878  0231 ae00d9        	ldw	x,#L373
 879  0234 8d000000      	callf	f_printf
 881  0238 84            	pop	a
 882  0239               L173:
 883                     ; 167 			memoryAddress++;
 885  0239 1e01          	ldw	x,(OFST-2,sp)
 886  023b 1c0001        	addw	x,#1
 887  023e 1f01          	ldw	(OFST-2,sp),x
 889                     ; 156 	while (memoryAddress < EEPROM_SIZE) // Loop until the end of the EEPROM
 891  0240 1e01          	ldw	x,(OFST-2,sp)
 892  0242 a37d00        	cpw	x,#32000
 893  0245 25d3          	jrult	L363
 894                     ; 169 	printf("\nDone reading EEPROM.\n");
 896  0247 ae00c2        	ldw	x,#L573
 897  024a 8d000000      	callf	f_printf
 899                     ; 170 }
 902  024e 5b03          	addw	sp,#3
 903  0250 87            	retf
 944                     ; 172 void EEPROM_Init(uint8_t defaultValue)
 944                     ; 173 {
 945                     	switch	.text
 946  0251               f_EEPROM_Init:
 948  0251 88            	push	a
 949  0252 89            	pushw	x
 950       00000002      OFST:	set	2
 953                     ; 174 	uint16_t address = 0;
 955                     ; 175 	for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
 957  0253 5f            	clrw	x
 958  0254 1f01          	ldw	(OFST-1,sp),x
 960  0256               L514:
 961                     ; 177 			EEPROM_WriteByte(address, defaultValue);
 963  0256 7b03          	ld	a,(OFST+1,sp)
 964  0258 88            	push	a
 965  0259 1e02          	ldw	x,(OFST+0,sp)
 966  025b 8d2a002a      	callf	f_EEPROM_WriteByte
 968  025f 84            	pop	a
 969                     ; 175 	for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
 971  0260 1e01          	ldw	x,(OFST-1,sp)
 972  0262 1c0001        	addw	x,#1
 973  0265 1f01          	ldw	(OFST-1,sp),x
 977  0267 1e01          	ldw	x,(OFST-1,sp)
 978  0269 a37d00        	cpw	x,#32000
 979  026c 25e8          	jrult	L514
 980                     ; 180 	writePointer = EEPROM_START_ADDRESS; // Reset pointer
 982  026e 5f            	clrw	x
 983  026f cf0000        	ldw	_writePointer,x
 984                     ; 181 	printf("EEPROM Initialized. All values set to: 0x%02X\n", defaultValue);
 986  0272 7b03          	ld	a,(OFST+1,sp)
 987  0274 88            	push	a
 988  0275 ae0093        	ldw	x,#L324
 989  0278 8d000000      	callf	f_printf
 991  027c 84            	pop	a
 992                     ; 182 }
 995  027d 5b03          	addw	sp,#3
 996  027f 87            	retf
1045                     ; 184 void EEPROM_Test (void)
1045                     ; 185 {
1046                     	switch	.text
1047  0280               f_EEPROM_Test:
1049  0280 5204          	subw	sp,#4
1050       00000004      OFST:	set	4
1053                     ; 186   uint16_t memoryAddress = 0x0000; // EEPROM memory address to write/read
1055  0282 5f            	clrw	x
1056  0283 1f02          	ldw	(OFST-2,sp),x
1058                     ; 187   uint8_t dataToWrite = 0xAB; // Data to write
1060  0285 a6ab          	ld	a,#171
1061  0287 6b04          	ld	(OFST+0,sp),a
1063                     ; 190   EEPROM_Config (); // Initialize I2C peripheral
1065  0289 8d000000      	callf	f_EEPROM_Config
1067                     ; 193   EEPROM_WriteByte (memoryAddress, dataToWrite);
1069  028d 7b04          	ld	a,(OFST+0,sp)
1070  028f 88            	push	a
1071  0290 1e03          	ldw	x,(OFST-1,sp)
1072  0292 8d2a002a      	callf	f_EEPROM_WriteByte
1074  0296 84            	pop	a
1075                     ; 194   printf ("Writing Finished\n");
1077  0297 ae0081        	ldw	x,#L544
1078  029a 8d000000      	callf	f_printf
1080                     ; 197   printf ("Reading Starting\n");
1082  029e ae006f        	ldw	x,#L744
1083  02a1 8d000000      	callf	f_printf
1085                     ; 199   dataRead = EEPROM_ReadByte (memoryAddress);
1087  02a5 1e02          	ldw	x,(OFST-2,sp)
1088  02a7 8d8d008d      	callf	f_EEPROM_ReadByte
1090  02ab 6b01          	ld	(OFST-3,sp),a
1092                     ; 202   if (dataRead == dataToWrite)
1094  02ad 7b01          	ld	a,(OFST-3,sp)
1095  02af 1104          	cp	a,(OFST+0,sp)
1096  02b1 2609          	jrne	L154
1097                     ; 204     printf ("Success");
1099  02b3 ae0067        	ldw	x,#L354
1100  02b6 8d000000      	callf	f_printf
1103  02ba 2007          	jra	L554
1104  02bc               L154:
1105                     ; 208     printf ("YOU FAIL");
1107  02bc ae005e        	ldw	x,#L754
1108  02bf 8d000000      	callf	f_printf
1110  02c3               L554:
1111                     ; 210 }
1114  02c3 5b04          	addw	sp,#4
1115  02c5 87            	retf
1207                     ; 213 bool read_from_eeprom(uint16_t start_addr, char* buffer, uint16_t buffer_size) {
1208                     	switch	.text
1209  02c6               f_read_from_eeprom:
1211  02c6 89            	pushw	x
1212  02c7 5205          	subw	sp,#5
1213       00000005      OFST:	set	5
1216                     ; 214 	uint16_t addr = start_addr;
1218  02c9 1f04          	ldw	(OFST-1,sp),x
1220                     ; 215 	uint16_t i = 0;
1222  02cb 5f            	clrw	x
1223  02cc 1f02          	ldw	(OFST-3,sp),x
1225                     ; 216 	memset(buffer, 0, buffer_size);		
1227  02ce 1e0b          	ldw	x,(OFST+6,sp)
1228  02d0 bf00          	ldw	c_x,x
1229  02d2 1e0d          	ldw	x,(OFST+8,sp)
1230  02d4 5d            	tnzw	x
1231  02d5 2707          	jreq	L03
1232  02d7               L23:
1233  02d7 5a            	decw	x
1234  02d8 926f00        	clr	([c_x.w],x)
1235  02db 5d            	tnzw	x
1236  02dc 26f9          	jrne	L23
1237  02de               L03:
1239  02de 2036          	jra	L325
1240  02e0               L125:
1241                     ; 219 			char ch = EEPROM_ReadByte(addr);
1243  02e0 1e04          	ldw	x,(OFST-1,sp)
1244  02e2 8d8d008d      	callf	f_EEPROM_ReadByte
1246  02e6 6b01          	ld	(OFST-4,sp),a
1248                     ; 220 			if (ch == '\0') {
1250  02e8 0d01          	tnz	(OFST-4,sp)
1251  02ea 2731          	jreq	L525
1252                     ; 221 					break;
1254                     ; 225 			if (ch < 32 && ch >126){
1256  02ec 7b01          	ld	a,(OFST-4,sp)
1257  02ee a120          	cp	a,#32
1258  02f0 2406          	jruge	L135
1260  02f2 7b01          	ld	a,(OFST-4,sp)
1261  02f4 a17f          	cp	a,#127
1262  02f6 2425          	jruge	L525
1263                     ; 226 					break; // Exit if we encounter the default value
1265  02f8               L135:
1266                     ; 229 			if (i < (buffer_size - 1)) {
1268  02f8 1e0d          	ldw	x,(OFST+8,sp)
1269  02fa 5a            	decw	x
1270  02fb 1302          	cpw	x,(OFST-3,sp)
1271  02fd 231e          	jrule	L525
1272                     ; 230 					buffer[i++] = ch;
1274  02ff 7b01          	ld	a,(OFST-4,sp)
1275  0301 1e02          	ldw	x,(OFST-3,sp)
1276  0303 1c0001        	addw	x,#1
1277  0306 1f02          	ldw	(OFST-3,sp),x
1278  0308 1d0001        	subw	x,#1
1280  030b 72fb0b        	addw	x,(OFST+6,sp)
1281  030e f7            	ld	(x),a
1283                     ; 234 			addr++;
1285  030f 1e04          	ldw	x,(OFST-1,sp)
1286  0311 1c0001        	addw	x,#1
1287  0314 1f04          	ldw	(OFST-1,sp),x
1289  0316               L325:
1290                     ; 218 	while (addr < EEPROM_START_ADDRESS + EEPROM_SIZE) {
1292  0316 1e04          	ldw	x,(OFST-1,sp)
1293  0318 a37d00        	cpw	x,#32000
1294  031b 25c3          	jrult	L125
1295  031d               L525:
1296                     ; 236 	return true;
1298  031d a601          	ld	a,#1
1301  031f 5b07          	addw	sp,#7
1302  0321 87            	retf
1349                     ; 239 void process_eeprom_logs() {
1350                     	switch	.text
1351  0322               f_process_eeprom_logs:
1353  0322 5234          	subw	sp,#52
1354       00000034      OFST:	set	52
1357                     ; 241 	uint16_t current_addr = EEPROM_START_ADDRESS;
1359  0324 5f            	clrw	x
1360  0325 1f01          	ldw	(OFST-51,sp),x
1362                     ; 242 	printf("Reading from EEPROM:\n");
1364  0327 ae0048        	ldw	x,#L755
1365  032a 8d000000      	callf	f_printf
1367                     ; 243 	EEPROM_ReadString(0x0000, buffer);
1369  032e 96            	ldw	x,sp
1370  032f 1c0003        	addw	x,#OFST-49
1371  0332 89            	pushw	x
1372  0333 5f            	clrw	x
1373  0334 8d0e010e      	callf	f_EEPROM_ReadString
1375  0338 85            	popw	x
1377  0339 2054          	jra	L365
1378  033b               L165:
1379                     ; 246 		if (!read_from_eeprom(current_addr, buffer, BATCH_BUFFER_SIZE)) {
1381  033b ae0032        	ldw	x,#50
1382  033e 89            	pushw	x
1383  033f 96            	ldw	x,sp
1384  0340 1c0005        	addw	x,#OFST-47
1385  0343 89            	pushw	x
1386  0344 1e05          	ldw	x,(OFST-47,sp)
1387  0346 8dc602c6      	callf	f_read_from_eeprom
1389  034a 5b04          	addw	sp,#4
1390  034c 4d            	tnz	a
1391  034d 260d          	jrne	L765
1392                     ; 247 				printf("Error reading from EEPROM at address: 0x%04X\n", current_addr);
1394  034f 1e01          	ldw	x,(OFST-51,sp)
1395  0351 89            	pushw	x
1396  0352 ae001a        	ldw	x,#L175
1397  0355 8d000000      	callf	f_printf
1399  0359 85            	popw	x
1400                     ; 248 				break; // Stop reading on error
1402  035a 203a          	jra	L565
1403  035c               L765:
1404                     ; 252 		if (strlen(buffer) > 0 && checkString(buffer)) {
1406  035c 96            	ldw	x,sp
1407  035d 1c0003        	addw	x,#OFST-49
1408  0360 8d000000      	callf	f_strlen
1410  0364 a30000        	cpw	x,#0
1411  0367 272d          	jreq	L565
1413  0369 96            	ldw	x,sp
1414  036a 1c0003        	addw	x,#OFST-49
1415  036d 8dd403d4      	callf	f_checkString
1417  0371 4d            	tnz	a
1418  0372 2722          	jreq	L565
1419                     ; 253 				printf("%s\n", buffer); // Print valid log data to the serial monitor
1421  0374 96            	ldw	x,sp
1422  0375 1c0003        	addw	x,#OFST-49
1423  0378 89            	pushw	x
1424  0379 ae0016        	ldw	x,#L575
1425  037c 8d000000      	callf	f_printf
1427  0380 85            	popw	x
1429                     ; 258 		current_addr += strlen(buffer) + 1; // +1 to skip the null terminator
1431  0381 96            	ldw	x,sp
1432  0382 1c0003        	addw	x,#OFST-49
1433  0385 8d000000      	callf	f_strlen
1435  0389 5c            	incw	x
1436  038a 72fb01        	addw	x,(OFST-51,sp)
1437  038d 1f01          	ldw	(OFST-51,sp),x
1439  038f               L365:
1440                     ; 244 	while (current_addr < EEPROM_START_ADDRESS + EEPROM_SIZE) {
1442  038f 1e01          	ldw	x,(OFST-51,sp)
1443  0391 a37d00        	cpw	x,#32000
1444  0394 25a5          	jrult	L165
1445  0396               L565:
1446                     ; 260 }
1449  0396 5b34          	addw	sp,#52
1450  0398 87            	retf
1488                     ; 262 void log_to_eeprom(const char* str) {
1489                     	switch	.text
1490  0399               f_log_to_eeprom:
1492  0399 89            	pushw	x
1493  039a 89            	pushw	x
1494       00000002      OFST:	set	2
1497                     ; 263 	if ((writePointer + strlen(str) + 1) >= (EEPROM_START_ADDRESS + EEPROM_SIZE)) {
1499  039b 8d000000      	callf	f_strlen
1501  039f 72bb0000      	addw	x,_writePointer
1502  03a3 5c            	incw	x
1503  03a4 a37d00        	cpw	x,#32000
1504  03a7 250b          	jrult	L716
1505                     ; 264 			writePointer = EEPROM_START_ADDRESS;
1507  03a9 5f            	clrw	x
1508  03aa cf0000        	ldw	_writePointer,x
1509                     ; 265 			printf("EEPROM out of space.\n");
1511  03ad ae0000        	ldw	x,#L126
1512  03b0 8d000000      	callf	f_printf
1514  03b4               L716:
1515                     ; 267 	EEPROM_WriteString(writePointer, str);
1517  03b4 1e03          	ldw	x,(OFST+1,sp)
1518  03b6 89            	pushw	x
1519  03b7 ce0000        	ldw	x,_writePointer
1520  03ba 8db101b1      	callf	f_EEPROM_WriteString
1522  03be 85            	popw	x
1523                     ; 268 	writePointer += strlen(str) + 1;
1525  03bf 1e03          	ldw	x,(OFST+1,sp)
1526  03c1 8d000000      	callf	f_strlen
1528  03c5 5c            	incw	x
1529  03c6 1f01          	ldw	(OFST-1,sp),x
1531  03c8 ce0000        	ldw	x,_writePointer
1532  03cb 72fb01        	addw	x,(OFST-1,sp)
1533  03ce cf0000        	ldw	_writePointer,x
1534                     ; 269 }
1537  03d1 5b04          	addw	sp,#4
1538  03d3 87            	retf
1591                     ; 271 bool checkString(const char* str)
1591                     ; 272 {
1592                     	switch	.text
1593  03d4               f_checkString:
1595  03d4 89            	pushw	x
1596  03d5 89            	pushw	x
1597       00000002      OFST:	set	2
1600                     ; 273 	bool flag = 0;
1602  03d6 0f01          	clr	(OFST-1,sp)
1604                     ; 274 	uint8_t i  = 0;
1606                     ; 275 	for (i = 1; i < strlen(str); i++) {
1608  03d8 a601          	ld	a,#1
1609  03da 6b02          	ld	(OFST+0,sp),a
1612  03dc 2018          	jra	L356
1613  03de               L746:
1614                     ; 276 		if (str[i] != str[0]) {
1616  03de 7b02          	ld	a,(OFST+0,sp)
1617  03e0 5f            	clrw	x
1618  03e1 97            	ld	xl,a
1619  03e2 72fb03        	addw	x,(OFST+1,sp)
1620  03e5 f6            	ld	a,(x)
1621  03e6 1e03          	ldw	x,(OFST+1,sp)
1622  03e8 f1            	cp	a,(x)
1623  03e9 2709          	jreq	L756
1624                     ; 277 				flag = 1;
1626  03eb a601          	ld	a,#1
1627  03ed 6b01          	ld	(OFST-1,sp),a
1629                     ; 278 				break;
1630  03ef               L556:
1631                     ; 281 return flag;
1633  03ef 7b01          	ld	a,(OFST-1,sp)
1636  03f1 5b04          	addw	sp,#4
1637  03f3 87            	retf
1638  03f4               L756:
1639                     ; 275 	for (i = 1; i < strlen(str); i++) {
1641  03f4 0c02          	inc	(OFST+0,sp)
1643  03f6               L356:
1646  03f6 1e03          	ldw	x,(OFST+1,sp)
1647  03f8 8d000000      	callf	f_strlen
1649  03fc 7b02          	ld	a,(OFST+0,sp)
1650  03fe 905f          	clrw	y
1651  0400 9097          	ld	yl,a
1652  0402 90bf00        	ldw	c_y,y
1653  0405 b300          	cpw	x,c_y
1654  0407 22d5          	jrugt	L746
1655  0409 20e4          	jra	L556
1678                     	xdef	f_checkString
1679                     	xdef	f_log_to_eeprom
1680                     	xdef	f_process_eeprom_logs
1681                     	xdef	f_read_from_eeprom
1682                     	xdef	f_EEPROM_Test
1683                     	xdef	f_EEPROM_Init
1684                     	xdef	f_EEPROM_LogData
1685                     	xdef	f_EEPROM_ReadData
1686                     	xdef	f_EEPROM_WriteString
1687                     	xdef	f_EEPROM_ReadString
1688                     	xdef	f_EEPROM_ReadByte
1689                     	xdef	f_EEPROM_WriteByte
1690                     	xdef	f_EEPROM_Config
1691                     	xdef	_writePointer
1692                     	xref	f_strlen
1693                     	xref	f_I2C_CheckEvent
1694                     	xref	f_I2C_SendData
1695                     	xref	f_I2C_Send7bitAddress
1696                     	xref	f_I2C_ReceiveData
1697                     	xref	f_I2C_AcknowledgeConfig
1698                     	xref	f_I2C_GenerateSTOP
1699                     	xref	f_I2C_GenerateSTART
1700                     	xref	f_I2C_Cmd
1701                     	xref	f_I2C_Init
1702                     	xref	f_I2C_DeInit
1703                     	xref	f_delay_ms
1704                     	xref	f_printf
1705                     	xref	f_CLK_PeripheralClockConfig
1706                     .const:	section	.text
1707  0000               L126:
1708  0000 454550524f4d  	dc.b	"EEPROM out of spac"
1709  0012 652e0a00      	dc.b	"e.",10,0
1710  0016               L575:
1711  0016 25730a00      	dc.b	"%s",10,0
1712  001a               L175:
1713  001a 4572726f7220  	dc.b	"Error reading from"
1714  002c 20454550524f  	dc.b	" EEPROM at address"
1715  003e 3a2030782530  	dc.b	": 0x%04X",10,0
1716  0048               L755:
1717  0048 52656164696e  	dc.b	"Reading from EEPRO"
1718  005a 4d3a0a00      	dc.b	"M:",10,0
1719  005e               L754:
1720  005e 594f55204641  	dc.b	"YOU FAIL",0
1721  0067               L354:
1722  0067 537563636573  	dc.b	"Success",0
1723  006f               L744:
1724  006f 52656164696e  	dc.b	"Reading Starting",10,0
1725  0081               L544:
1726  0081 57726974696e  	dc.b	"Writing Finished",10,0
1727  0093               L324:
1728  0093 454550524f4d  	dc.b	"EEPROM Initialized"
1729  00a5 2e20416c6c20  	dc.b	". All values set t"
1730  00b7 6f3a20307825  	dc.b	"o: 0x%02X",10,0
1731  00c2               L573:
1732  00c2 0a446f6e6520  	dc.b	10,68,111,110,101,32
1733  00c8 72656164696e  	dc.b	"reading EEPROM.",10,0
1734  00d9               L373:
1735  00d9 256300        	dc.b	"%c",0
1736  00dc               L343:
1737  00dc 44617461204c  	dc.b	"Data Logged: %s at"
1738  00ee 206164647265  	dc.b	" address: 0x%04X",10,0
1739                     	xref.b	c_x
1740                     	xref.b	c_y
1760                     	end
