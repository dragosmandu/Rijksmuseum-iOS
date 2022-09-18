//
//  RijksmuseumWorker.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/16/22.
//

import Foundation

class RijksmuseumWorker { }

extension RijksmuseumWorker {
    
    
    func getCollections(with reqDto: RijksmuseumApiDtos.GetCollections.Request) async throws -> [RijksmuseumModels.Collection] {
        let respDto = try await ApiClient.shared.getCollections(with: reqDto)
        let collectionList = respDto.collections.compactMap { dto in
            RijksmuseumModels.Collection(with: dto)
        }
        
        return collectionList
    }
    
    func getCollectionDetails(with reqDto: RijksmuseumApiDtos.GetCollectionDetails.Request) async throws -> RijksmuseumModels.CollectionDetails {
        let respDto = try await ApiClient.shared.getCollectionDetails(with: reqDto)
        
        return RijksmuseumModels.CollectionDetails(with: respDto.collectionDetails)
    }
    
}
