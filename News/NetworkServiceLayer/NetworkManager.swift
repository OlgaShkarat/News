//
//  NetworkManager.swift
//  News
//
//  Created by Ольга on 04.03.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol  {
    func fetchNews(source: NewsSource, completion: @escaping (NewsAll?) -> ())
}


class NetworkManager: NetworkManagerProtocol {
    
    struct Constants {
        static let baseURL = URL(string: "http://newsapi.org/v2/top-headlines?")!
        static let apiKey = "121e0b11918f4962a697e1dfafb54a2a"
        
        
        
        struct Keys {
            static let apiKey = "apiKey"
            static let source = "sources"
        }
    }
    
    let urlSession: URLSession
    init() {
        let config = URLSessionConfiguration.default
        urlSession = URLSession(configuration: config)
    }
    
    
    func fetchNews(source: NewsSource, completion: @escaping (NewsAll?) -> ()) {
        
        let url = Constants.baseURL
        var components = URLComponents(string: url.absoluteString)
        components?.queryItems = [
            URLQueryItem(name: Constants.Keys.apiKey, value:Constants.apiKey),
            URLQueryItem(name: Constants.Keys.source, value: source.rawValue)
        ]
        
        guard let currentURL =  components?.url else { fatalError("Can't  create url") }
        
    
        let task = urlSession.dataTask(with: currentURL) { (data, _, error) in
            guard let jsonData = data else {
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            
            do {
                let parseData = try jsonDecoder.decode(NewsAll.self, from: jsonData)
                completion(parseData)
            } catch let error {
                print("Can't parsed data news \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }
}
