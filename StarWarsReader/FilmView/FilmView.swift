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
      NavigationLink(destination: viewModel.crawlLinkDestination!) {
        VStack(alignment: .leading, spacing: 12.0) {
          Text("Episode \(viewModel.episode)")
          Text(viewModel.title)
            .font(.title)
          Text("\"\(viewModel.crawlBeginning)\"")
        }
      }
    }
  }

  var productionSection: some View {
    Section(header: Text("Production")) {
      VStack(alignment: .leading, spacing: 12) {
        Text("Release date: \(viewModel.releaseDate)")
        Text("Director: \(viewModel.director)")
        Text("Producers: \(viewModel.producers)")
      }
    }
  }

  var charactersSection: some View {
    Section(header: charactersSectionHeader) {
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
    Section(header: planetsSectionHeader) {
      if viewModel.planets.isEmpty {
        Text("No results")
      } else {
        ForEach(0..<self.viewModel.numberOfRows(forSection: .planets)) { index in
          FilmPlanetRowView(viewModel: self.viewModel.planetViewModel(forPlanetAtIndex: index))
        }
      }
    }
  }

  var speciesSection: some View {
    Section(header: speciesSectionHeader) {
      if viewModel.species.isEmpty {
        Text("No results")
      } else {
        ForEach(0..<self.viewModel.numberOfRows(forSection: .species)) { index in
          FilmSpeciesRowView(viewModel: self.viewModel.speciesViewModel(forSpeciesAtIndex: index))
        }
      }
    }
  }

  var starshipsSection: some View {
    Section(header: starshipsSectionHeader) {
      if viewModel.starships.isEmpty {
        Text("No results")
      } else {
        ForEach(0..<self.viewModel.numberOfRows(forSection: .starships)) { index in
          FilmStarshipRowView(viewModel: self.viewModel.starshipViewModel(forStarshipAtIndex: index))
        }
      }
    }
  }

  var vehiclesSection: some View {
    Section(header: vehiclesSectionHeader) {
      if viewModel.vehicles.isEmpty {
        Text("No results")
      } else {
        ForEach(0..<self.viewModel.numberOfRows(forSection: .vehicles)) { index in
          FilmVehicleRowView(viewModel: self.viewModel.vehicleViewModel(forVehicleAtIndex: index))
        }
      }
    }
  }
}

extension FilmView {

  var charactersSectionHeader: some View {
    HStack {
      Text(FilmViewSection.characters.title)
      if viewModel.needsDisclosure(forSection: FilmViewSection.characters) {
        Spacer()
        NavigationLink(
          destination: viewModel.characterListView,
          tag: FilmViewSection.characters.destination.tag,
          selection: $navigationTag,
          label: {
            headerButton(forDestination: FilmViewSection.characters.destination)
        })
      }
    }
  }

  var planetsSectionHeader: some View {
    HStack {
      Text(FilmViewSection.planets.title)
      if viewModel.needsDisclosure(forSection: FilmViewSection.planets) {
        Spacer()
        NavigationLink(
          destination: viewModel.filmPlanetsListView,
          tag: FilmViewSection.planets.destination.tag,
          selection: $navigationTag,
          label: {
            headerButton(forDestination: FilmViewSection.planets.destination)
        })
      }
    }
  }

  var speciesSectionHeader: some View {
    HStack {
      Text(FilmViewSection.species.title)
      if viewModel.needsDisclosure(forSection: FilmViewSection.species) {
        Spacer()
        NavigationLink(
          destination: viewModel.filmSpeciesListView,
          tag: FilmViewSection.species.destination.tag,
          selection: $navigationTag,
          label: {
            headerButton(forDestination: FilmViewSection.species.destination)
        })
      }
    }
  }

  var starshipsSectionHeader: some View {
    HStack {
      Text(FilmViewSection.starships.title)
      if viewModel.needsDisclosure(forSection: FilmViewSection.starships) {
        Spacer()
        NavigationLink(
          destination: viewModel.filmStarshipListView,
          tag: FilmViewSection.starships.destination.tag,
          selection: $navigationTag,
          label: {
            headerButton(forDestination: FilmViewSection.starships.destination)
        })
      }
    }
  }

  var vehiclesSectionHeader: some View {
    HStack {
      Text(FilmViewSection.vehicles.title)
      if viewModel.needsDisclosure(forSection: FilmViewSection.vehicles) {
        Spacer()
        NavigationLink(
          destination: viewModel.filmVehicleListView,
          tag: FilmViewSection.vehicles.destination.tag,
          selection: $navigationTag,
          label: {
            headerButton(forDestination: FilmViewSection.vehicles.destination)
        })
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

extension FilmView {
  static var mock: FilmView {
    let film = loadSampleFilm(.newHope)
    let characterView: CharacterViewProvider = { _ in PersonView.mock }
    let characterList: CharacterListProvider = { _ in CharacterListView.mock }
    let planetView: FilmPlanetViewProvider = { _ in PlanetView.mock }
    let planetList: FilmPlanetListProvider = { _ in FilmPlanetListView.mock }
    let speciesView: FilmSpeciesViewProvider = { _ in SpeciesView.mock }
    let filmSpeciesList: FilmSpeciewsListProvider = { _ in FilmSpeciesListView.mock }
    let starshipView: FilmStarshipViewProvider = { _ in StarshipView.mock }
    let filmStarshipList: FilmStarshipListProvider = { _ in FilmStarshipListView.mock }
    let vehicleView: FilmVehicleViewProvider = { _ in VehicleView.mock }
    let filmVehicleList: FilmVehicleListProvider = { _ in FilmVehicleListView.mock }
    let crawlView = FilmCrawlView(viewModel: FilmCrawlViewModel(film: loadSampleFilm(.newHope)))
    let viewModel = FilmViewModel(
      filmId: film.filmId,
      characterViewProvider: characterView,
      characterListProvider: characterList,
      filmPlanetViewProvider: planetView,
      filmPlanetListProvider: planetList,
      filmSpeciesViewProvider: speciesView,
      filmSpeciesListProvider: filmSpeciesList,
      filmStarshipViewProvider: starshipView,
      filmStarshipListProvider: filmStarshipList,
      filmVehicleViewProvider: vehicleView,
      filmVehicleListProvider: filmVehicleList,
      filmCrawlViewProvider: { _ in crawlView }
    )
    return FilmView(viewModel: viewModel)
  }
}

// swiftlint:disable type_name
struct FilmView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FilmView.mock
    }
  }
}
