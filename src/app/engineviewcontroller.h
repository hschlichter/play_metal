#if defined(TARGET_IOS)
#import <UIKit/UIKit.h>
#define PlatformViewController UIViewController
#else
#include <AppKit/AppKit.h>
#define PlatformViewController NSViewController
#endif

#import "engineview.h"

@interface EngineViewController : PlatformViewController <EngineViewDelegate>

@end
