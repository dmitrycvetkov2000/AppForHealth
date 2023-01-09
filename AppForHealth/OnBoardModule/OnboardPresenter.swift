//
//  OnboardPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import UIKit

protocol OnboardPresenterProtocol: AnyObject {
    func didTappedLastButton()
    func viewDidLoaded(viewOfOnboard: UIView, vc: UIViewController)
    func createImage(viewOfOnboard: UIView, vc: UIViewController)
}

class OnboardPresenter {
    weak var view: OnboardVCProtocol?
    var router: OnboardRouterProtocol
    var interactor: OnboardInteractorProtocol
    
    init(interactor: OnboardInteractorProtocol, router: OnboardRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension OnboardPresenter: OnboardPresenterProtocol {
    func didTappedLastButton() {
        router.openAuthorization()
    }
    
    func createImage(viewOfOnboard: UIView, vc: UIViewController) {
        viewOfOnboard.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(viewOfOnboard)
        
        
        viewOfOnboard.rightAnchor.constraint(equalTo: vc.view.rightAnchor, constant: 0).isActive = true
        viewOfOnboard.leftAnchor.constraint(equalTo: vc.view.leftAnchor, constant: 0).isActive = true
        viewOfOnboard.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: 0).isActive = true
        viewOfOnboard.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor, constant: 0).isActive = true
    }
    
    func viewDidLoaded(viewOfOnboard: UIView, vc: UIViewController) {
        vc.view.backgroundColor = .brown
        createImage(viewOfOnboard: viewOfOnboard, vc: vc)
    }
    

}
