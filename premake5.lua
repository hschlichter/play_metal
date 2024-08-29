workspace "Play"
    configurations { "Debug", "Release" }
    location "_build"

    filter {}
        language "C++"
        cppdialect "C++17"

    xcodebuildsettings {
        ["CLANG_ENABLE_OBJC_ARC"] = "YES",
        ["CLANG_ENABLE_MODULES"] = "NO",
        ["CLANG_ENABLE_CXX_MODULES"] = "NO",
        ["CXX_STANDARD_LIBRARY"] = "libc++",
        ["CLANG_CXX_LANGUAGE_STANDARD"] = "c++17",
        ["CLANG_ENABLE_OBJC_WEAK"] = "YES",
        ["MTL_ENABLE_DEBUG_INFO"] = "YES",
        ["MTL_FAST_MATH"] = "YES",
    }

project "Play-MacOS"
    kind "WindowedApp"
    system "macosx"
    architecture "ARM64"
    defines { "TARGET_MACOS" }
    targetname "Play"
    targetdir "_out/MacOS/%{cfg.buildcfg}"
    objdir "_temp/MacOS/%{cfg.buildcfg}"

    files { 
        "src/**.m",
        "src/**.mm",
        "src/**.h",
        "src/**.cpp",
        "src/app/appkit/macOS/Info.plist",
        "src/app/appkit/macOS/Base.lproj/Main.storyboard",
    }

    removefiles {
        "src/app/uikit/**",
    }

    includedirs {
        "src/",
    }
    
    externalincludedirs { 
        "external/metal-cpp_macOS14.2_iOS17.2"
    }

    xcodebuildsettings {
        ["PRODUCT_BUNDLE_IDENTIFIER"] = "com.example.macos.Play",
        ["INFOPLIST_FILE"] = "../src/app/appkit/macOS/Info.plist",
        ["MACOSX_DEPLOYMENT_TARGET"] = "10.14",
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

project "Play-iOS"
    kind "WindowedApp"
    system "ios"
    architecture "ARM64"
    defines { "TARGET_IOS" }
    targetname "Play"
    targetdir "_out/iOS/%{cfg.buildcfg}"
    objdir "_temp/iOS/%{cfg.buildcfg}"

    files { 
        "src/**.m",
        "src/**.mm",
        "src/**.h",
        "src/**.cpp",
        "src/app/uikit/iOS/Info.plist",
        "src/app/uikit/iOS/Base.lproj/Main.storyboard",
    }

    removefiles {
        "src/app/appkit/**",
    }

    includedirs {
        "src/",
    }

    externalincludedirs { "external/metal-cpp_macOS14.2_iOS17.2" }

    xcodebuildsettings {
        ["PRODUCT_BUNDLE_IDENTIFIER"] = "com.example.ios.Play",
        ["INFOPLIST_FILE"] = "../src/app/uikit/iOS/Info.plist",
        ["SDKROOT"] = "iphoneos",
        ["TARGETED_DEVICE_FAMILY"] = "1,2",
        ["IPHONEOS_DEPLOYMENT_TARGET"] = "17.0",
        ["CXX_STANDARD_LIBRARY"] = "libc++",
        ["LIBRARY_SEARCH_PATHS"] = {
            "$(SDKROOT)/usr/lib",
        },
        ["HEADER_SEARCH_PATHS"] = {
            "$(SDKROOT)/usr/include",
            "$(SDKROOT)/usr/include/c++/v1",
        },
    }

    filter "system:ios" 
        links {
            "UIKit.framework",
            "Foundation.framework",
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

