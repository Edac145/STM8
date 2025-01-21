   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     .const:	section	.text
  15  0000               L32_time_buf:
  16  0000 00            	dc.b	0
  17  0001 00            	dc.b	0
  18  0002 00            	dc.b	0
  19  0003 00            	dc.b	0
  20  0004 00            	dc.b	0
  21  0005 00            	dc.b	0
  22  0006 00            	dc.b	0
  23  0007               L52_init_time:
  24  0007 00            	dc.b	0
  25  0008 00            	dc.b	0
  26  0009 12            	dc.b	18
  27  000a 01            	dc.b	1
  28  000b 07            	dc.b	7
  29  000c 07            	dc.b	7
  30  000d 23            	dc.b	35
  98                     ; 35 void main (void)
  98                     ; 36 {
 100                     	switch	.text
 101  0000               _main:
 103  0000 5212          	subw	sp,#18
 104       00000012      OFST:	set	18
 107                     ; 37 	unsigned char time_buf[7] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00};
 109  0002 96            	ldw	x,sp
 110  0003 1c000c        	addw	x,#OFST-6
 111  0006 90ae0000      	ldw	y,#L32_time_buf
 112  000a a607          	ld	a,#7
 113  000c cd0000        	call	c_xymov
 115                     ; 39 	unsigned char init_time[7] = {0x00, 0x00, 0x12, 0x01, 0x07, 0x07, 0x23}; 
 117  000f 96            	ldw	x,sp
 118  0010 1c0003        	addw	x,#OFST-15
 119  0013 90ae0007      	ldw	y,#L52_init_time
 120  0017 a607          	ld	a,#7
 121  0019 cd0000        	call	c_xymov
 123                     ; 40 	int i = 0 ;
 125                     ; 41   clock_setup ();
 127  001c cd00c9        	call	_clock_setup
 129                     ; 42   TIM4_Config ();
 131  001f cd0000        	call	_TIM4_Config
 133                     ; 43   UART3_setup ();
 135  0022 ad75          	call	_UART3_setup
 137                     ; 45 	ds1302_init();
 139  0024 cd011f        	call	_ds1302_init
 141                     ; 47 	set_time(init_time);
 143  0027 96            	ldw	x,sp
 144  0028 1c0003        	addw	x,#OFST-15
 145  002b cd025b        	call	_set_time
 147  002e               L36:
 148                     ; 51     read_time(time_buf);
 150  002e 96            	ldw	x,sp
 151  002f 1c000c        	addw	x,#OFST-6
 152  0032 cd02c7        	call	_read_time
 154                     ; 52 		printf("Raw time_buf: ");
 156  0035 ae004a        	ldw	x,#L76
 157  0038 cd0000        	call	_printf
 159                     ; 53     for(i = 0; i < 7; i++) {
 161  003b 5f            	clrw	x
 162  003c 1f0a          	ldw	(OFST-8,sp),x
 164  003e               L17:
 165                     ; 54         printf("%d ", time_buf[i]);
 167  003e 96            	ldw	x,sp
 168  003f 1c000c        	addw	x,#OFST-6
 169  0042 1f01          	ldw	(OFST-17,sp),x
 171  0044 1e0a          	ldw	x,(OFST-8,sp)
 172  0046 72fb01        	addw	x,(OFST-17,sp)
 173  0049 f6            	ld	a,(x)
 174  004a 88            	push	a
 175  004b ae0046        	ldw	x,#L77
 176  004e cd0000        	call	_printf
 178  0051 84            	pop	a
 179                     ; 53     for(i = 0; i < 7; i++) {
 181  0052 1e0a          	ldw	x,(OFST-8,sp)
 182  0054 1c0001        	addw	x,#1
 183  0057 1f0a          	ldw	(OFST-8,sp),x
 187  0059 9c            	rvf
 188  005a 1e0a          	ldw	x,(OFST-8,sp)
 189  005c a30007        	cpw	x,#7
 190  005f 2fdd          	jrslt	L17
 191                     ; 56     printf("\n");
 193  0061 ae0044        	ldw	x,#L101
 194  0064 cd0000        	call	_printf
 196                     ; 58     printf("Time: %02d:%02d:%02d\n", time_buf[2], time_buf[1], time_buf[0]); // hh:mm:ss
 198  0067 7b0c          	ld	a,(OFST-6,sp)
 199  0069 88            	push	a
 200  006a 7b0e          	ld	a,(OFST-4,sp)
 201  006c 88            	push	a
 202  006d 7b10          	ld	a,(OFST-2,sp)
 203  006f 88            	push	a
 204  0070 ae002e        	ldw	x,#L301
 205  0073 cd0000        	call	_printf
 207  0076 5b03          	addw	sp,#3
 208                     ; 59     printf("Date: %02d/%02d/%02d (day: %d)\n", time_buf[5], time_buf[4], (time_buf[6] + 2000), time_buf[3]); // dd/mm/yyyy
 210  0078 7b0f          	ld	a,(OFST-3,sp)
 211  007a 88            	push	a
 212  007b 7b13          	ld	a,(OFST+1,sp)
 213  007d 5f            	clrw	x
 214  007e 97            	ld	xl,a
 215  007f 1c07d0        	addw	x,#2000
 216  0082 89            	pushw	x
 217  0083 7b13          	ld	a,(OFST+1,sp)
 218  0085 88            	push	a
 219  0086 7b15          	ld	a,(OFST+3,sp)
 220  0088 88            	push	a
 221  0089 ae000e        	ldw	x,#L501
 222  008c cd0000        	call	_printf
 224  008f 5b05          	addw	sp,#5
 225                     ; 60 		delay_ms(1000);
 227  0091 ae03e8        	ldw	x,#1000
 228  0094 cd0000        	call	_delay_ms
 231  0097 2095          	jra	L36
 257                     ; 64 void UART3_setup (void)
 257                     ; 65 {
 258                     	switch	.text
 259  0099               _UART3_setup:
 263                     ; 66   UART3_DeInit ();
 265  0099 cd0000        	call	_UART3_DeInit
 267                     ; 69   UART3_Init (9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
 267                     ; 70               UART3_MODE_TX_ENABLE);
 269  009c 4b04          	push	#4
 270  009e 4b00          	push	#0
 271  00a0 4b00          	push	#0
 272  00a2 4b00          	push	#0
 273  00a4 ae2580        	ldw	x,#9600
 274  00a7 89            	pushw	x
 275  00a8 ae0000        	ldw	x,#0
 276  00ab 89            	pushw	x
 277  00ac cd0000        	call	_UART3_Init
 279  00af 5b08          	addw	sp,#8
 280                     ; 72   UART3_Cmd (ENABLE); // Enable UART1
 282  00b1 a601          	ld	a,#1
 283  00b3 cd0000        	call	_UART3_Cmd
 285                     ; 73 }
 288  00b6 81            	ret
 324                     ; 75 PUTCHAR_PROTOTYPE{
 325                     	switch	.text
 326  00b7               _putchar:
 328  00b7 88            	push	a
 329       00000000      OFST:	set	0
 332                     ; 77   UART3_SendData8 (c);
 334  00b8 cd0000        	call	_UART3_SendData8
 337  00bb               L731:
 338                     ; 79   while (UART3_GetFlagStatus (UART3_FLAG_TXE) == RESET);
 340  00bb ae0080        	ldw	x,#128
 341  00be cd0000        	call	_UART3_GetFlagStatus
 343  00c1 4d            	tnz	a
 344  00c2 27f7          	jreq	L731
 345                     ; 81   return (c);
 347  00c4 7b01          	ld	a,(OFST+1,sp)
 350  00c6 5b01          	addw	sp,#1
 351  00c8 81            	ret
 384                     ; 84 void clock_setup (void)
 384                     ; 85 {
 385                     	switch	.text
 386  00c9               _clock_setup:
 390                     ; 86   CLK_DeInit ();
 392  00c9 cd0000        	call	_CLK_DeInit
 394                     ; 87   CLK_HSECmd (DISABLE);
 396  00cc 4f            	clr	a
 397  00cd cd0000        	call	_CLK_HSECmd
 399                     ; 88   CLK_LSICmd (DISABLE);
 401  00d0 4f            	clr	a
 402  00d1 cd0000        	call	_CLK_LSICmd
 404                     ; 89   CLK_HSICmd (ENABLE);
 406  00d4 a601          	ld	a,#1
 407  00d6 cd0000        	call	_CLK_HSICmd
 410  00d9               L551:
 411                     ; 90   while (CLK_GetFlagStatus (CLK_FLAG_HSIRDY) == FALSE);
 413  00d9 ae0102        	ldw	x,#258
 414  00dc cd0000        	call	_CLK_GetFlagStatus
 416  00df 4d            	tnz	a
 417  00e0 27f7          	jreq	L551
 418                     ; 92   CLK_ClockSwitchCmd (ENABLE);
 420  00e2 a601          	ld	a,#1
 421  00e4 cd0000        	call	_CLK_ClockSwitchCmd
 423                     ; 93   CLK_HSIPrescalerConfig (CLK_PRESCALER_HSIDIV1);
 425  00e7 4f            	clr	a
 426  00e8 cd0000        	call	_CLK_HSIPrescalerConfig
 428                     ; 94   CLK_SYSCLKConfig (CLK_PRESCALER_CPUDIV1);
 430  00eb a680          	ld	a,#128
 431  00ed cd0000        	call	_CLK_SYSCLKConfig
 433                     ; 96   CLK_ClockSwitchConfig (CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
 433                     ; 97                          CLK_CURRENTCLOCKSTATE_ENABLE);
 435  00f0 4b01          	push	#1
 436  00f2 4b00          	push	#0
 437  00f4 ae01e1        	ldw	x,#481
 438  00f7 cd0000        	call	_CLK_ClockSwitchConfig
 440  00fa 85            	popw	x
 441                     ; 100   CLK_PeripheralClockConfig (CLK_PERIPHERAL_UART3, ENABLE);
 443  00fb ae0301        	ldw	x,#769
 444  00fe cd0000        	call	_CLK_PeripheralClockConfig
 446                     ; 105 }
 449  0101 81            	ret
 474                     ; 107 void GPIO_setup (void)
 474                     ; 108 {
 475                     	switch	.text
 476  0102               _GPIO_setup:
 480                     ; 109   GPIO_DeInit (GPIOE);
 482  0102 ae5014        	ldw	x,#20500
 483  0105 cd0000        	call	_GPIO_DeInit
 485                     ; 110   GPIO_Init (GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
 487  0108 4bb0          	push	#176
 488  010a 4b02          	push	#2
 489  010c ae5014        	ldw	x,#20500
 490  010f cd0000        	call	_GPIO_Init
 492  0112 85            	popw	x
 493                     ; 111   GPIO_Init (GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
 495  0113 4bb0          	push	#176
 496  0115 4b04          	push	#4
 497  0117 ae5014        	ldw	x,#20500
 498  011a cd0000        	call	_GPIO_Init
 500  011d 85            	popw	x
 501                     ; 112 }
 504  011e 81            	ret
 528                     ; 114 void ds1302_init()
 528                     ; 115 {
 529                     	switch	.text
 530  011f               _ds1302_init:
 534                     ; 116   GPIO_Init(DS1302_DATA_PORT, (GPIO_Pin_TypeDef)(DS1302_DATA), GPIO_MODE_OUT_PP_HIGH_FAST); 
 536  011f 4bf0          	push	#240
 537  0121 4b10          	push	#16
 538  0123 ae500a        	ldw	x,#20490
 539  0126 cd0000        	call	_GPIO_Init
 541  0129 85            	popw	x
 542                     ; 117   GPIO_Init(DS1302_RST_PORT, (GPIO_Pin_TypeDef)(DS1302_RST ), GPIO_MODE_OUT_PP_HIGH_FAST); 
 544  012a 4bf0          	push	#240
 545  012c 4b02          	push	#2
 546  012e ae500a        	ldw	x,#20490
 547  0131 cd0000        	call	_GPIO_Init
 549  0134 85            	popw	x
 550                     ; 118   GPIO_Init(DS1302_SCLK_PORT, (GPIO_Pin_TypeDef)(DS1302_SCLK), GPIO_MODE_OUT_PP_HIGH_FAST); 
 552  0135 4bf0          	push	#240
 553  0137 4b04          	push	#4
 554  0139 ae500a        	ldw	x,#20490
 555  013c cd0000        	call	_GPIO_Init
 557  013f 85            	popw	x
 558                     ; 119 }
 561  0140 81            	ret
 597                     ; 120 static void sclk(char h)
 597                     ; 121 {
 598                     	switch	.text
 599  0141               L3_sclk:
 603                     ; 122   if(h)
 605  0141 4d            	tnz	a
 606  0142 270b          	jreq	L712
 607                     ; 123     GPIO_WriteHigh(DS1302_SCLK_PORT,DS1302_SCLK);
 609  0144 4b04          	push	#4
 610  0146 ae500a        	ldw	x,#20490
 611  0149 cd0000        	call	_GPIO_WriteHigh
 613  014c 84            	pop	a
 615  014d 2009          	jra	L122
 616  014f               L712:
 617                     ; 125     GPIO_WriteLow(DS1302_SCLK_PORT,DS1302_SCLK);
 619  014f 4b04          	push	#4
 620  0151 ae500a        	ldw	x,#20490
 621  0154 cd0000        	call	_GPIO_WriteLow
 623  0157 84            	pop	a
 624  0158               L122:
 625                     ; 126 }
 628  0158 81            	ret
 665                     ; 127 static void data_out(char h)
 665                     ; 128 {
 666                     	switch	.text
 667  0159               L5_data_out:
 669  0159 88            	push	a
 670       00000000      OFST:	set	0
 673                     ; 129   GPIO_Init(DS1302_DATA_PORT,(GPIO_Pin_TypeDef)DS1302_DATA,GPIO_MODE_OUT_PP_HIGH_FAST);
 675  015a 4bf0          	push	#240
 676  015c 4b10          	push	#16
 677  015e ae500a        	ldw	x,#20490
 678  0161 cd0000        	call	_GPIO_Init
 680  0164 85            	popw	x
 681                     ; 130   if(h)
 683  0165 0d01          	tnz	(OFST+1,sp)
 684  0167 270b          	jreq	L142
 685                     ; 131     GPIO_WriteHigh(DS1302_DATA_PORT,DS1302_DATA);
 687  0169 4b10          	push	#16
 688  016b ae500a        	ldw	x,#20490
 689  016e cd0000        	call	_GPIO_WriteHigh
 691  0171 84            	pop	a
 693  0172 2009          	jra	L342
 694  0174               L142:
 695                     ; 133     GPIO_WriteLow(DS1302_DATA_PORT,DS1302_DATA);
 697  0174 4b10          	push	#16
 698  0176 ae500a        	ldw	x,#20490
 699  0179 cd0000        	call	_GPIO_WriteLow
 701  017c 84            	pop	a
 702  017d               L342:
 703                     ; 134 }
 706  017d 84            	pop	a
 707  017e 81            	ret
 753                     ; 135 static BitStatus data_in()
 753                     ; 136 {
 754                     	switch	.text
 755  017f               L7_data_in:
 759                     ; 137   GPIO_Init(DS1302_DATA_PORT, (GPIO_Pin_TypeDef)(DS1302_DATA ), GPIO_MODE_IN_FL_NO_IT);
 761  017f 4b00          	push	#0
 762  0181 4b10          	push	#16
 763  0183 ae500a        	ldw	x,#20490
 764  0186 cd0000        	call	_GPIO_Init
 766  0189 85            	popw	x
 767                     ; 138   return GPIO_ReadInputPin(DS1302_DATA_PORT,(GPIO_Pin_TypeDef)(DS1302_DATA ));
 769  018a 4b10          	push	#16
 770  018c ae500a        	ldw	x,#20490
 771  018f cd0000        	call	_GPIO_ReadInputPin
 773  0192 5b01          	addw	sp,#1
 776  0194 81            	ret
 812                     ; 140 static void rst(char h)
 812                     ; 141 {
 813                     	switch	.text
 814  0195               L11_rst:
 818                     ; 142   if(h)
 820  0195 4d            	tnz	a
 821  0196 270b          	jreq	L303
 822                     ; 143     GPIO_WriteHigh(DS1302_RST_PORT,DS1302_RST);
 824  0198 4b02          	push	#2
 825  019a ae500a        	ldw	x,#20490
 826  019d cd0000        	call	_GPIO_WriteHigh
 828  01a0 84            	pop	a
 830  01a1 2009          	jra	L503
 831  01a3               L303:
 832                     ; 145     GPIO_WriteLow(DS1302_RST_PORT,DS1302_RST);
 834  01a3 4b02          	push	#2
 835  01a5 ae500a        	ldw	x,#20490
 836  01a8 cd0000        	call	_GPIO_WriteLow
 838  01ab 84            	pop	a
 839  01ac               L503:
 840                     ; 146 }
 843  01ac 81            	ret
 889                     ; 147 static void write_byte(unsigned char data)
 889                     ; 148 {
 890                     	switch	.text
 891  01ad               L31_write_byte:
 893  01ad 88            	push	a
 894  01ae 88            	push	a
 895       00000001      OFST:	set	1
 898                     ; 150   for(i = 0;i< 8;i++)
 900  01af 0f01          	clr	(OFST+0,sp)
 902  01b1               L133:
 903                     ; 152     sclk(0);
 905  01b1 4f            	clr	a
 906  01b2 ad8d          	call	L3_sclk
 908                     ; 153     if(data & 0x01)
 910  01b4 7b02          	ld	a,(OFST+1,sp)
 911  01b6 a501          	bcp	a,#1
 912  01b8 2706          	jreq	L733
 913                     ; 154       data_out(1);
 915  01ba a601          	ld	a,#1
 916  01bc ad9b          	call	L5_data_out
 919  01be 2003          	jra	L143
 920  01c0               L733:
 921                     ; 156       data_out(0);
 923  01c0 4f            	clr	a
 924  01c1 ad96          	call	L5_data_out
 926  01c3               L143:
 927                     ; 157     data >>= 1;
 929  01c3 0402          	srl	(OFST+1,sp)
 930                     ; 158     sclk(1);
 932  01c5 a601          	ld	a,#1
 933  01c7 cd0141        	call	L3_sclk
 935                     ; 159 		delay_us(1); // Small delay after each clock pulse
 937  01ca ae0001        	ldw	x,#1
 938  01cd cd0000        	call	_delay_us
 940                     ; 150   for(i = 0;i< 8;i++)
 942  01d0 0c01          	inc	(OFST+0,sp)
 946  01d2 7b01          	ld	a,(OFST+0,sp)
 947  01d4 a108          	cp	a,#8
 948  01d6 25d9          	jrult	L133
 949                     ; 161 }
 952  01d8 85            	popw	x
 953  01d9 81            	ret
1009                     ; 162 static unsigned char read_byte()
1009                     ; 163 {
1010                     	switch	.text
1011  01da               L51_read_byte:
1013  01da 5203          	subw	sp,#3
1014       00000003      OFST:	set	3
1017                     ; 164   unsigned char i,temp = 0;
1019  01dc 0f03          	clr	(OFST+0,sp)
1021                     ; 166   for(i = 0;i< 8;i ++)
1023  01de 0f02          	clr	(OFST-1,sp)
1025  01e0               L173:
1026                     ; 168     temp = temp>>1;
1028  01e0 0403          	srl	(OFST+0,sp)
1030                     ; 169     sclk(0);
1032  01e2 4f            	clr	a
1033  01e3 cd0141        	call	L3_sclk
1035                     ; 170     bit = data_in();
1037  01e6 ad97          	call	L7_data_in
1039  01e8 6b01          	ld	(OFST-2,sp),a
1041                     ; 171     if(bit == RESET)
1043  01ea 0d01          	tnz	(OFST-2,sp)
1044  01ec 2706          	jreq	L104
1046                     ; 177       temp = temp | 0x80;
1048  01ee 7b03          	ld	a,(OFST+0,sp)
1049  01f0 aa80          	or	a,#128
1050  01f2 6b03          	ld	(OFST+0,sp),a
1052  01f4               L104:
1053                     ; 179     sclk(1);
1055  01f4 a601          	ld	a,#1
1056  01f6 cd0141        	call	L3_sclk
1058                     ; 180 		delay_us(1); // Small delay after each clock pulse
1060  01f9 ae0001        	ldw	x,#1
1061  01fc cd0000        	call	_delay_us
1063                     ; 166   for(i = 0;i< 8;i ++)
1065  01ff 0c02          	inc	(OFST-1,sp)
1069  0201 7b02          	ld	a,(OFST-1,sp)
1070  0203 a108          	cp	a,#8
1071  0205 25d9          	jrult	L173
1072                     ; 182   return temp;
1074  0207 7b03          	ld	a,(OFST+0,sp)
1077  0209 5b03          	addw	sp,#3
1078  020b 81            	ret
1125                     ; 184 static void write(unsigned char  addr,unsigned char data)
1125                     ; 185 {
1126                     	switch	.text
1127  020c               L71_write:
1129  020c 89            	pushw	x
1130       00000000      OFST:	set	0
1133                     ; 187   rst(0);
1135  020d 4f            	clr	a
1136  020e ad85          	call	L11_rst
1138                     ; 188   sclk(0);
1140  0210 4f            	clr	a
1141  0211 cd0141        	call	L3_sclk
1143                     ; 189   rst(1);
1145  0214 a601          	ld	a,#1
1146  0216 cd0195        	call	L11_rst
1148                     ; 190   write_byte(addr);
1150  0219 7b01          	ld	a,(OFST+1,sp)
1151  021b ad90          	call	L31_write_byte
1153                     ; 191   write_byte(data);
1155  021d 7b02          	ld	a,(OFST+2,sp)
1156  021f ad8c          	call	L31_write_byte
1158                     ; 192   rst(0);
1160  0221 4f            	clr	a
1161  0222 cd0195        	call	L11_rst
1163                     ; 193   sclk(1);
1165  0225 a601          	ld	a,#1
1166  0227 cd0141        	call	L3_sclk
1168                     ; 194   data_out(1);
1170  022a a601          	ld	a,#1
1171  022c cd0159        	call	L5_data_out
1173                     ; 195 }
1176  022f 85            	popw	x
1177  0230 81            	ret
1225                     ; 196 static unsigned char read(unsigned char addr)
1225                     ; 197 {
1226                     	switch	.text
1227  0231               L12_read:
1229  0231 88            	push	a
1230  0232 88            	push	a
1231       00000001      OFST:	set	1
1234                     ; 198   unsigned char temp = 0;
1236                     ; 200   rst(0);
1238  0233 4f            	clr	a
1239  0234 cd0195        	call	L11_rst
1241                     ; 201   sclk(0);
1243  0237 4f            	clr	a
1244  0238 cd0141        	call	L3_sclk
1246                     ; 202   rst(1);
1248  023b a601          	ld	a,#1
1249  023d cd0195        	call	L11_rst
1251                     ; 203   write_byte(addr);
1253  0240 7b02          	ld	a,(OFST+1,sp)
1254  0242 cd01ad        	call	L31_write_byte
1256                     ; 204   temp = read_byte();
1258  0245 ad93          	call	L51_read_byte
1260  0247 6b01          	ld	(OFST+0,sp),a
1262                     ; 205   rst(0);
1264  0249 4f            	clr	a
1265  024a cd0195        	call	L11_rst
1267                     ; 206   sclk(1);
1269  024d a601          	ld	a,#1
1270  024f cd0141        	call	L3_sclk
1272                     ; 207   data_out(1);
1274  0252 a601          	ld	a,#1
1275  0254 cd0159        	call	L5_data_out
1277                     ; 208   return temp;
1279  0257 7b01          	ld	a,(OFST+0,sp)
1282  0259 85            	popw	x
1283  025a 81            	ret
1346                     ; 210 void set_time(unsigned char time[])
1346                     ; 211 {
1347                     	switch	.text
1348  025b               _set_time:
1350  025b 89            	pushw	x
1351  025c 5204          	subw	sp,#4
1352       00000004      OFST:	set	4
1355                     ; 213   write(0x8e,0);
1357  025e ae8e00        	ldw	x,#36352
1358  0261 ada9          	call	L71_write
1360                     ; 214   for(i = 0,add = 0x80;i<7;i++,add+=2)
1362  0263 0f04          	clr	(OFST+0,sp)
1364  0265 a680          	ld	a,#128
1365  0267 6b03          	ld	(OFST-1,sp),a
1367  0269               L105:
1368                     ; 216     temp = time[i]/10;
1370  0269 7b04          	ld	a,(OFST+0,sp)
1371  026b 5f            	clrw	x
1372  026c 97            	ld	xl,a
1373  026d 72fb05        	addw	x,(OFST+1,sp)
1374  0270 f6            	ld	a,(x)
1375  0271 5f            	clrw	x
1376  0272 97            	ld	xl,a
1377  0273 a60a          	ld	a,#10
1378  0275 62            	div	x,a
1379  0276 9f            	ld	a,xl
1380  0277 6b02          	ld	(OFST-2,sp),a
1382                     ; 217     time[i] = time[i]%10 + temp*16;
1384  0279 7b04          	ld	a,(OFST+0,sp)
1385  027b 5f            	clrw	x
1386  027c 97            	ld	xl,a
1387  027d 72fb05        	addw	x,(OFST+1,sp)
1388  0280 7b02          	ld	a,(OFST-2,sp)
1389  0282 4e            	swap	a
1390  0283 a4f0          	and	a,#240
1391  0285 6b01          	ld	(OFST-3,sp),a
1393  0287 7b04          	ld	a,(OFST+0,sp)
1394  0289 905f          	clrw	y
1395  028b 9097          	ld	yl,a
1396  028d 72f905        	addw	y,(OFST+1,sp)
1397  0290 90f6          	ld	a,(y)
1398  0292 905f          	clrw	y
1399  0294 9097          	ld	yl,a
1400  0296 a60a          	ld	a,#10
1401  0298 9062          	div	y,a
1402  029a 905f          	clrw	y
1403  029c 9097          	ld	yl,a
1404  029e 909f          	ld	a,yl
1405  02a0 1b01          	add	a,(OFST-3,sp)
1406  02a2 f7            	ld	(x),a
1407                     ; 218     write(add,time[i]);
1409  02a3 7b04          	ld	a,(OFST+0,sp)
1410  02a5 5f            	clrw	x
1411  02a6 97            	ld	xl,a
1412  02a7 72fb05        	addw	x,(OFST+1,sp)
1413  02aa f6            	ld	a,(x)
1414  02ab 97            	ld	xl,a
1415  02ac 7b03          	ld	a,(OFST-1,sp)
1416  02ae 95            	ld	xh,a
1417  02af cd020c        	call	L71_write
1419                     ; 214   for(i = 0,add = 0x80;i<7;i++,add+=2)
1421  02b2 0c04          	inc	(OFST+0,sp)
1423  02b4 0c03          	inc	(OFST-1,sp)
1424  02b6 0c03          	inc	(OFST-1,sp)
1428  02b8 7b04          	ld	a,(OFST+0,sp)
1429  02ba a107          	cp	a,#7
1430  02bc 25ab          	jrult	L105
1431                     ; 220   write(0x8e,0x80);
1433  02be ae8e80        	ldw	x,#36480
1434  02c1 cd020c        	call	L71_write
1436                     ; 221 }
1439  02c4 5b06          	addw	sp,#6
1440  02c6 81            	ret
1503                     ; 222 void read_time(unsigned char time[7])
1503                     ; 223 {
1504                     	switch	.text
1505  02c7               _read_time:
1507  02c7 89            	pushw	x
1508  02c8 5204          	subw	sp,#4
1509       00000004      OFST:	set	4
1512                     ; 225   for(i = 0,add = 0x81;i<7;i++,add+=2)
1514  02ca 0f04          	clr	(OFST+0,sp)
1516  02cc a681          	ld	a,#129
1517  02ce 6b02          	ld	(OFST-2,sp),a
1519  02d0               L145:
1520                     ; 227     temp = read(add);
1522  02d0 7b02          	ld	a,(OFST-2,sp)
1523  02d2 cd0231        	call	L12_read
1525  02d5 6b03          	ld	(OFST-1,sp),a
1527                     ; 228     time[i] = (temp>>4)*10+(temp%16);
1529  02d7 7b04          	ld	a,(OFST+0,sp)
1530  02d9 5f            	clrw	x
1531  02da 97            	ld	xl,a
1532  02db 72fb05        	addw	x,(OFST+1,sp)
1533  02de 7b03          	ld	a,(OFST-1,sp)
1534  02e0 a40f          	and	a,#15
1535  02e2 6b01          	ld	(OFST-3,sp),a
1537  02e4 7b03          	ld	a,(OFST-1,sp)
1538  02e6 4e            	swap	a
1539  02e7 a40f          	and	a,#15
1540  02e9 90ae000a      	ldw	y,#10
1541  02ed 9042          	mul	y,a
1542  02ef 909f          	ld	a,yl
1543  02f1 1b01          	add	a,(OFST-3,sp)
1544  02f3 f7            	ld	(x),a
1545                     ; 225   for(i = 0,add = 0x81;i<7;i++,add+=2)
1547  02f4 0c04          	inc	(OFST+0,sp)
1549  02f6 0c02          	inc	(OFST-2,sp)
1550  02f8 0c02          	inc	(OFST-2,sp)
1554  02fa 7b04          	ld	a,(OFST+0,sp)
1555  02fc a107          	cp	a,#7
1556  02fe 25d0          	jrult	L145
1557                     ; 230 }
1560  0300 5b06          	addw	sp,#6
1561  0302 81            	ret
1574                     	xdef	_main
1575                     	xdef	_read_time
1576                     	xdef	_set_time
1577                     	xdef	_ds1302_init
1578                     	xdef	_GPIO_setup
1579                     	xdef	_UART3_setup
1580                     	xdef	_clock_setup
1581                     	xref	_delay_us
1582                     	xref	_delay_ms
1583                     	xref	_TIM4_Config
1584                     	xdef	_putchar
1585                     	xref	_printf
1586                     	xref	_UART3_GetFlagStatus
1587                     	xref	_UART3_SendData8
1588                     	xref	_UART3_Cmd
1589                     	xref	_UART3_Init
1590                     	xref	_UART3_DeInit
1591                     	xref	_GPIO_ReadInputPin
1592                     	xref	_GPIO_WriteLow
1593                     	xref	_GPIO_WriteHigh
1594                     	xref	_GPIO_Init
1595                     	xref	_GPIO_DeInit
1596                     	xref	_CLK_GetFlagStatus
1597                     	xref	_CLK_SYSCLKConfig
1598                     	xref	_CLK_HSIPrescalerConfig
1599                     	xref	_CLK_ClockSwitchConfig
1600                     	xref	_CLK_PeripheralClockConfig
1601                     	xref	_CLK_ClockSwitchCmd
1602                     	xref	_CLK_LSICmd
1603                     	xref	_CLK_HSICmd
1604                     	xref	_CLK_HSECmd
1605                     	xref	_CLK_DeInit
1606                     	switch	.const
1607  000e               L501:
1608  000e 446174653a20  	dc.b	"Date: %02d/%02d/%0"
1609  0020 326420286461  	dc.b	"2d (day: %d)",10,0
1610  002e               L301:
1611  002e 54696d653a20  	dc.b	"Time: %02d:%02d:%0"
1612  0040 32640a00      	dc.b	"2d",10,0
1613  0044               L101:
1614  0044 0a00          	dc.b	10,0
1615  0046               L77:
1616  0046 25642000      	dc.b	"%d ",0
1617  004a               L76:
1618  004a 526177207469  	dc.b	"Raw time_buf: ",0
1619                     	xref.b	c_x
1639                     	xref	c_xymov
1640                     	end
