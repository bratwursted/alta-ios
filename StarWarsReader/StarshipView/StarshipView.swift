//
//  StarshipView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct StarshipView: View {

  @ObservedObject var viewModel: StarshipViewModel

  var body: some View {
    List {
      if viewModel.starship == nil {
        Text("No result")
      } else {
        primarySection
        speedAndPowerSection
        crewCapacitySection
        filmsSection
        pilotsSection
      }
    }
    .navigationBarTitle(Text(viewModel.viewTitle), displayMode: .inline)
    .onAppear {
      self.viewModel.loadStarship()
    }
  }
}

extension StarshipView {

  var primarySection: some View {
    Section {
      VStack(alignment: .leading, spacing: 12) {
        Text(verbatim: viewModel.name)
        Text(verbatim: "Manufacturer: \(viewModel.manufacturer)")
        Text(verbatim: "Cost: \(viewModel.cost)")
      }
    }
  }

  var crewCapacitySection: some View {
    Section(header: Text("Crew & Capacity")) {
      VStack(alignment: .leading, spacing: 12) {
        Text(verbatim: "Class: \(viewModel.classification)")
        Text(verbatim: "Length: \(viewModel.length)")
        Text(verbatim: "Crew: \(viewModel.crew)")
        Text(verbatim: "Passengers: \(viewModel.passengers)")
        Text(verbatim: "Cargo: \(viewModel.cargo)")
        Text(verbatim: "Consumables: \(viewModel.consumables)")
      }
    }
  }

  var speedAndPowerSection: some View {
    Section(header: Text("Speed & Power")) {
      VStack(alignment: .leading, spacing: 12) {
        Text(verbatim: "Max. air speed: \(viewModel.maximumSpeed)")
        Text(verbatim: "Megalights: \(viewModel.megalights)")
        Text(verbatim: "Hyperdrive rating: \(viewModel.hyperdriveClass)")
      }
    }
  }

  var filmsSection: some View {
    Section(header: Text("Appears in")) {
      if viewModel.films.isEmpty {
        Text("No results")
      } else {
        ForEach(viewModel.films, id: \.self) { film in
          StarshipFilmRowView(viewModel: self.viewModel.rowViewModel(forFilm: film))
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
          PilotRowView(viewModel: self.viewModel.rowViewModel(forPilot: pilot))
        }
      }
    }
  }
}

extension StarshipView {
  static var mock: StarshipView {
    let falcon = loadSampleStarship(.falcon)
    let mockData = MockDataService(falcon)
    let viewModel = StarshipViewModel(
      resourceId: falcon.starshipId,
      dataService: mockData
    )
    return StarshipView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct StarshipView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      StarshipView.mock
    }
  }
}
