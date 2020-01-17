//
//  FlowCoordinator.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/16/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct FlowCoordinator {

  func makeKeyAndVisible(_ window: UIWindow) {
    let filmsList = makeFilmsList()
    window.rootViewController = UIHostingController(rootView: filmsList)
    window.makeKeyAndVisible()
  }

  private func makeFilmsList() -> FilmsListView {
    let viewModel = FilmsListViewModel(filmViewInitializer: { film in
      self.makeFilmView(with: film.filmId)
    })
    return FilmsListView(viewModel: viewModel)
  }

  private func makeFilmView(with filmId: String) -> FilmView {
    let viewModel = FilmViewModel(
      filmId: filmId,
      characterViewInitializer: { character in
        self.makePersonView(with: character.characterId)
        },
      characterList: { characters in
        self.makeCharacterListView(characters: characters)
      },
      planetView: { planet in
        self.makePlanetView(with: planet.planetId)
      },
      filmPlanetList: { planets in
        self.makePlanetsListView(planets: planets)
      },
      speciesView: { species in
        self.makeSpeciesView(with: species.speciesId)
      },
      filmSpeciesList: { species in
        self.makeSpeciesListView(species: species)
      },
      starshipView: { starship in
        self.makeStarshipView(with: starship.starshipId)
      },
      filmStarshipList: { starships in
        self.makeStarshipListView(starships: starships)
      },
      vehicleView: { vehicle in
        self.makeVehicleView(with: vehicle.vehicleId)
      },
      filmVehicleList: { vehicles in
        self.makeVehicleListView(vehicles: vehicles)
      }
    )
    return FilmView(viewModel: viewModel)
  }

  private func makeCharacterListView(characters: [Film.Character]) -> CharacterListView {
    let viewModel = CharacterListViewModel(
      characters: characters,
      characterViewInitializer: { character in
        self.makePersonView(with: character.characterId)
      }
    )
    return CharacterListView(viewModel: viewModel)
  }

  private func makePlanetsListView(planets: [Film.Planet]) -> FilmPlanetListView {
    let viewModel = FilmPlanetListViewModel(
      planets: planets,
      planetView: { planet in
        self.makePlanetView(with: planet.planetId)
      }
    )
    return FilmPlanetListView(viewModel: viewModel)
  }

  private func makeSpeciesListView(species: [Film.Species]) -> FilmSpeciesListView {
    let viewModel = FilmSpeciesListViewModel(
      species: species,
      speciesView: { species in
      self.makeSpeciesView(with: species.speciesId)
    })
    return FilmSpeciesListView(viewModel: viewModel)
  }

  private func makeStarshipListView(starships: [Film.Starship]) -> FilmStarshipListView {
    let viewModel = FilmStarshipListViewModel(
      starships: starships,
      filmStarshipView: { starship in
        self.makeStarshipView(with: starship.starshipId)
    })
    return FilmStarshipListView(viewModel: viewModel)
  }

  private func makeVehicleListView(vehicles: [Film.Vehicle]) -> FilmVehicleListView {
    let viewModel = FilmVehicleListViewModel(
      vehicles: vehicles,
      vehicleView: { vehicle in
        self.makeVehicleView(with: vehicle.vehicleId)
    })
    return FilmVehicleListView(viewModel: viewModel)
  }

  private func makePersonView(with resourceId: String) -> PersonView {
    let viewModel = PersonViewModel(
      resourceId: resourceId,
      homeworldView: { planet in
        guard let planet = planet else { return nil }
        return self.makePlanetView(with: planet.planetId)
      },
      speciesView: { species in
        self.makeSpeciesView(with: species.speciesId)
      },
      filmView: { film in
        self.makeFilmView(with: film.filmId)
      },
      starshipView: { starship in
        self.makeStarshipView(with: starship.starshipId)
      },
      vehicleView: { vehicle in
        self.makeVehicleView(with: vehicle.vehicleId)
    })
    return PersonView(viewModel: viewModel)
  }

  private func makePlanetView(with resourceId: String) -> PlanetView {
    let viewModel = PlanetViewModel(
      planetId: resourceId,
      planetFilmView: { film in
        self.makeFilmView(with: film.filmId)
      },
      residentView: { resident in
        self.makePersonView(with: resident.residentId)
    })
    return PlanetView(viewModel: viewModel)
  }

  private func makeSpeciesView(with resourceId: String) -> SpeciesView {
    let viewModel = SpeciesViewModel(
      resourceId: resourceId,
      filmView: { film in
        self.makeFilmView(with: film.filmId)
      },
      personView: { person in
        self.makePersonView(with: person.personId)
    })
    return SpeciesView(viewModel: viewModel)
  }

  private func makeStarshipView(with resourceId: String) -> StarshipView {
    let viewModel = StarshipViewModel(
      resourceId: resourceId,
      pilotView: { pilot in
        self.makePersonView(with: pilot.pilotId)
      },
      filmView: { film in
        self.makeFilmView(with: film.filmId)
    })
    return StarshipView(viewModel: viewModel)
  }

  private func makeVehicleView(with resourceId: String) -> VehicleView {
    let viewModel = VehicleViewModel(resourceId: resourceId)
    return VehicleView(viewModel: viewModel)
  }
}
