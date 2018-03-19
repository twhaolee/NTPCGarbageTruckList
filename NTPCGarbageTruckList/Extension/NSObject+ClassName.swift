//
//  NSObject+ClassName.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/19.
//

import Foundation

extension NSObject {
    class func className() -> String {
        return String(describing: self)
    }

    func className() -> String {
        return type(of: self).className()
    }
}
