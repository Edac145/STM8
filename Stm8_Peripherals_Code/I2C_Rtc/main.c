/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s.h"
#include "stdio.h"
#include "delay.h"
//#include "Ds1302.h"

#define DS1302_RST    GPIO_PIN_1
#define DS1302_RST_PORT   GPIOC
#define DS1302_SCLK   GPIO_PIN_2
#define DS1302_SCLK_PORT   GPIOC
#define DS1302_DATA   GPIO_PIN_4
#define DS1302_DATA_PORT  GPIOC

#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

void clock_setup (void);
void UART3_setup (void);
void GPIO_setup (void);
void ds1302_init(void);
static void sclk(char h);
static void data_out(char h);
static BitStatus data_in(void);
static void rst(char h);
static void write_byte(unsigned char data);
static unsigned char read_byte(void);
static void write(unsigned char addr, unsigned char data);
static unsigned char read(unsigned char addr);
void set_time(unsigned char time[]);
void read_time(unsigned char time[7]);

void main (void)
{
	unsigned char time_buf[7] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00};
	// Set time: 12:00:00 on 1st July 2023
	unsigned char init_time[7] = {0x00, 0x00, 0x12, 0x01, 0x07, 0x07, 0x23}; 
	int i = 0 ;
  clock_setup ();
  TIM4_Config ();
  UART3_setup ();
  //GPIO_setup ();
	ds1302_init();
	
	set_time(init_time);
  while(1)
	{
//	  Ds1302_GetDateTime(&dt);
    read_time(time_buf);
		printf("Raw time_buf: ");
    for(i = 0; i < 7; i++) {
        printf("%d ", time_buf[i]);
    }
    printf("\n");
	  // Example of printing formatted time and date
    printf("Time: %02d:%02d:%02d\n", time_buf[2], time_buf[1], time_buf[0]); // hh:mm:ss
    printf("Date: %02d/%02d/%02d (day: %d)\n", time_buf[5], time_buf[4], (time_buf[6] + 2000), time_buf[3]); // dd/mm/yyyy
		delay_ms(1000);
	}
}

void UART3_setup (void)
{
  UART3_DeInit ();

  // Configure UART1 at 9600 baud rate, 8 bits, no parity, 1 stop bit
  UART3_Init (9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
              UART3_MODE_TX_ENABLE);

  UART3_Cmd (ENABLE); // Enable UART1
}

PUTCHAR_PROTOTYPE{
  /* Write a character to the UART1 */
  UART3_SendData8 (c);
  /* Loop until the end of transmission */
  while (UART3_GetFlagStatus (UART3_FLAG_TXE) == RESET);

  return (c);
}

void clock_setup (void)
{
  CLK_DeInit ();
  CLK_HSECmd (DISABLE);
  CLK_LSICmd (DISABLE);
  CLK_HSICmd (ENABLE);
  while (CLK_GetFlagStatus (CLK_FLAG_HSIRDY) == FALSE);

  CLK_ClockSwitchCmd (ENABLE);
  CLK_HSIPrescalerConfig (CLK_PRESCALER_HSIDIV1);
  CLK_SYSCLKConfig (CLK_PRESCALER_CPUDIV1);

  CLK_ClockSwitchConfig (CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
                         CLK_CURRENTCLOCKSTATE_ENABLE);

  //CLK_PeripheralClockConfig (CLK_PERIPHERAL_TIMER4, ENABLE);
  CLK_PeripheralClockConfig (CLK_PERIPHERAL_UART3, ENABLE);
  //CLK_PeripheralClockConfig (CLK_PERIPHERAL_I2C, ENABLE);
  // CLK_CCOConfig(CLK_OUTPUT_CPU);
  // CLK_CCOCmd(ENABLE);
  // while(CLK_GetFlagStatus(CLK_FLAG_CCORDY) == FALSE);
}

void GPIO_setup (void)
{
  GPIO_DeInit (GPIOE);
  GPIO_Init (GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
  GPIO_Init (GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
}

void ds1302_init()
{
  GPIO_Init(DS1302_DATA_PORT, (GPIO_Pin_TypeDef)(DS1302_DATA), GPIO_MODE_OUT_PP_HIGH_FAST); 
  GPIO_Init(DS1302_RST_PORT, (GPIO_Pin_TypeDef)(DS1302_RST ), GPIO_MODE_OUT_PP_HIGH_FAST); 
  GPIO_Init(DS1302_SCLK_PORT, (GPIO_Pin_TypeDef)(DS1302_SCLK), GPIO_MODE_OUT_PP_HIGH_FAST); 
}
static void sclk(char h)
{
  if(h)
    GPIO_WriteHigh(DS1302_SCLK_PORT,DS1302_SCLK);
  else
    GPIO_WriteLow(DS1302_SCLK_PORT,DS1302_SCLK);
}
static void data_out(char h)
{
  GPIO_Init(DS1302_DATA_PORT,(GPIO_Pin_TypeDef)DS1302_DATA,GPIO_MODE_OUT_PP_HIGH_FAST);
  if(h)
    GPIO_WriteHigh(DS1302_DATA_PORT,DS1302_DATA);
  else
    GPIO_WriteLow(DS1302_DATA_PORT,DS1302_DATA);
}
static BitStatus data_in()
{
  GPIO_Init(DS1302_DATA_PORT, (GPIO_Pin_TypeDef)(DS1302_DATA ), GPIO_MODE_IN_FL_NO_IT);
  return GPIO_ReadInputPin(DS1302_DATA_PORT,(GPIO_Pin_TypeDef)(DS1302_DATA ));
}
static void rst(char h)
{
  if(h)
    GPIO_WriteHigh(DS1302_RST_PORT,DS1302_RST);
  else
    GPIO_WriteLow(DS1302_RST_PORT,DS1302_RST);
}
static void write_byte(unsigned char data)
{
  unsigned char i;
  for(i = 0;i< 8;i++)
  {
    sclk(0);
    if(data & 0x01)
      data_out(1);
    else
      data_out(0);
    data >>= 1;
    sclk(1);
		delay_us(1); // Small delay after each clock pulse
  }
}
static unsigned char read_byte()
{
  unsigned char i,temp = 0;
  BitStatus bit;
  for(i = 0;i< 8;i ++)
  {
    temp = temp>>1;
    sclk(0);
    bit = data_in();
    if(bit == RESET)
    {
      
    }
    else
    {
      temp = temp | 0x80;
    }
    sclk(1);
		delay_us(1); // Small delay after each clock pulse
  }
  return temp;
}
static void write(unsigned char  addr,unsigned char data)
{
	//delay_us(1);
  rst(0);
  sclk(0);
  rst(1);
  write_byte(addr);
  write_byte(data);
  rst(0);
  sclk(1);
  data_out(1);
}
static unsigned char read(unsigned char addr)
{
  unsigned char temp = 0;
	//delay_us(1);
  rst(0);
  sclk(0);
  rst(1);
  write_byte(addr);
  temp = read_byte();
  rst(0);
  sclk(1);
  data_out(1);
  return temp;
}
void set_time(unsigned char time[])
{
  unsigned char i,add,temp;
  write(0x8e,0);
  for(i = 0,add = 0x80;i<7;i++,add+=2)
  {
    temp = time[i]/10;
    time[i] = time[i]%10 + temp*16;
    write(add,time[i]);
  }
  write(0x8e,0x80);
}
void read_time(unsigned char time[7])
{
  unsigned char i , add,temp;
  for(i = 0,add = 0x81;i<7;i++,add+=2)
  {
    temp = read(add);
    time[i] = (temp>>4)*10+(temp%16);
  }
}