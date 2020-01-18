//
//  CharacterListView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct CharacterListViewModel {

  let characters: [Film.Character]

  let characterViewProvider: CharacterViewProvider

  func viewModel(forCharacter character: Film.Character) -> CharacterRowViewModel {
    return CharacterRowViewModel(
      character: character,
      personView: characterViewProvider(character)
    )
  }
}

struct CharacterListView: View {

  let viewModel: CharacterListViewModel

  var body: some View {
    List {
      ForEach(viewModel.characters, id: \.self) { character in
        CharacterRowView(
          viewModel: self.viewModel.viewModel(forCharacter: character)
        )
      }
    }
    .navigationBarTitle(Text("Characters"), displayMode: .inline)
  }
}

extension CharacterListView {
  static var mock: CharacterListView {
    let newHope = loadSampleFilm(.newHope)
    let viewModel = CharacterListViewModel(
      characters: newHope.characters,
      characterViewProvider: { _ in PersonView.mock }
    )
    return CharacterListView(viewModel: viewModel)
  }
}

// swiftlint:disable all
struct CharacterListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      CharacterListView.mock
    }
  }
}
