#include "stm8s_i2c.h"
//#include "i2c.h"
#include "stdio.h"

void I2CInit()
{
    I2C_Init(100000, 0x00, I2C_DUTYCYCLE_2,
            I2C_ACK_NONE, I2C_ADDMODE_7BIT, 2);
}

void I2CDeinit()
{
    I2C_DeInit();
}

void I2CWrite(uint8_t slave, uint8_t addr, uint8_t * buffer, uint8_t size)
{
    // need to read regs to clear some flags
    volatile uint8_t reg;
		uint8_t index = 0;

    I2C_Cmd(ENABLE);
    I2C_GenerateSTART(ENABLE);
    // wait until start is sent
    while(!(I2C->SR1 & I2C_SR1_SB));
    // EV5: SB=1, cleared by reading SR1 register followed by writing DR register with Address.

    I2C_Send7bitAddress(slave, I2C_DIRECTION_TX);
    // wait addr bit, if set - we have ACK
    while(!(I2C->SR1 & I2C_SR1_ADDR));
    // EV6: ADDR=1, cleared by reading SR1 register followed by reading SR3
    reg = I2C->SR1;
    reg = I2C->SR3;
    // EV8_1: TXE=1, shift register empty, data register empty, write DR register.

    I2C_SendData(addr);
    while(!(I2C->SR1 & I2C_SR1_TXE));

    while(size)
    {
        size--;
        I2C_SendData(buffer[index]);
        index++;
        // wait TXE, set after data moved to shift reg
        while(!(I2C->SR1 & I2C_SR1_TXE));
        // EV8: TXE=1, shift register not empty, data register empty, cleared by writing DR register
    }
    // wait bte
    while(!(I2C->SR1 & I2C_SR1_BTF));
    //EV8_2: TXE=1, BTF = 1, Program STOP request. TXE and BTF are cleared by HW by stop condition

    //stop after this byte
    I2C_GenerateSTOP(ENABLE);

    // wait MSL
    while((I2C->SR3 & I2C_SR3_MSL));
    I2C_Cmd(DISABLE);
}


void I2CRead(uint8_t slave, uint8_t addr, uint8_t * buffer, uint8_t size)
{
    // need to read regs to clear some flags
    volatile uint8_t reg;
		uint8_t index = 0;

    I2C_Cmd(ENABLE);
    I2C_GenerateSTART(ENABLE);
    // wait until start is sent
    //printf("I2CRead: wait tx SB\r\n");
    while(!(I2C->SR1 & I2C_SR1_SB));
    // EV5: SB=1, cleared by reading SR1 register followed by writing DR register with Address.
    
    I2C_Send7bitAddress(slave, I2C_DIRECTION_TX);
    // wait addr bit, if set - we have ACK
    //printf("I2CRead: wait tx ADDR\r\n");
    while(!(I2C->SR1 & I2C_SR1_ADDR));
    // EV6: ADDR=1, cleared by reading SR1 register followed by reading SR3
    reg = I2C->SR1;
    reg = I2C->SR3;
    // EV8_1: TXE=1, shift register empty, data register empty, write DR register.

    I2C_SendData(addr);
    //printf("I2CRead: wait tx addr TXE\r\n");
    while(!(I2C->SR1 & I2C_SR1_TXE));
    //printf("I2CRead: wait tx addr BTF\r\n");
    while(!(I2C->SR1 & I2C_SR1_BTF));

    // we should ACK received data
    I2C->CR2 |= I2C_CR2_ACK;

    I2C_GenerateSTART(ENABLE);
    //printf("I2CRead: wait rx SB\r\n");
    while(!(I2C->SR1 & I2C_SR1_SB));

    I2C_Send7bitAddress(slave, I2C_DIRECTION_RX);
    // wait addr bit, if set - we have ACK
    //printf("I2CRead: wait rx ADDR\r\n");
    while(!(I2C->SR1 & I2C_SR1_ADDR));
    // EV6: ADDR=1, cleared by reading SR1 register followed by reading SR3
    reg = I2C->SR1;
    reg = I2C->SR3;

    while(size)
    {
        size--;
        if(size == 0)
        {
            // we should NACK last byte
            I2C->CR2 &= ~I2C_CR2_ACK;
        }
        //printf("I2CRead: wait rx RXNE\r\n");
        while(!(I2C->SR1 & I2C_SR1_RXNE));
        buffer[index] = I2C_ReceiveData();
        index++;
    }

    //stop after this byte
    I2C_GenerateSTOP(ENABLE);

    // wait MSL
    //printf("I2CRead: wait MSL\r\n");
    while((I2C->SR3 & I2C_SR3_MSL));
    I2C_Cmd(DISABLE);
}
