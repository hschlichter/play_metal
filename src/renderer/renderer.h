#pragma once

namespace MTL
{
    class Device;
    class Drawable;
    class CommandQueue;
    class RenderPipelineState;
    class Buffer;
    class RenderPassDescriptor;
    enum PixelFormat : unsigned long;
}

namespace CA
{
    class MetalLayer;
}

class Renderer
{
public:
    Renderer(MTL::Device* device, MTL::PixelFormat pixelFormat);
    ~Renderer();

    void SetupRenderPassDescriptor();
    void BuildShaders();
    void BuildBuffers();
    void Render(CA::MetalLayer* layer);

private:
    MTL::Device* _device;
    MTL::PixelFormat _pixelFormat;
    MTL::RenderPassDescriptor* _renderPassDescriptor;
    MTL::CommandQueue* _commandQueue;
    MTL::RenderPipelineState* _pipelineState;
    MTL::Buffer* _vertexPositionsBuffer;
    MTL::Buffer* _vertexColorsBuffer;
};
