//
//  WeekViewModel.swift
//  Rainstorm
//
//  Created by Bart Jacobs on 16/07/2018.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import Foundation

struct WeekViewModel {
    
    // MARK: - Properties
    
    let weatherData: [ForecastWeatherConditions]
    
    // MARK: -
    
    var numberOfDays: Int {
        return weatherData.count
    }
    
    // MARK: - Methods
    
    func viewModel(for index: Int) -> WeekDayViewModel {
        return WeekDayViewModel(weatherData: weatherData[index])
    }
    
}
