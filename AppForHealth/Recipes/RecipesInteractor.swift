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
    
    var group = DispatchGroup()
    func getRequest(helper: HelperForRecipes, type: ApiType) {
        helper.modelForReceipts = ModelForReceipts()
        switch type {
        case .getReceipeForLaunch:
            group.enter()
            ApiManager.shared.getReceipeForBreakfast { [weak self] receipts in
                guard let self = self else { return }
                guard let results = receipts.results else { return }
                for item in results {
                    if let imageString = item.image { // Картинка
                        if let url = URL(string: imageString) {
                            group.enter()
                            URLSession.shared.dataTask(with: url) { (data, response, error) in
                                defer {
                                    self.group.leave()
                                }
                                if let imageData = data {
                                    helper.modelForReceipts?.images.append(UIImage(data: imageData))
                                }
                            }.resume()
                        }
                    }
                    group.enter()
                    if let name = item.title { // Название блюда
                        helper.modelForReceipts?.nameOfFood.append(name)
                    }
                    if let id = item.id { // Запоминаем id блюда для его подробного описания
                        helper.modelForReceipts?.id.append(id)
                    }
                    group.leave()
                }
                group.leave()
            }
            group.notify(queue: .main) {
                self.presenter?.reloadCollectView()
                self.presenter?.removeSpinnerAndBlurEffect()
            }
        case .getReceipeForDessert:
            presenter?.setBlurEffect()
            presenter?.setSpinnerAndStart()
            group.enter()
            ApiManager.shared.getReceipeForDeserts { [weak self] receipts in
                guard let self = self else { return }
                guard let results = receipts.results else { return }
                for item in results {
                    if let imageString = item.image { // Картинка
                        if let url = URL(string: imageString) {
                            group.enter()
                            URLSession.shared.dataTask(with: url) { (data, response, error) in
                                defer {
                                    self.group.leave()
                                }
                                if let imageData = data {
                                    helper.modelForReceipts?.images.append(UIImage(data: imageData))
                                }
                            }.resume()
                        }
                    }
                    group.enter()
                    if let name = item.title { // Название блюда
                        helper.modelForReceipts?.nameOfFood.append(name)
                    }
                    if let id = item.id { // Запоминаем id блюда для его подробного описания
                        helper.modelForReceipts?.id.append(id)
                    }
                    group.leave()
                }
                group.leave()
            }
            group.notify(queue: .main) {
                self.presenter?.reloadCollectView()
                self.presenter?.removeSpinnerAndBlurEffect()
            }
        case .getMoreInfoAboutReceipt:
            print("")
        case .getReceipeForSoup:
            presenter?.setBlurEffect()
            presenter?.setSpinnerAndStart()
            group.enter()
            ApiManager.shared.getReceipeForSoup { [weak self] receipts in
                guard let self = self else { return }
                guard let results = receipts.results else { return }
                for item in results {
                    if let imageString = item.image { // Картинка
                        if let url = URL(string: imageString) {
                            group.enter()
                            URLSession.shared.dataTask(with: url) { (data, response, error) in
                                defer {
                                    self.group.leave()
                                }
                                if let imageData = data {
                                    helper.modelForReceipts?.images.append(UIImage(data: imageData))
                                }
                            }.resume()
                        }
                    }
                    group.enter()
                    if let name = item.title { // Название блюда
                        helper.modelForReceipts?.nameOfFood.append(name)
                    }
                    if let id = item.id { // Запоминаем id блюда для его подробного описания
                        helper.modelForReceipts?.id.append(id)
                    }
                    group.leave()
                }
                group.leave()
            }
            group.notify(queue: .main) {
                self.presenter?.reloadCollectView()
                self.presenter?.removeSpinnerAndBlurEffect()
            }
        }
    }
}

