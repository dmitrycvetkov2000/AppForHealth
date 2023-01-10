//
//  ResultVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 19.12.2022.
//

import UIKit

protocol ResultVCProtocol: AnyObject {
    
}

class ResultVC: UIViewController {
    var presenter: ResultPresenterProtocol?
    
    var labelResult = UILabel()
    var imtResultLabel = UILabel()
     
    var caloriesLabel = UILabel()
    
    var numberOfWaterLabel = UILabel()
    
    var okButton = UIButton()
    
    
    lazy var age: Int16? = nil
    lazy var gender: String? = nil
    lazy var height: Int16? = nil
    lazy var weight: Int16? = nil
    
    lazy var activity: String? = nil
    lazy var goal: String? = nil
    
    lazy var bmr: Double? =  nil
    lazy var numberOfWater: Int? = nil
    
    lazy var imt: Float? = nil
    lazy var squareOfHeight: Int16? = nil
    lazy var squareOfHeightDel: Float? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoaded(vc: self, labelResult: labelResult)
        
        createIMTLabel(imtResultLabel)
        
        createCaloriesLabel(caloriesLabel)
        
        createNumberOfWaterLabel(numberOfWaterLabel)
        
        createOkButton(okButton)
    }
    
    @objc func goMainAndStart() {
        presenter?.didTapOkButton()
    }
}
    
extension ResultVC: ResultVCProtocol {
    
    func createIMTLabel(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.font = UIFont(name: "Vasek", size: 1000)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .left
        label.textColor = .white
        presenter?.culculationIMT(imtResultLabel: imtResultLabel)
        
        label.topAnchor.constraint(equalTo: labelResult.bottomAnchor, constant: 10).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 62).isActive = true
    }
    
    func createCaloriesLabel(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.font = UIFont(name: "Vasek", size: 1000)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .left
        label.textColor = .white
        label.text = String("Предложенное количество калорий: \(presenter?.culculationCalories() ?? 0)")
        
        label.topAnchor.constraint(equalTo: imtResultLabel.bottomAnchor, constant: 10).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 62).isActive = true
    }
    
    func createNumberOfWaterLabel(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.font = UIFont(name: "Vasek", size: 1000)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .left
        label.textColor = .white
        label.text = String("Нужно пить: \(presenter?.calculateNumberOfWater() ?? 0) мл воды в день")
        
        label.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 10).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 62).isActive = true
    }
    
    func createOkButton(_ button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.setTitle("Ок", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .cyan
        
        button.addTarget(self, action: #selector(goMainAndStart), for: .touchUpInside)
        
        button.heightAnchor.constraint(equalToConstant: 62).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}
