//
//  ListSection.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 03.05.2023.
//

import Foundation

enum ListSection {
    case menuScrollMini([ListItem])
    case buttons([ListItem])
    case menuScrollMain([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .menuScrollMini(let items),
                .buttons(let items),
                .menuScrollMain(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
    var headerTitle: String {
        switch self {
        case .menuScrollMini(_):
            return "Сведения о Вас".localized()
        case .buttons(_):
            return "Функции приложения".localized()
        case .menuScrollMain(_):
            return ""
        }
    }
}
