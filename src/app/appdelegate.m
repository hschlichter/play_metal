#import "appdelegate.h"
#if defined(TARGET_IOS)
#import "uikit/uiengineview.h"
#endif

@implementation AppDelegate

#if defined TARGET_MACOS
// Close app when window is closed
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication*)app {
    return YES;
}
#endif

#if defined(TARGET_IOS)
- (void)applicationDidFinishLaunching:(UIApplication*)app {
#elif defined(TARGET_MACOS)
- (void)applicationDidFinishLaunching:(NSNotification*)notification {
#endif
    
    [self start];
    
    self.keepRunning = YES;
    [self mainLoop];
}
    
#if defined(TARGET_IOS)
- (void)applicationWillTerminate:(UIApplication*)app {
#elif defined(TARGET_MACOS)
- (void)applicationWillTerminate:(NSNotification*)aNotification {
#endif
    self.keepRunning = NO;
    
    [self stop];
}
    
- (void)mainLoop {
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
        while (self.keepRunning)
        {
            @autoreleasepool {
                CFTimeInterval currentTime = CACurrentMediaTime();
                float deltaTime = (float)(currentTime - self.lastUpdateTime);
                self.lastUpdateTime = currentTime;
                
                [self update:deltaTime];
                
#if defined(TARGET_MACOS)
                NSEvent *event;
                while ((event = [NSApp nextEventMatchingMask:NSEventMaskAny
                                                   untilDate:nil
                                                      inMode:NSDefaultRunLoopMode
                                                     dequeue:YES])) {
                    [NSApp sendEvent:event];
                    [NSApp updateWindows];
                }
#endif

                [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.001]];
            }
        }
    });
}

#if defined(TARGET_IOS)
- (void)applicationWillResignActive:(UIApplication*)application {
    self.isInBackground = YES;
}

- (void)applicationDidBecomeActive:(UIApplication*)application {
    self.isInBackground = NO;
    self.lastUpdateTime = CACurrentMediaTime();
    [self mainLoop];
}

- (void)applicationDidEnterBackground:(UIApplication*)application {
    self.isInBackground = YES;
    self.keepRunning = NO;
}

- (void)applicationWillEnterForeground:(UIApplication*)application {
    self.isInBackground = NO;
    self.keepRunning = YES;
    self.lastUpdateTime = CACurrentMediaTime();
    [self mainLoop];
}
#endif
    
- (void)start {
    NSLog(@"Start");
}
    
- (void)update:(float)deltaTime {
    NSLog(@"Update, %f", deltaTime);
}

- (void)stop {
    NSLog(@"Stop");
}
    
@end
