   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  64                     ; 9 void DS3231_GetTime(uint8_t *buf, uint8_t size)
  64                     ; 10 {
  65                     	switch	.text
  66  0000               f_DS3231_GetTime:
  68  0000 89            	pushw	x
  69       00000000      OFST:	set	0
  72                     ; 11     I2CRead(DS3231_READ_ADDR, DS3231_SECONDS, buf, size);
  74  0001 7b06          	ld	a,(OFST+6,sp)
  75  0003 88            	push	a
  76  0004 89            	pushw	x
  77  0005 aed100        	ldw	x,#53504
  78  0008 8d000000      	callf	f_I2CRead
  80  000c 5b03          	addw	sp,#3
  81                     ; 12 }
  84  000e 85            	popw	x
  85  000f 87            	retf
 159                     ; 14 void DS3231_SetTime(uint8_t *buf, uint8_t size)
 159                     ; 15 {
 160                     	switch	.text
 161  0010               f_DS3231_SetTime:
 163  0010 89            	pushw	x
 164  0011 5206          	subw	sp,#6
 165       00000006      OFST:	set	6
 168                     ; 18 		const char *months = "JanFebMarAprMayJunJulAugSepOctNovDec";
 170  0013 ae000c        	ldw	x,#L17
 171  0016 1f05          	ldw	(OFST-1,sp),x
 173                     ; 19 	  const char *month_str = __DATE__;
 175  0018 ae0000        	ldw	x,#L37
 176  001b 1f03          	ldw	(OFST-3,sp),x
 178                     ; 25     month = ((strstr(months, month_str) - months) / 3 + 1); // Month index (1 for Jan, 2 for Feb, etc.)
 180  001d 1e03          	ldw	x,(OFST-3,sp)
 181  001f 89            	pushw	x
 182  0020 1e07          	ldw	x,(OFST+1,sp)
 183  0022 8d000000      	callf	f_strstr
 185  0026 5b02          	addw	sp,#2
 186  0028 72f005        	subw	x,(OFST-1,sp)
 187  002b a603          	ld	a,#3
 188  002d 8d000000      	callf	d_sdivx
 190  0031 5c            	incw	x
 191                     ; 26     buf[0] = (__TIME__[6] - '0')*16 + (__TIME__[7] - '0');
 193  0032 1e07          	ldw	x,(OFST+1,sp)
 194  0034 a628          	ld	a,#40
 195  0036 f7            	ld	(x),a
 196                     ; 27     buf[1] = (__TIME__[3] - '0')*16 + (__TIME__[4] - '0');
 198  0037 1e07          	ldw	x,(OFST+1,sp)
 199  0039 a628          	ld	a,#40
 200  003b e701          	ld	(1,x),a
 201                     ; 28     buf[2] = (__TIME__[0] - '0')*16 + (__TIME__[1] - '0');
 203  003d 1e07          	ldw	x,(OFST+1,sp)
 204  003f a609          	ld	a,#9
 205  0041 e702          	ld	(2,x),a
 206                     ; 29 		buf[5] = ('0' - '0') * 16 + ('1' - '0');
 208  0043 1e07          	ldw	x,(OFST+1,sp)
 209  0045 a601          	ld	a,#1
 210  0047 e705          	ld	(5,x),a
 211                     ; 30     buf[4] = ((__DATE__[4] - '0') * 16) + (__DATE__[5] - '0'); // Day
 213  0049 1e07          	ldw	x,(OFST+1,sp)
 214  004b a623          	ld	a,#35
 215  004d e704          	ld	(4,x),a
 216                     ; 31     buf[6] = ((__DATE__[9] - '0') * 16) + (__DATE__[10] - '0'); // Year (last two digits)
 218  004f 1e07          	ldw	x,(OFST+1,sp)
 219  0051 a625          	ld	a,#37
 220  0053 e706          	ld	(6,x),a
 221                     ; 36     I2CWrite(DS3231_WRITE_ADDR, DS3231_SECONDS, buf, size);
 223  0055 7b0c          	ld	a,(OFST+6,sp)
 224  0057 88            	push	a
 225  0058 1e08          	ldw	x,(OFST+2,sp)
 226  005a 89            	pushw	x
 227  005b aed000        	ldw	x,#53248
 228  005e 8d000000      	callf	f_I2CWrite
 230  0062 5b03          	addw	sp,#3
 231                     ; 41 }
 234  0064 5b08          	addw	sp,#8
 235  0066 87            	retf
 289                     ; 43 void DS3231_GetTemp(uint8_t *val, uint8_t *frac)
 289                     ; 44 {
 290                     	switch	.text
 291  0067               f_DS3231_GetTemp:
 293  0067 89            	pushw	x
 294  0068 88            	push	a
 295       00000001      OFST:	set	1
 298                     ; 47     I2CRead(DS3231_ADDR, DS3231_TEMP_MSB, val, 1);
 300  0069 4b01          	push	#1
 301  006b 89            	pushw	x
 302  006c aed011        	ldw	x,#53265
 303  006f 8d000000      	callf	f_I2CRead
 305  0073 5b03          	addw	sp,#3
 306                     ; 48     I2CRead(DS3231_ADDR, DS3231_TEMP_LSB, &tmp, 1);
 308  0075 4b01          	push	#1
 309  0077 96            	ldw	x,sp
 310  0078 1c0002        	addw	x,#OFST+1
 311  007b 89            	pushw	x
 312  007c aed012        	ldw	x,#53266
 313  007f 8d000000      	callf	f_I2CRead
 315  0083 5b03          	addw	sp,#3
 316                     ; 50     switch (tmp)
 318  0085 7b01          	ld	a,(OFST+0,sp)
 320                     ; 61         default:
 320                     ; 62             *frac = 0;
 321  0087 a040          	sub	a,#64
 322  0089 270d          	jreq	L57
 323  008b a040          	sub	a,#64
 324  008d 2710          	jreq	L77
 325  008f a040          	sub	a,#64
 326  0091 2713          	jreq	L101
 327  0093               L301:
 330  0093 1e07          	ldw	x,(OFST+6,sp)
 331  0095 7f            	clr	(x)
 332  0096 2013          	jra	L531
 333  0098               L57:
 334                     ; 52         case 0x40:
 334                     ; 53             *frac = 3;
 336  0098 1e07          	ldw	x,(OFST+6,sp)
 337  009a a603          	ld	a,#3
 338  009c f7            	ld	(x),a
 339                     ; 54             break;
 341  009d 200c          	jra	L531
 342  009f               L77:
 343                     ; 55         case 0x80:
 343                     ; 56             *frac = 5;
 345  009f 1e07          	ldw	x,(OFST+6,sp)
 346  00a1 a605          	ld	a,#5
 347  00a3 f7            	ld	(x),a
 348                     ; 57             break;
 350  00a4 2005          	jra	L531
 351  00a6               L101:
 352                     ; 58         case 0xC0:
 352                     ; 59             *frac = 8;
 354  00a6 1e07          	ldw	x,(OFST+6,sp)
 355  00a8 a608          	ld	a,#8
 356  00aa f7            	ld	(x),a
 357                     ; 60             break;
 359  00ab               L531:
 360                     ; 64 }
 363  00ab 5b03          	addw	sp,#3
 364  00ad 87            	retf
 397                     ; 66 uint8_t _bcd2dec(uint8_t bcd)
 397                     ; 67 {
 398                     	switch	.text
 399  00ae               f__bcd2dec:
 401  00ae 88            	push	a
 402  00af 88            	push	a
 403       00000001      OFST:	set	1
 406                     ; 68     return ((bcd >> 4) * 10) + (bcd & 0x0F);
 408  00b0 a40f          	and	a,#15
 409  00b2 6b01          	ld	(OFST+0,sp),a
 411  00b4 7b02          	ld	a,(OFST+1,sp)
 412  00b6 4e            	swap	a
 413  00b7 a40f          	and	a,#15
 414  00b9 97            	ld	xl,a
 415  00ba a60a          	ld	a,#10
 416  00bc 42            	mul	x,a
 417  00bd 9f            	ld	a,xl
 418  00be 1b01          	add	a,(OFST+0,sp)
 421  00c0 85            	popw	x
 422  00c1 87            	retf
 455                     ; 71 uint8_t _dec2bcd(uint8_t dec)
 455                     ; 72 {
 456                     	switch	.text
 457  00c2               f__dec2bcd:
 459  00c2 88            	push	a
 460  00c3 88            	push	a
 461       00000001      OFST:	set	1
 464                     ; 73     return ((dec / 10) << 4) | (dec % 10);
 466  00c4 5f            	clrw	x
 467  00c5 97            	ld	xl,a
 468  00c6 a60a          	ld	a,#10
 469  00c8 62            	div	x,a
 470  00c9 5f            	clrw	x
 471  00ca 97            	ld	xl,a
 472  00cb 9f            	ld	a,xl
 473  00cc 6b01          	ld	(OFST+0,sp),a
 475  00ce 7b02          	ld	a,(OFST+1,sp)
 476  00d0 5f            	clrw	x
 477  00d1 97            	ld	xl,a
 478  00d2 a60a          	ld	a,#10
 479  00d4 62            	div	x,a
 480  00d5 9f            	ld	a,xl
 481  00d6 97            	ld	xl,a
 482  00d7 a610          	ld	a,#16
 483  00d9 42            	mul	x,a
 484  00da 9f            	ld	a,xl
 485  00db 1a01          	or	a,(OFST+0,sp)
 488  00dd 85            	popw	x
 489  00de 87            	retf
 501                     	xref	f_strstr
 502                     	xref	f_I2CWrite
 503                     	xref	f_I2CRead
 504                     	xdef	f__dec2bcd
 505                     	xdef	f__bcd2dec
 506                     	xdef	f_DS3231_GetTemp
 507                     	xdef	f_DS3231_SetTime
 508                     	xdef	f_DS3231_GetTime
 509                     .const:	section	.text
 510  0000               L37:
 511  0000 4a616e203233  	dc.b	"Jan 23 2025",0
 512  000c               L17:
 513  000c 4a616e466562  	dc.b	"JanFebMarAprMayJun"
 514  001e 4a756c417567  	dc.b	"JulAugSepOctNovDec",0
 515                     	xref.b	c_x
 535                     	xref	d_sdivx
 536                     	end
