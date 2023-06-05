//
//  FindFoodVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 03.03.2023.
//

import UIKit
import SnapKit
import RealmSwift

protocol FindFoodVCProtocol: AnyObject {
    
}

class FindFoodVC: UIViewController {
    
    var presenter: FindFoodVCPresenterProtocol?
    
    var helper = HelperForTableAndSearchBar()
    
    let labelFindFood = UILabel()
    let searchBar = UISearchBar()
    let buttonForAdd = UIButton()
    
    let returLeftBarButton = UIButton()
    let rightBarButton = UIButton()
    
    var labelForStatisticFood = UILabel()
    
    var realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        helper.tableViewForFind.backgroundColor = .brown
        helper.tableViewForFind.separatorColor = .black
        configureNavigationItems()
        
        self.helper.products = self.helper.realm.objects(Product.self) // Заполняем массив базы данных
       
        self.searchBar.delegate = self.helper
        
        helper.tableViewForFind.delegate = self.helper
        helper.tableViewForFind.dataSource = self.helper
        helper.delegateForTransition = self
        
        navigationItem.titleView = createLabelForTitle()

        createSearchBar()
        createTableViewForFind()
        
        createButtonForAdd()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        helper.tableViewForFind.reloadData()
    }
    
    func configureNavigationItems() {
        returLeftBarButton.translatesAutoresizingMaskIntoConstraints = false
        returLeftBarButton.clipsToBounds = true
        returLeftBarButton.widthAnchor.constraint(equalToConstant: 61).isActive = true
        returLeftBarButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        returLeftBarButton.layer.cornerRadius = 0.5 * returLeftBarButton.bounds.size.width
        
        returLeftBarButton.setBackgroundImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
        returLeftBarButton.tintColor = .tabBarMainColor
        returLeftBarButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        
        rightBarButton.translatesAutoresizingMaskIntoConstraints = false
        rightBarButton.clipsToBounds = true
        rightBarButton.widthAnchor.constraint(equalToConstant: 61).isActive = true
        rightBarButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        rightBarButton.layer.cornerRadius = 0.5 * returLeftBarButton.bounds.size.width
        
        navigationItem.titleView = createLabelForTitle()
        let leftBarButtonItem = UIBarButtonItem(customView: returLeftBarButton)
        let rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    @objc func openMenu() {
        presenter?.didTapReturnButton()
    }
    
    func createLabelForTitle() -> UILabel {
        labelFindFood.numberOfLines = 1
        labelFindFood.adjustsFontSizeToFitWidth = true
        
        labelFindFood.text = "Поиск продукта".localized()
        labelFindFood.font = UIFont.systemFont(ofSize: 1000)
        labelFindFood.textAlignment = .center
        
        return labelFindFood
    }

    func createSearchBar() {
        view.addSubview(searchBar)
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.enablesReturnKeyAutomatically = false
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.left.right.equalToSuperview().inset(20)
        }
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
    }
    
    func createTableViewForFind() {
        helper.tableViewForFind.register(CellForFindFood.self, forCellReuseIdentifier: CellForFindFood.identificator)
        view.addSubview(helper.tableViewForFind)
        helper.tableViewForFind.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).inset(0)
            make.left.right.bottom.equalToSuperview()
        }
    }
    func createButtonForAdd() {
        view.addSubview(buttonForAdd)
        buttonForAdd.snp.makeConstraints { make in
            make.width.height.equalTo(64)
            make.bottom.equalToSuperview().inset(90)
            make.right.equalToSuperview().inset(20)
        }
        buttonForAdd.layer.cornerRadius = 0.5 * buttonForAdd.bounds.size.width
        buttonForAdd.clipsToBounds = true
        
        buttonForAdd.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        buttonForAdd.tintColor = .titleColor
        
        buttonForAdd.addTarget(self, action: #selector(addNewFood), for: .touchUpInside)
    }
    @objc func addNewFood() {
        presenter?.didTapAddButton()
    }
}

extension FindFoodVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.searchTextField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension FindFoodVC: ChangeVCDelegate {
    func changeVC(name: String, proteins: Double, fats: Double, carb: Double, ccal: Int) {
        let vc = AddFoodModuleBuilder.build()
        
        vc.productTextField.text = name.localized()
        vc.proteinsTextField.text = String(proteins)
        vc.fatsTextField.text = String(fats)
        vc.carbTextField.text = String(carb)
        vc.ccalTextField.text = String(ccal)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FindFoodVC: FindFoodVCProtocol {
    
}
