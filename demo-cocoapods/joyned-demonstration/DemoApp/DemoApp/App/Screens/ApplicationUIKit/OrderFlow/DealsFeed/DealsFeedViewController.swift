//
//  DealsFeedViewController.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 12/12/2023.
//
import Foundation
import UIKit
import JoynedMobileSDK
///
///
///
class DealsFeedViewController : UIViewController
{
    // MARK: - type - enum
    struct Constants
    {
        struct Identifier
        {
            private init() {}
        }
        private init() {}
    }
    
    // MARK: - Properties
    private var selectedItem : Venue?
    
    // MARK: - Properties
    private var dataSource : UICollectionViewDiffableDataSource<Int, Venue>!
    
    // MARK: - @IBOutlet
    @IBOutlet      var  logoImageView : UIImageView!
    @IBOutlet weak var collectionView : UICollectionView! {
        didSet {
            collectionView.delegate = self
        }
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = String()
        navigationItem.titleView = logoImageView
        navigationItem.setHidesBackButton(true, animated: false)
        
        registerVisualElements()
        configureVisualElements()
        configureDataSource()
    }
    
    // MARK: - @IBAction
    @IBAction func unwindAfterTransactionComplete(_ segue: UIStoryboardSegue)
    {
        
    }
    
    // MARK: - Navigation
    @IBSegueAction func showProductViewController(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> UIViewController? {
        
        guard segueIdentifier == Constants.Identifier.segue else { return nil }
        
        let viewController = ProductViewController(coder: coder)
        viewController?.venue = selectedItem
        
        return viewController
    }
    // MARK: - Constants
    func present(selected item: Venue)
    {
        selectedItem = item
        performSegue(withIdentifier: Constants.Identifier.segue, sender: self)
    }
}
// MARK: - Constants
fileprivate extension DealsFeedViewController.Constants.Identifier
{
    static var   cell : String { "DealsFeedCellIdentifier"   }
    static var header : String { "DealsFeedHeaderIdentifier" }
    static var global : String { "SearchHeaderIdentifier"    }
    static var segue  : String { "segueToProduct" }
}
// MARK: - Collection View setup
fileprivate extension DealsFeedViewController
{
    private func registerVisualElements()
    {
        collectionView.register(ProductCollectionViewCell.classNib, forCellWithReuseIdentifier: Constants.Identifier.cell)
        collectionView.register(SearchHeaderView.classNib         , forSupplementaryViewOfKind: Constants.Identifier.global, withReuseIdentifier: Constants.Identifier.global)
    }
    private func configureVisualElements()
    {
        
        dataSource = UICollectionViewDiffableDataSource<Int, Venue>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifier.cell, for: indexPath)
            
            if let cell = cell as? ProductCollectionViewCell
            {
                cell.titleLabel.text        = item.productTitle
                cell.datesLabel.text        = "\(item.productDates.checkin) - \(item.productDates.checkout)"
                cell.descriptionLabel.text  = item.productDescription
                cell.locationLabel.text     = nil
                cell.priceLabel.text        = "\(item.productPrice.amount) \(item.productPrice.currency)"
                cell.imageView.image        = UIImage(named: item.productThumbnail)
                cell.joynedButton.delegate  = self
            }
            
            return cell
        }
        dataSource?.supplementaryViewProvider = { (collectionView,kind,indexPath) -> UICollectionReusableView? in
            
            guard kind == Constants.Identifier.global else { return nil }
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: Constants.Identifier.global,
                for: indexPath
            )
        }
    }
    
    private func configureDataSource()
    {
        var snapshot  = NSDiffableDataSourceSnapshot<Int, Venue>()
        
        DataService.shared.venues.enumerated().forEach { pair in
            
            snapshot.appendSections([pair.offset])
            snapshot.appendItems([pair.element])
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
// MARK: - UICollectionViewDelegate
extension DealsFeedViewController : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // Handle cell selection here
        if let item = dataSource.itemIdentifier(for: indexPath) {
            selectedItem = item
        }
        // Clear selection at the end of the click
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard selectedItem != nil else { return }
        performSegue(withIdentifier: Constants.Identifier.segue, sender: self)
    }
}
extension DealsFeedViewController : JoynedButtonDelegate
{
    func willPresentMobileSDKContent()
    {
        logger.debug()
    }
    
    func didPresentMobileSDKContent()
    {
        logger.debug()
    }
    
    func joynedButton(_ button: JoynedButton, productOfferingForItem indexPath: IndexPath) -> JoynedOfferingRequest?
    {
        return encode(product: dataSource.itemIdentifier(for: indexPath))
    }
    
    private func encode(product item: Venue?) -> JoynedOfferingRequest?
    {
        guard let venue   = item              else { return nil }
        guard let product = venue.toPayload() else { return nil }
        guard let extra   = venue.toJSON()    else { return nil }
        // let extra: [String: Any] = [
        //     "itemLink": "https://voyage.joyned.app/product/1",
        // ]
        return JoynedOfferingRequest(offeringString: product, extraString: extra)
    }
}
