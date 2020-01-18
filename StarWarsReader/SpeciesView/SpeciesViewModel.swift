//
//  SpeciesViewModel.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

typealias SpeciesFilmViewProvider = (Species.Film) -> FilmView

typealias SpeciesPersonViewProvider = (Species.Person) -> PersonView

final class SpeciesViewModel: ObservableObject {

  private let speciesId: String

  private let dataService: Swapi

  private var disposables = Set<AnyCancellable>()

  private var needsfetchSpecies = true

  private let speciesFilmViewProvider: SpeciesFilmViewProvider

  private let speciesPersonViewProvider: SpeciesPersonViewProvider

  @Published var species: Species?

  var people: [Species.Person] = []

  var films: [Species.Film] = []

  init(
    resourceId: String,
    speciesFilmViewProvider: @escaping SpeciesFilmViewProvider,
    speciesPersonViewProvider: @escaping SpeciesPersonViewProvider,
    dataService: Swapi = SwapiService()
  ) {
    speciesId = resourceId
    self.speciesFilmViewProvider = speciesFilmViewProvider
    self.speciesPersonViewProvider = speciesPersonViewProvider
    self.dataService = dataService
  }

  func loadSpecies() {
    guard needsfetchSpecies else { return }
    dataService.species(with: speciesId)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        self.needsfetchSpecies = false
        switch completion {
        case .failure(let error):
          print("There was an error getting the species \(self.speciesId): \(error)")
          self.species = nil
        case .finished:
          break
        }
      }, receiveValue: { species in
        self.species = species
        self.people = species.people
        self.films = species.films
      })
    .store(in: &disposables)
  }

  var viewTitle: String {
    species?.name ?? ""
  }

  var name: String {
    species?.name ?? String.valueNotAvailable
  }

  var speciesDescription: String {
    var description = ""
    if let designation = species?.designation {
      description = "\(designation.localizedCapitalized) "
    }
    if let classification = species?.classification {
      description += classification.localizedCapitalized
    }
    return description.isEmpty ? String.valueNotAvailable : description
  }

  var language: String {
    guard let speciesLanguage = species?.language else {
      return String.valueNotAvailable
    }
    return speciesLanguage.localizedCapitalized
  }

  var height: String {
    guard let heightCm = species?.height else {
      return String.valueNotAvailable
    }
    let heightMeters = Float(heightCm) / 100
    return "\(heightMeters) m."
  }

  var lifespan: String {
    guard let speciesLifespan = species?.lifespan else {
      return String.valueNotAvailable
    }
    return "\(speciesLifespan) standard yrs."
  }

  var hair: String {
    guard let hairColors = species?.hairColor else {
      return String.valueNotAvailable
    }
    return hairColors.map { $0.rawValue.localizedCapitalized }.joined(separator: ", ")
  }

  var eyes: String {
    guard let eyeColors = species?.eyeColor else {
      return String.valueNotAvailable
    }
    return eyeColors.map { $0.rawValue.localizedCapitalized }.joined(separator: ", ")
  }

  var skin: String {
    guard let skinTones = species?.skinColor else {
      return String.valueNotAvailable
    }
    return skinTones.map { $0.rawValue.localizedCapitalized }.joined(separator: ", ")
  }

  func rowViewModel(forPerson person: Species.Person) -> SpeciesPersonRowViewModel {
    SpeciesPersonRowViewModel(person: person, personView: speciesPersonViewProvider(person))
  }

  func rowViewModel(forFilm film: Species.Film) -> SpeciesFilmRowViewModel {
    SpeciesFilmRowViewModel(film: film, filmView: speciesFilmViewProvider(film))
  }
}
