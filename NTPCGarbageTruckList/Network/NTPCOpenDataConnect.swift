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


    /// 取得新北市郵遞區號列表
    func getZipcodeList(completionHandler: @escaping ([ZipcodeModel]?, Error?) -> Void) {
        var apiPaths = self.apiRootPaths
        apiPaths.append(NTPCApiDataType.zipcode.rawValue)

        let apiPath = apiPaths.filter({ !$0.isEmpty }).joined(separator: "/")

        self.getDatas(apiPath: apiPath, queryItems: [], completionHandler: completionHandler)
    }

    /// 取得新北市垃圾收取點資訊
    func getGarbageStationInfoList(startIndex: UInt,
                                   limit: UInt,
                                   on city: String,
                                   completionHandler: @escaping ([GarbageStationModel]?, Error?) -> Void) {
        var apiPaths = self.apiRootPaths
        apiPaths.append(NTPCApiDataType.garbageStationInfo.rawValue)

        let apiPath = apiPaths.filter({ !$0.isEmpty }).joined(separator: "/")

        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "$top", value: "\(min(limit, 2000))"))
        queryItems.append(URLQueryItem(name: "$skip", value: "\(startIndex)"))
        queryItems.append(URLQueryItem(name: "$filter", value: "city eq \(city)"))

        self.getDatas(apiPath: apiPath, queryItems: queryItems, completionHandler: completionHandler)
    }

    private func getDatas<T: Codable & JsonProtocol>(apiPath: String,
                                                     queryItems: [URLQueryItem],
                                                     completionHandler: @escaping ([T]?, Error?) -> Void) {
        var url = self.serverUrl.appendingPathComponent(apiPath)

        var queryItems = queryItems
        queryItems.append(URLQueryItem(name: "$format", value: "json"))

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = queryItems

        url = components.url ?? url

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let taskCompletionHandler = { (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }

            guard !data.isEmpty else {
                completionHandler([], nil)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                let error = error ?? CustomError(code: -1, localizedDescription: "The response isn't HTTP response.")
                completionHandler(nil, error)
                return
            }

            guard 200..<300 ~= httpResponse.statusCode else {
                let error = CustomError(code: httpResponse.statusCode, localizedDescription: "Response is failure")
                completionHandler(nil, error)
                return
            }

            completionHandler(data.decodeToModelArray(), nil)
        }

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                taskCompletionHandler(data, response, error)
            }
        })

        task.resume()
    }
}
