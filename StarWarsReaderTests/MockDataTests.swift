//
//  MockDataTests.swift
//  StarWarsReaderTests
//
//  Created by Joe Bramhall on 1/12/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import XCTest
import Combine
@testable import StarWarsReader

class MockDataTests: XCTestCase {

  var sut: Swapi?

  var disposables = Set<AnyCancellable>()

  override func tearDown() {
    sut = nil
  }

  func testAllFilmsMockData() {
    sut = MockDataService(sampleFilms)
    let result = sut?.allFilms()
    XCTAssertNotNil(result)

    result?.sink(receiveCompletion: { _ in
      // no ops
    }, receiveValue: { films in
      XCTAssertTrue(films.count == 7)
      XCTAssertEqual(films[0].title, "The Phantom Menace")
    })
    .store(in: &disposables)
  }

}
