//
//  CollectionDetailsModels.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/15/22.
//

import Foundation

struct CollectionDetailsModels {
    
    enum Error: LocalizedError {
        case invalidCollectionDetails
        
        var errorDescription: String? {
            switch self {
            case .invalidCollectionDetails:
                return "Invalid collection details"
            }
        }
    }
    
    struct GetCollectionDetails {
        struct Response {
            let collectionDetails: RijksmuseumModels.CollectionDetails?
        }
        
        struct ViewModel {
            let headerViewModel: CollectionDetailsHeaderView.ViewModel
            let detailsViewModel: CollectionDetailsDetailsScrollView.ViewModel
        }
    }
    
}
