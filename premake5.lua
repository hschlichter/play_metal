-- workspace "Play"
--     configurations { "Debug", "Release" }
--     platforms { "MacOS", "iOS" }
--     location "_build"
--
--     filter "platforms:MacOS" 
--         system "macosx"
--         architecture "ARM64"
--         defines { "TARGET_MACOS" }
--
--     filter "platforms:iOS"
--         system "ios"
--         architecture "ARM64"
--         defines { "TARGET_IOS" }
--
--     filter {}
--         language "C++"
--         cppdialect "C++17"
--         objdir "_temp/%{cfg.platform}/%{cfg.buildcfg}"
--
-- project "Play"
--     kind "WindowedApp"
--
--     targetname "main"
--
--     files { 
--         "src/**.m",
--         "src/**.mm",
--         "src/**.h",
--         "src/**.cpp",
--         -- "src/app/appkit/macOS/Info.plist",
--         -- "src/app/appkit/macOS/Base.lproj/Main.storyboard",
--         "src/app/uikit/iOS/Info.plist",
--         "src/app/uikit/iOS/Base.lproj/Main.storyboard",
--     }
--
--     externalincludedirs { "external/metal-cpp_macOS14.2_iOS17.2" }
--
--     -- xcodebuildsettings {
--     --     ["PRODUCT_BUNDLE_IDENTIFIER"] = "com.example.Play",
--     --     -- ["CLANG_ENABLE_OBJC_ARC"] = "YES",
--     --     ["MTL_ENABLE_DEBUG_INFO"] = "YES",
--     --     ["MTL_FAST_MATH"] = "YES",
--     -- }
--
--     -- xcodebuildresources {
--     --     "%{cfg.targetdir}/../Info.plist"
--     -- }
--     
--     filter "system:macosx"
--         targetdir "_out/%{cfg.platform}/%{cfg.buildcfg}/Play.app/Contents/MacOS/"
--         externalincludedirs {
--             "/usr/include", 
--             "/usr/local/include",
--             "/System/Library/Frameworks/Cocoa.framework/Headers",
--         }
--         libdirs {
--             "/usr/lib", 
--             "/usr/local/lib" 
--         }
--         links {
--             "Cocoa.framework",
--             "QuartzCore.framework",
--             "Foundation.framework",
--             "Metal.framework",
--             "MetalKit.framework",
--         }
--         xcodebuildsettings {
--             ["INFOPLIST_FILE"] = "../src/app/appkit/macOS/Info.plist",
--             ["MACOSX_DEPLOYMENT_TARGET"] = "10.14",
--         }
--         postbuildcommands {
--             "{COPY} ../src/app/appkit/macOS/Info.plist %{cfg.targetdir}/../",
--             "{COPY} ../src/app/appkit/macOS/Base.lproj/Main.Storyboard %{cfg.targetdir}/Main.storyboard",
--         }
--
--     filter "system:ios" 
--         targetdir "_out/%{cfg.platform}/%{cfg.buildcfg}/Play.app/Contents/iOS/"
--         externalincludedirs {
--             "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include"
--         }
--         libdirs {
--             "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib"
--         }
--         links {
--             "UIKit.framework",
--             "Foundation.framework",
--             "QuartzCore.framework",
--             "Metal.framework",
--             "MetalKit.framework",
--         }
--         xcodebuildsettings {
--             ["INFOPLIST_FILE"] = "../src/app/uikit/iOS/Info.plist",
--         }
--         postbuildcommands {
--             "{COPY} ../src/app/uikit/iOS/Info.plist %{cfg.targetdir}/../Info.plist",
--             "{COPY} ../src/app/uikit/iOS/Base.lproj/Main.Storyboard %{cfg.targetdir}/Main.storyboard",
--         }
--
--     filter "configurations:Debug"
--         defines { "DEBUG" }
--         symbols "On"
--
--     filter "configurations:Release"
--         defines { "NDEBUG" }
--         optimize "On"



workspace "MyWorkspace"
    configurations { "Debug", "Release" }
    platforms { "MacOS", "iOS" }
    location "build"

    -- MacOS Project
    project "MyApp-MacOS"
        kind "WindowedApp"
        language "C++"
        cppdialect "C++17"
        targetname "MyApp"
        system "macosx"
        architecture "x86_64"
        files { "src/**.cpp", "src/**.h" }
        targetdir "_out/MacOS/%{cfg.buildcfg}/MyApp.app/Contents/MacOS/"
        
        -- macOS-specific frameworks
        links {
            "Cocoa.framework",
            "QuartzCore.framework",
            "Foundation.framework",
            "Metal.framework",
            "MetalKit.framework"
        }

        -- Debug Configuration for macOS
        filter "configurations:Debug"
            defines { "DEBUG" }
            symbols "On"

        -- Release Configuration for macOS
        filter "configurations:Release"
            defines { "NDEBUG" }
            optimize "On"

    -- iOS Project
    project "MyApp-iOS"
        kind "WindowedApp"
        language "C++"
        cppdialect "C++17"
        targetname "MyApp"
        system "ios"
        architecture "ARM64"
        files { "src/**.cpp", "src/**.h", "Resources/Main.storyboard", "Resources/Info.plist" }
        targetdir "_out/iOS/%{cfg.buildcfg}/MyApp.app/Contents/iOS/"
        
        -- iOS-specific frameworks
        links {
            "UIKit.framework",
            "QuartzCore.framework",
            "Foundation.framework",
            "Metal.framework",
            "MetalKit.framework"
        }

        -- Copy storyboard and Info.plist to the app bundle
        postbuildcommands {
            "{COPY} Resources/Main.storyboardc %{cfg.targetdir}/Main.storyboardc",
            "{COPY} Resources/Info.plist %{cfg.targetdir}/../Info.plist"
        }

        -- Debug Configuration for iOS
        filter "configurations:Debug"
            defines { "DEBUG" }
            symbols "On"

        -- Release Configuration for iOS
        filter "configurations:Release"
            defines { "NDEBUG" }
            optimize "On"

