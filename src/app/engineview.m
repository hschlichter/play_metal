#import "engineview.h"

@implementation EngineView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initCommon];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self initCommon];
    }
    return self;
}

- (void)initCommon
{
    _metalLayer = (CAMetalLayer*) self.layer;

    self.layer.delegate = self;

#if defined(TARGET_IOS)
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(applicationDidEnterBackground)
                   name:UIApplicationDidEnterBackgroundNotification
                 object:nil];
    
    [center addObserver:self
               selector:@selector(applicationWillEnterForeground)
                   name:UIApplicationWillEnterForegroundNotification
                 object:nil];
#endif
}

- (void)stopRenderLoop
{
    // Stubbed out method.  Subclasses need to implement this method.
}

- (void)dealloc
{
#if defined(TARGET_IOS)
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#endif
    
    [self stopRenderLoop];
}

- (void)resizeDrawable:(CGFloat)scaleFactor
{
    CGSize newSize = self.bounds.size;
    newSize.width *= scaleFactor;
    newSize.height *= scaleFactor;

    if(newSize.width <= 0 || newSize.width <= 0)
    {
        return;
    }

    // All AppKit and UIKit calls which notify of a resize are called on the main thread.  Use
    // a synchronized block to ensure that resize notifications on the delegate are atomic
    @synchronized(_metalLayer)
    {
        if(newSize.width == _metalLayer.drawableSize.width &&
           newSize.height == _metalLayer.drawableSize.height)
        {
            return;
        }

        _metalLayer.drawableSize = newSize;

        [_delegate drawableResize:newSize];
    }
}

- (void)render
{
    // Must synchronize if rendering on background thread to ensure resize operations from the
    // main thread are complete before rendering which depends on the size occurs.
    @synchronized(_metalLayer)
    {
        [_delegate renderToMetalLayer:_metalLayer];
    }
}

@end
