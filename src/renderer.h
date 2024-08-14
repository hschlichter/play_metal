#pragma once
#include <Metal/Metal.hpp>
#include <QuartzCore/CAMetalLayer.h>

class Renderer {
public:
    Renderer(MTL::Device* device);
    ~Renderer();
    void draw(MTL::Drawable* drawable);
    
private:
    MTL::Device* _device;
    MTL::CommandQueue* _commandQueue;
    MTL::RenderPipelineState* _pipelineState;
    MTL::Buffer* _vertexBuffer;
};

