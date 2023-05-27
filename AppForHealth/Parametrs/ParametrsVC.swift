//
//  ParametrsVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 18.12.2022.
//

import UIKit

protocol ParametrsVCProtocol: AnyObject {
    func setTapRecognizer()
    func createViewForHello()
}

class ParametrsVC: UIViewController {
    var presenter: ParametrsPresenterProtocol?
    
    lazy var gender: String? = nil
    
    lazy var age: Int? = nil
    lazy var weight: Int? = nil
    lazy var height: Int? = nil
    
    lazy var levelOfActivity: String? = nil
    
    lazy var goal: String? = nil
    
    var labelParametry = LabelTitle()
    
    var firstStackView = UIStackView()
    var menButton = MiniButton()
    var womanButton = MiniButton()
    
    var secondStackView = UIStackView()
    var ageTextField = MyTextField()
    var weightTextField = MyTextField()
    var heightTextField = MyTextField()
    
    var levelOfActivityLabel = JustText()
    
    var fourthStackView = UIStackView()
    var lowButtonActivity = MiniButton()
    var middleButtonActivity = MiniButton()
    var highButtonActivity = MiniButton()
    
    var goalLabel = JustText()
    
    var fiveStackView = UIStackView()
    var loseWeightButton = MiniButton()
    var normalButton = MiniButton()
    var hainWeight = MiniButton()
    
    var saveButton = MainButton()
    
    var tapRecognizer: UITapGestureRecognizer?
    
    var nameForUser: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        presenter?.setTapRecognizer()
        createLabelParametry(labelParametry)
        createFirstStackView(firstStackView, button1: menButton, button2: womanButton)
        
        createSecondStackView(secondStackView, textFieldAge: ageTextField, textFieldWeight: weightTextField, textFieldHeight: heightTextField)
        
        createLevelOfActivityLabel(levelOfActivityLabel)
        
        createThourthStackView(fourthStackView, button1: lowButtonActivity, button2: middleButtonActivity, button3: highButtonActivity)
        
        createGoalLabel(goalLabel)
        
        createFiveStackView(fiveStackView, button1: loseWeightButton, button2: normalButton, button3: hainWeight)
        
        createSaveButton(saveButton)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.createViewForHello()
    }

    @objc func tapOnMenButton() {
        womanButton.backgroundColor = .noActiveColor
        menButton.backgroundColor = .activeColor
        womanButton.layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
        menButton.layer.borderColor = UIColor.forMiniButtonBorder.cgColor
        gender = Genders.man.rawValue
    }
    @objc func tapOnWomanButton() {
        menButton.backgroundColor = .noActiveColor
        womanButton.backgroundColor = .activeColor
        womanButton.layer.borderColor = UIColor.forMiniButtonBorder.cgColor
        menButton.layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
        gender = Genders.woman.rawValue
    }
    

    @objc func tapOnLowActivityButton() {
        lowButtonActivity.backgroundColor = .activeColor
        middleButtonActivity.backgroundColor = .noActiveColor
        highButtonActivity.backgroundColor = .noActiveColor
        
        lowButtonActivity.layer.borderColor = UIColor.forMiniButtonBorder.cgColor
        middleButtonActivity.layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
        highButtonActivity.layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
        
        levelOfActivity = LevelOfActivityEnum.low.rawValue
    }
    @objc func tapOnMiddleActivityButton() {
        lowButtonActivity.backgroundColor = .noActiveColor
        middleButtonActivity.backgroundColor = .activeColor
        highButtonActivity.backgroundColor = .noActiveColor
        
        lowButtonActivity.layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
        middleButtonActivity.layer.borderColor = UIColor.forMiniButtonBorder.cgColor
        highButtonActivity.layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
        
        levelOfActivity = LevelOfActivityEnum.middle.rawValue
    }
    @objc func tapOnHighActivityButton() {
        lowButtonActivity.backgroundColor = .noActiveColor
        middleButtonActivity.backgroundColor = .noActiveColor
        highButtonActivity.backgroundColor = .activeColor
        
        lowButtonActivity.layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
        middleButtonActivity.layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
        highButtonActivity.layer.borderColor = UIColor.forMiniButtonBorder.cgColor
        
        levelOfActivity = LevelOfActivityEnum.hight.rawValue
    }
    
    
    @objc func tapONLoseWeightButton() {
        loseWeightButton.backgroundColor = .activeColor
        normalButton.backgroundColor = .noActiveColor
        hainWeight.backgroundColor = .noActiveColor
        
        loseWeightButton.layer.borderColor = UIColor.forMiniButtonBorder.cgColor
        normalButton.layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
        hainWeight.layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
        
        goal = Goals.leaveWeight.rawValue
    }
    @objc func tapONNormalWeightButton() {
        loseWeightButton.backgroundColor = .noActiveColor
        normalButton.backgroundColor = .activeColor
        hainWeight.backgroundColor = .noActiveColor
        
        loseWeightButton.layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
        normalButton.layer.borderColor = UIColor.forMiniButtonBorder.cgColor
        hainWeight.layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
        
        goal = Goals.norma.rawValue
    }
    @objc func tapONGainWeightButton() {
        loseWeightButton.backgroundColor = .noActiveColor
        normalButton.backgroundColor = .noActiveColor
        hainWeight.backgroundColor = .activeColor
        
        loseWeightButton.layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
        normalButton.layer.borderColor = UIColor.forMiniButtonBorderNoActive.cgColor
        hainWeight.layer.borderColor = UIColor.forMiniButtonBorder.cgColor

        
        goal = Goals.weightUp.rawValue
    }
    
    @objc func tapOnSaveButton() {
        if let ageText = Int(ageTextField.text ?? ""), let gender = gender, let goal = goal, let height = Int(heightTextField.text ?? ""), let levelOfActivity = levelOfActivity, let weight = Int(weightTextField.text ?? "") {
            presenter?.didTappedSaveButton(age: String(ageText), gender: gender, goal: goal, height: String(height), levelOfActivity: levelOfActivity, weight: String(weight))
        } else {
            let alert = UIAlertController(title: "Ошибка".localized(), message: "Проверьте корректность введенных данных".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок".localized(), style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ParametrsVC: ParametrsVCProtocol {
    func createLabelParametry(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        label.text = "Ваши параметры".localized()
        
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
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
        
        button1.setTitle("Мужчина".localized(), for: .normal)
        button2.setTitle("Женщина".localized(), for: .normal)
        
        button1.addTarget(self, action: #selector(tapOnMenButton), for: .touchUpInside)
        button2.addTarget(self, action: #selector(tapOnWomanButton), for: .touchUpInside)
        
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: labelParametry.bottomAnchor, constant: 20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        button1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button1.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0).isActive = true
        
        button2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button2.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0).isActive = true
        
        button1.widthAnchor.constraint(equalTo: button2.widthAnchor).isActive = true
    }
    
    func createSecondStackView(_ stackView: UIStackView, textFieldAge: MyTextField, textFieldWeight: MyTextField, textFieldHeight: MyTextField) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        textFieldAge.translatesAutoresizingMaskIntoConstraints = false
        textFieldWeight.translatesAutoresizingMaskIntoConstraints = false
        textFieldHeight.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(textFieldAge)
        stackView.addArrangedSubview(textFieldWeight)
        stackView.addArrangedSubview(textFieldHeight)
        
        textFieldAge.delegate = self
        textFieldWeight.delegate = self
        textFieldHeight.delegate = self
        
        stackView.spacing = 20
        stackView.axis = .horizontal
        
        textFieldAge.attributedPlaceholder = NSAttributedString(
            string: "Возраст".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6783986092, green: 0.7456328273, blue: 0.6901838183, alpha: 1)]
        )
        textFieldWeight.attributedPlaceholder = NSAttributedString(
            string: "Вес".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6783986092, green: 0.7456328273, blue: 0.6901838183, alpha: 1)]
        )
        textFieldHeight.attributedPlaceholder = NSAttributedString(
            string: "Рост".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6783986092, green: 0.7456328273, blue: 0.6901838183, alpha: 1)]
        )
        
        
        textFieldAge.keyboardType = .numbersAndPunctuation
        textFieldWeight.keyboardType = .numbersAndPunctuation
        textFieldHeight.keyboardType = .numbersAndPunctuation
        
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 40).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        textFieldAge.heightAnchor.constraint(equalToConstant: 20).isActive = true
        textFieldAge.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0).isActive = true
        
        textFieldWeight.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        textFieldHeight.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        textFieldAge.widthAnchor.constraint(equalTo: textFieldHeight.widthAnchor).isActive = true
        textFieldWeight.widthAnchor.constraint(equalTo: textFieldAge.widthAnchor).isActive = true
    }
    
    func createLevelOfActivityLabel(_ labelOfActivity: JustText) {
        labelOfActivity.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelOfActivity)

        labelOfActivity.text = "Уровень активности".localized()
        
        labelOfActivity.topAnchor.constraint(equalTo: secondStackView.bottomAnchor, constant: 40).isActive = true
        labelOfActivity.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        labelOfActivity.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }

    func createThourthStackView(_ stackView: UIStackView, button1: MiniButton, button2: MiniButton, button3: MiniButton) {
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
        
        button1.setTitle("Низкий".localized(), for: .normal)
        button2.setTitle("Средний".localized(), for: .normal)
        button3.setTitle("Высокий".localized(), for: .normal)
        
        button1.addTarget(self, action: #selector(tapOnLowActivityButton), for: .touchUpInside)
        button2.addTarget(self, action: #selector(tapOnMiddleActivityButton), for: .touchUpInside)
        button3.addTarget(self, action: #selector(tapOnHighActivityButton), for: .touchUpInside)
        
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: levelOfActivityLabel.bottomAnchor, constant: 0).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        button1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button1.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0).isActive = true
        
        button2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        button3.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button3.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0).isActive = true
        
        button1.widthAnchor.constraint(equalTo: button3.widthAnchor).isActive = true
        button2.widthAnchor.constraint(equalTo: button1.widthAnchor).isActive = true
    }
    
    func createGoalLabel(_ label: JustText) {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        label.text = "Цель".localized()
        
        label.topAnchor.constraint(equalTo: fourthStackView.bottomAnchor, constant: 40).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
    
    func createFiveStackView(_ stackView: UIStackView, button1: MiniButton, button2: MiniButton, button3: MiniButton) {
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
        
        button1.setTitle("Похудеть".localized(), for: .normal)
        button2.setTitle("Норма".localized(), for: .normal)
        button3.setTitle("Набрать".localized(), for: .normal)
        
        button1.addTarget(self, action: #selector(tapONLoseWeightButton), for: .touchUpInside)
        button2.addTarget(self, action: #selector(tapONNormalWeightButton), for: .touchUpInside)
        button3.addTarget(self, action: #selector(tapONGainWeightButton), for: .touchUpInside)
        
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: goalLabel.bottomAnchor, constant: 0).isActive = true
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
        
        button.setTitle("Сохранить".localized(), for: .normal)
        
        button.addTarget(self, action: #selector(tapOnSaveButton), for: .touchUpInside)
        
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    // MARK: - Gestures
    func setTapRecognizer() {
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        view.addGestureRecognizer(tapRecognizer!)
    }
    @objc func tapGesture() {
        view.endEditing(true)
    }
    
// MARK: - ViewForHello
    func createViewForHello() {
        RealmManager.instance.fillUserRealm()
        if let users = RealmManager.instance.userRealm {
            for user in users {
                nameForUser = user.nameOfUser
            }
        }
        
        if let nameOfUser = nameForUser {
            let viewForName = UIView()
            let label = LabelTitle()
            viewForName.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(viewForName)
            viewForName.addSubview(label)
            
            viewForName.backgroundColor = .tabBarMainColor
            viewForName.clipsToBounds = true
            viewForName.layer.cornerRadius = 20
            viewForName.alpha = 0
            
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 2
            label.text = "Здравствуйте,".localized() + " \(nameOfUser)"
            label.textColor = .forJustText
            
            NSLayoutConstraint.activate([
                viewForName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
                viewForName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
                viewForName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                viewForName.heightAnchor.constraint(equalToConstant: 150),
                
                label.leftAnchor.constraint(equalTo: viewForName.leftAnchor, constant: 20),
                label.rightAnchor.constraint(equalTo: viewForName.rightAnchor, constant: -20),
                label.centerYAnchor.constraint(equalTo: viewForName.centerYAnchor)
            ])

            UIView.animate(withDuration: 2.5) {
                viewForName.alpha = 1.0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    UIView.animate(withDuration: 2.5) {
                        viewForName.alpha = 0.0
                    }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    viewForName.layer.removeAllAnimations()
                    viewForName.removeFromSuperview()
                }
            }
        }
    }
}

extension ParametrsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

