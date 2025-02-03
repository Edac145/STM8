   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  45                     ; 58 void TIM1_DeInit(void)
  45                     ; 59 {
  46                     	switch	.text
  47  0000               f_TIM1_DeInit:
  51                     ; 60   TIM1->CR1  = TIM1_CR1_RESET_VALUE;
  53  0000 725f5250      	clr	21072
  54                     ; 61   TIM1->CR2  = TIM1_CR2_RESET_VALUE;
  56  0004 725f5251      	clr	21073
  57                     ; 62   TIM1->SMCR = TIM1_SMCR_RESET_VALUE;
  59  0008 725f5252      	clr	21074
  60                     ; 63   TIM1->ETR  = TIM1_ETR_RESET_VALUE;
  62  000c 725f5253      	clr	21075
  63                     ; 64   TIM1->IER  = TIM1_IER_RESET_VALUE;
  65  0010 725f5254      	clr	21076
  66                     ; 65   TIM1->SR2  = TIM1_SR2_RESET_VALUE;
  68  0014 725f5256      	clr	21078
  69                     ; 67   TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
  71  0018 725f525c      	clr	21084
  72                     ; 68   TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
  74  001c 725f525d      	clr	21085
  75                     ; 70   TIM1->CCMR1 = 0x01;
  77  0020 35015258      	mov	21080,#1
  78                     ; 71   TIM1->CCMR2 = 0x01;
  80  0024 35015259      	mov	21081,#1
  81                     ; 72   TIM1->CCMR3 = 0x01;
  83  0028 3501525a      	mov	21082,#1
  84                     ; 73   TIM1->CCMR4 = 0x01;
  86  002c 3501525b      	mov	21083,#1
  87                     ; 75   TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
  89  0030 725f525c      	clr	21084
  90                     ; 76   TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
  92  0034 725f525d      	clr	21085
  93                     ; 77   TIM1->CCMR1 = TIM1_CCMR1_RESET_VALUE;
  95  0038 725f5258      	clr	21080
  96                     ; 78   TIM1->CCMR2 = TIM1_CCMR2_RESET_VALUE;
  98  003c 725f5259      	clr	21081
  99                     ; 79   TIM1->CCMR3 = TIM1_CCMR3_RESET_VALUE;
 101  0040 725f525a      	clr	21082
 102                     ; 80   TIM1->CCMR4 = TIM1_CCMR4_RESET_VALUE;
 104  0044 725f525b      	clr	21083
 105                     ; 81   TIM1->CNTRH = TIM1_CNTRH_RESET_VALUE;
 107  0048 725f525e      	clr	21086
 108                     ; 82   TIM1->CNTRL = TIM1_CNTRL_RESET_VALUE;
 110  004c 725f525f      	clr	21087
 111                     ; 83   TIM1->PSCRH = TIM1_PSCRH_RESET_VALUE;
 113  0050 725f5260      	clr	21088
 114                     ; 84   TIM1->PSCRL = TIM1_PSCRL_RESET_VALUE;
 116  0054 725f5261      	clr	21089
 117                     ; 85   TIM1->ARRH  = TIM1_ARRH_RESET_VALUE;
 119  0058 35ff5262      	mov	21090,#255
 120                     ; 86   TIM1->ARRL  = TIM1_ARRL_RESET_VALUE;
 122  005c 35ff5263      	mov	21091,#255
 123                     ; 87   TIM1->CCR1H = TIM1_CCR1H_RESET_VALUE;
 125  0060 725f5265      	clr	21093
 126                     ; 88   TIM1->CCR1L = TIM1_CCR1L_RESET_VALUE;
 128  0064 725f5266      	clr	21094
 129                     ; 89   TIM1->CCR2H = TIM1_CCR2H_RESET_VALUE;
 131  0068 725f5267      	clr	21095
 132                     ; 90   TIM1->CCR2L = TIM1_CCR2L_RESET_VALUE;
 134  006c 725f5268      	clr	21096
 135                     ; 91   TIM1->CCR3H = TIM1_CCR3H_RESET_VALUE;
 137  0070 725f5269      	clr	21097
 138                     ; 92   TIM1->CCR3L = TIM1_CCR3L_RESET_VALUE;
 140  0074 725f526a      	clr	21098
 141                     ; 93   TIM1->CCR4H = TIM1_CCR4H_RESET_VALUE;
 143  0078 725f526b      	clr	21099
 144                     ; 94   TIM1->CCR4L = TIM1_CCR4L_RESET_VALUE;
 146  007c 725f526c      	clr	21100
 147                     ; 95   TIM1->OISR  = TIM1_OISR_RESET_VALUE;
 149  0080 725f526f      	clr	21103
 150                     ; 96   TIM1->EGR   = 0x01; /* TIM1_EGR_UG */
 152  0084 35015257      	mov	21079,#1
 153                     ; 97   TIM1->DTR   = TIM1_DTR_RESET_VALUE;
 155  0088 725f526e      	clr	21102
 156                     ; 98   TIM1->BKR   = TIM1_BKR_RESET_VALUE;
 158  008c 725f526d      	clr	21101
 159                     ; 99   TIM1->RCR   = TIM1_RCR_RESET_VALUE;
 161  0090 725f5264      	clr	21092
 162                     ; 100   TIM1->SR1   = TIM1_SR1_RESET_VALUE;
 164  0094 725f5255      	clr	21077
 165                     ; 101 }
 168  0098 87            	retf	
 276                     ; 111 void TIM1_TimeBaseInit(uint16_t TIM1_Prescaler,
 276                     ; 112                        TIM1_CounterMode_TypeDef TIM1_CounterMode,
 276                     ; 113                        uint16_t TIM1_Period,
 276                     ; 114                        uint8_t TIM1_RepetitionCounter)
 276                     ; 115 {
 277                     	switch	.text
 278  0099               f_TIM1_TimeBaseInit:
 280       fffffffe      OFST: set -2
 283                     ; 117   assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));
 285                     ; 120   TIM1->ARRH = (uint8_t)(TIM1_Period >> 8);
 287  0099 7b05          	ld	a,(OFST+7,sp)
 288  009b c75262        	ld	21090,a
 289                     ; 121   TIM1->ARRL = (uint8_t)(TIM1_Period);
 291  009e 7b06          	ld	a,(OFST+8,sp)
 292  00a0 c75263        	ld	21091,a
 293                     ; 124   TIM1->PSCRH = (uint8_t)(TIM1_Prescaler >> 8);
 295  00a3 9e            	ld	a,xh
 296  00a4 c75260        	ld	21088,a
 297                     ; 125   TIM1->PSCRL = (uint8_t)(TIM1_Prescaler);
 299  00a7 9f            	ld	a,xl
 300  00a8 c75261        	ld	21089,a
 301                     ; 128   TIM1->CR1 = (uint8_t)((uint8_t)(TIM1->CR1 & (uint8_t)(~(TIM1_CR1_CMS | TIM1_CR1_DIR)))
 301                     ; 129                         | (uint8_t)(TIM1_CounterMode));
 303  00ab c65250        	ld	a,21072
 304  00ae a48f          	and	a,#143
 305  00b0 1a04          	or	a,(OFST+6,sp)
 306  00b2 c75250        	ld	21072,a
 307                     ; 132   TIM1->RCR = TIM1_RepetitionCounter;
 309  00b5 7b07          	ld	a,(OFST+9,sp)
 310  00b7 c75264        	ld	21092,a
 311                     ; 133 }
 314  00ba 87            	retf	
 598                     ; 154 void TIM1_OC1Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 598                     ; 155                   TIM1_OutputState_TypeDef TIM1_OutputState,
 598                     ; 156                   TIM1_OutputNState_TypeDef TIM1_OutputNState,
 598                     ; 157                   uint16_t TIM1_Pulse,
 598                     ; 158                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 598                     ; 159                   TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
 598                     ; 160                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
 598                     ; 161                   TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
 598                     ; 162 {
 599                     	switch	.text
 600  00bb               f_TIM1_OC1Init:
 602  00bb 89            	pushw	x
 603  00bc 5203          	subw	sp,#3
 604       00000003      OFST:	set	3
 607                     ; 164   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 609                     ; 165   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 611                     ; 166   assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
 613                     ; 167   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 615                     ; 168   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
 617                     ; 169   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
 619                     ; 170   assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
 621                     ; 174   TIM1->CCER1 &= (uint8_t)(~( TIM1_CCER1_CC1E | TIM1_CCER1_CC1NE 
 621                     ; 175                              | TIM1_CCER1_CC1P | TIM1_CCER1_CC1NP));
 623  00be c6525c        	ld	a,21084
 624  00c1 a4f0          	and	a,#240
 625  00c3 c7525c        	ld	21084,a
 626                     ; 178   TIM1->CCER1 |= (uint8_t)((uint8_t)((uint8_t)(TIM1_OutputState & TIM1_CCER1_CC1E)
 626                     ; 179                                      | (uint8_t)(TIM1_OutputNState & TIM1_CCER1_CC1NE))
 626                     ; 180                            | (uint8_t)( (uint8_t)(TIM1_OCPolarity  & TIM1_CCER1_CC1P)
 626                     ; 181                                        | (uint8_t)(TIM1_OCNPolarity & TIM1_CCER1_CC1NP)));
 628  00c6 7b0d          	ld	a,(OFST+10,sp)
 629  00c8 a408          	and	a,#8
 630  00ca 6b03          	ld	(OFST+0,sp),a
 632  00cc 7b0c          	ld	a,(OFST+9,sp)
 633  00ce a402          	and	a,#2
 634  00d0 1a03          	or	a,(OFST+0,sp)
 635  00d2 6b02          	ld	(OFST-1,sp),a
 637  00d4 7b09          	ld	a,(OFST+6,sp)
 638  00d6 a404          	and	a,#4
 639  00d8 6b01          	ld	(OFST-2,sp),a
 641  00da 9f            	ld	a,xl
 642  00db a401          	and	a,#1
 643  00dd 1a01          	or	a,(OFST-2,sp)
 644  00df 1a02          	or	a,(OFST-1,sp)
 645  00e1 ca525c        	or	a,21084
 646  00e4 c7525c        	ld	21084,a
 647                     ; 184   TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_OCM)) | 
 647                     ; 185                           (uint8_t)TIM1_OCMode);
 649  00e7 c65258        	ld	a,21080
 650  00ea a48f          	and	a,#143
 651  00ec 1a04          	or	a,(OFST+1,sp)
 652  00ee c75258        	ld	21080,a
 653                     ; 188   TIM1->OISR &= (uint8_t)(~(TIM1_OISR_OIS1 | TIM1_OISR_OIS1N));
 655  00f1 c6526f        	ld	a,21103
 656  00f4 a4fc          	and	a,#252
 657  00f6 c7526f        	ld	21103,a
 658                     ; 190   TIM1->OISR |= (uint8_t)((uint8_t)( TIM1_OCIdleState & TIM1_OISR_OIS1 ) | 
 658                     ; 191                           (uint8_t)( TIM1_OCNIdleState & TIM1_OISR_OIS1N ));
 660  00f9 7b0f          	ld	a,(OFST+12,sp)
 661  00fb a402          	and	a,#2
 662  00fd 6b03          	ld	(OFST+0,sp),a
 664  00ff 7b0e          	ld	a,(OFST+11,sp)
 665  0101 a401          	and	a,#1
 666  0103 1a03          	or	a,(OFST+0,sp)
 667  0105 ca526f        	or	a,21103
 668  0108 c7526f        	ld	21103,a
 669                     ; 194   TIM1->CCR1H = (uint8_t)(TIM1_Pulse >> 8);
 671  010b 7b0a          	ld	a,(OFST+7,sp)
 672  010d c75265        	ld	21093,a
 673                     ; 195   TIM1->CCR1L = (uint8_t)(TIM1_Pulse);
 675  0110 7b0b          	ld	a,(OFST+8,sp)
 676  0112 c75266        	ld	21094,a
 677                     ; 196 }
 680  0115 5b05          	addw	sp,#5
 681  0117 87            	retf	
 784                     ; 217 void TIM1_OC2Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 784                     ; 218                   TIM1_OutputState_TypeDef TIM1_OutputState,
 784                     ; 219                   TIM1_OutputNState_TypeDef TIM1_OutputNState,
 784                     ; 220                   uint16_t TIM1_Pulse,
 784                     ; 221                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 784                     ; 222                   TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
 784                     ; 223                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
 784                     ; 224                   TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
 784                     ; 225 {
 785                     	switch	.text
 786  0118               f_TIM1_OC2Init:
 788  0118 89            	pushw	x
 789  0119 5203          	subw	sp,#3
 790       00000003      OFST:	set	3
 793                     ; 227   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 795                     ; 228   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 797                     ; 229   assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
 799                     ; 230   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 801                     ; 231   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
 803                     ; 232   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
 805                     ; 233   assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
 807                     ; 237   TIM1->CCER1 &= (uint8_t)(~( TIM1_CCER1_CC2E | TIM1_CCER1_CC2NE | 
 807                     ; 238                              TIM1_CCER1_CC2P | TIM1_CCER1_CC2NP));
 809  011b c6525c        	ld	a,21084
 810  011e a40f          	and	a,#15
 811  0120 c7525c        	ld	21084,a
 812                     ; 242   TIM1->CCER1 |= (uint8_t)((uint8_t)((uint8_t)(TIM1_OutputState & TIM1_CCER1_CC2E  ) | 
 812                     ; 243                                      (uint8_t)(TIM1_OutputNState & TIM1_CCER1_CC2NE )) | 
 812                     ; 244                            (uint8_t)((uint8_t)(TIM1_OCPolarity  & TIM1_CCER1_CC2P  ) | 
 812                     ; 245                                      (uint8_t)(TIM1_OCNPolarity & TIM1_CCER1_CC2NP )));
 814  0123 7b0d          	ld	a,(OFST+10,sp)
 815  0125 a480          	and	a,#128
 816  0127 6b03          	ld	(OFST+0,sp),a
 818  0129 7b0c          	ld	a,(OFST+9,sp)
 819  012b a420          	and	a,#32
 820  012d 1a03          	or	a,(OFST+0,sp)
 821  012f 6b02          	ld	(OFST-1,sp),a
 823  0131 7b09          	ld	a,(OFST+6,sp)
 824  0133 a440          	and	a,#64
 825  0135 6b01          	ld	(OFST-2,sp),a
 827  0137 9f            	ld	a,xl
 828  0138 a410          	and	a,#16
 829  013a 1a01          	or	a,(OFST-2,sp)
 830  013c 1a02          	or	a,(OFST-1,sp)
 831  013e ca525c        	or	a,21084
 832  0141 c7525c        	ld	21084,a
 833                     ; 248   TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_OCM)) | 
 833                     ; 249                           (uint8_t)TIM1_OCMode);
 835  0144 c65259        	ld	a,21081
 836  0147 a48f          	and	a,#143
 837  0149 1a04          	or	a,(OFST+1,sp)
 838  014b c75259        	ld	21081,a
 839                     ; 252   TIM1->OISR &= (uint8_t)(~(TIM1_OISR_OIS2 | TIM1_OISR_OIS2N));
 841  014e c6526f        	ld	a,21103
 842  0151 a4f3          	and	a,#243
 843  0153 c7526f        	ld	21103,a
 844                     ; 254   TIM1->OISR |= (uint8_t)((uint8_t)(TIM1_OISR_OIS2 & TIM1_OCIdleState) | 
 844                     ; 255                           (uint8_t)(TIM1_OISR_OIS2N & TIM1_OCNIdleState));
 846  0156 7b0f          	ld	a,(OFST+12,sp)
 847  0158 a408          	and	a,#8
 848  015a 6b03          	ld	(OFST+0,sp),a
 850  015c 7b0e          	ld	a,(OFST+11,sp)
 851  015e a404          	and	a,#4
 852  0160 1a03          	or	a,(OFST+0,sp)
 853  0162 ca526f        	or	a,21103
 854  0165 c7526f        	ld	21103,a
 855                     ; 258   TIM1->CCR2H = (uint8_t)(TIM1_Pulse >> 8);
 857  0168 7b0a          	ld	a,(OFST+7,sp)
 858  016a c75267        	ld	21095,a
 859                     ; 259   TIM1->CCR2L = (uint8_t)(TIM1_Pulse);
 861  016d 7b0b          	ld	a,(OFST+8,sp)
 862  016f c75268        	ld	21096,a
 863                     ; 260 }
 866  0172 5b05          	addw	sp,#5
 867  0174 87            	retf	
 970                     ; 281 void TIM1_OC3Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 970                     ; 282                   TIM1_OutputState_TypeDef TIM1_OutputState,
 970                     ; 283                   TIM1_OutputNState_TypeDef TIM1_OutputNState,
 970                     ; 284                   uint16_t TIM1_Pulse,
 970                     ; 285                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 970                     ; 286                   TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
 970                     ; 287                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
 970                     ; 288                   TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
 970                     ; 289 {
 971                     	switch	.text
 972  0175               f_TIM1_OC3Init:
 974  0175 89            	pushw	x
 975  0176 5203          	subw	sp,#3
 976       00000003      OFST:	set	3
 979                     ; 291   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 981                     ; 292   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 983                     ; 293   assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
 985                     ; 294   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 987                     ; 295   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
 989                     ; 296   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
 991                     ; 297   assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
 993                     ; 301   TIM1->CCER2 &= (uint8_t)(~( TIM1_CCER2_CC3E | TIM1_CCER2_CC3NE | 
 993                     ; 302                              TIM1_CCER2_CC3P | TIM1_CCER2_CC3NP));
 995  0178 c6525d        	ld	a,21085
 996  017b a4f0          	and	a,#240
 997  017d c7525d        	ld	21085,a
 998                     ; 305   TIM1->CCER2 |= (uint8_t)((uint8_t)((uint8_t)(TIM1_OutputState  & TIM1_CCER2_CC3E   ) |
 998                     ; 306                                      (uint8_t)(TIM1_OutputNState & TIM1_CCER2_CC3NE  )) | 
 998                     ; 307                            (uint8_t)((uint8_t)(TIM1_OCPolarity   & TIM1_CCER2_CC3P   ) | 
 998                     ; 308                                      (uint8_t)(TIM1_OCNPolarity  & TIM1_CCER2_CC3NP  )));
1000  0180 7b0d          	ld	a,(OFST+10,sp)
1001  0182 a408          	and	a,#8
1002  0184 6b03          	ld	(OFST+0,sp),a
1004  0186 7b0c          	ld	a,(OFST+9,sp)
1005  0188 a402          	and	a,#2
1006  018a 1a03          	or	a,(OFST+0,sp)
1007  018c 6b02          	ld	(OFST-1,sp),a
1009  018e 7b09          	ld	a,(OFST+6,sp)
1010  0190 a404          	and	a,#4
1011  0192 6b01          	ld	(OFST-2,sp),a
1013  0194 9f            	ld	a,xl
1014  0195 a401          	and	a,#1
1015  0197 1a01          	or	a,(OFST-2,sp)
1016  0199 1a02          	or	a,(OFST-1,sp)
1017  019b ca525d        	or	a,21085
1018  019e c7525d        	ld	21085,a
1019                     ; 311   TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM)) | 
1019                     ; 312                           (uint8_t)TIM1_OCMode);
1021  01a1 c6525a        	ld	a,21082
1022  01a4 a48f          	and	a,#143
1023  01a6 1a04          	or	a,(OFST+1,sp)
1024  01a8 c7525a        	ld	21082,a
1025                     ; 315   TIM1->OISR &= (uint8_t)(~(TIM1_OISR_OIS3 | TIM1_OISR_OIS3N));
1027  01ab c6526f        	ld	a,21103
1028  01ae a4cf          	and	a,#207
1029  01b0 c7526f        	ld	21103,a
1030                     ; 317   TIM1->OISR |= (uint8_t)((uint8_t)(TIM1_OISR_OIS3 & TIM1_OCIdleState) | 
1030                     ; 318                           (uint8_t)(TIM1_OISR_OIS3N & TIM1_OCNIdleState));
1032  01b3 7b0f          	ld	a,(OFST+12,sp)
1033  01b5 a420          	and	a,#32
1034  01b7 6b03          	ld	(OFST+0,sp),a
1036  01b9 7b0e          	ld	a,(OFST+11,sp)
1037  01bb a410          	and	a,#16
1038  01bd 1a03          	or	a,(OFST+0,sp)
1039  01bf ca526f        	or	a,21103
1040  01c2 c7526f        	ld	21103,a
1041                     ; 321   TIM1->CCR3H = (uint8_t)(TIM1_Pulse >> 8);
1043  01c5 7b0a          	ld	a,(OFST+7,sp)
1044  01c7 c75269        	ld	21097,a
1045                     ; 322   TIM1->CCR3L = (uint8_t)(TIM1_Pulse);
1047  01ca 7b0b          	ld	a,(OFST+8,sp)
1048  01cc c7526a        	ld	21098,a
1049                     ; 323 }
1052  01cf 5b05          	addw	sp,#5
1053  01d1 87            	retf	
1126                     ; 338 void TIM1_OC4Init(TIM1_OCMode_TypeDef TIM1_OCMode,
1126                     ; 339                   TIM1_OutputState_TypeDef TIM1_OutputState,
1126                     ; 340                   uint16_t TIM1_Pulse,
1126                     ; 341                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
1126                     ; 342                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState)
1126                     ; 343 {
1127                     	switch	.text
1128  01d2               f_TIM1_OC4Init:
1130  01d2 89            	pushw	x
1131  01d3 88            	push	a
1132       00000001      OFST:	set	1
1135                     ; 345   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
1137                     ; 346   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
1139                     ; 347   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
1141                     ; 348   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
1143                     ; 351   TIM1->CCER2 &= (uint8_t)(~(TIM1_CCER2_CC4E | TIM1_CCER2_CC4P));
1145  01d4 c6525d        	ld	a,21085
1146  01d7 a4cf          	and	a,#207
1147  01d9 c7525d        	ld	21085,a
1148                     ; 353   TIM1->CCER2 |= (uint8_t)((uint8_t)(TIM1_OutputState & TIM1_CCER2_CC4E ) |  
1148                     ; 354                            (uint8_t)(TIM1_OCPolarity  & TIM1_CCER2_CC4P ));
1150  01dc 7b09          	ld	a,(OFST+8,sp)
1151  01de a420          	and	a,#32
1152  01e0 6b01          	ld	(OFST+0,sp),a
1154  01e2 9f            	ld	a,xl
1155  01e3 a410          	and	a,#16
1156  01e5 1a01          	or	a,(OFST+0,sp)
1157  01e7 ca525d        	or	a,21085
1158  01ea c7525d        	ld	21085,a
1159                     ; 357   TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_OCM)) | 
1159                     ; 358                           TIM1_OCMode);
1161  01ed c6525b        	ld	a,21083
1162  01f0 a48f          	and	a,#143
1163  01f2 1a02          	or	a,(OFST+1,sp)
1164  01f4 c7525b        	ld	21083,a
1165                     ; 361   if (TIM1_OCIdleState != TIM1_OCIDLESTATE_RESET)
1167  01f7 7b0a          	ld	a,(OFST+9,sp)
1168  01f9 270a          	jreq	L534
1169                     ; 363     TIM1->OISR |= (uint8_t)(~TIM1_CCER2_CC4P);
1171  01fb c6526f        	ld	a,21103
1172  01fe aadf          	or	a,#223
1173  0200 c7526f        	ld	21103,a
1175  0203 2004          	jra	L734
1176  0205               L534:
1177                     ; 367     TIM1->OISR &= (uint8_t)(~TIM1_OISR_OIS4);
1179  0205 721d526f      	bres	21103,#6
1180  0209               L734:
1181                     ; 371   TIM1->CCR4H = (uint8_t)(TIM1_Pulse >> 8);
1183  0209 7b07          	ld	a,(OFST+6,sp)
1184  020b c7526b        	ld	21099,a
1185                     ; 372   TIM1->CCR4L = (uint8_t)(TIM1_Pulse);
1187  020e 7b08          	ld	a,(OFST+7,sp)
1188  0210 c7526c        	ld	21100,a
1189                     ; 373 }
1192  0213 5b03          	addw	sp,#3
1193  0215 87            	retf	
1397                     ; 388 void TIM1_BDTRConfig(TIM1_OSSIState_TypeDef TIM1_OSSIState,
1397                     ; 389                      TIM1_LockLevel_TypeDef TIM1_LockLevel,
1397                     ; 390                      uint8_t TIM1_DeadTime,
1397                     ; 391                      TIM1_BreakState_TypeDef TIM1_Break,
1397                     ; 392                      TIM1_BreakPolarity_TypeDef TIM1_BreakPolarity,
1397                     ; 393                      TIM1_AutomaticOutput_TypeDef TIM1_AutomaticOutput)
1397                     ; 394 {
1398                     	switch	.text
1399  0216               f_TIM1_BDTRConfig:
1401  0216 89            	pushw	x
1402  0217 88            	push	a
1403       00000001      OFST:	set	1
1406                     ; 396   assert_param(IS_TIM1_OSSI_STATE_OK(TIM1_OSSIState));
1408                     ; 397   assert_param(IS_TIM1_LOCK_LEVEL_OK(TIM1_LockLevel));
1410                     ; 398   assert_param(IS_TIM1_BREAK_STATE_OK(TIM1_Break));
1412                     ; 399   assert_param(IS_TIM1_BREAK_POLARITY_OK(TIM1_BreakPolarity));
1414                     ; 400   assert_param(IS_TIM1_AUTOMATIC_OUTPUT_STATE_OK(TIM1_AutomaticOutput));
1416                     ; 402   TIM1->DTR = (uint8_t)(TIM1_DeadTime);
1418  0218 7b07          	ld	a,(OFST+6,sp)
1419  021a c7526e        	ld	21102,a
1420                     ; 406   TIM1->BKR  =  (uint8_t)((uint8_t)(TIM1_OSSIState | (uint8_t)TIM1_LockLevel)  | 
1420                     ; 407                           (uint8_t)((uint8_t)(TIM1_Break | (uint8_t)TIM1_BreakPolarity)  | 
1420                     ; 408                           (uint8_t)TIM1_AutomaticOutput));
1422  021d 7b08          	ld	a,(OFST+7,sp)
1423  021f 1a09          	or	a,(OFST+8,sp)
1424  0221 1a0a          	or	a,(OFST+9,sp)
1425  0223 6b01          	ld	(OFST+0,sp),a
1427  0225 9f            	ld	a,xl
1428  0226 1a02          	or	a,(OFST+1,sp)
1429  0228 1a01          	or	a,(OFST+0,sp)
1430  022a c7526d        	ld	21101,a
1431                     ; 409 }
1434  022d 5b03          	addw	sp,#3
1435  022f 87            	retf	
1636                     ; 423 void TIM1_ICInit(TIM1_Channel_TypeDef TIM1_Channel,
1636                     ; 424                  TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
1636                     ; 425                  TIM1_ICSelection_TypeDef TIM1_ICSelection,
1636                     ; 426                  TIM1_ICPSC_TypeDef TIM1_ICPrescaler,
1636                     ; 427                  uint8_t TIM1_ICFilter)
1636                     ; 428 {
1637                     	switch	.text
1638  0230               f_TIM1_ICInit:
1640  0230 89            	pushw	x
1641       00000000      OFST:	set	0
1644                     ; 430   assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
1646                     ; 431   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
1648                     ; 432   assert_param(IS_TIM1_IC_SELECTION_OK(TIM1_ICSelection));
1650                     ; 433   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_ICPrescaler));
1652                     ; 434   assert_param(IS_TIM1_IC_FILTER_OK(TIM1_ICFilter));
1654                     ; 436   if (TIM1_Channel == TIM1_CHANNEL_1)
1656  0231 9e            	ld	a,xh
1657  0232 4d            	tnz	a
1658  0233 2616          	jrne	L766
1659                     ; 439     TI1_Config((uint8_t)TIM1_ICPolarity,
1659                     ; 440                (uint8_t)TIM1_ICSelection,
1659                     ; 441                (uint8_t)TIM1_ICFilter);
1661  0235 7b08          	ld	a,(OFST+8,sp)
1662  0237 88            	push	a
1663  0238 7b07          	ld	a,(OFST+7,sp)
1664  023a 97            	ld	xl,a
1665  023b 7b03          	ld	a,(OFST+3,sp)
1666  023d 95            	ld	xh,a
1667  023e 8dbb07bb      	callf	L3f_TI1_Config
1669  0242 84            	pop	a
1670                     ; 443     TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1672  0243 7b07          	ld	a,(OFST+7,sp)
1673  0245 8d980698      	callf	f_TIM1_SetIC1Prescaler
1676  0249 204a          	jra	L176
1677  024b               L766:
1678                     ; 445   else if (TIM1_Channel == TIM1_CHANNEL_2)
1680  024b 7b01          	ld	a,(OFST+1,sp)
1681  024d a101          	cp	a,#1
1682  024f 2616          	jrne	L376
1683                     ; 448     TI2_Config((uint8_t)TIM1_ICPolarity,
1683                     ; 449                (uint8_t)TIM1_ICSelection,
1683                     ; 450                (uint8_t)TIM1_ICFilter);
1685  0251 7b08          	ld	a,(OFST+8,sp)
1686  0253 88            	push	a
1687  0254 7b07          	ld	a,(OFST+7,sp)
1688  0256 97            	ld	xl,a
1689  0257 7b03          	ld	a,(OFST+3,sp)
1690  0259 95            	ld	xh,a
1691  025a 8deb07eb      	callf	L5f_TI2_Config
1693  025e 84            	pop	a
1694                     ; 452     TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1696  025f 7b07          	ld	a,(OFST+7,sp)
1697  0261 8da506a5      	callf	f_TIM1_SetIC2Prescaler
1700  0265 202e          	jra	L176
1701  0267               L376:
1702                     ; 454   else if (TIM1_Channel == TIM1_CHANNEL_3)
1704  0267 a102          	cp	a,#2
1705  0269 2616          	jrne	L776
1706                     ; 457     TI3_Config((uint8_t)TIM1_ICPolarity,
1706                     ; 458                (uint8_t)TIM1_ICSelection,
1706                     ; 459                (uint8_t)TIM1_ICFilter);
1708  026b 7b08          	ld	a,(OFST+8,sp)
1709  026d 88            	push	a
1710  026e 7b07          	ld	a,(OFST+7,sp)
1711  0270 97            	ld	xl,a
1712  0271 7b03          	ld	a,(OFST+3,sp)
1713  0273 95            	ld	xh,a
1714  0274 8d1b081b      	callf	L7f_TI3_Config
1716  0278 84            	pop	a
1717                     ; 461     TIM1_SetIC3Prescaler(TIM1_ICPrescaler);
1719  0279 7b07          	ld	a,(OFST+7,sp)
1720  027b 8db206b2      	callf	f_TIM1_SetIC3Prescaler
1723  027f 2014          	jra	L176
1724  0281               L776:
1725                     ; 466     TI4_Config((uint8_t)TIM1_ICPolarity,
1725                     ; 467                (uint8_t)TIM1_ICSelection,
1725                     ; 468                (uint8_t)TIM1_ICFilter);
1727  0281 7b08          	ld	a,(OFST+8,sp)
1728  0283 88            	push	a
1729  0284 7b07          	ld	a,(OFST+7,sp)
1730  0286 97            	ld	xl,a
1731  0287 7b03          	ld	a,(OFST+3,sp)
1732  0289 95            	ld	xh,a
1733  028a 8d4b084b      	callf	L11f_TI4_Config
1735  028e 84            	pop	a
1736                     ; 470     TIM1_SetIC4Prescaler(TIM1_ICPrescaler);
1738  028f 7b07          	ld	a,(OFST+7,sp)
1739  0291 8dbf06bf      	callf	f_TIM1_SetIC4Prescaler
1741  0295               L176:
1742                     ; 472 }
1745  0295 85            	popw	x
1746  0296 87            	retf	
1841                     ; 488 void TIM1_PWMIConfig(TIM1_Channel_TypeDef TIM1_Channel,
1841                     ; 489                      TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
1841                     ; 490                      TIM1_ICSelection_TypeDef TIM1_ICSelection,
1841                     ; 491                      TIM1_ICPSC_TypeDef TIM1_ICPrescaler,
1841                     ; 492                      uint8_t TIM1_ICFilter)
1841                     ; 493 {
1842                     	switch	.text
1843  0297               f_TIM1_PWMIConfig:
1845  0297 89            	pushw	x
1846  0298 89            	pushw	x
1847       00000002      OFST:	set	2
1850                     ; 494   uint8_t icpolarity = TIM1_ICPOLARITY_RISING;
1852                     ; 495   uint8_t icselection = TIM1_ICSELECTION_DIRECTTI;
1854                     ; 498   assert_param(IS_TIM1_PWMI_CHANNEL_OK(TIM1_Channel));
1856                     ; 499   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
1858                     ; 500   assert_param(IS_TIM1_IC_SELECTION_OK(TIM1_ICSelection));
1860                     ; 501   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_ICPrescaler));
1862                     ; 504   if (TIM1_ICPolarity != TIM1_ICPOLARITY_FALLING)
1864  0299 9f            	ld	a,xl
1865  029a 4a            	dec	a
1866  029b 2702          	jreq	L157
1867                     ; 506     icpolarity = TIM1_ICPOLARITY_FALLING;
1869  029d a601          	ld	a,#1
1871  029f               L157:
1872                     ; 510     icpolarity = TIM1_ICPOLARITY_RISING;
1874  029f 6b01          	ld	(OFST-1,sp),a
1876                     ; 514   if (TIM1_ICSelection == TIM1_ICSELECTION_DIRECTTI)
1878  02a1 7b08          	ld	a,(OFST+6,sp)
1879  02a3 4a            	dec	a
1880  02a4 2604          	jrne	L557
1881                     ; 516     icselection = TIM1_ICSELECTION_INDIRECTTI;
1883  02a6 a602          	ld	a,#2
1885  02a8 2002          	jra	L757
1886  02aa               L557:
1887                     ; 520     icselection = TIM1_ICSELECTION_DIRECTTI;
1889  02aa a601          	ld	a,#1
1890  02ac               L757:
1891  02ac 6b02          	ld	(OFST+0,sp),a
1893                     ; 523   if (TIM1_Channel == TIM1_CHANNEL_1)
1895  02ae 7b03          	ld	a,(OFST+1,sp)
1896  02b0 262a          	jrne	L167
1897                     ; 526     TI1_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSelection,
1897                     ; 527                (uint8_t)TIM1_ICFilter);
1899  02b2 7b0a          	ld	a,(OFST+8,sp)
1900  02b4 88            	push	a
1901  02b5 7b09          	ld	a,(OFST+7,sp)
1902  02b7 97            	ld	xl,a
1903  02b8 7b05          	ld	a,(OFST+3,sp)
1904  02ba 95            	ld	xh,a
1905  02bb 8dbb07bb      	callf	L3f_TI1_Config
1907  02bf 84            	pop	a
1908                     ; 530     TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1910  02c0 7b09          	ld	a,(OFST+7,sp)
1911  02c2 8d980698      	callf	f_TIM1_SetIC1Prescaler
1913                     ; 533     TI2_Config(icpolarity, icselection, TIM1_ICFilter);
1915  02c6 7b0a          	ld	a,(OFST+8,sp)
1916  02c8 88            	push	a
1917  02c9 7b03          	ld	a,(OFST+1,sp)
1918  02cb 97            	ld	xl,a
1919  02cc 7b02          	ld	a,(OFST+0,sp)
1920  02ce 95            	ld	xh,a
1921  02cf 8deb07eb      	callf	L5f_TI2_Config
1923  02d3 84            	pop	a
1924                     ; 536     TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1926  02d4 7b09          	ld	a,(OFST+7,sp)
1927  02d6 8da506a5      	callf	f_TIM1_SetIC2Prescaler
1930  02da 2028          	jra	L367
1931  02dc               L167:
1932                     ; 541     TI2_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSelection,
1932                     ; 542                (uint8_t)TIM1_ICFilter);
1934  02dc 7b0a          	ld	a,(OFST+8,sp)
1935  02de 88            	push	a
1936  02df 7b09          	ld	a,(OFST+7,sp)
1937  02e1 97            	ld	xl,a
1938  02e2 7b05          	ld	a,(OFST+3,sp)
1939  02e4 95            	ld	xh,a
1940  02e5 8deb07eb      	callf	L5f_TI2_Config
1942  02e9 84            	pop	a
1943                     ; 545     TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1945  02ea 7b09          	ld	a,(OFST+7,sp)
1946  02ec 8da506a5      	callf	f_TIM1_SetIC2Prescaler
1948                     ; 548     TI1_Config(icpolarity, icselection, TIM1_ICFilter);
1950  02f0 7b0a          	ld	a,(OFST+8,sp)
1951  02f2 88            	push	a
1952  02f3 7b03          	ld	a,(OFST+1,sp)
1953  02f5 97            	ld	xl,a
1954  02f6 7b02          	ld	a,(OFST+0,sp)
1955  02f8 95            	ld	xh,a
1956  02f9 8dbb07bb      	callf	L3f_TI1_Config
1958  02fd 84            	pop	a
1959                     ; 551     TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1961  02fe 7b09          	ld	a,(OFST+7,sp)
1962  0300 8d980698      	callf	f_TIM1_SetIC1Prescaler
1964  0304               L367:
1965                     ; 553 }
1968  0304 5b04          	addw	sp,#4
1969  0306 87            	retf	
2023                     ; 561 void TIM1_Cmd(FunctionalState NewState)
2023                     ; 562 {
2024                     	switch	.text
2025  0307               f_TIM1_Cmd:
2029                     ; 564   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2031                     ; 567   if (NewState != DISABLE)
2033  0307 4d            	tnz	a
2034  0308 2705          	jreq	L3101
2035                     ; 569     TIM1->CR1 |= TIM1_CR1_CEN;
2037  030a 72105250      	bset	21072,#0
2040  030e 87            	retf	
2041  030f               L3101:
2042                     ; 573     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_CEN);
2044  030f 72115250      	bres	21072,#0
2045                     ; 575 }
2048  0313 87            	retf	
2083                     ; 583 void TIM1_CtrlPWMOutputs(FunctionalState NewState)
2083                     ; 584 {
2084                     	switch	.text
2085  0314               f_TIM1_CtrlPWMOutputs:
2089                     ; 586   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2091                     ; 590   if (NewState != DISABLE)
2093  0314 4d            	tnz	a
2094  0315 2705          	jreq	L5301
2095                     ; 592     TIM1->BKR |= TIM1_BKR_MOE;
2097  0317 721e526d      	bset	21101,#7
2100  031b 87            	retf	
2101  031c               L5301:
2102                     ; 596     TIM1->BKR &= (uint8_t)(~TIM1_BKR_MOE);
2104  031c 721f526d      	bres	21101,#7
2105                     ; 598 }
2108  0320 87            	retf	
2214                     ; 617 void TIM1_ITConfig(TIM1_IT_TypeDef  TIM1_IT, FunctionalState NewState)
2214                     ; 618 {
2215                     	switch	.text
2216  0321               f_TIM1_ITConfig:
2218  0321 89            	pushw	x
2219       00000000      OFST:	set	0
2222                     ; 620   assert_param(IS_TIM1_IT_OK(TIM1_IT));
2224                     ; 621   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2226                     ; 623   if (NewState != DISABLE)
2228  0322 9f            	ld	a,xl
2229  0323 4d            	tnz	a
2230  0324 2706          	jreq	L7011
2231                     ; 626     TIM1->IER |= (uint8_t)TIM1_IT;
2233  0326 9e            	ld	a,xh
2234  0327 ca5254        	or	a,21076
2236  032a 2006          	jra	L1111
2237  032c               L7011:
2238                     ; 631     TIM1->IER &= (uint8_t)(~(uint8_t)TIM1_IT);
2240  032c 7b01          	ld	a,(OFST+1,sp)
2241  032e 43            	cpl	a
2242  032f c45254        	and	a,21076
2243  0332               L1111:
2244  0332 c75254        	ld	21076,a
2245                     ; 633 }
2248  0335 85            	popw	x
2249  0336 87            	retf	
2272                     ; 640 void TIM1_InternalClockConfig(void)
2272                     ; 641 {
2273                     	switch	.text
2274  0337               f_TIM1_InternalClockConfig:
2278                     ; 643   TIM1->SMCR &= (uint8_t)(~TIM1_SMCR_SMS);
2280  0337 c65252        	ld	a,21074
2281  033a a4f8          	and	a,#248
2282  033c c75252        	ld	21074,a
2283                     ; 644 }
2286  033f 87            	retf	
2402                     ; 662 void TIM1_ETRClockMode1Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2402                     ; 663                               TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2402                     ; 664                               uint8_t ExtTRGFilter)
2402                     ; 665 {
2403                     	switch	.text
2404  0340               f_TIM1_ETRClockMode1Config:
2406  0340 89            	pushw	x
2407       00000000      OFST:	set	0
2410                     ; 667   assert_param(IS_TIM1_EXT_PRESCALER_OK(TIM1_ExtTRGPrescaler));
2412                     ; 668   assert_param(IS_TIM1_EXT_POLARITY_OK(TIM1_ExtTRGPolarity));
2414                     ; 671   TIM1_ETRConfig(TIM1_ExtTRGPrescaler, TIM1_ExtTRGPolarity, ExtTRGFilter);
2416  0341 7b06          	ld	a,(OFST+6,sp)
2417  0343 88            	push	a
2418  0344 7b02          	ld	a,(OFST+2,sp)
2419  0346 95            	ld	xh,a
2420  0347 8d680368      	callf	f_TIM1_ETRConfig
2422  034b 84            	pop	a
2423                     ; 674   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~(uint8_t)(TIM1_SMCR_SMS | TIM1_SMCR_TS )))
2423                     ; 675                          | (uint8_t)((uint8_t)TIM1_SLAVEMODE_EXTERNAL1 | TIM1_TS_ETRF ));
2425  034c c65252        	ld	a,21074
2426  034f aa77          	or	a,#119
2427  0351 c75252        	ld	21074,a
2428                     ; 676 }
2431  0354 85            	popw	x
2432  0355 87            	retf	
2489                     ; 694 void TIM1_ETRClockMode2Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2489                     ; 695                               TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2489                     ; 696                               uint8_t ExtTRGFilter)
2489                     ; 697 {
2490                     	switch	.text
2491  0356               f_TIM1_ETRClockMode2Config:
2493  0356 89            	pushw	x
2494       00000000      OFST:	set	0
2497                     ; 699   assert_param(IS_TIM1_EXT_PRESCALER_OK(TIM1_ExtTRGPrescaler));
2499                     ; 700   assert_param(IS_TIM1_EXT_POLARITY_OK(TIM1_ExtTRGPolarity));
2501                     ; 703   TIM1_ETRConfig(TIM1_ExtTRGPrescaler, TIM1_ExtTRGPolarity, ExtTRGFilter);
2503  0357 7b06          	ld	a,(OFST+6,sp)
2504  0359 88            	push	a
2505  035a 7b02          	ld	a,(OFST+2,sp)
2506  035c 95            	ld	xh,a
2507  035d 8d680368      	callf	f_TIM1_ETRConfig
2509  0361 721c5253      	bset	21075,#6
2510                     ; 706   TIM1->ETR |= TIM1_ETR_ECE;
2512                     ; 707 }
2515  0365 5b03          	addw	sp,#3
2516  0367 87            	retf	
2571                     ; 725 void TIM1_ETRConfig(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2571                     ; 726                     TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2571                     ; 727                     uint8_t ExtTRGFilter)
2571                     ; 728 {
2572                     	switch	.text
2573  0368               f_TIM1_ETRConfig:
2575  0368 89            	pushw	x
2576       00000000      OFST:	set	0
2579                     ; 730   assert_param(IS_TIM1_EXT_TRG_FILTER_OK(ExtTRGFilter));
2581                     ; 732   TIM1->ETR |= (uint8_t)((uint8_t)(TIM1_ExtTRGPrescaler | (uint8_t)TIM1_ExtTRGPolarity )|
2581                     ; 733                          (uint8_t)ExtTRGFilter );
2583  0369 9f            	ld	a,xl
2584  036a 1a01          	or	a,(OFST+1,sp)
2585  036c 1a06          	or	a,(OFST+6,sp)
2586  036e ca5253        	or	a,21075
2587  0371 c75253        	ld	21075,a
2588                     ; 734 }
2591  0374 85            	popw	x
2592  0375 87            	retf	
2680                     ; 751 void TIM1_TIxExternalClockConfig(TIM1_TIxExternalCLK1Source_TypeDef TIM1_TIxExternalCLKSource,
2680                     ; 752                                  TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
2680                     ; 753                                  uint8_t ICFilter)
2680                     ; 754 {
2681                     	switch	.text
2682  0376               f_TIM1_TIxExternalClockConfig:
2684  0376 89            	pushw	x
2685       00000000      OFST:	set	0
2688                     ; 756   assert_param(IS_TIM1_TIXCLK_SOURCE_OK(TIM1_TIxExternalCLKSource));
2690                     ; 757   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
2692                     ; 758   assert_param(IS_TIM1_IC_FILTER_OK(ICFilter));
2694                     ; 761   if (TIM1_TIxExternalCLKSource == TIM1_TIXEXTERNALCLK1SOURCE_TI2)
2696  0377 9e            	ld	a,xh
2697  0378 a160          	cp	a,#96
2698  037a 260e          	jrne	L1131
2699                     ; 763     TI2_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSELECTION_DIRECTTI, (uint8_t)ICFilter);
2701  037c 7b06          	ld	a,(OFST+6,sp)
2702  037e 88            	push	a
2703  037f 9f            	ld	a,xl
2704  0380 ae0001        	ldw	x,#1
2705  0383 95            	ld	xh,a
2706  0384 8deb07eb      	callf	L5f_TI2_Config
2709  0388 200d          	jra	L3131
2710  038a               L1131:
2711                     ; 767     TI1_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSELECTION_DIRECTTI, (uint8_t)ICFilter);
2713  038a 7b06          	ld	a,(OFST+6,sp)
2714  038c 88            	push	a
2715  038d 7b03          	ld	a,(OFST+3,sp)
2716  038f ae0001        	ldw	x,#1
2717  0392 95            	ld	xh,a
2718  0393 8dbb07bb      	callf	L3f_TI1_Config
2720  0397               L3131:
2721  0397 84            	pop	a
2722                     ; 771   TIM1_SelectInputTrigger((TIM1_TS_TypeDef)TIM1_TIxExternalCLKSource);
2724  0398 7b01          	ld	a,(OFST+1,sp)
2725  039a 8da803a8      	callf	f_TIM1_SelectInputTrigger
2727                     ; 774   TIM1->SMCR |= (uint8_t)(TIM1_SLAVEMODE_EXTERNAL1);
2729  039e c65252        	ld	a,21074
2730  03a1 aa07          	or	a,#7
2731  03a3 c75252        	ld	21074,a
2732                     ; 775 }
2735  03a6 85            	popw	x
2736  03a7 87            	retf	
2820                     ; 787 void TIM1_SelectInputTrigger(TIM1_TS_TypeDef TIM1_InputTriggerSource)
2820                     ; 788 {
2821                     	switch	.text
2822  03a8               f_TIM1_SelectInputTrigger:
2824  03a8 88            	push	a
2825       00000000      OFST:	set	0
2828                     ; 790   assert_param(IS_TIM1_TRIGGER_SELECTION_OK(TIM1_InputTriggerSource));
2830                     ; 793   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~TIM1_SMCR_TS)) | (uint8_t)TIM1_InputTriggerSource);
2832  03a9 c65252        	ld	a,21074
2833  03ac a48f          	and	a,#143
2834  03ae 1a01          	or	a,(OFST+1,sp)
2835  03b0 c75252        	ld	21074,a
2836                     ; 794 }
2839  03b3 84            	pop	a
2840  03b4 87            	retf	
2875                     ; 803 void TIM1_UpdateDisableConfig(FunctionalState NewState)
2875                     ; 804 {
2876                     	switch	.text
2877  03b5               f_TIM1_UpdateDisableConfig:
2881                     ; 806   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2883                     ; 809   if (NewState != DISABLE)
2885  03b5 4d            	tnz	a
2886  03b6 2705          	jreq	L1731
2887                     ; 811     TIM1->CR1 |= TIM1_CR1_UDIS;
2889  03b8 72125250      	bset	21072,#1
2892  03bc 87            	retf	
2893  03bd               L1731:
2894                     ; 815     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_UDIS);
2896  03bd 72135250      	bres	21072,#1
2897                     ; 817 }
2900  03c1 87            	retf	
2957                     ; 827 void TIM1_UpdateRequestConfig(TIM1_UpdateSource_TypeDef TIM1_UpdateSource)
2957                     ; 828 {
2958                     	switch	.text
2959  03c2               f_TIM1_UpdateRequestConfig:
2963                     ; 830   assert_param(IS_TIM1_UPDATE_SOURCE_OK(TIM1_UpdateSource));
2965                     ; 833   if (TIM1_UpdateSource != TIM1_UPDATESOURCE_GLOBAL)
2967  03c2 4d            	tnz	a
2968  03c3 2705          	jreq	L3241
2969                     ; 835     TIM1->CR1 |= TIM1_CR1_URS;
2971  03c5 72145250      	bset	21072,#2
2974  03c9 87            	retf	
2975  03ca               L3241:
2976                     ; 839     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_URS);
2978  03ca 72155250      	bres	21072,#2
2979                     ; 841 }
2982  03ce 87            	retf	
3017                     ; 849 void TIM1_SelectHallSensor(FunctionalState NewState)
3017                     ; 850 {
3018                     	switch	.text
3019  03cf               f_TIM1_SelectHallSensor:
3023                     ; 852   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3025                     ; 855   if (NewState != DISABLE)
3027  03cf 4d            	tnz	a
3028  03d0 2705          	jreq	L5441
3029                     ; 857     TIM1->CR2 |= TIM1_CR2_TI1S;
3031  03d2 721e5251      	bset	21073,#7
3034  03d6 87            	retf	
3035  03d7               L5441:
3036                     ; 861     TIM1->CR2 &= (uint8_t)(~TIM1_CR2_TI1S);
3038  03d7 721f5251      	bres	21073,#7
3039                     ; 863 }
3042  03db 87            	retf	
3098                     ; 873 void TIM1_SelectOnePulseMode(TIM1_OPMode_TypeDef TIM1_OPMode)
3098                     ; 874 {
3099                     	switch	.text
3100  03dc               f_TIM1_SelectOnePulseMode:
3104                     ; 876   assert_param(IS_TIM1_OPM_MODE_OK(TIM1_OPMode));
3106                     ; 879   if (TIM1_OPMode != TIM1_OPMODE_REPETITIVE)
3108  03dc 4d            	tnz	a
3109  03dd 2705          	jreq	L7741
3110                     ; 881     TIM1->CR1 |= TIM1_CR1_OPM;
3112  03df 72165250      	bset	21072,#3
3115  03e3 87            	retf	
3116  03e4               L7741:
3117                     ; 885     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_OPM);
3119  03e4 72175250      	bres	21072,#3
3120                     ; 888 }
3123  03e8 87            	retf	
3220                     ; 903 void TIM1_SelectOutputTrigger(TIM1_TRGOSource_TypeDef TIM1_TRGOSource)
3220                     ; 904 {
3221                     	switch	.text
3222  03e9               f_TIM1_SelectOutputTrigger:
3224  03e9 88            	push	a
3225       00000000      OFST:	set	0
3228                     ; 906   assert_param(IS_TIM1_TRGO_SOURCE_OK(TIM1_TRGOSource));
3230                     ; 909   TIM1->CR2 = (uint8_t)((uint8_t)(TIM1->CR2 & (uint8_t)(~TIM1_CR2_MMS)) | 
3230                     ; 910                         (uint8_t) TIM1_TRGOSource);
3232  03ea c65251        	ld	a,21073
3233  03ed a48f          	and	a,#143
3234  03ef 1a01          	or	a,(OFST+1,sp)
3235  03f1 c75251        	ld	21073,a
3236                     ; 911 }
3239  03f4 84            	pop	a
3240  03f5 87            	retf	
3313                     ; 923 void TIM1_SelectSlaveMode(TIM1_SlaveMode_TypeDef TIM1_SlaveMode)
3313                     ; 924 {
3314                     	switch	.text
3315  03f6               f_TIM1_SelectSlaveMode:
3317  03f6 88            	push	a
3318       00000000      OFST:	set	0
3321                     ; 926   assert_param(IS_TIM1_SLAVE_MODE_OK(TIM1_SlaveMode));
3323                     ; 929   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~TIM1_SMCR_SMS)) |
3323                     ; 930                          (uint8_t)TIM1_SlaveMode);
3325  03f7 c65252        	ld	a,21074
3326  03fa a4f8          	and	a,#248
3327  03fc 1a01          	or	a,(OFST+1,sp)
3328  03fe c75252        	ld	21074,a
3329                     ; 931 }
3332  0401 84            	pop	a
3333  0402 87            	retf	
3368                     ; 939 void TIM1_SelectMasterSlaveMode(FunctionalState NewState)
3368                     ; 940 {
3369                     	switch	.text
3370  0403               f_TIM1_SelectMasterSlaveMode:
3374                     ; 942   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3376                     ; 945   if (NewState != DISABLE)
3378  0403 4d            	tnz	a
3379  0404 2705          	jreq	L3161
3380                     ; 947     TIM1->SMCR |= TIM1_SMCR_MSM;
3382  0406 721e5252      	bset	21074,#7
3385  040a 87            	retf	
3386  040b               L3161:
3387                     ; 951     TIM1->SMCR &= (uint8_t)(~TIM1_SMCR_MSM);
3389  040b 721f5252      	bres	21074,#7
3390                     ; 953 }
3393  040f 87            	retf	
3478                     ; 975 void TIM1_EncoderInterfaceConfig(TIM1_EncoderMode_TypeDef TIM1_EncoderMode,
3478                     ; 976                                  TIM1_ICPolarity_TypeDef TIM1_IC1Polarity,
3478                     ; 977                                  TIM1_ICPolarity_TypeDef TIM1_IC2Polarity)
3478                     ; 978 {
3479                     	switch	.text
3480  0410               f_TIM1_EncoderInterfaceConfig:
3482  0410 89            	pushw	x
3483       00000000      OFST:	set	0
3486                     ; 980   assert_param(IS_TIM1_ENCODER_MODE_OK(TIM1_EncoderMode));
3488                     ; 981   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_IC1Polarity));
3490                     ; 982   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_IC2Polarity));
3492                     ; 985   if (TIM1_IC1Polarity != TIM1_ICPOLARITY_RISING)
3494  0411 9f            	ld	a,xl
3495  0412 4d            	tnz	a
3496  0413 2706          	jreq	L7561
3497                     ; 987     TIM1->CCER1 |= TIM1_CCER1_CC1P;
3499  0415 7212525c      	bset	21084,#1
3501  0419 2004          	jra	L1661
3502  041b               L7561:
3503                     ; 991     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
3505  041b 7213525c      	bres	21084,#1
3506  041f               L1661:
3507                     ; 994   if (TIM1_IC2Polarity != TIM1_ICPOLARITY_RISING)
3509  041f 7b06          	ld	a,(OFST+6,sp)
3510  0421 2706          	jreq	L3661
3511                     ; 996     TIM1->CCER1 |= TIM1_CCER1_CC2P;
3513  0423 721a525c      	bset	21084,#5
3515  0427 2004          	jra	L5661
3516  0429               L3661:
3517                     ; 1000     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2P);
3519  0429 721b525c      	bres	21084,#5
3520  042d               L5661:
3521                     ; 1003   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(TIM1_SMCR_MSM | TIM1_SMCR_TS))
3521                     ; 1004                          | (uint8_t) TIM1_EncoderMode);
3523  042d c65252        	ld	a,21074
3524  0430 a4f0          	and	a,#240
3525  0432 1a01          	or	a,(OFST+1,sp)
3526  0434 c75252        	ld	21074,a
3527                     ; 1007   TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_CCxS)) 
3527                     ; 1008                           | (uint8_t) CCMR_TIxDirect_Set);
3529  0437 c65258        	ld	a,21080
3530  043a a4fc          	and	a,#252
3531  043c aa01          	or	a,#1
3532  043e c75258        	ld	21080,a
3533                     ; 1009   TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_CCxS))
3533                     ; 1010                           | (uint8_t) CCMR_TIxDirect_Set);
3535  0441 c65259        	ld	a,21081
3536  0444 a4fc          	and	a,#252
3537  0446 aa01          	or	a,#1
3538  0448 c75259        	ld	21081,a
3539                     ; 1011 }
3542  044b 85            	popw	x
3543  044c 87            	retf	
3609                     ; 1023 void TIM1_PrescalerConfig(uint16_t Prescaler,
3609                     ; 1024                           TIM1_PSCReloadMode_TypeDef TIM1_PSCReloadMode)
3609                     ; 1025 {
3610                     	switch	.text
3611  044d               f_TIM1_PrescalerConfig:
3613       fffffffe      OFST: set -2
3616                     ; 1027   assert_param(IS_TIM1_PRESCALER_RELOAD_OK(TIM1_PSCReloadMode));
3618                     ; 1030   TIM1->PSCRH = (uint8_t)(Prescaler >> 8);
3620  044d 9e            	ld	a,xh
3621  044e c75260        	ld	21088,a
3622                     ; 1031   TIM1->PSCRL = (uint8_t)(Prescaler);
3624  0451 9f            	ld	a,xl
3625  0452 c75261        	ld	21089,a
3626                     ; 1034   TIM1->EGR = (uint8_t)TIM1_PSCReloadMode;
3628  0455 7b04          	ld	a,(OFST+6,sp)
3629  0457 c75257        	ld	21079,a
3630                     ; 1035 }
3633  045a 87            	retf	
3668                     ; 1048 void TIM1_CounterModeConfig(TIM1_CounterMode_TypeDef TIM1_CounterMode)
3668                     ; 1049 {
3669                     	switch	.text
3670  045b               f_TIM1_CounterModeConfig:
3672  045b 88            	push	a
3673       00000000      OFST:	set	0
3676                     ; 1051   assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));
3678                     ; 1055   TIM1->CR1 = (uint8_t)((uint8_t)(TIM1->CR1 & (uint8_t)((uint8_t)(~TIM1_CR1_CMS) & (uint8_t)(~TIM1_CR1_DIR)))
3678                     ; 1056                         | (uint8_t)TIM1_CounterMode);
3680  045c c65250        	ld	a,21072
3681  045f a48f          	and	a,#143
3682  0461 1a01          	or	a,(OFST+1,sp)
3683  0463 c75250        	ld	21072,a
3684                     ; 1057 }
3687  0466 84            	pop	a
3688  0467 87            	retf	
3745                     ; 1067 void TIM1_ForcedOC1Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3745                     ; 1068 {
3746                     	switch	.text
3747  0468               f_TIM1_ForcedOC1Config:
3749  0468 88            	push	a
3750       00000000      OFST:	set	0
3753                     ; 1070   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3755                     ; 1073   TIM1->CCMR1 =  (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_OCM))|
3755                     ; 1074                            (uint8_t)TIM1_ForcedAction);
3757  0469 c65258        	ld	a,21080
3758  046c a48f          	and	a,#143
3759  046e 1a01          	or	a,(OFST+1,sp)
3760  0470 c75258        	ld	21080,a
3761                     ; 1075 }
3764  0473 84            	pop	a
3765  0474 87            	retf	
3800                     ; 1085 void TIM1_ForcedOC2Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3800                     ; 1086 {
3801                     	switch	.text
3802  0475               f_TIM1_ForcedOC2Config:
3804  0475 88            	push	a
3805       00000000      OFST:	set	0
3808                     ; 1088   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3810                     ; 1091   TIM1->CCMR2  =  (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_OCM))
3810                     ; 1092                             | (uint8_t)TIM1_ForcedAction);
3812  0476 c65259        	ld	a,21081
3813  0479 a48f          	and	a,#143
3814  047b 1a01          	or	a,(OFST+1,sp)
3815  047d c75259        	ld	21081,a
3816                     ; 1093 }
3819  0480 84            	pop	a
3820  0481 87            	retf	
3855                     ; 1104 void TIM1_ForcedOC3Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3855                     ; 1105 {
3856                     	switch	.text
3857  0482               f_TIM1_ForcedOC3Config:
3859  0482 88            	push	a
3860       00000000      OFST:	set	0
3863                     ; 1107   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3865                     ; 1110   TIM1->CCMR3  =  (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM))  
3865                     ; 1111                             | (uint8_t)TIM1_ForcedAction);
3867  0483 c6525a        	ld	a,21082
3868  0486 a48f          	and	a,#143
3869  0488 1a01          	or	a,(OFST+1,sp)
3870  048a c7525a        	ld	21082,a
3871                     ; 1112 }
3874  048d 84            	pop	a
3875  048e 87            	retf	
3910                     ; 1123 void TIM1_ForcedOC4Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3910                     ; 1124 {
3911                     	switch	.text
3912  048f               f_TIM1_ForcedOC4Config:
3914  048f 88            	push	a
3915       00000000      OFST:	set	0
3918                     ; 1126   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3920                     ; 1129   TIM1->CCMR4  =  (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_OCM)) 
3920                     ; 1130                             | (uint8_t)TIM1_ForcedAction);
3922  0490 c6525b        	ld	a,21083
3923  0493 a48f          	and	a,#143
3924  0495 1a01          	or	a,(OFST+1,sp)
3925  0497 c7525b        	ld	21083,a
3926                     ; 1131 }
3929  049a 84            	pop	a
3930  049b 87            	retf	
3965                     ; 1139 void TIM1_ARRPreloadConfig(FunctionalState NewState)
3965                     ; 1140 {
3966                     	switch	.text
3967  049c               f_TIM1_ARRPreloadConfig:
3971                     ; 1142   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3973                     ; 1145   if (NewState != DISABLE)
3975  049c 4d            	tnz	a
3976  049d 2705          	jreq	L5502
3977                     ; 1147     TIM1->CR1 |= TIM1_CR1_ARPE;
3979  049f 721e5250      	bset	21072,#7
3982  04a3 87            	retf	
3983  04a4               L5502:
3984                     ; 1151     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_ARPE);
3986  04a4 721f5250      	bres	21072,#7
3987                     ; 1153 }
3990  04a8 87            	retf	
4024                     ; 1161 void TIM1_SelectCOM(FunctionalState NewState)
4024                     ; 1162 {
4025                     	switch	.text
4026  04a9               f_TIM1_SelectCOM:
4030                     ; 1164   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4032                     ; 1167   if (NewState != DISABLE)
4034  04a9 4d            	tnz	a
4035  04aa 2705          	jreq	L7702
4036                     ; 1169     TIM1->CR2 |= TIM1_CR2_COMS;
4038  04ac 72145251      	bset	21073,#2
4041  04b0 87            	retf	
4042  04b1               L7702:
4043                     ; 1173     TIM1->CR2 &= (uint8_t)(~TIM1_CR2_COMS);
4045  04b1 72155251      	bres	21073,#2
4046                     ; 1175 }
4049  04b5 87            	retf	
4084                     ; 1183 void TIM1_CCPreloadControl(FunctionalState NewState)
4084                     ; 1184 {
4085                     	switch	.text
4086  04b6               f_TIM1_CCPreloadControl:
4090                     ; 1186   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4092                     ; 1189   if (NewState != DISABLE)
4094  04b6 4d            	tnz	a
4095  04b7 2705          	jreq	L1212
4096                     ; 1191     TIM1->CR2 |= TIM1_CR2_CCPC;
4098  04b9 72105251      	bset	21073,#0
4101  04bd 87            	retf	
4102  04be               L1212:
4103                     ; 1195     TIM1->CR2 &= (uint8_t)(~TIM1_CR2_CCPC);
4105  04be 72115251      	bres	21073,#0
4106                     ; 1197 }
4109  04c2 87            	retf	
4144                     ; 1205 void TIM1_OC1PreloadConfig(FunctionalState NewState)
4144                     ; 1206 {
4145                     	switch	.text
4146  04c3               f_TIM1_OC1PreloadConfig:
4150                     ; 1208   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4152                     ; 1211   if (NewState != DISABLE)
4154  04c3 4d            	tnz	a
4155  04c4 2705          	jreq	L3412
4156                     ; 1213     TIM1->CCMR1 |= TIM1_CCMR_OCxPE;
4158  04c6 72165258      	bset	21080,#3
4161  04ca 87            	retf	
4162  04cb               L3412:
4163                     ; 1217     TIM1->CCMR1 &= (uint8_t)(~TIM1_CCMR_OCxPE);
4165  04cb 72175258      	bres	21080,#3
4166                     ; 1219 }
4169  04cf 87            	retf	
4204                     ; 1227 void TIM1_OC2PreloadConfig(FunctionalState NewState)
4204                     ; 1228 {
4205                     	switch	.text
4206  04d0               f_TIM1_OC2PreloadConfig:
4210                     ; 1230   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4212                     ; 1233   if (NewState != DISABLE)
4214  04d0 4d            	tnz	a
4215  04d1 2705          	jreq	L5612
4216                     ; 1235     TIM1->CCMR2 |= TIM1_CCMR_OCxPE;
4218  04d3 72165259      	bset	21081,#3
4221  04d7 87            	retf	
4222  04d8               L5612:
4223                     ; 1239     TIM1->CCMR2 &= (uint8_t)(~TIM1_CCMR_OCxPE);
4225  04d8 72175259      	bres	21081,#3
4226                     ; 1241 }
4229  04dc 87            	retf	
4264                     ; 1249 void TIM1_OC3PreloadConfig(FunctionalState NewState)
4264                     ; 1250 {
4265                     	switch	.text
4266  04dd               f_TIM1_OC3PreloadConfig:
4270                     ; 1252   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4272                     ; 1255   if (NewState != DISABLE)
4274  04dd 4d            	tnz	a
4275  04de 2705          	jreq	L7022
4276                     ; 1257     TIM1->CCMR3 |= TIM1_CCMR_OCxPE;
4278  04e0 7216525a      	bset	21082,#3
4281  04e4 87            	retf	
4282  04e5               L7022:
4283                     ; 1261     TIM1->CCMR3 &= (uint8_t)(~TIM1_CCMR_OCxPE);
4285  04e5 7217525a      	bres	21082,#3
4286                     ; 1263 }
4289  04e9 87            	retf	
4324                     ; 1271 void TIM1_OC4PreloadConfig(FunctionalState NewState)
4324                     ; 1272 {
4325                     	switch	.text
4326  04ea               f_TIM1_OC4PreloadConfig:
4330                     ; 1274   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4332                     ; 1277   if (NewState != DISABLE)
4334  04ea 4d            	tnz	a
4335  04eb 2705          	jreq	L1322
4336                     ; 1279     TIM1->CCMR4 |= TIM1_CCMR_OCxPE;
4338  04ed 7216525b      	bset	21083,#3
4341  04f1 87            	retf	
4342  04f2               L1322:
4343                     ; 1283     TIM1->CCMR4 &= (uint8_t)(~TIM1_CCMR_OCxPE);
4345  04f2 7217525b      	bres	21083,#3
4346                     ; 1285 }
4349  04f6 87            	retf	
4383                     ; 1293 void TIM1_OC1FastConfig(FunctionalState NewState)
4383                     ; 1294 {
4384                     	switch	.text
4385  04f7               f_TIM1_OC1FastConfig:
4389                     ; 1296   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4391                     ; 1299   if (NewState != DISABLE)
4393  04f7 4d            	tnz	a
4394  04f8 2705          	jreq	L3522
4395                     ; 1301     TIM1->CCMR1 |= TIM1_CCMR_OCxFE;
4397  04fa 72145258      	bset	21080,#2
4400  04fe 87            	retf	
4401  04ff               L3522:
4402                     ; 1305     TIM1->CCMR1 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4404  04ff 72155258      	bres	21080,#2
4405                     ; 1307 }
4408  0503 87            	retf	
4442                     ; 1315 void TIM1_OC2FastConfig(FunctionalState NewState)
4442                     ; 1316 {
4443                     	switch	.text
4444  0504               f_TIM1_OC2FastConfig:
4448                     ; 1318   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4450                     ; 1321   if (NewState != DISABLE)
4452  0504 4d            	tnz	a
4453  0505 2705          	jreq	L5722
4454                     ; 1323     TIM1->CCMR2 |= TIM1_CCMR_OCxFE;
4456  0507 72145259      	bset	21081,#2
4459  050b 87            	retf	
4460  050c               L5722:
4461                     ; 1327     TIM1->CCMR2 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4463  050c 72155259      	bres	21081,#2
4464                     ; 1329 }
4467  0510 87            	retf	
4501                     ; 1337 void TIM1_OC3FastConfig(FunctionalState NewState)
4501                     ; 1338 {
4502                     	switch	.text
4503  0511               f_TIM1_OC3FastConfig:
4507                     ; 1340   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4509                     ; 1343   if (NewState != DISABLE)
4511  0511 4d            	tnz	a
4512  0512 2705          	jreq	L7132
4513                     ; 1345     TIM1->CCMR3 |= TIM1_CCMR_OCxFE;
4515  0514 7214525a      	bset	21082,#2
4518  0518 87            	retf	
4519  0519               L7132:
4520                     ; 1349     TIM1->CCMR3 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4522  0519 7215525a      	bres	21082,#2
4523                     ; 1351 }
4526  051d 87            	retf	
4560                     ; 1359 void TIM1_OC4FastConfig(FunctionalState NewState)
4560                     ; 1360 {
4561                     	switch	.text
4562  051e               f_TIM1_OC4FastConfig:
4566                     ; 1362   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4568                     ; 1365   if (NewState != DISABLE)
4570  051e 4d            	tnz	a
4571  051f 2705          	jreq	L1432
4572                     ; 1367     TIM1->CCMR4 |= TIM1_CCMR_OCxFE;
4574  0521 7214525b      	bset	21083,#2
4577  0525 87            	retf	
4578  0526               L1432:
4579                     ; 1371     TIM1->CCMR4 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4581  0526 7215525b      	bres	21083,#2
4582                     ; 1373 }
4585  052a 87            	retf	
4689                     ; 1389 void TIM1_GenerateEvent(TIM1_EventSource_TypeDef TIM1_EventSource)
4689                     ; 1390 {
4690                     	switch	.text
4691  052b               f_TIM1_GenerateEvent:
4695                     ; 1392   assert_param(IS_TIM1_EVENT_SOURCE_OK(TIM1_EventSource));
4697                     ; 1395   TIM1->EGR = (uint8_t)TIM1_EventSource;
4699  052b c75257        	ld	21079,a
4700                     ; 1396 }
4703  052e 87            	retf	
4738                     ; 1406 void TIM1_OC1PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
4738                     ; 1407 {
4739                     	switch	.text
4740  052f               f_TIM1_OC1PolarityConfig:
4744                     ; 1409   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
4746                     ; 1412   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
4748  052f 4d            	tnz	a
4749  0530 2705          	jreq	L5242
4750                     ; 1414     TIM1->CCER1 |= TIM1_CCER1_CC1P;
4752  0532 7212525c      	bset	21084,#1
4755  0536 87            	retf	
4756  0537               L5242:
4757                     ; 1418     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
4759  0537 7213525c      	bres	21084,#1
4760                     ; 1420 }
4763  053b 87            	retf	
4798                     ; 1430 void TIM1_OC1NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
4798                     ; 1431 {
4799                     	switch	.text
4800  053c               f_TIM1_OC1NPolarityConfig:
4804                     ; 1433   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
4806                     ; 1436   if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
4808  053c 4d            	tnz	a
4809  053d 2705          	jreq	L7442
4810                     ; 1438     TIM1->CCER1 |= TIM1_CCER1_CC1NP;
4812  053f 7216525c      	bset	21084,#3
4815  0543 87            	retf	
4816  0544               L7442:
4817                     ; 1442     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1NP);
4819  0544 7217525c      	bres	21084,#3
4820                     ; 1444 }
4823  0548 87            	retf	
4858                     ; 1454 void TIM1_OC2PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
4858                     ; 1455 {
4859                     	switch	.text
4860  0549               f_TIM1_OC2PolarityConfig:
4864                     ; 1457   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
4866                     ; 1460   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
4868  0549 4d            	tnz	a
4869  054a 2705          	jreq	L1742
4870                     ; 1462     TIM1->CCER1 |= TIM1_CCER1_CC2P;
4872  054c 721a525c      	bset	21084,#5
4875  0550 87            	retf	
4876  0551               L1742:
4877                     ; 1466     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2P);
4879  0551 721b525c      	bres	21084,#5
4880                     ; 1468 }
4883  0555 87            	retf	
4918                     ; 1478 void TIM1_OC2NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
4918                     ; 1479 {
4919                     	switch	.text
4920  0556               f_TIM1_OC2NPolarityConfig:
4924                     ; 1481   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
4926                     ; 1484   if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
4928  0556 4d            	tnz	a
4929  0557 2705          	jreq	L3152
4930                     ; 1486     TIM1->CCER1 |= TIM1_CCER1_CC2NP;
4932  0559 721e525c      	bset	21084,#7
4935  055d 87            	retf	
4936  055e               L3152:
4937                     ; 1490     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2NP);
4939  055e 721f525c      	bres	21084,#7
4940                     ; 1492 }
4943  0562 87            	retf	
4978                     ; 1502 void TIM1_OC3PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
4978                     ; 1503 {
4979                     	switch	.text
4980  0563               f_TIM1_OC3PolarityConfig:
4984                     ; 1505   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
4986                     ; 1508   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
4988  0563 4d            	tnz	a
4989  0564 2705          	jreq	L5352
4990                     ; 1510     TIM1->CCER2 |= TIM1_CCER2_CC3P;
4992  0566 7212525d      	bset	21085,#1
4995  056a 87            	retf	
4996  056b               L5352:
4997                     ; 1514     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3P);
4999  056b 7213525d      	bres	21085,#1
5000                     ; 1516 }
5003  056f 87            	retf	
5038                     ; 1527 void TIM1_OC3NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
5038                     ; 1528 {
5039                     	switch	.text
5040  0570               f_TIM1_OC3NPolarityConfig:
5044                     ; 1530   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
5046                     ; 1533   if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
5048  0570 4d            	tnz	a
5049  0571 2705          	jreq	L7552
5050                     ; 1535     TIM1->CCER2 |= TIM1_CCER2_CC3NP;
5052  0573 7216525d      	bset	21085,#3
5055  0577 87            	retf	
5056  0578               L7552:
5057                     ; 1539     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3NP);
5059  0578 7217525d      	bres	21085,#3
5060                     ; 1541 }
5063  057c 87            	retf	
5098                     ; 1551 void TIM1_OC4PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
5098                     ; 1552 {
5099                     	switch	.text
5100  057d               f_TIM1_OC4PolarityConfig:
5104                     ; 1554   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
5106                     ; 1557   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
5108  057d 4d            	tnz	a
5109  057e 2705          	jreq	L1062
5110                     ; 1559     TIM1->CCER2 |= TIM1_CCER2_CC4P;
5112  0580 721a525d      	bset	21085,#5
5115  0584 87            	retf	
5116  0585               L1062:
5117                     ; 1563     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4P);
5119  0585 721b525d      	bres	21085,#5
5120                     ; 1565 }
5123  0589 87            	retf	
5167                     ; 1579 void TIM1_CCxCmd(TIM1_Channel_TypeDef TIM1_Channel, FunctionalState NewState)
5167                     ; 1580 {
5168                     	switch	.text
5169  058a               f_TIM1_CCxCmd:
5171  058a 89            	pushw	x
5172       00000000      OFST:	set	0
5175                     ; 1582   assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
5177                     ; 1583   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
5179                     ; 1585   if (TIM1_Channel == TIM1_CHANNEL_1)
5181  058b 9e            	ld	a,xh
5182  058c 4d            	tnz	a
5183  058d 2610          	jrne	L7262
5184                     ; 1588     if (NewState != DISABLE)
5186  058f 9f            	ld	a,xl
5187  0590 4d            	tnz	a
5188  0591 2706          	jreq	L1362
5189                     ; 1590       TIM1->CCER1 |= TIM1_CCER1_CC1E;
5191  0593 7210525c      	bset	21084,#0
5193  0597 203e          	jra	L5362
5194  0599               L1362:
5195                     ; 1594       TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
5197  0599 7211525c      	bres	21084,#0
5198  059d 2038          	jra	L5362
5199  059f               L7262:
5200                     ; 1598   else if (TIM1_Channel == TIM1_CHANNEL_2)
5202  059f 7b01          	ld	a,(OFST+1,sp)
5203  05a1 a101          	cp	a,#1
5204  05a3 2610          	jrne	L7362
5205                     ; 1601     if (NewState != DISABLE)
5207  05a5 7b02          	ld	a,(OFST+2,sp)
5208  05a7 2706          	jreq	L1462
5209                     ; 1603       TIM1->CCER1 |= TIM1_CCER1_CC2E;
5211  05a9 7218525c      	bset	21084,#4
5213  05ad 2028          	jra	L5362
5214  05af               L1462:
5215                     ; 1607       TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2E);
5217  05af 7219525c      	bres	21084,#4
5218  05b3 2022          	jra	L5362
5219  05b5               L7362:
5220                     ; 1610   else if (TIM1_Channel == TIM1_CHANNEL_3)
5222  05b5 a102          	cp	a,#2
5223  05b7 2610          	jrne	L7462
5224                     ; 1613     if (NewState != DISABLE)
5226  05b9 7b02          	ld	a,(OFST+2,sp)
5227  05bb 2706          	jreq	L1562
5228                     ; 1615       TIM1->CCER2 |= TIM1_CCER2_CC3E;
5230  05bd 7210525d      	bset	21085,#0
5232  05c1 2014          	jra	L5362
5233  05c3               L1562:
5234                     ; 1619       TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3E);
5236  05c3 7211525d      	bres	21085,#0
5237  05c7 200e          	jra	L5362
5238  05c9               L7462:
5239                     ; 1625     if (NewState != DISABLE)
5241  05c9 7b02          	ld	a,(OFST+2,sp)
5242  05cb 2706          	jreq	L7562
5243                     ; 1627       TIM1->CCER2 |= TIM1_CCER2_CC4E;
5245  05cd 7218525d      	bset	21085,#4
5247  05d1 2004          	jra	L5362
5248  05d3               L7562:
5249                     ; 1631       TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4E);
5251  05d3 7219525d      	bres	21085,#4
5252  05d7               L5362:
5253                     ; 1634 }
5256  05d7 85            	popw	x
5257  05d8 87            	retf	
5301                     ; 1647 void TIM1_CCxNCmd(TIM1_Channel_TypeDef TIM1_Channel, FunctionalState NewState)
5301                     ; 1648 {
5302                     	switch	.text
5303  05d9               f_TIM1_CCxNCmd:
5305  05d9 89            	pushw	x
5306       00000000      OFST:	set	0
5309                     ; 1650   assert_param(IS_TIM1_COMPLEMENTARY_CHANNEL_OK(TIM1_Channel));
5311                     ; 1651   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
5313                     ; 1653   if (TIM1_Channel == TIM1_CHANNEL_1)
5315  05da 9e            	ld	a,xh
5316  05db 4d            	tnz	a
5317  05dc 2610          	jrne	L5072
5318                     ; 1656     if (NewState != DISABLE)
5320  05de 9f            	ld	a,xl
5321  05df 4d            	tnz	a
5322  05e0 2706          	jreq	L7072
5323                     ; 1658       TIM1->CCER1 |= TIM1_CCER1_CC1NE;
5325  05e2 7214525c      	bset	21084,#2
5327  05e6 2029          	jra	L3172
5328  05e8               L7072:
5329                     ; 1662       TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1NE);
5331  05e8 7215525c      	bres	21084,#2
5332  05ec 2023          	jra	L3172
5333  05ee               L5072:
5334                     ; 1665   else if (TIM1_Channel == TIM1_CHANNEL_2)
5336  05ee 7b01          	ld	a,(OFST+1,sp)
5337  05f0 4a            	dec	a
5338  05f1 2610          	jrne	L5172
5339                     ; 1668     if (NewState != DISABLE)
5341  05f3 7b02          	ld	a,(OFST+2,sp)
5342  05f5 2706          	jreq	L7172
5343                     ; 1670       TIM1->CCER1 |= TIM1_CCER1_CC2NE;
5345  05f7 721c525c      	bset	21084,#6
5347  05fb 2014          	jra	L3172
5348  05fd               L7172:
5349                     ; 1674       TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2NE);
5351  05fd 721d525c      	bres	21084,#6
5352  0601 200e          	jra	L3172
5353  0603               L5172:
5354                     ; 1680     if (NewState != DISABLE)
5356  0603 7b02          	ld	a,(OFST+2,sp)
5357  0605 2706          	jreq	L5272
5358                     ; 1682       TIM1->CCER2 |= TIM1_CCER2_CC3NE;
5360  0607 7214525d      	bset	21085,#2
5362  060b 2004          	jra	L3172
5363  060d               L5272:
5364                     ; 1686       TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3NE);
5366  060d 7215525d      	bres	21085,#2
5367  0611               L3172:
5368                     ; 1689 }
5371  0611 85            	popw	x
5372  0612 87            	retf	
5416                     ; 1712 void TIM1_SelectOCxM(TIM1_Channel_TypeDef TIM1_Channel, TIM1_OCMode_TypeDef TIM1_OCMode)
5416                     ; 1713 {
5417                     	switch	.text
5418  0613               f_TIM1_SelectOCxM:
5420  0613 89            	pushw	x
5421       00000000      OFST:	set	0
5424                     ; 1715   assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
5426                     ; 1716   assert_param(IS_TIM1_OCM_OK(TIM1_OCMode));
5428                     ; 1718   if (TIM1_Channel == TIM1_CHANNEL_1)
5430  0614 9e            	ld	a,xh
5431  0615 4d            	tnz	a
5432  0616 2610          	jrne	L3572
5433                     ; 1721     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
5435  0618 7211525c      	bres	21084,#0
5436                     ; 1724     TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_OCM)) 
5436                     ; 1725                             | (uint8_t)TIM1_OCMode);
5438  061c c65258        	ld	a,21080
5439  061f a48f          	and	a,#143
5440  0621 1a02          	or	a,(OFST+2,sp)
5441  0623 c75258        	ld	21080,a
5443  0626 2038          	jra	L5572
5444  0628               L3572:
5445                     ; 1727   else if (TIM1_Channel == TIM1_CHANNEL_2)
5447  0628 7b01          	ld	a,(OFST+1,sp)
5448  062a a101          	cp	a,#1
5449  062c 2610          	jrne	L7572
5450                     ; 1730     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2E);
5452  062e 7219525c      	bres	21084,#4
5453                     ; 1733     TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_OCM))
5453                     ; 1734                             | (uint8_t)TIM1_OCMode);
5455  0632 c65259        	ld	a,21081
5456  0635 a48f          	and	a,#143
5457  0637 1a02          	or	a,(OFST+2,sp)
5458  0639 c75259        	ld	21081,a
5460  063c 2022          	jra	L5572
5461  063e               L7572:
5462                     ; 1736   else if (TIM1_Channel == TIM1_CHANNEL_3)
5464  063e a102          	cp	a,#2
5465  0640 2610          	jrne	L3672
5466                     ; 1739     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3E);
5468  0642 7211525d      	bres	21085,#0
5469                     ; 1742     TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM)) 
5469                     ; 1743                             | (uint8_t)TIM1_OCMode);
5471  0646 c6525a        	ld	a,21082
5472  0649 a48f          	and	a,#143
5473  064b 1a02          	or	a,(OFST+2,sp)
5474  064d c7525a        	ld	21082,a
5476  0650 200e          	jra	L5572
5477  0652               L3672:
5478                     ; 1748     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4E);
5480  0652 7219525d      	bres	21085,#4
5481                     ; 1751     TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_OCM)) 
5481                     ; 1752                             | (uint8_t)TIM1_OCMode);
5483  0656 c6525b        	ld	a,21083
5484  0659 a48f          	and	a,#143
5485  065b 1a02          	or	a,(OFST+2,sp)
5486  065d c7525b        	ld	21083,a
5487  0660               L5572:
5488                     ; 1754 }
5491  0660 85            	popw	x
5492  0661 87            	retf	
5525                     ; 1762 void TIM1_SetCounter(uint16_t Counter)
5525                     ; 1763 {
5526                     	switch	.text
5527  0662               f_TIM1_SetCounter:
5531                     ; 1765   TIM1->CNTRH = (uint8_t)(Counter >> 8);
5533  0662 9e            	ld	a,xh
5534  0663 c7525e        	ld	21086,a
5535                     ; 1766   TIM1->CNTRL = (uint8_t)(Counter);
5537  0666 9f            	ld	a,xl
5538  0667 c7525f        	ld	21087,a
5539                     ; 1767 }
5542  066a 87            	retf	
5575                     ; 1775 void TIM1_SetAutoreload(uint16_t Autoreload)
5575                     ; 1776 {
5576                     	switch	.text
5577  066b               f_TIM1_SetAutoreload:
5581                     ; 1778   TIM1->ARRH = (uint8_t)(Autoreload >> 8);
5583  066b 9e            	ld	a,xh
5584  066c c75262        	ld	21090,a
5585                     ; 1779   TIM1->ARRL = (uint8_t)(Autoreload);
5587  066f 9f            	ld	a,xl
5588  0670 c75263        	ld	21091,a
5589                     ; 1780  }
5592  0673 87            	retf	
5625                     ; 1788 void TIM1_SetCompare1(uint16_t Compare1)
5625                     ; 1789 {
5626                     	switch	.text
5627  0674               f_TIM1_SetCompare1:
5631                     ; 1791   TIM1->CCR1H = (uint8_t)(Compare1 >> 8);
5633  0674 9e            	ld	a,xh
5634  0675 c75265        	ld	21093,a
5635                     ; 1792   TIM1->CCR1L = (uint8_t)(Compare1);
5637  0678 9f            	ld	a,xl
5638  0679 c75266        	ld	21094,a
5639                     ; 1793 }
5642  067c 87            	retf	
5675                     ; 1801 void TIM1_SetCompare2(uint16_t Compare2)
5675                     ; 1802 {
5676                     	switch	.text
5677  067d               f_TIM1_SetCompare2:
5681                     ; 1804   TIM1->CCR2H = (uint8_t)(Compare2 >> 8);
5683  067d 9e            	ld	a,xh
5684  067e c75267        	ld	21095,a
5685                     ; 1805   TIM1->CCR2L = (uint8_t)(Compare2);
5687  0681 9f            	ld	a,xl
5688  0682 c75268        	ld	21096,a
5689                     ; 1806 }
5692  0685 87            	retf	
5725                     ; 1814 void TIM1_SetCompare3(uint16_t Compare3)
5725                     ; 1815 {
5726                     	switch	.text
5727  0686               f_TIM1_SetCompare3:
5731                     ; 1817   TIM1->CCR3H = (uint8_t)(Compare3 >> 8);
5733  0686 9e            	ld	a,xh
5734  0687 c75269        	ld	21097,a
5735                     ; 1818   TIM1->CCR3L = (uint8_t)(Compare3);
5737  068a 9f            	ld	a,xl
5738  068b c7526a        	ld	21098,a
5739                     ; 1819 }
5742  068e 87            	retf	
5775                     ; 1827 void TIM1_SetCompare4(uint16_t Compare4)
5775                     ; 1828 {
5776                     	switch	.text
5777  068f               f_TIM1_SetCompare4:
5781                     ; 1830   TIM1->CCR4H = (uint8_t)(Compare4 >> 8);
5783  068f 9e            	ld	a,xh
5784  0690 c7526b        	ld	21099,a
5785                     ; 1831   TIM1->CCR4L = (uint8_t)(Compare4);
5787  0693 9f            	ld	a,xl
5788  0694 c7526c        	ld	21100,a
5789                     ; 1832 }
5792  0697 87            	retf	
5827                     ; 1844 void TIM1_SetIC1Prescaler(TIM1_ICPSC_TypeDef TIM1_IC1Prescaler)
5827                     ; 1845 {
5828                     	switch	.text
5829  0698               f_TIM1_SetIC1Prescaler:
5831  0698 88            	push	a
5832       00000000      OFST:	set	0
5835                     ; 1847   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC1Prescaler));
5837                     ; 1850   TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_ICxPSC)) 
5837                     ; 1851                           | (uint8_t)TIM1_IC1Prescaler);
5839  0699 c65258        	ld	a,21080
5840  069c a4f3          	and	a,#243
5841  069e 1a01          	or	a,(OFST+1,sp)
5842  06a0 c75258        	ld	21080,a
5843                     ; 1852 }
5846  06a3 84            	pop	a
5847  06a4 87            	retf	
5882                     ; 1864 void TIM1_SetIC2Prescaler(TIM1_ICPSC_TypeDef TIM1_IC2Prescaler)
5882                     ; 1865 {
5883                     	switch	.text
5884  06a5               f_TIM1_SetIC2Prescaler:
5886  06a5 88            	push	a
5887       00000000      OFST:	set	0
5890                     ; 1868   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC2Prescaler));
5892                     ; 1871   TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_ICxPSC))
5892                     ; 1872                           | (uint8_t)TIM1_IC2Prescaler);
5894  06a6 c65259        	ld	a,21081
5895  06a9 a4f3          	and	a,#243
5896  06ab 1a01          	or	a,(OFST+1,sp)
5897  06ad c75259        	ld	21081,a
5898                     ; 1873 }
5901  06b0 84            	pop	a
5902  06b1 87            	retf	
5937                     ; 1885 void TIM1_SetIC3Prescaler(TIM1_ICPSC_TypeDef TIM1_IC3Prescaler)
5937                     ; 1886 {
5938                     	switch	.text
5939  06b2               f_TIM1_SetIC3Prescaler:
5941  06b2 88            	push	a
5942       00000000      OFST:	set	0
5945                     ; 1889   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC3Prescaler));
5947                     ; 1892   TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_ICxPSC)) | 
5947                     ; 1893                           (uint8_t)TIM1_IC3Prescaler);
5949  06b3 c6525a        	ld	a,21082
5950  06b6 a4f3          	and	a,#243
5951  06b8 1a01          	or	a,(OFST+1,sp)
5952  06ba c7525a        	ld	21082,a
5953                     ; 1894 }
5956  06bd 84            	pop	a
5957  06be 87            	retf	
5992                     ; 1906 void TIM1_SetIC4Prescaler(TIM1_ICPSC_TypeDef TIM1_IC4Prescaler)
5992                     ; 1907 {
5993                     	switch	.text
5994  06bf               f_TIM1_SetIC4Prescaler:
5996  06bf 88            	push	a
5997       00000000      OFST:	set	0
6000                     ; 1910   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC4Prescaler));
6002                     ; 1913   TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_ICxPSC)) |
6002                     ; 1914                           (uint8_t)TIM1_IC4Prescaler);
6004  06c0 c6525b        	ld	a,21083
6005  06c3 a4f3          	and	a,#243
6006  06c5 1a01          	or	a,(OFST+1,sp)
6007  06c7 c7525b        	ld	21083,a
6008                     ; 1915 }
6011  06ca 84            	pop	a
6012  06cb 87            	retf	
6063                     ; 1922 uint16_t TIM1_GetCapture1(void)
6063                     ; 1923 {
6064                     	switch	.text
6065  06cc               f_TIM1_GetCapture1:
6067  06cc 5204          	subw	sp,#4
6068       00000004      OFST:	set	4
6071                     ; 1926   uint16_t tmpccr1 = 0;
6073                     ; 1927   uint8_t tmpccr1l=0, tmpccr1h=0;
6077                     ; 1929   tmpccr1h = TIM1->CCR1H;
6079  06ce c65265        	ld	a,21093
6080  06d1 6b02          	ld	(OFST-2,sp),a
6082                     ; 1930   tmpccr1l = TIM1->CCR1L;
6084  06d3 c65266        	ld	a,21094
6085  06d6 6b01          	ld	(OFST-3,sp),a
6087                     ; 1932   tmpccr1 = (uint16_t)(tmpccr1l);
6089  06d8 5f            	clrw	x
6090  06d9 97            	ld	xl,a
6091  06da 1f03          	ldw	(OFST-1,sp),x
6093                     ; 1933   tmpccr1 |= (uint16_t)((uint16_t)tmpccr1h << 8);
6095  06dc 5f            	clrw	x
6096  06dd 7b02          	ld	a,(OFST-2,sp)
6097  06df 97            	ld	xl,a
6098  06e0 7b04          	ld	a,(OFST+0,sp)
6099  06e2 01            	rrwa	x,a
6100  06e3 1a03          	or	a,(OFST-1,sp)
6101  06e5 01            	rrwa	x,a
6103                     ; 1935   return (uint16_t)tmpccr1;
6107  06e6 5b04          	addw	sp,#4
6108  06e8 87            	retf	
6159                     ; 1943 uint16_t TIM1_GetCapture2(void)
6159                     ; 1944 {
6160                     	switch	.text
6161  06e9               f_TIM1_GetCapture2:
6163  06e9 5204          	subw	sp,#4
6164       00000004      OFST:	set	4
6167                     ; 1947   uint16_t tmpccr2 = 0;
6169                     ; 1948   uint8_t tmpccr2l=0, tmpccr2h=0;
6173                     ; 1950   tmpccr2h = TIM1->CCR2H;
6175  06eb c65267        	ld	a,21095
6176  06ee 6b02          	ld	(OFST-2,sp),a
6178                     ; 1951   tmpccr2l = TIM1->CCR2L;
6180  06f0 c65268        	ld	a,21096
6181  06f3 6b01          	ld	(OFST-3,sp),a
6183                     ; 1953   tmpccr2 = (uint16_t)(tmpccr2l);
6185  06f5 5f            	clrw	x
6186  06f6 97            	ld	xl,a
6187  06f7 1f03          	ldw	(OFST-1,sp),x
6189                     ; 1954   tmpccr2 |= (uint16_t)((uint16_t)tmpccr2h << 8);
6191  06f9 5f            	clrw	x
6192  06fa 7b02          	ld	a,(OFST-2,sp)
6193  06fc 97            	ld	xl,a
6194  06fd 7b04          	ld	a,(OFST+0,sp)
6195  06ff 01            	rrwa	x,a
6196  0700 1a03          	or	a,(OFST-1,sp)
6197  0702 01            	rrwa	x,a
6199                     ; 1956   return (uint16_t)tmpccr2;
6203  0703 5b04          	addw	sp,#4
6204  0705 87            	retf	
6255                     ; 1964 uint16_t TIM1_GetCapture3(void)
6255                     ; 1965 {
6256                     	switch	.text
6257  0706               f_TIM1_GetCapture3:
6259  0706 5204          	subw	sp,#4
6260       00000004      OFST:	set	4
6263                     ; 1967   uint16_t tmpccr3 = 0;
6265                     ; 1968   uint8_t tmpccr3l=0, tmpccr3h=0;
6269                     ; 1970   tmpccr3h = TIM1->CCR3H;
6271  0708 c65269        	ld	a,21097
6272  070b 6b02          	ld	(OFST-2,sp),a
6274                     ; 1971   tmpccr3l = TIM1->CCR3L;
6276  070d c6526a        	ld	a,21098
6277  0710 6b01          	ld	(OFST-3,sp),a
6279                     ; 1973   tmpccr3 = (uint16_t)(tmpccr3l);
6281  0712 5f            	clrw	x
6282  0713 97            	ld	xl,a
6283  0714 1f03          	ldw	(OFST-1,sp),x
6285                     ; 1974   tmpccr3 |= (uint16_t)((uint16_t)tmpccr3h << 8);
6287  0716 5f            	clrw	x
6288  0717 7b02          	ld	a,(OFST-2,sp)
6289  0719 97            	ld	xl,a
6290  071a 7b04          	ld	a,(OFST+0,sp)
6291  071c 01            	rrwa	x,a
6292  071d 1a03          	or	a,(OFST-1,sp)
6293  071f 01            	rrwa	x,a
6295                     ; 1976   return (uint16_t)tmpccr3;
6299  0720 5b04          	addw	sp,#4
6300  0722 87            	retf	
6351                     ; 1984 uint16_t TIM1_GetCapture4(void)
6351                     ; 1985 {
6352                     	switch	.text
6353  0723               f_TIM1_GetCapture4:
6355  0723 5204          	subw	sp,#4
6356       00000004      OFST:	set	4
6359                     ; 1987   uint16_t tmpccr4 = 0;
6361                     ; 1988   uint8_t tmpccr4l=0, tmpccr4h=0;
6365                     ; 1990   tmpccr4h = TIM1->CCR4H;
6367  0725 c6526b        	ld	a,21099
6368  0728 6b02          	ld	(OFST-2,sp),a
6370                     ; 1991   tmpccr4l = TIM1->CCR4L;
6372  072a c6526c        	ld	a,21100
6373  072d 6b01          	ld	(OFST-3,sp),a
6375                     ; 1993   tmpccr4 = (uint16_t)(tmpccr4l);
6377  072f 5f            	clrw	x
6378  0730 97            	ld	xl,a
6379  0731 1f03          	ldw	(OFST-1,sp),x
6381                     ; 1994   tmpccr4 |= (uint16_t)((uint16_t)tmpccr4h << 8);
6383  0733 5f            	clrw	x
6384  0734 7b02          	ld	a,(OFST-2,sp)
6385  0736 97            	ld	xl,a
6386  0737 7b04          	ld	a,(OFST+0,sp)
6387  0739 01            	rrwa	x,a
6388  073a 1a03          	or	a,(OFST-1,sp)
6389  073c 01            	rrwa	x,a
6391                     ; 1996   return (uint16_t)tmpccr4;
6395  073d 5b04          	addw	sp,#4
6396  073f 87            	retf	
6429                     ; 2004 uint16_t TIM1_GetCounter(void)
6429                     ; 2005 {
6430                     	switch	.text
6431  0740               f_TIM1_GetCounter:
6433  0740 89            	pushw	x
6434       00000002      OFST:	set	2
6437                     ; 2006   uint16_t tmpcntr = 0;
6439                     ; 2008   tmpcntr = ((uint16_t)TIM1->CNTRH << 8);
6441  0741 c6525e        	ld	a,21086
6442  0744 97            	ld	xl,a
6443  0745 4f            	clr	a
6444  0746 02            	rlwa	x,a
6445  0747 1f01          	ldw	(OFST-1,sp),x
6447                     ; 2011   return (uint16_t)(tmpcntr | (uint16_t)(TIM1->CNTRL));
6449  0749 c6525f        	ld	a,21087
6450  074c 5f            	clrw	x
6451  074d 97            	ld	xl,a
6452  074e 01            	rrwa	x,a
6453  074f 1a02          	or	a,(OFST+0,sp)
6454  0751 01            	rrwa	x,a
6455  0752 1a01          	or	a,(OFST-1,sp)
6456  0754 01            	rrwa	x,a
6459  0755 5b02          	addw	sp,#2
6460  0757 87            	retf	
6493                     ; 2019 uint16_t TIM1_GetPrescaler(void)
6493                     ; 2020 {
6494                     	switch	.text
6495  0758               f_TIM1_GetPrescaler:
6497  0758 89            	pushw	x
6498       00000002      OFST:	set	2
6501                     ; 2021   uint16_t temp = 0;
6503                     ; 2023   temp = ((uint16_t)TIM1->PSCRH << 8);
6505  0759 c65260        	ld	a,21088
6506  075c 97            	ld	xl,a
6507  075d 4f            	clr	a
6508  075e 02            	rlwa	x,a
6509  075f 1f01          	ldw	(OFST-1,sp),x
6511                     ; 2026   return (uint16_t)( temp | (uint16_t)(TIM1->PSCRL));
6513  0761 c65261        	ld	a,21089
6514  0764 5f            	clrw	x
6515  0765 97            	ld	xl,a
6516  0766 01            	rrwa	x,a
6517  0767 1a02          	or	a,(OFST+0,sp)
6518  0769 01            	rrwa	x,a
6519  076a 1a01          	or	a,(OFST-1,sp)
6520  076c 01            	rrwa	x,a
6523  076d 5b02          	addw	sp,#2
6524  076f 87            	retf	
6697                     ; 2047 FlagStatus TIM1_GetFlagStatus(TIM1_FLAG_TypeDef TIM1_FLAG)
6697                     ; 2048 {
6698                     	switch	.text
6699  0770               f_TIM1_GetFlagStatus:
6701  0770 89            	pushw	x
6702  0771 89            	pushw	x
6703       00000002      OFST:	set	2
6706                     ; 2049   FlagStatus bitstatus = RESET;
6708                     ; 2050   uint8_t tim1_flag_l = 0, tim1_flag_h = 0;
6712                     ; 2053   assert_param(IS_TIM1_GET_FLAG_OK(TIM1_FLAG));
6714                     ; 2055   tim1_flag_l = (uint8_t)(TIM1->SR1 & (uint8_t)TIM1_FLAG);
6716  0772 9f            	ld	a,xl
6717  0773 c45255        	and	a,21077
6718  0776 6b01          	ld	(OFST-1,sp),a
6720                     ; 2056   tim1_flag_h = (uint8_t)((uint16_t)TIM1_FLAG >> 8);
6722  0778 7b03          	ld	a,(OFST+1,sp)
6723  077a 6b02          	ld	(OFST+0,sp),a
6725                     ; 2058   if ((tim1_flag_l | (uint8_t)(TIM1->SR2 & tim1_flag_h)) != 0)
6727  077c c45256        	and	a,21078
6728  077f 1a01          	or	a,(OFST-1,sp)
6729  0781 2702          	jreq	L5643
6730                     ; 2060     bitstatus = SET;
6732  0783 a601          	ld	a,#1
6735  0785               L5643:
6736                     ; 2064     bitstatus = RESET;
6739                     ; 2066   return (FlagStatus)(bitstatus);
6743  0785 5b04          	addw	sp,#4
6744  0787 87            	retf	
6778                     ; 2087 void TIM1_ClearFlag(TIM1_FLAG_TypeDef TIM1_FLAG)
6778                     ; 2088 {
6779                     	switch	.text
6780  0788               f_TIM1_ClearFlag:
6782  0788 89            	pushw	x
6783       00000000      OFST:	set	0
6786                     ; 2090   assert_param(IS_TIM1_CLEAR_FLAG_OK(TIM1_FLAG));
6788                     ; 2093   TIM1->SR1 = (uint8_t)(~(uint8_t)(TIM1_FLAG));
6790  0789 9f            	ld	a,xl
6791  078a 43            	cpl	a
6792  078b c75255        	ld	21077,a
6793                     ; 2094   TIM1->SR2 = (uint8_t)((uint8_t)(~((uint8_t)((uint16_t)TIM1_FLAG >> 8))) & 
6793                     ; 2095                         (uint8_t)0x1E);
6795  078e 7b01          	ld	a,(OFST+1,sp)
6796  0790 43            	cpl	a
6797  0791 a41e          	and	a,#30
6798  0793 c75256        	ld	21078,a
6799                     ; 2096 }
6802  0796 85            	popw	x
6803  0797 87            	retf	
6866                     ; 2112 ITStatus TIM1_GetITStatus(TIM1_IT_TypeDef TIM1_IT)
6866                     ; 2113 {
6867                     	switch	.text
6868  0798               f_TIM1_GetITStatus:
6870  0798 88            	push	a
6871  0799 89            	pushw	x
6872       00000002      OFST:	set	2
6875                     ; 2114   ITStatus bitstatus = RESET;
6877                     ; 2115   uint8_t TIM1_itStatus = 0, TIM1_itEnable = 0;
6881                     ; 2118   assert_param(IS_TIM1_GET_IT_OK(TIM1_IT));
6883                     ; 2120   TIM1_itStatus = (uint8_t)(TIM1->SR1 & (uint8_t)TIM1_IT);
6885  079a c45255        	and	a,21077
6886  079d 6b01          	ld	(OFST-1,sp),a
6888                     ; 2122   TIM1_itEnable = (uint8_t)(TIM1->IER & (uint8_t)TIM1_IT);
6890  079f c65254        	ld	a,21076
6891  07a2 1403          	and	a,(OFST+1,sp)
6892  07a4 6b02          	ld	(OFST+0,sp),a
6894                     ; 2124   if ((TIM1_itStatus != (uint8_t)RESET ) && (TIM1_itEnable != (uint8_t)RESET ))
6896  07a6 7b01          	ld	a,(OFST-1,sp)
6897  07a8 2708          	jreq	L1453
6899  07aa 7b02          	ld	a,(OFST+0,sp)
6900  07ac 2704          	jreq	L1453
6901                     ; 2126     bitstatus = SET;
6903  07ae a601          	ld	a,#1
6906  07b0 2001          	jra	L3453
6907  07b2               L1453:
6908                     ; 2130     bitstatus = RESET;
6910  07b2 4f            	clr	a
6912  07b3               L3453:
6913                     ; 2132   return (ITStatus)(bitstatus);
6917  07b3 5b03          	addw	sp,#3
6918  07b5 87            	retf	
6953                     ; 2149 void TIM1_ClearITPendingBit(TIM1_IT_TypeDef TIM1_IT)
6953                     ; 2150 {
6954                     	switch	.text
6955  07b6               f_TIM1_ClearITPendingBit:
6959                     ; 2152   assert_param(IS_TIM1_IT_OK(TIM1_IT));
6961                     ; 2155   TIM1->SR1 = (uint8_t)(~(uint8_t)TIM1_IT);
6963  07b6 43            	cpl	a
6964  07b7 c75255        	ld	21077,a
6965                     ; 2156 }
6968  07ba 87            	retf	
7019                     ; 2174 static void TI1_Config(uint8_t TIM1_ICPolarity,
7019                     ; 2175                        uint8_t TIM1_ICSelection,
7019                     ; 2176                        uint8_t TIM1_ICFilter)
7019                     ; 2177 {
7020                     	switch	.text
7021  07bb               L3f_TI1_Config:
7023  07bb 89            	pushw	x
7024  07bc 88            	push	a
7025       00000001      OFST:	set	1
7028                     ; 2179   TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
7030  07bd 7211525c      	bres	21084,#0
7031                     ; 2182   TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF ))) | 
7031                     ; 2183                           (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
7033  07c1 7b07          	ld	a,(OFST+6,sp)
7034  07c3 97            	ld	xl,a
7035  07c4 a610          	ld	a,#16
7036  07c6 42            	mul	x,a
7037  07c7 9f            	ld	a,xl
7038  07c8 1a03          	or	a,(OFST+2,sp)
7039  07ca 6b01          	ld	(OFST+0,sp),a
7041  07cc c65258        	ld	a,21080
7042  07cf a40c          	and	a,#12
7043  07d1 1a01          	or	a,(OFST+0,sp)
7044  07d3 c75258        	ld	21080,a
7045                     ; 2186   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7047  07d6 7b02          	ld	a,(OFST+1,sp)
7048  07d8 2706          	jreq	L1163
7049                     ; 2188     TIM1->CCER1 |= TIM1_CCER1_CC1P;
7051  07da 7212525c      	bset	21084,#1
7053  07de 2004          	jra	L3163
7054  07e0               L1163:
7055                     ; 2192     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
7057  07e0 7213525c      	bres	21084,#1
7058  07e4               L3163:
7059                     ; 2196   TIM1->CCER1 |=  TIM1_CCER1_CC1E;
7061  07e4 7210525c      	bset	21084,#0
7062                     ; 2197 }
7065  07e8 5b03          	addw	sp,#3
7066  07ea 87            	retf	
7117                     ; 2215 static void TI2_Config(uint8_t TIM1_ICPolarity,
7117                     ; 2216                        uint8_t TIM1_ICSelection,
7117                     ; 2217                        uint8_t TIM1_ICFilter)
7117                     ; 2218 {
7118                     	switch	.text
7119  07eb               L5f_TI2_Config:
7121  07eb 89            	pushw	x
7122  07ec 88            	push	a
7123       00000001      OFST:	set	1
7126                     ; 2220   TIM1->CCER1 &=  (uint8_t)(~TIM1_CCER1_CC2E);
7128  07ed 7219525c      	bres	21084,#4
7129                     ; 2223   TIM1->CCMR2  = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF ))) 
7129                     ; 2224                            | (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
7131  07f1 7b07          	ld	a,(OFST+6,sp)
7132  07f3 97            	ld	xl,a
7133  07f4 a610          	ld	a,#16
7134  07f6 42            	mul	x,a
7135  07f7 9f            	ld	a,xl
7136  07f8 1a03          	or	a,(OFST+2,sp)
7137  07fa 6b01          	ld	(OFST+0,sp),a
7139  07fc c65259        	ld	a,21081
7140  07ff a40c          	and	a,#12
7141  0801 1a01          	or	a,(OFST+0,sp)
7142  0803 c75259        	ld	21081,a
7143                     ; 2226   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7145  0806 7b02          	ld	a,(OFST+1,sp)
7146  0808 2706          	jreq	L3463
7147                     ; 2228     TIM1->CCER1 |= TIM1_CCER1_CC2P;
7149  080a 721a525c      	bset	21084,#5
7151  080e 2004          	jra	L5463
7152  0810               L3463:
7153                     ; 2232     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2P);
7155  0810 721b525c      	bres	21084,#5
7156  0814               L5463:
7157                     ; 2235   TIM1->CCER1 |=  TIM1_CCER1_CC2E;
7159  0814 7218525c      	bset	21084,#4
7160                     ; 2236 }
7163  0818 5b03          	addw	sp,#3
7164  081a 87            	retf	
7215                     ; 2254 static void TI3_Config(uint8_t TIM1_ICPolarity,
7215                     ; 2255                        uint8_t TIM1_ICSelection,
7215                     ; 2256                        uint8_t TIM1_ICFilter)
7215                     ; 2257 {
7216                     	switch	.text
7217  081b               L7f_TI3_Config:
7219  081b 89            	pushw	x
7220  081c 88            	push	a
7221       00000001      OFST:	set	1
7224                     ; 2259   TIM1->CCER2 &=  (uint8_t)(~TIM1_CCER2_CC3E);
7226  081d 7211525d      	bres	21085,#0
7227                     ; 2262   TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF))) 
7227                     ; 2263                           | (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
7229  0821 7b07          	ld	a,(OFST+6,sp)
7230  0823 97            	ld	xl,a
7231  0824 a610          	ld	a,#16
7232  0826 42            	mul	x,a
7233  0827 9f            	ld	a,xl
7234  0828 1a03          	or	a,(OFST+2,sp)
7235  082a 6b01          	ld	(OFST+0,sp),a
7237  082c c6525a        	ld	a,21082
7238  082f a40c          	and	a,#12
7239  0831 1a01          	or	a,(OFST+0,sp)
7240  0833 c7525a        	ld	21082,a
7241                     ; 2266   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7243  0836 7b02          	ld	a,(OFST+1,sp)
7244  0838 2706          	jreq	L5763
7245                     ; 2268     TIM1->CCER2 |= TIM1_CCER2_CC3P;
7247  083a 7212525d      	bset	21085,#1
7249  083e 2004          	jra	L7763
7250  0840               L5763:
7251                     ; 2272     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3P);
7253  0840 7213525d      	bres	21085,#1
7254  0844               L7763:
7255                     ; 2275   TIM1->CCER2 |=  TIM1_CCER2_CC3E;
7257  0844 7210525d      	bset	21085,#0
7258                     ; 2276 }
7261  0848 5b03          	addw	sp,#3
7262  084a 87            	retf	
7313                     ; 2294 static void TI4_Config(uint8_t TIM1_ICPolarity,
7313                     ; 2295                        uint8_t TIM1_ICSelection,
7313                     ; 2296                        uint8_t TIM1_ICFilter)
7313                     ; 2297 {
7314                     	switch	.text
7315  084b               L11f_TI4_Config:
7317  084b 89            	pushw	x
7318  084c 88            	push	a
7319       00000001      OFST:	set	1
7322                     ; 2299   TIM1->CCER2 &=  (uint8_t)(~TIM1_CCER2_CC4E);
7324  084d 7219525d      	bres	21085,#4
7325                     ; 2302   TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF )))
7325                     ; 2303                           | (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
7327  0851 7b07          	ld	a,(OFST+6,sp)
7328  0853 97            	ld	xl,a
7329  0854 a610          	ld	a,#16
7330  0856 42            	mul	x,a
7331  0857 9f            	ld	a,xl
7332  0858 1a03          	or	a,(OFST+2,sp)
7333  085a 6b01          	ld	(OFST+0,sp),a
7335  085c c6525b        	ld	a,21083
7336  085f a40c          	and	a,#12
7337  0861 1a01          	or	a,(OFST+0,sp)
7338  0863 c7525b        	ld	21083,a
7339                     ; 2306   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7341  0866 7b02          	ld	a,(OFST+1,sp)
7342  0868 2706          	jreq	L7273
7343                     ; 2308     TIM1->CCER2 |= TIM1_CCER2_CC4P;
7345  086a 721a525d      	bset	21085,#5
7347  086e 2004          	jra	L1373
7348  0870               L7273:
7349                     ; 2312     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4P);
7351  0870 721b525d      	bres	21085,#5
7352  0874               L1373:
7353                     ; 2316   TIM1->CCER2 |=  TIM1_CCER2_CC4E;
7355  0874 7218525d      	bset	21085,#4
7356                     ; 2317 }
7359  0878 5b03          	addw	sp,#3
7360  087a 87            	retf	
7372                     	xdef	f_TIM1_ClearITPendingBit
7373                     	xdef	f_TIM1_GetITStatus
7374                     	xdef	f_TIM1_ClearFlag
7375                     	xdef	f_TIM1_GetFlagStatus
7376                     	xdef	f_TIM1_GetPrescaler
7377                     	xdef	f_TIM1_GetCounter
7378                     	xdef	f_TIM1_GetCapture4
7379                     	xdef	f_TIM1_GetCapture3
7380                     	xdef	f_TIM1_GetCapture2
7381                     	xdef	f_TIM1_GetCapture1
7382                     	xdef	f_TIM1_SetIC4Prescaler
7383                     	xdef	f_TIM1_SetIC3Prescaler
7384                     	xdef	f_TIM1_SetIC2Prescaler
7385                     	xdef	f_TIM1_SetIC1Prescaler
7386                     	xdef	f_TIM1_SetCompare4
7387                     	xdef	f_TIM1_SetCompare3
7388                     	xdef	f_TIM1_SetCompare2
7389                     	xdef	f_TIM1_SetCompare1
7390                     	xdef	f_TIM1_SetAutoreload
7391                     	xdef	f_TIM1_SetCounter
7392                     	xdef	f_TIM1_SelectOCxM
7393                     	xdef	f_TIM1_CCxNCmd
7394                     	xdef	f_TIM1_CCxCmd
7395                     	xdef	f_TIM1_OC4PolarityConfig
7396                     	xdef	f_TIM1_OC3NPolarityConfig
7397                     	xdef	f_TIM1_OC3PolarityConfig
7398                     	xdef	f_TIM1_OC2NPolarityConfig
7399                     	xdef	f_TIM1_OC2PolarityConfig
7400                     	xdef	f_TIM1_OC1NPolarityConfig
7401                     	xdef	f_TIM1_OC1PolarityConfig
7402                     	xdef	f_TIM1_GenerateEvent
7403                     	xdef	f_TIM1_OC4FastConfig
7404                     	xdef	f_TIM1_OC3FastConfig
7405                     	xdef	f_TIM1_OC2FastConfig
7406                     	xdef	f_TIM1_OC1FastConfig
7407                     	xdef	f_TIM1_OC4PreloadConfig
7408                     	xdef	f_TIM1_OC3PreloadConfig
7409                     	xdef	f_TIM1_OC2PreloadConfig
7410                     	xdef	f_TIM1_OC1PreloadConfig
7411                     	xdef	f_TIM1_CCPreloadControl
7412                     	xdef	f_TIM1_SelectCOM
7413                     	xdef	f_TIM1_ARRPreloadConfig
7414                     	xdef	f_TIM1_ForcedOC4Config
7415                     	xdef	f_TIM1_ForcedOC3Config
7416                     	xdef	f_TIM1_ForcedOC2Config
7417                     	xdef	f_TIM1_ForcedOC1Config
7418                     	xdef	f_TIM1_CounterModeConfig
7419                     	xdef	f_TIM1_PrescalerConfig
7420                     	xdef	f_TIM1_EncoderInterfaceConfig
7421                     	xdef	f_TIM1_SelectMasterSlaveMode
7422                     	xdef	f_TIM1_SelectSlaveMode
7423                     	xdef	f_TIM1_SelectOutputTrigger
7424                     	xdef	f_TIM1_SelectOnePulseMode
7425                     	xdef	f_TIM1_SelectHallSensor
7426                     	xdef	f_TIM1_UpdateRequestConfig
7427                     	xdef	f_TIM1_UpdateDisableConfig
7428                     	xdef	f_TIM1_SelectInputTrigger
7429                     	xdef	f_TIM1_TIxExternalClockConfig
7430                     	xdef	f_TIM1_ETRConfig
7431                     	xdef	f_TIM1_ETRClockMode2Config
7432                     	xdef	f_TIM1_ETRClockMode1Config
7433                     	xdef	f_TIM1_InternalClockConfig
7434                     	xdef	f_TIM1_ITConfig
7435                     	xdef	f_TIM1_CtrlPWMOutputs
7436                     	xdef	f_TIM1_Cmd
7437                     	xdef	f_TIM1_PWMIConfig
7438                     	xdef	f_TIM1_ICInit
7439                     	xdef	f_TIM1_BDTRConfig
7440                     	xdef	f_TIM1_OC4Init
7441                     	xdef	f_TIM1_OC3Init
7442                     	xdef	f_TIM1_OC2Init
7443                     	xdef	f_TIM1_OC1Init
7444                     	xdef	f_TIM1_TimeBaseInit
7445                     	xdef	f_TIM1_DeInit
7464                     	end
