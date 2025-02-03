   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  45                     ; 32 void SD_LowLevel_DeInit(void)
  45                     ; 33 {
  46                     	switch	.text
  47  0000               f_SD_LowLevel_DeInit:
  51                     ; 34 	SPI_Cmd(DISABLE); /*!< SD_SPI disable */
  53  0000 4f            	clr	a
  54  0001 8d000000      	callf	f_SPI_Cmd
  56                     ; 36    CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
  58  0005 ae0100        	ldw	x,#256
  59  0008 8d000000      	callf	f_CLK_PeripheralClockConfig
  61                     ; 39   GPIO_Init(SD_SPI_SCK_GPIO_PORT, SD_SPI_SCK_PIN, GPIO_MODE_IN_FL_NO_IT);
  63  000c 4b00          	push	#0
  64  000e 4b20          	push	#32
  65  0010 ae500a        	ldw	x,#20490
  66  0013 8d000000      	callf	f_GPIO_Init
  68  0017 85            	popw	x
  69                     ; 42   GPIO_Init(SD_SPI_MISO_GPIO_PORT, SD_SPI_MISO_PIN, GPIO_MODE_IN_FL_NO_IT);
  71  0018 4b00          	push	#0
  72  001a 4b80          	push	#128
  73  001c ae500a        	ldw	x,#20490
  74  001f 8d000000      	callf	f_GPIO_Init
  76  0023 85            	popw	x
  77                     ; 45   GPIO_Init(SD_SPI_MOSI_GPIO_PORT, SD_SPI_MOSI_PIN, GPIO_MODE_IN_FL_NO_IT);
  79  0024 4b00          	push	#0
  80  0026 4b40          	push	#64
  81  0028 ae500a        	ldw	x,#20490
  82  002b 8d000000      	callf	f_GPIO_Init
  84  002f 85            	popw	x
  85                     ; 48   GPIO_Init(SD_CS_GPIO_PORT, SD_CS_PIN, GPIO_MODE_IN_FL_NO_IT);
  87  0030 4b00          	push	#0
  88  0032 4b01          	push	#1
  89  0034 ae5005        	ldw	x,#20485
  90  0037 8d000000      	callf	f_GPIO_Init
  92  003b 85            	popw	x
  93                     ; 52 }
  96  003c 87            	retf
 123                     ; 55 void SD_LowLevel_Init(void)
 123                     ; 56 {
 124                     	switch	.text
 125  003d               f_SD_LowLevel_Init:
 129                     ; 58    CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE); 
 131  003d ae0101        	ldw	x,#257
 132  0040 8d000000      	callf	f_CLK_PeripheralClockConfig
 134                     ; 60    GPIO_ExternalPullUpConfig(SD_SPI_SCK_GPIO_PORT, (GPIO_Pin_TypeDef)(SD_SPI_MISO_PIN | SD_SPI_MOSI_PIN |
 134                     ; 61                              SD_SPI_SCK_PIN), ENABLE);
 136  0044 4b01          	push	#1
 137  0046 4be0          	push	#224
 138  0048 ae500a        	ldw	x,#20490
 139  004b 8d000000      	callf	f_GPIO_ExternalPullUpConfig
 141  004f 85            	popw	x
 142                     ; 64    SPI_Init( SPI_FIRSTBIT_MSB, SPI_BAUDRATEPRESCALER_4, SPI_MODE_MASTER,
 142                     ; 65             SPI_CLOCKPOLARITY_HIGH, SPI_CLOCKPHASE_2EDGE, SPI_DATADIRECTION_2LINES_FULLDUPLEX,
 142                     ; 66             SPI_NSS_SOFT, 0x07);
 144  0050 4b07          	push	#7
 145  0052 4b02          	push	#2
 146  0054 4b00          	push	#0
 147  0056 4b01          	push	#1
 148  0058 4b02          	push	#2
 149  005a 4b04          	push	#4
 150  005c ae0008        	ldw	x,#8
 151  005f 8d000000      	callf	f_SPI_Init
 153  0063 5b06          	addw	sp,#6
 154                     ; 70    SPI_Cmd( ENABLE);
 156  0065 a601          	ld	a,#1
 157  0067 8d000000      	callf	f_SPI_Cmd
 159                     ; 73    GPIO_Init(SD_CS_GPIO_PORT, SD_CS_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
 161  006b 4bd0          	push	#208
 162  006d 4b01          	push	#1
 163  006f ae5005        	ldw	x,#20485
 164  0072 8d000000      	callf	f_GPIO_Init
 166  0076 85            	popw	x
 167                     ; 74 }
 170  0077 87            	retf
 182                     	xdef	f_SD_LowLevel_Init
 183                     	xdef	f_SD_LowLevel_DeInit
 184                     	xref	f_SPI_Cmd
 185                     	xref	f_SPI_Init
 186                     	xref	f_GPIO_ExternalPullUpConfig
 187                     	xref	f_GPIO_Init
 188                     	xref	f_CLK_PeripheralClockConfig
 207                     	end
