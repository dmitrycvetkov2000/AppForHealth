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
        let wasHandled:Bool = VKSdk.processOpen(url as URL, fromApplication: sourceApplication as String?)
        print("url: \(url)")
        return wasHandled
    }
}

