//
//  ProductFeedLayout.swift
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
final class ProductFeedLayout : CompositionalLayout
{
    // MARK: - type - enum
    struct Constants
    {
        struct Identifier
        {
            static var global : String { "SearchHeaderIdentifier" }
            static var header : String { UICollectionView.elementKindSectionHeader }
            static var footer : String { UICollectionView.elementKindSectionFooter }
            private init() {}
        }
        
        private init() {}
    }
    
    // MARK: -
    init()
    {
        let layoutParams = ProductFeedLayout.generateLayout()
        super.init(section: layoutParams.section, configuration: layoutParams.configuration)
    }
    required init?(coder: NSCoder)
    {
        let layoutParams = ProductFeedLayout.generateLayout()
        super.init(section: layoutParams.section, configuration: layoutParams.configuration)
    }
    
    static func generateLayout() -> (section: NSCollectionLayoutSection, configuration: UICollectionViewCompositionalLayoutConfiguration)
    {
        // Item configuration ==================================================================================
        let itemSize = NSCollectionLayoutSize(
            widthDimension : .fractionalWidth (1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top     : 10,
            leading : 10,
            bottom  : 00,
            trailing: 10
        )
        // Group configuration =================================================================================
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension : .fractionalWidth (1.0),
                heightDimension: .fractionalHeight(1.0/2.75)//.estimated(300)
            ), subitems: [
                item
            ])
        
        
        // Section configuration ===============================================================================
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = CGFloat(0.0)
        
        // Global sticky header ====================================================================================
        
        let globalHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80)
        )
        
        let globalHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: globalHeaderSize,
            elementKind: Constants.Identifier.global,
            alignment: .top
        )
        globalHeader.pinToVisibleBounds = true
        
        // 8 - General configuration ===================================================================================
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.boundarySupplementaryItems = [globalHeader]
        configuration.interSectionSpacing        = CGFloat(00.0)
        configuration.scrollDirection            = .vertical
        
        return (section: section, configuration: configuration)
    }
}
