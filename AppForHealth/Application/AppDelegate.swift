//
//  AppDelegate.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 05.12.2022.
//

import UIKit
import CoreData
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let splashPresenter = SplashScreenPresenter()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        splashPresenter.present()
        let window = UIWindow()
        
        let vc = AuthorizationModuleBuilder.build()
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        DispatchQueue.global().async { // Делаем какую-либо работу
            FirebaseApp.configure()

//            for i in 0...1000000 {
//                print(i*i)
//                if i % 10000 == 0 {
//                    self.splashPresenter.notify(percent: Float(i) / 1000000.0)
//                }
//            }
            
            DispatchQueue.main.async {
                if Core.shared.isNewUser() {
                    DispatchQueue.main.async {
                        
                            let vc = OnboardModuleBuilder.build()

                            window.rootViewController = vc
                            window.makeKeyAndVisible()
                        //Core.shared.setIsNotNewUser()
                    }
                } else {
                    DispatchQueue.main.async {
                        
                        if CoreDataManager.instance.isEmptyCoreData() {
                            let vc = ParametrsModuleBuilder.build()
                            window.rootViewController = vc
                            window.makeKeyAndVisible()
                        } else {
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
                self.splashPresenter.dismiss()
            }
        }
 

        self.window = window
        return true
    }
//    func applicationDidFinishLaunching(_ application: UIApplication) {
//        let window = UIWindow()
//        let vc = AuthorizationModuleBuilder.build()
//        window.rootViewController = vc
//        self.window = window
//        window.makeKeyAndVisible()
//    }
    // MARK: UISceneSession Lifecycle

//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    

}

