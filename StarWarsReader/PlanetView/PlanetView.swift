//
//  PlanetView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct PlanetView: View {

  @ObservedObject var viewModel: PlanetViewModel

  var body: some View {
    List {
      if viewModel.planet == nil {
        Text("No result")
      } else {
        topSection
        climateTerrainSection
        sizeAndPopulationSection
        filmsSection
        residentsSection
      }
    }
    .navigationBarTitle(Text(viewModel.viewTitle), displayMode: .inline)
    .onAppear {
      self.viewModel.loadPlanet()
    }
  }
}

extension PlanetView {

  var topSection: some View {
    Section {
      VStack(alignment: .leading, spacing: 12) {
        Text(verbatim: viewModel.name)
      }
    }
  }

  var climateTerrainSection: some View {
    Section(header: Text("Climate & Terrain")) {
      VStack(alignment: .leading, spacing: 12) {
        Text("Climate: \(viewModel.climate)")
        Text("Terrain: \(viewModel.terrain)")
        Text("Surface water: \(viewModel.surfaceWater)")
      }
    }
  }

  var sizeAndPopulationSection: some View {
    Section(header: Text("Size & Population")) {
      VStack(alignment: .leading, spacing: 12) {
        Text(verbatim: "Diameter: \(viewModel.diameter) km.")
        Text(verbatim: "\(viewModel.gravity) gravity")
        Text(verbatim: "Population: \(viewModel.population)")
        Text(verbatim: "Rotational period: \(viewModel.rotation) standard hrs.")
        Text(verbatim: "Orbital period: \(viewModel.orbit) standard days")
      }
    }
  }

  var filmsSection: some View {
    Section(header: Text("Appears in")) {
      if viewModel.films.isEmpty {
        Text("No results")
      } else {
        ForEach(viewModel.films, id: \.self) { film  in
          PlanetFilmRowView(viewModel: self.viewModel.rowViewModel(forFilm: film))
        }
      }
    }
  }

  var residentsSection: some View {
    Section(header: Text("Residents")) {
      if viewModel.residents.isEmpty {
        Text("No results")
      } else {
        ForEach(viewModel.residents, id: \.self) { resident in
          ResidentRowView(viewModel: self.viewModel.rowViewModel(forResident: resident))
        }
      }
    }
  }
}

extension PlanetView {
  static var mock: PlanetView {
    let tatooine = loadSamplePlanet(.tatooine)
    let mockData = MockDataService(tatooine)
    let viewModel = PlanetViewModel(
      planetId: tatooine.planetId,
      planetFilmView: { _ in FilmView.mock },
      dataService: mockData
    )
    return PlanetView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct PlanetView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      PlanetView.mock
    }
  }
}
