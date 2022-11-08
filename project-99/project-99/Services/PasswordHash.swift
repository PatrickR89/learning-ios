//
//  PasswordHash.swift
//  project-99
//
//  Created by Patrick on 08.11.2022..
//

import Foundation
import CryptoSwift

protocol PasswordHash {
    func hashPassword(password: String, salt: UUID) -> String
}

extension PasswordHash {
    func hashPassword(password: String, salt: UUID) -> String {
        let hashedValue = "\(password)\(salt.uuidString)".sha256()
        return hashedValue
    }
}
