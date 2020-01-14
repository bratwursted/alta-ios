//
//  StarshipRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct StarshipRowViewModel {

  let starship: Person.Starship

  var name: String {
    starship.name
  }
}

struct StarshipRowView: View {

  let viewModel: StarshipRowViewModel

  var body: some View {
    Text(viewModel.name)
  }
}

// swiftlint:disable all
struct StarshipRowView_Previews: PreviewProvider {
  static let vm: StarshipRowViewModel = {
    let luke = loadSamplePerson("luke")
    return StarshipRowViewModel(starship: luke.starships.first!)
  }()

  static var previews: some View {
    StarshipRowView(viewModel: vm)
  }
}
