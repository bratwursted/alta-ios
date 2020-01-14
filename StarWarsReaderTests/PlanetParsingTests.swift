//
//  PlanetParsingTests.swift
//  StarWarsReaderTests
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import XCTest
@testable import StarWarsReader

class PlanetParsingTests: XCTestCase {

  var sut: Planet?

  override func setUp() {
    sut = loadSamplePlanet("tatooine")
  }

  override func tearDown() {
    sut = nil
  }

  func testPlanetParsing() {
    XCTAssertNotNil(sut)
    XCTAssertEqual(sut?.name, "Tatooine")
  }
}
