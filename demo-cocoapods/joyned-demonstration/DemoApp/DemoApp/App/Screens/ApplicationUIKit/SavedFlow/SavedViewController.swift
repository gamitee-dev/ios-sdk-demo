//
//  SavedViewController.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 06/03/2024.
//  Copyright © 2024 co.joyned. All rights reserved.
//
import Foundation
import UIKit
import JoynedMobileSDK
///
///
class SavedViewController : UIViewController
{
    // MARK: - type - enum
    
    // MARK: - Properties
    
    // MARK: - View LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Saved"
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        JoynedSDK.hideDisplay()
    }
}
