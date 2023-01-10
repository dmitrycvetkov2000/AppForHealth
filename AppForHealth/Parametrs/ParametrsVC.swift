//
//  ParametrsVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 18.12.2022.
//

import UIKit

protocol ParametrsVCProtocol: AnyObject {
    
}

class ParametrsVC: UIViewController {
    var presenter: ParametrsPresenterProtocol?
    
    lazy var gender: String? = nil
    
    lazy var age: Int? = nil
    lazy var weight: Int? = nil
    lazy var height: Int? = nil
    
    lazy var levelOfActivity: String? = nil
    
    lazy var goal: String? = nil
    
    var labelParametry = UILabel()
    
    var firstStackView = UIStackView()
    var menButton = UIButton()
    var womanButton = UIButton()
    
    
    var secondStackView = UIStackView()
    var ageTextField = UITextField()
    var weightTextField = UITextField()
    var heightTextField = UITextField()
    
    var levelOfActivityLabel = UILabel()
    
    
    var fourthStackView = UIStackView()
    var lowButtonActivity = UIButton()
    var middleButtonActivity = UIButton()
    var highButtonActivity = UIButton()
    
    var goalLabel = UILabel()
    
    var fiveStackView = UIStackView()
    var loseWeightButton = UIButton()
    var normalButton = UIButton()
    var hainWeight = UIButton()
    
    var saveButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        createLabelParametry(labelParametry)
        createFirstStackView(firstStackView, button1: menButton, button2: womanButton)
        
        createSecondStackView(secondStackView, textFieldAge: ageTextField, textFieldWeight: weightTextField, textFieldHeight: heightTextField)
        
        createLevelOfActivityLabel(levelOfActivityLabel)
        
        createThourthStackView(fourthStackView, button1: lowButtonActivity, button2: middleButtonActivity, button3: highButtonActivity)
        
        createGoalLabel(goalLabel)
        
        createFiveStackView(fiveStackView, button1: loseWeightButton, button2: normalButton, button3: hainWeight)
        
        createSaveButton(saveButton)
           
    }
    

    @objc func tapOnMenButton() {
        womanButton.backgroundColor = .gray
        menButton.backgroundColor = .black
        gender = "Мужчина"
    }
    @objc func tapOnWomanButton() {
        menButton.backgroundColor = .gray
        womanButton.backgroundColor = .black
        gender = "Женщина"
    }
    

    @objc func tapOnLowActivityButton() {
        lowButtonActivity.backgroundColor = .white
        middleButtonActivity.backgroundColor = .clear
        highButtonActivity.backgroundColor = .clear
        
        levelOfActivity = "Низкий"
    }
    @objc func tapOnMiddleActivityButton() {
        lowButtonActivity.backgroundColor = .clear
        middleButtonActivity.backgroundColor = .white
        highButtonActivity.backgroundColor = .clear
        
        levelOfActivity = "Средний"
    }
    @objc func tapOnHighActivityButton() {
        lowButtonActivity.backgroundColor = .clear
        middleButtonActivity.backgroundColor = .clear
        highButtonActivity.backgroundColor = .white
        
        levelOfActivity = "Высокий"
    }
    
    
    @objc func tapONLoseWeightButton() {
        loseWeightButton.backgroundColor = .black
        loseWeightButton.setTitleColor(.white, for: .normal)
        normalButton.backgroundColor = .gray
        hainWeight.backgroundColor = .gray
        
        goal = "Похудеть"
    }
    @objc func tapONNormalWeightButton() {
        loseWeightButton.backgroundColor = .gray
        normalButton.backgroundColor = .black
        normalButton.setTitleColor(.white, for: .normal)
        hainWeight.backgroundColor = .gray
        
        goal = "Норма"
    }
    @objc func tapONGainWeightButton() {
        loseWeightButton.backgroundColor = .gray
        normalButton.backgroundColor = .gray
        hainWeight.backgroundColor = .black
        hainWeight.setTitleColor(.white, for: .normal)
        
        goal = "Набрать"
    }
    
    @objc func tapOnSaveButton() {
        
        presenter?.didTappedSaveButton(ageTextField: ageTextField, gender: gender ?? "Unknown", goal: goal ?? "Unknown", heightTextField: heightTextField, levelOfActivity: levelOfActivity ?? "Unknown", weightTextField: weightTextField)

    }
}

extension ParametrsVC: ParametrsVCProtocol {
    func createLabelParametry(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.font = UIFont(name: "Vasek", size: 1000)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Ваши параметры"
        
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func createFirstStackView(_ stackView: UIStackView, button1: UIButton, button2: UIButton) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        
        stackView.spacing = 20
        stackView.axis = .horizontal
        
        button1.backgroundColor = .gray
        button2.backgroundColor = .gray
        
        button1.setTitle("Мужчина", for: .normal)
        button2.setTitle("Женщина", for: .normal)
        button1.setTitleColor(.white, for: .normal)
        button2.setTitleColor(.white, for: .normal)
        
        
        button1.addTarget(self, action: #selector(tapOnMenButton), for: .touchUpInside)
        button2.addTarget(self, action: #selector(tapOnWomanButton), for: .touchUpInside)
        
        
        
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: labelParametry.bottomAnchor, constant: 40).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        button1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button1.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0).isActive = true
        
        button2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button2.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0).isActive = true
        
        button1.widthAnchor.constraint(equalTo: button2.widthAnchor).isActive = true
    }
    
    func createSecondStackView(_ stackView: UIStackView, textFieldAge: UITextField, textFieldWeight: UITextField, textFieldHeight: UITextField) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        textFieldAge.translatesAutoresizingMaskIntoConstraints = false
        textFieldWeight.translatesAutoresizingMaskIntoConstraints = false
        textFieldHeight.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(textFieldAge)
        stackView.addArrangedSubview(textFieldWeight)
        stackView.addArrangedSubview(textFieldHeight)
        
        stackView.spacing = 20
        stackView.axis = .horizontal
        
        textFieldAge.placeholder = "Возраст"
        textFieldWeight.placeholder = "Вес"
        textFieldHeight.placeholder = "Рост"
        
        textFieldAge.backgroundColor = .white
        textFieldWeight.backgroundColor = .white
        textFieldHeight.backgroundColor = .white
        
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 40).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        textFieldAge.heightAnchor.constraint(equalToConstant: 20).isActive = true
        textFieldAge.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0).isActive = true
        
        textFieldWeight.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        textFieldHeight.heightAnchor.constraint(equalToConstant: 20).isActive = true
        textFieldHeight.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0).isActive = true
        
        textFieldAge.widthAnchor.constraint(equalTo: textFieldHeight.widthAnchor).isActive = true
        textFieldWeight.widthAnchor.constraint(equalTo: textFieldAge.widthAnchor).isActive = true
    }
    
    func createLevelOfActivityLabel(_ labelOfActivity: UILabel) {
        labelOfActivity.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelOfActivity)
        labelOfActivity.textColor = .white
        labelOfActivity.textAlignment = .left
        
        labelOfActivity.font = UIFont(name: "Vasek", size: 1000)
        labelOfActivity.numberOfLines = 1
        labelOfActivity.adjustsFontSizeToFitWidth = true
        labelOfActivity.text = "Уровень активности"
        
        labelOfActivity.topAnchor.constraint(equalTo: secondStackView.bottomAnchor, constant: 0).isActive = true
        labelOfActivity.heightAnchor.constraint(equalToConstant: 68).isActive = true
        labelOfActivity.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        labelOfActivity.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }

    
    func createThourthStackView(_ stackView: UIStackView, button1: UIButton, button2: UIButton, button3: UIButton) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(button3)
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        button1.backgroundColor = .clear
        button2.backgroundColor = .clear
        button3.backgroundColor = .clear
        
        button1.setTitle("Низкий", for: .normal)
        button2.setTitle("Средний", for: .normal)
        button3.setTitle("Высокий", for: .normal)
        
        button1.setTitleColor(.black, for: .normal)
        button2.setTitleColor(.black, for: .normal)
        button3.setTitleColor(.black, for: .normal)
        
        button1.addTarget(self, action: #selector(tapOnLowActivityButton), for: .touchUpInside)
        button2.addTarget(self, action: #selector(tapOnMiddleActivityButton), for: .touchUpInside)
        button3.addTarget(self, action: #selector(tapOnHighActivityButton), for: .touchUpInside)
        
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: levelOfActivityLabel.bottomAnchor, constant: 20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        button1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button1.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0).isActive = true
        
        button2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        button3.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button3.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0).isActive = true
        
        button1.widthAnchor.constraint(equalTo: button3.widthAnchor).isActive = true
        button2.widthAnchor.constraint(equalTo: button1.widthAnchor).isActive = true
    }
    
    func createGoalLabel(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.font = UIFont(name: "Vasek", size: 1000)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.text = "Цель"
        
        label.textAlignment = .left
        label.textColor = .white
        
        label.topAnchor.constraint(equalTo: fourthStackView.bottomAnchor, constant: 20).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 68).isActive = true
    }
    
    func createFiveStackView(_ stackView: UIStackView, button1: UIButton, button2: UIButton, button3: UIButton) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(button3)
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        button1.backgroundColor = .white
        button2.backgroundColor = .white
        button3.backgroundColor = .white
        
        button1.setTitle("Похудеть", for: .normal)
        button2.setTitle("Норма", for: .normal)
        button3.setTitle("Набрать", for: .normal)
        
        button1.setTitleColor(.black, for: .normal)
        button2.setTitleColor(.black, for: .normal)
        button3.setTitleColor(.black, for: .normal)
        
        button1.addTarget(self, action: #selector(tapONLoseWeightButton), for: .touchUpInside)
        button2.addTarget(self, action: #selector(tapONNormalWeightButton), for: .touchUpInside)
        button3.addTarget(self, action: #selector(tapONGainWeightButton), for: .touchUpInside)
        
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: goalLabel.bottomAnchor, constant: 10).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        button1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button1.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0).isActive = true
        
        button2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        button3.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button3.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0).isActive = true
        
        button1.widthAnchor.constraint(equalTo: button3.widthAnchor).isActive = true
        button2.widthAnchor.constraint(equalTo: button1.widthAnchor).isActive = true
    }
    
    func createSaveButton(_ button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.backgroundColor = .black
        button.setTitle("Сохранить", for: .normal)
        
        button.addTarget(self, action: #selector(tapOnSaveButton), for: .touchUpInside)
        
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}


