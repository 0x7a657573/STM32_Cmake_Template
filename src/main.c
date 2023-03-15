/**********************************************************************
 * File : main.c
 * Copyright (c) 0x7a657573.
 * Created On : Mon Mar 13 2023
 * 
 * This program is free software: you can redistribute it and/or modify  
 * it under the terms of the GNU General Public License as published by  
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful, but 
 * WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License 
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 **********************************************************************/
#include <stm32f1xx.h>
#include <stm32f1xx_hal.h>
#include <stm32f1xx_hal_gpio.h>
#include "main.h"

int main(void)
{
    LED_GPIO_CLK_ENABLE();
    LL_GPIO_SetPinMode(LED_GPIO_PORT, LED_PIN, LL_GPIO_MODE_OUTPUT);

    while (1)
    {
        LL_GPIO_TogglePin(LED_GPIO_PORT, LED_PIN);
        HAL_Delay(100);
    }
    
   return 0; 
}
