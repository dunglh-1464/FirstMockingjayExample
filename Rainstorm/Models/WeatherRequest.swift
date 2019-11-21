//
//  WeatherRequest.swift
//  Rainstorm
//
//  Created by Bart Jacobs on 14/06/2018.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import Foundation

struct WeatherRequest {
    
    // MARK: - Properties
    
    let baseUrl: URL
    
    // MARK: -
    
    let location: Location
    
    // MARK: -
    
    var latitude: Double {
        return location.latitude
    }
    
    var longitude: Double {
        return location.longitude
    }
    
    // MARK: -
    
    var url: URL {
        return baseUrl.appendingPathComponent("\(latitude),\(longitude)")
    }
    
}
