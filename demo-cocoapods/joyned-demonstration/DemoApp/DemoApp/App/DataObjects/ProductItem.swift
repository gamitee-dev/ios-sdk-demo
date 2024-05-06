//
//  ProductItem.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 18/12/2023.
//  Copyright © 2023 co.joyned. All rights reserved.
//
import Foundation
///
///
///
struct ProductItem: Codable, Hashable {
    var productTitle: String
    var productRate: Int
    var productThumbnail: String
    var productImages: [String]
    var productDates: ProductDates
    var productTags: ProductTags
    var productDescription: String
    var productDetails: ProductDetails
    var productLocation: String
    var productPrice: String
    var isFavorite: Bool
    
    struct ProductDates: Codable, Hashable {
        var checkin: String
        var checkout: String
    }
    
    struct ProductTags: Codable, Hashable {
        var pet_friendly: Bool
        var spa: Bool
        var indoor_pool: Bool
        var ac: Bool
    }
    
    struct ProductDetails: Codable, Hashable {
        var room: String
        var adults: Int
        var children: Int
    }
}
