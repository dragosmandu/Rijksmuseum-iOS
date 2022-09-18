//
//  CollectionListPresenter.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/15/22.
//

import Foundation

protocol CollectionListPresentationLogic {
    
    func presentCollectionList(with response: CollectionListModels.GetCollectionList.Response)
    func presentCollectionDetails()
    
}

class CollectionListPresenter {
    
    // MARK: - Public Variables
    
    weak var viewController: CollectionListDisplayLogic?
    
}

// MARK: - CollectionListPresentationLogic

extension CollectionListPresenter: CollectionListPresentationLogic {
    
    func presentCollectionList(with response: CollectionListModels.GetCollectionList.Response) {
        let cellViewModels = response.collectionList.map { collection in
            CollectionListCollectionViewCell.ViewModel(id: collection.id,
                                                       titleText: collection.title,
                                                       subtitleText: collection.principalOrFirstMaker,
                                                       imageUrl: collection.webImage?.url)
        }
        let footerViewModel = getFooterViewModel(with: response.err)
        let viewModel = CollectionListModels.GetCollectionList.ViewModel(cellViewModels: cellViewModels,
                                                                         footerViewModel: footerViewModel)
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayCollectionList(with: viewModel)
        }
    }
    
    func presentCollectionDetails() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayCollectionDetails()
        }
    }
    
}

// MARK: - Private Helpers

private extension CollectionListPresenter {
    
    func getFooterViewModel(with err: Error?) -> LabelCollectionReusableView.ViewModel? {
        guard let err = err else { return nil }
        
        return .init(text: err.localizedDescription,
                     textColor: .red,
                     textAlignment: .center,
                     font: .systemFont(ofSize: 18, weight: .semibold),
                     bgColor: .clear)
    }
    
}
