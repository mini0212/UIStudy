//
//  NSObject+Extensions.swift
//  UIStudy
//
//  Created by Min on 2021/07/13.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
