//
//  CollectionDetailsInteractor.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/15/22.
//

import Foundation

protocol CollectionDetailsBusinessLogic {
    
    func getCollectionDetails()
    
}

protocol CollectionDetailsDataStore {
    
    var collectionObjectNumber: String? { get set }
    
}

class CollectionDetailsInteractor: CollectionDetailsDataStore {
    
    // MARK: - Public Variables
    
    var presenter: CollectionDetailsPresentationLogic?
    var collectionObjectNumber: String?
    
    // MARK: - Private Variables
    
    private let rijksmuseumWorker = RijksmuseumWorker()
    
    private var isFetchingData = false
    private var collectionDetails: RijksmuseumModels.CollectionDetails?
    
}

// MARK: - CollectionDetailsBusinessLogic

extension CollectionDetailsInteractor: CollectionDetailsBusinessLogic {
    
    func getCollectionDetails() {
        Task(priority: .background) {
            if !isFetchingData {
                isFetchingData = true
                defer {
                    presentCollectionDetails()
                    isFetchingData = false
                }
                
                guard let collectionObjectNumber = collectionObjectNumber else { return }
                let req = RijksmuseumApiDtos.GetCollectionDetails.Request(culture: .en,
                                                                          objectNumber: collectionObjectNumber)
                do { collectionDetails = try await rijksmuseumWorker.getCollectionDetails(with: req) }
            }
        }
    }
    
}

// MARK: - Private Helpers

private extension CollectionDetailsInteractor {
    
    func presentCollectionDetails() {
        let response = CollectionDetailsModels.GetCollectionDetails.Response(collectionDetails: collectionDetails)
        
        presenter?.presentCollectionDetails(with: response)
    }
    
}
