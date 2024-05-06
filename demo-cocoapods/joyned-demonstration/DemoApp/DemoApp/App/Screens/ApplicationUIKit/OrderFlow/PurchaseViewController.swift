//
//  PurchaseViewController.swift
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
class PurchaseViewController : UIViewController
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
    @IBOutlet weak var    topPriceLabel : UILabel!
    @IBOutlet weak var pannelPriceLabel : UILabel!
    
    // MARK: - Properties - internal
    internal var venue : Venue!
    
    // MARK: - View LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = venue?.productTitle ?? "Purchase"
        
        [topPriceLabel,pannelPriceLabel].forEach {
            $0.text = "\(venue.productPrice.amount) \(venue.productPrice.currency)"
        }
    }
    
    // MARK: - @IBAction
    @IBAction func triggerNavigation(_ sender: Any, forEvent event: UIEvent)
    {
        guard venue != nil else { return }

        // {
        // apiKey: "Z2FtaXRlZS1kZW1vOmm3HXn4IQ",
        // apiKey: "dm95YWdlLWRlbW86giVSNSnTY8D-hwUqvr6PNTGGfZ_PphmGZUvdPi8_Shw",
        // transactionId: "123",
        // price: "1.23",
        // currencyCode: "USD",
        // productIds: ["hotel-123", "hotel-456"],
        // }
        let transactionPayload: [String: Any] = [
            "transactionId": "321",
            "price": "1.23",
            "currencyCode": "USD",
            "productIds": ["hotel-123", "hotel-456"]
        ]

        // Convert the dictionary to Data
        if let data = try? JSONSerialization.data(withJSONObject: transactionPayload, options: .prettyPrinted) {
            
            // Convert the Data to a UTF-8 string
            if let json = String(data: data, encoding: .utf8) {
                // let transaction = "{\"transactionId\":\"123\",\"price\":\"1.23\",\"currencyCode\":\"USD\",\"productIds\":[\"hotel-123\",\"hotel-456\"]}"
                JoynedSDK.report(Transaction: JoynedTransactionRequest(transactionString: json))
            }
        }
        performSegue(withIdentifier: Constants.Identifier.segue, sender: self)
    }
    
    // MARK: - Navigation
    @IBSegueAction func showStatusViewController(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> UIViewController? {
        
        guard segueIdentifier == Constants.Identifier.segue else { return nil }
        
        let viewController = StatusViewController(coder: coder)
        return viewController
    }
}
// MARK: - Constants
fileprivate extension PurchaseViewController.Constants.Identifier
{
    static var segue  : String { "segueToStatus" }
}
