//
//  Data.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

enum FilmSampleData {
  case newHope

  var fileName: String {
    switch self {
    case .newHope:
      return "newHope"
    }
  }
}

enum PersonSampleData {
  case luke

  var fileName: String {
    switch self {
    case .luke:
      return "luke"
    }
  }
}

enum PlanetSampleData {
  case tatooine

  var fileName: String {
    switch self {
    case .tatooine:
      return "tatooine"
    }
  }
}

enum SpeciesSampledata {
  case twilek

  var fileName: String {
    switch self {
    case .twilek:
      return "twilek"
    }
  }
}

enum StarshipSampleData {
  case falcon

  var fileName: String {
    switch self {
    case .falcon:
      return "falcon"
    }
  }
}

enum VehicleSampleData {
  case airspeeder

  var fileName: String {
    switch self {
    case .airspeeder:
      return "airspeeder"
    }
  }
}

var sampleFilms: [FilmsResponse.Film] {
  let response: SwapiResponse<FilmsResponse> = load("allFilms")
  return response.data.allFilms
}

func loadSampleFilm(_ sampleData: FilmSampleData) -> Film {
  let response: SwapiResponse<FilmQueryResponse> = load(sampleData.fileName)
  return response.data.film
}

func loadSamplePerson(_ sampleData: PersonSampleData) -> Person {
  let response: SwapiResponse<PersonQueryResponse> = load(sampleData.fileName)
  return response.data.person
}

func loadSamplePlanet(_ sampleData: PlanetSampleData) -> Planet {
  let response: SwapiResponse<PlanetQueryResponse> = load(sampleData.fileName)
  return response.data.planet
}

func loadSampleSpecies(_ sampleData: SpeciesSampledata) -> Species {
  let response: SwapiResponse<SpeciesQueryResponse> = load(sampleData.fileName)
  return response.data.species
}

func loadSampleStarship(_ sampleData: StarshipSampleData) -> Starship {
  let response: SwapiResponse<StarshipQueryResponse> = load(sampleData.fileName)
  return response.data.starship
}

func loadSampleVehicle(_ sampleData: VehicleSampleData) -> Vehicle {
  let response: SwapiResponse<VehicleQueryResponse> = load(sampleData.fileName)
  return response.data.vehicle
}

func load<T: Decodable>(_ name: String) -> T {
  guard let fileUrl = Bundle.main.url(forResource: name, withExtension: "json") else {
    fatalError("Expected to find data file \(name)")
  }

  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .customISO8601

  do {
    let data = try Data(contentsOf: fileUrl)
    return try decoder.decode(T.self, from: data)
  } catch {
    fatalError("There was an error parsing the file \(name): \(error)")
  }

}
