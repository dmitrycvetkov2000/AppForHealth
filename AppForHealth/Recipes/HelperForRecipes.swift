//
//  HelperForRecipes.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 29.12.2022.
//

import UIKit

protocol DataForCollect {
    var images: [UIImage?] { get set }
    
    var nameOfFood: [String?] { get set }
    
    var id: [Int?] { get set }
}

class HelperForRecipes: NSObject {
    
    let identifier = "cellForRecipes"
    
    //var model = ModelOfDataForCollectionViewRecipes()
    
    var modelForReceipts: DataForCollect? = ModelForReceipts()
    
    weak var viewController: RecipesVC?
    
    lazy var spinnerOnView: CustomSpinnerSimple = {
        let spinner = CustomSpinnerSimple(squareLength: 100)
        return spinner
    }()
}


extension HelperForRecipes: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        modelForReceipts?.id.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MyCollectionViewCellForRecipes
//        if modelForDinner.ingredients.count ?? 0 > indexPath.item {
//            cell?.setLabelIngredients(ingredients: modelForDinner.ingredients[indexPath.item] ?? "")
//        }
        if modelForReceipts?.nameOfFood.count ?? 0 > indexPath.item {
            cell?.setLabelForName(name: modelForReceipts?.nameOfFood[indexPath.item] ?? "")
        }
        if modelForReceipts?.images.count ?? 0 > indexPath.item {
                //cell?.addSubview(self.spinnerOnView)
                //self.spinnerOnView.startAnimation(delay: 0.04, replicates: 20)
            if let image = self.modelForReceipts?.images[indexPath.item] {
                cell?.setImage(image: image, completion: {
                })
            }
        }
        
        cell?.setButton(vc: viewController ?? UIViewController(), index: modelForReceipts?.id[indexPath.item] ?? 0)
        
        cell?.backgroundColor = .brown
        if indexPath.item == 0 {
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
        
    return cell ?? UICollectionViewCell()
    }
    
}
