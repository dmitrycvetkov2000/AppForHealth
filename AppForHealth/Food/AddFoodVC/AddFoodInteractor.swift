//
//  AddFoodInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import Foundation

protocol AddFoodInteractorProtocol: AnyObject {
    func findMultiple(weight: Double)
}
class AddFoodInteractor {
    weak var presenter: AddFoodPresenterProtocol?
}

extension AddFoodInteractor: AddFoodInteractorProtocol {
    func findMultiple(weight: Double) {
        var result: Double? = nil
        result = weight / 100
        
        let prot = UserDefaults.standard.string(forKey: KeysForPFCC.proteins.rawValue)
        let fats = UserDefaults.standard.string(forKey: KeysForPFCC.fats.rawValue)
        let carb = UserDefaults.standard.string(forKey: KeysForPFCC.carb.rawValue)
        let ccal = UserDefaults.standard.string(forKey: KeysForPFCC.ccal.rawValue)
        
        if let prot = Double(prot ?? "0.0"), let fats = Double(fats ?? "0.0"), let carb = Double(carb ?? "0.0"), let ccal = Double(ccal ?? "0.0"), let res = result {
            let p = prot * result!
            let f = fats * result!
            let c = carb * result!
            let cc = ccal * result!
            
            presenter?.fillTextFields(res: res, prot: p, fat: f, carb: c, ccal: cc)
        }
    }
}
