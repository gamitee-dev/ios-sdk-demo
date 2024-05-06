import Foundation
import UIKit
///
///
///
final class ProductLayout : CompositionalLayout
{
    init()
    {
        let layoutParams = ProductLayout.generateLayout()
        super.init(section: layoutParams.section, configuration: layoutParams.configuration)
    }
    required init?(coder: NSCoder)
    {
        let layoutParams = ProductLayout.generateLayout()
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
        
        // Group configuration =================================================================================
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension : .fractionalWidth (1.0),
                heightDimension: .fractionalHeight(1.0)
            ), subitems: [
                item
            ])
        
        // Section configuration ===============================================================================
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = CGFloat(0.0)
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = CGFloat(0.0)
        configuration.scrollDirection     = .vertical
        
        return (section: section, configuration: configuration)
    }
}
