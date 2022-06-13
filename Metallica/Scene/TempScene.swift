//
//  TempScene.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class TempScene: CoreScene {
    
    override init(
        device: MTLDevice
    ) {
        super.init(device: device)
        let triangle1 = Triangle(device: device, color: .init( 1, 0, 0, 1 ))
        triangle1.scale(axis: .init(repeating: 1))
        
        let triangle2 = Triangle(device: device, color: .init( 0, 1, 0, 1 ))
        triangle2.scale(axis: .init(repeating: 0.5))
        
        add(child: triangle1)
        add(child: triangle2)
    }
    
}
