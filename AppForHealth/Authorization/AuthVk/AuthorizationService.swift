//
//  AuthorizationService.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 26.05.2023.
//

import VK_ios_sdk
import FirebaseAuth

protocol AuthorizationServiceDelegate: AnyObject {
    func authorizationService(_ service: AuthorizationService, didAuthorizeWithToken token: VKAccessToken)
    func authorizationServiceDidFailToAuthorize(_ service: AuthorizationService)
    func authorizationService(_ service: AuthorizationService, shouldPresentViewController viewController: UIViewController)
}

final class AuthorizationService: NSObject {

    weak var delegate: AuthorizationServiceDelegate?

    private let sdk: VKSdk

    init(appId: String) {
        self.sdk = VKSdk.initialize(withAppId: appId)
        super.init()
        self.sdk.register(self)
        self.sdk.uiDelegate = self
    }

    func authorize(vk: AuthorizationViewController) {
        VKSdk.wakeUpSession([]) { (state, error) in
            switch state {
            case .initialized:
                VKSdk.authorize(["wall", "friends"])
            case .authorized:
                self.delegate?.authorizationService(self, didAuthorizeWithToken: VKSdk.accessToken())
                
                print("UGGEEEEEE = \(VKSdk.accessToken())")
                
                Auth.auth().signIn(withEmail: "gtht@mail.ru", password: "123456") { result, error in
                    if error == nil{
                        print("NO ERRORS = \(result?.user.uid as Any)")
                        //self.dismiss(animated: true, completion: nil)
                        //self.presenter?.didTapDoneButtonFromRegistration()
                        let vc2 = MainTabBarModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
                        vc2.modalPresentationStyle = .fullScreen
                        vk.present(vc2, animated: true)
                    }else{
                        print("ERRRROROROROORORORROR")
                        print(error as Any)
                    }
                }
            case .error, .unknown:
                self.delegate?.authorizationServiceDidFailToAuthorize(self)
            case .pending, .external, .safariInApp, .webview:
                break
            @unknown default:
                fatalError()
            }
        }
    }
}

extension AuthorizationService: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            self.delegate?.authorizationService(self, didAuthorizeWithToken: result.token)
        } else {
            self.delegate?.authorizationServiceDidFailToAuthorize(self)
        }
    }

    func vkSdkUserAuthorizationFailed() {
        self.delegate?.authorizationServiceDidFailToAuthorize(self)
    }
}

extension AuthorizationService: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.delegate?.authorizationService(self, shouldPresentViewController: controller)
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        assertionFailure("Unhandled situation")
    }
}

