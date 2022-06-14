//
//  Primitive.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class Primitive: Node {
    
    var renderPipelineState: MTLRenderPipelineState!
    var depthStencilState: MTLDepthStencilState!
    
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    
    var vertices: [Vertex]!
    var indices: [UInt16]!
    
    var modelConstants = ModelConstants()
    
    init(device: MTLDevice) {
        super.init()
        createVerticies()
        createBuffers(device: device)
        createPipelineState(device: device)
        createDepthStencil(device: device)
    }
    
    func createVerticies() {}
    
    func createDepthStencil(device: MTLDevice) {
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.isDepthWriteEnabled = true
        depthStencilDescriptor.depthCompareFunction = .less
        depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
    
    func createPipelineState(device: MTLDevice) {
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "basic_vertex_function")
        let fragmentFunction = library?.makeFunction(name: "basic_fragment_function")
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        
        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].offset = MemoryLayout<SIMD3<Float>>.size
        
        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        
        renderPipelineDescriptor.vertexDescriptor = vertexDescriptor
        
        // Try to update the state of the renderPipeline
        do {
            renderPipelineState = try device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createBuffers(device: MTLDevice) {
        vertexBuffer = device.makeBuffer(bytes: vertices,
                                         length: MemoryLayout<Vertex>.stride * vertices.count,
                                         options: [])
        indexBuffer = device.makeBuffer(bytes: indices,
                                        length: MemoryLayout<UInt16>.size * indices.count,
                                        options: [])
    }
    
    func scale(axis: SIMD3<Float>) {
        modelConstants.modelMatrix.scale(axis: axis)
    }
    
    func translate(direction: SIMD3<Float>) {
        modelConstants.modelMatrix.translate(direction: direction)
    }
    
    func rotate(angle: Float, axis: SIMD3<Float>) {
        modelConstants.modelMatrix.rotate(angle: angle, axis: axis)
    }
    
    override func render(commandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        commandEncoder.setRenderPipelineState(renderPipelineState)
        commandEncoder.setDepthStencilState(depthStencilState)
        super.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
        
        commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        commandEncoder.setVertexBytes(&modelConstants, length: MemoryLayout<ModelConstants>.stride, index: 1)
        
        commandEncoder.drawIndexedPrimitives(type: .triangle,
                                             indexCount: indices.count,
                                             indexType: .uint16,
                                             indexBuffer: indexBuffer,
                                             indexBufferOffset: 0)
    }
    
}
