//
//  MyCollectionViewCellForRecipes.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 29.12.2022.
//

import UIKit

class MyCollectionViewCellForRecipes: UICollectionViewCell {
    
    var labelForName = JustText()
    var image = UIImageView()
    
    let viewModelForButton = ButtonWithImageViewModel(title: "Подробнее о рецепте".localized(), imageName: "info.circle")
    let buttonForMoreInformation: ButtonWithImage = {
        let button = ButtonWithImage(frame: .zero)
        return button
    }()
    
    var index = 0
    
    var vc = RecipesVC()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        self.addSubview(image)
        self.addSubview(labelForName)
        self.addSubview(buttonForMoreInformation)

        setConstraintsForMoreInfoButton()
        setConstrainsForImage()

        setConstrainsForNameLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setLabelForName(name: String) {
        labelForName.textAlignment = .center
        labelForName.text = name        
    }

    func setImage(image: UIImage, completion: () -> Void) {
        self.image.image = image
        self.image.contentMode = .scaleAspectFit
        completion()
    }
    
    func setButton(vc: RecipesVC, index: Int) {
        buttonForMoreInformation.configure(with: viewModelForButton)
        
        buttonForMoreInformation.addTarget(self, action: #selector(showMoreAboutReceipts), for: .touchUpInside)
        self.vc = vc
        self.index = index
    }
    @objc func showMoreAboutReceipts() {
        let vc = MoreInformationModuleBuilder.build()
        
        vc.id = self.index
        vc.image = self.image.image ?? UIImage()
        print("index = \(self.index)")
        self.vc.present(vc, animated: true)
    }
    
    func setConstrainsForImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        image.topAnchor.constraint(equalTo: self.buttonForMoreInformation.bottomAnchor, constant: 10).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
    
    func setConstrainsForNameLabel() {
        labelForName.translatesAutoresizingMaskIntoConstraints = false
        
        labelForName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        labelForName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        labelForName.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive = true
    }
    
    func setConstraintsForMoreInfoButton() {
        buttonForMoreInformation.translatesAutoresizingMaskIntoConstraints = false
        
        buttonForMoreInformation.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        buttonForMoreInformation.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        buttonForMoreInformation.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        buttonForMoreInformation.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}



class UILabelWithInsets: UILabel {
    public var textInsets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            setNeedsDisplay() // вызывает drawText после установки отступов
        }
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}

