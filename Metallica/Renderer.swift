//
//  Renderer.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class Renderer: NSObject {
    
    var commandQueue: MTLCommandQueue!
    var depthStencilState: MTLDepthStencilState!
    var scene: CoreScene
    var wireframeFillEnabled = false
    var touchPosition: SIMD2<Float> = .zero
    
    init(device: MTLDevice) {
        scene = BasicScene(device: device)
        super.init()
        
        commandQueue = device.makeCommandQueue()
        createDepthStencil(device: device)
    }
    
    func createDepthStencil(device: MTLDevice) {
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.isDepthWriteEnabled = true
        depthStencilDescriptor.depthCompareFunction = .less
        depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        scene.aspectRatio = Float(view.bounds.width / view.bounds.height)
    }

    func draw(in view: MTKView) {
        let deltaTime = 1 / Float(view.preferredFramesPerSecond)
        
        if let drawable = view.currentDrawable,
           let renderPassDescriptor = view.currentRenderPassDescriptor,
           let commandBuffer = commandQueue.makeCommandBuffer(),
           let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) {
            commandEncoder.setDepthStencilState(depthStencilState)
            commandEncoder.setTriangleFillMode(wireframeFillEnabled ? .lines : .fill)
            
            var touch = (view as? MetalView)?.renderer.touchPosition ?? .zero
            touch.x += Float(view.bounds.width / 2)
            touch.y += Float(view.bounds.height / 2)
            scene.light.position = touch
            scene.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
            
            commandEncoder.endEncoding()
            commandBuffer.present(drawable)
            commandBuffer.commit()
        }
    }
}
