//
//  PlanetFilmRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct PlanetFilmRowViewModel {

  let film: Planet.Film

  var title: String {
    film.title
  }

  var filmViewModel: FilmViewModel {
    FilmViewModel(
      filmId: film.filmId,
      // TODO: factor out these mock initializers
      characterViewInitializer: { _ in PersonView.mock },
      characterList: { _ in CharacterListView.mock }
    )
  }
}

struct PlanetFilmRowView: View {

  let viewModel: PlanetFilmRowViewModel

  var body: some View {
    Text(viewModel.title)
  }
}

// swiftlint:disable all
struct PlanetFilmRowView_Previews: PreviewProvider {
  static let vm: PlanetFilmRowViewModel = {
    let tatooine = loadSamplePlanet("tatooine")
    return PlanetFilmRowViewModel(film: tatooine.films.first!)
  }()

  static var previews: some View {
    PlanetFilmRowView(viewModel: vm)
  }
}
