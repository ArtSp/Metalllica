//
//  Renderer.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class Renderer: NSObject {
    
    var commandQueue: MTLCommandQueue!
    var depthStencilState: MTLDepthStencilState!
    var samplerState: MTLSamplerState!
    var scene: CoreScene
    var wireframeFillEnabled = false
    
    init(
        device: MTLDevice
    ) {
        scene = BasicScene(device: device)
        super.init()
        
        commandQueue = device.makeCommandQueue()
        createDepthStencil(device: device)
        createSamplerState(device: device)
    }
    
    func createDepthStencil(
        device: MTLDevice
    ) {
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.isDepthWriteEnabled = true
        depthStencilDescriptor.depthCompareFunction = .less
        depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
    
    func createSamplerState(
        device: MTLDevice
    ){
        let samplerDescriptor = MTLSamplerDescriptor()
        samplerDescriptor.minFilter = .linear
        samplerDescriptor.magFilter = .linear
        samplerState = device.makeSamplerState(descriptor: samplerDescriptor)
    }
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(
        _ view: MTKView,
        drawableSizeWillChange size: CGSize
    ) {
        scene.camera.aspectRatio = Float(view.bounds.width / view.bounds.height)
    }

    func draw(
        in view: MTKView
    ) {
        let deltaTime = 1 / Float(view.preferredFramesPerSecond)
        
        if let drawable = view.currentDrawable,
           let renderPassDescriptor = view.currentRenderPassDescriptor,
           let commandBuffer = commandQueue.makeCommandBuffer(),
           let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) {
            commandEncoder.setDepthStencilState(depthStencilState)
            commandEncoder.setFragmentSamplerState(samplerState, index: 0)
            commandEncoder.setTriangleFillMode(wireframeFillEnabled ? .lines : .fill)
            
            let lightPos: SIMD2<Float> = .init(
                Float(InputHandler.touchLocation?.x ?? InputHandler.defaultTouchLocation?.x ?? 0),
                Float(InputHandler.touchLocation?.y ?? InputHandler.defaultTouchLocation?.y ?? 0)
            )
            scene.light.position = lightPos
            scene.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
            
            commandEncoder.endEncoding()
            commandBuffer.present(drawable)
            commandBuffer.commit()
        }
    }
}
