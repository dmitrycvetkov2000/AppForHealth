//
//  CellForMiniSection.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 03.05.2023.
//

import UIKit

class CellForMiniSection: UICollectionViewCell {
    private let miniImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let miniLabel: JustText = {
        let label = JustText()

        label.font = UIFont(name: "Vasek", size: 38)
        label.textInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLabel()
        setConstraints()
        
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 2
                layer.borderColor = UIColor.red.cgColor
            } else {
                layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    func setupView() {
        backgroundColor = .titleColor
        addSubview(miniImageView)
    }
    
    func setupLabel() {
        addSubview(miniLabel)
    }
    
    func configurateCell(imageName: String, labelText: String) {
        miniImageView.image = UIImage(named: imageName)
        miniLabel.text = labelText
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            miniImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            miniImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            miniImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            miniImageView.widthAnchor.constraint(equalTo: heightAnchor, constant: -10),

            miniLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            miniLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            miniLabel.leftAnchor.constraint(equalTo: miniImageView.rightAnchor, constant: 0),
            miniLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
            
        ])
    }
}
