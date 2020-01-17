//
//  HeaderButton.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/17/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import SwiftUI

struct HeaderButtonView: View {
  var body: some View {
    HStack {
      Text("See all")
      Image(systemName: "chevron.right")
        .font(.caption)
    }
  }
}
