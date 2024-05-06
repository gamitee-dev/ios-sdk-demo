//
//  ExtensionsUIViewController.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 14/12/2023.
//
import Foundation
import UIKit
///
///
///
extension UIViewController
{
    var v_content : UIViewController
    {
        if let controller = self as? UINavigationController
        {
            return controller.visibleViewController ?? self
        }
        else if let controller = self as? UITabBarController
        {
            return controller.selectedViewController ?? self
        }
        return self
    }
    
    var v_topViewController : UIViewController?
    {
        if v_content != self
        {
            return v_content.v_topViewController
        }
        
        if let presentedVC = presentedViewController
        {
            return presentedVC.v_topViewController
        }
        
        if let type = NSClassFromString("SlideMenuControllerSwift.SlideMenuController") , isKind(of: type)
        {
            return children.first?.v_topViewController
        }
        
        if !children.isEmpty , children.last?.viewIfLoaded?.window != nil
        {
            return children.last?.v_topViewController
        }
        
        guard isViewLoaded else { return self }

        for subview in view.subviews
        {
            // Key property which most of us are unaware of / rarely use.
            guard let responder  = subview.next                   else { continue }
            guard let controller = responder as? UIViewController else { continue }
            return controller.v_topViewController
        }
        return self
    }

    @IBInspectable var additionalTopSafeAreaInset : CGFloat
    {
        get { additionalSafeAreaInsets.top }
        set {
            additionalSafeAreaInsets = UIEdgeInsets(
                top: newValue,
                left: additionalSafeAreaInsets.left,
                bottom: additionalSafeAreaInsets.bottom,
                right: additionalSafeAreaInsets.right
            )
        }
    }
    @IBInspectable var additionalLeftSafeAreaInset : CGFloat
    {
        get { additionalSafeAreaInsets.left }
        set {
            additionalSafeAreaInsets = UIEdgeInsets(
                top: additionalSafeAreaInsets.top,
                left: newValue,
                bottom: additionalSafeAreaInsets.bottom,
                right: additionalSafeAreaInsets.right
            )
        }
    }
    @IBInspectable var additionalRightSafeAreaInset : CGFloat
    {
        get { additionalSafeAreaInsets.right }
        set {
            additionalSafeAreaInsets = UIEdgeInsets(
                top: additionalSafeAreaInsets.right,
                left: additionalSafeAreaInsets.left,
                bottom: additionalSafeAreaInsets.bottom,
                right: newValue
            )
        }
    }
    @IBInspectable var additionalBottomSafeAreaInset : CGFloat
    {
        get { additionalSafeAreaInsets.bottom }
        set {
            additionalSafeAreaInsets = UIEdgeInsets(
                top: additionalSafeAreaInsets.right,
                left: additionalSafeAreaInsets.left,
                bottom: newValue,
                right: additionalSafeAreaInsets.right
            )
        }
    }
}
