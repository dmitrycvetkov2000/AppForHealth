//
//  ConstarinsOfAuth.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.12.2022.
//

import Foundation
import UIKit

class ConstrainsOfAuth {
    func createDateLabelConstraints(_ label: UILabel, _ view: UIView) {
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func createRegistrationLabelConstrains(_ label: UILabel, _ view: UIView) {
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
    
    func createStackViewConstraints(_ stackView: UIStackView, _ view: UIView, registrationLabel: UILabel) {
        stackView.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 20).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
    
    func createTextFieldsConstraint(nameTextField: UITextField, emailField: UITextField, passwordField: UITextField) {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createOtherLabelConstraints(_ label: UILabel, _ view: UIView, stackViewForEntry: UIStackView) {
        label.topAnchor.constraint(equalTo: stackViewForEntry.bottomAnchor, constant: 10).isActive = true
        label.widthAnchor.constraint(equalToConstant: 260).isActive = true
        label.heightAnchor.constraint(equalToConstant: 34).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func createButtonConstraints(_ button: UIButton, _ view: UIView, otherLabel: UILabel) {
        button.topAnchor.constraint(equalTo: otherLabel.bottomAnchor, constant: 2).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
