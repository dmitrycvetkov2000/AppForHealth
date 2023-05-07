//
//  AllEnums.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 17.03.2023.
//

import Foundation

enum AllCasesEnums {
    case goals(goal: Goals)
    case genders(gender: Genders)
    case imtEnum(imt: IMTEnum)
    case keysForPFCC(parametr: KeysForPFCC)
    case statusOfUser(status: StatusOfUser)
    case levelOfActivityEnum(activity: LevelOfActivityEnum)
    
    var value: String {
        switch self {
        case .goals(goal: let goal):
            switch goal {
            case .leaveWeight:
                return "Похудеть"
            case .norma:
                return "Норма"
            case .weightUp:
                return "Набрать"
            }
        case .genders(gender: let gender):
            switch gender {
            case .man:
                return "Мужчина"
            case .woman:
                return "Женщина"
            }
        case .imtEnum(imt: let imt):
            switch imt {
            case .underWeight:
                return "ИМТ: Недовес"
            case .norma:
                return "ИМТ: В норме"
            case .excessWeight:
                return "ИМТ: Избыточный вес"
            case .overWeight:
                return "ИМТ: Ожирение"
            case .notSuccess:
                return "ИМТ: Не выявлен"
            }
        case .keysForPFCC(parametr: let parametr):
            switch parametr {
            case .proteins:
                return "proteins"
            case .fats:
                return "fats"
            case .carb:
                return "carb"
            case .ccal:
                return "ccal"
            }
        case .statusOfUser(status: let status):
            switch status {
            case .isNewUser:
                return "IsNewUser"
            }
        case .levelOfActivityEnum(activity: let activity):
            switch activity {
            case .low:
                return "Низкий"
            case .middle:
                return "Средний"
            case .hight:
                return "Высокий"
            }
        }
    
    }
}


enum Goals: String {
    case leaveWeight = "Похудеть"
    case norma = "Норма"
    case weightUp = "Набрать"
}

enum Genders: String {
    case man = "Мужчина"
    case woman = "Женщина"
}

enum IMTEnum: String {
    case underWeight = "ИМТ: Недовес"
    case norma = "ИМТ: В норме"
    case excessWeight = "ИМТ: Избыточный вес"
    case overWeight = "ИМТ: Ожирение"
    
    case notSuccess = "ИМТ: Не выявлен"
}

enum KeysForPFCC: String {
    case proteins = "proteins"
    case fats = "fats"
    case carb = "carb"
    case ccal = "ccal"
}

enum StatusOfUser: String {
    case isNewUser = "IsNewUser"
}

enum LevelOfActivityEnum: String {
    case low = "Низкий"
    case middle = "Средний"
    case hight = "Высокий"
}
