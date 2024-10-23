//
//  User.swift
//  Ecommerce-Fullstack
//
//  Created by Đoàn Văn Khoan on 23/10/24.
//

import Foundation

struct RegisterRequest: Codable {
    let email: String
    let password: String
    let name: String
}

struct ValidateResponse: Decodable {
    let message: String?
}
