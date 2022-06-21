//
//  ContentView.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import SwiftUI
import MPSwiftUI

struct ContentView: View {
    
    @State private var wireframeIsOn = false
    
    let metalUIView = MetalView()
    
    var body: some View {
        VStack {
            SwiftUIView { metalUIView }
            .onUpdateUIView { _, _ in
                metalUIView.renderer.wireframeFillEnabled = wireframeIsOn
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
