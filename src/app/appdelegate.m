#import "appdelegate.h"

@implementation AppDelegate

#if TARGET_MACOS
// Close app when window is closed
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app {
    return YES;
}
#endif

@end
