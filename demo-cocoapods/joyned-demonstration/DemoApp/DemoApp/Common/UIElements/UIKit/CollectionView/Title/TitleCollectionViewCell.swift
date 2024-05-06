//
//  TitleCollectionViewCell.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 16/12/2023.
//  Copyright © 2023 co.joyned. All rights reserved.
//
import Foundation
import UIKit
///
///
///
class TitleCollectionViewCell: UICollectionViewCell
{
    class var  nameNib : String { String(describing: self) }
    class var classNib : UINib  { UINib(nibName: nameNib, bundle: nil) }
    
    @IBOutlet weak var titleLabel: UILabel!
}
