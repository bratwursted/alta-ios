//
//  PersonView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct PersonView: View {

  @ObservedObject var viewModel: PersonViewModel

  var body: some View {
    List {
      if viewModel.person == nil {
        Text("No result")
      } else {
        personalSection
        characteristicsSection
        homeworldSection
        speciesSection
        filmsSection
        starshipsSection
        vehiclesSection
      }
    }
    .navigationBarTitle(Text(viewModel.viewTitle), displayMode: .inline)
    .onAppear {
      self.viewModel.loadPersonContent()
    }
  }
}

extension PersonView {
  var personalSection: some View {
    Section {
      VStack(alignment: .leading, spacing: 12) {
        Text(verbatim: viewModel.name!)
        Text(verbatim: "Gender: \(viewModel.gender)")
        Text(verbatim: "Born: \(viewModel.birthYear)")
      }
    }
  }

  var characteristicsSection: some View {
    Section(header: Text("Characteristics")) {
      VStack(alignment: .leading, spacing: 12) {
        Text(verbatim: "Height: \(viewModel.height) m")
        Text(verbatim: "Mass: \(viewModel.mass) kg")
        Text(verbatim: "Hair: \(viewModel.hair)")
        Text(verbatim: "Eyes: \(viewModel.eyes)")
        Text(verbatim: "Skin: \(viewModel.skin)")
      }
    }
  }

  var homeworldSection: some View {
    Section(header: Text("Homeworld")) {
      HomeworldRowView(viewModel: viewModel.homeworldViewModel)
    }
  }

  var speciesSection: some View {
    Section(header: Text("Species")) {
      if viewModel.species.isEmpty {
        Text("No results")
      } else {
        ForEach(viewModel.species, id: \.self) { species in
          SpeciesRowView(
            viewModel: self.viewModel.speciesViewModel(forSpecies: species)
          )
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
          PersonFilmRowView(
            viewModel: self.viewModel.filmViewModel(forFilm: film)
          )
        }
      }
    }
  }

  var starshipsSection: some View {
    Section(header: Text("Starships")) {
      if viewModel.starships.isEmpty {
        Text("No results")
      } else {
        ForEach(viewModel.starships, id: \.self) { starship in
          StarshipRowView(
            viewModel: self.viewModel.starshipViewModel(forStarship: starship)
          )
        }
      }
    }
  }

  var vehiclesSection: some View {
    Section(header: Text("Vehicles")) {
      if viewModel.vehicles.isEmpty {
        Text("No results")
      } else {
        ForEach(viewModel.vehicles, id: \.self) { vehicle in
          VehicleRowView(
            viewModel: self.viewModel.vehicleViewModel(forVehicle: vehicle)
          )
        }
      }
    }
  }

}

extension PersonView {
  static var mock: PersonView {
    let luke = loadSamplePerson(.luke)
    let mockData = MockDataService(luke)
    let viewModel = PersonViewModel(
      resourceId: luke.personId,
      homeworldView: { _ in PlanetView.mock },
      speciesView: { _ in SpeciesView.mock },
      filmView: { _ in FilmView.mock },
      starshipView: { _ in StarshipView.mock },
      dataService: mockData
    )
    return PersonView(viewModel: viewModel)
  }
}

// swiftlint:disable type_name
struct PersonView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      PersonView.mock
    }
  }
}
