//
//  PlanetViewModel.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

typealias PlanetFilmViewProvider = (Planet.Film) -> FilmView

typealias ResidentViewProvider = (Planet.Resident) -> PersonView

final class PlanetViewModel: ObservableObject {

  private let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.locale = Locale.current
    formatter.numberStyle = .decimal
    return formatter
  }()

  private let planetId: String

  private let dataService: Swapi

  private var disposables = Set<AnyCancellable>()

  private var needsPlanetContent = true

  private let planetFilmViewProvider: PlanetFilmViewProvider

  private let residentViewProvider: ResidentViewProvider

  @Published var planet: Planet?

  var residents: [Planet.Resident] = []

  var films: [Planet.Film] = []

  init(
    planetId: String,
    planetFilmViewProvider: @escaping PlanetFilmViewProvider,
    residentViewProvider: @escaping ResidentViewProvider,
    dataService: Swapi = SwapiService()
  ) {
    self.planetId = planetId
    self.planetFilmViewProvider = planetFilmViewProvider
    self.residentViewProvider = residentViewProvider
    self.dataService = dataService
  }

  func loadPlanet() {
    guard needsPlanetContent else { return }
    dataService.planet(with: planetId)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        self.needsPlanetContent = false
        switch completion {
        case .failure(let error):
          print("Error loading planet \(self.planetId): \(error)")
          self.planet = nil
        case .finished:
          break
        }
      }, receiveValue: { planet in
        self.planet = planet
        self.films = planet.films
        self.residents = planet.residents
      })
    .store(in: &disposables)
  }

  var viewTitle: String {
    planet?.name ?? ""
  }

  var name: String {
    planet?.name ?? String.valueNotAvailable
  }

  var climate: String {
    guard let climates = planet?.climate else {
      return String.valueNotAvailable
    }
    return climates.joined(separator: ", ").localizedCapitalized
  }

  var terrain: String {
    guard let terrains = planet?.terrain else {
      return String.valueNotAvailable
    }
    return terrains.joined(separator: ", ").localizedCapitalized
  }

  var diameter: String {
    guard let planetDiameter = planet?.diameter,
      let formattedDiameter = formatter.string(from: NSNumber(value: planetDiameter)) else {
      return String.valueNotAvailable
    }
    return formattedDiameter
  }

  var gravity: String {
    planet?.gravity ?? String.valueNotAvailable
  }

  var orbit: String {
    guard let period = planet?.orbitalPeriod else {
      return String.valueNotAvailable
    }
    return String(period)
  }

  var rotation: String {
    guard let period = planet?.rotationPeriod else {
      return String.valueNotAvailable
    }
    return String(period)
  }

  var population: String {
    guard let planetPopulation = planet?.population,
      let formattedPopulation = formatter.string(from: NSNumber(value: Double(planetPopulation))) else {
      return String.valueNotAvailable
    }
    return formattedPopulation
  }

  var surfaceWater: String {
    guard let waterArea = planet?.surfaceWater else {
      return String.valueNotAvailable
    }
    return "\(String(waterArea))%"
  }

  func rowViewModel(forFilm film: Planet.Film) -> PlanetFilmRowViewModel {
    PlanetFilmRowViewModel(film: film, filmView: planetFilmViewProvider(film))
  }

  func rowViewModel(forResident resident: Planet.Resident) -> ResidentRowViewModel {
    ResidentRowViewModel(resident: resident, residentView: residentViewProvider(resident))
  }

}
