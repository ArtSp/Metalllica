//
//  CoreScene.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class CoreScene: Node {
    
    var device: MTLDevice!
    var sceneConstants = SceneConstants()
    var light = Light()
    var aspectRatio: Float = 1
    
    init(
        device: MTLDevice
    ) {
        self.device = device
        super.init()
    }
    
    override func render(
        commandEncoder: MTLRenderCommandEncoder,
        deltaTime: Float
    ) {
        sceneConstants.projectionMatrix = matrix_float4x4(
            perspectiveDegreesFOV: 45,
            aspectRatio: aspectRatio,
            nearZ: 0.1,
            farZ: 100
        )
        commandEncoder.setVertexBytes(&sceneConstants,
                                      length: MemoryLayout<SceneConstants>.stride,
                                      index: 2)
        commandEncoder.setFragmentBytes(&light,
                                        length: MemoryLayout<Light>.stride,
                                        index: 1)
        super.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
    }
}
