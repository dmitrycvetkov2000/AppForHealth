//
//  MainButton.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 20.04.2023.
//

import UIKit


class MainButton: UIButton {

    init() {
        super.init(frame: .zero)
        setTitleColor(UIColor.forJustText, for: .normal)
        backgroundColor = UIColor.buttonBackColor
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor.forButtonBorder.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor.forJustText, for: .normal)
        backgroundColor = UIColor.buttonBackColor
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor.forButtonBorder.cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
