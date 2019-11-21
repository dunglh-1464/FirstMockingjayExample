//
//  NetworkService.swift
//  Rainstorm
//
//  Created by Bart Jacobs on 13/12/2018.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import Foundation

protocol NetworkService {
    
    // MARK: - Type Aliases
    
    typealias FetchDataCompletion = (Data?, URLResponse?, Error?) -> Void
    
    // MARK: - Methods
    
    func fetchData(with url: URL, completionHandler: @escaping FetchDataCompletion)
    
}
