//
//  CharacterRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct CharacterRowViewModel {

  let character: Film.Character

  let personView: PersonView

  var name: String {
    character.name
  }

  var personViewModel: PersonViewModel {
    PersonViewModel(resourceId: character.characterId)
  }
}

struct CharacterRowView: View {

  let viewModel: CharacterRowViewModel

  var body: some View {
    NavigationLink(destination: viewModel.personView) {
      Text(viewModel.name)
    }
  }
}

extension CharacterRowView {
  static var mock: CharacterRowView {
    let film = loadSampleFilm("newHope")
    let viewModel = CharacterRowViewModel(
      character: film.characters[0],
      personView: PersonView.mock
    )
    return CharacterRowView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct CharacterRowView_Previews: PreviewProvider {
  static var previews: some View {
    CharacterRowView.mock
  }
}
