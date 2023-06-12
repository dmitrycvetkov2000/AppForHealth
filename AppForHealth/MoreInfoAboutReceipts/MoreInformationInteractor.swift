//
//  MoreInformationInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import Foundation
import UIKit

protocol MoreInformationInteractorProtocol: AnyObject {
    func downloadInfo(id: Int)
}
class MoreInformationInteractor {
    weak var presenter: MoreInformationPresenterProtocol?
    
    
    var masImages = [UIImage]()
    
    let group = DispatchGroup()
    
    var ingredients = [(image: UIImage, amount: Double, type: String, name: String)]()
    
    var nameOfReceipt = ""
    
    var instructionsOfReceipt = ""
    
    var time = 0
}

extension MoreInformationInteractor: MoreInformationInteractorProtocol {
    func downloadInfo(id: Int) {
        group.enter()
        
        ApiManager.shared.getMoreInfoAboutReceipt(id: id) { [weak self] info in
            guard let self = self else { return }

            if let ingredients = info.extendedIngredients {
                var dataOfIngredient: (image: UIImage, amount: Double, type: String, name: String) = (image: UIImage(), amount: Double(), type: String(), name: String())
                for ingredient in ingredients {
                    if let imageOfIngredient = ingredient.image {
                        if let url = URL(string: "https://spoonacular.com/cdn/ingredients_100x100/\(imageOfIngredient)") {
                            group.enter()
                            URLSession.shared.dataTask(with: url) { (data, response, error) in
                                defer {
                                    self.group.leave()
                                }
                                if let imageData = data {
                                    self.masImages.append(UIImage(data: imageData) ?? UIImage())
                                }
                            }.resume()
                        }
                    }
                    group.enter()
                    if let amount = ingredient.amount {
                        dataOfIngredient.amount = amount
                    }
                    if let type = ingredient.measures?.metric?.unitLong {
                        dataOfIngredient.type = type
                    }
                    if let name = ingredient.nameClean {
                        dataOfIngredient.name = name
                    }
                    
                    
                        self.ingredients.append(dataOfIngredient)
                    group.leave()
                }
            }

            self.nameOfReceipt = info.title ?? "Не найдено"
            self.instructionsOfReceipt = info.instructions ?? "Не найдено"

            if let time = info.readyInMinutes {
                    self.time = time
            }
            self.group.leave()
        }
        
        group.notify(queue: .main) {
            self.presenter?.didCreateScrollView()
            self.presenter?.didAddInContentView(nameOfReceipt: self.nameOfReceipt, time: self.time)

            self.presenter?.didCreateStackForIngredients()
            for (indexOfImage, ingredient) in self.ingredients.indexed() {
                self.presenter?.didCreateStackIngredient(image: self.masImages[indexOfImage], name: ingredient.name, type: ingredient.type, amount: ingredient.amount)
            }
            self.presenter?.didCreateLabelInstructions()
            self.presenter?.createdLabelForInstruction(text: self.instructionsOfReceipt)
        }
    }
}
