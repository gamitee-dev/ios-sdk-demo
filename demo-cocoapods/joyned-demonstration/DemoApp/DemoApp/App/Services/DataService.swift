//
//  DataService.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 04/03/2024.
//  Copyright © 2024 co.joyned. All rights reserved.
//

import UIKit

final internal class DataService : NSObject
{
    // MARK: - Singleton
    internal class var  shared : DataService { _shared }
    private static var _shared : DataService = DataService()
    
    // MARK: - Properties
    private var decoder : JSONDecoder
    internal private(set) var venues : [Venue]
    
    // MARK: - View LifeCycle
    private override init()
    {
        self.decoder = JSONDecoder()
        self.venues  = [Venue]()
        super.init()
    }
    
    internal func triggerDataLoad()
    {
        guard let container = loadVenuesFromJSON() else { return }
        venues.removeAll()
        venues.append(contentsOf: container.venues)
    }
    internal func item(for targetUrl: URL) -> Venue?
    {
        venues.first(where: { $0.productURL == targetUrl.absoluteString })
    }
}
// MARK: - load from local JSON file
fileprivate extension DataService
{
    func loadDataFromJSON(file named: String) -> Data?
    {
        guard let path = Bundle.main.path(forResource: named, ofType: "json")  else { return nil }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path))     else { return nil }
        return data
    }
    
    func loadProductItemsFromJSON() -> [ProductItem]
    {
        guard let data = loadDataFromJSON(file: "ProductSeed")                         else { return [ProductItem]() }
        guard let json = try? decoder.decode([String: [ProductItem]].self, from: data) else { return [ProductItem]() }
        let products = json["products"] ?? [ProductItem]()
        return products
    }
    
    func loadProductBundleFromJSON() -> BundlesContainer?
    {
        guard let data      = loadDataFromJSON(file: "BundleSeed")                   else { return nil }
        guard let container = try? decoder.decode(BundlesContainer.self, from: data) else { return nil }
        return container
    }
    func loadVenuesFromJSON() -> VenuesContainer?
    {
        guard let data      = loadDataFromJSON(file: "VenuesSeed")                  else { return nil }
        guard let container = try? decoder.decode(VenuesContainer.self, from: data) else { return nil }
        return container
    }
}
