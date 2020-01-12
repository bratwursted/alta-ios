//
//  FullFilmParsingTests.swift
//  StarWarsReaderTests
//
//  Created by Joe Bramhall on 1/12/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import XCTest
@testable import StarWarsReader

class FullFilmParsingTests: XCTestCase {

  var expectedResults: Film {
    let luke = Film.Character(name: "Luke Skywalker", characterId: "cj0nv9p8yewci0130wjy4o5fa")
    let tatooine = Film.Planet(name: "Tatooine", planetId: "cj0o7m3mzs1ap0172bipe927s")
    let wookie = Film.Species(name: "Wookiee", speciesId: "cj0o9opw3dwea0177u3d86jvi")
    let falcon = Film.Starship(name: "Millennium Falcon", starshipId: "cj0nwtqpzq4tt01142nh7e9i4")
    let landspeeder = Film.Vehicle(name: "X-34 landspeeder", vehicleId: "cj0o79rknibu30172b1vfxlau")
    let crawl = "It is a period of civil war."
    let producers = [
      "Gary Kurtz",
      "Rick McCallum"
    ]

    return Film(
      characters: [luke],
      director: "George Lucas",
      episode: 4,
      filmId: "cj0nxmy3fga5s01148gf8iy3c",
      openingCrawl: crawl,
      planets: [tatooine],
      producers: producers,
      releaseDate: Date(),
      species: [wookie],
      starships: [falcon],
      title: "A New Hope",
      vehicles: [landspeeder]
    )
  }

  var sut: Film?

  override func setUp() {
    sut = loadSampleFilm("newHope")
  }

  override func tearDown() {
    sut = nil
  }

  func testFilmParsing() {
    XCTAssertNotNil(sut)

    let expected = expectedResults
    XCTAssertEqual(sut?.title, expected.title)
    XCTAssertEqual(sut?.director, expected.director)
    XCTAssertEqual(sut?.producers, expected.producers)
    XCTAssertEqual(sut?.episode, expected.episode)
    XCTAssertTrue(sut?.openingCrawl.contains(expected.openingCrawl) == true)
    XCTAssertTrue(sut?.characters.contains(expected.characters[0]) == true)
    XCTAssertTrue(sut?.planets.contains(expected.planets[0]) == true)
    XCTAssertTrue(sut?.starships.contains(expected.starships[0]) == true)
    XCTAssertTrue(sut?.species.contains(expected.species[0]) == true)
    XCTAssertTrue(sut?.vehicles.contains(expected.vehicles[0]) == true)
  }
}
