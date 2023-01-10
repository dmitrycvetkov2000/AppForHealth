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
    
        ApiManager.shared.getInfo { recipes in
            
 
            for j in 0..<(recipes.hits?.count ?? 0) {
                for i in 0..<(recipes.hits?[j].recipe?.ingredients?.count ?? 0) {
                    if i == 0 {
                        self.stroke.insert((recipes.hits?[j].recipe?.ingredients?[i].text ?? "Null"), at: j)
                    } else {
                        self.stroke[j].append((", \(recipes.hits?[j].recipe?.ingredients?[i].text ?? "Null")" ))
                    }
                }
                self.strIng.insert(self.stroke[j], at: j)
                self.helper.model.ingredients.insert(self.strIng[j], at: j)
                
                self.helper.model.nameOfFood.insert(recipes.hits?[j].recipe?.label, at: j)
                
                self.helper.model.calories.insert(Int(recipes.hits?[j].recipe?.calories ?? 0), at: j)
                
                self.helper.model.imageOfFoodUrl.insert(recipes.hits?[j].recipe?.image, at: j)
            }
            
            DispatchQueue.main.async {
                self.setCollectView()
            }
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myCollectionView?.frame = view.bounds
        setCollectView()
    }
    
    
    func setCollectView() {
        view.addSubview(myCollectionView ?? UICollectionViewCell())
        
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height)

        myCollectionView?.backgroundColor = .white
        myCollectionView?.register(MyCollectionViewCellForRecipes.self, forCellWithReuseIdentifier: helper.identifier)
        myCollectionView?.dataSource = self.helper
        
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
    }
}

extension RecipesVC: RecipesVCProtocol {
    
}
