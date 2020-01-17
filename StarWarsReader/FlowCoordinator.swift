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

  private func makePersonView(with resourceId: String) -> PersonView {
    let viewModel = PersonViewModel(resourceId: resourceId)
    return PersonView(viewModel: viewModel)
  }
}
