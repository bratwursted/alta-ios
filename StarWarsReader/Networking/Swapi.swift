//
//  Swapi.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

enum SwapiError: Error {
  case badRequest
  case networkingError(error: NetworkError)
  case parsingError(error: Error)
  case unknown
}

protocol Swapi {
  func allFilms() -> AnyPublisher<[FilmsResponse.Film], SwapiError>
  func film(withId filmId: String) -> AnyPublisher<Film, SwapiError>
}

struct SwapiService: Swapi {

  private let datafetcher = DataFetcher()

  func allFilms() -> AnyPublisher<[FilmsResponse.Film], SwapiError> {
    let query = SwapiQuery("AllFilmsQuery")
    let queryResponse: AnyPublisher<SwapiResponse<FilmsResponse>, SwapiError> = resource(query: query)
    return queryResponse
      .map { response in
        response.data.allFilms
    }
    .eraseToAnyPublisher()
  }

  func film(withId filmId: String) -> AnyPublisher<Film, SwapiError> {
    let query = SwapiQuery("FilmQuery", resourceId: filmId)
    let queryResponse: AnyPublisher<SwapiResponse<FilmQueryResponse>, SwapiError> = resource(query: query)
    return queryResponse
      .map { response in
        response.data.film
    }
    .eraseToAnyPublisher()
  }

  private func resource<T: Decodable>(query: SwapiQuery) -> AnyPublisher<T, SwapiError> {
    guard let request = query.urlRequest else {
      return Fail(error: SwapiError.badRequest).eraseToAnyPublisher()
    }
    return datafetcher.fetch(request)
      .mapError { networkError in
        SwapiError.networkingError(error: networkError)
    }
    .flatMap(maxPublishers: .max(1)) { data in
      decode(data)
    }
    .map({ (response) -> T in
      response.self
    })
      .eraseToAnyPublisher()
  }
}

struct MockDataService<T: Decodable>: Swapi {

  private let data: T

  init(_ data: T) {
    self.data = data
  }

  func allFilms() -> AnyPublisher<[FilmsResponse.Film], SwapiError> {
    guard let filmsData = data as? [FilmsResponse.Film] else {
      fatalError("Expected mock data service to be initialized with type `[FilmsResponse.Film]`")
    }
    return Result.Publisher(filmsData).eraseToAnyPublisher()
  }

  func film(withId filmId: String) -> AnyPublisher<Film, SwapiError> {
    guard let filmData = data as? Film else {
      fatalError("Expected mock data service to be initialized with type `Film`")
    }
    return Result.Publisher(filmData).eraseToAnyPublisher()
  }
}
