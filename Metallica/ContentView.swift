//
//  ContentView.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import SwiftUI
import MPSwiftUI

struct ContentView: View {
    
    @State private var wireframeIsOn = false
    
    let metalUIView = MetalView()
    
    @ViewBuilder
    func controlButton(
        key: InputHandler.InputKey
    ) -> some View {
        let imageName: String = {
            switch key {
            case .left: return "chevron.left"
            case .right: return "chevron.right"
            case .down: return "chevron.down"
            case .up: return "chevron.up"
            default: fatalError("Unexpected")
            }
        }()
        
        Image(systemName: imageName)
            .foregroundColor(.white)
            .padding()
            .background(Color(uiColor: .lightGray).clipShape(Circle()))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in InputHandler.pressedKeys.insert(key) }
                    .onEnded { _ in InputHandler.pressedKeys.remove(key) }
            )
    }
    
    var body: some View {
        VStack {
            SwiftUIView { metalUIView }
            .onUpdateUIView { _, _ in
                metalUIView.renderer.wireframeFillEnabled = wireframeIsOn
            }
            .readSize {
                InputHandler.defaultTouchLocation = .init(x: $0.width / 2, y: $0.height / 2)
            }
            
            Divider()
            
            HStack(alignment: .center, spacing: 0) {
                controlButton(key: .left)
                VStack(spacing: 10) {
                    controlButton(key: .up)
                    controlButton(key: .down)
                }
                controlButton(key: .right)
            }
            
            HStack {
                Toggle("Wireframe", isOn: $wireframeIsOn)
                Spacer()
            }
            .padding()
            
        }.ignoresSafeArea(edges: .top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

public extension SwiftUIView {
    func onMakeUIView(
        handler: @escaping (Context) -> UIView
    ) -> SwiftUIView {
        var copy = self
        return copy.setMakeUIView(handler: handler)
    }
    
    func onUpdateUIView(
        handler: @escaping (UIView, Context) -> Void
    ) -> SwiftUIView {
        var copy = self
        return copy.setUpdateUIView(handler: handler)
    }
}
