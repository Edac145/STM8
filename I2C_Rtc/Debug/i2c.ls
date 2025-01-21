   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  43                     ; 4 void I2CInit()
  43                     ; 5 {
  45                     	switch	.text
  46  0000               _I2CInit:
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
  62  0012 cd0000        	call	_I2C_Init
  64  0015 5b0a          	addw	sp,#10
  65                     ; 8 }
  68  0017 81            	ret
  92                     ; 10 void I2CDeinit()
  92                     ; 11 {
  93                     	switch	.text
  94  0018               _I2CDeinit:
  98                     ; 12     I2C_DeInit();
 100  0018 cd0000        	call	_I2C_DeInit
 102                     ; 13 }
 105  001b 81            	ret
 190                     ; 15 void I2CWrite(uint8_t slave, uint8_t addr, uint8_t * buffer, uint8_t size)
 190                     ; 16 {
 191                     	switch	.text
 192  001c               _I2CWrite:
 194  001c 89            	pushw	x
 195  001d 89            	pushw	x
 196       00000002      OFST:	set	2
 199                     ; 19 		uint8_t index = 0;
 201  001e 0f02          	clr	(OFST+0,sp)
 203                     ; 21     I2C_Cmd(ENABLE);
 205  0020 a601          	ld	a,#1
 206  0022 cd0000        	call	_I2C_Cmd
 208                     ; 22     I2C_GenerateSTART(ENABLE);
 210  0025 a601          	ld	a,#1
 211  0027 cd0000        	call	_I2C_GenerateSTART
 214  002a               L57:
 215                     ; 24     while(!(I2C->SR1 & I2C_SR1_SB));
 217  002a c65217        	ld	a,21015
 218  002d a501          	bcp	a,#1
 219  002f 27f9          	jreq	L57
 220                     ; 27     I2C_Send7bitAddress(slave, I2C_DIRECTION_TX);
 222  0031 7b03          	ld	a,(OFST+1,sp)
 223  0033 5f            	clrw	x
 224  0034 95            	ld	xh,a
 225  0035 cd0000        	call	_I2C_Send7bitAddress
 228  0038               L301:
 229                     ; 29     while(!(I2C->SR1 & I2C_SR1_ADDR));
 231  0038 c65217        	ld	a,21015
 232  003b a502          	bcp	a,#2
 233  003d 27f9          	jreq	L301
 234                     ; 31     reg = I2C->SR1;
 236  003f c65217        	ld	a,21015
 237  0042 6b01          	ld	(OFST-1,sp),a
 239                     ; 32     reg = I2C->SR3;
 241  0044 c65219        	ld	a,21017
 242  0047 6b01          	ld	(OFST-1,sp),a
 244                     ; 35     I2C_SendData(addr);
 246  0049 7b04          	ld	a,(OFST+2,sp)
 247  004b cd0000        	call	_I2C_SendData
 250  004e               L111:
 251                     ; 36     while(!(I2C->SR1 & I2C_SR1_TXE));
 253  004e c65217        	ld	a,21015
 254  0051 a580          	bcp	a,#128
 255  0053 27f9          	jreq	L111
 257  0055 2016          	jra	L711
 258  0057               L511:
 259                     ; 40         size--;
 261  0057 0a09          	dec	(OFST+7,sp)
 262                     ; 41         I2C_SendData(buffer[index]);
 264  0059 7b02          	ld	a,(OFST+0,sp)
 265  005b 5f            	clrw	x
 266  005c 97            	ld	xl,a
 267  005d 72fb07        	addw	x,(OFST+5,sp)
 268  0060 f6            	ld	a,(x)
 269  0061 cd0000        	call	_I2C_SendData
 271                     ; 42         index++;
 273  0064 0c02          	inc	(OFST+0,sp)
 276  0066               L521:
 277                     ; 44         while(!(I2C->SR1 & I2C_SR1_TXE));
 279  0066 c65217        	ld	a,21015
 280  0069 a580          	bcp	a,#128
 281  006b 27f9          	jreq	L521
 282  006d               L711:
 283                     ; 38     while(size)
 285  006d 0d09          	tnz	(OFST+7,sp)
 286  006f 26e6          	jrne	L511
 288  0071               L331:
 289                     ; 48     while(!(I2C->SR1 & I2C_SR1_BTF));
 291  0071 c65217        	ld	a,21015
 292  0074 a504          	bcp	a,#4
 293  0076 27f9          	jreq	L331
 294                     ; 52     I2C_GenerateSTOP(ENABLE);
 296  0078 a601          	ld	a,#1
 297  007a cd0000        	call	_I2C_GenerateSTOP
 300  007d               L141:
 301                     ; 55     while((I2C->SR3 & I2C_SR3_MSL));
 303  007d c65219        	ld	a,21017
 304  0080 a501          	bcp	a,#1
 305  0082 26f9          	jrne	L141
 306                     ; 56     I2C_Cmd(DISABLE);
 308  0084 4f            	clr	a
 309  0085 cd0000        	call	_I2C_Cmd
 311                     ; 57 }
 314  0088 5b04          	addw	sp,#4
 315  008a 81            	ret
 401                     ; 60 void I2CRead(uint8_t slave, uint8_t addr, uint8_t * buffer, uint8_t size)
 401                     ; 61 {
 402                     	switch	.text
 403  008b               _I2CRead:
 405  008b 89            	pushw	x
 406  008c 89            	pushw	x
 407       00000002      OFST:	set	2
 410                     ; 64 		uint8_t index = 0;
 412  008d 0f02          	clr	(OFST+0,sp)
 414                     ; 65     I2C_Cmd(ENABLE);
 416  008f a601          	ld	a,#1
 417  0091 cd0000        	call	_I2C_Cmd
 419                     ; 66     I2C_GenerateSTART(ENABLE);
 421  0094 a601          	ld	a,#1
 422  0096 cd0000        	call	_I2C_GenerateSTART
 425  0099               L112:
 426                     ; 69     while(!(I2C->SR1 & I2C_SR1_SB));
 428  0099 c65217        	ld	a,21015
 429  009c a501          	bcp	a,#1
 430  009e 27f9          	jreq	L112
 431                     ; 72     I2C_Send7bitAddress(slave, I2C_DIRECTION_TX);
 433  00a0 7b03          	ld	a,(OFST+1,sp)
 434  00a2 5f            	clrw	x
 435  00a3 95            	ld	xh,a
 436  00a4 cd0000        	call	_I2C_Send7bitAddress
 439  00a7               L712:
 440                     ; 75     while(!(I2C->SR1 & I2C_SR1_ADDR));
 442  00a7 c65217        	ld	a,21015
 443  00aa a502          	bcp	a,#2
 444  00ac 27f9          	jreq	L712
 445                     ; 77     reg = I2C->SR1;
 447  00ae c65217        	ld	a,21015
 448  00b1 6b01          	ld	(OFST-1,sp),a
 450                     ; 78     reg = I2C->SR3;
 452  00b3 c65219        	ld	a,21017
 453  00b6 6b01          	ld	(OFST-1,sp),a
 455                     ; 81     I2C_SendData(addr);
 457  00b8 7b04          	ld	a,(OFST+2,sp)
 458  00ba cd0000        	call	_I2C_SendData
 461  00bd               L522:
 462                     ; 83     while(!(I2C->SR1 & I2C_SR1_TXE));
 464  00bd c65217        	ld	a,21015
 465  00c0 a580          	bcp	a,#128
 466  00c2 27f9          	jreq	L522
 468  00c4               L332:
 469                     ; 85     while(!(I2C->SR1 & I2C_SR1_BTF));
 471  00c4 c65217        	ld	a,21015
 472  00c7 a504          	bcp	a,#4
 473  00c9 27f9          	jreq	L332
 474                     ; 88     I2C->CR2 |= I2C_CR2_ACK;
 476  00cb 72145211      	bset	21009,#2
 477                     ; 90     I2C_GenerateSTART(ENABLE);
 479  00cf a601          	ld	a,#1
 480  00d1 cd0000        	call	_I2C_GenerateSTART
 483  00d4               L142:
 484                     ; 92     while(!(I2C->SR1 & I2C_SR1_SB));
 486  00d4 c65217        	ld	a,21015
 487  00d7 a501          	bcp	a,#1
 488  00d9 27f9          	jreq	L142
 489                     ; 94     I2C_Send7bitAddress(slave, I2C_DIRECTION_RX);
 491  00db 7b03          	ld	a,(OFST+1,sp)
 492  00dd ae0001        	ldw	x,#1
 493  00e0 95            	ld	xh,a
 494  00e1 cd0000        	call	_I2C_Send7bitAddress
 497  00e4               L742:
 498                     ; 97     while(!(I2C->SR1 & I2C_SR1_ADDR));
 500  00e4 c65217        	ld	a,21015
 501  00e7 a502          	bcp	a,#2
 502  00e9 27f9          	jreq	L742
 503                     ; 99     reg = I2C->SR1;
 505  00eb c65217        	ld	a,21015
 506  00ee 6b01          	ld	(OFST-1,sp),a
 508                     ; 100     reg = I2C->SR3;
 510  00f0 c65219        	ld	a,21017
 511  00f3 6b01          	ld	(OFST-1,sp),a
 514  00f5 2020          	jra	L752
 515  00f7               L352:
 516                     ; 104         size--;
 518  00f7 0a09          	dec	(OFST+7,sp)
 519                     ; 105         if(size == 0)
 521  00f9 0d09          	tnz	(OFST+7,sp)
 522  00fb 2604          	jrne	L762
 523                     ; 108             I2C->CR2 &= ~I2C_CR2_ACK;
 525  00fd 72155211      	bres	21009,#2
 526  0101               L762:
 527                     ; 111         while(!(I2C->SR1 & I2C_SR1_RXNE));
 529  0101 c65217        	ld	a,21015
 530  0104 a540          	bcp	a,#64
 531  0106 27f9          	jreq	L762
 532                     ; 112         buffer[index] = I2C_ReceiveData();
 534  0108 7b02          	ld	a,(OFST+0,sp)
 535  010a 5f            	clrw	x
 536  010b 97            	ld	xl,a
 537  010c 72fb07        	addw	x,(OFST+5,sp)
 538  010f 89            	pushw	x
 539  0110 cd0000        	call	_I2C_ReceiveData
 541  0113 85            	popw	x
 542  0114 f7            	ld	(x),a
 543                     ; 113         index++;
 545  0115 0c02          	inc	(OFST+0,sp)
 547  0117               L752:
 548                     ; 102     while(size)
 550  0117 0d09          	tnz	(OFST+7,sp)
 551  0119 26dc          	jrne	L352
 552                     ; 117     I2C_GenerateSTOP(ENABLE);
 554  011b a601          	ld	a,#1
 555  011d cd0000        	call	_I2C_GenerateSTOP
 558  0120               L572:
 559                     ; 121     while((I2C->SR3 & I2C_SR3_MSL));
 561  0120 c65219        	ld	a,21017
 562  0123 a501          	bcp	a,#1
 563  0125 26f9          	jrne	L572
 564                     ; 122     I2C_Cmd(DISABLE);
 566  0127 4f            	clr	a
 567  0128 cd0000        	call	_I2C_Cmd
 569                     ; 123 }
 572  012b 5b04          	addw	sp,#4
 573  012d 81            	ret
 586                     	xdef	_I2CRead
 587                     	xdef	_I2CWrite
 588                     	xdef	_I2CDeinit
 589                     	xdef	_I2CInit
 590                     	xref	_I2C_SendData
 591                     	xref	_I2C_Send7bitAddress
 592                     	xref	_I2C_ReceiveData
 593                     	xref	_I2C_GenerateSTOP
 594                     	xref	_I2C_GenerateSTART
 595                     	xref	_I2C_Cmd
 596                     	xref	_I2C_Init
 597                     	xref	_I2C_DeInit
 616                     	end
