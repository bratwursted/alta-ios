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
  func person(with personId: String) -> AnyPublisher<Person, SwapiError>
  func planet(with planetId: String) -> AnyPublisher<Planet, SwapiError>
  func species(with speciesId: String) -> AnyPublisher<Species, SwapiError>
  func starship(with starshipId: String) -> AnyPublisher<Starship, SwapiError>
  func vehicle(with vehicleId: String) -> AnyPublisher<Vehicle, SwapiError>
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
    let query = SwapiQuery("SingleFilmQuery", resourceId: filmId)
    let queryResponse: AnyPublisher<SwapiResponse<FilmQueryResponse>, SwapiError> = resource(query: query)
    return queryResponse
      .map { response in
        response.data.film
    }
    .eraseToAnyPublisher()
  }

  func person(with personId: String) -> AnyPublisher<Person, SwapiError> {
    let query = SwapiQuery("SinglePersonQuery", resourceId: personId)
    let queryResponse: AnyPublisher<SwapiResponse<PersonQueryResponse>, SwapiError> = resource(query: query)
    return queryResponse
      .map { response in
        response.data.person
    }
    .eraseToAnyPublisher()
  }

  func planet(with planetId: String) -> AnyPublisher<Planet, SwapiError> {
    let query = SwapiQuery("SinglePlanetQuery", resourceId: planetId)
    let queryResponse: AnyPublisher<SwapiResponse<PlanetQueryResponse>, SwapiError> = resource(query: query)
    return queryResponse
      .map { response in
        response.data.planet
    }
    .eraseToAnyPublisher()
  }

  func species(with speciesId: String) -> AnyPublisher<Species, SwapiError> {
    let query = SwapiQuery("SingleSpeciesQuery", resourceId: speciesId)
    let queryResponse: AnyPublisher<SwapiResponse<SpeciesQueryResponse>, SwapiError> = resource(query: query)
    return queryResponse
      .map { response in
        response.data.species
    }
    .eraseToAnyPublisher()
  }

  func starship(with starshipId: String) -> AnyPublisher<Starship, SwapiError> {
    let query = SwapiQuery("SingleStarshipQuery", resourceId: starshipId)
    let queryResponse: AnyPublisher<SwapiResponse<StarshipQueryResponse>, SwapiError> = resource(query: query)
    return queryResponse
      .map { response in
        response.data.starship
    }
    .eraseToAnyPublisher()
  }

  func vehicle(with vehicleId: String) -> AnyPublisher<Vehicle, SwapiError> {
    let query = SwapiQuery("SingleVehicleQuery", resourceId: vehicleId)
    let queryResponse: AnyPublisher<SwapiResponse<VehicleQueryResponse>, SwapiError> = resource(query: query)
    return queryResponse
      .map { response in
        response.data.vehicle
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

  func person(with personId: String) -> AnyPublisher<Person, SwapiError> {
    guard let personData = data as? Person else {
      fatalError("Expected mock data service to be initialized with type `Person`")
    }
    return Result.Publisher(personData).eraseToAnyPublisher()
  }

  func planet(with planetId: String) -> AnyPublisher<Planet, SwapiError> {
    guard let planetData = data as? Planet else {
      fatalError("Expected mock data service to be initialized with type `Planet`.")
    }
    return Result.Publisher(planetData).eraseToAnyPublisher()
  }

  func species(with speciesId: String) -> AnyPublisher<Species, SwapiError> {
    guard let speciesData = data as? Species else {
      fatalError("Expected mock data service to be initialized with type `Species`")
    }
    return Result.Publisher(speciesData).eraseToAnyPublisher()
  }

  func starship(with starshipId: String) -> AnyPublisher<Starship, SwapiError> {
    guard let starshipData = data as? Starship else {
      fatalError("Expected mock data service to be initialized with type `Starship`")
    }
    return Result.Publisher(starshipData).eraseToAnyPublisher()
  }

  func vehicle(with vehicleId: String) -> AnyPublisher<Vehicle, SwapiError> {
    guard let vehicleData = data as? Vehicle else {
      fatalError("Expected mock data service to be initialized with type `Vehicle`")
    }
    return Result.Publisher(vehicleData).eraseToAnyPublisher()
  }
}
