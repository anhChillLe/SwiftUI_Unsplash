//
//  ApiClien.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 28/8/24.
//

import Foundation
import Alamofire

enum ApiClienError: Error {
    case notFound(varivableString: String)
    case invalidURL(url: String)
}

typealias RequestCompletion<T> = (Result<T, AFError>) -> Void

class ApiClient {
    private let baseURL: URL
    private let session: Session
    
    private init(baseURL: URL, accessKey: String, secretKey: String) {
        self.baseURL = baseURL
        let interceptor = ApiInterceptor(accessKey: accessKey, secretKey: secretKey)
        self.session = Session(interceptor: interceptor)
        
        let memoryCapacity = 20 * 1024 * 1024 // 20 MB bộ nhớ RAM
        let diskCapacity = 100 * 1024 * 1024  // 100 MB bộ nhớ đĩa
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "unsplash-cache")
        URLCache.shared = urlCache
    }
    
    static let shared: ApiClient = {
        do {
            guard let stringUrl = ProcessInfo.processInfo.environment["API_URL"] else {
                throw ApiClienError.notFound(varivableString: "API_URL")
            }
            guard let accessKey = ProcessInfo.processInfo.environment["ACCESS_KEY"] else {
                throw ApiClienError.notFound(varivableString: "ACCESS_KEY")
            }
            guard let secretKey = ProcessInfo.processInfo.environment["SECRET_KEY"] else {
                throw ApiClienError.notFound(varivableString: "SECRET_KEY")
            }
            guard let baseUrl = URL(string: stringUrl) else {
                throw ApiClienError.invalidURL(url: stringUrl)
            }
            return ApiClient(baseURL: baseUrl, accessKey: accessKey, secretKey: secretKey)
        } catch {
            fatalError("Failed to initialize APIClient: \(error)")
        }
    }()
    
    func request<T: Decodable>(_ endpoint: String, method: HTTPMethod = .get, parameters: Parameters? = nil, completion: @escaping RequestCompletion<T>) {
        let url = baseURL.appendingPathComponent(endpoint)
        
        // Gửi request bằng Alamofire
        session.request(url, method: method, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response.result)
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success(_): break
                    
                }
            }
    }
    
    
    var requestCodeUrl: String {
        let scopes = ["public", "read_user", "write_user", "read_photos", "write_photos", "write_likes", "write_followers", "read_collections", "write_collections"]
        let accessKey = ProcessInfo.processInfo.environment["ACCESS_KEY"] ?? ""
        let params: [String:String] = [
            "client_id": accessKey,
            "redirect_uri": "unsplash://",
            "response_type": "code",
            "scopes": scopes.joined(separator: "+")
        ]
        let queryParams = params.map { "\($0)=\($1)" }.joined(separator: "&")
        return "https://unsplash.com/oauth/authorize?\(queryParams)"
    }
}
