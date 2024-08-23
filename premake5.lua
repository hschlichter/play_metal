workspace "Play"
    configurations { "Debug", "Release" }
    location "_build"

project "Play"
    kind "ConsoleApp"

    language "C++"
    cppdialect "C++17"

    targetname "main"
    targetdir "_out/%{cfg.buildcfg}/Play.app/Contents/MacOS/"
    objdir "_temp/%{cfg.buildcfg}"

    files { 
        "src/**.m",
        "src/**.mm",
        "src/**.h",
        "src/**.cpp",
    }

    externalincludedirs { "/System/Library/Frameworks/Cocoa.framework/Headers" }
    externalincludedirs { "external/metal-cpp_macOS14.2_iOS17.2" }

    xcodebuildsettings {
        ["INFOPLIST_FILE"] = "../Info.plist",
        ["PRODUCT_BUNDLE_IDENTIFIER"] = "com.example.Play",
        -- ["CLANG_ENABLE_OBJC_ARC"] = "YES",
        ["MACOSX_DEPLOYMENT_TARGET"] = "10.14",
        ["MTL_ENABLE_DEBUG_INFO"] = "YES",
        ["MTL_FAST_MATH"] = "YES",
    }

    xcodebuildresources {
        "%{cfg.targetdir}/../Info.plist"
    }

    postbuildcommands {
        "{COPY} ../Info.plist %{cfg.targetdir}/../",
    }
    
    filter "system:macosx"
        links {
            "Cocoa.framework",
            "QuartzCore.framework",
            "Foundation.framework",
            "Metal.framework",
            "MetalKit.framework",
        }

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"

