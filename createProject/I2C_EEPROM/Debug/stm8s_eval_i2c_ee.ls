   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _sEEAddress:
  16  0000 00a0          	dc.w	160
  17  0002               _sEETimeout:
  18  0002 0000a000      	dc.l	40960
  49                     ; 105 uint32_t sEE_TIMEOUT_UserCallback(void)
  49                     ; 106 {
  51                     	switch	.text
  52  0000               _sEE_TIMEOUT_UserCallback:
  56                     ; 107   return 0;
  58  0000 ae0000        	ldw	x,#0
  59  0003 bf02          	ldw	c_lreg+2,x
  60  0005 ae0000        	ldw	x,#0
  61  0008 bf00          	ldw	c_lreg,x
  64  000a 81            	ret
  87                     ; 114 void sEE_DeInit(void)
  87                     ; 115 {
  88                     	switch	.text
  89  000b               _sEE_DeInit:
  93                     ; 117 }
  96  000b 81            	ret
 122                     ; 124 void sEE_Init(void)
 122                     ; 125 {
 123                     	switch	.text
 124  000c               _sEE_Init:
 128                     ; 127   CLK_PeripheralClockConfig(sEE_I2C_CLK, ENABLE);
 130  000c ae0001        	ldw	x,#1
 131  000f cd0000        	call	_CLK_PeripheralClockConfig
 133                     ; 130   I2C_Cmd( ENABLE);
 135  0012 a601          	ld	a,#1
 136  0014 cd0000        	call	_I2C_Cmd
 138                     ; 132   I2C_Init(I2C_SPEED, I2C_SLAVE_ADDRESS7, I2C_DUTYCYCLE_2, I2C_ACK_CURR, 
 138                     ; 133            I2C_ADDMODE_7BIT, 16);
 140  0017 4b10          	push	#16
 141  0019 4b00          	push	#0
 142  001b 4b01          	push	#1
 143  001d 4b00          	push	#0
 144  001f ae0050        	ldw	x,#80
 145  0022 89            	pushw	x
 146  0023 ae86a0        	ldw	x,#34464
 147  0026 89            	pushw	x
 148  0027 ae0001        	ldw	x,#1
 149  002a 89            	pushw	x
 150  002b cd0000        	call	_I2C_Init
 152  002e 5b0a          	addw	sp,#10
 153                     ; 139 }
 156  0030 81            	ret
 213                     ; 162 uint32_t sEE_ReadBuffer(uint8_t* pBuffer, uint16_t ReadAddr, uint16_t* NumByteToRead)
 213                     ; 163 {
 214                     	switch	.text
 215  0031               _sEE_ReadBuffer:
 217  0031 89            	pushw	x
 218       00000000      OFST:	set	0
 221                     ; 166   sEETimeout = sEE_LONG_TIMEOUT;
 223  0032 aea000        	ldw	x,#40960
 224  0035 bf04          	ldw	_sEETimeout+2,x
 225  0037 ae0000        	ldw	x,#0
 226  003a bf02          	ldw	_sEETimeout,x
 228  003c 2017          	jra	L76
 229  003e               L36:
 230                     ; 169     if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
 232  003e ae0002        	ldw	x,#_sEETimeout
 233  0041 cd0000        	call	c_ltor
 235  0044 ae0002        	ldw	x,#_sEETimeout
 236  0047 a601          	ld	a,#1
 237  0049 cd0000        	call	c_lgsbc
 239  004c cd0000        	call	c_lrzmp
 241  004f 2604          	jrne	L76
 244  0051 adad          	call	_sEE_TIMEOUT_UserCallback
 247  0053 2030          	jra	L41
 248  0055               L76:
 249                     ; 167   while(I2C_GetFlagStatus( I2C_FLAG_BUSBUSY))
 251  0055 ae0302        	ldw	x,#770
 252  0058 cd0000        	call	_I2C_GetFlagStatus
 254  005b 4d            	tnz	a
 255  005c 26e0          	jrne	L36
 256                     ; 173   I2C_GenerateSTART(ENABLE);
 258  005e a601          	ld	a,#1
 259  0060 cd0000        	call	_I2C_GenerateSTART
 261                     ; 176   sEETimeout = sEE_FLAG_TIMEOUT;
 263  0063 ae1000        	ldw	x,#4096
 264  0066 bf04          	ldw	_sEETimeout+2,x
 265  0068 ae0000        	ldw	x,#0
 266  006b bf02          	ldw	_sEETimeout,x
 268  006d 2019          	jra	L101
 269  006f               L57:
 270                     ; 179     if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
 272  006f ae0002        	ldw	x,#_sEETimeout
 273  0072 cd0000        	call	c_ltor
 275  0075 ae0002        	ldw	x,#_sEETimeout
 276  0078 a601          	ld	a,#1
 277  007a cd0000        	call	c_lgsbc
 279  007d cd0000        	call	c_lrzmp
 281  0080 2606          	jrne	L101
 284  0082 cd0000        	call	_sEE_TIMEOUT_UserCallback
 287  0085               L41:
 289  0085 5b02          	addw	sp,#2
 290  0087 81            	ret
 291  0088               L101:
 292                     ; 177   while(!I2C_CheckEvent( I2C_EVENT_MASTER_MODE_SELECT))
 294  0088 ae0301        	ldw	x,#769
 295  008b cd0000        	call	_I2C_CheckEvent
 297  008e 4d            	tnz	a
 298  008f 27de          	jreq	L57
 299                     ; 183   I2C_Send7bitAddress( (uint8_t)sEEAddress, I2C_DIRECTION_TX);
 301  0091 b601          	ld	a,_sEEAddress+1
 302  0093 5f            	clrw	x
 303  0094 95            	ld	xh,a
 304  0095 cd0000        	call	_I2C_Send7bitAddress
 306                     ; 186   sEETimeout = sEE_FLAG_TIMEOUT;
 308  0098 ae1000        	ldw	x,#4096
 309  009b bf04          	ldw	_sEETimeout+2,x
 310  009d ae0000        	ldw	x,#0
 311  00a0 bf02          	ldw	_sEETimeout,x
 313  00a2 2018          	jra	L311
 314  00a4               L701:
 315                     ; 189     if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
 317  00a4 ae0002        	ldw	x,#_sEETimeout
 318  00a7 cd0000        	call	c_ltor
 320  00aa ae0002        	ldw	x,#_sEETimeout
 321  00ad a601          	ld	a,#1
 322  00af cd0000        	call	c_lgsbc
 324  00b2 cd0000        	call	c_lrzmp
 326  00b5 2605          	jrne	L311
 329  00b7 cd0000        	call	_sEE_TIMEOUT_UserCallback
 332  00ba 20c9          	jra	L41
 333  00bc               L311:
 334                     ; 187   while(!I2C_CheckEvent( I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED))
 336  00bc ae0782        	ldw	x,#1922
 337  00bf cd0000        	call	_I2C_CheckEvent
 339  00c2 4d            	tnz	a
 340  00c3 27df          	jreq	L701
 341                     ; 210   sEETimeout = sEE_FLAG_TIMEOUT;
 343  00c5 ae1000        	ldw	x,#4096
 344  00c8 bf04          	ldw	_sEETimeout+2,x
 345  00ca ae0000        	ldw	x,#0
 346  00cd bf02          	ldw	_sEETimeout,x
 348  00cf 2018          	jra	L521
 349  00d1               L121:
 350                     ; 213     if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
 352  00d1 ae0002        	ldw	x,#_sEETimeout
 353  00d4 cd0000        	call	c_ltor
 355  00d7 ae0002        	ldw	x,#_sEETimeout
 356  00da a601          	ld	a,#1
 357  00dc cd0000        	call	c_lgsbc
 359  00df cd0000        	call	c_lrzmp
 361  00e2 2605          	jrne	L521
 364  00e4 cd0000        	call	_sEE_TIMEOUT_UserCallback
 367  00e7 209c          	jra	L41
 368  00e9               L521:
 369                     ; 211   while(I2C_GetFlagStatus(I2C_FLAG_TRANSFERFINISHED) == RESET)
 371  00e9 ae0104        	ldw	x,#260
 372  00ec cd0000        	call	_I2C_GetFlagStatus
 374  00ef 4d            	tnz	a
 375  00f0 27df          	jreq	L121
 376                     ; 217   I2C_GenerateSTART( ENABLE);
 378  00f2 a601          	ld	a,#1
 379  00f4 cd0000        	call	_I2C_GenerateSTART
 381                     ; 220   sEETimeout = sEE_FLAG_TIMEOUT;
 383  00f7 ae1000        	ldw	x,#4096
 384  00fa bf04          	ldw	_sEETimeout+2,x
 385  00fc ae0000        	ldw	x,#0
 386  00ff bf02          	ldw	_sEETimeout,x
 388  0101 2018          	jra	L731
 389  0103               L331:
 390                     ; 223     if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
 392  0103 ae0002        	ldw	x,#_sEETimeout
 393  0106 cd0000        	call	c_ltor
 395  0109 ae0002        	ldw	x,#_sEETimeout
 396  010c a601          	ld	a,#1
 397  010e cd0000        	call	c_lgsbc
 399  0111 cd0000        	call	c_lrzmp
 401  0114 2605          	jrne	L731
 404  0116 cd0000        	call	_sEE_TIMEOUT_UserCallback
 407  0119 2040          	jra	L61
 408  011b               L731:
 409                     ; 221   while(!I2C_CheckEvent( I2C_EVENT_MASTER_MODE_SELECT))
 411  011b ae0301        	ldw	x,#769
 412  011e cd0000        	call	_I2C_CheckEvent
 414  0121 4d            	tnz	a
 415  0122 27df          	jreq	L331
 416                     ; 227   I2C_Send7bitAddress((uint8_t)sEEAddress, I2C_DIRECTION_RX);
 418  0124 b601          	ld	a,_sEEAddress+1
 419  0126 ae0001        	ldw	x,#1
 420  0129 95            	ld	xh,a
 421  012a cd0000        	call	_I2C_Send7bitAddress
 423                     ; 230   if ((uint16_t)(*NumByteToRead)> 3) 
 425  012d 1e07          	ldw	x,(OFST+7,sp)
 426  012f 9093          	ldw	y,x
 427  0131 90fe          	ldw	y,(y)
 428  0133 90a30004      	cpw	y,#4
 429  0137 2549          	jrult	L541
 430                     ; 233       sEETimeout = sEE_FLAG_TIMEOUT;
 432  0139 ae1000        	ldw	x,#4096
 433  013c bf04          	ldw	_sEETimeout+2,x
 434  013e ae0000        	ldw	x,#0
 435  0141 bf02          	ldw	_sEETimeout,x
 437  0143 2019          	jra	L351
 438  0145               L741:
 439                     ; 236         if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
 441  0145 ae0002        	ldw	x,#_sEETimeout
 442  0148 cd0000        	call	c_ltor
 444  014b ae0002        	ldw	x,#_sEETimeout
 445  014e a601          	ld	a,#1
 446  0150 cd0000        	call	c_lgsbc
 448  0153 cd0000        	call	c_lrzmp
 450  0156 2606          	jrne	L351
 453  0158 cd0000        	call	_sEE_TIMEOUT_UserCallback
 456  015b               L61:
 458  015b 5b02          	addw	sp,#2
 459  015d 81            	ret
 460  015e               L351:
 461                     ; 234       while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
 463  015e ae0104        	ldw	x,#260
 464  0161 cd0000        	call	_I2C_GetFlagStatus
 466  0164 4d            	tnz	a
 467  0165 27de          	jreq	L741
 468                     ; 240       *pBuffer = I2C_ReceiveData();
 470  0167 cd0000        	call	_I2C_ReceiveData
 472  016a 1e01          	ldw	x,(OFST+1,sp)
 473  016c f7            	ld	(x),a
 474                     ; 243       *pBuffer++;
 476  016d 1e01          	ldw	x,(OFST+1,sp)
 477  016f 1c0001        	addw	x,#1
 478  0172 1f01          	ldw	(OFST+1,sp),x
 479  0174 1d0001        	subw	x,#1
 480  0177 f6            	ld	a,(x)
 481                     ; 246       (uint16_t)(*NumByteToRead)--;
 483  0178 1e07          	ldw	x,(OFST+7,sp)
 484  017a 9093          	ldw	y,x
 485  017c fe            	ldw	x,(x)
 486  017d 1d0001        	subw	x,#1
 487  0180 90ff          	ldw	(y),x
 488  0182               L541:
 489                     ; 251   if ((uint16_t)(*NumByteToRead) == 3)  
 491  0182 1e07          	ldw	x,(OFST+7,sp)
 492  0184 9093          	ldw	y,x
 493  0186 90fe          	ldw	y,(y)
 494  0188 90a30003      	cpw	y,#3
 495  018c 2703          	jreq	L42
 496  018e cc0225        	jp	L161
 497  0191               L42:
 498                     ; 255       sEETimeout = sEE_FLAG_TIMEOUT;
 500  0191 ae1000        	ldw	x,#4096
 501  0194 bf04          	ldw	_sEETimeout+2,x
 502  0196 ae0000        	ldw	x,#0
 503  0199 bf02          	ldw	_sEETimeout,x
 505  019b 2018          	jra	L761
 506  019d               L361:
 507                     ; 258         if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
 509  019d ae0002        	ldw	x,#_sEETimeout
 510  01a0 cd0000        	call	c_ltor
 512  01a3 ae0002        	ldw	x,#_sEETimeout
 513  01a6 a601          	ld	a,#1
 514  01a8 cd0000        	call	c_lgsbc
 516  01ab cd0000        	call	c_lrzmp
 518  01ae 2605          	jrne	L761
 521  01b0 cd0000        	call	_sEE_TIMEOUT_UserCallback
 524  01b3 20a6          	jra	L61
 525  01b5               L761:
 526                     ; 256       while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
 528  01b5 ae0104        	ldw	x,#260
 529  01b8 cd0000        	call	_I2C_GetFlagStatus
 531  01bb 4d            	tnz	a
 532  01bc 27df          	jreq	L361
 533                     ; 262       I2C_AcknowledgeConfig(I2C_ACK_NONE);
 535  01be 4f            	clr	a
 536  01bf cd0000        	call	_I2C_AcknowledgeConfig
 538                     ; 265       sEE_EnterCriticalSection_UserCallback();
 540  01c2 cd08d6        	call	_sEE_EnterCriticalSection_UserCallback
 542                     ; 268       *pBuffer = I2C_ReceiveData();
 544  01c5 cd0000        	call	_I2C_ReceiveData
 546  01c8 1e01          	ldw	x,(OFST+1,sp)
 547  01ca f7            	ld	(x),a
 548                     ; 271       *pBuffer++;
 550  01cb 1e01          	ldw	x,(OFST+1,sp)
 551  01cd 1c0001        	addw	x,#1
 552  01d0 1f01          	ldw	(OFST+1,sp),x
 553  01d2 1d0001        	subw	x,#1
 554  01d5 f6            	ld	a,(x)
 555                     ; 274       I2C_GenerateSTOP(ENABLE);
 557  01d6 a601          	ld	a,#1
 558  01d8 cd0000        	call	_I2C_GenerateSTOP
 560                     ; 277       *pBuffer = I2C_ReceiveData();
 562  01db cd0000        	call	_I2C_ReceiveData
 564  01de 1e01          	ldw	x,(OFST+1,sp)
 565  01e0 f7            	ld	(x),a
 566                     ; 280        sEE_ExitCriticalSection_UserCallback();
 568  01e1 cd08d8        	call	_sEE_ExitCriticalSection_UserCallback
 570                     ; 283       *pBuffer++;
 572  01e4 1e01          	ldw	x,(OFST+1,sp)
 573  01e6 1c0001        	addw	x,#1
 574  01e9 1f01          	ldw	(OFST+1,sp),x
 575  01eb 1d0001        	subw	x,#1
 576  01ee f6            	ld	a,(x)
 577                     ; 286       sEETimeout = sEE_FLAG_TIMEOUT;
 579  01ef ae1000        	ldw	x,#4096
 580  01f2 bf04          	ldw	_sEETimeout+2,x
 581  01f4 ae0000        	ldw	x,#0
 582  01f7 bf02          	ldw	_sEETimeout,x
 584  01f9 2018          	jra	L102
 585  01fb               L571:
 586                     ; 289         if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
 588  01fb ae0002        	ldw	x,#_sEETimeout
 589  01fe cd0000        	call	c_ltor
 591  0201 ae0002        	ldw	x,#_sEETimeout
 592  0204 a601          	ld	a,#1
 593  0206 cd0000        	call	c_lgsbc
 595  0209 cd0000        	call	c_lrzmp
 597  020c 2605          	jrne	L102
 600  020e cd0000        	call	_sEE_TIMEOUT_UserCallback
 603  0211 2048          	jra	L02
 604  0213               L102:
 605                     ; 287       while (I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET)
 607  0213 ae0140        	ldw	x,#320
 608  0216 cd0000        	call	_I2C_GetFlagStatus
 610  0219 4d            	tnz	a
 611  021a 27df          	jreq	L571
 612                     ; 292       *pBuffer = I2C_ReceiveData();
 614  021c cd0000        	call	_I2C_ReceiveData
 616  021f 1e01          	ldw	x,(OFST+1,sp)
 617  0221 f7            	ld	(x),a
 618                     ; 295       NumByteToRead = 0;
 620  0222 5f            	clrw	x
 621  0223 1f07          	ldw	(OFST+7,sp),x
 622  0225               L161:
 623                     ; 301   if ((uint16_t)(*NumByteToRead) == 2)
 625  0225 1e07          	ldw	x,(OFST+7,sp)
 626  0227 9093          	ldw	y,x
 627  0229 90fe          	ldw	y,(y)
 628  022b 90a30002      	cpw	y,#2
 629  022f 2703          	jreq	L62
 630  0231 cc02c0        	jp	L702
 631  0234               L62:
 632                     ; 304     I2C_AcknowledgeConfig(I2C_ACK_NEXT);
 634  0234 a602          	ld	a,#2
 635  0236 cd0000        	call	_I2C_AcknowledgeConfig
 637                     ; 307     sEETimeout = sEE_FLAG_TIMEOUT;
 639  0239 ae1000        	ldw	x,#4096
 640  023c bf04          	ldw	_sEETimeout+2,x
 641  023e ae0000        	ldw	x,#0
 642  0241 bf02          	ldw	_sEETimeout,x
 644  0243 2019          	jra	L512
 645  0245               L112:
 646                     ; 310       if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
 648  0245 ae0002        	ldw	x,#_sEETimeout
 649  0248 cd0000        	call	c_ltor
 651  024b ae0002        	ldw	x,#_sEETimeout
 652  024e a601          	ld	a,#1
 653  0250 cd0000        	call	c_lgsbc
 655  0253 cd0000        	call	c_lrzmp
 657  0256 2606          	jrne	L512
 660  0258 cd0000        	call	_sEE_TIMEOUT_UserCallback
 663  025b               L02:
 665  025b 5b02          	addw	sp,#2
 666  025d 81            	ret
 667  025e               L512:
 668                     ; 308     while(I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
 670  025e ae0102        	ldw	x,#258
 671  0261 cd0000        	call	_I2C_GetFlagStatus
 673  0264 4d            	tnz	a
 674  0265 27de          	jreq	L112
 675                     ; 314      (void)I2C->SR3;
 677  0267 c65219        	ld	a,21017
 678                     ; 317     I2C_AcknowledgeConfig(I2C_ACK_NONE);
 680  026a 4f            	clr	a
 681  026b cd0000        	call	_I2C_AcknowledgeConfig
 683                     ; 320       sEETimeout = sEE_FLAG_TIMEOUT;
 685  026e ae1000        	ldw	x,#4096
 686  0271 bf04          	ldw	_sEETimeout+2,x
 687  0273 ae0000        	ldw	x,#0
 688  0276 bf02          	ldw	_sEETimeout,x
 690  0278 2018          	jra	L722
 691  027a               L322:
 692                     ; 323         if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
 694  027a ae0002        	ldw	x,#_sEETimeout
 695  027d cd0000        	call	c_ltor
 697  0280 ae0002        	ldw	x,#_sEETimeout
 698  0283 a601          	ld	a,#1
 699  0285 cd0000        	call	c_lgsbc
 701  0288 cd0000        	call	c_lrzmp
 703  028b 2605          	jrne	L722
 706  028d cd0000        	call	_sEE_TIMEOUT_UserCallback
 709  0290 20c9          	jra	L02
 710  0292               L722:
 711                     ; 321       while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
 713  0292 ae0104        	ldw	x,#260
 714  0295 cd0000        	call	_I2C_GetFlagStatus
 716  0298 4d            	tnz	a
 717  0299 27df          	jreq	L322
 718                     ; 327     sEE_EnterCriticalSection_UserCallback();
 720  029b cd08d6        	call	_sEE_EnterCriticalSection_UserCallback
 722                     ; 330       I2C_GenerateSTOP(ENABLE);
 724  029e a601          	ld	a,#1
 725  02a0 cd0000        	call	_I2C_GenerateSTOP
 727                     ; 333       *pBuffer = I2C_ReceiveData();
 729  02a3 cd0000        	call	_I2C_ReceiveData
 731  02a6 1e01          	ldw	x,(OFST+1,sp)
 732  02a8 f7            	ld	(x),a
 733                     ; 336       *pBuffer++;  
 735  02a9 1e01          	ldw	x,(OFST+1,sp)
 736  02ab 1c0001        	addw	x,#1
 737  02ae 1f01          	ldw	(OFST+1,sp),x
 738  02b0 1d0001        	subw	x,#1
 739  02b3 f6            	ld	a,(x)
 740                     ; 339        sEE_ExitCriticalSection_UserCallback();
 742  02b4 cd08d8        	call	_sEE_ExitCriticalSection_UserCallback
 744                     ; 342       *pBuffer = I2C_ReceiveData();
 746  02b7 cd0000        	call	_I2C_ReceiveData
 748  02ba 1e01          	ldw	x,(OFST+1,sp)
 749  02bc f7            	ld	(x),a
 750                     ; 345       NumByteToRead = 0;   
 752  02bd 5f            	clrw	x
 753  02be 1f07          	ldw	(OFST+7,sp),x
 754  02c0               L702:
 755                     ; 350   if ((uint16_t)(*NumByteToRead) < 2)
 757  02c0 1e07          	ldw	x,(OFST+7,sp)
 758  02c2 9093          	ldw	y,x
 759  02c4 90fe          	ldw	y,(y)
 760  02c6 90a30002      	cpw	y,#2
 761  02ca 2503          	jrult	L03
 762  02cc cc037c        	jp	L532
 763  02cf               L03:
 764                     ; 353     sEETimeout = sEE_FLAG_TIMEOUT;
 766  02cf ae1000        	ldw	x,#4096
 767  02d2 bf04          	ldw	_sEETimeout+2,x
 768  02d4 ae0000        	ldw	x,#0
 769  02d7 bf02          	ldw	_sEETimeout,x
 771  02d9 2018          	jra	L342
 772  02db               L732:
 773                     ; 356       if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
 775  02db ae0002        	ldw	x,#_sEETimeout
 776  02de cd0000        	call	c_ltor
 778  02e1 ae0002        	ldw	x,#_sEETimeout
 779  02e4 a601          	ld	a,#1
 780  02e6 cd0000        	call	c_lgsbc
 782  02e9 cd0000        	call	c_lrzmp
 784  02ec 2605          	jrne	L342
 787  02ee cd0000        	call	_sEE_TIMEOUT_UserCallback
 790  02f1 203d          	jra	L22
 791  02f3               L342:
 792                     ; 354     while(I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
 794  02f3 ae0102        	ldw	x,#258
 795  02f6 cd0000        	call	_I2C_GetFlagStatus
 797  02f9 4d            	tnz	a
 798  02fa 27df          	jreq	L732
 799                     ; 360     I2C_AcknowledgeConfig(I2C_ACK_NONE);   
 801  02fc 4f            	clr	a
 802  02fd cd0000        	call	_I2C_AcknowledgeConfig
 804                     ; 363     sEE_EnterCriticalSection_UserCallback();
 806  0300 cd08d6        	call	_sEE_EnterCriticalSection_UserCallback
 808                     ; 366     (void)sEE_I2C->SR3;
 810  0303 c65219        	ld	a,21017
 811                     ; 369     I2C_GenerateSTOP( ENABLE);
 813  0306 a601          	ld	a,#1
 814  0308 cd0000        	call	_I2C_GenerateSTOP
 816                     ; 372     sEE_ExitCriticalSection_UserCallback();
 818  030b cd08d8        	call	_sEE_ExitCriticalSection_UserCallback
 820                     ; 375     sEETimeout = sEE_FLAG_TIMEOUT;
 822  030e ae1000        	ldw	x,#4096
 823  0311 bf04          	ldw	_sEETimeout+2,x
 824  0313 ae0000        	ldw	x,#0
 825  0316 bf02          	ldw	_sEETimeout,x
 827  0318 2019          	jra	L552
 828  031a               L152:
 829                     ; 378       if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
 831  031a ae0002        	ldw	x,#_sEETimeout
 832  031d cd0000        	call	c_ltor
 834  0320 ae0002        	ldw	x,#_sEETimeout
 835  0323 a601          	ld	a,#1
 836  0325 cd0000        	call	c_lgsbc
 838  0328 cd0000        	call	c_lrzmp
 840  032b 2606          	jrne	L552
 843  032d cd0000        	call	_sEE_TIMEOUT_UserCallback
 846  0330               L22:
 848  0330 5b02          	addw	sp,#2
 849  0332 81            	ret
 850  0333               L552:
 851                     ; 376     while(I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET)
 853  0333 ae0140        	ldw	x,#320
 854  0336 cd0000        	call	_I2C_GetFlagStatus
 856  0339 4d            	tnz	a
 857  033a 27de          	jreq	L152
 858                     ; 382     *pBuffer = I2C_ReceiveData();
 860  033c cd0000        	call	_I2C_ReceiveData
 862  033f 1e01          	ldw	x,(OFST+1,sp)
 863  0341 f7            	ld	(x),a
 864                     ; 385     (uint16_t)(*NumByteToRead)--;        
 866  0342 1e07          	ldw	x,(OFST+7,sp)
 867  0344 9093          	ldw	y,x
 868  0346 fe            	ldw	x,(x)
 869  0347 1d0001        	subw	x,#1
 870  034a 90ff          	ldw	(y),x
 871                     ; 388     sEETimeout = sEE_FLAG_TIMEOUT;
 873  034c ae1000        	ldw	x,#4096
 874  034f bf04          	ldw	_sEETimeout+2,x
 875  0351 ae0000        	ldw	x,#0
 876  0354 bf02          	ldw	_sEETimeout,x
 878  0356 2018          	jra	L762
 879  0358               L362:
 880                     ; 391       if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
 882  0358 ae0002        	ldw	x,#_sEETimeout
 883  035b cd0000        	call	c_ltor
 885  035e ae0002        	ldw	x,#_sEETimeout
 886  0361 a601          	ld	a,#1
 887  0363 cd0000        	call	c_lgsbc
 889  0366 cd0000        	call	c_lrzmp
 891  0369 2605          	jrne	L762
 894  036b cd0000        	call	_sEE_TIMEOUT_UserCallback
 897  036e 20c0          	jra	L22
 898  0370               L762:
 899                     ; 389     while(sEE_I2C->CR2 & I2C_CR2_STOP)
 901  0370 c65211        	ld	a,21009
 902  0373 a502          	bcp	a,#2
 903  0375 26e1          	jrne	L362
 904                     ; 395     I2C_AcknowledgeConfig( I2C_ACK_CURR);    
 906  0377 a601          	ld	a,#1
 907  0379 cd0000        	call	_I2C_AcknowledgeConfig
 909  037c               L532:
 910                     ; 398   return sEE_OK;  
 912  037c ae0000        	ldw	x,#0
 913  037f bf02          	ldw	c_lreg+2,x
 914  0381 ae0000        	ldw	x,#0
 915  0384 bf00          	ldw	c_lreg,x
 917  0386 20a8          	jra	L22
1011                     ; 409 void sEE_WriteBuffer(uint8_t* pBuffer, uint16_t WriteAddr, uint16_t NumByteToWrite)
1011                     ; 410 {
1012                     	switch	.text
1013  0388               _sEE_WriteBuffer:
1015  0388 89            	pushw	x
1016  0389 5207          	subw	sp,#7
1017       00000007      OFST:	set	7
1020                     ; 411   uint8_t NumOfPage = 0, NumOfSingle = 0, count = 0;
1026                     ; 412   uint16_t Addr = 0;
1028                     ; 414   Addr = WriteAddr % sEE_PAGESIZE;
1030  038b 7b0c          	ld	a,(OFST+5,sp)
1031  038d 97            	ld	xl,a
1032  038e 7b0d          	ld	a,(OFST+6,sp)
1033  0390 a43f          	and	a,#63
1034  0392 5f            	clrw	x
1035  0393 02            	rlwa	x,a
1036  0394 1f03          	ldw	(OFST-4,sp),x
1037  0396 01            	rrwa	x,a
1039                     ; 415   count = (uint8_t)(sEE_PAGESIZE - (uint16_t)Addr);
1041  0397 a640          	ld	a,#64
1042  0399 1004          	sub	a,(OFST-3,sp)
1043  039b 6b07          	ld	(OFST+0,sp),a
1045                     ; 416   NumOfPage =  (uint8_t)(NumByteToWrite / sEE_PAGESIZE);
1047  039d 1e0e          	ldw	x,(OFST+7,sp)
1048  039f a606          	ld	a,#6
1049  03a1               L43:
1050  03a1 54            	srlw	x
1051  03a2 4a            	dec	a
1052  03a3 26fc          	jrne	L43
1053  03a5 9f            	ld	a,xl
1054  03a6 6b06          	ld	(OFST-1,sp),a
1056                     ; 417   NumOfSingle = (uint8_t)(NumByteToWrite % sEE_PAGESIZE);
1058  03a8 7b0f          	ld	a,(OFST+8,sp)
1059  03aa a43f          	and	a,#63
1060  03ac 6b05          	ld	(OFST-2,sp),a
1062                     ; 420   if (Addr == 0)
1064  03ae 1e03          	ldw	x,(OFST-4,sp)
1065  03b0 2703          	jreq	L44
1066  03b2 cc0498        	jp	L343
1067  03b5               L44:
1068                     ; 423     if (NumOfPage == 0)
1070  03b5 0d06          	tnz	(OFST-1,sp)
1071  03b7 2703          	jreq	L64
1072  03b9 cc0449        	jp	L563
1073  03bc               L64:
1074                     ; 426       sEEDataNum = NumOfSingle;
1076  03bc 7b05          	ld	a,(OFST-2,sp)
1077  03be b700          	ld	_sEEDataNum,a
1078                     ; 428       sEE_WritePage(pBuffer, WriteAddr, (uint8_t*)(&sEEDataNum));
1080  03c0 ae0000        	ldw	x,#_sEEDataNum
1081  03c3 89            	pushw	x
1082  03c4 1e0e          	ldw	x,(OFST+7,sp)
1083  03c6 89            	pushw	x
1084  03c7 1e0c          	ldw	x,(OFST+5,sp)
1085  03c9 cd069e        	call	_sEE_WritePage
1087  03cc 5b04          	addw	sp,#4
1088                     ; 430       sEETimeout = sEE_LONG_TIMEOUT;
1090  03ce aea000        	ldw	x,#40960
1091  03d1 bf04          	ldw	_sEETimeout+2,x
1092  03d3 ae0000        	ldw	x,#0
1093  03d6 bf02          	ldw	_sEETimeout,x
1095  03d8 2018          	jra	L353
1096  03da               L743:
1097                     ; 433         if((sEETimeout--) == 0) {sEE_TIMEOUT_UserCallback(); return;};
1099  03da ae0002        	ldw	x,#_sEETimeout
1100  03dd cd0000        	call	c_ltor
1102  03e0 ae0002        	ldw	x,#_sEETimeout
1103  03e3 a601          	ld	a,#1
1104  03e5 cd0000        	call	c_lgsbc
1106  03e8 cd0000        	call	c_lrzmp
1108  03eb 2605          	jrne	L353
1111  03ed cd0000        	call	_sEE_TIMEOUT_UserCallback
1115  03f0 203f          	jra	L24
1116  03f2               L353:
1117                     ; 431       while (sEEDataNum > 0)
1119  03f2 3d00          	tnz	_sEEDataNum
1120  03f4 26e4          	jrne	L743
1121                     ; 435       sEE_WaitEepromStandbyState();
1123  03f6 cd07c6        	call	_sEE_WaitEepromStandbyState
1126  03f9 ac9a069a      	jpf	L714
1127  03fd               L363:
1128                     ; 443         sEEDataNum = sEE_PAGESIZE;
1130  03fd 35400000      	mov	_sEEDataNum,#64
1131                     ; 444         sEE_WritePage(pBuffer, WriteAddr, (uint8_t*)(&sEEDataNum));
1133  0401 ae0000        	ldw	x,#_sEEDataNum
1134  0404 89            	pushw	x
1135  0405 1e0e          	ldw	x,(OFST+7,sp)
1136  0407 89            	pushw	x
1137  0408 1e0c          	ldw	x,(OFST+5,sp)
1138  040a cd069e        	call	_sEE_WritePage
1140  040d 5b04          	addw	sp,#4
1141                     ; 446         sEETimeout = sEE_LONG_TIMEOUT;
1143  040f aea000        	ldw	x,#40960
1144  0412 bf04          	ldw	_sEETimeout+2,x
1145  0414 ae0000        	ldw	x,#0
1146  0417 bf02          	ldw	_sEETimeout,x
1148  0419 2019          	jra	L573
1149  041b               L173:
1150                     ; 449           if((sEETimeout--) == 0) {sEE_TIMEOUT_UserCallback(); return;};
1152  041b ae0002        	ldw	x,#_sEETimeout
1153  041e cd0000        	call	c_ltor
1155  0421 ae0002        	ldw	x,#_sEETimeout
1156  0424 a601          	ld	a,#1
1157  0426 cd0000        	call	c_lgsbc
1159  0429 cd0000        	call	c_lrzmp
1161  042c 2606          	jrne	L573
1164  042e cd0000        	call	_sEE_TIMEOUT_UserCallback
1167  0431               L24:
1170  0431 5b09          	addw	sp,#9
1171  0433 81            	ret
1172  0434               L573:
1173                     ; 447         while (sEEDataNum > 0)
1175  0434 3d00          	tnz	_sEEDataNum
1176  0436 26e3          	jrne	L173
1177                     ; 451         sEE_WaitEepromStandbyState();
1179  0438 cd07c6        	call	_sEE_WaitEepromStandbyState
1181                     ; 452         WriteAddr +=  sEE_PAGESIZE;
1183  043b 1e0c          	ldw	x,(OFST+5,sp)
1184  043d 1c0040        	addw	x,#64
1185  0440 1f0c          	ldw	(OFST+5,sp),x
1186                     ; 453         pBuffer += sEE_PAGESIZE;
1188  0442 1e08          	ldw	x,(OFST+1,sp)
1189  0444 1c0040        	addw	x,#64
1190  0447 1f08          	ldw	(OFST+1,sp),x
1191  0449               L563:
1192                     ; 440       while (NumOfPage--)
1194  0449 7b06          	ld	a,(OFST-1,sp)
1195  044b 0a06          	dec	(OFST-1,sp)
1197  044d 4d            	tnz	a
1198  044e 26ad          	jrne	L363
1199                     ; 456       if (NumOfSingle != 0)
1201  0450 0d05          	tnz	(OFST-2,sp)
1202  0452 2603          	jrne	L05
1203  0454 cc069a        	jp	L714
1204  0457               L05:
1205                     ; 459         sEEDataNum = NumOfSingle;
1207  0457 7b05          	ld	a,(OFST-2,sp)
1208  0459 b700          	ld	_sEEDataNum,a
1209                     ; 460         sEE_WritePage(pBuffer, WriteAddr, (uint8_t*)(&sEEDataNum));
1211  045b ae0000        	ldw	x,#_sEEDataNum
1212  045e 89            	pushw	x
1213  045f 1e0e          	ldw	x,(OFST+7,sp)
1214  0461 89            	pushw	x
1215  0462 1e0c          	ldw	x,(OFST+5,sp)
1216  0464 cd069e        	call	_sEE_WritePage
1218  0467 5b04          	addw	sp,#4
1219                     ; 462         sEETimeout = sEE_LONG_TIMEOUT;
1221  0469 aea000        	ldw	x,#40960
1222  046c bf04          	ldw	_sEETimeout+2,x
1223  046e ae0000        	ldw	x,#0
1224  0471 bf02          	ldw	_sEETimeout,x
1226  0473 2018          	jra	L114
1227  0475               L504:
1228                     ; 465           if((sEETimeout--) == 0) {sEE_TIMEOUT_UserCallback(); return;};
1230  0475 ae0002        	ldw	x,#_sEETimeout
1231  0478 cd0000        	call	c_ltor
1233  047b ae0002        	ldw	x,#_sEETimeout
1234  047e a601          	ld	a,#1
1235  0480 cd0000        	call	c_lgsbc
1237  0483 cd0000        	call	c_lrzmp
1239  0486 2605          	jrne	L114
1242  0488 cd0000        	call	_sEE_TIMEOUT_UserCallback
1246  048b 20a4          	jra	L24
1247  048d               L114:
1248                     ; 463         while (sEEDataNum > 0)
1250  048d 3d00          	tnz	_sEEDataNum
1251  048f 26e4          	jrne	L504
1252                     ; 467         sEE_WaitEepromStandbyState();
1254  0491 cd07c6        	call	_sEE_WaitEepromStandbyState
1256  0494 ac9a069a      	jpf	L714
1257  0498               L343:
1258                     ; 475     if (NumOfPage == 0)
1260  0498 0d06          	tnz	(OFST-1,sp)
1261  049a 2703          	jreq	L25
1262  049c cc0584        	jp	L124
1263  049f               L25:
1264                     ; 479       if (NumByteToWrite > count)
1266  049f 7b07          	ld	a,(OFST+0,sp)
1267  04a1 5f            	clrw	x
1268  04a2 97            	ld	xl,a
1269  04a3 bf00          	ldw	c_x,x
1270  04a5 1e0e          	ldw	x,(OFST+7,sp)
1271  04a7 b300          	cpw	x,c_x
1272  04a9 2203          	jrugt	L45
1273  04ab cc0541        	jp	L324
1274  04ae               L45:
1275                     ; 482         sEEDataNum = count;
1277  04ae 7b07          	ld	a,(OFST+0,sp)
1278  04b0 b700          	ld	_sEEDataNum,a
1279                     ; 484         sEE_WritePage(pBuffer, WriteAddr, (uint8_t*)(&sEEDataNum));
1281  04b2 ae0000        	ldw	x,#_sEEDataNum
1282  04b5 89            	pushw	x
1283  04b6 1e0e          	ldw	x,(OFST+7,sp)
1284  04b8 89            	pushw	x
1285  04b9 1e0c          	ldw	x,(OFST+5,sp)
1286  04bb cd069e        	call	_sEE_WritePage
1288  04be 5b04          	addw	sp,#4
1289                     ; 486         sEETimeout = sEE_LONG_TIMEOUT;
1291  04c0 aea000        	ldw	x,#40960
1292  04c3 bf04          	ldw	_sEETimeout+2,x
1293  04c5 ae0000        	ldw	x,#0
1294  04c8 bf02          	ldw	_sEETimeout,x
1296  04ca 201a          	jra	L134
1297  04cc               L524:
1298                     ; 489           if((sEETimeout--) == 0) {sEE_TIMEOUT_UserCallback(); return;};
1300  04cc ae0002        	ldw	x,#_sEETimeout
1301  04cf cd0000        	call	c_ltor
1303  04d2 ae0002        	ldw	x,#_sEETimeout
1304  04d5 a601          	ld	a,#1
1305  04d7 cd0000        	call	c_lgsbc
1307  04da cd0000        	call	c_lrzmp
1309  04dd 2607          	jrne	L134
1312  04df cd0000        	call	_sEE_TIMEOUT_UserCallback
1316  04e2 ac310431      	jpf	L24
1317  04e6               L134:
1318                     ; 487         while (sEEDataNum > 0)
1320  04e6 3d00          	tnz	_sEEDataNum
1321  04e8 26e2          	jrne	L524
1322                     ; 491         sEE_WaitEepromStandbyState();
1324  04ea cd07c6        	call	_sEE_WaitEepromStandbyState
1326                     ; 494         sEEDataNum = (uint8_t)(NumByteToWrite - count);
1328  04ed 7b0f          	ld	a,(OFST+8,sp)
1329  04ef 1007          	sub	a,(OFST+0,sp)
1330  04f1 b700          	ld	_sEEDataNum,a
1331                     ; 496         sEE_WritePage((uint8_t*)(pBuffer + count), (WriteAddr + count), (uint8_t*)(&sEEDataNum));
1333  04f3 ae0000        	ldw	x,#_sEEDataNum
1334  04f6 89            	pushw	x
1335  04f7 7b0e          	ld	a,(OFST+7,sp)
1336  04f9 97            	ld	xl,a
1337  04fa 7b0f          	ld	a,(OFST+8,sp)
1338  04fc 1b09          	add	a,(OFST+2,sp)
1339  04fe 2401          	jrnc	L63
1340  0500 5c            	incw	x
1341  0501               L63:
1342  0501 02            	rlwa	x,a
1343  0502 89            	pushw	x
1344  0503 01            	rrwa	x,a
1345  0504 7b0b          	ld	a,(OFST+4,sp)
1346  0506 5f            	clrw	x
1347  0507 97            	ld	xl,a
1348  0508 72fb0c        	addw	x,(OFST+5,sp)
1349  050b cd069e        	call	_sEE_WritePage
1351  050e 5b04          	addw	sp,#4
1352                     ; 498         sEETimeout = sEE_LONG_TIMEOUT;
1354  0510 aea000        	ldw	x,#40960
1355  0513 bf04          	ldw	_sEETimeout+2,x
1356  0515 ae0000        	ldw	x,#0
1357  0518 bf02          	ldw	_sEETimeout,x
1359  051a 201a          	jra	L344
1360  051c               L734:
1361                     ; 501           if((sEETimeout--) == 0) {sEE_TIMEOUT_UserCallback(); return;};
1363  051c ae0002        	ldw	x,#_sEETimeout
1364  051f cd0000        	call	c_ltor
1366  0522 ae0002        	ldw	x,#_sEETimeout
1367  0525 a601          	ld	a,#1
1368  0527 cd0000        	call	c_lgsbc
1370  052a cd0000        	call	c_lrzmp
1372  052d 2607          	jrne	L344
1375  052f cd0000        	call	_sEE_TIMEOUT_UserCallback
1379  0532 ac310431      	jpf	L24
1380  0536               L344:
1381                     ; 499         while (sEEDataNum > 0)
1383  0536 3d00          	tnz	_sEEDataNum
1384  0538 26e2          	jrne	L734
1385                     ; 503         sEE_WaitEepromStandbyState();
1387  053a cd07c6        	call	_sEE_WaitEepromStandbyState
1390  053d ac9a069a      	jpf	L714
1391  0541               L324:
1392                     ; 508         sEEDataNum = NumOfSingle;
1394  0541 7b05          	ld	a,(OFST-2,sp)
1395  0543 b700          	ld	_sEEDataNum,a
1396                     ; 509         sEE_WritePage(pBuffer, WriteAddr, (uint8_t*)(&sEEDataNum));
1398  0545 ae0000        	ldw	x,#_sEEDataNum
1399  0548 89            	pushw	x
1400  0549 1e0e          	ldw	x,(OFST+7,sp)
1401  054b 89            	pushw	x
1402  054c 1e0c          	ldw	x,(OFST+5,sp)
1403  054e cd069e        	call	_sEE_WritePage
1405  0551 5b04          	addw	sp,#4
1406                     ; 511         sEETimeout = sEE_LONG_TIMEOUT;
1408  0553 aea000        	ldw	x,#40960
1409  0556 bf04          	ldw	_sEETimeout+2,x
1410  0558 ae0000        	ldw	x,#0
1411  055b bf02          	ldw	_sEETimeout,x
1413  055d 201a          	jra	L754
1414  055f               L354:
1415                     ; 514           if((sEETimeout--) == 0) {sEE_TIMEOUT_UserCallback(); return;};
1417  055f ae0002        	ldw	x,#_sEETimeout
1418  0562 cd0000        	call	c_ltor
1420  0565 ae0002        	ldw	x,#_sEETimeout
1421  0568 a601          	ld	a,#1
1422  056a cd0000        	call	c_lgsbc
1424  056d cd0000        	call	c_lrzmp
1426  0570 2607          	jrne	L754
1429  0572 cd0000        	call	_sEE_TIMEOUT_UserCallback
1433  0575 ac310431      	jpf	L24
1434  0579               L754:
1435                     ; 512         while (sEEDataNum > 0)
1437  0579 3d00          	tnz	_sEEDataNum
1438  057b 26e2          	jrne	L354
1439                     ; 516         sEE_WaitEepromStandbyState();
1441  057d cd07c6        	call	_sEE_WaitEepromStandbyState
1443  0580 ac9a069a      	jpf	L714
1444  0584               L124:
1445                     ; 522       NumByteToWrite -= count;
1447  0584 7b07          	ld	a,(OFST+0,sp)
1448  0586 5f            	clrw	x
1449  0587 97            	ld	xl,a
1450  0588 1f01          	ldw	(OFST-6,sp),x
1452  058a 1e0e          	ldw	x,(OFST+7,sp)
1453  058c 72f001        	subw	x,(OFST-6,sp)
1454  058f 1f0e          	ldw	(OFST+7,sp),x
1455                     ; 523       NumOfPage = (uint8_t)(NumByteToWrite / sEE_PAGESIZE);
1457  0591 1e0e          	ldw	x,(OFST+7,sp)
1458  0593 a606          	ld	a,#6
1459  0595               L04:
1460  0595 54            	srlw	x
1461  0596 4a            	dec	a
1462  0597 26fc          	jrne	L04
1463  0599 9f            	ld	a,xl
1464  059a 6b06          	ld	(OFST-1,sp),a
1466                     ; 524       NumOfSingle = (uint8_t)(NumByteToWrite % sEE_PAGESIZE);
1468  059c 7b0f          	ld	a,(OFST+8,sp)
1469  059e a43f          	and	a,#63
1470  05a0 6b05          	ld	(OFST-2,sp),a
1472                     ; 526       if (count != 0)
1474  05a2 0d07          	tnz	(OFST+0,sp)
1475  05a4 2603          	jrne	L65
1476  05a6 cc0651        	jp	L505
1477  05a9               L65:
1478                     ; 529         sEEDataNum = count;
1480  05a9 7b07          	ld	a,(OFST+0,sp)
1481  05ab b700          	ld	_sEEDataNum,a
1482                     ; 530         sEE_WritePage(pBuffer, WriteAddr, (uint8_t*)(&sEEDataNum));
1484  05ad ae0000        	ldw	x,#_sEEDataNum
1485  05b0 89            	pushw	x
1486  05b1 1e0e          	ldw	x,(OFST+7,sp)
1487  05b3 89            	pushw	x
1488  05b4 1e0c          	ldw	x,(OFST+5,sp)
1489  05b6 cd069e        	call	_sEE_WritePage
1491  05b9 5b04          	addw	sp,#4
1492                     ; 532         sEETimeout = sEE_LONG_TIMEOUT;
1494  05bb aea000        	ldw	x,#40960
1495  05be bf04          	ldw	_sEETimeout+2,x
1496  05c0 ae0000        	ldw	x,#0
1497  05c3 bf02          	ldw	_sEETimeout,x
1499  05c5 201a          	jra	L574
1500  05c7               L174:
1501                     ; 535           if((sEETimeout--) == 0) {sEE_TIMEOUT_UserCallback(); return;};
1503  05c7 ae0002        	ldw	x,#_sEETimeout
1504  05ca cd0000        	call	c_ltor
1506  05cd ae0002        	ldw	x,#_sEETimeout
1507  05d0 a601          	ld	a,#1
1508  05d2 cd0000        	call	c_lgsbc
1510  05d5 cd0000        	call	c_lrzmp
1512  05d8 2607          	jrne	L574
1515  05da cd0000        	call	_sEE_TIMEOUT_UserCallback
1519  05dd ac310431      	jpf	L24
1520  05e1               L574:
1521                     ; 533         while (sEEDataNum > 0)
1523  05e1 3d00          	tnz	_sEEDataNum
1524  05e3 26e2          	jrne	L174
1525                     ; 537         sEE_WaitEepromStandbyState();
1527  05e5 cd07c6        	call	_sEE_WaitEepromStandbyState
1529                     ; 538         WriteAddr += count;
1531  05e8 7b07          	ld	a,(OFST+0,sp)
1532  05ea 5f            	clrw	x
1533  05eb 97            	ld	xl,a
1534  05ec 1f01          	ldw	(OFST-6,sp),x
1536  05ee 1e0c          	ldw	x,(OFST+5,sp)
1537  05f0 72fb01        	addw	x,(OFST-6,sp)
1538  05f3 1f0c          	ldw	(OFST+5,sp),x
1539                     ; 539         pBuffer += count;
1541  05f5 7b07          	ld	a,(OFST+0,sp)
1542  05f7 5f            	clrw	x
1543  05f8 97            	ld	xl,a
1544  05f9 1f01          	ldw	(OFST-6,sp),x
1546  05fb 1e08          	ldw	x,(OFST+1,sp)
1547  05fd 72fb01        	addw	x,(OFST-6,sp)
1548  0600 1f08          	ldw	(OFST+1,sp),x
1549  0602 204d          	jra	L505
1550  0604               L305:
1551                     ; 545         sEEDataNum = sEE_PAGESIZE;
1553  0604 35400000      	mov	_sEEDataNum,#64
1554                     ; 546         sEE_WritePage(pBuffer, WriteAddr, (uint8_t*)(&sEEDataNum));
1556  0608 ae0000        	ldw	x,#_sEEDataNum
1557  060b 89            	pushw	x
1558  060c 1e0e          	ldw	x,(OFST+7,sp)
1559  060e 89            	pushw	x
1560  060f 1e0c          	ldw	x,(OFST+5,sp)
1561  0611 cd069e        	call	_sEE_WritePage
1563  0614 5b04          	addw	sp,#4
1564                     ; 548         sEETimeout = sEE_LONG_TIMEOUT;
1566  0616 aea000        	ldw	x,#40960
1567  0619 bf04          	ldw	_sEETimeout+2,x
1568  061b ae0000        	ldw	x,#0
1569  061e bf02          	ldw	_sEETimeout,x
1571  0620 201a          	jra	L515
1572  0622               L115:
1573                     ; 551           if((sEETimeout--) == 0) {sEE_TIMEOUT_UserCallback(); return;};
1575  0622 ae0002        	ldw	x,#_sEETimeout
1576  0625 cd0000        	call	c_ltor
1578  0628 ae0002        	ldw	x,#_sEETimeout
1579  062b a601          	ld	a,#1
1580  062d cd0000        	call	c_lgsbc
1582  0630 cd0000        	call	c_lrzmp
1584  0633 2607          	jrne	L515
1587  0635 cd0000        	call	_sEE_TIMEOUT_UserCallback
1591  0638 ac310431      	jpf	L24
1592  063c               L515:
1593                     ; 549         while (sEEDataNum > 0)
1595  063c 3d00          	tnz	_sEEDataNum
1596  063e 26e2          	jrne	L115
1597                     ; 553         sEE_WaitEepromStandbyState();
1599  0640 cd07c6        	call	_sEE_WaitEepromStandbyState
1601                     ; 554         WriteAddr +=  sEE_PAGESIZE;
1603  0643 1e0c          	ldw	x,(OFST+5,sp)
1604  0645 1c0040        	addw	x,#64
1605  0648 1f0c          	ldw	(OFST+5,sp),x
1606                     ; 555         pBuffer += sEE_PAGESIZE;
1608  064a 1e08          	ldw	x,(OFST+1,sp)
1609  064c 1c0040        	addw	x,#64
1610  064f 1f08          	ldw	(OFST+1,sp),x
1611  0651               L505:
1612                     ; 542       while (NumOfPage--)
1614  0651 7b06          	ld	a,(OFST-1,sp)
1615  0653 0a06          	dec	(OFST-1,sp)
1617  0655 4d            	tnz	a
1618  0656 26ac          	jrne	L305
1619                     ; 557       if (NumOfSingle != 0)
1621  0658 0d05          	tnz	(OFST-2,sp)
1622  065a 273e          	jreq	L714
1623                     ; 560         sEEDataNum = NumOfSingle;
1625  065c 7b05          	ld	a,(OFST-2,sp)
1626  065e b700          	ld	_sEEDataNum,a
1627                     ; 561         sEE_WritePage(pBuffer, WriteAddr, (uint8_t*)(&sEEDataNum));
1629  0660 ae0000        	ldw	x,#_sEEDataNum
1630  0663 89            	pushw	x
1631  0664 1e0e          	ldw	x,(OFST+7,sp)
1632  0666 89            	pushw	x
1633  0667 1e0c          	ldw	x,(OFST+5,sp)
1634  0669 ad33          	call	_sEE_WritePage
1636  066b 5b04          	addw	sp,#4
1637                     ; 563         sEETimeout = sEE_LONG_TIMEOUT;
1639  066d aea000        	ldw	x,#40960
1640  0670 bf04          	ldw	_sEETimeout+2,x
1641  0672 ae0000        	ldw	x,#0
1642  0675 bf02          	ldw	_sEETimeout,x
1644  0677 201a          	jra	L135
1645  0679               L525:
1646                     ; 566           if((sEETimeout--) == 0) {sEE_TIMEOUT_UserCallback(); return;};
1648  0679 ae0002        	ldw	x,#_sEETimeout
1649  067c cd0000        	call	c_ltor
1651  067f ae0002        	ldw	x,#_sEETimeout
1652  0682 a601          	ld	a,#1
1653  0684 cd0000        	call	c_lgsbc
1655  0687 cd0000        	call	c_lrzmp
1657  068a 2607          	jrne	L135
1660  068c cd0000        	call	_sEE_TIMEOUT_UserCallback
1664  068f ac310431      	jpf	L24
1665  0693               L135:
1666                     ; 564         while (sEEDataNum > 0)
1668  0693 3d00          	tnz	_sEEDataNum
1669  0695 26e2          	jrne	L525
1670                     ; 568         sEE_WaitEepromStandbyState();
1672  0697 cd07c6        	call	_sEE_WaitEepromStandbyState
1674  069a               L714:
1675                     ; 572 }
1677  069a ac310431      	jpf	L24
1732                     ; 597 uint32_t sEE_WritePage(uint8_t* pBuffer, uint16_t WriteAddr, uint8_t* NumByteToWrite)
1732                     ; 598 {
1733                     	switch	.text
1734  069e               _sEE_WritePage:
1736  069e 89            	pushw	x
1737       00000000      OFST:	set	0
1740                     ; 602   sEEDataWritePointer = NumByteToWrite;  
1742  069f 1e07          	ldw	x,(OFST+7,sp)
1743  06a1 bf01          	ldw	_sEEDataWritePointer,x
1744                     ; 605   sEETimeout = sEE_LONG_TIMEOUT;
1746  06a3 aea000        	ldw	x,#40960
1747  06a6 bf04          	ldw	_sEETimeout+2,x
1748  06a8 ae0000        	ldw	x,#0
1749  06ab bf02          	ldw	_sEETimeout,x
1751  06ad 2018          	jra	L565
1752  06af               L165:
1753                     ; 608     if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
1755  06af ae0002        	ldw	x,#_sEETimeout
1756  06b2 cd0000        	call	c_ltor
1758  06b5 ae0002        	ldw	x,#_sEETimeout
1759  06b8 a601          	ld	a,#1
1760  06ba cd0000        	call	c_lgsbc
1762  06bd cd0000        	call	c_lrzmp
1764  06c0 2605          	jrne	L565
1767  06c2 cd0000        	call	_sEE_TIMEOUT_UserCallback
1770  06c5 2030          	jra	L26
1771  06c7               L565:
1772                     ; 606   while(I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
1774  06c7 ae0302        	ldw	x,#770
1775  06ca cd0000        	call	_I2C_GetFlagStatus
1777  06cd 4d            	tnz	a
1778  06ce 26df          	jrne	L165
1779                     ; 612   I2C_GenerateSTART( ENABLE);
1781  06d0 a601          	ld	a,#1
1782  06d2 cd0000        	call	_I2C_GenerateSTART
1784                     ; 615   sEETimeout = sEE_FLAG_TIMEOUT;
1786  06d5 ae1000        	ldw	x,#4096
1787  06d8 bf04          	ldw	_sEETimeout+2,x
1788  06da ae0000        	ldw	x,#0
1789  06dd bf02          	ldw	_sEETimeout,x
1791  06df 2019          	jra	L775
1792  06e1               L375:
1793                     ; 618     if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
1795  06e1 ae0002        	ldw	x,#_sEETimeout
1796  06e4 cd0000        	call	c_ltor
1798  06e7 ae0002        	ldw	x,#_sEETimeout
1799  06ea a601          	ld	a,#1
1800  06ec cd0000        	call	c_lgsbc
1802  06ef cd0000        	call	c_lrzmp
1804  06f2 2606          	jrne	L775
1807  06f4 cd0000        	call	_sEE_TIMEOUT_UserCallback
1810  06f7               L26:
1812  06f7 5b02          	addw	sp,#2
1813  06f9 81            	ret
1814  06fa               L775:
1815                     ; 616   while(!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT))
1817  06fa ae0301        	ldw	x,#769
1818  06fd cd0000        	call	_I2C_CheckEvent
1820  0700 4d            	tnz	a
1821  0701 27de          	jreq	L375
1822                     ; 622   sEETimeout = sEE_FLAG_TIMEOUT;
1824  0703 ae1000        	ldw	x,#4096
1825  0706 bf04          	ldw	_sEETimeout+2,x
1826  0708 ae0000        	ldw	x,#0
1827  070b bf02          	ldw	_sEETimeout,x
1828                     ; 623   I2C_Send7bitAddress((uint8_t)sEEAddress, I2C_DIRECTION_TX);
1830  070d b601          	ld	a,_sEEAddress+1
1831  070f 5f            	clrw	x
1832  0710 95            	ld	xh,a
1833  0711 cd0000        	call	_I2C_Send7bitAddress
1835                     ; 626   sEETimeout = sEE_FLAG_TIMEOUT;
1837  0714 ae1000        	ldw	x,#4096
1838  0717 bf04          	ldw	_sEETimeout+2,x
1839  0719 ae0000        	ldw	x,#0
1840  071c bf02          	ldw	_sEETimeout,x
1842  071e 2018          	jra	L116
1843  0720               L506:
1844                     ; 629     if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
1846  0720 ae0002        	ldw	x,#_sEETimeout
1847  0723 cd0000        	call	c_ltor
1849  0726 ae0002        	ldw	x,#_sEETimeout
1850  0729 a601          	ld	a,#1
1851  072b cd0000        	call	c_lgsbc
1853  072e cd0000        	call	c_lrzmp
1855  0731 2605          	jrne	L116
1858  0733 cd0000        	call	_sEE_TIMEOUT_UserCallback
1861  0736 20bf          	jra	L26
1862  0738               L116:
1863                     ; 627   while(!I2C_CheckEvent( I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED))
1865  0738 ae0782        	ldw	x,#1922
1866  073b cd0000        	call	_I2C_CheckEvent
1868  073e 4d            	tnz	a
1869  073f 27df          	jreq	L506
1870                     ; 655   sEETimeout = sEE_FLAG_TIMEOUT; 
1872  0741 ae1000        	ldw	x,#4096
1873  0744 bf04          	ldw	_sEETimeout+2,x
1874  0746 ae0000        	ldw	x,#0
1875  0749 bf02          	ldw	_sEETimeout,x
1877  074b 2018          	jra	L326
1878  074d               L716:
1879                     ; 658     if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
1881  074d ae0002        	ldw	x,#_sEETimeout
1882  0750 cd0000        	call	c_ltor
1884  0753 ae0002        	ldw	x,#_sEETimeout
1885  0756 a601          	ld	a,#1
1886  0758 cd0000        	call	c_lgsbc
1888  075b cd0000        	call	c_lrzmp
1890  075e 2605          	jrne	L326
1893  0760 cd0000        	call	_sEE_TIMEOUT_UserCallback
1896  0763 2092          	jra	L26
1897  0765               L326:
1898                     ; 656   while(!I2C_CheckEvent( I2C_EVENT_MASTER_BYTE_TRANSMITTED))
1900  0765 ae0784        	ldw	x,#1924
1901  0768 cd0000        	call	_I2C_CheckEvent
1903  076b 4d            	tnz	a
1904  076c 27df          	jreq	L716
1906  076e 2034          	jra	L336
1907  0770               L136:
1908                     ; 665     I2C_SendData( *pBuffer);
1910  0770 1e01          	ldw	x,(OFST+1,sp)
1911  0772 f6            	ld	a,(x)
1912  0773 cd0000        	call	_I2C_SendData
1914                     ; 669     sEETimeout = sEE_LONG_TIMEOUT;
1916  0776 aea000        	ldw	x,#40960
1917  0779 bf04          	ldw	_sEETimeout+2,x
1918  077b ae0000        	ldw	x,#0
1919  077e bf02          	ldw	_sEETimeout,x
1921  0780 2016          	jra	L346
1922  0782               L736:
1923                     ; 672       if((sEETimeout--) == 0) sEE_TIMEOUT_UserCallback();
1925  0782 ae0002        	ldw	x,#_sEETimeout
1926  0785 cd0000        	call	c_ltor
1928  0788 ae0002        	ldw	x,#_sEETimeout
1929  078b a601          	ld	a,#1
1930  078d cd0000        	call	c_lgsbc
1932  0790 cd0000        	call	c_lrzmp
1934  0793 2603          	jrne	L346
1937  0795 cd0000        	call	_sEE_TIMEOUT_UserCallback
1939  0798               L346:
1940                     ; 670     while(!I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED))
1942  0798 ae0104        	ldw	x,#260
1943  079b cd0000        	call	_I2C_GetFlagStatus
1945  079e 4d            	tnz	a
1946  079f 27e1          	jreq	L736
1947                     ; 674     (uint16_t)(*sEEDataWritePointer)--;
1949  07a1 923a01        	dec	[_sEEDataWritePointer.w]
1950  07a4               L336:
1951                     ; 662   while((uint16_t)(*sEEDataWritePointer) > 0)
1953  07a4 92c601        	ld	a,[_sEEDataWritePointer.w]
1954  07a7 5f            	clrw	x
1955  07a8 97            	ld	xl,a
1956  07a9 a30000        	cpw	x,#0
1957  07ac 26c2          	jrne	L136
1958                     ; 678     I2C_GenerateSTOP(ENABLE);
1960  07ae a601          	ld	a,#1
1961  07b0 cd0000        	call	_I2C_GenerateSTOP
1963                     ; 681     (void)sEE_I2C->SR1;
1965  07b3 c65217        	ld	a,21015
1966                     ; 682     (void)sEE_I2C->SR3;
1968  07b6 c65219        	ld	a,21017
1969                     ; 685   return sEE_OK;  
1971  07b9 ae0000        	ldw	x,#0
1972  07bc bf02          	ldw	c_lreg+2,x
1973  07be ae0000        	ldw	x,#0
1974  07c1 bf00          	ldw	c_lreg,x
1977  07c3 5b02          	addw	sp,#2
1978  07c5 81            	ret
2031                     .const:	section	.text
2032  0000               L67:
2033  0000 00000096      	dc.l	150
2034                     ; 706 uint32_t sEE_WaitEepromStandbyState(void) 
2034                     ; 707 {
2035                     	switch	.text
2036  07c6               _sEE_WaitEepromStandbyState:
2038  07c6 5207          	subw	sp,#7
2039       00000007      OFST:	set	7
2042                     ; 708   __IO uint8_t tmpSR1 = 0;
2044  07c8 0f07          	clr	(OFST+0,sp)
2046                     ; 709   __IO uint32_t sEETrials = 0;
2048  07ca ae0000        	ldw	x,#0
2049  07cd 1f05          	ldw	(OFST-2,sp),x
2050  07cf ae0000        	ldw	x,#0
2051  07d2 1f03          	ldw	(OFST-4,sp),x
2053                     ; 712   sEETimeout = sEE_LONG_TIMEOUT;
2055  07d4 aea000        	ldw	x,#40960
2056  07d7 bf04          	ldw	_sEETimeout+2,x
2057  07d9 ae0000        	ldw	x,#0
2058  07dc bf02          	ldw	_sEETimeout,x
2060  07de 2018          	jra	L776
2061  07e0               L376:
2062                     ; 715     if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
2064  07e0 ae0002        	ldw	x,#_sEETimeout
2065  07e3 cd0000        	call	c_ltor
2067  07e6 ae0002        	ldw	x,#_sEETimeout
2068  07e9 a601          	ld	a,#1
2069  07eb cd0000        	call	c_lgsbc
2071  07ee cd0000        	call	c_lrzmp
2073  07f1 2605          	jrne	L776
2076  07f3 cd0000        	call	_sEE_TIMEOUT_UserCallback
2079  07f6 2030          	jra	L001
2080  07f8               L776:
2081                     ; 713   while(I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
2083  07f8 ae0302        	ldw	x,#770
2084  07fb cd0000        	call	_I2C_GetFlagStatus
2086  07fe 4d            	tnz	a
2087  07ff 26df          	jrne	L376
2088  0801               L507:
2089                     ; 724     I2C_GenerateSTART(ENABLE);
2091  0801 a601          	ld	a,#1
2092  0803 cd0000        	call	_I2C_GenerateSTART
2094                     ; 727     sEETimeout = sEE_FLAG_TIMEOUT;
2096  0806 ae1000        	ldw	x,#4096
2097  0809 bf04          	ldw	_sEETimeout+2,x
2098  080b ae0000        	ldw	x,#0
2099  080e bf02          	ldw	_sEETimeout,x
2101  0810 2019          	jra	L517
2102  0812               L117:
2103                     ; 730       if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
2105  0812 ae0002        	ldw	x,#_sEETimeout
2106  0815 cd0000        	call	c_ltor
2108  0818 ae0002        	ldw	x,#_sEETimeout
2109  081b a601          	ld	a,#1
2110  081d cd0000        	call	c_lgsbc
2112  0820 cd0000        	call	c_lrzmp
2114  0823 2606          	jrne	L517
2117  0825 cd0000        	call	_sEE_TIMEOUT_UserCallback
2120  0828               L001:
2122  0828 5b07          	addw	sp,#7
2123  082a 81            	ret
2124  082b               L517:
2125                     ; 728     while(!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT))
2127  082b ae0301        	ldw	x,#769
2128  082e cd0000        	call	_I2C_CheckEvent
2130  0831 4d            	tnz	a
2131  0832 27de          	jreq	L117
2132                     ; 734     I2C_Send7bitAddress((uint8_t)sEEAddress, I2C_DIRECTION_TX);
2134  0834 b601          	ld	a,_sEEAddress+1
2135  0836 5f            	clrw	x
2136  0837 95            	ld	xh,a
2137  0838 cd0000        	call	_I2C_Send7bitAddress
2139                     ; 737     sEETimeout = sEE_LONG_TIMEOUT;
2141  083b aea000        	ldw	x,#40960
2142  083e bf04          	ldw	_sEETimeout+2,x
2143  0840 ae0000        	ldw	x,#0
2144  0843 bf02          	ldw	_sEETimeout,x
2145  0845               L327:
2146                     ; 741       tmpSR1 = sEE_I2C->SR1;
2148  0845 c65217        	ld	a,21015
2149  0848 6b07          	ld	(OFST+0,sp),a
2151                     ; 744       if((sEETimeout--) == 0) return sEE_TIMEOUT_UserCallback();
2153  084a ae0002        	ldw	x,#_sEETimeout
2154  084d cd0000        	call	c_ltor
2156  0850 ae0002        	ldw	x,#_sEETimeout
2157  0853 a601          	ld	a,#1
2158  0855 cd0000        	call	c_lgsbc
2160  0858 cd0000        	call	c_lrzmp
2162  085b 2605          	jrne	L527
2165  085d cd0000        	call	_sEE_TIMEOUT_UserCallback
2168  0860 20c6          	jra	L001
2169  0862               L527:
2170                     ; 748     while((I2C_GetFlagStatus(I2C_FLAG_ADDRESSSENTMATCHED)== RESET) & 
2170                     ; 749           (I2C_GetFlagStatus(I2C_FLAG_ACKNOWLEDGEFAILURE)== RESET));
2172  0862 ae0204        	ldw	x,#516
2173  0865 cd0000        	call	_I2C_GetFlagStatus
2175  0868 4d            	tnz	a
2176  0869 2605          	jrne	L66
2177  086b ae0001        	ldw	x,#1
2178  086e 2001          	jra	L07
2179  0870               L66:
2180  0870 5f            	clrw	x
2181  0871               L07:
2182  0871 1f01          	ldw	(OFST-6,sp),x
2184  0873 ae0102        	ldw	x,#258
2185  0876 cd0000        	call	_I2C_GetFlagStatus
2187  0879 4d            	tnz	a
2188  087a 2605          	jrne	L27
2189  087c ae0001        	ldw	x,#1
2190  087f 2001          	jra	L47
2191  0881               L27:
2192  0881 5f            	clrw	x
2193  0882               L47:
2194  0882 01            	rrwa	x,a
2195  0883 1402          	and	a,(OFST-5,sp)
2196  0885 01            	rrwa	x,a
2197  0886 1401          	and	a,(OFST-6,sp)
2198  0888 01            	rrwa	x,a
2199  0889 a30000        	cpw	x,#0
2200  088c 26b7          	jrne	L327
2201                     ; 750   tmpSR1 = sEE_I2C->SR1;   
2203  088e c65217        	ld	a,21015
2204  0891 6b07          	ld	(OFST+0,sp),a
2206                     ; 752     if (tmpSR1 & I2C_SR1_ADDR)
2208  0893 7b07          	ld	a,(OFST+0,sp)
2209  0895 a502          	bcp	a,#2
2210  0897 2715          	jreq	L337
2211                     ; 756       (void)sEE_I2C->SR3;
2213  0899 c65219        	ld	a,21017
2214                     ; 759       I2C_GenerateSTOP(ENABLE);
2216  089c a601          	ld	a,#1
2217  089e cd0000        	call	_I2C_GenerateSTOP
2219                     ; 762       return sEE_OK;
2221  08a1 ae0000        	ldw	x,#0
2222  08a4 bf02          	ldw	c_lreg+2,x
2223  08a6 ae0000        	ldw	x,#0
2224  08a9 bf00          	ldw	c_lreg,x
2226  08ab cc0828        	jra	L001
2227  08ae               L337:
2228                     ; 767       I2C_ClearFlag(I2C_FLAG_ACKNOWLEDGEFAILURE);                  
2230  08ae ae0204        	ldw	x,#516
2231  08b1 cd0000        	call	_I2C_ClearFlag
2233                     ; 771     if (sEETrials++ == sEE_MAX_TRIALS_NUMBER)
2235  08b4 96            	ldw	x,sp
2236  08b5 1c0003        	addw	x,#OFST-4
2237  08b8 cd0000        	call	c_ltor
2239  08bb 96            	ldw	x,sp
2240  08bc 1c0003        	addw	x,#OFST-4
2241  08bf a601          	ld	a,#1
2242  08c1 cd0000        	call	c_lgadc
2245  08c4 ae0000        	ldw	x,#L67
2246  08c7 cd0000        	call	c_lcmp
2248  08ca 2703          	jreq	L201
2249  08cc cc0801        	jp	L507
2250  08cf               L201:
2251                     ; 774       return sEE_TIMEOUT_UserCallback();
2253  08cf cd0000        	call	_sEE_TIMEOUT_UserCallback
2256  08d2 ac280828      	jpf	L001
2282                     ; 805 void sEE_EnterCriticalSection_UserCallback(void)
2282                     ; 806 {
2283                     	switch	.text
2284  08d6               _sEE_EnterCriticalSection_UserCallback:
2288                     ; 807   disableInterrupts();  
2291  08d6 9b            sim
2293                     ; 808 }
2297  08d7 81            	ret
2322                     ; 820 void sEE_ExitCriticalSection_UserCallback(void)
2322                     ; 821 {
2323                     	switch	.text
2324  08d8               _sEE_ExitCriticalSection_UserCallback:
2328                     ; 822   enableInterrupts();
2331  08d8 9a            rim
2333                     ; 823 }
2337  08d9 81            	ret
2390                     	switch	.ubsct
2391  0000               _sEEDataNum:
2392  0000 00            	ds.b	1
2393                     	xdef	_sEEDataNum
2394  0001               _sEEDataWritePointer:
2395  0001 0000          	ds.b	2
2396                     	xdef	_sEEDataWritePointer
2397                     	xdef	_sEETimeout
2398                     	xdef	_sEEAddress
2399                     	xdef	_sEE_ExitCriticalSection_UserCallback
2400                     	xdef	_sEE_EnterCriticalSection_UserCallback
2401                     	xdef	_sEE_TIMEOUT_UserCallback
2402                     	xdef	_sEE_WaitEepromStandbyState
2403                     	xdef	_sEE_WriteBuffer
2404                     	xdef	_sEE_WritePage
2405                     	xdef	_sEE_ReadBuffer
2406                     	xdef	_sEE_Init
2407                     	xdef	_sEE_DeInit
2408                     	xref	_I2C_ClearFlag
2409                     	xref	_I2C_GetFlagStatus
2410                     	xref	_I2C_CheckEvent
2411                     	xref	_I2C_SendData
2412                     	xref	_I2C_Send7bitAddress
2413                     	xref	_I2C_ReceiveData
2414                     	xref	_I2C_AcknowledgeConfig
2415                     	xref	_I2C_GenerateSTOP
2416                     	xref	_I2C_GenerateSTART
2417                     	xref	_I2C_Cmd
2418                     	xref	_I2C_Init
2419                     	xref	_CLK_PeripheralClockConfig
2420                     	xref.b	c_lreg
2421                     	xref.b	c_x
2441                     	xref	c_lcmp
2442                     	xref	c_lgadc
2443                     	xref	c_lrzmp
2444                     	xref	c_lgsbc
2445                     	xref	c_ltor
2446                     	end
