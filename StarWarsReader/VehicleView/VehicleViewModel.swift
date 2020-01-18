//
//  VehicleViewModel.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

typealias VehicleFilmViewProvider = (Vehicle.Film) -> FilmView

typealias VehiclePilotViewProvider = (Vehicle.Pilot) -> PersonView

final class VehicleViewModel: ObservableObject {

  private let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.locale = Locale.current
    formatter.numberStyle = .decimal
    return formatter
  }()

  private let vehicleId: String

  private let dataService: Swapi

  private var disposables = Set<AnyCancellable>()

  private let vehicleFilmViewProvider: VehicleFilmViewProvider

  private let vehiclePilotViewProvider: VehiclePilotViewProvider

  private var needsVehicleData = true

  @Published var vehicle: Vehicle?

  var films: [Vehicle.Film] = []

  var pilots: [Vehicle.Pilot] = []

  init(
    resourceId: String,
    vehicleFilmViewProvider: @escaping VehicleFilmViewProvider,
    vehiclePilotViewProvider: @escaping VehiclePilotViewProvider,
    dataService: Swapi = SwapiService()
  ) {
    vehicleId = resourceId
    self.vehicleFilmViewProvider = vehicleFilmViewProvider
    self.vehiclePilotViewProvider = vehiclePilotViewProvider
    self.dataService = dataService
  }

  func loadVehicle() {
    guard needsVehicleData else { return }
    dataService.vehicle(with: vehicleId)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        self.needsVehicleData = false
        switch completion {
        case .failure(let error):
          print("There was an error getting the vehicle \(self.vehicleId): \(error)")
          self.vehicle = nil
        case .finished:
          break
        }
      }, receiveValue: { vehicle in
        self.vehicle = vehicle
        self.films = vehicle.films
        self.pilots = vehicle.pilots
      })
    .store(in: &disposables)
  }

  var viewTitle: String {
    vehicle?.name ?? ""
  }

  var name: String {
    vehicle?.name ?? String.valueNotAvailable
  }

  var model: String {
    vehicle?.model.localizedCapitalized ?? String.valueNotAvailable
  }

  var manufacturer: String {
    guard let makers = vehicle?.manufacturer else {
      return String.valueNotAvailable
    }
    return makers.joined(separator: ", ")
  }

  var classification: String {
    vehicle?.vehicleClass.localizedCapitalized ?? String.valueNotAvailable
  }

  var consumables: String {
    vehicle?.consumables ?? String.valueNotAvailable
  }

  var maximumSpeed: String {
    guard let maxSpeed = vehicle?.maximumSpeed,
      let formattedSpeed = formatter.string(from: NSNumber(value: maxSpeed)) else {
        return String.valueNotAvailable
    }
    return "\(formattedSpeed) kph"
  }

  var passengers: String {
    guard let passengersValue = vehicle?.passengers,
      let passengerCapacity = formatter.string(from: NSNumber(value: passengersValue)) else {
        return String.valueNotAvailable
    }
    return passengerCapacity
  }

  var crew: String {
    guard let crewValue = vehicle?.crew,
      let crewCapacity = formatter.string(from: NSNumber(value: crewValue)) else {
        return String.valueNotAvailable
    }
    return crewCapacity
  }

  var cost: String {
    guard let vehicleCost = vehicle?.cost,
      let credits = formatter.string(from: NSNumber(value: vehicleCost)) else {
        return String.valueNotAvailable
    }
    return "\(credits) galactic credits"
  }

  var length: String {
    guard let vehicleLength = vehicle?.length,
      let lengthMeters = formatter.string(from: NSNumber(value: vehicleLength)) else {
        return String.valueNotAvailable
    }
    return "\(lengthMeters) m."
  }

  var cargo: String {
    guard let vehicleCargo = vehicle?.cargo,
      let cargoCapacity = formatter.string(from: NSNumber(value: vehicleCargo)) else {
        return String.valueNotAvailable
    }
    return "\(cargoCapacity) kg."
  }

  func rowViewModel(forFilm film: Vehicle.Film) -> VehicleFilmRowViewModel {
    VehicleFilmRowViewModel(film: film, filmView: vehicleFilmViewProvider(film))
  }

  func rowViewModel(forPilot pilot: Vehicle.Pilot) -> VehiclePilotRowViewModel {
    VehiclePilotRowViewModel(pilot: pilot, pilotView: vehiclePilotViewProvider(pilot))
  }
}
