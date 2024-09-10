//
//  CollectionAction.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 1/9/24.
//

import Foundation
import Alamofire

extension Collection {
    static func list(page: Int = 1, perPage: Int = 20, completion: @escaping RequestCompletion<[Collection]>){
        ApiClient.shared.request(
            "/collections",
            parameters: [
                "page": page,
                "per_page": perPage
            ],
            completion: completion
        )
    }
    
    func listPhoto(
        page: Int = 1,
        perPage: Int = 20,
        orientation: Orientation? = nil,
        completion: @escaping RequestCompletion<[Photo]>
    ) {
        var params: Parameters = [
            "page": page,
            "per_page": perPage
        ]
        if let orientation {
            params.updateValue(orientation.rawValue, forKey: "orientation")
        }
        ApiClient.shared.request(
            "/collections/\(id)/photos",
            parameters: params,
            completion: completion
        )
    }
}
