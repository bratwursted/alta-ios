//
//  NavigationDestination.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

enum NavigationDestination {
  case characters
  case planets
  case species
  case starships
  case vehicles

  var tag: Int {
    switch self {
    case .characters:
      return 1
    case .planets:
      return 2
    case .species:
      return 3
    case .starships:
      return 4
    case .vehicles:
      return 5
    }
  }

}
