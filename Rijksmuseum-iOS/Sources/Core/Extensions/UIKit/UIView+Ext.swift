//
//  UIView+Ext.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/15/22.
//

import UIKit

extension UIView {
    
    func addCornerRadius(_ radius: CGFloat, maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.cornerCurve = .continuous
        layer.maskedCorners = maskedCorners
    }
    
    func addSubviews(_ subviews: [UIView]) {
        for subview in subviews {
            addSubview(subview)
        }
    }
    
}
