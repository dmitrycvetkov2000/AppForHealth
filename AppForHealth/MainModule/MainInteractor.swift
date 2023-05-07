//
//  MainInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import Foundation
import CoreData

protocol MainInteractorProtocol: AnyObject {
    func getData<T>(name: String) -> T?
    func checkIMTAndDetermSmile(imt: String) -> String
}

class MainInteractor: MainInteractorProtocol {

    weak var presenter: MainPresenterProtocol?
    
    func getData<T>(name: String) -> T? {
        CoreDataManager.instance.getElementFromBD(find: name)
    }
    
    func checkIMTAndDetermSmile(imt: String) -> String {
        switch imt {
        case "":
            return "🤷‍♂️"
        case IMTEnum.underWeight.rawValue:
            return "🪫"
        case IMTEnum.norma.rawValue:
            return "👍🏽"
        case IMTEnum.excessWeight.rawValue:
            return "🤏🏽"
        case IMTEnum.overWeight.rawValue:
            return "⚠️"
        default:
            return "⛔️"
        }
    }
}
