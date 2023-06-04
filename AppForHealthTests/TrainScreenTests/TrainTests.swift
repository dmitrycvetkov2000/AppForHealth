//
//  TrainTests.swift
//  AppForHealthTests
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import XCTest
@testable import AppForHealth
final class TrainTests: XCTestCase {
    private let trainVC = TrainVC()
    private let trainInteractor = TrainInteractor()
    
    func testDecrementTimer() {
        // Given
        trainInteractor.score = 0
        trainVC.durationTime = 21
        trainInteractor.masVideos = ["1", "2", "3", "4"]
        // When
        trainInteractor.presenter?.decrementDurationTime()
        // Then
        wait(for: [], timeout: 1)
        XCTAssertEqual(1, trainVC.durationTime)
    }

}
