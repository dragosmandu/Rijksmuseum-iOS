//
//  ApiClient.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/16/22.
//

import Foundation
import Moya

actor ApiClient {
    
    static let shared = ApiClient()
    
    private let rijksmuseumApiProvider = MoyaProvider<RijksmuseumApi>()
    
    private init() { }
    
}

// MARK: - RijksmuseumApi

extension ApiClient {
    
    func getCollections(with reqDto: RijksmuseumApiDtos.GetCollections.Request) async throws -> RijksmuseumApiDtos.GetCollections.Response {
        try await withCheckedThrowingContinuation { continuation in
            rijksmuseumApiProvider.request(.collections(reqDto: reqDto)) { result in
                switch result {
                case .success(let resp):
                    do {
                        let respDto = try resp.map(RijksmuseumApiDtos.GetCollections.Response.self,
                                                   failsOnEmptyData: false)
                        
                        continuation.resume(with: .success(respDto))
                    } catch let err {
                        continuation.resume(with: .failure(err))
                    }
                    
                case .failure(let err):
                    continuation.resume(with: .failure(err))
                }
            }
        }
    }
    
    func getCollectionDetails(with reqDto: RijksmuseumApiDtos.GetCollectionDetails.Request) async throws -> RijksmuseumApiDtos.GetCollectionDetails.Response {
        try await withCheckedThrowingContinuation { continuation in
            rijksmuseumApiProvider.request(.collectionDetails(reqDto: reqDto)) { result in
                switch result {
                case .success(let resp):
                    do {
                        let respDto = try resp.map(RijksmuseumApiDtos.GetCollectionDetails.Response.self,
                                                   failsOnEmptyData: false)
                        
                        continuation.resume(with: .success(respDto))
                    } catch let err {
                        continuation.resume(with: .failure(err))
                    }
                    
                case .failure(let err):
                    continuation.resume(with: .failure(err))
                }
            }
        }
    }
    
}
