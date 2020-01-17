//
//  ResidentRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct ResidentRowViewModel {

  let resident: Planet.Resident

  var name: String {
    resident.name
  }

  var personViewModel: PersonViewModel {
    // TODO: refactor mock value 
    PersonViewModel(
      resourceId: resident.residentId,
      homeworldView: { _ in PlanetView.mock },
      speciesView: { _ in SpeciesView.mock }
    )
  }
}

struct ResidentRowView: View {

  let viewModel: ResidentRowViewModel

  var body: some View {
    Text(viewModel.name)
  }
}

// swiftlint:disable all
struct ResidentRowView_Previews: PreviewProvider {
  static let vm: ResidentRowViewModel = {
    let tatooine = loadSamplePlanet(.tatooine)
    return ResidentRowViewModel(resident: tatooine.residents.first!)
  }()

  static var previews: some View {
    ResidentRowView(viewModel: vm)
  }
}
