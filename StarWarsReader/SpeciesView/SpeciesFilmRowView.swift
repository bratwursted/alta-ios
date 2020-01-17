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
    FilmViewModel(filmId: film.filmId)
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
    let twilek = loadSampleSpecies("twilek")
    return SpeciesFilmRowViewModel(film: twilek.films.first!)
  }()

  static var previews: some View {
    SpeciesFilmRowView(viewModel: vm)
  }
}
