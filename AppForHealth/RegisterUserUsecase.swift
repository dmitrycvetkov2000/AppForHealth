//
//  RegisterUserUsecase.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 13.01.2023.
//

import Foundation

struct RegisterUserUsecase {

    private let gateway: AuthenticationGateway
    private let presenter: RegisterUserPresenter

    init(gateway: AuthenticationGateway, presenter: RegisterUserPresenter) {
        self.gateway = gateway
        self.presenter = presenter
    }
    
    // ...
}
