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

  var name: String {
    starship.name
  }

  var starshipViewModel: StarshipViewModel {
    StarshipViewModel(resourceId: starship.starshipId)
  }
}

struct FilmStarshipRowView: View {

  let viewModel: FilmStarshipRowViewModel

  var body: some View {
    Text(viewModel.name)
  }
}

// swiftlint:disable all
struct FilmStarshipRowView_Previews: PreviewProvider {
  static let vm: FilmStarshipRowViewModel = {
    let newHope = loadSampleFilm("newHope")
    return FilmStarshipRowViewModel(starship: newHope.starships.first!)
  }()

  static var previews: some View {
    FilmStarshipRowView(viewModel: vm)
  }
}
