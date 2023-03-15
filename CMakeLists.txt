cmake_minimum_required (VERSION 3.15.3)

# Path to toolchain file. This one has to be before 'project()' below
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/arm-none-eabi-gcc.cmake)

# Set Project Name
project (basic_cmake)


# List of source files
set(MAIN_SRC_FILES
    src/main.c
    src/initialize-hardware.c
)

# List of include files
set(MAIN_INC_FILES
    Inc/
)

# List of libraries
set(LIB_LIST
    
)

# Linker Selection 
set(LINKER_SECTIONS
   -Tmem.ld
   -Tsections.ld
)

set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

# Optional: issue a message to be sure it uses the correct toolchain file.
message(STATUS "CMAKE_TOOLCHAIN_FILE is: ${CMAKE_TOOLCHAIN_FILE}")

# Find all subdirectories that have CMakeLists.txt files
file(GLOB SUBDIRS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} */CMakeLists.txt)

# Remove the CMakeLists.txt part from each subdirectory name
string(REGEX REPLACE "/CMakeLists.txt" "" SUBDIRS "${SUBDIRS}")

#Add each subdirectory to the build
foreach(SUBDIR ${SUBDIRS})
    add_subdirectory(${SUBDIR})
endforeach()

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

# Build the executable based on the source files
set(EXECUTABLE ${PROJECT_NAME}.elf)
add_executable(${EXECUTABLE} ${MAIN_SRC_FILES})


# include directories to use when compiling a given target.
target_include_directories(${EXECUTABLE} PUBLIC ${MAIN_INC_FILES})

# Link the executable to the simple_cmake library.
target_link_libraries(${EXECUTABLE} ${LIB_LIST})

# List of compiler defines, prefix with -D compiler option
target_compile_definitions(${EXECUTABLE} PUBLIC
    -DDEBUG        
    -DUSE_FULL_ASSERT
    -DSTM32F103xB
    -DUSE_HAL_DRIVER
    -DHSE_VALUE=8000000
)

# Compiler options
target_compile_options(${EXECUTABLE} PUBLIC
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

# Linker options
target_link_options(${EXECUTABLE} PRIVATE
    ${LINKER_SECTIONS}
    -L${CMAKE_SOURCE_DIR}/system/ldscripts

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