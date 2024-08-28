#import <QuartzCore/CAMetalLayer.h>
#import <Metal/Metal.h>

#if TARGET_IOS
@import UIKit;
#else
@import AppKit;
#endif

// Protocol to provide resize and redraw callbacks to a delegate
@protocol EngineViewDelegate <NSObject>

- (void)drawableResize:(CGSize)size;

- (void)renderToMetalLayer:(nonnull CAMetalLayer *)metalLayer;

@end

// Metal view base class
#if TARGET_IOS
@interface EngineView : UIView <CALayerDelegate>
#else
@interface EngineView : NSView <CALayerDelegate>
#endif

@property (nonatomic, nonnull, readonly) CAMetalLayer *metalLayer;

@property (nonatomic, getter=isPaused) BOOL paused;

@property (nonatomic, nullable) id<EngineViewDelegate> delegate;

- (void)initCommon;

- (void)resizeDrawable:(CGFloat)scaleFactor;

- (void)stopRenderLoop;

- (void)render;

@end
