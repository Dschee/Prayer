//
//  Created by Cihat Gündüz on 19.03.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import XCTest

class AppStoreSnapshotUITests: XCTestCase {
  let app = XCUIApplication()
  var uiMode: String = "light"

  override func setUp() {
    super.setUp()

    continueAfterFailure = false

    setupSnapshot(app)
    app.launch()

    uiMode = app.launchArguments.contains("DARK_MODE") ? "dark" : "light"
    XCUIDevice.shared.orientation = UIDevice.current.userInterfaceIdiom == .pad ? .landscapeLeft : .portrait
  }

  func testTakeAppStoreScreenshots() {
    let faqText = localizedString(key: "SETTINGS.FAQ_BUTTON.TITLE")
    if let faqDoneButton = app.navigationBars[faqText].buttons.allElementsBoundByIndex.first {
      faqDoneButton.tap()
    }

    snapshot("1-Settings-\(uiMode)")

    // Wait until starting Opening Prayer
    let startPrayerText = localizedString(key: "SETTINGS.START_BUTTON.TITLE")
    app.tables.staticTexts[startPrayerText].tap()

    let openingPrayerExpectation = expectation(description: "Going to Opening Prayer")
    DispatchQueue.main.async {
      let openingText = self.localizedTextFileEntry(fileName: "001_The-Opening", lineIndex: 2)
      while !self.app.staticTexts[openingText].exists {
        _ = self.app.staticTexts.count
      }

      openingPrayerExpectation.fulfill()
    }

    waitForExpectations(timeout: 100, handler: nil)
    snapshot("2-Opening-Prayer-\(uiMode)")

    // Wait until going to Ruku
    let rukuExpectation = expectation(description: "Going to Ruku Screenshot")
    DispatchQueue.main.async {
      let rukuText = self.localizedTextFileEntry(fileName: "Ruku", lineIndex: 0)
      while !self.app.staticTexts[rukuText].exists {
        _ = self.app.staticTexts.count
      }

      rukuExpectation.fulfill()
    }

    waitForExpectations(timeout: 100, handler: nil)
    snapshot("3-Ruku-\(uiMode)")
  }

  private func localizedString(key: String) -> String {
    let language = String(deviceLanguage.prefix(upTo: deviceLanguage.index(deviceLanguage.startIndex, offsetBy: 2)))
    let localizationBundle = Bundle(
      path: Bundle(for: AppStoreSnapshotUITests.self).path(forResource: language, ofType: "lproj")!
    )
    return NSLocalizedString(key, bundle: localizationBundle!, comment: "")
  }

  private func localizedTextFileEntry(fileName: String, lineIndex: Int) -> String {
    let language = String(deviceLanguage.prefix(upTo: deviceLanguage.index(deviceLanguage.startIndex, offsetBy: 2)))
    let localizationBundle = Bundle(
      path: Bundle(for: AppStoreSnapshotUITests.self).path(forResource: language, ofType: "lproj")!
    )!
    let filePath = localizationBundle.path(forResource: fileName, ofType: "txt")!
    let textFileContent: String = try! String(contentsOfFile: filePath)
    return textFileContent.components(separatedBy: .newlines)[lineIndex]
  }
}
