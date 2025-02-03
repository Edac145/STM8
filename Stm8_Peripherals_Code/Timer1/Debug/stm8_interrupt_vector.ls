   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  17                     .const:	section	.text
  18  0000               __vectab:
  19  0000 82            	dc.b	130
  21  0001 00            	dc.b	page(f__stext)
  22  0002 0000          	dc.w	f__stext
  23  0004 82            	dc.b	130
  25  0005 00            	dc.b	page(f_NonHandledInterrupt)
  26  0006 0000          	dc.w	f_NonHandledInterrupt
  27  0008 82            	dc.b	130
  29  0009 00            	dc.b	page(f_NonHandledInterrupt)
  30  000a 0000          	dc.w	f_NonHandledInterrupt
  31  000c 82            	dc.b	130
  33  000d 00            	dc.b	page(f_NonHandledInterrupt)
  34  000e 0000          	dc.w	f_NonHandledInterrupt
  35  0010 82            	dc.b	130
  37  0011 00            	dc.b	page(f_NonHandledInterrupt)
  38  0012 0000          	dc.w	f_NonHandledInterrupt
  39  0014 82            	dc.b	130
  41  0015 00            	dc.b	page(f_NonHandledInterrupt)
  42  0016 0000          	dc.w	f_NonHandledInterrupt
  43  0018 82            	dc.b	130
  45  0019 00            	dc.b	page(f_NonHandledInterrupt)
  46  001a 0000          	dc.w	f_NonHandledInterrupt
  47  001c 82            	dc.b	130
  49  001d 00            	dc.b	page(f_NonHandledInterrupt)
  50  001e 0000          	dc.w	f_NonHandledInterrupt
  51  0020 82            	dc.b	130
  53  0021 00            	dc.b	page(f_NonHandledInterrupt)
  54  0022 0000          	dc.w	f_NonHandledInterrupt
  55  0024 82            	dc.b	130
  57  0025 00            	dc.b	page(f_NonHandledInterrupt)
  58  0026 0000          	dc.w	f_NonHandledInterrupt
  59  0028 82            	dc.b	130
  61  0029 00            	dc.b	page(f_NonHandledInterrupt)
  62  002a 0000          	dc.w	f_NonHandledInterrupt
  63  002c 82            	dc.b	130
  65  002d 00            	dc.b	page(f_NonHandledInterrupt)
  66  002e 0000          	dc.w	f_NonHandledInterrupt
  67  0030 82            	dc.b	130
  69  0031 00            	dc.b	page(f_NonHandledInterrupt)
  70  0032 0000          	dc.w	f_NonHandledInterrupt
  71  0034 82            	dc.b	130
  73  0035 00            	dc.b	page(f_TIM1_UPD_IRQHandler)
  74  0036 0000          	dc.w	f_TIM1_UPD_IRQHandler
  75  0038 82            	dc.b	130
  77  0039 00            	dc.b	page(f_TIM1_CH1_CCP_IRQHandler)
  78  003a 0000          	dc.w	f_TIM1_CH1_CCP_IRQHandler
  79  003c 82            	dc.b	130
  81  003d 00            	dc.b	page(f_NonHandledInterrupt)
  82  003e 0000          	dc.w	f_NonHandledInterrupt
  83  0040 82            	dc.b	130
  85  0041 00            	dc.b	page(f_NonHandledInterrupt)
  86  0042 0000          	dc.w	f_NonHandledInterrupt
  87  0044 82            	dc.b	130
  89  0045 00            	dc.b	page(f_NonHandledInterrupt)
  90  0046 0000          	dc.w	f_NonHandledInterrupt
  91  0048 82            	dc.b	130
  93  0049 00            	dc.b	page(f_NonHandledInterrupt)
  94  004a 0000          	dc.w	f_NonHandledInterrupt
  95  004c 82            	dc.b	130
  97  004d 00            	dc.b	page(f_NonHandledInterrupt)
  98  004e 0000          	dc.w	f_NonHandledInterrupt
  99  0050 82            	dc.b	130
 101  0051 00            	dc.b	page(f_NonHandledInterrupt)
 102  0052 0000          	dc.w	f_NonHandledInterrupt
 103  0054 82            	dc.b	130
 105  0055 00            	dc.b	page(f_NonHandledInterrupt)
 106  0056 0000          	dc.w	f_NonHandledInterrupt
 107  0058 82            	dc.b	130
 109  0059 00            	dc.b	page(f_NonHandledInterrupt)
 110  005a 0000          	dc.w	f_NonHandledInterrupt
 111  005c 82            	dc.b	130
 113  005d 00            	dc.b	page(f_NonHandledInterrupt)
 114  005e 0000          	dc.w	f_NonHandledInterrupt
 115  0060 82            	dc.b	130
 117  0061 00            	dc.b	page(f_NonHandledInterrupt)
 118  0062 0000          	dc.w	f_NonHandledInterrupt
 119  0064 82            	dc.b	130
 121  0065 00            	dc.b	page(f_TIM4_IRQHandler)
 122  0066 0000          	dc.w	f_TIM4_IRQHandler
 123  0068 82            	dc.b	130
 125  0069 00            	dc.b	page(f_NonHandledInterrupt)
 126  006a 0000          	dc.w	f_NonHandledInterrupt
 127  006c 82            	dc.b	130
 129  006d 00            	dc.b	page(f_NonHandledInterrupt)
 130  006e 0000          	dc.w	f_NonHandledInterrupt
 131  0070 82            	dc.b	130
 133  0071 00            	dc.b	page(f_NonHandledInterrupt)
 134  0072 0000          	dc.w	f_NonHandledInterrupt
 135  0074 82            	dc.b	130
 137  0075 00            	dc.b	page(f_NonHandledInterrupt)
 138  0076 0000          	dc.w	f_NonHandledInterrupt
 139  0078 82            	dc.b	130
 141  0079 00            	dc.b	page(f_NonHandledInterrupt)
 142  007a 0000          	dc.w	f_NonHandledInterrupt
 143  007c 82            	dc.b	130
 145  007d 00            	dc.b	page(f_NonHandledInterrupt)
 146  007e 0000          	dc.w	f_NonHandledInterrupt
 206                     	xdef	__vectab
 207                     	xref	f_TIM4_IRQHandler
 208                     	xref	f_NonHandledInterrupt
 209                     	xref	f__stext
 210                     	xref	f_TIM1_CH1_CCP_IRQHandler
 211                     	xref	f_TIM1_UPD_IRQHandler
 230                     	end
