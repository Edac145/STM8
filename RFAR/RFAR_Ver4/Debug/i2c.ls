   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  43                     ; 5 void I2CInit()
  43                     ; 6 {
  44                     	switch	.text
  45  0000               f_I2CInit:
  49                     ; 7     I2C_Init(100000, 0x00, I2C_DUTYCYCLE_2,
  49                     ; 8             I2C_ACK_NONE, I2C_ADDMODE_7BIT, 2);
  51  0000 4b02          	push	#2
  52  0002 4b00          	push	#0
  53  0004 4b00          	push	#0
  54  0006 4b00          	push	#0
  55  0008 5f            	clrw	x
  56  0009 89            	pushw	x
  57  000a ae86a0        	ldw	x,#34464
  58  000d 89            	pushw	x
  59  000e ae0001        	ldw	x,#1
  60  0011 89            	pushw	x
  61  0012 8d000000      	callf	f_I2C_Init
  63  0016 5b0a          	addw	sp,#10
  64                     ; 9 }
  67  0018 87            	retf
  90                     ; 11 void I2CDeinit()
  90                     ; 12 {
  91                     	switch	.text
  92  0019               f_I2CDeinit:
  96                     ; 13     I2C_DeInit();
  98  0019 8d000000      	callf	f_I2C_DeInit
 100                     ; 14 }
 103  001d 87            	retf
 187                     ; 16 void I2CWrite(uint8_t slave, uint8_t addr, uint8_t * buffer, uint8_t size)
 187                     ; 17 {
 188                     	switch	.text
 189  001e               f_I2CWrite:
 191  001e 89            	pushw	x
 192  001f 89            	pushw	x
 193       00000002      OFST:	set	2
 196                     ; 20 		uint8_t index = 0;
 198  0020 0f02          	clr	(OFST+0,sp)
 200                     ; 22     I2C_Cmd(ENABLE);
 202  0022 a601          	ld	a,#1
 203  0024 8d000000      	callf	f_I2C_Cmd
 205                     ; 23     I2C_GenerateSTART(ENABLE);
 207  0028 a601          	ld	a,#1
 208  002a 8d000000      	callf	f_I2C_GenerateSTART
 211  002e               L57:
 212                     ; 25     while(!(I2C->SR1 & I2C_SR1_SB));
 214  002e c65217        	ld	a,21015
 215  0031 a501          	bcp	a,#1
 216  0033 27f9          	jreq	L57
 217                     ; 28     I2C_Send7bitAddress(slave, I2C_DIRECTION_TX);
 219  0035 7b03          	ld	a,(OFST+1,sp)
 220  0037 5f            	clrw	x
 221  0038 95            	ld	xh,a
 222  0039 8d000000      	callf	f_I2C_Send7bitAddress
 225  003d               L301:
 226                     ; 30     while(!(I2C->SR1 & I2C_SR1_ADDR));
 228  003d c65217        	ld	a,21015
 229  0040 a502          	bcp	a,#2
 230  0042 27f9          	jreq	L301
 231                     ; 32     reg = I2C->SR1;
 233  0044 c65217        	ld	a,21015
 234  0047 6b01          	ld	(OFST-1,sp),a
 236                     ; 33     reg = I2C->SR3;
 238  0049 c65219        	ld	a,21017
 239  004c 6b01          	ld	(OFST-1,sp),a
 241                     ; 36     I2C_SendData(addr);
 243  004e 7b04          	ld	a,(OFST+2,sp)
 244  0050 8d000000      	callf	f_I2C_SendData
 247  0054               L111:
 248                     ; 37     while(!(I2C->SR1 & I2C_SR1_TXE));
 250  0054 c65217        	ld	a,21015
 251  0057 a580          	bcp	a,#128
 252  0059 27f9          	jreq	L111
 254  005b 2017          	jra	L711
 255  005d               L511:
 256                     ; 41         size--;
 258  005d 0a0a          	dec	(OFST+8,sp)
 259                     ; 42         I2C_SendData(buffer[index]);
 261  005f 7b02          	ld	a,(OFST+0,sp)
 262  0061 5f            	clrw	x
 263  0062 97            	ld	xl,a
 264  0063 72fb08        	addw	x,(OFST+6,sp)
 265  0066 f6            	ld	a,(x)
 266  0067 8d000000      	callf	f_I2C_SendData
 268                     ; 43         index++;
 270  006b 0c02          	inc	(OFST+0,sp)
 273  006d               L521:
 274                     ; 45         while(!(I2C->SR1 & I2C_SR1_TXE));
 276  006d c65217        	ld	a,21015
 277  0070 a580          	bcp	a,#128
 278  0072 27f9          	jreq	L521
 279  0074               L711:
 280                     ; 39     while(size)
 282  0074 0d0a          	tnz	(OFST+8,sp)
 283  0076 26e5          	jrne	L511
 285  0078               L331:
 286                     ; 49     while(!(I2C->SR1 & I2C_SR1_BTF));
 288  0078 c65217        	ld	a,21015
 289  007b a504          	bcp	a,#4
 290  007d 27f9          	jreq	L331
 291                     ; 53     I2C_GenerateSTOP(ENABLE);
 293  007f a601          	ld	a,#1
 294  0081 8d000000      	callf	f_I2C_GenerateSTOP
 297  0085               L141:
 298                     ; 56     while((I2C->SR3 & I2C_SR3_MSL));
 300  0085 c65219        	ld	a,21017
 301  0088 a501          	bcp	a,#1
 302  008a 26f9          	jrne	L141
 303                     ; 57     I2C_Cmd(DISABLE);
 305  008c 4f            	clr	a
 306  008d 8d000000      	callf	f_I2C_Cmd
 308                     ; 58 }
 311  0091 5b04          	addw	sp,#4
 312  0093 87            	retf
 397                     ; 61 void I2CRead(uint8_t slave, uint8_t addr, uint8_t * buffer, uint8_t size)
 397                     ; 62 {
 398                     	switch	.text
 399  0094               f_I2CRead:
 401  0094 89            	pushw	x
 402  0095 89            	pushw	x
 403       00000002      OFST:	set	2
 406                     ; 65 		uint8_t index = 0;
 408  0096 0f02          	clr	(OFST+0,sp)
 410                     ; 67     I2C_Cmd(ENABLE);
 412  0098 a601          	ld	a,#1
 413  009a 8d000000      	callf	f_I2C_Cmd
 415                     ; 68     I2C_GenerateSTART(ENABLE);
 417  009e a601          	ld	a,#1
 418  00a0 8d000000      	callf	f_I2C_GenerateSTART
 421  00a4               L112:
 422                     ; 71     while(!(I2C->SR1 & I2C_SR1_SB));
 424  00a4 c65217        	ld	a,21015
 425  00a7 a501          	bcp	a,#1
 426  00a9 27f9          	jreq	L112
 427                     ; 74     I2C_Send7bitAddress(slave, I2C_DIRECTION_TX);
 429  00ab 7b03          	ld	a,(OFST+1,sp)
 430  00ad 5f            	clrw	x
 431  00ae 95            	ld	xh,a
 432  00af 8d000000      	callf	f_I2C_Send7bitAddress
 435  00b3               L712:
 436                     ; 77     while(!(I2C->SR1 & I2C_SR1_ADDR));
 438  00b3 c65217        	ld	a,21015
 439  00b6 a502          	bcp	a,#2
 440  00b8 27f9          	jreq	L712
 441                     ; 79     reg = I2C->SR1;
 443  00ba c65217        	ld	a,21015
 444  00bd 6b01          	ld	(OFST-1,sp),a
 446                     ; 80     reg = I2C->SR3;
 448  00bf c65219        	ld	a,21017
 449  00c2 6b01          	ld	(OFST-1,sp),a
 451                     ; 83     I2C_SendData(addr);
 453  00c4 7b04          	ld	a,(OFST+2,sp)
 454  00c6 8d000000      	callf	f_I2C_SendData
 457  00ca               L522:
 458                     ; 85     while(!(I2C->SR1 & I2C_SR1_TXE));
 460  00ca c65217        	ld	a,21015
 461  00cd a580          	bcp	a,#128
 462  00cf 27f9          	jreq	L522
 464  00d1               L332:
 465                     ; 87     while(!(I2C->SR1 & I2C_SR1_BTF));
 467  00d1 c65217        	ld	a,21015
 468  00d4 a504          	bcp	a,#4
 469  00d6 27f9          	jreq	L332
 470                     ; 90     I2C->CR2 |= I2C_CR2_ACK;
 472  00d8 72145211      	bset	21009,#2
 473                     ; 92     I2C_GenerateSTART(ENABLE);
 475  00dc a601          	ld	a,#1
 476  00de 8d000000      	callf	f_I2C_GenerateSTART
 479  00e2               L142:
 480                     ; 94     while(!(I2C->SR1 & I2C_SR1_SB));
 482  00e2 c65217        	ld	a,21015
 483  00e5 a501          	bcp	a,#1
 484  00e7 27f9          	jreq	L142
 485                     ; 96     I2C_Send7bitAddress(slave, I2C_DIRECTION_RX);
 487  00e9 7b03          	ld	a,(OFST+1,sp)
 488  00eb ae0001        	ldw	x,#1
 489  00ee 95            	ld	xh,a
 490  00ef 8d000000      	callf	f_I2C_Send7bitAddress
 493  00f3               L742:
 494                     ; 99     while(!(I2C->SR1 & I2C_SR1_ADDR));
 496  00f3 c65217        	ld	a,21015
 497  00f6 a502          	bcp	a,#2
 498  00f8 27f9          	jreq	L742
 499                     ; 101     reg = I2C->SR1;
 501  00fa c65217        	ld	a,21015
 502  00fd 6b01          	ld	(OFST-1,sp),a
 504                     ; 102     reg = I2C->SR3;
 506  00ff c65219        	ld	a,21017
 507  0102 6b01          	ld	(OFST-1,sp),a
 510  0104 2021          	jra	L752
 511  0106               L352:
 512                     ; 106         size--;
 514  0106 0a0a          	dec	(OFST+8,sp)
 515                     ; 107         if(size == 0)
 517  0108 0d0a          	tnz	(OFST+8,sp)
 518  010a 2604          	jrne	L762
 519                     ; 110             I2C->CR2 &= ~I2C_CR2_ACK;
 521  010c 72155211      	bres	21009,#2
 522  0110               L762:
 523                     ; 113         while(!(I2C->SR1 & I2C_SR1_RXNE));
 525  0110 c65217        	ld	a,21015
 526  0113 a540          	bcp	a,#64
 527  0115 27f9          	jreq	L762
 528                     ; 114         buffer[index] = I2C_ReceiveData();
 530  0117 7b02          	ld	a,(OFST+0,sp)
 531  0119 5f            	clrw	x
 532  011a 97            	ld	xl,a
 533  011b 72fb08        	addw	x,(OFST+6,sp)
 534  011e 89            	pushw	x
 535  011f 8d000000      	callf	f_I2C_ReceiveData
 537  0123 85            	popw	x
 538  0124 f7            	ld	(x),a
 539                     ; 115         index++;
 541  0125 0c02          	inc	(OFST+0,sp)
 543  0127               L752:
 544                     ; 104     while(size)
 546  0127 0d0a          	tnz	(OFST+8,sp)
 547  0129 26db          	jrne	L352
 548                     ; 119     I2C_GenerateSTOP(ENABLE);
 550  012b a601          	ld	a,#1
 551  012d 8d000000      	callf	f_I2C_GenerateSTOP
 554  0131               L572:
 555                     ; 123     while((I2C->SR3 & I2C_SR3_MSL));
 557  0131 c65219        	ld	a,21017
 558  0134 a501          	bcp	a,#1
 559  0136 26f9          	jrne	L572
 560                     ; 124     I2C_Cmd(DISABLE);
 562  0138 4f            	clr	a
 563  0139 8d000000      	callf	f_I2C_Cmd
 565                     ; 125 }
 568  013d 5b04          	addw	sp,#4
 569  013f 87            	retf
 581                     	xdef	f_I2CRead
 582                     	xdef	f_I2CWrite
 583                     	xdef	f_I2CDeinit
 584                     	xdef	f_I2CInit
 585                     	xref	f_I2C_SendData
 586                     	xref	f_I2C_Send7bitAddress
 587                     	xref	f_I2C_ReceiveData
 588                     	xref	f_I2C_GenerateSTOP
 589                     	xref	f_I2C_GenerateSTART
 590                     	xref	f_I2C_Cmd
 591                     	xref	f_I2C_Init
 592                     	xref	f_I2C_DeInit
 611                     	end
