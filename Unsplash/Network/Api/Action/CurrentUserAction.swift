//
//  UserAction.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 5/9/24.
//

import Foundation

extension CurrentUser {
    static func getProfile(completetion: @escaping RequestCompletion<CurrentUser>){
        ApiClient.shared.request("/me", completion: completetion)
    }
    
    static func getLikeds(completetion: @escaping RequestCompletion<[Photo]>){
        ApiClient.shared.request(
            "/",
            method: .get,
            completion: completetion
        )
    }
}
