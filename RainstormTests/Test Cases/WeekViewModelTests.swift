//
//  WeekViewModelTests.swift
//  RainstormTests
//
//  Created by Bart Jacobs on 19/09/2018.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Rainstorm

class WeekViewModelTests: XCTestCase {

    // MARK: - Properties
    
    var viewModel: WeekViewModel!

    // MARK: - Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
        
        // Load Stub
        let data = loadStub(name: "darksky", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()
        
        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // Initialize Dark Sky Response
        let darkSkyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
        
        // Initialize View Model
        viewModel = WeekViewModel(weatherData: darkSkyResponse.forecast)
    }
    
    override func tearDown() {
        super.tearDown()
    }


    // MARK: - Tests for Number of Days
    
    func testNumberOfDays() {
        XCTAssertEqual(viewModel.numberOfDays, 8)
    }
    
    // MARK: - Tests for View Model for Index
    
    func testViewModelForIndex() {
        let weekDayViewModel = viewModel.viewModel(for: 5)
        
        XCTAssertEqual(weekDayViewModel.day, "Sunday")
        XCTAssertEqual(weekDayViewModel.date, "September 2")
    }

}
