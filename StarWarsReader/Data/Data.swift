//
//  Data.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

var sampleFilms: [FilmsResponse.Film] {
  let response: SwapiResponse<FilmsResponse> = load("allFilms")
  return response.data.allFilms
}

func loadSampleFilm(_ name: String) -> Film {
  let response: SwapiResponse<FilmQueryResponse> = load(name)
  return response.data.film
}

func loadSamplePerson(_ name: String) -> Person {
  let response: SwapiResponse<PersonQueryResponse> = load(name)
  return response.data.person
}

func loadSamplePlanet(_ name: String) -> Planet {
  let response: SwapiResponse<PlanetQueryResponse> = load(name)
  return response.data.planet
}

func loadSampleSpecies(_ name: String) -> Species {
  let response: SwapiResponse<SpeciesQueryResponse> = load(name)
  return response.data.species
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
