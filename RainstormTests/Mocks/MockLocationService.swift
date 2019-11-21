//
//  MockLocationService.swift
//  RainstormTests
//
//  Created by Bart Jacobs on 13/12/2018.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import Foundation
@testable import Rainstorm

class MockLocationService: LocationService {
    
    // MARK: - Properties
    
    var location: Location? = Location(latitude: 0.0, longitude: 0.0)

    // MARK: -
    
    var delay: TimeInterval = 0.0

    // MARK: - Location Service
    
    func fetchLocation(completion: @escaping LocationService.FetchLocationCompletion) {
        // Create Result
        let result: LocationServiceResult
        
        if let location = location {
            result = .success(location)
        } else {
            result = .failure(.notAuthorizedToRequestLocation)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            // Invoke Handler
            completion(result)
        }
    }

}
