# Export component lists
execute_process(
    COMMAND
    powershell -ExecutionPolicy RemoteSigned "(Get-VSSetupInstance | Select-VSSetupInstance -Product *) | ConvertTo-Json"
    OUTPUT_FILE vssetup.json # FIXME: Won't be a JSON if no VS on the system
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
    RESULT_VARIABLE rr)

if(rr)
    message(FATAL_ERROR "Failed to query VS packages")
endif()

# Export installation config
# FIXME: Fill it with powershell
set(install_path
    "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional")

cmake_path(SET vswhere0 NORMALIZE "c:/Program Files (x86)/Microsoft Visual Studio/Installer/vs_installer.exe")
cmake_path(NATIVE_PATH vswhere0 vswhere)


execute_process(
    COMMAND ${vswhere} export
    --installPath ${install_path}
    --quiet
    --config export.json

    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
