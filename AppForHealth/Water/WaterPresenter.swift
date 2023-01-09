//
//  WaterPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 08.01.2023.
//

import UIKit

protocol WaterPresenterProtocol: AnyObject {
    func viewDidLoaded()
    
}

class WaterPresenter {
    
    weak var view: WaterVCProtocol?
    var router: WaterRouterProtocol
    var interactor: WaterInteractorProtocol
    
    init(interactor: WaterInteractorProtocol, router: WaterRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension WaterPresenter: WaterPresenterProtocol {
    func viewDidLoaded() {
        
    }
    
    
//    func createLabelNumberOfWater(_ label: UILabel, _ vc: UIViewController) {
//        
//        
//        vc.view.addSubview(label)
//        
//        label.font = UIFont(name: "Vasek", size: 1000)
//        label.numberOfLines = 1
//        label.adjustsFontSizeToFitWidth = true
//        
//        label.textAlignment = .left
//        label.textColor = .white
//        label.text = "0"
//        
//    }
//    
//    func createLabelNumberOfWaterConstraints(_ label: UILabel, _ vc: UIViewController) {
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        label.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: 10).isActive = true
//        label.leftAnchor.constraint(equalTo: vc.view.leftAnchor, constant: 10).isActive = true
//        label.rightAnchor.constraint(equalTo: vc.view.rightAnchor, constant: -10).isActive = true
//        label.heightAnchor.constraint(equalToConstant: 62).isActive = true
//    }
//    
//    func createButtonForWater(_ button: UIButton, _ vc: UIViewController) {
//        button.translatesAutoresizingMaskIntoConstraints = false
//        vc.view.addSubview(button)
//        
//        button.backgroundColor = .green
//        
//        button.setTitle("Выпил стакан воды", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
//        
//        button.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
//        button.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        
////        button.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: 10).isActive = true
////        button.leftAnchor.constraint(equalTo: vc.view.leftAnchor, constant: 10).isActive = true
////        button.rightAnchor.constraint(equalTo: vc.view.rightAnchor, constant: -10).isActive = true
////        button.heightAnchor.constraint(equalToConstant: 62).isActive = true
//        
//        
//    }
}
