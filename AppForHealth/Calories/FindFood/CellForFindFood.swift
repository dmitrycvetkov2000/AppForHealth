//
//  CellForFindFood.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 03.03.2023.
//

import UIKit
import SnapKit

class CellForFindFood: UITableViewCell {
    static let identificator = "CellForFindFood"
    let labelForNameOfFood = UILabelWithInsets()
    
    let labelForProteins = UILabel()
    let labelForFat = UILabel()
    let labelForCarb = UILabel()
    let stackForPFC = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .brown
        
        self.addSubview(labelForNameOfFood)
        setConstrainsForLabelNameOfFood()
        self.addSubview(stackForPFC)
        setConstrainsForStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLabelForNameOfFood(nameOfFindFood: String) {
        labelForNameOfFood.textInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        labelForNameOfFood.font = UIFont(name: "Vasek", size: 1000)
        labelForNameOfFood.numberOfLines = 1
        labelForNameOfFood.adjustsFontSizeToFitWidth = true
        
        labelForNameOfFood.textAlignment = .left
        
        labelForNameOfFood.text = nameOfFindFood.localized()
        
        labelForNameOfFood.textColor = UIColor.forJustText
    }
    func createStackForPFC(proteins: Double, fat: Double, carb: Double) {
        stackForPFC.addArrangedSubview(labelForProteins)
        stackForPFC.addArrangedSubview(labelForFat)
        stackForPFC.addArrangedSubview(labelForCarb)
        
        labelForProteins.numberOfLines = 1
        labelForFat.numberOfLines = 1
        labelForCarb.numberOfLines = 1
        
        labelForProteins.textAlignment = .left
        labelForFat.textAlignment = .left
        labelForCarb.textAlignment = .left
        
        stackForPFC.spacing = 10
        stackForPFC.axis = .horizontal
        stackForPFC.distribution = .fillProportionally
        
        labelForProteins.text = "Б:".localized() + " \(proteins)"
        labelForFat.text = "Ж:".localized() + " \(fat)"
        labelForCarb.text = "У:".localized() + " \(carb)"
    }
    
}
extension CellForFindFood {
    func setConstrainsForLabelNameOfFood() {
        labelForNameOfFood.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    func setConstrainsForStack() {
        stackForPFC.snp.makeConstraints { make in
            make.top.equalTo(labelForNameOfFood.snp.bottom).inset(-10)
            make.left.equalToSuperview()
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}
