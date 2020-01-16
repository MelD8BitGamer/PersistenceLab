//
//  NetworkHelperTest.swift
//  NetworkHelperTest
//
//  Created by Melinda Diaz on 1/16/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import XCTest
@testable import PersistanceLab //this import MUST be the same name as your project so it can be used anywhere in the code


final class NetworkHelperTests: XCTestCase {
  func testNetworkHelper() {
    let exp = XCTestExpectation(description: "fetched data")
    let url = URL(string: "https://itunes.apple.com/search?media=podcast&limit=200&term=swift")!
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure(let appError):
        XCTFail("failed to fetch data with error: \(appError)")
      case .success(let data):
        XCTAssertGreaterThan(data.count, 200_000)
        exp.fulfill()
      }
    }
    
    wait(for: [exp], timeout: 5.0)
  }
  
  func testAppError() {
    XCTAssertEqual(AppError.noData.description, "no data returned from web api")
  }
  
  static var allTests = [
    ("testNetworkHelper", testNetworkHelper),
    ("testAppError", testAppError)
  ]
}
