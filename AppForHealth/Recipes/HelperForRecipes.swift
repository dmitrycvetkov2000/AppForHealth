//
//  HelperForRecipes.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 29.12.2022.
//

import UIKit

class HelperForRecipes: NSObject {
    
    let identifier = "cellForRecipes"
    
    var model = ModelOfDataForCollectionViewRecipes()
    
    weak var viewController: RecipesVC?
    
    lazy var spinnerOnView: CustomSpinnerSimple = {
        let spinner = CustomSpinnerSimple(squareLength: 100)
        return spinner
    }()
}


extension HelperForRecipes: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MyCollectionViewCellForRecipes
        if model.ingredients.count > indexPath.item {
            cell?.setLabelIngredients(ingredients: model.ingredients[indexPath.item] ?? "")
        }
        if model.nameOfFood.count > indexPath.item {
            cell?.setLabelForName(name: model.nameOfFood[indexPath.item] ?? "")
        }
        if model.imageOfFoodUrl.count > indexPath.item {
            cell?.addSubview(spinnerOnView)
            spinnerOnView.startAnimation(delay: 0.04, replicates: 20)
            if let imageUrl = model.imageOfFoodUrl[indexPath.item] {
                cell?.setImage(url: imageUrl, completion: { [weak self] in
                    self?.spinnerOnView.stopAnimation()
                    self?.spinnerOnView.removeFromSuperview()
                })
            }
        }
        if model.calories.count > indexPath.item {
            cell?.setLabelCalories(calories: model.calories[indexPath.item] ?? 0)
        }
        
        cell?.backgroundColor = .brown
        return cell ?? UICollectionViewCell()
    }
}
