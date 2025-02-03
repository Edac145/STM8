/**
  ******************************************************************************
  * @file    stm8s_eval.c
  * @author  MCD Application Team
  * @version V1.1.0
  * @date    05-February-2018
  * @brief   This file provides firmware functions to manage Leds, push-buttons
  *          and COM ports available on STM8S Evaluation Boards from STMicroelectronics.
  ******************************************************************************
  * @attention
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

/* Includes ------------------------------------------------------------------*/
#include "stm8s_eval.h"
#include "stm8s_spi.h"
#include "stm8s_clk.h"

void SD_LowLevel_DeInit(void)
{
	SPI_Cmd(DISABLE); /*!< SD_SPI disable */
   /*!< SD_SPI Peripheral clock disable */
   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 
   /*!< Configure SD_SPI pins: SCK */
  GPIO_Init(SD_SPI_SCK_GPIO_PORT, SD_SPI_SCK_PIN, GPIO_MODE_IN_FL_NO_IT);
 
  /*!< Configure SD_SPI pins: MISO */
  GPIO_Init(SD_SPI_MISO_GPIO_PORT, SD_SPI_MISO_PIN, GPIO_MODE_IN_FL_NO_IT);

  /*!< Configure SD_SPI pins: MOSI */
  GPIO_Init(SD_SPI_MOSI_GPIO_PORT, SD_SPI_MOSI_PIN, GPIO_MODE_IN_FL_NO_IT);

  /*!< Configure SD_SPI_CS_PIN pin: SD Card CS pin */
  GPIO_Init(SD_CS_GPIO_PORT, SD_CS_PIN, GPIO_MODE_IN_FL_NO_IT);
	
  /*!< Configure SD_SPI_DETECT_PIN pin: SD Card detect pin */
  //GPIO_Init(SD_DETECT_GPIO_PORT, SD_DETECT_PIN, GPIO_MODE_IN_FL_NO_IT);
}


void SD_LowLevel_Init(void)
{
/* Enable SPI clock */
   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE); 
 /* Set the MOSI,MISO and SCK at high level */
   GPIO_ExternalPullUpConfig(SD_SPI_SCK_GPIO_PORT, (GPIO_Pin_TypeDef)(SD_SPI_MISO_PIN | SD_SPI_MOSI_PIN |
                             SD_SPI_SCK_PIN), ENABLE);
 
   /* SD_SPI Configuration */
   SPI_Init( SPI_FIRSTBIT_MSB, SPI_BAUDRATEPRESCALER_4, SPI_MODE_MASTER,
            SPI_CLOCKPOLARITY_HIGH, SPI_CLOCKPHASE_2EDGE, SPI_DATADIRECTION_2LINES_FULLDUPLEX,
            SPI_NSS_SOFT, 0x07);
 
 
   /* SD_SPI enable */
   SPI_Cmd( ENABLE);
 
   /* Set MSD ChipSelect pin in Output push-pull high level */
   GPIO_Init(SD_CS_GPIO_PORT, SD_CS_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
}
/** @addtogroup Utilities
  * @{
  */

/** @defgroup STM8S_EVAL
  * @brief This file provides firmware functions to manage Leds, push-buttons
  *        and COM ports available on STM8 Evaluation Boards from STMicroelectronics.
  * @{
  */

/** @defgroup STM8S_EVAL_Abstraction_Layer
  * @{
  */

#ifdef USE_STM8_128_EVAL
 #include "stm8-128_eval/stm8_128_eval.c"
#else
// #error "Please select first the STM8 EVAL board to be used (in stm8s_eval.h)"
#endif

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private function ----------------------------------------------------------*/

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/