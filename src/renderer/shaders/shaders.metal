#include <metal_stdlib>
using namespace metal;

struct VertexOut {
    float4 position [[position]];
};

vertex VertexOut vertex_main(uint vertexID [[vertex_id]],
                             constant float3 *vertexArray [[buffer(0)]]) {
    VertexOut out;
    out.position = float4(vertexArray[vertexID], 1.0);
    return out;
}

fragment float4 fragment_main() {
    return float4(1.0, 0.0, 0.0, 1.0);  // Red color
}

