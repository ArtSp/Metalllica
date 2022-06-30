//
//  Shaders.metal
//  Created by Artjoms Spole on 10/06/2022.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
    float2 textCoords [[ attribute(2) ]];
};

struct VertexOut {
    float4 position [[ position ]];
    float4 color;
    float2 textCoords;
};

struct ModelConstants {
    float4x4 modelViewMatrics;
};

struct SceneConstants {
    float4x4 projectionMatrix;
};

struct Light {
    float ptmRatio;
    float2 position;
};

vertex VertexOut basic_vertex_function(const VertexIn vIn [[ stage_in ]],
                                       constant ModelConstants &modelConstants [[ buffer(1)]],
                                       constant SceneConstants &sceneConstants [[ buffer(2)]]) {
    VertexOut vOut;
    vOut.position = sceneConstants.projectionMatrix * modelConstants.modelViewMatrics * float4(vIn.position, 1);
    vOut.color = vIn.color;
    vOut.textCoords = vIn.textCoords;
    return vOut;
}

fragment half4 basic_fragment_function(VertexOut vIn [[ stage_in ]],
                                        constant Light &light [[buffer(1)]]) {
    float intensity = 1 / length(vIn.position.xy - light.position * light.ptmRatio);
    float4 color = vIn.color * intensity * 100;
    return half4(color.x, color.y, color.z, 1);
}

fragment half4 textured_fragment_function(VertexOut vIn [[ stage_in ]],
                                          constant Light &light [[ buffer(1) ]],
                                          sampler sampler2d [[ sampler(0) ]],
                                          texture2d<float> texture [[ texture(0) ]]){
    float intensity = 1 / length(vIn.position.xy - light.position * light.ptmRatio);
    float4 color = texture.sample(sampler2d, vIn.textCoords);
    color = color * intensity * 50;
    return half4(color.x, color.y, color.z, 1);
}
