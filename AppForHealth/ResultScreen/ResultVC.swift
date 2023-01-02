//
//  ResultVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 19.12.2022.
//

import UIKit
import CoreData

protocol ResultVCProtocol: AnyObject {
    
}

class ResultVC: UIViewController {
    var presenter: ResultPresenterProtocol?
    
    var labelResult = UILabel()
    var imtResultLabel = UILabel()
     
    var caloriesLabel = UILabel()
    
    var numberOfWaterLabel = UILabel()
    
    var okButton = UIButton()
    
    
    lazy var age: Int16? = nil
    lazy var gender: String? = nil
    lazy var height: Int16? = nil
    lazy var weight: Int16? = nil
    
    lazy var activity: String? = nil
    lazy var goal: String? = nil
    
    lazy var bmr: Double? =  nil
    lazy var numberOfWater: Int? = nil
    
    enum IMT {
        case lightWeight, normal, excessWeight, obesity
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLabelResult(labelResult)
        createIMTLabel(imtResultLabel)
        
        createCaloriesLabel(caloriesLabel)
        
        createNumberOfWaterLabel(numberOfWaterLabel)
        
        createOkButton(okButton)
    }
    
    func calculateNumberOfWater() -> Int {
        if gender == "Мужчина" {
            numberOfWater = Int(weight ?? 0) * 35
            return numberOfWater ?? 0
        }
        if gender == "Женщина" {
            numberOfWater = Int(weight ?? 0) * 31
            return numberOfWater ?? 0
        }
        return 0
    }
    
    func culculationCalories() -> Double {
        // Формула для мужчин BMR = 88,36 + (13,4 × вес в кг) + (4,8 × рост в см) – (5,7 × возраст в годах).
        //Формула для женщин BMR = 447,6 + (9,2 × вес в кг) + (3,1 × рост в см) – (4,3 × возраст в годах).
        
        if gender == "Мужчина" {
            let weightBMR = 13.4 * Double(weight ?? 0)
            let heughtBMR = 4.8 * Double(height ?? 0)
            let ageBMR = 5.7 * Double(age ?? 0)
            bmr = 88.36 + (weightBMR) + (heughtBMR) - (ageBMR)
        }
        if gender == "Женщина" {
            let weightBMR = 9.2 * Double(weight ?? 0)
            let heughtBMR = 3.1 * Double(height ?? 0)
            let ageBMR = 4.3 * Double(age ?? 0)
            bmr = 447.6 + (weightBMR) + (heughtBMR) - (ageBMR)
        }
        
        switch activity {
            case "Низкий":
                bmr = (bmr ?? 0) * 1.2
            return bmr ?? 0
            case "Средний":
                bmr = (bmr ?? 0) * 1.5
            return bmr ?? 0
            case "Высокий":
                bmr = (bmr ?? 0) * 1.8
            return bmr ?? 0
        default:
            print("error")
        }
        return bmr ?? 0
    }
    
    func culculationIMT() {
        //        lazy var age: Int16? = nil
        //        lazy var gender: String? = nil
        //        lazy var height: Int16? = nil
        //        lazy var weight: Int16? = nil
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                print("В базе данных  \(result.age), \(result.gender), \(result.goal), \(result.height), \(result.levelOfActivity), \(result.weight)")
                age = result.age
                gender = result.gender
                height = result.height
                weight = result.weight
            }
        } catch {
            print(error)
        }
        
        let imt = Float(Int(weight ?? 0) / (Int(height ?? 0) * Int(height ?? 0)) / 1000)
        print("imt = \(imt)")
        
        if gender == "Мужчина" && age ?? 0 < 65{
            switch true {
            case imt <= 18.5:
                print("Легкий вес \(IMT.lightWeight)")
                imtResultLabel.text = "ИМТ: Недовес"
                break
            case imt > 18.5 && imt <= 24.9:
                print("Нормальный вес \(IMT.normal)")
                imtResultLabel.text = "ИМТ: В норме"
                break
            case imt > 24.9 && imt <= 29.9:
                print("Избыточный вес \(IMT.excessWeight)")
                imtResultLabel.text = "ИМТ: Избыточный вес"
                break
            case imt > 29.9:
                print("Ожирение \(IMT.obesity)")
                imtResultLabel.text = "ИМТ: Ожирение"
                break
            default:
                print("NO")
                imtResultLabel.text = "ИМТ: Не выявлен"
            }
        }
        
        if gender == "Мужчина" && age ?? 0 >= 65 && age ?? 0 < 74{
            switch true {
            case imt <= 22:
                print("Легкий вес \(IMT.lightWeight)")
                imtResultLabel.text = "ИМТ: Недовес"
                break
            case imt > 22 && imt <= 26.9:
                print("Нормальный вес \(IMT.normal)")
                imtResultLabel.text = "ИМТ: В норме"
                break
            case imt > 26.9 && imt <= 29.9:
                print("Избыточный вес \(IMT.excessWeight)")
                imtResultLabel.text = "ИМТ: Избыточный вес"
                break
            case imt > 29.9:
                print("Ожирение \(IMT.obesity)")
                imtResultLabel.text = "ИМТ: Ожирение"
                break
            default:
                print("Не выявлен")
            }
        }
        
        if gender == "Мужчина" && age ?? 0 >= 75{
            switch true {
            case imt <= 23:
                print("Легкий вес \(IMT.lightWeight)")
                imtResultLabel.text = "ИМТ: Недовес"
                break
            case imt > 23 && imt <= 27.9:
                print("Нормальный вес \(IMT.normal)")
                imtResultLabel.text = "ИМТ: В норме"
                break
            case imt > 27.9 && imt <= 29.9:
                print("Избыточный вес \(IMT.excessWeight)")
                imtResultLabel.text = "ИМТ: Избыточный вес"
                break
            case imt > 29.9:
                print("Ожирение \(IMT.obesity)")
                imtResultLabel.text = "ИМТ: Ожирение"
                break
            default:
                print("Не выявлен")
            }
        }
        
        
        
        if gender == "Женщина" && age ?? 0 < 65{
            switch true {
            case imt <= 17:
                print("Легкий вес \(IMT.lightWeight)")
                imtResultLabel.text = "ИМТ: Недовес"
                break
            case imt > 17 && imt <= 24.2:
                print("Нормальный вес \(IMT.normal)")
                imtResultLabel.text = "ИМТ: В норме"
                break
            case imt > 24.2 && imt <= 29.2:
                print("Избыточный вес \(IMT.excessWeight)")
                imtResultLabel.text = "ИМТ: Избыточный вес"
                break
            case imt > 29.2:
                print("Ожирение \(IMT.obesity)")
                imtResultLabel.text = "ИМТ: Ожирение"
                break
            default:
                print("Не выявлен")
            }
        }
        
        if gender == "Женщина" && age ?? 0 >= 65 && age ?? 0 < 74{
            switch true {
            case imt <= 21.4:
                print("Легкий вес \(IMT.lightWeight)")
                imtResultLabel.text = "ИМТ: Недовес"
                break
            case imt > 21.4 && imt <= 26:
                print("Нормальный вес \(IMT.normal)")
                imtResultLabel.text = "ИМТ: В норме"
                break
            case imt > 26 && imt <= 29.3:
                print("Избыточный вес \(IMT.excessWeight)")
                imtResultLabel.text = "ИМТ: Избыточный вес"
                break
            case imt > 29.3:
                print("Ожирение \(IMT.obesity)")
                imtResultLabel.text = "ИМТ: Ожирение"
                break
            default:
                print("Не выявлен")
            }
        }
        
        if gender == "Женщина" && age ?? 0 >= 75{
            switch true {
            case imt <= 22.6:
                print("Легкий вес \(IMT.lightWeight)")
                imtResultLabel.text = "ИМТ: Недовес"
                break
            case imt > 22.6 && imt <= 27.4:
                print("Нормальный вес \(IMT.normal)")
                imtResultLabel.text = "ИМТ: В норме"
                break
            case imt > 27.4 && imt <= 29.6:
                print("Избыточный вес \(IMT.excessWeight)")
                imtResultLabel.text = "ИМТ: Избыточный вес"
                break
            case imt > 29.6:
                print("Ожирение \(IMT.obesity)")
                imtResultLabel.text = "ИМТ: Ожирение"
                break
            default:
                print("Не выявлен")
            }
        }

    }
    @objc func goMainAndStart() {
        presenter?.didTapOkButton()
    }

}
    
    


extension ResultVC: ResultVCProtocol {
    
    func createLabelResult(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.font = UIFont(name: "Vasek", size: 1000)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Ваши параметры"
        
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func createIMTLabel(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.font = UIFont(name: "Vasek", size: 1000)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .left
        label.textColor = .white
        culculationIMT()
        
        label.topAnchor.constraint(equalTo: labelResult.bottomAnchor, constant: 10).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 62).isActive = true
    }
    
    func createCaloriesLabel(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.font = UIFont(name: "Vasek", size: 1000)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .left
        label.textColor = .white
        label.text = String("Предложенное количество калорий: \(culculationCalories())")
        
        label.topAnchor.constraint(equalTo: imtResultLabel.bottomAnchor, constant: 10).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 62).isActive = true
    }
    
    func createNumberOfWaterLabel(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.font = UIFont(name: "Vasek", size: 1000)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .left
        label.textColor = .white
        label.text = String("Нужно пить: \(calculateNumberOfWater()) мл воды в день")
        
        label.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 10).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 62).isActive = true
    }
    
    func createOkButton(_ button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.setTitle("Ок", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .cyan
        
        button.addTarget(self, action: #selector(goMainAndStart), for: .touchUpInside)
        
        button.heightAnchor.constraint(equalToConstant: 62).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}
