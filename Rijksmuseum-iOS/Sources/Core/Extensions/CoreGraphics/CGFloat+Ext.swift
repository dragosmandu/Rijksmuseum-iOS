//
//  CGFloat+Ext.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/15/22.
//

import CoreGraphics

extension CGFloat {
    
    static let padding = Padding()
    
    struct Padding {
        private static let unit: CGFloat = 4
        
        let margin = unit * 4
        
        let xSmall = unit
        let small = unit * 2
        let medium = unit * 3
        let large = unit * 4
        let xLarge = unit * 5
        let xxLarge = unit * 6
        
        fileprivate init() { }
    }
    
}
