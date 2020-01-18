//
//  FilmSpeciesListView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct FilmSpeciesListViewModel {

  let species: [Film.Species]

  let speciesViewProvider: FilmSpeciesViewProvider

  func viewModel(for species: Film.Species) -> FilmSpeciesRowViewModel {
    FilmSpeciesRowViewModel(
      species: species,
      speciesView: speciesViewProvider(species)
    )
  }
}

struct FilmSpeciesListView: View {

  let viewModel: FilmSpeciesListViewModel

  var body: some View {
    List {
      ForEach(viewModel.species, id: \.self) { species in
        FilmSpeciesRowView(viewModel: self.viewModel.viewModel(for: species))
      }
    }
    .navigationBarTitle(Text("Species"), displayMode: .inline)
  }
}

extension FilmSpeciesListView {
  static var mock: FilmSpeciesListView {
    let filmSpecies = loadSampleFilm(.newHope).species
    let viewModel = FilmSpeciesListViewModel(
      species: filmSpecies,
      speciesViewProvider: { _ in SpeciesView.mock }
    )
    return FilmSpeciesListView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct FilmSpeciesListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FilmSpeciesListView.mock
    }
  }
}
