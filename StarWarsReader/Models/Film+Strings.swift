//
//  Film+Strings.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/12/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

extension Int {
  var romanNumeral: String {

    var value = self
    var convertedString = ""

    let numerals = [
    "M",
    "CM",
    "D",
    "CD",
    "C",
    "XC",
    "L",
    "XL",
    "X",
    "IX",
    "V",
    "IV",
    "I"
    ]

    let decimals = [
    1000,
    900,
    500,
    400,
    100,
    90,
    50,
    40,
    10,
    9,
    5,
    4,
    1
    ]

    for (index, romanCharacter) in numerals.enumerated() {
      let decimalValue = decimals[index]
      let quotient = value / decimalValue

      if quotient > 0 {
        for _ in 0..<quotient {
          convertedString += romanCharacter
          value -= quotient * decimalValue
        }
      }
    }

    return convertedString
  }
}
