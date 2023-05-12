//
//  AuthorizationPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.12.2022.
//

import UIKit
import VK_ios_sdk

protocol AuthorizationPresenterProtocol: AnyObject {
    func viewDidLoaded()
    
    func didTapDoneButton()
    func didTapDoneButtonFromRegistration()
    
    func didRegistration(name: String, email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView)
    func didEntrance(email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView)
    
    func showAlert(vc: UIViewController)
    func showSpinnerAndBlackoutScreen(vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView)
    
    func showAlertForParol(vc: UIViewController)
    
    func setTapRecognizer()
    
    func saveNameForUser(name: String)
    
    func didTapGoogleButton(vc: ViewController)
    
    func didTapVKButton(vc: ViewController, result: VKAuthorizationResult)
}

class AuthorizationPresenter {
    weak var view: AuthorizationViewProtocol?
    var router: AuthorizationRouterProtocol
    var interactor: AuthorizationInteractorProtocol
    
    init(interactor: AuthorizationInteractorProtocol, router: AuthorizationRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension AuthorizationPresenter: AuthorizationPresenterProtocol {

    func didTapDoneButton() {
        router.openMain()
    }
    func didTapDoneButtonFromRegistration() {
        if interactor.checkCoreDataIsEmpty() {
            router.openParametrsScreen()
        } else {
            router.openMain()
        }
        
    }
    
    func viewDidLoaded() {

    }
    
    func saveNameForUser(name: String) {
        let realm = RealmManager.instance.realm

        let nameOfUser = UserRealm(value: [name])
        try! realm.write {
            realm.add(nameOfUser)
        }
    }
    
    func didRegistration(name: String, email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView) {
        
        interactor.registration(name: name, email: email, password: password, presenter: self, vc: vc, spinner: spinner, blurEffectView: blurEffectView)
    }
    
    func didEntrance(email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView) {
        interactor.entranceInAcc(email: email, password: password, presenter: self, vc: vc, spinner: spinner, blurEffectView: blurEffectView)
    }
    
    func showAlert(vc: UIViewController) {
        let alert = UIAlertController(title: "Ошибка".localized(), message: "Заполните все поля".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок".localized(), style: .default))
        vc.present(alert, animated: true, completion: nil)
    }
    
    func showSpinnerAndBlackoutScreen(vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView) {
        blurEffectView.alpha = 0.8
        blurEffectView.frame = vc.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.view.addSubview(blurEffectView)
        vc.view.addSubview(spinner)
        spinner.startAnimation(delay: 0.04, replicates: 20)
    }
    
    func showAlertForParol(vc: UIViewController) {
        let alert = UIAlertController(title: "Ошибка".localized(), message: "Пароль должен содержать не менее 6 символов".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок".localized(), style: .default))
        vc.present(alert, animated: true, completion: nil)
    }
    
    func setTapRecognizer() {
        view?.setTapRecognizer()
    }
    
    func didTapGoogleButton(vc: ViewController) {
        interactor.registrationGoogle(vc: vc)
    }
    
    func didTapVKButton(vc: ViewController, result: VKAuthorizationResult) {
        interactor.registrationVK(vc: vc, result: result)
    }
}
