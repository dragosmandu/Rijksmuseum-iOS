//
//  CollectionDetailsRouter.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/15/22.
//

import UIKit

protocol CollectionDetailsRoutingLogic {
    
}

protocol CollectionDetailsDataPassing {
    
    var dataStore: CollectionDetailsDataStore? { get }
    
}

class CollectionDetailsRouter: CollectionDetailsDataPassing {
    
    // MARK: - Public Variables
    
    weak var viewController: UIViewController?
    var dataStore: CollectionDetailsDataStore?
    
}

// MARK: - CollectionDetailsRoutingLogic

extension CollectionDetailsRouter: CollectionDetailsRoutingLogic {
    
}
