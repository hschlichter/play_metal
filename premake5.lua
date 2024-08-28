workspace "Play"
    configurations { "Debug", "Release" }
    location "_build"

    filter {}
        language "C++"
        cppdialect "C++17"

project "Play-MacOS"
    kind "WindowedApp"
    system "macosx"
    architecture "ARM64"
    defines { "TARGET_MACOS" }
    targetname "Play"
    -- targetdir "_out/MacOS/%{cfg.buildcfg}/Play.app/Contents/MacOS/"
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
        ["CLANG_ENABLE_OBJC_ARC"] = "YES",
        ["CLANG_ENABLE_MODULES"] = "YES",

        ["CXX_STANDARD_LIBRARY"] = "libc++",
        ["CLANG_CXX_LANGUAGE_STANDARD"] = "c++17",
        ["CLANG_ENABLE_OBJC_WEAK"] = "YES",
        ["CLANG_ENABLE_CXX_MODULES"] = "YES",
        ["OTHER_CFLAGS"] = "-fmodules -fcxx-modules", 
        
        ["MTL_ENABLE_DEBUG_INFO"] = "YES",
        ["MTL_FAST_MATH"] = "YES",
        ["INFOPLIST_FILE"] = "../src/app/appkit/macOS/Info.plist",
        ["MACOSX_DEPLOYMENT_TARGET"] = "10.14",
    }

    filter "system:macosx"
        -- externalincludedirs {
        --     "/usr/include", 
        --     "/usr/local/include",
        --     "/System/Library/Frameworks/Cocoa.framework/Headers",
        -- }
        -- libdirs {
        --     "/usr/lib", 
        --     "/usr/local/lib" 
        -- }
        links {
            "Cocoa.framework",
            "QuartzCore.framework",
            "Foundation.framework",
            "Metal.framework",
            "MetalKit.framework",
        }
        -- postbuildcommands {
        --     "{COPY} ../src/app/appkit/macOS/Info.plist %{cfg.targetdir}/../",
        --     "{COPY} ../src/app/appkit/macOS/Base.lproj/Main.Storyboard %{cfg.targetdir}/Main.storyboard",
        -- }

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
    -- targetdir "_out/iOS/%{cfg.buildcfg}/Play.app/Contents/MacOS/"
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
        ["CLANG_ENABLE_OBJC_ARC"] = "YES",
        ["CLANG_ENABLE_MODULES"] = "YES",
        ["MTL_ENABLE_DEBUG_INFO"] = "YES",
        ["MTL_FAST_MATH"] = "YES",

        ["CXX_STANDARD_LIBRARY"] = "libc++",
        ["CLANG_CXX_LANGUAGE_STANDARD"] = "c++17",
        ["CLANG_ENABLE_OBJC_WEAK"] = "YES",
        ["CLANG_ENABLE_CXX_MODULES"] = "YES",
        ["OTHER_CFLAGS"] = "-fmodules -fcxx-modules", 

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
        -- externalincludedirs {
        --     "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include"
        -- }
        -- libdirs {
        --     "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib"
        -- }
        links {
            "UIKit.framework",
            "Foundation.framework",
            "QuartzCore.framework",
            "Metal.framework",
            "MetalKit.framework",
        }
        -- postbuildcommands {
        --     "{COPY} ../src/app/uikit/iOS/Info.plist %{cfg.targetdir}/../Info.plist",
        --     "{COPY} ../src/app/uikit/iOS/Base.lproj/Main.Storyboard %{cfg.targetdir}/Main.storyboard",
        -- }

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"

