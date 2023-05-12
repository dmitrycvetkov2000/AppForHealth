//
//  VKAuthScreen.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 11.05.2023.
//

import UIKit
import WebKit

class VKAuthScreen: WKWebView {
    var req: URLRequest?
    var token = ""
    override init(frame: CGRect, configuration: WKWebViewConfiguration?) {
        super.init(frame: frame, configuration: configuration ?? WKWebViewConfiguration())
        
        self.navigationDelegate = self
            var urlComponent = URLComponents()
            urlComponent.scheme = "https"
            urlComponent.host = "oauth.vk.com"
            urlComponent.path = "/authorize"
            
            urlComponent.queryItems = [
                URLQueryItem(name: "client_id", value: "no"), // ?
                URLQueryItem(name: "redirect_uri", value: "http://oauth.vk.com/blank.html"),
                URLQueryItem(name: "display", value: "mobile"),
                URLQueryItem(name: "response_type", value: "token")
            ]
            
        //let req = URLRequest(url: URL(string: "https://www.google.com")!)
            req = URLRequest(url: urlComponent.url!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VKAuthScreen: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("1234")
        
        guard let url = navigationResponse.response.url, url.path() == "/blank.html", let fragment = url.fragment() else {
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
        }
        
        
        decisionHandler(.cancel)
    }
}
