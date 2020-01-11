//
//  Planet.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

// swiftlint:disable nesting

/// Metadata describing a planet in the Star Wars universe.
struct Planet: Codable {

  /// Metadatdata describing a Star Wars film that features this planet.
  struct Film: Codable {

    /// The title of this film (e.g., "A New Hope").
    let title: String

    /// A unique ID `String`
    let filmId: String

    enum CodingKeys: String, CodingKey {
      case title
      case filmId = "id"
    }
  }

  /// Metadata describing a person who lives on this planet.
  struct Resident: Codable {

    /// The name of the person (e.g., "Luke Skywalker").
    let name: String

    /// A unique ID `String`
    let residentId: String

    enum CodingKeys: String, CodingKey {
      case name
      case residentId = "id"
    }
  }

  /// The climate of this planet.
  let climate: [String]

  /// The average diamtere of this planet in kilometers.
  let diameter: Int

  /// An aray of `Film` featuring this planet.
  let films: [Film]

  /// The gravity of this planet, where "1" is standard gravity.
  let gravity: String

  /// A unique ID string.
  let planetId: String

  /// The name of the planet (e.g., "Tatooine")
  let name: String

  /// The number of standard days for the planet to make one orbit of its local star.
  let orbitalPeriod: Int

  /// The average population of inhabitants for this planet.
  let population: Float

  /// An array of people associated with this planet, empty if the planet is uninhabited.
  let residents: [Resident]

  /// The number of standard hours for the planet to make one roation on it's axis.
  let rotationPeriod: Int

  /// The percentage of surface area that is naturally occuring water.
  let surfaceWater: Float

  /// The terrain of the planet.
  let terrain: [String]

  enum CodingKeys: String, CodingKey {
    case climate
    case diameter
    case films
    case gravity
    case planetId = "id"
    case name
    case orbitalPeriod
    case population
    case residents
    case rotationPeriod
    case surfaceWater
    case terrain
  }
}
