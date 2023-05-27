//
//  ViewController.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 05.12.2022.
//

import UIKit
import VK_ios_sdk
//import GoogleSignIn
//import FirebaseAuth
//import VK_ios_sdk


protocol AuthorizationViewProtocol: AnyObject {
    func setTapRecognizer()
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
                labelForMessengersRegistration.text = "Зарегистрироваться с помощью".localized()
                buttonForEnterOrRegistration.setTitle("Зарегистрироваться".localized(), for: .normal)
                registrationLabel.text = "Регистрация".localized()
                nameTextField.isHidden = false
                buttonForChangeView.setTitle("Вход".localized(), for: .normal)
                otherLabel.text = "У вас уже есть аккаунт?".localized()
            } else {
                labelForMessengersRegistration.text = "Войти с помощью".localized()
                buttonForEnterOrRegistration.setTitle("Войти".localized(), for: .normal)
                registrationLabel.text = "Вход".localized()
                nameTextField.isHidden = true
                buttonForChangeView.setTitle("Регистрация".localized(), for: .normal)
                otherLabel.text = "У вас нет аккаунта?".localized()
            }
        }
    }
    
    let constrains = ConstrainsOfAuth()
    
    var registrationLabel = LabelTitle()
    var otherLabel = JustText()
    
    
    var stackViewForEntry = UIStackView()
    var nameTextField = MyTextField()
    var emailTextField = MyTextField()
    var passwordTextField = MyTextField()
    
    var buttonForEnterOrRegistration = MainButton()
    var buttonForChangeView = UIButton()
    
    var tapRecognizer: UITapGestureRecognizer?
    
    var labelForMessengersRegistration = JustText()
    var StackForButtonsMessenger = UIStackView()
    var vkButton = UIButton()
    var googleButton = UIButton()
    
    //var vcVKAuthScreen = VKAuthScreen()
    //let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        presenter?.setTapRecognizer()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        self.view.backgroundColor = .brown
        
        createLabel(registrationLabel)
        constrains.createRegistrationLabelConstrains(registrationLabel, view)
        
        
        constrains.createTextFieldsConstraint(nameTextField: nameTextField, emailField: emailTextField, passwordField: passwordTextField)
        createStackViewForEntry()
        constrains.createStackViewConstraints(stackViewForEntry, view, registrationLabel: registrationLabel)
        
        createButtonForEnterOrRegistration()
        constrains.createBottonForEnterOrRegistrationConstraints(button: buttonForEnterOrRegistration, view, stackViewForEntry: stackViewForEntry)
        
        createOtherLabel()
        constrains.createOtherLabelConstraints(otherLabel, view, button: buttonForEnterOrRegistration)
        
        createButtonForEnter()
        constrains.createButtonConstraints(buttonForChangeView, view, otherLabel: otherLabel)
 
        createStackForButtons()
        
        createLabelForMessengersRegistration()
        constrains.createLabelForMessengersRegistration(label: labelForMessengersRegistration, view: view, stack: StackForButtonsMessenger)
        
    }

}


extension ViewController: AuthorizationViewProtocol {
    func enterOrRegistr(textField: UITextField?) {
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
                if textField != nil {
                    if textField == nameTextField {
                        emailTextField.becomeFirstResponder()
                    }
                    if textField == emailTextField {
                        passwordTextField.becomeFirstResponder()
                    }
                    if textField == passwordTextField {
                        presenter?.showAlert(vc: self)
                    }
                } else {
                        presenter?.showAlert(vc: self)
                }

            }
        } else {
            if(!email.isEmpty && !password.isEmpty) {
                presenter?.showSpinnerAndBlackoutScreen(vc: self, spinner: spinner, blurEffectView: blurEffectView)
                presenter?.didEntrance(email: email, password: password, presenter: self.presenter, vc: self, spinner: spinner, blurEffectView: blurEffectView)
            }
        }
    }
}



extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enterOrRegistr(textField: textField)
        return true
    }
}

extension ViewController {
    func createLabel(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        if label == registrationLabel {
            label.adjustsFontSizeToFitWidth = true
            
            label.text = "Регистрация".localized()
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
            string: "Введите имя".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6783986092, green: 0.7456328273, blue: 0.6901838183, alpha: 1)]
        )
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Введите email".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6783986092, green: 0.7456328273, blue: 0.6901838183, alpha: 1)]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Введите пароль".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6783986092, green: 0.7456328273, blue: 0.6901838183, alpha: 1)]
        )
        
        //emailTextField.keyboardType = .emailAddress //////?
        
        nameTextField.returnKeyType = .continue
        emailTextField.returnKeyType = .continue
        emailTextField.autocapitalizationType = .none
        passwordTextField.returnKeyType = .done
        nameTextField.textContentType = .name
        emailTextField.textContentType = .emailAddress
        passwordTextField.textContentType = .password
        passwordTextField.autocapitalizationType = .none
        
        passwordTextField.isSecureTextEntry = true
        
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
        
        stackViewForEntry.addArrangedSubview(nameTextField)
        stackViewForEntry.addArrangedSubview(emailTextField)
        stackViewForEntry.addArrangedSubview(passwordTextField)
        
        view.addSubview(stackViewForEntry)
    }
    
    func createButtonForEnterOrRegistration() {
        buttonForEnterOrRegistration.translatesAutoresizingMaskIntoConstraints = false
        buttonForEnterOrRegistration.setTitle("Зарегистрироваться".localized(), for: .normal)
        view.addSubview(buttonForEnterOrRegistration)
        buttonForEnterOrRegistration.addTarget(self, action: #selector(EnterOrRegistr), for: .touchUpInside)
    }
    @objc func EnterOrRegistr() {
        enterOrRegistr(textField: nil)
    }
    
    func createOtherLabel() {
        otherLabel.translatesAutoresizingMaskIntoConstraints = false
        otherLabel.numberOfLines = 1
        otherLabel.adjustsFontSizeToFitWidth = true
        otherLabel.textAlignment = .center
        otherLabel.text = "У вас уже есть аккаунт?".localized()
        view.addSubview(otherLabel)
    }

    func createButtonForEnter() {
        buttonForChangeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonForChangeView)
        buttonForChangeView.setTitle("Войти".localized(), for: .normal)
        buttonForChangeView.setTitleColor(.black, for: .normal)
        
        buttonForChangeView.backgroundColor = .clear
        
        buttonForChangeView.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
    }
    @objc func onButtonTapped(){
        signup = !signup
    }
 
    func createLabelForMessengersRegistration() {
        labelForMessengersRegistration.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelForMessengersRegistration)
        labelForMessengersRegistration.textAlignment = .center
        
        labelForMessengersRegistration.text = "Зарегистрируйтесь с помощью".localized()
        
    }
    func createStackForButtons() {
        StackForButtonsMessenger.translatesAutoresizingMaskIntoConstraints = false
        StackForButtonsMessenger.axis = .horizontal
        StackForButtonsMessenger.spacing = 20

        view.addSubview(StackForButtonsMessenger)
        
        StackForButtonsMessenger.addArrangedSubview(vkButton)
        StackForButtonsMessenger.addArrangedSubview(googleButton)
        
        constrains.createStackForButtons(stack: StackForButtonsMessenger, view: view)
        
        vkButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        
        let imageVK = UIImage(named: "vk")
        vkButton.setImage(imageVK, for: .normal)
        
        let imageGoogle = UIImage(named: "google")
        googleButton.setImage(imageGoogle, for: .normal)
        
        NSLayoutConstraint.activate([
            vkButton.widthAnchor.constraint(equalTo: StackForButtonsMessenger.heightAnchor),
            vkButton.heightAnchor.constraint(equalTo: StackForButtonsMessenger.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            googleButton.widthAnchor.constraint(equalTo: StackForButtonsMessenger.heightAnchor),
            googleButton.heightAnchor.constraint(equalTo: StackForButtonsMessenger.heightAnchor)
        ])
        
        vkButton.addTarget(self, action: #selector(didTapVK), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(didTapGoogle), for: .touchUpInside)
    }
    @objc func didTapVK() {
        var vkAuthScreen = VKAuthScreen(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), configuration: nil, vc: self)
        view.addSubview(vkAuthScreen)
    }
    @objc func didTapGoogle() {
        presenter?.didTapGoogleButton(vc: self)
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
// MARK: - VKDelegate
extension ViewController: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print("Регистрация закончилась")
        presenter?.didTapVKButton(vc: self, result: result)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("Ошибка регистрации ВК")
    }
}

