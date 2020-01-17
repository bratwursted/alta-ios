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

  var name: String {
    pilot.name
  }

  var personViewModel: PersonViewModel {
    // TODO: refactor mock value 
    PersonViewModel(
      resourceId: pilot.pilotId,
      homeworldView: { _ in PlanetView.mock },
      speciesView: { _ in SpeciesView.mock }
    )
  }
}

struct PilotRowView: View {

  let viewModel: PilotRowViewModel

  var body: some View {
    Text(viewModel.name)
  }
}

// swiftlint:disable all
struct PilotRowView_Previews: PreviewProvider {
  static let vm: PilotRowViewModel = {
    let falcon = loadSampleStarship(.falcon)
    return PilotRowViewModel(pilot: falcon.pilots.first!)
  }()

  static var previews: some View {
    PilotRowView(viewModel: vm)
  }
}
