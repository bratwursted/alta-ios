//
//  SwapiResponse.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

struct SwapiResponse<T: Codable>: Codable {

  let data: T
}
