//
//  Types.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

struct Vertex {
    var position: SIMD3<Float>
    var color: SIMD4<Float>
}

struct ModelConstants {
    var modelMatrix = matrix_identity_float4x4
}

struct SceneConstants {
    var projectionMatrix = matrix_identity_float4x4
}

struct Light {
    let ptmRatio = Float(UIScreen.main.scale)
    var position: SIMD2<Float> = .zero
}
