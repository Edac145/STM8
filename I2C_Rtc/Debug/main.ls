   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     .const:	section	.text
  15  0000               L3_time_buf:
  16  0000 00            	dc.b	0
  17  0001 00            	dc.b	0
  18  0002 00            	dc.b	0
  19  0003 00            	dc.b	0
  20  0004 00            	dc.b	0
  21  0005 00            	dc.b	0
  22  0006 00            	dc.b	0
  23  0007               L5_init_time:
  24  0007 00            	dc.b	0
  25  0008 00            	dc.b	0
  26  0009 12            	dc.b	18
  27  000a 01            	dc.b	1
  28  000b 07            	dc.b	7
  29  000c 07            	dc.b	7
  30  000d 23            	dc.b	35
 136                     ; 21 void main (void)
 136                     ; 22 {
 138                     	switch	.text
 139  0000               _main:
 141  0000 521d          	subw	sp,#29
 142       0000001d      OFST:	set	29
 145                     ; 23 	unsigned char time_buf[7] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00};
 147  0002 96            	ldw	x,sp
 148  0003 1c0004        	addw	x,#OFST-25
 149  0006 90ae0000      	ldw	y,#L3_time_buf
 150  000a a607          	ld	a,#7
 151  000c cd0000        	call	c_xymov
 153                     ; 25 	unsigned char init_time[7] = {0x00, 0x00, 0x12, 0x01, 0x07, 0x07, 0x23}; 
 155  000f 96            	ldw	x,sp
 156  0010 1c000d        	addw	x,#OFST-16
 157  0013 90ae0007      	ldw	y,#L5_init_time
 158  0017 a607          	ld	a,#7
 159  0019 cd0000        	call	c_xymov
 161                     ; 31 	int i = 0 ;
 163                     ; 32   clock_setup ();
 165  001c cd011f        	call	_clock_setup
 167                     ; 33   TIM4_Config ();
 169  001f cd0000        	call	_TIM4_Config
 171                     ; 34   UART3_setup ();
 173  0022 cd00ef        	call	_UART3_setup
 175                     ; 35   GPIO_setup ();
 177  0025 cd0158        	call	_GPIO_setup
 179                     ; 36 	I2CInit();
 181  0028 cd0000        	call	_I2CInit
 183                     ; 37   printf("\r\nCompiled: %s %s\r\n", __DATE__, __TIME__);
 185  002b ae00aa        	ldw	x,#L76
 186  002e 89            	pushw	x
 187  002f ae00b3        	ldw	x,#L56
 188  0032 89            	pushw	x
 189  0033 ae00bf        	ldw	x,#L36
 190  0036 cd0000        	call	_printf
 192  0039 5b04          	addw	sp,#4
 193                     ; 38 	DS3231_SetTime(init_time, 7);
 195  003b 4b07          	push	#7
 196  003d 96            	ldw	x,sp
 197  003e 1c000e        	addw	x,#OFST-15
 198  0041 cd0000        	call	_DS3231_SetTime
 200  0044 84            	pop	a
 201  0045               L17:
 202                     ; 41 		DS3231_GetTime(rtc_buf, 7);
 204  0045 4b07          	push	#7
 205  0047 96            	ldw	x,sp
 206  0048 1c0018        	addw	x,#OFST-5
 207  004b cd0000        	call	_DS3231_GetTime
 209  004e 84            	pop	a
 210                     ; 43     day = (rtc_buf[4] >> 8);
 212  004f 0f14          	clr	(OFST-9,sp)
 214                     ; 44 		month = (rtc_buf[5] >> 12); // Mask out century bit
 216  0051 0f15          	clr	(OFST-8,sp)
 218                     ; 45 		year = (rtc_buf[6] >> 8);
 220  0053 0f16          	clr	(OFST-7,sp)
 222                     ; 46 		printf("Raw day: %02X (Parsed Day: %02d)\n", rtc_buf[4], day);
 224  0055 4b00          	push	#0
 225  0057 7b1c          	ld	a,(OFST-1,sp)
 226  0059 88            	push	a
 227  005a ae0088        	ldw	x,#L57
 228  005d cd0000        	call	_printf
 230  0060 85            	popw	x
 231                     ; 47 		printf("Raw month: %02X (Parsed Month: %02d)\n", rtc_buf[5], month);
 233  0061 7b15          	ld	a,(OFST-8,sp)
 234  0063 88            	push	a
 235  0064 7b1d          	ld	a,(OFST+0,sp)
 236  0066 88            	push	a
 237  0067 ae0062        	ldw	x,#L77
 238  006a cd0000        	call	_printf
 240  006d 85            	popw	x
 241                     ; 48 		printf("Raw year: %02X (Parsed Year: 20%02d)\n", rtc_buf[6], year);
 243  006e 7b16          	ld	a,(OFST-7,sp)
 244  0070 88            	push	a
 245  0071 7b1e          	ld	a,(OFST+1,sp)
 246  0073 88            	push	a
 247  0074 ae003c        	ldw	x,#L101
 248  0077 cd0000        	call	_printf
 250  007a 85            	popw	x
 251                     ; 51 		printf("Date: %02X-%02X-20%02X\n", day, month, year);
 253  007b 7b16          	ld	a,(OFST-7,sp)
 254  007d 88            	push	a
 255  007e 7b16          	ld	a,(OFST-7,sp)
 256  0080 88            	push	a
 257  0081 7b16          	ld	a,(OFST-7,sp)
 258  0083 88            	push	a
 259  0084 ae0024        	ldw	x,#L301
 260  0087 cd0000        	call	_printf
 262  008a 5b03          	addw	sp,#3
 263                     ; 53 		printf("Time: %02d:%02d:%02d\n",
 263                     ; 54 					 (rtc_buf[2] >> 4) * 10 + (rtc_buf[2] & 0x0F), // Convert Hours from BCD
 263                     ; 55 					 (rtc_buf[1] >> 4) * 10 + (rtc_buf[1] & 0x0F), // Convert Minutes from BCD
 263                     ; 56 					 (rtc_buf[0] >> 4) * 10 + (rtc_buf[0] & 0x0F)  // Convert Seconds from BCD
 263                     ; 57 					);
 265  008c 7b17          	ld	a,(OFST-6,sp)
 266  008e a40f          	and	a,#15
 267  0090 6b03          	ld	(OFST-26,sp),a
 269  0092 7b17          	ld	a,(OFST-6,sp)
 270  0094 4e            	swap	a
 271  0095 a40f          	and	a,#15
 272  0097 5f            	clrw	x
 273  0098 97            	ld	xl,a
 274  0099 a60a          	ld	a,#10
 275  009b cd0000        	call	c_bmulx
 277  009e 01            	rrwa	x,a
 278  009f 1b03          	add	a,(OFST-26,sp)
 279  00a1 2401          	jrnc	L6
 280  00a3 5c            	incw	x
 281  00a4               L6:
 282  00a4 02            	rlwa	x,a
 283  00a5 89            	pushw	x
 284  00a6 01            	rrwa	x,a
 285  00a7 7b1a          	ld	a,(OFST-3,sp)
 286  00a9 a40f          	and	a,#15
 287  00ab 6b04          	ld	(OFST-25,sp),a
 289  00ad 7b1a          	ld	a,(OFST-3,sp)
 290  00af 4e            	swap	a
 291  00b0 a40f          	and	a,#15
 292  00b2 5f            	clrw	x
 293  00b3 97            	ld	xl,a
 294  00b4 a60a          	ld	a,#10
 295  00b6 cd0000        	call	c_bmulx
 297  00b9 01            	rrwa	x,a
 298  00ba 1b04          	add	a,(OFST-25,sp)
 299  00bc 2401          	jrnc	L01
 300  00be 5c            	incw	x
 301  00bf               L01:
 302  00bf 02            	rlwa	x,a
 303  00c0 89            	pushw	x
 304  00c1 01            	rrwa	x,a
 305  00c2 7b1d          	ld	a,(OFST+0,sp)
 306  00c4 a40f          	and	a,#15
 307  00c6 6b05          	ld	(OFST-24,sp),a
 309  00c8 7b1d          	ld	a,(OFST+0,sp)
 310  00ca 4e            	swap	a
 311  00cb a40f          	and	a,#15
 312  00cd 5f            	clrw	x
 313  00ce 97            	ld	xl,a
 314  00cf a60a          	ld	a,#10
 315  00d1 cd0000        	call	c_bmulx
 317  00d4 01            	rrwa	x,a
 318  00d5 1b05          	add	a,(OFST-24,sp)
 319  00d7 2401          	jrnc	L21
 320  00d9 5c            	incw	x
 321  00da               L21:
 322  00da 02            	rlwa	x,a
 323  00db 89            	pushw	x
 324  00dc 01            	rrwa	x,a
 325  00dd ae000e        	ldw	x,#L501
 326  00e0 cd0000        	call	_printf
 328  00e3 5b06          	addw	sp,#6
 329                     ; 58 		delay_ms(1000);
 331  00e5 ae03e8        	ldw	x,#1000
 332  00e8 cd0000        	call	_delay_ms
 335  00eb ac450045      	jpf	L17
 361                     ; 62 void UART3_setup (void)
 361                     ; 63 {
 362                     	switch	.text
 363  00ef               _UART3_setup:
 367                     ; 64   UART3_DeInit ();
 369  00ef cd0000        	call	_UART3_DeInit
 371                     ; 67   UART3_Init (9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
 371                     ; 68               UART3_MODE_TX_ENABLE);
 373  00f2 4b04          	push	#4
 374  00f4 4b00          	push	#0
 375  00f6 4b00          	push	#0
 376  00f8 4b00          	push	#0
 377  00fa ae2580        	ldw	x,#9600
 378  00fd 89            	pushw	x
 379  00fe ae0000        	ldw	x,#0
 380  0101 89            	pushw	x
 381  0102 cd0000        	call	_UART3_Init
 383  0105 5b08          	addw	sp,#8
 384                     ; 70   UART3_Cmd (ENABLE); // Enable UART1
 386  0107 a601          	ld	a,#1
 387  0109 cd0000        	call	_UART3_Cmd
 389                     ; 71 }
 392  010c 81            	ret
 428                     ; 73 PUTCHAR_PROTOTYPE{
 429                     	switch	.text
 430  010d               _putchar:
 432  010d 88            	push	a
 433       00000000      OFST:	set	0
 436                     ; 75   UART3_SendData8 (c);
 438  010e cd0000        	call	_UART3_SendData8
 441  0111               L731:
 442                     ; 77   while (UART3_GetFlagStatus (UART3_FLAG_TXE) == RESET);
 444  0111 ae0080        	ldw	x,#128
 445  0114 cd0000        	call	_UART3_GetFlagStatus
 447  0117 4d            	tnz	a
 448  0118 27f7          	jreq	L731
 449                     ; 79   return (c);
 451  011a 7b01          	ld	a,(OFST+1,sp)
 454  011c 5b01          	addw	sp,#1
 455  011e 81            	ret
 488                     ; 82 void clock_setup (void)
 488                     ; 83 {
 489                     	switch	.text
 490  011f               _clock_setup:
 494                     ; 84   CLK_DeInit ();
 496  011f cd0000        	call	_CLK_DeInit
 498                     ; 85   CLK_HSECmd (DISABLE);
 500  0122 4f            	clr	a
 501  0123 cd0000        	call	_CLK_HSECmd
 503                     ; 86   CLK_LSICmd (DISABLE);
 505  0126 4f            	clr	a
 506  0127 cd0000        	call	_CLK_LSICmd
 508                     ; 87   CLK_HSICmd (ENABLE);
 510  012a a601          	ld	a,#1
 511  012c cd0000        	call	_CLK_HSICmd
 514  012f               L551:
 515                     ; 88   while (CLK_GetFlagStatus (CLK_FLAG_HSIRDY) == FALSE);
 517  012f ae0102        	ldw	x,#258
 518  0132 cd0000        	call	_CLK_GetFlagStatus
 520  0135 4d            	tnz	a
 521  0136 27f7          	jreq	L551
 522                     ; 90   CLK_ClockSwitchCmd (ENABLE);
 524  0138 a601          	ld	a,#1
 525  013a cd0000        	call	_CLK_ClockSwitchCmd
 527                     ; 91   CLK_HSIPrescalerConfig (CLK_PRESCALER_HSIDIV1);
 529  013d 4f            	clr	a
 530  013e cd0000        	call	_CLK_HSIPrescalerConfig
 532                     ; 92   CLK_SYSCLKConfig (CLK_PRESCALER_CPUDIV1);
 534  0141 a680          	ld	a,#128
 535  0143 cd0000        	call	_CLK_SYSCLKConfig
 537                     ; 94   CLK_ClockSwitchConfig (CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
 537                     ; 95                          CLK_CURRENTCLOCKSTATE_ENABLE);
 539  0146 4b01          	push	#1
 540  0148 4b00          	push	#0
 541  014a ae01e1        	ldw	x,#481
 542  014d cd0000        	call	_CLK_ClockSwitchConfig
 544  0150 85            	popw	x
 545                     ; 98   CLK_PeripheralClockConfig (CLK_PERIPHERAL_UART3, ENABLE);
 547  0151 ae0301        	ldw	x,#769
 548  0154 cd0000        	call	_CLK_PeripheralClockConfig
 550                     ; 103 }
 553  0157 81            	ret
 578                     ; 105 void GPIO_setup (void)
 578                     ; 106 {
 579                     	switch	.text
 580  0158               _GPIO_setup:
 584                     ; 107   GPIO_DeInit (GPIOE);
 586  0158 ae5014        	ldw	x,#20500
 587  015b cd0000        	call	_GPIO_DeInit
 589                     ; 108   GPIO_Init (GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
 591  015e 4bb0          	push	#176
 592  0160 4b02          	push	#2
 593  0162 ae5014        	ldw	x,#20500
 594  0165 cd0000        	call	_GPIO_Init
 596  0168 85            	popw	x
 597                     ; 109   GPIO_Init (GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
 599  0169 4bb0          	push	#176
 600  016b 4b04          	push	#4
 601  016d ae5014        	ldw	x,#20500
 602  0170 cd0000        	call	_GPIO_Init
 604  0173 85            	popw	x
 605                     ; 110 }
 608  0174 81            	ret
 644                     ; 112 void PrintTime(uint8_t *buf) {
 645                     	switch	.text
 646  0175               _PrintTime:
 648  0175 89            	pushw	x
 649  0176 5203          	subw	sp,#3
 650       00000003      OFST:	set	3
 653                     ; 113     printf("Time: %02d:%02d:%02d\n",
 653                     ; 114            (buf[2] >> 4) * 10 + (buf[2] & 0x0F),  // Convert hours from BCD
 653                     ; 115            (buf[1] >> 4) * 10 + (buf[1] & 0x0F),  // Convert minutes from BCD
 653                     ; 116            (buf[0] >> 4) * 10 + (buf[0] & 0x0F)); // Convert seconds from BCD
 655  0178 f6            	ld	a,(x)
 656  0179 a40f          	and	a,#15
 657  017b 6b03          	ld	(OFST+0,sp),a
 659  017d f6            	ld	a,(x)
 660  017e 4e            	swap	a
 661  017f a40f          	and	a,#15
 662  0181 5f            	clrw	x
 663  0182 97            	ld	xl,a
 664  0183 a60a          	ld	a,#10
 665  0185 cd0000        	call	c_bmulx
 667  0188 01            	rrwa	x,a
 668  0189 1b03          	add	a,(OFST+0,sp)
 669  018b 2401          	jrnc	L62
 670  018d 5c            	incw	x
 671  018e               L62:
 672  018e 02            	rlwa	x,a
 673  018f 89            	pushw	x
 674  0190 01            	rrwa	x,a
 675  0191 1e06          	ldw	x,(OFST+3,sp)
 676  0193 e601          	ld	a,(1,x)
 677  0195 a40f          	and	a,#15
 678  0197 6b04          	ld	(OFST+1,sp),a
 680  0199 1e06          	ldw	x,(OFST+3,sp)
 681  019b e601          	ld	a,(1,x)
 682  019d 4e            	swap	a
 683  019e a40f          	and	a,#15
 684  01a0 5f            	clrw	x
 685  01a1 97            	ld	xl,a
 686  01a2 a60a          	ld	a,#10
 687  01a4 cd0000        	call	c_bmulx
 689  01a7 01            	rrwa	x,a
 690  01a8 1b04          	add	a,(OFST+1,sp)
 691  01aa 2401          	jrnc	L03
 692  01ac 5c            	incw	x
 693  01ad               L03:
 694  01ad 02            	rlwa	x,a
 695  01ae 89            	pushw	x
 696  01af 01            	rrwa	x,a
 697  01b0 1e08          	ldw	x,(OFST+5,sp)
 698  01b2 e602          	ld	a,(2,x)
 699  01b4 a40f          	and	a,#15
 700  01b6 6b05          	ld	(OFST+2,sp),a
 702  01b8 1e08          	ldw	x,(OFST+5,sp)
 703  01ba e602          	ld	a,(2,x)
 704  01bc 4e            	swap	a
 705  01bd a40f          	and	a,#15
 706  01bf 5f            	clrw	x
 707  01c0 97            	ld	xl,a
 708  01c1 a60a          	ld	a,#10
 709  01c3 cd0000        	call	c_bmulx
 711  01c6 01            	rrwa	x,a
 712  01c7 1b05          	add	a,(OFST+2,sp)
 713  01c9 2401          	jrnc	L23
 714  01cb 5c            	incw	x
 715  01cc               L23:
 716  01cc 02            	rlwa	x,a
 717  01cd 89            	pushw	x
 718  01ce 01            	rrwa	x,a
 719  01cf ae000e        	ldw	x,#L501
 720  01d2 cd0000        	call	_printf
 722  01d5 5b06          	addw	sp,#6
 723                     ; 117 }
 726  01d7 5b05          	addw	sp,#5
 727  01d9 81            	ret
 740                     	xdef	_main
 741                     	xdef	_PrintTime
 742                     	xdef	_GPIO_setup
 743                     	xdef	_UART3_setup
 744                     	xdef	_clock_setup
 745                     	xref	_DS3231_SetTime
 746                     	xref	_DS3231_GetTime
 747                     	xref	_I2CInit
 748                     	xref	_delay_ms
 749                     	xref	_TIM4_Config
 750                     	xdef	_putchar
 751                     	xref	_printf
 752                     	xref	_UART3_GetFlagStatus
 753                     	xref	_UART3_SendData8
 754                     	xref	_UART3_Cmd
 755                     	xref	_UART3_Init
 756                     	xref	_UART3_DeInit
 757                     	xref	_GPIO_Init
 758                     	xref	_GPIO_DeInit
 759                     	xref	_CLK_GetFlagStatus
 760                     	xref	_CLK_SYSCLKConfig
 761                     	xref	_CLK_HSIPrescalerConfig
 762                     	xref	_CLK_ClockSwitchConfig
 763                     	xref	_CLK_PeripheralClockConfig
 764                     	xref	_CLK_ClockSwitchCmd
 765                     	xref	_CLK_LSICmd
 766                     	xref	_CLK_HSICmd
 767                     	xref	_CLK_HSECmd
 768                     	xref	_CLK_DeInit
 769                     	switch	.const
 770  000e               L501:
 771  000e 54696d653a20  	dc.b	"Time: %02d:%02d:%0"
 772  0020 32640a00      	dc.b	"2d",10,0
 773  0024               L301:
 774  0024 446174653a20  	dc.b	"Date: %02X-%02X-20"
 775  0036 253032580a00  	dc.b	"%02X",10,0
 776  003c               L101:
 777  003c 526177207965  	dc.b	"Raw year: %02X (Pa"
 778  004e 727365642059  	dc.b	"rsed Year: 20%02d)"
 779  0060 0a00          	dc.b	10,0
 780  0062               L77:
 781  0062 526177206d6f  	dc.b	"Raw month: %02X (P"
 782  0074 617273656420  	dc.b	"arsed Month: %02d)"
 783  0086 0a00          	dc.b	10,0
 784  0088               L57:
 785  0088 526177206461  	dc.b	"Raw day: %02X (Par"
 786  009a 736564204461  	dc.b	"sed Day: %02d)",10,0
 787  00aa               L76:
 788  00aa 32303a30333a  	dc.b	"20:03:12",0
 789  00b3               L56:
 790  00b3 4a616e203138  	dc.b	"Jan 18 2025",0
 791  00bf               L36:
 792  00bf 0d0a436f6d70  	dc.b	13,10,67,111,109,112
 793  00c5 696c65643a20  	dc.b	"iled: %s %s",13
 794  00d1 0a00          	dc.b	10,0
 795                     	xref.b	c_x
 815                     	xref	c_bmulx
 816                     	xref	c_xymov
 817                     	end
