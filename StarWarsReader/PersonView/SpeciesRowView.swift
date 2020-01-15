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

  var name: String {
    species.name
  }

  var speciesViewModel: SpeciesViewModel {
    SpeciesViewModel(resourceId: species.speciesId)
  }
}

struct SpeciesRowView: View {

  let viewModel: SpeciesRowViewModel

  var body: some View {
    NavigationLink(destination: SpeciesView(viewModel: viewModel.speciesViewModel)) {
      Text(viewModel.name)
    }
  }
}

// swiftlint:disable all
struct SpeciesRowView_Previews: PreviewProvider {
  static let vm: SpeciesRowViewModel = {
    let luke = loadSamplePerson("luke")
    return SpeciesRowViewModel(species: luke.species.first!)
  }()

  static var previews: some View {
    SpeciesRowView(viewModel: vm)
  }
}
