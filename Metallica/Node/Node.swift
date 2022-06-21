//
//  Node.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class Node {
    
    private(set) var children: [Node] = []
    var position = SIMD3<Float>(repeating: 0)
    var rotation = SIMD3<Float>(repeating: 0)
    var scale = SIMD3<Float>(repeating: 1)
    
    var modelMatrix: matrix_float4x4 {
        var modelMatrix = matrix_identity_float4x4
        modelMatrix.translate(direction: position)
        modelMatrix.rotate(angle: rotation.x, axis: .init(1, 0, 0))
        modelMatrix.rotate(angle: rotation.y, axis: .init(0, 1, 0))
        modelMatrix.rotate(angle: rotation.z, axis: .init(0, 0, 1))
        modelMatrix.scale(axis: scale)
        return modelMatrix
    }

    func add(child: Node) {
        children.append(child)
    }
    
    func render(
        commandEncoder: MTLRenderCommandEncoder,
        deltaTime: Float
    ) {
        children
            .forEach { node in
            node.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
        }
        
        (self as? Renderable)?.draw(commandEncoder: commandEncoder)
    }
}
