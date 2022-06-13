//
//  Plain.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class Plane: Primitive {
    
    override func createVerticies() {
        super.createVerticies()
        
        vertices = [
            Vertex(position: .init(1, 1, 0),    color: .init(1, 0, 0, 1)),
            Vertex(position: .init(-1, 1, 0),   color: .init(0, 1, 0, 1)),
            Vertex(position: .init(-1, -1, 0),  color: .init(0, 0, 1, 1)),
            Vertex(position: .init(1, -1, 0),   color: .init(1, 1, 1, 1))
        ]
        
        indices = [
            0, 1, 2,
            0, 2, 3
        ]
    }
    
}
