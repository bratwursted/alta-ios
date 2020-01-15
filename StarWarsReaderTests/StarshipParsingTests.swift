//
//  StarshipParsingTests.swift
//  StarWarsReaderTests
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import XCTest
@testable import Star_Wars_Reader

class StarshipParsingTests: XCTestCase {

  var sut: Starship?

  override func setUp() {
    sut = loadSampleStarship("falcon")
  }

  override func tearDown() {
    sut = nil
  }

  func testParsing() {
    XCTAssertNotNil(sut)
    XCTAssertEqual(sut?.name, "Millennium Falcon")
  }
}
