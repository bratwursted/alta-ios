//
//  VehicleView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct VehicleView: View {

  @ObservedObject var viewModel: VehicleViewModel

  var body: some View {
    List {
      if viewModel.vehicle == nil {
        Text("No result")
      } else {
        nameSection
        capacitySection
        speedSection
      }
    }
    .navigationBarTitle(Text(viewModel.viewTitle), displayMode: .inline)
    .onAppear {
      self.viewModel.loadVehicle()
    }
  }
}

extension VehicleView {

  var nameSection: some View {
    Section {
      VStack(alignment: .leading, spacing: 12) {
        Text(verbatim: viewModel.name)
        Text(verbatim: "Model: \(viewModel.model)")
        Text(verbatim: "Class: \(viewModel.classification)")
        Text(verbatim: "Manufacturer: \(viewModel.manufacturer)")
        Text(verbatim: "Cost: \(viewModel.cost)")
      }
    }
  }

  var capacitySection: some View {
    Section(header: Text("Size & Capacity")) {
      VStack(alignment: .leading, spacing: 12) {
        Text(verbatim: "Length: \(viewModel.length)")
        Text(verbatim: "Crew: \(viewModel.crew)")
        Text(verbatim: "Passengers: \(viewModel.passengers)")
        Text(verbatim: "Consumables: \(viewModel.consumables)")
      }
    }
  }

  var speedSection: some View {
    Section(header: Text("Speed")) {
      Text(verbatim: "Max. speed: \(viewModel.maximumSpeed)")
    }
  }
}

// swiftlint:disable all
struct VehicleView_Previews: PreviewProvider {
  static let vm: VehicleViewModel = {
    let airspeeder = loadSampleVehicle("airspeeder")
    let dataSource = MockDataService(airspeeder)
    return VehicleViewModel(
      resourceId: airspeeder.vehicleId,
      dataService: dataSource
    )
  }()

  static var previews: some View {
    NavigationView {
      VehicleView(viewModel: vm)
    }
  }
}
