//
//  Species.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

// swiftlint:disable nesting

struct SpeciesQueryResponse: Codable {
  let species: Species

  enum CodingKeys: String, CodingKey {
    case species = "Species"
  }
}

/// Metadata that describes a species in the Star Wars universe.
struct Species: Codable {

  /// An enumeration of eye color values.
  enum EyeColor: String, Codable {
    case AMBER
    case BLACK
    case BLUE
    case BROWN
    case GOLD
    case GREEN
    case GREY
    case HAZEL
    case INDIGO
    case ORANGE
    case PINK
    case RED
    case SILVER
    case UNKNOWN
    case YELLOW
    case GOLDEN
  }

  /// An enumeration of hair color values.
  enum HairColor: String, Codable {
    case UNKNOWN
    case BROWN
    case WHITE
    case RED
    case BLACK
    case BLONDE
  }

  /// An enumeration of skin color and skin tone values. 
  enum SkinColor: String, Codable {
    case BLUE
    case BROWN
    case CAUCASIAN
    case DARK
    case GREEN
    case GREY
    case MAGENTA
    case ORANGE
    case PALE
    case PALEPINK
    case PEACH
    case PINK
    case PURPLE
    case RED
    case TAN
    case UNKNOWN
    case WHITE
    case YELLOW
    case BLACK
    case ASIAN
    case HISPANIC
  }

  /// Metadata describing a film that featues a species.
  struct Film: Codable {
    let title: String
    let filmId: String

    enum CodingKeys: String, CodingKey {
      case title
      case filmId = "id"
    }
  }

  /// Metadata describing a person of a certain species.
  struct Person: Codable {
    let name: String
    let personId: String

    enum CodingKeys: String, CodingKey {
      case name
      case personId = "id"
    }
  }

  /// The average height in centimeters for members of this species.
  let height: Int

  /// The average lifespan in standard years for members of this species.
  let lifespan: Int

  /// The classification for this species (e.g., "mammal")
  let classification: String?

  /// The designation of this species (e.g., "sentient")
  let designation: String

  /// The eye colors typically associated with this species.
  let eyeColor: [EyeColor]?

  /// An array of films featuring tis species.
  let films: [Film]

  /// The hair colors typically associated with this species.
  let hairColor: [HairColor]?

  /// A unique ID string
  let speciesId: String

  /// The language commonly spoken by members of this species (e.g., "Shyriiwook").
  let language: String?

  /// The name of this species (e.g., "Wookie").
  let name: String

  /// Known people in the Star Wars universe who are members of this species.
  let people: [Person]

  /// The skin colors typically associated with this species.
  let skinColor: [SkinColor]

  enum CodingKeys: String, CodingKey {
    case height = "averageHeight"
    case lifespan = "averageLifespan"
    case classification
    case designation
    case eyeColor
    case films
    case hairColor
    case speciesId = "id"
    case language
    case name
    case people
    case skinColor
  }
}
