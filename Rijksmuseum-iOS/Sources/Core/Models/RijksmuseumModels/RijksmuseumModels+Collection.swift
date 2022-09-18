//
//  RijksmuseumModels+Collection.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/16/22.
//

import Foundation

extension RijksmuseumModels {
    
    struct Collection {
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
        
        init(with dto: RijksmuseumApiDtos.Collection) {
            links = .init(with: dto.links)
            id = dto.id
            objectNumber = dto.objectNumber
            title = dto.title
            hasImage = dto.hasImage
            principalOrFirstMaker = dto.principalOrFirstMaker
            longTitle = dto.longTitle
            showImage = dto.showImage
            permitDownload = dto.permitDownload
            webImage = .init(with: dto.webImage)
            headerImage = .init(with: dto.headerImage)
            productionPlaces = dto.productionPlaces
        }
    }
    
}
