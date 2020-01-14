//
//  FilmViewModel.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/12/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

final class FilmViewModel: ObservableObject {

  private let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale.current
    formatter.dateStyle = .medium
    return formatter
  }()

  private let dataService: Swapi

  private let filmId: String

  private var disposables = Set<AnyCancellable>()

  @Published var film: Film?

  var characters: [Film.Character] = []

  var planets: [Film.Planet] = []

  var species: [Film.Species] = []

  var starships: [Film.Starship] = []

  var vehicles: [Film.Vehicle] = []

  init(
    filmId: String,
    dataService: Swapi = SwapiService()
  ) {
    self.dataService = dataService
    self.filmId = filmId
  }

  func loadFilmContent() {
    dataService.film(withId: filmId)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
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

  var title: String? {
    film?.title
  }

  var episode: String? {
    film?.episode.romanNumeral
  }

  var crawlBeginning: String? {
    film?.formattedCrawl.firstSentence
  }

  var releaseDate: String? {
    guard let filmRelease = film?.releaseDate else {
      return nil
    }
    return formatter.string(from: filmRelease)
  }

  var director: String? {
    film?.director
  }

  var producers: String? {
    film?.producers.joined(separator: ", ")
  }

  private func character(atIndex index: Int) -> Film.Character {
    characters[index]
  }

  func planet(atIndex index: Int) -> String {
    planets[index].name
  }

  func species(atIndex index: Int) -> String {
    species[index].name
  }

  func starships(atIndex index: Int) -> String {
    starships[index].name
  }

  func vehicle(atIndex index: Int) -> String {
    vehicles[index].name
  }

  func characterViewModel(forCharacterAtIndex index: Int) -> CharacterRowViewModel {
    CharacterRowViewModel(character: character(atIndex: index))
  }
}
