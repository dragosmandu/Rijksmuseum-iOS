//
//  Encodable+Ext.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/16/22.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        
        return (try? JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }
    
}
