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

  @State var navigationTag: Int?

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
    Section(header: headerView(forSectrion: .characters)) {
      if viewModel.characters.isEmpty {
        Text("No results")
      } else {
        ForEach(0..<self.viewModel.numberOfRows(forSection: .characters)) { index in
          CharacterRowView(viewModel: self.viewModel.characterViewModel(forCharacterAtIndex: index))
        }
      }
    }
  }

  var planetsSection: some View {
    Section(header: headerView(forSectrion: .planets)) {
      if viewModel.planets.isEmpty {
        Text("No results")
      } else {
        ForEach(0..<self.viewModel.numberOfRows(forSection: .planets)) { index in
          Text(self.viewModel.planet(atIndex: index))
        }
      }
    }
  }

  var speciesSection: some View {
    Section(header: headerView(forSectrion: .species)) {
      if viewModel.species.isEmpty {
        Text("No results")
      } else {
        ForEach(0..<self.viewModel.numberOfRows(forSection: .species)) { index in
          Text(self.viewModel.species(atIndex: index))
        }
      }
    }
  }

  var starshipsSection: some View {
    Section(header: headerView(forSectrion: .starships)) {
      if viewModel.starships.isEmpty {
        Text("No results")
      } else {
        ForEach(0..<self.viewModel.numberOfRows(forSection: .starships)) { index in
          Text(self.viewModel.starships(atIndex: index))
        }
      }
    }
  }

  var vehiclesSection: some View {
    Section(header: headerView(forSectrion: .vehicles)) {
      if viewModel.vehicles.isEmpty {
        Text("No results")
      } else {
        ForEach(0..<self.viewModel.numberOfRows(forSection: .vehicles)) { index in
          Text(self.viewModel.vehicle(atIndex: index))
        }
      }
    }
  }
}

extension FilmView {

  func headerView(
    forSectrion section: FilmViewSection
  ) -> some View {
    HStack {
      Text(section.title)
      Spacer()
      if viewModel.needsDisclosure(forDestination: section.destination) {
        headerButton(forDestination: section.destination)
      }
    }
  }

  func headerButton(forDestination destination: NavigationDestination) -> Button<HeaderButtonView> {
    Button(
      action: {
        self.navigationTag = destination.tag
    }, label: {
      HeaderButtonView()
    })
  }

}

struct HeaderButtonView: View {
  var body: some View {
    HStack {
      Text("See all")
      Image(systemName: "chevron.right")
        .font(.caption)
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
