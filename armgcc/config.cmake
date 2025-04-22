# config to select component, the format is CONFIG_USE_${component}
# Please refer to cmake files below to get available components:
#  ${SdkRootDirPath}/devices/MIMXRT1064/all_lib_device.cmake

set(CONFIG_COMPILER gcc)
set(CONFIG_TOOLCHAIN armgcc)
# set(CONFIG_USE_COMPONENT_CONFIGURATION false)
# set(CONFIG_USE_board_boot_header true)
# set(CONFIG_USE_driver_clock true)
# set(CONFIG_USE_driver_iomuxc false)
# set(CONFIG_USE_CMSIS_Include_core_cm true)
# set(CONFIG_USE_device_CMSIS true)
# set(CONFIG_USE_device_system true)
# set(CONFIG_USE_device_startup true)
# set(CONFIG_USE_device_boot_header true)
# set(CONFIG_USE_driver_cache_armv7_m7 true)
# set(CONFIG_USE_driver_common false)
# set(CONFIG_USE_driver_dcdc_1 true)
# set(CONFIG_USE_driver_gpc_1 true)
# set(CONFIG_USE_driver_igpio true)
# set(CONFIG_USE_driver_lpuart true)
# set(CONFIG_USE_driver_pmu true)
# set(CONFIG_USE_driver_src true)
# set(CONFIG_USE_utility_assert_lite true)
# set(CONFIG_USE_utilities_misc_utilities true)
# set(CONFIG_USE_utility_str true)
# set(CONFIG_USE_utility_debug_console_lite true)
# set(CONFIG_USE_component_lpuart_adapter true)
# set(CONFIG_USE_middleware_freertos-kernel true)
# set(CONFIG_USE_middleware_freertos-kernel_heap_4 true)
# set(CONFIG_USE_middleware_freertos-kernel_extension true)
# set(CONFIG_USE_middleware_freertos-kernel_config true)
set(CONFIG_CORE cm7f)
set(CONFIG_DEVICE MIMXRT1064)
set(CONFIG_BOARD evkmimxrt1064)
set(CONFIG_KIT evkmimxrt1064)
set(CONFIG_DEVICE_ID MIMXRT1064xxxxA)
set(CONFIG_FPU DP_FPU)
set(CONFIG_DSP NO_DSP)
set(CONFIG_CORE_ID core0)

function(group_link_libraries)
    get_property(
            SDK_LIB_FILES
            TARGET ${MCUX_SDK_PROJECT_NAME}
            PROPERTY LINK_LIBRARIES)

    foreach(item ${SDK_LIB_FILES})
        string(REGEX MATCH "::@.*|-Wl,--start-group|-Wl,--end-group" match "${item}")
        if (match)
            continue()
        else ()
            list(APPEND already_added_libs ${item})
        endif ()
    endforeach()

    list(REMOVE_DUPLICATES already_added_libs)
    # clear link libraries before reordering
    set_property(TARGET ${MCUX_SDK_PROJECT_NAME} PROPERTY LINK_LIBRARIES "")
    # wrap all link libraries
    target_link_libraries(${MCUX_SDK_PROJECT_NAME} PRIVATE -Wl,--start-group)

    target_link_libraries(${MCUX_SDK_PROJECT_NAME} PRIVATE ${already_added_libs})

    target_link_libraries(${MCUX_SDK_PROJECT_NAME} PRIVATE -Wl,--end-group)
endfunction()