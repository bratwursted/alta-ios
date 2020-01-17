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

  let filmView: FilmView

  var title: String {
    film.title
  }
}

struct SpeciesFilmRowView: View {

  let viewModel: SpeciesFilmRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.filmView) {
      Text(viewModel.title)
    }
  }
}

extension SpeciesFilmRowView {
  static var mock: SpeciesFilmRowView {
    let speciesFilm = loadSampleSpecies(.twilek).films[0]
    let viewModel = SpeciesFilmRowViewModel(film: speciesFilm, filmView: FilmView.mock)
    return SpeciesFilmRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct SpeciesFilmRowView_Previews: PreviewProvider {
  static var previews: some View {
    SpeciesFilmRowView.mock
  }
}
