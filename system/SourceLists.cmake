

set(SRC_FILES 
    src/cmsis/system_stm32f1xx.c
    src/cmsis/vectors_stm32f103xb.c
    src/cortexm/exception-handlers.c
    src/cortexm/initialize-hardware.c
    src/cortexm/reset-hardware.c
    src/diag/trace-impl.c
    src/diag/trace.c
    src/newlib/assert.c
    src/newlib/cxx.cpp
    src/newlib/exit.c
    src/newlib/sbrk.c
    src/newlib/startup.c
    src/newlib/syscalls.c    
    # HAL Library Source
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_eth.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_dma.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_dac_ex.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_dac.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_crc.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_cortex.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_cec.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_can.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_adc_ex.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_adc.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_iwdg.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_irda.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_i2s.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_i2c.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_hcd.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_gpio_ex.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_gpio.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_flash_ex.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_flash.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_exti.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_smartcard.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_sd.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_rtc_ex.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_rtc.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_rcc_ex.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_rcc.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_pwr.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_hal_pcd_ex.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_hal_pcd.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_pccard.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_nor.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_nand.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_mmc.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_wwdg.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_usart.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_uart.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_tim_ex.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_tim.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_sram.c
    stm32f1xx_hal_driver/Src/stm32f1xx_hal_spi.c

    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_rcc.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_pwr.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_i2c.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_gpio.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_fsmc.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_exti.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_dma.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_dac.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_crc.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_adc.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_utils.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_usb.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_usart.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_tim.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_spi.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_sdmmc.c
    # stm32f1xx_hal_driver/Src/stm32f1xx_ll_rtc.c
)

set(INC_FILES
    .    
    include
    include/cmsis
    stm32f1xx_hal_driver/Inc
)