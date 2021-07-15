//
//  UIVIew+Extensions.swift
//  UIStudy
//
//  Created by Min on 2021/07/14.
//

import UIKit

extension UIView {
    
    func roundCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func borderColor(width: CGFloat = 1, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
}
