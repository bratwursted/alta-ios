//
//  FilmParsingTests.swift
//  StarWarsReaderTests
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import XCTest
@testable import Star_Wars_Reader

class FilmParsingTests: XCTestCase {

  var sut: [FilmsResponse.Film]?

  override func setUp() {
    sut = sampleFilms
  }

  override func tearDown() {
    sut = nil
  }

  func testParsingAllFilms() {
    XCTAssertNotNil(sut)
    XCTAssertEqual(sut?.count, 7)
    XCTAssertEqual(sut?[0].title, "The Phantom Menace")
    XCTAssertEqual(sut?[1].episode, 2)
  }
}
