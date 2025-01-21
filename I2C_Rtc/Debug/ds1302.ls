   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
 169                     ; 42 void Ds1302_Init(GPIO_TypeDef* port_ena, uint8_t pin_ena, 
 169                     ; 43                  GPIO_TypeDef* port_clk, uint8_t pin_clk, 
 169                     ; 44                  GPIO_TypeDef* port_dat, uint8_t pin_dat)
 169                     ; 45 {
 171                     	switch	.text
 172  0000               _Ds1302_Init:
 174  0000 89            	pushw	x
 175       00000000      OFST:	set	0
 178                     ; 46     _port_ena = port_ena;
 180  0001 bf08          	ldw	L52__port_ena,x
 181                     ; 47     _port_clk = port_clk;
 183  0003 1e06          	ldw	x,(OFST+6,sp)
 184  0005 bf06          	ldw	L72__port_clk,x
 185                     ; 48     _port_dat = port_dat;
 187  0007 1e09          	ldw	x,(OFST+9,sp)
 188  0009 bf04          	ldw	L13__port_dat,x
 189                     ; 49     _pin_ena = pin_ena;
 191  000b 7b05          	ld	a,(OFST+5,sp)
 192  000d b703          	ld	L33__pin_ena,a
 193                     ; 50     _pin_clk = pin_clk;
 195  000f 7b08          	ld	a,(OFST+8,sp)
 196  0011 b702          	ld	L53__pin_clk,a
 197                     ; 51     _pin_dat = pin_dat;
 199  0013 7b0b          	ld	a,(OFST+11,sp)
 200  0015 b701          	ld	L73__pin_dat,a
 201                     ; 53     _dat_direction = INPUT;
 203  0017 3f00          	clr	L14__dat_direction
 204                     ; 55     GPIO_Init(port_ena, pin_ena, GPIO_MODE_OUT_PP_LOW_FAST);
 206  0019 4be0          	push	#224
 207  001b 7b06          	ld	a,(OFST+6,sp)
 208  001d 88            	push	a
 209  001e 1e03          	ldw	x,(OFST+3,sp)
 210  0020 cd0000        	call	_GPIO_Init
 212  0023 85            	popw	x
 213                     ; 56     GPIO_Init(port_clk, pin_clk, GPIO_MODE_OUT_PP_LOW_FAST);
 215  0024 4be0          	push	#224
 216  0026 7b09          	ld	a,(OFST+9,sp)
 217  0028 88            	push	a
 218  0029 1e08          	ldw	x,(OFST+8,sp)
 219  002b cd0000        	call	_GPIO_Init
 221  002e 85            	popw	x
 222                     ; 57     _setDirection(port_dat, pin_dat, _dat_direction);
 224  002f 3b0000        	push	L14__dat_direction
 225  0032 7b0c          	ld	a,(OFST+12,sp)
 226  0034 88            	push	a
 227  0035 1e0b          	ldw	x,(OFST+11,sp)
 228  0037 cd02a3        	call	L71__setDirection
 230  003a 85            	popw	x
 231                     ; 59     GPIO_WriteLow(port_ena, pin_ena);
 233  003b 7b05          	ld	a,(OFST+5,sp)
 234  003d 88            	push	a
 235  003e 1e02          	ldw	x,(OFST+2,sp)
 236  0040 cd0000        	call	_GPIO_WriteLow
 238  0043 84            	pop	a
 239                     ; 60     GPIO_WriteLow(port_clk, pin_clk);
 241  0044 7b08          	ld	a,(OFST+8,sp)
 242  0046 88            	push	a
 243  0047 1e07          	ldw	x,(OFST+7,sp)
 244  0049 cd0000        	call	_GPIO_WriteLow
 246  004c 84            	pop	a
 247                     ; 61 }
 250  004d 85            	popw	x
 251  004e 81            	ret
 289                     ; 63 bool Ds1302_IsHalted(void)
 289                     ; 64 {
 290                     	switch	.text
 291  004f               _Ds1302_IsHalted:
 293  004f 88            	push	a
 294       00000001      OFST:	set	1
 297                     ; 65 	uint8_t seconds = 0;
 299                     ; 66 	_prepareRead(REG_SECONDS);
 301  0050 a680          	ld	a,#128
 302  0052 cd01d4        	call	L5__prepareRead
 304                     ; 67 	seconds = _readByte();
 306  0055 cd022d        	call	__readByte
 308  0058 6b01          	ld	(OFST+0,sp),a
 310                     ; 68 	_end();
 312  005a cd0223        	call	L11__end
 314                     ; 69 	return (seconds & 0b10000000);
 316  005d 7b01          	ld	a,(OFST+0,sp)
 317  005f a580          	bcp	a,#128
 318  0061 2704          	jreq	L01
 319  0063 a601          	ld	a,#1
 320  0065 2001          	jra	L21
 321  0067               L01:
 322  0067 4f            	clr	a
 323  0068               L21:
 326  0068 5b01          	addw	sp,#1
 327  006a 81            	ret
 424                     ; 72 void Ds1302_GetDateTime(DateTime* dt)
 424                     ; 73 {
 425                     	switch	.text
 426  006b               _Ds1302_GetDateTime:
 428  006b 89            	pushw	x
 429       00000000      OFST:	set	0
 432                     ; 74     _prepareRead(REG_BURST);
 434  006c a6be          	ld	a,#190
 435  006e cd01d4        	call	L5__prepareRead
 437                     ; 75     dt->second = _bcd2dec(_readByte() & 0b01111111);
 439  0071 cd022d        	call	__readByte
 441  0074 a47f          	and	a,#127
 442  0076 cd02c0        	call	L12__bcd2dec
 444  0079 1e01          	ldw	x,(OFST+1,sp)
 445  007b f7            	ld	(x),a
 446                     ; 76     dt->minute = _bcd2dec(_readByte() & 0b01111111);
 448  007c cd022d        	call	__readByte
 450  007f a47f          	and	a,#127
 451  0081 cd02c0        	call	L12__bcd2dec
 453  0084 1e01          	ldw	x,(OFST+1,sp)
 454  0086 e701          	ld	(1,x),a
 455                     ; 77     dt->hour   = _bcd2dec(_readByte() & 0b00111111);
 457  0088 cd022d        	call	__readByte
 459  008b a43f          	and	a,#63
 460  008d cd02c0        	call	L12__bcd2dec
 462  0090 1e01          	ldw	x,(OFST+1,sp)
 463  0092 e702          	ld	(2,x),a
 464                     ; 78     dt->day    = _bcd2dec(_readByte() & 0b00111111);
 466  0094 cd022d        	call	__readByte
 468  0097 a43f          	and	a,#63
 469  0099 cd02c0        	call	L12__bcd2dec
 471  009c 1e01          	ldw	x,(OFST+1,sp)
 472  009e e703          	ld	(3,x),a
 473                     ; 79     dt->month  = _bcd2dec(_readByte() & 0b00011111);
 475  00a0 cd022d        	call	__readByte
 477  00a3 a41f          	and	a,#31
 478  00a5 cd02c0        	call	L12__bcd2dec
 480  00a8 1e01          	ldw	x,(OFST+1,sp)
 481  00aa e704          	ld	(4,x),a
 482                     ; 80     dt->dow    = _bcd2dec(_readByte() & 0b00000111);
 484  00ac cd022d        	call	__readByte
 486  00af a407          	and	a,#7
 487  00b1 cd02c0        	call	L12__bcd2dec
 489  00b4 1e01          	ldw	x,(OFST+1,sp)
 490  00b6 e705          	ld	(5,x),a
 491                     ; 81     dt->year   = _bcd2dec(_readByte() & 0b11111111);
 493  00b8 cd022d        	call	__readByte
 495  00bb cd02c0        	call	L12__bcd2dec
 497  00be 1e01          	ldw	x,(OFST+1,sp)
 498  00c0 e706          	ld	(6,x),a
 499                     ; 82     _end();
 501  00c2 cd0223        	call	L11__end
 503                     ; 83 }
 506  00c5 85            	popw	x
 507  00c6 81            	ret
 548                     ; 85 void Ds1302_SetDateTime(DateTime* dt)
 548                     ; 86 {
 549                     	switch	.text
 550  00c7               _Ds1302_SetDateTime:
 552  00c7 89            	pushw	x
 553       00000000      OFST:	set	0
 556                     ; 87     _prepareWrite(REG_WP);
 558  00c8 a68e          	ld	a,#142
 559  00ca cd0201        	call	L7__prepareWrite
 561                     ; 88     _writeByte(0b00000000);
 563  00cd 4f            	clr	a
 564  00ce cd025e        	call	L31__writeByte
 566                     ; 89     _end();
 568  00d1 cd0223        	call	L11__end
 570                     ; 91     _prepareWrite(REG_BURST);
 572  00d4 a6be          	ld	a,#190
 573  00d6 cd0201        	call	L7__prepareWrite
 575                     ; 92     _writeByte(_dec2bcd(dt->second % 60));
 577  00d9 1e01          	ldw	x,(OFST+1,sp)
 578  00db f6            	ld	a,(x)
 579  00dc 5f            	clrw	x
 580  00dd 97            	ld	xl,a
 581  00de a63c          	ld	a,#60
 582  00e0 62            	div	x,a
 583  00e1 5f            	clrw	x
 584  00e2 97            	ld	xl,a
 585  00e3 9f            	ld	a,xl
 586  00e4 cd02d4        	call	L32__dec2bcd
 588  00e7 cd025e        	call	L31__writeByte
 590                     ; 93     _writeByte(_dec2bcd(dt->minute % 60));
 592  00ea 1e01          	ldw	x,(OFST+1,sp)
 593  00ec e601          	ld	a,(1,x)
 594  00ee 5f            	clrw	x
 595  00ef 97            	ld	xl,a
 596  00f0 a63c          	ld	a,#60
 597  00f2 62            	div	x,a
 598  00f3 5f            	clrw	x
 599  00f4 97            	ld	xl,a
 600  00f5 9f            	ld	a,xl
 601  00f6 cd02d4        	call	L32__dec2bcd
 603  00f9 cd025e        	call	L31__writeByte
 605                     ; 94     _writeByte(_dec2bcd(dt->hour % 24));
 607  00fc 1e01          	ldw	x,(OFST+1,sp)
 608  00fe e602          	ld	a,(2,x)
 609  0100 5f            	clrw	x
 610  0101 97            	ld	xl,a
 611  0102 a618          	ld	a,#24
 612  0104 62            	div	x,a
 613  0105 5f            	clrw	x
 614  0106 97            	ld	xl,a
 615  0107 9f            	ld	a,xl
 616  0108 cd02d4        	call	L32__dec2bcd
 618  010b cd025e        	call	L31__writeByte
 620                     ; 95     _writeByte(_dec2bcd(dt->day % 32));
 622  010e 1e01          	ldw	x,(OFST+1,sp)
 623  0110 e603          	ld	a,(3,x)
 624  0112 a41f          	and	a,#31
 625  0114 cd02d4        	call	L32__dec2bcd
 627  0117 cd025e        	call	L31__writeByte
 629                     ; 96     _writeByte(_dec2bcd(dt->month % 13));
 631  011a 1e01          	ldw	x,(OFST+1,sp)
 632  011c e604          	ld	a,(4,x)
 633  011e 5f            	clrw	x
 634  011f 97            	ld	xl,a
 635  0120 a60d          	ld	a,#13
 636  0122 62            	div	x,a
 637  0123 5f            	clrw	x
 638  0124 97            	ld	xl,a
 639  0125 9f            	ld	a,xl
 640  0126 cd02d4        	call	L32__dec2bcd
 642  0129 cd025e        	call	L31__writeByte
 644                     ; 97     _writeByte(_dec2bcd(dt->dow % 8));
 646  012c 1e01          	ldw	x,(OFST+1,sp)
 647  012e e605          	ld	a,(5,x)
 648  0130 a407          	and	a,#7
 649  0132 cd02d4        	call	L32__dec2bcd
 651  0135 cd025e        	call	L31__writeByte
 653                     ; 98     _writeByte(_dec2bcd(dt->year % 100));
 655  0138 1e01          	ldw	x,(OFST+1,sp)
 656  013a e606          	ld	a,(6,x)
 657  013c 5f            	clrw	x
 658  013d 97            	ld	xl,a
 659  013e a664          	ld	a,#100
 660  0140 62            	div	x,a
 661  0141 5f            	clrw	x
 662  0142 97            	ld	xl,a
 663  0143 9f            	ld	a,xl
 664  0144 cd02d4        	call	L32__dec2bcd
 666  0147 cd025e        	call	L31__writeByte
 668                     ; 99     _writeByte(0b10000000);
 670  014a a680          	ld	a,#128
 671  014c cd025e        	call	L31__writeByte
 673                     ; 100     _end();
 675  014f cd0223        	call	L11__end
 677                     ; 101 }
 680  0152 85            	popw	x
 681  0153 81            	ret
 705                     ; 103 void Ds1302_Halt(void)
 705                     ; 104 {
 706                     	switch	.text
 707  0154               _Ds1302_Halt:
 711                     ; 105     _setHaltFlag(true);
 713  0154 a601          	ld	a,#1
 714  0156 ad05          	call	L3__setHaltFlag
 716                     ; 106 }
 719  0158 81            	ret
 743                     ; 108 void Ds1302_Start(void)
 743                     ; 109 {
 744                     	switch	.text
 745  0159               _Ds1302_Start:
 749                     ; 110     _setHaltFlag(false);
 751  0159 4f            	clr	a
 752  015a ad01          	call	L3__setHaltFlag
 754                     ; 111 }
 757  015c 81            	ret
 816                     ; 113 static void _setHaltFlag(bool stopped)
 816                     ; 114 {
 817                     	switch	.text
 818  015d               L3__setHaltFlag:
 820  015d 88            	push	a
 821  015e 520c          	subw	sp,#12
 822       0000000c      OFST:	set	12
 825                     ; 116 		int b = 0;
 827                     ; 117     _prepareRead(REG_BURST);
 829  0160 a6be          	ld	a,#190
 830  0162 ad70          	call	L5__prepareRead
 832                     ; 118     for (b = 0; b < 8; b++) regs[b] = _readByte();
 834  0164 5f            	clrw	x
 835  0165 1f0b          	ldw	(OFST-1,sp),x
 837  0167               L713:
 840  0167 cd022d        	call	__readByte
 842  016a 96            	ldw	x,sp
 843  016b 1c0003        	addw	x,#OFST-9
 844  016e 1f01          	ldw	(OFST-11,sp),x
 846  0170 1e0b          	ldw	x,(OFST-1,sp)
 847  0172 72fb01        	addw	x,(OFST-11,sp)
 848  0175 f7            	ld	(x),a
 851  0176 1e0b          	ldw	x,(OFST-1,sp)
 852  0178 1c0001        	addw	x,#1
 853  017b 1f0b          	ldw	(OFST-1,sp),x
 857  017d 9c            	rvf
 858  017e 1e0b          	ldw	x,(OFST-1,sp)
 859  0180 a30008        	cpw	x,#8
 860  0183 2fe2          	jrslt	L713
 861                     ; 119     _end();
 863  0185 cd0223        	call	L11__end
 865                     ; 121     if (stopped) regs[0] |= 0b10000000;
 867  0188 7b0d          	ld	a,(OFST+1,sp)
 868  018a a501          	bcp	a,#1
 869  018c 2708          	jreq	L523
 872  018e 7b03          	ld	a,(OFST-9,sp)
 873  0190 aa80          	or	a,#128
 874  0192 6b03          	ld	(OFST-9,sp),a
 877  0194 2006          	jra	L723
 878  0196               L523:
 879                     ; 122     else regs[0] &= ~0b10000000;
 881  0196 7b03          	ld	a,(OFST-9,sp)
 882  0198 a47f          	and	a,#127
 883  019a 6b03          	ld	(OFST-9,sp),a
 885  019c               L723:
 886                     ; 123     regs[7] = 0b10000000;
 888  019c a680          	ld	a,#128
 889  019e 6b0a          	ld	(OFST-2,sp),a
 891                     ; 125     _prepareWrite(REG_WP);
 893  01a0 a68e          	ld	a,#142
 894  01a2 ad5d          	call	L7__prepareWrite
 896                     ; 126     _writeByte(0b00000000);
 898  01a4 4f            	clr	a
 899  01a5 cd025e        	call	L31__writeByte
 901                     ; 127     _end();
 903  01a8 ad79          	call	L11__end
 905                     ; 129     _prepareWrite(REG_BURST);
 907  01aa a6be          	ld	a,#190
 908  01ac ad53          	call	L7__prepareWrite
 910                     ; 130     for (b = 0; b < 8; b++) _writeByte(regs[b]);
 912  01ae 5f            	clrw	x
 913  01af 1f0b          	ldw	(OFST-1,sp),x
 915  01b1               L133:
 918  01b1 96            	ldw	x,sp
 919  01b2 1c0003        	addw	x,#OFST-9
 920  01b5 1f01          	ldw	(OFST-11,sp),x
 922  01b7 1e0b          	ldw	x,(OFST-1,sp)
 923  01b9 72fb01        	addw	x,(OFST-11,sp)
 924  01bc f6            	ld	a,(x)
 925  01bd cd025e        	call	L31__writeByte
 929  01c0 1e0b          	ldw	x,(OFST-1,sp)
 930  01c2 1c0001        	addw	x,#1
 931  01c5 1f0b          	ldw	(OFST-1,sp),x
 935  01c7 9c            	rvf
 936  01c8 1e0b          	ldw	x,(OFST-1,sp)
 937  01ca a30008        	cpw	x,#8
 938  01cd 2fe2          	jrslt	L133
 939                     ; 131     _end();
 941  01cf ad52          	call	L11__end
 943                     ; 132 }
 946  01d1 5b0d          	addw	sp,#13
 947  01d3 81            	ret
 997                     ; 134 static void _prepareRead(uint8_t address)
 997                     ; 135 {
 998                     	switch	.text
 999  01d4               L5__prepareRead:
1001  01d4 88            	push	a
1002  01d5 88            	push	a
1003       00000001      OFST:	set	1
1006                     ; 136 	uint8_t command = 0;
1008                     ; 137 	_setDirection(_port_dat, _pin_dat, OUTPUT);
1010  01d6 4bc0          	push	#192
1011  01d8 3b0001        	push	L73__pin_dat
1012  01db be04          	ldw	x,L13__port_dat
1013  01dd cd02a3        	call	L71__setDirection
1015  01e0 85            	popw	x
1016                     ; 138 	GPIO_WriteHigh(_port_ena, _pin_ena);
1018  01e1 3b0003        	push	L33__pin_ena
1019  01e4 be08          	ldw	x,L52__port_ena
1020  01e6 cd0000        	call	_GPIO_WriteHigh
1022  01e9 84            	pop	a
1023                     ; 139 	command = 0b10000001 | address;
1025  01ea 7b02          	ld	a,(OFST+1,sp)
1026  01ec aa81          	or	a,#129
1027  01ee 6b01          	ld	(OFST+0,sp),a
1029                     ; 140 	_writeByte(command);
1031  01f0 7b01          	ld	a,(OFST+0,sp)
1032  01f2 ad6a          	call	L31__writeByte
1034                     ; 141 	_setDirection(_port_dat, _pin_dat, INPUT);
1036  01f4 4b00          	push	#0
1037  01f6 3b0001        	push	L73__pin_dat
1038  01f9 be04          	ldw	x,L13__port_dat
1039  01fb cd02a3        	call	L71__setDirection
1041  01fe 85            	popw	x
1042                     ; 142 }
1045  01ff 85            	popw	x
1046  0200 81            	ret
1096                     ; 144 static void _prepareWrite(uint8_t address)
1096                     ; 145 {
1097                     	switch	.text
1098  0201               L7__prepareWrite:
1100  0201 88            	push	a
1101  0202 88            	push	a
1102       00000001      OFST:	set	1
1105                     ; 146 	uint8_t command = 0;
1107                     ; 147 	_setDirection(_port_dat, _pin_dat, OUTPUT);
1109  0203 4bc0          	push	#192
1110  0205 3b0001        	push	L73__pin_dat
1111  0208 be04          	ldw	x,L13__port_dat
1112  020a cd02a3        	call	L71__setDirection
1114  020d 85            	popw	x
1115                     ; 148 	GPIO_WriteHigh(_port_ena, _pin_ena);
1117  020e 3b0003        	push	L33__pin_ena
1118  0211 be08          	ldw	x,L52__port_ena
1119  0213 cd0000        	call	_GPIO_WriteHigh
1121  0216 84            	pop	a
1122                     ; 149 	command = 0b10000000 | address;
1124  0217 7b02          	ld	a,(OFST+1,sp)
1125  0219 aa80          	or	a,#128
1126  021b 6b01          	ld	(OFST+0,sp),a
1128                     ; 150 	_writeByte(command);
1130  021d 7b01          	ld	a,(OFST+0,sp)
1131  021f ad3d          	call	L31__writeByte
1133                     ; 151 }
1136  0221 85            	popw	x
1137  0222 81            	ret
1163                     ; 153 static void _end(void)
1163                     ; 154 {
1164                     	switch	.text
1165  0223               L11__end:
1169                     ; 155     GPIO_WriteLow(_port_ena, _pin_ena);
1171  0223 3b0003        	push	L33__pin_ena
1172  0226 be08          	ldw	x,L52__port_ena
1173  0228 cd0000        	call	_GPIO_WriteLow
1175  022b 84            	pop	a
1176                     ; 156 }
1179  022c 81            	ret
1226                     ; 158 uint8_t _readByte(void)
1226                     ; 159 {
1227                     	switch	.text
1228  022d               __readByte:
1230  022d 89            	pushw	x
1231       00000002      OFST:	set	2
1234                     ; 160     uint8_t byte = 0;
1236  022e 0f01          	clr	(OFST-1,sp)
1238                     ; 161 		uint8_t b = 0;
1240                     ; 162     for (b = 0; b < 8; b++)
1242  0230 0f02          	clr	(OFST+0,sp)
1244  0232               L534:
1245                     ; 164         if (GPIO_ReadInputPin(_port_dat, _pin_dat)) byte |= (0x01 << b);
1247  0232 3b0001        	push	L73__pin_dat
1248  0235 be04          	ldw	x,L13__port_dat
1249  0237 cd0000        	call	_GPIO_ReadInputPin
1251  023a 5b01          	addw	sp,#1
1252  023c 4d            	tnz	a
1253  023d 2711          	jreq	L344
1256  023f 7b02          	ld	a,(OFST+0,sp)
1257  0241 5f            	clrw	x
1258  0242 97            	ld	xl,a
1259  0243 a601          	ld	a,#1
1260  0245 5d            	tnzw	x
1261  0246 2704          	jreq	L63
1262  0248               L04:
1263  0248 48            	sll	a
1264  0249 5a            	decw	x
1265  024a 26fc          	jrne	L04
1266  024c               L63:
1267  024c 1a01          	or	a,(OFST-1,sp)
1268  024e 6b01          	ld	(OFST-1,sp),a
1270  0250               L344:
1271                     ; 165         _nextBit();
1273  0250 ad32          	call	L51__nextBit
1275                     ; 162     for (b = 0; b < 8; b++)
1277  0252 0c02          	inc	(OFST+0,sp)
1281  0254 7b02          	ld	a,(OFST+0,sp)
1282  0256 a108          	cp	a,#8
1283  0258 25d8          	jrult	L534
1284                     ; 168     return byte;
1286  025a 7b01          	ld	a,(OFST-1,sp)
1289  025c 85            	popw	x
1290  025d 81            	ret
1339                     ; 171 static void _writeByte(uint8_t value)
1339                     ; 172 {
1340                     	switch	.text
1341  025e               L31__writeByte:
1343  025e 88            	push	a
1344  025f 88            	push	a
1345       00000001      OFST:	set	1
1348                     ; 173 	uint8_t b = 0;
1350                     ; 174     for (b = 0; b < 8; b++)
1352  0260 0f01          	clr	(OFST+0,sp)
1354  0262               L764:
1355                     ; 176         GPIO_WriteLow(_port_clk, _pin_clk);
1357  0262 3b0002        	push	L53__pin_clk
1358  0265 be06          	ldw	x,L72__port_clk
1359  0267 cd0000        	call	_GPIO_WriteLow
1361  026a 84            	pop	a
1362                     ; 177         GPIO_Write(_port_dat, (value & 0x01));
1364  026b 7b02          	ld	a,(OFST+1,sp)
1365  026d a401          	and	a,#1
1366  026f 88            	push	a
1367  0270 be04          	ldw	x,L13__port_dat
1368  0272 cd0000        	call	_GPIO_Write
1370  0275 84            	pop	a
1371                     ; 178         _nextBit();
1373  0276 ad0c          	call	L51__nextBit
1375                     ; 179         value >>= 1;
1377  0278 0402          	srl	(OFST+1,sp)
1378                     ; 174     for (b = 0; b < 8; b++)
1380  027a 0c01          	inc	(OFST+0,sp)
1384  027c 7b01          	ld	a,(OFST+0,sp)
1385  027e a108          	cp	a,#8
1386  0280 25e0          	jrult	L764
1387                     ; 181 }
1390  0282 85            	popw	x
1391  0283 81            	ret
1419                     ; 183 static void _nextBit(void)
1419                     ; 184 {
1420                     	switch	.text
1421  0284               L51__nextBit:
1425                     ; 185     GPIO_WriteHigh(_port_clk, _pin_clk);
1427  0284 3b0002        	push	L53__pin_clk
1428  0287 be06          	ldw	x,L72__port_clk
1429  0289 cd0000        	call	_GPIO_WriteHigh
1431  028c 84            	pop	a
1432                     ; 186     delay_us(1); // Replace with STM8-compatible delay
1434  028d ae0001        	ldw	x,#1
1435  0290 cd0000        	call	_delay_us
1437                     ; 187     GPIO_WriteLow(_port_clk, _pin_clk);
1439  0293 3b0002        	push	L53__pin_clk
1440  0296 be06          	ldw	x,L72__port_clk
1441  0298 cd0000        	call	_GPIO_WriteLow
1443  029b 84            	pop	a
1444                     ; 188     delay_us(1);
1446  029c ae0001        	ldw	x,#1
1447  029f cd0000        	call	_delay_us
1449                     ; 189 }
1452  02a2 81            	ret
1508                     ; 191 static void _setDirection(GPIO_TypeDef* port, uint8_t pin, uint8_t direction)
1508                     ; 192 {
1509                     	switch	.text
1510  02a3               L71__setDirection:
1512  02a3 89            	pushw	x
1513       00000000      OFST:	set	0
1516                     ; 193     if (direction == INPUT)
1518  02a4 0d06          	tnz	(OFST+6,sp)
1519  02a6 260b          	jrne	L535
1520                     ; 195         GPIO_Init(port, pin, GPIO_MODE_IN_FL_NO_IT);
1522  02a8 4b00          	push	#0
1523  02aa 7b06          	ld	a,(OFST+6,sp)
1524  02ac 88            	push	a
1525  02ad cd0000        	call	_GPIO_Init
1527  02b0 85            	popw	x
1529  02b1 200b          	jra	L735
1530  02b3               L535:
1531                     ; 199         GPIO_Init(port, pin, GPIO_MODE_OUT_PP_LOW_FAST);
1533  02b3 4be0          	push	#224
1534  02b5 7b06          	ld	a,(OFST+6,sp)
1535  02b7 88            	push	a
1536  02b8 1e03          	ldw	x,(OFST+3,sp)
1537  02ba cd0000        	call	_GPIO_Init
1539  02bd 85            	popw	x
1540  02be               L735:
1541                     ; 201 }
1544  02be 85            	popw	x
1545  02bf 81            	ret
1579                     ; 203 static uint8_t _bcd2dec(uint8_t bcd)
1579                     ; 204 {
1580                     	switch	.text
1581  02c0               L12__bcd2dec:
1583  02c0 88            	push	a
1584  02c1 88            	push	a
1585       00000001      OFST:	set	1
1588                     ; 205     return ((bcd >> 4) * 10) + (bcd & 0x0F);
1590  02c2 a40f          	and	a,#15
1591  02c4 6b01          	ld	(OFST+0,sp),a
1593  02c6 7b02          	ld	a,(OFST+1,sp)
1594  02c8 4e            	swap	a
1595  02c9 a40f          	and	a,#15
1596  02cb 97            	ld	xl,a
1597  02cc a60a          	ld	a,#10
1598  02ce 42            	mul	x,a
1599  02cf 9f            	ld	a,xl
1600  02d0 1b01          	add	a,(OFST+0,sp)
1603  02d2 85            	popw	x
1604  02d3 81            	ret
1638                     ; 208 static uint8_t _dec2bcd(uint8_t dec)
1638                     ; 209 {
1639                     	switch	.text
1640  02d4               L32__dec2bcd:
1642  02d4 88            	push	a
1643  02d5 88            	push	a
1644       00000001      OFST:	set	1
1647                     ; 210     return ((dec / 10) << 4) | (dec % 10);
1649  02d6 5f            	clrw	x
1650  02d7 97            	ld	xl,a
1651  02d8 a60a          	ld	a,#10
1652  02da 62            	div	x,a
1653  02db 5f            	clrw	x
1654  02dc 97            	ld	xl,a
1655  02dd 9f            	ld	a,xl
1656  02de 6b01          	ld	(OFST+0,sp),a
1658  02e0 7b02          	ld	a,(OFST+1,sp)
1659  02e2 5f            	clrw	x
1660  02e3 97            	ld	xl,a
1661  02e4 a60a          	ld	a,#10
1662  02e6 62            	div	x,a
1663  02e7 9f            	ld	a,xl
1664  02e8 97            	ld	xl,a
1665  02e9 a610          	ld	a,#16
1666  02eb 42            	mul	x,a
1667  02ec 9f            	ld	a,xl
1668  02ed 1a01          	or	a,(OFST+0,sp)
1671  02ef 85            	popw	x
1672  02f0 81            	ret
1759                     	switch	.ubsct
1760  0000               L14__dat_direction:
1761  0000 00            	ds.b	1
1762  0001               L73__pin_dat:
1763  0001 00            	ds.b	1
1764  0002               L53__pin_clk:
1765  0002 00            	ds.b	1
1766  0003               L33__pin_ena:
1767  0003 00            	ds.b	1
1768  0004               L13__port_dat:
1769  0004 0000          	ds.b	2
1770  0006               L72__port_clk:
1771  0006 0000          	ds.b	2
1772  0008               L52__port_ena:
1773  0008 0000          	ds.b	2
1774                     	xref	_delay_us
1775                     	xdef	__readByte
1776                     	xdef	_Ds1302_Start
1777                     	xdef	_Ds1302_Halt
1778                     	xdef	_Ds1302_SetDateTime
1779                     	xdef	_Ds1302_GetDateTime
1780                     	xdef	_Ds1302_IsHalted
1781                     	xdef	_Ds1302_Init
1782                     	xref	_GPIO_ReadInputPin
1783                     	xref	_GPIO_WriteLow
1784                     	xref	_GPIO_WriteHigh
1785                     	xref	_GPIO_Write
1786                     	xref	_GPIO_Init
1806                     	end
