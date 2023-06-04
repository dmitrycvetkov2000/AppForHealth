//
//  MainModuleTests.swift
//  AppForHealthTests
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import XCTest
@testable import AppForHealth
final class MainModuleTests: XCTestCase {
    private let mainModuleInteractor = MainInteractor()

    func testDetermeSmile() {
        // Given
        let imt = IMTEnum.norma.rawValue
        // When
        let smile = mainModuleInteractor.checkIMTAndDetermSmile(imt: imt)
        // Then
        XCTAssertEqual("👍🏽", smile)
    }
}
