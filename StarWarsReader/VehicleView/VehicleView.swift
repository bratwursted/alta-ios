//
//  VehicleView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct VehicleView: View {

  @ObservedObject var viewModel: VehicleViewModel

  var body: some View {
    List {
      if viewModel.vehicle == nil {
        Text("No result")
      } else {
        nameSection
        capacitySection
        speedSection
        filmsSection
        pilotsSection
      }
    }
    .navigationBarTitle(Text(viewModel.viewTitle), displayMode: .inline)
    .onAppear {
      self.viewModel.loadVehicle()
    }
  }
}

extension VehicleView {

  var nameSection: some View {
    Section {
      VStack(alignment: .leading, spacing: 12) {
        Text(verbatim: viewModel.name)
        Text(verbatim: "Manufacturer: \(viewModel.manufacturer)")
        Text(verbatim: "Class: \(viewModel.classification)")
        Text(verbatim: "Model: \(viewModel.model)")
        Text(verbatim: "Cost: \(viewModel.cost)")
      }
    }
  }

  var capacitySection: some View {
    Section(header: Text("Size & Capacity")) {
      VStack(alignment: .leading, spacing: 12) {
        Text(verbatim: "Length: \(viewModel.length)")
        Text(verbatim: "Crew: \(viewModel.crew)")
        Text(verbatim: "Passengers: \(viewModel.passengers)")
        Text(verbatim: "Cargo: \(viewModel.cargo)")
        Text(verbatim: "Consumables: \(viewModel.consumables)")
      }
    }
  }

  var speedSection: some View {
    Section(header: Text("Speed")) {
      Text(verbatim: "Max. speed: \(viewModel.maximumSpeed)")
    }
  }

  var filmsSection: some View {
    Section(header: Text("Appears in")) {
      if viewModel.films.isEmpty {
        Text("No results")
      } else {
        ForEach(viewModel.films, id: \.self) { film in
          VehicleFilmRowView(viewModel: self.viewModel.rowViewModel(forFilm: film))
        }
      }
    }
  }

  var pilotsSection: some View {
    Section(header: Text("Pilots")) {
      if viewModel.pilots.isEmpty {
        Text("No results")
      } else {
        ForEach(viewModel.pilots, id: \.self) { pilot in
          VehiclePilotRowView(viewModel: self.viewModel.rowViewModel(forPilot: pilot))
        }
      }
    }
  }
}

extension VehicleView {
  static var mock: VehicleView {
    let airspeeder = loadSampleVehicle("airspeeder")
    let mockData = MockDataService(airspeeder)
    let viewModel = VehicleViewModel(
      resourceId: airspeeder.vehicleId,
      dataService: mockData
    )
    return VehicleView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct VehicleView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      VehicleView.mock
    }
  }
}
