#import "metalview.h"
#import <Metal/Metal.h>
#import <QuartzCore/CAMetalLayer.h>
#import "renderer.h"

@implementation MetalView
{
    CAMetalLayer* _metalLayer;
    Renderer* _renderer;
}

- (instancetype)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self)
    {
        _metalLayer = [CAMetalLayer layer];
        _metalLayer.device = MTLCreateSystemDefaultDevice();
        _metalLayer.pixelFormat = MTLPixelFormatBGRA8Unorm;
        self.layer = _metalLayer;
        self.wantsLayer = YES;

        _renderer = new Renderer(reinterpret_cast<MTL::Device*>(_metalLayer.device));
        [self render];
    }
    return self;
}

- (void)render
{
    @autoreleasepool
    {
        _renderer->draw(reinterpret_cast<CA::MetalLayer*>(_metalLayer));
        [self performSelector:@selector(render) withObject:nil afterDelay:1.0 / 60.0];
    }
}

@end
