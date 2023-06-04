//
//  WaterTests.swift
//  AppForHealthTests
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import XCTest
@testable import AppForHealth

final class WaterTests: XCTestCase {
    private let waterInteractor = WaterInteractor()
    
    func testIncWater() {
        // Given
        waterInteractor.numberML = 0
        // When
        waterInteractor.incWater(label: UILabel())
        // Then
        XCTAssertEqual(100, waterInteractor.numberML)
    }

}
