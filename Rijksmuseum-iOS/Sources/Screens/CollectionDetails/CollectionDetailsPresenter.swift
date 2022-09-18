//
//  CollectionDetailsPresenter.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/15/22.
//

import Foundation

protocol CollectionDetailsPresentationLogic {
    
    func presentCollectionDetails(with response: CollectionDetailsModels.GetCollectionDetails.Response)
    
}

class CollectionDetailsPresenter {
    
    // MARK: - Public Variables
    
    weak var viewController: CollectionDetailsDisplayLogic?
    
}

// MARK: - CollectionDetailsPresentationLogic

extension CollectionDetailsPresenter: CollectionDetailsPresentationLogic {
    
    func presentCollectionDetails(with response: CollectionDetailsModels.GetCollectionDetails.Response) {
        let err = response.collectionDetails == nil ? CollectionDetailsModels.Error.invalidCollectionDetails : nil
        let headerViewModel = CollectionDetailsHeaderView.ViewModel(imageUrl: response.collectionDetails?.webImage?.url,
                                                                    principalOrFirstMaker: response.collectionDetails?.principalOrFirstMaker,
                                                                    longTitle: response.collectionDetails?.longTitle)
        let detailsViewModel = CollectionDetailsDetailsScrollView.ViewModel(id: response.collectionDetails?.id,
                                                                            productionPlaces: response.collectionDetails?.productionPlaces ?? [],
                                                                            acquisitionDateStr: response.collectionDetails?.acquisition?.date?.formatted(date: .abbreviated, time: .omitted),
                                                                            prirefStr: response.collectionDetails?.priref,
                                                                            description: response.collectionDetails?.description,
                                                                            err: err)
        let viewModel = CollectionDetailsModels.GetCollectionDetails.ViewModel(headerViewModel: headerViewModel,
                                                                               detailsViewModel: detailsViewModel)
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayCollectionDetails(with: viewModel)
        }
    }
    
}

// MARK: - Private Helpers

private extension CollectionDetailsPresenter {
    
}
