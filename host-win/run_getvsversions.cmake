# Export component lists

# Install https://github.com/Microsoft/vssetup.powershell from NuGet
execute_process(
    COMMAND
    powershell Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope CurrentUser
    RESULT_VARIABLE rr
)
if(rr)
    message(FATAL_ERROR "Failed to install NuGet")
endif()

execute_process(
    COMMAND
    powershell Install-Module VSSetup -Scope CurrentUser -Force
    RESULT_VARIABLE rr)

if(rr)
    message(FATAL_ERROR "Failed to install VSSetup module")
endif()

execute_process(
    COMMAND
    powershell -ExecutionPolicy RemoteSigned "(Get-VSSetupInstance | Select-VSSetupInstance -Product *) | ConvertTo-Json"
    OUTPUT_FILE vssetup.json
    RESULT_VARIABLE rr)

if(rr)
    message(FATAL_ERROR "Failed to query VS packages")
endif()

return()

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
