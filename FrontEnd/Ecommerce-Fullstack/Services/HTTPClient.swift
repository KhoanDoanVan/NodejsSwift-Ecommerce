//
//  HTTPClient.swift
//  Ecommerce-Fullstack
//
//  Created by Đoàn Văn Khoan on 23/10/24.
//

import Foundation

enum HTTPMETHOD: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidHTTPStatusCode
}

class HTTPClient {
    
    static let shared = HTTPClient()
    
    /// Config
    let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        
        config.httpCookieStorage = HTTPCookieStorage.shared
        return config
    }()
    
    let session: URLSession
    
    // MARK: Init
    init() {
        self.session = URLSession(configuration: configuration)
    }
    
    /// HTTP Request
    func httpRequest<T: Decodable>(
        url: URL,
        method: HTTPMETHOD,
        body: Data? = nil,
        headers: [String:String]? = nil,
        token: String? = nil
    ) async throws -> (data: T, response: HTTPURLResponse) {
        
        /// Request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            let responseData = try JSONDecoder().decode(T.self, from: data)
            return (responseData,httpResponse)
        } catch {
            throw error
        }
    }
}
