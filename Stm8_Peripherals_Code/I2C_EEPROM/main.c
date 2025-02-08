#include "stm8s.h"
#include "stdio.h"
#include "delay.h"
#include "string.h"

// Define the EEPROM 7-bit address
#define EEPROM_7BIT_ADDRESS  0x50  // A0, A1, A2 set to 0
#define EEPROM_WRITE_ADDRESS (EEPROM_7BIT_ADDRESS << 1)  // 8-bit write address: 0xA0
#define EEPROM_READ_ADDRESS  ((EEPROM_7BIT_ADDRESS << 1) | 1)  // 8-bit read address: 0xA1

#define LOG_ENTRY_SIZE        37     // Fixed size of one log entry (including '\0')
#define MAX_ENTRIES           (EEPROM_SIZE / LOG_ENTRY_SIZE) // Maximum number of entries

#define EEPROM_START_ADDRESS  0x0000    // Start address of EEPROM
#define EEPROM_SIZE           32000     // Total EEPROM size in bytes
#define MAX_STRING_LENGTH     50        // Maximum string length (including '\n' and '\0')
#define BATCH_BUFFER_SIZE     50        // Reading buffer size

#define PUTCHAR_PROTOTYPE char putchar(char c)
#define GETCHAR_PROTOTYPE char getchar(void)

#define true  1
#define false 0

uint16_t writePointer = EEPROM_START_ADDRESS; // Pointer to the next log entry

void clock_setup (void);
void UART3_setup (void);
void GPIO_setup (void);
void I2C_Configuration (void);
void EEPROM_WriteByte (uint16_t memoryAddress, uint8_t data);
uint8_t EEPROM_ReadByte (uint16_t memoryAddress);
void EEPROM_ReadString (uint16_t memoryAddress, char *buffer);
void EEPROM_WriteString (uint16_t memoryAddress, char *data);
void EEPROM_LogData(const char *data);
void EEPROM_Init(uint16_t defaultValue);
void EEPROM_Test (void);
void EEPROM_ReadData(void);
bool read_from_eeprom(uint16_t start_addr, char* buffer, uint16_t buffer_size);
void process_eeprom_logs(void);
void log_to_eeprom(const char* str);
bool checkString(const char* str);

void main (void)
{
  int i = 0;
  char writeData[] = "17-01-25,14:36:00,50.000,5.000,1.230";
	char sample_data1[] = "17-01-25,14:36:00,FDR AMPLITUDE: 24.5";
	char sample_data2[] = "17-01-25,14:36:00,Freq < SetFreq";
	char sample_data3[] = "17-01-25,14:36:00,ZeroCrosssing Detected";
	char sample_data4[] = "17-01-25,14:36:00 Signal 1 DC";
	char sample_data5[] = "17-01-25,14:36:00 Signal 1 AC";
	char sample_data6[] = "17-01-25,14:36:00 Signal 1 AC below 10 mv";
	char sample_data7[] = "17-01-25,14:36:00 pulse to Commutation Thyristor";
  char readData[40]; // Buffer to read data back (make sure it's large enough for expected strings)
  uint16_t startAddress = 0x0000;
  clock_setup ();
  TIM4_Config ();
  UART3_setup ();
  GPIO_setup ();
  I2C_Configuration ();
  delay_ms(1000);
  printf ("Starting:\n");
	printf("EEPROM Logging and Reading Example\n");
  
	/*for(i = 0; i < 200; i++)
	{
		printf("%u,", i);
		log_to_eeprom(writeData);
		log_to_eeprom(sample_data1);
		log_to_eeprom(sample_data2);	
		log_to_eeprom(sample_data3);
		log_to_eeprom(sample_data2);	
		log_to_eeprom(sample_data4);
		log_to_eeprom(sample_data5);	
		log_to_eeprom(sample_data6);
		log_to_eeprom(sample_data7);	
  }*/
	
	// Process and read data logs from EEPROM
	process_eeprom_logs();

  EEPROM_Test();
  while(1)
	{
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

  CLK_PeripheralClockConfig (CLK_PERIPHERAL_TIMER4, ENABLE);
  CLK_PeripheralClockConfig (CLK_PERIPHERAL_UART3, ENABLE);
  CLK_PeripheralClockConfig (CLK_PERIPHERAL_I2C, ENABLE);
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

void I2C_Configuration (void)
{
  I2C_DeInit (); // Reset I2C to default state

  // Initialize I2C with 100kHz standard mode, 7-bit address, and enable ACK
  I2C_Init (
            100000, // I2C clock frequency (100kHz)
            0x00, // Own address (not required for master mode)
            I2C_DUTYCYCLE_2, // Fast mode Tlow/Thigh = 2
            I2C_ACK_CURR, // Enable ACK for current byte
            I2C_ADDMODE_7BIT, // 7-bit addressing mode
            16 // Input clock frequency in MHz (adjust as per your system clock)
            );
  I2C_Cmd (ENABLE); // Enable the I2C peripheral
}

void EEPROM_WriteByte (uint16_t memoryAddress, uint8_t data)
{
  // Generate START condition
  I2C_GenerateSTART (ENABLE);
  while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
  // Send EEPROM write address
  I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
  while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
  // Send high byte of memory address
  I2C_SendData ((uint8_t) (memoryAddress >> 8));
  while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
  // Send low byte of memory address
  I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
  while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
  // Send data to write
  I2C_SendData (data);
  while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
  // Generate STOP condition
  I2C_GenerateSTOP (ENABLE);
  delay_ms (5);
}

uint8_t EEPROM_ReadByte (uint16_t memoryAddress)
{
  uint8_t receivedData;
  uint8_t i = 0;
  // Generate START condition
  I2C_GenerateSTART (ENABLE);
  while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
  // Send EEPROM write address (for addressing memory)
  I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
  while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
  // Send high byte of memory address
  I2C_SendData ((uint8_t) (memoryAddress >> 8));
  while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
  // Send low byte of memory address
  I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
  while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
  // Generate repeated START condition
  //I2C_GenerateSTOP(ENABLE);
  I2C_GenerateSTART (ENABLE);
  while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
  // Send EEPROM read address
  I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
  while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
  // Wait for data byte to be received
  while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED) == ERROR);
  receivedData = I2C_ReceiveData ();
  // Generate STOP condition
  I2C_GenerateSTOP (ENABLE);
  //delay_ms (5);
  return receivedData;
}

void EEPROM_ReadString (uint16_t memoryAddress, char* buffer)
{
  uint8_t tempData = 0;
  uint8_t i = 0;
  // Generate START condition
  I2C_GenerateSTART (ENABLE);
  while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
  // Send EEPROM write address (for addressing memory)
  I2C_Send7bitAddress (EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
  while (I2C_CheckEvent (I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
  // Send high byte of memory address
  I2C_SendData ((uint8_t) (memoryAddress >> 8));
  while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
  // Send low byte of memory address
  I2C_SendData ((uint8_t) (memoryAddress & 0xFF));
  while (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
  // Generate repeated START condition
  //I2C_GenerateSTOP(ENABLE);
  I2C_GenerateSTART (ENABLE);
  while (I2C_CheckEvent (I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
  // Send EEPROM read address
  I2C_Send7bitAddress (EEPROM_READ_ADDRESS, I2C_DIRECTION_RX);
  while (I2C_CheckEvent (I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == ERROR);
  while (1)
  {
    if (I2C_CheckEvent (I2C_EVENT_MASTER_BYTE_RECEIVED))
    {
      uint8_t tempData = I2C_ReceiveData ();
      if (tempData == '\0')
      {
        I2C_AcknowledgeConfig (I2C_ACK_NONE);
        I2C_GenerateSTOP (ENABLE);
        break;
      }
      else
        buffer[i++] = tempData;
    }
  }
  buffer[i] = '\0';
  // Generate STOP condition
  //delay_ms (5);
}

void EEPROM_WriteString (uint16_t memoryAddress, char *data)
{
  while (*data)
  { // Loop until we reach the null terminator '\0'
    EEPROM_WriteByte (memoryAddress, *data); // Write one character to EEPROM
    memoryAddress++; // Increment the address to write the next character
    data++; // Move to the next character in the string
  }
  // Ensure the null terminator '\0' is also written
  EEPROM_WriteByte (memoryAddress, '\0');
}

void EEPROM_LogData(const char *data)
{
	uint16_t memoryAddress = writePointer; // Start writing at the current write pointer

	// Write the log string to EEPROM (including null terminator '\0')
	EEPROM_WriteString(memoryAddress, data);

	// Move the pointer to the next log entry
	writePointer += LOG_ENTRY_SIZE;

	// If the pointer exceeds the EEPROM size, wrap it around to the start (FIFO)
	if (writePointer >= EEPROM_SIZE)
	{
			writePointer = EEPROM_START_ADDRESS;
	}

	printf("Data Logged: %s at address: 0x%04X\n", data, memoryAddress);
}

void EEPROM_ReadData(void)
{
    uint16_t memoryAddress = EEPROM_START_ADDRESS; // Start at the beginning of EEPROM
    uint8_t data; // Variable to hold the read byte

    //printf("Reading EEPROM data:\n");
    while (memoryAddress < EEPROM_SIZE) // Loop until the end of the EEPROM
    {
        // Read a byte from the current address
        data = EEPROM_ReadByte(memoryAddress);

        // Check if the byte is a printable character
        if (data >= 33 && data <= 122) // Printable ASCII range
        {
            printf("%c", data); // Print the character directly
        }
        // Move to the next memory address
        memoryAddress++;
    }
    printf("\nDone reading EEPROM.\n");
}

void EEPROM_Init(uint16_t defaultValue)
{
    uint16_t address = 0;

    printf("Initializing EEPROM...\n");
    for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
    {
        EEPROM_WriteByte(address, defaultValue); // Write default value
        // OPTIONAL: Check for EEPROM write completion instead of a fixed delay
				printf("%d,", address);
        // If polling is not possible, reduce the delay to a smaller value (e.g., 1ms)
        //delay_ms(1);
    }

    writePointer = EEPROM_START_ADDRESS; // Reset pointer
    printf("EEPROM Initialized. All values set to: 0x%02X\n", defaultValue);
}

void EEPROM_Test (void)
{
  uint16_t memoryAddress = 0x0000; // EEPROM memory address to write/read
  uint8_t dataToWrite = 0xAB; // Data to write
  uint8_t dataRead;

  I2C_Configuration (); // Initialize I2C peripheral

  // Write data to EEPROM
  EEPROM_WriteByte (memoryAddress, dataToWrite);
  printf ("Writing Finished\n");
  // Add a small delay to ensure EEPROM write completes
  //delay_ms(5);
  printf ("Reading Starting\n");
  // Read data back from EEPROM
  dataRead = EEPROM_ReadByte (memoryAddress);

  // Compare written and read data for debugging (optional)
  if (dataRead == dataToWrite)
  {
    printf ("Success");
  }
  else
  {
    printf ("YOU FAIL");
  }
}

bool read_from_eeprom(uint16_t start_addr, char* buffer, uint16_t buffer_size) {
    uint16_t addr = start_addr;
    uint16_t i = 0;
    memset(buffer, 0, buffer_size);		
    
    while (addr < EEPROM_START_ADDRESS + EEPROM_SIZE) {
        char ch = EEPROM_ReadByte(addr);
        if (ch == '\0') {
            break;
        }
				
				// If the read character is .FF (default byte)
        if (ch < 32 && ch >126){
            break; // Exit if we encounter the default value
        }
				
        if (i < (buffer_size - 1)) {
            buffer[i++] = ch;
        } else {
            break;
        }
        addr++;
    }
    return true;
}
/*
bool read_from_eeprom(uint16_t start_addr, char* buffer, uint16_t buffer_size) {
	uint16_t i = 0;
    if (buffer == NULL || buffer_size == 0) {
        return false;  // Invalid parameters
    }
    
    // Clear the buffer and ensure no residual data
    memset(buffer, 0, buffer_size);
    
    // Use EEPROM_ReadString to read from the given address
    EEPROM_ReadString(start_addr, buffer);
    
    // Ensure that the data in the buffer is properly null-terminated within buffer_size
    buffer[buffer_size - 1] = '\0';  // Safeguard against overflow
    
    // Validate content for reasonable character values (e.g., non-default values)
    for (i = 0; i < buffer_size; ++i) {
        if (buffer[i] == '\0') {
            break;  // Valid string termination
        }
        // Check for invalid characters (e.g., out of printable range)
        if (buffer[i] < 32 || buffer[i] > 126) {
            buffer[i] = '\0';  // Terminate at the first invalid character
            break;
        }
    }

    return true;  // Successfully read
}*/

void process_eeprom_logs() {
    char buffer[BATCH_BUFFER_SIZE]; // Buffer for reading a batch of data
    uint16_t current_addr = EEPROM_START_ADDRESS;
    printf("Reading from EEPROM:\n");
		EEPROM_ReadString(0x00, buffer);
    while (current_addr < EEPROM_START_ADDRESS + EEPROM_SIZE) {
        // Read a batch of data from EEPROM
        if (!read_from_eeprom(current_addr, buffer, BATCH_BUFFER_SIZE)) {
            printf("Error reading from EEPROM at address: 0x%04X\n", current_addr);
            break; // Stop reading on error
        }
				
        // Validate the buffer length and skip empty or invalid logs
        if (strlen(buffer) > 0 && checkString(buffer)) {
            printf("%s\n", buffer); // Print valid log data to the serial monitor
        } else {
            break; // Stop if an empty or invalid buffer is encountered
        }
        // Increment the address to the next log entry (including '\0' terminator)
        current_addr += strlen(buffer) + 1; // +1 to skip the null terminator
    }
}
/*
bool read_from_eeprom(uint16_t start_addr, char* buffer, uint16_t buffer_size) {
    uint16_t addr = start_addr;
    uint16_t i = 0;

    memset(buffer, 0, buffer_size); // Clear the buffer

    // Set the internal EEPROM address pointer
    I2C_GenerateSTART(ENABLE);
    while (I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT) == ERROR);
    I2C_Send7bitAddress(EEPROM_WRITE_ADDRESS, I2C_DIRECTION_TX);
    while (I2C_CheckEvent(I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == ERROR);
    I2C_SendData((uint8_t)(addr >> 8));
    while (I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
    I2C_SendData((uint8_t)(addr & 0xFF));
    while (I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_TRANSMITTED) == ERROR);
    I2C_GenerateSTOP(ENABLE);

    // Now proceed to read data
    while (addr < EEPROM_START_ADDRESS + EEPROM_SIZE) {
        char ch = EEPROM_ReadByte(addr);
        if (ch == '\0') break; // Stop at null terminator
        if (i < (buffer_size - 1)) {
            buffer[i++] = ch;
        } else {
            break; // Prevent overflow
        }
        addr++;
    }

    return true;
}*/

void log_to_eeprom(const char* str) {
    if ((writePointer + strlen(str) + 1) >= (EEPROM_START_ADDRESS + EEPROM_SIZE)) {
        printf("EEPROM out of space.\n");
				writePointer = EEPROM_START_ADDRESS;
    }
    EEPROM_WriteString(writePointer, str);
    writePointer += strlen(str) + 1;
}

bool checkString(const char* str)
{
	bool flag = 0;
	uint8_t i  = 0;
	for (i = 1; i < strlen(str); i++) {
		if (str[i] != str[0]) {
				flag = 1;
				break;
		}
	}
return flag;
}