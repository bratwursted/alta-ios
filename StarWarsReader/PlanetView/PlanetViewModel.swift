//
//  PlanetViewModel.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

final class PlanetViewModel: ObservableObject {

  private struct Strings {
    static let notAvailable = "n/a"
  }

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

  @Published var planet: Planet?

  var residents: [Planet.Resident] = []

  var films: [Planet.Film] = []

  init(
    planetId: String,
    dataService: Swapi = SwapiService()
  ) {
    self.planetId = planetId
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
    planet?.name ?? Strings.notAvailable
  }

  var climate: String {
    guard let climates = planet?.climate else {
      return "n/a"
    }
    return climates.joined(separator: ", ").localizedCapitalized
  }

  var terrain: String {
    guard let terrains = planet?.terrain else {
      return "n/a"
    }
    return terrains.joined(separator: ", ").localizedCapitalized
  }

  var diameter: String {
    guard let planetDiameter = planet?.diameter else {
      return Strings.notAvailable
    }
    return formatter.string(from: NSNumber(value: planetDiameter)) ?? Strings.notAvailable
  }

  var gravity: String {
    planet?.gravity ?? Strings.notAvailable
  }

  var orbit: String {
    guard let period = planet?.orbitalPeriod else {
      return Strings.notAvailable
    }
    return String(period)
  }

  var rotation: String {
    guard let period = planet?.rotationPeriod else {
      return Strings.notAvailable
    }
    return String(period)
  }

  var population: String {
    guard let planetPopulation = planet?.population else {
      return Strings.notAvailable
    }
    return formatter.string(from: NSNumber(value: Double(planetPopulation))) ?? Strings.notAvailable
  }

  var surfaceWater: String {
    guard let waterArea = planet?.surfaceWater else {
      return Strings.notAvailable
    }
    return "\(String(waterArea))%"
  }

  func rowViewModel(forFilm film: Planet.Film) -> PlanetFilmRowViewModel {
    PlanetFilmRowViewModel(film: film)
  }

  func rowViewModel(forResident resident: Planet.Resident) -> ResidentRowViewModel {
    ResidentRowViewModel(resident: resident)
  }

}
