/**
  ******************************************************************************
  * @file    stm8s_eval_i2c_ee.h
  * @author  MCD Application Team
  * @version V1.0.0
  * @date    25-February-2011
  * @brief   This file contains all the functions prototypes for the stm8s_eval_i2c_ee
  *          firmware driver.
  ******************************************************************************
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
  ******************************************************************************
  */  

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM8S_EVAL_I2C_EE_H
#define __STM8S_EVAL_I2C_EE_H

/* Includes ------------------------------------------------------------------*/
//#include "stm8s_eval.h"
#include "stm8s.h"
#include "main.h"
/** @addtogroup Utilities
  * @{
  */
  
/** @addtogroup STM8S_EVAL
  * @{
  */ 

/** @addtogroup Common
  * @{
  */
  
/** @addtogroup STM8S_EVAL_I2C_EE
  * @{
  */  

/* Exported types ------------------------------------------------------------*/
  
/** @defgroup STM8S_EVAL_I2C_EE_Exported_Constants
  * @{
  */
/* Uncomment this line to use the default start and end of critical section 
   callbacks (it disables then enables all interrupts) */
#define USE_DEFAULT_CRITICAL_CALLBACK 
/* Start and End of critical section: these callbacks should be typically used
   to disable interrupts when entering a critical section of I2C communication
   You may use default callbacks provided into this driver by uncommenting the 
   define USE_DEFAULT_CRITICAL_CALLBACK.
   Or you can comment that line and implement these callbacks into your 
   application */

/* Uncomment the following line to use the default sEE_TIMEOUT_UserCallback() 
   function implemented in stm8s_eval_i2c_ee.c file.
   sEE_TIMEOUT_UserCallback() function is called whenever a timeout condition 
   occurs during communication (waiting on an event that doesn't occur, bus 
   errors, busy devices ...). */   
/* #define USE_DEFAULT_TIMEOUT_CALLBACK */

//#if !defined (sEE_M24C64_32)
/* Use the defines below to choose the EEPROM type */
//#define sEE_M24C64_32  /* Support the devices: M24C32 and M24C64 */
//#endif

#ifdef sEE_M24C64_32
/* For M24C32 and M24C64 devices, E0,E1 and E2 pins are all used for device 
  address selection (ne need for additional address lines). According to the 
  Hardware connection on the board (on STM8 EVAL board E0 = E1 = E2 = 0) */

 #define sEE_HW_ADDRESS     0x50   /* E0 = E1 = E2 = 0 */ 
#endif /* sEE_M24C64_32 */

#define I2C_SPEED              100000
#define I2C_SLAVE_ADDRESS7     0x50

#if defined (sEE_M24C64_32)
#define sEE_PAGESIZE    32
#else
#define sEE_PAGESIZE  64
#endif
 
   
/* Maximum Timeout values for flags and events waiting loops. These timeouts are
   not based on accurate values, they just guarantee that the application will 
   not remain stuck if the I2C communication is corrupted.
   You may modify these timeout values depending on CPU frequency and application
   conditions (interrupts routines ...). */   
#define sEE_FLAG_TIMEOUT         ((uint32_t)0x1000)
#define sEE_LONG_TIMEOUT         ((uint32_t)(10 * sEE_FLAG_TIMEOUT))

/* Maximum number of trials for sEE_WaitEepromStandbyState() function */
#define sEE_MAX_TRIALS_NUMBER     150

#define sEE_OK                    0
#define sEE_FAIL                  1 

/**
  * @}
  */ 
  
/* Exported macro ------------------------------------------------------------*/ 

/** @defgroup STM8S_EVAL_I2C_EE_Exported_Functions
  * @{
  */ 
void     sEE_DeInit(void);
void     sEE_Init(void);
uint32_t sEE_ReadBuffer(uint8_t* pBuffer, uint16_t ReadAddr, uint16_t* NumByteToRead);
uint32_t sEE_WritePage(uint8_t* pBuffer, uint16_t WriteAddr, uint8_t* NumByteToWrite);
void     sEE_WriteBuffer(uint8_t* pBuffer, uint16_t WriteAddr, uint16_t NumByteToWrite);
uint32_t sEE_WaitEepromStandbyState(void);

/* USER Callbacks: These are functions for which prototypes only are declared in
   EEPROM driver and that should be implemented into user application. */  
/* sEE_TIMEOUT_UserCallback() function is called whenever a timeout condition 
   occurs during communication (waiting on an event that doesn't occur, bus 
   errors, busy devices ...).
   You can use the default timeout callback implementation by uncommenting the 
   define USE_DEFAULT_TIMEOUT_CALLBACK in stm8s_eval_i2c_ee.h file.
   Typically the user implementation of this callback should reset I2C peripheral
   and re-initialize communication or in worst case reset all the application. */
uint32_t sEE_TIMEOUT_UserCallback(void);

/* Start and End of critical section: these callbacks should be typically used
   to disable interrupts when entering a critical section of I2C communication
   You may use default callbacks provided into this driver by uncommenting the 
   define USE_DEFAULT_CRITICAL_CALLBACK in stm8s_eval_i2c_ee.h file..
   Or you can comment that line and implement these callbacks into your 
   application */
void sEE_EnterCriticalSection_UserCallback(void);
void sEE_ExitCriticalSection_UserCallback(void);

#endif /* __STM8S_EVAL_I2C_EE_H */
/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */ 

/**
  * @}
  */

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/