//
//  MyTextField.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 21.04.2023.
//

import UIKit

class MyTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 10
        backgroundColor = #colorLiteral(red: 0.4380294085, green: 0.3144482672, blue: 0.7371886373, alpha: 1)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
