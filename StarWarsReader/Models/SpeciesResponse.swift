//
//  SpeciesResponse.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

/// Describesd a response for `allSpecies` query.
struct SpeciesResponse: Codable {

  /// Metadata describing a species in the `allSpecies` query response.
  struct Species: Codable {

    /// The name of this species (e.g., "Ewok")
    let name: String

    /// A unique ID string. 
    let speciesId: String

    enum CodingKeys: String, CodingKey {
      case name
      case speciesId = "id"
    }
  }

  let allSpecies: [Species]?
}
