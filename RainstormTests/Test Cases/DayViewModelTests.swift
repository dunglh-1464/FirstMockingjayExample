//
//  DayViewModelTests.swift
//  RainstormTests
//
//  Created by Bart Jacobs on 28/08/2018.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Rainstorm

class DayViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: DayViewModel!

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
        viewModel = DayViewModel(weatherData: darkSkyResponse.current)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests for Date
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "Tue, August 28 2018")
    }

    // MARK: - Tests for Time
    
    func testTime() {
        XCTAssertEqual(viewModel.time, "03:02 PM")
    }

    // MARK: - Tests for Summary
    
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Overcast")
    }
    
    // MARK: - Tests for Temperature
    
    func testTemperature() {
        XCTAssertEqual(viewModel.temperature, "57.7 °F")
    }
    
    // MARK: - Tests for Wind Speed
    
    func testWindSpeed() {
        XCTAssertEqual(viewModel.windSpeed, "5 MPH")
    }
    
    // MARK: - Tests for Image
    
    func testImage() {
        let viewModelImage = viewModel.image
        let imageDataViewModel = UIImagePNGRepresentation(viewModelImage!)!
        let imageDataReference = UIImagePNGRepresentation(UIImage(named: "cloudy")!)!
        
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage!.size.width, 45.0)
        XCTAssertEqual(viewModelImage!.size.height, 33.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }
    
}
