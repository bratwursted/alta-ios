//
//  VehiclesResponse.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

// swiftlint:disable nesting

/// Describes a response from `allVehicles` query.
struct VehiclesResponse: Codable {

  /// Metadat  describing a vehicle returned by the `allVehicles` query.
  struct Vehicle: Codable {

    /// The name of this vehicle (e.g., "Sand Crawler")
    let name: String

    /// A unique ID string
    let vehicleId: String

    enum CodingKeys: String, CodingKey {
      case name
      case vehicleId = "id"
    }
  }

  let allVehicles: [Vehicle]?
}
