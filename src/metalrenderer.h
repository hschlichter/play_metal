#pragma once

#include <Metal/Metal.hpp>
#include <QuartzCore/CAMetalLayer.hpp>

class MetalRenderer {
public:
    MetalRenderer(MTL::Device* device, CAMetalLayer* layer);
    ~MetalRenderer();
    void render();
    void setLayerSize(float width, float height);

private:
    MTL::Device* device;
    CAMetalLayer* metalLayer;
    MTL::CommandQueue* commandQueue;
    MTL::RenderPipelineState* pipelineState;

    void createCommandQueue();
    void createRenderPipeline();
};

