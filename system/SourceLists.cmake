

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
)

set(INC_FILES
    .    
    include
    include/cmsis
    stm32f1xx_hal_driver/Inc
)