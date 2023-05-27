//
//  FirebaseService.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 18.12.2022.
//

import Foundation
import Firebase
import GoogleSignIn
import VK_ios_sdk

class FirebaseService {
    
    func signOutFromAcc(presenter: SettingPresenterProtocol?) {
        let defaults = UserDefaults.standard
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            
            if let tokenVK = defaults.string(forKey: "token") {
                let url = URL(string: "http://api.vk.com/oauth/logout")!
                let req = URLRequest(url: url)
                VKAuthScreen().load(req)
                defaults.removeObject(forKey: "token")
                print("Выход из вк")
            }

            DispatchQueue.main.async {
                presenter?.didTapOnExitButton()
            }
        } catch {
            print(error)
        }
    }
    
    
    func registration(name: String, email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView) {
        
        let alert = UIAlertController(title: "Ошибка регистрации".localized(), message: "Проверьте корректность email адреса или интернет соединения".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        
        let backgroundQueue = DispatchQueue(label: "background_queue",
                                                    qos: .background)
                
        
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error == nil {
                    if let result = result {
                        print(result.user.uid)
                        backgroundQueue.async {
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["name" : name, "email" : email])
                            
                        }
                        //Переход на другой экран
                        presenter?.saveNameForUser(name: name)
                        presenter?.didTapDoneButtonFromRegistration()
                    }
                } else {
                    
                    blurEffectView.isHidden = true
                    spinner.stopAnimation()
                    spinner.isHidden = true
                    
                    vc.present(alert, animated: true, completion: nil)
                    print(error ?? "error")
                }
                
            }
    }
    
    
    func entrance(email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView) {
        
        
        let alert = UIAlertController(title: "Ошибка входа", message: "Проверьте корректность введенных данных или интернет-соединения", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error == nil {
                print("Выполняется вход")
                //Переход на другой экран 
                presenter?.didTapDoneButtonFromRegistration()
            } else {
                blurEffectView.isHidden = true
                spinner.stopAnimation()
                spinner.isHidden = true
                
                vc.present(alert, animated: true, completion: nil)
                print(error.debugDescription)
            }
        }
    }
    
}
