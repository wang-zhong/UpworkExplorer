//
//  NetworkManager.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/10.
//

import Foundation

class NetworkManager {
    static func loadData(url: URL, completion: @escaping ([JobPost]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let response = try? JSONDecoder().decode([JobPost].self, from: data) {
                DispatchQueue.main.async {
                    completion(response)
                }
            }
        }.resume()
    }
}
