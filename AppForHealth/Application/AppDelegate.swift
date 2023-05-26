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
import VK_ios_sdk

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
                let defaults = UserDefaults.standard
                if CoreDataManager.instance.isEmptyCoreData() && ((Auth.auth().currentUser != nil) || (defaults.string(forKey: "token") != nil)) {
                    let vc = ParametrsModuleBuilder.build()
                    window.rootViewController = vc
                    window.makeKeyAndVisible()
                } else if !CoreDataManager.instance.isEmptyCoreData() && ((Auth.auth().currentUser != nil) || (defaults.string(forKey: "token") != nil)) {
                    let vc = MainTabBarModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
                    window.rootViewController = vc
                    window.makeKeyAndVisible()
                } else if Core.shared.isNewUser() && CoreDataManager.instance.isEmptyCoreData() && (Auth.auth().currentUser == nil && defaults.string(forKey: "token") == nil) {
                    let vc = OnboardModuleBuilder.build()
                    window.rootViewController = vc
                    window.makeKeyAndVisible()
                } else if CoreDataManager.instance.isEmptyCoreData() && (Auth.auth().currentUser == nil && defaults.string(forKey: "token") == nil) {
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
            let value1 = Product(value: ["Банан".localized(), 42.5, 12.5, 23.4, 10] as [Any])
            let value2 = Product(value: ["Апельсин".localized(), 4.5, 2.5, 3.4, 20] as [Any])
            let value3 = Product(value: ["Яблоко".localized(), 2.5, 1.5, 2.4, 30] as [Any])
            let value4 = Product(value: ["Киви".localized(), 10.5, 6.9, 2.1, 40] as [Any])
            let value5 = Product(value: ["Мороженное".localized(), 23, 14.5, 53.4, 50] as [Any])
            let value6 = Product(value: ["Ананас".localized(), 0.5, 6.5, 8.4, 60] as [Any])
            let value7 = Product(value: ["Арбуз".localized(), 40.5, 32.5, 3.4, 70] as [Any])
            let value8 = Product(value: ["Дыня".localized(), 5.5, 5.5, 5.4, 80] as [Any])
            
            let values = [value1, value2, value3, value4, value5, value6, value7, value8]
            
            try! realm.write {
                for val in values {
                    realm.add(val)
                }
            }
        }
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String else {
            return true
        }
        var handled: Bool
        var vkHandled: Bool
        
        handled = GIDSignIn.sharedInstance.handle(url)
        vkHandled = VKSdk.processOpen(url, fromApplication: sourceApplication)
        if handled {
            return true
        }
        if vkHandled {
            return true
        }
        return false
    }
    private func application(application: UIApplication, openURL url: NSURL, sourceApplication: NSString?, annotation: AnyObject) -> Bool {
        var wasHandled:Bool = VKSdk.processOpen(url as URL, fromApplication: sourceApplication as String?)
        print("url: \(url)")
        return wasHandled
    }
}

