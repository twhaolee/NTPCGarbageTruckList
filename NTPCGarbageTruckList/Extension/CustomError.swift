//
//  CustomError.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/20.
//

import Foundation

struct CustomError: LocalizedError {

    var title: String?
    var code: Int
    var localizedDescription: String { return self.description }

    var errorDescription: String? { return self.description }

    private var description: String

    init(title: String = "NTPCGarbageTruckListError", code: Int, localizedDescription: String) {
        self.title = title
        self.code = code
        self.description = localizedDescription
    }
}
