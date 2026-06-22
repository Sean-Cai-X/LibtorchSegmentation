if(MSVC AND NOT TARGET CUDA::nvToolsExt)
    find_package(CUDAToolkit QUIET)
    if(CUDAToolkit_FOUND AND NOT TARGET CUDA::nvToolsExt)
        add_library(CUDA::nvToolsExt INTERFACE IMPORTED)
        if(DEFINED CUDAToolkit_INCLUDE_DIRS)
            set_target_properties(CUDA::nvToolsExt PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${CUDAToolkit_INCLUDE_DIRS}"
            )
        endif()
        message(STATUS "Provided CUDA::nvToolsExt compatibility target for CUDA/NVTX header-only layout")
    endif()
endif()

function(libtorchsegmentation_sanitize_nvtoolsext_includes target_name)
    if(NOT TARGET ${target_name})
        return()
    endif()

    get_target_property(_includes ${target_name} INTERFACE_INCLUDE_DIRECTORIES)
    if(NOT _includes)
        return()
    endif()

    set(_cleaned_includes "")
    foreach(_include_dir IN LISTS _includes)
        if(_include_dir MATCHES "NVIDIA Corporation[/\\\\]NvToolsExt[/\\\\]include")
            if(DEFINED CUDAToolkit_INCLUDE_DIRS)
                list(APPEND _cleaned_includes "${CUDAToolkit_INCLUDE_DIRS}")
            endif()
        else()
            list(APPEND _cleaned_includes "${_include_dir}")
        endif()
    endforeach()

    list(REMOVE_DUPLICATES _cleaned_includes)
    set_target_properties(${target_name} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${_cleaned_includes}"
    )
endfunction()
