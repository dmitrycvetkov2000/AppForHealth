//
//  MenuVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 16.03.2023.
//

import UIKit


class MenuVC: UIViewController {
    var helper = Helper()
    lazy var myCollectionView = UICollectionView()
    var navVC: UINavigationController?

    let hideSideMenuButton = UIButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        navVC = UINavigationController(rootViewController: self)

        view.insertSubview(navVC!.view, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateNavItems()

        configurationCollectionView()

        view.backgroundColor = #colorLiteral(red: 0.4520246983, green: 0.2730536163, blue: 0.02726845257, alpha: 1)
    }
    
    func configurateNavItems() {
        hideSideMenuButton.translatesAutoresizingMaskIntoConstraints = false
        hideSideMenuButton.clipsToBounds = true
        hideSideMenuButton.widthAnchor.constraint(equalToConstant: 61).isActive = true
        hideSideMenuButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        hideSideMenuButton.layer.cornerRadius = 0.5 * hideSideMenuButton.bounds.size.width

        hideSideMenuButton.setBackgroundImage(UIImage(systemName: "line.horizontal.3.circle.fill"), for: .normal)
        hideSideMenuButton.tintColor = .tabBarMainColor

        let rightBarButtonItem = UIBarButtonItem(customView: hideSideMenuButton)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func configurationCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: self.view.frame.width - (self.view.frame.width - 140), bottom: 0, right: 0)

        layout.itemSize = CGSize(width: self.view.frame.width - 140, height: 100)
        layout.scrollDirection = .vertical

        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        myCollectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)

        myCollectionView.translatesAutoresizingMaskIntoConstraints = false

        myCollectionView.dataSource = self.helper
        myCollectionView.delegate = self.helper

        myCollectionView.backgroundColor = #colorLiteral(red: 0.4520246983, green: 0.2730536163, blue: 0.02726845257, alpha: 1)

        navVC!.view.addSubview(myCollectionView)
        NSLayoutConstraint.activate([
            myCollectionView.bottomAnchor.constraint(equalTo: navVC!.view.bottomAnchor, constant: 0),
            myCollectionView.topAnchor.constraint(equalTo: navVC!.navigationBar.bottomAnchor, constant: 0),
            myCollectionView.leftAnchor.constraint(equalTo: navVC!.view.leftAnchor, constant: 0),
            myCollectionView.rightAnchor.constraint(equalTo: navVC!.view.rightAnchor, constant: 0)
        ])

    }
}


