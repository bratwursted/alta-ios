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

  let filmView: FilmView

  var title: String {
    film.title
  }
}

struct PersonFilmRowView: View {

  let viewModel: PersonFilmRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.filmView) {
      Text(viewModel.title)
    }
  }
}

extension PersonFilmRowView {
  static var mock: PersonFilmRowView {
    let personFilm = loadSamplePerson(.luke).films[0]
    let viewModel = PersonFilmRowViewModel(film: personFilm, filmView: FilmView.mock)
    return PersonFilmRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct PersonFilmRowView_Previews: PreviewProvider {
  static var previews: some View {
    PersonFilmRowView.mock
  }
}
