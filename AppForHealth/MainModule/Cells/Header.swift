//
//  Header.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.05.2023.
//

import UIKit

class Header: UICollectionReusableView {
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        addSubview(headerLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeader(sectionName: String) {
        headerLabel.text = sectionName
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        ])
    }
}

