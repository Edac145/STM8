   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  44                     ; 4 void I2CInit()
  44                     ; 5 {
  45                     	switch	.text
  46  0000               f_I2CInit:
  50                     ; 6     I2C_Init(100000, 0x00, I2C_DUTYCYCLE_2,
  50                     ; 7             I2C_ACK_CURR, I2C_ADDMODE_7BIT, 16);
  52  0000 4b10          	push	#16
  53  0002 4b00          	push	#0
  54  0004 4b01          	push	#1
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
 184                     ; 16 void I2CWrite(uint8_t slave, uint8_t addr, uint8_t * buffer, uint8_t size)
 184                     ; 17 {
 185                     	switch	.text
 186  0024               f_I2CWrite:
 188  0024 89            	pushw	x
 189  0025 89            	pushw	x
 190       00000002      OFST:	set	2
 193                     ; 20 		uint8_t index = 0;
 195  0026 0f02          	clr	(OFST+0,sp)
 197                     ; 23     I2C_GenerateSTART(ENABLE);
 199  0028 a601          	ld	a,#1
 200  002a 8d000000      	callf	f_I2C_GenerateSTART
 203  002e               L56:
 204                     ; 25     while(!(I2C->SR1 & I2C_SR1_SB));
 206  002e c65217        	ld	a,21015
 207  0031 a501          	bcp	a,#1
 208  0033 27f9          	jreq	L56
 209                     ; 28     I2C_Send7bitAddress(slave, I2C_DIRECTION_TX);
 211  0035 7b03          	ld	a,(OFST+1,sp)
 212  0037 5f            	clrw	x
 213  0038 95            	ld	xh,a
 214  0039 8d000000      	callf	f_I2C_Send7bitAddress
 217  003d               L37:
 218                     ; 30     while(!(I2C->SR1 & I2C_SR1_ADDR));
 220  003d c65217        	ld	a,21015
 221  0040 a502          	bcp	a,#2
 222  0042 27f9          	jreq	L37
 223                     ; 32     reg = I2C->SR1;
 225  0044 c65217        	ld	a,21015
 226  0047 6b01          	ld	(OFST-1,sp),a
 228                     ; 33     reg = I2C->SR3;
 230  0049 c65219        	ld	a,21017
 231  004c 6b01          	ld	(OFST-1,sp),a
 233                     ; 36     I2C_SendData(addr);
 235  004e 7b04          	ld	a,(OFST+2,sp)
 236  0050 8d000000      	callf	f_I2C_SendData
 239  0054               L101:
 240                     ; 37     while(!(I2C->SR1 & I2C_SR1_TXE));
 242  0054 c65217        	ld	a,21015
 243  0057 a580          	bcp	a,#128
 244  0059 27f9          	jreq	L101
 246  005b 2017          	jra	L701
 247  005d               L501:
 248                     ; 41         size--;
 250  005d 0a0a          	dec	(OFST+8,sp)
 251                     ; 42         I2C_SendData(buffer[index]);
 253  005f 7b02          	ld	a,(OFST+0,sp)
 254  0061 5f            	clrw	x
 255  0062 97            	ld	xl,a
 256  0063 72fb08        	addw	x,(OFST+6,sp)
 257  0066 f6            	ld	a,(x)
 258  0067 8d000000      	callf	f_I2C_SendData
 260                     ; 43         index++;
 262  006b 0c02          	inc	(OFST+0,sp)
 265  006d               L511:
 266                     ; 45         while(!(I2C->SR1 & I2C_SR1_TXE));
 268  006d c65217        	ld	a,21015
 269  0070 a580          	bcp	a,#128
 270  0072 27f9          	jreq	L511
 271  0074               L701:
 272                     ; 39     while(size)
 274  0074 0d0a          	tnz	(OFST+8,sp)
 275  0076 26e5          	jrne	L501
 277  0078               L321:
 278                     ; 49     while(!(I2C->SR1 & I2C_SR1_BTF));
 280  0078 c65217        	ld	a,21015
 281  007b a504          	bcp	a,#4
 282  007d 27f9          	jreq	L321
 283                     ; 53     I2C_GenerateSTOP(ENABLE);
 285  007f a601          	ld	a,#1
 286  0081 8d000000      	callf	f_I2C_GenerateSTOP
 289  0085               L131:
 290                     ; 56     while((I2C->SR3 & I2C_SR3_MSL));
 292  0085 c65219        	ld	a,21017
 293  0088 a501          	bcp	a,#1
 294  008a 26f9          	jrne	L131
 295                     ; 58 }
 298  008c 5b04          	addw	sp,#4
 299  008e 87            	retf
 375                     ; 61 void I2CRead(uint8_t slave, uint8_t addr, uint8_t * buffer, uint8_t size)
 375                     ; 62 {
 376                     	switch	.text
 377  008f               f_I2CRead:
 379  008f 89            	pushw	x
 380  0090 89            	pushw	x
 381       00000002      OFST:	set	2
 384                     ; 65 		uint8_t index = 0;
 386  0091 0f02          	clr	(OFST+0,sp)
 388                     ; 68     I2C_GenerateSTART(ENABLE);
 390  0093 a601          	ld	a,#1
 391  0095 8d000000      	callf	f_I2C_GenerateSTART
 394  0099               L171:
 395                     ; 71     while(!(I2C->SR1 & I2C_SR1_SB));
 397  0099 c65217        	ld	a,21015
 398  009c a501          	bcp	a,#1
 399  009e 27f9          	jreq	L171
 400                     ; 74     I2C_Send7bitAddress(slave, I2C_DIRECTION_TX);
 402  00a0 7b03          	ld	a,(OFST+1,sp)
 403  00a2 5f            	clrw	x
 404  00a3 95            	ld	xh,a
 405  00a4 8d000000      	callf	f_I2C_Send7bitAddress
 408  00a8               L771:
 409                     ; 77     while(!(I2C->SR1 & I2C_SR1_ADDR));
 411  00a8 c65217        	ld	a,21015
 412  00ab a502          	bcp	a,#2
 413  00ad 27f9          	jreq	L771
 414                     ; 79     reg = I2C->SR1;
 416  00af c65217        	ld	a,21015
 417  00b2 6b01          	ld	(OFST-1,sp),a
 419                     ; 80     reg = I2C->SR3;
 421  00b4 c65219        	ld	a,21017
 422  00b7 6b01          	ld	(OFST-1,sp),a
 424                     ; 83     I2C_SendData(addr);
 426  00b9 7b04          	ld	a,(OFST+2,sp)
 427  00bb 8d000000      	callf	f_I2C_SendData
 430  00bf               L502:
 431                     ; 85     while(!(I2C->SR1 & I2C_SR1_TXE));
 433  00bf c65217        	ld	a,21015
 434  00c2 a580          	bcp	a,#128
 435  00c4 27f9          	jreq	L502
 437  00c6               L312:
 438                     ; 87     while(!(I2C->SR1 & I2C_SR1_BTF));
 440  00c6 c65217        	ld	a,21015
 441  00c9 a504          	bcp	a,#4
 442  00cb 27f9          	jreq	L312
 443                     ; 90     I2C->CR2 |= I2C_CR2_ACK;
 445  00cd 72145211      	bset	21009,#2
 446                     ; 92     I2C_GenerateSTART(ENABLE);
 448  00d1 a601          	ld	a,#1
 449  00d3 8d000000      	callf	f_I2C_GenerateSTART
 452  00d7               L122:
 453                     ; 94     while(!(I2C->SR1 & I2C_SR1_SB));
 455  00d7 c65217        	ld	a,21015
 456  00da a501          	bcp	a,#1
 457  00dc 27f9          	jreq	L122
 458                     ; 96     I2C_Send7bitAddress(slave, I2C_DIRECTION_RX);
 460  00de 7b03          	ld	a,(OFST+1,sp)
 461  00e0 ae0001        	ldw	x,#1
 462  00e3 95            	ld	xh,a
 463  00e4 8d000000      	callf	f_I2C_Send7bitAddress
 466  00e8               L722:
 467                     ; 99     while(!(I2C->SR1 & I2C_SR1_ADDR));
 469  00e8 c65217        	ld	a,21015
 470  00eb a502          	bcp	a,#2
 471  00ed 27f9          	jreq	L722
 472                     ; 101     reg = I2C->SR1;
 474  00ef c65217        	ld	a,21015
 475  00f2 6b01          	ld	(OFST-1,sp),a
 477                     ; 102     reg = I2C->SR3;
 479  00f4 c65219        	ld	a,21017
 480  00f7 6b01          	ld	(OFST-1,sp),a
 483  00f9 2021          	jra	L732
 484  00fb               L332:
 485                     ; 106         size--;
 487  00fb 0a0a          	dec	(OFST+8,sp)
 488                     ; 107         if(size == 0)
 490  00fd 0d0a          	tnz	(OFST+8,sp)
 491  00ff 2604          	jrne	L742
 492                     ; 110             I2C->CR2 &= ~I2C_CR2_ACK;
 494  0101 72155211      	bres	21009,#2
 495  0105               L742:
 496                     ; 113         while(!(I2C->SR1 & I2C_SR1_RXNE));
 498  0105 c65217        	ld	a,21015
 499  0108 a540          	bcp	a,#64
 500  010a 27f9          	jreq	L742
 501                     ; 114         buffer[index] = I2C_ReceiveData();
 503  010c 7b02          	ld	a,(OFST+0,sp)
 504  010e 5f            	clrw	x
 505  010f 97            	ld	xl,a
 506  0110 72fb08        	addw	x,(OFST+6,sp)
 507  0113 89            	pushw	x
 508  0114 8d000000      	callf	f_I2C_ReceiveData
 510  0118 85            	popw	x
 511  0119 f7            	ld	(x),a
 512                     ; 115         index++;
 514  011a 0c02          	inc	(OFST+0,sp)
 516  011c               L732:
 517                     ; 104     while(size)
 519  011c 0d0a          	tnz	(OFST+8,sp)
 520  011e 26db          	jrne	L332
 521                     ; 119     I2C_GenerateSTOP(ENABLE);
 523  0120 a601          	ld	a,#1
 524  0122 8d000000      	callf	f_I2C_GenerateSTOP
 527  0126               L552:
 528                     ; 123     while((I2C->SR3 & I2C_SR3_MSL));
 530  0126 c65219        	ld	a,21017
 531  0129 a501          	bcp	a,#1
 532  012b 26f9          	jrne	L552
 533                     ; 125 }
 536  012d 5b04          	addw	sp,#4
 537  012f 87            	retf
 549                     	xdef	f_I2CRead
 550                     	xdef	f_I2CWrite
 551                     	xdef	f_I2CDeinit
 552                     	xdef	f_I2CInit
 553                     	xref	f_I2C_SendData
 554                     	xref	f_I2C_Send7bitAddress
 555                     	xref	f_I2C_ReceiveData
 556                     	xref	f_I2C_GenerateSTOP
 557                     	xref	f_I2C_GenerateSTART
 558                     	xref	f_I2C_Cmd
 559                     	xref	f_I2C_Init
 560                     	xref	f_I2C_DeInit
 579                     	end
