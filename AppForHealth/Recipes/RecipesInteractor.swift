//
//  RecipesInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 28.12.2022.
//

import UIKit

protocol RecipesInteractorProtocol: AnyObject {
    func getRequest(helper: HelperForRecipes, type: ApiType)
}

class RecipesInteractor: RecipesInteractorProtocol {
    weak var presenter: RecipesPresenterProtocol?
    
    func getRequest(helper: HelperForRecipes, type: ApiType) {
        helper.modelForReceipts = ModelForReceipts()
        switch type {
        case .getReceipeForLaunch:
            ApiManager.shared.getReceipeForBreakfast { [weak self] receipts in
                guard let self = self else { return }
                guard let results = receipts.results else { return }
                for item in results {
                    if let imageString = item.image { // Картинка
                        if let url = URL(string: imageString) {
                            URLSession.shared.dataTask(with: url) { (data, response, error) in
                                if let imageData = data {
                                    helper.modelForReceipts?.images.append(UIImage(data: imageData))
                                }
                            }.resume()
                        }
                    }
                    if let name = item.title { // Название блюда
                        helper.modelForReceipts?.nameOfFood.append(name)
                    }
                    if let id = item.id { // Запоминаем id блюда для его подробного описания
                        helper.modelForReceipts?.id.append(id)
                    }
                }
                
                DispatchQueue.main.async {
                    self.presenter?.reloadCollectView()
                    self.presenter?.removeSpinnerAndBlurEffect()
                }
            }
        case .getReceipeForDessert:
            presenter?.setBlurEffect()
            presenter?.setSpinnerAndStart()
            ApiManager.shared.getReceipeForDeserts { [weak self] receipts in
                guard let self = self else { return }
                guard let results = receipts.results else { return }
                for item in results {
                    if let imageString = item.image { // Картинка
                        if let url = URL(string: imageString) {
                            URLSession.shared.dataTask(with: url) { (data, response, error) in
                                if let imageData = data {
                                    helper.modelForReceipts?.images.append(UIImage(data: imageData))
                                }
                            }.resume()
                        }
                    }
                    if let name = item.title { // Название блюда
                        helper.modelForReceipts?.nameOfFood.append(name)
                    }
                    if let id = item.id { // Запоминаем id блюда для его подробного описания
                        helper.modelForReceipts?.id.append(id)
                    }
                }
                
                DispatchQueue.main.async {
                    self.presenter?.reloadCollectView()
                    self.presenter?.removeSpinnerAndBlurEffect()
                }
            }
        case .getMoreInfoAboutReceipt:
            print("")
        case .getReceipeForSoup:
            presenter?.setBlurEffect()
            presenter?.setSpinnerAndStart()
            ApiManager.shared.getReceipeForSoup { [weak self] receipts in
                guard let self = self else { return }
                guard let results = receipts.results else { return }
                for item in results {
                    if let imageString = item.image { // Картинка
                        if let url = URL(string: imageString) {
                            URLSession.shared.dataTask(with: url) { (data, response, error) in
                                if let imageData = data {
                                    helper.modelForReceipts?.images.append(UIImage(data: imageData))
                                    print("DDDDD = Добавляется картинка в массив")
                                }
                            }.resume()
                        }
                    }
                    if let name = item.title { // Название блюда
                        helper.modelForReceipts?.nameOfFood.append(name)
                    }
                    if let id = item.id { // Запоминаем id блюда для его подробного описания
                        helper.modelForReceipts?.id.append(id)
                    }
                }
                
                DispatchQueue.main.async {
                    self.presenter?.reloadCollectView()
                    self.presenter?.removeSpinnerAndBlurEffect()
                }
            }
        }

    }
}

