//
//  WebVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 11.05.2023.
//

//import UIKit
//import FirebaseAuth
//import VK_ios_sdk
////51651308
//class WebVC: UIViewController {
//    let VK_APP_ID = "51651308"
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        var vkAuthScreen = VKAuthScreen(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), configuration: nil)
//        view.addSubview(vkAuthScreen)
//        vkAuthScreen.load(vkAuthScreen.req ?? URLRequest(url: URL(string: "https://www.google.com")!))
//        
//        let sdkVKInstance = VKSdk.initialize(withAppId: self.VK_APP_ID)
//        sdkVKInstance?.register(self)
//        sdkVKInstance?.uiDelegate = self
//    }
//}
//extension WebVC: VKSdkDelegate {
//    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
//        print("vkSdkAccessAuthorizationFinished")
//    }
//    
//    func vkSdkUserAuthorizationFailed() {
//        print("vkSdkUserAuthorizationFailed")
//    }
//}
//
//extension WebVC: VKSdkUIDelegate {
//    func vkSdkAccessTokenUpdated(_ newToken: VKAccessToken!, oldToken: VKAccessToken!) {
//        print("vkSdkAccessTokenUpdated")
//    }
//    func vkSdkAuthorizationStateUpdated(with result: VKAuthorizationResult!) {
//        print("vkSdkAuthorizationStateUpdated")
//    }
//    func vkSdkShouldPresent(_ controller: UIViewController!) {
//        print("vkSdkShouldPresent")
//    }
//    
//    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
//        print("vkSdkNeedCaptchaEnter")
//    }
//}
