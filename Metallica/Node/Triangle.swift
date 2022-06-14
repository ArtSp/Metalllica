//
//  Triangle.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class Triangle: Primitive {
    
    let color: SIMD4<Float>
    
    init(device: MTLDevice, color: SIMD4<Float>) {
        self.color = color
        super.init(device: device)
    }
    
    override func createVerticies() {
        super.createVerticies()
        
        vertices = [
            Vertex(position: .init(0, 1, 0), color: color),
            Vertex(position: .init(-1, -1, 0), color: color),
            Vertex(position: .init(1, -1, 0), color: color),
        ]
        
        indices = [
            0, 1, 2
        ]
    }
    
}
