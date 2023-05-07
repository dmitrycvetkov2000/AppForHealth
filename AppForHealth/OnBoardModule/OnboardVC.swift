////
////  OnboardVC.swift
////  AppForHealth
////
////  Created by Дмитрий Цветков on 15.12.2022.
////
//
import UIKit

class OnboardVC: UIViewController {
    
    let labelForTitle = LabelTitle()
    
    let labelForText = JustText()
    
    let imageView = UIImageView()
    
    let button = MainButton()
    
    lazy var subView: [UIView] = [self.labelForTitle, self.labelForText, self.imageView, self.button]
    
    init(helper: OnboardHelper) {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .brown
        edgesForExtendedLayout = []
        
        labelForTitle.text = helper.title
        labelForText.text = helper.text
        imageView.image = helper.image
        imageView.contentMode = .scaleAspectFit
        
        button.setTitle(helper.buttonTitle, for: .normal)
        
        for view in subView { self.view.addSubview(view) }
        
        setConstrainsForLabelTitle()
        setConstrainsForTextLabel()
        setConstrainsForButton()
        setConstrainsForImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstrainsForLabelTitle() {
        labelForTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelForTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            labelForTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            labelForTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    func setConstrainsForTextLabel() {
        labelForText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelForText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            labelForText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            labelForText.topAnchor.constraint(equalTo: labelForTitle.bottomAnchor, constant: 2)
        ])
    }
    
    func setConstrainsForButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    func setConstrainsForImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            imageView.topAnchor.constraint(equalTo: labelForText.bottomAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
