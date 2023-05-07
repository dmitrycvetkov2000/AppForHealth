//
//  Helper.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 28.12.2022.
//

import UIKit

class Helper: NSObject {
    
    var model = ModelOfDataForCollectionView()
    
    var presenter: MainTabBarPresenterProtocol?
    
}


extension Helper: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.name.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as? MyCollectionViewCell
        if model.name.count > indexPath.item {
            cell?.setLabelForName(name: model.name[indexPath.item] ?? "")
        }
        if model.image.count > indexPath.item {
            if let image = model.image[indexPath.item]{
                cell?.setImage(image: image)
            }
        }
        cell?.backgroundColor = .brown
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.HideSideMenu()
        if indexPath.row == 0 {
            presenter?.didTapRecipesButton()
        }
        if indexPath.row == 1 {
            presenter?.didTapWaterButton()
        }
        if indexPath.row == 2 {
            presenter?.didTapTrainButton()
        }
        if indexPath.row == 3 {
            presenter?.didTapCaloriesButton()
        }
        if indexPath.row == 4 {
            presenter?.didTapMapButton()
        }
        if indexPath.row == 5 {
            presenter?.didTapSettingsButton()
        }
        
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 3
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 140 - 6, height: collectionView.bounds.height / CGFloat(5))
    }
}

