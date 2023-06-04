//
//  VKAuthScreen.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 11.05.2023.
//

import UIKit
import WebKit
import VK_ios_sdk

class VKAuthScreen: WKWebView, VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print("vkSdkShouldPresent")
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("vkSdkNeedCaptchaEnter")
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print("vkSdkAccessAuthorizationFinished")
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("vkSdkUserAuthorizationFailed")
    }
    
    func vkSdkAccessTokenUpdated(_ newToken: VKAccessToken!, oldToken: VKAccessToken!) {
        print("vkSdkAccessTokenUpdated")
    }
    func vkSdkAuthorizationStateUpdated(with result: VKAuthorizationResult!) {
        print("vkSdkAuthorizationStateUpdated")
    }
    
    let VK_APP_ID = "51651308"
    var req: URLRequest?
    var token = ""
    weak var vc: ViewController?
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration?) {
        super.init(frame: frame, configuration: configuration ?? WKWebViewConfiguration())
        
        
        let sdkVKInstance = VKSdk.initialize(withAppId: self.VK_APP_ID)
        sdkVKInstance?.register(self)
        sdkVKInstance?.uiDelegate = self
        self.navigationDelegate = self
        
            var urlComponent = URLComponents()
            urlComponent.scheme = "https"
            urlComponent.host = "oauth.vk.com"
            urlComponent.path = "/authorize"
            
            urlComponent.queryItems = [
                URLQueryItem(name: "client_id", value: "51651308"),
                URLQueryItem(name: "redirect_uri", value: "http://oauth.vk.com/blank.html"),
                URLQueryItem(name: "display", value: "mobile"),
                URLQueryItem(name: "response_type", value: "token")
            ]
        req = URLRequest(url: (urlComponent.url ?? URL(string: "https://www.google.com"))!)
        
        if let req = req {
            self.load(req)
        }
    }
    init(frame: CGRect, configuration: WKWebViewConfiguration?, vc: ViewController) {
        super.init(frame: frame, configuration: configuration ?? WKWebViewConfiguration())
        let sdkVKInstance = VKSdk.initialize(withAppId: self.VK_APP_ID)
        sdkVKInstance?.register(self)
        sdkVKInstance?.uiDelegate = self
        self.navigationDelegate = self
        
            var urlComponent = URLComponents()
            urlComponent.scheme = "https"
            urlComponent.host = "oauth.vk.com"
            urlComponent.path = "/authorize"
            
            urlComponent.queryItems = [
                URLQueryItem(name: "client_id", value: "51651308"),
                URLQueryItem(name: "redirect_uri", value: "http://oauth.vk.com/blank.html"),
                URLQueryItem(name: "display", value: "mobile"),
                URLQueryItem(name: "response_type", value: "token")
            ]
            
        req = URLRequest(url: (urlComponent.url ?? URL(string: "https://www.google.com"))!)
        
        if let req = req {
            self.load(req)
            self.vc = vc
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VKAuthScreen: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment.components(separatedBy: "&")
            .map {$0.components(separatedBy: "=")}
            .reduce([String:String]()) { res, param in
                var dict = res
                let key = param[0]
                let value = param[1]
                dict[key] = value
                
                return dict
            }
        if let accessToken = params["access_token"] {
            token = accessToken
            let defaults = UserDefaults.standard
            defaults.set(token, forKey: "token")
            self.removeFromSuperview()
            vc?.presenter?.didTapDoneButtonFromRegistration()
        }
        decisionHandler(.cancel)
    }
}
