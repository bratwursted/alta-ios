//
//  StarshipFilmRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct StarshipFilmRowViewModel {

  let film: Starship.Film

  let filmView: FilmView

  var title: String {
    film.title
  }
}

struct StarshipFilmRowView: View {

  let viewModel: StarshipFilmRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.filmView) {
      Text(viewModel.title)
    }
  }
}

extension StarshipFilmRowView {
  static var mock: StarshipFilmRowView {
    let starshipFilm = loadSampleStarship(.falcon).films[0]
    let viewModel = StarshipFilmRowViewModel(film: starshipFilm, filmView: FilmView.mock)
    return StarshipFilmRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct StarshipFilmRowView_Previews: PreviewProvider {
  static var previews: some View {
    StarshipFilmRowView.mock
  }
}
