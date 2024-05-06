//
//  SearchNavigationDelegate.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 14/12/2023.
//  Copyright © 2023 co. All rights reserved.
//
import Foundation
import UIKit
///
///
///
class SearchNavigationDelegate : NSObject
{
    private func addSubviewConstraints(to containerView: UIView, contentView: UIView)
    {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: containerView, attribute: .leading, relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: contentView, attribute: .leading,
                multiplier: 1.0, constant: 0.0
            ),
            NSLayoutConstraint(
                item: containerView, attribute: .trailing, relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: contentView, attribute: .trailing,
                multiplier: 1.0, constant: 0.0
            ),
            NSLayoutConstraint(
                item: containerView, attribute: .bottom, relatedBy: .equal,
                toItem: contentView, attribute: .top,
                multiplier: 1.0, constant: 0.0
            )
        ])
    }
}
// MARK: - UINavigationControllerDelegate
extension SearchNavigationDelegate : UINavigationControllerDelegate
{
    // Called when the navigation controller shows a new top view controller via a push, pop or setting of the view controller stack.
    @available(iOS 2.0, *)
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
    {
        if viewController is UITabBarController
        {
            viewController.navigationItem.setHidesBackButton(true, animated: false)
        }
        
        guard let navBar = navigationController.navigationBar as? NavigationBar else { return }
        
        let navItem = viewController.v_content.navigationItem
        
        for subview in navigationController.navigationBar.subviews where subview.v_isNavigationBarContentView
        {
            subview.clipsToBounds = false
            
            if let item = navItem as? NavigationItem
            {
                guard let subtitleView = item.subtitleView     else { continue }
                guard !subview.subviews.contains(subtitleView) else { continue }
                navBar.touchableView = subtitleView
                addSubviewConstraints(to: subview, contentView: subtitleView)
                
                viewController.additionalSafeAreaInsets = UIEdgeInsets(
                    top: subtitleView.frame.height,
                    left: 0,
                    bottom: 0,
                    right: 0
                )
                
            } else {
                navBar.touchableView?.removeFromSuperview()
            }
        }
        
        if navigationController.viewControllers.first is DealsFeedViewController , viewController is ProductViewController
        {
            navigationController.transitionCoordinator?.animate(alongsideTransition: { context in
                viewController.tabBarController?.tabBar.alpha = 0.0
            })
        }
        if viewController is DealsFeedViewController
        {
            navigationController.transitionCoordinator?.animate(alongsideTransition: { context in
                viewController.tabBarController?.tabBar.alpha = 1.0
            })
        }
    }
    
    @available(iOS 2.0, *)
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool)
    {
        if viewController is UITabBarController
        {
            viewController.navigationItem.setHidesBackButton(true, animated: false)
        }

        for subview in navigationController.navigationBar.subviews where subview.v_isNavigationBarContentView
        {
            subview.clipsToBounds = false
        }
    }
}
