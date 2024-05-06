//
//  ExtensionsUIView.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 14/12/2023.
//
import Foundation
import UIKit
///
///
///
internal extension UIView
{
    var v_isNavigationBarContentView: Bool
    {
        NSStringFromClass(classForCoder).contains("_UINavigationBarContentView")
    }
}
