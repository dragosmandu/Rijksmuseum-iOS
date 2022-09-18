//
//  CollectionListModels.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/15/22.
//

import Foundation

struct CollectionListModels {
    
    struct GetCollectionList {
        struct Response {
            let collectionList: [RijksmuseumModels.Collection]
            let err: Error?
        }
        
        struct ViewModel {
            let cellViewModels: [CollectionListCollectionViewCell.ViewModel]
            let footerViewModel: LabelCollectionReusableView.ViewModel?
        }
    }
    
    struct SelectCollection {
        struct Request {
            let index: Int
        }
    }
    
}
