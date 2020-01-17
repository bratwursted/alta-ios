//
//  FilmPlanetRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct FilmPlanetRowViewModel {

  let planet: Film.Planet

  let planetView: PlanetView

  var name: String {
    planet.name
  }

  var planetViewModel: PlanetViewModel {
    PlanetViewModel(planetId: planet.planetId)
  }
}

struct FilmPlanetRowView: View {

  let viewModel: FilmPlanetRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.planetView) {
      Text(viewModel.name)
    }
  }
}

extension FilmPlanetRowView {
  static var mock: FilmPlanetRowView {
    let filmPlanet = loadSampleFilm(.newHope).planets[0]
    let viewModel = FilmPlanetRowViewModel(
      planet: filmPlanet,
      planetView: PlanetView.mock
    )
    return FilmPlanetRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct FilmPlanetRowView_Previews: PreviewProvider {
  static var previews: some View {
    FilmPlanetRowView.mock
  }
}
