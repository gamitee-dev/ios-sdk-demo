//
//  SplashViewController.swift
//  TestApp
//
//  Created by Arkadi Yoskovitz on 12/12/2023.
//
import UIKit
import SwiftUI
///
///
///
class SplashViewController : UIViewController
{
    // MARK: - type - enum
    enum Constants
    {
        case uikit
    }
    
    // MARK: - Properties
    
    // MARK: - @IBOutlet
    @IBOutlet var navigationLabelView: UIStackView!
    
    // MARK: - View LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        // TODO: -
        //  Check flag, and then after delay
        //      if true  load UITabBarController
        //      if false load UIHostingController
        let runningCase = Constants.uikit
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: DispatchWorkItem(block: { [weak self] in
            
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.setNavigationBarHidden(true, animated: true)
            strongSelf.performSegue(withIdentifier: strongSelf.segue(for: runningCase), sender: strongSelf)
        }))
    }
    
    private func segue(for navigation: Constants) -> String
    {
        switch navigation 
        {
        case .uikit  : return "segueToUIKit"
        }
    }
}

extension SplashViewController.Constants : CustomStringConvertible
{
    var description : String
    {
        switch self
        {
        case .uikit  : return "uikit"
        }
    }
}

