//
//  FilmRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/12/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct FilmRowView: View {

  let viewModel: FilmRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.filmView) {
      VStack(alignment: .leading, spacing: 6) {
        Text("Episode \(viewModel.episode) (\(viewModel.released))")
          .font(.body)
        Text(viewModel.title)
          .font(.largeTitle)
      }
    }
  }
}

extension FilmRowView {

  static var mock: FilmRowView {
    let film = sampleFilms[3]
    let viewModel = FilmRowViewModel(
      film: film,
      filmView: FilmView.mock
    )
    return FilmRowView(viewModel: viewModel)
  }
}

// swiftlint:disable type_name
struct FilmRowView_Previews: PreviewProvider {
  static var previews: some View {
    FilmRowView.mock
  }
}
