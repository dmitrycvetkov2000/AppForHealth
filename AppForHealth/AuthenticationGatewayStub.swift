//
//  AuthenticationGatewayStub.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 13.01.2023.
//

import Foundation
@testable import AppForHealth

class AuthenticationGatewayStub: AuthenticationGateway {

    var registeredUser: UserEntity?
    var registerResult: Result<UserEntity, AuthenticationError>?

    func register(name: String, email: String, password: String, birthdate: Date,
                  completion: @escaping ((Result<UserEntity, AuthenticationError>) -> Void)) {
        guard let registerResult = registerResult else { return }

        switch registerResult {
        case .failure(_):
            registeredUser = nil
        case .success(_):
            registeredUser = UserEntity(identifier: nil, name: name, email: email, birthdate: birthdate)
        }

        completion(registerResult)

    }

}