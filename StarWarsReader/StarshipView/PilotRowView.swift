//
//  PilotRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct PilotRowViewModel {

  let pilot: Starship.Pilot

  let pilotView: PersonView

  var name: String {
    pilot.name
  }
}

struct PilotRowView: View {

  let viewModel: PilotRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.pilotView) {
      Text(viewModel.name)
    }
  }
}

extension PilotRowView {
  static var mock: PilotRowView {
    let starshipPilot = loadSampleStarship(.falcon).pilots[0]
    let viewModel = PilotRowViewModel(pilot: starshipPilot, pilotView: PersonView.mock)
    return PilotRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct PilotRowView_Previews: PreviewProvider {
  static var previews: some View {
    PilotRowView.mock
  }
}
