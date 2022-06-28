//
//  InputHandler.swift
//  Created by Artjoms Spole on 28/06/2022.
//

import CoreGraphics
import Foundation

enum InputHandler {
    static var pressedKeys: InputKey = []
    static var touchLocation: CGPoint?
    static var defaultTouchLocation: CGPoint?
    
    struct InputKey: OptionSet {
        let rawValue: Int
        
        static let up     = InputKey(rawValue: 1 << 0)
        static let down   = InputKey(rawValue: 1 << 1)
        static let right  = InputKey(rawValue: 1 << 2)
        static let left   = InputKey(rawValue: 1 << 3)
    }
}
