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

  let starshipView: StarshipView

  var name: String {
    starship.name
  }
}

struct StarshipRowView: View {

  let viewModel: StarshipRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.starshipView) {
      Text(viewModel.name)
    }
  }
}

extension StarshipRowView {
  static var mock: StarshipRowView {
    let personStarship = loadSamplePerson(.luke).starships[0]
    let viewModel = StarshipRowViewModel(starship: personStarship, starshipView: StarshipView.mock)
    return StarshipRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct StarshipRowView_Previews: PreviewProvider {
  static var previews: some View {
    StarshipRowView.mock
  }
}
