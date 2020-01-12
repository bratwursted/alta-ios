//
//  FilmsListViewModel.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/12/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

final class FilmsListViewModel: ObservableObject {

  private let dataService: Swapi

  private var disposables = Set<AnyCancellable>()

  @Published var films: [FilmsResponse.Film] = []

  init(dataService: Swapi = SwapiService()) {
    self.dataService = dataService
  }

  func loadFilmsList() {
    dataService.allFilms()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.films = []
          print("There was an error getting the films list \(error)")
        case .finished:
          break
        }
      }, receiveValue: { films in
          self.films = films
      })
  .store(in: &disposables)
  }

  func rowViewModel(forFilm film: FilmsResponse.Film) -> FilmRowViewModel {
    return FilmRowViewModel(film: film)
  }
}
