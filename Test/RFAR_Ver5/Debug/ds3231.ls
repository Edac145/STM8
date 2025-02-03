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
 191  0027 a647          	ld	a,#71
 192  0029 f7            	ld	(x),a
 193                     ; 27     buf[1] = (__TIME__[3] - '0')*16 + (__TIME__[4] - '0');
 195  002a a638          	ld	a,#56
 196  002c e701          	ld	(1,x),a
 197                     ; 28     buf[2] = (__TIME__[0] - '0')*16 + (__TIME__[1] - '0');
 199  002e a611          	ld	a,#17
 200  0030 e702          	ld	(2,x),a
 201                     ; 29 		buf[5] = ('0' - '0') * 16 + ('1' - '0');
 203  0032 a601          	ld	a,#1
 204  0034 e705          	ld	(5,x),a
 205                     ; 30     buf[4] = ((__DATE__[4] - '0') * 16) + (__DATE__[5] - '0'); // Day
 207  0036 a625          	ld	a,#37
 208  0038 e704          	ld	(4,x),a
 209                     ; 31     buf[6] = ((__DATE__[9] - '0') * 16) + (__DATE__[10] - '0'); // Year (last two digits)
 211  003a e706          	ld	(6,x),a
 212                     ; 36     I2CWrite(DS3231_WRITE_ADDR, DS3231_SECONDS, buf, size);
 214  003c 7b0c          	ld	a,(OFST+6,sp)
 215  003e 88            	push	a
 216  003f 89            	pushw	x
 217  0040 aed000        	ldw	x,#53248
 218  0043 8d000000      	callf	f_I2CWrite
 220  0047 5b0b          	addw	sp,#11
 221                     ; 41 }
 224  0049 87            	retf	
 278                     ; 43 void DS3231_GetTemp(uint8_t *val, uint8_t *frac)
 278                     ; 44 {
 279                     	switch	.text
 280  004a               f_DS3231_GetTemp:
 282  004a 89            	pushw	x
 283  004b 88            	push	a
 284       00000001      OFST:	set	1
 287                     ; 47     I2CRead(DS3231_ADDR, DS3231_TEMP_MSB, val, 1);
 289  004c 4b01          	push	#1
 290  004e 89            	pushw	x
 291  004f aed011        	ldw	x,#53265
 292  0052 8d000000      	callf	f_I2CRead
 294  0056 5b03          	addw	sp,#3
 295                     ; 48     I2CRead(DS3231_ADDR, DS3231_TEMP_LSB, &tmp, 1);
 297  0058 4b01          	push	#1
 298  005a 96            	ldw	x,sp
 299  005b 1c0002        	addw	x,#OFST+1
 300  005e 89            	pushw	x
 301  005f aed012        	ldw	x,#53266
 302  0062 8d000000      	callf	f_I2CRead
 304  0066 5b03          	addw	sp,#3
 305                     ; 50     switch (tmp)
 307  0068 7b01          	ld	a,(OFST+0,sp)
 309                     ; 61         default:
 309                     ; 62             *frac = 0;
 310  006a a040          	sub	a,#64
 311  006c 270d          	jreq	L57
 312  006e a040          	sub	a,#64
 313  0070 270f          	jreq	L77
 314  0072 a040          	sub	a,#64
 315  0074 2711          	jreq	L101
 318  0076 1e07          	ldw	x,(OFST+6,sp)
 319  0078 7f            	clr	(x)
 320  0079 2011          	jra	L531
 321  007b               L57:
 322                     ; 52         case 0x40:
 322                     ; 53             *frac = 3;
 324  007b 1e07          	ldw	x,(OFST+6,sp)
 325  007d a603          	ld	a,#3
 326                     ; 54             break;
 328  007f 200a          	jpf	LC001
 329  0081               L77:
 330                     ; 55         case 0x80:
 330                     ; 56             *frac = 5;
 332  0081 1e07          	ldw	x,(OFST+6,sp)
 333  0083 a605          	ld	a,#5
 334                     ; 57             break;
 336  0085 2004          	jpf	LC001
 337  0087               L101:
 338                     ; 58         case 0xC0:
 338                     ; 59             *frac = 8;
 340  0087 1e07          	ldw	x,(OFST+6,sp)
 341  0089 a608          	ld	a,#8
 342  008b               LC001:
 343  008b f7            	ld	(x),a
 344                     ; 60             break;
 346  008c               L531:
 347                     ; 64 }
 350  008c 5b03          	addw	sp,#3
 351  008e 87            	retf	
 384                     ; 66 uint8_t _bcd2dec(uint8_t bcd)
 384                     ; 67 {
 385                     	switch	.text
 386  008f               f__bcd2dec:
 388  008f 88            	push	a
 389  0090 88            	push	a
 390       00000001      OFST:	set	1
 393                     ; 68     return ((bcd >> 4) * 10) + (bcd & 0x0F);
 395  0091 a40f          	and	a,#15
 396  0093 6b01          	ld	(OFST+0,sp),a
 398  0095 7b02          	ld	a,(OFST+1,sp)
 399  0097 4e            	swap	a
 400  0098 a40f          	and	a,#15
 401  009a 97            	ld	xl,a
 402  009b a60a          	ld	a,#10
 403  009d 42            	mul	x,a
 404  009e 9f            	ld	a,xl
 405  009f 1b01          	add	a,(OFST+0,sp)
 408  00a1 85            	popw	x
 409  00a2 87            	retf	
 442                     ; 71 uint8_t _dec2bcd(uint8_t dec)
 442                     ; 72 {
 443                     	switch	.text
 444  00a3               f__dec2bcd:
 446  00a3 88            	push	a
 447  00a4 88            	push	a
 448       00000001      OFST:	set	1
 451                     ; 73     return ((dec / 10) << 4) | (dec % 10);
 453  00a5 5f            	clrw	x
 454  00a6 97            	ld	xl,a
 455  00a7 a60a          	ld	a,#10
 456  00a9 62            	div	x,a
 457  00aa 6b01          	ld	(OFST+0,sp),a
 459  00ac 5f            	clrw	x
 460  00ad 7b02          	ld	a,(OFST+1,sp)
 461  00af 97            	ld	xl,a
 462  00b0 a60a          	ld	a,#10
 463  00b2 62            	div	x,a
 464  00b3 a610          	ld	a,#16
 465  00b5 42            	mul	x,a
 466  00b6 9f            	ld	a,xl
 467  00b7 1a01          	or	a,(OFST+0,sp)
 470  00b9 85            	popw	x
 471  00ba 87            	retf	
 483                     	xref	f_strstr
 484                     	xref	f_I2CWrite
 485                     	xref	f_I2CRead
 486                     	xdef	f__dec2bcd
 487                     	xdef	f__bcd2dec
 488                     	xdef	f_DS3231_GetTemp
 489                     	xdef	f_DS3231_SetTime
 490                     	xdef	f_DS3231_GetTime
 491                     .const:	section	.text
 492  0000               L37:
 493  0000 4a616e203235  	dc.b	"Jan 25 2025",0
 494  000c               L17:
 495  000c 4a616e466562  	dc.b	"JanFebMarAprMayJun"
 496  001e 4a756c417567  	dc.b	"JulAugSepOctNovDec",0
 497                     	xref.b	c_x
 517                     	xref	d_sdivx
 518                     	end
