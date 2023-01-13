//
//  AuthenticationGateway.swift.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 13.01.2023.
//

import Foundation

protocol AuthenticationGateway {
    func register(name: String, email: String, password: String, birthdate: Date,
                  completion: @escaping ((Result<UserEntity, AuthenticationError>) -> Void))
}
