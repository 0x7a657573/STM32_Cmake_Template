
# Microcontroller memory config
set(FLASH_SIZE "64K" CACHE STRING "microcontroller FLASH size") 
set(RAM_SIZE  "20K" CACHE STRING "microcontroller RAM size")

# compiler option
set(TARGET_MCU_COMPILER
    -mcpu=cortex-m3 
    -mthumb 
    -std=gnu99
    -Og
    -g3
    -fmessage-length=0 
    -fsigned-char 
    -ffunction-sections 
    -fdata-sections 
    -ffreestanding 
    -fno-move-loop-invariants 
    -Wall 
    -Wextra 
)

# linker option
set(TARGET_MCU_LINKER
    -mcpu=cortex-m3
    -fmessage-length=0 
    -fsigned-char 
    -ffunction-sections
    -Wall
    -nostartfiles
    -Xlinker --gc-sections
)

# target define
set(TARGET_MCU_DEF
    -DDEBUG        
    -DUSE_FULL_ASSERT
    -DSTM32F103xB
    -DUSE_HAL_DRIVER
    -DHSE_VALUE=8000000
)