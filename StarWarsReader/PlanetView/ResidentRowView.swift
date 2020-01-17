//
//  ResidentRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct ResidentRowViewModel {

  let resident: Planet.Resident

  let residentView: PersonView

  var name: String {
    resident.name
  }
}

struct ResidentRowView: View {

  let viewModel: ResidentRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.residentView) {
      Text(viewModel.name)
    }
  }
}

extension ResidentRowView {
  static var mock: ResidentRowView {
    let resident = loadSamplePlanet(.tatooine).residents[0]
    let viewModel = ResidentRowViewModel(resident: resident, residentView: PersonView.mock)
    return ResidentRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct ResidentRowView_Previews: PreviewProvider {
  static var previews: some View {
    ResidentRowView.mock
  }
}
