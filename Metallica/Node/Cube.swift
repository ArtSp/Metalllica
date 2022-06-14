//
//  Cube.swift
//  Created by Artjoms Spole on 14/06/2022.
//

import MetalKit

class Cube: Primitive {
    
    override func createVerticies() {
        super.createVerticies()
        
        vertices = [
            Vertex(position: .init(-1,  1,  1), color: .init(1,0,0,1)),     //v0
            Vertex(position: .init(-1, -1,  1), color: .init(0,1,0,1)),     //v1
            Vertex(position: .init( 1,  1,  1), color: .init(0,0,1,1)),     //v2
            Vertex(position: .init( 1, -1,  1), color: .init(1,1,0,1)),     //v3
            Vertex(position: .init(-1,  1, -1), color: .init(0,1,1,1)),     //v4
            Vertex(position: .init( 1,  1, -1), color: .init(1,0.5,0.5,1)), //v5
            Vertex(position: .init(-1, -1, -1), color: .init(0.5,1,0,1)),   //v6
            Vertex(position: .init( 1, -1, -1), color: .init(1,0,0.5,1)),   //v7
        ]
        
        indices = [
            // Triangle 1   Triangle2
            0,1,2,          2,1,3, // Front
            5,2,3,          5,3,7, // Right
            0,2,4,          2,5,4, // Top
            0,1,4,          4,1,6, // Left
            5,4,6,          5,6,7, // Back
            3,1,6,          3,6,7, // Bottom
        ]
    }
    
}
