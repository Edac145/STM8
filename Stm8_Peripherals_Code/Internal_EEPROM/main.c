/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "stdio.h"
#include "delay.h"
#include "stdlib.h"

#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

void UART3_setup (void);
void clock_setup (void);
float ConvertStringToFloat(char *str);
void FlashTest(void);
void UART3_ClearBuffer(void);
void UART3_ReceiveString(char *buffer, uint16_t max_length);
void EEPROM_WriteString(uint32_t address, char *str);
void EEPROM_ReadString(uint32_t address, char *buffer, uint16_t max_length) ;
void ConvertFloatToString(float value, char *str, uint16_t maxLength);
void main(void)
{
		float value = 0;
		char receivedString[32] = {0};
    char eepromString[32] = {0};
    uint32_t eepromAddress = 0x4000;
		char str[] = "2.345";
		clock_setup ();
		UART3_setup ();
		TIM4_Config();
		
		//value = ConvertStringToFloat(str);
		//printf("Value: %f\n", value);
    /* Define FLASH programming time */
    FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);

    /* Unlock Data memory */
    FLASH_Unlock(FLASH_MEMTYPE_DATA);

    /* Read a byte at a specified address */
		
		printf("Enter a string to store in EEPROM:\n\r");
    UART3_ReceiveString(receivedString, sizeof(receivedString));

    // Write the received string to EEPROM
    EEPROM_WriteString(eepromAddress, receivedString);

    // Read back the string from EEPROM
    EEPROM_ReadString(eepromAddress, eepromString, sizeof(eepromString));

    // Display the string read from EEPROM
    printf("String read from EEPROM: %s\n\r", eepromString);
		
		value = ConvertStringToFloat(eepromString);
    printf("Value: %f\n", value);
		
    while (1)
    {
    }
}

void FlashTest(void)
{
	 uint32_t add = 0x00;
	 uint8_t val = 0x00, val_comp = 0x00;
	  add = 0x4000;
		val = FLASH_ReadByte(add);

    /* Program complement value (of previous read byte) at previous address + 1 */
    val_comp = (uint8_t)(~val);
    FLASH_ProgramByte((add + 1), val_comp);

    /* Check program action */
    val = FLASH_ReadByte((add + 1));
    if (val == val_comp)
    {
			  delay_ms(1000);
				printf("Operation Read and Write Success\n\r");
    }
		else
		{
				delay_ms(1000);
				printf("Operation Read and Write Failed\n\r");
		}

    /* Erase byte at a specified address & address + 1 */
 //   FLASH_EraseByte(add);
 //   FLASH_EraseByte((add + 1));
    /* Erase action */
 //   val = FLASH_ReadByte(add);
 //   val_comp = FLASH_ReadByte((add + 1));
 //   if ((val != 0x00) & (val_comp != 0x00))
 //   {
	//		delay_ms(1000);
//			printf("Operation Erase Failed\n\r");
 //   }
	//	else
	//	{
//			delay_ms(1000);
//			printf("Operation Erase Success\n\r");
//		}
	
}

void UART3_setup (void)
{
  UART3_DeInit ();

  // Configure UART1 at 9600 baud rate, 8 bits, no parity, 1 stop bit
  UART3_Init (9600, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
              UART3_MODE_TXRX_ENABLE);

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

void UART3_ClearBuffer(void) {
    while (UART3_GetFlagStatus(UART3_FLAG_RXNE) != RESET) {
        (void)UART3_ReceiveData8(); // Clear any preexisting data
    }
}

void UART3_ReceiveString(char *buffer, uint16_t max_length) {
    uint16_t i = 0;
    char receivedChar;

    for (i = 0; i < max_length; i++) {
        buffer[i] = '\0';
    }
    i = 0;

    // Receive characters until newline or max length is reached
    while (i < max_length - 1) {
        while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET);

        receivedChar = UART3_ReceiveData8();

        if (receivedChar == '\n' || receivedChar == '\r') {
            break; // Stop on newline or carriage return
        }

        buffer[i++] = receivedChar;
    }

    buffer[i] = '\0'; // Null-terminate the string
}

float ConvertStringToFloat(char *str) {
    float value = 0.0f;
		char formattedStr[16]; // Temporary buffer to format value
    // Convert string to float
    sscanf(str, "%f", &value);

    // Limit precision to 3 decimal places
    sprintf(formattedStr, "%.3f", value); // Format float with %.3f
    sscanf(formattedStr, "%f", &value); // Re-convert to float for uniformity

    return value;
}

void EEPROM_WriteString(uint32_t address, char *str) {
    while (*str) {
        FLASH_ProgramByte(address++, (uint8_t)(*str++));
    }
    FLASH_ProgramByte(address, '\0'); // Write a null terminator
}

void EEPROM_ReadString(uint32_t address, char *buffer, uint16_t max_length) {
    uint16_t i = 0;
    char c;

    while (i < max_length - 1) {
        c = (char)FLASH_ReadByte(address++); // Read a byte
        if (c == '\0') {
            break; // Stop if null terminator is encountered
        }
        buffer[i++] = c; // Store the character in the buffer
    }
    buffer[i] = '\0'; // Null-terminate the string
}

void ConvertFloatToString(float value, char *str, uint16_t maxLength) {
    // Ensure the output string respects the buffer size and includes %.3f formatting
    sprintf(str, "%.3f", value);
}