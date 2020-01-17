//
//  SpeciesPersonRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct SpeciesPersonRowViewModel {

  let person: Species.Person

  let personView: PersonView

  var name: String {
    person.name
  }
}

struct SpeciesPersonRowView: View {

  let viewModel: SpeciesPersonRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.personView) {
      Text(viewModel.name)
    }
  }
}

extension SpeciesPersonRowView {
  static var mock: SpeciesPersonRowView {
    let speciesPerson = loadSampleSpecies(.twilek).people[0]
    let viewModel = SpeciesPersonRowViewModel(person: speciesPerson, personView: PersonView.mock)
    return SpeciesPersonRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct SpeciesPersonRowView_Previews: PreviewProvider {
  static var previews: some View {
    SpeciesPersonRowView.mock
  }
}
