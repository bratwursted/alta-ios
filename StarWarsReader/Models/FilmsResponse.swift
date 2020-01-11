//
//  FilmsResponse.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

// swiftlint:disable nesting

/// The response object from an `allFilms` query.
struct FilmsResponse: Codable {

  /// Metadata describing some basic information for a Star Wars film.
  struct Film: Codable {

    /// The film's title (e.g., "A New Hope")
    let title: String

    /// The film's spisode number.
    let episode: Int

    /// A unique ID `String`.
    let filmId: String

    /// The film's release date.
    let releaseDate: Date

    enum CodingKeys: String, CodingKey {
      case episode = "episodeId"
      case filmId = "id"
      case releaseDate
      case title
    }
  }

  /// The `FilmItem` array returned from the service.
  let allFilms: [Film]
}
