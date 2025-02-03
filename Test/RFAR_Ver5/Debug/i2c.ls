   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  47                     ; 4 void I2CInit()
  47                     ; 5 {
  48                     	switch	.text
  49  0000               f_I2CInit:
  53                     ; 6     I2C_Init(100000, 0x00, I2C_DUTYCYCLE_2,
  53                     ; 7             I2C_ACK_NONE, I2C_ADDMODE_7BIT, 2);
  55  0000 4b02          	push	#2
  56  0002 4b00          	push	#0
  57  0004 4b00          	push	#0
  58  0006 4b00          	push	#0
  59  0008 5f            	clrw	x
  60  0009 89            	pushw	x
  61  000a ae86a0        	ldw	x,#34464
  62  000d 89            	pushw	x
  63  000e ae0001        	ldw	x,#1
  64  0011 89            	pushw	x
  65  0012 8d000000      	callf	f_I2C_Init
  67  0016 5b0a          	addw	sp,#10
  68                     ; 8 		I2C_Cmd(ENABLE);
  70  0018 a601          	ld	a,#1
  72                     ; 9 }
  75  001a ac000000      	jpf	f_I2C_Cmd
  98                     ; 11 void I2CDeinit()
  98                     ; 12 {
  99                     	switch	.text
 100  001e               f_I2CDeinit:
 104                     ; 13     I2C_DeInit();
 107                     ; 14 }
 110  001e ac000000      	jpf	f_I2C_DeInit
 193                     ; 16 void I2CWrite(uint8_t slave, uint8_t addr, uint8_t * buffer, uint8_t size)
 193                     ; 17 {
 194                     	switch	.text
 195  0022               f_I2CWrite:
 197  0022 89            	pushw	x
 198  0023 89            	pushw	x
 199       00000002      OFST:	set	2
 202                     ; 20 		uint8_t index = 0;
 204  0024 0f02          	clr	(OFST+0,sp)
 206                     ; 23     I2C_GenerateSTART(ENABLE);
 208  0026 a601          	ld	a,#1
 209  0028 8d000000      	callf	f_I2C_GenerateSTART
 212  002c               L57:
 213                     ; 25     while(!(I2C->SR1 & I2C_SR1_SB));
 215  002c 72015217fb    	btjf	21015,#0,L57
 216                     ; 28     I2C_Send7bitAddress(slave, I2C_DIRECTION_TX);
 218  0031 7b03          	ld	a,(OFST+1,sp)
 219  0033 5f            	clrw	x
 220  0034 95            	ld	xh,a
 221  0035 8d000000      	callf	f_I2C_Send7bitAddress
 224  0039               L301:
 225                     ; 30     while(!(I2C->SR1 & I2C_SR1_ADDR));
 227  0039 72035217fb    	btjf	21015,#1,L301
 228                     ; 32     reg = I2C->SR1;
 230  003e c65217        	ld	a,21015
 231  0041 6b01          	ld	(OFST-1,sp),a
 233                     ; 33     reg = I2C->SR3;
 235  0043 c65219        	ld	a,21017
 236  0046 6b01          	ld	(OFST-1,sp),a
 238                     ; 36     I2C_SendData(addr);
 240  0048 7b04          	ld	a,(OFST+2,sp)
 241  004a 8d000000      	callf	f_I2C_SendData
 244  004e               L111:
 245                     ; 37     while(!(I2C->SR1 & I2C_SR1_TXE));
 247  004e 720f5217fb    	btjf	21015,#7,L111
 249  0053 2015          	jra	L711
 250  0055               L511:
 251                     ; 41         size--;
 253  0055 0a0a          	dec	(OFST+8,sp)
 254                     ; 42         I2C_SendData(buffer[index]);
 256  0057 5f            	clrw	x
 257  0058 7b02          	ld	a,(OFST+0,sp)
 258  005a 97            	ld	xl,a
 259  005b 72fb08        	addw	x,(OFST+6,sp)
 260  005e f6            	ld	a,(x)
 261  005f 8d000000      	callf	f_I2C_SendData
 263                     ; 43         index++;
 265  0063 0c02          	inc	(OFST+0,sp)
 268  0065               L521:
 269                     ; 45         while(!(I2C->SR1 & I2C_SR1_TXE));
 271  0065 720f5217fb    	btjf	21015,#7,L521
 272  006a               L711:
 273                     ; 39     while(size)
 275  006a 7b0a          	ld	a,(OFST+8,sp)
 276  006c 26e7          	jrne	L511
 278  006e               L331:
 279                     ; 49     while(!(I2C->SR1 & I2C_SR1_BTF));
 281  006e 72055217fb    	btjf	21015,#2,L331
 282                     ; 53     I2C_GenerateSTOP(ENABLE);
 284  0073 a601          	ld	a,#1
 285  0075 8d000000      	callf	f_I2C_GenerateSTOP
 288  0079               L141:
 289                     ; 56     while((I2C->SR3 & I2C_SR3_MSL));
 291  0079 72005219fb    	btjt	21017,#0,L141
 292                     ; 58 }
 295  007e 5b04          	addw	sp,#4
 296  0080 87            	retf	
 380                     ; 61 void I2CRead(uint8_t slave, uint8_t addr, uint8_t * buffer, uint8_t size)
 380                     ; 62 {
 381                     	switch	.text
 382  0081               f_I2CRead:
 384  0081 89            	pushw	x
 385  0082 89            	pushw	x
 386       00000002      OFST:	set	2
 389                     ; 65 		uint8_t index = 0;
 391  0083 0f02          	clr	(OFST+0,sp)
 393                     ; 68     I2C_GenerateSTART(ENABLE);
 395  0085 a601          	ld	a,#1
 396  0087 8d000000      	callf	f_I2C_GenerateSTART
 399  008b               L112:
 400                     ; 71     while(!(I2C->SR1 & I2C_SR1_SB));
 402  008b 72015217fb    	btjf	21015,#0,L112
 403                     ; 74     I2C_Send7bitAddress(slave, I2C_DIRECTION_TX);
 405  0090 7b03          	ld	a,(OFST+1,sp)
 406  0092 5f            	clrw	x
 407  0093 95            	ld	xh,a
 408  0094 8d000000      	callf	f_I2C_Send7bitAddress
 411  0098               L712:
 412                     ; 77     while(!(I2C->SR1 & I2C_SR1_ADDR));
 414  0098 72035217fb    	btjf	21015,#1,L712
 415                     ; 79     reg = I2C->SR1;
 417  009d c65217        	ld	a,21015
 418  00a0 6b01          	ld	(OFST-1,sp),a
 420                     ; 80     reg = I2C->SR3;
 422  00a2 c65219        	ld	a,21017
 423  00a5 6b01          	ld	(OFST-1,sp),a
 425                     ; 83     I2C_SendData(addr);
 427  00a7 7b04          	ld	a,(OFST+2,sp)
 428  00a9 8d000000      	callf	f_I2C_SendData
 431  00ad               L522:
 432                     ; 85     while(!(I2C->SR1 & I2C_SR1_TXE));
 434  00ad 720f5217fb    	btjf	21015,#7,L522
 436  00b2               L332:
 437                     ; 87     while(!(I2C->SR1 & I2C_SR1_BTF));
 439  00b2 72055217fb    	btjf	21015,#2,L332
 440                     ; 90     I2C->CR2 |= I2C_CR2_ACK;
 442  00b7 72145211      	bset	21009,#2
 443                     ; 92     I2C_GenerateSTART(ENABLE);
 445  00bb a601          	ld	a,#1
 446  00bd 8d000000      	callf	f_I2C_GenerateSTART
 449  00c1               L142:
 450                     ; 94     while(!(I2C->SR1 & I2C_SR1_SB));
 452  00c1 72015217fb    	btjf	21015,#0,L142
 453                     ; 96     I2C_Send7bitAddress(slave, I2C_DIRECTION_RX);
 455  00c6 7b03          	ld	a,(OFST+1,sp)
 456  00c8 ae0001        	ldw	x,#1
 457  00cb 95            	ld	xh,a
 458  00cc 8d000000      	callf	f_I2C_Send7bitAddress
 461  00d0               L742:
 462                     ; 99     while(!(I2C->SR1 & I2C_SR1_ADDR));
 464  00d0 72035217fb    	btjf	21015,#1,L742
 465                     ; 101     reg = I2C->SR1;
 467  00d5 c65217        	ld	a,21015
 468  00d8 6b01          	ld	(OFST-1,sp),a
 470                     ; 102     reg = I2C->SR3;
 472  00da c65219        	ld	a,21017
 473  00dd 6b01          	ld	(OFST-1,sp),a
 476  00df 201d          	jra	L752
 477  00e1               L352:
 478                     ; 106         size--;
 480  00e1 0a0a          	dec	(OFST+8,sp)
 481                     ; 107         if(size == 0)
 483  00e3 2604          	jrne	L762
 484                     ; 110             I2C->CR2 &= ~I2C_CR2_ACK;
 486  00e5 72155211      	bres	21009,#2
 487  00e9               L762:
 488                     ; 113         while(!(I2C->SR1 & I2C_SR1_RXNE));
 490  00e9 720d5217fb    	btjf	21015,#6,L762
 491                     ; 114         buffer[index] = I2C_ReceiveData();
 493  00ee 7b02          	ld	a,(OFST+0,sp)
 494  00f0 5f            	clrw	x
 495  00f1 97            	ld	xl,a
 496  00f2 72fb08        	addw	x,(OFST+6,sp)
 497  00f5 89            	pushw	x
 498  00f6 8d000000      	callf	f_I2C_ReceiveData
 500  00fa 85            	popw	x
 501  00fb f7            	ld	(x),a
 502                     ; 115         index++;
 504  00fc 0c02          	inc	(OFST+0,sp)
 506  00fe               L752:
 507                     ; 104     while(size)
 509  00fe 7b0a          	ld	a,(OFST+8,sp)
 510  0100 26df          	jrne	L352
 511                     ; 119     I2C_GenerateSTOP(ENABLE);
 513  0102 4c            	inc	a
 514  0103 8d000000      	callf	f_I2C_GenerateSTOP
 517  0107               L572:
 518                     ; 123     while((I2C->SR3 & I2C_SR3_MSL));
 520  0107 72005219fb    	btjt	21017,#0,L572
 521                     ; 125 }
 524  010c 5b04          	addw	sp,#4
 525  010e 87            	retf	
 537                     	xdef	f_I2CRead
 538                     	xdef	f_I2CWrite
 539                     	xdef	f_I2CDeinit
 540                     	xdef	f_I2CInit
 541                     	xref	f_I2C_SendData
 542                     	xref	f_I2C_Send7bitAddress
 543                     	xref	f_I2C_ReceiveData
 544                     	xref	f_I2C_GenerateSTOP
 545                     	xref	f_I2C_GenerateSTART
 546                     	xref	f_I2C_Cmd
 547                     	xref	f_I2C_Init
 548                     	xref	f_I2C_DeInit
 567                     	end
