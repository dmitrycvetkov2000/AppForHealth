//
//  MyCollectionViewCellForRecipes.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 29.12.2022.
//

import UIKit

class MyCollectionViewCellForRecipes: UICollectionViewCell {
    
    var labelForName = UILabel()
    var labelForCalories = UILabel()
    var image = UIImageView()
    var labelForIngredients = UILabelWithInsets()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .green
        
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
        
        //labelForName.adjustsFontSizeToFitWidth = true
        
        labelForName.font = UIFont(name: "Vasek", size: 1000)
        labelForName.numberOfLines = 1
        labelForName.adjustsFontSizeToFitWidth = true
        
        //labelForName.adjustsFontSizeToFitWidth = true
        //labelForName.numberOfLines = 1
        labelForName.textAlignment = .center
        labelForName.text = name
        
        //labelForName.font =
        labelForName.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
    
    func setLabelIngredients(ingredients: String) {
        labelForIngredients.textInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        labelForIngredients.backgroundColor = .black
        labelForIngredients.font = UIFont(name: "Vasek", size: 1000)
        labelForIngredients.numberOfLines = 0
        labelForIngredients.adjustsFontSizeToFitWidth = true
        
        labelForIngredients.textAlignment = .left
        labelForIngredients.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        labelForIngredients.text = ingredients
        
    }
    
    func setImage(url: String) {
                    
            if let url = URL(string: url) {
               URLSession.shared.dataTask(with: url) { (data, response, error) in
                 // Error handling...
                 guard let imageData = data else { return }

                 DispatchQueue.main.async {
                     self.image.image = UIImage(data: imageData)
                     self.image.contentMode = .scaleAspectFill
                 }
               }.resume()
             }
    }
    
    func setLabelCalories(calories: Double) {
        //labelForIngredients.textInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        labelForCalories.backgroundColor = .black
        labelForCalories.font = UIFont(name: "Vasek", size: 1000)
        labelForCalories.numberOfLines = 1
        labelForCalories.adjustsFontSizeToFitWidth = true
        
        labelForCalories.textAlignment = .center
        labelForCalories.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        labelForCalories.text = String(calories)
        
    }

    
    func setConstrainsForImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -230).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100).isActive = true
    }
    
    func setConstrainsForNameLabel() {
        labelForName.translatesAutoresizingMaskIntoConstraints = false
        
        
        labelForName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        labelForName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelForName.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive = true
        labelForName.heightAnchor.constraint(equalToConstant: 80).isActive = true
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
        labelForCalories.bottomAnchor.constraint(equalTo: image.topAnchor, constant: 0).isActive = true
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
