//
//  CollectionListRouter.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/15/22.
//

import UIKit

protocol CollectionListRoutingLogic {
    
    func routeToCollectionDetails()
    
}

protocol CollectionListDataPassing {
    
    var dataStore: CollectionListDataStore? { get }
    
}

class CollectionListRouter: CollectionListDataPassing {
    
    // MARK: - Public Variables
    
    weak var viewController: UIViewController?
    var dataStore: CollectionListDataStore?
    
}

// MARK: - CollectionListRoutingLogic

extension CollectionListRouter: CollectionListRoutingLogic {
    
    func routeToCollectionDetails() {
        let destVc = CollectionDetailsViewController()
        guard let selectedCollectionObjectNumber = dataStore?.selectedCollectionObjectNumber,
              var destDataStore = destVc.router?.dataStore else {
            return
        }
        
        destDataStore.collectionObjectNumber = selectedCollectionObjectNumber
        
        viewController?.navigationController?.pushViewController(destVc, animated: true)
    }
    
}
