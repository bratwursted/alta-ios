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

  func viewModel(for species: Film.Species) -> FilmSpeciesRowViewModel {
    FilmSpeciesRowViewModel(species: species)
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

// swiftlint:disable all
struct FilmSpeciesListView_Previews: PreviewProvider {
  static let vm: FilmSpeciesListViewModel = {
    let newHope = loadSampleFilm("newHope")
    return FilmSpeciesListViewModel(species: newHope.species)
  }()

  static var previews: some View {
    NavigationView {
      FilmSpeciesListView(viewModel: vm)
    }
  }
}
