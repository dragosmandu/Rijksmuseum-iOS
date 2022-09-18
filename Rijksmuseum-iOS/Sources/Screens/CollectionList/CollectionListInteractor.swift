//
//  CollectionListInteractor.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/15/22.
//

import Foundation

protocol CollectionListBusinessLogic {
    
    func getNextCollectionListPage()
    func refreshCollectionList()
    func selectCollection(request: CollectionListModels.SelectCollection.Request)
    
}

protocol CollectionListDataStore {
    
    var selectedCollectionObjectNumber: String? { get }
    
}

class CollectionListInteractor: CollectionListDataStore {
    
    // MARK: - Public Variables
    
    var presenter: CollectionListPresentationLogic?
    var selectedCollectionObjectNumber: String?
    
    // MARK: - Private Variables
    
    private let rijksmuseumWorker = RijksmuseumWorker()
    private let pageSize = 20
    
    private var collectionList: [RijksmuseumModels.Collection] = []
    private var currentPage = 0
    private var isFetchingData = false
    private var hasNextPage = true
    
}

// MARK: - CollectionListBusinessLogic

extension CollectionListInteractor: CollectionListBusinessLogic {
    
    func getNextCollectionListPage() {
        Task(priority: .background) {
            if !isFetchingData && hasNextPage {
                isFetchingData = true
                defer { isFetchingData = false }
                
                var err: Error?
                let reqDto = RijksmuseumApiDtos.GetCollections.Request(culture: .en,
                                                                       involvedMaker: nil,
                                                                       page: currentPage,
                                                                       pageSize: pageSize)
                do {
                    let collectionListPage = try await rijksmuseumWorker.getCollections(with: reqDto)
                    
                    currentPage += 1
                    hasNextPage = !collectionListPage.isEmpty
                    
                    collectionList.append(contentsOf: collectionListPage)
                } catch { err = error }
                
                presentCurrentCollectionList(with: err)
            }
        }
    }
    
    func refreshCollectionList() {
        collectionList = []
        currentPage = 0
        isFetchingData = false
        hasNextPage = true
        
        getNextCollectionListPage()
    }
    
    func selectCollection(request: CollectionListModels.SelectCollection.Request) {
        guard let selectedCollection = collectionList[safe: request.index] else { return }
        
        selectedCollectionObjectNumber = selectedCollection.objectNumber
        
        presenter?.presentCollectionDetails()
    }
    
}

// MARK: - Private Helpers

private extension CollectionListInteractor {
    
    func presentCurrentCollectionList(with err: Error?) {
        let resp = CollectionListModels.GetCollectionList.Response(collectionList: collectionList,
                                                                   err: err)
        
        presenter?.presentCollectionList(with: resp)
    }
    
}
