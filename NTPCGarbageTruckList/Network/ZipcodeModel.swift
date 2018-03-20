//
//  ZipcodeModel.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/20.
//

import Foundation

struct ZipcodeModel: Codable, JsonProtocol {
    var district: String
    var zipcode: String

    enum CodingKeys: String, CodingKey {
        case district = "District"
        case zipcode
    }
}
