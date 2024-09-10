//
//  UserDetailViewModel.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 9/9/24.
//

import Foundation
import SwiftUI
import Alamofire

@Observable
class UserDetailViewModel {
    let user: User
    var apiState: APIState<UserFull> = .idle
    
    init(user: User) {
        self.user = user
    }
    
    func getProfile(){
        self.apiState = .loading
        user.getProfile { result in
            switch result {
            case .success(let profile):
                self.apiState = .success(profile)
            case .failure(let error):
                self.apiState = .failure(error)
            }
        }
    }
}
