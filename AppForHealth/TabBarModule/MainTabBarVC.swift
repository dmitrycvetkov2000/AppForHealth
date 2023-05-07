//
//  MainTabBarVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import UIKit

protocol MainTabBarProtocol: AnyObject {
    func HideSideMenu()
    func setSwipeRecognizer1()
    func setSwipeRecognizer2()
    func setTapRecognizer()
}

class MainTabBarVC: UITabBarController {
    
    var presenter: MainTabBarPresenterProtocol?
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }()
    
    var masButtons: [UIButton] = []
    
    let menuButton = UIButton()
    let m = UIButton()
    
    var menuVC: MenuVC?
    
    var swipeRecognizer: UISwipeGestureRecognizer?
    var swipeRecognizer2: UISwipeGestureRecognizer?
    var tapRecognizer: UITapGestureRecognizer?

    var isShowMenuVC = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        generateTabBar()
        setTabBarAppearance()
        
        configureNavigationItems()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        blurEffectView.removeFromSuperview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.setSwipeRecognizer1()
    }

    func setBlurEffect() {
        blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.alpha = 0.8
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(blurEffectView)
    }
    
    func configureNavigationItems() {
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.clipsToBounds = true
        menuButton.widthAnchor.constraint(equalToConstant: 61).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        menuButton.layer.cornerRadius = 0.5 * menuButton.bounds.size.width
        
        menuButton.setBackgroundImage(UIImage(systemName: "line.horizontal.3.circle.fill"), for: .normal)
        menuButton.tintColor = .tabBarMainColor

        menuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        
        let leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
    }
    
    
    
    @objc func openMenu() {
        if !isShowMenuVC {
            configureMenuVC()
        }
        
        isShowMenuVC = !isShowMenuVC
        print("isShowMenuVC = \(isShowMenuVC)")
        showMenuVC(show: isShowMenuVC)
    }
    

    @objc func closeMenu() {
        isShowMenuVC = !isShowMenuVC
        print("isShowMenuVC = \(isShowMenuVC)")
        showMenuVC(show: isShowMenuVC)
        view.removeGestureRecognizer(tapRecognizer!)
        view.removeGestureRecognizer(swipeRecognizer2!)
    }
    
    
    func setSwipeRecognizer1() {
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture1))
        swipeRecognizer!.direction = .right
        view.addGestureRecognizer(swipeRecognizer!)
    }
    func setSwipeRecognizer2() {
        swipeRecognizer2 = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture2))
        swipeRecognizer2!.direction = .left
        view.addGestureRecognizer(swipeRecognizer2!)
    }
    
    func setTapRecognizer() {
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(swipeGesture2))
        view.addGestureRecognizer(tapRecognizer!)
    }
    
    @objc func swipeGesture1(sender: UISwipeGestureRecognizer) {
        if menuVC == nil {
            if !isShowMenuVC {
                configureMenuVC()
            }
            isShowMenuVC = !isShowMenuVC
            print("isShowMenuVC = \(isShowMenuVC)")
            showMenuVC(show: isShowMenuVC)
        }
    }
    @objc func swipeGesture2(sender: UISwipeGestureRecognizer) {
        if menuVC != nil {
            if isShowMenuVC {
                isShowMenuVC = !isShowMenuVC
                print("isShowMenuVC = \(isShowMenuVC)")
                showMenuVC(show: isShowMenuVC)
                view.removeGestureRecognizer(tapRecognizer!)
                view.removeGestureRecognizer(swipeRecognizer2!)
            }
        } else {
            
        }
    }
    
    func configureMenuVC() {
        if menuVC == nil {
            menuVC = MenuVC()

            self.navigationController?.addChild(menuVC!)
            self.navigationController?.view.addSubview(menuVC!.view)
            menuVC!.didMove(toParent: self)
            
            menuVC!.hideSideMenuButton.addTarget(self, action: #selector(closeMenu), for: .touchUpInside)

            menuVC!.view.frame.origin.x = -(self.view.frame.width)

            print("Create MenuVC")

            self.menuVC!.helper.presenter = self.presenter
            
            presenter?.setSwipeRecognizer2()
            presenter?.setTapRecognizer()
        }
    }
    
    func showMenuVC(show: Bool) {
        if show {
            print("show")
            print(self.view.frame.width)
            setBlurEffect()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.menuVC!.view.frame.origin.x = -140
                
                
            }) { (finished) in
                
            }

        } else {
            blurEffectView.removeFromSuperview()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.menuVC!.view.frame.origin.x = -(self.view.frame.width)
                self.navigationController?.navigationBar.frame.origin.x = 200
                
            }) { [weak self] (finished) in

                self?.menuVC!.willMove(toParent: nil)
                self?.menuVC!.view.removeFromSuperview()
                self?.menuVC!.removeFromParent()
                
                self?.menuVC = nil
                print("Удалили меню \(String(describing: self?.menuVC))")
            }
        }
    }
    
    func generateTabBar() {
        viewControllers = [
            generateVC(vc: MainModuleBuilder.build(), title: "Главная".localized(), image: UIImage(systemName: "house.fill")),
            generateVC(vc: SecondModuleBuilder.build(), title: "Статистика калорий".localized(), image: UIImage(systemName: "chart.pie.fill")),
            generateVC(vc: ThirdModuleBuilder.build(), title: "Статистика воды".localized(), image: UIImage(systemName: "cup.and.saucer.fill"))
        ]
    }
    
    func generateVC(vc: UIViewController, title: String, image: UIImage?) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        
        return vc
    }
    
    func setTabBarAppearance() {
        let positionX: CGFloat = 0
        let positionY: CGFloat = 14
        let width = tabBar.bounds.width - positionX * 2
        let height = tabBar.bounds.height + positionY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionX, y: tabBar.bounds.minY - positionY, width: width, height: height), cornerRadius: 0)
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.tabBarMainColor.cgColor
        tabBar.tintColor = UIColor.tabBarTintColor
        tabBar.unselectedItemTintColor = UIColor.tabBarHalfTintColor
    }
    
}
extension MainTabBarVC: MainTabBarProtocol {
    func HideSideMenu() {
        if menuVC != nil && isShowMenuVC {
            isShowMenuVC = !isShowMenuVC

            self.menuVC!.willMove(toParent: nil)
            self.menuVC!.view.removeFromSuperview()
            self.menuVC!.removeFromParent()
            
            self.menuVC = nil
            
            view.removeGestureRecognizer(tapRecognizer!)
            view.removeGestureRecognizer(swipeRecognizer2!)
            print("Удалили меню \(String(describing: self.menuVC))")
        }
    }
}
