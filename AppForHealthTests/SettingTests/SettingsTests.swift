//
//  SettingsTests.swift
//  AppForHealthTests
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import XCTest
@testable import AppForHealth
final class SettingsTests: XCTestCase {
    private let settingInteractor = SettingInteractor()
    
    func testReloadNumberOfWaterForMan() {
        // Given
        settingInteractor.numberOfWater = 100
        let manGender = Genders.man.rawValue
        let manWeight: Int16 = 100
        // When
        let manResult = settingInteractor.reloadNumberOfWater(gender: manGender, weight: manWeight)
        // Then
        XCTAssertEqual(3500, manResult)
    }
    
    func testReloadNumberOfWaterForWoman() {
        // Given
        settingInteractor.numberOfWater = 100
        let gender = Genders.woman.rawValue
        let weight: Int16 = 100
        // When
        let result = settingInteractor.reloadNumberOfWater(gender: gender, weight: weight)
        // Then
        XCTAssertEqual(3100, result)
    }
    
    func testReloadIMTForMan() {
        // Given
        settingInteractor.numberOfWater = 100
        let gender = Genders.man.rawValue
        let height: Int16 = 100
        let weight: Int16 = 100
        let age: Int16 = 20
        // When
        let result = settingInteractor.reloadIMT(height: height, weight: weight, gender: gender, age: age)
        // Then
        XCTAssertEqual(IMTEnum.overWeight.rawValue, result)
    }
    
    func testReloadIMTForWoman() {
        // Given
        settingInteractor.numberOfWater = 100
        let gender = Genders.woman.rawValue
        let height: Int16 = 100
        let weight: Int16 = 100
        let age: Int16 = 20
        // When
        let result = settingInteractor.reloadIMT(height: height, weight: weight, gender: gender, age: age)
        // Then
        XCTAssertEqual(IMTEnum.overWeight.rawValue, result)
    }
    
    func testReloadCaloriesForMan() {
        // Given
        settingInteractor.numberOfWater = 100
        let gender = Genders.man.rawValue
        let height: Int16 = 100
        let weight: Int16 = 100
        let age: Int16 = 20
        let levelOfActivity = LevelOfActivityEnum.middle.rawValue
        // When
        let result = settingInteractor.reloadNumberOfCcal(gender: gender, weight: weight, height: height, age: age, levelOfActivity: levelOfActivity)
        // Then
        XCTAssertEqual(2691, result)
    }
    
    func testReloadCaloriesForWoman() {
        
        // Given
        settingInteractor.numberOfWater = 100
        let gender = Genders.woman.rawValue
        let height: Int16 = 100
        let weight: Int16 = 100
        let age: Int16 = 20
        let levelOfActivity = LevelOfActivityEnum.middle.rawValue
        // When
        let result = settingInteractor.reloadNumberOfCcal(gender: gender, weight: weight, height: height, age: age, levelOfActivity: levelOfActivity)
        // Then
        XCTAssertEqual(2386, result)
    }
}
