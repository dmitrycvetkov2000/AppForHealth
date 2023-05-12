//
//  AuthorizationInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.12.2022.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseAuth
import VK_ios_sdk


protocol AuthorizationInteractorProtocol: AnyObject {
    
    func registration(name: String, email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView)
    
    func entranceInAcc(email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView)
    
    func checkCoreDataIsEmpty() -> Bool
    
    func registrationGoogle(vc: ViewController)
    
    func registrationVK(vc: ViewController, result: VKAuthorizationResult)
}

class AuthorizationInteractor: AuthorizationInteractorProtocol {
    
    weak var presenter: AuthorizationPresenterProtocol?
    
    let firebaseService = FirebaseService()
    
    
    func registration(name: String, email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView) {
        firebaseService.registration(name: name, email: email, password: password, presenter: presenter, vc: vc, spinner: spinner, blurEffectView: blurEffectView)
    }
    
    func entranceInAcc(email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView) {
        firebaseService.entrance(email: email, password: password, presenter: presenter, vc: vc, spinner: spinner, blurEffectView: blurEffectView)
    }
    
    func checkCoreDataIsEmpty() -> Bool {
        return CoreDataManager.instance.isEmptyCoreData()
    }
    
    func registrationVK(vc: ViewController, result: VKAuthorizationResult) {
//        let sdkInstance = VKSdk.initialize(withAppId: "") // ?
//        sdkInstance?.register(vc)
        guard let idToken = result.token.userId, let accessToken = result.token.accessToken else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        Auth.auth().signIn(with: credential) { (result, error) in
            if error == nil{
                print(result?.user.uid as Any)
                //self.dismiss(animated: true, completion: nil)
                self.presenter?.didTapDoneButtonFromRegistration()
            }else{
                print(error as Any)
            }
        }
    }
    
    func registrationGoogle(vc: ViewController) {
        GIDSignIn.sharedInstance.signIn(with: GIDConfiguration(clientID: "154147269434-up7tbkfdd00m02usbe9rrrip74sgb4ep.apps.googleusercontent.com"), presenting: vc) { user, error in
          guard error == nil else { return }
            print("Вход через гугл")
            let authentication = user?.authentication
            let idToken = authentication?.idToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken!, accessToken: authentication!.accessToken)
            Auth.auth().signIn(with: credential) { (result, error) in
                if error == nil{
                    print(result?.user.uid as Any)
                    //self.dismiss(animated: true, completion: nil)
                    self.presenter?.didTapDoneButtonFromRegistration()
                }else{
                    print(error as Any)
                }
            }
          // If sign in succeeded, display the app's main content View.
        }
    }
}
