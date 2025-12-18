# Tentative: Build both amd64/arm64
# yunibuild-<>-amd64

set(docker podman) # FIXME: Detect it
set(imagetypes)
macro(imginfo name variant path)
    if("${variant}" STREQUAL BOTH)
        set(_variants amd64 arm64)
    else()
        set(_variants ${variant})
    endif()
    set(_pth ${CMAKE_CURRENT_LIST_DIR}/${path})
    if(IS_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/${path})
        set(_pth_amd64 ${_pth})
        set(_pth_arm64 ${_pth})
    else()
        set(_pth_amd64 ${_pth}-amd64)
        set(_pth_arm64 ${_pth}-arm64)
    endif()
    list(APPEND imagetypes ${name})
    foreach(v IN LISTS _variants)
        if(IS_DIRECTORY ${_pth_${v}})
            set(${name}-${v} ${_pth_${v}})
        else()
            message(STATUS "Not found: ${_pth_${v}} (${name}:${v})")
        endif()
    endforeach()
endmacro()

# Linux
imginfo(fedora BOTH linux/yunifedora)
imginfo(linuxglibc BOTH linux/yunilinuxglibc)
imginfo(linuxmusl BOTH linux/yunilinuxmusl)
imginfo(linuxsteam amd64 linux/yunilinuxsteam)
imginfo(ubuntu BOTH linux/yuniubuntu)
imginfo(alpine BOTH linux/yunialpine)

# SDK
imginfo(android amd64 yuniandroid)

foreach(i IN LISTS imagetypes)
    foreach(v amd64 arm64)
        if(${i}-${v})
            message(STATUS "Building ${i} (${v})")
            execute_process(COMMAND ${docker}
                build --platform linux/${v}
                --tag yunibuild-${i}-${v}
                .
                RESULT_VARIABLE rr
                WORKING_DIRECTORY ${${i}-${v}})
            if(rr)
                message(FATAL_ERROR "Failed to build ${i} (${v})")
            endif()
        endif()
    endforeach()
endforeach()

