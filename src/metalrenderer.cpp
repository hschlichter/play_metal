#include "metalrenderer.h"

MetalRenderer::MetalRenderer(MTL::Device* device, CAMetalLayer* layer) 
    : device(device), metalLayer(layer) {
    createCommandQueue();
    createRenderPipeline();
}

MetalRenderer::~MetalRenderer() {
    // Destructor implementation if needed
}

void MetalRenderer::render() {
    CAMetalDrawable* drawable = metalLayer->nextDrawable();
    if (!drawable) return;

    MTL::RenderPassDescriptor* passDescriptor = MTL::RenderPassDescriptor::alloc()->init();
    passDescriptor->colorAttachments()->object(0)->setTexture(drawable->texture());
    passDescriptor->colorAttachments()->object(0)->setLoadAction(MTL::LoadActionClear);
    passDescriptor->colorAttachments()->object(0)->setClearColor(MTL::ClearColor::Make(0.0, 0.5, 0.8, 1.0));
    passDescriptor->colorAttachments()->object(0)->setStoreAction(MTL::StoreActionStore);

    MTL::CommandBuffer* commandBuffer = commandQueue->commandBuffer();
    MTL::RenderCommandEncoder* renderEncoder = commandBuffer->renderCommandEncoder(passDescriptor);
    renderEncoder->endEncoding();
    commandBuffer->presentDrawable(drawable);
    commandBuffer->commit();
}

void MetalRenderer::setLayerSize(float width, float height) {
    metalLayer->setDrawableSize(MTL::Size(width, height));
}

void MetalRenderer::createCommandQueue() {
    commandQueue = device->newCommandQueue();
}

void MetalRenderer::createRenderPipeline() {
    MTL::Library* library = device->newDefaultLibrary();
    MTL::Function* vertexFunction = library->newFunction("vertexShader");
    MTL::Function* fragmentFunction = library->newFunction("fragmentShader");

    MTL::RenderPipelineDescriptor* pipelineDescriptor = MTL::RenderPipelineDescriptor::alloc()->init();
    pipelineDescriptor->setVertexFunction(vertexFunction);
    pipelineDescriptor->setFragmentFunction(fragmentFunction);
    pipelineDescriptor->colorAttachments()->object(0)->setPixelFormat(MTL::PixelFormatBGRA8Unorm);

    NSError* error = nil;
    pipelineState = device->newRenderPipelineState(pipelineDescriptor, &error);
    if (!pipelineState) {
        std::cerr << "Failed to create pipeline state: " << error.localizedDescription.UTF8String << std::endl;
    }
}

