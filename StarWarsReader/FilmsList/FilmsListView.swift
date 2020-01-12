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
    List {
      if viewModel.films.isEmpty {
        Text("No results")
      } else {
        ForEach(viewModel.films, id: \.self) { film in
          Text(film.title)
        }
      }
    }
    .onAppear {
      self.viewModel.loadFilmsList()
    }
  }
}

// swiftlint:disable type_name identifier_name
struct FilmsListView_Previews: PreviewProvider {
  static let vm: FilmsListViewModel = {
    let dataService = MockDataService(sampleFilms)
    return FilmsListViewModel(dataService: dataService)
  }()

  static var previews: some View {
    FilmsListView(viewModel: vm)
  }
}
