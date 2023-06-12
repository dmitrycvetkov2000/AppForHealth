//
//  TableViewCellForFood.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 27.02.2023.
//

import SnapKit

class TableViewCellForFood: UITableViewCell {
    static let identificator = "TableViewCellForFood"
       
    let labelForNameOfFood = UILabelWithInsets()
    
    let proteinsLabel = UILabelWithInsets()
    let fatLabel = UILabel()
    let carbLabel = UILabel()
    let stackForPFC = UIStackView()
    
    let labelForTime = UILabelWithInsets()
    
    let caloriesLabel = UILabel()
    let weightLabel = UILabel()
    let stackForCalWeight = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(labelForTime)
        setConstraintsForTimeLabel()
        self.addSubview(labelForNameOfFood)
        setConstrainsForNameLabel()
        self.addSubview(stackForPFC)
        setConstreintsForStackPFC()
        self.addSubview(stackForCalWeight)
        setConstrainsForStackCalWeight()
        
        backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLabelForName(nameOfFood: String) {
        labelForNameOfFood.textInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        labelForNameOfFood.font = UIFont(name: "Vasek", size: 1000)
        labelForNameOfFood.numberOfLines = 1
        labelForNameOfFood.adjustsFontSizeToFitWidth = true
        
        labelForNameOfFood.textAlignment = .left
        
        labelForNameOfFood.text = nameOfFood.localized()
        
        labelForNameOfFood.textColor = UIColor.forJustText
    }
    
    
    func createStackViewForPFC(proteins: Double, fat: Double, carb: Double) {
        stackForPFC.addArrangedSubview(proteinsLabel)
        stackForPFC.addArrangedSubview(fatLabel)
        stackForPFC.addArrangedSubview(carbLabel)
        
        stackForPFC.axis = .horizontal
        stackForPFC.spacing = 10
        stackForPFC.distribution = .equalSpacing
        
        proteinsLabel.text = "Б:".localized() + " \(proteins)"
        fatLabel.text = "Ж:".localized() + " \(fat)"
        carbLabel.text = "У:".localized() + " \(carb)"
        
        proteinsLabel.textColor = #colorLiteral(red: 0.1821803749, green: 0.1844733059, blue: 0.184432894, alpha: 1)
        fatLabel.textColor = #colorLiteral(red: 0.1821803749, green: 0.1844733059, blue: 0.184432894, alpha: 1)
        carbLabel.textColor = #colorLiteral(red: 0.1821803749, green: 0.1844733059, blue: 0.184432894, alpha: 1)
    }
    
    func createLabelForTime(time: String) {
        labelForTime.textInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        labelForTime.font = UIFont(name: "Vasek", size: 1000)
        labelForTime.numberOfLines = 1
        labelForTime.adjustsFontSizeToFitWidth = true
        
        labelForTime.textAlignment = .right
        
        labelForTime.text = time
        
        labelForTime.textColor = UIColor.forJustText
    }
    
    func createStackViewForCalWeight(calories: Int, weight: Int) {
        stackForCalWeight.addArrangedSubview(caloriesLabel)
        stackForCalWeight.addArrangedSubview(weightLabel)
        
        stackForCalWeight.axis = .horizontal
        stackForCalWeight.spacing = 10
        
        caloriesLabel.textAlignment = .right
        weightLabel.textAlignment = .right
        
        caloriesLabel.text = "\(calories) " + "ккал".localized()
        weightLabel.text = "\(weight) " + "г.".localized()
        
        caloriesLabel.textColor = #colorLiteral(red: 0.1821803749, green: 0.1844733059, blue: 0.184432894, alpha: 1)
        weightLabel.textColor = #colorLiteral(red: 0.1821803749, green: 0.1844733059, blue: 0.184432894, alpha: 1)
    }
}
extension TableViewCellForFood {    
    func setConstrainsForNameLabel() {
        labelForNameOfFood.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalTo(labelForTime.snp.left)
        }
    }
    
    func setConstreintsForStackPFC() {
        stackForPFC.snp.makeConstraints { make in
            make.top.equalTo(labelForNameOfFood.snp.bottom).inset(0)
            make.left.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(200)
            make.bottom.equalToSuperview()
        }
    }
    
    func setConstraintsForTimeLabel() {
        labelForTime.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
    }
    
    func setConstrainsForStackCalWeight() {
        stackForCalWeight.snp.makeConstraints { make in
            make.top.equalTo(labelForTime.snp.bottom).inset(0)
            make.right.equalToSuperview()
            make.left.equalTo(stackForPFC.snp.right)
            make.height.equalTo(30)
            make.bottom.equalToSuperview()
        }
    }
}
