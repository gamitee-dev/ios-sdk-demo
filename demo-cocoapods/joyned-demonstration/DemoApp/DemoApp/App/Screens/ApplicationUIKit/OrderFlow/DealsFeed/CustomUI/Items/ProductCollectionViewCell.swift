//
//  ProductCollectionViewCell.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 18/12/2023.
//  Copyright © 2023 co.joyned. All rights reserved.
//
import Foundation
import UIKit
import JoynedMobileSDK
///
///
///
class ProductCollectionViewCell : TitleCollectionViewCell
{
    @IBOutlet weak var imageView        : UIImageView!
    @IBOutlet weak var datesLabel       : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var locationLabel    : UILabel!
    @IBOutlet weak var priceLabel       : UILabel!
    @IBOutlet weak var favoriteButton   : UIButton!
    @IBOutlet weak var   joynedButton   : JoynedButton!

    override func prepareForReuse()
    {
        super.prepareForReuse()
        favoriteButton?.isHidden  = true
        favoriteButton?.isEnabled = false
    }
    
    override func prepareForInterfaceBuilder()
    {
        super.prepareForInterfaceBuilder()
        favoriteButton?.isHidden  = true
        favoriteButton?.isEnabled = false
    }
}
