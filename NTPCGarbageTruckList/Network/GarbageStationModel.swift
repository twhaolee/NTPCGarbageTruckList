//
//  GarbageStationModel.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/21.
//

import Foundation

struct GarbageStationModel: Codable, JsonProtocol {
    /// 行政區
    var city: String

    /// 清運點名稱
    var name: String

    /// 表定抵達清運時間
    var time: String
}
