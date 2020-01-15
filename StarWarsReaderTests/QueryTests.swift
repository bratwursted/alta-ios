//
//  QueryTests.swift
//  StarWarsReaderTests
//
//  Created by Joe Bramhall on 1/12/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import XCTest
@testable import Star_Wars_Reader

class QueryTests: XCTestCase {

  var sut: SwapiQuery?

  override func tearDown() {
    sut = nil
  }

  func testAllFilmQuery() {
    sut = SwapiQuery("AllFilmsQuery")
    XCTAssertNotNil(sut?.urlRequest)
    XCTAssertNotNil(sut?.urlRequest?.httpBody)

    let body = sut?.urlRequest?.httpBody
    let queryParams = try! JSONSerialization.jsonObject(with: body!, options: []) as! [String: Any]
    let query = queryParams["query"] as! String
    XCTAssertNotNil(query)
    XCTAssertTrue(query.contains("title"))
  }
}
