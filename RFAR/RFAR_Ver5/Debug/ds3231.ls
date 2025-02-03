   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  67                     ; 9 void DS3231_GetTime(uint8_t *buf, uint8_t size)
  67                     ; 10 {
  68                     	switch	.text
  69  0000               f_DS3231_GetTime:
  71  0000 89            	pushw	x
  72       00000000      OFST:	set	0
  75                     ; 11     I2CRead(DS3231_READ_ADDR, DS3231_SECONDS, buf, size);
  77  0001 7b06          	ld	a,(OFST+6,sp)
  78  0003 88            	push	a
  79  0004 89            	pushw	x
  80  0005 aed100        	ldw	x,#53504
  81  0008 8d000000      	callf	f_I2CRead
  83                     ; 12 }
  86  000c 5b05          	addw	sp,#5
  87  000e 87            	retf	
 161                     ; 14 void DS3231_SetTime(uint8_t *buf, uint8_t size)
 161                     ; 15 {
 162                     	switch	.text
 163  000f               f_DS3231_SetTime:
 165  000f 89            	pushw	x
 166  0010 5206          	subw	sp,#6
 167       00000006      OFST:	set	6
 170                     ; 18 		const char *months = "JanFebMarAprMayJunJulAugSepOctNovDec";
 172  0012 ae000c        	ldw	x,#L17
 173  0015 1f05          	ldw	(OFST-1,sp),x
 175                     ; 19 	  const char *month_str = __DATE__;
 177  0017 ae0000        	ldw	x,#L37
 178  001a 1f03          	ldw	(OFST-3,sp),x
 180                     ; 25     month = ((strstr(months, month_str) - months) / 3 + 1); // Month index (1 for Jan, 2 for Feb, etc.)
 182  001c 89            	pushw	x
 183  001d 1e07          	ldw	x,(OFST+1,sp)
 184  001f 8d000000      	callf	f_strstr
 186  0023 5b02          	addw	sp,#2
 188                     ; 26     buf[0] = (__TIME__[6] - '0')*16 + (__TIME__[7] - '0');
 190  0025 1e07          	ldw	x,(OFST+1,sp)
 191  0027 a627          	ld	a,#39
 192  0029 f7            	ld	(x),a
 193                     ; 27     buf[1] = (__TIME__[3] - '0')*16 + (__TIME__[4] - '0');
 195  002a a616          	ld	a,#22
 196  002c e701          	ld	(1,x),a
 197                     ; 28     buf[2] = (__TIME__[0] - '0')*16 + (__TIME__[1] - '0');
 199  002e a619          	ld	a,#25
 200  0030 e702          	ld	(2,x),a
 201                     ; 29 		buf[5] = ('0' - '0') * 16 + ('1' - '0');
 203  0032 a601          	ld	a,#1
 204  0034 e705          	ld	(5,x),a
 205                     ; 30     buf[4] = ((__DATE__[4] - '0') * 16) + (__DATE__[5] - '0'); // Day
 207  0036 a627          	ld	a,#39
 208  0038 e704          	ld	(4,x),a
 209                     ; 31     buf[6] = ((__DATE__[9] - '0') * 16) + (__DATE__[10] - '0'); // Year (last two digits)
 211  003a a625          	ld	a,#37
 212  003c e706          	ld	(6,x),a
 213                     ; 36     I2CWrite(DS3231_WRITE_ADDR, DS3231_SECONDS, buf, size);
 215  003e 7b0c          	ld	a,(OFST+6,sp)
 216  0040 88            	push	a
 217  0041 89            	pushw	x
 218  0042 aed000        	ldw	x,#53248
 219  0045 8d000000      	callf	f_I2CWrite
 221  0049 5b0b          	addw	sp,#11
 222                     ; 41 }
 225  004b 87            	retf	
 279                     ; 43 void DS3231_GetTemp(uint8_t *val, uint8_t *frac)
 279                     ; 44 {
 280                     	switch	.text
 281  004c               f_DS3231_GetTemp:
 283  004c 89            	pushw	x
 284  004d 88            	push	a
 285       00000001      OFST:	set	1
 288                     ; 47     I2CRead(DS3231_ADDR, DS3231_TEMP_MSB, val, 1);
 290  004e 4b01          	push	#1
 291  0050 89            	pushw	x
 292  0051 aed011        	ldw	x,#53265
 293  0054 8d000000      	callf	f_I2CRead
 295  0058 5b03          	addw	sp,#3
 296                     ; 48     I2CRead(DS3231_ADDR, DS3231_TEMP_LSB, &tmp, 1);
 298  005a 4b01          	push	#1
 299  005c 96            	ldw	x,sp
 300  005d 1c0002        	addw	x,#OFST+1
 301  0060 89            	pushw	x
 302  0061 aed012        	ldw	x,#53266
 303  0064 8d000000      	callf	f_I2CRead
 305  0068 5b03          	addw	sp,#3
 306                     ; 50     switch (tmp)
 308  006a 7b01          	ld	a,(OFST+0,sp)
 310                     ; 61         default:
 310                     ; 62             *frac = 0;
 311  006c a040          	sub	a,#64
 312  006e 270d          	jreq	L57
 313  0070 a040          	sub	a,#64
 314  0072 270f          	jreq	L77
 315  0074 a040          	sub	a,#64
 316  0076 2711          	jreq	L101
 319  0078 1e07          	ldw	x,(OFST+6,sp)
 320  007a 7f            	clr	(x)
 321  007b 2011          	jra	L531
 322  007d               L57:
 323                     ; 52         case 0x40:
 323                     ; 53             *frac = 3;
 325  007d 1e07          	ldw	x,(OFST+6,sp)
 326  007f a603          	ld	a,#3
 327                     ; 54             break;
 329  0081 200a          	jpf	LC001
 330  0083               L77:
 331                     ; 55         case 0x80:
 331                     ; 56             *frac = 5;
 333  0083 1e07          	ldw	x,(OFST+6,sp)
 334  0085 a605          	ld	a,#5
 335                     ; 57             break;
 337  0087 2004          	jpf	LC001
 338  0089               L101:
 339                     ; 58         case 0xC0:
 339                     ; 59             *frac = 8;
 341  0089 1e07          	ldw	x,(OFST+6,sp)
 342  008b a608          	ld	a,#8
 343  008d               LC001:
 344  008d f7            	ld	(x),a
 345                     ; 60             break;
 347  008e               L531:
 348                     ; 64 }
 351  008e 5b03          	addw	sp,#3
 352  0090 87            	retf	
 385                     ; 66 uint8_t _bcd2dec(uint8_t bcd)
 385                     ; 67 {
 386                     	switch	.text
 387  0091               f__bcd2dec:
 389  0091 88            	push	a
 390  0092 88            	push	a
 391       00000001      OFST:	set	1
 394                     ; 68     return ((bcd >> 4) * 10) + (bcd & 0x0F);
 396  0093 a40f          	and	a,#15
 397  0095 6b01          	ld	(OFST+0,sp),a
 399  0097 7b02          	ld	a,(OFST+1,sp)
 400  0099 4e            	swap	a
 401  009a a40f          	and	a,#15
 402  009c 97            	ld	xl,a
 403  009d a60a          	ld	a,#10
 404  009f 42            	mul	x,a
 405  00a0 9f            	ld	a,xl
 406  00a1 1b01          	add	a,(OFST+0,sp)
 409  00a3 85            	popw	x
 410  00a4 87            	retf	
 443                     ; 71 uint8_t _dec2bcd(uint8_t dec)
 443                     ; 72 {
 444                     	switch	.text
 445  00a5               f__dec2bcd:
 447  00a5 88            	push	a
 448  00a6 88            	push	a
 449       00000001      OFST:	set	1
 452                     ; 73     return ((dec / 10) << 4) | (dec % 10);
 454  00a7 5f            	clrw	x
 455  00a8 97            	ld	xl,a
 456  00a9 a60a          	ld	a,#10
 457  00ab 62            	div	x,a
 458  00ac 6b01          	ld	(OFST+0,sp),a
 460  00ae 5f            	clrw	x
 461  00af 7b02          	ld	a,(OFST+1,sp)
 462  00b1 97            	ld	xl,a
 463  00b2 a60a          	ld	a,#10
 464  00b4 62            	div	x,a
 465  00b5 a610          	ld	a,#16
 466  00b7 42            	mul	x,a
 467  00b8 9f            	ld	a,xl
 468  00b9 1a01          	or	a,(OFST+0,sp)
 471  00bb 85            	popw	x
 472  00bc 87            	retf	
 484                     	xref	f_strstr
 485                     	xref	f_I2CWrite
 486                     	xref	f_I2CRead
 487                     	xdef	f__dec2bcd
 488                     	xdef	f__bcd2dec
 489                     	xdef	f_DS3231_GetTemp
 490                     	xdef	f_DS3231_SetTime
 491                     	xdef	f_DS3231_GetTime
 492                     .const:	section	.text
 493  0000               L37:
 494  0000 4a616e203237  	dc.b	"Jan 27 2025",0
 495  000c               L17:
 496  000c 4a616e466562  	dc.b	"JanFebMarAprMayJun"
 497  001e 4a756c417567  	dc.b	"JulAugSepOctNovDec",0
 498                     	xref.b	c_x
 518                     	xref	d_sdivx
 519                     	end
