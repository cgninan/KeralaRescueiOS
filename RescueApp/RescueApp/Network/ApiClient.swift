//
//  ApiClient.swift
//  RescueApp
//
//  Created by Jayahari Vavachan on 8/17/18.
//  Copyright © 2018 Jayahari Vavachan. All rights reserved.
//

typealias ResourceNeeds = ([RequestModel]) -> Void

import Foundation


class ApiClient: NSObject {
    private static let instance = ApiClient()
    private let defaultSession = URLSession(configuration: .default)
    
    static var shared: ApiClient {
        return instance
    }
    
    func getResourceNeeds(completion: ResourceNeeds) {
        guard let url = URL(string: APIConstants.RESOURCE_URL) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        let dataTask = defaultSession.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let requests = try decoder.decode([RequestModel].self, from: data)
                print(requests)
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }
}