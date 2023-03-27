cmake_minimum_required (VERSION 3.15.3)

# Path to toolchain file. This one has to be before 'project()' below
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/arm-none-eabi-gcc.cmake)

# Switch for FreeRTOS support, enable it for some Applications who needs it.
set(ENABLE_FREERTOS OFF CACHE BOOL "Enable FreeRTOS")


# Set Project Name
project (basic_cmake)

# Allow switching of target mcu
set(MCU_LIST STM32F1xx STM32F4xx)
set(MCU STM32F1xx CACHE STRING "Default target is STM32F1xx")
set_property(CACHE MCU PROPERTY STRINGS ${MCU_LIST})

# List of source files
set(MAIN_SRC_FILES
    src/main.c
    src/initialize-hardware.c
)

# List of include files
set(MAIN_INC_FILES
    Inc/
)

# List of defines
set (TARGET_DEF_LISTS
    -DDEBUG        
    -DUSE_FULL_ASSERT
    -DSTM32F103xB
    -DUSE_HAL_DRIVER
    -DHSE_VALUE=8000000
)

# List of libraries
set(LIB_LIST

)

# compiler option
set(COMPILER_OPTION 
    -mcpu=cortex-m3 
    -mthumb 
    -std=gnu99
    -Os
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

# Linker Selection 
set(LINKER_SECTIONS
   -Tmem.ld
   -Tsections.ld
)

# Microcontroller memory config
set(FLASH_SIZE "64K" CACHE STRING "microcontroller FLASH size") 
set(RAM_SIZE  "20K" CACHE STRING "microcontroller RAM size")

configure_file (
    "${PROJECT_SOURCE_DIR}/system/ldscripts/mem.ld.in"
    "${PROJECT_BINARY_DIR}/system/ldscripts/mem.ld"
)
configure_file (
    "${PROJECT_SOURCE_DIR}/system/ldscripts/sections.ld.in"
    "${PROJECT_BINARY_DIR}/system/ldscripts/sections.ld"
)

find_package(Git QUIET)
if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
# Update submodules as needed
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule update")
        execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT)
        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init --recursive failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
        endif()
    endif()
endif()

set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

# Optional: issue a message to be sure it uses the correct toolchain file.
message(STATUS "CMAKE_TOOLCHAIN_FILE is: ${CMAKE_TOOLCHAIN_FILE}")

# Finding All SourceList.cmake in all sub directory
# Find all subdirectories that have SourceLists.cmake files
file(GLOB SUBDIRS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} */SourceLists.cmake)
foreach(SUBDIR ${SUBDIRS})
    include(${SUBDIR})   
    # Remove the SourceLists.cmake part from each subdirectory name
    string(REGEX REPLACE "/SourceLists.cmake" "" LPATH "${SUBDIR}")

    foreach(SRC_FILE ${SRC_FILES})
        list(APPEND MAIN_SRC_FILES ${LPATH}/${SRC_FILE})
    endforeach()

    foreach(INC_FILE ${INC_FILES})
        list(APPEND MAIN_INC_FILES ${LPATH}/${INC_FILE})
    endforeach()
    
    unset(SRC_FILES)
endforeach()

# Add FreeRTOS
if(ENABLE_FREERTOS)
    message(STATUS "ٍEnable FreeRTOS")

    add_library(freertos_config INTERFACE)
    target_include_directories(freertos_config SYSTEM
    INTERFACE
    system
    )

    target_compile_definitions(freertos_config
    INTERFACE
    projCOVERAGE_TEST=0
    )
    
    target_compile_options(freertos_config INTERFACE ${COMPILER_OPTION})

    # Select the native compile PORT
    set(FREERTOS_PORT "GCC_ARM_CM3" CACHE STRING "" FORCE)
    set(FREERTOS_HEAP "4" CACHE STRING "")
    set(FREERTOS_MAINSTACK "512" CACHE STRING "FreeRTOS main task stack in Byte")

    add_subdirectory(system/FreeRTOS)
    list(APPEND LIB_LIST "freertos_kernel")
    list(APPEND TARGET_DEF_LISTS USE_FREERTOS)
    list(APPEND TARGET_DEF_LISTS FREERTOS_MAINSTACK=${FREERTOS_MAINSTACK})
endif(ENABLE_FREERTOS)

# Build the executable based on the source files
set(EXECUTABLE ${PROJECT_NAME}.elf)
add_executable(${EXECUTABLE} ${MAIN_SRC_FILES})


# include directories to use when compiling a given target.
target_include_directories(${EXECUTABLE} PUBLIC ${MAIN_INC_FILES})

# Link the executable to the simple_cmake library.
target_link_libraries(${EXECUTABLE} ${LIB_LIST})

# List of compiler defines, prefix with -D compiler option
target_compile_definitions(${EXECUTABLE} PUBLIC ${TARGET_DEF_LISTS})

# Compiler options
target_compile_options(${EXECUTABLE} PUBLIC ${COMPILER_OPTION})

# Linker options
target_link_options(${EXECUTABLE} PRIVATE
    ${LINKER_SECTIONS}
    -L${CMAKE_CURRENT_BINARY_DIR}/system/ldscripts

    -mcpu=cortex-m3
    -fmessage-length=0 
    -fsigned-char 
    -ffunction-sections

    -Wall

    -nostartfiles
    -Xlinker --gc-sections
    -Wl,-Map=${PROJECT_NAME}.map,--cref
    -Wl,--gc-sections
)      

# Print executable size as part of the post build process
add_custom_command(TARGET ${EXECUTABLE}
        POST_BUILD
        COMMAND ${CMAKE_SIZE_UTIL} ${EXECUTABLE}
)

# Create hex and bin files after the build
add_custom_command(TARGET ${EXECUTABLE}
        POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -O binary ${EXECUTABLE} ${PROJECT_NAME}.bin
        COMMAND ${CMAKE_OBJCOPY} -O ihex ${EXECUTABLE} ${PROJECT_NAME}.hex
)