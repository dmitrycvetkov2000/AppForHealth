//
//  AddFoodVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.03.2023.
//

import UIKit
import RealmSwift

protocol AddFoodVCProtocol: AnyObject {
    func fillTextFields(res: Double, prot: Double, fat: Double, carb: Double, ccal: Double)
}

class AddFoodVC: UIViewController {
    var presenter: AddFoodPresenterProtocol?
    
    let labelForTitle = UILabel()
    
    let timeLabel = UILabel()
    let timeTextField = UITextField()
    let stackForTime = UIStackView()
    
    let productLabel = UILabel()
    let productTextField = UITextField()
    let stackForProduct = UIStackView()
    
    let weightLabel = UILabel()
    let weightTextField = UITextField()
    let stackForWeight = UIStackView()
    
    let proteinsLabel = UILabel()
    let proteinsTextField = UITextField()
    let stackForProteins = UIStackView()
    
    let fatsLabel = UILabel()
    let fatsTextField = UITextField()
    let stackForFats = UIStackView()
    
    let carbLabel = UILabel()
    let carbTextField = UITextField()
    let stackForCarb = UIStackView()
    
    let ccalLabel = UILabel()
    let ccalTextField = UITextField()
    let stackForCcal = UIStackView()
    
    let buttonForCancel = UIButton()
    let buttonForAccept = UIButton()
    
    let realm = try! Realm()
    
    let defaults = UserDefaults.standard
    
    var returLeftBarButton = UIButton()
    var rightBarButton = UIButton()
    
    var labelEating = UILabel()
    
    var swipeRecognizer: UISwipeGestureRecognizer?
    
    func setSwipeRecognizer() {
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipeRecognizer!.direction = .right
        view.addGestureRecognizer(swipeRecognizer!)
    }
    @objc func swipeGesture(sender: UISwipeGestureRecognizer) {
        presenter?.didTapBackButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSwipeRecognizer()
        view.backgroundColor = .brown
        
        weightTextField.delegate = self
        proteinsTextField.delegate = self
        fatsTextField.delegate = self
        carbTextField.delegate = self
        ccalTextField.delegate = self
        
        configureNavigationItems()
        
        createStackView(stackView: stackForTime, label: timeLabel, textField: timeTextField)
        createStackView(stackView: stackForProduct, label: productLabel, textField: productTextField)
        createStackView(stackView: stackForWeight, label: weightLabel, textField: weightTextField)
        createStackView(stackView: stackForProteins, label: proteinsLabel, textField: proteinsTextField)
        createStackView(stackView: stackForFats, label: fatsLabel, textField: fatsTextField)
        createStackView(stackView: stackForCarb, label: carbLabel, textField: carbTextField)
        createStackView(stackView: stackForCcal, label: ccalLabel, textField: ccalTextField)
        
        createButtonForCancel()
        createButtonForAccept()
        
        defaults.set(proteinsTextField.text, forKey: KeysForPFCC.proteins.rawValue)
        defaults.set(fatsTextField.text, forKey: KeysForPFCC.fats.rawValue)
        defaults.set(carbTextField.text, forKey: KeysForPFCC.carb.rawValue)
        defaults.set(ccalTextField.text, forKey: KeysForPFCC.ccal.rawValue)

        weightTextField.addTarget(self, action: #selector(findMultiple), for: .editingChanged)
    }
        @objc func findMultiple() {
            if let text = weightTextField.text, let weight = Double(text) {
                presenter?.findMultiple(weight: weight)
            }
        }
    
}
extension AddFoodVC {
    func configureNavigationItems() {
        returLeftBarButton.translatesAutoresizingMaskIntoConstraints = false
        returLeftBarButton.clipsToBounds = true
        returLeftBarButton.widthAnchor.constraint(equalToConstant: 61).isActive = true
        returLeftBarButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        returLeftBarButton.layer.cornerRadius = 0.5 * returLeftBarButton.bounds.size.width
        
        returLeftBarButton.setBackgroundImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
        returLeftBarButton.tintColor = .tabBarMainColor
        returLeftBarButton.addTarget(self, action: #selector(comeback), for: .touchUpInside)
        
        rightBarButton.translatesAutoresizingMaskIntoConstraints = false
        rightBarButton.clipsToBounds = true
        rightBarButton.widthAnchor.constraint(equalToConstant: 61).isActive = true
        rightBarButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        rightBarButton.layer.cornerRadius = 0.5 * returLeftBarButton.bounds.size.width
        
        rightBarButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        rightBarButton.tintColor = .titleColor
        rightBarButton.addTarget(self, action: #selector(accept), for: .touchUpInside)
        
        navigationItem.titleView = createLabelForTitle()
        
        let leftBarButtonItem = UIBarButtonItem(customView: returLeftBarButton)
        let rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    func createLabelForTitle() -> UILabel {
        labelEating.numberOfLines = 1
        labelEating.adjustsFontSizeToFitWidth = true
        
        labelEating.text = "Съесть".localized()
        labelEating.font = UIFont.systemFont(ofSize: 1000)
        labelEating.textAlignment = .center
        labelEating.textColor = .black
        
        return labelEating
    }

    @objc func comeback() {
        presenter?.didTapBackButton()
    }
    
    @objc func accept() {
        let name = productTextField.text
        let proteins: Double? = Double((proteinsTextField.text)!)
        let fats: Double? = Double((fatsTextField.text)!)
        let carb: Double? = Double((carbTextField.text)!)
        let weight: Int? = Int(weightTextField.text!)
        let ccal: Int? = Int(ccalTextField.text!)
        let time: String = timeTextField.text!
        let token: String? = DefaultsManager.instance.defaults.string(forKey: "token")
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 10800)            // указатель временной зоны относительно гринвича
        let formatteddate = formatter.string(from: date as Date)
        let dateNow = formatteddate
        
        if let name = name, let proteins = proteins, let fats = fats, let carb = carb, let ccal = ccal, weight != nil, timeTextField.text != "", let token = token {
            let value = ProductToday(value: [name, weight as Any, proteins, fats, carb, ccal, time, dateNow, token])
            try! realm.write {
                    realm.add(value)
            }
            if !searchObjectsInBD(nameFood: name) {
                let value = Product(value: [name, proteins, fats, carb, ccal, token] as [Any])
                try! realm.write {
                    realm.add(value)
                }
                showAlertOfSuccess()
            } else {
                showAlertOfOk()
            }
        } else {
            showAlertOfError()
        }
    }
    
    func showCurTime() -> String {
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 10800)            // указатель временной зоны относительно гринвича
        let formatteddate = formatter.string(from: time as Date)
        return formatteddate
    }
    
    func createStackView(stackView: UIStackView, label: UILabel, textField: UITextField) {
        view.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        
        label.numberOfLines = 1

        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .black

        textField.textColor = .blue
        textField.layer.borderWidth = 1
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.green.cgColor
        textField.backgroundColor = .white
        
        switch label {
        case timeLabel:
            timeLabel.text = "Время".localized()
            timeTextField.text = showCurTime()
            setConstrainsForStackView(stackView: stackForTime)
            break
        case productLabel:
            productLabel.text = "Продукт".localized()
            setConstrainsForStackView(stackView: stackForProduct)
            break
        case weightLabel:
            weightLabel.text = "Вес(гр.)".localized()
            weightTextField.text = "100"
            setConstrainsForStackView(stackView: stackForWeight)
            break
        case proteinsLabel:
            proteinsLabel.text = "Белки".localized()
            setConstrainsForStackView(stackView: stackForProteins)
            break
        case fatsLabel:
            fatsLabel.text = "Жиры".localized()
            setConstrainsForStackView(stackView: stackForFats)
            break
        case carbLabel:
            carbLabel.text = "Углеводы".localized()
            carbLabel.adjustsFontSizeToFitWidth = true
            setConstrainsForStackView(stackView: stackForCarb)
            break
        case ccalLabel:
            ccalLabel.text = "Калории".localized()
            setConstrainsForStackView(stackView: stackForCcal)
            break
        default:
            print("stackView error")
        }
        label.setContentHuggingPriority(UILayoutPriority(250), for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
    }
    
    func setConstrainsForStackView(stackView: UIStackView) {
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(46)
        }
        switch stackView {
        case stackForTime:
            stackForTime.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            }
            timeLabel.snp.makeConstraints { make in
                make.width.equalTo(86)
            }
            
            break
        case stackForProduct:
            stackForProduct.snp.makeConstraints { make in
                make.top.equalTo(stackForTime.snp.bottom).inset(-20)
            }
            productLabel.snp.makeConstraints { make in
                make.width.equalTo(86)
            }
            break
        case stackForWeight:
            stackForWeight.snp.makeConstraints { make in
                make.top.equalTo(stackForProduct.snp.bottom).inset(-20)
            }
            weightLabel.snp.makeConstraints { make in
                make.width.equalTo(86)
            }
            break
        case stackForProteins:
            stackForProteins.snp.makeConstraints { make in
                make.top.equalTo(stackForWeight.snp.bottom).inset(-20)
            }
            proteinsLabel.snp.makeConstraints { make in
                make.width.equalTo(86)
            }
            break
        case stackForFats:
            stackForFats.snp.makeConstraints { make in
                make.top.equalTo(stackForProteins.snp.bottom).inset(-20)
            }
            fatsLabel.snp.makeConstraints { make in
                make.width.equalTo(86)
            }
            break
        case stackForCarb:
            stackForCarb.snp.makeConstraints { make in
                make.top.equalTo(stackForFats.snp.bottom).inset(-20)
            }
            carbLabel.snp.makeConstraints { make in
                make.width.equalTo(86)
            }
            break
        case stackForCcal:
            stackForCcal.snp.makeConstraints { make in
                make.top.equalTo(stackForCarb.snp.bottom).inset(-20)
            }
            ccalLabel.snp.makeConstraints { make in
                make.width.equalTo(86)
            }
            break
        default:
            print("Error constrains")
        }
    }
    
    func createButtonForCancel() {
        view.addSubview(buttonForCancel)
        buttonForCancel.snp.makeConstraints { make in
            make.width.height.equalTo(64)
            make.bottom.equalToSuperview().inset(90)
            make.right.equalToSuperview().inset(20)
        }
        buttonForCancel.layer.cornerRadius = 0.5 * buttonForCancel.bounds.size.width
        buttonForCancel.clipsToBounds = true
        
        buttonForCancel.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        buttonForCancel.tintColor = .red
        
        buttonForCancel.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    }
    @objc func cancel() {
        presenter?.didTapCancelButton()
    }
    
    func createButtonForAccept() {
        view.addSubview(buttonForAccept)
        buttonForAccept.snp.makeConstraints { make in
            make.width.height.equalTo(64)
            make.bottom.equalTo(buttonForCancel.snp.top).inset(-4)
            make.right.equalToSuperview().inset(16)
        }
        buttonForAccept.layer.cornerRadius = 0.5 * buttonForAccept.bounds.size.width
        buttonForAccept.clipsToBounds = true
        
        buttonForAccept.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        buttonForAccept.tintColor = .titleColor
        
        buttonForAccept.addTarget(self, action: #selector(acceptFood), for: .touchUpInside)
    }
    @objc func acceptFood() {
        let name = productTextField.text
        let proteins: Double? = Double((proteinsTextField.text)!)
        let fats: Double? = Double((fatsTextField.text)!)
        let carb: Double? = Double((carbTextField.text)!)
        let weight: Int? = Int(weightTextField.text!)
        let ccal: Int? = Int(ccalTextField.text!)
        let time: String = timeTextField.text!
        let token: String? = DefaultsManager.instance.defaults.string(forKey: "token")
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 10800)            // указатель временной зоны относительно гринвича
        let formatteddate = formatter.string(from: date as Date)
        let dateNow = formatteddate
        

        
        if let name = name, let proteins = proteins, let fats = fats, let carb = carb, let ccal = ccal, weight != nil, timeTextField.text != "", let token = token {
            let value = ProductToday(value: [name, weight as Any, proteins, fats, carb, ccal, time, dateNow, token])
            try! realm.write {
                    realm.add(value)
            }
            if !searchObjectsInBD(nameFood: name) {
                let value = Product(value: [name, proteins, fats, carb, ccal, token] as [Any])
                try! realm.write {
                    realm.add(value)
                }
                showAlertOfSuccess()
            } else {
                showAlertOfOk()
            }
        } else {
            showAlertOfError()
        }
    }
    
    func searchObjectsInBD(nameFood: String) -> Bool {
        let namesOfFood = realm.objects(Product.self)
        for name in namesOfFood {
            if DefaultsManager.instance.defaults.string(forKey: "token") == name.token {
                if nameFood == name.name {
                    return true
                }
            }
        }
        return false
    }
    
    func showAlertOfError() {
        let alert = UIAlertController(title: "Ошибка".localized(), message: "Проверьте корректность введенных данных".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок".localized(), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertOfSuccess() {
        let alert = UIAlertController(title: "Успешно".localized(), message: "Продукт добавлен".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок".localized(), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertOfOk() {
        let alert = UIAlertController(title: "Успешно".localized(), message: "Съедено".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок".localized(), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - TextFieldDelegate
extension AddFoodVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension AddFoodVC: AddFoodVCProtocol {
    func fillTextFields(res: Double, prot: Double, fat: Double, carb: Double, ccal: Double) {
        if res == 1.0 {
            proteinsTextField.text = String(prot)
            fatsTextField.text = String(fat)
            carbTextField.text = String(carb)
            ccalTextField.text = String(Int(ccal))
        } else {
            proteinsTextField.text = String(NSString(format:"%.4f", prot))
            fatsTextField.text = String(NSString(format:"%.4f", fat))
            carbTextField.text = String(NSString(format:"%.4f", carb))
            ccalTextField.text = String(Int(ccal))
        }
    }
}
