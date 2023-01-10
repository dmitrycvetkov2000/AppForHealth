//
//  MyCollectionViewCell.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 28.12.2022.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    var labelForName = UILabel()
    var image = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.addSubview(image)
        self.addSubview(labelForName)
        
        setConstrainsForImage()
        setConstrainsForNameLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setLabelForName(name: String) {
        
        labelForName.font = UIFont(name: "Vasek", size: 1000)
        labelForName.numberOfLines = 1
        labelForName.adjustsFontSizeToFitWidth = true
        
        labelForName.textAlignment = .center
        labelForName.text = name
        
        labelForName.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
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
