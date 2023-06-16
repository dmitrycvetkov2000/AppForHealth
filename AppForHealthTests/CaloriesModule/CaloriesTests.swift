//
//  CaloriesTests.swift
//  AppForHealthTests
//
//  Created by Дмитрий Цветков on 16.06.2023.
//

import XCTest
import RealmSwift
@testable import AppForHealth
import CoreData

final class CaloriesTests: XCTestCase {
    private let caloriesInteractor = CaloriesInteractor()
    let realm = try! Realm()
    
    func testIncCountsOfProtFatsCarbs() {
        // Given
        let prot: Double = 150
        let value = ProductToday(value: ["i", 100, prot, 100, 100, 100, "", "", ""] as [Any])
        try! realm.write {
                realm.add(value)
        }
        let array: [ProductToday] = [value]
        // When
        caloriesInteractor.incCountsOfProtFatsCarbs(array: array)
        // Then
        XCTAssertEqual(prot, caloriesInteractor.countProt)
    }
    
    func testDetermePercents() {
        // Given
        caloriesInteractor.countProt = 200
        caloriesInteractor.maxProt = 400
        // When
        caloriesInteractor.determePercents()
        // Then
        XCTAssertEqual(0.5, caloriesInteractor.percentOfProt)
    }
    
    func testDetermeMaxValuesProtFatsCarbs() {
        // Given
        DefaultsManager.instance.setValue(value: "token", key: "token")
        
        let value = ProductToday(value: ["i", 100, 100, 100, 100, 100, "", "", "token"] as [Any])
        try! realm.write {
                realm.add(value)
        }
        let array: [ProductToday] = [value]
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                result.gender = Genders.man.rawValue
                result.goal = Goals.norma.rawValue
                result.age = 20
                result.height = 180
                result.weight = 80
                result.levelOfActivity = LevelOfActivityEnum.hight.rawValue
                result.imt = IMTEnum.norma.rawValue
                result.reccomendWater = 2000
                result.reccomendCcal = 2500
                result.token = "token"
            }
        } catch {
            print(error)
        }
        CoreDataManager.instance.saveContext()
        
        
        // When
        caloriesInteractor.determeMaxValuesProtFatsCarbs(array: array)
        // Then
        XCTAssertEqual(750, caloriesInteractor.maxProt)
    }
    
}

