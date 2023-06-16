//
//  TrainTest.swift
//  AppForHealthTests
//
//  Created by Дмитрий Цветков on 12.06.2023.
//

import XCTest
@testable import AppForHealth
final class TrainTest: XCTestCase {
    private let trainInteractor = TrainInteractor()
    private let trainRouter = TrainRouter()
    private let trainVC = TrainVC()
    
    func testDecrementTime() {
        // Given
        let trainPresenter = TrainPresenter(interactor: trainInteractor, router: trainRouter)
        trainPresenter.view = trainVC
        trainVC.presenter = trainPresenter
        trainInteractor.presenter = trainPresenter
        trainInteractor.score = 0
        trainInteractor.masVideos = ["g", "gg"]
        trainVC.durationTime = -1
        // When
        trainInteractor.decrementDurationTime()
        // Then
        XCTAssertEqual(1, trainInteractor.score)
    }
}
