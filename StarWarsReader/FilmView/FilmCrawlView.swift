//
//  FilmCrawlView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct FilmCrawlViewModel {

  let film: Film

  var openingCrawl: String {
    film.formattedCrawl
  }

  var title: String {
    film.title
  }
}

struct FilmCrawlView: View {

  let viewModel: FilmCrawlViewModel

  var body: some View {
    List {
      Section {
        Text(viewModel.openingCrawl)
      }
    }
    .navigationBarTitle(Text(viewModel.title), displayMode: .inline)
    .padding()
  }
}

// swiftlint:disable all
struct FilmCrawlView_Previews: PreviewProvider {
  static let vm: FilmCrawlViewModel = {
    let film = loadSampleFilm("newHope")
    return FilmCrawlViewModel(film: film)
  }()

  static var previews: some View {
    NavigationView {
      FilmCrawlView(viewModel: vm)
    }
  }
}
