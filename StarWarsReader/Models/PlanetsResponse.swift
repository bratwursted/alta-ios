//
//  PlanetsResponse.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

/// Describes a response for a `allPlanets` query. 
struct PlanetsResponse: Codable {

  struct Planet: Codable {
    let name: String
    let planetId: String

    enum CodingKeys: String, CodingKey {
      case name
      case planetId = "id"
    }
  }

  let allPlanets: [Planet]?
}
