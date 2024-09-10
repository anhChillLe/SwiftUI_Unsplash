//
//  UserAction.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 9/9/24.
//

import Foundation

extension User {
    func getProfile(completion: @escaping RequestCompletion<UserFull>){
        ApiClient.shared.request(
            "/users/\(username)",
            completion: completion
        )
    }
}
