//
//  CatsApiTests.swift
//  CatsApiTests
//
//  Created by Dream Store on 26.10.2021.
//

import XCTest
@testable import CatsApi

class CatsApiTests: XCTestCase {
    
    var sut: URLSession!
    let url = URL(string: "https://api.thecatapi.com/v1/image/test")!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    
    func testApiCall_WhenCorrectURL_ShoudReturn_HTTPStatusCode200() throws {
        
        let urlString =
        "https://api.thecatapi.com/v1/images/search?limit=10"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sut.dataTask(with: url) { _, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    
    func testApiCall_WhenInCorrectURL_ShoudReturn_NoSuccess() throws {
        
        let urlString =
        "https://api.thecatapi.com/v1"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Status code: 404")
        
        let dataTask = sut.dataTask(with: url) { _, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode != 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    
    
}
