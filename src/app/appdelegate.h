#if TARGET_IOS
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif

#if TARGET_IOS
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
#else
@interface AppDelegate : NSObject <NSApplicationDelegate>
#endif

@property (nonatomic, assign) BOOL keepRunning;
@property (nonatomic, assign) BOOL isInBackground;
@property (nonatomic, assign) CFTimeInterval lastUpdateTime;

@end
