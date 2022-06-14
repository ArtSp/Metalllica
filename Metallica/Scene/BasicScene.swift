//
//  BasicScene.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class BasicScene: CoreScene {
    
    var c: Primitive!
    
    override init(device: MTLDevice) {
        super.init(device: device)
        
        c = Cube(device: device)
        c.translate(direction: .init(0, 0, -80))
        
        add(child: c)
    }
    
    override func render(
        commandEncoder: MTLRenderCommandEncoder,
        deltaTime: Float
    ) {
        c.rotate(angle: deltaTime, axis: .init(1, 0.3, 0.3))
        super.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
    }
}
