//
//  StarshipsResponse.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

/// Describes a response for a `allStarships` query.
struct StarshipsResponse: Codable {

  /// Metadata describing a starship returned in `allStarships` query.
  struct Starship: Codable {

    /// The common name of the starship (e.g., "Millennium Falcon")
    let name: String

    /// A unique ID string
    let starshipId: String

    enum CodingKeys: String, CodingKey {
      case name
      case starshipId = "id"
    }
  }

  let allStarships: [Starship]?
}
