//
//  MainViewController.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {

}

class MainViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    var presenter: MainPresenterProtocol?
    
    var myCollectionView: UICollectionView?
    
    var helper = Helper()
    
    var masButtons: [UIButton] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setCollectView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myCollectionView?.frame = view.bounds
        setCollectView()
        
    }
    
    func setCollectView(){
        view.addSubview(myCollectionView ?? UICollectionViewCell())
        
        var layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.bounds.width / 2 - 10, height: 100)
        
        myCollectionView?.backgroundColor = .black
        myCollectionView?.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: helper.identifier)
        myCollectionView?.delegate = self
        myCollectionView?.dataSource = self.helper
        
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
    }
    
}

extension MainViewController: MainViewProtocol {
    
}
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            presenter?.didTapRecipesButton()
        }
        if indexPath.row == 1 {
            presenter?.didTapWaterButton()
        }
        if indexPath.row == 2 {
            presenter?.didTapSettingsButton()
        }
        
    }
}
