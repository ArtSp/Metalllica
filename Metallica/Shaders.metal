//
//  Shaders.metal
//  Created by Artjoms Spole on 10/06/2022.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
};

struct VertexOut {
    float4 position [[ position ]];
    float4 color;
};

struct ModelConstants {
    float4x4 modelMatrics;
};

struct SceneConstants {
    float4x4 projectionMatrix;
};

struct Light {
    float2 position;
};

vertex VertexOut basic_vertex_function(const VertexIn vIn [[ stage_in ]],
                                       constant ModelConstants &modelConstants [[ buffer(1)]],
                                       constant SceneConstants &sceneConstants [[ buffer(2)]]) {
    VertexOut vOut;
    vOut.position = sceneConstants.projectionMatrix * modelConstants.modelMatrics * float4(vIn.position, 1);
    vOut.color = vIn.color;
    return vOut;
}

fragment half4 basic_fragment_function(VertexOut vIn [[ stage_in ]],
                                        constant Light &ligh [[buffer(1)]]) {
    float intensity = 1 / length(vIn.position.xy - ligh.position);
    float4 color = vIn.color * intensity * 50;
    return half4(color.x, color.y, color.z, 1);
}
