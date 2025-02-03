   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     .const:	section	.text
  15  0000               L3_receivedString:
  16  0000 00            	dc.b	0
  17  0001 000000000000  	ds.b	31
  18  0020               L5_eepromString:
  19  0020 00            	dc.b	0
  20  0021 000000000000  	ds.b	31
  21  0040               L7_str:
  22  0040 322e33343500  	dc.b	"2.345",0
 111                     ; 19 void main(void)
 111                     ; 20 {
 112                     	switch	.text
 113  0000               f_main:
 115  0000 524a          	subw	sp,#74
 116       0000004a      OFST:	set	74
 119                     ; 21 		float value = 0;
 121                     ; 22 		char receivedString[32] = {0};
 123  0002 96            	ldw	x,sp
 124  0003 1c0007        	addw	x,#OFST-67
 125  0006 90ae0000      	ldw	y,#L3_receivedString
 126  000a a620          	ld	a,#32
 127  000c 8d000000      	callf	d_xymov
 129                     ; 23     char eepromString[32] = {0};
 131  0010 96            	ldw	x,sp
 132  0011 1c0027        	addw	x,#OFST-35
 133  0014 90ae0020      	ldw	y,#L5_eepromString
 134  0018 a620          	ld	a,#32
 135  001a 8d000000      	callf	d_xymov
 137                     ; 24     uint32_t eepromAddress = 0x4000;
 139  001e ae4000        	ldw	x,#16384
 140  0021 1f49          	ldw	(OFST-1,sp),x
 141  0023 ae0000        	ldw	x,#0
 142  0026 1f47          	ldw	(OFST-3,sp),x
 144                     ; 25 		char str[] = "2.345";
 146  0028 96            	ldw	x,sp
 147  0029 1c0001        	addw	x,#OFST-73
 148  002c 90ae0040      	ldw	y,#L7_str
 149  0030 a606          	ld	a,#6
 150  0032 8d000000      	callf	d_xymov
 152                     ; 26 		clock_setup ();
 154  0036 8d6b016b      	callf	f_clock_setup
 156                     ; 27 		UART3_setup ();
 158  003a 8d360136      	callf	f_UART3_setup
 160                     ; 28 		TIM4_Config();
 162  003e 8d000000      	callf	f_TIM4_Config
 164                     ; 33     FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
 166  0042 4f            	clr	a
 167  0043 8d000000      	callf	f_FLASH_SetProgrammingTime
 169                     ; 36     FLASH_Unlock(FLASH_MEMTYPE_DATA);
 171  0047 a6f7          	ld	a,#247
 172  0049 8d000000      	callf	f_FLASH_Unlock
 174                     ; 40 		printf("Enter a string to store in EEPROM:\n\r");
 176  004d ae00bc        	ldw	x,#L55
 177  0050 8d000000      	callf	f_printf
 179                     ; 41     UART3_ReceiveString(receivedString, sizeof(receivedString));
 181  0054 ae0020        	ldw	x,#32
 182  0057 89            	pushw	x
 183  0058 96            	ldw	x,sp
 184  0059 1c0009        	addw	x,#OFST-65
 185  005c 8dbf01bf      	callf	f_UART3_ReceiveString
 187  0060 85            	popw	x
 188                     ; 44     EEPROM_WriteString(eepromAddress, receivedString);
 190  0061 96            	ldw	x,sp
 191  0062 1c0007        	addw	x,#OFST-67
 192  0065 89            	pushw	x
 193  0066 1e4b          	ldw	x,(OFST+1,sp)
 194  0068 89            	pushw	x
 195  0069 1e4b          	ldw	x,(OFST+1,sp)
 196  006b 89            	pushw	x
 197  006c 8d6b026b      	callf	f_EEPROM_WriteString
 199  0070 5b06          	addw	sp,#6
 200                     ; 47     EEPROM_ReadString(eepromAddress, eepromString, sizeof(eepromString));
 202  0072 ae0020        	ldw	x,#32
 203  0075 89            	pushw	x
 204  0076 96            	ldw	x,sp
 205  0077 1c0029        	addw	x,#OFST-33
 206  007a 89            	pushw	x
 207  007b 1e4d          	ldw	x,(OFST+3,sp)
 208  007d 89            	pushw	x
 209  007e 1e4d          	ldw	x,(OFST+3,sp)
 210  0080 89            	pushw	x
 211  0081 8dab02ab      	callf	f_EEPROM_ReadString
 213  0085 5b08          	addw	sp,#8
 214                     ; 50     printf("String read from EEPROM: %s\n\r", eepromString);
 216  0087 96            	ldw	x,sp
 217  0088 1c0027        	addw	x,#OFST-35
 218  008b 89            	pushw	x
 219  008c ae009e        	ldw	x,#L75
 220  008f 8d000000      	callf	f_printf
 222  0093 85            	popw	x
 223                     ; 52 		value = ConvertStringToFloat(eepromString);
 225  0094 96            	ldw	x,sp
 226  0095 1c0027        	addw	x,#OFST-35
 227  0098 8d1b021b      	callf	f_ConvertStringToFloat
 229  009c 96            	ldw	x,sp
 230  009d 1c0047        	addw	x,#OFST-3
 231  00a0 8d000000      	callf	d_rtol
 234                     ; 53     printf("Value: %f\n", value);
 236  00a4 1e49          	ldw	x,(OFST-1,sp)
 237  00a6 89            	pushw	x
 238  00a7 1e49          	ldw	x,(OFST-1,sp)
 239  00a9 89            	pushw	x
 240  00aa ae0093        	ldw	x,#L16
 241  00ad 8d000000      	callf	f_printf
 243  00b1 5b04          	addw	sp,#4
 244  00b3               L36:
 246  00b3 20fe          	jra	L36
 301                     ; 59 void FlashTest(void)
 301                     ; 60 {
 302                     	switch	.text
 303  00b5               f_FlashTest:
 305  00b5 5206          	subw	sp,#6
 306       00000006      OFST:	set	6
 309                     ; 61 	 uint32_t add = 0x00;
 311                     ; 62 	 uint8_t val = 0x00, val_comp = 0x00;
 315                     ; 63 	  add = 0x4000;
 317  00b7 ae4000        	ldw	x,#16384
 318  00ba 1f03          	ldw	(OFST-3,sp),x
 319  00bc ae0000        	ldw	x,#0
 320  00bf 1f01          	ldw	(OFST-5,sp),x
 322                     ; 64 		val = FLASH_ReadByte(add);
 324  00c1 ae4000        	ldw	x,#16384
 325  00c4 89            	pushw	x
 326  00c5 ae0000        	ldw	x,#0
 327  00c8 89            	pushw	x
 328  00c9 8d000000      	callf	f_FLASH_ReadByte
 330  00cd 5b04          	addw	sp,#4
 331  00cf 6b06          	ld	(OFST+0,sp),a
 333                     ; 67     val_comp = (uint8_t)(~val);
 335  00d1 7b06          	ld	a,(OFST+0,sp)
 336  00d3 43            	cpl	a
 337  00d4 6b05          	ld	(OFST-1,sp),a
 339                     ; 68     FLASH_ProgramByte((add + 1), val_comp);
 341  00d6 7b05          	ld	a,(OFST-1,sp)
 342  00d8 88            	push	a
 343  00d9 96            	ldw	x,sp
 344  00da 1c0002        	addw	x,#OFST-4
 345  00dd 8d000000      	callf	d_ltor
 347  00e1 a601          	ld	a,#1
 348  00e3 8d000000      	callf	d_ladc
 350  00e7 be02          	ldw	x,c_lreg+2
 351  00e9 89            	pushw	x
 352  00ea be00          	ldw	x,c_lreg
 353  00ec 89            	pushw	x
 354  00ed 8d000000      	callf	f_FLASH_ProgramByte
 356  00f1 5b05          	addw	sp,#5
 357                     ; 71     val = FLASH_ReadByte((add + 1));
 359  00f3 96            	ldw	x,sp
 360  00f4 1c0001        	addw	x,#OFST-5
 361  00f7 8d000000      	callf	d_ltor
 363  00fb a601          	ld	a,#1
 364  00fd 8d000000      	callf	d_ladc
 366  0101 be02          	ldw	x,c_lreg+2
 367  0103 89            	pushw	x
 368  0104 be00          	ldw	x,c_lreg
 369  0106 89            	pushw	x
 370  0107 8d000000      	callf	f_FLASH_ReadByte
 372  010b 5b04          	addw	sp,#4
 373  010d 6b06          	ld	(OFST+0,sp),a
 375                     ; 72     if (val == val_comp)
 377  010f 7b06          	ld	a,(OFST+0,sp)
 378  0111 1105          	cp	a,(OFST-1,sp)
 379  0113 2610          	jrne	L511
 380                     ; 74 			  delay_ms(1000);
 382  0115 ae03e8        	ldw	x,#1000
 383  0118 8d000000      	callf	f_delay_ms
 385                     ; 75 				printf("Operation Read and Write Success\n\r");
 387  011c ae0070        	ldw	x,#L711
 388  011f 8d000000      	callf	f_printf
 391  0123 200e          	jra	L121
 392  0125               L511:
 393                     ; 79 				delay_ms(1000);
 395  0125 ae03e8        	ldw	x,#1000
 396  0128 8d000000      	callf	f_delay_ms
 398                     ; 80 				printf("Operation Read and Write Failed\n\r");
 400  012c ae004e        	ldw	x,#L321
 401  012f 8d000000      	callf	f_printf
 403  0133               L121:
 404                     ; 100 }
 407  0133 5b06          	addw	sp,#6
 408  0135 87            	retf
 433                     ; 102 void UART3_setup (void)
 433                     ; 103 {
 434                     	switch	.text
 435  0136               f_UART3_setup:
 439                     ; 104   UART3_DeInit ();
 441  0136 8d000000      	callf	f_UART3_DeInit
 443                     ; 107   UART3_Init (9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
 443                     ; 108               UART3_MODE_TXRX_ENABLE);
 445  013a 4b0c          	push	#12
 446  013c 4b00          	push	#0
 447  013e 4b00          	push	#0
 448  0140 4b00          	push	#0
 449  0142 ae2580        	ldw	x,#9600
 450  0145 89            	pushw	x
 451  0146 ae0000        	ldw	x,#0
 452  0149 89            	pushw	x
 453  014a 8d000000      	callf	f_UART3_Init
 455  014e 5b08          	addw	sp,#8
 456                     ; 110   UART3_Cmd (ENABLE); // Enable UART1
 458  0150 a601          	ld	a,#1
 459  0152 8d000000      	callf	f_UART3_Cmd
 461                     ; 111 }
 464  0156 87            	retf
 499                     ; 113 PUTCHAR_PROTOTYPE{
 500                     	switch	.text
 501  0157               f_putchar:
 503  0157 88            	push	a
 504       00000000      OFST:	set	0
 507                     ; 115   UART3_SendData8 (c);
 509  0158 8d000000      	callf	f_UART3_SendData8
 512  015c               L551:
 513                     ; 117   while (UART3_GetFlagStatus (UART3_FLAG_TXE) == RESET);
 515  015c ae0080        	ldw	x,#128
 516  015f 8d000000      	callf	f_UART3_GetFlagStatus
 518  0163 4d            	tnz	a
 519  0164 27f6          	jreq	L551
 520                     ; 119   return (c);
 522  0166 7b01          	ld	a,(OFST+1,sp)
 525  0168 5b01          	addw	sp,#1
 526  016a 87            	retf
 558                     ; 122 void clock_setup (void)
 558                     ; 123 {
 559                     	switch	.text
 560  016b               f_clock_setup:
 564                     ; 124   CLK_DeInit ();
 566  016b 8d000000      	callf	f_CLK_DeInit
 568                     ; 125   CLK_HSECmd (DISABLE);
 570  016f 4f            	clr	a
 571  0170 8d000000      	callf	f_CLK_HSECmd
 573                     ; 126   CLK_LSICmd (DISABLE);
 575  0174 4f            	clr	a
 576  0175 8d000000      	callf	f_CLK_LSICmd
 578                     ; 127   CLK_HSICmd (ENABLE);
 580  0179 a601          	ld	a,#1
 581  017b 8d000000      	callf	f_CLK_HSICmd
 584  017f               L371:
 585                     ; 128   while (CLK_GetFlagStatus (CLK_FLAG_HSIRDY) == FALSE);
 587  017f ae0102        	ldw	x,#258
 588  0182 8d000000      	callf	f_CLK_GetFlagStatus
 590  0186 4d            	tnz	a
 591  0187 27f6          	jreq	L371
 592                     ; 130   CLK_ClockSwitchCmd (ENABLE);
 594  0189 a601          	ld	a,#1
 595  018b 8d000000      	callf	f_CLK_ClockSwitchCmd
 597                     ; 131   CLK_HSIPrescalerConfig (CLK_PRESCALER_HSIDIV1);
 599  018f 4f            	clr	a
 600  0190 8d000000      	callf	f_CLK_HSIPrescalerConfig
 602                     ; 132   CLK_SYSCLKConfig (CLK_PRESCALER_CPUDIV1);
 604  0194 a680          	ld	a,#128
 605  0196 8d000000      	callf	f_CLK_SYSCLKConfig
 607                     ; 134   CLK_ClockSwitchConfig (CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
 607                     ; 135                          CLK_CURRENTCLOCKSTATE_ENABLE);
 609  019a 4b01          	push	#1
 610  019c 4b00          	push	#0
 611  019e ae01e1        	ldw	x,#481
 612  01a1 8d000000      	callf	f_CLK_ClockSwitchConfig
 614  01a5 85            	popw	x
 615                     ; 138   CLK_PeripheralClockConfig (CLK_PERIPHERAL_UART3, ENABLE);
 617  01a6 ae0301        	ldw	x,#769
 618  01a9 8d000000      	callf	f_CLK_PeripheralClockConfig
 620                     ; 143 }
 623  01ad 87            	retf
 647                     ; 145 void UART3_ClearBuffer(void) {
 648                     	switch	.text
 649  01ae               f_UART3_ClearBuffer:
 653  01ae 2004          	jra	L112
 654  01b0               L702:
 655                     ; 147         (void)UART3_ReceiveData8(); // Clear any preexisting data
 657  01b0 8d000000      	callf	f_UART3_ReceiveData8
 659  01b4               L112:
 660                     ; 146     while (UART3_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
 662  01b4 ae0020        	ldw	x,#32
 663  01b7 8d000000      	callf	f_UART3_GetFlagStatus
 665  01bb 4d            	tnz	a
 666  01bc 26f2          	jrne	L702
 667                     ; 149 }
 670  01be 87            	retf
 734                     ; 151 void UART3_ReceiveString(char *buffer, uint16_t max_length) {
 735                     	switch	.text
 736  01bf               f_UART3_ReceiveString:
 738  01bf 89            	pushw	x
 739  01c0 5203          	subw	sp,#3
 740       00000003      OFST:	set	3
 743                     ; 152     uint16_t i = 0;
 745                     ; 155     for (i = 0; i < max_length; i++) {
 747  01c2 5f            	clrw	x
 748  01c3 1f02          	ldw	(OFST-1,sp),x
 751  01c5 200d          	jra	L352
 752  01c7               L742:
 753                     ; 156         buffer[i] = '\0';
 755  01c7 1e04          	ldw	x,(OFST+1,sp)
 756  01c9 72fb02        	addw	x,(OFST-1,sp)
 757  01cc 7f            	clr	(x)
 758                     ; 155     for (i = 0; i < max_length; i++) {
 760  01cd 1e02          	ldw	x,(OFST-1,sp)
 761  01cf 1c0001        	addw	x,#1
 762  01d2 1f02          	ldw	(OFST-1,sp),x
 764  01d4               L352:
 767  01d4 1e02          	ldw	x,(OFST-1,sp)
 768  01d6 1309          	cpw	x,(OFST+6,sp)
 769  01d8 25ed          	jrult	L742
 770                     ; 158     i = 0;
 772  01da 5f            	clrw	x
 773  01db 1f02          	ldw	(OFST-1,sp),x
 776  01dd 202c          	jra	L362
 777  01df               L172:
 778                     ; 162         while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);
 780  01df ae0020        	ldw	x,#32
 781  01e2 8d000000      	callf	f_UART3_GetFlagStatus
 783  01e6 4d            	tnz	a
 784  01e7 27f6          	jreq	L172
 785                     ; 164         receivedChar = UART3_ReceiveData8();
 787  01e9 8d000000      	callf	f_UART3_ReceiveData8
 789  01ed 6b01          	ld	(OFST-2,sp),a
 791                     ; 166         if (receivedChar == '\n' || receivedChar == '\r') {
 793  01ef 7b01          	ld	a,(OFST-2,sp)
 794  01f1 a10a          	cp	a,#10
 795  01f3 271d          	jreq	L562
 797  01f5 7b01          	ld	a,(OFST-2,sp)
 798  01f7 a10d          	cp	a,#13
 799  01f9 2717          	jreq	L562
 800                     ; 170         buffer[i++] = receivedChar;
 802  01fb 7b01          	ld	a,(OFST-2,sp)
 803  01fd 1e02          	ldw	x,(OFST-1,sp)
 804  01ff 1c0001        	addw	x,#1
 805  0202 1f02          	ldw	(OFST-1,sp),x
 806  0204 1d0001        	subw	x,#1
 808  0207 72fb04        	addw	x,(OFST+1,sp)
 809  020a f7            	ld	(x),a
 810  020b               L362:
 811                     ; 161     while (i < max_length - 1) {
 813  020b 1e09          	ldw	x,(OFST+6,sp)
 814  020d 5a            	decw	x
 815  020e 1302          	cpw	x,(OFST-1,sp)
 816  0210 22cd          	jrugt	L172
 817  0212               L562:
 818                     ; 173     buffer[i] = '\0'; // Null-terminate the string
 820  0212 1e04          	ldw	x,(OFST+1,sp)
 821  0214 72fb02        	addw	x,(OFST-1,sp)
 822  0217 7f            	clr	(x)
 823                     ; 174 }
 826  0218 5b05          	addw	sp,#5
 827  021a 87            	retf
 883                     ; 176 float ConvertStringToFloat(char *str) {
 884                     	switch	.text
 885  021b               f_ConvertStringToFloat:
 887  021b 89            	pushw	x
 888  021c 5214          	subw	sp,#20
 889       00000014      OFST:	set	20
 892                     ; 177     float value = 0.0f;
 894  021e ce00e3        	ldw	x,L333+2
 895  0221 1f13          	ldw	(OFST-1,sp),x
 896  0223 ce00e1        	ldw	x,L333
 897  0226 1f11          	ldw	(OFST-3,sp),x
 899                     ; 180     sscanf(str, "%f", &value);
 901  0228 96            	ldw	x,sp
 902  0229 1c0011        	addw	x,#OFST-3
 903  022c 89            	pushw	x
 904  022d ae004b        	ldw	x,#L733
 905  0230 89            	pushw	x
 906  0231 1e19          	ldw	x,(OFST+5,sp)
 907  0233 8d000000      	callf	f_sscanf
 909  0237 5b04          	addw	sp,#4
 910                     ; 183     sprintf(formattedStr, "%.3f", value); // Format float with %.3f
 912  0239 1e13          	ldw	x,(OFST-1,sp)
 913  023b 89            	pushw	x
 914  023c 1e13          	ldw	x,(OFST-1,sp)
 915  023e 89            	pushw	x
 916  023f ae0046        	ldw	x,#L143
 917  0242 89            	pushw	x
 918  0243 96            	ldw	x,sp
 919  0244 1c0007        	addw	x,#OFST-13
 920  0247 8d000000      	callf	f_sprintf
 922  024b 5b06          	addw	sp,#6
 923                     ; 184     sscanf(formattedStr, "%f", &value); // Re-convert to float for uniformity
 925  024d 96            	ldw	x,sp
 926  024e 1c0011        	addw	x,#OFST-3
 927  0251 89            	pushw	x
 928  0252 ae004b        	ldw	x,#L733
 929  0255 89            	pushw	x
 930  0256 96            	ldw	x,sp
 931  0257 1c0005        	addw	x,#OFST-15
 932  025a 8d000000      	callf	f_sscanf
 934  025e 5b04          	addw	sp,#4
 935                     ; 186     return value;
 937  0260 96            	ldw	x,sp
 938  0261 1c0011        	addw	x,#OFST-3
 939  0264 8d000000      	callf	d_ltor
 943  0268 5b16          	addw	sp,#22
 944  026a 87            	retf
 988                     ; 189 void EEPROM_WriteString(uint32_t address, char *str) {
 989                     	switch	.text
 990  026b               f_EEPROM_WriteString:
 992       00000000      OFST:	set	0
 995  026b 202a          	jra	L763
 996  026d               L563:
 997                     ; 191         FLASH_ProgramByte(address++, (uint8_t)(*str++));
 999  026d 1e08          	ldw	x,(OFST+8,sp)
1000  026f 1c0001        	addw	x,#1
1001  0272 1f08          	ldw	(OFST+8,sp),x
1002  0274 1d0001        	subw	x,#1
1003  0277 f6            	ld	a,(x)
1004  0278 88            	push	a
1005  0279 96            	ldw	x,sp
1006  027a 1c0005        	addw	x,#OFST+5
1007  027d 8d000000      	callf	d_ltor
1009  0281 96            	ldw	x,sp
1010  0282 1c0005        	addw	x,#OFST+5
1011  0285 a601          	ld	a,#1
1012  0287 8d000000      	callf	d_lgadc
1014  028b be02          	ldw	x,c_lreg+2
1015  028d 89            	pushw	x
1016  028e be00          	ldw	x,c_lreg
1017  0290 89            	pushw	x
1018  0291 8d000000      	callf	f_FLASH_ProgramByte
1020  0295 5b05          	addw	sp,#5
1021  0297               L763:
1022                     ; 190     while (*str) {
1024  0297 1e08          	ldw	x,(OFST+8,sp)
1025  0299 7d            	tnz	(x)
1026  029a 26d1          	jrne	L563
1027                     ; 193     FLASH_ProgramByte(address, '\0'); // Write a null terminator
1029  029c 4b00          	push	#0
1030  029e 1e07          	ldw	x,(OFST+7,sp)
1031  02a0 89            	pushw	x
1032  02a1 1e07          	ldw	x,(OFST+7,sp)
1033  02a3 89            	pushw	x
1034  02a4 8d000000      	callf	f_FLASH_ProgramByte
1036  02a8 5b05          	addw	sp,#5
1037                     ; 194 }
1040  02aa 87            	retf
1111                     ; 196 void EEPROM_ReadString(uint32_t address, char *buffer, uint16_t max_length) {
1112                     	switch	.text
1113  02ab               f_EEPROM_ReadString:
1115  02ab 5203          	subw	sp,#3
1116       00000003      OFST:	set	3
1119                     ; 197     uint16_t i = 0;
1121  02ad 5f            	clrw	x
1122  02ae 1f01          	ldw	(OFST-2,sp),x
1125  02b0 203d          	jra	L534
1126  02b2               L134:
1127                     ; 201         c = (char)FLASH_ReadByte(address++); // Read a byte
1129  02b2 96            	ldw	x,sp
1130  02b3 1c0007        	addw	x,#OFST+4
1131  02b6 8d000000      	callf	d_ltor
1133  02ba 96            	ldw	x,sp
1134  02bb 1c0007        	addw	x,#OFST+4
1135  02be a601          	ld	a,#1
1136  02c0 8d000000      	callf	d_lgadc
1138  02c4 be02          	ldw	x,c_lreg+2
1139  02c6 89            	pushw	x
1140  02c7 be00          	ldw	x,c_lreg
1141  02c9 89            	pushw	x
1142  02ca 8d000000      	callf	f_FLASH_ReadByte
1144  02ce 5b04          	addw	sp,#4
1145  02d0 6b03          	ld	(OFST+0,sp),a
1147                     ; 202         if (c == '\0') {
1149  02d2 0d03          	tnz	(OFST+0,sp)
1150  02d4 2609          	jrne	L144
1151                     ; 203             break; // Stop if null terminator is encountered
1152  02d6               L734:
1153                     ; 207     buffer[i] = '\0'; // Null-terminate the string
1155  02d6 1e0b          	ldw	x,(OFST+8,sp)
1156  02d8 72fb01        	addw	x,(OFST-2,sp)
1157  02db 7f            	clr	(x)
1158                     ; 208 }
1161  02dc 5b03          	addw	sp,#3
1162  02de 87            	retf
1163  02df               L144:
1164                     ; 205         buffer[i++] = c; // Store the character in the buffer
1166  02df 7b03          	ld	a,(OFST+0,sp)
1167  02e1 1e01          	ldw	x,(OFST-2,sp)
1168  02e3 1c0001        	addw	x,#1
1169  02e6 1f01          	ldw	(OFST-2,sp),x
1170  02e8 1d0001        	subw	x,#1
1172  02eb 72fb0b        	addw	x,(OFST+8,sp)
1173  02ee f7            	ld	(x),a
1174  02ef               L534:
1175                     ; 200     while (i < max_length - 1) {
1177  02ef 1e0d          	ldw	x,(OFST+10,sp)
1178  02f1 5a            	decw	x
1179  02f2 1301          	cpw	x,(OFST-2,sp)
1180  02f4 22bc          	jrugt	L134
1181  02f6 20de          	jra	L734
1226                     ; 210 void ConvertFloatToString(float value, char *str, uint16_t maxLength) {
1227                     	switch	.text
1228  02f8               f_ConvertFloatToString:
1230       00000000      OFST:	set	0
1233                     ; 212     sprintf(str, "%.3f", value);
1235  02f8 1e06          	ldw	x,(OFST+6,sp)
1236  02fa 89            	pushw	x
1237  02fb 1e06          	ldw	x,(OFST+6,sp)
1238  02fd 89            	pushw	x
1239  02fe ae0046        	ldw	x,#L143
1240  0301 89            	pushw	x
1241  0302 1e0e          	ldw	x,(OFST+14,sp)
1242  0304 8d000000      	callf	f_sprintf
1244  0308 5b06          	addw	sp,#6
1245                     ; 213 }
1248  030a 87            	retf
1260                     	xdef	f_main
1261                     	xdef	f_ConvertFloatToString
1262                     	xdef	f_EEPROM_ReadString
1263                     	xdef	f_EEPROM_WriteString
1264                     	xdef	f_UART3_ReceiveString
1265                     	xdef	f_UART3_ClearBuffer
1266                     	xdef	f_FlashTest
1267                     	xdef	f_ConvertStringToFloat
1268                     	xdef	f_clock_setup
1269                     	xdef	f_UART3_setup
1270                     	xref	f_delay_ms
1271                     	xref	f_TIM4_Config
1272                     	xref	f_sprintf
1273                     	xref	f_sscanf
1274                     	xdef	f_putchar
1275                     	xref	f_printf
1276                     	xref	f_UART3_GetFlagStatus
1277                     	xref	f_UART3_SendData8
1278                     	xref	f_UART3_ReceiveData8
1279                     	xref	f_UART3_Cmd
1280                     	xref	f_UART3_Init
1281                     	xref	f_UART3_DeInit
1282                     	xref	f_FLASH_SetProgrammingTime
1283                     	xref	f_FLASH_ReadByte
1284                     	xref	f_FLASH_ProgramByte
1285                     	xref	f_FLASH_Unlock
1286                     	xref	f_CLK_GetFlagStatus
1287                     	xref	f_CLK_SYSCLKConfig
1288                     	xref	f_CLK_HSIPrescalerConfig
1289                     	xref	f_CLK_ClockSwitchConfig
1290                     	xref	f_CLK_PeripheralClockConfig
1291                     	xref	f_CLK_ClockSwitchCmd
1292                     	xref	f_CLK_LSICmd
1293                     	xref	f_CLK_HSICmd
1294                     	xref	f_CLK_HSECmd
1295                     	xref	f_CLK_DeInit
1296                     	switch	.const
1297  0046               L143:
1298  0046 252e336600    	dc.b	"%.3f",0
1299  004b               L733:
1300  004b 256600        	dc.b	"%f",0
1301  004e               L321:
1302  004e 4f7065726174  	dc.b	"Operation Read and"
1303  0060 205772697465  	dc.b	" Write Failed",10
1304  006e 0d00          	dc.b	13,0
1305  0070               L711:
1306  0070 4f7065726174  	dc.b	"Operation Read and"
1307  0082 205772697465  	dc.b	" Write Success",10
1308  0091 0d00          	dc.b	13,0
1309  0093               L16:
1310  0093 56616c75653a  	dc.b	"Value: %f",10,0
1311  009e               L75:
1312  009e 537472696e67  	dc.b	"String read from E"
1313  00b0 4550524f4d3a  	dc.b	"EPROM: %s",10
1314  00ba 0d00          	dc.b	13,0
1315  00bc               L55:
1316  00bc 456e74657220  	dc.b	"Enter a string to "
1317  00ce 73746f726520  	dc.b	"store in EEPROM:",10
1318  00df 0d00          	dc.b	13,0
1319  00e1               L333:
1320  00e1 00000000      	dc.w	0,0
1321                     	xref.b	c_lreg
1322                     	xref.b	c_x
1342                     	xref	d_lgadc
1343                     	xref	d_ladc
1344                     	xref	d_ltor
1345                     	xref	d_rtol
1346                     	xref	d_xymov
1347                     	end
