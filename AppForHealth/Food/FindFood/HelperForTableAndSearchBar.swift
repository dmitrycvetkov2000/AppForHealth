//
//  HelperForTableAndSearchBar.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 03.03.2023.
//

import UIKit
import RealmSwift

protocol ChangeVCDelegate: AnyObject {
    func changeVC(name: String, proteins: Double, fats: Double, carb: Double, ccal: Int)
}

class HelperForTableAndSearchBar: NSObject {
    
    let token = DefaultsManager.instance.defaults.string(forKey: "token")

    var isSearching: Bool = false
    
    var model: ModelOfDataForFindTable?
    
    let tableViewForFind = UITableView()
    
    let realm = try! Realm()
    
    var products: Results<Product>?
    
    var arraysForDate = [Product]()
    
    weak var delegateForTransition: ChangeVCDelegate?
    
    func transitionOnAddFoodVC(name: String, proteins: Double, fats: Double, carb: Double, ccal: Int) {
        delegateForTransition?.changeVC(name: name, proteins: proteins, fats: fats, carb: carb, ccal: ccal)
    }
}


extension HelperForTableAndSearchBar: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.model = ModelOfDataForFindTable()
        guard searchText != "" || searchText != " " else {
            print("empty search")
            return
        }
        
        if searchBar.text == "" {
            self.isSearching = false
            tableViewForFind.reloadData()
        } else {
            self.isSearching = true
            
            for product in arraysForDate {
                if product.name.lowercased().contains(searchBar.text?.lowercased() ?? "") {
                    self.model?.name.append(product.name.localized())
                    self.model?.proteins.append(product.proteins)
                    self.model?.fats.append(product.fats)
                    self.model?.carb.append(product.carb)
                    self.model?.ccal.append(product.ccal)
                }
            }
            tableViewForFind.reloadData()
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearching {
            return model?.name.count ?? 0
        } else {
            return arraysForDate.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: CellForFindFood.identificator, for: indexPath) as? CellForFindFood) else {
            fatalError()
        }
        if self.isSearching {
            let name = model?.name[indexPath.row]

            let product = arraysForDate.first { prod in
                if prod.name == name {
                    return true
                } else {
                    return false
                }
            }
 
            cell.createLabelForNameOfFood(nameOfFindFood: name ?? "")
            cell.createStackForPFC(proteins: product?.proteins ?? 0.0, fat: product?.fats ?? 0.0, carb: product?.carb ?? 0.0)
        } else {
            cell.createLabelForNameOfFood(nameOfFindFood: arraysForDate[indexPath.row].name)
            cell.createStackForPFC(proteins: arraysForDate[indexPath.row].proteins, fat: arraysForDate[indexPath.row].fats, carb: arraysForDate[indexPath.row].carb)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            transitionOnAddFoodVC(name: self.model?.name[indexPath.row] ?? "", proteins: self.model?.proteins[indexPath.row] ?? 0, fats: self.model?.fats[indexPath.row] ?? 0, carb: self.model?.carb[indexPath.row] ?? 0, ccal: self.model?.ccal[indexPath.row] ?? 0)
        } else {
            transitionOnAddFoodVC(name: arraysForDate[indexPath.row].name, proteins: arraysForDate[indexPath.row].proteins, fats: arraysForDate[indexPath.row].fats, carb: arraysForDate[indexPath.row].carb, ccal: arraysForDate[indexPath.row].ccal)
        }
    }
}
