//
//  ParametrsTests.swift
//  AppForHealthTests
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import XCTest
@testable import AppForHealth
final class ParametrsTests: XCTestCase {
    
    private let parametrsInteractor = ParametrsInteractor()
    private let parametrsVC = ParametrsVC()
    
    func testWriteParametrsForMan() {
        // Given
        parametrsVC.gender = "Мужчина"
        // When
        let result = parametrsInteractor.writeParametersToBD(age: parametrsVC.ageTextField.text ?? "", gender: parametrsVC.gender ?? "", goal: parametrsVC.goal ?? "", height: parametrsVC.heightTextField.text ?? "", levelOfActivity: parametrsVC.levelOfActivity ?? "", weight: parametrsVC.weightTextField.text ?? "")
        // Then
        XCTAssertEqual("Мужчина", result)
    }
    
    func testWriteParametrsForWoman() {
        // Given
        parametrsVC.gender = "Женщина"
        // When
        let result = parametrsInteractor.writeParametersToBD(age: parametrsVC.ageTextField.text ?? "", gender: parametrsVC.gender ?? "", goal: parametrsVC.goal ?? "", height: parametrsVC.heightTextField.text ?? "", levelOfActivity: parametrsVC.levelOfActivity ?? "", weight: parametrsVC.weightTextField.text ?? "")
        // Then
        XCTAssertEqual("Женщина", result)
    }
}
