//
//  JustText.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 20.04.2023.
//

import UIKit

class JustText: UILabelWithInsets {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        font = UIFont(name: "Vasek", size: 40)
        numberOfLines = 0
        
        textAlignment = .left
        
        textColor = UIColor.forJustText
        
    }

    init(title: String) {
        super.init(frame: .zero)

        font = UIFont(name: "Vasek", size: 40)
        numberOfLines = 0
        
        textAlignment = .left
        
        text = title
        
        textColor = UIColor.forJustText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
