//
//  VehicleFilmRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct VehicleFilmRowViewModel {

  let film: Vehicle.Film

  let filmView: FilmView

  var title: String {
    film.title
  }
}

struct VehicleFilmRowView: View {

  let viewModel: VehicleFilmRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.filmView) {
      Text(viewModel.title)
    }
  }
}

extension VehicleFilmRowView {
  static var mock: VehicleFilmRowView {
    let film = loadSampleVehicle(.airspeeder).films[0]
    let viewModel = VehicleFilmRowViewModel(film: film, filmView: FilmView.mock)
    return VehicleFilmRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct VehicleFilmRowView_Previews: PreviewProvider {
  static var previews: some View {
    VehicleFilmRowView.mock
  }
}
