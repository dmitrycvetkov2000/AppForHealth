//
//  RecipesVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 28.12.2022.
//
import UIKit

protocol RecipesVCProtocol: AnyObject {
    func configureNavigationItems()
    func setBlurEffect()
    func setSpinnerAndStart()
    func removeSpinnerAndBlurEffect()
    
    func setSpinnerOnView()
}

class RecipesVC: UIViewController {
    var presenter: RecipesPresenterProtocol?
    
    var myCollectionView: UICollectionView?
    
    var helper = HelperForRecipes()
    
    var strIng = [String]()
    
    var stroke = [String]()
    
    let leftButton = UIButton()
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }()
    
    private lazy var spinner: CustomSpinnerSimple = {
        let spinner = CustomSpinnerSimple(squareLength: 100)
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helper.viewController = self
        presenter?.setNavigationItems()
        presenter?.setBlurEffect()
        presenter?.setSpinnerAndStart()
        view.backgroundColor = .brown
    
        ApiManager.shared.getInfo { recipes in
            DispatchQueue.main.async {
                self.setCollectView()
                self.presenter?.removeSpinnerAndBlurEffect()
            }
 
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
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myCollectionView?.frame = view.bounds
        setCollectView()
    }
    
    func setCollectView() {
        view.addSubview(myCollectionView ?? UICollectionViewCell())
        
        let layout = UICollectionViewFlowLayout()
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
    func configureNavigationItems() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.clipsToBounds = true
        leftButton.widthAnchor.constraint(equalToConstant: 61).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        leftButton.layer.cornerRadius = 0.5 * leftButton.bounds.size.width
        
        leftButton.setBackgroundImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
        leftButton.tintColor = .tabBarMainColor
        leftButton.addTarget(self, action: #selector(returnInMain), for: .touchUpInside)
        
        let leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func returnInMain() {
        presenter?.didTapLeftButton()
    }
    
    func setBlurEffect() {
        blurEffectView.alpha = 0.8
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    func setSpinnerAndStart() {
        view.addSubview(spinner)
        spinner.startAnimation(delay: 0.04, replicates: 20)
    }
    
    func removeSpinnerAndBlurEffect() {
        spinner.stopAnimation()
        spinner.removeFromSuperview()
        blurEffectView.removeFromSuperview()
    }
    
    func setSpinnerOnView() {
        
    }
}
