//
//  CellForButtons.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.05.2023.
//

import UIKit

class CellForButtons: UICollectionViewCell {
    private let miniImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let miniLabel: JustText = {
        let label = JustText()
        label.font = UIFont(name: "Vasek", size: 36)
        label.textColor = .forJustText
        label.textInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLabel()
        setConstraints()
        
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .tabBarMainColor
        addSubview(miniImageView)
    }
    
    func setupLabel() {
        addSubview(miniLabel)
    }
    
    func configurateCell(imageName: String, labelText: String) {
        miniImageView.image = UIImage(named: imageName)
        miniLabel.text = labelText
        miniLabel.textColor = .black
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            miniImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            miniImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            miniImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            miniImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),

            miniLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            miniLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            miniLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            miniLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
            
        ])
    }
}
