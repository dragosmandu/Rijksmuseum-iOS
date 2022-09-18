//
//  RijksmuseumApi.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/16/22.
//

import Foundation
import Moya

enum RijksmuseumApi {
    
    static private let apiKey = "0fiuZFh4"
    
    case collections(reqDto: RijksmuseumApiDtos.GetCollections.Request)
    case collectionDetails(reqDto: RijksmuseumApiDtos.GetCollectionDetails.Request)
    
}

// MARK: - TargetType

extension RijksmuseumApi: TargetType {
    
    var baseURL: URL {
        URL(string: "https://www.rijksmuseum.nl/api")!
    }
    
    var path: String {
        switch self {
        case .collections(let reqDto):
            return "/\(reqDto.culture.rawValue)/collection"
            
        case .collectionDetails(let reqDto):
            return "/\(reqDto.culture.rawValue)/collection/\(reqDto.objectNumber)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .collections, .collectionDetails:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .collections(let reqDto):
            return .requestParameters(parameters: getParameters(with: reqDto),
                                      encoding: URLEncoding.queryString)
            
        case .collectionDetails(let reqDto):
            return .requestParameters(parameters: getParameters(with: reqDto),
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
}

// MARK: - Private Helpers

private extension RijksmuseumApi {
    
    func getParameters(with reqDto: Encodable) -> [String: Any] {
        ["key": Self.apiKey].merging(reqDto.dictionary) { _, reqDto in reqDto }
    }
    
}
