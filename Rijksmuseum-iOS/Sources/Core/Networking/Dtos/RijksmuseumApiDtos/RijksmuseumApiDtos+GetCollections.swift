//
//  RijksmuseumApiDtos+GetCollections.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/18/22.
//

import Foundation

extension RijksmuseumApiDtos {
    
    struct Collection: Decodable {
        let links: Links?
        let id: String
        let objectNumber: String
        let title: String
        let hasImage: Bool?
        let principalOrFirstMaker: String?
        let longTitle: String?
        let showImage: Bool?
        let permitDownload: Bool?
        let webImage: ImageInfo?
        let headerImage: ImageInfo?
        let productionPlaces: [String]
    }
    
    struct GetCollections {
        struct Request: Encodable {
            enum CodingKeys: String, CodingKey {
                case involvedMaker
                case page = "p"
                case pageSize = "ps"
            }
            
            let culture: Culture
            let involvedMaker: String?
            let page: Int
            let pageSize: Int
        }
        
        struct Response: Decodable {
            enum CodingKeys: String, CodingKey {
                case elapsedMilliseconds
                case count
                case collections = "artObjects"
            }
            
            let elapsedMilliseconds: Double?
            let count: Int?
            let collections: [Collection]
        }
    }
    
}
