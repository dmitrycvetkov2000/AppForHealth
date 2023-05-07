//
//  Extention + String.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 01.05.2023.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
