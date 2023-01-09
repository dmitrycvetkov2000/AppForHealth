//
//  WaterVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 08.01.2023.
//

import UIKit
import CoreData


protocol WaterVCProtocol: AnyObject {
    
}

class WaterVC: UIViewController {
    var presenter: WaterPresenterProtocol?
    var labelNumberOfWater = UILabel()
    var buttonIncWater = UIButton()
    
    var numberML: Int16 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
//        presenter?.createLabelNumberOfWater(labelNumberOfWater, self)
//        presenter?.createLabelNumberOfWaterConstraints(labelNumberOfWater, self)
//        presenter?.createButtonForWater(buttonIncWater, self)
//        createLabelNumberOfWater(labelNumberOfWater)
//        createLabelNumberOfWaterConstraints(labelNumberOfWater)
        createButtonForWater(buttonIncWater, self)
        
        view.backgroundColor = .blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createLabelNumberOfWater(labelNumberOfWater)
        createLabelNumberOfWaterConstraints(labelNumberOfWater)
    }
    
    
}

extension WaterVC: WaterVCProtocol {
    func createLabelNumberOfWater(_ label: UILabel) {
        
        
        view.addSubview(label)
        
        label.font = UIFont(name: "Vasek", size: 1000)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .center
        label.textColor = .white
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                numberML = result.numberOfWater
            }
        } catch {
            print(error)
        }
        
        label.text = "\(numberML) мл"
        
    }
    func createLabelNumberOfWaterConstraints(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 62).isActive = true
    }
    
    func createButtonForWater(_ button: UIButton, _ vc: UIViewController) {
        button.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(button)
        
        button.backgroundColor = .green
        
        button.setTitle("Выпил стакан воды", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapWaterButton), for: .touchUpInside)
        
        button.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
//        button.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: 10).isActive = true
//        button.leftAnchor.constraint(equalTo: vc.view.leftAnchor, constant: 10).isActive = true
//        button.rightAnchor.constraint(equalTo: vc.view.rightAnchor, constant: -10).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 62).isActive = true
        
        
    }
    func incWater() -> Int16 {
        numberML += 100
        labelNumberOfWater.text = "\(numberML) мл"
        
        
        return numberML
    }
    
    @objc func tapWaterButton() {
        let managedObject = Person()
        
        incWater()
//        numberML += 100
//        labelNumberOfWater.text = "\(numberML) мл"
        
        managedObject.numberOfWater = numberML
        
        CoreDataManager.instance.saveContext()
        
    }
    
}
