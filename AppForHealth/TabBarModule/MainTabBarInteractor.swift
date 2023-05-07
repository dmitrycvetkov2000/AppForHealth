//
//  MainTabBarInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import Foundation

protocol MainTabBarInteractorProtocol: AnyObject {
    
}
class MainTabBarInteractor: MainTabBarInteractorProtocol {
    weak var presenter: MainTabBarPresenterProtocol?
}
