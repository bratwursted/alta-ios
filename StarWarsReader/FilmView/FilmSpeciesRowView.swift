//
//  FilmSpeciesRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct FilmSpeciesRowViewModel {

  let species: Film.Species

  let speciesView: SpeciesView

  var name: String {
    species.name
  }

}

struct FilmSpeciesRowView: View {

  let viewModel: FilmSpeciesRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.speciesView) {
      Text(viewModel.name)
    }
  }
}

extension FilmSpeciesRowView {
  static var mock: FilmSpeciesRowView {
    let filmSpecies = loadSampleFilm("newHope").species[0]
    let viewModel = FilmSpeciesRowViewModel(species: filmSpecies, speciesView: SpeciesView.mock)
    return FilmSpeciesRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct FilmSpeciesRowView_Previews: PreviewProvider {
  static var previews: some View {
    FilmSpeciesRowView.mock
  }
}
