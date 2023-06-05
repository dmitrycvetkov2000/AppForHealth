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
    
    var model = ModelOfDataForFindTable()
    
    let tableViewForFind = UITableView()
    
    let realm = try! Realm()
    
    var products: Results<Product>?
    
    weak var delegateForTransition: ChangeVCDelegate?
    
    func transitionOnAddFoodVC(name: String, proteins: Double, fats: Double, carb: Double, ccal: Int) {
        delegateForTransition?.changeVC(name: name, proteins: proteins, fats: fats, carb: carb, ccal: ccal)
    }
}


extension HelperForTableAndSearchBar: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.model.filteredData.removeAll()
        guard searchText != "" || searchText != " " else {
            print("empty search")
            return
        }
        
        if searchBar.text == "" {
            self.isSearching = false
            tableViewForFind.reloadData()
        } else {
            self.isSearching = true
            
            if let products = products {
                for product in products {
                        if product.name.lowercased().contains(searchBar.text?.lowercased() ?? "") {
                            self.model.filteredData.append(product.name.localized())
                        }
                }
                tableViewForFind.reloadData()
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearching {
            return model.filteredData.count
        } else {
            return products?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: CellForFindFood.identificator, for: indexPath) as? CellForFindFood) else {
            fatalError()
        }
        if self.isSearching {
            let name = model.filteredData[indexPath.row]

            let product = products?.first { prod in
                if prod.name == name {
                    return true
                } else {
                    return false
                }
            }
 
            cell.createLabelForNameOfFood(nameOfFindFood: name)
            cell.createStackForPFC(proteins: product?.proteins ?? 0.0, fat: product?.fats ?? 0.0, carb: product?.carb ?? 0.0)
        } else {
                if let name = products?[indexPath.row].name {
                    cell.createLabelForNameOfFood(nameOfFindFood: name)
                }
                if let proteins = products?[indexPath.row].proteins, let fats = products?[indexPath.row].fats, let carb = products?[indexPath.row].carb {
                    cell.createStackForPFC(proteins: proteins, fat: fats, carb: carb)
                }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transitionOnAddFoodVC(name: products?[indexPath.row].name ?? "", proteins: products?[indexPath.row].proteins ?? 0.0, fats: products?[indexPath.row].fats ?? 0.0, carb: products?[indexPath.row].carb ?? 0.0, ccal: products?[indexPath.row].ccal ?? 0)
    }
}
