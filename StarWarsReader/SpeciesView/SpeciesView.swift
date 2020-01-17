//
//  SpeciesView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct SpeciesView: View {

  @ObservedObject var viewModel: SpeciesViewModel

  var body: some View {
    List {
      if viewModel.species == nil {
        Text("No result")
      } else {
        topSection
        characteristicsSection
        peopleSection
        filmsSection
      }
    }
    .navigationBarTitle(Text(viewModel.viewTitle), displayMode: .inline)
    .onAppear {
      self.viewModel.loadSpecies()
    }
  }
}

extension SpeciesView {

  var topSection: some View {
    Section {
      VStack(alignment: .leading, spacing: 12) {
        Text(verbatim: viewModel.name)
        Text(verbatim: viewModel.speciesDescription)
        Text(verbatim: "Avg. height: \(viewModel.height)")
        Text(verbatim: "Avg. lifespan: \(viewModel.lifespan)")
      }
    }
  }

  var characteristicsSection: some View {
    Section(header: Text("Characteristics")) {
      VStack(alignment: .leading, spacing: 12) {
        Text(verbatim: "Eye color: \(viewModel.eyes)")
        Text(verbatim: "Hair color: \(viewModel.hair)")
        Text(verbatim: "Skin: \(viewModel.skin)")
      }
    }
  }

  var peopleSection: some View {
    Section(header: Text("People")) {
      if viewModel.people.isEmpty {
        Text("No results")
      } else {
        ForEach(viewModel.people, id: \.self) { person in
          SpeciesPersonRowView(viewModel: self.viewModel.rowViewModel(forPerson: person))
        }
      }
    }
  }

  var filmsSection: some View {
    Section(header: Text("Appears in")) {
      if viewModel.films.isEmpty {
        Text("No results")
      } else {
        ForEach(viewModel.films, id: \.self) { film in
          SpeciesFilmRowView(viewModel: self.viewModel.rowViewModel(forFilm: film))
        }
      }
    }
  }
}

extension SpeciesView {
  static var mock: SpeciesView {
    let twilek = loadSampleSpecies("twilek")
    let mockData = MockDataService(twilek)
    let viewModel = SpeciesViewModel(
      resourceId: twilek.speciesId,
      dataService: mockData
    )
    return SpeciesView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct SpeciesView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SpeciesView.mock
    }
  }
}
