//
//  ContentView.swift
//  Created by Artjoms Spole on 13/06/2022.
//

import SwiftUI
import MPSwiftUI

struct ContentView: View {
    var body: some View {
        SwiftUIView {
            MetalView()
        }
        .ignoresSafeArea()
        .aspectRatio(1, contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
