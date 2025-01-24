   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  46                     ; 4 void I2CInit()
  46                     ; 5 {
  47                     	switch	.text
  48  0000               f_I2CInit:
  52                     ; 6     I2C_Init(100000, 0x00, I2C_DUTYCYCLE_2,
  52                     ; 7             I2C_ACK_NONE, I2C_ADDMODE_7BIT, 2);
  54  0000 4b02          	push	#2
  55  0002 4b00          	push	#0
  56  0004 4b00          	push	#0
  57  0006 4b00          	push	#0
  58  0008 5f            	clrw	x
  59  0009 89            	pushw	x
  60  000a ae86a0        	ldw	x,#34464
  61  000d 89            	pushw	x
  62  000e ae0001        	ldw	x,#1
  63  0011 89            	pushw	x
  64  0012 8d000000      	callf	f_I2C_Init
  66  0016 5b0a          	addw	sp,#10
  67                     ; 8 }
  70  0018 87            	retf	
  93                     ; 10 void I2CDeinit()
  93                     ; 11 {
  94                     	switch	.text
  95  0019               f_I2CDeinit:
  99                     ; 12     I2C_DeInit();
 102                     ; 13 }
 105  0019 ac000000      	jpf	f_I2C_DeInit
 189                     ; 15 void I2CWrite(uint8_t slave, uint8_t addr, uint8_t * buffer, uint8_t size)
 189                     ; 16 {
 190                     	switch	.text
 191  001d               f_I2CWrite:
 193  001d 89            	pushw	x
 194  001e 89            	pushw	x
 195       00000002      OFST:	set	2
 198                     ; 19 		uint8_t index = 0;
 200  001f 0f02          	clr	(OFST+0,sp)
 202                     ; 21     I2C_Cmd(ENABLE);
 204  0021 a601          	ld	a,#1
 205  0023 8d000000      	callf	f_I2C_Cmd
 207                     ; 22     I2C_GenerateSTART(ENABLE);
 209  0027 a601          	ld	a,#1
 210  0029 8d000000      	callf	f_I2C_GenerateSTART
 213  002d               L57:
 214                     ; 24     while(!(I2C->SR1 & I2C_SR1_SB));
 216  002d 72015217fb    	btjf	21015,#0,L57
 217                     ; 27     I2C_Send7bitAddress(slave, I2C_DIRECTION_TX);
 219  0032 7b03          	ld	a,(OFST+1,sp)
 220  0034 5f            	clrw	x
 221  0035 95            	ld	xh,a
 222  0036 8d000000      	callf	f_I2C_Send7bitAddress
 225  003a               L301:
 226                     ; 29     while(!(I2C->SR1 & I2C_SR1_ADDR));
 228  003a 72035217fb    	btjf	21015,#1,L301
 229                     ; 31     reg = I2C->SR1;
 231  003f c65217        	ld	a,21015
 232  0042 6b01          	ld	(OFST-1,sp),a
 234                     ; 32     reg = I2C->SR3;
 236  0044 c65219        	ld	a,21017
 237  0047 6b01          	ld	(OFST-1,sp),a
 239                     ; 35     I2C_SendData(addr);
 241  0049 7b04          	ld	a,(OFST+2,sp)
 242  004b 8d000000      	callf	f_I2C_SendData
 245  004f               L111:
 246                     ; 36     while(!(I2C->SR1 & I2C_SR1_TXE));
 248  004f 720f5217fb    	btjf	21015,#7,L111
 250  0054 2015          	jra	L711
 251  0056               L511:
 252                     ; 40         size--;
 254  0056 0a0a          	dec	(OFST+8,sp)
 255                     ; 41         I2C_SendData(buffer[index]);
 257  0058 5f            	clrw	x
 258  0059 7b02          	ld	a,(OFST+0,sp)
 259  005b 97            	ld	xl,a
 260  005c 72fb08        	addw	x,(OFST+6,sp)
 261  005f f6            	ld	a,(x)
 262  0060 8d000000      	callf	f_I2C_SendData
 264                     ; 42         index++;
 266  0064 0c02          	inc	(OFST+0,sp)
 269  0066               L521:
 270                     ; 44         while(!(I2C->SR1 & I2C_SR1_TXE));
 272  0066 720f5217fb    	btjf	21015,#7,L521
 273  006b               L711:
 274                     ; 38     while(size)
 276  006b 7b0a          	ld	a,(OFST+8,sp)
 277  006d 26e7          	jrne	L511
 279  006f               L331:
 280                     ; 48     while(!(I2C->SR1 & I2C_SR1_BTF));
 282  006f 72055217fb    	btjf	21015,#2,L331
 283                     ; 52     I2C_GenerateSTOP(ENABLE);
 285  0074 a601          	ld	a,#1
 286  0076 8d000000      	callf	f_I2C_GenerateSTOP
 289  007a               L141:
 290                     ; 55     while((I2C->SR3 & I2C_SR3_MSL));
 292  007a 72005219fb    	btjt	21017,#0,L141
 293                     ; 56     I2C_Cmd(DISABLE);
 295  007f 4f            	clr	a
 296  0080 8d000000      	callf	f_I2C_Cmd
 298                     ; 57 }
 301  0084 5b04          	addw	sp,#4
 302  0086 87            	retf	
 387                     ; 60 void I2CRead(uint8_t slave, uint8_t addr, uint8_t * buffer, uint8_t size)
 387                     ; 61 {
 388                     	switch	.text
 389  0087               f_I2CRead:
 391  0087 89            	pushw	x
 392  0088 89            	pushw	x
 393       00000002      OFST:	set	2
 396                     ; 64 		uint8_t index = 0;
 398  0089 0f02          	clr	(OFST+0,sp)
 400                     ; 66     I2C_Cmd(ENABLE);
 402  008b a601          	ld	a,#1
 403  008d 8d000000      	callf	f_I2C_Cmd
 405                     ; 67     I2C_GenerateSTART(ENABLE);
 407  0091 a601          	ld	a,#1
 408  0093 8d000000      	callf	f_I2C_GenerateSTART
 411  0097               L112:
 412                     ; 70     while(!(I2C->SR1 & I2C_SR1_SB));
 414  0097 72015217fb    	btjf	21015,#0,L112
 415                     ; 73     I2C_Send7bitAddress(slave, I2C_DIRECTION_TX);
 417  009c 7b03          	ld	a,(OFST+1,sp)
 418  009e 5f            	clrw	x
 419  009f 95            	ld	xh,a
 420  00a0 8d000000      	callf	f_I2C_Send7bitAddress
 423  00a4               L712:
 424                     ; 76     while(!(I2C->SR1 & I2C_SR1_ADDR));
 426  00a4 72035217fb    	btjf	21015,#1,L712
 427                     ; 78     reg = I2C->SR1;
 429  00a9 c65217        	ld	a,21015
 430  00ac 6b01          	ld	(OFST-1,sp),a
 432                     ; 79     reg = I2C->SR3;
 434  00ae c65219        	ld	a,21017
 435  00b1 6b01          	ld	(OFST-1,sp),a
 437                     ; 82     I2C_SendData(addr);
 439  00b3 7b04          	ld	a,(OFST+2,sp)
 440  00b5 8d000000      	callf	f_I2C_SendData
 443  00b9               L522:
 444                     ; 84     while(!(I2C->SR1 & I2C_SR1_TXE));
 446  00b9 720f5217fb    	btjf	21015,#7,L522
 448  00be               L332:
 449                     ; 86     while(!(I2C->SR1 & I2C_SR1_BTF));
 451  00be 72055217fb    	btjf	21015,#2,L332
 452                     ; 89     I2C->CR2 |= I2C_CR2_ACK;
 454  00c3 72145211      	bset	21009,#2
 455                     ; 91     I2C_GenerateSTART(ENABLE);
 457  00c7 a601          	ld	a,#1
 458  00c9 8d000000      	callf	f_I2C_GenerateSTART
 461  00cd               L142:
 462                     ; 93     while(!(I2C->SR1 & I2C_SR1_SB));
 464  00cd 72015217fb    	btjf	21015,#0,L142
 465                     ; 95     I2C_Send7bitAddress(slave, I2C_DIRECTION_RX);
 467  00d2 7b03          	ld	a,(OFST+1,sp)
 468  00d4 ae0001        	ldw	x,#1
 469  00d7 95            	ld	xh,a
 470  00d8 8d000000      	callf	f_I2C_Send7bitAddress
 473  00dc               L742:
 474                     ; 98     while(!(I2C->SR1 & I2C_SR1_ADDR));
 476  00dc 72035217fb    	btjf	21015,#1,L742
 477                     ; 100     reg = I2C->SR1;
 479  00e1 c65217        	ld	a,21015
 480  00e4 6b01          	ld	(OFST-1,sp),a
 482                     ; 101     reg = I2C->SR3;
 484  00e6 c65219        	ld	a,21017
 485  00e9 6b01          	ld	(OFST-1,sp),a
 488  00eb 201d          	jra	L752
 489  00ed               L352:
 490                     ; 105         size--;
 492  00ed 0a0a          	dec	(OFST+8,sp)
 493                     ; 106         if(size == 0)
 495  00ef 2604          	jrne	L762
 496                     ; 109             I2C->CR2 &= ~I2C_CR2_ACK;
 498  00f1 72155211      	bres	21009,#2
 499  00f5               L762:
 500                     ; 112         while(!(I2C->SR1 & I2C_SR1_RXNE));
 502  00f5 720d5217fb    	btjf	21015,#6,L762
 503                     ; 113         buffer[index] = I2C_ReceiveData();
 505  00fa 7b02          	ld	a,(OFST+0,sp)
 506  00fc 5f            	clrw	x
 507  00fd 97            	ld	xl,a
 508  00fe 72fb08        	addw	x,(OFST+6,sp)
 509  0101 89            	pushw	x
 510  0102 8d000000      	callf	f_I2C_ReceiveData
 512  0106 85            	popw	x
 513  0107 f7            	ld	(x),a
 514                     ; 114         index++;
 516  0108 0c02          	inc	(OFST+0,sp)
 518  010a               L752:
 519                     ; 103     while(size)
 521  010a 7b0a          	ld	a,(OFST+8,sp)
 522  010c 26df          	jrne	L352
 523                     ; 118     I2C_GenerateSTOP(ENABLE);
 525  010e 4c            	inc	a
 526  010f 8d000000      	callf	f_I2C_GenerateSTOP
 529  0113               L572:
 530                     ; 122     while((I2C->SR3 & I2C_SR3_MSL));
 532  0113 72005219fb    	btjt	21017,#0,L572
 533                     ; 123     I2C_Cmd(DISABLE);
 535  0118 4f            	clr	a
 536  0119 8d000000      	callf	f_I2C_Cmd
 538                     ; 124 }
 541  011d 5b04          	addw	sp,#4
 542  011f 87            	retf	
 554                     	xdef	f_I2CRead
 555                     	xdef	f_I2CWrite
 556                     	xdef	f_I2CDeinit
 557                     	xdef	f_I2CInit
 558                     	xref	f_I2C_SendData
 559                     	xref	f_I2C_Send7bitAddress
 560                     	xref	f_I2C_ReceiveData
 561                     	xref	f_I2C_GenerateSTOP
 562                     	xref	f_I2C_GenerateSTART
 563                     	xref	f_I2C_Cmd
 564                     	xref	f_I2C_Init
 565                     	xref	f_I2C_DeInit
 584                     	end
