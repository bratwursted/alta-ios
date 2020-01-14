//
//  PersonFilmRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct PersonFilmRowViewModel {

  let film: Person.Film

  var title: String {
    film.title
  }

  var filmViewModel: FilmViewModel {
    FilmViewModel(filmId: film.filmId)
  }
}

struct PersonFilmRowView: View {

  let viewModel: PersonFilmRowViewModel

  var body: some View {
    NavigationLink(destination: FilmView(viewModel: viewModel.filmViewModel, navigationTag: nil)) {
      Text(viewModel.title)
    }
  }
}

// swiftlint:disable all
struct PersonFilmRowView_Previews: PreviewProvider {
  static let vm: PersonFilmRowViewModel = {
    let luke = loadSamplePerson("luke")
    return PersonFilmRowViewModel(film: luke.films.first!)
  }()

  static var previews: some View {
    PersonFilmRowView(viewModel: vm)
  }
}
