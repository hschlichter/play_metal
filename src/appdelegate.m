#import "appdelegate.h"
#import "metalview.h"

@implementation AppDelegate {
    NSWindow* _window;
    MetalView* _metalView;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSRect frame = NSMakeRect(0, 0, 800, 600);
    _window = [[NSWindow alloc] initWithContentRect:frame
                                          styleMask:(NSWindowStyleMaskTitled |
                                                     NSWindowStyleMaskClosable |
                                                     NSWindowStyleMaskResizable)
                                            backing:NSBackingStoreBuffered
                                              defer:NO];
    _metalView = [[MetalView alloc] initWithFrame:frame];
    [_window setTitle:@"MetalCpp Triangle"];
    [_window setContentView:_metalView];
    [_window makeKeyAndOrderFront:nil];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app {
    return YES;
}

@end

