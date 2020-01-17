//
//  FilmStarshipListView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct FilmStarshipListViewModel {

  let starships: [Film.Starship]

  let filmStarshipView: FilmStarshipViewInitializer

  func viewModel(forStarship starship: Film.Starship) -> FilmStarshipRowViewModel {
    FilmStarshipRowViewModel(
      starship: starship,
      starshipView: filmStarshipView(starship)
    )
  }
}

struct FilmStarshipListView: View {

  let viewModel: FilmStarshipListViewModel

  var body: some View {
    List {
      ForEach(viewModel.starships, id: \.self) { starship in
        FilmStarshipRowView(
          viewModel: self.viewModel.viewModel(forStarship: starship)
        )
      }
    }
    .navigationBarTitle(Text("Starships"), displayMode: .inline)
  }
}

extension FilmStarshipListView {
  static var mock: FilmStarshipListView {
    let starships = loadSampleFilm(.newHope).starships
    let viewModel = FilmStarshipListViewModel(starships: starships, filmStarshipView: { _ in StarshipView.mock })
    return FilmStarshipListView(viewModel: viewModel)
  }
}

//swiftlint:disable all
struct FilmStarshipListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FilmStarshipListView.mock
    }
  }
}
