//
//  Primitive.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class Primitive: Node {
    var renderPipelineState: MTLRenderPipelineState!
    var vertexDesctriptor: MTLVertexDescriptor!
    
    var fragmentFunctionName: String
    var vertexFunctionName: String
    
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    
    var vertices: [Vertex]!
    var indices: [UInt16]!
    
    var modelConstants = ModelConstants()
    
    var vertexDescriptor: MTLVertexDescriptor! = {
        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0

        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].offset = MemoryLayout<SIMD3<Float>>.size

        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        
        return vertexDescriptor
    }()
    
    
    init(
        device: MTLDevice
    ) {
        vertexFunctionName = "basic_vertex_function"
        fragmentFunctionName = "basic_fragment_function"
        super.init()
        createVerticies()
        createBuffers(device: device)
        renderPipelineState = buildPipelineState(device: device)
    }
    
    func createVerticies() {}
    
    func createBuffers(
        device: MTLDevice
    ) {
        vertexBuffer = device.makeBuffer(bytes: vertices,
                                         length: MemoryLayout<Vertex>.stride * vertices.count,
                                         options: [])
        indexBuffer = device.makeBuffer(bytes: indices,
                                        length: MemoryLayout<UInt16>.size * indices.count,
                                        options: [])
    }
    
}

extension Primitive: Renderable {
    
    func draw(
        commandEncoder: MTLRenderCommandEncoder
    ) {
        modelConstants.modelMatrix = modelMatrix
        
        commandEncoder.setRenderPipelineState(renderPipelineState)
        commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        commandEncoder.setVertexBytes(&modelConstants, length: MemoryLayout<ModelConstants>.stride, index: 1)
        
        commandEncoder.drawIndexedPrimitives(type: .triangle,
                                             indexCount: indices.count,
                                             indexType: .uint16,
                                             indexBuffer: indexBuffer,
                                             indexBufferOffset: 0)
    }
}
