//
//  Auth.swift
//  Ecommerce-Fullstack
//
//  Created by Đoàn Văn Khoan on 18/10/24.
//

import Foundation

@Observable
class AuthVM {
    var isValidLogin: Bool = false
    var isValidRegister: Bool = false
    var isValidForget: Bool = false
    
    var passwordValidStateLogin: ValidateState = .empty
    var passwordValidStateRegister: ValidateState = .empty
    var emailValidStateLogin: ValidateState = .empty
    var emailValidStateRegister: ValidateState = .empty
    var emailValidStateForget: ValidateState = .empty
    var nameValidStateRegister: ValidateState = .empty
    
    var alertTitle = ""
    var alertMessage = ""
    var showAlert: Bool = false
    
    var emailLogin = "" {
        didSet {
            emailValidStateLogin = emailLogin.isEmpty ? .empty : (isValidEmail(emailLogin) ? .valid : .invalid)
            updateValidLogin()
        }
    }
    
    var emailRegister = "" {
        didSet {
            emailValidStateRegister = emailRegister.isEmpty ? .empty : (isValidEmail(emailRegister) ? .valid : .invalid)
            updateValidRegister()
        }
    }
    
    var emailForget = "" {
        didSet {
            emailValidStateForget = emailForget.isEmpty ? .empty : (isValidEmail(emailForget) ? .valid : .invalid)
            updateValidForget()
        }
    }
    
    var passwordLogin = "" {
        didSet {
            passwordValidStateLogin = passwordLogin.isEmpty ? .empty : (passwordLogin.count <= 4 ? .invalid : .valid)
            updateValidForget()
        }
    }
    
    var passwordRegister = "" {
        didSet {
            passwordValidStateRegister = passwordRegister.isEmpty ? .empty : (passwordRegister.count <= 4 ? .invalid : .valid)
            updateValidRegister()
        }
    }
    
    var nameRegister = "" {
        didSet {
            nameValidStateRegister = nameRegister.isEmpty ? .empty : (nameRegister.count <= 4 ? .invalid : .valid)
            updateValidRegister()
        }
    }
    
    func updateValidLogin() {
        isValidLogin = emailValidStateLogin == .valid && passwordValidStateLogin == .valid
    }
    
    func updateValidRegister() {
        isValidRegister = emailValidStateRegister == .valid && passwordValidStateRegister == .valid && nameValidStateRegister == .valid
    }
    
    func updateValidForget() {
        isValidForget = emailValidStateForget == .valid
    }
    
    /// Register Function
    func register(name: String, email: String, password: String) async throws -> ValidateResponse {
        guard let url = URLComponents(string: "\(baseURL)/register")?.url else {
            return ValidateResponse(message: "URL Incorrect")
        }
        
        let registerRequest = RegisterRequest(email: email, password: password, name: name)
        
        let requestBody: Data
        
        do {
            requestBody = try JSONEncoder().encode(registerRequest)
        } catch {
            throw NetworkError.invalidData
        }
        
        do {
            let (authResponse, httpResponse) = try await HTTPClient.shared.httpRequest(url: url, method: .POST, body: requestBody) as (ValidateResponse, HTTPURLResponse)
            
            if (200...299).contains(httpResponse.statusCode) {
                alertTitle = "Success"
                alertMessage = authResponse.message ?? ""
                showAlert = true
                return ValidateResponse(message: authResponse.message)
            } else {
                alertTitle = "Error"
                alertMessage = authResponse.message ?? ""
                showAlert = true
                throw NetworkError.invalidResponse
            }
        } catch {
            alertTitle = "Error"
            alertMessage = "Network Request Failed"
            showAlert = true
            throw NetworkError.invalidResponse
        }
    }
}

let baseURL: String = "http://localhost:4000"
