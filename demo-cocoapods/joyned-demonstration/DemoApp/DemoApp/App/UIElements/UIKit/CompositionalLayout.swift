//
//  CompositionalLayout.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 19/12/2023.
//  Copyright © 2023 co.joyned. All rights reserved.
//
import Foundation
import UIKit
///
///
///
class CompositionalLayout : UICollectionViewCompositionalLayout
{
    // MARK: - Properties
    @IBInspectable
    var interSectionSpacing : CGFloat = 0
    {
        didSet {
            let new = UICollectionViewCompositionalLayoutConfiguration()
            new.scrollDirection     = configuration.scrollDirection
            new.interSectionSpacing = interSectionSpacing
            configuration = new
        }
    }
}
