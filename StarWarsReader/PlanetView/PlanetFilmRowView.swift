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

  let filmView: FilmView

  var title: String {
    film.title
  }
}

struct PlanetFilmRowView: View {

  let viewModel: PlanetFilmRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.filmView) {
      Text(viewModel.title)
    }
  }
}

extension PlanetFilmRowView {
  static var mock: PlanetFilmRowView {
    let planetFilm = loadSamplePlanet(.tatooine).films[0]
    let viewModel = PlanetFilmRowViewModel(film: planetFilm, filmView: FilmView.mock)
    return PlanetFilmRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct PlanetFilmRowView_Previews: PreviewProvider {
  static var previews: some View {
    PlanetFilmRowView.mock
  }
}
