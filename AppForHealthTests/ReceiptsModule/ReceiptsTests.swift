//
//  ReceiptsTests.swift
//  AppForHealthTests
//
//  Created by Дмитрий Цветков on 16.06.2023.
//

import XCTest
@testable import AppForHealth

final class ReceiptsTests: XCTestCase {
    private var recipesInteractor: RecipesInteractor!
    override func setUpWithError() throws {
        recipesInteractor = RecipesInteractor()
    }

    override func tearDownWithError() throws {
        recipesInteractor = nil
    }
    
    func testGetRequest() {
        // Given
        let helper = HelperForRecipes()
        let expect = expectation(description: "receipt")
        // When
        do {
            recipesInteractor.getRequest(helper: helper, type: .getReceipeForLaunch)
            expect.fulfill()
        }

        // Then
        wait(for: [expect])
        print(helper.modelForReceipts?.nameOfFood)
        XCTAssertEqual([], helper.modelForReceipts?.nameOfFood)
    }
    

}
