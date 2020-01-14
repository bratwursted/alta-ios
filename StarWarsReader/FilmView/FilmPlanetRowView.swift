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

  var name: String {
    planet.name
  }
}

struct FilmPlanetRowView: View {

  let viewModel: FilmPlanetRowViewModel

  var body: some View {
    Text(viewModel.name)
  }
}

// swiftlint:disable all
struct FilmPlanetRowView_Previews: PreviewProvider {
  static let vm: FilmPlanetRowViewModel = {
    let film = loadSampleFilm("newHope")
    return FilmPlanetRowViewModel(planet: film.planets.first!)
  }()

  static var previews: some View {
    FilmPlanetRowView(viewModel: vm)
  }
}
