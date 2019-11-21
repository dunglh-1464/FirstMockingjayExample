//
//  RootViewModelTests.swift
//  RainstormTests
//
//  Created by Bart Jacobs on 13/12/2018.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Rainstorm

class RootViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: RootViewModel!
    
    // MARK: -
    
    var networkService: MockNetworkService!
    var locationService: MockLocationService!

    // MARK: - Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
        
        // Initialize Mock Network Service
        networkService = MockNetworkService()
        
        // Configure Mock Network Service
        networkService.data = loadStub(name: "darksky", extension: "json")
        
        // Initialize Mock Location Service
        locationService = MockLocationService()

        // Initialize Root View Model
        viewModel = RootViewModel(networkService: networkService, locationService: locationService)
    }

    override func tearDown() {
        super.tearDown()
        
        // Reset User Defaults
        UserDefaults.standard.removeObject(forKey: "didFetchWeatherData")
    }

    // MARK: - Tests for Refresh
    
    func testRefresh_Success() {
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")

        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            if case .success(let weatherData) = result {
                XCTAssertEqual(weatherData.latitude, 37.8267)
                XCTAssertEqual(weatherData.longitude, -122.4233)

                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.refresh()
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefresh_FailedToFetchLocation() {
        // Configure Location Service
        locationService.location = nil
        
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, RootViewModel.WeatherDataError.notAuthorizedToRequestLocation)
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.refresh()
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
 
    func testRefresh_FailedToFetchWeatherData_RequestFailed() {
        // Configure Network Service
        networkService.error = NSError(domain: "com.cocoacasts.network.service", code: 1, userInfo: nil)

        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, RootViewModel.WeatherDataError.noWeatherDataAvailable)
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.refresh()
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefresh_FailedToFetchWeatherData_InvalidResponse() {
        // Configure Network Service
        networkService.data = "data".data(using: .utf8)

        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, RootViewModel.WeatherDataError.noWeatherDataAvailable)
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.refresh()
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefresh_FailedToFetchWeatherData_NoErrorNoResponse() {
        // Configure Network Service
        networkService.data = nil
        
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, RootViewModel.WeatherDataError.noWeatherDataAvailable)
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.refresh()
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
 
    // MARK: - Tests for Refreshing Weather Data
    
    func testApplicationWillEnterForeground_NoTimestamp() {
        // Reset User Defaults
        UserDefaults.standard.removeObject(forKey: "didFetchWeatherData")
        
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            // Fulfill Expectation
            expectation.fulfill()
        }
        
        // Post Notification
        NotificationCenter.default.post(name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testApplicationWillEnterForeground_ShouldRefresh() {
        // Reset User Defaults
        UserDefaults.standard.set(Date().addingTimeInterval(-3600.0), forKey: "didFetchWeatherData")

        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            // Fulfill Expectation
            expectation.fulfill()
        }
        
        // Post Notification
        NotificationCenter.default.post(name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testApplicationWillEnterForeground_ShouldNotRefresh() {
        // Reset User Defaults
        UserDefaults.standard.set(Date(), forKey: "didFetchWeatherData")

        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        // Configure Expectation
        expectation.isInverted = true

        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            // Fulfill Expectation
            expectation.fulfill()
        }
        
        // Post Notification
        NotificationCenter.default.post(name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
}
