//
//  FirebaseService.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 18.12.2022.
//

import Foundation
import Firebase

class FirebaseService {
    func signOutFromAcc(presenter: MainPresenterProtocol?) {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                presenter?.didTapExitButton()
                print("SSSSSS")
            }
            
        } catch {
            print(error)
        }
    }
    
    
    func registration(name: String, email: String, password: String, presenter: AuthorizationPresenterProtocol?) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                if let result = result {
                    print(result.user.uid)
                    let ref = Database.database().reference().child("users")
                    ref.child(result.user.uid).updateChildValues(["name" : name, "email" : email])
                    //Переход на другой экран нужно сделать
                    presenter?.didTapDoneButtonFromRegistration()
                }
            }
        }
    }
    
    
    func entrance(email: String, password: String, presenter: AuthorizationPresenterProtocol?) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error == nil {
                print("Выполняется вход")
                //Переход на другой экран нужно сделать
                presenter?.didTapDoneButton()
            } else {
                print(error.debugDescription)
            }
        }
    }
    
}