//
//  Swapi.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

protocol Swapi {
  func allFilms() -> AnyPublisher<Any, Error>
}
