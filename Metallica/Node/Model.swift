//
//  Model.swif
//  Created by Artjoms Spole on 30/06/2022.
//

import MetalKit

class Model: Node {

    var fragmentFunctionName: String! =  "basic_fragment_function"
    var vertexFunctionName: String = "basic_vertex_function"
    
    var meshes: [AnyObject]?
    var modelConstants = ModelConstants()
    var texture: MTLTexture?
    
    var renderPipelineState: MTLRenderPipelineState!
    var vertexDescriptor: MTLVertexDescriptor! = {
        let vertexDescriptor = MTLVertexDescriptor()
        
        //Vertices
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0

        //Color
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].offset = MemoryLayout<SIMD3<Float>>.size
        
        //Texture
        vertexDescriptor.attributes[2].bufferIndex = 0
        vertexDescriptor.attributes[2].format = .float2
        vertexDescriptor.attributes[2].offset = MemoryLayout<SIMD3<Float>>.size + MemoryLayout<SIMD4<Float>>.size

        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        
        return vertexDescriptor
    }()
    
    init(
        device: MTLDevice,
        modelName: String,
        imageName: String?
    ) {
        super.init()
        buildModelMeshes(device: device, modelName: modelName)
        
        if let imageName = imageName,
           let texture = setTexture(device: device, imageName: imageName){
            self.texture = texture
            fragmentFunctionName = "textured_fragment_function"
        }
        
        renderPipelineState = buildPipelineState(device: device)
    }
    
    func buildModelMeshes(
        device: MTLDevice,
        modelName: String
    ) {
        let assetUrl = Bundle.main.url(forResource: modelName, withExtension: "obj")
        let assetVertexDesctiptor = MTKModelIOVertexDescriptorFromMetal(vertexDescriptor)
        
        let position = assetVertexDesctiptor.attributes[0] as! MDLVertexAttribute
        position.name = MDLVertexAttributePosition
        assetVertexDesctiptor.attributes[0] = position
        
        let color = assetVertexDesctiptor.attributes[1] as! MDLVertexAttribute
        color.name = MDLVertexAttributeColor
        assetVertexDesctiptor.attributes[1] = color
        
        let textureCoord = assetVertexDesctiptor.attributes[2] as! MDLVertexAttribute
        textureCoord.name = MDLVertexAttributeTextureCoordinate
        assetVertexDesctiptor.attributes[2] = textureCoord
        
        let bufferAllocator = MTKMeshBufferAllocator(device: device)
        let asset = MDLAsset(url: assetUrl!, vertexDescriptor: assetVertexDesctiptor, bufferAllocator: bufferAllocator)
        
        do {
            meshes = try MTKMesh.newMeshes(asset: asset, device: device).metalKitMeshes
        } catch {
            print(error)
        }
    }
    
}

extension Model: Renderable {
    
    func draw(
        commandEncoder: MTLRenderCommandEncoder,
        modelViewMatrix: matrix_float4x4
    ) {
        commandEncoder.setRenderPipelineState(renderPipelineState)
        modelConstants.modelViewMatrix = modelViewMatrix
        commandEncoder.setVertexBytes(&modelConstants, length: MemoryLayout<ModelConstants>.stride, index: 1)
        
        if let texture = texture {
            commandEncoder.setFragmentTexture(texture, index: 0)
        }
        
        guard let meshes = self.meshes as? [MTKMesh], !meshes.isEmpty else { return }
        meshes.forEach { mesh in
            let vertexBuffer = mesh.vertexBuffers[0].buffer
            commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            
            mesh.submeshes.forEach { submesh in
                commandEncoder.drawIndexedPrimitives(type: submesh.primitiveType,
                                                     indexCount: submesh.indexCount,
                                                     indexType: submesh.indexType,
                                                     indexBuffer: submesh.indexBuffer.buffer,
                                                     indexBufferOffset: submesh.indexBuffer.offset)
            }
        }
    }
    
}

extension Model: Texturable {

}
