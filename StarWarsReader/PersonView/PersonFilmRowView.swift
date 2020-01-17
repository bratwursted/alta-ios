//
//  PersonFilmRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct PersonFilmRowViewModel {

  let film: Person.Film

  var title: String {
    film.title
  }

  var filmViewModel: FilmViewModel {
    FilmViewModel(
      filmId: film.filmId,
      // TODO: factor out these mock initializers
      characterViewInitializer: { _ in PersonView.mock },
      characterList: { _ in CharacterListView.mock },
      planetView: { _ in PlanetView.mock },
      filmPlanetList: { _ in FilmPlanetListView.mock },
      speciesView: { _ in SpeciesView.mock },
      filmSpeciesList: { _ in FilmSpeciesListView.mock },
      starshipView: { _ in StarshipView.mock },
      filmStarshipList: { _ in FilmStarshipListView.mock },
      vehicleView: { _ in VehicleView.mock },
      filmVehicleList: { _ in FilmVehicleListView.mock }
    )
  }
}

struct PersonFilmRowView: View {

  let viewModel: PersonFilmRowViewModel

  var body: some View {
    Text(viewModel.title)
  }
}

// swiftlint:disable all
struct PersonFilmRowView_Previews: PreviewProvider {
  static let vm: PersonFilmRowViewModel = {
    let luke = loadSamplePerson(.luke)
    return PersonFilmRowViewModel(film: luke.films.first!)
  }()

  static var previews: some View {
    PersonFilmRowView(viewModel: vm)
  }
}
