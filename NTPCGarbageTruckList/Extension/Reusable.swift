//
//  Reusable.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/20.
//

import Foundation

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
