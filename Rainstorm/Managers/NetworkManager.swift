//
//  NetworkManager.swift
//  Rainstorm
//
//  Created by Bart Jacobs on 13/12/2018.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import Foundation

class NetworkManager: NetworkService {
    
    // MARK: - Network Service
    
    func fetchData(with url: URL, completionHandler: @escaping NetworkService.FetchDataCompletion) {
        URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
    }
    
}
