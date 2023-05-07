//
//  HelperForFindTableView.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 03.03.2023.
//

//import UIKit
//
//class HelperForFindTableView: NSObject {
//    
//    //let identifier = "cellForFood"
//    
//    var model = ModelOfDataForFindTable()///////
//    
//    //weak var viewController: RecipesVC?
//
//}
//
//
//extension HelperForFindTableView: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if FindFoodVC.isSearching {
//            return model.filteredData.count
//        } else {
//            return model.data.count
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = (tableView.dequeueReusableCell(withIdentifier: CellForFindFood.identificator, for: indexPath) as? CellForFindFood) else {
//            fatalError()
//        }
//        if FindFoodVC.isSearching {
//            //print("создалось")
//            cell.createLabelForNameOfFood(nameOfFindFood: model.filteredData[indexPath.row])
//        } else {
//            //print("создалось2")
//            cell.createLabelForNameOfFood(nameOfFindFood: model.data[indexPath.row])
//        }
//        return cell
//    }
//    
//}

