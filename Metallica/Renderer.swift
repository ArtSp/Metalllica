//
//  Renderer.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class Renderer: NSObject {
    
    var commandQueue: MTLCommandQueue!
    var scenes: [CoreScene] = []
    
    init(
        device: MTLDevice
    ) {
        super.init()
        
        commandQueue = device.makeCommandQueue()
        scenes.append(BasicScene(device: device))
        scenes.append(TempScene(device: device))
    }
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(
        _ view: MTKView,
        drawableSizeWillChange size: CGSize
    ) {}

    func draw(
        in view: MTKView
    ) {
        if let drawable = view.currentDrawable,
           let renderPassDescriptor = view.currentRenderPassDescriptor,
           let commandBuffer = commandQueue.makeCommandBuffer(),
           let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) {
            
            scenes.forEach {
                $0.render(commandEncoder: commandEncoder)
            }
            
            commandEncoder.endEncoding()
            commandBuffer.present(drawable)
            commandBuffer.commit()
        }
    }
}
