//
//  FilmSpeciesRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct FilmSpeciesRowViewModel {

  let species: Film.Species

  var name: String {
    species.name
  }

  var speciesViewModel: SpeciesViewModel {
    SpeciesViewModel(resourceId: species.speciesId)
  }
}

struct FilmSpeciesRowView: View {

  let viewModel: FilmSpeciesRowViewModel

  var body: some View {
    Text(viewModel.name)
  }
}

// swiftlint:disable all
struct FilmSpeciesRowView_Previews: PreviewProvider {
  static let vm: FilmSpeciesRowViewModel = {
    let newHope = loadSampleFilm("newHope")
    return FilmSpeciesRowViewModel(species: newHope.species.first!)
  }()

  static var previews: some View {
    FilmSpeciesRowView(viewModel: vm)
  }
}
