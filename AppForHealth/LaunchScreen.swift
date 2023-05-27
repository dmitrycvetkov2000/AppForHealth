//
//  SplashViewController.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 05.12.2022.
//

import Foundation
import UIKit

class LaunchScreen: UIViewController {
    var progressLine = UIProgressView()
    var percentLabel = UILabel()
    
    var mainPicture = UIImageView()
    var textPicture = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LaunchScreen()")
        self.view.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        
        createProgressView(progressLine)
        createProgressLabel(percentLabel)
        createMainPicture(mainPicture)
        
        createTextLabel(textPicture)
        
        createMainPictureConstraint()
        createTextLabelConstraint()
        
        createProgressLabelConstraint()
        createProgressViewConstraint()
        
    }

    
    private lazy var spinner: CustomSpinnerSimple = {
            let spinner = CustomSpinnerSimple(squareLength: 100)
            return spinner
        }()
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

}
class Core {
    static let shared = Core()
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: StatusOfUser.isNewUser.rawValue)
    }
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: StatusOfUser.isNewUser.rawValue)
    }
}


extension LaunchScreen {
    func createProgressLabel(_ label: UILabel){
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.textColor = .white
        percentLabel.textAlignment = .left
        percentLabel.text = "0%"
        
        self.view.addSubview(percentLabel)
    }
    
    func createProgressView(_ progress: UIProgressView){
        progressLine.translatesAutoresizingMaskIntoConstraints = false
        progressLine.progressViewStyle = .default

        progressLine.progressTintColor = #colorLiteral(red: 0.4356435537, green: 0.7536904812, blue: 0.5441738367, alpha: 1)
        progressLine.trackTintColor = #colorLiteral(red: 0.3402369618, green: 0.3682516813, blue: 0.4323373735, alpha: 1)
        progressLine.layer.cornerRadius = 8
        progressLine.clipsToBounds = true
        self.view.addSubview(progressLine)
    }
    
    func set(progress: Float){
        percentLabel.text = "\(Int(progress * 100))%"
        progressLine.progress = progress
    }

    func createProgressLabelConstraint(){
        percentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        percentLabel.topAnchor.constraint(equalTo: textPicture.bottomAnchor, constant: 120).isActive = true
        percentLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    

    
    func createProgressViewConstraint(){
        progressLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 90).isActive = true
        progressLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90).isActive = true
        progressLine.heightAnchor.constraint(equalToConstant: 16).isActive = true
        progressLine.topAnchor.constraint(equalTo: percentLabel.bottomAnchor, constant: 0).isActive = true
    }
    
    func createMainPicture(_ picture: UIImageView){
        mainPicture.translatesAutoresizingMaskIntoConstraints = false
        mainPicture.image = UIImage(named: "LaunchPicture")
        mainPicture.contentMode = .scaleAspectFit
        self.view.addSubview(mainPicture)
    }
    
    func createTextLabel(_ label: UILabel){
        textPicture.translatesAutoresizingMaskIntoConstraints = false
        
        textPicture.font = UIFont(name: "Vasek", size: 1000)
        textPicture.numberOfLines = 1
        textPicture.adjustsFontSizeToFitWidth = true
        textPicture.textAlignment = .center
        textPicture.text = "Здоровье".localized()
        textPicture.textColor = #colorLiteral(red: 0, green: 0.3431890011, blue: 0, alpha: 1)
        self.view.addSubview(textPicture)
    }

    func createMainPictureConstraint(){
        mainPicture.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        mainPicture.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        mainPicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainPicture.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    

    func createTextLabelConstraint(){
        textPicture.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 75).isActive = true
        textPicture.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -75).isActive = true
        textPicture.topAnchor.constraint(equalTo: mainPicture.bottomAnchor, constant: -80).isActive = true
        textPicture.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
}
