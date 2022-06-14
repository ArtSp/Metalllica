//
//  MetalView.swift
//  Created by Artjoms Spole on 10/06/2022.
//

import SwiftUI
import MPSwiftUI
import MetalKit

class MetalView: MTKView {
    var renderer: Renderer!
    
    init() {
        super.init(frame: .zero, device: MTLCreateSystemDefaultDevice())
        // Make sure we are on a device that can run metal!
        guard let defaultDevice = device else {
            fatalError("Device loading error")
        }
        colorPixelFormat = .bgra8Unorm
        depthStencilPixelFormat = .depth32Float
        // Our clear color, can be set to any color
        clearColor = MTLClearColor(red: 0, green: 0.8, blue: 0.3, alpha: 1)
        createRenderer(device: defaultDevice)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createRenderer(device: MTLDevice) {
        renderer = Renderer(device: device)
        delegate = renderer
    }
    
}

// MARK: - Preview:

struct MetalView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView {
            MetalView()
        }
    }
}
 
