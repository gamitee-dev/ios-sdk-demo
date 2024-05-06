//
//  Venue.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 29/02/2024.
//  Copyright © 2024 co.joyned. All rights reserved.
//
import Foundation
///
///
struct VenuesContainer : Codable , Hashable
{
    var venues : [Venue]
}
///
///
internal struct Venue : Codable , Hashable
{
    // MARK: - Types - enum
    enum CustomKeys: String , CodingKey
    {
        case title      = "title"
        case desc       = "description"
        case images     = "images"
        case url        = "directURL"
        case identifier = "offeringHash"
        case rating         = "rating"
        case price          = "price"
        case offeringName   = "offeringName"
        case dates          = "data"
    }
    
    // MARK: - Types - struct
    internal struct ProductPrice: Codable, Hashable {
        internal var amount: Double
        internal var currency: String
    }
    internal struct ProductDates: Codable, Hashable {
        internal var checkin: String
        internal var checkout: String
    }
    internal struct ProductTags: Codable, Hashable {
        internal var pet_friendly: Bool
        internal var spa: Bool
        internal var indoor_pool: Bool
        internal var ac: Bool
    }
    internal struct ProductDetails: Codable, Hashable {
        internal var room: String
        internal var adults: Int
        internal var children: Int
    }
    // MARK: - static
    fileprivate static var encoder  : JSONEncoder  = {
        let e = JSONEncoder()
        e.outputFormatting = .prettyPrinted
        return e
    }()
    // MARK: - properties
    internal var productTitle: String
    internal var productDescription: String
    internal var productImages: [String]
    internal var productURL: String
    internal var productID: String
    internal var productRating: Int
    internal var productThumbnail: String
    internal var productOfferingName: String
    internal var productPrice: ProductPrice
    
    internal var productDates: ProductDates
    
    internal var productTags: ProductTags
    internal var productDetails: ProductDetails
    internal var isFavorite: Bool
}
extension Venue
{
    func toJSON() -> String? 
    {
        guard let jsonData = try? Venue.encoder.encode(self) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    
    func toPayload() -> String?
    {
        let content = NSMutableDictionary()

        content.setObject(productTitle          , forKey: CustomKeys.title.rawValue         as NSString)
        content.setObject(productDescription    , forKey: CustomKeys.desc.rawValue          as NSString)
        content.setObject(productImages         , forKey: CustomKeys.images.rawValue        as NSString)
        content.setObject(productURL            , forKey: CustomKeys.url.rawValue           as NSString)
        content.setObject(productID             , forKey: CustomKeys.identifier.rawValue    as NSString)
        content.setObject(productRating         , forKey: CustomKeys.rating.rawValue        as NSString)
        content.setObject(productOfferingName   , forKey: CustomKeys.offeringName.rawValue  as NSString)
        
        let price  = NSMutableDictionary()
        price.setObject(productPrice.amount   , forKey: "amount"   as NSString)
        price.setObject(productPrice.currency , forKey: "currency" as NSString)
        
        content.setObject(price                 , forKey: CustomKeys.price.rawValue as NSString)
        content.setObject("{}"                  , forKey: CustomKeys.dates.rawValue as NSString)

        guard let data = try? JSONSerialization.data(withJSONObject: content, options: .prettyPrinted) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
// =====================================================================================================================
//{
//    "productTitle": "Acropolis Greece Guided Tour",
//    "productDescription": "Acropolis Greece Guided Tour. Qui dolor anim non irure adipisicing mollit. Do incididunt enim in sunt duis aliquip. Ullamco officia sunt sint nisi nisi elit ad duis qui sit. ",
//    "productImages": [
//        "https://demo.joyned.co/images/new_travel/acropolis-greece-guided-tour.jpg"
//    ],
//    "productURL": "https://demo.joyned.co/travel/item/1",
//    "productID": "1",
//    "productRating": 3,
//    "productPrice": {
//        "amount": 53.20,
//        "currency": "USD",
//    },
//    "productThumbnail": "acropolis-greece-guided-tour",
//    "productOfferingName": "hotel-offering",
//    "productDates": {
//        "checkin": "Sat, Nov 20",
//        "checkout": "Wed, Nov 24"
//    },
//    "productTags": {
//        "pet_friendly": true,
//        "spa": false,
//        "indoor_pool": false,
//        "ac": true
//    },
//    "productDetails": {
//        "room": "1 rooms",
//        "adults": 6,
//        "children": 0
//    },
//    "isFavorite": false
//}
// =====================================================================================================================
// {
//     "title": "Acropolis Greece Guided Tour",
//     "description": "Acropolis Greece Guided Tour. Qui dolor anim non irure adipisicing mollit. Do incididunt enim in sunt duis aliquip. Ullamco officia sunt sint nisi nisi elit ad duis qui sit. ",
//     "images": ["https://demo.joyned.co/images/new_travel/acropolis-greece-guided-tour.jpg"],
//     "directURL": "https://demo.joyned.co/travel/item/1",
//     "offeringHash": "1",
//     "rating": 3,
//     "price": {
//         "amount": 53.20,
//         "currency": "USD",
//     },
//     "offeringName": "hotel-offering",
//     "data": {
//     },
// },
// =====================================================================================================================
