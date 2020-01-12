//
//  Data.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/11/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

func sampleFilms() -> [FilmsResponse.Film] {
  let response: SwapiResponse<FilmsResponse> = load("allFilms")
  return response.data.allFilms
}

func load<T: Decodable>(_ name: String) -> T {
  guard let fileUrl = Bundle.main.url(forResource: name, withExtension: "json") else {
    fatalError("Expected to find data file \(name)")
  }

  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .iso8601

  do {
    let data = try Data(contentsOf: fileUrl)
    return try decoder.decode(T.self, from: data)
  } catch {
    fatalError("There was an error parsing the file \(name): \(error)")
  }

}
