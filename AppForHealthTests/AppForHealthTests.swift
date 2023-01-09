//
//  AppForHealthTests.swift
//  AppForHealthTests
//
//  Created by Дмитрий Цветков on 05.12.2022.
//

import XCTest
@testable import AppForHealth
import CoreData

final class AppForHealthTests: XCTestCase {
    
    var parametrsVC = ParametrsVC()
    var parametrsInteractor = ParametrsInteractor()
    
    var resultVC = ResultVC()
    var water = WaterVC()
    
    func testActions1() {
        // Given
        resultVC.gender = "Мужчина"
        resultVC.weight = 100
        
        // When
        let result = resultVC.calculateNumberOfWater()
        
        // Then
        
        XCTAssertEqual(3500, result)
        
        
        
        // Given
        resultVC.gender = "Женщина"
        resultVC.weight = 100
        
        // When
        
        let result2 = resultVC.calculateNumberOfWater()
        
        // Then
        
        XCTAssertEqual(3100, result2)
    }
    
    func testActions2() {
        // Given
        resultVC.gender = "Мужчина"
        resultVC.weight = 100
        resultVC.height = 180
        resultVC.age = 20
        resultVC.activity = "Низкий"
        
        // When
        let result = resultVC.culculationCalories()
        
        // Then
        
        XCTAssertEqual(2614.0319999999997, result)
    }
    
    func testActions3() {
        // Given
        water.numberML = 200
        
        // When
        let result = water.incWater()
        
        // Then
        
        XCTAssertEqual(300, result)
    }
    
    func testActions4() {
        // Given
        parametrsVC.gender = "Мужчина"

        
        // When
        let result = parametrsInteractor.writeParametersToBD(ageTextField: parametrsVC.ageTextField, gender: parametrsVC.gender ?? "", goal: parametrsVC.goal ?? "", heightTextField: parametrsVC.heightTextField, levelOfActivity: parametrsVC.levelOfActivity ?? "", weightTextField: parametrsVC.weightTextField)
        
        // Then
        
        XCTAssertEqual("Мужчина", result)
    }
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
