//
//  SpeciesViewModel.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

final class SpeciesViewModel: ObservableObject {

  private struct SpeciesStrings {
    static let notAvailable = "n/a"
  }

  private let speciesId: String

  private let dataService: Swapi

  private var disposables = Set<AnyCancellable>()

  private var needsfetchSpecies = true

  @Published var species: Species?

  var people: [Species.Person] = []

  var films: [Species.Film] = []

  init(
    resourceId: String,
    dataService: Swapi = SwapiService()
  ) {
    speciesId = resourceId
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
    species?.name ?? SpeciesStrings.notAvailable
  }

  var speciesDescription: String {
    guard let classification = species?.classification, let designation = species?.designation else {
      return SpeciesStrings.notAvailable
    }
    return "\(designation.localizedCapitalized) \(classification.localizedCapitalized)"
  }

  var language: String {
    guard let speciesLanguage = species?.language else {
      return SpeciesStrings.notAvailable
    }
    return speciesLanguage.localizedCapitalized
  }

  var height: String {
    guard let heightCm = species?.height else {
      return SpeciesStrings.notAvailable
    }
    let heightMeters = Float(heightCm) / 100
    return "\(heightMeters) m."
  }

  var lifespan: String {
    guard let speciesLifespan = species?.lifespan else {
      return SpeciesStrings.notAvailable
    }
    return "\(speciesLifespan) standard yrs."
  }

  var hair: String {
    guard let hairColors = species?.hairColor else {
      return SpeciesStrings.notAvailable
    }
    return hairColors.map { $0.rawValue.localizedCapitalized }.joined(separator: ", ")
  }

  var eyes: String {
    guard let eyeColors = species?.eyeColor else {
      return SpeciesStrings.notAvailable
    }
    return eyeColors.map { $0.rawValue.localizedCapitalized }.joined(separator: ", ")
  }

  var skin: String {
    guard let skinTones = species?.skinColor else {
      return SpeciesStrings.notAvailable
    }
    return skinTones.map { $0.rawValue.localizedCapitalized }.joined(separator: ", ")
  }

  func rowViewModel(forPerson person: Species.Person) -> SpeciesPersonRowViewModel {
    SpeciesPersonRowViewModel(person: person)
  }

  func rowViewModel(forFilm film: Species.Film) -> SpeciesFilmRowViewModel {
    SpeciesFilmRowViewModel(film: film)
  }
}
