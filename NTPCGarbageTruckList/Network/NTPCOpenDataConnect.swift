//
//  NTPCOpenDataConnect.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/19.
//

import Foundation

class NTPCOpenDataConnect: NSObject {
    static let shared = NTPCOpenDataConnect()

    let serverUrl: URL = URL(string: "http://data.ntpc.gov.tw")!
    let apiRootPaths: [String] = ["od/data/api"]
}
