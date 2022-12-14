//
//  ViewController.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 05.12.2022.
//

import UIKit

protocol AuthorizationViewProtocol: AnyObject {

}

class ViewController: UIViewController {
    var presenter: AuthorizationPresenterProtocol?
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }()
    
    private lazy var spinner: CustomSpinnerSimple = {
            let spinner = CustomSpinnerSimple(squareLength: 100)
            return spinner
        }()
    
    var signup: Bool = true {
        willSet {
            if newValue {
                registrationLabel.text = "Регистрация"
                nameTextField.isHidden = false
                buttonForEnter.setTitle("Вход", for: .normal)
                otherLabel.text = "У вас уже есть аккаунт?"
            } else {
                registrationLabel.text = "Вход"
                nameTextField.isHidden = true
                buttonForEnter.setTitle("Регистрация", for: .normal)
                otherLabel.text = "У вас нет аккаунта?"
            }
        }
    }
    
    let constrains = ConstrainsOfAuth()
    
    var registrationLabel = UILabel()
    var otherLabel = UILabel()
    
    
    var stackViewForEntry = UIStackView()
    var nameTextField = UITextField()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    
    var buttonForEnter = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        self.view.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        
        createLabel(registrationLabel)
        constrains.createRegistrationLabelConstrains(registrationLabel, view)
        
        
        constrains.createTextFieldsConstraint(nameTextField: nameTextField, emailField: emailTextField, passwordField: passwordTextField)
        createStackViewForEntry()
        constrains.createStackViewConstraints(stackViewForEntry, view, registrationLabel: registrationLabel)
        
        createOtherLabel()
        constrains.createOtherLabelConstraints(otherLabel, view, stackViewForEntry: stackViewForEntry)
        
        createButtonForEnter()
        constrains.createButtonConstraints(buttonForEnter, view, otherLabel: otherLabel)
 
    }

}


extension ViewController: AuthorizationViewProtocol {

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if(signup) {
            if(!name.isEmpty && !email.isEmpty && !password.isEmpty) {
                
                if password.count < 6 {
                    presenter?.showAlertForParol(vc: self)
                } else {
                    presenter?.showSpinnerAndBlackoutScreen(vc: self, spinner: spinner, blurEffectView: blurEffectView)
                    presenter?.didRegistration(name: name, email: email, password: password, presenter: self.presenter, vc: self, spinner: spinner, blurEffectView: blurEffectView)
                }
                
            } else {
                if textField == nameTextField {
                    emailTextField.becomeFirstResponder()
                }
                if textField == emailTextField {
                    passwordTextField.becomeFirstResponder()
                }
                if textField == passwordTextField {
                    presenter?.showAlert(vc: self)
                }
            }
        } else {
            if(!email.isEmpty && !password.isEmpty) {
                presenter?.showSpinnerAndBlackoutScreen(vc: self, spinner: spinner, blurEffectView: blurEffectView)
                presenter?.didEntrance(email: email, password: password, presenter: self.presenter, vc: self, spinner: spinner, blurEffectView: blurEffectView)
            }
        }
        return true
    }
}

extension ViewController {
    func createLabel(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        if label == registrationLabel {
            label.font = UIFont(name: "Vasek", size: 1000)
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            
            label.text = "Регистрация"
            
            label.textAlignment = .center
        }
        view.addSubview(label)
    }

    func createStackViewForEntry() {
        stackViewForEntry.translatesAutoresizingMaskIntoConstraints = false
        stackViewForEntry.backgroundColor = .clear
        
        if signup {
            stackViewForEntry.spacing = 20
        } else {
            stackViewForEntry.spacing = 160
        }
        
        stackViewForEntry.axis = .vertical
        stackViewForEntry.distribution = .fillEqually
        
        
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "Введите имя",
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6783986092, green: 0.7456328273, blue: 0.6901838183, alpha: 1)]
        )
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Введите email",
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6783986092, green: 0.7456328273, blue: 0.6901838183, alpha: 1)]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Введите пароль",
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6783986092, green: 0.7456328273, blue: 0.6901838183, alpha: 1)]
        )
        
        nameTextField.returnKeyType = .continue
        emailTextField.returnKeyType = .continue
        passwordTextField.returnKeyType = .done
        nameTextField.textContentType = .name
        emailTextField.textContentType = .emailAddress
        passwordTextField.textContentType = .password
        
        passwordTextField.isSecureTextEntry = true
        
        emailTextField.keyboardType = .emailAddress
        
        nameTextField.autocorrectionType = .no
        emailTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        
        let spacerView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 0))
        nameTextField.leftViewMode = UITextField.ViewMode.always
        nameTextField.leftView = spacerView
        
        let spacerView2 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 0))
        emailTextField.leftViewMode = UITextField.ViewMode.always
        emailTextField.leftView = spacerView2

        let spacerView3 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordTextField.leftViewMode = UITextField.ViewMode.always
        passwordTextField.leftView = spacerView3
        
        
        nameTextField.backgroundColor = #colorLiteral(red: 0.4380294085, green: 0.3144482672, blue: 0.7371886373, alpha: 1)
        emailTextField.backgroundColor = #colorLiteral(red: 0.4380294085, green: 0.3144482672, blue: 0.7371886373, alpha: 1)
        passwordTextField.backgroundColor = #colorLiteral(red: 0.4380294085, green: 0.3144482672, blue: 0.7371886373, alpha: 1)
        
        stackViewForEntry.addArrangedSubview(nameTextField)
        stackViewForEntry.addArrangedSubview(emailTextField)
        stackViewForEntry.addArrangedSubview(passwordTextField)
        
        
        view.addSubview(stackViewForEntry)
    }

    
    func createOtherLabel() {
        otherLabel.translatesAutoresizingMaskIntoConstraints = false
        otherLabel.font = UIFont(name: "Vasek", size: 1000)
        otherLabel.numberOfLines = 1
        otherLabel.adjustsFontSizeToFitWidth = true
        otherLabel.textAlignment = .center
        otherLabel.text = "У вас уже есть аккаунт?"
        view.addSubview(otherLabel)
        
    }

    
    func createButtonForEnter() {
        buttonForEnter.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonForEnter)
        buttonForEnter.setTitle("Войти", for: .normal)
        buttonForEnter.setTitleColor(.black, for: .normal)
        
        buttonForEnter.backgroundColor = .clear
        
        buttonForEnter.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
        
    }
    @objc func onButtonTapped(){
        signup = !signup
    }
}

