//
//  StatusViewController.swift
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
class StatusViewController : UIViewController
{
    // MARK: - type - enum
    
    // MARK: - Properties
    internal var venue : Venue!

    // MARK: - View LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Status"
        navigationItem.setHidesBackButton(true, animated: false)
        
        // let button = JoynedSDK.generateJoynedButton(
        //     frame: CGRect(x: 100, y: 500, width: 70, height: 34))
        // view.addSubview(button)
        JoynedSDK.generateJoynedButton(frame: CGRect(x: 100, y: 500, width: 70, height: 34), with: self)
    }
    
    // MARK: - @IBAction
    @IBAction func triggerNavigation(_ sender: Any, forEvent event: UIEvent)
    {
        performSegue(withIdentifier: "unwindAfterSuccess", sender: self)
    }
}
extension StatusViewController : JoynedButtonDelegate
{
    func willPresentMobileSDKContent()
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
        return JoynedOfferingRequest(offeringString: product, extraString: extra)
    }
}
