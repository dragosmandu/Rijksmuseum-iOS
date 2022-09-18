//
//  RijksmuseumApiDtos+GetCollectionDetails.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/18/22.
//

import Foundation

extension RijksmuseumApiDtos {
    
    struct CollectionDetails: Decodable {
        struct Acquisition: Decodable {
            let method: String?
            let date: String?
        }
        
        let links: Links?
        let id: String
        let objectNumber: String
        let principalOrFirstMaker: String?
        let title: String
        let longTitle: String?
        let showImage: Bool?
        let webImage: ImageInfo?
        let productionPlaces: [String]
        let priref: String?
        let description: String
        let acquisition: Acquisition?
    }
    
    struct GetCollectionDetails {
        struct Request: Encodable {
            let culture: Culture
            let objectNumber: String
        }
        
        struct Response: Decodable {
            enum CodingKeys: String, CodingKey {
                case elapsedMilliseconds
                case collectionDetails = "artObject"
            }
            
            let elapsedMilliseconds: Double?
            let collectionDetails: CollectionDetails
        }
    }
    
}
