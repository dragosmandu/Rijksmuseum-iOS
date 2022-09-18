//
//  RijksmuseumApiDtos.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/16/22.
//

import Foundation

struct RijksmuseumApiDtos {
    
    enum Culture: String, Encodable {
        case nl
        case en
    }
    
    struct Links: Decodable {
        let `self`: String?
        let web: String?
        let search: String?
    }
    
    struct ImageInfo: Decodable {
        let guid: String?
        let offsetPercentageX: Double?
        let offsetPercentageY: Double?
        let width: Double?
        let height: Double?
        let url: String?
    }
    
}
