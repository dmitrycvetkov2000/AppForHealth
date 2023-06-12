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
    func reloadCollectView()
    
    func setupCollectViewOnFirstCell()
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
    
    var scrollView = UIScrollView()
    var stackView = UIStackView()
    var buttonForDesserts = MiniButton()
    var buttonForBreakfast = MiniButton()
    var buttonForLaunch = MiniButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helper.viewController = self
        presenter?.setNavigationItems()
        
        presenter?.setBlurEffect()
        presenter?.setSpinnerAndStart()
        view.backgroundColor = .brown

        presenter?.getRequest(helper: helper, type: ApiType.getReceipeForSoup)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createScrollView()
        self.setCollectView()
    }
    
    func createScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.alwaysBounceHorizontal = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.frame = CGRect(x: 0, y: navigationController!.navigationBar.frame.height + navigationController!.navigationBar.frame.minY + 10, width: view.bounds.width, height: 40)
        scrollView.contentSize = CGSize(width: view.bounds.width + 60, height: 0)
        
        stackView.frame = scrollView.frame
        stackView.frame.origin = CGPoint(x: 10, y: 0)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        addButtonsInStackView(title: "Обеды".localized(), button: buttonForBreakfast)
        addButtonsInStackView(title: "Ужины".localized(), button: buttonForLaunch)
        addButtonsInStackView(title: "Десерты".localized(), button: buttonForDesserts)
        
        buttonForBreakfast.addTarget(self, action: #selector(changeDataCollectViewBreakfast), for: .touchUpInside)
        buttonForLaunch.addTarget(self, action: #selector(changeDataCollectViewLaunch), for: .touchUpInside)
        buttonForDesserts.addTarget(self, action: #selector(changeDataCollectViewDeserts), for: .touchUpInside)
        
        buttonForBreakfast.clipsToBounds = true
        buttonForLaunch.clipsToBounds = true
        buttonForDesserts.clipsToBounds = true
    }
    func addButtonsInStackView(title: String, button: UIButton) {
        button.setTitle(title, for: .normal)
        buttonForBreakfast.backgroundColor = .activeColor
        buttonForBreakfast.isUserInteractionEnabled = false
        stackView.addArrangedSubview(button)
    }
    @objc func changeDataCollectViewBreakfast() {
            print("buttonForBreakfast")
        presenter?.setBlurEffect()
        presenter?.setSpinnerAndStart()
        changeActiveButton(button: buttonForBreakfast)
        presenter?.getRequest(helper: helper, type: ApiType.getReceipeForSoup)
    }
    @objc func changeDataCollectViewLaunch() {
            print("buttonForLaunch")
        presenter?.setBlurEffect()
        presenter?.setSpinnerAndStart()
        changeActiveButton(button: buttonForLaunch)
        presenter?.getRequest(helper: helper, type: ApiType.getReceipeForLaunch)
    }
    @objc func changeDataCollectViewDeserts() {
            print("buttonForDesserts")
        presenter?.setBlurEffect()
        presenter?.setSpinnerAndStart()
        changeActiveButton(button: buttonForDesserts)
        presenter?.getRequest(helper: helper, type: ApiType.getReceipeForDessert)
    }
    func changeActiveButton(button: MiniButton) {
        buttonForBreakfast.backgroundColor = .noActiveColor
        buttonForBreakfast.isUserInteractionEnabled = true
        buttonForLaunch.backgroundColor  = .noActiveColor
        buttonForLaunch.isUserInteractionEnabled = true
        buttonForDesserts.backgroundColor  = .noActiveColor
        buttonForDesserts.isUserInteractionEnabled = true
        
        button.backgroundColor = .activeColor
        button.isUserInteractionEnabled = false
    }
    
    func setCollectView() {
        myCollectionView?.removeFromSuperview()
        myCollectionView = nil
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height - scrollView.frame.height - 10)
        myCollectionView = UICollectionView(frame: CGRect(x: 0, y: scrollView.frame.maxY + 10, width: view.bounds.width, height: view.bounds.height - scrollView.frame.height - 10), collectionViewLayout: layout)
        view.addSubview(myCollectionView ?? UICollectionView())
        myCollectionView?.backgroundColor = .clear
        myCollectionView?.register(MyCollectionViewCellForRecipes.self, forCellWithReuseIdentifier: helper.identifier)
        myCollectionView?.dataSource = self.helper
        myCollectionView?.delegate = self.helper
        myCollectionView?.bounces = false
    }
}



extension RecipesVC: RecipesVCProtocol {
    func setupCollectViewOnFirstCell() {
        self.myCollectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
                                            at: .left,
                                            animated: true)
    }
    
    
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
    
    func reloadCollectView() {
        self.myCollectionView?.reloadData()
    }
}
