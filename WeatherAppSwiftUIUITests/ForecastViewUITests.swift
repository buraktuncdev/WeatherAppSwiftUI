//
//  ForecastViewUITests.swift
//  WeatherAppSwiftUIUITests
//
//  Created by Burak Tunc on 16.05.22.
//

import XCTest

class ForecastViewUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func test_ForecastView_HumidityTab_IsExists() {
        self.useLocationPermissionTestCaseHelper(elementToTap: 1, expectedTextOnScreen: "Humidity")
    }

    func test_ForecastView_WindSpeedTab_IsExists() {
        self.useLocationPermissionTestCaseHelper(elementToTap: 0, expectedTextOnScreen: "Wind Speed")
    }

    func test_ForecastView_VisibilityTab_IsExists() {
        self.useLocationPermissionTestCaseHelper(elementToTap: 0, expectedTextOnScreen: "Visibility")
    }

    func test_LocationPermissionCheck_NotAllowed_ToErrorView_IsButtonTitleExists() {
        self.useLocationPermissionTestCaseHelper(elementToTap: 2, expectedTextOnScreen: "Use Application without location")
    }

    func test_LocationPermissionCheck_NotAllowed_ToErrorView_IsErrorMessageExists() {
        self.useLocationPermissionTestCaseHelper(elementToTap: 2,
                             expectedTextOnScreen: "Our application does not have location permissions. Please enable it in settings.")
    }

    func useLocationPermissionTestCaseHelper(elementToTap: Int, expectedTextOnScreen: String) {
      app.resetAuthorizationStatus(for: .location)
      app.launch()

      let exp = expectation(description: "wait for acceptance...")
      let monitor = self.addUIInterruptionMonitor(withDescription: "Authotization Dialog") { alert in
        let allowButton = alert.buttons.element(boundBy: elementToTap)
        XCTAssertTrue(allowButton.waitForExistence(timeout: 1))
        allowButton.tap()
        exp.fulfill()
        return true
      }

      app.tap()
      wait(for: [exp], timeout: 10)

        let expected = app.staticTexts[expectedTextOnScreen]
        XCTAssertTrue(expected.exists)
      self.removeUIInterruptionMonitor(monitor)
    }

}
