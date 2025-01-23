#include "stm8s.h"
#include "stdio.h"
#include "delay.h"
#include "stm8s_i2c.h"

// Define the EEPROM 7-bit address
#define EEPROM_7BIT_ADDRESS  0x50  // A0, A1, A2 set to 0
#define EEPROM_WRITE_ADDRESS (EEPROM_7BIT_ADDRESS << 1)  // 8-bit write address: 0xA0
#define EEPROM_READ_ADDRESS  ((EEPROM_7BIT_ADDRESS << 1) | 1)  // 8-bit read address: 0xA1

#define EEPROM_START_ADDRESS  0x0000 // Start address of EEPROM
#define EEPROM_SIZE           32000   // Total size of EEPROM in bytes
#define LOG_ENTRY_SIZE        37     // Fixed size of one log entry (including '\0')
#define MAX_ENTRIES           (EEPROM_SIZE / LOG_ENTRY_SIZE) // Maximum number of entries

extern volatile uint16_t writePointer; // Pointer to the next log entry

void EEPROM_Config (void);
void EEPROM_WriteByte (uint16_t memoryAddress, uint8_t data);
uint8_t EEPROM_ReadByte (uint16_t memoryAddress);
void EEPROM_ReadString (uint16_t memoryAddress, char *buffer);
void EEPROM_WriteString (uint16_t memoryAddress, char *data);
void EEPROM_LogData(const char *data);
void EEPROM_Init(uint8_t defaultValue);
void EEPROM_Test (void);
