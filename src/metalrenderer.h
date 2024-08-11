#pragma once

#include <Metal/Metal.hpp>
#include <QuartzCore/CAMetalLayer.hpp>

class MetalRenderer {
public:
    MetalRenderer(MTL::Device* device, CA::MetalLayer* layer);
    ~MetalRenderer();
    void render();
    void setLayerSize(float width, float height);

private:
    MTL::Device* device;
    CA::MetalLayer* metalLayer;
    MTL::CommandQueue* commandQueue;
    MTL::RenderPipelineState* pipelineState;

    void createCommandQueue();
    void createRenderPipeline();
};

