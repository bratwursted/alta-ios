//
//  FilmVehicleRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct FilmVehicleRowViewModel {

  let vehicle: Film.Vehicle

  let vehicleView: VehicleView

  var name: String {
    vehicle.name
  }
}

struct FilmVehicleRowView: View {

  let viewModel: FilmVehicleRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.vehicleView) {
      Text(viewModel.name)
    }
  }
}

extension FilmVehicleRowView {
  static var mock: FilmVehicleRowView {
    let filmVehicle = loadSampleFilm(.newHope).vehicles[0]
    let viewModel = FilmVehicleRowViewModel(vehicle: filmVehicle, vehicleView: VehicleView.mock)
    return FilmVehicleRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct FilmVehicleRowView_Previews: PreviewProvider {
  static var previews: some View {
    FilmVehicleRowView.mock
  }
}
