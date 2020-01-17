//
//  FilmViewModel.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/12/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

typealias CharacterViewInitializer = (Film.Character) -> PersonView

typealias CharacterListInitializer = ([Film.Character]) -> CharacterListView

typealias FilmPlanetViewInitializer = (Film.Planet) -> PlanetView

typealias FilmPlanetListInitializer = ([Film.Planet]) -> FilmPlanetListView

typealias FilmSpeciesViewInitializer = (Film.Species) -> SpeciesView

typealias FilmSpeciewsListInitializer = ([Film.Species]) -> FilmSpeciesListView

typealias FilmStarshipViewInitializer = (Film.Starship) -> StarshipView

typealias FilmStarshipListInitializer = ([Film.Starship]) -> FilmStarshipListView

typealias FilmVehicleViewInitializer = (Film.Vehicle) -> VehicleView

typealias FilmVehicleListInitializer = ([Film.Vehicle]) -> FilmVehicleListView

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

  private let characterViewInitializer: CharacterViewInitializer

  private let characterList: CharacterListInitializer

  private let planetView: FilmPlanetViewInitializer

  private let filmPlanetList: FilmPlanetListInitializer

  private let speciesView: FilmSpeciesViewInitializer

  private let filmSpeciesList: FilmSpeciewsListInitializer

  private let starshipView: FilmStarshipViewInitializer

  private let filmStarshipList: FilmStarshipListInitializer

  private let vehicleView: FilmVehicleViewInitializer

  @Published var film: Film?

  var characters: [Film.Character] = []

  var planets: [Film.Planet] = []

  var species: [Film.Species] = []

  var starships: [Film.Starship] = []

  var vehicles: [Film.Vehicle] = []

  init(
    filmId: String,
    characterViewInitializer: @escaping CharacterViewInitializer,
    characterList: @escaping CharacterListInitializer,
    planetView: @escaping FilmPlanetViewInitializer,
    filmPlanetList: @escaping FilmPlanetListInitializer,
    speciesView: @escaping FilmSpeciesViewInitializer,
    filmSpeciesList: @escaping FilmSpeciewsListInitializer,
    starshipView: @escaping FilmStarshipViewInitializer,
    filmStarshipList: @escaping FilmStarshipListInitializer,
    vehicleView: @escaping FilmVehicleViewInitializer,
    dataService: Swapi = SwapiService()
  ) {
    self.dataService = dataService
    self.characterViewInitializer = characterViewInitializer
    self.characterList = characterList
    self.planetView = planetView
    self.filmPlanetList = filmPlanetList
    self.speciesView = speciesView
    self.filmSpeciesList = filmSpeciesList
    self.starshipView = starshipView
    self.filmStarshipList = filmStarshipList
    self.vehicleView = vehicleView
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

  func characterViewModel(forCharacterAtIndex index: Int) -> CharacterRowViewModel {
    let theCharacter = character(atIndex: index)
    return CharacterRowViewModel(
      character: theCharacter,
      personView: characterViewInitializer(theCharacter)
    )
  }

  func planetViewModel(forPlanetAtIndex index: Int) -> FilmPlanetRowViewModel {
    let aPlanet = planet(atIndex: index)
    return FilmPlanetRowViewModel(
      planet: aPlanet,
      planetView: planetView(aPlanet)
    )
  }

  func speciesViewModel(forSpeciesAtIndex index: Int) -> FilmSpeciesRowViewModel {
    let aSpecies = species(atIndex: index)
    return FilmSpeciesRowViewModel(species: aSpecies, speciesView: speciesView(aSpecies))
  }

  func starshipViewModel(forStarshipAtIndex index: Int) -> FilmStarshipRowViewModel {
    let aStarship = starships(atIndex: index)
    return FilmStarshipRowViewModel(starship: aStarship, starshipView: starshipView(aStarship))
  }

  func vehicleViewModel(forVehicleAtIndex index: Int) -> FilmVehicleRowViewModel {
    let aVehicle = vehicle(atIndex: index)
    return FilmVehicleRowViewModel(vehicle: aVehicle, vehicleView: vehicleView(aVehicle))
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
    characterList(characters)
  }

  var filmPlanetsListView: FilmPlanetListView {
    filmPlanetList(planets)
  }

  var filmSpeciesListView: FilmSpeciesListView {
    filmSpeciesList(species)
  }

  var filmStarshipListView: FilmStarshipListView {
    filmStarshipList(starships)
  }

  var vehicleListViewModel: FilmVehicleListViewModel {
    FilmVehicleListViewModel(vehicles: vehicles)
  }
}
