//
//  BasicScene.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class BasicScene: CoreScene {
    
    var c1: Primitive!
    var c2: Primitive!
    
    override init(
        device: MTLDevice
    ) {
        super.init(device: device)
        
        c1 = Cube(device: device)
        c1.position.x = 0.5
        c1.position.z = -80
        
        c2 = Cube(device: device)
        c2.position.x = -0.5
        c2.position.z = -90
        
        add(child: c1)
        add(child: c2)
    }
    
    override func render(
        commandEncoder: MTLRenderCommandEncoder,
        deltaTime: Float
    ) {
        c1.rotation.x += deltaTime
        c1.rotation.y += deltaTime
        
        let moveSpeed: Float = 0.05
        let rotationSpeed: Float = 0.001
        
        let node: Node = camera
        
        if InputHandler.pressedKeys.contains(.forward) {
            node.position.z += moveSpeed * 10
        }
        
        if InputHandler.pressedKeys.contains(.backward) {
            node.position.z -= moveSpeed * 10
        }
        
        if InputHandler.pressedKeys.contains(.up) {
            node.rotation.x -= rotationSpeed
        }
        
        if InputHandler.pressedKeys.contains(.down) {
            node.rotation.x += rotationSpeed
        }
        
        if InputHandler.pressedKeys.contains(.left) {
            node.rotation.y -= rotationSpeed
        }
        
        if InputHandler.pressedKeys.contains(.right) {
            node.rotation.y += rotationSpeed
        }

        super.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
    }
}
