   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _flag_SDHC:
  16  0000 0000          	dc.w	0
  47                     ; 146 void SD_DeInit(void)
  47                     ; 147 {
  48                     	switch	.text
  49  0000               f_SD_DeInit:
  53                     ; 148   SD_LowLevel_DeInit();
  55  0000 8d000000      	callf	f_SD_LowLevel_DeInit
  57                     ; 149 }
  60  0004 87            	retf
 200                     .const:	section	.text
 201  0000               L01:
 202  0000 0000000a      	dc.l	10
 203                     ; 158 SD_Error SD_Init(void)
 203                     ; 159 {
 204                     	switch	.text
 205  0005               f_SD_Init:
 207  0005 5204          	subw	sp,#4
 208       00000004      OFST:	set	4
 211                     ; 160   uint32_t i = 0;
 213                     ; 162   SD_LowLevel_Init();
 215  0007 8d000000      	callf	f_SD_LowLevel_Init
 217                     ; 165   SD_CS_HIGH();
 219  000b 4b01          	push	#1
 220  000d ae5005        	ldw	x,#20485
 221  0010 8d000000      	callf	f_GPIO_WriteHigh
 223  0014 84            	pop	a
 224                     ; 169   for (i = 0; i <= 9; i++)
 226  0015 ae0000        	ldw	x,#0
 227  0018 1f03          	ldw	(OFST-1,sp),x
 228  001a ae0000        	ldw	x,#0
 229  001d 1f01          	ldw	(OFST-3,sp),x
 231  001f               L77:
 232                     ; 172     SD_WriteByte(SD_DUMMY_BYTE);
 234  001f a6ff          	ld	a,#255
 235  0021 8d0e0e0e      	callf	f_SD_WriteByte
 237                     ; 169   for (i = 0; i <= 9; i++)
 239  0025 96            	ldw	x,sp
 240  0026 1c0001        	addw	x,#OFST-3
 241  0029 a601          	ld	a,#1
 242  002b 8d000000      	callf	d_lgadc
 247  002f 96            	ldw	x,sp
 248  0030 1c0001        	addw	x,#OFST-3
 249  0033 8d000000      	callf	d_ltor
 251  0037 ae0000        	ldw	x,#L01
 252  003a 8d000000      	callf	d_lcmp
 254  003e 25df          	jrult	L77
 255                     ; 177   return (SD_GoIdleState());
 257  0040 8d290c29      	callf	f_SD_GoIdleState
 261  0044 5b04          	addw	sp,#4
 262  0046 87            	retf
 296                     ; 185 uint8_t SD_Detect(void)
 296                     ; 186 {
 297                     	switch	.text
 298  0047               f_SD_Detect:
 300  0047 88            	push	a
 301       00000001      OFST:	set	1
 304                     ; 187   __IO uint8_t status = SD_PRESENT;
 306  0048 a601          	ld	a,#1
 307  004a 6b01          	ld	(OFST+0,sp),a
 309                     ; 190   if (GPIO_ReadInputData(SD_DETECT_GPIO_PORT) & SD_DETECT_PIN)
 311  004c ae5005        	ldw	x,#20485
 312  004f 8d000000      	callf	f_GPIO_ReadInputData
 314  0053 a502          	bcp	a,#2
 315  0055 2702          	jreq	L321
 316                     ; 192     status = SD_NOT_PRESENT;
 318  0057 0f01          	clr	(OFST+0,sp)
 320  0059               L321:
 321                     ; 194   return status;
 323  0059 7b01          	ld	a,(OFST+0,sp)
 326  005b 5b01          	addw	sp,#1
 327  005d 87            	retf
 954                     ; 205 SD_Error SD_GetCardInfo(SD_CardInfo *cardinfo)
 954                     ; 206 {
 955                     	switch	.text
 956  005e               f_SD_GetCardInfo:
 958  005e 89            	pushw	x
 959  005f 88            	push	a
 960       00000001      OFST:	set	1
 963                     ; 207   SD_Error status = SD_RESPONSE_FAILURE;
 965                     ; 209   SD_GetCSDRegister(&(cardinfo->SD_csd));
 967  0060 8df604f6      	callf	f_SD_GetCSDRegister
 969                     ; 210   status = SD_GetCIDRegister(&(cardinfo->SD_cid));
 971  0064 1e02          	ldw	x,(OFST+1,sp)
 972  0066 1c0014        	addw	x,#20
 973  0069 8d970897      	callf	f_SD_GetCIDRegister
 975  006d 6b01          	ld	(OFST+0,sp),a
 977                     ; 211   if(flag_SDHC == 1)
 979  006f be00          	ldw	x,_flag_SDHC
 980  0071 a30001        	cpw	x,#1
 981  0074 264a          	jrne	L135
 982                     ; 213     cardinfo->CardBlockSize = 512;
 984  0076 1e02          	ldw	x,(OFST+1,sp)
 985  0078 a600          	ld	a,#0
 986  007a e72d          	ld	(45,x),a
 987  007c a602          	ld	a,#2
 988  007e e72c          	ld	(44,x),a
 989  0080 a600          	ld	a,#0
 990  0082 e72b          	ld	(43,x),a
 991  0084 a600          	ld	a,#0
 992  0086 e72a          	ld	(42,x),a
 993                     ; 214     cardinfo->CardCapacity = (cardinfo->SD_csd.version.v2.DeviceSize + 1) * cardinfo->CardBlockSize;
 995  0088 1602          	ldw	y,(OFST+1,sp)
 996  008a 90e60b        	ld	a,(11,y)
 997  008d b703          	ld	c_lreg+3,a
 998  008f 90e60a        	ld	a,(10,y)
 999  0092 b702          	ld	c_lreg+2,a
1000  0094 90e609        	ld	a,(9,y)
1001  0097 b701          	ld	c_lreg+1,a
1002  0099 90e608        	ld	a,(8,y)
1003  009c b700          	ld	c_lreg,a
1004  009e 3f00          	clr	c_lreg
1005  00a0 b601          	ld	a,c_lreg+1
1006  00a2 a43f          	and	a,#63
1007  00a4 b701          	ld	c_lreg+1,a
1008  00a6 a601          	ld	a,#1
1009  00a8 8d000000      	callf	d_ladc
1011  00ac 1e02          	ldw	x,(OFST+1,sp)
1012  00ae 1c002a        	addw	x,#42
1013  00b1 8d000000      	callf	d_lmul
1015  00b5 1e02          	ldw	x,(OFST+1,sp)
1016  00b7 1c0026        	addw	x,#38
1017  00ba 8d000000      	callf	d_rtol
1020  00be 2078          	jra	L335
1021  00c0               L135:
1022                     ; 218     cardinfo->CardCapacity = (cardinfo->SD_csd.version.v1.DeviceSize + 1) ;
1024  00c0 1602          	ldw	y,(OFST+1,sp)
1025  00c2 93            	ldw	x,y
1026  00c3 ee08          	ldw	x,(8,x)
1027  00c5 01            	rrwa	x,a
1028  00c6 41            	exg	a,xl
1029  00c7 a40f          	and	a,#15
1030  00c9 41            	exg	a,xl
1031  00ca 02            	rlwa	x,a
1032  00cb 5c            	incw	x
1033  00cc 8d000000      	callf	d_itolx
1035  00d0 1e02          	ldw	x,(OFST+1,sp)
1036  00d2 1c0026        	addw	x,#38
1037  00d5 8d000000      	callf	d_rtol
1039                     ; 219     cardinfo->CardCapacity *= (1 << (cardinfo->SD_csd.version.v1.DeviceSizeMul + 2));
1041  00d9 1e02          	ldw	x,(OFST+1,sp)
1042  00db 1602          	ldw	y,(OFST+1,sp)
1043  00dd 90e60c        	ld	a,(12,y)
1044  00e0 a407          	and	a,#7
1045  00e2 ab02          	add	a,#2
1046  00e4 90ae0001      	ldw	y,#1
1047  00e8 4d            	tnz	a
1048  00e9 2705          	jreq	L61
1049  00eb               L02:
1050  00eb 9058          	sllw	y
1051  00ed 4a            	dec	a
1052  00ee 26fb          	jrne	L02
1053  00f0               L61:
1054  00f0 8d000000      	callf	d_itoly
1056  00f4 1c0026        	addw	x,#38
1057  00f7 8d000000      	callf	d_lgmul
1059                     ; 220     cardinfo->CardBlockSize = 1 << (cardinfo->SD_csd.RdBlockLen);
1061  00fb ae0001        	ldw	x,#1
1062  00fe 1602          	ldw	y,(OFST+1,sp)
1063  0100 90e606        	ld	a,(6,y)
1064  0103 a40f          	and	a,#15
1065  0105 4d            	tnz	a
1066  0106 2704          	jreq	L22
1067  0108               L42:
1068  0108 58            	sllw	x
1069  0109 4a            	dec	a
1070  010a 26fc          	jrne	L42
1071  010c               L22:
1072  010c 8d000000      	callf	d_itolx
1074  0110 1e02          	ldw	x,(OFST+1,sp)
1075  0112 1c002a        	addw	x,#42
1076  0115 8d000000      	callf	d_rtol
1078                     ; 221     cardinfo->CardCapacity *= cardinfo->CardBlockSize;
1080  0119 1e02          	ldw	x,(OFST+1,sp)
1081  011b 1602          	ldw	y,(OFST+1,sp)
1082  011d 90e62d        	ld	a,(45,y)
1083  0120 b703          	ld	c_lreg+3,a
1084  0122 90e62c        	ld	a,(44,y)
1085  0125 b702          	ld	c_lreg+2,a
1086  0127 90e62b        	ld	a,(43,y)
1087  012a b701          	ld	c_lreg+1,a
1088  012c 90e62a        	ld	a,(42,y)
1089  012f b700          	ld	c_lreg,a
1090  0131 1c0026        	addw	x,#38
1091  0134 8d000000      	callf	d_lgmul
1093  0138               L335:
1094                     ; 224   return status;
1096  0138 7b01          	ld	a,(OFST+0,sp)
1099  013a 5b03          	addw	sp,#3
1100  013c 87            	retf
1231                     ; 237 SD_Error SD_ReadBlock(uint8_t* pBuffer, uint32_t ReadAddr, uint16_t BlockSize)
1231                     ; 238 {
1232                     	switch	.text
1233  013d               f_SD_ReadBlock:
1235  013d 89            	pushw	x
1236  013e 5213          	subw	sp,#19
1237       00000013      OFST:	set	19
1240                     ; 239   uint32_t i = 0;
1242                     ; 240   SD_Error rvalue = SD_RESPONSE_FAILURE;
1244  0140 a6ff          	ld	a,#255
1245  0142 6b0f          	ld	(OFST-4,sp),a
1247                     ; 243   SD_CS_LOW();
1249  0144 4b01          	push	#1
1250  0146 ae5005        	ldw	x,#20485
1251  0149 8d000000      	callf	f_GPIO_WriteLow
1253  014d 84            	pop	a
1254                     ; 246   response = SD_SendCmd(SD_CMD_READ_SINGLE_BLOCK, ReadAddr/(flag_SDHC == 1 ? BlockSize: 1), 0xFF, SD_ANSWER_R1_EXPECTED);
1256  014e 4b00          	push	#0
1257  0150 4bff          	push	#255
1258  0152 be00          	ldw	x,_flag_SDHC
1259  0154 a30001        	cpw	x,#1
1260  0157 2604          	jrne	L03
1261  0159 1e1f          	ldw	x,(OFST+12,sp)
1262  015b 2003          	jra	L23
1263  015d               L03:
1264  015d ae0001        	ldw	x,#1
1265  0160               L23:
1266  0160 8d000000      	callf	d_uitolx
1268  0164 96            	ldw	x,sp
1269  0165 1c0003        	addw	x,#OFST-16
1270  0168 8d000000      	callf	d_rtol
1273  016c 96            	ldw	x,sp
1274  016d 1c001b        	addw	x,#OFST+8
1275  0170 8d000000      	callf	d_ltor
1277  0174 96            	ldw	x,sp
1278  0175 1c0003        	addw	x,#OFST-16
1279  0178 8d000000      	callf	d_ludv
1281  017c be02          	ldw	x,c_lreg+2
1282  017e 89            	pushw	x
1283  017f be00          	ldw	x,c_lreg
1284  0181 89            	pushw	x
1285  0182 4b11          	push	#17
1286  0184 96            	ldw	x,sp
1287  0185 1c0011        	addw	x,#OFST-2
1288  0188 89            	pushw	x
1289  0189 8d430a43      	callf	L3f_SD_SendCmd
1291  018d 5b09          	addw	sp,#9
1292                     ; 249   if (response.r1 == SD_RESPONSE_NO_ERROR)
1294  018f 0d0a          	tnz	(OFST-9,sp)
1295  0191 2647          	jrne	L516
1296                     ; 252     if (!SD_GetResponse(SD_START_DATA_SINGLE_BLOCK_READ))
1298  0193 a6fe          	ld	a,#254
1299  0195 8da60ba6      	callf	f_SD_GetResponse
1301  0199 4d            	tnz	a
1302  019a 263e          	jrne	L516
1303                     ; 255       for (i = 0; i < BlockSize; i++)
1305  019c ae0000        	ldw	x,#0
1306  019f 1f12          	ldw	(OFST-1,sp),x
1307  01a1 ae0000        	ldw	x,#0
1308  01a4 1f10          	ldw	(OFST-3,sp),x
1311  01a6 2018          	jra	L526
1312  01a8               L126:
1313                     ; 258         *pBuffer = SD_ReadByte();
1315  01a8 8d2e0e2e      	callf	f_SD_ReadByte
1317  01ac 1e14          	ldw	x,(OFST+1,sp)
1318  01ae f7            	ld	(x),a
1319                     ; 261         pBuffer++;
1321  01af 1e14          	ldw	x,(OFST+1,sp)
1322  01b1 1c0001        	addw	x,#1
1323  01b4 1f14          	ldw	(OFST+1,sp),x
1324                     ; 255       for (i = 0; i < BlockSize; i++)
1326  01b6 96            	ldw	x,sp
1327  01b7 1c0010        	addw	x,#OFST-3
1328  01ba a601          	ld	a,#1
1329  01bc 8d000000      	callf	d_lgadc
1332  01c0               L526:
1335  01c0 1e1d          	ldw	x,(OFST+10,sp)
1336  01c2 8d000000      	callf	d_uitolx
1338  01c6 96            	ldw	x,sp
1339  01c7 1c0010        	addw	x,#OFST-3
1340  01ca 8d000000      	callf	d_lcmp
1342  01ce 22d8          	jrugt	L126
1343                     ; 264       SD_ReadByte();
1345  01d0 8d2e0e2e      	callf	f_SD_ReadByte
1347                     ; 265       SD_ReadByte();
1349  01d4 8d2e0e2e      	callf	f_SD_ReadByte
1351                     ; 267       rvalue = SD_RESPONSE_NO_ERROR;
1353  01d8 0f0f          	clr	(OFST-4,sp)
1355  01da               L516:
1356                     ; 271   SD_CS_HIGH();
1358  01da 4b01          	push	#1
1359  01dc ae5005        	ldw	x,#20485
1360  01df 8d000000      	callf	f_GPIO_WriteHigh
1362  01e3 84            	pop	a
1363                     ; 274   SD_WriteByte(SD_DUMMY_BYTE);
1365  01e4 a6ff          	ld	a,#255
1366  01e6 8d0e0e0e      	callf	f_SD_WriteByte
1368                     ; 277   return rvalue;
1370  01ea 7b0f          	ld	a,(OFST-4,sp)
1373  01ec 5b15          	addw	sp,#21
1374  01ee 87            	retf
1481                     ; 291 SD_Error SD_ReadMultiBlocks(uint8_t* pBuffer, uint32_t ReadAddr, uint16_t BlockSize, uint32_t NumberOfBlocks)
1481                     ; 292 {
1482                     	switch	.text
1483  01ef               f_SD_ReadMultiBlocks:
1485  01ef 89            	pushw	x
1486  01f0 5217          	subw	sp,#23
1487       00000017      OFST:	set	23
1490                     ; 293   uint32_t i = 0, Offset = 0;
1494  01f2 ae0000        	ldw	x,#0
1495  01f5 1f11          	ldw	(OFST-6,sp),x
1496  01f7 ae0000        	ldw	x,#0
1497  01fa 1f0f          	ldw	(OFST-8,sp),x
1499                     ; 294   SD_Error rvalue = SD_RESPONSE_FAILURE;
1501  01fc a6ff          	ld	a,#255
1502  01fe 6b13          	ld	(OFST-4,sp),a
1504                     ; 298   SD_CS_LOW();
1506  0200 4b01          	push	#1
1507  0202 ae5005        	ldw	x,#20485
1508  0205 8d000000      	callf	f_GPIO_WriteLow
1510  0209 84            	pop	a
1512  020a acc002c0      	jpf	L507
1513  020e               L307:
1514                     ; 304     response = SD_SendCmd(SD_CMD_READ_SINGLE_BLOCK, (ReadAddr + Offset)/(flag_SDHC == 1 ?BlockSize: 1), 0xFF, SD_ANSWER_R1_EXPECTED);
1516  020e 4b00          	push	#0
1517  0210 4bff          	push	#255
1518  0212 be00          	ldw	x,_flag_SDHC
1519  0214 a30001        	cpw	x,#1
1520  0217 2604          	jrne	L63
1521  0219 1e23          	ldw	x,(OFST+12,sp)
1522  021b 2003          	jra	L04
1523  021d               L63:
1524  021d ae0001        	ldw	x,#1
1525  0220               L04:
1526  0220 8d000000      	callf	d_uitolx
1528  0224 96            	ldw	x,sp
1529  0225 1c0003        	addw	x,#OFST-20
1530  0228 8d000000      	callf	d_rtol
1533  022c 96            	ldw	x,sp
1534  022d 1c001f        	addw	x,#OFST+8
1535  0230 8d000000      	callf	d_ltor
1537  0234 96            	ldw	x,sp
1538  0235 1c0011        	addw	x,#OFST-6
1539  0238 8d000000      	callf	d_ladd
1541  023c 96            	ldw	x,sp
1542  023d 1c0003        	addw	x,#OFST-20
1543  0240 8d000000      	callf	d_ludv
1545  0244 be02          	ldw	x,c_lreg+2
1546  0246 89            	pushw	x
1547  0247 be00          	ldw	x,c_lreg
1548  0249 89            	pushw	x
1549  024a 4b11          	push	#17
1550  024c 96            	ldw	x,sp
1551  024d 1c0011        	addw	x,#OFST-6
1552  0250 89            	pushw	x
1553  0251 8d430a43      	callf	L3f_SD_SendCmd
1555  0255 5b09          	addw	sp,#9
1556                     ; 306     if (response.r1 != SD_RESPONSE_NO_ERROR)
1558  0257 0d0a          	tnz	(OFST-13,sp)
1559  0259 2706          	jreq	L117
1560                     ; 308       return  SD_RESPONSE_FAILURE;
1562  025b a6ff          	ld	a,#255
1564  025d acee02ee      	jpf	L24
1565  0261               L117:
1566                     ; 311     if (!SD_GetResponse(SD_START_DATA_SINGLE_BLOCK_READ))
1568  0261 a6fe          	ld	a,#254
1569  0263 8da60ba6      	callf	f_SD_GetResponse
1571  0267 4d            	tnz	a
1572  0268 2652          	jrne	L317
1573                     ; 314       for (i = 0; i < BlockSize; i++)
1575  026a ae0000        	ldw	x,#0
1576  026d 1f16          	ldw	(OFST-1,sp),x
1577  026f ae0000        	ldw	x,#0
1578  0272 1f14          	ldw	(OFST-3,sp),x
1581  0274 2018          	jra	L127
1582  0276               L517:
1583                     ; 317         *pBuffer = SD_ReadByte();
1585  0276 8d2e0e2e      	callf	f_SD_ReadByte
1587  027a 1e18          	ldw	x,(OFST+1,sp)
1588  027c f7            	ld	(x),a
1589                     ; 319         pBuffer++;
1591  027d 1e18          	ldw	x,(OFST+1,sp)
1592  027f 1c0001        	addw	x,#1
1593  0282 1f18          	ldw	(OFST+1,sp),x
1594                     ; 314       for (i = 0; i < BlockSize; i++)
1596  0284 96            	ldw	x,sp
1597  0285 1c0014        	addw	x,#OFST-3
1598  0288 a601          	ld	a,#1
1599  028a 8d000000      	callf	d_lgadc
1602  028e               L127:
1605  028e 1e21          	ldw	x,(OFST+10,sp)
1606  0290 8d000000      	callf	d_uitolx
1608  0294 96            	ldw	x,sp
1609  0295 1c0014        	addw	x,#OFST-3
1610  0298 8d000000      	callf	d_lcmp
1612  029c 22d8          	jrugt	L517
1613                     ; 322       Offset += 512;
1615  029e ae0200        	ldw	x,#512
1616  02a1 bf02          	ldw	c_lreg+2,x
1617  02a3 ae0000        	ldw	x,#0
1618  02a6 bf00          	ldw	c_lreg,x
1619  02a8 96            	ldw	x,sp
1620  02a9 1c000f        	addw	x,#OFST-8
1621  02ac 8d000000      	callf	d_lgadd
1624                     ; 324       SD_ReadByte();
1626  02b0 8d2e0e2e      	callf	f_SD_ReadByte
1628                     ; 325       SD_ReadByte();
1630  02b4 8d2e0e2e      	callf	f_SD_ReadByte
1632                     ; 327       rvalue = SD_RESPONSE_NO_ERROR;
1634  02b8 0f13          	clr	(OFST-4,sp)
1637  02ba 2004          	jra	L507
1638  02bc               L317:
1639                     ; 332       rvalue = SD_RESPONSE_FAILURE;
1641  02bc a6ff          	ld	a,#255
1642  02be 6b13          	ld	(OFST-4,sp),a
1644  02c0               L507:
1645                     ; 301   while (NumberOfBlocks--)
1647  02c0 96            	ldw	x,sp
1648  02c1 1c0023        	addw	x,#OFST+12
1649  02c4 8d000000      	callf	d_ltor
1651  02c8 96            	ldw	x,sp
1652  02c9 1c0023        	addw	x,#OFST+12
1653  02cc a601          	ld	a,#1
1654  02ce 8d000000      	callf	d_lgsbc
1656  02d2 8d000000      	callf	d_lrzmp
1658  02d6 2704          	jreq	L44
1659  02d8 ac0e020e      	jpf	L307
1660  02dc               L44:
1661                     ; 336   SD_CS_HIGH();
1663  02dc 4b01          	push	#1
1664  02de ae5005        	ldw	x,#20485
1665  02e1 8d000000      	callf	f_GPIO_WriteHigh
1667  02e5 84            	pop	a
1668                     ; 338   SD_WriteByte(SD_DUMMY_BYTE);
1670  02e6 a6ff          	ld	a,#255
1671  02e8 8d0e0e0e      	callf	f_SD_WriteByte
1673                     ; 340   return rvalue;
1675  02ec 7b13          	ld	a,(OFST-4,sp)
1677  02ee               L24:
1679  02ee 5b19          	addw	sp,#25
1680  02f0 87            	retf
1769                     ; 353 SD_Error SD_WriteBlock(uint8_t* pBuffer, uint32_t WriteAddr, uint16_t BlockSize)
1769                     ; 354 {
1770                     	switch	.text
1771  02f1               f_SD_WriteBlock:
1773  02f1 89            	pushw	x
1774  02f2 5213          	subw	sp,#19
1775       00000013      OFST:	set	19
1778                     ; 355   uint32_t i = 0;
1780                     ; 356   SD_Error rvalue = SD_RESPONSE_FAILURE;
1782  02f4 a6ff          	ld	a,#255
1783  02f6 6b0f          	ld	(OFST-4,sp),a
1785                     ; 360   SD_CS_LOW();
1787  02f8 4b01          	push	#1
1788  02fa ae5005        	ldw	x,#20485
1789  02fd 8d000000      	callf	f_GPIO_WriteLow
1791  0301 84            	pop	a
1792                     ; 363   response = SD_SendCmd(SD_CMD_WRITE_SINGLE_BLOCK, WriteAddr/(flag_SDHC == 1 ? BlockSize: 1), 0xFF, SD_ANSWER_R1_EXPECTED);
1794  0302 4b00          	push	#0
1795  0304 4bff          	push	#255
1796  0306 be00          	ldw	x,_flag_SDHC
1797  0308 a30001        	cpw	x,#1
1798  030b 2604          	jrne	L05
1799  030d 1e1f          	ldw	x,(OFST+12,sp)
1800  030f 2003          	jra	L25
1801  0311               L05:
1802  0311 ae0001        	ldw	x,#1
1803  0314               L25:
1804  0314 8d000000      	callf	d_uitolx
1806  0318 96            	ldw	x,sp
1807  0319 1c0003        	addw	x,#OFST-16
1808  031c 8d000000      	callf	d_rtol
1811  0320 96            	ldw	x,sp
1812  0321 1c001b        	addw	x,#OFST+8
1813  0324 8d000000      	callf	d_ltor
1815  0328 96            	ldw	x,sp
1816  0329 1c0003        	addw	x,#OFST-16
1817  032c 8d000000      	callf	d_ludv
1819  0330 be02          	ldw	x,c_lreg+2
1820  0332 89            	pushw	x
1821  0333 be00          	ldw	x,c_lreg
1822  0335 89            	pushw	x
1823  0336 4b18          	push	#24
1824  0338 96            	ldw	x,sp
1825  0339 1c0011        	addw	x,#OFST-2
1826  033c 89            	pushw	x
1827  033d 8d430a43      	callf	L3f_SD_SendCmd
1829  0341 5b09          	addw	sp,#9
1830                     ; 366   if (response.r1 == SD_RESPONSE_NO_ERROR)
1832  0343 0d0a          	tnz	(OFST-9,sp)
1833  0345 2652          	jrne	L177
1834                     ; 369     SD_WriteByte(SD_DUMMY_BYTE);
1836  0347 a6ff          	ld	a,#255
1837  0349 8d0e0e0e      	callf	f_SD_WriteByte
1839                     ; 372     SD_WriteByte(0xFE);
1841  034d a6fe          	ld	a,#254
1842  034f 8d0e0e0e      	callf	f_SD_WriteByte
1844                     ; 375     for (i = 0; i < BlockSize; i++)
1846  0353 ae0000        	ldw	x,#0
1847  0356 1f12          	ldw	(OFST-1,sp),x
1848  0358 ae0000        	ldw	x,#0
1849  035b 1f10          	ldw	(OFST-3,sp),x
1852  035d 2018          	jra	L777
1853  035f               L377:
1854                     ; 378       SD_WriteByte(*pBuffer);
1856  035f 1e14          	ldw	x,(OFST+1,sp)
1857  0361 f6            	ld	a,(x)
1858  0362 8d0e0e0e      	callf	f_SD_WriteByte
1860                     ; 380       pBuffer++;
1862  0366 1e14          	ldw	x,(OFST+1,sp)
1863  0368 1c0001        	addw	x,#1
1864  036b 1f14          	ldw	(OFST+1,sp),x
1865                     ; 375     for (i = 0; i < BlockSize; i++)
1867  036d 96            	ldw	x,sp
1868  036e 1c0010        	addw	x,#OFST-3
1869  0371 a601          	ld	a,#1
1870  0373 8d000000      	callf	d_lgadc
1873  0377               L777:
1876  0377 1e1d          	ldw	x,(OFST+10,sp)
1877  0379 8d000000      	callf	d_uitolx
1879  037d 96            	ldw	x,sp
1880  037e 1c0010        	addw	x,#OFST-3
1881  0381 8d000000      	callf	d_lcmp
1883  0385 22d8          	jrugt	L377
1884                     ; 383     SD_ReadByte();
1886  0387 8d2e0e2e      	callf	f_SD_ReadByte
1888                     ; 384     SD_ReadByte();
1890  038b 8d2e0e2e      	callf	f_SD_ReadByte
1892                     ; 386     if (SD_GetDataResponse() == SD_DATA_OK)
1894  038f 8d3b0b3b      	callf	f_SD_GetDataResponse
1896  0393 a105          	cp	a,#5
1897  0395 2602          	jrne	L177
1898                     ; 388       rvalue = SD_RESPONSE_NO_ERROR;
1900  0397 0f0f          	clr	(OFST-4,sp)
1902  0399               L177:
1903                     ; 392   SD_CS_HIGH();
1905  0399 4b01          	push	#1
1906  039b ae5005        	ldw	x,#20485
1907  039e 8d000000      	callf	f_GPIO_WriteHigh
1909  03a2 84            	pop	a
1910                     ; 394   SD_WriteByte(SD_DUMMY_BYTE);
1912  03a3 a6ff          	ld	a,#255
1913  03a5 8d0e0e0e      	callf	f_SD_WriteByte
1915                     ; 397   return rvalue;
1917  03a9 7b0f          	ld	a,(OFST-4,sp)
1920  03ab 5b15          	addw	sp,#21
1921  03ad 87            	retf
2029                     ; 411 SD_Error SD_WriteMultiBlocks(uint8_t* pBuffer, uint32_t WriteAddr, uint16_t BlockSize, uint32_t NumberOfBlocks)
2029                     ; 412 {
2030                     	switch	.text
2031  03ae               f_SD_WriteMultiBlocks:
2033  03ae 89            	pushw	x
2034  03af 5217          	subw	sp,#23
2035       00000017      OFST:	set	23
2038                     ; 413   uint32_t i = 0, Offset = 0;
2042  03b1 ae0000        	ldw	x,#0
2043  03b4 1f0c          	ldw	(OFST-11,sp),x
2044  03b6 ae0000        	ldw	x,#0
2045  03b9 1f0a          	ldw	(OFST-13,sp),x
2047                     ; 414   SD_Error rvalue = SD_RESPONSE_FAILURE;
2049  03bb a6ff          	ld	a,#255
2050  03bd 6b0e          	ld	(OFST-9,sp),a
2052                     ; 417   SD_CS_LOW();
2054  03bf 4b01          	push	#1
2055  03c1 ae5005        	ldw	x,#20485
2056  03c4 8d000000      	callf	f_GPIO_WriteLow
2058  03c8 84            	pop	a
2059                     ; 419   response = SD_SendCmd(SD_CMD_SET_BLOCKLEN, BlockSize, 0xFF, SD_ANSWER_R1_EXPECTED);
2061  03c9 4b00          	push	#0
2062  03cb 4bff          	push	#255
2063  03cd 1e23          	ldw	x,(OFST+12,sp)
2064  03cf 8d000000      	callf	d_uitolx
2066  03d3 be02          	ldw	x,c_lreg+2
2067  03d5 89            	pushw	x
2068  03d6 be00          	ldw	x,c_lreg
2069  03d8 89            	pushw	x
2070  03d9 4b10          	push	#16
2071  03db 96            	ldw	x,sp
2072  03dc 1c0016        	addw	x,#OFST-1
2073  03df 89            	pushw	x
2074  03e0 8d430a43      	callf	L3f_SD_SendCmd
2076  03e4 5b09          	addw	sp,#9
2077                     ; 421   SD_CS_HIGH();
2079  03e6 4b01          	push	#1
2080  03e8 ae5005        	ldw	x,#20485
2081  03eb 8d000000      	callf	f_GPIO_WriteHigh
2083  03ef 84            	pop	a
2084                     ; 423   SD_WriteByte(SD_DUMMY_BYTE);
2086  03f0 a6ff          	ld	a,#255
2087  03f2 8d0e0e0e      	callf	f_SD_WriteByte
2089                     ; 425   if ( response.r1 != SD_RESPONSE_NO_ERROR)
2091  03f6 0d0f          	tnz	(OFST-8,sp)
2092  03f8 2604          	jrne	L46
2093  03fa acc404c4      	jpf	L3601
2094  03fe               L46:
2095                     ; 427     return SD_RESPONSE_FAILURE;
2097  03fe a6ff          	ld	a,#255
2099  0400 204f          	jra	L26
2100  0402               L1601:
2101                     ; 434     response = SD_SendCmd(SD_CMD_WRITE_SINGLE_BLOCK, (WriteAddr + Offset)/(flag_SDHC == 1 ? BlockSize: 1), 0xFF, SD_ANSWER_R1_EXPECTED);
2103  0402 4b00          	push	#0
2104  0404 4bff          	push	#255
2105  0406 be00          	ldw	x,_flag_SDHC
2106  0408 a30001        	cpw	x,#1
2107  040b 2604          	jrne	L65
2108  040d 1e23          	ldw	x,(OFST+12,sp)
2109  040f 2003          	jra	L06
2110  0411               L65:
2111  0411 ae0001        	ldw	x,#1
2112  0414               L06:
2113  0414 8d000000      	callf	d_uitolx
2115  0418 96            	ldw	x,sp
2116  0419 1c0003        	addw	x,#OFST-20
2117  041c 8d000000      	callf	d_rtol
2120  0420 96            	ldw	x,sp
2121  0421 1c001f        	addw	x,#OFST+8
2122  0424 8d000000      	callf	d_ltor
2124  0428 96            	ldw	x,sp
2125  0429 1c000c        	addw	x,#OFST-11
2126  042c 8d000000      	callf	d_ladd
2128  0430 96            	ldw	x,sp
2129  0431 1c0003        	addw	x,#OFST-20
2130  0434 8d000000      	callf	d_ludv
2132  0438 be02          	ldw	x,c_lreg+2
2133  043a 89            	pushw	x
2134  043b be00          	ldw	x,c_lreg
2135  043d 89            	pushw	x
2136  043e 4b18          	push	#24
2137  0440 96            	ldw	x,sp
2138  0441 1c0016        	addw	x,#OFST-1
2139  0444 89            	pushw	x
2140  0445 8d430a43      	callf	L3f_SD_SendCmd
2142  0449 5b09          	addw	sp,#9
2143                     ; 436     if (response.r1 != SD_RESPONSE_NO_ERROR)
2145  044b 0d0f          	tnz	(OFST-8,sp)
2146  044d 2705          	jreq	L7601
2147                     ; 438       return  SD_RESPONSE_FAILURE;
2149  044f a6ff          	ld	a,#255
2151  0451               L26:
2153  0451 5b19          	addw	sp,#25
2154  0453 87            	retf
2155  0454               L7601:
2156                     ; 441     SD_WriteByte(SD_DUMMY_BYTE);
2158  0454 a6ff          	ld	a,#255
2159  0456 8d0e0e0e      	callf	f_SD_WriteByte
2161                     ; 442     SD_WriteByte(SD_DUMMY_BYTE);
2163  045a a6ff          	ld	a,#255
2164  045c 8d0e0e0e      	callf	f_SD_WriteByte
2166                     ; 444     SD_WriteByte(SD_START_DATA_SINGLE_BLOCK_WRITE);
2168  0460 a6fe          	ld	a,#254
2169  0462 8d0e0e0e      	callf	f_SD_WriteByte
2171                     ; 446     for (i = 0; i < BlockSize; i++)
2173  0466 ae0000        	ldw	x,#0
2174  0469 1f16          	ldw	(OFST-1,sp),x
2175  046b ae0000        	ldw	x,#0
2176  046e 1f14          	ldw	(OFST-3,sp),x
2179  0470 2018          	jra	L5701
2180  0472               L1701:
2181                     ; 449       SD_WriteByte(*pBuffer);
2183  0472 1e18          	ldw	x,(OFST+1,sp)
2184  0474 f6            	ld	a,(x)
2185  0475 8d0e0e0e      	callf	f_SD_WriteByte
2187                     ; 451       pBuffer++;
2189  0479 1e18          	ldw	x,(OFST+1,sp)
2190  047b 1c0001        	addw	x,#1
2191  047e 1f18          	ldw	(OFST+1,sp),x
2192                     ; 446     for (i = 0; i < BlockSize; i++)
2194  0480 96            	ldw	x,sp
2195  0481 1c0014        	addw	x,#OFST-3
2196  0484 a601          	ld	a,#1
2197  0486 8d000000      	callf	d_lgadc
2200  048a               L5701:
2203  048a 1e21          	ldw	x,(OFST+10,sp)
2204  048c 8d000000      	callf	d_uitolx
2206  0490 96            	ldw	x,sp
2207  0491 1c0014        	addw	x,#OFST-3
2208  0494 8d000000      	callf	d_lcmp
2210  0498 22d8          	jrugt	L1701
2211                     ; 454     Offset += 512;
2213  049a ae0200        	ldw	x,#512
2214  049d bf02          	ldw	c_lreg+2,x
2215  049f ae0000        	ldw	x,#0
2216  04a2 bf00          	ldw	c_lreg,x
2217  04a4 96            	ldw	x,sp
2218  04a5 1c000a        	addw	x,#OFST-13
2219  04a8 8d000000      	callf	d_lgadd
2222                     ; 456     SD_ReadByte();
2224  04ac 8d2e0e2e      	callf	f_SD_ReadByte
2226                     ; 457     SD_ReadByte();
2228  04b0 8d2e0e2e      	callf	f_SD_ReadByte
2230                     ; 459     if (SD_GetDataResponse() == SD_DATA_OK)
2232  04b4 8d3b0b3b      	callf	f_SD_GetDataResponse
2234  04b8 a105          	cp	a,#5
2235  04ba 2604          	jrne	L1011
2236                     ; 462       rvalue = SD_RESPONSE_NO_ERROR;
2238  04bc 0f0e          	clr	(OFST-9,sp)
2241  04be 2004          	jra	L3601
2242  04c0               L1011:
2243                     ; 467       rvalue = SD_RESPONSE_FAILURE;
2245  04c0 a6ff          	ld	a,#255
2246  04c2 6b0e          	ld	(OFST-9,sp),a
2248  04c4               L3601:
2249                     ; 431   while (NumberOfBlocks--)
2251  04c4 96            	ldw	x,sp
2252  04c5 1c0023        	addw	x,#OFST+12
2253  04c8 8d000000      	callf	d_ltor
2255  04cc 96            	ldw	x,sp
2256  04cd 1c0023        	addw	x,#OFST+12
2257  04d0 a601          	ld	a,#1
2258  04d2 8d000000      	callf	d_lgsbc
2260  04d6 8d000000      	callf	d_lrzmp
2262  04da 2704          	jreq	L66
2263  04dc ac020402      	jpf	L1601
2264  04e0               L66:
2265                     ; 471   SD_CS_HIGH();
2267  04e0 4b01          	push	#1
2268  04e2 ae5005        	ldw	x,#20485
2269  04e5 8d000000      	callf	f_GPIO_WriteHigh
2271  04e9 84            	pop	a
2272                     ; 473   SD_WriteByte(SD_DUMMY_BYTE);
2274  04ea a6ff          	ld	a,#255
2275  04ec 8d0e0e0e      	callf	f_SD_WriteByte
2277                     ; 475   return rvalue;
2279  04f0 7b0e          	ld	a,(OFST-9,sp)
2281  04f2 ac510451      	jpf	L26
2364                     	switch	.const
2365  0004               L27:
2366  0004 00000010      	dc.l	16
2367                     ; 487 SD_Error SD_GetCSDRegister(SD_CSD* SD_csd)
2367                     ; 488 {
2368                     	switch	.text
2369  04f6               f_SD_GetCSDRegister:
2371  04f6 89            	pushw	x
2372  04f7 5222          	subw	sp,#34
2373       00000022      OFST:	set	34
2376                     ; 489   uint32_t i = 0;
2378                     ; 490   SD_Error rvalue = SD_RESPONSE_FAILURE;
2380  04f9 a6ff          	ld	a,#255
2381  04fb 6b0e          	ld	(OFST-20,sp),a
2383                     ; 495   SD_CS_LOW();
2385  04fd 4b01          	push	#1
2386  04ff ae5005        	ldw	x,#20485
2387  0502 8d000000      	callf	f_GPIO_WriteLow
2389  0506 84            	pop	a
2390                     ; 497   response = SD_SendCmd(SD_CMD_SEND_CSD, 0, 0xFF, SD_ANSWER_R1_EXPECTED);
2392  0507 4b00          	push	#0
2393  0509 4bff          	push	#255
2394  050b ae0000        	ldw	x,#0
2395  050e 89            	pushw	x
2396  050f ae0000        	ldw	x,#0
2397  0512 89            	pushw	x
2398  0513 4b09          	push	#9
2399  0515 96            	ldw	x,sp
2400  0516 1c0010        	addw	x,#OFST-18
2401  0519 89            	pushw	x
2402  051a 8d430a43      	callf	L3f_SD_SendCmd
2404  051e 5b09          	addw	sp,#9
2405                     ; 499   if (response.r1 == SD_RESPONSE_NO_ERROR)
2407  0520 0d09          	tnz	(OFST-25,sp)
2408  0522 2648          	jrne	L5411
2409                     ; 501     if (!SD_GetResponse(SD_START_DATA_SINGLE_BLOCK_READ))
2411  0524 a6fe          	ld	a,#254
2412  0526 8da60ba6      	callf	f_SD_GetResponse
2414  052a 4d            	tnz	a
2415  052b 2631          	jrne	L7411
2416                     ; 503       for (i = 0; i < 16; i++)
2418  052d ae0000        	ldw	x,#0
2419  0530 1f11          	ldw	(OFST-17,sp),x
2420  0532 ae0000        	ldw	x,#0
2421  0535 1f0f          	ldw	(OFST-19,sp),x
2423  0537               L1511:
2424                     ; 506         CSD_Tab[i] = SD_ReadByte();
2426  0537 8d2e0e2e      	callf	f_SD_ReadByte
2428  053b 96            	ldw	x,sp
2429  053c 1c0013        	addw	x,#OFST-15
2430  053f 72fb11        	addw	x,(OFST-17,sp)
2431  0542 f7            	ld	(x),a
2432                     ; 503       for (i = 0; i < 16; i++)
2434  0543 96            	ldw	x,sp
2435  0544 1c000f        	addw	x,#OFST-19
2436  0547 a601          	ld	a,#1
2437  0549 8d000000      	callf	d_lgadc
2442  054d 96            	ldw	x,sp
2443  054e 1c000f        	addw	x,#OFST-19
2444  0551 8d000000      	callf	d_ltor
2446  0555 ae0004        	ldw	x,#L27
2447  0558 8d000000      	callf	d_lcmp
2449  055c 25d9          	jrult	L1511
2450  055e               L7411:
2451                     ; 510     SD_WriteByte(SD_DUMMY_BYTE);
2453  055e a6ff          	ld	a,#255
2454  0560 8d0e0e0e      	callf	f_SD_WriteByte
2456                     ; 511     SD_WriteByte(SD_DUMMY_BYTE);
2458  0564 a6ff          	ld	a,#255
2459  0566 8d0e0e0e      	callf	f_SD_WriteByte
2461                     ; 513     rvalue = SD_RESPONSE_NO_ERROR;
2463  056a 0f0e          	clr	(OFST-20,sp)
2465  056c               L5411:
2466                     ; 518   SD_csd->CSDStruct = (CSD_Tab[0] & 0xC0) >> 6;
2468  056c 7b13          	ld	a,(OFST-15,sp)
2469  056e 4e            	swap	a
2470  056f 44            	srl	a
2471  0570 44            	srl	a
2472  0571 a403          	and	a,#3
2473  0573 1e23          	ldw	x,(OFST+1,sp)
2474  0575 f8            	xor	a,(x)
2475  0576 a403          	and	a,#3
2476  0578 f8            	xor	a,(x)
2477  0579 f7            	ld	(x),a
2478                     ; 519   SD_csd->Reserved1 = CSD_Tab[0] & 0x3F;
2480  057a 7b13          	ld	a,(OFST-15,sp)
2481  057c 1e23          	ldw	x,(OFST+1,sp)
2482  057e 48            	sll	a
2483  057f 48            	sll	a
2484  0580 f8            	xor	a,(x)
2485  0581 a4fc          	and	a,#252
2486  0583 f8            	xor	a,(x)
2487  0584 f7            	ld	(x),a
2488                     ; 522   SD_csd->TAAC = CSD_Tab[1];
2490  0585 7b14          	ld	a,(OFST-14,sp)
2491  0587 1e23          	ldw	x,(OFST+1,sp)
2492  0589 e701          	ld	(1,x),a
2493                     ; 525   SD_csd->NSAC = CSD_Tab[2];
2495  058b 7b15          	ld	a,(OFST-13,sp)
2496  058d 1e23          	ldw	x,(OFST+1,sp)
2497  058f e702          	ld	(2,x),a
2498                     ; 528   SD_csd->MaxBusClkFrec = CSD_Tab[3];
2500  0591 7b16          	ld	a,(OFST-12,sp)
2501  0593 1e23          	ldw	x,(OFST+1,sp)
2502  0595 e703          	ld	(3,x),a
2503                     ; 531   SD_csd->CardComdClasses = CSD_Tab[4] << 4;
2505  0597 7b17          	ld	a,(OFST-11,sp)
2506  0599 97            	ld	xl,a
2507  059a a610          	ld	a,#16
2508  059c 42            	mul	x,a
2509  059d 01            	rrwa	x,a
2510  059e 1623          	ldw	y,(OFST+1,sp)
2511  05a0 90e705        	ld		(5,y),a
2512  05a3 9f            	ld	a,xl
2513  05a4 90e804        	xor	a,(4,y)
2514  05a7 a40f          	and	a,#15
2515  05a9 90e804        	xor	a,(4,y)
2516  05ac 90e704        	ld	(4,y),a
2517                     ; 534   SD_csd->CardComdClasses |= (CSD_Tab[5] & 0xF0) >> 4;
2519  05af 1623          	ldw	y,(OFST+1,sp)
2520  05b1 7b18          	ld	a,(OFST-10,sp)
2521  05b3 4e            	swap	a
2522  05b4 a40f          	and	a,#15
2523  05b6 5f            	clrw	x
2524  05b7 97            	ld	xl,a
2525  05b8 1f07          	ldw	(OFST-27,sp),x
2527  05ba 93            	ldw	x,y
2528  05bb ee04          	ldw	x,(4,x)
2529  05bd 01            	rrwa	x,a
2530  05be 41            	exg	a,xl
2531  05bf a40f          	and	a,#15
2532  05c1 41            	exg	a,xl
2533  05c2 1a08          	or	a,(OFST-26,sp)
2534  05c4 41            	exg	a,xl
2535  05c5 1a07          	or	a,(OFST-27,sp)
2536  05c7 41            	exg	a,xl
2537  05c8 90e705        	ld		(5,y),a
2538  05cb 9f            	ld	a,xl
2539  05cc 90e804        	xor	a,(4,y)
2540  05cf a40f          	and	a,#15
2541  05d1 90e804        	xor	a,(4,y)
2542  05d4 90e704        	ld	(4,y),a
2543                     ; 535   SD_csd->RdBlockLen = CSD_Tab[5] & 0x0F;
2545  05d7 7b18          	ld	a,(OFST-10,sp)
2546  05d9 1e23          	ldw	x,(OFST+1,sp)
2547  05db e806          	xor	a,(6,x)
2548  05dd a40f          	and	a,#15
2549  05df e806          	xor	a,(6,x)
2550  05e1 e706          	ld	(6,x),a
2551                     ; 538   SD_csd->PartBlockRead = (CSD_Tab[6] & 0x80) >> 7;
2553  05e3 7b19          	ld	a,(OFST-9,sp)
2554  05e5 49            	rlc	a
2555  05e6 4f            	clr	a
2556  05e7 49            	rlc	a
2557  05e8 1e23          	ldw	x,(OFST+1,sp)
2558  05ea 4e            	swap	a
2559  05eb e806          	xor	a,(6,x)
2560  05ed a410          	and	a,#16
2561  05ef e806          	xor	a,(6,x)
2562  05f1 e706          	ld	(6,x),a
2563                     ; 539   SD_csd->WrBlockMisalign = (CSD_Tab[6] & 0x40) >> 6;
2565  05f3 7b19          	ld	a,(OFST-9,sp)
2566  05f5 4e            	swap	a
2567  05f6 44            	srl	a
2568  05f7 44            	srl	a
2569  05f8 a403          	and	a,#3
2570  05fa 1e23          	ldw	x,(OFST+1,sp)
2571  05fc 4e            	swap	a
2572  05fd 48            	sll	a
2573  05fe e806          	xor	a,(6,x)
2574  0600 a420          	and	a,#32
2575  0602 e806          	xor	a,(6,x)
2576  0604 e706          	ld	(6,x),a
2577                     ; 540   SD_csd->RdBlockMisalign = (CSD_Tab[6] & 0x20) >> 5;
2579  0606 7b19          	ld	a,(OFST-9,sp)
2580  0608 4e            	swap	a
2581  0609 44            	srl	a
2582  060a a407          	and	a,#7
2583  060c 1e23          	ldw	x,(OFST+1,sp)
2584  060e 4e            	swap	a
2585  060f 48            	sll	a
2586  0610 48            	sll	a
2587  0611 e806          	xor	a,(6,x)
2588  0613 a440          	and	a,#64
2589  0615 e806          	xor	a,(6,x)
2590  0617 e706          	ld	(6,x),a
2591                     ; 541   SD_csd->DSRImpl = (CSD_Tab[6] & 0x10) >> 4;
2593  0619 7b19          	ld	a,(OFST-9,sp)
2594  061b 4e            	swap	a
2595  061c a40f          	and	a,#15
2596  061e 1e23          	ldw	x,(OFST+1,sp)
2597  0620 46            	rrc	a
2598  0621 46            	rrc	a
2599  0622 e806          	xor	a,(6,x)
2600  0624 a480          	and	a,#128
2601  0626 e806          	xor	a,(6,x)
2602  0628 e706          	ld	(6,x),a
2603                     ; 542   SD_csd->Reserved2 = 0; /*!< Reserved */
2605  062a 1e23          	ldw	x,(OFST+1,sp)
2606  062c e60f          	ld	a,(15,x)
2607  062e a4fc          	and	a,#252
2608  0630 e70f          	ld	(15,x),a
2609                     ; 544   if(flag_SDHC == 0)
2611  0632 be00          	ldw	x,_flag_SDHC
2612  0634 2704          	jreq	L47
2613  0636 acde06de      	jpf	L7511
2614  063a               L47:
2615                     ; 546     SD_csd->version.v1.Reserved1 = ((CSD_Tab[6] & 0x0C) >> 2);
2617  063a 7b19          	ld	a,(OFST-9,sp)
2618  063c 44            	srl	a
2619  063d 44            	srl	a
2620  063e 1e23          	ldw	x,(OFST+1,sp)
2621  0640 e807          	xor	a,(7,x)
2622  0642 a403          	and	a,#3
2623  0644 e807          	xor	a,(7,x)
2624  0646 e707          	ld	(7,x),a
2625                     ; 548     SD_csd->version.v1.DeviceSize =  ((CSD_Tab[6] & 0x03) << 10)
2625                     ; 549                                    |  (CSD_Tab[7] << 2)
2625                     ; 550                                    | ((CSD_Tab[8] & 0xC0) >> 6);
2627  0648 7b1b          	ld	a,(OFST-7,sp)
2628  064a 4e            	swap	a
2629  064b 44            	srl	a
2630  064c 44            	srl	a
2631  064d a403          	and	a,#3
2632  064f 5f            	clrw	x
2633  0650 97            	ld	xl,a
2634  0651 1f07          	ldw	(OFST-27,sp),x
2636  0653 7b1a          	ld	a,(OFST-8,sp)
2637  0655 97            	ld	xl,a
2638  0656 a604          	ld	a,#4
2639  0658 42            	mul	x,a
2640  0659 1f05          	ldw	(OFST-29,sp),x
2642  065b 7b19          	ld	a,(OFST-9,sp)
2643  065d a403          	and	a,#3
2644  065f 5f            	clrw	x
2645  0660 97            	ld	xl,a
2646  0661 4f            	clr	a
2647  0662 02            	rlwa	x,a
2648  0663 58            	sllw	x
2649  0664 58            	sllw	x
2650  0665 01            	rrwa	x,a
2651  0666 1a06          	or	a,(OFST-28,sp)
2652  0668 41            	exg	a,xl
2653  0669 1a05          	or	a,(OFST-29,sp)
2654  066b 41            	exg	a,xl
2655  066c 1a08          	or	a,(OFST-26,sp)
2656  066e 41            	exg	a,xl
2657  066f 1a07          	or	a,(OFST-27,sp)
2658  0671 41            	exg	a,xl
2659  0672 1623          	ldw	y,(OFST+1,sp)
2660  0674 90e709        	ld		(9,y),a
2661  0677 9f            	ld	a,xl
2662  0678 90e808        	xor	a,(8,y)
2663  067b a40f          	and	a,#15
2664  067d 90e808        	xor	a,(8,y)
2665  0680 90e708        	ld	(8,y),a
2666                     ; 551     SD_csd->version.v1.MaxRdCurrentVDDMin = (CSD_Tab[8] & 0x38) >> 3;
2668  0683 7b1b          	ld	a,(OFST-7,sp)
2669  0685 44            	srl	a
2670  0686 44            	srl	a
2671  0687 44            	srl	a
2672  0688 1e23          	ldw	x,(OFST+1,sp)
2673  068a e80a          	xor	a,(10,x)
2674  068c a407          	and	a,#7
2675  068e e80a          	xor	a,(10,x)
2676  0690 e70a          	ld	(10,x),a
2677                     ; 552     SD_csd->version.v1.MaxRdCurrentVDDMax = (CSD_Tab[8] & 0x07);
2679  0692 7b1b          	ld	a,(OFST-7,sp)
2680  0694 1e23          	ldw	x,(OFST+1,sp)
2681  0696 48            	sll	a
2682  0697 48            	sll	a
2683  0698 48            	sll	a
2684  0699 e80a          	xor	a,(10,x)
2685  069b a438          	and	a,#56
2686  069d e80a          	xor	a,(10,x)
2687  069f e70a          	ld	(10,x),a
2688                     ; 553     SD_csd->version.v1.MaxWrCurrentVDDMin = (CSD_Tab[9] & 0xE0) >> 5;
2690  06a1 7b1c          	ld	a,(OFST-6,sp)
2691  06a3 4e            	swap	a
2692  06a4 44            	srl	a
2693  06a5 a407          	and	a,#7
2694  06a7 1e23          	ldw	x,(OFST+1,sp)
2695  06a9 e80b          	xor	a,(11,x)
2696  06ab a407          	and	a,#7
2697  06ad e80b          	xor	a,(11,x)
2698  06af e70b          	ld	(11,x),a
2699                     ; 554     SD_csd->version.v1.MaxWrCurrentVDDMax = (CSD_Tab[9] & 0x1C) >> 2;
2701  06b1 7b1c          	ld	a,(OFST-6,sp)
2702  06b3 44            	srl	a
2703  06b4 44            	srl	a
2704  06b5 1e23          	ldw	x,(OFST+1,sp)
2705  06b7 48            	sll	a
2706  06b8 48            	sll	a
2707  06b9 48            	sll	a
2708  06ba e80b          	xor	a,(11,x)
2709  06bc a438          	and	a,#56
2710  06be e80b          	xor	a,(11,x)
2711  06c0 e70b          	ld	(11,x),a
2712                     ; 555     SD_csd->version.v1.DeviceSizeMul = ((CSD_Tab[9] & 0x03) << 1)
2712                     ; 556                                       |((CSD_Tab[10] & 0x80) >> 7);
2714  06c2 7b1d          	ld	a,(OFST-5,sp)
2715  06c4 49            	rlc	a
2716  06c5 4f            	clr	a
2717  06c6 49            	rlc	a
2718  06c7 6b08          	ld	(OFST-26,sp),a
2720  06c9 7b1c          	ld	a,(OFST-6,sp)
2721  06cb a403          	and	a,#3
2722  06cd 48            	sll	a
2723  06ce 1a08          	or	a,(OFST-26,sp)
2724  06d0 1e23          	ldw	x,(OFST+1,sp)
2725  06d2 e80c          	xor	a,(12,x)
2726  06d4 a407          	and	a,#7
2727  06d6 e80c          	xor	a,(12,x)
2728  06d8 e70c          	ld	(12,x),a
2730  06da ac680768      	jpf	L1611
2731  06de               L7511:
2732                     ; 560     SD_csd->version.v2.Reserved1 = ((CSD_Tab[6] & 0x0F) << 2) | ((CSD_Tab[7] & 0xC0) >> 6);
2734  06de 7b1a          	ld	a,(OFST-8,sp)
2735  06e0 4e            	swap	a
2736  06e1 44            	srl	a
2737  06e2 44            	srl	a
2738  06e3 a403          	and	a,#3
2739  06e5 6b08          	ld	(OFST-26,sp),a
2741  06e7 7b19          	ld	a,(OFST-9,sp)
2742  06e9 a40f          	and	a,#15
2743  06eb 48            	sll	a
2744  06ec 48            	sll	a
2745  06ed 1a08          	or	a,(OFST-26,sp)
2746  06ef 1e23          	ldw	x,(OFST+1,sp)
2747  06f1 e807          	xor	a,(7,x)
2748  06f3 a43f          	and	a,#63
2749  06f5 e807          	xor	a,(7,x)
2750  06f7 e707          	ld	(7,x),a
2751                     ; 561     SD_csd->version.v2.DeviceSize= ((CSD_Tab[7] & 0x3F) * 0x10000) | (CSD_Tab[8] << 8) | CSD_Tab[9];
2753  06f9 7b1c          	ld	a,(OFST-6,sp)
2754  06fb b703          	ld	c_lreg+3,a
2755  06fd 3f02          	clr	c_lreg+2
2756  06ff 3f01          	clr	c_lreg+1
2757  0701 3f00          	clr	c_lreg
2758  0703 96            	ldw	x,sp
2759  0704 1c0005        	addw	x,#OFST-29
2760  0707 8d000000      	callf	d_rtol
2763  070b 7b1b          	ld	a,(OFST-7,sp)
2764  070d 5f            	clrw	x
2765  070e 97            	ld	xl,a
2766  070f 90ae0100      	ldw	y,#256
2767  0713 8d000000      	callf	d_umul
2769  0717 96            	ldw	x,sp
2770  0718 1c0001        	addw	x,#OFST-33
2771  071b 8d000000      	callf	d_rtol
2774  071f 7b1a          	ld	a,(OFST-8,sp)
2775  0721 a43f          	and	a,#63
2776  0723 b703          	ld	c_lreg+3,a
2777  0725 3f02          	clr	c_lreg+2
2778  0727 3f01          	clr	c_lreg+1
2779  0729 3f00          	clr	c_lreg
2780  072b be02          	ldw	x,c_lreg+2
2781  072d bf00          	ldw	c_lreg,x
2782  072f 5f            	clrw	x
2783  0730 bf02          	ldw	c_lreg+2,x
2784  0732 96            	ldw	x,sp
2785  0733 1c0001        	addw	x,#OFST-33
2786  0736 8d000000      	callf	d_lor
2788  073a 96            	ldw	x,sp
2789  073b 1c0005        	addw	x,#OFST-29
2790  073e 8d000000      	callf	d_lor
2792  0742 1623          	ldw	y,(OFST+1,sp)
2793  0744 3f00          	clr	c_lreg
2794  0746 b601          	ld	a,c_lreg+1
2795  0748 a43f          	and	a,#63
2796  074a b701          	ld	c_lreg+1,a
2797  074c b603          	ld	a,c_lreg+3
2798  074e 90e70b        	ld	(11,y),a
2799  0751 b602          	ld	a,c_lreg+2
2800  0753 90e70a        	ld	(10,y),a
2801  0756 90e609        	ld	a,(9,y)
2802  0759 a4c0          	and	a,#192
2803  075b ba01          	or	a,c_lreg+1
2804  075d 90e709        	ld	(9,y),a
2805                     ; 562     SD_csd->version.v2.Reserved2 = ((CSD_Tab[10] & 0x80) >> 8);
2807  0760 1e23          	ldw	x,(OFST+1,sp)
2808  0762 e60c          	ld	a,(12,x)
2809  0764 a4fe          	and	a,#254
2810  0766 e70c          	ld	(12,x),a
2811  0768               L1611:
2812                     ; 565   SD_csd->EraseSingleBlockEnable = (CSD_Tab[10] & 0x40) >> 6;
2814  0768 7b1d          	ld	a,(OFST-5,sp)
2815  076a 4e            	swap	a
2816  076b 44            	srl	a
2817  076c 44            	srl	a
2818  076d a403          	and	a,#3
2819  076f 1e23          	ldw	x,(OFST+1,sp)
2820  0771 e80d          	xor	a,(13,x)
2821  0773 a401          	and	a,#1
2822  0775 e80d          	xor	a,(13,x)
2823  0777 e70d          	ld	(13,x),a
2824                     ; 566   SD_csd->EraseSectorSize   = ((CSD_Tab[10] & 0x3F) << 1)
2824                     ; 567                               |((CSD_Tab[11] & 0x80) >> 7);
2826  0779 7b1e          	ld	a,(OFST-4,sp)
2827  077b 49            	rlc	a
2828  077c 4f            	clr	a
2829  077d 49            	rlc	a
2830  077e 6b08          	ld	(OFST-26,sp),a
2832  0780 7b1d          	ld	a,(OFST-5,sp)
2833  0782 a43f          	and	a,#63
2834  0784 48            	sll	a
2835  0785 1a08          	or	a,(OFST-26,sp)
2836  0787 1e23          	ldw	x,(OFST+1,sp)
2837  0789 48            	sll	a
2838  078a e80d          	xor	a,(13,x)
2839  078c a4fe          	and	a,#254
2840  078e e80d          	xor	a,(13,x)
2841  0790 e70d          	ld	(13,x),a
2842                     ; 570   SD_csd->WrProtectGrSize = (CSD_Tab[11] & 0x7F);
2844  0792 7b1e          	ld	a,(OFST-4,sp)
2845  0794 1e23          	ldw	x,(OFST+1,sp)
2846  0796 e80e          	xor	a,(14,x)
2847  0798 a47f          	and	a,#127
2848  079a e80e          	xor	a,(14,x)
2849  079c e70e          	ld	(14,x),a
2850                     ; 573   SD_csd->WrProtectGrEnable = (CSD_Tab[12] & 0x80) >> 7;
2852  079e 7b1f          	ld	a,(OFST-3,sp)
2853  07a0 49            	rlc	a
2854  07a1 4f            	clr	a
2855  07a2 49            	rlc	a
2856  07a3 1e23          	ldw	x,(OFST+1,sp)
2857  07a5 46            	rrc	a
2858  07a6 46            	rrc	a
2859  07a7 e80e          	xor	a,(14,x)
2860  07a9 a480          	and	a,#128
2861  07ab e80e          	xor	a,(14,x)
2862  07ad e70e          	ld	(14,x),a
2863                     ; 574   SD_csd->Reserved2         = (CSD_Tab[12] & 0x60) >> 5;
2865  07af 7b1f          	ld	a,(OFST-3,sp)
2866  07b1 4e            	swap	a
2867  07b2 44            	srl	a
2868  07b3 a407          	and	a,#7
2869  07b5 1e23          	ldw	x,(OFST+1,sp)
2870  07b7 e80f          	xor	a,(15,x)
2871  07b9 a403          	and	a,#3
2872  07bb e80f          	xor	a,(15,x)
2873  07bd e70f          	ld	(15,x),a
2874                     ; 575   SD_csd->WrSpeedFact       = (CSD_Tab[12] & 0x1C) >> 2;
2876  07bf 7b1f          	ld	a,(OFST-3,sp)
2877  07c1 44            	srl	a
2878  07c2 44            	srl	a
2879  07c3 1e23          	ldw	x,(OFST+1,sp)
2880  07c5 48            	sll	a
2881  07c6 48            	sll	a
2882  07c7 e80f          	xor	a,(15,x)
2883  07c9 a41c          	and	a,#28
2884  07cb e80f          	xor	a,(15,x)
2885  07cd e70f          	ld	(15,x),a
2886                     ; 578   SD_csd->MaxWrBlockLen     = ((CSD_Tab[12] & 0x03) << 2)
2886                     ; 579                               |((CSD_Tab[13] & 0xC0) >> 6);
2888  07cf 7b20          	ld	a,(OFST-2,sp)
2889  07d1 4e            	swap	a
2890  07d2 44            	srl	a
2891  07d3 44            	srl	a
2892  07d4 a403          	and	a,#3
2893  07d6 6b08          	ld	(OFST-26,sp),a
2895  07d8 7b1f          	ld	a,(OFST-3,sp)
2896  07da a403          	and	a,#3
2897  07dc 48            	sll	a
2898  07dd 48            	sll	a
2899  07de 1a08          	or	a,(OFST-26,sp)
2900  07e0 1e23          	ldw	x,(OFST+1,sp)
2901  07e2 e810          	xor	a,(16,x)
2902  07e4 a40f          	and	a,#15
2903  07e6 e810          	xor	a,(16,x)
2904  07e8 e710          	ld	(16,x),a
2905                     ; 580   SD_csd->WriteBlockPartial = (CSD_Tab[13] & 0x20) >> 5;
2907  07ea 7b20          	ld	a,(OFST-2,sp)
2908  07ec 4e            	swap	a
2909  07ed 44            	srl	a
2910  07ee a407          	and	a,#7
2911  07f0 1e23          	ldw	x,(OFST+1,sp)
2912  07f2 4e            	swap	a
2913  07f3 e810          	xor	a,(16,x)
2914  07f5 a410          	and	a,#16
2915  07f7 e810          	xor	a,(16,x)
2916  07f9 e710          	ld	(16,x),a
2917                     ; 581   SD_csd->Reserved3         = (CSD_Tab[13] & 0x1F);
2919  07fb 7b20          	ld	a,(OFST-2,sp)
2920  07fd 1e23          	ldw	x,(OFST+1,sp)
2921  07ff e811          	xor	a,(17,x)
2922  0801 a41f          	and	a,#31
2923  0803 e811          	xor	a,(17,x)
2924  0805 e711          	ld	(17,x),a
2925                     ; 584   SD_csd->FileFormatGrouop = (CSD_Tab[14] & 0x80) >> 7;
2927  0807 7b21          	ld	a,(OFST-1,sp)
2928  0809 49            	rlc	a
2929  080a 4f            	clr	a
2930  080b 49            	rlc	a
2931  080c 1e23          	ldw	x,(OFST+1,sp)
2932  080e 4e            	swap	a
2933  080f 48            	sll	a
2934  0810 e811          	xor	a,(17,x)
2935  0812 a420          	and	a,#32
2936  0814 e811          	xor	a,(17,x)
2937  0816 e711          	ld	(17,x),a
2938                     ; 585   SD_csd->CopyFlag         = (CSD_Tab[14] & 0x40) >> 6;
2940  0818 7b21          	ld	a,(OFST-1,sp)
2941  081a 4e            	swap	a
2942  081b 44            	srl	a
2943  081c 44            	srl	a
2944  081d a403          	and	a,#3
2945  081f 1e23          	ldw	x,(OFST+1,sp)
2946  0821 4e            	swap	a
2947  0822 48            	sll	a
2948  0823 48            	sll	a
2949  0824 e811          	xor	a,(17,x)
2950  0826 a440          	and	a,#64
2951  0828 e811          	xor	a,(17,x)
2952  082a e711          	ld	(17,x),a
2953                     ; 586   SD_csd->PermWrProtect    = (CSD_Tab[14] & 0x20) >> 5;
2955  082c 7b21          	ld	a,(OFST-1,sp)
2956  082e 4e            	swap	a
2957  082f 44            	srl	a
2958  0830 a407          	and	a,#7
2959  0832 1e23          	ldw	x,(OFST+1,sp)
2960  0834 46            	rrc	a
2961  0835 46            	rrc	a
2962  0836 e811          	xor	a,(17,x)
2963  0838 a480          	and	a,#128
2964  083a e811          	xor	a,(17,x)
2965  083c e711          	ld	(17,x),a
2966                     ; 587   SD_csd->TempWrProtect    = (CSD_Tab[14] & 0x10) >> 4;
2968  083e 7b21          	ld	a,(OFST-1,sp)
2969  0840 4e            	swap	a
2970  0841 a40f          	and	a,#15
2971  0843 1e23          	ldw	x,(OFST+1,sp)
2972  0845 e812          	xor	a,(18,x)
2973  0847 a401          	and	a,#1
2974  0849 e812          	xor	a,(18,x)
2975  084b e712          	ld	(18,x),a
2976                     ; 588   SD_csd->FileFormat       = (CSD_Tab[14] & 0x0C) >> 2;
2978  084d 7b21          	ld	a,(OFST-1,sp)
2979  084f 44            	srl	a
2980  0850 44            	srl	a
2981  0851 1e23          	ldw	x,(OFST+1,sp)
2982  0853 48            	sll	a
2983  0854 e812          	xor	a,(18,x)
2984  0856 a406          	and	a,#6
2985  0858 e812          	xor	a,(18,x)
2986  085a e712          	ld	(18,x),a
2987                     ; 589   SD_csd->Reserved4        = (CSD_Tab[14] & 0x03);
2989  085c 7b21          	ld	a,(OFST-1,sp)
2990  085e 1e23          	ldw	x,(OFST+1,sp)
2991  0860 48            	sll	a
2992  0861 48            	sll	a
2993  0862 48            	sll	a
2994  0863 e812          	xor	a,(18,x)
2995  0865 a418          	and	a,#24
2996  0867 e812          	xor	a,(18,x)
2997  0869 e712          	ld	(18,x),a
2998                     ; 592   SD_csd->crc = (CSD_Tab[15] & 0xFE) >> 1;
3000  086b 7b22          	ld	a,(OFST+0,sp)
3001  086d 44            	srl	a
3002  086e 1e23          	ldw	x,(OFST+1,sp)
3003  0870 e813          	xor	a,(19,x)
3004  0872 a47f          	and	a,#127
3005  0874 e813          	xor	a,(19,x)
3006  0876 e713          	ld	(19,x),a
3007                     ; 593   SD_csd->Reserved4 = 1;
3009  0878 1e23          	ldw	x,(OFST+1,sp)
3010  087a e612          	ld	a,(18,x)
3011  087c a4e7          	and	a,#231
3012  087e aa08          	or	a,#8
3013  0880 e712          	ld	(18,x),a
3014                     ; 596   SD_CS_HIGH();
3016  0882 4b01          	push	#1
3017  0884 ae5005        	ldw	x,#20485
3018  0887 8d000000      	callf	f_GPIO_WriteHigh
3020  088b 84            	pop	a
3021                     ; 598   SD_WriteByte(SD_DUMMY_BYTE);
3023  088c a6ff          	ld	a,#255
3024  088e 8d0e0e0e      	callf	f_SD_WriteByte
3026                     ; 601   return rvalue;
3028  0892 7b0e          	ld	a,(OFST-20,sp)
3031  0894 5b24          	addw	sp,#36
3032  0896 87            	retf
3114                     ; 613 SD_Error SD_GetCIDRegister(SD_CID* SD_cid)
3114                     ; 614 {
3115                     	switch	.text
3116  0897               f_SD_GetCIDRegister:
3118  0897 89            	pushw	x
3119  0898 521f          	subw	sp,#31
3120       0000001f      OFST:	set	31
3123                     ; 615   uint32_t i = 0;
3125                     ; 616   SD_Error rvalue = SD_RESPONSE_FAILURE;
3127                     ; 620   SD_CS_LOW();
3129  089a 4b01          	push	#1
3130  089c ae5005        	ldw	x,#20485
3131  089f 8d000000      	callf	f_GPIO_WriteLow
3133  08a3 84            	pop	a
3134                     ; 623   response = SD_SendCmd(SD_CMD_SEND_CID, 0, 0xFF, SD_ANSWER_R1_EXPECTED);
3136  08a4 4b00          	push	#0
3137  08a6 4bff          	push	#255
3138  08a8 ae0000        	ldw	x,#0
3139  08ab 89            	pushw	x
3140  08ac ae0000        	ldw	x,#0
3141  08af 89            	pushw	x
3142  08b0 4b0a          	push	#10
3143  08b2 96            	ldw	x,sp
3144  08b3 1c000d        	addw	x,#OFST-18
3145  08b6 89            	pushw	x
3146  08b7 8d430a43      	callf	L3f_SD_SendCmd
3148  08bb 5b09          	addw	sp,#9
3149                     ; 626   if (response.r1 == SD_RESPONSE_NO_ERROR)
3151  08bd 0d06          	tnz	(OFST-25,sp)
3152  08bf 264a          	jrne	L3221
3153                     ; 628     if (!SD_GetResponse(SD_START_DATA_SINGLE_BLOCK_READ))
3155  08c1 a6fe          	ld	a,#254
3156  08c3 8da60ba6      	callf	f_SD_GetResponse
3158  08c7 4d            	tnz	a
3159  08c8 2631          	jrne	L5221
3160                     ; 631       for (i = 0; i < 16; i++)
3162  08ca ae0000        	ldw	x,#0
3163  08cd 1f0e          	ldw	(OFST-17,sp),x
3164  08cf ae0000        	ldw	x,#0
3165  08d2 1f0c          	ldw	(OFST-19,sp),x
3167  08d4               L7221:
3168                     ; 633         CID_Tab[i] = SD_ReadByte();
3170  08d4 8d2e0e2e      	callf	f_SD_ReadByte
3172  08d8 96            	ldw	x,sp
3173  08d9 1c0010        	addw	x,#OFST-15
3174  08dc 72fb0e        	addw	x,(OFST-17,sp)
3175  08df f7            	ld	(x),a
3176                     ; 631       for (i = 0; i < 16; i++)
3178  08e0 96            	ldw	x,sp
3179  08e1 1c000c        	addw	x,#OFST-19
3180  08e4 a601          	ld	a,#1
3181  08e6 8d000000      	callf	d_lgadc
3186  08ea 96            	ldw	x,sp
3187  08eb 1c000c        	addw	x,#OFST-19
3188  08ee 8d000000      	callf	d_ltor
3190  08f2 ae0004        	ldw	x,#L27
3191  08f5 8d000000      	callf	d_lcmp
3193  08f9 25d9          	jrult	L7221
3194  08fb               L5221:
3195                     ; 637     SD_WriteByte(SD_DUMMY_BYTE);
3197  08fb a6ff          	ld	a,#255
3198  08fd 8d0e0e0e      	callf	f_SD_WriteByte
3200                     ; 638     SD_WriteByte(SD_DUMMY_BYTE);
3202  0901 a6ff          	ld	a,#255
3203  0903 8d0e0e0e      	callf	f_SD_WriteByte
3205                     ; 640     rvalue = SD_RESPONSE_NO_ERROR;
3207  0907 0f0b          	clr	(OFST-20,sp)
3210  0909 2004          	jra	L5321
3211  090b               L3221:
3212                     ; 645     rvalue = SD_RESPONSE_FAILURE;
3214  090b a6ff          	ld	a,#255
3215  090d 6b0b          	ld	(OFST-20,sp),a
3217  090f               L5321:
3218                     ; 649   SD_cid->ManufacturerID = CID_Tab[0];
3220  090f 7b10          	ld	a,(OFST-15,sp)
3221  0911 1e20          	ldw	x,(OFST+1,sp)
3222  0913 f7            	ld	(x),a
3223                     ; 652   SD_cid->OEM_AppliID = CID_Tab[1] << 8;
3225  0914 7b11          	ld	a,(OFST-14,sp)
3226  0916 5f            	clrw	x
3227  0917 97            	ld	xl,a
3228  0918 4f            	clr	a
3229  0919 02            	rlwa	x,a
3230  091a 1620          	ldw	y,(OFST+1,sp)
3231  091c 90ef01        	ldw	(1,y),x
3232                     ; 655   SD_cid->OEM_AppliID |= CID_Tab[2];
3234  091f 1e20          	ldw	x,(OFST+1,sp)
3235  0921 7b12          	ld	a,(OFST-13,sp)
3236  0923 905f          	clrw	y
3237  0925 9097          	ld	yl,a
3238  0927 9001          	rrwa	y,a
3239  0929 ea02          	or	a,(2,x)
3240  092b 9001          	rrwa	y,a
3241  092d ea01          	or	a,(1,x)
3242  092f 9001          	rrwa	y,a
3243  0931 ef01          	ldw	(1,x),y
3244                     ; 658   SD_cid->ProdName1 = CID_Tab[3] * 0x1000000;
3246  0933 7b13          	ld	a,(OFST-12,sp)
3247  0935 b703          	ld	c_lreg+3,a
3248  0937 3f02          	clr	c_lreg+2
3249  0939 3f01          	clr	c_lreg+1
3250  093b 3f00          	clr	c_lreg
3251  093d a618          	ld	a,#24
3252  093f 8d000000      	callf	d_llsh
3254  0943 1e20          	ldw	x,(OFST+1,sp)
3255  0945 1c0003        	addw	x,#3
3256  0948 8d000000      	callf	d_rtol
3258                     ; 661   SD_cid->ProdName1 |= CID_Tab[4] * 0x10000;
3260  094c 1e20          	ldw	x,(OFST+1,sp)
3261  094e 7b14          	ld	a,(OFST-11,sp)
3262  0950 b703          	ld	c_lreg+3,a
3263  0952 3f02          	clr	c_lreg+2
3264  0954 3f01          	clr	c_lreg+1
3265  0956 3f00          	clr	c_lreg
3266  0958 a610          	ld	a,#16
3267  095a 8d000000      	callf	d_llsh
3269  095e 1c0003        	addw	x,#3
3270  0961 8d000000      	callf	d_lgor
3272                     ; 664   SD_cid->ProdName1 |= CID_Tab[5] << 8;
3274  0965 1e20          	ldw	x,(OFST+1,sp)
3275  0967 7b15          	ld	a,(OFST-10,sp)
3276  0969 905f          	clrw	y
3277  096b 9097          	ld	yl,a
3278  096d 4f            	clr	a
3279  096e 9002          	rlwa	y,a
3280  0970 8d000000      	callf	d_itoly
3282  0974 1c0003        	addw	x,#3
3283  0977 8d000000      	callf	d_lgor
3285                     ; 667   SD_cid->ProdName1 |= CID_Tab[6];
3287  097b 1e20          	ldw	x,(OFST+1,sp)
3288  097d 7b16          	ld	a,(OFST-9,sp)
3289  097f b703          	ld	c_lreg+3,a
3290  0981 3f02          	clr	c_lreg+2
3291  0983 3f01          	clr	c_lreg+1
3292  0985 3f00          	clr	c_lreg
3293  0987 1c0003        	addw	x,#3
3294  098a 8d000000      	callf	d_lgor
3296                     ; 670   SD_cid->ProdName2 = CID_Tab[7];
3298  098e 7b17          	ld	a,(OFST-8,sp)
3299  0990 1e20          	ldw	x,(OFST+1,sp)
3300  0992 e707          	ld	(7,x),a
3301                     ; 673   SD_cid->ProdRev = CID_Tab[8];
3303  0994 7b18          	ld	a,(OFST-7,sp)
3304  0996 1e20          	ldw	x,(OFST+1,sp)
3305  0998 e708          	ld	(8,x),a
3306                     ; 676   SD_cid->ProdSN = CID_Tab[9] *  0x1000000;
3308  099a 7b19          	ld	a,(OFST-6,sp)
3309  099c b703          	ld	c_lreg+3,a
3310  099e 3f02          	clr	c_lreg+2
3311  09a0 3f01          	clr	c_lreg+1
3312  09a2 3f00          	clr	c_lreg
3313  09a4 a618          	ld	a,#24
3314  09a6 8d000000      	callf	d_llsh
3316  09aa 1e20          	ldw	x,(OFST+1,sp)
3317  09ac 1c0009        	addw	x,#9
3318  09af 8d000000      	callf	d_rtol
3320                     ; 679   SD_cid->ProdSN |= CID_Tab[10] * 0x10000;
3322  09b3 1e20          	ldw	x,(OFST+1,sp)
3323  09b5 7b1a          	ld	a,(OFST-5,sp)
3324  09b7 b703          	ld	c_lreg+3,a
3325  09b9 3f02          	clr	c_lreg+2
3326  09bb 3f01          	clr	c_lreg+1
3327  09bd 3f00          	clr	c_lreg
3328  09bf a610          	ld	a,#16
3329  09c1 8d000000      	callf	d_llsh
3331  09c5 1c0009        	addw	x,#9
3332  09c8 8d000000      	callf	d_lgor
3334                     ; 682   SD_cid->ProdSN |= CID_Tab[11] << 8;
3336  09cc 1e20          	ldw	x,(OFST+1,sp)
3337  09ce 7b1b          	ld	a,(OFST-4,sp)
3338  09d0 905f          	clrw	y
3339  09d2 9097          	ld	yl,a
3340  09d4 4f            	clr	a
3341  09d5 9002          	rlwa	y,a
3342  09d7 8d000000      	callf	d_itoly
3344  09db 1c0009        	addw	x,#9
3345  09de 8d000000      	callf	d_lgor
3347                     ; 685   SD_cid->ProdSN |= CID_Tab[12];
3349  09e2 1e20          	ldw	x,(OFST+1,sp)
3350  09e4 7b1c          	ld	a,(OFST-3,sp)
3351  09e6 b703          	ld	c_lreg+3,a
3352  09e8 3f02          	clr	c_lreg+2
3353  09ea 3f01          	clr	c_lreg+1
3354  09ec 3f00          	clr	c_lreg
3355  09ee 1c0009        	addw	x,#9
3356  09f1 8d000000      	callf	d_lgor
3358                     ; 688   SD_cid->Reserved1 |= (CID_Tab[13] & 0xF0) >> 4;
3360  09f5 1e20          	ldw	x,(OFST+1,sp)
3361  09f7 7b1d          	ld	a,(OFST-2,sp)
3362  09f9 4e            	swap	a
3363  09fa a40f          	and	a,#15
3364  09fc ea0d          	or	a,(13,x)
3365  09fe e70d          	ld	(13,x),a
3366                     ; 689   SD_cid->ManufactDate = (CID_Tab[13] & 0x0F) << 8;
3368  0a00 7b1d          	ld	a,(OFST-2,sp)
3369  0a02 a40f          	and	a,#15
3370  0a04 5f            	clrw	x
3371  0a05 97            	ld	xl,a
3372  0a06 4f            	clr	a
3373  0a07 02            	rlwa	x,a
3374  0a08 1620          	ldw	y,(OFST+1,sp)
3375  0a0a 90ef0e        	ldw	(14,y),x
3376                     ; 692   SD_cid->ManufactDate |= CID_Tab[14];
3378  0a0d 1e20          	ldw	x,(OFST+1,sp)
3379  0a0f 7b1e          	ld	a,(OFST-1,sp)
3380  0a11 905f          	clrw	y
3381  0a13 9097          	ld	yl,a
3382  0a15 9001          	rrwa	y,a
3383  0a17 ea0f          	or	a,(15,x)
3384  0a19 9001          	rrwa	y,a
3385  0a1b ea0e          	or	a,(14,x)
3386  0a1d 9001          	rrwa	y,a
3387  0a1f ef0e          	ldw	(14,x),y
3388                     ; 695   SD_cid->CID_CRC = (CID_Tab[15] & 0xFE) >> 1;
3390  0a21 7b1f          	ld	a,(OFST+0,sp)
3391  0a23 44            	srl	a
3392  0a24 1e20          	ldw	x,(OFST+1,sp)
3393  0a26 e710          	ld	(16,x),a
3394                     ; 696   SD_cid->Reserved2 = 1;
3396  0a28 1e20          	ldw	x,(OFST+1,sp)
3397  0a2a a601          	ld	a,#1
3398  0a2c e711          	ld	(17,x),a
3399                     ; 699   SD_CS_HIGH();
3401  0a2e 4b01          	push	#1
3402  0a30 ae5005        	ldw	x,#20485
3403  0a33 8d000000      	callf	f_GPIO_WriteHigh
3405  0a37 84            	pop	a
3406                     ; 701   SD_WriteByte(SD_DUMMY_BYTE);
3408  0a38 a6ff          	ld	a,#255
3409  0a3a 8d0e0e0e      	callf	f_SD_WriteByte
3411                     ; 704   return rvalue;
3413  0a3e 7b0b          	ld	a,(OFST-20,sp)
3416  0a40 5b21          	addw	sp,#33
3417  0a42 87            	retf
3419                     	switch	.const
3420  0008               L7321_retr:
3421  0008 ff            	dc.b	255
3422  0009 ff            	dc.b	255
3423  000a ff            	dc.b	255
3424  000b ff            	dc.b	255
3425  000c ff            	dc.b	255
3518                     	switch	.const
3519  000d               L201:
3520  000d 00000006      	dc.l	6
3521                     ; 714 static SD_CmdAnswer_typedef SD_SendCmd(uint8_t Cmd, uint32_t Arg, uint8_t Crc, uint8_t Answer)
3521                     ; 715 {
3522                     	switch	.text
3523  0a43               L3f_SD_SendCmd:
3525  0a43 520f          	subw	sp,#15
3526       0000000f      OFST:	set	15
3529                     ; 716   uint32_t i = 0x00;
3531                     ; 717   SD_CmdAnswer_typedef retr = {0xFF, 0xFF , 0xFF, 0xFF, 0xFF};
3533  0a45 96            	ldw	x,sp
3534  0a46 1c000b        	addw	x,#OFST-4
3535  0a49 90ae0008      	ldw	y,#L7321_retr
3536  0a4d a605          	ld	a,#5
3537  0a4f 8d000000      	callf	d_xymov
3539                     ; 720   Frame[0] = (Cmd | 0x40); /*!< Construct byte 1 */
3541  0a53 7b15          	ld	a,(OFST+6,sp)
3542  0a55 aa40          	or	a,#64
3543  0a57 6b01          	ld	(OFST-14,sp),a
3545                     ; 722   Frame[1] = (uint8_t)(Arg >> 24); /*!< Construct byte 2 */
3547  0a59 7b16          	ld	a,(OFST+7,sp)
3548  0a5b 6b02          	ld	(OFST-13,sp),a
3550                     ; 724   Frame[2] = (uint8_t)(Arg >> 16); /*!< Construct byte 3 */
3552  0a5d 7b17          	ld	a,(OFST+8,sp)
3553  0a5f 6b03          	ld	(OFST-12,sp),a
3555                     ; 726   Frame[3] = (uint8_t)(Arg >> 8); /*!< Construct byte 4 */
3557  0a61 7b18          	ld	a,(OFST+9,sp)
3558  0a63 6b04          	ld	(OFST-11,sp),a
3560                     ; 728   Frame[4] = (uint8_t)(Arg); /*!< Construct byte 5 */
3562  0a65 7b19          	ld	a,(OFST+10,sp)
3563  0a67 6b05          	ld	(OFST-10,sp),a
3565                     ; 730   Frame[5] = (Crc | 0x01); /*!< Construct CRC: byte 6 */
3567  0a69 7b1a          	ld	a,(OFST+11,sp)
3568  0a6b aa01          	or	a,#1
3569  0a6d 6b06          	ld	(OFST-9,sp),a
3571                     ; 732   SD_CS_LOW();
3573  0a6f 4b01          	push	#1
3574  0a71 ae5005        	ldw	x,#20485
3575  0a74 8d000000      	callf	f_GPIO_WriteLow
3577  0a78 84            	pop	a
3578                     ; 734   for (i = 0; i < 6; i++)
3580  0a79 ae0000        	ldw	x,#0
3581  0a7c 1f09          	ldw	(OFST-6,sp),x
3582  0a7e ae0000        	ldw	x,#0
3583  0a81 1f07          	ldw	(OFST-8,sp),x
3585  0a83               L1231:
3586                     ; 736     SD_WriteByte(Frame[i]); /*!< Send the Cmd bytes */
3588  0a83 96            	ldw	x,sp
3589  0a84 1c0001        	addw	x,#OFST-14
3590  0a87 72fb09        	addw	x,(OFST-6,sp)
3591  0a8a f6            	ld	a,(x)
3592  0a8b 8d0e0e0e      	callf	f_SD_WriteByte
3594                     ; 734   for (i = 0; i < 6; i++)
3596  0a8f 96            	ldw	x,sp
3597  0a90 1c0007        	addw	x,#OFST-8
3598  0a93 a601          	ld	a,#1
3599  0a95 8d000000      	callf	d_lgadc
3604  0a99 96            	ldw	x,sp
3605  0a9a 1c0007        	addw	x,#OFST-8
3606  0a9d 8d000000      	callf	d_ltor
3608  0aa1 ae000d        	ldw	x,#L201
3609  0aa4 8d000000      	callf	d_lcmp
3611  0aa8 25d9          	jrult	L1231
3612                     ; 739 switch(Answer)
3614  0aaa 7b1b          	ld	a,(OFST+12,sp)
3616                     ; 768   default :
3616                     ; 769     break;
3617  0aac 4d            	tnz	a
3618  0aad 270f          	jreq	L1421
3619  0aaf 4a            	dec	a
3620  0ab0 2714          	jreq	L3421
3621  0ab2 4a            	dec	a
3622  0ab3 273f          	jreq	L5421
3623  0ab5 4a            	dec	a
3624  0ab6 274c          	jreq	L7421
3625  0ab8 a002          	sub	a,#2
3626  0aba 2748          	jreq	L7421
3627  0abc 206c          	jra	L1331
3628  0abe               L1421:
3629                     ; 741   case SD_ANSWER_R1_EXPECTED :
3629                     ; 742     retr.r1 = SD_ReadData();
3631  0abe 8d520e52      	callf	f_SD_ReadData
3633  0ac2 6b0b          	ld	(OFST-4,sp),a
3635                     ; 743     break;
3637  0ac4 2064          	jra	L1331
3638  0ac6               L3421:
3639                     ; 744   case SD_ANSWER_R1B_EXPECTED :
3639                     ; 745     retr.r1 = SD_ReadData();
3641  0ac6 8d520e52      	callf	f_SD_ReadData
3643  0aca 6b0b          	ld	(OFST-4,sp),a
3645                     ; 746     retr.r2 = SD_WriteByte(SD_DUMMY_BYTE);
3647  0acc a6ff          	ld	a,#255
3648  0ace 8d0e0e0e      	callf	f_SD_WriteByte
3650  0ad2 6b0c          	ld	(OFST-3,sp),a
3652                     ; 748     SD_CS_HIGH();
3654  0ad4 4b01          	push	#1
3655  0ad6 ae5005        	ldw	x,#20485
3656  0ad9 8d000000      	callf	f_GPIO_WriteHigh
3658  0add 84            	pop	a
3659                     ; 751     SD_CS_LOW();
3661  0ade 4b01          	push	#1
3662  0ae0 ae5005        	ldw	x,#20485
3663  0ae3 8d000000      	callf	f_GPIO_WriteLow
3665  0ae7 84            	pop	a
3667  0ae8               L5331:
3668                     ; 754     while (SD_WriteByte(SD_DUMMY_BYTE) != 0xFF);
3670  0ae8 a6ff          	ld	a,#255
3671  0aea 8d0e0e0e      	callf	f_SD_WriteByte
3673  0aee a1ff          	cp	a,#255
3674  0af0 26f6          	jrne	L5331
3675                     ; 755     break;
3677  0af2 2036          	jra	L1331
3678  0af4               L5421:
3679                     ; 756   case SD_ANSWER_R2_EXPECTED :
3679                     ; 757     retr.r1 = SD_ReadData();
3681  0af4 8d520e52      	callf	f_SD_ReadData
3683  0af8 6b0b          	ld	(OFST-4,sp),a
3685                     ; 758     retr.r2 = SD_WriteByte(SD_DUMMY_BYTE);
3687  0afa a6ff          	ld	a,#255
3688  0afc 8d0e0e0e      	callf	f_SD_WriteByte
3690  0b00 6b0c          	ld	(OFST-3,sp),a
3692                     ; 759     break;
3694  0b02 2026          	jra	L1331
3695  0b04               L7421:
3696                     ; 760   case SD_ANSWER_R3_EXPECTED :
3696                     ; 761   case SD_ANSWER_R7_EXPECTED :
3696                     ; 762     retr.r1 = SD_ReadData();
3698  0b04 8d520e52      	callf	f_SD_ReadData
3700  0b08 6b0b          	ld	(OFST-4,sp),a
3702                     ; 763     retr.r2 = SD_WriteByte(SD_DUMMY_BYTE);
3704  0b0a a6ff          	ld	a,#255
3705  0b0c 8d0e0e0e      	callf	f_SD_WriteByte
3707  0b10 6b0c          	ld	(OFST-3,sp),a
3709                     ; 764     retr.r3 = SD_WriteByte(SD_DUMMY_BYTE);
3711  0b12 a6ff          	ld	a,#255
3712  0b14 8d0e0e0e      	callf	f_SD_WriteByte
3714  0b18 6b0d          	ld	(OFST-2,sp),a
3716                     ; 765     retr.r4 = SD_WriteByte(SD_DUMMY_BYTE);
3718  0b1a a6ff          	ld	a,#255
3719  0b1c 8d0e0e0e      	callf	f_SD_WriteByte
3721  0b20 6b0e          	ld	(OFST-1,sp),a
3723                     ; 766     retr.r5 = SD_WriteByte(SD_DUMMY_BYTE);
3725  0b22 a6ff          	ld	a,#255
3726  0b24 8d0e0e0e      	callf	f_SD_WriteByte
3728  0b28 6b0f          	ld	(OFST+0,sp),a
3730                     ; 767     break;
3732  0b2a               L1521:
3733                     ; 768   default :
3733                     ; 769     break;
3735  0b2a               L1331:
3736                     ; 771   return retr;
3738  0b2a 1e13          	ldw	x,(OFST+4,sp)
3739  0b2c 9096          	ldw	y,sp
3740  0b2e 72a9000b      	addw	y,#OFST-4
3741  0b32 a605          	ld	a,#5
3742  0b34 8d000000      	callf	d_xymov
3746  0b38 5b0f          	addw	sp,#15
3747  0b3a 87            	retf
3799                     	switch	.const
3800  0011               L601:
3801  0011 00000041      	dc.l	65
3802                     ; 783 uint8_t SD_GetDataResponse(void)
3802                     ; 784 {
3803                     	switch	.text
3804  0b3b               f_SD_GetDataResponse:
3806  0b3b 5206          	subw	sp,#6
3807       00000006      OFST:	set	6
3810                     ; 785   uint32_t i = 0;
3812  0b3d ae0000        	ldw	x,#0
3813  0b40 1f03          	ldw	(OFST-3,sp),x
3814  0b42 ae0000        	ldw	x,#0
3815  0b45 1f01          	ldw	(OFST-5,sp),x
3817                     ; 786   uint8_t response = 0, rvalue = 0;
3819  0b47 0f06          	clr	(OFST+0,sp)
3824  0b49 203f          	jra	L1041
3825  0b4b               L7731:
3826                     ; 791     response = SD_ReadByte();
3828  0b4b 8d2e0e2e      	callf	f_SD_ReadByte
3830  0b4f 6b06          	ld	(OFST+0,sp),a
3832                     ; 793     response &= 0x1F;
3834  0b51 7b06          	ld	a,(OFST+0,sp)
3835  0b53 a41f          	and	a,#31
3836  0b55 6b06          	ld	(OFST+0,sp),a
3838                     ; 794     switch (response)
3840  0b57 7b06          	ld	a,(OFST+0,sp)
3842                     ; 808         break;
3843  0b59 a005          	sub	a,#5
3844  0b5b 270e          	jreq	L1431
3845  0b5d a006          	sub	a,#6
3846  0b5f 2710          	jreq	L3431
3847  0b61 a002          	sub	a,#2
3848  0b63 2710          	jreq	L5431
3849  0b65               L7431:
3850                     ; 807         rvalue = SD_DATA_OTHER_ERROR;
3852  0b65 a6ff          	ld	a,#255
3853  0b67 6b05          	ld	(OFST-1,sp),a
3855                     ; 808         break;
3857  0b69 200f          	jra	L7041
3858  0b6b               L1431:
3859                     ; 798         rvalue = SD_DATA_OK;
3861  0b6b a605          	ld	a,#5
3862  0b6d 6b05          	ld	(OFST-1,sp),a
3864                     ; 799         break;
3866  0b6f 2009          	jra	L7041
3867  0b71               L3431:
3868                     ; 801       case SD_DATA_CRC_ERROR:
3868                     ; 802         return SD_DATA_CRC_ERROR;
3870  0b71 a60b          	ld	a,#11
3872  0b73 2002          	jra	L011
3873  0b75               L5431:
3874                     ; 803       case SD_DATA_WRITE_ERROR:
3874                     ; 804         return SD_DATA_WRITE_ERROR;
3876  0b75 a60d          	ld	a,#13
3878  0b77               L011:
3880  0b77 5b06          	addw	sp,#6
3881  0b79 87            	retf
3882  0b7a               L7041:
3883                     ; 812     if (rvalue == SD_DATA_OK)
3885  0b7a 7b05          	ld	a,(OFST-1,sp)
3886  0b7c a105          	cp	a,#5
3887  0b7e 271b          	jreq	L5141
3888                     ; 813       break;
3890                     ; 815     i++;
3892  0b80 96            	ldw	x,sp
3893  0b81 1c0001        	addw	x,#OFST-5
3894  0b84 a601          	ld	a,#1
3895  0b86 8d000000      	callf	d_lgadc
3898  0b8a               L1041:
3899                     ; 788   while (i <= 64)
3901  0b8a 96            	ldw	x,sp
3902  0b8b 1c0001        	addw	x,#OFST-5
3903  0b8e 8d000000      	callf	d_ltor
3905  0b92 ae0011        	ldw	x,#L601
3906  0b95 8d000000      	callf	d_lcmp
3908  0b99 25b0          	jrult	L7731
3909  0b9b               L5141:
3910                     ; 819   while (SD_ReadByte() == 0);
3912  0b9b 8d2e0e2e      	callf	f_SD_ReadByte
3914  0b9f 4d            	tnz	a
3915  0ba0 27f9          	jreq	L5141
3916                     ; 822   return response;
3918  0ba2 7b06          	ld	a,(OFST+0,sp)
3920  0ba4 20d1          	jra	L011
3964                     ; 832 SD_Error SD_GetResponse(uint8_t Response)
3964                     ; 833 {
3965                     	switch	.text
3966  0ba6               f_SD_GetResponse:
3968  0ba6 88            	push	a
3969  0ba7 5204          	subw	sp,#4
3970       00000004      OFST:	set	4
3973                     ; 834   uint32_t Count = 0xFFF;
3975  0ba9 ae0fff        	ldw	x,#4095
3976  0bac 1f03          	ldw	(OFST-1,sp),x
3977  0bae ae0000        	ldw	x,#0
3978  0bb1 1f01          	ldw	(OFST-3,sp),x
3981  0bb3 200a          	jra	L7441
3982  0bb5               L3441:
3983                     ; 839     Count--;
3985  0bb5 96            	ldw	x,sp
3986  0bb6 1c0001        	addw	x,#OFST-3
3987  0bb9 a601          	ld	a,#1
3988  0bbb 8d000000      	callf	d_lgsbc
3991  0bbf               L7441:
3992                     ; 837   while ((SD_ReadByte() != Response) && Count)
3994  0bbf 8d2e0e2e      	callf	f_SD_ReadByte
3996  0bc3 1105          	cp	a,(OFST+1,sp)
3997  0bc5 270a          	jreq	L3541
3999  0bc7 96            	ldw	x,sp
4000  0bc8 1c0001        	addw	x,#OFST-3
4001  0bcb 8d000000      	callf	d_lzmp
4003  0bcf 26e4          	jrne	L3441
4004  0bd1               L3541:
4005                     ; 842   if (Count == 0)
4007  0bd1 96            	ldw	x,sp
4008  0bd2 1c0001        	addw	x,#OFST-3
4009  0bd5 8d000000      	callf	d_lzmp
4011  0bd9 2604          	jrne	L5541
4012                     ; 845     return SD_RESPONSE_FAILURE;
4014  0bdb a6ff          	ld	a,#255
4016  0bdd 2001          	jra	L411
4017  0bdf               L5541:
4018                     ; 850     return SD_RESPONSE_NO_ERROR;
4020  0bdf 4f            	clr	a
4022  0be0               L411:
4024  0be0 5b05          	addw	sp,#5
4025  0be2 87            	retf
4063                     ; 859 uint16_t SD_GetStatus(void)
4063                     ; 860 {
4064                     	switch	.text
4065  0be3               f_SD_GetStatus:
4067  0be3 520a          	subw	sp,#10
4068       0000000a      OFST:	set	10
4071                     ; 863   SD_CS_LOW();
4073  0be5 4b01          	push	#1
4074  0be7 ae5005        	ldw	x,#20485
4075  0bea 8d000000      	callf	f_GPIO_WriteLow
4077  0bee 84            	pop	a
4078                     ; 866   retr = SD_SendCmd(SD_CMD_SEND_STATUS, 0, 0xFF, SD_ANSWER_R2_EXPECTED);
4080  0bef 4b02          	push	#2
4081  0bf1 4bff          	push	#255
4082  0bf3 ae0000        	ldw	x,#0
4083  0bf6 89            	pushw	x
4084  0bf7 ae0000        	ldw	x,#0
4085  0bfa 89            	pushw	x
4086  0bfb 4b0d          	push	#13
4087  0bfd 96            	ldw	x,sp
4088  0bfe 1c000d        	addw	x,#OFST+3
4089  0c01 89            	pushw	x
4090  0c02 8d430a43      	callf	L3f_SD_SendCmd
4092  0c06 5b09          	addw	sp,#9
4093                     ; 869   SD_CS_HIGH();
4095  0c08 4b01          	push	#1
4096  0c0a ae5005        	ldw	x,#20485
4097  0c0d 8d000000      	callf	f_GPIO_WriteHigh
4099  0c11 84            	pop	a
4100                     ; 872   SD_WriteByte(SD_DUMMY_BYTE);
4102  0c12 a6ff          	ld	a,#255
4103  0c14 8d0e0e0e      	callf	f_SD_WriteByte
4105                     ; 875   if(( retr.r1 == SD_RESPONSE_NO_ERROR) && ( retr.r2 == SD_RESPONSE_NO_ERROR))
4107  0c18 0d06          	tnz	(OFST-4,sp)
4108  0c1a 2607          	jrne	L7741
4110  0c1c 0d07          	tnz	(OFST-3,sp)
4111  0c1e 2603          	jrne	L7741
4112                     ; 877     return SD_RESPONSE_NO_ERROR;
4114  0c20 5f            	clrw	x
4116  0c21 2003          	jra	L021
4117  0c23               L7741:
4118                     ; 880   return SD_RESPONSE_FAILURE;
4120  0c23 ae00ff        	ldw	x,#255
4122  0c26               L021:
4124  0c26 5b0a          	addw	sp,#10
4125  0c28 87            	retf
4173                     ; 890 SD_Error SD_GoIdleState(void)
4173                     ; 891 {
4174                     	switch	.text
4175  0c29               f_SD_GoIdleState:
4177  0c29 520b          	subw	sp,#11
4178       0000000b      OFST:	set	11
4181                     ; 893   __IO uint8_t counter = 0;
4183  0c2b 0f06          	clr	(OFST-5,sp)
4185  0c2d               L3251:
4186                     ; 900     response = SD_SendCmd(SD_CMD_GO_IDLE_STATE, 0, 0x95, SD_ANSWER_R1_EXPECTED);
4188  0c2d 4b00          	push	#0
4189  0c2f 4b95          	push	#149
4190  0c31 ae0000        	ldw	x,#0
4191  0c34 89            	pushw	x
4192  0c35 ae0000        	ldw	x,#0
4193  0c38 89            	pushw	x
4194  0c39 4b00          	push	#0
4195  0c3b 96            	ldw	x,sp
4196  0c3c 1c000e        	addw	x,#OFST+3
4197  0c3f 89            	pushw	x
4198  0c40 8d430a43      	callf	L3f_SD_SendCmd
4200  0c44 5b09          	addw	sp,#9
4201                     ; 903     SD_CS_HIGH();
4203  0c46 4b01          	push	#1
4204  0c48 ae5005        	ldw	x,#20485
4205  0c4b 8d000000      	callf	f_GPIO_WriteHigh
4207  0c4f 84            	pop	a
4208                     ; 906     SD_WriteByte(SD_DUMMY_BYTE);
4210  0c50 a6ff          	ld	a,#255
4211  0c52 8d0e0e0e      	callf	f_SD_WriteByte
4213                     ; 908     if(counter >= 100)
4215  0c56 7b06          	ld	a,(OFST-5,sp)
4216  0c58 a164          	cp	a,#100
4217  0c5a 2506          	jrult	L1351
4218                     ; 910       return SD_RESPONSE_FAILURE;
4220  0c5c a6ff          	ld	a,#255
4222  0c5e ac950d95      	jpf	L421
4223  0c62               L1351:
4224                     ; 912     counter ++;
4226  0c62 0c06          	inc	(OFST-5,sp)
4228                     ; 914   while(response.r1 != SD_IN_IDLE_STATE);
4230  0c64 7b07          	ld	a,(OFST-4,sp)
4231  0c66 a101          	cp	a,#1
4232  0c68 26c3          	jrne	L3251
4233                     ; 919   response = SD_SendCmd(SD_CMD_SEND_IF_COND, 0x1AA, 0x87, SD_ANSWER_R7_EXPECTED);
4235  0c6a 4b05          	push	#5
4236  0c6c 4b87          	push	#135
4237  0c6e ae01aa        	ldw	x,#426
4238  0c71 89            	pushw	x
4239  0c72 ae0000        	ldw	x,#0
4240  0c75 89            	pushw	x
4241  0c76 4b08          	push	#8
4242  0c78 96            	ldw	x,sp
4243  0c79 1c000e        	addw	x,#OFST+3
4244  0c7c 89            	pushw	x
4245  0c7d 8d430a43      	callf	L3f_SD_SendCmd
4247  0c81 5b09          	addw	sp,#9
4248                     ; 922   SD_CS_HIGH();
4250  0c83 4b01          	push	#1
4251  0c85 ae5005        	ldw	x,#20485
4252  0c88 8d000000      	callf	f_GPIO_WriteHigh
4254  0c8c 84            	pop	a
4255                     ; 925   SD_WriteByte(SD_DUMMY_BYTE);
4257  0c8d a6ff          	ld	a,#255
4258  0c8f 8d0e0e0e      	callf	f_SD_WriteByte
4260                     ; 927   if((response.r1  & SD_ILLEGAL_COMMAND) == SD_ILLEGAL_COMMAND)
4262  0c93 7b07          	ld	a,(OFST-4,sp)
4263  0c95 a404          	and	a,#4
4264  0c97 a104          	cp	a,#4
4265  0c99 265f          	jrne	L3351
4266  0c9b               L5351:
4267                     ; 934       response = SD_SendCmd(SD_CMD_APP_CMD, 0x00000000, 0xFF, SD_ANSWER_R1_EXPECTED);
4269  0c9b 4b00          	push	#0
4270  0c9d 4bff          	push	#255
4271  0c9f ae0000        	ldw	x,#0
4272  0ca2 89            	pushw	x
4273  0ca3 ae0000        	ldw	x,#0
4274  0ca6 89            	pushw	x
4275  0ca7 4b37          	push	#55
4276  0ca9 96            	ldw	x,sp
4277  0caa 1c000e        	addw	x,#OFST+3
4278  0cad 89            	pushw	x
4279  0cae 8d430a43      	callf	L3f_SD_SendCmd
4281  0cb2 5b09          	addw	sp,#9
4282                     ; 935       SD_CS_HIGH();
4284  0cb4 4b01          	push	#1
4285  0cb6 ae5005        	ldw	x,#20485
4286  0cb9 8d000000      	callf	f_GPIO_WriteHigh
4288  0cbd 84            	pop	a
4289                     ; 936       SD_WriteByte(SD_DUMMY_BYTE);
4291  0cbe a6ff          	ld	a,#255
4292  0cc0 8d0e0e0e      	callf	f_SD_WriteByte
4294                     ; 939       response = SD_SendCmd(SD_CMD_SD_APP_OP_COND, 0x00000000, 0xFF, SD_ANSWER_R1_EXPECTED);
4296  0cc4 4b00          	push	#0
4297  0cc6 4bff          	push	#255
4298  0cc8 ae0000        	ldw	x,#0
4299  0ccb 89            	pushw	x
4300  0ccc ae0000        	ldw	x,#0
4301  0ccf 89            	pushw	x
4302  0cd0 4b29          	push	#41
4303  0cd2 96            	ldw	x,sp
4304  0cd3 1c000e        	addw	x,#OFST+3
4305  0cd6 89            	pushw	x
4306  0cd7 8d430a43      	callf	L3f_SD_SendCmd
4308  0cdb 5b09          	addw	sp,#9
4309                     ; 940       SD_CS_HIGH();
4311  0cdd 4b01          	push	#1
4312  0cdf ae5005        	ldw	x,#20485
4313  0ce2 8d000000      	callf	f_GPIO_WriteHigh
4315  0ce6 84            	pop	a
4316                     ; 941       SD_WriteByte(SD_DUMMY_BYTE);
4318  0ce7 a6ff          	ld	a,#255
4319  0ce9 8d0e0e0e      	callf	f_SD_WriteByte
4321                     ; 943     while(response.r1 == SD_IN_IDLE_STATE);
4323  0ced 7b07          	ld	a,(OFST-4,sp)
4324  0cef a101          	cp	a,#1
4325  0cf1 27a8          	jreq	L5351
4326                     ; 944     flag_SDHC = 0;
4328  0cf3 5f            	clrw	x
4329  0cf4 bf00          	ldw	_flag_SDHC,x
4331  0cf6 ac070e07      	jpf	L3451
4332  0cfa               L3351:
4333                     ; 946   else if(response.r1 == SD_IN_IDLE_STATE)
4335  0cfa 7b07          	ld	a,(OFST-4,sp)
4336  0cfc a101          	cp	a,#1
4337  0cfe 2704          	jreq	L621
4338  0d00 ac0a0e0a      	jpf	L5451
4339  0d04               L621:
4340  0d04               L7451:
4341                     ; 952       response = SD_SendCmd(SD_CMD_APP_CMD, 0, 0xFF, SD_ANSWER_R1_EXPECTED);
4343  0d04 4b00          	push	#0
4344  0d06 4bff          	push	#255
4345  0d08 ae0000        	ldw	x,#0
4346  0d0b 89            	pushw	x
4347  0d0c ae0000        	ldw	x,#0
4348  0d0f 89            	pushw	x
4349  0d10 4b37          	push	#55
4350  0d12 96            	ldw	x,sp
4351  0d13 1c000e        	addw	x,#OFST+3
4352  0d16 89            	pushw	x
4353  0d17 8d430a43      	callf	L3f_SD_SendCmd
4355  0d1b 5b09          	addw	sp,#9
4356                     ; 953       SD_CS_HIGH();
4358  0d1d 4b01          	push	#1
4359  0d1f ae5005        	ldw	x,#20485
4360  0d22 8d000000      	callf	f_GPIO_WriteHigh
4362  0d26 84            	pop	a
4363                     ; 954       SD_WriteByte(SD_DUMMY_BYTE);
4365  0d27 a6ff          	ld	a,#255
4366  0d29 8d0e0e0e      	callf	f_SD_WriteByte
4368                     ; 957       response = SD_SendCmd(SD_CMD_SD_APP_OP_COND, 0x40000000, 0xFF, SD_ANSWER_R1_EXPECTED);
4370  0d2d 4b00          	push	#0
4371  0d2f 4bff          	push	#255
4372  0d31 ae0000        	ldw	x,#0
4373  0d34 89            	pushw	x
4374  0d35 ae4000        	ldw	x,#16384
4375  0d38 89            	pushw	x
4376  0d39 4b29          	push	#41
4377  0d3b 96            	ldw	x,sp
4378  0d3c 1c000e        	addw	x,#OFST+3
4379  0d3f 89            	pushw	x
4380  0d40 8d430a43      	callf	L3f_SD_SendCmd
4382  0d44 5b09          	addw	sp,#9
4383                     ; 958       SD_CS_HIGH();
4385  0d46 4b01          	push	#1
4386  0d48 ae5005        	ldw	x,#20485
4387  0d4b 8d000000      	callf	f_GPIO_WriteHigh
4389  0d4f 84            	pop	a
4390                     ; 959       SD_WriteByte(SD_DUMMY_BYTE);
4392  0d50 a6ff          	ld	a,#255
4393  0d52 8d0e0e0e      	callf	f_SD_WriteByte
4395                     ; 961     while(response.r1 == SD_IN_IDLE_STATE);
4397  0d56 7b07          	ld	a,(OFST-4,sp)
4398  0d58 a101          	cp	a,#1
4399  0d5a 27a8          	jreq	L7451
4400                     ; 963     if((response.r1 & SD_ILLEGAL_COMMAND) == SD_ILLEGAL_COMMAND)
4402  0d5c 7b07          	ld	a,(OFST-4,sp)
4403  0d5e a404          	and	a,#4
4404  0d60 a104          	cp	a,#4
4405  0d62 2663          	jrne	L5551
4406  0d64               L7551:
4407                     ; 967         response = SD_SendCmd(SD_CMD_APP_CMD, 0, 0xFF, SD_ANSWER_R1_EXPECTED);
4409  0d64 4b00          	push	#0
4410  0d66 4bff          	push	#255
4411  0d68 ae0000        	ldw	x,#0
4412  0d6b 89            	pushw	x
4413  0d6c ae0000        	ldw	x,#0
4414  0d6f 89            	pushw	x
4415  0d70 4b37          	push	#55
4416  0d72 96            	ldw	x,sp
4417  0d73 1c000e        	addw	x,#OFST+3
4418  0d76 89            	pushw	x
4419  0d77 8d430a43      	callf	L3f_SD_SendCmd
4421  0d7b 5b09          	addw	sp,#9
4422                     ; 968         SD_CS_HIGH();
4424  0d7d 4b01          	push	#1
4425  0d7f ae5005        	ldw	x,#20485
4426  0d82 8d000000      	callf	f_GPIO_WriteHigh
4428  0d86 84            	pop	a
4429                     ; 969         SD_WriteByte(SD_DUMMY_BYTE);
4431  0d87 a6ff          	ld	a,#255
4432  0d89 8d0e0e0e      	callf	f_SD_WriteByte
4434                     ; 970         if(response.r1 != SD_IN_IDLE_STATE)
4436  0d8d 7b07          	ld	a,(OFST-4,sp)
4437  0d8f a101          	cp	a,#1
4438  0d91 2705          	jreq	L5651
4439                     ; 972           return SD_RESPONSE_FAILURE;
4441  0d93 a6ff          	ld	a,#255
4443  0d95               L421:
4445  0d95 5b0b          	addw	sp,#11
4446  0d97 87            	retf
4447  0d98               L5651:
4448                     ; 975         response = SD_SendCmd(SD_CMD_SD_APP_OP_COND, 0x00000000, 0xFF, SD_ANSWER_R1_EXPECTED);
4450  0d98 4b00          	push	#0
4451  0d9a 4bff          	push	#255
4452  0d9c ae0000        	ldw	x,#0
4453  0d9f 89            	pushw	x
4454  0da0 ae0000        	ldw	x,#0
4455  0da3 89            	pushw	x
4456  0da4 4b29          	push	#41
4457  0da6 96            	ldw	x,sp
4458  0da7 1c000e        	addw	x,#OFST+3
4459  0daa 89            	pushw	x
4460  0dab 8d430a43      	callf	L3f_SD_SendCmd
4462  0daf 5b09          	addw	sp,#9
4463                     ; 976         SD_CS_HIGH();
4465  0db1 4b01          	push	#1
4466  0db3 ae5005        	ldw	x,#20485
4467  0db6 8d000000      	callf	f_GPIO_WriteHigh
4469  0dba 84            	pop	a
4470                     ; 977         SD_WriteByte(SD_DUMMY_BYTE);
4472  0dbb a6ff          	ld	a,#255
4473  0dbd 8d0e0e0e      	callf	f_SD_WriteByte
4475                     ; 979       while(response.r1 == SD_IN_IDLE_STATE);
4477  0dc1 7b07          	ld	a,(OFST-4,sp)
4478  0dc3 a101          	cp	a,#1
4479  0dc5 279d          	jreq	L7551
4480  0dc7               L5551:
4481                     ; 983     response = SD_SendCmd(SD_CMD_READ_OCR, 0x00000000, 0xFF, SD_ANSWER_R3_EXPECTED);
4483  0dc7 4b03          	push	#3
4484  0dc9 4bff          	push	#255
4485  0dcb ae0000        	ldw	x,#0
4486  0dce 89            	pushw	x
4487  0dcf ae0000        	ldw	x,#0
4488  0dd2 89            	pushw	x
4489  0dd3 4b3a          	push	#58
4490  0dd5 96            	ldw	x,sp
4491  0dd6 1c000e        	addw	x,#OFST+3
4492  0dd9 89            	pushw	x
4493  0dda 8d430a43      	callf	L3f_SD_SendCmd
4495  0dde 5b09          	addw	sp,#9
4496                     ; 984     SD_CS_HIGH();
4498  0de0 4b01          	push	#1
4499  0de2 ae5005        	ldw	x,#20485
4500  0de5 8d000000      	callf	f_GPIO_WriteHigh
4502  0de9 84            	pop	a
4503                     ; 985     SD_WriteByte(SD_DUMMY_BYTE);
4505  0dea a6ff          	ld	a,#255
4506  0dec 8d0e0e0e      	callf	f_SD_WriteByte
4508                     ; 986     if(response.r1 != SD_RESPONSE_NO_ERROR)
4510  0df0 0d07          	tnz	(OFST-4,sp)
4511  0df2 2704          	jreq	L7651
4512                     ; 988       return SD_RESPONSE_FAILURE;
4514  0df4 a6ff          	ld	a,#255
4516  0df6 209d          	jra	L421
4517  0df8               L7651:
4518                     ; 990     flag_SDHC = (response.r2 & 0x40) >> 6;
4520  0df8 7b08          	ld	a,(OFST-3,sp)
4521  0dfa 4e            	swap	a
4522  0dfb 44            	srl	a
4523  0dfc 44            	srl	a
4524  0dfd a403          	and	a,#3
4525  0dff 5f            	clrw	x
4526  0e00 a401          	and	a,#1
4527  0e02 5f            	clrw	x
4528  0e03 5f            	clrw	x
4529  0e04 97            	ld	xl,a
4530  0e05 bf00          	ldw	_flag_SDHC,x
4532  0e07               L3451:
4533                     ; 997   return SD_RESPONSE_NO_ERROR;
4535  0e07 4f            	clr	a
4537  0e08 208b          	jra	L421
4538  0e0a               L5451:
4539                     ; 994     return SD_RESPONSE_FAILURE;
4541  0e0a a6ff          	ld	a,#255
4543  0e0c 2087          	jra	L421
4579                     ; 1005 uint8_t SD_WriteByte(uint8_t Data)
4579                     ; 1006 {
4580                     	switch	.text
4581  0e0e               f_SD_WriteByte:
4583  0e0e 88            	push	a
4584       00000000      OFST:	set	0
4587  0e0f               L3161:
4588                     ; 1008   while(SPI_GetFlagStatus(SPI_FLAG_TXE) == RESET)
4590  0e0f a602          	ld	a,#2
4591  0e11 8d000000      	callf	f_SPI_GetFlagStatus
4593  0e15 4d            	tnz	a
4594  0e16 27f7          	jreq	L3161
4595                     ; 1013   SPI_SendData(Data);
4597  0e18 7b01          	ld	a,(OFST+1,sp)
4598  0e1a 8d000000      	callf	f_SPI_SendData
4601  0e1e               L1261:
4602                     ; 1016   while(SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET)
4604  0e1e a601          	ld	a,#1
4605  0e20 8d000000      	callf	f_SPI_GetFlagStatus
4607  0e24 4d            	tnz	a
4608  0e25 27f7          	jreq	L1261
4609                     ; 1021   return SPI_ReceiveData();
4611  0e27 8d000000      	callf	f_SPI_ReceiveData
4615  0e2b 5b01          	addw	sp,#1
4616  0e2d 87            	retf
4652                     ; 1029 uint8_t SD_ReadByte(void)
4652                     ; 1030 {
4653                     	switch	.text
4654  0e2e               f_SD_ReadByte:
4656  0e2e 88            	push	a
4657       00000001      OFST:	set	1
4660                     ; 1031   uint8_t Data = 0;
4663  0e2f               L5461:
4664                     ; 1034   while (SPI_GetFlagStatus(SPI_FLAG_TXE) == RESET)
4666  0e2f a602          	ld	a,#2
4667  0e31 8d000000      	callf	f_SPI_GetFlagStatus
4669  0e35 4d            	tnz	a
4670  0e36 27f7          	jreq	L5461
4671                     ; 1038   SPI_SendData(SD_DUMMY_BYTE);
4673  0e38 a6ff          	ld	a,#255
4674  0e3a 8d000000      	callf	f_SPI_SendData
4677  0e3e               L3561:
4678                     ; 1041   while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET)
4680  0e3e a601          	ld	a,#1
4681  0e40 8d000000      	callf	f_SPI_GetFlagStatus
4683  0e44 4d            	tnz	a
4684  0e45 27f7          	jreq	L3561
4685                     ; 1045   Data = SPI_ReceiveData();
4687  0e47 8d000000      	callf	f_SPI_ReceiveData
4689  0e4b 6b01          	ld	(OFST+0,sp),a
4691                     ; 1048   return Data;
4693  0e4d 7b01          	ld	a,(OFST+0,sp)
4696  0e4f 5b01          	addw	sp,#1
4697  0e51 87            	retf
4740                     ; 1056 uint8_t SD_ReadData(void)
4740                     ; 1057 {
4741                     	switch	.text
4742  0e52               f_SD_ReadData:
4744  0e52 89            	pushw	x
4745       00000002      OFST:	set	2
4748                     ; 1058   uint8_t timeout = 0x08;
4750  0e53 a608          	ld	a,#8
4751  0e55 6b01          	ld	(OFST-1,sp),a
4753  0e57               L1071:
4754                     ; 1063     readvalue = SD_WriteByte(SD_DUMMY_BYTE);
4756  0e57 a6ff          	ld	a,#255
4757  0e59 8d0e0e0e      	callf	f_SD_WriteByte
4759  0e5d 6b02          	ld	(OFST+0,sp),a
4761                     ; 1064     timeout--;
4763  0e5f 0a01          	dec	(OFST-1,sp)
4765                     ; 1066   }while ((readvalue == SD_DUMMY_BYTE) && timeout);
4767  0e61 7b02          	ld	a,(OFST+0,sp)
4768  0e63 a1ff          	cp	a,#255
4769  0e65 2604          	jrne	L7071
4771  0e67 0d01          	tnz	(OFST-1,sp)
4772  0e69 26ec          	jrne	L1071
4773  0e6b               L7071:
4774                     ; 1069   return readvalue;
4776  0e6b 7b02          	ld	a,(OFST+0,sp)
4779  0e6d 85            	popw	x
4780  0e6e 87            	retf
4803                     	xdef	_flag_SDHC
4804                     	xdef	f_SD_ReadData
4805                     	xdef	f_SD_ReadByte
4806                     	xdef	f_SD_WriteByte
4807                     	xdef	f_SD_GetStatus
4808                     	xdef	f_SD_GoIdleState
4809                     	xdef	f_SD_GetDataResponse
4810                     	xdef	f_SD_GetResponse
4811                     	xdef	f_SD_GetCIDRegister
4812                     	xdef	f_SD_GetCSDRegister
4813                     	xdef	f_SD_WriteMultiBlocks
4814                     	xdef	f_SD_WriteBlock
4815                     	xdef	f_SD_ReadMultiBlocks
4816                     	xdef	f_SD_ReadBlock
4817                     	xdef	f_SD_GetCardInfo
4818                     	xdef	f_SD_Detect
4819                     	xdef	f_SD_Init
4820                     	xdef	f_SD_DeInit
4821                     	xref	f_SD_LowLevel_Init
4822                     	xref	f_SD_LowLevel_DeInit
4823                     	xref	f_SPI_GetFlagStatus
4824                     	xref	f_SPI_ReceiveData
4825                     	xref	f_SPI_SendData
4826                     	xref	f_GPIO_ReadInputData
4827                     	xref	f_GPIO_WriteLow
4828                     	xref	f_GPIO_WriteHigh
4829                     	xref.b	c_lreg
4830                     	xref.b	c_x
4831                     	xref.b	c_y
4850                     	xref	d_lzmp
4851                     	xref	d_xymov
4852                     	xref	d_lgor
4853                     	xref	d_llsh
4854                     	xref	d_lor
4855                     	xref	d_umul
4856                     	xref	d_lrzmp
4857                     	xref	d_lgsbc
4858                     	xref	d_lgadd
4859                     	xref	d_ladd
4860                     	xref	d_ludv
4861                     	xref	d_uitolx
4862                     	xref	d_lgmul
4863                     	xref	d_itoly
4864                     	xref	d_itolx
4865                     	xref	d_rtol
4866                     	xref	d_lmul
4867                     	xref	d_ladc
4868                     	xref	d_lcmp
4869                     	xref	d_ltor
4870                     	xref	d_lgadc
4871                     	end
