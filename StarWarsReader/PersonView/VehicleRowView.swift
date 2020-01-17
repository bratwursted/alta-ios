//
//  VehicleRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct VehicleRowViewModel {

  let vehicle: Person.Vehicle

  let vehicleView: VehicleView

  var name: String {
    vehicle.name
  }
}

struct VehicleRowView: View {

  let viewModel: VehicleRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.vehicleView) {
      Text(viewModel.name)
    }
  }
}

extension VehicleRowView {
  static var mock: VehicleRowView {
    let personVehicle = loadSamplePerson(.luke).vehicles[0]
    let viewModel = VehicleRowViewModel(vehicle: personVehicle, vehicleView: VehicleView.mock)
    return VehicleRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct VehicleRowView_Previews: PreviewProvider {
  static var previews: some View {
    VehicleRowView.mock
  }
}
