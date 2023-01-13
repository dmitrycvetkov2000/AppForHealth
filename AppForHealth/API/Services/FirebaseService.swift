//
//  FirebaseService.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 18.12.2022.
//

import Foundation
import Firebase

class FirebaseService {
    func signOutFromAcc(presenter: SettingPresenterProtocol?) {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                presenter?.didTapOnExitButton()
            }
            
        } catch {
            print(error)
        }
    }
    
    
    func registration(name: String, email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView) {
        
        let alert = UIAlertController(title: "Ошибка регистрации", message: "Проверьте корректность email адреса или интернет соединения", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                if let result = result {
                    print(result.user.uid)
                    let ref = Database.database().reference().child("users")
                    ref.child(result.user.uid).updateChildValues(["name" : name, "email" : email])
                    //Переход на другой экран
                    presenter?.didTapDoneButtonFromRegistration()
                }
            } else {
                
                blurEffectView.isHidden = true
                spinner.stopAnimation()
                spinner.isHidden = true
                
                vc.present(alert, animated: true, completion: nil)
                print(error)
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
                presenter?.didTapDoneButton()
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
