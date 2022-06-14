//
//  Node.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class Node {
    
    private(set) var children: [Node] = []
    
    func add(child: Node) {
        children.append(child)
    }
    
    func render(
        commandEncoder: MTLRenderCommandEncoder,
        deltaTime: Float
    ) {
        children.forEach { node in
            node.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
        }
    }
}
