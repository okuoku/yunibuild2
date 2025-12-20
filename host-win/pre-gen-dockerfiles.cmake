foreach(osversion ltsc2025 ltsc2025-arm64)
    # ltsc2025: Current
    # ltsc2022: Standard baseimage(LTSC2022 for GitHub Actions)
    # 2004: On Windows10, 2004 is only suitable image for it
    set(BASEIMAGE mcr.microsoft.com/windows/servercore:${osversion})
    if(${osversion} STREQUAL 2004)
        set(label win10desktop)
    else()
        set(label ${osversion})
    endif()
    foreach(tool cygwin msys2-ucrt64 msys2-i686 msvc17-base)
        configure_file(${CMAKE_CURRENT_LIST_DIR}/Dockerfile-${tool}.in
            ${CMAKE_CURRENT_LIST_DIR}/Dockerfile-${tool}.${label}
            @ONLY)
    endforeach()
endforeach()
