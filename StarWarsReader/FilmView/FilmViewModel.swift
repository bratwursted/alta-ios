//
//  FilmViewModel.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/12/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

typealias CharacterViewProvider = (Film.Character) -> PersonView

typealias CharacterListProvider = ([Film.Character]) -> CharacterListView

typealias FilmPlanetViewProvider = (Film.Planet) -> PlanetView

typealias FilmPlanetListProvider = ([Film.Planet]) -> FilmPlanetListView

typealias FilmSpeciesViewProvider = (Film.Species) -> SpeciesView

typealias FilmSpeciewsListProvider = ([Film.Species]) -> FilmSpeciesListView

typealias FilmStarshipViewProvider = (Film.Starship) -> StarshipView

typealias FilmStarshipListProvider = ([Film.Starship]) -> FilmStarshipListView

typealias FilmVehicleViewProvider = (Film.Vehicle) -> VehicleView

typealias FilmVehicleListProvider = ([Film.Vehicle]) -> FilmVehicleListView

typealias CrawlViewProvider = (Film?) -> FilmCrawlView?

final class FilmViewModel: ObservableObject {

  static let maximumSectionRows = 3

  private let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale.current
    formatter.dateStyle = .medium
    return formatter
  }()

  private let dataService: Swapi

  private let filmId: String

  private var disposables = Set<AnyCancellable>()

  private var needsFilmContent = true

  private let characterViewProvider: CharacterViewProvider

  private let characterListProvider: CharacterListProvider

  private let filmPlanetViewProvider: FilmPlanetViewProvider

  private let filmPlanetListProvider: FilmPlanetListProvider

  private let filmSpeciesViewProvider: FilmSpeciesViewProvider

  private let filmSpeciesListProvider: FilmSpeciewsListProvider

  private let filmStarshipViewProvider: FilmStarshipViewProvider

  private let filmStarshipListProvider: FilmStarshipListProvider

  private let filmVehicleViewProvider: FilmVehicleViewProvider

  private let filmVehicleListProvider: FilmVehicleListProvider

  private let filmCrawlViewProvider: CrawlViewProvider

  @Published var film: Film?

  var characters: [Film.Character] = []

  var planets: [Film.Planet] = []

  var species: [Film.Species] = []

  var starships: [Film.Starship] = []

  var vehicles: [Film.Vehicle] = []

  init(
    filmId: String,
    characterViewProvider: @escaping CharacterViewProvider,
    characterListProvider: @escaping CharacterListProvider,
    filmPlanetViewProvider: @escaping FilmPlanetViewProvider,
    filmPlanetListProvider: @escaping FilmPlanetListProvider,
    filmSpeciesViewProvider: @escaping FilmSpeciesViewProvider,
    filmSpeciesListProvider: @escaping FilmSpeciewsListProvider,
    filmStarshipViewProvider: @escaping FilmStarshipViewProvider,
    filmStarshipListProvider: @escaping FilmStarshipListProvider,
    filmVehicleViewProvider: @escaping FilmVehicleViewProvider,
    filmVehicleListProvider: @escaping FilmVehicleListProvider,
    filmCrawlViewProvider: @escaping CrawlViewProvider,
    dataService: Swapi = SwapiService()
  ) {
    self.dataService = dataService
    self.characterViewProvider = characterViewProvider
    self.characterListProvider = characterListProvider
    self.filmPlanetViewProvider = filmPlanetViewProvider
    self.filmPlanetListProvider = filmPlanetListProvider
    self.filmSpeciesViewProvider = filmSpeciesViewProvider
    self.filmSpeciesListProvider = filmSpeciesListProvider
    self.filmStarshipViewProvider = filmStarshipViewProvider
    self.filmStarshipListProvider = filmStarshipListProvider
    self.filmVehicleViewProvider = filmVehicleViewProvider
    self.filmVehicleListProvider = filmVehicleListProvider
    self.filmCrawlViewProvider = filmCrawlViewProvider
    self.filmId = filmId
  }

  func loadFilmContent() {
    guard needsFilmContent else { return }
    dataService.film(withId: filmId)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        self.needsFilmContent = false
        switch completion {
        case .failure(let error):
          print("There was an error loading the film with id \(self.filmId): \(error)")
          self.film = nil
        case .finished:
          break
        }
      }, receiveValue: { film in
        self.film = film
        self.characters = film.characters
        self.planets = film.planets
        self.species = film.species
        self.starships = film.starships
        self.vehicles = film.vehicles
      })
      .store(in: &disposables)
  }

  var viewTitle: String {
    film?.title ?? ""
  }

  var title: String {
    film?.title ?? String.valueNotAvailable
  }

  var episode: String {
    film?.episode.romanNumeral ?? String.valueNotAvailable
  }

  var crawlBeginning: String {
    film?.formattedCrawl.firstSentence ?? String.valueNotAvailable
  }

  var releaseDate: String {
    guard let filmRelease = film?.releaseDate else {
        return String.valueNotAvailable
    }
    return formatter.string(from: filmRelease)
  }

  var director: String {
    film?.director ?? String.valueNotAvailable
  }

  var producers: String {
    guard let filmProducers = film?.producers else {
      return String.valueNotAvailable
    }
    return filmProducers.joined(separator: ", ")
  }

  private func character(atIndex index: Int) -> Film.Character {
    characters[index]
  }

  func planet(atIndex index: Int) -> Film.Planet {
    planets[index]
  }

  func species(atIndex index: Int) -> Film.Species {
    species[index]
  }

  func starships(atIndex index: Int) -> Film.Starship {
    starships[index]
  }

  func vehicle(atIndex index: Int) -> Film.Vehicle {
    vehicles[index]
  }

  var crawlLinkDestination: FilmCrawlView? {
    filmCrawlViewProvider(film)
  }

  func characterViewModel(forCharacterAtIndex index: Int) -> CharacterRowViewModel {
    let theCharacter = character(atIndex: index)
    return CharacterRowViewModel(
      character: theCharacter,
      personView: characterViewProvider(theCharacter)
    )
  }

  func planetViewModel(forPlanetAtIndex index: Int) -> FilmPlanetRowViewModel {
    let aPlanet = planet(atIndex: index)
    return FilmPlanetRowViewModel(
      planet: aPlanet,
      planetView: filmPlanetViewProvider(aPlanet)
    )
  }

  func speciesViewModel(forSpeciesAtIndex index: Int) -> FilmSpeciesRowViewModel {
    let aSpecies = species(atIndex: index)
    return FilmSpeciesRowViewModel(species: aSpecies, speciesView: filmSpeciesViewProvider(aSpecies))
  }

  func starshipViewModel(forStarshipAtIndex index: Int) -> FilmStarshipRowViewModel {
    let aStarship = starships(atIndex: index)
    return FilmStarshipRowViewModel(starship: aStarship, starshipView: filmStarshipViewProvider(aStarship))
  }

  func vehicleViewModel(forVehicleAtIndex index: Int) -> FilmVehicleRowViewModel {
    let aVehicle = vehicle(atIndex: index)
    return FilmVehicleRowViewModel(vehicle: aVehicle, vehicleView: filmVehicleViewProvider(aVehicle))
  }

  func needsDisclosure(forSection section: FilmViewSection) -> Bool {
    switch section {
    case .characters:
      return characters.count > FilmViewModel.maximumSectionRows
    case .planets:
      return planets.count > FilmViewModel.maximumSectionRows
    case .species:
      return species.count > FilmViewModel.maximumSectionRows
    case .starships:
      return starships.count > FilmViewModel.maximumSectionRows
    case .vehicles:
      return vehicles.count > FilmViewModel.maximumSectionRows
    }
  }

  func numberOfRows(forSection section: FilmViewSection) -> Int {
    var allRows: Int
    switch section {
    case .characters:
      allRows = characters.count
    case .planets:
      allRows = planets.count
    case .species:
      allRows = species.count
    case .starships:
      allRows = starships.count
    case .vehicles:
      allRows = vehicles.count
    }

    return min(FilmViewModel.maximumSectionRows, allRows)
  }

  var characterListView: CharacterListView {
    characterListProvider(characters)
  }

  var filmPlanetsListView: FilmPlanetListView {
    filmPlanetListProvider(planets)
  }

  var filmSpeciesListView: FilmSpeciesListView {
    filmSpeciesListProvider(species)
  }

  var filmStarshipListView: FilmStarshipListView {
    filmStarshipListProvider(starships)
  }

  var filmVehicleListView: FilmVehicleListView {
    filmVehicleListProvider(vehicles)
  }
}
