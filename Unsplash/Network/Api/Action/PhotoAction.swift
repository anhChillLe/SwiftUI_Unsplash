//
//  PhotoAction.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 30/8/24.
//

import Foundation
import Alamofire

enum OrderBy: String {
    case lastest
    case oldest
    case popular
}

enum Orientation: String {
    case landscape
    case portrait
    case squarish
}

extension Photo {
    static func list(page: Int = 1, perPage: Int = 20, orderBy: OrderBy = .lastest, completion: @escaping RequestCompletion<[Photo]>){
        ApiClient.shared.request(
            "/photos",
            method: .get,
            parameters: [
                "page" : page,
                "per_page" : perPage,
                "order_by" : orderBy.rawValue
            ],
            completion: completion
        )
    }
    
    static func get(id: String, completion: @escaping RequestCompletion<PhotoFull>){
        ApiClient.shared.request(
            "/photos/\(id)",
            method: .get,
            completion: completion
        )
    }
    
    func like(completion: @escaping RequestCompletion<LikedResult>){
        ApiClient.shared.request(
            "/photos/\(id)/like",
            method: .post,
            completion: completion
        )
    }
    
    func unLike(completion: @escaping RequestCompletion<LikedResult>){
        ApiClient.shared.request(
            "/photos/\(id)/like",
            method: .delete,
            completion: completion
        )
    }
}

