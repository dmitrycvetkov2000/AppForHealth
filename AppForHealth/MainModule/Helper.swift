//
//  Helper.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 28.12.2022.
//

import UIKit

class Helper: NSObject {
    
    let identifier = "cell"
    
    var model = ModelOfDataForCollectionView()
    
    weak var viewController: MainViewController?
}


extension Helper: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.number.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MyCollectionViewCell
//        if model.number.count > indexPath.item {
//            cell?.setLabelForNumber(number: model.number[indexPath.item] ?? "")
//        }
        if model.name.count > indexPath.item {
            cell?.setLabelForName(name: model.name[indexPath.item] ?? "")
        }
        if model.image.count > indexPath.item {
            if let image = model.image[indexPath.item]{
                cell?.setImage(image: image)
            }
        }
        cell?.backgroundColor = .clear
        return cell ?? UICollectionViewCell()
    }
}
