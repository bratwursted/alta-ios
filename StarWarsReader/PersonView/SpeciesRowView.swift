//
//  SpeciesRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct SpeciesRowViewModel {
  let species: Person.Species

  let speciesView: SpeciesView

  var name: String {
    species.name
  }
}

struct SpeciesRowView: View {

  let viewModel: SpeciesRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.speciesView) {
      Text(viewModel.name)
    }
  }
}

extension SpeciesRowView {
  static var mock: SpeciesRowView {
    let personSpecies = loadSamplePerson(.luke).species[0]
    let viewModel = SpeciesRowViewModel(species: personSpecies, speciesView: SpeciesView.mock)
    return SpeciesRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct SpeciesRowView_Previews: PreviewProvider {
  static var previews: some View {
    SpeciesRowView.mock
  }
}
