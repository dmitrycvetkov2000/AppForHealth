//
//  MainViewController.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import UIKit
import Firebase

protocol MainViewProtocol: AnyObject {
    
}

class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol?
    
    var exitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = .cyan
        print("Name Of User")
        DispatchQueue.main.async {
            print(Auth.auth().currentUser?.email)
        }
        
        crateButton()
        //
    }
}

extension MainViewController: MainViewProtocol {
    func crateButton() {
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exitButton)
        
        exitButton.addTarget(self, action: #selector(exitB), for: .touchUpInside)
        
        exitButton.setTitle("Выйти", for: .normal)
        
        exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exitButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        exitButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func exitB() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.presenter?.didTapExitButton()
                print("SSSSSS")
            }
            
        } catch {
            print(error)
        }
    }
}
