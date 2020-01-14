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
    NavigationLink(destination: PersonView(viewModel: viewModel.personViewModel)) {
      Text(viewModel.name)
    }
  }
}

// swiftlint:disable all
struct CharacterRowView_Previews: PreviewProvider {
  static let vm: CharacterRowViewModel = {
    let film = loadSampleFilm("newHope")
    return CharacterRowViewModel(character: film.characters.first!)
  }()

  static var previews: some View {
    CharacterRowView(viewModel: vm)
  }
}
