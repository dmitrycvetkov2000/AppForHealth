//
//  SettingVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 09.01.2023.
//

import UIKit

protocol SettingVCProtocol: AnyObject {
    
    func createButtonForExit()
    func createConstraintsForButtonForExit()
    
    func addScrollView()
    
    func addLabelForGender()
    
    func addStackViewForGender()
    
    func createLabelForAgeHeightAndWeight()
    
    func createStackViewForAgeHeightAndWeightTextFields()
    
    func createLabelOfActivity()
    
    func createStackViewForActivity()
    
    func createLabelForGoal()
    
    func createStackViewForGoal()
    
}

class SettingVC: UIViewController {
    var presenter: SettingPresenterProtocol?
    
    var buttonForExit = UIButton()
    
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var labelForGender = UILabel()
    
    var stackViewForGender = UIStackView()
    var manButton = UIButton()
    var womanButton = UIButton()
    
    
    var labelForAgeHeightAndWeight = UILabel()
    
    var stackViewForAgeWeightHeightTextField = UIStackView()
    
    var ageTextField = UITextField()
    var weightTextField = UITextField()
    var heightTextField = UITextField()
    
    
    var labelOfActivity = UILabel()
    
    var stackViewForActivity = UIStackView()
    var lowActivity = UIButton()
    var middleActivity = UIButton()
    var hightActivity = UIButton()
    
    var labelForGoal = UILabel()
    
    var stackViewForGoal = UIStackView()
    var loseWeightButton = UIButton()
    var saveWeightButton = UIButton()
    var gainWeightButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        presenter?.viewDidLoaded()
        
        
    }
    
    @objc func exitAction() {
        presenter?.didExit()
    }
}

extension SettingVC: SettingVCProtocol {
    
    func createButtonForExit() {
        view.addSubview(buttonForExit)
        
        buttonForExit.setTitle("Выйти", for: .normal)
        buttonForExit.setTitleColor(.red, for: .normal)
        buttonForExit.backgroundColor = .blue
        
        buttonForExit.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
    }
    
    func createConstraintsForButtonForExit() {
        buttonForExit.translatesAutoresizingMaskIntoConstraints = false
        
        buttonForExit.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        buttonForExit.heightAnchor.constraint(equalToConstant: 60).isActive = true
        buttonForExit.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        buttonForExit.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    func addScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        
        scrollView.backgroundColor = .brown
        contentView.backgroundColor = .yellow
        
        
        
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 2000).isActive = true

    }
    
    func addLabelForGender() {
        labelForGender.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelForGender)
        
        labelForGender.font = UIFont(name: "Vasek", size: 1000)
        labelForGender.numberOfLines = 1
        labelForGender.adjustsFontSizeToFitWidth = true
        
        labelForGender.textAlignment = .center
        labelForGender.text = "Ваш пол"
        
        labelForGender.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        
        labelForGender.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelForGender.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        labelForGender.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        labelForGender.heightAnchor.constraint(equalToConstant: 60).isActive = true
        

    }
    
    func addStackViewForGender() {
        stackViewForGender.translatesAutoresizingMaskIntoConstraints = false
        manButton.translatesAutoresizingMaskIntoConstraints = false
        womanButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        contentView.addSubview(stackViewForGender)
        
        stackViewForGender.addArrangedSubview(manButton)
        stackViewForGender.addArrangedSubview(womanButton)
        
        stackViewForGender.spacing = 20
        stackViewForGender.axis = .horizontal
        
        manButton.backgroundColor = .gray
        womanButton.backgroundColor = .gray
        
        manButton.setTitle("Мужчина", for: .normal)
        womanButton.setTitle("Женщина", for: .normal)
        manButton.setTitleColor(.white, for: .normal)
        womanButton.setTitleColor(.white, for: .normal)
        
        
//        manButton.addTarget(self, action: #selector(tapOnMenButton), for: .touchUpInside)
//        womanButton.addTarget(self, action: #selector(tapOnWomanButton), for: .touchUpInside)
        
        
        stackViewForGender.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackViewForGender.topAnchor.constraint(equalTo: labelForGender.bottomAnchor, constant: 10).isActive = true
        stackViewForGender.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        stackViewForGender.heightAnchor.constraint(equalToConstant: 60).isActive = true
        

        manButton.widthAnchor.constraint(equalTo: womanButton.widthAnchor).isActive = true
        
    }
    
    func createLabelForAgeHeightAndWeight() {
        labelForAgeHeightAndWeight.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelForAgeHeightAndWeight)
        
        labelForAgeHeightAndWeight.font = UIFont(name: "Vasek", size: 1000)
        labelForAgeHeightAndWeight.numberOfLines = 1
        labelForAgeHeightAndWeight.adjustsFontSizeToFitWidth = true
        
        labelForAgeHeightAndWeight.textAlignment = .center
        labelForAgeHeightAndWeight.text = "Ваш возраст, вес и рост"
        
        labelForAgeHeightAndWeight.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        
        labelForAgeHeightAndWeight.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelForAgeHeightAndWeight.topAnchor.constraint(equalTo: stackViewForGender.bottomAnchor, constant: 20).isActive = true
        labelForAgeHeightAndWeight.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        labelForAgeHeightAndWeight.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func createStackViewForAgeHeightAndWeightTextFields() {
        
        stackViewForAgeWeightHeightTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        heightTextField.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackViewForAgeWeightHeightTextField)
        
        stackViewForAgeWeightHeightTextField.addArrangedSubview(ageTextField)
        stackViewForAgeWeightHeightTextField.addArrangedSubview(weightTextField)
        stackViewForAgeWeightHeightTextField.addArrangedSubview(heightTextField)
        
        stackViewForAgeWeightHeightTextField.spacing = 20
        stackViewForAgeWeightHeightTextField.axis = .horizontal
        
        ageTextField.borderStyle = .roundedRect
        weightTextField.borderStyle = .roundedRect
        heightTextField.borderStyle = .roundedRect
        
        ageTextField.placeholder = "Возраст"
        weightTextField.placeholder = "Вес"
        heightTextField.placeholder = "Рост"
                
        
        stackViewForAgeWeightHeightTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackViewForAgeWeightHeightTextField.topAnchor.constraint(equalTo: labelForAgeHeightAndWeight.bottomAnchor, constant: 10).isActive = true
        stackViewForAgeWeightHeightTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        stackViewForAgeWeightHeightTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        

        ageTextField.widthAnchor.constraint(equalTo: weightTextField.widthAnchor).isActive = true
        heightTextField.widthAnchor.constraint(equalTo: ageTextField.widthAnchor).isActive = true
        
    }
    
    func createLabelOfActivity() {
        labelOfActivity.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelOfActivity)
        
        labelOfActivity.font = UIFont(name: "Vasek", size: 1000)
        labelOfActivity.numberOfLines = 1
        labelOfActivity.adjustsFontSizeToFitWidth = true
        
        labelOfActivity.textAlignment = .center
        labelOfActivity.text = "Ваш уровень активности"
        
        labelOfActivity.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        
        labelOfActivity.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelOfActivity.topAnchor.constraint(equalTo: stackViewForAgeWeightHeightTextField.bottomAnchor, constant: 20).isActive = true
        labelOfActivity.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        labelOfActivity.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func createStackViewForActivity() {
        stackViewForActivity.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        heightTextField.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackViewForActivity)
        
        stackViewForActivity.addArrangedSubview(lowActivity)
        stackViewForActivity.addArrangedSubview(middleActivity)
        stackViewForActivity.addArrangedSubview(hightActivity)
        
        stackViewForActivity.spacing = 20
        stackViewForActivity.axis = .horizontal
        
        lowActivity.setTitle("Низкий", for: .normal)
        middleActivity.setTitle("Средний", for: .normal)
        hightActivity.setTitle("Высокий", for: .normal)
        
        lowActivity.backgroundColor = .black
        middleActivity.backgroundColor = .black
        hightActivity.backgroundColor = .black
                
        
        stackViewForActivity.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackViewForActivity.topAnchor.constraint(equalTo: labelOfActivity.bottomAnchor, constant: 10).isActive = true
        stackViewForActivity.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        stackViewForActivity.heightAnchor.constraint(equalToConstant: 60).isActive = true
        

        lowActivity.widthAnchor.constraint(equalTo: middleActivity.widthAnchor).isActive = true
        hightActivity.widthAnchor.constraint(equalTo: lowActivity.widthAnchor).isActive = true
    }
    
    func createLabelForGoal() {
        labelForGoal.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelForGoal)
        
        labelForGoal.font = UIFont(name: "Vasek", size: 1000)
        labelForGoal.numberOfLines = 1
        labelForGoal.adjustsFontSizeToFitWidth = true
        
        labelForGoal.textAlignment = .center
        labelForGoal.text = "Ваша цель"
        
        labelForGoal.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        
        labelForGoal.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelForGoal.topAnchor.constraint(equalTo: stackViewForActivity.bottomAnchor, constant: 20).isActive = true
        labelForGoal.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        labelForGoal.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func createStackViewForGoal() {
        stackViewForGoal.translatesAutoresizingMaskIntoConstraints = false
        loseWeightButton.translatesAutoresizingMaskIntoConstraints = false
        saveWeightButton.translatesAutoresizingMaskIntoConstraints = false
        gainWeightButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackViewForGoal)
        
        stackViewForGoal.addArrangedSubview(loseWeightButton)
        stackViewForGoal.addArrangedSubview(saveWeightButton)
        stackViewForGoal.addArrangedSubview(gainWeightButton)
        
        stackViewForGoal.spacing = 20
        stackViewForGoal.axis = .horizontal
        
        loseWeightButton.setTitle("Похудеть", for: .normal)
        saveWeightButton.setTitle("Поддерживать вес", for: .normal)
        gainWeightButton.setTitle("Набрать вес", for: .normal)
        
        saveWeightButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        loseWeightButton.backgroundColor = .black
        saveWeightButton.backgroundColor = .black
        gainWeightButton.backgroundColor = .black
                
        
        stackViewForGoal.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackViewForGoal.topAnchor.constraint(equalTo: labelForGoal.bottomAnchor, constant: 10).isActive = true
        stackViewForGoal.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        stackViewForGoal.heightAnchor.constraint(equalToConstant: 60).isActive = true
        

        loseWeightButton.widthAnchor.constraint(equalTo: saveWeightButton.widthAnchor).isActive = true
        gainWeightButton.widthAnchor.constraint(equalTo: loseWeightButton.widthAnchor).isActive = true
    }
}
