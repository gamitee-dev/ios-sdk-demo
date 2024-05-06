//
//  NavigationBar.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 13/12/2023.
//  Copyright © 2023 co. All rights reserved.
//
import Foundation
import UIKit
///
///
///
class NavigationBar : UINavigationBar
{
    weak var touchableView : UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        applyViewHierarchyChanges()
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        applyViewHierarchyChanges()
    }
    
    private func applyViewHierarchyChanges()
    {
        for subview in self.subviews where subview.v_isNavigationBarContentView
        {
            subview.clipsToBounds = false
        }
    }
    
    // MARK: - touch handling logic
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? 
    {
        for touchable in [touchableView] 
        {
            guard let t = touchable else { continue }
            let p = t.convert(point, from: self)
            
            guard let v = t.hitTest(p, with: event) , v.window != nil else { continue }
            return v
        }
        return super.hitTest(point, with: event)
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool 
    {
        if super.point(inside: point, with: event) 
        {
            return true
        }
        
        for touchable in [touchableView]
        {
            guard let t = touchable else { continue }
            let p = t.convert(point, from: self)
            
            guard t.window != nil else { continue }
            return !t.isHidden && t.point(inside: p, with: event)
        }
        return false
    }
}
