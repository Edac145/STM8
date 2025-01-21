   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  64                     ; 7 void DS3231_GetTime(uint8_t *buf, uint8_t size)
  64                     ; 8 {
  66                     	switch	.text
  67  0000               _DS3231_GetTime:
  69  0000 89            	pushw	x
  70       00000000      OFST:	set	0
  73                     ; 9     I2CRead(DS3231_ADDR, DS3231_SECONDS, buf, size);
  75  0001 7b05          	ld	a,(OFST+5,sp)
  76  0003 88            	push	a
  77  0004 89            	pushw	x
  78  0005 aed000        	ldw	x,#53248
  79  0008 cd0000        	call	_I2CRead
  81  000b 5b03          	addw	sp,#3
  82                     ; 10 }
  85  000d 85            	popw	x
  86  000e 81            	ret
 179                     ; 12 void DS3231_SetTime(uint8_t *buf, uint8_t size)
 179                     ; 13 {
 180                     	switch	.text
 181  000f               _DS3231_SetTime:
 183  000f 89            	pushw	x
 184  0010 520e          	subw	sp,#14
 185       0000000e      OFST:	set	14
 188                     ; 16     const char *months = "JanFebMarAprMayJunJulAugSepOctNovDec";
 190  0012 ae000c        	ldw	x,#L101
 191  0015 1f0d          	ldw	(OFST-1,sp),x
 193                     ; 17 	  const char *month_str = __DATE__;
 195  0017 ae0000        	ldw	x,#L301
 196  001a 1f09          	ldw	(OFST-5,sp),x
 198                     ; 21     buf[0] = (__TIME__[6] - '0')*16 + (__TIME__[7] - '0');
 200  001c 1e0f          	ldw	x,(OFST+1,sp)
 201  001e a611          	ld	a,#17
 202  0020 f7            	ld	(x),a
 203                     ; 22     buf[1] = (__TIME__[3] - '0')*16 + (__TIME__[4] - '0');
 205  0021 1e0f          	ldw	x,(OFST+1,sp)
 206  0023 a603          	ld	a,#3
 207  0025 e701          	ld	(1,x),a
 208                     ; 23     buf[2] = (__TIME__[0] - '0')*16 + (__TIME__[1] - '0');
 210  0027 1e0f          	ldw	x,(OFST+1,sp)
 211  0029 a620          	ld	a,#32
 212  002b e702          	ld	(2,x),a
 213                     ; 24     buf[5] = ((strstr(months, month_str) - months) / 3 + 1);    // Month
 215  002d 1e09          	ldw	x,(OFST-5,sp)
 216  002f 89            	pushw	x
 217  0030 1e0f          	ldw	x,(OFST+1,sp)
 218  0032 cd0000        	call	_strstr
 220  0035 5b02          	addw	sp,#2
 221  0037 72f00d        	subw	x,(OFST-1,sp)
 222  003a a603          	ld	a,#3
 223  003c cd0000        	call	c_sdivx
 225  003f 5c            	incw	x
 226  0040 160f          	ldw	y,(OFST+1,sp)
 227  0042 01            	rrwa	x,a
 228  0043 90e705        	ld	(5,y),a
 229  0046 02            	rlwa	x,a
 230                     ; 25     buf[4] = ((__DATE__[4] - '0') << 4) | (__DATE__[5] - '0'); // Day
 232  0047 1e0f          	ldw	x,(OFST+1,sp)
 233  0049 a618          	ld	a,#24
 234  004b e704          	ld	(4,x),a
 235                     ; 26     buf[6] = ((__DATE__[9] - '0') << 4) | (__DATE__[10] - '0'); // Year (last two digits)
 237  004d 1e0f          	ldw	x,(OFST+1,sp)
 238  004f a625          	ld	a,#37
 239  0051 e706          	ld	(6,x),a
 240                     ; 29     year = (__DATE__[9] - '0') * 10 + (__DATE__[10] - '0') + 2000;
 242  0053 ae07e9        	ldw	x,#2025
 243  0056 1f0b          	ldw	(OFST-3,sp),x
 245                     ; 30     month = (strstr(months, month_str) - months) / 3 + 1;
 247  0058 1e09          	ldw	x,(OFST-5,sp)
 248  005a 89            	pushw	x
 249  005b 1e0f          	ldw	x,(OFST+1,sp)
 250  005d cd0000        	call	_strstr
 252  0060 5b02          	addw	sp,#2
 253  0062 72f00d        	subw	x,(OFST-1,sp)
 254  0065 a603          	ld	a,#3
 255  0067 cd0000        	call	c_sdivx
 257  006a 5c            	incw	x
 258  006b 1f0d          	ldw	(OFST-1,sp),x
 260                     ; 31     day = (__DATE__[4] - '0') * 10 + (__DATE__[5] - '0');
 262                     ; 32     if (month < 3) {
 264  006d 9c            	rvf
 265  006e 1e0d          	ldw	x,(OFST-1,sp)
 266  0070 a30003        	cpw	x,#3
 267  0073 2e0e          	jrsge	L501
 268                     ; 33         month += 12;
 270  0075 1e0d          	ldw	x,(OFST-1,sp)
 271  0077 1c000c        	addw	x,#12
 272  007a 1f0d          	ldw	(OFST-1,sp),x
 274                     ; 34         year -= 1;
 276  007c 1e0b          	ldw	x,(OFST-3,sp)
 277  007e 1d0001        	subw	x,#1
 278  0081 1f0b          	ldw	(OFST-3,sp),x
 280  0083               L501:
 281                     ; 36     buf[3] = ((day + (13 * (month + 1)) / 5 + year + (year / 4) - (year / 100) + (year / 400)) % 7) + 1;
 283  0083 1e0b          	ldw	x,(OFST-3,sp)
 284  0085 90ae0190      	ldw	y,#400
 285  0089 cd0000        	call	c_idiv
 287  008c 1f05          	ldw	(OFST-9,sp),x
 289  008e 1e0b          	ldw	x,(OFST-3,sp)
 290  0090 a664          	ld	a,#100
 291  0092 cd0000        	call	c_sdivx
 293  0095 1f03          	ldw	(OFST-11,sp),x
 295  0097 1e0b          	ldw	x,(OFST-3,sp)
 296  0099 a604          	ld	a,#4
 297  009b cd0000        	call	c_sdivx
 299  009e 1f01          	ldw	(OFST-13,sp),x
 301  00a0 1e0d          	ldw	x,(OFST-1,sp)
 302  00a2 a60d          	ld	a,#13
 303  00a4 cd0000        	call	c_bmulx
 305  00a7 1c000d        	addw	x,#13
 306  00aa a605          	ld	a,#5
 307  00ac cd0000        	call	c_sdivx
 309  00af 72fb0b        	addw	x,(OFST-3,sp)
 310  00b2 72fb01        	addw	x,(OFST-13,sp)
 311  00b5 1c0012        	addw	x,#18
 312  00b8 72f003        	subw	x,(OFST-11,sp)
 313  00bb 72fb05        	addw	x,(OFST-9,sp)
 314  00be a607          	ld	a,#7
 315  00c0 cd0000        	call	c_smodx
 317  00c3 5c            	incw	x
 318  00c4 160f          	ldw	y,(OFST+1,sp)
 319  00c6 01            	rrwa	x,a
 320  00c7 90e703        	ld	(3,y),a
 321  00ca 02            	rlwa	x,a
 322                     ; 39     I2CWrite(DS3231_ADDR, DS3231_SECONDS, buf, size);
 324  00cb 7b13          	ld	a,(OFST+5,sp)
 325  00cd 88            	push	a
 326  00ce 1e10          	ldw	x,(OFST+2,sp)
 327  00d0 89            	pushw	x
 328  00d1 aed000        	ldw	x,#53248
 329  00d4 cd0000        	call	_I2CWrite
 331  00d7 5b03          	addw	sp,#3
 332                     ; 44 }
 335  00d9 5b10          	addw	sp,#16
 336  00db 81            	ret
 391                     ; 46 void DS3231_GetTemp(uint8_t *val, uint8_t *frac)
 391                     ; 47 {
 392                     	switch	.text
 393  00dc               _DS3231_GetTemp:
 395  00dc 89            	pushw	x
 396  00dd 88            	push	a
 397       00000001      OFST:	set	1
 400                     ; 50     I2CRead(DS3231_ADDR, DS3231_TEMP_MSB, val, 1);
 402  00de 4b01          	push	#1
 403  00e0 89            	pushw	x
 404  00e1 aed011        	ldw	x,#53265
 405  00e4 cd0000        	call	_I2CRead
 407  00e7 5b03          	addw	sp,#3
 408                     ; 51     I2CRead(DS3231_ADDR, DS3231_TEMP_LSB, &tmp, 1);
 410  00e9 4b01          	push	#1
 411  00eb 96            	ldw	x,sp
 412  00ec 1c0002        	addw	x,#OFST+1
 413  00ef 89            	pushw	x
 414  00f0 aed012        	ldw	x,#53266
 415  00f3 cd0000        	call	_I2CRead
 417  00f6 5b03          	addw	sp,#3
 418                     ; 53     switch (tmp)
 420  00f8 7b01          	ld	a,(OFST+0,sp)
 422                     ; 64         default:
 422                     ; 65             *frac = 0;
 423  00fa a040          	sub	a,#64
 424  00fc 270d          	jreq	L701
 425  00fe a040          	sub	a,#64
 426  0100 2710          	jreq	L111
 427  0102 a040          	sub	a,#64
 428  0104 2713          	jreq	L311
 429  0106               L511:
 432  0106 1e06          	ldw	x,(OFST+5,sp)
 433  0108 7f            	clr	(x)
 434  0109 2013          	jra	L741
 435  010b               L701:
 436                     ; 55         case 0x40:
 436                     ; 56             *frac = 3;
 438  010b 1e06          	ldw	x,(OFST+5,sp)
 439  010d a603          	ld	a,#3
 440  010f f7            	ld	(x),a
 441                     ; 57             break;
 443  0110 200c          	jra	L741
 444  0112               L111:
 445                     ; 58         case 0x80:
 445                     ; 59             *frac = 5;
 447  0112 1e06          	ldw	x,(OFST+5,sp)
 448  0114 a605          	ld	a,#5
 449  0116 f7            	ld	(x),a
 450                     ; 60             break;
 452  0117 2005          	jra	L741
 453  0119               L311:
 454                     ; 61         case 0xC0:
 454                     ; 62             *frac = 8;
 456  0119 1e06          	ldw	x,(OFST+5,sp)
 457  011b a608          	ld	a,#8
 458  011d f7            	ld	(x),a
 459                     ; 63             break;
 461  011e               L741:
 462                     ; 67 }
 465  011e 5b03          	addw	sp,#3
 466  0120 81            	ret
 479                     	xref	_strstr
 480                     	xref	_I2CWrite
 481                     	xref	_I2CRead
 482                     	xdef	_DS3231_GetTemp
 483                     	xdef	_DS3231_SetTime
 484                     	xdef	_DS3231_GetTime
 485                     .const:	section	.text
 486  0000               L301:
 487  0000 4a616e203138  	dc.b	"Jan 18 2025",0
 488  000c               L101:
 489  000c 4a616e466562  	dc.b	"JanFebMarAprMayJun"
 490  001e 4a756c417567  	dc.b	"JulAugSepOctNovDec",0
 491                     	xref.b	c_x
 511                     	xref	c_smodx
 512                     	xref	c_idiv
 513                     	xref	c_sdivy
 514                     	xref	c_bmulx
 515                     	xref	c_sdivx
 516                     	end
