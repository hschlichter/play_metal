#if defined(TARGET_IOS)
@import UIKit;
#define PlatformViewController UIViewController
#else
@import AppKit;
#define PlatformViewController NSViewController
#endif

#import "engineview.h"

@interface EngineViewController : PlatformViewController <EngineViewDelegate>

@end
