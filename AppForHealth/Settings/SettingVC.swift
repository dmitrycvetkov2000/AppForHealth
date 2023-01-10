//
//  SettingVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 09.01.2023.
//

import UIKit

protocol SettingVCProtocol: AnyObject {
    
}

class SettingVC: UIViewController {
    var presenter: SettingPresenterProtocol?
    
    var buttonForExit = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        createButtonForExit(buttonForExit)
        createConstraintsForButtonForExit(buttonForExit)
    }
    
    @objc func exitAction() {
        presenter?.didExit()
    }
}

extension SettingVC: SettingVCProtocol {
    
    func createButtonForExit(_ button: UIButton) {
        view.addSubview(button)
        
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .blue
        
        button.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
    }
    
    func createConstraintsForButtonForExit(_ button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
}
