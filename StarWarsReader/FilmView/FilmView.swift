//
//  FilmView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/12/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct FilmView: View {

  @ObservedObject var viewModel: FilmViewModel

  var body: some View {
    List {
      if viewModel.film == nil {
        Text("No result")
      } else {
        topSection
        productionSection
        charactersSection
        planetsSection
        speciesSection
        starshipsSection
        vehiclesSection
      }
    }
    .navigationBarTitle(Text(viewModel.viewTitle), displayMode: .inline)
    .onAppear {
      self.viewModel.loadFilmContent()
    }
  }
}

extension FilmView {
  var topSection: some View {
    Section {
      VStack(alignment: .leading, spacing: 12.0) {
        Text("Episode \(viewModel.episode!)")
        Text(viewModel.title!)
          .font(.title)
        Text("\"\(viewModel.crawlBeginning!)\"")
      }
    }
  }

  var productionSection: some View {
    Section(header: Text("Production")) {
      VStack(alignment: .leading, spacing: 12) {
        Text("Release date: \(viewModel.releaseDate!)")
        Text("Director: \(viewModel.director!)")
        Text("Producers: \(viewModel.producers!)")
      }
    }
  }

  var charactersSection: some View {
    Section(header: Text("Characters")) {
      if viewModel.characters.isEmpty {
        Text("No results")
      } else {
        ForEach(0..<3) { index in
          CharacterRowView(viewModel: self.viewModel.characterViewModel(forCharacterAtIndex: index))
        }
      }
    }
  }

  var planetsSection: some View {
    Section(header: Text("Planets")) {
      if viewModel.planets.isEmpty {
        Text("No results")
      } else {
        ForEach(0..<3) { index in
          Text(self.viewModel.planet(atIndex: index))
        }
      }
    }
  }

  var speciesSection: some View {
    Section(header: Text("Species")) {
      if viewModel.species.isEmpty {
        Text("No results")
      } else {
        ForEach(0..<3) { index in
          Text(self.viewModel.species(atIndex: index))
        }
      }
    }
  }

  var starshipsSection: some View {
    Section(header: Text("Starships")) {
      if viewModel.starships.isEmpty {
        Text("No results")
      } else {
        ForEach(0..<3) { index in
          Text(self.viewModel.starships(atIndex: index))
        }
      }
    }
  }

  var vehiclesSection: some View {
    Section(header: Text("Vehicles")) {
      if viewModel.vehicles.isEmpty {
        Text("No results")
      } else {
        ForEach(0..<3) { index in
          Text(self.viewModel.vehicle(atIndex: index))
        }
      }
    }
  }
}

// swiftlint:disable type_name identifier_name
struct FilmView_Previews: PreviewProvider {
  static let vm: FilmViewModel = {
    let film = loadSampleFilm("newHope")
    let service = MockDataService(film)
    return FilmViewModel(filmId: film.filmId, dataService: service)
  }()

  static var previews: some View {
    NavigationView {
      FilmView(viewModel: vm)
    }
  }
}
