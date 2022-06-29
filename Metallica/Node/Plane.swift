//
//  Plain.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class Plane: Primitive {
    
    override func createVerticies() {
        super.createVerticies()
        
        vertices = [
            Vertex(position: SIMD3<Float>( 1,  1, 0), color: SIMD4<Float>(1, 0 ,0, 1), textCoords: SIMD2<Float>(1,1)), //v0
            Vertex(position: SIMD3<Float>(-1,  1, 0), color: SIMD4<Float>(0, 1, 0 ,1), textCoords: SIMD2<Float>(0,1)), //v1
            Vertex(position: SIMD3<Float>(-1, -1, 0), color: SIMD4<Float>(0, 0, 1, 1), textCoords: SIMD2<Float>(0,0)), //v2
            Vertex(position: SIMD3<Float>( 1, -1, 0), color: SIMD4<Float>(1, 0, 1, 1), textCoords: SIMD2<Float>(1,0)), //v3
        ]
        
        indices = [
            0, 1, 2,
            0, 2, 3
        ]
    }
    
}
