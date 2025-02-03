#include "eeprom.h"

volatile uint16_t writePointer = EEPROM_START_ADDRESS; // Pointer to the next log entry

void EEPROM_Config (void)
{ 
  CLK_PeripheralClockConfig (CLK_PERIPHERAL_I2C, ENABLE);
  GPIO_DeInit (GPIOE);
  GPIO_Init (GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);
  GPIO_Init (GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_OD_HIZ_FAST);
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
  delay_ms (5);
  return receivedData;
}

char* EEPROM_ReadString (uint16_t memoryAddress, char* buffer)  //Changed from no return to char*
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
  delay_ms (5);
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

/*void EEPROM_ReadData(void)
{
    uint16_t memoryAddress = EEPROM_START_ADDRESS; // Start at the beginning of EEPROM
    char buffer[40]; // Buffer to hold the read string

    while (memoryAddress < EEPROM_SIZE) // Loop through EEPROM
    {
        // Read a string from the current memory address
        EEPROM_ReadString(memoryAddress, buffer);

        // Stop if the string read is empty (indicates no data logged further)
        if (buffer[0] == '\0')
        {
            break;
        }

        // Print the read data
        printf("Data Logged: %s at address: 0x%04X\n", buffer, memoryAddress);

        // Move to the next log entry address
        memoryAddress += LOG_ENTRY_SIZE; 
    }
}*/

/*void EEPROM_ReadData(void)
{
    uint16_t memoryAddress = EEPROM_START_ADDRESS; // Start at the beginning of EEPROM
    uint8_t data; // Variable to hold the read byte

    while (memoryAddress < EEPROM_SIZE) // Loop until the end of the EEPROM
    {
        // Read a byte from the current address
        data = EEPROM_ReadByte(memoryAddress);

        // Print the data in hexadecimal format to the serial monitor
        printf("%c", data);

        // Move to the next memory address
        memoryAddress++;
    }
}*/

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



void EEPROM_Init(uint8_t defaultValue)
{
	uint16_t address = 0;
	for (address = EEPROM_START_ADDRESS; address < EEPROM_SIZE; address++)
	{
			EEPROM_WriteByte(address, defaultValue);
			delay_ms(5); // Ensure write delay
	}
	writePointer = EEPROM_START_ADDRESS; // Reset pointer
	printf("EEPROM Initialized. All values set to: 0x%02X\n", defaultValue);
}

void EEPROM_Test (void)
{
  uint16_t memoryAddress = 0x0000; // EEPROM memory address to write/read
  uint8_t dataToWrite = 0xAB; // Data to write
  uint8_t dataRead;

  EEPROM_Config (); // Initialize I2C peripheral

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
