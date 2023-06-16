//
//  ThirdTabBarModuleTests.swift
//  AppForHealthTests
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import XCTest
@testable import AppForHealth
final class ThirdTabBarModuleTests: XCTestCase {
    private let thirdInteractor = ThirdInteractor()
    
    func testMasOfWeeks() {
        // Given
        thirdInteractor.weekMas = []
        // When
        thirdInteractor.getLast7Days()
        // Then
        XCTAssertEqual(7, thirdInteractor.weekMas.count)
    }
    
    func testFormateDate() {
        // Given
        thirdInteractor.weekMas = ["11.07.2000"]
        // When
        thirdInteractor.dateFormate(i: 0)
        // Then
        XCTAssertEqual("11.07", thirdInteractor.weekMas[0])
    }
    
    func testShowMasOfWeek() {
        // Given
        thirdInteractor.weekMas = ["11.07.2000", "15.07.2000", "18.07.2000"]
        // When
        let res = thirdInteractor.showMasOfWeek()
        // Then
        XCTAssertEqual(res, thirdInteractor.weekMas)
    }
}
