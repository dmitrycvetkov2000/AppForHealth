//
//  MainViewController.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import UIKit


protocol MainViewProtocol: AnyObject {
    func createMainLabel()
        
    func createGenderAgeLabel() -> String
    func createIMTLabel() -> String
    func createHeightWeightBodyFatLabel() -> String
    func createReccomendCaloriesLabel() -> String
    func createRecomendWaterLabel() -> String
    
}

class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol?
    
    var mainLabel = LabelTitle()
    
    var stackForLabels = UIStackView()
    
    var genderAgeLabel = MainScreenLabel()
    var heightWeightBodyFatLabel = MainScreenLabel()
    var imtLabel = MainScreenLabel()
    var reccomendCaloriesLabel = MainScreenLabel()
    var recomendWaterLabel = MainScreenLabel()

    var helper: HelperForCollectionViewMain?
        
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.backgroundColor = .none
        collectionView.bounces = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private func setDelegates() {
        collectionView.delegate = self.helper
        collectionView.dataSource = self.helper
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.register(CellForMiniSection.self, forCellWithReuseIdentifier: helper!.identifierForMini)
        collectionView.register(CellForButtons.self, forCellWithReuseIdentifier: helper!.identifierForButtons)
        collectionView.register(CellForMainSection.self, forCellWithReuseIdentifier: helper!.identifierForMain)
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: helper!.identifierForHeader)
        
        collectionView.collectionViewLayout = helper!.createLayout()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helper = HelperForCollectionViewMain(presenter: presenter!)

        setupViews()
        setDelegates()
    }
}

extension MainViewController: MainViewProtocol {
    func createMainLabel() {
        view.addSubview(mainLabel)
        
        mainLabel.text = "Сведения о Вас".localized()
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(0)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    func createGenderAgeLabel() -> String {
        
        let gender: String? = presenter?.getData(name: "gender")
        let age: Int16? = presenter?.getData(name: "age")
        
        if let gender = gender, let age = age {
            return "\(gender)".localized() + ", возраст:".localized() + " \(age)"
        } else if let gender = gender {
            return "\(gender)".localized() + ", возраст не определен".localized()
        } else if let age = age {
            return "Пол не определен, возраст:".localized() + " \(age)"
        }
        return "No"
    }
    
    func createIMTLabel() -> String {
        let imt: String? = presenter?.getData(name: "imt")
        let smile: String = presenter?.determSmile(imt: imt ?? "") ?? "⛔️"
        
        return "Ваш".localized() + " \(imt ?? IMTEnum.notSuccess.rawValue)".localized() + " \(smile)"
    }
    
    func createHeightWeightBodyFatLabel() -> String {
        let height: Int16? = presenter?.getData(name: "height")
        let weight: Int16? = presenter?.getData(name: "weight")

        if let height = height, let weight = weight {
            return "Рост:".localized() + " \(height)" + ", вес:".localized() + " \(weight) 📐"
        } else if let height = height {
            return "Рост:".localized() + " \(height)" + ", вес: Не определен 📐".localized()
        } else if let weight = weight {
            return "Рост: Не определен, вес:".localized() + " \(weight) 📐"
        }
        return ""
    }
    
    func createReccomendCaloriesLabel() -> String {
        let recCalories: Int16? = presenter?.getData(name: "reccomendCcal")

        if let recCalories = recCalories {
            return "Рекомендуемое количество калорий:".localized() + " \(recCalories) 🍝"
        } else {
            return "Рекомендуемое количество калорий:".localized() +  " Не определено".localized() + "🍝"
        }
    }
    func createRecomendWaterLabel() -> String {
        let recWater: Int16? = presenter?.getData(name: "reccomendWater")
        if let recWater = recWater {
            return "Рекомендуемое количество воды в день:".localized() + " \(recWater) 🚰"
        } else {
            return "Рекомендуемое количество воды в день:".localized() + " Не определено".localized() + " 🚰"
        }
    }
}

