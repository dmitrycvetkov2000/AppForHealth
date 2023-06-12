//
//  MoreInformationPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import UIKit

protocol MoreInformationPresenterProtocol: AnyObject {
    func didCreateScrollView()
    func didAddInContentView(nameOfReceipt: String, time: Int)
    func didCreateStackForIngredients()
    func didCreateStackIngredient(image: UIImage, name: String, type: String, amount: Double)
    
    func didCreateLabelInstructions()
    func createdLabelForInstruction(text: String)
    
    func downloadData(id: Int)
}
class MoreInformationPresenter {
    weak var view: MoreInformationVCProtocol?
    var router: MoreInformationRouterProtocol
    var interactor: MoreInformationInteractorProtocol
    
    init(interactor: MoreInformationInteractorProtocol, router: MoreInformationRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}
extension MoreInformationPresenter: MoreInformationPresenterProtocol {
    func didCreateScrollView() {
        view?.createScrollView()
    }
    
    func didAddInContentView(nameOfReceipt: String, time: Int) {
        view?.addInContentView(nameOfReceipt: nameOfReceipt, time: time)
    }
    
    func didCreateStackForIngredients() {
        view?.createStackForIngredients()
    }
    
    func didCreateStackIngredient(image: UIImage, name: String, type: String, amount: Double) {
        view?.createStackIngredient(image: image, name: name, type: type, amount: amount)
    }
    
    func didCreateLabelInstructions() {
        view?.createLabelInstructions()
    }
    
    func createdLabelForInstruction(text: String) {
        view?.createLabelForInstruction(text: text)
    }
    
    func downloadData(id: Int) {
        interactor.downloadInfo(id: id)
    }
}
