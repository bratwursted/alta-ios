//
//  HomeworldRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct HomeworldRowViewModel {

  let homeworld: Person.Planet?

  let planetView: PlanetView?

  var name: String {
    homeworld?.name ?? "n/a"
  }
}

struct HomeworldRowView: View {
  let viewModel: HomeworldRowViewModel

  var body: some View {
    Group {
      if viewModel.planetView == nil {
        Text(viewModel.name)
      } else {
        NavigationLink(destination: viewModel.planetView!) {
          Text(viewModel.name)
        }
      }
    }
  }
}

extension HomeworldRowView {
  static var mock: HomeworldRowView {
    let homeworld = loadSamplePerson(.luke).homeworld
    let viewModel = HomeworldRowViewModel(homeworld: homeworld, planetView: PlanetView.mock)
    return HomeworldRowView(viewModel: viewModel)
  }
}

// swiftlint:disable type_name
struct HomeworldRowView_Previews: PreviewProvider {
  static var previews: some View {
    HomeworldRowView.mock
  }
}
