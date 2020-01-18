//
//  PersonViewModel.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

typealias PersonHomeworldViewProvider = (Person.Planet?) -> PlanetView?

typealias PersonSpeciesViewProvider = (Person.Species) -> SpeciesView

typealias PersonFilmViewProvider = (Person.Film) -> FilmView

typealias PersonStarshipViewProvider = (Person.Starship) -> StarshipView

typealias PersonVehicleViewProvider = (Person.Vehicle) -> VehicleView

final class PersonViewModel: ObservableObject {

  private let personId: String

  private let dataService: Swapi

  private var disposables = Set<AnyCancellable>()

  private var needsPersonContent = true

  private let personHomeworldViewProvider: PersonHomeworldViewProvider

  private let personSpeciesViewProvider: PersonSpeciesViewProvider

  private let personFilmViewProvider: PersonFilmViewProvider

  private let personStarshipViewProvider: PersonStarshipViewProvider

  private let personVehicleViewProvider: PersonVehicleViewProvider

  @Published var person: Person?

  var films: [Person.Film] = []

  var species: [Person.Species] = []

  var starships: [Person.Starship] = []

  var vehicles: [Person.Vehicle] = []

  init(
    resourceId: String,
    personHomeworldViewProvider: @escaping PersonHomeworldViewProvider,
    personSpeciesViewProvider: @escaping PersonSpeciesViewProvider,
    personFilmViewProvider: @escaping PersonFilmViewProvider,
    personStarshipViewProvider: @escaping PersonStarshipViewProvider,
    personVehicleViewProvider: @escaping PersonVehicleViewProvider,
    dataService: Swapi = SwapiService()
  ) {
    personId = resourceId
    self.personHomeworldViewProvider = personHomeworldViewProvider
    self.personSpeciesViewProvider = personSpeciesViewProvider
    self.personFilmViewProvider = personFilmViewProvider
    self.personStarshipViewProvider = personStarshipViewProvider
    self.personVehicleViewProvider = personVehicleViewProvider
    self.dataService = dataService
  }

  func loadPersonContent() {
    guard needsPersonContent else { return }
    dataService.person(with: personId)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        self.needsPersonContent = false
        switch completion {
        case .failure(let error):
          print("There was an error \(error)")
          self.person = nil
        case .finished:
          break
        }
      }, receiveValue: { person in
        self.person = person
        self.films = person.films
        self.species = person.species
        self.starships = person.starships
        self.vehicles = person.vehicles
      })
    .store(in: &disposables)
  }

  var viewTitle: String {
    person?.name ?? ""
  }

  var name: String? {
    person?.name
  }

  var birthYear: String {
    guard let born = person?.birthYear else {
      return String.valueNotAvailable
    }
    return born
  }

  var gender: String {
    guard let genderValue = person?.gender else {
      return String.valueNotAvailable
    }
    return genderValue.rawValue.localizedCapitalized
  }

  var height: String {
    guard let heightValue = person?.height else {
      return String.valueNotAvailable
    }
    let heightMeters = Float(heightValue) / 100
    return String(heightMeters)
  }

  var mass: String {
    String(person?.mass ?? 0)
  }

  var hair: String {
    guard let hairColors = person?.hairColor else {
      return String.valueNotAvailable
    }
    return hairColors.map { $0.rawValue.localizedLowercase }.joined(separator: ", ")
  }

  var eyes: String {
    guard let eyeColors = person?.eyeColor else {
      return String.valueNotAvailable
    }
    return eyeColors.map { $0.rawValue.localizedLowercase }.joined(separator: ", ")
  }

  var skin: String {
    guard let skinTones = person?.skinColor else {
      return String.valueNotAvailable
    }
    return skinTones.map { $0.rawValue.localizedLowercase }.joined(separator: ", ")
  }

  var homeworldViewModel: HomeworldRowViewModel {
    HomeworldRowViewModel(homeworld: person?.homeworld, planetView: personHomeworldViewProvider(person?.homeworld))
  }

  func speciesViewModel(forSpecies species: Person.Species) -> SpeciesRowViewModel {
    SpeciesRowViewModel(species: species, speciesView: personSpeciesViewProvider(species))
  }

  func starshipViewModel(forStarship starship: Person.Starship) -> StarshipRowViewModel {
    StarshipRowViewModel(starship: starship, starshipView: personStarshipViewProvider(starship))
  }

  func vehicleViewModel(forVehicle vehicle: Person.Vehicle) -> VehicleRowViewModel {
    VehicleRowViewModel(vehicle: vehicle, vehicleView: personVehicleViewProvider(vehicle))
  }

  func filmViewModel(forFilm film: Person.Film) -> PersonFilmRowViewModel {
    PersonFilmRowViewModel(film: film, filmView: personFilmViewProvider(film))
  }
}
