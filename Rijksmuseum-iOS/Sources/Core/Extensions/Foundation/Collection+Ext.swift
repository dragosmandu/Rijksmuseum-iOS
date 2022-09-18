//
//  Collection+Ext.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/15/22.
//

import Foundation

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
    
}
