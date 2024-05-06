//
//  ProductBundle.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 18/12/2023.
//  Copyright © 2023 co.joyned. All rights reserved.
//
import Foundation
///
///
///
struct ProductBundle : Codable , Hashable
{
    var bundleTitle     : String
    var bundleImageName : String
    var bundleLocation  : String
    var bundlePrice     : String
    var bundleItems     : [ProductItem]
}
struct BundlesContainer : Codable
{
    var bundles : [[ProductBundle]]
}
