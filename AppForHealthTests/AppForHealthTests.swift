//
//  AppForHealthTests.swift
//  AppForHealthTests
//
//  Created by Дмитрий Цветков on 05.12.2022.
//

import XCTest
@testable import AppForHealth
import CoreData
import Firebase

final class AppForHealthTests: XCTestCase {
    
    var parametrsVC = ParametrsVC()
    var parametrsInteractor = ParametrsInteractor()
    
    var resultVC = ResultVC()
    var resultInteractor = ResultInteractor()
    
    var settingVC = SettingVC()
    var settingInteractor = SettingInteractor()

    var water = WaterVC()
    
    
    func testActions1ForResultModule() {
        // Given
        
        let managedObject = Person()
        managedObject.gender = "Мужчина"
        managedObject.weight = 100

        CoreDataManager.instance.saveContext()
        resultVC.gender = "Мужчина"
        resultVC.weight = 100

        // When
        let result = resultInteractor.calculateNumberOfWater()

        // Then

        XCTAssertEqual(3500, result)



        // Given
        managedObject.gender = "Женщина"
        managedObject.weight = 100
        CoreDataManager.instance.saveContext()
        
        resultVC.gender = "Женщина"
        resultVC.weight = 100

        // When

        let result2 = resultInteractor.calculateNumberOfWater()

        // Then

        XCTAssertEqual(3100, result2)
    }
    
    func testActions2ForResultModule() {
        // Given
        resultVC.gender = "Мужчина"
        resultVC.weight = 100
        resultVC.height = 180
        resultVC.age = 20
        resultVC.activity = "Низкий"
        
        
        let managedObject = Person()
        managedObject.gender = "Мужчина"
        managedObject.weight = 100
        managedObject.height = 180
        managedObject.age = 20
        managedObject.activity = "Низкий"
        CoreDataManager.instance.saveContext()

        // When
        let result = resultInteractor.culculationCalories()

        // Then

        XCTAssertEqual(2178, result)
    }
//    func testActions1ForSettingsModule() {
//        // Given
//        water.numberML = 200
//        
//        // When
//        let result = settingInteractor.signOut()
//        
//        // Then
//        
//        XCTAssertEqual(true, result())
//    }
    
    func testActions1ForWaterModule() {
        // Given
        water.numberML = 200
        
        // When
        let result = water.incWater()
        
        // Then
        
        XCTAssertEqual(300, result)
    }
    
    func testActions1ForParametrsModule() {
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
