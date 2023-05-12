//
//  AppDelegate.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 05.12.2022.
//

import UIKit
import CoreData
import Firebase
import RealmSwift
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private let splashPresenter = SplashScreenPresenter()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.splashPresenter.present()
        let window = UIWindow()
        
        let vc = AuthorizationModuleBuilder.build()

        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        DispatchQueue.global().async { // Делаем какую-либо работу
            for i in 0...1000000 {
                if i == 0 {
                    DispatchQueue.global().async {
                        DispatchQueue.main.async {
                            FirebaseApp.configure()
                            self.createFodsForBD()
                        }
                    }
                }
                //print(i*i)
                if i % 10000 == 0 {
                    //DispatchQueue.main.async {
                        self.splashPresenter.notify(percent: Float(i) / 1000000.0)
                    //}
                }
            }

            DispatchQueue.main.async {
                                if CoreDataManager.instance.isEmptyCoreData() && (Auth.auth().currentUser != nil) {
                                    let vc = ParametrsModuleBuilder.build()
                                    window.rootViewController = vc
                                    window.makeKeyAndVisible()
                                } else if !CoreDataManager.instance.isEmptyCoreData() && (Auth.auth().currentUser != nil) {
                                    let vc = MainTabBarModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
                                    window.rootViewController = vc
                                    window.makeKeyAndVisible()
                                } else if Core.shared.isNewUser() && CoreDataManager.instance.isEmptyCoreData() && (Auth.auth().currentUser == nil) {
                                    let vc = OnboardModuleBuilder.build()
                                    window.rootViewController = vc
                                    window.makeKeyAndVisible()
                                } else if CoreDataManager.instance.isEmptyCoreData() && (Auth.auth().currentUser == nil) {
                                    let vc = AuthorizationModuleBuilder.build()
                                    window.rootViewController = vc
                                    window.makeKeyAndVisible()
                                }
                self.window = window
                    DispatchQueue.main.async {
                        self.splashPresenter.dismiss()
                    }
            }
        }
        return true
    }
    
    func createFodsForBD() {
        let realm = try! Realm()
        if realm.isEmpty {
            let value1 = Product(value: ["Банан".localized(), 42.5, 12.5, 23.4, 10])
            let value2 = Product(value: ["Апельсин".localized(), 4.5, 2.5, 3.4, 20])
            let value3 = Product(value: ["Яблоко".localized(), 2.5, 1.5, 2.4, 30])
            let value4 = Product(value: ["Киви".localized(), 10.5, 6.9, 2.1, 40])
            let value5 = Product(value: ["Мороженное".localized(), 23, 14.5, 53.4, 50])
            let value6 = Product(value: ["Ананас".localized(), 0.5, 6.5, 8.4, 60])
            let value7 = Product(value: ["Арбуз".localized(), 40.5, 32.5, 3.4, 70])
            let value8 = Product(value: ["Дыня".localized(), 5.5, 5.5, 5.4, 80])
            
            let values = [value1, value2, value3, value4, value5, value6, value7, value8]
            
            try! realm.write {
                for val in values {
                    realm.add(val)
                }
            }
        }
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled: Bool

        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
          return true
        }
        return false
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

