//
//  Interceptor.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 28/8/24.
//

import Foundation
import Alamofire

struct ApiInterceptor: RequestInterceptor {
    private let accessKey: String
    private let secretKey: String
    
    init(accessKey: String, secretKey: String) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        
        let memoryCapacity = 100 * 1024 * 1024 // 20  MB of RAM
        let diskCapacity = 100 * 1024 * 1024   // 100 MB of DISK
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myCache")

        URLCache.shared = urlCache
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("1000", forHTTPHeaderField: "X-Ratelimit-Limit")
        request.setValue("999", forHTTPHeaderField: "X-Ratelimit-Remaining")
        
        let token = UserDefaults.standard.string(forKey: "token")
        let authorization = if let token {
            "Bearer \(token)"
        } else {
            "Client-ID \(accessKey)"
        }
        
        request.setValue(authorization, forHTTPHeaderField: "Authorization")
        
        
        request.cachePolicy = .useProtocolCachePolicy
        request.setValue("public, max-age=3600", forHTTPHeaderField: "Cache-Control")
        
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}
