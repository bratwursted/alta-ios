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

  let vehicleView: FilmVehicleViewInitializer = { _ in VehicleView.mock }

  func viewModel(forVehicle vehicle: Film.Vehicle) -> FilmVehicleRowViewModel {
    FilmVehicleRowViewModel(vehicle: vehicle, vehicleView: vehicleView(vehicle))
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

// swiftlint:disable all
struct FilmVehicleListView_Previews: PreviewProvider {
  static let vm: FilmVehicleListViewModel = {
    let newHope = loadSampleFilm(.newHope)
    return FilmVehicleListViewModel(vehicles: newHope.vehicles)
  }()

  static var previews: some View {
    NavigationView {
      FilmVehicleListView(viewModel: vm)
    }
  }
}
