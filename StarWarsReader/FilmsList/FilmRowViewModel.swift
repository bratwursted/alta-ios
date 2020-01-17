//
//  FilmRowViewModel.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/12/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

struct FilmRowViewModel {

  private let film: FilmsResponse.Film

  let filmView: FilmView

  init(
    film: FilmsResponse.Film,
    filmView: FilmView
  ) {
    self.film = film
    self.filmView = filmView
  }

  var title: String {
    film.title
  }

  var episode: String {
    film.episode.romanNumeral
  }

  var released: String {
    let calendar = Calendar.current
    let releaseYear = calendar.component(.year, from: film.releaseDate)
    return String(releaseYear)
  }

  var filmViewModel: FilmViewModel {
    FilmViewModel(filmId: film.filmId)
  }

}
