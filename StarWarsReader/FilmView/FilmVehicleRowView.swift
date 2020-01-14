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

  var name: String {
    vehicle.name
  }

  var vehicleViewModel: VehicleViewModel {
    VehicleViewModel(resourceId: vehicle.vehicleId)
  }
}

struct FilmVehicleRowView: View {

  let viewModel: FilmVehicleRowViewModel

  var body: some View {
    NavigationLink(destination: VehicleView(viewModel: viewModel.vehicleViewModel)) {
      Text(viewModel.name)
    }
  }
}

// swiftlint:disable all
struct FilmVehicleRowView_Previews: PreviewProvider {
  static let vm: FilmVehicleRowViewModel = {
    let newHope = loadSampleFilm("newHope")
    return FilmVehicleRowViewModel(vehicle: newHope.vehicles.first!)
  }()
  
  static var previews: some View {
    FilmVehicleRowView(viewModel: vm)
  }
}
