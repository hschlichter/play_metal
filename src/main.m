#import <Cocoa/Cocoa.h>
#import "appdelegate.h"

int main(int argc, const char* argv[]) {
    @autoreleasepool {
        AppDelegate *delegate = [[AppDelegate alloc] init];
        NSApplication *app = [NSApplication sharedApplication];
        [app setDelegate:delegate];
        [app run];
    }
    return EXIT_SUCCESS;
}

