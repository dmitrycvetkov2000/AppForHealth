//
//  ResultPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 19.12.2022.
//

import UIKit

protocol ResultPresenterProtocol: AnyObject {
    func didTapOkButton()
    
    func viewDidLoaded(vc: UIViewController, labelResult: UILabel)
    
    func createLabelResult(_ label: UILabel, vc: UIViewController)
}

class ResultPresenter {
    
    weak var view: ResultVCProtocol?
    var router: ResultRouterProtocol
    var interactor: ResultInteractorProtocol
    
    init(interactor: ResultInteractorProtocol, router: ResultRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension ResultPresenter: ResultPresenterProtocol {
    func viewDidLoaded(vc: UIViewController, labelResult: UILabel) {
        createLabelResult(labelResult, vc: vc)
    }
    
    func createLabelResult(_ label: UILabel, vc: UIViewController) {
        label.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(label)
        
        label.font = UIFont(name: "Vasek", size: 1000)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Ваши параметры"
        
        label.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: 30).isActive = true
        label.leftAnchor.constraint(equalTo: vc.view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: vc.view.rightAnchor, constant: -10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func didTapOkButton() {
        router.openMain()
    }
    
    
}
