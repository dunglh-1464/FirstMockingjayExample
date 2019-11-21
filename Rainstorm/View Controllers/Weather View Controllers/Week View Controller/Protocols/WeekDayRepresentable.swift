//
//  WeekDayRepresentable.swift
//  Rainstorm
//
//  Created by Bart Jacobs on 10/09/2018.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import UIKit

protocol WeekDayRepresentable {
    
    var day: String { get }
    var date: String { get }
    var temperature: String { get }
    var windSpeed: String { get }
    var image: UIImage? { get }
    
}
