//
//  RijksmuseumModels+CollectionDetails.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/16/22.
//

import Foundation

extension RijksmuseumModels {
    
    class CollectionDetails {
        struct Acquisition {
            let method: String?
            let date: Date?
            
            init(with dto: RijksmuseumApiDtos.CollectionDetails.Acquisition?) {
                method = dto?.method
                
                if let dateStr = dto?.date {
                    let dateFormatter = DateFormatter()
                    
                    dateFormatter.locale = Locale.current
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    date = dateFormatter.date(from: dateStr)
                } else {
                    date = nil
                }
            }
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
        
        init(with dto: RijksmuseumApiDtos.CollectionDetails) {
            links = .init(with: dto.links)
            id = dto.id
            objectNumber = dto.objectNumber
            principalOrFirstMaker = dto.principalOrFirstMaker
            title = dto.title
            longTitle = dto.longTitle
            showImage = dto.showImage
            webImage = .init(with: dto.webImage)
            productionPlaces = dto.productionPlaces
            priref = dto.priref
            description = dto.description
            acquisition = .init(with: dto.acquisition)
        }
    }
    
}
