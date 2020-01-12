//
//  Film.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

// swiftlint:disable nesting

struct FilmQueryResponse: Codable {
  let film: Film

  enum CodingKeys: String, CodingKey {
    case film = "Film"
  }
}

/// Metadata describing a Star Wars film.
struct Film: Codable, Hashable {

  /// Metadata describing a character appearing in a `Film`.
  struct Character: Codable, Hashable {

    /// The character's name (e.g., "Luke Skywalker").
    let name: String

    /// A unique ID `String`.
    let characterId: String

    enum CodingKeys: String, CodingKey {
      case name
      case characterId = "id"
    }
  }

  /// Metadatdata describing a planet that appears in a `Film`.
  struct Planet: Codable, Hashable {

    /// The planet's name (e.g., "Tatooine").
    let name: String

    /// A unique ID `String` for the planet.
    let planetId: String

    enum CodingKeys: String, CodingKey {
      case name
      case planetId = "id"
    }
  }

  /// Metadata describing a species that appears in a `Film`.
  struct Species: Codable, Hashable {

    /// The species' name (e.g., "Wookiee")
    let name: String

    /// A unique `String` ID for the species.
    let speciesId: String

    enum CodingKeys: String, CodingKey {
      case name
      case speciesId = "id"
    }
  }

  /// Metadata describing a starship that appears in a `Film`.
  struct Starship: Codable, Hashable {

    /// The name of the starship (e.g., "Millennium Falcon")
    let name: String

    /// A unique ID `String` for the starship.
    let starshipId: String

    enum CodingKeys: String, CodingKey {
      case name
      case starshipId = "id"
    }
  }

  /// Metadata describing a vehicle that appears in a `Film`.
  struct Vehicle: Codable, Hashable {

    /// The name of the vehicle (e.g., "Sand Crawler")
    let name: String

    /// A unique ID `String`
    let vehicleId: String

    enum CodingKeys: String, CodingKey {
      case name
      case vehicleId = "id"
    }
  }

  /// An array of `FilmCharacter` who appear in the film.
  let characters: [Character]

  /// The name of the film's director (e.g., "George Lucas").
  let director: String

  /// The film's episode number.
  let episode: Int

  /// A unique ID `String` for the film.
  let filmId: String

  /// The crawl that appears at the beginning of the film (e.g., "It is a period of civil war.")
  let openingCrawl: String

  /// An array of `FilmPlanet` that appear in the film.
  let planets: [Planet]

  /// An array containing the names of the film's producers.
  let producers: [String]

  /// The film's release date.
  let releaseDate: Date

  /// An array of `FilmSpecies` that appear in the film.
  let species: [Species]

  /// An array of  `FilmStarship` that appear in the film.
  let starships: [Starship]

  /// The title of the film (e.e., "A New Hope")
  let title: String

  /// An array of `FilmVehicle` that appear in the film.
  let vehicles: [Vehicle]

  enum CodingKeys: String, CodingKey {
    case characters
    case director
    case episode = "episodeId"
    case filmId = "id"
    case openingCrawl
    case planets
    case producers
    case releaseDate
    case species
    case starships
    case title
    case vehicles
  }
}
