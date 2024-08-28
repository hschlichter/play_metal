#import "uiengineview.h"

@implementation UIEngineView
{
    CADisplayLink *_displayLink;

    // Secondary thread containing the render loop
    NSThread *_renderThread;

    // Flag to indcate rendering should cease on the main thread
    BOOL _continueRunLoop;
}

+ (Class) layerClass
{
    return [CAMetalLayer class];
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];

    if(self.window == nil)
    {
        // If moving off of a window destroy the display link.
        [_displayLink invalidate];
        _displayLink = nil;
        return;
    }

    [self setupCADisplayLinkForScreen:self.window.screen];

    // Protect _continueRunLoop with a `@synchronized` block since it is accessed by the seperate
    // animation thread
    @synchronized(self)
    {
        // Stop animation loop allowing the loop to complete if it's in progress.
        _continueRunLoop = NO;
    }

    // Create and start a secondary NSThread which will have another run runloop.  The NSThread
    // class will call the 'runThread' method at the start of the secondary thread's execution.
    _renderThread =  [[NSThread alloc] initWithTarget:self selector:@selector(runThread) object:nil];
    _continueRunLoop = YES;
    [_renderThread start];

    // Perform any actions which need to know the size and scale of the drawable.  When UIKit calls
    // didMoveToWindow after the view initialization, this is the first opportunity to notify
    // components of the drawable's size
    [self resizeDrawable:self.window.screen.nativeScale];
}

- (void)setPaused:(BOOL)paused
{
    super.paused = paused;

    _displayLink.paused = paused;
}

- (void)setupCADisplayLinkForScreen:(UIScreen*)screen
{
    [self stopRenderLoop];

    _displayLink = [screen displayLinkWithTarget:self selector:@selector(render)];

    _displayLink.paused = self.paused;

    _displayLink.preferredFramesPerSecond = 60;
}

- (void)applicationDidEnterBackground
{
    self.paused = YES;
}

- (void)applicationWillEnterForeground
{
    self.paused = NO;
}

- (void)stopRenderLoop
{
    [_displayLink invalidate];
}

- (void)runThread
{
    // Set the display link to the run loop of this thread so its call back occurs on this thread
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [_displayLink addToRunLoop:runLoop forMode:@"AAPLDisplayLinkMode"];

    // The '_continueRunLoop' ivar is set outside this thread, so it must be synchronized.  Create a
    // 'continueRunLoop' local var that can be set from the _continueRunLoop ivar in a @synchronized block
    BOOL continueRunLoop = YES;

    // Begin the run loop
    while (continueRunLoop)
    {
        // Create autorelease pool for the current iteration of loop.
        @autoreleasepool
        {
            // Run the loop once accepting input only from the display link.
            [runLoop runMode:@"AAPLDisplayLinkMode" beforeDate:[NSDate distantFuture]];
        }

        // Synchronize this with the _continueRunLoop ivar which is set on another thread
        @synchronized(self)
        {
            // Anything accessed outside the thread such as the '_continueRunLoop' ivar
            // is read inside the synchronized block to ensure it is fully/atomically written
            continueRunLoop = _continueRunLoop;
        }
    }
}

// Override all methods which indicate the view's size has changed
- (void)setContentScaleFactor:(CGFloat)contentScaleFactor
{
    [super setContentScaleFactor:contentScaleFactor];
    [self resizeDrawable:self.window.screen.nativeScale];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self resizeDrawable:self.window.screen.nativeScale];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self resizeDrawable:self.window.screen.nativeScale];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    [self resizeDrawable:self.window.screen.nativeScale];
}

@end
