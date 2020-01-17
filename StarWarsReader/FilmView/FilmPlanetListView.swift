//
//  FilmPlanetListView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct FilmPlanetListViewModel {

  let planets: [Film.Planet]

  let planetView: FilmPlanetViewInitializer = { _ in PlanetView.mock }

  func viewModel(forPlanet planet: Film.Planet) -> FilmPlanetRowViewModel {
    FilmPlanetRowViewModel(
      planet: planet,
      planetView: planetView(planet)
    )
  }

  var viewTitle: String {
    "Planets"
  }
}

struct FilmPlanetListView: View {

  let viewModel: FilmPlanetListViewModel

  var body: some View {
    List {
      ForEach(viewModel.planets, id: \.self) { planet in
        FilmPlanetRowView(viewModel: self.viewModel.viewModel(forPlanet: planet))
      }
    }
    .navigationBarTitle(Text(viewModel.viewTitle), displayMode: .inline)
  }
}

// swiftlint:disable all
struct PlanetListView_Previews: PreviewProvider {
  static let vm: FilmPlanetListViewModel = {
    let film = loadSampleFilm("newHope")
    return FilmPlanetListViewModel(planets: film.planets)
  }()

  static var previews: some View {
    NavigationView {
      FilmPlanetListView(viewModel: vm)
    }
  }
}
