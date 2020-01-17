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
      self.makeFilmView(with: film)
    })
    return FilmsListView(viewModel: viewModel)
  }

  private func makeFilmView(with film: FilmsResponse.Film) -> FilmView {
    let viewModel = FilmViewModel(filmId: film.filmId)
    return FilmView(viewModel: viewModel)
  }
}
