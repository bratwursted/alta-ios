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

  func viewModel(forStarship starship: Film.Starship) -> FilmStarshipRowViewModel {
    FilmStarshipRowViewModel(starship: starship, starshipView: StarshipView.mock)
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

//swiftlint:disable all
struct FilmStarshipListView_Previews: PreviewProvider {
  static let vm: FilmStarshipListViewModel = {
    let newHope = loadSampleFilm(.newHope)
    return FilmStarshipListViewModel(starships: newHope.starships)
  }()

  static var previews: some View {
    NavigationView {
      FilmStarshipListView(viewModel: vm)
    }
  }
}
