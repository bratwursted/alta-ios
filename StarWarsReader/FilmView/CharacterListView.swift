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

  func viewModel(forCharacter character: Film.Character) -> CharacterRowViewModel {
    return CharacterRowViewModel(character: character)
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

// swiftlint:disable all
struct CharacterListView_Previews: PreviewProvider {
  static let vm: CharacterListViewModel = {
    let film = loadSampleFilm("newHope")
    return CharacterListViewModel(characters: film.characters)
  }()

  static var previews: some View {
    NavigationView {
      CharacterListView(viewModel: vm)
    }
  }
}
