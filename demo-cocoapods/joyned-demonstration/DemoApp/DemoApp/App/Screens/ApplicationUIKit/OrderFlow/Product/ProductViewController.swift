//
//  ProductViewController.swift
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
class ProductViewController : UIViewController
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
    
    // MARK: - Properties - @IBOutlet
    @IBOutlet var tagViews: [UIButton]!
    
    @IBOutlet weak var vanueTagsView : UIStackView!
    @IBOutlet weak var vanueTagPet   : UIButton!
    @IBOutlet weak var vanueTagSpa   : UIButton!
    @IBOutlet weak var vanueTagPool  : UIButton!
    @IBOutlet weak var vanueTagAC    : UIButton!
    
    @IBOutlet weak var vanueTitleLabel : UILabel!
    @IBOutlet weak var vanueCheckInLabel : UILabel!
    @IBOutlet weak var vanueCheckOutLabel : UILabel!
    
    @IBOutlet weak var          roomLabel : UILabel!
    @IBOutlet weak var   adultsCountLabel : UILabel!
    @IBOutlet weak var childrenCountLabel : UILabel!
    
    @IBOutlet weak var bottomPanelView : UIView!
    @IBOutlet weak var joynedButton : JoynedButton! {
        didSet {
            joynedButton.delegate = self
        }
    }

    // MARK: - Properties - internal
    internal var venue : Venue!
    
    // MARK: - Properties - private
    private   var dataSource : UICollectionViewDiffableDataSource<Int, String>!
    
    // MARK: - @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        registerVisualElements()
        configureVisualElements()
        configureDataSource()
        configureLayout()
        configureUI()
        
        joynedAreaComputation = { [weak self] in
            
            guard let strongSelf = self else { return nil }
            
            let converted = strongSelf.view.convert(strongSelf.bottomPanelView.frame, to: strongSelf.bottomPanelView.window)
            return CGRect(
                x: converted.minX,
                y: strongSelf.view.safeAreaLayoutGuide.layoutFrame.minY,
                width: converted.width,
                height: converted.minY - strongSelf.view.safeAreaLayoutGuide.layoutFrame.minY
            )
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    // MARK: - @IBAction
    @IBAction func triggerNavigation(_ sender: Any, forEvent event: UIEvent)
    {
        guard venue != nil else { return }
        performSegue(withIdentifier: Constants.Identifier.segue, sender: self)
    }
    
    // MARK: - Navigation
    @IBSegueAction func showPurchaseViewController(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> UIViewController? {
        
        guard segueIdentifier == Constants.Identifier.segue else { return nil }
        
        let viewController = PurchaseViewController(coder: coder)
        viewController?.venue = venue
        return viewController
    }
    // MARK: -
    private func configureUI()
    {
        title = venue?.productTitle ?? "Product"
        
        vanueTitleLabel.text = venue.productTitle
        vanueCheckInLabel.text = venue.productDates.checkin
        vanueCheckOutLabel.text = venue.productDates.checkout
        roomLabel.text = "\(venue.productDetails.room)"
        adultsCountLabel.text = "\(venue.productDetails.adults) Adults"
        childrenCountLabel.text = "\(venue.productDetails.children) Children"

        tagViews.forEach {
            $0.isUserInteractionEnabled = false
            $0.removeFromSuperview()
        }
        if venue.productTags.pet_friendly {
            vanueTagsView.addArrangedSubview(vanueTagPet)
        }
        if venue.productTags.spa {
            vanueTagsView.addArrangedSubview(vanueTagSpa)
        }
        if venue.productTags.indoor_pool {
            vanueTagsView.addArrangedSubview(vanueTagPool)
        }
        if venue.productTags.ac {
            vanueTagsView.addArrangedSubview(vanueTagAC)
        }
        vanueTagsView.setNeedsLayout()
        vanueTagsView.layoutIfNeeded()
    }
    
    private func registerVisualElements()
    {
        collectionView.register(ProductImageCollectionViewCell.classNib, forCellWithReuseIdentifier: Constants.Identifier.cell)
    }
    private func configureVisualElements()
    {
        dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) { (collectionView, indexPath, imageName) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifier.cell, for: indexPath)
            
            if let cell = cell as? ProductImageCollectionViewCell
            {
                cell.imageView.image = UIImage(named: imageName)
            }
            
            return cell
        }
    }
    
    private func configureDataSource()
    {
        var snapshot  = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        
        if let container = venue
        {
            snapshot.appendItems([container.productThumbnail])
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func configureLayout()
    {
        // collectionView.collectionViewLayout = createLayout()
    }
    func createLayout() -> UICollectionViewLayout
    {
        return ProductLinesLayout()
    }
}
// MARK: - Constants
fileprivate extension ProductViewController.Constants.Identifier
{
    static var   cell : String { "cellIdentifier"  }
    static var segue  : String { "segueToPurchase" }
}
extension ProductViewController : JoynedButtonDelegate
{
    func willPresentMobileSDKContent()
    {
        logger.debug()
    }
    
    func didPresentMobileSDKContent()
    {
        logger.debug()
    }
    func joynedButton(_ button: JoynedButton, productOfferingFor location: CGPoint) -> JoynedOfferingRequest?
    {
        logger.debug()
        
        return encode(product: venue)
    }
    
    private func encode(product item: Venue?) -> JoynedOfferingRequest?
    {
        guard let venue   = item              else { return nil }
        guard let product = venue.toPayload() else { return nil }
        guard let extra   = venue.toJSON()    else { return nil }
        
        // let product: [String: Any] = [
        //     "title": "Russian tour",
        //     "description": "Russian Tour is the very best tour. Fun and exhilarating.",
        //     "images": [
        //         "https://demo.joyned.co/images/new_travel/acropolis-greece-guided-tour.jpg"
        //     ],
        //     "directURL": "https://demo.joyned.co/travel/item/2",
        //     "offeringHash": "2",
        //     "price": [
        //         "amount": 12.3,
        //         "currency": "USD",
        //         "description": "per person"
        //     ],
        //     "offeringName": "hotel-offering",
        //     "data": [
        //         "startDate": 1701858141610,
        //         "endDate": 1701944531000
        //     ]
        // ]
        // let extra: [String: Any] = [
        //     "itemLink": "https://voyage.joyned.app/product/1",
        // ]
        
        return JoynedOfferingRequest(offeringString: product, extraString: extra)
    }
}
