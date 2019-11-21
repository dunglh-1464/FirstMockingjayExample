//
//  LocationService.swift
//  Rainstorm
//
//  Created by Bart Jacobs on 12/10/2018.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import Foundation

enum LocationServiceError: Error {
    case notAuthorizedToRequestLocation
}

enum LocationServiceResult {
    case success(Location)
    case failure(LocationServiceError)
}

protocol LocationService {
    
    // MARK: - Type Aliases
    
    typealias FetchLocationCompletion = (LocationServiceResult) -> Void
    
    // MARK: - Methods
    
    func fetchLocation(completion: @escaping FetchLocationCompletion)
    
}
