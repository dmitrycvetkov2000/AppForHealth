//
//  MyCollectionViewCellForRecipes.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 29.12.2022.
//

import UIKit

class MyCollectionViewCellForRecipes: UICollectionViewCell {
    
    var labelForName = JustText()
    var labelForCalories = LabelTitle()
    var image = UIImageView()
    var labelForIngredients = JustText()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .brown
        
        self.addSubview(labelForCalories)
        self.addSubview(image)
        self.addSubview(labelForName)
        self.addSubview(labelForIngredients)

        setConstrainsForImage()
        setConstrainsForCaloriesLabel()
        setConstrainsForNameLabel()
        setConstrainsForIngredientsLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setLabelForName(name: String) {
        labelForName.textAlignment = .center
        labelForName.text = name
    }
    
    func setLabelIngredients(ingredients: String) {
        labelForIngredients.textInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: -4)

        labelForIngredients.adjustsFontSizeToFitWidth = true

        labelForIngredients.backgroundColor = .black
        labelForIngredients.textColor = .white
        
        labelForIngredients.text = ingredients
    }

    func setImage(url: String, completion: @escaping () -> Void) {
        
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Error handling...
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: imageData)
                    self.image.contentMode = .scaleToFill
                    completion()
                }
            }.resume()
        }
    }
    
    func setLabelCalories(calories: Int) {
        labelForCalories.adjustsFontSizeToFitWidth = true
        
        labelForCalories.text = String("\(calories) " + "калорий".localized())
    }

    
    func setConstrainsForImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -230).isActive = true
        image.topAnchor.constraint(equalTo: labelForCalories.bottomAnchor, constant: 0).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
    
    func setConstrainsForNameLabel() {
        labelForName.translatesAutoresizingMaskIntoConstraints = false
        
        labelForName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        labelForName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelForName.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive = true
    }
    
    func setConstrainsForIngredientsLabel() {
        labelForIngredients.translatesAutoresizingMaskIntoConstraints = false

        labelForIngredients.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelForIngredients.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        labelForIngredients.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        labelForIngredients.topAnchor.constraint(equalTo: labelForName.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    func setConstrainsForCaloriesLabel() {
        labelForCalories.translatesAutoresizingMaskIntoConstraints = false

        labelForCalories.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelForCalories.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        labelForCalories.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
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

