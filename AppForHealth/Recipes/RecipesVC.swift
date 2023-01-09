//
//  RecipesVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 28.12.2022.
//
import UIKit

protocol RecipesVCProtocol: AnyObject {
    
}

class RecipesVC: UIViewController {
    var presenter: RecipesPresenterProtocol?
    
    var myCollectionView: UICollectionView?
    
    //var model = ModelOfDataForCollectionViewRecipes()
    
    var helper = HelperForRecipes()
    
    var strIng = [String]()
    
    var stroke = [String]()
    

    private lazy var spinner: CustomSpinnerSimple = {
            let spinner = CustomSpinnerSimple(squareLength: 100)
            return spinner
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
        
        print("SSSSSSSSS")
//        DispatchQueue.main.async {
//            //self.view.addSubview(self.spinner)
//            self.view.bringSubviewToFront(self.spinner)
//            self.spinner.startAnimation(delay: 0.04, replicates: 20)
//        }
        ApiManager.shared.getInfo { recipes in
            
 
            for j in 0..<(recipes.hits?.count ?? 0) {
                for i in 0..<(recipes.hits?[j].recipe?.ingredients?.count ?? 0) {
                    //print(recipes.hits?[j].recipe?.ingredients?[i].text)
                    if i == 0 {
                        self.stroke.insert((recipes.hits?[j].recipe?.ingredients?[i].text ?? "Null"), at: j)
                    } else {
                        self.stroke[j].append((", \(recipes.hits?[j].recipe?.ingredients?[i].text ?? "Null")" ))
                    }
                }
                print("RRRRRREEEE \(self.stroke[j])")
                self.strIng.insert(self.stroke[j], at: j)
                self.helper.model.ingredients.insert(self.strIng[j], at: j)
                
                self.helper.model.nameOfFood.insert(recipes.hits?[j].recipe?.label, at: j)
                
                self.helper.model.calories.insert(Int(recipes.hits?[j].recipe?.calories ?? 0), at: j)
                
                self.helper.model.imageOfFoodUrl.insert(recipes.hits?[j].recipe?.image, at: j)
            }
            
            DispatchQueue.main.async {
                self.setCollectView()
//                self.view.bringSubviewToFront(self.spinner)
//                self.spinner.startAnimation(delay: 0.04, replicates: 20)
            }
            
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myCollectionView?.frame = view.bounds
        setCollectView()

    }
    
    
    func setCollectView() {
        //myCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(myCollectionView ?? UICollectionViewCell())
        
        
//        myCollectionView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//        myCollectionView?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
//        myCollectionView?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//        myCollectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        //layout.minimumLineSpacing = 20

        
        myCollectionView?.backgroundColor = .white
        myCollectionView?.register(MyCollectionViewCellForRecipes.self, forCellWithReuseIdentifier: helper.identifier)
        //myCollectionView?.delegate = self
        myCollectionView?.dataSource = self.helper
        
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
    }
}

extension RecipesVC: RecipesVCProtocol {
    
}
