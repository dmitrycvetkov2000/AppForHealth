//
//  HelperForAppDelegate.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 13.01.2023.
//

import UIKit
import Firebase

class HelperForAppDelegate {
    func launchApp(_ window: UIWindow?, splashPresenter: SplashScreenPresenter) -> UIWindow {
        splashPresenter.present()
        let window = UIWindow()
        
        let vc = AuthorizationModuleBuilder.build()
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        DispatchQueue.global().async { // Делаем какую-либо работу
            FirebaseApp.configure()

            for i in 0...1000000 {
                print(i*i)
                if i % 10000 == 0 {
                    splashPresenter.notify(percent: Float(i) / 1000000.0)
                }
            }
            
            DispatchQueue.main.async {
                if Core.shared.isNewUser() {
                    DispatchQueue.main.async {
                            let vc = OnboardModuleBuilder.build()

                            window.rootViewController = vc
                            window.makeKeyAndVisible()
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        
                        if CoreDataManager.instance.isEmptyCoreData() && (Auth.auth().currentUser != nil) {
                            let vc = ParametrsModuleBuilder.build()
                            window.rootViewController = vc
                            window.makeKeyAndVisible()
                        } else if !CoreDataManager.instance.isEmptyCoreData() && (Auth.auth().currentUser != nil) {
                            let vc = MainModuleBuilder.build()
                            window.rootViewController = vc
                            window.makeKeyAndVisible()
                        }
                        
                        Auth.auth().addStateDidChangeListener { auth, user in
                            if user == nil { // Если пользователь вышел или не зарегистрирован
                                let vc = AuthorizationModuleBuilder.build()
                                window.rootViewController = vc
                                window.makeKeyAndVisible()

                            }
                        }
                    }
                }
                splashPresenter.dismiss()
            }
        }
        return window
    }
}
