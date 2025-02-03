   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  42                     ; 50 void SPI_DeInit(void)
  42                     ; 51 {
  43                     	switch	.text
  44  0000               f_SPI_DeInit:
  48                     ; 52   SPI->CR1    = SPI_CR1_RESET_VALUE;
  50  0000 725f5200      	clr	20992
  51                     ; 53   SPI->CR2    = SPI_CR2_RESET_VALUE;
  53  0004 725f5201      	clr	20993
  54                     ; 54   SPI->ICR    = SPI_ICR_RESET_VALUE;
  56  0008 725f5202      	clr	20994
  57                     ; 55   SPI->SR     = SPI_SR_RESET_VALUE;
  59  000c 35025203      	mov	20995,#2
  60                     ; 56   SPI->CRCPR  = SPI_CRCPR_RESET_VALUE;
  62  0010 35075205      	mov	20997,#7
  63                     ; 57 }
  66  0014 87            	retf
 381                     ; 78 void SPI_Init(SPI_FirstBit_TypeDef FirstBit, SPI_BaudRatePrescaler_TypeDef BaudRatePrescaler, SPI_Mode_TypeDef Mode, SPI_ClockPolarity_TypeDef ClockPolarity, SPI_ClockPhase_TypeDef ClockPhase, SPI_DataDirection_TypeDef Data_Direction, SPI_NSS_TypeDef Slave_Management, uint8_t CRCPolynomial)
 381                     ; 79 {
 382                     	switch	.text
 383  0015               f_SPI_Init:
 385  0015 89            	pushw	x
 386  0016 88            	push	a
 387       00000001      OFST:	set	1
 390                     ; 81   assert_param(IS_SPI_FIRSTBIT_OK(FirstBit));
 392                     ; 82   assert_param(IS_SPI_BAUDRATE_PRESCALER_OK(BaudRatePrescaler));
 394                     ; 83   assert_param(IS_SPI_MODE_OK(Mode));
 396                     ; 84   assert_param(IS_SPI_POLARITY_OK(ClockPolarity));
 398                     ; 85   assert_param(IS_SPI_PHASE_OK(ClockPhase));
 400                     ; 86   assert_param(IS_SPI_DATA_DIRECTION_OK(Data_Direction));
 402                     ; 87   assert_param(IS_SPI_SLAVEMANAGEMENT_OK(Slave_Management));
 404                     ; 88   assert_param(IS_SPI_CRC_POLYNOMIAL_OK(CRCPolynomial));
 406                     ; 91   SPI->CR1 = (uint8_t)((uint8_t)((uint8_t)FirstBit | BaudRatePrescaler) |
 406                     ; 92                        (uint8_t)((uint8_t)ClockPolarity | ClockPhase));
 408  0017 7b08          	ld	a,(OFST+7,sp)
 409  0019 1a09          	or	a,(OFST+8,sp)
 410  001b 6b01          	ld	(OFST+0,sp),a
 412  001d 9f            	ld	a,xl
 413  001e 1a02          	or	a,(OFST+1,sp)
 414  0020 1a01          	or	a,(OFST+0,sp)
 415  0022 c75200        	ld	20992,a
 416                     ; 95   SPI->CR2 = (uint8_t)((uint8_t)(Data_Direction) | (uint8_t)(Slave_Management));
 418  0025 7b0a          	ld	a,(OFST+9,sp)
 419  0027 1a0b          	or	a,(OFST+10,sp)
 420  0029 c75201        	ld	20993,a
 421                     ; 97   if (Mode == SPI_MODE_MASTER)
 423  002c 7b07          	ld	a,(OFST+6,sp)
 424  002e a104          	cp	a,#4
 425  0030 2606          	jrne	L302
 426                     ; 99     SPI->CR2 |= (uint8_t)SPI_CR2_SSI;
 428  0032 72105201      	bset	20993,#0
 430  0036 2004          	jra	L502
 431  0038               L302:
 432                     ; 103     SPI->CR2 &= (uint8_t)~(SPI_CR2_SSI);
 434  0038 72115201      	bres	20993,#0
 435  003c               L502:
 436                     ; 107   SPI->CR1 |= (uint8_t)(Mode);
 438  003c c65200        	ld	a,20992
 439  003f 1a07          	or	a,(OFST+6,sp)
 440  0041 c75200        	ld	20992,a
 441                     ; 110   SPI->CRCPR = (uint8_t)CRCPolynomial;
 443  0044 7b0c          	ld	a,(OFST+11,sp)
 444  0046 c75205        	ld	20997,a
 445                     ; 111 }
 448  0049 5b03          	addw	sp,#3
 449  004b 87            	retf
 503                     ; 119 void SPI_Cmd(FunctionalState NewState)
 503                     ; 120 {
 504                     	switch	.text
 505  004c               f_SPI_Cmd:
 509                     ; 122   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 511                     ; 124   if (NewState != DISABLE)
 513  004c 4d            	tnz	a
 514  004d 2706          	jreq	L532
 515                     ; 126     SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
 517  004f 721c5200      	bset	20992,#6
 519  0053 2004          	jra	L732
 520  0055               L532:
 521                     ; 130     SPI->CR1 &= (uint8_t)(~SPI_CR1_SPE); /* Disable the SPI peripheral*/
 523  0055 721d5200      	bres	20992,#6
 524  0059               L732:
 525                     ; 132 }
 528  0059 87            	retf
 636                     ; 141 void SPI_ITConfig(SPI_IT_TypeDef SPI_IT, FunctionalState NewState)
 636                     ; 142 {
 637                     	switch	.text
 638  005a               f_SPI_ITConfig:
 640  005a 89            	pushw	x
 641  005b 88            	push	a
 642       00000001      OFST:	set	1
 645                     ; 143   uint8_t itpos = 0;
 647                     ; 145   assert_param(IS_SPI_CONFIG_IT_OK(SPI_IT));
 649                     ; 146   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 651                     ; 149   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)SPI_IT & (uint8_t)0x0F));
 653  005c 9e            	ld	a,xh
 654  005d a40f          	and	a,#15
 655  005f 5f            	clrw	x
 656  0060 97            	ld	xl,a
 657  0061 a601          	ld	a,#1
 658  0063 5d            	tnzw	x
 659  0064 2704          	jreq	L41
 660  0066               L61:
 661  0066 48            	sll	a
 662  0067 5a            	decw	x
 663  0068 26fc          	jrne	L61
 664  006a               L41:
 665  006a 6b01          	ld	(OFST+0,sp),a
 667                     ; 151   if (NewState != DISABLE)
 669  006c 0d03          	tnz	(OFST+2,sp)
 670  006e 270a          	jreq	L113
 671                     ; 153     SPI->ICR |= itpos; /* Enable interrupt*/
 673  0070 c65202        	ld	a,20994
 674  0073 1a01          	or	a,(OFST+0,sp)
 675  0075 c75202        	ld	20994,a
 677  0078 2009          	jra	L313
 678  007a               L113:
 679                     ; 157     SPI->ICR &= (uint8_t)(~itpos); /* Disable interrupt*/
 681  007a 7b01          	ld	a,(OFST+0,sp)
 682  007c 43            	cpl	a
 683  007d c45202        	and	a,20994
 684  0080 c75202        	ld	20994,a
 685  0083               L313:
 686                     ; 159 }
 689  0083 5b03          	addw	sp,#3
 690  0085 87            	retf
 723                     ; 166 void SPI_SendData(uint8_t Data)
 723                     ; 167 {
 724                     	switch	.text
 725  0086               f_SPI_SendData:
 729                     ; 168   SPI->DR = Data; /* Write in the DR register the data to be sent*/
 731  0086 c75204        	ld	20996,a
 732                     ; 169 }
 735  0089 87            	retf
 757                     ; 176 uint8_t SPI_ReceiveData(void)
 757                     ; 177 {
 758                     	switch	.text
 759  008a               f_SPI_ReceiveData:
 763                     ; 178   return ((uint8_t)SPI->DR); /* Return the data in the DR register*/
 765  008a c65204        	ld	a,20996
 768  008d 87            	retf
 803                     ; 187 void SPI_NSSInternalSoftwareCmd(FunctionalState NewState)
 803                     ; 188 {
 804                     	switch	.text
 805  008e               f_SPI_NSSInternalSoftwareCmd:
 809                     ; 190   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 811                     ; 192   if (NewState != DISABLE)
 813  008e 4d            	tnz	a
 814  008f 2706          	jreq	L163
 815                     ; 194     SPI->CR2 |= SPI_CR2_SSI; /* Set NSS pin internally by software*/
 817  0091 72105201      	bset	20993,#0
 819  0095 2004          	jra	L363
 820  0097               L163:
 821                     ; 198     SPI->CR2 &= (uint8_t)(~SPI_CR2_SSI); /* Reset NSS pin internally by software*/
 823  0097 72115201      	bres	20993,#0
 824  009b               L363:
 825                     ; 200 }
 828  009b 87            	retf
 850                     ; 207 void SPI_TransmitCRC(void)
 850                     ; 208 {
 851                     	switch	.text
 852  009c               f_SPI_TransmitCRC:
 856                     ; 209   SPI->CR2 |= SPI_CR2_CRCNEXT; /* Enable the CRC transmission*/
 858  009c 72185201      	bset	20993,#4
 859                     ; 210 }
 862  00a0 87            	retf
 897                     ; 218 void SPI_CalculateCRCCmd(FunctionalState NewState)
 897                     ; 219 {
 898                     	switch	.text
 899  00a1               f_SPI_CalculateCRCCmd:
 903                     ; 221   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 905                     ; 223   if (NewState != DISABLE)
 907  00a1 4d            	tnz	a
 908  00a2 2706          	jreq	L314
 909                     ; 225     SPI->CR2 |= SPI_CR2_CRCEN; /* Enable the CRC calculation*/
 911  00a4 721a5201      	bset	20993,#5
 913  00a8 2004          	jra	L514
 914  00aa               L314:
 915                     ; 229     SPI->CR2 &= (uint8_t)(~SPI_CR2_CRCEN); /* Disable the CRC calculation*/
 917  00aa 721b5201      	bres	20993,#5
 918  00ae               L514:
 919                     ; 231 }
 922  00ae 87            	retf
 985                     ; 238 uint8_t SPI_GetCRC(SPI_CRC_TypeDef SPI_CRC)
 985                     ; 239 {
 986                     	switch	.text
 987  00af               f_SPI_GetCRC:
 989  00af 88            	push	a
 990       00000001      OFST:	set	1
 993                     ; 240   uint8_t crcreg = 0;
 995                     ; 243   assert_param(IS_SPI_CRC_OK(SPI_CRC));
 997                     ; 245   if (SPI_CRC != SPI_CRC_RX)
 999  00b0 4d            	tnz	a
1000  00b1 2707          	jreq	L154
1001                     ; 247     crcreg = SPI->TXCRCR;  /* Get the Tx CRC register*/
1003  00b3 c65207        	ld	a,20999
1004  00b6 6b01          	ld	(OFST+0,sp),a
1007  00b8 2005          	jra	L354
1008  00ba               L154:
1009                     ; 251     crcreg = SPI->RXCRCR; /* Get the Rx CRC register*/
1011  00ba c65206        	ld	a,20998
1012  00bd 6b01          	ld	(OFST+0,sp),a
1014  00bf               L354:
1015                     ; 255   return crcreg;
1017  00bf 7b01          	ld	a,(OFST+0,sp)
1020  00c1 5b01          	addw	sp,#1
1021  00c3 87            	retf
1045                     ; 263 void SPI_ResetCRC(void)
1045                     ; 264 {
1046                     	switch	.text
1047  00c4               f_SPI_ResetCRC:
1051                     ; 267   SPI_CalculateCRCCmd(ENABLE);
1053  00c4 a601          	ld	a,#1
1054  00c6 8da100a1      	callf	f_SPI_CalculateCRCCmd
1056                     ; 270   SPI_Cmd(ENABLE);
1058  00ca a601          	ld	a,#1
1059  00cc 8d4c004c      	callf	f_SPI_Cmd
1061                     ; 271 }
1064  00d0 87            	retf
1087                     ; 278 uint8_t SPI_GetCRCPolynomial(void)
1087                     ; 279 {
1088                     	switch	.text
1089  00d1               f_SPI_GetCRCPolynomial:
1093                     ; 280   return SPI->CRCPR; /* Return the CRC polynomial register */
1095  00d1 c65205        	ld	a,20997
1098  00d4 87            	retf
1153                     ; 288 void SPI_BiDirectionalLineConfig(SPI_Direction_TypeDef SPI_Direction)
1153                     ; 289 {
1154                     	switch	.text
1155  00d5               f_SPI_BiDirectionalLineConfig:
1159                     ; 291   assert_param(IS_SPI_DIRECTION_OK(SPI_Direction));
1161                     ; 293   if (SPI_Direction != SPI_DIRECTION_RX)
1163  00d5 4d            	tnz	a
1164  00d6 2706          	jreq	L325
1165                     ; 295     SPI->CR2 |= SPI_CR2_BDOE; /* Set the Tx only mode*/
1167  00d8 721c5201      	bset	20993,#6
1169  00dc 2004          	jra	L525
1170  00de               L325:
1171                     ; 299     SPI->CR2 &= (uint8_t)(~SPI_CR2_BDOE); /* Set the Rx only mode*/
1173  00de 721d5201      	bres	20993,#6
1174  00e2               L525:
1175                     ; 301 }
1178  00e2 87            	retf
1298                     ; 311 FlagStatus SPI_GetFlagStatus(SPI_Flag_TypeDef SPI_FLAG)
1298                     ; 312 {
1299                     	switch	.text
1300  00e3               f_SPI_GetFlagStatus:
1302  00e3 88            	push	a
1303       00000001      OFST:	set	1
1306                     ; 313   FlagStatus status = RESET;
1308                     ; 315   assert_param(IS_SPI_FLAGS_OK(SPI_FLAG));
1310                     ; 318   if ((SPI->SR & (uint8_t)SPI_FLAG) != (uint8_t)RESET)
1312  00e4 c45203        	and	a,20995
1313  00e7 2706          	jreq	L306
1314                     ; 320     status = SET; /* SPI_FLAG is set */
1316  00e9 a601          	ld	a,#1
1317  00eb 6b01          	ld	(OFST+0,sp),a
1320  00ed 2002          	jra	L506
1321  00ef               L306:
1322                     ; 324     status = RESET; /* SPI_FLAG is reset*/
1324  00ef 0f01          	clr	(OFST+0,sp)
1326  00f1               L506:
1327                     ; 328   return status;
1329  00f1 7b01          	ld	a,(OFST+0,sp)
1332  00f3 5b01          	addw	sp,#1
1333  00f5 87            	retf
1367                     ; 346 void SPI_ClearFlag(SPI_Flag_TypeDef SPI_FLAG)
1367                     ; 347 {
1368                     	switch	.text
1369  00f6               f_SPI_ClearFlag:
1373                     ; 348   assert_param(IS_SPI_CLEAR_FLAGS_OK(SPI_FLAG));
1375                     ; 350   SPI->SR = (uint8_t)(~SPI_FLAG);
1377  00f6 43            	cpl	a
1378  00f7 c75203        	ld	20995,a
1379                     ; 351 }
1382  00fa 87            	retf
1463                     ; 366 ITStatus SPI_GetITStatus(SPI_IT_TypeDef SPI_IT)
1463                     ; 367 {
1464                     	switch	.text
1465  00fb               f_SPI_GetITStatus:
1467  00fb 88            	push	a
1468  00fc 89            	pushw	x
1469       00000002      OFST:	set	2
1472                     ; 368   ITStatus pendingbitstatus = RESET;
1474                     ; 369   uint8_t itpos = 0;
1476                     ; 370   uint8_t itmask1 = 0;
1478                     ; 371   uint8_t itmask2 = 0;
1480                     ; 372   uint8_t enablestatus = 0;
1482                     ; 373   assert_param(IS_SPI_GET_IT_OK(SPI_IT));
1484                     ; 375   itpos = (uint8_t)((uint8_t)1 << ((uint8_t)SPI_IT & (uint8_t)0x0F));
1486  00fd a40f          	and	a,#15
1487  00ff 5f            	clrw	x
1488  0100 97            	ld	xl,a
1489  0101 a601          	ld	a,#1
1490  0103 5d            	tnzw	x
1491  0104 2704          	jreq	L05
1492  0106               L25:
1493  0106 48            	sll	a
1494  0107 5a            	decw	x
1495  0108 26fc          	jrne	L25
1496  010a               L05:
1497  010a 6b01          	ld	(OFST-1,sp),a
1499                     ; 378   itmask1 = (uint8_t)((uint8_t)SPI_IT >> (uint8_t)4);
1501  010c 7b03          	ld	a,(OFST+1,sp)
1502  010e 4e            	swap	a
1503  010f a40f          	and	a,#15
1504  0111 6b02          	ld	(OFST+0,sp),a
1506                     ; 380   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
1508  0113 7b02          	ld	a,(OFST+0,sp)
1509  0115 5f            	clrw	x
1510  0116 97            	ld	xl,a
1511  0117 a601          	ld	a,#1
1512  0119 5d            	tnzw	x
1513  011a 2704          	jreq	L45
1514  011c               L65:
1515  011c 48            	sll	a
1516  011d 5a            	decw	x
1517  011e 26fc          	jrne	L65
1518  0120               L45:
1519  0120 6b02          	ld	(OFST+0,sp),a
1521                     ; 382   enablestatus = (uint8_t)((uint8_t)SPI->SR & itmask2);
1523  0122 c65203        	ld	a,20995
1524  0125 1402          	and	a,(OFST+0,sp)
1525  0127 6b02          	ld	(OFST+0,sp),a
1527                     ; 384   if (((SPI->ICR & itpos) != RESET) && enablestatus)
1529  0129 c65202        	ld	a,20994
1530  012c 1501          	bcp	a,(OFST-1,sp)
1531  012e 270a          	jreq	L766
1533  0130 0d02          	tnz	(OFST+0,sp)
1534  0132 2706          	jreq	L766
1535                     ; 387     pendingbitstatus = SET;
1537  0134 a601          	ld	a,#1
1538  0136 6b02          	ld	(OFST+0,sp),a
1541  0138 2002          	jra	L176
1542  013a               L766:
1543                     ; 392     pendingbitstatus = RESET;
1545  013a 0f02          	clr	(OFST+0,sp)
1547  013c               L176:
1548                     ; 395   return  pendingbitstatus;
1550  013c 7b02          	ld	a,(OFST+0,sp)
1553  013e 5b03          	addw	sp,#3
1554  0140 87            	retf
1598                     ; 412 void SPI_ClearITPendingBit(SPI_IT_TypeDef SPI_IT)
1598                     ; 413 {
1599                     	switch	.text
1600  0141               f_SPI_ClearITPendingBit:
1602  0141 88            	push	a
1603       00000001      OFST:	set	1
1606                     ; 414   uint8_t itpos = 0;
1608                     ; 415   assert_param(IS_SPI_CLEAR_IT_OK(SPI_IT));
1610                     ; 420   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)(SPI_IT & (uint8_t)0xF0) >> 4));
1612  0142 a4f0          	and	a,#240
1613  0144 4e            	swap	a
1614  0145 a40f          	and	a,#15
1615  0147 5f            	clrw	x
1616  0148 97            	ld	xl,a
1617  0149 a601          	ld	a,#1
1618  014b 5d            	tnzw	x
1619  014c 2704          	jreq	L26
1620  014e               L46:
1621  014e 48            	sll	a
1622  014f 5a            	decw	x
1623  0150 26fc          	jrne	L46
1624  0152               L26:
1625  0152 6b01          	ld	(OFST+0,sp),a
1627                     ; 422   SPI->SR = (uint8_t)(~itpos);
1629  0154 7b01          	ld	a,(OFST+0,sp)
1630  0156 43            	cpl	a
1631  0157 c75203        	ld	20995,a
1632                     ; 424 }
1635  015a 84            	pop	a
1636  015b 87            	retf
1648                     	xdef	f_SPI_ClearITPendingBit
1649                     	xdef	f_SPI_GetITStatus
1650                     	xdef	f_SPI_ClearFlag
1651                     	xdef	f_SPI_GetFlagStatus
1652                     	xdef	f_SPI_BiDirectionalLineConfig
1653                     	xdef	f_SPI_GetCRCPolynomial
1654                     	xdef	f_SPI_ResetCRC
1655                     	xdef	f_SPI_GetCRC
1656                     	xdef	f_SPI_CalculateCRCCmd
1657                     	xdef	f_SPI_TransmitCRC
1658                     	xdef	f_SPI_NSSInternalSoftwareCmd
1659                     	xdef	f_SPI_ReceiveData
1660                     	xdef	f_SPI_SendData
1661                     	xdef	f_SPI_ITConfig
1662                     	xdef	f_SPI_Cmd
1663                     	xdef	f_SPI_Init
1664                     	xdef	f_SPI_DeInit
1683                     	end
