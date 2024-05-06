//
//  ProductLinesLayout.swift
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
final class ProductLinesLayout : CompositionalLayout
{
    init()
    {
        let layoutParams = ProductLinesLayout.generateLayout()
        super.init(section: layoutParams.section, configuration: layoutParams.configuration)
    }
    required init?(coder: NSCoder)
    {
        let layoutParams = ProductLinesLayout.generateLayout()
        super.init(section: layoutParams.section, configuration: layoutParams.configuration)
    }
    
    static func generateLayout() -> (section: NSCollectionLayoutSection, configuration: UICollectionViewCompositionalLayoutConfiguration)
    {
        // 1 - configure first raw items (2 items) ======================================
        let firstItemSize = NSCollectionLayoutSize(
            widthDimension : .fractionalWidth (0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let firstItem = NSCollectionLayoutItem(layoutSize: firstItemSize)
        firstItem.contentInsets = NSDirectionalEdgeInsets(
            top     : 3,
            leading : 3,
            bottom  : 3,
            trailing: 3
        )
        
        // 1 - configure first raw group ================================================
        let firstGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension : .fractionalWidth (1.0),
            heightDimension: .fractionalHeight(1.0)
        ), subitems: [
            firstItem,
            firstItem
        ])
        
        // 2 - configure second raw items (2 items) =====================================
        let secondItemSize = NSCollectionLayoutSize(
            widthDimension : .fractionalWidth (1.0 / 3.0),
            heightDimension: .fractionalHeight(1.0 / 1.0)
        )
        let secondItem = NSCollectionLayoutItem(layoutSize: secondItemSize)
        secondItem.contentInsets = NSDirectionalEdgeInsets(
            top     : 3,
            leading : 3,
            bottom  : 3,
            trailing: 3
        )
        
        // 2 - configure second raw group ===============================================
        let secondGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension : .fractionalWidth (1.0),
            heightDimension: .fractionalHeight(1.0)
        ), subitems: [
            secondItem,
            secondItem,
            secondItem
        ])
        
        // 3 - configure groups (rows) in a single section =============================================================
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension : .fractionalWidth(1.0),
            heightDimension: .estimated(100)
        ), subitems: [
            firstGroup,
            secondGroup
        ])
        
        // 4 - configure section =======================================================================================
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.interGroupSpacing = CGFloat(10.0)
        
        // 5 - configure global ========================================================================================
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = CGFloat(00.0)
        configuration.scrollDirection     = .vertical
        
        return (section: section, configuration: configuration)
    }
}
