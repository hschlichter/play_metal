#import "engineviewcontroller.h"
#if TARGET_IOS
#import "uiengineview.h"
#else
#import "nsengineview.h"
#endif

#include "renderer/renderer.h"

#import <QuartzCore/CAMetalLayer.h>

@implementation EngineViewController
{
    Renderer* _renderer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    MTLPixelFormat pixelFormat = MTLPixelFormatBGRA8Unorm_sRGB;

    EngineView *view = (EngineView*)self.view;
    view.metalLayer.device = device;
    view.delegate = self;
    view.metalLayer.pixelFormat = pixelFormat;

    _renderer = new Renderer((__bridge MTL::Device*)device, (MTL::PixelFormat)pixelFormat);
}

- (void)drawableResize:(CGSize)size
{
//    [_renderer drawableResize:size];
}

- (void)renderToMetalLayer:(nonnull CAMetalLayer*)layer
{
    _renderer->Render((__bridge CA::MetalLayer*)layer);
}

@end
