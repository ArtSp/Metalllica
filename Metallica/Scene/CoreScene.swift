//
//  CoreScene.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class CoreScene: Node {
    
    var device: MTLDevice!
    var sceneConstants = SceneConstants()
    
    init(device: MTLDevice) {
        self.device = device
        super.init()
        sceneConstants.projectionMatrix = matrix_float4x4(
            perspectiveDegreesFOV: 45,
            aspectRatio: 1,
            nearZ: 0.1,
            farZ: 100
        )
    }
    
    override func render(commandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        commandEncoder.setVertexBytes(&sceneConstants,
                                      length: MemoryLayout<SceneConstants>.stride,
                                      index: 2)
        super.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
    }
}
