function(update_git_submodules)
    find_package(Git QUIET)

    if(NOT GIT_FOUND)
        message(WARNING "Git not found! Submodules will not be updated automatically.")
        return()
    endif()

    if(NOT EXISTS "${PROJECT_SOURCE_DIR}/.git")
        message(STATUS "No Git repository found. Skipping submodule update.")
        return()
    endif()

    message(STATUS "Checking and updating Git submodules...")

    execute_process(
        COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive --depth=1
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        RESULT_VARIABLE GIT_SUBMOD_RESULT
        OUTPUT_VARIABLE GIT_SUBMOD_OUTPUT
        ERROR_VARIABLE GIT_SUBMOD_ERROR
    )

    if(NOT GIT_SUBMOD_RESULT EQUAL 0)
        message(FATAL_ERROR "Submodule update failed with error code ${GIT_SUBMOD_RESULT}.\n"
                            "Error: ${GIT_SUBMOD_ERROR}\n"
                            "Please run 'git submodule update --init --recursive' manually.")
    else()
        message(STATUS "Submodules updated successfully.")
    endif()
endfunction()
