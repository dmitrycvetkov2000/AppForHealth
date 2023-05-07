//
//  MockData.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 03.05.2023.
//

import Foundation

class MockData: NSObject {
    
    var model: ModelOfDataMain?
    var menuScrollMain: ListSection?
    var menuScrollButtons: ListSection?
    var menuScrollMini: ListSection?
    
    
    init(model: ModelOfDataMain) {
        self.model = model
        
        menuScrollMini = {
            .menuScrollMini([.init(title: "Мои параметры", image: model.imageParametry, description: ""),
                             .init(title: "ИМТ", image: model.imageIMT, description: ""),
                             .init(title: "Рекомендации по калориям", image: model.imageCcal, description: ""),
                             .init(title: "Рекомендации по воде", image: model.imageWater, description: "")
                            ])
        }()
        
        menuScrollButtons = {
            .buttons([.init(title: "Рецепты", image: "Рецепты", description: ""),
                             .init(title: "Вода", image: "Вода", description: ""),
                             .init(title: "Тренировка", image: "Тренировка", description: ""),
                             .init(title: "Калории", image: "Калории", description: ""),
                             .init(title: "Карта", image: "Карта", description: ""),
                             .init(title: "Настройки", image: "Настройки", description: "")
                            ])
        }()
        
        menuScrollMain = {
            .menuScrollMain([.init(title: "Мои параметры", image: "", description: "\(model.genderAndAge)\n\(model.heightAndWeight)\nВы можете изменить свои параметры в настройках"),
                             .init(title: "Индекс массы тела", image: "", description: "\(model.imt)\nИМТ позволяет оценить степень соответствия массы и роста и определяет в норме ли Ваша масса"),
                             .init(title: "Рекомендации по калориям", image: "", description: "\(model.reccomnedCcal)"),
                             .init(title: "Рекомендации по воде", image: "", description: "\(model.reccomnedWater)")
            ])
        }()
        
    }
    
    var pageData: [ListSection] {
        [menuScrollMini!, menuScrollButtons!, menuScrollMain!]
    }
}
