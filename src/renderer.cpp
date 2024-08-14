#include "renderer.h"

static const float vertexData[] = {
    0.0f,  0.5f, 0.0f,
   -0.5f, -0.5f, 0.0f,
    0.5f, -0.5f, 0.0f,
};

Renderer::Renderer(MTL::Device* device) : _device(device) {
//    _commandQueue = _device->newCommandQueue();
//    
//    MTL::Library* defaultLibrary = _device->newDefaultLibrary();
//    MTL::Function* vertexFunction = defaultLibrary->newFunctionWithName(NS::String::string("vertex_main", NS::UTF8StringEncoding));
//    MTL::Function* fragmentFunction = defaultLibrary->newFunctionWithName(NS::String::string("fragment_main", NS::UTF8StringEncoding));
//
//    MTL::RenderPipelineDescriptor* pipelineDescriptor = MTL::RenderPipelineDescriptor::alloc()->init();
//    pipelineDescriptor->setVertexFunction(vertexFunction);
//    pipelineDescriptor->setFragmentFunction(fragmentFunction);
//    pipelineDescriptor->colorAttachments()->object(0)->setPixelFormat(MTL::PixelFormat::PixelFormatBGRA8Unorm);
//
//    _pipelineState = _device->newRenderPipelineState(pipelineDescriptor, nullptr);
//    
//    _vertexBuffer = _device->newBuffer(vertexData, sizeof(vertexData), MTL::ResourceStorageModeManaged);
}

Renderer::~Renderer() {
//    _vertexBuffer->release();
//    _pipelineState->release();
//    _commandQueue->release();
}

void Renderer::draw(MTL::Drawable* drawable) {
//    MTL::CommandBuffer* commandBuffer = _commandQueue->commandBuffer();
//
//    MTL::RenderPassDescriptor* passDescriptor = MTL::RenderPassDescriptor::alloc()->init();
//    passDescriptor->colorAttachments()->object(0)->setClearColor(MTL::ClearColor::Make(0.0, 0.0, 0.0, 1.0));
//    passDescriptor->colorAttachments()->object(0)->setLoadAction(MTL::LoadActionClear);
//    passDescriptor->colorAttachments()->object(0)->setStoreAction(MTL::StoreActionStore);
//    passDescriptor->colorAttachments()->object(0)->setTexture(drawable.texture());
//
//    MTL::RenderCommandEncoder* renderEncoder = commandBuffer->renderCommandEncoder(passDescriptor);
//    renderEncoder->setRenderPipelineState(_pipelineState);
//    renderEncoder->setVertexBuffer(_vertexBuffer, 0, 0);
//    renderEncoder->drawPrimitives(MTL::PrimitiveTypeTriangle, 0, 3);
//    renderEncoder->endEncoding();
//
//    commandBuffer->presentDrawable(drawable);
//    commandBuffer->commit();
}

