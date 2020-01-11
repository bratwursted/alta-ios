//
//  PeopleResponse.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

/// Describes a response for `allPeople`.
struct PeopleResponse: Codable {

  /// Metadata describing a limited set of attributes associated with a person in the Star Wars universe.
  struct Person: Codable {

    /// The name of this person
    let name: String

    /// A unique ID `String`
    let personId: String
  }

  /// The array of `Person` returned from the data service.
  let allPeople: [Person]?
}
