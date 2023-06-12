//
//  SettingVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 09.01.2023.
//

import UIKit

protocol SettingVCProtocol: AnyObject {
    func configureNavifationItems()
    
    func setupLayout()
    
    func createButtonForExit()
    func createConstraintsForButtonForExit()
    
    func addLabelForGender()
    
    func addStackViewForGender()
    
    func createLabelForAgeHeightWeightAndWaist()
    
    func createStackViewForAgeHeightAndWeightTextFields()
    
    func createLabelOfActivity()
    
    func createStackViewForActivity()
    
    func createLabelForGoal()
    
    func createStackViewForGoal()
    
    func createButtonForSave()
    
    func showAlertAboutSave()
}

class SettingVC: UIViewController {
    var presenter: SettingPresenterProtocol?
    
    var buttonForSave = MainButton()
    var buttonForExit = MainButton()
    
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var labelForGender = JustText()
    
    var stackViewForGender = UIStackView()
    var manButton = MiniButton()
    var womanButton = MiniButton()
    
    var labelForAgeHeightAndWeight = JustText()
    
    var stackViewForAgeWeightHeightTextField = UIStackView()
    
    var ageTextField = MyTextField()
    var weightTextField = MyTextField()
    var heightTextField = MyTextField()
    
    var labelOfActivity = JustText()
    
    var stackViewForActivity = UIStackView()
    var lowActivity = MiniButton()
    var middleActivity = MiniButton()
    var hightActivity = MiniButton()
    
    var labelForGoal = JustText()
    
    var stackViewForGoal = UIStackView()
    var loseWeightButton = MiniButton()
    var saveWeightButton = MiniButton()
    var gainWeightButton = MiniButton()
    
    var gender: String = ""
    var age: Int? = 0
    var weight: Int? = 0
    var height: Int? = 0
    var levelOfActivity: String = ""
    var goal: String = ""
    
    var tapRecognizer: UITapGestureRecognizer?
    var swipeRecognizer: UISwipeGestureRecognizer?
    
    func setSwipeRecognizer() {
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipeRecognizer!.direction = .right
        view.addGestureRecognizer(swipeRecognizer!)
    }
    @objc func swipeGesture(sender: UISwipeGestureRecognizer) {
        presenter?.didTapOnBackButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        setSwipeRecognizer()
        setTapRecognizer()
        presenter?.viewDidLoaded()
    }
    
    @objc func exitAction() {
        presenter?.didExit()
    }
    @objc func saveAction() {
        presenter?.didTapOnSaveButton(gender: self.gender, age: ageTextField.text ?? "0", weight: weightTextField.text ?? "0", height: heightTextField.text ?? "0", levelOfActivity: self.levelOfActivity, goal: self.goal)
    }
    @objc func tapOnMenButton() {
        womanButton.backgroundColor = .noActiveColor
        manButton.backgroundColor = .activeColor
        gender = Genders.man.rawValue
    }
    @objc func tapOnWomanButton() {
        manButton.backgroundColor = .noActiveColor
        womanButton.backgroundColor = .activeColor
        gender = Genders.woman.rawValue
    }
    @objc func tapOnlowActivityButton() {
        lowActivity.backgroundColor = .activeColor
        middleActivity.backgroundColor = .noActiveColor
        hightActivity.backgroundColor = .noActiveColor
        levelOfActivity = LevelOfActivityEnum.low.rawValue
    }
    @objc func tapOnmiddleActivityButton() {
        lowActivity.backgroundColor = .noActiveColor
        middleActivity.backgroundColor = .activeColor
        hightActivity.backgroundColor = .noActiveColor
        levelOfActivity = LevelOfActivityEnum.middle.rawValue
    }
    @objc func tapOnhightActivityButton() {
        lowActivity.backgroundColor = .noActiveColor
        middleActivity.backgroundColor = .noActiveColor
        hightActivity.backgroundColor = .activeColor
        levelOfActivity = LevelOfActivityEnum.hight.rawValue
    }
    @objc func tapOnLoseWeightButton() {
        loseWeightButton.backgroundColor = .activeColor
        saveWeightButton.backgroundColor = .noActiveColor
        gainWeightButton.backgroundColor = .noActiveColor
        goal = Goals.leaveWeight.rawValue
    }
    @objc func tapOnSaveWeightButton() {
        loseWeightButton.backgroundColor = .noActiveColor
        saveWeightButton.backgroundColor = .activeColor
        gainWeightButton.backgroundColor = .noActiveColor
        goal = Goals.norma.rawValue
    }
    @objc func tapOnGainWeightButton() {
        loseWeightButton.backgroundColor = .noActiveColor
        saveWeightButton.backgroundColor = .noActiveColor
        gainWeightButton.backgroundColor = .activeColor
        goal = Goals.weightUp.rawValue
    }
}

extension SettingVC: SettingVCProtocol {
    func configureNavifationItems() {
        let leftButton = UIButton()

        leftButton.clipsToBounds = true
        leftButton.widthAnchor.constraint(equalToConstant: 61).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        leftButton.layer.cornerRadius = 0.5 * leftButton.bounds.size.width
        
        leftButton.setBackgroundImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
        leftButton.tintColor = .tabBarMainColor
        leftButton.addTarget(self, action: #selector(comeback), for: .touchUpInside)
        
        let leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func comeback() {
        presenter?.didTapOnBackButton()
    }
    
    func setupLayout() {
        createScrollView()
        createContentView()
        prepareScrollView()
    }
    
    func createScrollView() {
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
    }
    func createContentView() {
        //contentView.backgroundColor = .yellow
    }
    func prepareScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            make.bottom.equalTo(scrollView.snp.bottom)
            
            make.height.equalTo(scrollView.snp.height).inset(-100)
            make.width.equalTo(scrollView.snp.width)
        }
    }
    
    func addLabelForGender() {
        labelForGender.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelForGender)

        labelForGender.text = "Ваш пол".localized()
        
        labelForGender.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        labelForGender.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        labelForGender.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
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

        manButton.setTitle("Мужчина".localized(), for: .normal)
        womanButton.setTitle("Женщина".localized(), for: .normal)
        
        DispatchQueue.main.async {
            let curGender: String? = self.presenter?.getElement(elementName: "gender")
            if let curGender = curGender {
                if curGender == Genders.man.rawValue {
                    self.gender = Genders.man.rawValue
                    self.manButton.backgroundColor = .activeColor
                }
                if curGender == Genders.woman.rawValue {
                    self.gender = Genders.woman.rawValue
                    self.womanButton.backgroundColor = .activeColor
                }
            }
        }
        manButton.addTarget(self, action: #selector(tapOnMenButton), for: .touchUpInside)
        womanButton.addTarget(self, action: #selector(tapOnWomanButton), for: .touchUpInside)
        
        stackViewForGender.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackViewForGender.topAnchor.constraint(equalTo: labelForGender.bottomAnchor, constant: 0).isActive = true
        stackViewForGender.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        stackViewForGender.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        manButton.widthAnchor.constraint(equalTo: womanButton.widthAnchor).isActive = true
    }
    
    func createLabelForAgeHeightWeightAndWaist() {
        labelForAgeHeightAndWeight.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelForAgeHeightAndWeight)

        labelForAgeHeightAndWeight.text = "Ваш возраст, вес, рост".localized()
        
        labelForAgeHeightAndWeight.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        labelForAgeHeightAndWeight.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        labelForAgeHeightAndWeight.topAnchor.constraint(equalTo: stackViewForGender.bottomAnchor, constant: 20).isActive = true
    }
    
    func createStackViewForAgeHeightAndWeightTextFields() {
        
        stackViewForAgeWeightHeightTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        heightTextField.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackViewForAgeWeightHeightTextField)
        
        ageTextField.delegate = self
        weightTextField.delegate = self
        heightTextField.delegate = self
        
        stackViewForAgeWeightHeightTextField.addArrangedSubview(ageTextField)
        stackViewForAgeWeightHeightTextField.addArrangedSubview(weightTextField)
        stackViewForAgeWeightHeightTextField.addArrangedSubview(heightTextField)
        
        stackViewForAgeWeightHeightTextField.spacing = 20
        stackViewForAgeWeightHeightTextField.axis = .horizontal
        
        ageTextField.borderStyle = .roundedRect
        weightTextField.borderStyle = .roundedRect
        heightTextField.borderStyle = .roundedRect
        
        ageTextField.attributedPlaceholder = NSAttributedString(
            string: "Возраст".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6783986092, green: 0.7456328273, blue: 0.6901838183, alpha: 1)]
        )
        weightTextField.attributedPlaceholder = NSAttributedString(
            string: "Вес".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6783986092, green: 0.7456328273, blue: 0.6901838183, alpha: 1)]
        )
        heightTextField.attributedPlaceholder = NSAttributedString(
            string: "Рост".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6783986092, green: 0.7456328273, blue: 0.6901838183, alpha: 1)]
        )
        
        ageTextField.keyboardType = .numbersAndPunctuation
        weightTextField.keyboardType = .numbersAndPunctuation
        heightTextField.keyboardType = .numbersAndPunctuation
        
        DispatchQueue.main.async {
            let age: Int16? = self.presenter?.getElement(elementName: "age")
            let weight: Int16? = self.presenter?.getElement(elementName: "weight")
            let height: Int16? = self.presenter?.getElement(elementName: "height")

            self.ageTextField.text = String(age ?? 0)
            self.weightTextField.text = String(weight ?? 0)
            self.heightTextField.text = String(height ?? 0)
        }
        
        stackViewForAgeWeightHeightTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackViewForAgeWeightHeightTextField.topAnchor.constraint(equalTo: labelForAgeHeightAndWeight.bottomAnchor, constant: 0).isActive = true
        stackViewForAgeWeightHeightTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        stackViewForAgeWeightHeightTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        ageTextField.widthAnchor.constraint(equalTo: weightTextField.widthAnchor).isActive = true
        heightTextField.widthAnchor.constraint(equalTo: ageTextField.widthAnchor).isActive = true
    }
    
    func createLabelOfActivity() {
        labelOfActivity.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelOfActivity)

        labelOfActivity.text = "Ваш уровень активности".localized()
        
        labelOfActivity.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        labelOfActivity.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        labelOfActivity.topAnchor.constraint(equalTo: stackViewForAgeWeightHeightTextField.bottomAnchor, constant: 20).isActive = true
    }
    
    func createStackViewForActivity() {
        stackViewForActivity.translatesAutoresizingMaskIntoConstraints = false
        lowActivity.translatesAutoresizingMaskIntoConstraints = false
        middleActivity.translatesAutoresizingMaskIntoConstraints = false
        hightActivity.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackViewForActivity)
        
        stackViewForActivity.addArrangedSubview(lowActivity)
        stackViewForActivity.addArrangedSubview(middleActivity)
        stackViewForActivity.addArrangedSubview(hightActivity)
        
        stackViewForActivity.spacing = 20
        stackViewForActivity.axis = .horizontal
        
        lowActivity.setTitle("Низкий".localized(), for: .normal)
        middleActivity.setTitle("Средний".localized(), for: .normal)
        hightActivity.setTitle("Высокий".localized(), for: .normal)
        
        DispatchQueue.main.async {
            let curActivity: String? = self.presenter?.getElement(elementName: "levelOfActivity")
            if let curActivity = curActivity {
                switch curActivity {
                case LevelOfActivityEnum.low.rawValue:
                    self.lowActivity.backgroundColor = .activeColor
                    self.levelOfActivity = LevelOfActivityEnum.low.rawValue
                    break
                case LevelOfActivityEnum.middle.rawValue:
                    self.middleActivity.backgroundColor = .activeColor
                    self.levelOfActivity = LevelOfActivityEnum.middle.rawValue
                    break
                case LevelOfActivityEnum.hight.rawValue:
                    self.hightActivity.backgroundColor = .activeColor
                    self.levelOfActivity = LevelOfActivityEnum.hight.rawValue
                    break
                default:
                    print("")
                }
            }
        }
        
        lowActivity.addTarget(self, action: #selector(tapOnlowActivityButton), for: .touchUpInside)
        middleActivity.addTarget(self, action: #selector(tapOnmiddleActivityButton), for: .touchUpInside)
        hightActivity.addTarget(self, action: #selector(tapOnhightActivityButton), for: .touchUpInside)
                
        stackViewForActivity.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackViewForActivity.topAnchor.constraint(equalTo: labelOfActivity.bottomAnchor, constant: 0).isActive = true
        stackViewForActivity.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        stackViewForActivity.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        lowActivity.widthAnchor.constraint(equalTo: middleActivity.widthAnchor).isActive = true
        hightActivity.widthAnchor.constraint(equalTo: lowActivity.widthAnchor).isActive = true
    }
    
    func createLabelForGoal() {
        labelForGoal.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelForGoal)

        labelForGoal.text = "Ваша цель".localized()
        
        labelForGoal.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        labelForGoal.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        labelForGoal.topAnchor.constraint(equalTo: stackViewForActivity.bottomAnchor, constant: 20).isActive = true
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
        
        loseWeightButton.setTitle("Похудеть".localized(), for: .normal)
        saveWeightButton.setTitle("Норма".localized(), for: .normal)
        gainWeightButton.setTitle("Набрать вес".localized(), for: .normal)
        
        saveWeightButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        DispatchQueue.main.async {
            let curGoal: String? = self.presenter?.getElement(elementName: "goal")
            if let curGoal = curGoal {
                switch curGoal {
                case Goals.leaveWeight.rawValue:
                    self.loseWeightButton.backgroundColor = .activeColor
                    self.goal = Goals.leaveWeight.rawValue
                case Goals.norma.rawValue:
                    self.saveWeightButton.backgroundColor = .activeColor
                    self.goal = Goals.norma.rawValue
                case Goals.weightUp.rawValue:
                    self.gainWeightButton.backgroundColor = .activeColor
                    self.goal = Goals.weightUp.rawValue
                    
                default:
                    print("")
                }
            }
        }
        
        loseWeightButton.addTarget(self, action: #selector(tapOnLoseWeightButton), for: .touchUpInside)
        saveWeightButton.addTarget(self, action: #selector(tapOnSaveWeightButton), for: .touchUpInside)
        gainWeightButton.addTarget(self, action: #selector(tapOnGainWeightButton), for: .touchUpInside)
                
        stackViewForGoal.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackViewForGoal.topAnchor.constraint(equalTo: labelForGoal.bottomAnchor, constant: 0).isActive = true
        stackViewForGoal.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        stackViewForGoal.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        loseWeightButton.widthAnchor.constraint(equalTo: saveWeightButton.widthAnchor).isActive = true
        gainWeightButton.widthAnchor.constraint(equalTo: loseWeightButton.widthAnchor).isActive = true
    }
    
    func createButtonForExit() {
        view.addSubview(buttonForExit)
        
        buttonForExit.setTitle("Выйти из аккаунта".localized(), for: .normal)
        buttonForExit.setTitleColor(.white, for: .normal)
        buttonForExit.backgroundColor = .red
        buttonForExit.layer.borderColor = #colorLiteral(red: 0.3127223253, green: 0, blue: 0.04685305804, alpha: 1)
        
        buttonForExit.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
    }
    
    func createConstraintsForButtonForExit() {
        buttonForExit.translatesAutoresizingMaskIntoConstraints = false
        
        buttonForExit.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        buttonForExit.heightAnchor.constraint(equalToConstant: 60).isActive = true
        buttonForExit.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
        buttonForExit.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
    }

    func createButtonForSave() {
        buttonForSave.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonForSave)
        
        buttonForSave.setTitle("Сохранить".localized(), for: .normal)
        
        buttonForSave.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        
        buttonForSave.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        buttonForSave.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        buttonForSave.topAnchor.constraint(equalTo: stackViewForGoal.bottomAnchor, constant: 50).isActive = true
        buttonForSave.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
    }
    
    func showAlertAboutSave() {
        let alert = UIAlertController(title: "Сохранение в базу данных".localized(), message: "Успешно".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок".localized(), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Gestures
    func setTapRecognizer() {
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        view.addGestureRecognizer(tapRecognizer!)
    }
    @objc func tapGesture() {
        view.endEditing(true)
    }
}

// MARK: - TextFieldsDelegate
extension SettingVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
