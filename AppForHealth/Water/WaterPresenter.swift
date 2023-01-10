//
//  WaterPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 08.01.2023.
//

import UIKit
import CoreData

protocol WaterPresenterProtocol: AnyObject {
    func viewDidLoaded()
    
    func countingTheAmountOfWater() -> Int
    
}

class WaterPresenter {
    
    weak var view: WaterVCProtocol?
    var router: WaterRouterProtocol
    var interactor: WaterInteractorProtocol
    
    init(interactor: WaterInteractorProtocol, router: WaterRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension WaterPresenter: WaterPresenterProtocol {
    func viewDidLoaded() {
        
    }
    
    func countingTheAmountOfWater() -> Int {
        var numberML: Int16? = 0
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                numberML = result.numberOfWater
            }
        } catch {
            print(error)
        }
        return Int(numberML ?? 0)
    }
}
