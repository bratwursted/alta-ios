//
//  SpeciesFilmRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct SpeciesFilmRowViewModel {

  let film: Species.Film

  var title: String {
    film.title
  }

  var filmViewModel: FilmViewModel {
    FilmViewModel(
      filmId: film.filmId,
      // TODO: factor out these mock initializers
      characterViewInitializer: { _ in PersonView.mock },
      characterList: { _ in CharacterListView.mock },
      planetView: { _ in PlanetView.mock },
      filmPlanetList: { _ in FilmPlanetListView.mock },
      speciesView: { _ in SpeciesView.mock },
      filmSpeciesList: { _ in FilmSpeciesListView.mock },
      starshipView: { _ in StarshipView.mock }
    )
  }
}

struct SpeciesFilmRowView: View {

  let viewModel: SpeciesFilmRowViewModel

  var body: some View {
    Text(viewModel.title)
  }
}

// swiftlint:disable all
struct SpeciesFilmRowView_Previews: PreviewProvider {
  static let vm: SpeciesFilmRowViewModel = {
    let twilek = loadSampleSpecies(.twilek)
    return SpeciesFilmRowViewModel(film: twilek.films.first!)
  }()

  static var previews: some View {
    SpeciesFilmRowView(viewModel: vm)
  }
}
