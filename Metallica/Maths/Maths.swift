//
//  Maths.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

extension matrix_float4x4 {
    
    mutating func scale(
        axis: SIMD3<Float>
    ) {
        var result = matrix_identity_float4x4
        
        let x = axis.x
        let y = axis.y
        let z = axis.z
        
        result.columns = (
            SIMD4<Float>(x, 0, 0, 0),
            SIMD4<Float>(0, y, 0, 0),
            SIMD4<Float>(0, 0, z, 0),
            SIMD4<Float>(0, 0, 0, 1)
        )
        
        self = matrix_multiply(self, result)
    }
}
