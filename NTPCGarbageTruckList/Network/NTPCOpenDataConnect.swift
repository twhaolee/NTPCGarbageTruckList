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

    private func getDatas<T: Codable & JsonProtocol>(apiPath: String,
                                                     queryItems: [URLQueryItem],
                                                     completionHandler: @escaping ([T]?, Error?) -> Void) {
        var url = self.serverUrl.appendingPathComponent(apiPath)

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = queryItems

        url = components.url ?? url

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let taskCompletionHandler = { (data: Data?, response: URLResponse?, error: Error?) in

        }

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                taskCompletionHandler(data, response, error)
            }
        })

        task.resume()
    }
}
