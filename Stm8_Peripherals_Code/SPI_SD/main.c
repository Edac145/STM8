/**
  ******************************************************************************
  * @file    SPI_FastCommunicationMicroSD\main.c
  * @author  MCD Application Team
  * @version V2.0.4
  * @date    26-April-2018
  * @brief   This file contains the main function for SPI fast communication example.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */ 
#define SD_CS_GPIO_PORT GPIOB
#define SD_CS_PIN  GPIO_PIN_0
/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "stm8s_eval.h"
#include "stm8s_eval_spi_sd.h"
#include "delay.h"
#include "stdio.h"

/**
  * @addtogroup SPI_FastCommunicationMicroSD
  * @{
  */
#define LED1    GPIOC, GPIO_PIN_3  // Red LED connected to PC3
#define LED2    GPIOE, GPIO_PIN_3  // Green LED connected to PE3
#define LED3    GPIOD, GPIO_PIN_0  // Blue LED connected to PD0
#define LED4    GPIOD, GPIO_PIN_3  // Yellow LED connected to PD3
#define LED5    GPIOA, GPIO_PIN_3  // White LED connected to PA3
/* Private macro -------------------------------------------------------------*/
#define countof(a) (sizeof(a) / sizeof(*(a)))

/* Private define ------------------------------------------------------------*/
#define BUFFER_SIZE (countof(TxBuffer)-1)

/* Private variables ---------------------------------------------------------*/
__IO uint16_t Status = 0;
uint8_t TxBuffer[] = "STM8S SPI Firmware Library Example: communication with a microSD card";
uint8_t RxBuffer[BUFFER_SIZE] = {0};
__IO ErrorStatus TransferStatus = ERROR;

/* Private function prototypes -----------------------------------------------*/
void Delay (uint16_t nCount);
static ErrorStatus Buffercmp(uint8_t* pBuffer1, uint8_t* pBuffer2, uint16_t BufferLength);
static void CLK_Config(void);
static void GPIO_Config(void);
/* Private functions ---------------------------------------------------------*/
/* Global variables ----------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/

/**
  * @brief  Main program.
  * @param  None
  * @retval None
  */
void main(void)
{
	uint8_t testByte = 0xA5;  // Example test byte
	uint8_t readByte = 0;
	/* Clock configuration -----------------------------------------*/
	CLK_Config();
	TIM4_Config();
	/* GPIO Configuration ------------------------------------------*/
	GPIO_Config();
  //SD_LowLevel_Init();
	
 /***********************SPI and MSD Card initialization******************/

	Delay(0xFFFF);
	/* Init the flash micro SD*/
	Status = SD_Init();
	
	SD_CS_LOW(); // Select SD card
	readByte = SD_WriteByte(testByte);
	SD_CS_HIGH(); // Deselect SD card

	
	if(readByte == testByte)
	{
		GPIO_WriteReverse(LED2);
	}

	
	/***************************Block Read/Write******************************/
	/* Write block of 512 bytes on address 0 */
	SD_WriteBlock(TxBuffer, 0, BUFFER_SIZE);
	
	/* Read block of 512 bytes from address 0 */
	SD_ReadBlock(RxBuffer, 0, BUFFER_SIZE);
	
	/* Check data */
	TransferStatus = Buffercmp(TxBuffer, RxBuffer, BUFFER_SIZE);
	if (TransferStatus != SUCCESS)
	{
		while (1) /* Go to infinite loop when there is mismatch in data programming*/
		{
			GPIO_WriteReverse(LED1);
			Delay((uint16_t)0xFFFF);
			Delay((uint16_t)0xFFFF);
		}
	}
	while (1)
	{
		GPIO_WriteReverse(LED1);
		GPIO_WriteReverse(LED2);
		GPIO_WriteReverse(LED3);
		GPIO_WriteReverse(LED4);
		Delay((uint16_t)0xFFFF);
		Delay((uint16_t)0xFFFF);
	}
}

/**
  * @brief  Configure system clock to run at 16Mhz
  * @param  None
  * @retval None
  */
static void CLK_Config(void)
{
	/* Initialization of the clock */
	/* Clock divider to HSI/1 */
	CLK_DeInit();
                
  CLK_HSECmd(DISABLE);
  CLK_LSICmd(DISABLE);
  CLK_HSICmd(ENABLE);
  while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
						
  CLK_ClockSwitchCmd(ENABLE);
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
						
  CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
  DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
						
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
}

static void GPIO_Config(void)
{
	GPIO_DeInit(GPIOC);     // Reset GPIO settings for port C
	GPIO_DeInit(GPIOA);     // Reset GPIO settings for port C
	GPIO_DeInit(GPIOB);     // Reset GPIO settings for port C
	GPIO_DeInit(GPIOD);     // Reset GPIO settings for port C
	GPIO_DeInit(GPIOE);     // Reset GPIO settings for port C
	GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOE, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // Initialize pin for GPIO
}

ErrorStatus Buffercmp(uint8_t* pBuffer1, uint8_t* pBuffer2, uint16_t BufferLength)
{
    while (BufferLength--)
    {
        if (*pBuffer1 != *pBuffer2)
        {
            return ERROR;
        }

        pBuffer1++;
        pBuffer2++;
    }

    return SUCCESS;
}

/**
  * @brief  Delay.
  * @param  nCount
  * @retval None
  */
void Delay(uint16_t nCount)
{
  /* Decrement nCount value */
  while (nCount != 0)
  {
    nCount--;
  }
}
