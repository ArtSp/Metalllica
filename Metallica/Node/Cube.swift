//
//  Cube.swift
//  Created by Artjoms Spole on 14/06/2022.
//

import MetalKit

class Cube: Primitive {
    
    override func createVerticies() {
        super.createVerticies()
        
        vertices = [
            Vertex(position: SIMD3<Float>(-0.5, 0.5,-0.5), color: SIMD4<Float>(1, 0, 0, 1), textCoords: SIMD2<Float>(0,0)),
            Vertex(position: SIMD3<Float>(-0.5,-0.5,-0.5), color: SIMD4<Float>(0, 1, 0, 1), textCoords: SIMD2<Float>(0,1)),
            Vertex(position: SIMD3<Float>( 0.5,-0.5,-0.5), color: SIMD4<Float>(0, 0, 1, 1), textCoords: SIMD2<Float>(1,1)),
            Vertex(position: SIMD3<Float>( 0.5, 0.5,-0.5), color: SIMD4<Float>(1, 0, 0, 1), textCoords: SIMD2<Float>(1,0)),
            
            Vertex(position: SIMD3<Float>(-0.5, 0.5, 0.5), color: SIMD4<Float>(1, 0, 0, 1), textCoords: SIMD2<Float>(0,0)),
            Vertex(position: SIMD3<Float>(-0.5,-0.5, 0.5), color: SIMD4<Float>(0, 1, 0, 1), textCoords: SIMD2<Float>(0,1)),
            Vertex(position: SIMD3<Float>( 0.5,-0.5, 0.5), color: SIMD4<Float>(0, 0, 1, 1), textCoords: SIMD2<Float>(1,1)),
            Vertex(position: SIMD3<Float>( 0.5, 0.5, 0.5), color: SIMD4<Float>(1, 0, 0, 1), textCoords: SIMD2<Float>(1,0)),
            
            Vertex(position: SIMD3<Float>( 0.5, 0.5,-0.5), color: SIMD4<Float>(1, 0, 0, 1), textCoords: SIMD2<Float>(0,0)),
            Vertex(position: SIMD3<Float>( 0.5,-0.5,-0.5), color: SIMD4<Float>(0, 1, 0, 1), textCoords: SIMD2<Float>(0,1)),
            Vertex(position: SIMD3<Float>( 0.5,-0.5, 0.5), color: SIMD4<Float>(0, 0, 1, 1), textCoords: SIMD2<Float>(1,1)),
            Vertex(position: SIMD3<Float>( 0.5, 0.5, 0.5), color: SIMD4<Float>(1, 0, 0, 1), textCoords: SIMD2<Float>(1,0)),
            
            Vertex(position: SIMD3<Float>(-0.5, 0.5,-0.5), color: SIMD4<Float>(1, 0, 0, 1), textCoords: SIMD2<Float>(0,0)),
            Vertex(position: SIMD3<Float>(-0.5,-0.5,-0.5), color: SIMD4<Float>(0, 1, 0, 1), textCoords: SIMD2<Float>(0,1)),
            Vertex(position: SIMD3<Float>(-0.5,-0.5, 0.5), color: SIMD4<Float>(0, 0, 1, 1), textCoords: SIMD2<Float>(1,1)),
            Vertex(position: SIMD3<Float>(-0.5, 0.5, 0.5), color: SIMD4<Float>(1, 0, 0, 1), textCoords: SIMD2<Float>(1,0)),
            
            Vertex(position: SIMD3<Float>(-0.5, 0.5, 0.5), color: SIMD4<Float>(1, 0, 0, 1), textCoords: SIMD2<Float>(0,0)),
            Vertex(position: SIMD3<Float>(-0.5, 0.5,-0.5), color: SIMD4<Float>(0, 1, 0, 1), textCoords: SIMD2<Float>(0,1)),
            Vertex(position: SIMD3<Float>( 0.5, 0.5,-0.5), color: SIMD4<Float>(0, 0, 1, 1), textCoords: SIMD2<Float>(1,1)),
            Vertex(position: SIMD3<Float>( 0.5, 0.5, 0.5), color: SIMD4<Float>(1, 0, 0, 1), textCoords: SIMD2<Float>(1,0)),
            
            Vertex(position: SIMD3<Float>(-0.5,-0.5, 0.5), color: SIMD4<Float>(1, 0, 0, 1), textCoords: SIMD2<Float>(0,0)),
            Vertex(position: SIMD3<Float>(-0.5,-0.5,-0.5), color: SIMD4<Float>(0, 1, 0, 1), textCoords: SIMD2<Float>(0,1)),
            Vertex(position: SIMD3<Float>( 0.5,-0.5,-0.5), color: SIMD4<Float>(0, 0, 1, 1), textCoords: SIMD2<Float>(1,1)),
            Vertex(position: SIMD3<Float>( 0.5,-0.5, 0.5), color: SIMD4<Float>(1, 0, 0, 1), textCoords: SIMD2<Float>(1,0))
        ]
        
        indices = [
            0,1,3,              3,1,2,
            4,5,7,              7,5,6,
            8,9,11,             11,9,10,
            12,13,15,           15,13,14,
            16,17,19,           19,17,18,
            20,21,23,           23,21,22
        ]
    }
    
}
