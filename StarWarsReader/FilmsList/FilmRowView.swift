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
    NavigationLink(destination: FilmView(viewModel: viewModel.filmViewModel)) {
      VStack(alignment: .leading, spacing: 6) {
        Text("Episode \(viewModel.episode) (\(viewModel.released))")
          .font(.body)
        Text(viewModel.title)
          .font(.largeTitle)
      }
    }
  }
}

// swiftlint:disable type_name identifier_name
struct FilmRowView_Previews: PreviewProvider {
  static let vm: FilmRowViewModel = {
    let film = sampleFilms[3]
    return FilmRowViewModel(film: film)
  }()

  static var previews: some View {
    FilmRowView(viewModel: vm)
  }
}
