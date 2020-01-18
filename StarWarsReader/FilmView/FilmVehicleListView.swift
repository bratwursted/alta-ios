//
//  FilmVehicleListView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct FilmVehicleListViewModel {

  let vehicles: [Film.Vehicle]

  let vehicleViewProvider: FilmVehicleViewProvider

  func viewModel(forVehicle vehicle: Film.Vehicle) -> FilmVehicleRowViewModel {
    FilmVehicleRowViewModel(vehicle: vehicle, vehicleView: vehicleViewProvider(vehicle))
  }
}

struct FilmVehicleListView: View {

  let viewModel: FilmVehicleListViewModel

  var body: some View {
    List {
      ForEach(viewModel.vehicles, id: \.self) { vehicle in
        FilmVehicleRowView(viewModel: self.viewModel.viewModel(forVehicle: vehicle))
      }
    }
    .navigationBarTitle(Text("Vehicles"), displayMode: .inline)
  }
}

extension FilmVehicleListView {
  static var mock: FilmVehicleListView {
    let filmVehicles = loadSampleFilm(.newHope).vehicles
    let viewModel = FilmVehicleListViewModel(
      vehicles: filmVehicles,
      vehicleViewProvider: { _ in VehicleView.mock }
    )
    return FilmVehicleListView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct FilmVehicleListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FilmVehicleListView.mock
    }
  }
}
