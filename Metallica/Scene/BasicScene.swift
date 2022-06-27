//
//  BasicScene.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class BasicScene: CoreScene {
    
    var c: Primitive!
    
    override init(
        device: MTLDevice
    ) {
        super.init(device: device)
        
        c = Cube(device: device)
        c.position.z = -80
        
        add(child: c)
    }
    
    override func render(
        commandEncoder: MTLRenderCommandEncoder,
        deltaTime: Float
    ) {
        c.rotation.x += deltaTime
        c.rotation.y += deltaTime
        super.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
    }
}
