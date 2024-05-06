//
//  ExtensionsUISearchBar.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 15/12/2023.
//  Copyright © 2023 co.joyned. All rights reserved.
//
import Foundation
import UIKit
///
///
///
@IBDesignable
extension UISearchBar
{
    @IBInspectable var searchTextFieldBackgroundColor : UIColor?
    {
        set { searchTextField.backgroundColor = newValue }
        get { searchTextField.backgroundColor }
    }
    @IBInspectable var searchTextFieldShadowRadius : CGFloat
    {
        set { searchTextField.layer.shadowRadius = newValue }
        get { searchTextField.layer.shadowRadius }
    }
    @IBInspectable var searchTextFieldShadowOpacity : Float
    {
        set { searchTextField.layer.shadowOpacity = newValue }
        get { searchTextField.layer.shadowOpacity }
    }
    @IBInspectable var searchTextFieldShadowOffset : CGSize
    {
        set { searchTextField.layer.shadowOffset = newValue }
        get { searchTextField.layer.shadowOffset }
    }
    @IBInspectable var searchTextFieldShadowColor : UIColor?
    {
        set { searchTextField.layer.shadowColor = newValue?.cgColor }
        get {
            if let color = searchTextField.layer.shadowColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
}
