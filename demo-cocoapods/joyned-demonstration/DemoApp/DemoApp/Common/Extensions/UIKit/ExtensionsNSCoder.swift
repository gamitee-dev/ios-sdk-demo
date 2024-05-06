//
//  ExtensionsNSCoder.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 18/12/2023.
//  Copyright © 2023 co.joyned. All rights reserved.
//
import Foundation
import UIKit
///
///
///
extension NSCoder
{
    func encodeUIRectCorner(_ corner: UIRectCorner, forKey key: String)
    {
        var encodedValue : UInt = 0
        
        if corner.contains(.topLeft) {
            encodedValue |= 1 << 0
        }
        if corner.contains(.topRight) {
            encodedValue |= 1 << 1
        }
        if corner.contains(.bottomLeft) {
            encodedValue |= 1 << 2
        }
        if corner.contains(.bottomRight) {
            encodedValue |= 1 << 3
        }
        encode(Int(encodedValue), forKey: key)
    }
    
    func decodeUIRectCorner(forKey key: String) -> UIRectCorner
    {
        let decodedValue = decodeInteger(forKey: key)
        
        var corner : UIRectCorner = []
        
        if decodedValue & (1 << 0) != 0 {
            corner.insert(.topLeft)
        }
        if decodedValue & (1 << 1) != 0 {
            corner.insert(.topRight)
        }
        if decodedValue & (1 << 2) != 0 {
            corner.insert(.bottomLeft)
        }
        if decodedValue & (1 << 3) != 0 {
            corner.insert(.bottomRight)
        }
        return corner
    }
}
