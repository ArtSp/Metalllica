//
//  CoreScene.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class CoreScene: Node {
    
    var device: MTLDevice!
    
    init(
        device: MTLDevice
    ) {
        self.device = device
        super.init()
    }
}
