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
 514                     ; 79 void EEPROM_ReadString (uint16_t memoryAddress, char* buffer)
 514                     ; 80 {
 515                     	switch	.text
 516  012f               f_EEPROM_ReadString:
 518  012f 89            	pushw	x
 519  0130 5203          	subw	sp,#3
 520       00000003      OFST:	set	3
 523                     ; 81   uint8_t tempData = 0;
 525                     ; 82   uint8_t i = 0;
 527  0132 0f03          	clr	(OFST+0,sp)
 529                     ; 84   I2C_GenerateSTART (ENABLE);
 531  0134 a601          	ld	a,#1
 532  0136 8d000000      	callf	f_I2C_GenerateSTART
 535  013a               L142:
 536                     ; 85   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 538  013a ae0301        	ldw	x,#769
 539  013d 8d000000      	callf	f_I2C_CheckEvent
 541  0141 4d            	tnz	a
 542  0142 27f6          	jreq	L142
 543                     ; 87   I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
 545  0144 aea000        	ldw	x,#40960
 546  0147 8d000000      	callf	f_I2C_Send7bitAddress
 549  014b               L742:
 550                     ; 88   while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
 552  014b ae0782        	ldw	x,#1922
 553  014e 8d000000      	callf	f_I2C_CheckEvent
 555  0152 4d            	tnz	a
 556  0153 27f6          	jreq	L742
 557                     ; 90   I2C_SendData ((uint8_t) (memoryAddress >> 8));
 559  0155 7b04          	ld	a,(OFST+1,sp)
 560  0157 8d000000      	callf	f_I2C_SendData
 563  015b               L552:
 564                     ; 91   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 566  015b ae0784        	ldw	x,#1924
 567  015e 8d000000      	callf	f_I2C_CheckEvent
 569  0162 4d            	tnz	a
 570  0163 27f6          	jreq	L552
 571                     ; 93   I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
 573  0165 7b05          	ld	a,(OFST+2,sp)
 574  0167 8d000000      	callf	f_I2C_SendData
 577  016b               L362:
 578                     ; 94   while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
 580  016b ae0784        	ldw	x,#1924
 581  016e 8d000000      	callf	f_I2C_CheckEvent
 583  0172 4d            	tnz	a
 584  0173 27f6          	jreq	L362
 585                     ; 97   I2C_GenerateSTART (ENABLE);
 587  0175 a601          	ld	a,#1
 588  0177 8d000000      	callf	f_I2C_GenerateSTART
 591  017b               L172:
 592                     ; 98   while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
 594  017b ae0301        	ldw	x,#769
 595  017e 8d000000      	callf	f_I2C_CheckEvent
 597  0182 4d            	tnz	a
 598  0183 27f6          	jreq	L172
 599                     ; 100   I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
 601  0185 aea101        	ldw	x,#41217
 602  0188 8d000000      	callf	f_I2C_Send7bitAddress
 605  018c               L772:
 606                     ; 101   while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
 608  018c ae0302        	ldw	x,#770
 609  018f 8d000000      	callf	f_I2C_CheckEvent
 611  0193 4d            	tnz	a
 612  0194 27f6          	jreq	L772
 613  0196               L303:
 614                     ; 104     if (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED))
 616  0196 ae0340        	ldw	x,#832
 617  0199 8d000000      	callf	f_I2C_CheckEvent
 619  019d 4d            	tnz	a
 620  019e 27f6          	jreq	L303
 621                     ; 106       uint8_t tempData = I2C_ReceiveData ();
 623  01a0 8d000000      	callf	f_I2C_ReceiveData
 625  01a4 6b01          	ld	(OFST-2,sp),a
 627                     ; 107       if (tempData == '\0')
 629  01a6 261c          	jrne	L113
 630                     ; 109         I2C_AcknowledgeConfig (I2C_ACK_NONE);
 632  01a8 8d000000      	callf	f_I2C_AcknowledgeConfig
 634                     ; 110         I2C_GenerateSTOP (ENABLE);
 636  01ac a601          	ld	a,#1
 637  01ae 8d000000      	callf	f_I2C_GenerateSTOP
 639                     ; 111         break;
 640                     ; 117   buffer[i] = '\0';
 642  01b2 7b03          	ld	a,(OFST+0,sp)
 643  01b4 5f            	clrw	x
 644  01b5 97            	ld	xl,a
 645  01b6 72fb09        	addw	x,(OFST+6,sp)
 646  01b9 7f            	clr	(x)
 647                     ; 119   delay_ms (5);
 649  01ba ae0005        	ldw	x,#5
 650  01bd 8d000000      	callf	f_delay_ms
 652                     ; 120 }
 655  01c1 5b05          	addw	sp,#5
 656  01c3 87            	retf	
 657  01c4               L113:
 658                     ; 114         buffer[i++] = tempData;
 660  01c4 7b03          	ld	a,(OFST+0,sp)
 661  01c6 0c03          	inc	(OFST+0,sp)
 663  01c8 5f            	clrw	x
 664  01c9 97            	ld	xl,a
 665  01ca 72fb09        	addw	x,(OFST+6,sp)
 666  01cd 7b01          	ld	a,(OFST-2,sp)
 667  01cf f7            	ld	(x),a
 668  01d0 20c4          	jra	L303
 712                     ; 122 void EEPROM_WriteString (uint16_t memoryAddress, char *data)
 712                     ; 123 {
 713                     	switch	.text
 714  01d2               f_EEPROM_WriteString:
 716  01d2 89            	pushw	x
 717       00000000      OFST:	set	0
 720  01d3 1e06          	ldw	x,(OFST+6,sp)
 721  01d5 2012          	jra	L143
 722  01d7               L733:
 723                     ; 126     EEPROM_WriteByte (memoryAddress, *data); // Write one character to EEPROM
 725  01d7 88            	push	a
 726  01d8 1e02          	ldw	x,(OFST+2,sp)
 727  01da 8d480048      	callf	f_EEPROM_WriteByte
 729  01de 84            	pop	a
 730                     ; 127     memoryAddress++; // Increment the address to write the next character
 732  01df 1e01          	ldw	x,(OFST+1,sp)
 733  01e1 5c            	incw	x
 734  01e2 1f01          	ldw	(OFST+1,sp),x
 735                     ; 128     data++; // Move to the next character in the string
 737  01e4 1e06          	ldw	x,(OFST+6,sp)
 738  01e6 5c            	incw	x
 739  01e7 1f06          	ldw	(OFST+6,sp),x
 740  01e9               L143:
 741                     ; 124   while (*data)
 743  01e9 f6            	ld	a,(x)
 744  01ea 26eb          	jrne	L733
 745                     ; 131   EEPROM_WriteByte (memoryAddress, '\0');
 747  01ec 4b00          	push	#0
 748  01ee 1e02          	ldw	x,(OFST+2,sp)
 749  01f0 8d480048      	callf	f_EEPROM_WriteByte
 751                     ; 132 }
 754  01f4 5b03          	addw	sp,#3
 755  01f6 87            	retf	
 801                     ; 134 void EEPROM_LogData(const char *data)
 801                     ; 135 {
 802                     	switch	.text
 803  01f7               f_EEPROM_LogData:
 805  01f7 89            	pushw	x
 806  01f8 89            	pushw	x
 807       00000002      OFST:	set	2
 810                     ; 136 	uint16_t memoryAddress = writePointer; // Start writing at the current write pointer
 812  01f9 be00          	ldw	x,_writePointer
 813  01fb 1f01          	ldw	(OFST-1,sp),x
 815                     ; 139 	EEPROM_WriteString(memoryAddress, data);
 817  01fd 1e03          	ldw	x,(OFST+1,sp)
 818  01ff 89            	pushw	x
 819  0200 1e03          	ldw	x,(OFST+1,sp)
 820  0202 8dd201d2      	callf	f_EEPROM_WriteString
 822  0206 85            	popw	x
 823                     ; 142 	writePointer += LOG_ENTRY_SIZE;
 825  0207 be00          	ldw	x,_writePointer
 826  0209 1c0025        	addw	x,#37
 827  020c bf00          	ldw	_writePointer,x
 828                     ; 145 	if (writePointer >= EEPROM_SIZE)
 830  020e be00          	ldw	x,_writePointer
 831  0210 a37d00        	cpw	x,#32000
 832  0213 2503          	jrult	L763
 833                     ; 147 			writePointer = EEPROM_START_ADDRESS;
 835  0215 5f            	clrw	x
 836  0216 bf00          	ldw	_writePointer,x
 837  0218               L763:
 838                     ; 150 	printf("Data Logged: %s at address: 0x%04X\n", data, memoryAddress);
 840  0218 1e01          	ldw	x,(OFST-1,sp)
 841  021a 89            	pushw	x
 842  021b 1e05          	ldw	x,(OFST+3,sp)
 843  021d 89            	pushw	x
 844  021e ae0064        	ldw	x,#L173
 845  0221 8d000000      	callf	f_printf
 847  0225 5b08          	addw	sp,#8
 848                     ; 151 }
 851  0227 87            	retf	
 897                     ; 153 void EEPROM_ReadData(const char *data)
 897                     ; 154 {
 898                     	switch	.text
 899  0228               f_EEPROM_ReadData:
 901  0228 89            	pushw	x
 902  0229 89            	pushw	x
 903       00000002      OFST:	set	2
 906                     ; 155 	uint16_t memoryAddress = EEPROM_START_ADDRESS; // Start writing at the current write pointer
 908  022a 5f            	clrw	x
 909  022b 1f01          	ldw	(OFST-1,sp),x
 911                     ; 158 	EEPROM_ReadString(memoryAddress, data);
 913  022d 1e03          	ldw	x,(OFST+1,sp)
 914  022f 89            	pushw	x
 915  0230 5f            	clrw	x
 916  0231 8d2f012f      	callf	f_EEPROM_ReadString
 918  0235 85            	popw	x
 919                     ; 161 	writePointer += LOG_ENTRY_SIZE;
 921  0236 be00          	ldw	x,_writePointer
 922  0238 1c0025        	addw	x,#37
 923  023b bf00          	ldw	_writePointer,x
 924                     ; 164 	if (writePointer >= EEPROM_SIZE)
 926  023d be00          	ldw	x,_writePointer
 927  023f a37d00        	cpw	x,#32000
 928  0242 2503          	jrult	L514
 929                     ; 166 			writePointer = EEPROM_START_ADDRESS;
 931  0244 5f            	clrw	x
 932  0245 bf00          	ldw	_writePointer,x
 933  0247               L514:
 934                     ; 169 	printf("Data Logged: %s at address: 0x%04X\n", data, memoryAddress);
 936  0247 1e01          	ldw	x,(OFST-1,sp)
 937  0249 89            	pushw	x
 938  024a 1e05          	ldw	x,(OFST+3,sp)
 939  024c 89            	pushw	x
 940  024d ae0064        	ldw	x,#L173
 941  0250 8d000000      	callf	f_printf
 943  0254 5b08          	addw	sp,#8
 944                     ; 170 }
 947  0256 87            	retf	
 993                     ; 172 void EEPROM_Init(uint8_t defaultValue)
 993                     ; 173 {
 994                     	switch	.text
 995  0257               f_EEPROM_Init:
 997  0257 88            	push	a
 998  0258 89            	pushw	x
 999       00000002      OFST:	set	2
1002                     ; 174 	uint16_t address = 0;
1004                     ; 175 	for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
1006  0259 5f            	clrw	x
1007  025a 1f01          	ldw	(OFST-1,sp),x
1009  025c               L144:
1010                     ; 177 			EEPROM_WriteByte(address, defaultValue);
1012  025c 7b03          	ld	a,(OFST+1,sp)
1013  025e 88            	push	a
1014  025f 1e02          	ldw	x,(OFST+0,sp)
1015  0261 8d480048      	callf	f_EEPROM_WriteByte
1017  0265 ae0005        	ldw	x,#5
1018  0268 84            	pop	a
1019                     ; 178 			delay_ms(5); // Ensure write delay
1021  0269 8d000000      	callf	f_delay_ms
1023                     ; 175 	for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
1025  026d 1e01          	ldw	x,(OFST-1,sp)
1026  026f 5c            	incw	x
1027  0270 1f01          	ldw	(OFST-1,sp),x
1031  0272 a37d00        	cpw	x,#32000
1032  0275 25e5          	jrult	L144
1033                     ; 180 	writePointer = EEPROM_START_ADDRESS; // Reset pointer
1035  0277 5f            	clrw	x
1036  0278 bf00          	ldw	_writePointer,x
1037                     ; 181 	printf("EEPROM Initialized. All values set to: 0x%02X\n", defaultValue);
1039  027a 7b03          	ld	a,(OFST+1,sp)
1040  027c 88            	push	a
1041  027d ae0035        	ldw	x,#L744
1042  0280 8d000000      	callf	f_printf
1044  0284 5b04          	addw	sp,#4
1045                     ; 182 }
1048  0286 87            	retf	
1103                     ; 184 void EEPROM_Test (void)
1103                     ; 185 {
1104                     	switch	.text
1105  0287               f_EEPROM_Test:
1107  0287 5204          	subw	sp,#4
1108       00000004      OFST:	set	4
1111                     ; 186   uint16_t memoryAddress = 0x0000; // EEPROM memory address to write/read
1113  0289 5f            	clrw	x
1114  028a 1f02          	ldw	(OFST-2,sp),x
1116                     ; 187   uint8_t dataToWrite = 0xAB; // Data to write
1118  028c a6ab          	ld	a,#171
1119  028e 6b04          	ld	(OFST+0,sp),a
1121                     ; 190   EEPROM_Config (); // Initialize I2C peripheral
1123  0290 8d000000      	callf	f_EEPROM_Config
1125                     ; 193   EEPROM_WriteByte (memoryAddress, dataToWrite);
1127  0294 7b04          	ld	a,(OFST+0,sp)
1128  0296 88            	push	a
1129  0297 1e03          	ldw	x,(OFST-1,sp)
1130  0299 8d480048      	callf	f_EEPROM_WriteByte
1132  029d ae0023        	ldw	x,#L774
1133  02a0 84            	pop	a
1134                     ; 194   printf ("Writing Finished\n");
1136  02a1 8d000000      	callf	f_printf
1138                     ; 197   printf ("Reading Starting\n");
1140  02a5 ae0011        	ldw	x,#L105
1141  02a8 8d000000      	callf	f_printf
1143                     ; 199   dataRead = EEPROM_ReadByte (memoryAddress);
1145  02ac 1e02          	ldw	x,(OFST-2,sp)
1146  02ae 8da900a9      	callf	f_EEPROM_ReadByte
1148  02b2 6b01          	ld	(OFST-3,sp),a
1150                     ; 202   if (dataRead == dataToWrite)
1152  02b4 1104          	cp	a,(OFST+0,sp)
1153  02b6 2605          	jrne	L305
1154                     ; 204     printf ("Success");
1156  02b8 ae0009        	ldw	x,#L505
1159  02bb 2003          	jra	L705
1160  02bd               L305:
1161                     ; 208     printf ("YOU FAIL");
1163  02bd ae0000        	ldw	x,#L115
1165  02c0               L705:
1166  02c0 8d000000      	callf	f_printf
1167                     ; 210 }
1170  02c4 5b04          	addw	sp,#4
1171  02c6 87            	retf	
1194                     	xdef	f_EEPROM_Test
1195                     	xdef	f_EEPROM_Init
1196                     	xdef	f_EEPROM_LogData
1197                     	xdef	f_EEPROM_ReadData
1198                     	xdef	f_EEPROM_WriteString
1199                     	xdef	f_EEPROM_ReadString
1200                     	xdef	f_EEPROM_ReadByte
1201                     	xdef	f_EEPROM_WriteByte
1202                     	xdef	f_EEPROM_Config
1203                     	xdef	_writePointer
1204                     	xref	f_I2C_CheckEvent
1205                     	xref	f_I2C_SendData
1206                     	xref	f_I2C_Send7bitAddress
1207                     	xref	f_I2C_ReceiveData
1208                     	xref	f_I2C_AcknowledgeConfig
1209                     	xref	f_I2C_GenerateSTOP
1210                     	xref	f_I2C_GenerateSTART
1211                     	xref	f_I2C_Cmd
1212                     	xref	f_I2C_Init
1213                     	xref	f_I2C_DeInit
1214                     	xref	f_delay_ms
1215                     	xref	f_printf
1216                     	xref	f_GPIO_Init
1217                     	xref	f_GPIO_DeInit
1218                     	xref	f_CLK_PeripheralClockConfig
1219                     .const:	section	.text
1220  0000               L115:
1221  0000 594f55204641  	dc.b	"YOU FAIL",0
1222  0009               L505:
1223  0009 537563636573  	dc.b	"Success",0
1224  0011               L105:
1225  0011 52656164696e  	dc.b	"Reading Starting",10,0
1226  0023               L774:
1227  0023 57726974696e  	dc.b	"Writing Finished",10,0
1228  0035               L744:
1229  0035 454550524f4d  	dc.b	"EEPROM Initialized"
1230  0047 2e20416c6c20  	dc.b	". All values set t"
1231  0059 6f3a20307825  	dc.b	"o: 0x%02X",10,0
1232  0064               L173:
1233  0064 44617461204c  	dc.b	"Data Logged: %s at"
1234  0076 206164647265  	dc.b	" address: 0x%04X",10,0
1254                     	end
