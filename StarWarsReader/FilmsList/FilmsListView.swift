//
//  FilmsListView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/12/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct FilmsListView: View {

  @ObservedObject var viewModel: FilmsListViewModel

  var body: some View {
    NavigationView {
      List {
        if viewModel.films.isEmpty {
          Text("No results")
        } else {
          ForEach(viewModel.films, id: \.self) { film in
            FilmRowView(viewModel: self.viewModel.rowViewModel(forFilm: film))
          }
        }
      }
      .navigationBarTitle(Text("Star Wars"))
      .onAppear {
        self.viewModel.loadFilmsList()
      }
    }
  }
}

extension FilmsListView {
  static var mock: FilmsListView {
    let mockData = MockDataService(sampleFilms)
    let viewModel = FilmsListViewModel(
      filmViewInitializer: { _ in
        FilmView.mock
    },
      dataService: mockData
    )
    return FilmsListView(viewModel: viewModel)
  }
}

// swiftlint:disable type_name
struct FilmsListView_Previews: PreviewProvider {
  static var previews: some View {
    FilmsListView.mock
  }
}
