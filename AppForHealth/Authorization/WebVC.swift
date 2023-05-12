//
//  WebVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 11.05.2023.
//

import UIKit
import FirebaseAuth
import VK_ios_sdk

class WebVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let vcVKAuthScreen = VKAuthScreen(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), configuration: nil)
        view.addSubview(vcVKAuthScreen)
        vcVKAuthScreen.load(vcVKAuthScreen.req ?? URLRequest(url: URL(string: "https://www.google.com")!))
        
        VKSdk.initialize(withAppId: "") // ?
        //VKSdk.instance().uiDelegate = self
        VKSdk.instance().register(self)
    }
}

extension WebVC: VKSdkDelegate {

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print("Регистрация закончилась")
        guard let idToken = result.token.userId, let accessToken = result.token.accessToken else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        Auth.auth().signIn(with: credential) { (result, error) in
            if error == nil{
                print(result?.user.uid as Any)
                //self.dismiss(animated: true, completion: nil)
                //self.presenter?.didTapDoneButtonFromRegistration()
                if CoreDataManager.instance.isEmptyCoreData() {
                    let vc = ParametrsModuleBuilder.build()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                } else {
                    let vc = MainTabBarModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            }else{
                print(error as Any)
            }
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("Ошибка регистрации ВК")
    }
    

}
