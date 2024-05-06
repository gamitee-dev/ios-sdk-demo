//
//  ExtensionsUIApplication.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 14/12/2023.
//
import Foundation
import UIKit
///
///
///
extension UIApplication
{
    /// A convianance accessor the current  main content window of the application
    var v_keyWindow : UIWindow?
    {
        let connectedScenes = connectedScenes.compactMap({ $0 as? UIWindowScene })
        let   focusedScenes = connectedScenes.filter({ $0.activationState == .foregroundActive })
        let    windowScenes = focusedScenes.isEmpty ? connectedScenes : focusedScenes
        
        let  sceneWindows = windowScenes.flatMap({ $0.windows })
        
        let windows : [UIWindow]
        if #available(iOS 15.0, *) {
            windows = sceneWindows
        } else {
            windows = sceneWindows.isEmpty ? self.windows : sceneWindows
        }
        
        return windows.first(where: \.isKeyWindow) ?? windows.first
    }
}
