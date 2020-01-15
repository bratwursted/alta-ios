//
//  VehicleParsingTests.swift
//  StarWarsReaderTests
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import XCTest
@testable import Star_Wars_Reader

class VehicleParsingTests: XCTestCase {

  var sut: Vehicle?

  override func setUp() {
    sut = loadSampleVehicle("airspeeder")
  }

  override func tearDown() {
    sut = nil
  }

  func testParsing() {
    XCTAssertNotNil(sut)
    XCTAssertEqual(sut?.name, "XJ-6 airspeeder")
  }
}
