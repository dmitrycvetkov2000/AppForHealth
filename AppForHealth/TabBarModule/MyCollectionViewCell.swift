//
//  MyCollectionViewCell.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 28.12.2022.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyCollectionViewCell"
    
    var labelForName = JustText()
    var image = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(image)
        self.addSubview(labelForName)

        setConstrainsForImage()
        setConstrainsForNameLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setLabelForName(name: String) {
        labelForName.font = UIFont(name: "FiraSans-Bold", size: 36)
        labelForName.textAlignment = .center
        labelForName.text = name
        
        labelForName.textColor = .forJustText
    }
    
    func setImage(image: String) {
        self.image.image = UIImage(named: image)
        self.image.contentMode = .scaleAspectFit
    }
    
    func setConstrainsForNameLabel() {
        labelForName.translatesAutoresizingMaskIntoConstraints = false
        
        labelForName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        labelForName.heightAnchor.constraint(equalToConstant: 80).isActive = true
        labelForName.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        labelForName.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        labelForName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
    
    func setConstrainsForImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
}
