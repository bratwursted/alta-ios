//
//  VehiclePilotRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct VehiclePilotRowViewModel {

  let pilot: Vehicle.Pilot

  let pilotView: PersonView

  var name: String {
    pilot.name
  }
}

struct VehiclePilotRowView: View {

  let viewModel: VehiclePilotRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.pilotView) {
      Text(viewModel.name)
    }
  }
}

extension VehiclePilotRowView {
  static var mock: VehiclePilotRowView {
    let pilot = loadSampleVehicle(.airspeeder).pilots[0]
    let viewModel = VehiclePilotRowViewModel(pilot: pilot, pilotView: PersonView.mock)
    return VehiclePilotRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct VehiclePilotRowView_Previews: PreviewProvider {
  static var previews: some View {
    VehiclePilotRowView.mock
  }
}
