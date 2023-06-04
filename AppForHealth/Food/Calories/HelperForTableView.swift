//
//  HelperForTableView.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 27.02.2023.
//

import UIKit
import RealmSwift


class HelperForTableView: NSObject {
    
    weak var viewController: CaloriesVC?
    
    let realm = try! Realm()
    
    var products: Results<ProductToday>?
    
    var date: String = ""
    var arraysForDate = [ProductToday]()
}


extension HelperForTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraysForDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: TableViewCellForFood.identificator, for: indexPath) as? TableViewCellForFood) else {
            fatalError()
        }
        cell.createLabelForName(nameOfFood: arraysForDate[indexPath.item].name)
        cell.createStackViewForPFC(proteins: arraysForDate[indexPath.item].proteins, fat: arraysForDate[indexPath.item].fats, carb: arraysForDate[indexPath.item].carb)
        cell.createStackViewForCalWeight(calories: arraysForDate[indexPath.item].ccal, weight: arraysForDate[indexPath.item].weight)
        cell.createLabelForTime(time: arraysForDate[indexPath.item].time)

        return cell
    }
 
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")
          tableView.beginUpdates()
          tableView.deleteRows(at: [indexPath], with: .automatic)
          
          try! realm.write {
              realm.delete(self.arraysForDate[indexPath.row])
          }
          self.arraysForDate.remove(at: indexPath.row)
              tableView.endUpdates()
          }
        viewController?.updateProgressView()
    }
}

