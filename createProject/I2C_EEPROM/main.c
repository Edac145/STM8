#include "stm8s.h"
#include "stdio.h"
#include "delay.h"
#include "stm8s_eval_i2c_ee.h"

#define sEE_WRITE_ADDRESS1        0x0000
#define sEE_READ_ADDRESS1         0x0000

/* Private macro -------------------------------------------------------------*/
#define countof(a) (sizeof(a) / sizeof(*(a)))
typedef enum {FAILED = 0, PASSED = !FAILED} TestStatus;

/* Private variables ---------------------------------------------------------*/
uint8_t Tx1_Buffer[] = "/* STM8S I2C Firmware Library EEPROM driver example:";
uint8_t Tx2_Buffer[] = "/* STM8S I2C";

#define BUFFER_SIZE1             (countof(Tx1_Buffer)-1)
#define BUFFER_SIZE2             (countof(Tx2_Buffer)-1)

uint8_t Rx1_Buffer[BUFFER_SIZE1], Rx2_Buffer[BUFFER_SIZE2];



volatile TestStatus TransferStatus1 = FAILED, TransferStatus2 = FAILED;
volatile uint16_t NumDataRead = 0;

#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

void clock_setup(void);
void UART3_setup(void);
void GPIO_setup(void);
void I2C_Configuration(void);
TestStatus Buffercmp(uint8_t* pBuffer1, uint8_t* pBuffer2, uint16_t BufferLength);

void main(void)
{
	uint8_t i = 0;
	char writeData[] = "Hello, EEPROM!";
	char readData[20];  // Buffer to read data back (make sure it's large enough for expected strings)
	uint16_t startAddress = 0x0000;
	clock_setup();
	TIM4_Config();
	UART3_setup();
	GPIO_setup();
	//I2C_Configuration();
  
	printf("Starting:\n");
	 sEE_Init();  

  /* First write in the memory followed by a read of the written data --------*/
  /* Write on I2C EEPROM from sEE_WRITE_ADDRESS1 */
  sEE_WriteBuffer(Tx1_Buffer, sEE_WRITE_ADDRESS1, BUFFER_SIZE1); 

  /* Wait for EEPROM standby state */
  sEE_WaitEepromStandbyState();  
  
  /* Set the Number of data to be read */
  NumDataRead = BUFFER_SIZE1;
  
  /* Read from I2C EEPROM from sEE_READ_ADDRESS1 */
  sEE_ReadBuffer(Rx1_Buffer, sEE_READ_ADDRESS1, (uint16_t *)(&NumDataRead)); 
	printf("reading data finsished\n");
	/* Wait till transfer is complete */
 
	TransferStatus1 = Buffercmp(Tx1_Buffer, Rx1_Buffer, BUFFER_SIZE1);
	
	if (TransferStatus1 == PASSED)
  {
    printf(" EEPROM Transfer1");
    printf("     PASSED      ");
  }
  else
  {
    printf(" EEPROM Transfer1");
    printf("     FAILED      ");
  }  
	sEE_DeInit();
  while (1)
  {
  }
}

// Configure UART1
void UART3_setup(void) {
  UART3_DeInit();

  // Configure UART1 at 9600 baud rate, 8 bits, no parity, 1 stop bit
  UART3_Init(9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
             UART3_MODE_TX_ENABLE);

  UART3_Cmd(ENABLE);  // Enable UART1
}

PUTCHAR_PROTOTYPE {
  /* Write a character to the UART1 */
  UART3_SendData8(c);
  /* Loop until the end of transmission */
  while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);

  return (c);
}

void clock_setup(void) {
  CLK_DeInit();
  CLK_HSECmd(DISABLE);
  CLK_LSICmd(DISABLE);
  CLK_HSICmd(ENABLE);
  while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);

  CLK_ClockSwitchCmd(ENABLE);
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);

  CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
                        CLK_CURRENTCLOCKSTATE_ENABLE);

  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, ENABLE);
  // CLK_CCOConfig(CLK_OUTPUT_CPU);
  // CLK_CCOCmd(ENABLE);
  // while(CLK_GetFlagStatus(CLK_FLAG_CCORDY) == FALSE);
}

void GPIO_setup(void)
{   
    //GPIO_DeInit(GPIOB);
		GPIO_DeInit(GPIOE);
    //GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_OD_HIZ_FAST);
    //GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_OD_HIZ_FAST);
		//GPIOB->ODR |= (1 << 4) | (1 << 5); // Enable pull-up resistors (set to high)
		GPIO_Init(GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
    GPIO_Init(GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
}

void I2C_Configuration(void)
{
    I2C_DeInit();  // Reset I2C to default state

    // Initialize I2C with 100kHz standard mode, 7-bit address, and enable ACK
    I2C_Init(
        100000,           // I2C clock frequency (100kHz)
        0x00,             // Own address (not required for master mode)
        I2C_DUTYCYCLE_2,  // Fast mode Tlow/Thigh = 2
        I2C_ACK_CURR,     // Enable ACK for current byte
        I2C_ADDMODE_7BIT, // 7-bit addressing mode
        16                // Input clock frequency in MHz (adjust as per your system clock)
    );
    //I2C_StretchClockCmd(ENABLE);
    I2C_Cmd(ENABLE);  // Enable the I2C peripheral
}

TestStatus Buffercmp(uint8_t* pBuffer1, uint8_t* pBuffer2, uint16_t BufferLength)
{
  while(BufferLength--)
  {
		printf("Comparing: %c with %c\n", *pBuffer1, *pBuffer2);  // Debug output
    if(*pBuffer1 != *pBuffer2)
    {
      return FAILED;
    }
    
    pBuffer1++;
    pBuffer2++;
  }

  return PASSED;  
}

