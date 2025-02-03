   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  44                     ; 4 void I2CInit()
  44                     ; 5 {
  45                     	switch	.text
  46  0000               f_I2CInit:
  50                     ; 6     I2C_Init(100000, 0x00, I2C_DUTYCYCLE_2,
  50                     ; 7             I2C_ACK_NONE, I2C_ADDMODE_7BIT, 2);
  52  0000 4b02          	push	#2
  53  0002 4b00          	push	#0
  54  0004 4b00          	push	#0
  55  0006 4b00          	push	#0
  56  0008 5f            	clrw	x
  57  0009 89            	pushw	x
  58  000a ae86a0        	ldw	x,#34464
  59  000d 89            	pushw	x
  60  000e ae0001        	ldw	x,#1
  61  0011 89            	pushw	x
  62  0012 8d000000      	callf	f_I2C_Init
  64  0016 5b0a          	addw	sp,#10
  65                     ; 8 		I2C_Cmd(ENABLE);
  67  0018 a601          	ld	a,#1
  68  001a 8d000000      	callf	f_I2C_Cmd
  70                     ; 9 }
  73  001e 87            	retf
  96                     ; 11 void I2CDeinit()
  96                     ; 12 {
  97                     	switch	.text
  98  001f               f_I2CDeinit:
 102                     ; 13     I2C_DeInit();
 104  001f 8d000000      	callf	f_I2C_DeInit
 106                     ; 14 }
 109  0023 87            	retf
 192                     ; 16 void I2CWrite(uint8_t slave, uint8_t addr, uint8_t * buffer, uint8_t size)
 192                     ; 17 {
 193                     	switch	.text
 194  0024               f_I2CWrite:
 196  0024 89            	pushw	x
 197  0025 89            	pushw	x
 198       00000002      OFST:	set	2
 201                     ; 20 		uint8_t index = 0;
 203  0026 0f02          	clr	(OFST+0,sp)
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
 303                     ; 58 }
 306  008c 5b04          	addw	sp,#4
 307  008e 87            	retf
 391                     ; 61 void I2CRead(uint8_t slave, uint8_t addr, uint8_t * buffer, uint8_t size)
 391                     ; 62 {
 392                     	switch	.text
 393  008f               f_I2CRead:
 395  008f 89            	pushw	x
 396  0090 89            	pushw	x
 397       00000002      OFST:	set	2
 400                     ; 65 		uint8_t index = 0;
 402  0091 0f02          	clr	(OFST+0,sp)
 404                     ; 68     I2C_GenerateSTART(ENABLE);
 406  0093 a601          	ld	a,#1
 407  0095 8d000000      	callf	f_I2C_GenerateSTART
 410  0099               L112:
 411                     ; 71     while(!(I2C->SR1 & I2C_SR1_SB));
 413  0099 c65217        	ld	a,21015
 414  009c a501          	bcp	a,#1
 415  009e 27f9          	jreq	L112
 416                     ; 74     I2C_Send7bitAddress(slave, I2C_DIRECTION_TX);
 418  00a0 7b03          	ld	a,(OFST+1,sp)
 419  00a2 5f            	clrw	x
 420  00a3 95            	ld	xh,a
 421  00a4 8d000000      	callf	f_I2C_Send7bitAddress
 424  00a8               L712:
 425                     ; 77     while(!(I2C->SR1 & I2C_SR1_ADDR));
 427  00a8 c65217        	ld	a,21015
 428  00ab a502          	bcp	a,#2
 429  00ad 27f9          	jreq	L712
 430                     ; 79     reg = I2C->SR1;
 432  00af c65217        	ld	a,21015
 433  00b2 6b01          	ld	(OFST-1,sp),a
 435                     ; 80     reg = I2C->SR3;
 437  00b4 c65219        	ld	a,21017
 438  00b7 6b01          	ld	(OFST-1,sp),a
 440                     ; 83     I2C_SendData(addr);
 442  00b9 7b04          	ld	a,(OFST+2,sp)
 443  00bb 8d000000      	callf	f_I2C_SendData
 446  00bf               L522:
 447                     ; 85     while(!(I2C->SR1 & I2C_SR1_TXE));
 449  00bf c65217        	ld	a,21015
 450  00c2 a580          	bcp	a,#128
 451  00c4 27f9          	jreq	L522
 453  00c6               L332:
 454                     ; 87     while(!(I2C->SR1 & I2C_SR1_BTF));
 456  00c6 c65217        	ld	a,21015
 457  00c9 a504          	bcp	a,#4
 458  00cb 27f9          	jreq	L332
 459                     ; 90     I2C->CR2 |= I2C_CR2_ACK;
 461  00cd 72145211      	bset	21009,#2
 462                     ; 92     I2C_GenerateSTART(ENABLE);
 464  00d1 a601          	ld	a,#1
 465  00d3 8d000000      	callf	f_I2C_GenerateSTART
 468  00d7               L142:
 469                     ; 94     while(!(I2C->SR1 & I2C_SR1_SB));
 471  00d7 c65217        	ld	a,21015
 472  00da a501          	bcp	a,#1
 473  00dc 27f9          	jreq	L142
 474                     ; 96     I2C_Send7bitAddress(slave, I2C_DIRECTION_RX);
 476  00de 7b03          	ld	a,(OFST+1,sp)
 477  00e0 ae0001        	ldw	x,#1
 478  00e3 95            	ld	xh,a
 479  00e4 8d000000      	callf	f_I2C_Send7bitAddress
 482  00e8               L742:
 483                     ; 99     while(!(I2C->SR1 & I2C_SR1_ADDR));
 485  00e8 c65217        	ld	a,21015
 486  00eb a502          	bcp	a,#2
 487  00ed 27f9          	jreq	L742
 488                     ; 101     reg = I2C->SR1;
 490  00ef c65217        	ld	a,21015
 491  00f2 6b01          	ld	(OFST-1,sp),a
 493                     ; 102     reg = I2C->SR3;
 495  00f4 c65219        	ld	a,21017
 496  00f7 6b01          	ld	(OFST-1,sp),a
 499  00f9 2021          	jra	L752
 500  00fb               L352:
 501                     ; 106         size--;
 503  00fb 0a0a          	dec	(OFST+8,sp)
 504                     ; 107         if(size == 0)
 506  00fd 0d0a          	tnz	(OFST+8,sp)
 507  00ff 2604          	jrne	L762
 508                     ; 110             I2C->CR2 &= ~I2C_CR2_ACK;
 510  0101 72155211      	bres	21009,#2
 511  0105               L762:
 512                     ; 113         while(!(I2C->SR1 & I2C_SR1_RXNE));
 514  0105 c65217        	ld	a,21015
 515  0108 a540          	bcp	a,#64
 516  010a 27f9          	jreq	L762
 517                     ; 114         buffer[index] = I2C_ReceiveData();
 519  010c 7b02          	ld	a,(OFST+0,sp)
 520  010e 5f            	clrw	x
 521  010f 97            	ld	xl,a
 522  0110 72fb08        	addw	x,(OFST+6,sp)
 523  0113 89            	pushw	x
 524  0114 8d000000      	callf	f_I2C_ReceiveData
 526  0118 85            	popw	x
 527  0119 f7            	ld	(x),a
 528                     ; 115         index++;
 530  011a 0c02          	inc	(OFST+0,sp)
 532  011c               L752:
 533                     ; 104     while(size)
 535  011c 0d0a          	tnz	(OFST+8,sp)
 536  011e 26db          	jrne	L352
 537                     ; 119     I2C_GenerateSTOP(ENABLE);
 539  0120 a601          	ld	a,#1
 540  0122 8d000000      	callf	f_I2C_GenerateSTOP
 543  0126               L572:
 544                     ; 123     while((I2C->SR3 & I2C_SR3_MSL));
 546  0126 c65219        	ld	a,21017
 547  0129 a501          	bcp	a,#1
 548  012b 26f9          	jrne	L572
 549                     ; 125 }
 552  012d 5b04          	addw	sp,#4
 553  012f 87            	retf
 565                     	xdef	f_I2CRead
 566                     	xdef	f_I2CWrite
 567                     	xdef	f_I2CDeinit
 568                     	xdef	f_I2CInit
 569                     	xref	f_I2C_SendData
 570                     	xref	f_I2C_Send7bitAddress
 571                     	xref	f_I2C_ReceiveData
 572                     	xref	f_I2C_GenerateSTOP
 573                     	xref	f_I2C_GenerateSTART
 574                     	xref	f_I2C_Cmd
 575                     	xref	f_I2C_Init
 576                     	xref	f_I2C_DeInit
 595                     	end
