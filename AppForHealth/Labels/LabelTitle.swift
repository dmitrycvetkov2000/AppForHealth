//
//  LabelTitle.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 20.04.2023.
//

import UIKit

class LabelTitle: UILabelWithInsets {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont(name: "RubikBubbles-Regular", size: 44)
        numberOfLines = 0

        textAlignment = .center
        textColor = UIColor.titleColor
    }
    
    init(title: String) {
        super.init(frame: .zero)

        font = UIFont(name: "RubikBubbles-Regular", size: 44)
        numberOfLines = 0
        
        textAlignment = .center
        
        text = title
        
        textColor = UIColor.titleColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
