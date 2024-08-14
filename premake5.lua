workspace "PlayMetalApp"
    configurations { "Debug", "Release" }
    location "_build"

project "PlayMetalApp"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    targetdir "bin/%{cfg.buildcfg}"
    location "_build"
    files {
        -- "src/**.mm",
        "src/**.cpp",
        "src/**.h",
        "src/**.metal",
    }

    externalincludedirs { "external/metal-cpp_macOS14.2_iOS17.2" }

    -- Set up Xcode project
    xcodebuildsettings {
        ["CLANG_ENABLE_OBJC_ARC"] = "YES",  -- Enable ARC
        ["MACOSX_DEPLOYMENT_TARGET"] = "10.14",  -- Minimum macOS version
        ["MTL_ENABLE_DEBUG_INFO"] = "YES"  -- Enable Metal debug info
    }

    filter "system:macosx"
        toolset "clang"
        defines { "PLATFORM_MACOSX" }
        links {
            "Cocoa.framework",
            "QuartzCore.framework",
            "Metal.framework",
            "MetalKit.framework",
        }

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"

