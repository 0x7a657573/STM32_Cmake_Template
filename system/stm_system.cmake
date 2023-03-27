
if(MCU STREQUAL STM32F1xx)
        include(system/f1_core/f1_core.cmake)
elseif(MCU STREQUAL STM32F4xx)
        include(system/f4_core/f4_core.cmake)
else()
        list(JOIN MCU_LIST "\r\n" strlist)
        message(FATAL_ERROR "Please Select correct MCU from list: \n${strlist}")
endif()
