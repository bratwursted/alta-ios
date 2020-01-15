//
//  SpeciesParsingTests.swift
//  StarWarsReaderTests
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import XCTest
@testable import Star_Wars_Reader

class SpeciesParsingTests: XCTestCase {

  var sut: Species?

  override func setUp() {
    sut = loadSampleSpecies("twilek")
  }

  override func tearDown() {
    sut = nil
  }

  func testParsing() {
    XCTAssertNotNil(sut)
    XCTAssertEqual(sut?.name, "Twi'lek")
  }
}
