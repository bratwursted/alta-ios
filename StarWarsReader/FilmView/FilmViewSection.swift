//
//  FilmViewSection.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

enum FilmViewSection {
  case characters
  case planets
  case species
  case starships
  case vehicles

  enum HeaderTitle: String {
    case characters = "Characters"
    case planets = "Planets"
    case species = "Species"
    case starships = "Starships"
    case vehicles = "Vehicles"
  }

  var title: String {
    switch self {
    case .characters:
      return HeaderTitle.characters.rawValue
    case .planets:
      return HeaderTitle.planets.rawValue
    case .species:
      return HeaderTitle.species.rawValue
    case .starships:
      return HeaderTitle.starships.rawValue
    case .vehicles:
      return HeaderTitle.vehicles.rawValue
    }
  }

  var destination: NavigationDestination {
    switch self {
    case .characters:
      return .characters
    case .planets:
      return .planets
    case .species:
      return .species
    case .starships:
      return .starships
    case .vehicles:
      return .vehicles
    }
  }
}
