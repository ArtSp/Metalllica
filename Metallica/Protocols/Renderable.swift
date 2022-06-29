//
//  Renderable.swift
//  Created by Artjoms Spole on 21/06/2022.
//

import MetalKit

protocol Renderable {
    var renderPipelineState: MTLRenderPipelineState! { get set }
    var vertexDescriptor: MTLVertexDescriptor! { get set }
    
    var fragmentFunctionName: String! { get set }
    var vertexFunctionName: String { get set }
    
    func draw(commandEncoder: MTLRenderCommandEncoder, modelViewMatrix: matrix_float4x4)
}

extension Renderable {
    func buildPipelineState(
        device: MTLDevice
    ) -> MTLRenderPipelineState {
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: vertexFunctionName)
        let fragmentFunction = library?.makeFunction(name: fragmentFunctionName)
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        renderPipelineDescriptor.vertexDescriptor = vertexDescriptor

        var renderPipelineState: MTLRenderPipelineState!
        do {
            renderPipelineState = try device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print(error.localizedDescription)
        }
        return renderPipelineState
    }
}
