//
//  Vehicle.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

// swiftlint:disable nesting

struct VehicleQueryResponse: Codable {
  let vehicle: Vehicle

  enum CodingKeys: String, CodingKey {
    case vehicle = "Vehicle"
  }
}

/// Metadata describing a vehicle in the Star Wars universe.
struct Vehicle: Codable {

  /// Metadata describing a Star Wars film featuring a vehicle.
  struct Film: Codable, Hashable {

    /// The film's title, (e.g., "A New Hope")
    let title: String

    /// A unique ID string
    let filmId: String

    enum CodingKeys: String, CodingKey {
      case title
      case filmId = "id"
    }
  }

  /// Metadata describing a person who pilots a vehicle.
  struct Pilot: Codable, Hashable {

    /// The name of the pilot (e.g., "Chewbacca")
    let name: String

    /// A unique ID string
    let pilotId: String

    enum CodingKeys: String, CodingKey {
      case name
      case pilotId = "id"
    }
  }

  /// The maximum amount of cargo this vehicle is capable of carrying, in kilograms
  let cargo: Int?

  /// The class of this vehicle (e.g., "Repulsorcraft")
  let vehicleClass: String

  /// The maximum time this vehicle can provide consumables for its entire crew without having to resupply.
  let consumables: String?

  /// The cost of this vehjicle in galactic credits.
  let cost: Int?

  /// The number of people needed to operate or pilot this vehicle.
  let crew: Int

  /// An array of Star Wars films that feature this vehicle.
  let films: [Film]

  /// A unique ID string
  let vehicleId: String

  /// The length of tis vehicle in meters.
  let length: Float?

  /// The manufacturer(s) of this vehicle (e.g., "Corellia Mining Corporation")
  let manufacturer: [String]?

  /// The maxumim speed of this vehicle in kph.
  let maximumSpeed: Int

  /// The vehicle's model name (e.g., "All-Terrain Attack Transport")
  let model: String

  /// The common name of this vehicle (e.g., "Sand Crawler")
  let name: String

  /// The maximum number of passengers this vehicle can carry.
  let passengers: Int?

  /// An array of people who have piloted this vehicle.
  let pilots: [Pilot]

  enum CodingKeys: String, CodingKey {
    case cargo = "cargoCapacity"
    case vehicleClass = "class"
    case consumables
    case cost = "costInCredits"
    case crew
    case films
    case vehicleId = "id"
    case length
    case manufacturer
    case maximumSpeed = "maxAtmospheringSpeed"
    case model
    case name
    case passengers
    case pilots
  }
}
