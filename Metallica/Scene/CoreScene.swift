//
//  CoreScene.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class CoreScene: Node {
    
    var device: MTLDevice!
    var sceneConstants = SceneConstants()
    var camera = Camera()
    var light = Light()
    
    init(
        device: MTLDevice
    ) {
        self.device = device
        super.init()
    }
    
    func render(
        commandEncoder: MTLRenderCommandEncoder,
        deltaTime: Float
    ) {
        sceneConstants.projectionMatrix = camera.projectionMatrix
        commandEncoder.setVertexBytes(&sceneConstants,length: MemoryLayout<SceneConstants>.stride, index: 2)
        commandEncoder.setFragmentBytes(&light, length: MemoryLayout<Light>.stride, index: 1)
        
        children.forEach { child in
            child.render(commandEncoder: commandEncoder, parentModelMatrix: camera.viewMatrics)
        }
    }
}
