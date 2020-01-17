//
//  StarshipViewModel.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

typealias PilotView = (Starship.Pilot) -> PersonView

final class StarshipViewModel: ObservableObject {

  private let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.locale = Locale.current
    formatter.numberStyle = .decimal
    return formatter
  }()

  private let starshipId: String

  private let dataService: Swapi

  private var disposables = Set<AnyCancellable>()

  private var needsStarshipData = true

  private var pilotView: PilotView

  @Published var starship: Starship?

  var films: [Starship.Film] = []

  var pilots: [Starship.Pilot] = []

  init(
    resourceId: String,
    pilotView: @escaping PilotView,
    dataService: Swapi = SwapiService()
  ) {
    starshipId = resourceId
    self.pilotView = pilotView
    self.dataService = dataService
  }

  func loadStarship() {
    guard needsStarshipData else { return }
    dataService.starship(with: starshipId)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        self.needsStarshipData = false
        switch completion {
        case .failure(let error):
          print("There was an error querying for starship \(self.starshipId): \(error)")
          self.starship = nil
        case .finished:
          break
        }
      }, receiveValue: { starship in
        self.starship = starship
        self.films = starship.films
        self.pilots = starship.pilots
      })
      .store(in: &disposables)
  }

  var viewTitle: String {
    starship?.name ?? ""
  }

  var name: String {
    starship?.name ?? String.valueNotAvailable
  }

  var classification: String {
    starship?.starshipClass.localizedCapitalized ?? String.valueNotAvailable
  }

  var manufacturer: String {
    guard let makers = starship?.manufacturer else {
      return String.valueNotAvailable
    }
    return makers.joined(separator: ", ")
  }

  var maximumSpeed: String {
    guard let topSpeed = starship?.maximumSpeed,
      let formattedSpeed = formatter.string(from: NSNumber(value: topSpeed)) else {
        return String.valueNotAvailable
    }
    return "\(formattedSpeed) kph"
  }

  var megalights: String {
    guard let mglt = starship?.megalights else {
      return String.valueNotAvailable
    }
    return "\(mglt) mglt"
  }

  var consumables: String {
    starship?.consumables ?? String.valueNotAvailable
  }

  var crew: String {
    guard let crewCapacity = starship?.crew,
      let formattedCrew = formatter.string(from: NSNumber(value: crewCapacity)) else {
        return String.valueNotAvailable
    }
    return formattedCrew
  }

  var passengers: String {
    guard let passengerCapacity = starship?.passengers,
      let formattedPassengers = formatter.string(from: NSNumber(value: passengerCapacity)) else {
        return String.valueNotAvailable
    }
    return formattedPassengers
  }

  var cost: String {
    guard let starshipCost = starship?.cost,
      let credits = formatter.string(from: NSNumber(value: starshipCost)) else {
        return String.valueNotAvailable
    }
    return "\(credits) galactic credits"
  }

  var hyperdriveClass: String {
    guard let rating = starship?.hyperdrive else {
      return String.valueNotAvailable
    }
    return "\(rating)"
  }

  var length: String {
    guard let starshipLength = starship?.length,
      let lengthMeters = formatter.string(from: NSNumber(value: starshipLength)) else {
        return String.valueNotAvailable
    }
    return "\(lengthMeters) m."
  }

  var cargo: String {
    guard let cargoCapacity = starship?.cargo,
      let cargoValue = formatter.string(from: NSNumber(value: cargoCapacity)) else {
        return String.valueNotAvailable
    }
    return "\(cargoValue) kg."
  }

  func rowViewModel(forFilm film: Starship.Film) -> StarshipFilmRowViewModel {
    StarshipFilmRowViewModel(film: film)
  }

  func rowViewModel(forPilot pilot: Starship.Pilot) -> PilotRowViewModel {
    PilotRowViewModel(pilot: pilot, pilotView: pilotView(pilot))
  }
}
