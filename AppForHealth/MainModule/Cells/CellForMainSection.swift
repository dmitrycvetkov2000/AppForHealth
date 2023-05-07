//
//  CellForMainSection.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 03.05.2023.
//

import UIKit

class CellForMainSection: UICollectionViewCell {
    
    private let mainLabelTitle: LabelTitle = {
        let label = LabelTitle()
        label.font = UIFont(name: "RubikBubbles-Regular", size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mainLabelDescription: JustText = {
        let label = JustText()
        label.font = UIFont(name: "Vasek", size: 38)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLabelTitle()
        setupLabelDescription()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabelTitle() {
        addSubview(mainLabelTitle)
    }
    
    func setupLabelDescription() {
        addSubview(mainLabelDescription)
    }
    
    
    func configurateCell(labelText: String, descriptionText: String) {
        mainLabelTitle.text = labelText
        mainLabelDescription.text = descriptionText
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            mainLabelTitle.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            mainLabelTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            mainLabelTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            
            mainLabelDescription.topAnchor.constraint(equalTo: mainLabelTitle.bottomAnchor, constant: 0),
            mainLabelDescription.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            mainLabelDescription.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
        ])
    }
}
