//
//  BasicScene.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import MetalKit

class BasicScene: CoreScene {
    
    override init(
        device: MTLDevice
    ) {
        super.init(device: device)
        add(child: Plane(device: device))
    }
}
