//
//  OnboardPageVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 20.04.2023.
//

import UIKit



protocol OnboardPageVCProtocol: AnyObject {
    
}

class OnboardPageVC: UIPageViewController {
    
    var presenter: OnboardPresenterProtocol?
    
    var helper = [OnboardHelper]()
    
    var index = 0
    
    let titles = ["Добро пожаловать!".localized(), "Возможности".localized(), "Старт".localized()]
    let texts = ["Рады видеть Вас в нашем приложении! \nС помощью данного приложения Вам будет легче следить за своим образом жизни!".localized(),
                 "Наше приложение поможет Вам отслеживать питание, количество выпитой жидкости, подскажет расположение ближайших фитнес центров, проведет интервальную тренировку и покажет вкусные рецепты!".localized(),
                 "Для начала нажмите кнопку \"Начать\"".localized()]
    let buttonTitles = ["Продолжить".localized(), "Продолжить".localized(), "Начать".localized()]
    
    
    var arrayImages: [UIImage] = []
    
    lazy var arrayVC: [OnboardVC] = {
        var arrayVC = [OnboardVC]()
        for vC in helper {
            arrayVC.append(OnboardVC(helper: vC))
        }
        return arrayVC
    }()
    
    
    func setTargetsForButton() {
        for vc in arrayVC {
            vc.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
    }

    @objc func didTapButton() {
        if index < 2 {
            goToNextPage(animated: true, completion: nil)
        } else {
            Core.shared.setIsNotNewUser()
            presenter?.didTappedLastButton()
        }
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
        self.dataSource = self
        self.delegate = self
        view.backgroundColor = .brown
        
        setViewControllers([arrayVC[0]], direction: .forward, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<3 {
            setImages(i: i)
            let data = OnboardHelper(title: titles[i], text: texts[i], image: arrayImages[i], buttonTitle: buttonTitles[i])
            helper.append(data)
        }
        setTargetsForButton()
    }
    
    func setImages(i: Int) {
            arrayImages.append(UIImage(named: "welcome_\(i+1)") ?? UIImage())
    }
}

extension OnboardPageVC: OnboardPageVCProtocol {

}

extension OnboardPageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        index -= 1
        guard let vc = viewController as? OnboardVC else { return nil }
        if let index = arrayVC.firstIndex(of: vc) {
            if index > 0 {
                return arrayVC[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        index += 1
        guard let vc = viewController as? OnboardVC else { return nil }
        if let index = arrayVC.firstIndex(of: vc) {
            if index < 2 {
                return arrayVC[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return index
    }
    
}

extension UIPageViewController {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?[0] {
            if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
                setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
            }
        }
    }

    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?[0] {
            if let previousPage = dataSource?.pageViewController(self, viewControllerBefore: currentViewController){
                setViewControllers([previousPage], direction: .reverse, animated: true, completion: completion)
            }
        }
    }
}
