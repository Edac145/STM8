   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  59                     ; 18 void main(void)
  59                     ; 19 {
  61                     	switch	.text
  62  0000               _main:
  64  0000 5228          	subw	sp,#40
  65       00000028      OFST:	set	40
  68                     ; 22   clock_setup();
  70  0002 ad42          	call	_clock_setup
  72                     ; 24   UART1_setup();
  74  0004 cd00a8        	call	_UART1_setup
  76                     ; 28   printf("\n\rUART1 Example :retarget the C library printf()/getchar() functions to the UART\n\r");
  78  0007 ae0032        	ldw	x,#L72
  79  000a cd0000        	call	_printf
  81                     ; 29   printf("\n\rEnter Text\n\r");
  83  000d ae0023        	ldw	x,#L13
  84  0010 cd0000        	call	_printf
  86  0013               L33:
  87                     ; 35 		UART1_SendString("Hello World!\n\r");
  89  0013 ae0014        	ldw	x,#L73
  90  0016 cd00c8        	call	_UART1_SendString
  92                     ; 36 		UART1_ReceiveString(ans, sizeof(ans));
  94  0019 ae0028        	ldw	x,#40
  95  001c 89            	pushw	x
  96  001d 96            	ldw	x,sp
  97  001e 1c0003        	addw	x,#OFST-37
  98  0021 cd00e8        	call	_UART1_ReceiveString
 100  0024 85            	popw	x
 101                     ; 37 		UART1_SendString("Recieved String is:");
 103  0025 ae0000        	ldw	x,#L14
 104  0028 cd00c8        	call	_UART1_SendString
 106                     ; 38 		UART1_SendString(ans);
 108  002b 96            	ldw	x,sp
 109  002c 1c0001        	addw	x,#OFST-39
 110  002f cd00c8        	call	_UART1_SendString
 113  0032 20df          	jra	L33
 149                     ; 48 PUTCHAR_PROTOTYPE
 149                     ; 49 {
 150                     	switch	.text
 151  0034               _putchar:
 153  0034 88            	push	a
 154       00000000      OFST:	set	0
 157                     ; 51   UART1_SendData8(c);
 159  0035 cd0000        	call	_UART1_SendData8
 162  0038               L36:
 163                     ; 53   while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 165  0038 ae0080        	ldw	x,#128
 166  003b cd0000        	call	_UART1_GetFlagStatus
 168  003e 4d            	tnz	a
 169  003f 27f7          	jreq	L36
 170                     ; 55   return (c);
 172  0041 7b01          	ld	a,(OFST+1,sp)
 175  0043 5b01          	addw	sp,#1
 176  0045 81            	ret
 209                     ; 58 void clock_setup(void)
 209                     ; 59 {
 210                     	switch	.text
 211  0046               _clock_setup:
 215                     ; 60       CLK_DeInit();
 217  0046 cd0000        	call	_CLK_DeInit
 219                     ; 62       CLK_HSECmd(DISABLE);
 221  0049 4f            	clr	a
 222  004a cd0000        	call	_CLK_HSECmd
 224                     ; 63       CLK_LSICmd(DISABLE);
 226  004d 4f            	clr	a
 227  004e cd0000        	call	_CLK_LSICmd
 229                     ; 64       CLK_HSICmd(ENABLE);
 231  0051 a601          	ld	a,#1
 232  0053 cd0000        	call	_CLK_HSICmd
 235  0056               L101:
 236                     ; 65       while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 238  0056 ae0102        	ldw	x,#258
 239  0059 cd0000        	call	_CLK_GetFlagStatus
 241  005c 4d            	tnz	a
 242  005d 27f7          	jreq	L101
 243                     ; 67       CLK_ClockSwitchCmd(ENABLE);
 245  005f a601          	ld	a,#1
 246  0061 cd0000        	call	_CLK_ClockSwitchCmd
 248                     ; 68       CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
 250  0064 a618          	ld	a,#24
 251  0066 cd0000        	call	_CLK_HSIPrescalerConfig
 253                     ; 69       CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 255  0069 a680          	ld	a,#128
 256  006b cd0000        	call	_CLK_SYSCLKConfig
 258                     ; 71       CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 258                     ; 72       DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 260  006e 4b01          	push	#1
 261  0070 4b00          	push	#0
 262  0072 ae01e1        	ldw	x,#481
 263  0075 cd0000        	call	_CLK_ClockSwitchConfig
 265  0078 85            	popw	x
 266                     ; 74       CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 268  0079 5f            	clrw	x
 269  007a cd0000        	call	_CLK_PeripheralClockConfig
 271                     ; 75       CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 273  007d ae0100        	ldw	x,#256
 274  0080 cd0000        	call	_CLK_PeripheralClockConfig
 276                     ; 76       CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 278  0083 ae1300        	ldw	x,#4864
 279  0086 cd0000        	call	_CLK_PeripheralClockConfig
 281                     ; 77       CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 283  0089 ae1200        	ldw	x,#4608
 284  008c cd0000        	call	_CLK_PeripheralClockConfig
 286                     ; 78       CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);           
 288  008f ae0201        	ldw	x,#513
 289  0092 cd0000        	call	_CLK_PeripheralClockConfig
 291                     ; 79       CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 293  0095 ae0700        	ldw	x,#1792
 294  0098 cd0000        	call	_CLK_PeripheralClockConfig
 296                     ; 80       CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 298  009b ae0500        	ldw	x,#1280
 299  009e cd0000        	call	_CLK_PeripheralClockConfig
 301                     ; 81       CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 303  00a1 ae0400        	ldw	x,#1024
 304  00a4 cd0000        	call	_CLK_PeripheralClockConfig
 306                     ; 82 }
 309  00a7 81            	ret
 335                     ; 84 void UART1_setup(void)
 335                     ; 85 {
 336                     	switch	.text
 337  00a8               _UART1_setup:
 341                     ; 86      UART1_DeInit();
 343  00a8 cd0000        	call	_UART1_DeInit
 345                     ; 88      UART1_Init(9600, 
 345                     ; 89                 UART1_WORDLENGTH_8D, 
 345                     ; 90                 UART1_STOPBITS_1, 
 345                     ; 91                 UART1_PARITY_NO, 
 345                     ; 92                 UART1_SYNCMODE_CLOCK_DISABLE, 
 345                     ; 93                 UART1_MODE_TXRX_ENABLE);
 347  00ab 4b0c          	push	#12
 348  00ad 4b80          	push	#128
 349  00af 4b00          	push	#0
 350  00b1 4b00          	push	#0
 351  00b3 4b00          	push	#0
 352  00b5 ae2580        	ldw	x,#9600
 353  00b8 89            	pushw	x
 354  00b9 ae0000        	ldw	x,#0
 355  00bc 89            	pushw	x
 356  00bd cd0000        	call	_UART1_Init
 358  00c0 5b09          	addw	sp,#9
 359                     ; 95      UART1_Cmd(ENABLE);
 361  00c2 a601          	ld	a,#1
 362  00c4 cd0000        	call	_UART1_Cmd
 364                     ; 96 }
 367  00c7 81            	ret
 404                     ; 98 void UART1_SendString(char *str)
 404                     ; 99 {
 405                     	switch	.text
 406  00c8               _UART1_SendString:
 408  00c8 89            	pushw	x
 409       00000000      OFST:	set	0
 412  00c9 2016          	jra	L531
 413  00cb               L331:
 414                     ; 102         UART1_SendData8(*str);
 416  00cb 1e01          	ldw	x,(OFST+1,sp)
 417  00cd f6            	ld	a,(x)
 418  00ce cd0000        	call	_UART1_SendData8
 421  00d1               L341:
 422                     ; 103         while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 424  00d1 ae0080        	ldw	x,#128
 425  00d4 cd0000        	call	_UART1_GetFlagStatus
 427  00d7 4d            	tnz	a
 428  00d8 27f7          	jreq	L341
 429                     ; 104         str++;
 431  00da 1e01          	ldw	x,(OFST+1,sp)
 432  00dc 1c0001        	addw	x,#1
 433  00df 1f01          	ldw	(OFST+1,sp),x
 434  00e1               L531:
 435                     ; 100     while (*str)
 437  00e1 1e01          	ldw	x,(OFST+1,sp)
 438  00e3 7d            	tnz	(x)
 439  00e4 26e5          	jrne	L331
 440                     ; 106 }
 443  00e6 85            	popw	x
 444  00e7 81            	ret
 509                     ; 108 void UART1_ReceiveString(char *buffer, uint16_t max_length) {
 510                     	switch	.text
 511  00e8               _UART1_ReceiveString:
 513  00e8 89            	pushw	x
 514  00e9 5203          	subw	sp,#3
 515       00000003      OFST:	set	3
 518                     ; 109 	uint16_t i = 0;
 520                     ; 112 	for (i = 0; i < max_length; i++) {
 522  00eb 5f            	clrw	x
 523  00ec 1f02          	ldw	(OFST-1,sp),x
 526  00ee 200d          	jra	L502
 527  00f0               L102:
 528                     ; 113 			buffer[i] = '\0';
 530  00f0 1e04          	ldw	x,(OFST+1,sp)
 531  00f2 72fb02        	addw	x,(OFST-1,sp)
 532  00f5 7f            	clr	(x)
 533                     ; 112 	for (i = 0; i < max_length; i++) {
 535  00f6 1e02          	ldw	x,(OFST-1,sp)
 536  00f8 1c0001        	addw	x,#1
 537  00fb 1f02          	ldw	(OFST-1,sp),x
 539  00fd               L502:
 542  00fd 1e02          	ldw	x,(OFST-1,sp)
 543  00ff 1308          	cpw	x,(OFST+5,sp)
 544  0101 25ed          	jrult	L102
 545                     ; 115 	i = 0;
 547  0103 5f            	clrw	x
 548  0104 1f02          	ldw	(OFST-1,sp),x
 551  0106 202a          	jra	L512
 552  0108               L322:
 553                     ; 119 			while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == RESET);
 555  0108 ae0020        	ldw	x,#32
 556  010b cd0000        	call	_UART1_GetFlagStatus
 558  010e 4d            	tnz	a
 559  010f 27f7          	jreq	L322
 560                     ; 121 			receivedChar = UART1_ReceiveData8();
 562  0111 cd0000        	call	_UART1_ReceiveData8
 564  0114 6b01          	ld	(OFST-2,sp),a
 566                     ; 123 			if (receivedChar == '\n' || receivedChar == '\r') {
 568  0116 7b01          	ld	a,(OFST-2,sp)
 569  0118 a10a          	cp	a,#10
 570  011a 271d          	jreq	L712
 572  011c 7b01          	ld	a,(OFST-2,sp)
 573  011e a10d          	cp	a,#13
 574  0120 2717          	jreq	L712
 575                     ; 126 			buffer[i++] = receivedChar;
 577  0122 7b01          	ld	a,(OFST-2,sp)
 578  0124 1e02          	ldw	x,(OFST-1,sp)
 579  0126 1c0001        	addw	x,#1
 580  0129 1f02          	ldw	(OFST-1,sp),x
 581  012b 1d0001        	subw	x,#1
 583  012e 72fb04        	addw	x,(OFST+1,sp)
 584  0131 f7            	ld	(x),a
 585  0132               L512:
 586                     ; 118 	while (i < max_length - 1) {
 588  0132 1e08          	ldw	x,(OFST+5,sp)
 589  0134 5a            	decw	x
 590  0135 1302          	cpw	x,(OFST-1,sp)
 591  0137 22cf          	jrugt	L322
 592  0139               L712:
 593                     ; 129 	buffer[i] = '\0'; // Null-terminate the string
 595  0139 1e04          	ldw	x,(OFST+1,sp)
 596  013b 72fb02        	addw	x,(OFST-1,sp)
 597  013e 7f            	clr	(x)
 598                     ; 130 }
 601  013f 5b05          	addw	sp,#5
 602  0141 81            	ret
 615                     	xdef	_main
 616                     	xdef	_UART1_ReceiveString
 617                     	xdef	_UART1_SendString
 618                     	xdef	_UART1_setup
 619                     	xdef	_clock_setup
 620                     	xref	_UART1_GetFlagStatus
 621                     	xref	_UART1_SendData8
 622                     	xref	_UART1_ReceiveData8
 623                     	xref	_UART1_Cmd
 624                     	xref	_UART1_Init
 625                     	xref	_UART1_DeInit
 626                     	xref	_CLK_GetFlagStatus
 627                     	xref	_CLK_SYSCLKConfig
 628                     	xref	_CLK_HSIPrescalerConfig
 629                     	xref	_CLK_ClockSwitchConfig
 630                     	xref	_CLK_PeripheralClockConfig
 631                     	xref	_CLK_ClockSwitchCmd
 632                     	xref	_CLK_LSICmd
 633                     	xref	_CLK_HSICmd
 634                     	xref	_CLK_HSECmd
 635                     	xref	_CLK_DeInit
 636                     	xdef	_putchar
 637                     	xref	_printf
 638                     .const:	section	.text
 639  0000               L14:
 640  0000 526563696576  	dc.b	"Recieved String is"
 641  0012 3a00          	dc.b	":",0
 642  0014               L73:
 643  0014 48656c6c6f20  	dc.b	"Hello World!",10
 644  0021 0d00          	dc.b	13,0
 645  0023               L13:
 646  0023 0a0d456e7465  	dc.b	10,13,69,110,116,101
 647  0029 722054657874  	dc.b	"r Text",10
 648  0030 0d00          	dc.b	13,0
 649  0032               L72:
 650  0032 0a0d55415254  	dc.b	10,13,85,65,82,84
 651  0038 31204578616d  	dc.b	"1 Example :retarge"
 652  004a 742074686520  	dc.b	"t the C library pr"
 653  005c 696e74662829  	dc.b	"intf()/getchar() f"
 654  006e 756e6374696f  	dc.b	"unctions to the UA"
 655  0080 52540a        	dc.b	"RT",10
 656  0083 0d00          	dc.b	13,0
 676                     	end
