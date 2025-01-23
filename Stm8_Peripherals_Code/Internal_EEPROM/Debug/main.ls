   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  81                     ; 12 void main(void)
  81                     ; 13 {
  83                     	switch	.text
  84  0000               _main:
  86  0000 5206          	subw	sp,#6
  87       00000006      OFST:	set	6
  90                     ; 15     uint8_t val = 0x00, val_comp = 0x00;
  94                     ; 16     uint32_t add = 0x00;
  96                     ; 17 		clock_setup ();
  98  0002 cd0121        	call	_clock_setup
 100                     ; 18 		UART3_setup ();
 102  0005 cd00f1        	call	_UART3_setup
 104                     ; 19 		TIM4_Config();
 106  0008 cd0000        	call	_TIM4_Config
 108                     ; 21     FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
 110  000b 4f            	clr	a
 111  000c cd0000        	call	_FLASH_SetProgrammingTime
 113                     ; 24     FLASH_Unlock(FLASH_MEMTYPE_DATA);
 115  000f a6f7          	ld	a,#247
 116  0011 cd0000        	call	_FLASH_Unlock
 118                     ; 27     add = 0x4000;
 120  0014 ae4000        	ldw	x,#16384
 121  0017 1f05          	ldw	(OFST-1,sp),x
 122  0019 ae0000        	ldw	x,#0
 123  001c 1f03          	ldw	(OFST-3,sp),x
 125                     ; 28     val = FLASH_ReadByte(add);
 127  001e ae4000        	ldw	x,#16384
 128  0021 89            	pushw	x
 129  0022 ae0000        	ldw	x,#0
 130  0025 89            	pushw	x
 131  0026 cd0000        	call	_FLASH_ReadByte
 133  0029 5b04          	addw	sp,#4
 134  002b 6b02          	ld	(OFST-4,sp),a
 136                     ; 31     val_comp = (uint8_t)(~val);
 138  002d 7b02          	ld	a,(OFST-4,sp)
 139  002f 43            	cpl	a
 140  0030 6b01          	ld	(OFST-5,sp),a
 142                     ; 32     FLASH_ProgramByte((add + 1), val_comp);
 144  0032 7b01          	ld	a,(OFST-5,sp)
 145  0034 88            	push	a
 146  0035 96            	ldw	x,sp
 147  0036 1c0004        	addw	x,#OFST-2
 148  0039 cd0000        	call	c_ltor
 150  003c a601          	ld	a,#1
 151  003e cd0000        	call	c_ladc
 153  0041 be02          	ldw	x,c_lreg+2
 154  0043 89            	pushw	x
 155  0044 be00          	ldw	x,c_lreg
 156  0046 89            	pushw	x
 157  0047 cd0000        	call	_FLASH_ProgramByte
 159  004a 5b05          	addw	sp,#5
 160                     ; 35     val = FLASH_ReadByte((add + 1));
 162  004c 96            	ldw	x,sp
 163  004d 1c0003        	addw	x,#OFST-3
 164  0050 cd0000        	call	c_ltor
 166  0053 a601          	ld	a,#1
 167  0055 cd0000        	call	c_ladc
 169  0058 be02          	ldw	x,c_lreg+2
 170  005a 89            	pushw	x
 171  005b be00          	ldw	x,c_lreg
 172  005d 89            	pushw	x
 173  005e cd0000        	call	_FLASH_ReadByte
 175  0061 5b04          	addw	sp,#4
 176  0063 6b02          	ld	(OFST-4,sp),a
 178                     ; 36     if (val == val_comp)
 180  0065 7b02          	ld	a,(OFST-4,sp)
 181  0067 1101          	cp	a,(OFST-5,sp)
 182  0069 260e          	jrne	L73
 183                     ; 38 			  delay_ms(1000);
 185  006b ae03e8        	ldw	x,#1000
 186  006e cd0000        	call	_delay_ms
 188                     ; 39 				printf("Operation Read and Write Success\n\r");
 190  0071 ae0055        	ldw	x,#L14
 191  0074 cd0000        	call	_printf
 194  0077 200c          	jra	L34
 195  0079               L73:
 196                     ; 43 				delay_ms(1000);
 198  0079 ae03e8        	ldw	x,#1000
 199  007c cd0000        	call	_delay_ms
 201                     ; 44 				printf("Operation Read and Write Failed\n\r");
 203  007f ae0033        	ldw	x,#L54
 204  0082 cd0000        	call	_printf
 206  0085               L34:
 207                     ; 48     FLASH_EraseByte(add);
 209  0085 1e05          	ldw	x,(OFST-1,sp)
 210  0087 89            	pushw	x
 211  0088 1e05          	ldw	x,(OFST-1,sp)
 212  008a 89            	pushw	x
 213  008b cd0000        	call	_FLASH_EraseByte
 215  008e 5b04          	addw	sp,#4
 216                     ; 49     FLASH_EraseByte((add + 1));
 218  0090 96            	ldw	x,sp
 219  0091 1c0003        	addw	x,#OFST-3
 220  0094 cd0000        	call	c_ltor
 222  0097 a601          	ld	a,#1
 223  0099 cd0000        	call	c_ladc
 225  009c be02          	ldw	x,c_lreg+2
 226  009e 89            	pushw	x
 227  009f be00          	ldw	x,c_lreg
 228  00a1 89            	pushw	x
 229  00a2 cd0000        	call	_FLASH_EraseByte
 231  00a5 5b04          	addw	sp,#4
 232                     ; 51     val = FLASH_ReadByte(add);
 234  00a7 1e05          	ldw	x,(OFST-1,sp)
 235  00a9 89            	pushw	x
 236  00aa 1e05          	ldw	x,(OFST-1,sp)
 237  00ac 89            	pushw	x
 238  00ad cd0000        	call	_FLASH_ReadByte
 240  00b0 5b04          	addw	sp,#4
 241  00b2 6b02          	ld	(OFST-4,sp),a
 243                     ; 52     val_comp = FLASH_ReadByte((add + 1));
 245  00b4 96            	ldw	x,sp
 246  00b5 1c0003        	addw	x,#OFST-3
 247  00b8 cd0000        	call	c_ltor
 249  00bb a601          	ld	a,#1
 250  00bd cd0000        	call	c_ladc
 252  00c0 be02          	ldw	x,c_lreg+2
 253  00c2 89            	pushw	x
 254  00c3 be00          	ldw	x,c_lreg
 255  00c5 89            	pushw	x
 256  00c6 cd0000        	call	_FLASH_ReadByte
 258  00c9 5b04          	addw	sp,#4
 259  00cb 6b01          	ld	(OFST-5,sp),a
 261                     ; 53     if ((val != 0x00) & (val_comp != 0x00))
 263  00cd 0d02          	tnz	(OFST-4,sp)
 264  00cf 2712          	jreq	L74
 266  00d1 0d01          	tnz	(OFST-5,sp)
 267  00d3 270e          	jreq	L74
 268                     ; 55 			delay_ms(1000);
 270  00d5 ae03e8        	ldw	x,#1000
 271  00d8 cd0000        	call	_delay_ms
 273                     ; 56 			printf("Operation Erase Failed\n\r");
 275  00db ae001a        	ldw	x,#L15
 276  00de cd0000        	call	_printf
 279  00e1 200c          	jra	L75
 280  00e3               L74:
 281                     ; 60 			delay_ms(1000);
 283  00e3 ae03e8        	ldw	x,#1000
 284  00e6 cd0000        	call	_delay_ms
 286                     ; 61 			printf("Operation Erase Success\n\r");
 288  00e9 ae0000        	ldw	x,#L55
 289  00ec cd0000        	call	_printf
 291  00ef               L75:
 293  00ef 20fe          	jra	L75
 319                     ; 69 void UART3_setup (void)
 319                     ; 70 {
 320                     	switch	.text
 321  00f1               _UART3_setup:
 325                     ; 71   UART3_DeInit ();
 327  00f1 cd0000        	call	_UART3_DeInit
 329                     ; 74   UART3_Init (9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
 329                     ; 75               UART3_MODE_TX_ENABLE);
 331  00f4 4b04          	push	#4
 332  00f6 4b00          	push	#0
 333  00f8 4b00          	push	#0
 334  00fa 4b00          	push	#0
 335  00fc ae2580        	ldw	x,#9600
 336  00ff 89            	pushw	x
 337  0100 ae0000        	ldw	x,#0
 338  0103 89            	pushw	x
 339  0104 cd0000        	call	_UART3_Init
 341  0107 5b08          	addw	sp,#8
 342                     ; 77   UART3_Cmd (ENABLE); // Enable UART1
 344  0109 a601          	ld	a,#1
 345  010b cd0000        	call	_UART3_Cmd
 347                     ; 78 }
 350  010e 81            	ret
 386                     ; 80 PUTCHAR_PROTOTYPE{
 387                     	switch	.text
 388  010f               _putchar:
 390  010f 88            	push	a
 391       00000000      OFST:	set	0
 394                     ; 82   UART3_SendData8 (c);
 396  0110 cd0000        	call	_UART3_SendData8
 399  0113               L311:
 400                     ; 84   while (UART3_GetFlagStatus (UART3_FLAG_TXE) == RESET);
 402  0113 ae0080        	ldw	x,#128
 403  0116 cd0000        	call	_UART3_GetFlagStatus
 405  0119 4d            	tnz	a
 406  011a 27f7          	jreq	L311
 407                     ; 86   return (c);
 409  011c 7b01          	ld	a,(OFST+1,sp)
 412  011e 5b01          	addw	sp,#1
 413  0120 81            	ret
 446                     ; 89 void clock_setup (void)
 446                     ; 90 {
 447                     	switch	.text
 448  0121               _clock_setup:
 452                     ; 91   CLK_DeInit ();
 454  0121 cd0000        	call	_CLK_DeInit
 456                     ; 92   CLK_HSECmd (DISABLE);
 458  0124 4f            	clr	a
 459  0125 cd0000        	call	_CLK_HSECmd
 461                     ; 93   CLK_LSICmd (DISABLE);
 463  0128 4f            	clr	a
 464  0129 cd0000        	call	_CLK_LSICmd
 466                     ; 94   CLK_HSICmd (ENABLE);
 468  012c a601          	ld	a,#1
 469  012e cd0000        	call	_CLK_HSICmd
 472  0131               L131:
 473                     ; 95   while (CLK_GetFlagStatus (CLK_FLAG_HSIRDY) == FALSE);
 475  0131 ae0102        	ldw	x,#258
 476  0134 cd0000        	call	_CLK_GetFlagStatus
 478  0137 4d            	tnz	a
 479  0138 27f7          	jreq	L131
 480                     ; 97   CLK_ClockSwitchCmd (ENABLE);
 482  013a a601          	ld	a,#1
 483  013c cd0000        	call	_CLK_ClockSwitchCmd
 485                     ; 98   CLK_HSIPrescalerConfig (CLK_PRESCALER_HSIDIV1);
 487  013f 4f            	clr	a
 488  0140 cd0000        	call	_CLK_HSIPrescalerConfig
 490                     ; 99   CLK_SYSCLKConfig (CLK_PRESCALER_CPUDIV1);
 492  0143 a680          	ld	a,#128
 493  0145 cd0000        	call	_CLK_SYSCLKConfig
 495                     ; 101   CLK_ClockSwitchConfig (CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
 495                     ; 102                          CLK_CURRENTCLOCKSTATE_ENABLE);
 497  0148 4b01          	push	#1
 498  014a 4b00          	push	#0
 499  014c ae01e1        	ldw	x,#481
 500  014f cd0000        	call	_CLK_ClockSwitchConfig
 502  0152 85            	popw	x
 503                     ; 105   CLK_PeripheralClockConfig (CLK_PERIPHERAL_UART3, ENABLE);
 505  0153 ae0301        	ldw	x,#769
 506  0156 cd0000        	call	_CLK_PeripheralClockConfig
 508                     ; 110 }
 511  0159 81            	ret
 524                     	xdef	_main
 525                     	xdef	_clock_setup
 526                     	xdef	_UART3_setup
 527                     	xref	_delay_ms
 528                     	xref	_TIM4_Config
 529                     	xdef	_putchar
 530                     	xref	_printf
 531                     	xref	_UART3_GetFlagStatus
 532                     	xref	_UART3_SendData8
 533                     	xref	_UART3_Cmd
 534                     	xref	_UART3_Init
 535                     	xref	_UART3_DeInit
 536                     	xref	_FLASH_SetProgrammingTime
 537                     	xref	_FLASH_ReadByte
 538                     	xref	_FLASH_ProgramByte
 539                     	xref	_FLASH_EraseByte
 540                     	xref	_FLASH_Unlock
 541                     	xref	_CLK_GetFlagStatus
 542                     	xref	_CLK_SYSCLKConfig
 543                     	xref	_CLK_HSIPrescalerConfig
 544                     	xref	_CLK_ClockSwitchConfig
 545                     	xref	_CLK_PeripheralClockConfig
 546                     	xref	_CLK_ClockSwitchCmd
 547                     	xref	_CLK_LSICmd
 548                     	xref	_CLK_HSICmd
 549                     	xref	_CLK_HSECmd
 550                     	xref	_CLK_DeInit
 551                     .const:	section	.text
 552  0000               L55:
 553  0000 4f7065726174  	dc.b	"Operation Erase Su"
 554  0012 63636573730a  	dc.b	"ccess",10
 555  0018 0d00          	dc.b	13,0
 556  001a               L15:
 557  001a 4f7065726174  	dc.b	"Operation Erase Fa"
 558  002c 696c65640a    	dc.b	"iled",10
 559  0031 0d00          	dc.b	13,0
 560  0033               L54:
 561  0033 4f7065726174  	dc.b	"Operation Read and"
 562  0045 205772697465  	dc.b	" Write Failed",10
 563  0053 0d00          	dc.b	13,0
 564  0055               L14:
 565  0055 4f7065726174  	dc.b	"Operation Read and"
 566  0067 205772697465  	dc.b	" Write Success",10
 567  0076 0d00          	dc.b	13,0
 568                     	xref.b	c_lreg
 588                     	xref	c_ladc
 589                     	xref	c_ltor
 590                     	end
