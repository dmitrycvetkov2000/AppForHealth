//
//  SplashScreenPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 05.12.2022.
//

import Foundation
import UIKit


final class SplashScreenPresenter {
    let vc = LaunchScreen()
    private var splashWindow: UIWindow? = {
        let splashWindow = UIWindow(frame: UIScreen.main.bounds)
        splashWindow.windowLevel = UIWindow.Level.alert + 1
        splashWindow.rootViewController = LaunchScreen()
        return splashWindow
    }()

    func present() {
        splashWindow?.isHidden = false
        splashWindow?.makeKeyAndVisible()
    }
    
    func notify(percent: Float) {
        DispatchQueue.main.async {
            (self.splashWindow?.rootViewController as? LaunchScreen)?.set(progress: percent)
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.25) {
            self.splashWindow?.alpha = 0.0
            self.splashWindow = nil
        }
        
    }
}


