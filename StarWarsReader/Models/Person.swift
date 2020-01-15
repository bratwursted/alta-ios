//
//  Person.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

// swiftlint:disable nesting

struct PersonQueryResponse: Codable {
  let person: Person

  enum CodingKeys: String, CodingKey {
    case person = "Person"
  }
}

/// Metadata describing a person in the Star Wars universe.
struct Person: Codable {

  /// An enumeration of different eye colors that occur in the Star Wars universe.
  enum EyeColor: String, Codable {
    case UNKNOWN
    case BLUE
    case YELLOW
    case RED
    case BROWN
    case BLUEGREY
    case BLACK
    case ORANGE
    case HAZEL
    case PINK
    case GOLD
    case GREEN
    case WHITE
    case DARK
  }

  /// An enumeration of diffrent genders that occur in the Star Wars universe.
  enum Gender: String, Codable {
    case UNKNOWN
    case MALE
    case FEMALE
    case HERMAPHRODITE
  }

  /// An enumeration of diffrent hair colors that occur in the Star Wars universe.
  enum HairColor: String, Codable {
    case AUBURN
    case BLACK
    case BLONDE
    case BROWN
    case GREY
    case UNKNOWN
    case WHITE
  }

  /// An enumeration of diffrent skin colors and skin tones that occur in the Star Wars universe.
  enum SkinColor: String, Codable {
    case UNKNOWN
    case FAIR
    case GOLD
    case WHITE
    case LIGHT
    case GREEN
    case GREENTAN
    case PALE
    case METAL
    case DARK
    case BROWNMOTTLE
    case BROWN
    case GREY
    case MOTTLEDGREEN
    case ORANGE
    case BLUE
    case RED
    case YELLOW
    case TAN
    case SILVER
  }

  /// Metadata describing a film that person appears in.
  struct Film: Codable, Hashable {

    /// The title of the film (e.g., "A New Hope").
    let title: String

    /// A unique ID `String`.
    let filmId: String

    enum CodingKeys: String, CodingKey {
      case title
      case filmId = "id"
    }
  }

  /// Metadat describing a planet associated with a person.
  struct Planet: Codable {

    /// The name of the planet (e.g., "Tatooine")
    let name: String

    /// A unique ID `String`.
    let planetId: String

    enum CodingKeys: String, CodingKey {
      case name
      case planetId = "id"
    }
  }

  /// Metadat describing a species associated with a person.
  struct Species: Codable, Hashable {

    /// The name of the species (e.g., "Wookie")
    let name: String

    /// A unique ID `String`
    let speciesId: String

    enum CodingKeys: String, CodingKey {
      case name
      case speciesId = "id"
    }
  }

  /// Metadat describing a starship associated with a person.
  struct Starship: Codable, Hashable {

    /// The name of the starship (e.g., "Millennium Falcon")
    let name: String

    /// A unique ID `String`
    let starshipId: String

    enum CodingKeys: String, CodingKey {
      case name
      case starshipId = "id"
    }
  }

  /// Metadat describing a vehicle associated with a person.
  struct Vehicle: Codable, Hashable {

    /// The name of the vehicle (e.g., "Snowspeeder")
    let name: String

    /// A unique ID `String`
    let vehicleId: String

    enum CodingKeys: String, CodingKey {
      case name
      case vehicleId = "id"
    }
  }

  /// The year the person was born, expressed as "BBY" (Before the Battle of Yavin) or "ABY" (After the Battle of Yavin).
  let birthYear: String?

  /// The person's `EyeColor`
  let eyeColor: [EyeColor]?

  /// The person's `Gender`.
  let gender: Gender?

  /// The person's `HairColor`.
  let hairColor: [HairColor]?

  /// The person's height in centimeters
  let height: Int?

  /// The `Planet` the person was born on .
  let homeworld: Planet?

  /// an array of `Film` featuring this person.
  let films: [Film]

  /// A unique ID `String`.
  let personId: String

  /// The mass of the person in kilograms.
  let mass: Float?

  /// The person's name.
  let name: String

  /// The person's `SkinColor`.
  let skinColor: [SkinColor]?

  /// The person's `Species`
  let species: [Species]

  /// An array of `Starship` piloted by this person.
  let starships: [Starship]

  /// An array of `Vehicle` piloted by this person.
  let vehicles: [Vehicle]

  enum CodingKeys: String, CodingKey {
    case birthYear
    case eyeColor
    case gender
    case hairColor
    case height
    case homeworld
    case films
    case personId = "id"
    case mass
    case name
    case skinColor
    case species
    case starships
    case vehicles
  }
}
