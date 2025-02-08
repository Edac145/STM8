   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  62                     ; 9 void DS3231_GetTime(uint8_t *buf, uint8_t size)
  62                     ; 10 {
  63                     	switch	.text
  64  0000               f_DS3231_GetTime:
  66  0000 89            	pushw	x
  67       00000000      OFST:	set	0
  70                     ; 11     I2CRead(DS3231_READ_ADDR, DS3231_SECONDS, buf, size);
  72  0001 7b06          	ld	a,(OFST+6,sp)
  73  0003 88            	push	a
  74  0004 89            	pushw	x
  75  0005 aed100        	ldw	x,#53504
  76  0008 8d000000      	callf	f_I2CRead
  78  000c 5b03          	addw	sp,#3
  79                     ; 12 }
  82  000e 85            	popw	x
  83  000f 87            	retf
 153                     ; 14 void DS3231_SetTime(uint8_t *buf, uint8_t size)
 153                     ; 15 {
 154                     	switch	.text
 155  0010               f_DS3231_SetTime:
 157  0010 89            	pushw	x
 158  0011 5206          	subw	sp,#6
 159       00000006      OFST:	set	6
 162                     ; 18 		const char *months = "JanFebMarAprMayJunJulAugSepOctNovDec";
 164  0013 ae000c        	ldw	x,#L36
 165  0016 1f05          	ldw	(OFST-1,sp),x
 167                     ; 19 	  const char *month_str = __DATE__;
 169  0018 ae0000        	ldw	x,#L56
 170  001b 1f03          	ldw	(OFST-3,sp),x
 172                     ; 25     month = ((strstr(months, month_str) - months) / 3 + 1); // Month index (1 for Jan, 2 for Feb, etc.)
 174  001d 1e03          	ldw	x,(OFST-3,sp)
 175  001f 89            	pushw	x
 176  0020 1e07          	ldw	x,(OFST+1,sp)
 177  0022 8d000000      	callf	f_strstr
 179  0026 5b02          	addw	sp,#2
 180  0028 72f005        	subw	x,(OFST-1,sp)
 181  002b a603          	ld	a,#3
 182  002d 8d000000      	callf	d_sdivx
 184  0031 5c            	incw	x
 185                     ; 26     buf[0] = (__TIME__[6] - '0')*16 + (__TIME__[7] - '0');
 187  0032 1e07          	ldw	x,(OFST+1,sp)
 188  0034 a608          	ld	a,#8
 189  0036 f7            	ld	(x),a
 190                     ; 27     buf[1] = (__TIME__[3] - '0')*16 + (__TIME__[4] - '0');
 192  0037 1e07          	ldw	x,(OFST+1,sp)
 193  0039 a613          	ld	a,#19
 194  003b e701          	ld	(1,x),a
 195                     ; 28     buf[2] = (__TIME__[0] - '0')*16 + (__TIME__[1] - '0');
 197  003d 1e07          	ldw	x,(OFST+1,sp)
 198  003f a611          	ld	a,#17
 199  0041 e702          	ld	(2,x),a
 200                     ; 29 		buf[5] = ('0' - '0') * 16 + ('2' - '0');
 202  0043 1e07          	ldw	x,(OFST+1,sp)
 203  0045 a602          	ld	a,#2
 204  0047 e705          	ld	(5,x),a
 205                     ; 30     buf[4] = ((__DATE__[4] - '0') * 16) + (__DATE__[5] - '0'); // Day
 207  0049 1e07          	ldw	x,(OFST+1,sp)
 208  004b a607          	ld	a,#7
 209  004d e704          	ld	(4,x),a
 210                     ; 31     buf[6] = ((__DATE__[9] - '0') * 16) + (__DATE__[10] - '0'); // Year (last two digits)
 212  004f 1e07          	ldw	x,(OFST+1,sp)
 213  0051 a625          	ld	a,#37
 214  0053 e706          	ld	(6,x),a
 215                     ; 36     I2CWrite(DS3231_WRITE_ADDR, DS3231_SECONDS, buf, size);
 217  0055 7b0c          	ld	a,(OFST+6,sp)
 218  0057 88            	push	a
 219  0058 1e08          	ldw	x,(OFST+2,sp)
 220  005a 89            	pushw	x
 221  005b aed000        	ldw	x,#53248
 222  005e 8d000000      	callf	f_I2CWrite
 224  0062 5b03          	addw	sp,#3
 225                     ; 41 }
 228  0064 5b08          	addw	sp,#8
 229  0066 87            	retf
 281                     ; 43 void DS3231_GetTemp(uint8_t *val, uint8_t *frac)
 281                     ; 44 {
 282                     	switch	.text
 283  0067               f_DS3231_GetTemp:
 285  0067 89            	pushw	x
 286  0068 88            	push	a
 287       00000001      OFST:	set	1
 290                     ; 47     I2CRead(DS3231_ADDR, DS3231_TEMP_MSB, val, 1);
 292  0069 4b01          	push	#1
 293  006b 89            	pushw	x
 294  006c aed011        	ldw	x,#53265
 295  006f 8d000000      	callf	f_I2CRead
 297  0073 5b03          	addw	sp,#3
 298                     ; 48     I2CRead(DS3231_ADDR, DS3231_TEMP_LSB, &tmp, 1);
 300  0075 4b01          	push	#1
 301  0077 96            	ldw	x,sp
 302  0078 1c0002        	addw	x,#OFST+1
 303  007b 89            	pushw	x
 304  007c aed012        	ldw	x,#53266
 305  007f 8d000000      	callf	f_I2CRead
 307  0083 5b03          	addw	sp,#3
 308                     ; 50     switch (tmp)
 310  0085 7b01          	ld	a,(OFST+0,sp)
 312                     ; 61         default:
 312                     ; 62             *frac = 0;
 313  0087 a040          	sub	a,#64
 314  0089 270d          	jreq	L76
 315  008b a040          	sub	a,#64
 316  008d 2710          	jreq	L17
 317  008f a040          	sub	a,#64
 318  0091 2713          	jreq	L37
 319  0093               L57:
 322  0093 1e07          	ldw	x,(OFST+6,sp)
 323  0095 7f            	clr	(x)
 324  0096 2013          	jra	L521
 325  0098               L76:
 326                     ; 52         case 0x40:
 326                     ; 53             *frac = 3;
 328  0098 1e07          	ldw	x,(OFST+6,sp)
 329  009a a603          	ld	a,#3
 330  009c f7            	ld	(x),a
 331                     ; 54             break;
 333  009d 200c          	jra	L521
 334  009f               L17:
 335                     ; 55         case 0x80:
 335                     ; 56             *frac = 5;
 337  009f 1e07          	ldw	x,(OFST+6,sp)
 338  00a1 a605          	ld	a,#5
 339  00a3 f7            	ld	(x),a
 340                     ; 57             break;
 342  00a4 2005          	jra	L521
 343  00a6               L37:
 344                     ; 58         case 0xC0:
 344                     ; 59             *frac = 8;
 346  00a6 1e07          	ldw	x,(OFST+6,sp)
 347  00a8 a608          	ld	a,#8
 348  00aa f7            	ld	(x),a
 349                     ; 60             break;
 351  00ab               L521:
 352                     ; 64 }
 355  00ab 5b03          	addw	sp,#3
 356  00ad 87            	retf
 387                     ; 66 uint8_t _bcd2dec(uint8_t bcd)
 387                     ; 67 {
 388                     	switch	.text
 389  00ae               f__bcd2dec:
 391  00ae 88            	push	a
 392  00af 88            	push	a
 393       00000001      OFST:	set	1
 396                     ; 68     return ((bcd >> 4) * 10) + (bcd & 0x0F);
 398  00b0 a40f          	and	a,#15
 399  00b2 6b01          	ld	(OFST+0,sp),a
 401  00b4 7b02          	ld	a,(OFST+1,sp)
 402  00b6 4e            	swap	a
 403  00b7 a40f          	and	a,#15
 404  00b9 97            	ld	xl,a
 405  00ba a60a          	ld	a,#10
 406  00bc 42            	mul	x,a
 407  00bd 9f            	ld	a,xl
 408  00be 1b01          	add	a,(OFST+0,sp)
 411  00c0 85            	popw	x
 412  00c1 87            	retf
 443                     ; 71 uint8_t _dec2bcd(uint8_t dec)
 443                     ; 72 {
 444                     	switch	.text
 445  00c2               f__dec2bcd:
 447  00c2 88            	push	a
 448  00c3 88            	push	a
 449       00000001      OFST:	set	1
 452                     ; 73     return ((dec / 10) << 4) | (dec % 10);
 454  00c4 5f            	clrw	x
 455  00c5 97            	ld	xl,a
 456  00c6 a60a          	ld	a,#10
 457  00c8 62            	div	x,a
 458  00c9 5f            	clrw	x
 459  00ca 97            	ld	xl,a
 460  00cb 9f            	ld	a,xl
 461  00cc 6b01          	ld	(OFST+0,sp),a
 463  00ce 7b02          	ld	a,(OFST+1,sp)
 464  00d0 5f            	clrw	x
 465  00d1 97            	ld	xl,a
 466  00d2 a60a          	ld	a,#10
 467  00d4 62            	div	x,a
 468  00d5 9f            	ld	a,xl
 469  00d6 97            	ld	xl,a
 470  00d7 a610          	ld	a,#16
 471  00d9 42            	mul	x,a
 472  00da 9f            	ld	a,xl
 473  00db 1a01          	or	a,(OFST+0,sp)
 476  00dd 85            	popw	x
 477  00de 87            	retf
 489                     	xref	f_strstr
 490                     	xref	f_I2CWrite
 491                     	xref	f_I2CRead
 492                     	xdef	f__dec2bcd
 493                     	xdef	f__bcd2dec
 494                     	xdef	f_DS3231_GetTemp
 495                     	xdef	f_DS3231_SetTime
 496                     	xdef	f_DS3231_GetTime
 497                     .const:	section	.text
 498  0000               L56:
 499  0000 466562202037  	dc.b	"Feb  7 2025",0
 500  000c               L36:
 501  000c 4a616e466562  	dc.b	"JanFebMarAprMayJun"
 502  001e 4a756c417567  	dc.b	"JulAugSepOctNovDec",0
 503                     	xref.b	c_x
 523                     	xref	d_sdivx
 524                     	end
