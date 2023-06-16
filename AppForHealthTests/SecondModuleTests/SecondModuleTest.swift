//
//  SecondModuleTest.swift
//  AppForHealthTests
//
//  Created by Дмитрий Цветков on 12.06.2023.
//

import XCTest
@testable import AppForHealth
final class SecondModuleTest: XCTestCase {
    private let settingInteractor = SecondInteractor()
    func testGetLast7Days() {
        // Given
        settingInteractor.weekMas = []
        // When
        settingInteractor.getLast7Days()
        // Then
        XCTAssertEqual(7, settingInteractor.weekMas.count)
    }
    
    func testDateFormate() {
        // Given
        settingInteractor.weekMas = ["11.07.2000"]
        // When
        settingInteractor.dateFormate(i: 0)
        // Then
        XCTAssertEqual("11.07", settingInteractor.weekMas[0])
    }
    
    func testShowMasOfWeek() {
        // Given
        settingInteractor.weekMas = ["11.07.2000", "15.07.2000", "18.07.2000"]
        // When
        let res = settingInteractor.showMasOfWeek()
        // Then
        XCTAssertEqual(res, settingInteractor.weekMas)
    }
}

