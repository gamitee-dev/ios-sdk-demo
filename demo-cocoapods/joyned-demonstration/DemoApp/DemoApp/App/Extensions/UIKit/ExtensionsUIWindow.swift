//
//  ExtensionsUIWindow.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 14/12/2023.
//
import Foundation
import UIKit
///
///
///
extension UIWindow
{
    var v_topViewController : UIViewController? {
        
        guard let rootController = rootViewController else { return nil }
        return rootController.v_topViewController
    }
}
