//
//  ActiveButton.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 26.04.2023.
//

import UIKit

class MiniButton: UIButton {
    init() {
        super.init(frame: .zero)
        setTitleColor(UIColor.forJustText, for: .normal)
        backgroundColor = UIColor.noActiveColor
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor.forJustText, for: .normal)
        backgroundColor = UIColor.noActiveColor
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
