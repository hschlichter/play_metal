workspace "Play"
    configurations { "Debug", "Release" }
    location "_build"

project "Play"
    kind "ConsoleApp"
    targetname "main"
    targetdir "_out/%{cfg.buildcfg}/Play.app/Contents/MacOS/"
    objdir "_temp/%{cfg.buildcfg}"

    files { "src/**.m" }
    includedirs { "/System/Library/Frameworks/Cocoa.framework/Headers" }

    xcodebuildsettings {
        ["INFOPLIST_FILE"] = "../Info.plist",
        ["PRODUCT_BUNDLE_IDENTIFIER"] = "com.example.Play",
    }

    xcodebuildresources {
        "%{cfg.targetdir}/../Info.plist"
    }

    postbuildcommands {
        "{COPY} ../Info.plist %{cfg.targetdir}/../"
    }

    filter "system:macosx"
        links { "Cocoa.framework" }

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"

