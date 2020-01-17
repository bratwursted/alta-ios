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

  let planetView: FilmPlanetViewInitializer

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

extension FilmPlanetListView {
  static var mock: FilmPlanetListView {
    let filmPlanets = loadSampleFilm(.newHope).planets
    let viewModel = FilmPlanetListViewModel(planets: filmPlanets, planetView: { _ in PlanetView.mock })
    return FilmPlanetListView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct FilmPlanetListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FilmPlanetListView.mock
    }
  }
}
