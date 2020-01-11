//
//  Starship.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

// swiftlint:disable nesting

/// Metadata describing a starship in the Star Wars universe.
struct Starship: Codable {

  /// Metadata describing a film that features a `Starship`.
  struct Film: Codable {

    /// The title of this film (e.g., "A New Hope")
    let title: String

    /// A unique ID string.
    let filmId: String

    enum CodingKeys: String, CodingKey {
      case title
      case filmId = "id"
    }
  }

  /// Metadata desribing a person who pilots a `Starship`
  struct Pilot: Codable {

    /// The name of this pilot (e.g., "Han Solo")
    let name: String

    /// A unique ID string.
    let pilotId: String

    enum CodingKeys: String, CodingKey {
      case name
      case pilotId = "id"
    }
  }

  /// The cargo capacity of this starship, in kilograms
  let cargo: Float

  /// The class of this starship (e.g., "Deep Space Mobile Battlestation")
  let starshipClass: String

  /// The amount of time this starship can provide consumables for its entire crew without having to resupply.
  let consumables: String

  /// The cost of this starship in Galactic credits.
  let cost: Float

  /// The number of people needed to operate or pilot this starship.
  let crew: Int

  /// An array of `Film` featureing this starship.
  let films: [Film]

  /// The class of hyperdrive for this starship.
  let hyperdrive: Float

  /// A unique ID string.
  let starshipId: String

  /// The starship's length in meters.
  let length: Float

  /// The manufacturer(s) of this starship (e.g., "Corellian Engineering Corporation")
  let manufacturer: [String]

  /// The maximum speed of this starship while in atmospheric flight in kph. Null if the starship is incapable of atmosperic flight.
  let maximumSpeed: Int?

  /// The number of megalights this starship can travel in a standard hour.
  let megalights: Int

  /// The common name of this starship (e.g., "Millennium Falcon")
  let name: String

  /// The maximum number of passengers this starship is capable of carrying.
  let passengers: Int

  /// An array of people who have piloted this starship. 
  let pilots: [Pilot]

  enum CodingKeys: String, CodingKey {
    case cargo = "cargoCapacity"
    case starshipClass = "class"
    case consumables
    case cost = "costInCredits"
    case crew
    case films
    case hyperdrive = "hyperdriveRating"
    case starshipId = "id"
    case length
    case manufacturer
    case maximumSpeed = "maxAtmospheringSpeed"
    case megalights = "mglt"
    case name
    case passengers
    case pilots
  }
}
