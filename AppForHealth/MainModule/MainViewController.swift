//
//  MainViewController.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import UIKit
//import Firebase

protocol MainViewProtocol: AnyObject {

}

class MainViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    var presenter: MainPresenterProtocol?
    
    var myCollectionView: UICollectionView?
    
    var helper = Helper()
    
    
    var exitButton = UIButton()
    
    //var mainScrollView = UIScrollView()
    //var mainCollectionView = UICollectionView()
    
    //var recipesButton = UIButton()
    
    var masButtons: [UIButton] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        //view.backgroundColor = .cyan

        
        //crateButton()
        
        //createScrollView(mainScrollView)

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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.bounds.width / 2 - 10, height: 100)
        //layout.minimumLineSpacing = 20
        
        myCollectionView?.backgroundColor = .black
        myCollectionView?.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: helper.identifier)
        myCollectionView?.delegate = self
        myCollectionView?.dataSource = self.helper
        
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
    }
    
}

extension MainViewController: MainViewProtocol {
    
//    func createScrollView(_ scrollView: UIScrollView) {
//        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(mainScrollView)
//
//        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
//        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//    }
    
    func crateButton() {
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exitButton)
        
        exitButton.addTarget(self, action: #selector(exitB), for: .touchUpInside)
        
        exitButton.setTitle("Выйти", for: .normal)
        
        exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exitButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        exitButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func exitB() {
        presenter?.didExit()

    }
}
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didTapRecipesButton()
    }
}
