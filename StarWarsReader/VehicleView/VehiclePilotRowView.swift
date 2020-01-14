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

  var name: String {
    pilot.name
  }

  var pilotViewModel: PersonViewModel {
    PersonViewModel(resourceId: pilot.pilotId)
  }
}

struct VehiclePilotRowView: View {

  let viewModel: VehiclePilotRowViewModel

  var body: some View {
    NavigationLink(destination: PersonView(viewModel: viewModel.pilotViewModel)) {
      Text(viewModel.name)
    }
  }
}

// swiftlint:disable all
struct VehiclePilotRowView_Previews: PreviewProvider {
  static let vm: VehiclePilotRowViewModel = {
    let airspeeder = loadSampleVehicle("airspeeder")
    return VehiclePilotRowViewModel(pilot: airspeeder.pilots.first!)
  }()

  static var previews: some View {
    VehiclePilotRowView(viewModel: vm)
  }
}
