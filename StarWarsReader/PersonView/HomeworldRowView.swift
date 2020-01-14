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

  var name: String {
    homeworld?.name ?? "n/a"
  }
}

struct HomeworldRowView: View {
  let viewModel: HomeworldRowViewModel

  var body: some View {
    Text(viewModel.name)
  }
}

// swiftlint:disable type_name identifier_name
struct HomeworldRowView_Previews: PreviewProvider {
  static let vm: HomeworldRowViewModel = {
    let luke = loadSamplePerson("luke")
    return HomeworldRowViewModel(homeworld: luke.homeworld!)
  }()

  static var previews: some View {
    HomeworldRowView(viewModel: vm)
  }
}
