//
//  BasicScene.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class BasicScene: CoreScene {
    
    var c1: Node!
    var c2: Node!
    
    override init(
        device: MTLDevice
    ) {
        super.init(device: device)
        
        c1 = Cube(device: device, imageName: "insta.jpeg")
        c1.position.x = 1
        c1.position.z = -20
        
//        c2 = Cube(device: device, imageName: "mp.png")
//        c2.position.x = -1
//        c2.position.z = -30
        
        c2 = Model(device: device, modelName: "f16", imageName: "mp.png")
        c2.position.x = -1
        c2.position.z = -30
        
        let c3 = Cube(device: device)
        c3.position.z = -40
        
        add(child: c1)
        add(child: c2)
        add(child: c3)
    }
    
    override func render(
        commandEncoder: MTLRenderCommandEncoder,
        deltaTime: Float
    ) {
        c1.rotation.x += deltaTime
        c1.rotation.y += deltaTime
        
        c2.rotation.x -= deltaTime / 2
        c2.rotation.y -= deltaTime / 2
        
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
