//
//  OnboardPageVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 20.04.2023.
//

import UIKit
import UserNotifications


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
        
        accesNotifications()
    }
    
    func setImages(i: Int) {
            arrayImages.append(UIImage(named: "welcome_\(i+1)") ?? UIImage())
    }
}

extension OnboardPageVC: OnboardPageVCProtocol {
    //MARK: - Notifications
    func accesNotifications() {
        let noticCenter = UNUserNotificationCenter.current()
        noticCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
            guard error == nil else { return }
            if granted {
                self.sheduleNotification { success in
                    if success {
                        print("We send it")
                    } else {
                        print("Failed")
                    }
                }
            }
        }
    }
    func sheduleNotification(completion: (Bool) -> ()) {
        let center = UNUserNotificationCenter.current()
        center.add(setupRequest(id: "dinner", title: "Время обеда", body: "Не забудьте полезно пообедать", hour: 14, minute: 0))
        center.add(setupRequest(id: "launch", title: "Время ужина", body: "Не забудьте полезно поужинать", hour: 20, minute: 0))
    }
    
    func setupRequest(id: String, title: String, body: String, hour: Int, minute: Int) -> UNNotificationRequest {
        removeNotifications(withId: [id])
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        var dateInfo = DateComponents()
        dateInfo.hour = 14
        dateInfo.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        return request
    }
    
    func removeNotifications(withId identifiers: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
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
