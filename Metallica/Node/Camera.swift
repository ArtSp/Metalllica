//
//  Camera.swift
//  Created by Artjoms Spole on 27/06/2022.
//

import MetalKit

class Camera: Node {
    
    var fov: Float = 180
    var aspectRatio: Float = 1
    var nearZ: Float = 0.1
    var farZ: Float = 1000
    
    var viewMatrics: matrix_float4x4 {
        modelMatrix
    }
    
    var projectionMatrix: matrix_float4x4 {
        matrix_float4x4(
            perspectiveDegreesFOV: fov,
            aspectRatio: aspectRatio,
            nearZ: nearZ,
            farZ: farZ
        )
    }
}
