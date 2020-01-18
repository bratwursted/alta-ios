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
      characterViewProvider: { character in
        self.makePersonView(with: character.characterId)
        },
      characterListProvider: { characters in
        self.makeCharacterListView(characters: characters)
      },
      planetViewProvider: { planet in
        self.makePlanetView(with: planet.planetId)
      },
      filmPlanetListProvider: { planets in
        self.makePlanetsListView(planets: planets)
      },
      speciesViewProvider: { species in
        self.makeSpeciesView(with: species.speciesId)
      },
      filmSpeciesListProvider: { species in
        self.makeSpeciesListView(species: species)
      },
      starshipViewProvider: { starship in
        self.makeStarshipView(with: starship.starshipId)
      },
      filmStarshipListProvider: { starships in
        self.makeStarshipListView(starships: starships)
      },
      vehicleViewProvider: { vehicle in
        self.makeVehicleView(with: vehicle.vehicleId)
      },
      filmVehicleListProvider: { vehicles in
        self.makeVehicleListView(vehicles: vehicles)
      },
      crawlViewProvider: { film in
        self.makeCrawlView(with: film)
    })

    return FilmView(viewModel: viewModel)
  }

  private func makeCrawlView(with film: Film?) -> FilmCrawlView? {
    guard let film = film else { return nil }
    let viewModel = FilmCrawlViewModel(film: film)
    return FilmCrawlView(viewModel: viewModel)
  }

  private func makeCharacterListView(characters: [Film.Character]) -> CharacterListView {
    let viewModel = CharacterListViewModel(
      characters: characters,
      characterViewProvider: { character in
        self.makePersonView(with: character.characterId)
      }
    )
    return CharacterListView(viewModel: viewModel)
  }

  private func makePlanetsListView(planets: [Film.Planet]) -> FilmPlanetListView {
    let viewModel = FilmPlanetListViewModel(
      planets: planets,
      planetViewProvider: { planet in
        self.makePlanetView(with: planet.planetId)
      }
    )
    return FilmPlanetListView(viewModel: viewModel)
  }

  private func makeSpeciesListView(species: [Film.Species]) -> FilmSpeciesListView {
    let viewModel = FilmSpeciesListViewModel(
      species: species,
      speciesViewProvider: { species in
      self.makeSpeciesView(with: species.speciesId)
    })
    return FilmSpeciesListView(viewModel: viewModel)
  }

  private func makeStarshipListView(starships: [Film.Starship]) -> FilmStarshipListView {
    let viewModel = FilmStarshipListViewModel(
      starships: starships,
      filmStarshipViewProvider: { starship in
        self.makeStarshipView(with: starship.starshipId)
    })
    return FilmStarshipListView(viewModel: viewModel)
  }

  private func makeVehicleListView(vehicles: [Film.Vehicle]) -> FilmVehicleListView {
    let viewModel = FilmVehicleListViewModel(
      vehicles: vehicles,
      vehicleViewProvider: { vehicle in
        self.makeVehicleView(with: vehicle.vehicleId)
    })
    return FilmVehicleListView(viewModel: viewModel)
  }

  private func makePersonView(with resourceId: String) -> PersonView {
    let viewModel = PersonViewModel(
      resourceId: resourceId,
      homeworldViewProvider: { planet in
        guard let planet = planet else { return nil }
        return self.makePlanetView(with: planet.planetId)
      },
      speciesViewProvider: { species in
        self.makeSpeciesView(with: species.speciesId)
      },
      filmViewProvider: { film in
        self.makeFilmView(with: film.filmId)
      },
      starshipViewProvider: { starship in
        self.makeStarshipView(with: starship.starshipId)
      },
      vehicleViewProvider: { vehicle in
        self.makeVehicleView(with: vehicle.vehicleId)
    })
    return PersonView(viewModel: viewModel)
  }

  private func makePlanetView(with resourceId: String) -> PlanetView {
    let viewModel = PlanetViewModel(
      planetId: resourceId,
      planetFilmViewProvider: { film in
        self.makeFilmView(with: film.filmId)
      },
      residentViewProvider: { resident in
        self.makePersonView(with: resident.residentId)
    })
    return PlanetView(viewModel: viewModel)
  }

  private func makeSpeciesView(with resourceId: String) -> SpeciesView {
    let viewModel = SpeciesViewModel(
      resourceId: resourceId,
      speciesFilmViewProvider: { film in
        self.makeFilmView(with: film.filmId)
      },
      speciesPersonViewProvider: { person in
        self.makePersonView(with: person.personId)
    })
    return SpeciesView(viewModel: viewModel)
  }

  private func makeStarshipView(with resourceId: String) -> StarshipView {
    let viewModel = StarshipViewModel(
      resourceId: resourceId,
      pilotViewProvider: { pilot in
        self.makePersonView(with: pilot.pilotId)
      },
      starshipFilmViewProvider: { film in
        self.makeFilmView(with: film.filmId)
    })
    return StarshipView(viewModel: viewModel)
  }

  private func makeVehicleView(with resourceId: String) -> VehicleView {
    let viewModel = VehicleViewModel(
      resourceId: resourceId,
      filmView: { film in
        self.makeFilmView(with: film.filmId)
      },
      pilotView: { pilot in
        self.makePersonView(with: pilot.pilotId)
    })
    return VehicleView(viewModel: viewModel)
  }
}
