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

  var name: String {
    person.name
  }

  var personViewModel: PersonViewModel {
    PersonViewModel(resourceId: person.personId)
  }
}

struct SpeciesPersonRowView: View {

  let viewModel: SpeciesPersonRowViewModel

  var body: some View {
    NavigationLink(destination: PersonView(viewModel: viewModel.personViewModel)) {
      Text(viewModel.name)
    }
  }
}

// swiftlint:disable all
struct SpeciesPersonRowView_Previews: PreviewProvider {
  static let vm: SpeciesPersonRowViewModel = {
    let twilek = loadSampleSpecies("twilek")
    return SpeciesPersonRowViewModel(person: twilek.people.first!)
  }()

  static var previews: some View {
    SpeciesPersonRowView(viewModel: vm)
  }
}
