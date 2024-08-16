#include "renderer.h"
#define NS_PRIVATE_IMPLEMENTATION
#define CA_PRIVATE_IMPLEMENTATION
#define MTL_PRIVATE_IMPLEMENTATION

#include <Metal/Metal.hpp>
/*#include <Metal/MTLRenderPass.hpp>*/
#include <QuartzCore/CAMetalLayer.hpp>
#include <QuartzCore/CAMetalDrawable.hpp>
#include <simd/simd.h>

Renderer::Renderer(MTL::Device* device)
: _device(device) 
{
    _commandQueue = _device->newCommandQueue();
    setupRenderPassDescriptor();
    buildShaders();
    buildBuffers();
}

Renderer::~Renderer()
{
    _pipelineState->release();
    _vertexColorsBuffer->release();
    _vertexPositionsBuffer->release();
    _renderPassDescriptor->release();
    _commandQueue->release();
}

void Renderer::setupRenderPassDescriptor()
{
    _renderPassDescriptor = MTL::RenderPassDescriptor::alloc();
    _renderPassDescriptor->init();
    auto colorAttachments = _renderPassDescriptor->colorAttachments();
    auto* colorDesc = MTL::RenderPassColorAttachmentDescriptor::alloc();
    colorDesc->setLoadAction(MTL::LoadAction::LoadActionClear);
    colorDesc->setStoreAction(MTL::StoreAction::StoreActionStore);
    colorDesc->setClearColor(MTL::ClearColor::Make(0, 1, 1, 1));
    colorAttachments->setObject(colorDesc, 0);
}

void Renderer::buildShaders()
{
    using NS::StringEncoding::UTF8StringEncoding;

    const char* shaderSrc = R"(
        #include <metal_stdlib>
        using namespace metal;

        struct v2f
        {
            float4 position [[position]];
            half3 color;
        };

        v2f vertex vertexMain( uint vertexId [[vertex_id]],
                               device const float3* positions [[buffer(0)]],
                               device const float3* colors [[buffer(1)]] )
        {
            v2f o;
            o.position = float4( positions[ vertexId ], 1.0 );
            o.color = half3 ( colors[ vertexId ] );
            return o;
        }

        half4 fragment fragmentMain( v2f in [[stage_in]] )
        {
            return half4( in.color, 1.0 );
        }
    )";

    NS::Error* error = nullptr;
    MTL::Library* library = _device->newLibrary(NS::String::string(shaderSrc, UTF8StringEncoding), nullptr, &error);
    if (!library)
    {
        __builtin_printf("%s", error->localizedDescription()->utf8String());
        assert(false);
    }

    MTL::Function* vertexFn = library->newFunction(NS::String::string("vertexMain", UTF8StringEncoding));
    MTL::Function* fragFn = library->newFunction(NS::String::string("fragmentMain", UTF8StringEncoding));

    MTL::RenderPipelineDescriptor* desc = MTL::RenderPipelineDescriptor::alloc()->init();
    desc->setVertexFunction(vertexFn);
    desc->setFragmentFunction(fragFn);
    desc->colorAttachments()->object(0)->setPixelFormat(MTL::PixelFormat::PixelFormatBGRA8Unorm);

    _pipelineState = _device->newRenderPipelineState(desc, &error);
    if (!_pipelineState)
    {
        __builtin_printf("%s", error->localizedDescription()->utf8String());
        assert(false);
    }

    vertexFn->release();
    fragFn->release();
    desc->release();
    library->release();
}

void Renderer::buildBuffers()
{
    const size_t NumVertices = 3;

    simd::float3 positions[NumVertices] =
    {
        {-0.8f,  0.8f, 0.0f },
        { 0.0f, -0.8f, 0.0f },
        { +0.8f,  0.8f, 0.0f }
    };

    simd::float3 colors[NumVertices] =
    {
        {  1.0, 0.3f, 0.2f },
        {  0.8f, 1.0, 0.0f },
        {  0.8f, 0.0f, 1.0 }
    };

    const size_t positionsDataSize = NumVertices * sizeof(simd::float3);
    const size_t colorDataSize = NumVertices * sizeof(simd::float3);

    MTL::Buffer* vertexPositionsBuffer = _device->newBuffer(positionsDataSize, MTL::ResourceStorageModeManaged);
    MTL::Buffer* vertexColorsBuffer = _device->newBuffer(colorDataSize, MTL::ResourceStorageModeManaged);

    _vertexPositionsBuffer = vertexPositionsBuffer;
    _vertexColorsBuffer = vertexColorsBuffer;

    memcpy(_vertexPositionsBuffer->contents(), positions, positionsDataSize);
    memcpy(_vertexColorsBuffer->contents(), colors, colorDataSize);

    _vertexPositionsBuffer->didModifyRange(NS::Range::Make(0, _vertexPositionsBuffer->length()));
    _vertexColorsBuffer->didModifyRange(NS::Range::Make(0, _vertexColorsBuffer->length()));
}

void Renderer::draw(CA::MetalLayer* layer) 
{
    CA::MetalDrawable* drawable = layer->nextDrawable();
    if (!drawable)
    {
        return;
    }
    
    NS::AutoreleasePool* pool = NS::AutoreleasePool::alloc()->init();

    MTL::CommandBuffer* cmdBuf = _commandQueue->commandBuffer();
    _renderPassDescriptor->colorAttachments()->object(0)->setTexture(drawable->texture());
    
    MTL::RenderCommandEncoder* enc = cmdBuf->renderCommandEncoder(_renderPassDescriptor);
    enc->setRenderPipelineState(_pipelineState);
    enc->setVertexBuffer(_vertexPositionsBuffer, 0, 0);
    enc->setVertexBuffer(_vertexColorsBuffer, 0, 1);
    enc->drawPrimitives(MTL::PrimitiveType::PrimitiveTypeTriangle, NS::UInteger(0), NS::UInteger(3));
    enc->endEncoding();

    cmdBuf->presentDrawable(drawable);
    cmdBuf->commit();

    pool->release();
}

