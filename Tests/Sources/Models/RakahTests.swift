//
//  Created by Cihat Gündüz on 12.01.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

@testable import App
import XCTest

class RakahTests: XCTestCase {
  func testCorrectComponentsCountForBeginningRakah() {
    let rakah = Rakah(
      isBeginningOfPrayer: true,
      includesStandingRecitation: true,
      includesSittingRecitation: false,
      isEndOfPrayer: false
    )

    let randomRecitation = "RR"
    let expectedComponentNames = [
      "Takbīr", "Opening Supplication", "Ta'awwudh", "al-Fatiha (The Opening)", randomRecitation, "Takbīr", "Ruku",
      "Straightening Up", "Takbīr",
      "Sajdah", "Takbīr", "Takbīr", "Sajdah", "Takbīr",
    ]

    XCTAssertEqual(rakah.components().count, expectedComponentNames.count)
    for (index, component) in rakah.components().enumerated() {
      // skip comparison for random recitations
      if expectedComponentNames[index] == randomRecitation { continue }
      XCTAssertEqual(component.name, expectedComponentNames[index])
    }
  }

  func testCorrectComponentsCountForEndingRakah() {
    let rakah = Rakah(
      isBeginningOfPrayer: false,
      includesStandingRecitation: false,
      includesSittingRecitation: true,
      isEndOfPrayer: true
    )

    let randomRecitation = "RR"
    let expectedComponentNames = [
      "al-Fatiha (The Opening)", "Takbīr", "Ruku", "Straightening Up", "Takbīr",
      "Sajdah", "Takbīr", "Takbīr", "Sajdah", "Takbīr",
      "Tashahhud", "Salatul-'Ibrahimiyyah", "Rabbanagh", "Salâm", "Salâm",
    ]

    XCTAssertEqual(rakah.components().count, expectedComponentNames.count)
    for (index, component) in rakah.components().enumerated() {
      // skip comparison for random recitations
      if expectedComponentNames[index] == randomRecitation { continue }
      XCTAssertEqual(component.name, expectedComponentNames[index])
    }
  }
}
