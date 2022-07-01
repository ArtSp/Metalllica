//
//  BasicScene.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class BasicScene: CoreScene {
    
    var instaCube: Node!
    var jet: Node!
    
    override init(
        device: MTLDevice
    ) {
        super.init(device: device)
        
        instaCube = Cube(device: device, imageName: "insta.jpeg")
        instaCube.position.x = 1
        instaCube.position.y = -1
        instaCube.position.z = -20
        
        jet = Model(device: device, modelName: "f16", imageName: "mp.png")
        jet.position.x = -1
        jet.position.y = 2
        jet.position.z = -30
        
        let planes = Instance(device: device, modelName: "f16", imageName: "insta.jpeg", instanceCount: 1000)
        for i in planes.nodes.indices {
            planes.nodes[i].position.x = 3 * Float(i)
            planes.nodes[i].position.z = -50
            planes.nodes[i].rotation.y = 0.2 * Float(i)
            planes.nodes[i].rotation.x = 0.2 * Float(i)
        }
        
        add(child: instaCube)
        add(child: jet)
        add(child: planes)
    }
    
    override func render(
        commandEncoder: MTLRenderCommandEncoder,
        deltaTime: Float
    ) {
        instaCube.rotation.x += deltaTime
        instaCube.rotation.y += deltaTime
        
        jet.rotation.x -= deltaTime / 2
        jet.rotation.y -= deltaTime / 2
        
        let moveSpeed: Float = 0.05
        let rotationSpeed: Float = 0.002
        
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
