//
//  FilmStarshipRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct FilmStarshipRowViewModel {

  let starship: Film.Starship

  let starshipView: StarshipView

  var name: String {
    starship.name
  }
}

struct FilmStarshipRowView: View {

  let viewModel: FilmStarshipRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.starshipView) {
      Text(viewModel.name)
    }
  }
}

extension FilmStarshipRowView {
  static var mock: FilmStarshipRowView {
    let filmStarship = loadSampleFilm(.newHope).starships[0]
    let viewModel = FilmStarshipRowViewModel(starship: filmStarship, starshipView: StarshipView.mock)
    return FilmStarshipRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct FilmStarshipRowView_Previews: PreviewProvider {
  static var previews: some View {
    FilmStarshipRowView.mock
  }
}
