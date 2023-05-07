//
//  MainScreenLabel.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 26.04.2023.
//

import UIKit

class MainScreenLabel: UILabelWithInsets {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        font = UIFont(name: "Vasek", size: 42)
        numberOfLines = 0
        
        textAlignment = .left
        
        textColor = UIColor.forJustText
        
    }

    init(title: String) {
        super.init(frame: .zero)
        
        textInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        font = UIFont(name: "Vasek", size: 42)
        numberOfLines = 0
        
        textAlignment = .left
        
        text = title
        
        textColor = UIColor.forJustText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
