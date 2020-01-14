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

  var name: String {
    vehicle.name
  }

  var vehicleViewModel: VehicleViewModel {
    VehicleViewModel(resourceId: vehicle.vehicleId)
  }
}

struct VehicleRowView: View {

  let viewModel: VehicleRowViewModel

  var body: some View {
    NavigationLink(destination: VehicleView(viewModel: viewModel.vehicleViewModel)) {
      Text(viewModel.name)
    }
  }
}

// swiftlint:disable all
struct VehicleRowView_Previews: PreviewProvider {
  static let vm: VehicleRowViewModel = {
    let luke = loadSamplePerson("luke")
    return VehicleRowViewModel(vehicle: luke.vehicles.first!)
  }()

  static var previews: some View {
    VehicleRowView(viewModel: vm)
  }
}
