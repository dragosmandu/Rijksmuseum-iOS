//
//  RijksmuseumModels.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/16/22.
//

import Foundation

struct RijksmuseumModels {
    
    struct Links {
        let selfLink: URL?
        let webLink: URL?
        let searchLink: URL?
        
        init?(with dto: RijksmuseumApiDtos.Links?) {
            guard let dto = dto else { return nil }
            
            if let selfLinkStr = dto.`self` {
                selfLink = URL(string: selfLinkStr)
            } else {
                selfLink = nil
            }
            
            if let webLinkStr = dto.web {
                webLink = URL(string: webLinkStr)
            } else {
                webLink = nil
            }
            
            if let searchLinkStr = dto.search {
                searchLink = URL(string: searchLinkStr)
            } else {
                searchLink = nil
            }
        }
    }
    
    struct ImageInfo {
        let guid: String?
        let offsetPercentage: CGPoint?
        let size: CGSize?
        let url: URL?
        
        init?(with dto: RijksmuseumApiDtos.ImageInfo?) {
            guard let dto = dto else { return nil }
            
            guid = dto.guid
            
            if let urlStr = dto.url {
                url = URL(string: urlStr)
            } else {
                url = nil
            }
            
            if let offsetPercentageX = dto.offsetPercentageX,
               let offsetPercentageY = dto.offsetPercentageY {
                offsetPercentage = .init(x: offsetPercentageX,
                                         y: offsetPercentageY)
            } else {
                offsetPercentage = nil
            }
            
            if let width = dto.width, let height = dto.height {
                size = .init(width: width, height: height)
            } else {
                size = nil
            }
        }
    }
    
}
