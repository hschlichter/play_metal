#pragma once

namespace MTL
{
    class Device;
    class Drawable;
    class CommandQueue;
    class RenderPipelineState;
    class Buffer;
    class RenderPassDescriptor;
}

namespace CA
{
    class MetalLayer;
}

class Renderer
{
public:
    Renderer(MTL::Device* device);
    ~Renderer();

    void setupRenderPassDescriptor();
    void buildShaders();
    void buildBuffers();
    void draw(CA::MetalLayer* layer);

private:
    MTL::Device* _device;
    MTL::RenderPassDescriptor* _renderPassDescriptor;
    MTL::CommandQueue* _commandQueue;
    MTL::RenderPipelineState* _pipelineState;
    MTL::Buffer* _vertexPositionsBuffer;
    MTL::Buffer* _vertexColorsBuffer;
};
