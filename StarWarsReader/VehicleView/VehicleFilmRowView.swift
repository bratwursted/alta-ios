//
//  VehicleFilmRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct VehicleFilmRowViewModel {

  let film: Vehicle.Film

  var title: String {
    film.title
  }

  var filmViewModel: FilmViewModel {
    FilmViewModel(
      filmId: film.filmId,
      // TODO: factor out these mock initializers
      characterViewInitializer: { _ in PersonView.mock },
      characterList: { _ in CharacterListView.mock},
      planetView: { _ in PlanetView.mock },
      filmPlanetList: { _ in FilmPlanetListView.mock },
      speciesView: { _ in SpeciesView.mock },
      filmSpeciesList: { _ in FilmSpeciesListView.mock },
      starshipView: { _ in StarshipView.mock },
      filmStarshipList: { _ in FilmStarshipListView.mock }
    )
  }
}

struct VehicleFilmRowView: View {

  let viewModel: VehicleFilmRowViewModel

  var body: some View {
    Text(viewModel.title)
  }
}

// swiftlint:disable all
struct VehicleFilmRowView_Previews: PreviewProvider {
  static let vm: VehicleFilmRowViewModel = {
    let airspeeder = loadSampleVehicle(.airspeeder)
    return VehicleFilmRowViewModel(film: airspeeder.films.first!)
  }()

  static var previews: some View {
    VehicleFilmRowView(viewModel: vm)
  }
}
